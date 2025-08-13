#!/usr/bin/env bash

git clone https://github.com/neovim/neovim.git ~/personal/neovim
cd ~/personal/neovim
git fetch
git checkout v0.11.3

sudo pacman -S --needed base-devel cmake gettext lua51 luarocks luajit
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
