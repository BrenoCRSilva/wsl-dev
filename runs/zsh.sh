#!/usr/bin/env bash

sudo pacman -S zsh
hash -r
sudo chsh -s $(which zsh)
