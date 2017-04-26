#!/usr/bin/env bash

N=$(hostname)

#Isolate plone instance PID
A=`ps -ef | grep adminvc/parts/instance/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
A2=`ps -ef | grep adminvc/parts/instance2/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
C=`ps -ef | grep campusservices/parts/instance/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
C2=`ps -ef | grep campusservices/parts/instance2/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
H=`ps -ef | grep housing/parts/instance/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
H2=`ps -ef | grep housing/parts/instance2/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
T=`ps -ef | grep transportation/parts/instance/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
T2=`ps -ef | grep transportation/parts/instance2/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
U=`ps -ef | grep ucpd/parts/instance/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`
U2=`ps -ef | grep ucpd/parts/instance2/etc/zope.conf | grep -v zdaemon | grep plone | gawk '{print \$2}'`

#Set P to %memory utilization threshold
P=12

#Get memory utilization for plone instances
MA=`top -bd .10 -p $A -n 1  | grep $A | gawk '{print \$10}'`
MA2=`top -bd .10 -p $A2 -n 1  | grep $A2 | gawk '{print \$10}'`
MC=`top -bd .10 -p $C -n 1  | grep $C | gawk '{print \$10}'`
MC2=`top -bd .10 -p $C2 -n 1  | grep $C2 | gawk '{print \$10}'`
MH=`top -bd .10 -p $H -n 1  | grep $H | gawk '{print \$10}'`
MH2=`top -bd .10 -p $H2 -n 1  | grep $H2 | gawk '{print \$10}'`
MT=`top -bd .10 -p $T -n 1  | grep $T | gawk '{print \$10}'`
MT2=`top -bd .10 -p $T2 -n 1  | grep $T2 | gawk '{print \$10}'`
MU=`top -bd .10 -p $U -n 1  | grep $U | gawk '{print \$10}'`
MU2=`top -bd .10 -p $U2 -n 1  | grep $U2 | gawk '{print \$10}'`

#Create new email file with subject
echo "Subject: Memory Utilization Alert $N" > /tmp/alertmail.txt

#Compare memory utilization to threshold
if (( $(echo "$MA > $P" | bc -l) )); then
echo "Memory alert adminvc plone instance 1 has reached $MA% memory utilization" >> /tmp/alertmail.txt 
fi

if (( $(echo "$MA2 > $P" | bc -l) )); then
echo "Memory alert adminvc plone instance 2 has reached $MA2% memory utilization" >> /tmp/alertmail.txt 
fi

if (( $(echo "$MC > $P" | bc -l) )); then
echo "Memory alert campus services plone instance 1 has reached $MC% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MC2 > $P" | bc -l) )); then
echo "Memory alert campus services plone instance 2 has reached $MC2% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MH > $P" | bc -l) )); then
echo "Memory alert housing plone instance 1 has reached $MH% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MH2 > $P" | bc -l) )); then
echo "Memory alert housing plone instance 2 has reached $MH2% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MT > $P" | bc -l) )); then
echo "Memory alert transportation instance 1 has reached $MT% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MT2 > $P" | bc -l) )); then
echo "Memory alert transportation instance 2 has reached $MT2% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MU > $P" | bc -l) )); then
echo "Memory alert ucpd instance 1 has reached $MU% memory utilization" >> /tmp/alertmail.txt
fi

if (( $(echo "$MU2 > $P" | bc -l) )); then
echo "Memory alert ucpd instance 2 has reached $MU2% memory utilization" >> /tmp/alertmail.txt
fi

if grep -q instance /tmp/alertmail.txt
then
sendmail <email address> < /tmp/alertmail.txt
fi

exit
