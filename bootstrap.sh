#!/bin/bash
cd "$(dirname "$0")"
git pull

for file in .*; do
    [ -f "$file" ] && [ -r "$file" ] && ln -s ~/dotfiles/$file ~/$file
done
unset file

source ~/.bash_profile
