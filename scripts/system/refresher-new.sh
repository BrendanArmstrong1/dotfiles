#!/usr/bin/env sh

name="$(xdotool search --onlyvisible --name '(- qutebrowser)')"
[ -z "$name" ] && exit 1


for pid in $name;do
     w
done

echo "$(xdotool getwindowname $name)"
