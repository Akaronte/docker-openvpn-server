#!/usr/bin/env sh

mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

if [ -f "/home/openvpn/easy-rsa" ];
then
  echo "home/openvpn/easy-rsa directory exists."
else
  cp -r /tmp/easy-rsa /home/openvpn/easy-rsa
  export EASYRSA_BATCH=1
  echo "home/openvpn/easy-rsa directory does not exist."
  cd /home/openvpn/easy-rsa/
  # sed 's/^RANDFILE /#&/' -i /home/openvpn/easy-rsa/openssl-easyrsa.cnf
  # sed 's/$ENV::EASYRSA_PKI/\/home\/openvpn/g' -i /home/openvpn/easy-rsa/openssl-easyrsa.cnf
  sh ./easyrsa init-pki
  sh ./easyrsa gen-dh
  cat /home/openvpn/easy-rsa/openssl-easyrsa.cnf
  sh ./easyrsa build-ca nopass
  sh ./easyrsa gen-req server nopass
  sh ./easyrsa sign-req server server batch
  openvpn --config /etc/openvpn/server.conf
fi
