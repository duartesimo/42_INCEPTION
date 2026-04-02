FROM debian:bullseye

RUN apt-get update && \
    apt-get install nginx openssl -y

COPY conf/default /etc/nginx/sites-available/default

COPY tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

RUN mkdir -p /etc/nginx/certs

EXPOSE 443

ENTRYPOINT ["bash", "/tmp/script.sh"]

CMD []