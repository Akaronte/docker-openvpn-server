FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt -y dist-upgrade && apt -y install openvpn easy-rsa && apt autoremove --purge && apt clean

RUN adduser -u 1000 openvpn

COPY server.conf /etc/openvpn/server.conf

# COPY ca.crt /etc/openvpn/ca.crt

# COPY server.crt /etc/openvpn/server.crt

# COPY server.key /etc/openvpn/server.key

# COPY dh2048.pem /etc/openvpn/dh2048.pem

# COPY EasyRSA-3.0.8.tgz /home/openvpn/EasyRSA-3.0.8.tgz

# RUN tar -xvf EasyRSA-3.0.8.tgz

# WORKDIR /home/openvpn

# USER openvpn

# ln -s /usr/share/easy-rsa/* ~/easy-rsa/

COPY vars /usr/share/easy-rsa/vars

COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]