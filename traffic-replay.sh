# /bin/bash

sudo tcpreplay -K -t --unique-ip -i eth1 -l 1000 ~/pcap/5gb-tcp-connection.pcap