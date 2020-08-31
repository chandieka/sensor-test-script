#!/bin/bash
# by Paul Colby (http://colby.id.au), no rights reserved ;)
# by chandieka 

timer=$1
dest=$2
counter=0
PREV_TOTAL=0
PREV_IDLE=0
mem_total=$(cat /proc/meminfo | grep "MemTotal" | grep -Eo "[0-9]*") # in kB
header="%-7s %-28s %-8s %-8s\n"
format="%-7s %-28s %-8s %-8s\n"
# printf "$header" "COUNTER" "TIMESTAMP" "CPU(%)" "MEMORY(%)"
printf "$header" "COUNTER" "TIMESTAMP" "CPU(%)" "MEMORY(%)" >> "./$dest/usage.txt"
while [[ $counter -le $timer ]]; do
  # Get the total CPU statistics, discarding the 'cpu ' prefix.
  # Get Free memory
  CPU=($(sed -n 's/^cpu\s//p' /proc/stat))
  mem_free=$(cat /proc/meminfo | grep "MemFree" | grep -Eo "[0-9]*") # in kB
  buffers=$(cat /proc/meminfo | grep "Buffers" | grep -Eo "[0-9]*")
  IDLE=${CPU[3]} # Just the idle CPU time.

  # Calculate the total CPU time.
  TOTAL=0
  for VALUE in "${CPU[@]:0:8}"; do
    TOTAL=$((TOTAL+VALUE))
  done

  # Calculate the CPU usage since we last checked.
  DIFF_IDLE=$((IDLE-PREV_IDLE))
  DIFF_TOTAL=$((TOTAL-PREV_TOTAL))
  DIFF_USAGE=$(echo "scale=2; ((1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10)" | bc )
  # Calculate the memory usage
  mem_usage=$(echo "scale=2; (($mem_total-$mem_free)*100)/$mem_total" | bc)
  # output the data
  # printf "$format" "$counter" "$(date +"%D %T:%N")" "$DIFF_USAGE%" "$mem_usage%"
  printf "$format" "$counter" "$(date +"%D %T:%N")" "$DIFF_USAGE%" "$mem_usage%" >> "./$dest/usage.txt"
  # Remember the total and idle CPU times for the next check.
  PREV_TOTAL="$TOTAL"
  PREV_IDLE="$IDLE"

  # Wait before checking again.
  sleep 1
  counter=$((counter + 1))
done