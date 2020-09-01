#!/bin/bash
counter=0
capint=$1
dest=$2

int1="eth1"
int2="eth2"
int3="eth3"
int4="eth4"

header="%-7s %-8s %-18s %-9s %-9s\n"
format="%-7s %-8s %-18s %-9s %-9s\n"
printf "$header" "COUNTER" "DATE" "TIMESTAMP" "TX(Mbps)" "RX(Mbps)" 
# printf "$header" "COUNTER" "DATE" "TIMESTAMP" "TX(Mbps)" "RX(Mbps)" >> ./$dest/network.txt
while [[ $counter -le $capint ]];
do
    txbytes_old1="`cat /sys/class/net/$int1/statistics/tx_bytes`";
    txbytes_old1="`cat /sys/class/net/$int2/statistics/tx_bytes`";
    txbytes_old1="`cat /sys/class/net/$int3/statistics/tx_bytes`";
    txbytes_old1="`cat /sys/class/net/$int4/statistics/tx_bytes`";

    rxbytes_old1="`cat /sys/class/net/$int1/statistics/rx_bytes`";
    rxbytes_old1="`cat /sys/class/net/$int2/statistics/rx_bytes`";
    rxbytes_old1="`cat /sys/class/net/$int3/statistics/rx_bytes`";
    rxbytes_old1="`cat /sys/class/net/$int4/statistics/rx_bytes`";
    
    sleep 1;
    
    txbytes_new1="`cat /sys/class/net/$int1/statistics/tx_bytes`";
    txbytes_new2="`cat /sys/class/net/$int2/statistics/tx_bytes`";
    txbytes_new3="`cat /sys/class/net/$int3/statistics/tx_bytes`";
    txbytes_new4="`cat /sys/class/net/$int4/statistics/tx_bytes`";

    rxbytes_new1="`cat /sys/class/net/$int1/statistics/rx_bytes`";
    rxbytes_new2="`cat /sys/class/net/$int2/statistics/rx_bytes`";
    rxbytes_new3="`cat /sys/class/net/$int3/statistics/rx_bytes`";
    rxbytes_new4="`cat /sys/class/net/$int4/statistics/rx_bytes`";
    
    rxbytes_old_sum=$(( rxbytes_old1 + rxbytes_old2 + rxbytes_old3 + rxbytes_old4 ))
    txbytes_old_sum=$(( txbytes_old1 + txbytes_old2 + txbytes_old3 + txbytes_old4 ))

    rxbytes_new_sum=$(( rxbytes_new1 + rxbytes_new2 + rxbytes_new3 + rxbytes_new4 ))
    txbytes_new_sum=$(( txbytes_new1 + txbytes_new2 + txbytes_new3 + txbytes_new4 ))

    txbytes=$(( txbytes_new_sum - txbytes_old_sum));
    rxbytes=$(( rxbytes_new_sum - rxbytes_old_sum));
    
    rxmbps=$(echo "scale=2; $rxbytes*8/1000000" | bc);
    txmbps=$(echo "scale=2; $txbytes*8/1000000" | bc);

    printf "$format" "$counter" "$(date +"%D")" "$(date +"%T.%N")"  "$txmbps" "$rxmbps"
    # printf "$format" "$counter" "$(date +"%D")" "$(date +"%T.%N")" "$txmbps" "$rxmbps" >> ./$dest/network.txt
    counter=$((counter + 1))
done 