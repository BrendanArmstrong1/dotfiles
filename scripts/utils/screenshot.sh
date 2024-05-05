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
    full_file_name=$(: | dmenu -i -p "File Name:" | tr ' ' '_')
    static_location="$HOME/S/Wiki/static"
    base_name=$(basename "$full_file_name")
    dir_name=$(dirname "$full_file_name")
    if [ "$dir_name" != '.' ]; then
      mkdir -p "$static_location/$dir_name"
      xclip -selection clipboard -o >> "$static_location/$dir_name/$base_name.png"
      echo -n "(/$dir_name/$base_name.png)" | xclip -selection clipboard
    else
      xclip -selection clipboard -o >> "$static_location/$base_name.png"
      echo -n "(/$base_name.png)" | xclip -selection clipboard
    fi
	esac
done
