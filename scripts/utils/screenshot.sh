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
  -w | --wiki)
    scrot '/tmp/%F_%T_$wx$h.png' --line mode=edge --select -e 'xclip -selection clipboard -target image/png -i $f'
    file_name=$(: | dmenu -i -p "File Name:" | tr ' ' '_')
    xclip -selection clipboard -o >> "$HOME/S/new_site/static/$file_name.png"
    echo -n "(/$file_name.png)" | xclip -selection clipboard
	esac
done
