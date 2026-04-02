#!/bin/bash

# Stop if error
set -e

# Wait for MariaDB be available
echo "Waiting for MariaDB on port 3306…"
until bash -c "</dev/tcp/mariadb/3306" >/dev/null 2>&1; do
  echo -n "."
  sleep 1
done
echo "MariaDB is up!"

# Prepare webroot
mkdir -p /var/www/html
cd /var/www/html
if [ ! -f .wordpress_initialized ]; then
  rm -rf *

# Install WP Command Line Interface
echo "Installing WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

  # Download WordPress core + Configs
  wp core download --allow-root
  wp core config --dbname="${DB_NAME}" \
                 --dbuser="${DB_USER}" \
                 --dbpass="${DB_PWD}" \
                 --dbhost="mariadb" \
                 --allow-root

  wp core install --url="${DOMAIN_NAME}" \
                  --title="${WP_TITLE}" \
                  --admin_user="${WP_ADMIN_USR}" \
                  --admin_password="${WP_ADMIN_PWD}" \
                  --admin_email="${WP_ADMIN_EMAIL}" \
                  --skip-email \
                  --allow-root

  wp user create "${WP_USR}" "${WP_EMAIL}" \
                 --role=editor \
                 --user_pass="${WP_PWD}" \
                 --allow-root

  wp theme install astra --activate --allow-root
  wp plugin update --all --allow-root

  wp config set WP_REDIS_HOST "$WP_REDIS_HOST" --allow-root
  wp config set WP_REDIS_PORT "$WP_REDIS_PORT" --allow-root
  wp config set WP_CACHE 'true' --allow-root
  wp plugin install redis-cache --allow-root
  wp plugin activate redis-cache --allow-root
  wp redis enable --allow-root

  touch .wordpress_initialized
fi

# Reconfigure PHP-FPM to listen on TCP port 9000 so Nginx can connect via fastcgi_pass wordpress:9000
sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

# Replaces the script PID 1 with PHP-FPM running in the foreground
exec "$@"
