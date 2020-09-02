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
newCap=$(getCap() $int)
newLost=$(getCap() $int)

cap=$((oldCap - newCap));
lost=$((oldLost - newLost));

echo "$cap $lost";

oldCap=oldCap
newCap=newCap
sleep 1;
done;