#!/bin/bash
yum -y update > /tmp/update.log

if grep -q kernel /tmp/update.log ; then
    echo "kernel update performed initiating restart" >> /tmp/update.log
    /usr/sbin/sendmail <email address> < /tmp/update.log
    shutdown -r now
else
    echo "update completed no restart required" >> /tmp/update.log
    /usr/sbin/sendmail <email address> < /tmp/update.log
fi
