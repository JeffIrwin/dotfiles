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
local f90_pattern = "^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$"
local f90_groups = { "file", "lnum", "col", "severity", "message" }
local f90_defaults = { ["source"] = "gfortran" }
local f90_severity_map = {
	["Error"] = vim.diagnostic.severity.ERROR,
	["Warning"] = vim.diagnostic.severity.WARN,
}

local fortran_linter = require("lint.parser").from_pattern(
	f90_pattern, f90_groups, f90_severity_map, f90_defaults
)

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
		"-I../../src/build/Debug", -- for aoc-fortran
		"-I./build/",
		"-I./build/include/",
		"-I./target/vc17/Win64/libCubesMod/Release/",
		"-J./build/", -- put generated module files in build dir
		"-Wall",
		"-Werror=implicit-interface",
		"-Wextra",
		"-Wno-compare-reals", -- not the most useless warning, but frequently noisy when I know what I'm doing
		"-Wno-tabs",
		"-cpp",
		"-fmax-errors=5",
		--"-I./build/debug/",
		--"-I./build/release/",
	},
	stream = "stderr",
	ignore_exitcode = true,
	env = nil,
	parser = fortran_linter
}

require('lint').linters_by_ft = {
	--markdown = {'vale'},
	fortran = { 'ShadowRimFortranLinter' },
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

-- Show a rounded box around the "hover" lsp popup (mapped to 'K' below)
vim.opt.winborder      = "rounded"

-- Case-insensitive file edit completion, e.g. `:e make<TAB>` can complete to Makefile
vim.opt.wildignorecase = true

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

-- Hide lint.  It will un-hide next time you write the buffer
--
-- Source:  https://github.com/mfussenegger/nvim-lint/issues/411#issuecomment-2360613936
vim.keymap.set("n", "<leader>h", function()
	--vim.diagnostic.enable = not vim.diagnostic.is_enabled()
	--if vim.diagnostic.is_enabled() then
	vim.diagnostic.reset()
	--else
	--	vim.diagnostic.enable()
	--end
end, { desc = "hide lint" })

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
vim.lsp.config["lua_ls"] = {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
				},
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
vim.lsp.enable("lua_ls")

--********
-- fortran

--require("lspconfig").fortls.setup {
--vim.lsp.config.fortls = {
vim.lsp.config["fortls"] = {
	cmd = {
		'fortls',
		'--lowercase_intrinsics',
		'--hover_signature',
		'--hover_language=fortran',
		'--use_signature_help'
	}
}
vim.lsp.enable("fortls")

--********
-- python
--require("lspconfig").pyright.setup {}
vim.lsp.config["pyright"] = {
}
vim.lsp.enable("pyright")

--********
-- LaTeX
vim.lsp.config["texlab"] = {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = true,
			},
			--forwardSearch = {
			--	executable = "zathura", -- or skim, sioyek, okular
			--	args = { "--synctex-forward", "%l:1:%f", "%p" },
			--},
			chktex = {
				onOpenAndSave = true,
				onEdit = false,
			},
		},
	},
}
vim.lsp.enable("texlab")

--********
-- LaTeX
--
--     cargo install texlab --locked

--require('lspconfig').texlab.setup{}
require('lspconfig').texlab.setup {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = true,
			},
			--forwardSearch = {
			--	executable = "zathura", -- or skim, sioyek, okular
			--	args = { "--synctex-forward", "%l:1:%f", "%p" },
			--},
			chktex = {
				onOpenAndSave = true,
				onEdit = false,
			},
		},
	},
}

--********

-- fortran linting
local function lint_runner()
	local lint_status, lint = pcall(require, "lint")
	if lint_status then
		lint.try_lint()
	end
end
vim.api.nvim_create_autocmd("BufEnter", { callback = lint_runner })
vim.api.nvim_create_autocmd("BufWritePost", { callback = lint_runner })
vim.api.nvim_create_autocmd("InsertLeave", { callback = lint_runner })

--------------------------------------------------------------------------------

vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_lines = true,
})

vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")
