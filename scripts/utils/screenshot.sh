#!/bin/bash

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
	-p | --pictures)
    default_name_raw=$(scrot '/tmp/%F_%T_$wx$h.png' --line mode=edge --select -e 'echo $f')
    default_name=$(echo "${default_name_raw#*tmp/}" | tr ':' '-')
    full_file_name=$(: | dmenu -i -p "File Name:" | tr ' ' '_')
    static_location="$HOME/Documents/Pictures"
    base_name=$(basename "$full_file_name")
    if [ "$full_file_name" == '' ]; then
      dir_name="refile"
      mkdir -p "$static_location/$dir_name"
      cp "$default_name_raw" "$static_location/$dir_name/$default_name"
      echo -n "/$static_location/$dir_name/$default_name" | xclip -selection clipboard
    else
      mkdir -p "$static_location"
      cp "$default_name_raw" "$static_location/$base_name.png"
      echo -n "$static_location/$base_name.png" | xclip -selection clipboard
    fi
		;;
  -w | --wiki)
    scrot '/tmp/%F_%T_$wx$h.png' --line mode=edge --select -e 'xclip -selection clipboard -target image/png -i $f'
    full_file_name=$(: | dmenu -i -p "File Name:" | tr ' ' '_')
    static_location="$HOME/ssd/Wiki/static"
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
