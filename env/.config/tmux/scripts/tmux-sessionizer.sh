#!/usr/bin/env zsh
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/ ~/Workspace/projects ~/personal/ ~/.config/nvim /mnt/c/Users/breno/personal/ -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

base_name=$(basename "$selected" | tr . _)

# If the path is under /mnt, prepend "win-" to the name
if [[ "$selected" == /mnt/* ]]; then
    selected_name="win-${base_name}"
else
    selected_name=$base_name
fi

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
