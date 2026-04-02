FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install mariadb-server -y

# Exposes MariaDB on all interfaces so WordPress container can connect over the inception network
RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

# Script runs as PID 1: bash /tmp/script.sh mysqld_safe
ENTRYPOINT ["bash", "/tmp/script.sh"]

CMD ["mysqld_safe"]