#!/usr/bin/env bash

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"


echo "Linking config files to $XDG_CONFIG_HOME..."

if [ ! -d "$XDG_CONFIG_HOME" ]; then
  mkdir -p "$XDG_CONFIG_HOME"
fi

for src in "$CONFIG_DIR/configs/"*;do
  base=$(basename "$src")
  dest="$XDG_CONFIG_HOME/$base"

  if [ -L "$dest" ]; then
    echo "Skipping $dest: already symlinked"
    continue
  elif [ -e "$dest" ]; then
    bak="$dest.bak"
    if [ -e "$bak" ];then
      echo "Warning: $bak already exists. Skipping $base"
      continue
    fi
    mv "$dest" "$bak"
    echo "Moved existing $dest to $bak"
  fi

  ln -s "$src" "$dest"
  echo "Linked $src -> $dest"
done
