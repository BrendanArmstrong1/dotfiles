#!/bin/sh

cat ~/storage/MediaStorage/Documents/emoji_list | dmenu -i -l 20 | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard 

pgrep -x dunst >/dev/null && notify-send "$(xclip -o -selection primary) has been copied to clipboard"
