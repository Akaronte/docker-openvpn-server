FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt -y dist-upgrade && apt -y install openvpn easy-rsa && apt autoremove --purge && apt clean

RUN adduser -u 1000 openvpn

COPY server.conf /etc/openvpn/server.conf

COPY vars /usr/share/easy-rsa/vars

COPY vars /home/openvpn/

COPY docker-entrypoint.sh /usr/bin/

COPY EasyRSA-3.1.1.tgz /tmp/

#ADD https://github.com/OpenVPN/easy-rsa/releases/download/v3.1.1/EasyRSA-3.1.1.tgz

RUN cd /tmp/ && tar -xvf EasyRSA-3.1.1.tgz && mv EasyRSA-3.1.1 easy-rsa

RUN chmod a+x /usr/bin/docker-entrypoint.sh 

ENTRYPOINT ["docker-entrypoint.sh"]
