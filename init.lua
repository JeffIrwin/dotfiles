
---- This is how you include ./lua/jeff/init.lua
--require("jeff")

-- Packer package manager plugins
require("plugins")

--print("hello from init.lua")

--vim.cmd('colorscheme default')
--vim.cmd('colorscheme koehler')
--vim.cmd('colorscheme rose-pine')

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

--vim.cmd("highlight WhiteSpaceBol guibg=lightgreen")
--vim.cmd("highlight WhiteSpaceBol ctermbg=lightgreen")
--vim.cmd("highlight WhiteSpaceBol ctermbg=darkgrey")
vim.cmd("highlight WhiteSpaceBol guibg=darkgrey")
vim.cmd('match WhiteSpaceBol /^ \\+/')
    
--vim.cmd('inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"')
--vim.cmd('inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"')

--vim.keymap.set('i', '<Tab>', function()
--    return vim.fn.pumvisible() == 1 and '<C-N>' or '<Tab>'
--end, {expr = true})

--vim.keymap.set('i', '<Tab>', "<C-n>", {})
--vim.keymap.set('i', '<Tab>', "<C-p>", {})

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

    --return '<C-p>'

end, {expr = true})

-- vaa
-- vab
-- vac

--local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
--vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

--local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--vim.keymap.set("i", "<TAB>", 'pumvisible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
--vim.keymap.set("i", "<S-TAB>", [[pumvisible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

--function smart_tab()
--    if vim.fn.pumvisible() ~= 0 then
--        vim.api.nvim_eval([[feedkeys("\<c-n>", "n")]])
--        return
--    end
--
--    local col = vim.fn.col(".") - 1
--    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
--        vim.api.nvim_eval([[feedkeys("\<tab>", "n")]])
--        return
--    end
--
--    vim.fn["compe#complete"]();
--end

--function smart_tab()
--    if vim.fn.pumvisible() ~= 0 then
--        vim.api.nvim_eval([[feedkeys("\<c-n>", "n")]])
--        return
--    end
--
--    local col = vim.fn.col(".") - 1
--    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
--        vim.api.nvim_eval([[feedkeys("\<tab>", "n")]])
--        return
--    end
--
--    vim.fn["compe#complete"]();
--end

