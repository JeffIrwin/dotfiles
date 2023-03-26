
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use { "rose-pine/neovim" }

	--use({
	--	'rose-pine/neovim',
	--	as = 'rose-pine',
	--	config = function()
	--		vim.cmd('colorscheme rose-pine')
	--	end
	--})

	use { "ellisonleao/gruvbox.nvim" }
	--use({
	--	"ellisonleao/gruvbox.nvim",
	--	config = function()
	--		vim.o.background = "dark"
	--		vim.cmd([[colorscheme gruvbox]])
	--	end
	--})

	use('christoomey/vim-tmux-navigator')

end)
