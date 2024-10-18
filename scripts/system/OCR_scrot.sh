#!/usr/bin/env sh

default_name_raw=$(scrot '/tmp/%F_%T_$wx$h.png' --line mode=classic --select -e 'echo $f')

directory_name=$(dirname "$0")

. "${directory_name}/OCR_scrot_files/venv/bin/activate"
image_text=$(python "${directory_name}/OCR_scrot_files/extract.py" --temp_file "$default_name_raw")

echo "$image_text" | xclip -selection clipboard
