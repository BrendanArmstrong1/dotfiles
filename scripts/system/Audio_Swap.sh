#!/usr/bin/bash

current_sink="$(pactl info | sed -n 's/Default Sink: //p')"

declare -A audio
while IFS="|" read -r sink name ; do
    audio["$sink"]="$name"
done < <(pactl list short sinks | awk -F "\t" '{print $1 "|" $2}')


echo "$current_sink"
for i in "${!audio[@]}"; do
    [[ "${audio[$i]}" =~ 0000_05 ]] && echo "${audio[$i]} $i" && continue
    [[ "${audio[$i]}" =~ $current_sink ]] && echo "${audio[$i]} $i" && continue
    pactl set-default-sink "${audio[$i]}"
    exit
done
