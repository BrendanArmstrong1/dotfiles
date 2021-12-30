#!/usr/bin/sh

echo "$1"
cat ~/S/AoC/Cook | xargs -I{} curl -s -H {} "https://adventofcode.com/2021/day/"$1"/input" >> ~/S/AoC/AoC-2021/Dec-"$1"/input.txt 
