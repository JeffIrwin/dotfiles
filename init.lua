
--------------------------------------------------------------------------------

---- This is how you include ./lua/jeff/init.lua
--require("jeff")

-- Packer package manager plugins
require("plugins")

--********

---- Builtin colorschemes, no packer required
--vim.cmd.colorscheme("default")
--vim.cmd.colorscheme("koehler")

-- These colorschemes require packer plugins

----vim.opt.background = "dark" -- or "light" for light mode
----vim.cmd.colorscheme("gruvbox")

--vim.cmd.colorscheme("tokyonight-night")
----vim.cmd.colorscheme("tokyonight-storm")
vim.cmd.colorscheme("tokyonight-moon")

----vim.cmd.colorscheme("iceberg")
--vim.cmd.colorscheme("rose-pine")

--********

-- Hybrid line numbers: show the current line as absolute and others as relative
vim.opt.number         = true
vim.opt.relativenumber = true

-- Remap split-window navigation commands, e.g. Ctrl+j instead of the standard
-- Ctrl+w Ctrl+j
--
-- Ref:
--
--     https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#easier-split-navigations
--
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {noremap = true})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {noremap = true})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {noremap = true})
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {noremap = true})

-- netrw (explorer) overrides normal keymaps.  this breaks the tmux integration
-- and i'm not sure if i can do anything about that (although it works if you
-- edit a normal file from netrw)
vim.cmd.autocmd("FileType netrw nmap <buffer> <C-j> <C-w><C-j>")
vim.cmd.autocmd("FileType netrw nmap <buffer> <C-k> <C-w><C-k>")
vim.cmd.autocmd("FileType netrw nmap <buffer> <C-l> <C-w><C-l>")
vim.cmd.autocmd("FileType netrw nmap <buffer> <C-h> <C-w><C-h>")

-- Open new splits to the right and bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use standard vim yank `y` and put `p` to copy/paste into/out-of vim
vim.api.nvim_set_option("clipboard", "unnamed")

---- not sure why i resorted to the stuff below, but the "clipboard" "unnamed"
---- setting above, in conjunction with "save_to_clipboard" in alacritty.toml,
---- has copy and paste working in all contexts

--vim.g.clipboard =
--{
--	name = 'WslClipboard',
--	copy = {
--		["+"] = 'clip.exe',
--		["*"] = 'clip.exe',
--	 },
--	paste = {
--		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--	},
--	cache_enabled = 0,
--}

--------------------------------------------------------------------------------

-- The leader key is like your personal namespace for vim commands.  Any command
-- defined with the leader as a prefix is guaranteed not to clash with any
-- builtin keybinding.
vim.g.mapleader = " "

--vim.keymap.set("n", "<leader>a", "<C-^>"     , {noremap = true}) -- alternate to the prev opened buf
vim.keymap.set("n", "<leader> ", "<C-^>"     , {noremap = true}) -- alternate to the prev opened buf

vim.keymap.set("n", "<leader>f", ":find "    , {noremap = true})
vim.keymap.set("n", "<leader>l", ":ls<CR>:b ", {noremap = true})
vim.keymap.set("n", "<leader>n", ":bnext<CR>", {noremap = true})
vim.keymap.set("n", "<leader>p", ":bprev<CR>", {noremap = true})
vim.keymap.set("n", "<leader>e", ":Ex<CR>"   , {noremap = true})
vim.keymap.set("n", "<leader>s", ":Sex<CR>"  , {noremap = true})
vim.keymap.set("n", "<leader>v", ":Vex!<CR>" , {noremap = true})

--------------------------------------------------------------------------------

-- Jeff's dumb supertab replacement
vim.keymap.set("i", "<Tab>",
function()

	local col = vim.fn.col(".") - 1

	-- If we're at the beginning of the line or on whitespace, insert a tab
	-- literal.  Otherwise, map to previous autocomplete (Ctrl+p)
	--
	-- Ref:
	--
	--     https://github.com/elianiva/dotfiles/blob/b0742981158c89063593ce27f74f780f3474d331/nvim/.config/nvim/lua/modules/_util.lua

	if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		return "<Tab>"
	else
		return "<C-p>"
	end

end, {expr = true, noremap = true})

--------------------------------------------------------------------------------

-- changemewtf's fuzzy finder.  Usage: ```<leader>f *pattern*<Tab>``` or 
-- ```:find *pattern*<Enter>```.  For example, I have a file under this
-- directory with this path and name:
--
--     ./after/ftplugin/fortran.lua
--
-- To edit it, simply type (in normal mode) " f for<Tab><Enter>".  That's
-- assuming there's no other match before it in the tab completion menu.
vim.opt.path:append { "**" } -- you *must* use ".opt" here, not just ".o"

-- TODO: try making a project-specific include which appends things like 3p
vim.opt.wildignore:append { "*/scratch/*", "*/target/*", "*/build/*" }

--------------------------------------------------------------------------------

