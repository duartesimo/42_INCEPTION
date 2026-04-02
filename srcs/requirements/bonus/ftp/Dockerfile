FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y vsftpd

RUN mkdir -p /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty

COPY /tools/vsftpd.conf /etc/vsftpd.conf
COPY /tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

EXPOSE 20 21 40000-40005

ENTRYPOINT ["/tmp/script.sh"]

CMD ["vsftpd", "/etc/vsftpd.conf"]