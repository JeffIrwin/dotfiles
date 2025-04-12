--------------------------------------------------------------------------------

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },

			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{
			"neovim/nvim-lspconfig"
		},
		{
			-- Source for configuring nvim-lint with gfortran:
			--
			--     https://fortran-lang.discourse.group/t/linter-for-nvim/8088/13?u=jeff.irwin
			--
			"mfussenegger/nvim-lint",
			event = { "BufWritePost", "InsertLeave" },
			config = function()
				local lint = require "lint"
				local gfortran_diagnostic_args =
				{
					-- Add your module location after `-I`, otherwise linting
					-- will stop after the first unfound `use`
					"-I./build/include/",
					"-J./build/",  -- put generated module files in build dir
					"-Wall",
					"-Wextra",
					"-Wno-tabs",
					"-fmax-errors=5",
				}
				lint.linters_by_ft = {
					fortran = {
						"gfortran",
					},
				}
				local pattern = "^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$"
				local groups = { "file", "lnum", "col", "severity", "message" }
				local severity_map = {
					["Error"] = vim.diagnostic.severity.ERROR,
					["Warning"] = vim.diagnostic.severity.WARN,
				}
				local defaults = { ["source"] = "gfortran" }

				local required_args = { "-fsyntax-only", "-fdiagnostics-plain-output" }
				local args = vim.list_extend(required_args, gfortran_diagnostic_args)

				lint.linters.gfortran = {
					cmd = "gfortran",
					stdin = false,
					append_fname = true,
					stream = "stderr",
					env = nil,
					args = args,
					ignore_exitcode = true,
					parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
				}
			end,
		}
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	--install = { colorscheme = { "habamax" } },
	--install = { colorscheme = { "tokyonight-moon" } },

	-- automatically check for plugin updates
	checker = { enabled = true, },
})
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end
})

--------------------------------------------------------------------------------

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

-- fortran lsp
require("lspconfig").fortls.setup {
	cmd = {
		'fortls',
		'--lowercase_intrinsics',
		'--hover_signature',
		'--hover_language=fortran',
		'--use_signature_help'
	}
}

-- fortran linting
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end
})
