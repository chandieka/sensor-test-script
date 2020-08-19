#!/bin/bash
counter=0
capint=$1
dest=$2
int=$3
while [[ $counter -le $capint ]];
do
    txbytes_old="`cat /sys/class/net/$3/statistics/tx_bytes`";
    rxbytes_old="`cat /sys/class/net/$3/statistics/rx_bytes`";
    
    sleep 1;
    
    txbytes_new="`cat /sys/class/net/$3/statistics/tx_bytes`";
    rxbytes_new="`cat /sys/class/net/$3/statistics/rx_bytes`";
    
    txbytes=$(( txbytes_new - txbytes_old));
    rxbytes=$(( rxbytes_new  - rxbytes_old));
    
    rxmbps=$(echo "scale=2; $rxbytes*8/1000000" | bc);
    txmbps=$(echo "scale=2; $txbytes*8/1000000" | bc);

    echo "$counter $(date +"%D %T:%N") TX $txmbps Mbps RX $rxmbps Mbps" >> ./$dest/network.txt
    counter=$((counter + 1))
done 