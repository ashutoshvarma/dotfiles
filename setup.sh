#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

MY_GPG_KEY_FP="B37F41901249D2AA"

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
link ".local/share/gpg/gpg.conf"

link ".config/nvim"
link ".config/kitty"
link ".config/dconf/user"

link ".gitconfig"
link ".gitignore"
link ".isort.cfg"
link ".p10k.zsh"
link ".tmux.conf"
link ".zprofile"
link ".zsh-aliases"
link ".zshenv"
link ".zshrc"

echo "Cloning pyenv and pyenv-virtualenv"
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

echo -e "\e[01;32mDone\e[0m"

if ! gpg -k | grep "$MY_GPG_KEY_FP" > /dev/null; then
    echo "Importing my public PGP key"
    curl -s https://ashutoshvarma.github.io/pgp_keys.asc | gpg --import
    gpg --trusted-key "$MY_GPG_KEY_FP" > /dev/null
fi
