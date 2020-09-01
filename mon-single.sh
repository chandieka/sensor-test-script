#!/bin/bash
int1="$1"

header="%-8s %-18s %-9s %-9s\n"
format="%-8s %-18s %-9s %-9s\n"
printf "$header" "DATE" "TIMESTAMP" "TX(Mbps)" "RX(Mbps)" 
# printf "$header" "DATE" "TIMESTAMP" "TX(Mbps)" "RX(Mbps)" >> ./$dest/network.txt
while true;
do
    txbytes_old="`cat /sys/class/net/$int1/statistics/tx_bytes`";
    rxbytes_old="`cat /sys/class/net/$int1/statistics/rx_bytes`";
    
    sleep 1;
    
    txbytes_new="`cat /sys/class/net/$int1/statistics/tx_bytes`";
    rxbytes_new="`cat /sys/class/net/$int1/statistics/rx_bytes`";
   
    txbytes=$(( txbytes_new - txbytes_old));
    rxbytes=$(( rxbytes_new - rxbytes_old));
    
    rxmbps=$(echo "scale=2; $rxbytes*8/1000000" | bc);
    txmbps=$(echo "scale=2; $txbytes*8/1000000" | bc);

    printf "$format" "$(date +"%D")" "$(date +"%T.%N")"  "$txmbps" "$rxmbps"
    # printf "$format" "$(date +"%D")" "$(date +"%T.%N")" "$txmbps" "$rxmbps" >> ./$dest/network.txt
done 