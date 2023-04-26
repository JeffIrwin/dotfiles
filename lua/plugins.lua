
-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- themes
	use("rose-pine/neovim")
	use("ellisonleao/gruvbox.nvim")
	use("folke/tokyonight.nvim")
	--use("https://codeberg.org/oahlen/iceberg.nvim")

	-- enhanced tmux/nvim navigation interop
	use("christoomey/vim-tmux-navigator")

end)

