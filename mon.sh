#! /bin/bash
int1="eth1"
int2="eth2"
int3="eth3"
int4="eth4"
int5="eth5"
int6="eth6"

header="%-8s %-18s %-9s %-9s\n"
format="%-8s %-18s %-9s %-9s\n"
printf "$header" "DATE" "TIMESTAMP" "TX(Mbps)" "RX(Mbps)" 
# printf "$header" "DATE" "TIMESTAMP" "TX(Mbps)" "RX(Mbps)" >> ./$dest/network.txt
while true;
do
    txbytes_old1="`cat /sys/class/net/$int1/statistics/tx_bytes`";
    txbytes_old2="`cat /sys/class/net/$int2/statistics/tx_bytes`";
    txbytes_old3="`cat /sys/class/net/$int3/statistics/tx_bytes`";
    txbytes_old4="`cat /sys/class/net/$int4/statistics/tx_bytes`";
    txbytes_old5="`cat /sys/class/net/$int5/statistics/tx_bytes`";
    txbytes_old6="`cat /sys/class/net/$int6/statistics/tx_bytes`";

    rxbytes_old1="`cat /sys/class/net/$int1/statistics/rx_bytes`";
    rxbytes_old2="`cat /sys/class/net/$int2/statistics/rx_bytes`";
    rxbytes_old3="`cat /sys/class/net/$int3/statistics/rx_bytes`";
    rxbytes_old4="`cat /sys/class/net/$int4/statistics/rx_bytes`";
    rxbytes_old5="`cat /sys/class/net/$int5/statistics/rx_bytes`";
    rxbytes_old6="`cat /sys/class/net/$int6/statistics/rx_bytes`";
    
    sleep 1;
    
    txbytes_new1="`cat /sys/class/net/$int1/statistics/tx_bytes`";
    txbytes_new2="`cat /sys/class/net/$int2/statistics/tx_bytes`";
    txbytes_new3="`cat /sys/class/net/$int3/statistics/tx_bytes`";
    txbytes_new4="`cat /sys/class/net/$int4/statistics/tx_bytes`";
    txbytes_new5="`cat /sys/class/net/$int5/statistics/tx_bytes`";
    txbytes_new6="`cat /sys/class/net/$int6/statistics/tx_bytes`";

    rxbytes_new1="`cat /sys/class/net/$int1/statistics/rx_bytes`";
    rxbytes_new2="`cat /sys/class/net/$int2/statistics/rx_bytes`";
    rxbytes_new3="`cat /sys/class/net/$int3/statistics/rx_bytes`";
    rxbytes_new4="`cat /sys/class/net/$int4/statistics/rx_bytes`";
    rxbytes_new5="`cat /sys/class/net/$int6/statistics/rx_bytes`";
    rxbytes_new6="`cat /sys/class/net/$int5/statistics/rx_bytes`";

    txbytes_total1=$(( txbytes_new1- txbytes_old1));
    txbytes_total2=$(( txbytes_new2- txbytes_old2));
    txbytes_total3=$(( txbytes_new3- txbytes_old3));
    txbytes_total4=$(( txbytes_new4- txbytes_old4));
    txbytes_total5=$(( txbytes_new5- txbytes_old5));
    txbytes_total6=$(( txbytes_new6- txbytes_old6));

    rxbytes_total1=$(( rxbytes_new1 - rxbytes_old1));
    rxbytes_total2=$(( rxbytes_new2 - rxbytes_old2));
    rxbytes_total3=$(( rxbytes_new3 - rxbytes_old3));
    rxbytes_total4=$(( rxbytes_new4 - rxbytes_old4));
    rxbytes_total5=$(( rxbytes_new5 - rxbytes_old5));
    rxbytes_total6=$(( rxbytes_new6 - rxbytes_old6));

    txbytes_sum=$((txbytes_total1 + txbytes_total2 + txbytes_total3 + txbytes_total4 + txbytes_total5 + txbytes_total6))
    rxbytes_sum=$((rxbytes_total1 + rxbytes_total2 + rxbytes_total3 + rxbytes_total4 + rxbytes_total5 + rxbytes_total6))
    
    rxmbps=$(echo "scale=2; $rxbytes_sum*8/1000000" | bc);
    txmbps=$(echo "scale=2; $txbytes_sum*8/1000000" | bc);

    printf "$format" "$(date +"%D")" "$(date +"%T.%N")"  "$txmbps" "$rxmbps"
    # printf "$format" "$counter" "$(date +"%D")" "$(date +"%T.%N")" "$txmbps" "$rxmbps" >> ./$dest/network.txt
done 