#!/bin/bash

color=$(xcolor 2>/dev/null)
[ -n color ] && echo -n "$color" | xclip -selection clipboard
