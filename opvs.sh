#!/bin/bash
#opvs (Wegare)
stop () {
killall -q openvpn stunnel fping
/etc/init.d/dnsmasq restart 2>/dev/null
}
user2="$(cat /root/akun/pass-opvs.txt | awk 'NR==1')" 
host2="$(cat /root/akun/opvs.txt | grep -i host | cut -d= -f2 | head -n1)"
port2="$(cat /root/akun/opvs.txt | grep -i port | cut -d= -f2 | head -n1)" 
pass2="$(cat /root/akun/pass-opvs.txt | awk 'NR==2')" 
openvpn2="$(cat /root/akun/opvs.txt | grep -i direkopvpn | cut -d= -f2)" 
bug2="$(cat /root/akun/opvs.txt | grep -i bug | cut -d= -f2)" 
clear
echo "Inject openvpn stunnel by wegare"
echo "1. Sett Profile"
echo "2. Start Inject"
echo "3. Stop Inject"
echo "4. Enable auto booting & auto rekonek"
echo "5. Disable auto booting & auto rekonek"
echo "e. exit"
read -p "(default tools: 2) : " tools
[ -z "${tools}" ] && tools="2"
if [ "$tools" = "1" ]; then
echo "Masukkan host/ip" 
read -p "default host/ip: $host2 : " host
[ -z "${host}" ] && host="$host2"

echo "Masukkan port ssl" 
read -p "default port ssl: $port2 : " port
[ -z "${port}" ] && port="$port2"

echo "Masukkan user" 
read -p "default user: $user2 : " user
[ -z "${user}" ] && user="$user2"

echo "Masukkan pass" 
read -p "default pass: $pass2 : " pass
[ -z "${pass}" ] && pass="$pass2"

echo "Masukkan bug" 
read -p "default bug: $bug2 : " bug
[ -z "${bug}" ] && bug="$bug2"

echo ""
echo "edit config ovpn" 
echo "tambahkan /root/akun/pass-opvs.txt di auth-user-pass" 
echo "contoh : auth-user-pass /root/akun/pass-opvs.txt" 
echo "edit remote menjadi remote 127.0.0.1 6969"
echo "contoh : remote $host $port menjadi remote 127.0.0.1 6969"
echo "tambahkan dibawah remote: route $host 255.255.255.255 net_gateway"
echo "lalu masukkan config kedalam direktori root openwrt"
echo ""
echo "Masukkan nama config ovpn" 
echo "contoh wegare.ovpn" 
read -p "default nama config ovpn: $openvpn2 : " openvpn
[ -z "${openvpn}" ] && openvpn="$openvpn2"

echo "[VPN]
client = yes
accept = 127.0.0.1:6969
connect = $host:$port
sni = $bug" > /root/akun/openssl.conf

echo "host=$host
port=$port
direkopvpn=$openvpn
bug=$bug" > /root/akun/opvs.txt
echo "$user
$pass" > /root/akun/pass-opvs.txt
echo "Sett Profile Sukses"
sleep 2
clear
/usr/bin/opvs
elif [ "${tools}" = "2" ]; then
stop
opvpn3="$(cat /root/akun/opvs.txt | grep -i direkopvpn | cut -d= -f2 | head -n1)" 
opvpn=$(find /root -name $opvpn3)
stunnel /root/akun/openssl.conf > /dev/null &
sleep 3
openvpn $opvpn &
fping -l google.com > /dev/null 2>&1 &
elif [ "${tools}" = "3" ]; then
stop
echo "Stop Suksess"
sleep 2
clear
/usr/bin/opvs
elif [ "${tools}" = "4" ]; then
cat <<EOF>> /etc/crontabs/root

# BEGIN AUTOREKONEKOPVS
*/1 * * * *  autorekonek-opvs
# END AUTOREKONEKOPVS
EOF
sed -i '/^$/d' /etc/crontabs/root 2>/dev/null
/etc/init.d/cron restart
echo "Enable Suksess"
sleep 2
clear
/usr/bin/opvs
elif [ "${tools}" = "5" ]; then
sed -i "/^# BEGIN AUTOREKONEKOPVS/,/^# END AUTOREKONEKOPVS/d" /etc/crontabs/root > /dev/null
/etc/init.d/cron restart
echo "Disable Suksess"
sleep 2
clear
/usr/bin/opvs
elif [ "${tools}" = "e" ]; then
clear
exit
else 
echo -e "$tools: invalid selection."
exit
fi