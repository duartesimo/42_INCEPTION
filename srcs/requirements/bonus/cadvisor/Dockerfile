FROM debian:bullseye

RUN apt -y update && \
    apt -y install wget 

WORKDIR /usr/local/bin

RUN wget https://github.com/google/cadvisor/releases/download/v0.39.0/cadvisor

RUN chmod +x cadvisor

EXPOSE 8080

ENTRYPOINT ["cadvisor"]