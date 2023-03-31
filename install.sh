#!/bin/bash

# Hopefully one of these works
sudo dnf install nvim -y 2> /dev/null
#sudo apt install nvim -y 2> /dev/null
sudo snap install nvim --classic 2>/dev/null
brew install nvim     -y 2> /dev/null

cp .tmux.conf ~

## TODO: modify this file and copy it if you don't already have one
#cp .tmux.conf.local.example ~/.tmux.conf.local

# This works with the repo cloned anywhere.  If you're going to modify and push
# changes, it's better to actually clone directly to the destination
#
# We don't really need the tmux files here but 🤷
mkdir -p ~/.config/nvim/
cp -r ./* ~/.config/nvim/

# Setup packer as the nvim package manager
rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
#nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

