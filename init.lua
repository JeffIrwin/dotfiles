
---- This is how you include ./lua/jeff/init.lua
--require("jeff")

-- Packer package manager plugins
require("plugins")

---- Builtin colorschemes, no packer required
--vim.cmd('colorscheme default')
--vim.cmd('colorscheme koehler')

-- These colorschemes require packer plugins
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
--vim.cmd([[colorscheme rose-pine]])

-- Hybrid line numbers: show the current line as absolute and others as relative
vim.o.number         = true
vim.o.relativenumber = true

-- Remap split-window navigation commands, e.g. Ctrl+j instead of the standard
-- Ctrl+w Ctrl+j
--
-- Ref:
--
--     https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#easier-split-navigations
--
vim.cmd("nnoremap <C-j> <C-w><C-j>")
vim.cmd("nnoremap <C-k> <C-w><C-k>")
vim.cmd("nnoremap <C-l> <C-w><C-l>")
vim.cmd("nnoremap <C-h> <C-w><C-h>")

-- Open new splits to the right and bottom
vim.cmd("set splitright")
vim.cmd("set splitbelow")

-- -----------------------------------------------------------------------------

vim.g.mapleader = " "

-- Map " pv" in normal mode ("n") to ":Ex" (file explorer).  Apparently this
-- shortcut is from emacs or something?
--
-- Ref:
--
--     ThePrimeagen's neovim rc youtube video
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)   -- explorer in current split

--vim.keymap.set("n", "<leader>ps", vim.cmd.Vex!) -- explorer in new split on right
vim.keymap.set("n", "<leader>ps", function() vim.cmd.Vex{ bang = true } end) -- explorer in new split on right

-- Jeff's dumb supertab replacement
vim.keymap.set('i', '<Tab>',
function()

	local col = vim.fn.col('.') - 1

	-- If we're at the beginning of the line or on whitespace, insert a tab
	-- literal.  Otherwise, map to previous autocomplete (Ctrl+p)
	--
	-- Ref:
	--
	--     https://github.com/elianiva/dotfiles/blob/b0742981158c89063593ce27f74f780f3474d331/nvim/.config/nvim/lua/modules/_util.lua

	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return '<Tab>'
	else
		return '<C-p>'
	end

end, {expr = true})

