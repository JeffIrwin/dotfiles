#!/bin/bash

set -x

# Hopefully one of these works
#
# I've had better luck with the pre-built archives and the AppImage ("universal"
# Linux package)
#sudo dnf install nvim -y 2> /dev/null
#sudo apt install nvim -y 2> /dev/null
#sudo snap install nvim --classic 2>/dev/null

### brew installs nvim 0.7.  Better to use the curl/tar method below to get
### up-to-date version
##brew install nvim        2> /dev/null

## TODO: add "if darwin" logic
#curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
#tar xzf nvim-macos.tar.gz
#cp ./nvim-macos/bin/nvim /usr/local/bin/

cp .tmux.conf ~

## TODO: modify this file and copy it if you don't already have one
#cp .tmux.conf.local.example ~/.tmux.conf.local

#USERNAME=$(cmd.exe /c "echo %USERNAME%")  # includes a carriage return :(
#APPDATA="/mnt/c/Users/$USERNAME/AppData/Roaming/"
APPDATA="/mnt/c/Users/$USER/AppData/Roaming/"
mkdir -p "$APPDATA/alacritty/"
cp alacritty.toml !$

# This works with the repo cloned anywhere.  If you're going to modify and push
# changes, it's better to actually clone directly to the destination
#
# We don't really need the tmux files et al here but 🤷
mkdir -p  ~/.config/nvim/
rm -rf pack
cp -r ./* ~/.config/nvim/

## Setup packer as the nvim package manager
#rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#
#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
#nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

cp .bashrc  ~
cp .inputrc ~

