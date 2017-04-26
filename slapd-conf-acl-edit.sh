#!/bin/bash
##This script edits slapd ACL after backup##
##then adds/ removes users and restarts slapd##

##define users and file path here##
USROLD=olduser
USRNEW=newuser
CONF=/usr/local/openldap/etc/openldap/slapd.conf

##check for root access##
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
##backup configuration file##
cp $CONF $CONF.`date +%F_%H%M%S`
if [ $? -eq 0 ]; then
    echo "$CONF backed up"
else
    echo "$CONF back up failed"
    exit 1
fi
##check old user exists##
grep $USROLD $CONF
if [ $? -eq 0 ]; then
    echo "The above lines contain $USROLD and will be modified"
else
    echo "$USROLD not found"
    exit 1
fi
##replace old user with new user##
sed -i -e "s/$USROLD/$USRNEW/g" "$CONF"
if [ $? -eq 0 ]; then
    echo "with $USRNEW like so"
    grep $USRNEW slapd.conf
else
    echo "edit failed validate configuration"
    exit 1
fi
/sbin/service slapd stop
sleep 3
/sbin/service slapd start
exit
