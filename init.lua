--------------------------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--------------------------------------------------------------------------------

vim.pack.add({
	{
		src = "https://github.com/neovim/nvim-lspconfig"
	},
	{
		src = 'https://github.com/folke/tokyonight.nvim'
	},
	{
		src = "https://github.com/christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		src = "https://github.com/mfussenegger/nvim-lint",
	}
})

--------------------------------------------------------------------------------

-- Source for configuring nvim-lint with gfortran:
--
--     https://fortran-lang.discourse.group/t/linter-for-nvim/8088/13?u=jeff.irwin
--
-- TODO: can these be placed in a fn to limit scope of "local" vars?
local pattern = "^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$"
local groups = { "file", "lnum", "col", "severity", "message" }
local severity_map = {
	["Error"] = vim.diagnostic.severity.ERROR,
	["Warning"] = vim.diagnostic.severity.WARN,
}
local defaults = { ["source"] = "gfortran" }

--local function fortran_linter()
--
--	require("lint.parser").from_pattern(pattern, groups, severity_map, defaults)
--end

require('lint').linters.ShadowRimFortranLinter = {
	cmd = 'gfortran',
	stdin = false,
	append_fname = true,
	args = {

		-- Required arguments
		"-fsyntax-only",
		"-fdiagnostics-plain-output",

		-- Other arguments

		-- Add your module location after `-I`, otherwise linting
		-- will stop after the first unfound `use`
		"-I./build/include/",
		"-J./build/",  -- put generated module files in build dir
		"-Wall",
		"-Wextra",
		"-Wno-tabs",
		"-cpp",
		"-fmax-errors=5",
	},
	stream = "stderr",
	ignore_exitcode = true,
	env = nil,
	--parser = fortran_linter
	parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults)
}

require('lint').linters_by_ft = {
	--markdown = {'vale'},
	fortran = {'ShadowRimFortranLinter'},
}

---- Builtin colorschemes, no packages required
--vim.cmd.colorscheme("default")
--vim.cmd.colorscheme("koehler")

-- These colorschemes require plugins

----vim.opt.background = "dark" -- or "light" for light mode
----vim.cmd.colorscheme("gruvbox")

--vim.cmd.colorscheme("tokyonight-night")
--vim.cmd.colorscheme("tokyonight-storm")
vim.cmd.colorscheme("tokyonight-moon")
--vim.cmd.colorscheme("habamax")

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
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { noremap = true })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { noremap = true })

-- idk why i have to set these TmuxNavigate* bindings in two places
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true })
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true })
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true })
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true })
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { noremap = true })

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
vim.api.nvim_set_option_value("clipboard", "unnamed", {})

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
vim.keymap.set("n", "<leader> ", "<C-^>", { noremap = true }) -- alternate to the prev opened buf

vim.keymap.set("n", "<leader>f", ":find ", { noremap = true })
vim.keymap.set("n", "<leader>l", ":ls<CR>:b ", { noremap = true })
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>p", ":bprev<CR>", { noremap = true })
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { noremap = true })
vim.keymap.set("n", "<leader>s", ":Sex<CR>", { noremap = true })
vim.keymap.set("n", "<leader>v", ":Vex!<CR>", { noremap = true })

-- Create the lsp keymaps only when a language server is active
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	end,
})

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
	end, { expr = true, noremap = true })

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

-- LSPs

---- Install:  npm i -g bash-language-server
--require("lspconfig").bashls.setup{}
--vim.api.nvim_create_autocmd('FileType', {
--  pattern = 'sh',
--  callback = function()
--    vim.lsp.start({
--      name = 'bash-language-server',
--      cmd = { 'bash-language-server', 'start' },
--    })
--  end,
--})

--********
--lua

require("lspconfig").lua_ls.setup {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name

			if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					--vim.env.VIMRUNTIME + "/lua",
					-- Depending on the usage, you might want to add additional paths here.
					--"${3rd}/luv/library",
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {}
	}
}

--********
-- fortran

require("lspconfig").fortls.setup {
	cmd = {
		'fortls',
		'--lowercase_intrinsics',
		'--hover_signature',
		'--hover_language=fortran',
		'--use_signature_help'
	}
}

--********
-- python
require("lspconfig").pyright.setup {}

--********

-- fortran linting
local function lint_runner()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
end
vim.api.nvim_create_autocmd("BufEnter"    , {callback = lint_runner})
vim.api.nvim_create_autocmd("BufWritePost", {callback = lint_runner})
vim.api.nvim_create_autocmd("InsertLeave" , {callback = lint_runner})

--------------------------------------------------------------------------------

vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_lines = true,
})

vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")

