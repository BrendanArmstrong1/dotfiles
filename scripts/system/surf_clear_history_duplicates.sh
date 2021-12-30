#!/bin/sh

cat /home/brendan/.config/surf/history.txt > /home/brendan/.config/surf/history.temp
cat /home/brendan/.config/surf/history.temp | sort | uniq -f 2 > /home/brendan/.config/surf/history.txt
rm -f /home/brendan/.config/surf/history.temp

