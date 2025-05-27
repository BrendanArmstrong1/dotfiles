#!/bin/sh

scrot '/tmp/%F_%T_$wx$h.png' --line mode=classic --select -e 'xclip -selection clipboard -target image/png -i $f'
#scrot --line mode=edge --select -F - | 
#| xclip -selection clipboard -t image/png
