#! /bin/bash

drop() {
    capPacket=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep packets | tail -n 1 | cut -d '|' -f3);
    dropPacket=$(cat /nsm/sensor_data/virtualsocdemo-sensor-$1/stats.log | grep drops | tail -n 1 | cut -d '|' -f3);
    a=$((dropPacket*100))
    b=$((dropPacket + capPacket))
    percentageDrop=$( echo "scale=2; $a/$b" | bc )


    echo "Interface: $1"
    echo "Captured Packet: $capPacket"
    echo "Dropped Packet: $dropPacket"
    echo "Percent dropped: $percentageDrop"
    echo ""
    echo "====================="
    echo ""
}

drop eth1;
drop eth2;
drop eth3;
drop eth4;
drop eth5;
drop eth6;