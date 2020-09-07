#! /bin/bash

mkdir ~/pcap/
cd ~/pcap/
wget http://downloads.digitalcorpora.org/corpora/packets/5gb-tcp-connection.pcap.gz
gunzip -v ./5gb-tcp-connection.pcap.gz
