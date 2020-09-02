# /bin/bash
captime=$((60*60)) # time
int="eth1" # interface
mbps="10000" # network speed

# absolute path for pcap
pcap1=""
pcap2=""
pcap3=""
pcap4=""

sudo timeout captime tcpreplay -i $int -K --loop 10000 --mbps $mbps $pcap1 &;
sudo timeout captime tcpreplay -i $int -K --loop 10000 --mbps $mbps $pcap1 &; 
sudo timeout captime tcpreplay -i $int -K --loop 10000 --mbps $mbps $pcap1 &; 
sudo timeout captime tcpreplay -i $int -K --loop 10000 --mbps $mbps $pcap1 &; 
sudo timeout captime tcpreplay -i $int -K --loop 10000 --mbps $mbps $pcap1 &; 
