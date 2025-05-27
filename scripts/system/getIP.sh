#!/bin/sh

ip="$(curl -s ifconfig.me)" 
date="$(date +%c)"
echo "$date IP:$ip" >> ~/Documents/PublicIP
