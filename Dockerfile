FROM ubuntu:latest
MAINTAINER Soul Assassino

ENV TS_VERSION=MatriX.110
ENV TZ=Europe/Kiev

EXPOSE 8090:8090

RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata wget curl && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    mkdir /torrserver/ && cd /torrserver/ && mkdir /db && \
    wget -O TorrServer -P /torrserver/ "https://github.com/YouROK/TorrServer/releases/download/$TS_VERSION/TorrServer-linux-amd64" && \
    chmod +x /torrserver/TorrServer
    
HEALTHCHECK --interval=30s --timeout=15s --retries=5 CMD curl -sS 127.0.0.1:8090 || exit 1

ENTRYPOINT ["/torrserver/TorrServer"]
CMD ["--path", "/torrserver/db"]
