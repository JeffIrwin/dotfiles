#!/bin/bash

# Hopefully one of these works
sudo apt install nvim -y 2> /dev/null
sudo dnf install nvim -y 2> /dev/null
brew install nvim     -y 2> /dev/null

cp .tmux.conf ~

## TODO: modify this file and copy it if you don't already have one
#cp .tmux.conf.local.example ~/.tmux.conf.local

mkdir -p ~/.config/nvim/
cp -r ./* ~/.config/nvim/

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim +PackerSync +q

