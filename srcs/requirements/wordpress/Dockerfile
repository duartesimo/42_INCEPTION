FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install php-fpm php-mysql curl less -y

COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

ENTRYPOINT ["bash", "/tmp/script.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]