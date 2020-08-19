#! /bin/bash
counter=0;
capint=$1
dest=$2
# sleep 1;
while [[ counter -le capint ]]
do  
    echo "$counter $(date +"%D %T:%N") CPU $(LC_ALL=C top -bn1 | grep "Cpu(s)" | 
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | 
    awk '{print 100 - $1}')% RAM $(free -m | 
    awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }')"  >> "$dest/usage.txt"

    sleep 1;

    counter=$(( counter + 1 ))
done