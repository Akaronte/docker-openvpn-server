FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt -y dist-upgrade && apt -y install openvpn easy-rsa && apt autoremove --purge && apt clean

RUN adduser -u 1000 openvpn

COPY server.conf /etc/openvpn/server.conf

COPY vars /tmp/

COPY docker-entrypoint.sh /usr/bin/

COPY openssl-easyrsa.cnf /tmp/

RUN chmod a+x /usr/bin/docker-entrypoint.sh 

ENTRYPOINT ["docker-entrypoint.sh"]
