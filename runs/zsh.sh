#!/usr/bin/env bash

sudo pacman -S zsh
hash -r
chsh -s $(which zsh)
