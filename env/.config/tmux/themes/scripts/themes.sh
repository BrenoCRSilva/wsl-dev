#!/usr/bin/env bash

SELECTED_THEME="$(tmux show-option -gv @tokyo-night-tmux_theme)"
TRANSPARENT_THEME="$(tmux show-option -gv @tokyo-night-tmux_transparent)"

case $SELECTED_THEME in
"storm")
  declare -A THEME=(
    ["background"]="#24283b"
    ["foreground"]="#e0def4"
    ["black"]="#191724"
    ["blue"]="#31748f"
    ["cyan"]="#9ccfd8"
    ["green"]="#56949f"
    ["magenta"]="#c4a7e7"
    ["red"]="#eb6f92"
    ["white"]="#787c99"
    ["yellow"]="#f6c177"

    ["bblack"]="#191724"
    ["bblue"]="#31748f"
    ["bcyan"]="#9ccfd8"
    ["bgreen"]="#56949f"
    ["bmagenta"]="#c4a7e7"
    ["bred"]="#eb6f92"
    ["bwhite"]="#787c99"
    ["byellow"]="#f6c177"
  )
  ;;

"day")
  declare -A THEME=(
    ["background"]="#d5d6db"
    ["foreground"]="#343b58"
    ["black"]="#0f0f14"
    ["blue"]="#34548a"
    ["cyan"]="#0f4b6e"
    ["green"]="#33635c"
    ["magenta"]="#5a4a78"
    ["red"]="#8c4351"
    ["white"]="#343b58"
    ["yellow"]="#8f5e15"

    ["bblack"]="#9699a3"
    ["bblue"]="#34548a"
    ["bcyan"]="#0f4b6e"
    ["bgreen"]="#33635c"
    ["bmagenta"]="#5a4a78"
    ["bred"]="#8c4351"
    ["bwhite"]="#343b58"
    ["byellow"]="#8f5815"
  )
  ;;

*)
  # Default to night theme
  declare -A THEME=(
    ["background"]="#191724"
    ["foreground"]="#e0def4"
    ["black"]="#191724"
    ["blue"]="#31748f"
    ["cyan"]="#9ccfd8"
    ["green"]="#56949f"
    ["magenta"]="#c4a7e7"
    ["red"]="#eb6f92"
    ["white"]="#787c99"
    ["yellow"]="#f6c177"

    ["bblack"]="#24283b"
    ["bblue"]="#31748f"
    ["bcyan"]="#9ccfd8"
    ["bgreen"]="#56949f"
    ["bmagenta"]="#c4a7e7"
    ["bred"]="#eb6f92"
    ["bwhite"]="#787c99"
    ["byellow"]="#f6c177"
  )
  ;;
esac

# Override background with "default" if transparent theme is enabled
if [ "${TRANSPARENT_THEME}" == 1 ]; then
  THEME["background"]="default"
fi

THEME['ghgreen']="#3fb950"
THEME['ghmagenta']="#A371F7"
THEME['ghred']="#d73a4a"
THEME['ghyellow']="#d29922"

RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"
