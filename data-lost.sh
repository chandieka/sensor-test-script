#! /bin/bash

getDrop() {
    dropPacket=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    echo $dropPacket;
}

getCapture(){
    capPacket=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep capture | tail -n 1 | cut -d '|' -f3);
    echo $capPacket;
}