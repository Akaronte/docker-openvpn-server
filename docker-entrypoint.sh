#!/usr/bin/env sh


mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

if [ -d "/usr/share/easy-rsa/pki" ];
then
  echo "/usr/share/easy-rsa/pki directory exists."
else
  export EASYRSA_BATCH=1
	echo "/usr/share/easy-rsa/pki directory does not exist."
  cd /usr/share/easy-rsa/
  sh ./easyrsa init-pki
  sh ./easyrsa gen-dh
  sed 's/^RANDFILE /#&/' -i /usr/share/easy-rsa/openssl-easyrsa.cnf
  sh ./easyrsa build-ca nopass
  sh ./easyrsa gen-req server nopass
  sh ./easyrsa sign-req server server batch
  openvpn --config /etc/openvpn/server.conf
fi
