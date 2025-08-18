#!/usr/bin/env bash

sudo pacman -S --noconfirm zsh
hash -r  # refresh shell hash

CURRENT_USER=${USER:-$(whoami)}

ZSH_PATH=$(which zsh)

if ! grep -q "^$ZSH_PATH$" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

chsh -s "$ZSH_PATH" "$CURRENT_USER"

