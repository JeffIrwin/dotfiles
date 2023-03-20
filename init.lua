
---- This is how you include ./lua/jeff/init.lua
--require("jeff")

-- Packer package manager plugins
require("plugins")

--vim.cmd('colorscheme default')
--vim.cmd('colorscheme koehler')

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Hybrid line numbers: show the current line as absolute and others as relative
vim.cmd("set number relativenumber")

vim.cmd("set tabstop=4")

-- nvim thinks tabs are illegal in Fortran.  They're not
vim.cmd("hi link fortranTab NONE")

vim.cmd("set textwidth=80")

-- Display leading spaces as dark grey (plays well with default colorscheme and
-- koehler).  Note that this has to be applied *after* setting the colorscheme
--
-- Ref:
--
--    https://stackoverflow.com/a/40498439/4347028
--
--vim.cmd("highlight WhiteSpaceBol guibg=lightgreen")
--vim.cmd("highlight WhiteSpaceBol ctermbg=lightgreen")
--vim.cmd("highlight WhiteSpaceBol ctermbg=darkgrey")
vim.cmd("highlight WhiteSpaceBol guibg=darkgrey")
vim.cmd('match WhiteSpaceBol /^ \\+/')

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

-- Map " pv" in normal mode ("n") to ":Ex" (file explorer)
--
-- Ref:
--
--     ThePrimeagen's neovim rc youtube video

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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

