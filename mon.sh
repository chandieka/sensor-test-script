#!/bin/bash
counter=0
int=$1
while true;
do
    txbytes_old="`cat /sys/class/net/$1/statistics/tx_bytes`";
    rxbytes_old="`cat /sys/class/net/$1/statistics/rx_bytes`";
    
    sleep 1;
    
    txbytes_new="`cat /sys/class/net/$1/statistics/tx_bytes`";
    rxbytes_new="`cat /sys/class/net/$1/statistics/rx_bytes`";
    
    txbytes=$(( txbytes_new - txbytes_old));
    rxbytes=$(( rxbytes_new  - rxbytes_old));
    
    rxmbps=$(echo "scale=2; $rxbytes*8/1000000" | bc);
    txmbps=$(echo "scale=2; $txbytes*8/1000000" | bc);

    echo "$counter $(date +"%D %T:%N") TX $txmbps Mbps RX $rxmbps Mbps"
done 