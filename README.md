docker build -t openvpn .

openvpn --config server.conf

docker run --rm --name openvpn -ti openvpn bash


cd /usr/share/easy-rsa/

./easyrsa init-pki

./easyrsa build-ca nopass

./easyrsa gen-req server nopass

./easyrsa sign-req server server batch

./easyrsa gen-req client nopass

./easyrsa sign-req client client

./easyrsa gen-dh


 /usr/share/easy-rsa/pki/dh.pem

cp /usr/share/easy-rsa/pki/dh.pem /etc/openvpn/dh2048.pem


cp /usr/share/easy-rsa/pki/private/server.key /etc/openvpn/server.key

cp /usr/share/easy-rsa/pki/issued/server.crt /etc/openvpn/server.crt

cp /usr/share/easy-rsa/pki/ca.crt /etc/openvpn/ca.crt


https://github.com/OpenVPN/easy-rsa/blob/master/easyrsa3/easyrsa