#!/usr/bin/env bash

sudo pacman -S zsh
hash -r

# Add zsh to /etc/shells and change shell
ZSH_PATH=$(which zsh)
if ! grep -q "^$ZSH_PATH$" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$ZSH_PATH"
