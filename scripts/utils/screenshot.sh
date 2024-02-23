#!/bin/sh

file="$HOME/Documents/Screenshots/%Y-%m-%d_\$wx\$h_\$p.png"

for i in "$@"; do
	case $i in
	-b | --blur)
		scrot --select=blur,15 --freeze -F "$file"
		shift # past argument=value
		;;
	-h | --hide)
		scrot --select=hide --line color="Black",opacity=255 --freeze -F "$file"
		shift # past argument=value
		;;
		# -s=* | --searchpath=*)
		# 	SEARCHPATH="${i#*=}"
		# 	shift # past argument=value
		# 	;;
	-f | --full)
		scrot --line mode=edge --select -F - | nsxiv-pipe
		shift
		;;
	-s | --select)
		scrot --line mode=edge --select -F "$file"
		;;
	esac
done
