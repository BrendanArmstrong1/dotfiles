#!/bin/bash

if [[ $# -eq 0 ]]
then
    for device in /sys/class/video4linux/* 
    do
        declare devpath="/dev/$(basename $device)"
        read name <$device/name
        echo "$devpath => $name"
    done
fi

if [[ $# -eq 1 ]]
then
    for device in /sys/class/video4linux/* 
    do
        if grep -q "$1" $device/name
        then
            echo "/dev/$(basename $device)"
            exit 0
        fi
    done
fi

    
