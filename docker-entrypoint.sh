#!/usr/bin/env sh

mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

if [ -d "/home/openvpn/easy-rsa" ];
then
  echo "PKI EXITS"
  openvpn --config /etc/openvpn/server.conf
else
  cp -r /usr/share/easy-rsa /home/openvpn/
  #cp /tmp/vars /home/openvpn/easy-rsa/
  export EASYRSA_BATCH=1
  echo "INSTALL PKI AND GENERATE BUILD-CA"
  cd /home/openvpn/easy-rsa/
  sed 's/^RANDFILE /#&/' -i /home/openvpn/easy-rsa/openssl-easyrsa.cnf
  #sed 's/$ENV::EASYRSA_PKI/\/home\/openvpn\/easy-rsa/g' -i /home/openvpn/easy-rsa/openssl-easyrsa.cnf
  sh ./easyrsa init-pki
  #cp /tmp/openssl-easyrsa.cnf /home/openvpn/easy-rsa/
  sh ./easyrsa gen-dh
  cat /home/openvpn/easy-rsa/openssl-easyrsa.cnf
  sh ./easyrsa build-ca nopass
  sh ./easyrsa gen-req server nopass
  sh ./easyrsa sign-req server server batch
  openvpn --config /etc/openvpn/server.conf
fi
