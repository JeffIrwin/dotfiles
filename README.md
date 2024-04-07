
# dotfiles

My dotfiles for configuring neovim, bash, tmux, alacritty, and more to come!

## Download and Setup

### Easy way: `install.sh` ⚠️ this will overwrite your dotfiles!

Clone this anywhere then run `install.sh`

### Hard way

Clone the repository in ~/.config/ and with the directory name `nvim`:

    # mkdir ~/.config
    pushd ~/.config
    # on Windows, use "%USERPROFILE%\AppData\Local\" instead of ~/.config
    
    # mv nvim nvim-BACKUP
    
    git clone git@github.com:JeffIrwin/neovim-dotfiles.git nvim
    cd nvim
    # hackety hack

There's probably a better way for me to manage all my dotfiles than renaming the dir of the git repo, but 🤷

(maybe:  https://www.atlassian.com/git/tutorials/dotfiles)

Open init.lua in the repo and source it:

    nvim init.lua
	:so

#### Package management

For package management, see:  https://github.com/wbthomason/packer.nvim

Packer's instructions are copied here:

    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

Sync the packages in nvim:

    :PackerSync

Also source the lua scripts.

#### tmux integration

For better consistency using nvim with tmux, see [.tmux.conf](.tmux.conf).
