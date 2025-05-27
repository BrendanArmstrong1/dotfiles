#!/bin/bash

languages=$(echo "golang lua cpp c typescript nodjs rust python bash" | tr ' ' '\n')
core_utils=$(echo "xargs find mv sed awk" | tr ' ' '\n')

selected=$(printf "%s\n%s" "$languages" "$core_utils" | fzf)
read -rp "query: " query

if echo "$languages" | grep -qs "$selected"; then
  tmux neww bash -c "curl cht.sh/$selected/$(echo "$query" | tr ' ' '+') & while [ : ]; do sleep 1; done"
else
  tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
