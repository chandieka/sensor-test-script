#! /bin/bash
int="eth1"

getDrop() {
    dropPacket1=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    # dropPacket2=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$2/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    # dropPacket3=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$3/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    # dropPacket4=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$4/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    # dropPacket5=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$5/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    # dropPacket6=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$6/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);

    # echo $(( dropPacket1 + dropPacket2 + dropPacket3 + dropPacket4 + dropPacket5  + dropPacket6 ));
    echo $dropPacket1;

}

getCapture(){
    capPacket1=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);
    # capPacket2=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$2/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);
    # capPacket3=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$3/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);
    # capPacket4=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$4/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);
    # capPacket5=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$5/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);
    # capPacket6=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$6/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);

    # echo $(( capPacket1 + capPacket2 + capPacket3 + capPacket4 + capPacket5  + capPacket6 )) ;
    echo $capPacket1;
}

oldCap=0;
oldLost=0;
format="%-18s %-15s %-15s %-15s\n"
header="%-18s %-15s %-15s %-15s\n"
printf "$header" "TIMESTAMP" "PROCESSED" "DROPPED" "OVERALL DROPPED(%)"
while true;
do 
    newCap=$(getCapture eth1)
    newLost=$(getDrop eth1)

    cap=$((newCap - oldCap));
    lost=$((newLost - oldLost));
    a=$(( newLost + newCap ))
    b=$(( newLost * 100))

    if [[ $cap != 0 || $lost != 0 ]]
    then
        dropPercent=$(echo "scale=2; $b/$a" | bc);
        printf "$format" "$(date +"%T.%N")" "$cap" "$lost" "$dropPercent%"
    fi;

    oldCap=$newCap
    oldLost=$newLost
    sleep 1;
done;