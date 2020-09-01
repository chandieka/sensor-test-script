#!/bin/bash
# Ver 1.2
clear;
# Description:
# the script will run the test with the specified configuration only
# How to use this script:
#   - put all the pcaps that need to be replay at one folder
#   - Change the constant variable as needed
#   - execute the script

# constant 
pcapPath="/home/user/sample_data/" # Directory where all the pcap will be replay at
statsPath1="/nsm/sensor_data/virtualsocdemo-sensor-eth1/"
statsPath2="/nsm/sensor_data/virtualsocdemo-sensor-eth2/"
statsPath3="/nsm/sensor_data/virtualsocdemo-sensor-eth3/"
statsPath4="/nsm/sensor_data/virtualsocdemo-sensor-eth4/"
time="1"     # one second interval for data capture
mult="1.0" # replay speed multiplier
recordTime=$((20 + 3)) # duration of the data capture and traffic replay (add 3 second to consider the prep time of tcpreplay)

sec=$((recordTime % 60));
hour=$((recordTime / 60));
min=$((hour % 60))
hour=$((hour / 60))

# Data input by the user by prompt
read -p "Give a name to the test run? " testName;

# directory of test results
logPath="$(pwd)/$testName";
if [ ! -d "$logPath" ];
then
    mkdir ./$testName;
    mkdir ./$testName/data/
    mkdir ./$testName/data/eth1/
    mkdir ./$testName/data/eth2/
    mkdir ./$testName/data/eth3/
    mkdir ./$testName/data/eth4/
else
    echo "Test already existed!!"
    # exit;
fi

# start the test..

# record data
# - CPU and Memory usage
# - Network Bandwitdh on an interface

echo "Data capture start for $hour:$min:$sec"
./mon-net.sh $recordTime "./$testName/data/$int1" &
./usage.sh $recordTime ./$testName/data &

# ./resource-usage.sh $recordTime ./$testName/data/ &
# nmon -ft -s $time -c $recordTime -m ./$testName/data/ 

# timer
while [ $hour -ge 0 ]; do
        while [ $min -ge 0 ]; do
                while [ $sec -ge 0 ]; do
                        echo -ne "Time: $hour:$min:$sec\033[0K\r";
                        let "sec=sec-1";
                        sleep 1;
                done
                sec=59; 
                let "min=min-1";
        done
        min=59;
        let "hour=hour-1";
done;

echo "Copying suricata stats.log"

cp $statsPath1/stats.log ./$testName/data/eth1/stats.log
cp $statsPath1/stats.log ./$testName/data/eth2/stats.log
cp $statsPath1/stats.log ./$testName/data/eth3/stats.log
cp $statsPath1/stats.log ./$testName/data/eth4/stats.log

echo "Test Finished!!!"
# finish the test...