#!/usr/bin/sh

echo "$1"
cat ~/S/AoC/Cook2015 | xargs -I{} curl -s -H {} "https://adventofcode.com/2015/day/"$1"/input" >> ~/S/AoC/AoC-2015/dec-"$1"/input.txt 
