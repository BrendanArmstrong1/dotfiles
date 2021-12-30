#!/bin/sh

pids="$(xdotool search --onlyvisible -name '(- Discord|- mpv|Terminal|- VIM|- Brave|@|pdf)')"
focuspid="$(xdotool getwindowfocus)"
focusname="$(xdotool getwindowname $focuspid | sed ':a;N;$!ba;s/\n/ /g')"

[ -z "$pids" ] && exit

echo "$(date '+%c')"
for pid in $pids;do
    [ "$pid" = "$focuspid" ] || xdotool getwindowname $pid
done
echo "$focusname (Current window focus)" 
echo ""
