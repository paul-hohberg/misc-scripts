#!/bin/bash
#disable IPv6
echo "#Disable IPv6" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
#Disable ip6tables
chkconfig ip6tables off
#Backup postfix/main.cf
cp /etc/postfix/main.cf /tmp/
#Configure postfix
sed -i -e 's/inet_protocols = all/inet_protocols = ipv4/g' /etc/postfix/main.cf
#Pause then validate
sleep 5
cat /etc/sysctl.conf
chkconfig --list ip6tables
grep inet_protocols /etc/postfix/main.cf
echo "done"
exit $?
