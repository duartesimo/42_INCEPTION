FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
    apache2 \
    php \
    php-mysqli \
    wget

WORKDIR /var/www/html

RUN wget "https://www.adminer.org/latest.php" -O adminer.php && \
    rm -f index.html && \
    chown -R www-data:www-data adminer.php && \
    chmod 755 adminer.php

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]