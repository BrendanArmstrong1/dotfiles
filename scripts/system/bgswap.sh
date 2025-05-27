#!/bin/sh

bg="$(tac "$HOME/.config/wall.txt" | xargs echo)"
mon0="${bg%% *}"

echo "$mon0" >~/.config/wall.txt

feh --no-fehbg --bg-fill "$mon0"
