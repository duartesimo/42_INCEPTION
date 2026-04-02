FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y apache2

RUN rm -f /var/www/html/index.html

COPY ./tools/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]