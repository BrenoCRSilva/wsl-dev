#!/usr/bin/env bash

KANATA_PATH="/home/brenocrs/.cargo/bin/kanata"
CONFIG_PATH="$HOME/.config/kanata/kanata.kbd"

if pgrep -x kanata >/dev/null; then
    pkill kanata
    sleep 0.2
else
    nohup "$KANATA_PATH" --cfg "$CONFIG_PATH" >/dev/null 2>&1 &
    disown
fi
        
