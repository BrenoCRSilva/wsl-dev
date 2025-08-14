#!/usr/bin/env bash
script_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
dry="0"


while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry="1"
    fi
    shift
done

log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

execute() {
    log "execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi
    "$@"
}

# Create directory if it doesn't exist
ensure_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        execute mkdir -p "$dir"
    fi
}

copy_dir() {
    pushd $1
    to=$2
    ensure_dir "$to"
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d ! -name ".git")
    for dir in $dirs; do
        execute rm -rf $to/$dir
        execute cp -r $dir $to/$dir
    done
    popd
}

copy_file() {
    from=$1
    to=$2
    name=$(basename $from)
    ensure_dir "$to"
    execute rm $to/$name 
    execute cp $from $to/$name
}

if [ -z "$XDG_CONFIG_HOME" ]; then
    echo "no xdg config home"
    echo "using ~/.config"
    XDG_CONFIG_HOME=$HOME/.config
fi

copy_dir env/.config $XDG_CONFIG_HOME
copy_file env/.zshrc $HOME
log "--------- dev-env ---------"



