#!/bin/sh

pids="$(xdotool search --onlyvisible -name '(- Discord|- Google Chrome|Emacs|- mpv|Terminal|- VIM|- Brave|@|pdf|st)')"
focuspid="$(xdotool getwindowfocus)"
focusname="$(xdotool getwindowname $focuspid | sed ':a;N;$!ba;s/\n/ /g')"

[ -z "$pids" ] && exit

logfile="/dev/shm/netlogActtracker"
rxcurrent="$(( $(paste -d '+' /sys/class/net/[ew]*/statistics/rx_bytes) ))"
txcurrent="$(( $(paste -d '+' /sys/class/net/[ew]*/statistics/tx_bytes) ))"
if ! [ -f "$logfile" ]; then
    echo "$rxcurrent $txcurrent" > "$logfile"
    data="new"
else
    prevdata="$(cat "$logfile")"
    down="$(( (rxcurrent-${prevdata%% *})/1024 ))"
    up="$(( (txcurrent-${prevdata##* })/1024 ))"
    data="down:$down up:$up"
fi
echo "$rxcurrent $txcurrent" > "$logfile"

echo "$(date '+%c')"
for pid in $pids;do
    [ "$pid" = "$focuspid" ] || xdotool getwindowname $pid
done
echo "$focusname (Current window focus)"
echo "Data usage{$data}KiB"
echo ""
