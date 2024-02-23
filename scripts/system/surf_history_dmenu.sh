#!/bin/sh

wincur="$(xdotool getwindowfocus)"
tac ~/.config/surf/history.txt | dmenu -l 10 -i -w "$wincur" | cut -d ' ' -f 3
