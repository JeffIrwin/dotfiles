
# neovim-dotfiles

My dotfiles for configuring neovim

## Download and Setup

Clone the repository in ~/.config/ and then rename it from neovim-dotfiles to nvim:

	# mkdir ~/.config
	pushd ~/.config
    git clone git@github.com:JeffIrwin/neovim-dotfiles.git
	# mv nvim nvim-BACKUP
	mv neovim-dotfiles nvim
	cd nvim
	# hackety hack

There's probably a better way for me to manage all my dotfiles than renaming the dir of the git repo, but 🤷

(maybe:  https://www.atlassian.com/git/tutorials/dotfiles)

Open init.lua in the repo and source it:

    nvim init.lua
	:so

# Package management

For package management, see:  https://github.com/wbthomason/packer.nvim

Sync the packages in nvim:

    `:PackerSync`

Also source the lua scripts.

