#!/bin/bash

# Stop if error
set -e

# Prepare the runtime directory
mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld

# Initialize the data directory on first run only
if [ ! -d /var/lib/mysql/mysql ]; then
  echo "=> initializing MariaDB datadir"
  mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Create database, user, etc
cat > /tmp/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Pass it to the real server as PID 1
echo "=> Starting MariaDB with init-file"
exec mysqld_safe --datadir=/var/lib/mysql --init-file=/tmp/init.sql