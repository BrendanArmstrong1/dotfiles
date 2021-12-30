#!/bin/sh

bg="$(tac "$HOME/.config/wall.txt" | xargs echo)"
mon0="${bg%% *}"
second="${bg#* }"
mon1="${second%% *}"

echo "$mon0" > ~/.config/wall.txt
echo "$mon1" >> ~/.config/wall.txt

feh --no-fehbg --bg-scale "$mon0" --bg-scale "$mon1"
