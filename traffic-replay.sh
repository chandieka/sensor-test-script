# /bin/bash

sudo tcpreplay -K --mbps 1000 --unique-ip -i eth1 -l 1000 ~/pcap/5gb-tcp-connection.pcap &
nload eth1