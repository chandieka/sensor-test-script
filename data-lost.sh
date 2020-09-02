#! /bin/bash

int="eth1"

getDrop() {
    dropPacket=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    echo $dropPacket;
}

getCapture(){
    capPacket=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep capture | tail -n 1 | cut -d '|' -f3);
    echo $capPacket;
}

oldCap=0
oldLost=0

while true;
do 
newCap=$(getCapture $int)
newLost=$(getLost $int)

cap=$((newCap - oldCap));
lost=$((newLost - oldLost));

if [[ $cap != 0 && $lost != 0 ]]
then
    echo "$cap $lost";
fi;

oldCap=newCap
newCap=newOld
sleep 1;
done;