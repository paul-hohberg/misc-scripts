#!/bin/bash

IPLIST="./hosts.txt"


for ip in $(cat $IPLIST)

do
    ping -c 2 -t 2 $ip &> /dev/null
    if [ $? -ne 0 ]; then

        echo $ip >> hosts_down.txt;

        else

        echo $ip >> hosts_up.txt;

    fi

done
