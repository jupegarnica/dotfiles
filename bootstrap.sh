#!/usr/bin/env bash

cd "$(dirname "$0")"

for file in .*; do
    if [ -f $file ] && [ -r $file ]; then
        if [ -f ~/$file ] && [ ! -h ~/$file ]; then
            echo "~/$file exists; creating a backup"
            mv ~/$file ~/$file.bak || (echo "error creating backup"; exit 1)
        fi

        ln -sf ~/dotfiles/$file ~/$file
    fi
done
unset file

source ~/.bash_profile
