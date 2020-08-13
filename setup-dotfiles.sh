#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

dotfiles_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd "$dotfiles_dir"

link() {
    orig_file="$dotfiles_dir/$1"
    if [ -n "$2" ]; then
        dest_file="$HOME/$2"
    else
        dest_file="$HOME/$1"
    fi

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
}


echo -e "\e[01;32m-------------------\e[0m"
echo -e "\e[01;32mSetting Up dotfiles\e[0m"
echo -e "\e[01;32m-------------------\e[0m"

link ".local/bin/prime-offload.sh"
link ".local/share/applications/prime-offload.desktop"

link ".config/nvim"
link ".config/kitty"

link ".gitconfig"
link ".gitignore"
link ".isort.cfg"
link ".p10k.zsh"
link ".tmux.conf"
link ".zprofile"
link ".zsh-aliases"
link ".zshenv"
link ".zshrc"

echo -e "\e[01;32mDone\e[0m"

