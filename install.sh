#!/bin/bash
#opvs (Wegare)
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/openvpn-stunnel/main/opvs.sh" -O /usr/bin/opvs
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/openvpn-stunnel/main/autorekonek-opvs.sh" -O /usr/bin/autorekonek-opvs
opkg update && opkg install lsof openvpn-openssl stunnel
chmod +x /usr/bin/opvs
chmod +x /usr/bin/autorekonek-opvs
rm -r ~/install.sh
mkdir -p ~/akun/
touch ~/akun/opvs.txt
sleep 2
echo "install selesai"
echo "untuk memulai tools silahkan jalankan perintah 'opvs'"

				