#! /bin/bash

while true;
do
    newZeekDrop=$(cat /nsm/bro/logs/stats/stats.log | grep "total" | grep "nic_drops" | tail -n1 | cut -d ' ' -f 5);
    newZeekPkts=$(cat /nsm/bro/logs/stats/stats.log | grep "total" | grep "nic_pkts" | tail -n1 | cut -d ' ' -f 5);

    echo "$newZeekDrop $newZeekPkts $newZeekTotal"
    sleep 1;
done;