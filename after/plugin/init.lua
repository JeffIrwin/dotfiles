
-- Some settings have to be applied afterwards, otherwise they are overridden by
-- defaults

--print("hello from after")
--
--print("vim.b.fortran_fixed_source = ", vim.b.fortran_fixed_source)
--print("vim.b.fortran_free_source = ", vim.b.fortran_free_source)
--print("vim.b = ", vim.b)
--print("")
----print("vim.o.fortran_fixed_source = ", vim.o.fortran_fixed_source)
----print("vim.o.fortran_free_source = ", vim.o.fortran_free_source)
----print("vim.o.fortran_have_tabs = ", vim.o.fortran_have_tabs)
--
--print("expand... = ", vim.fn.expand("%:e"))

--local ext = vim.fn.expand("%:e")
--if ext == "f90" or ext == "F90" then
--	--print("extension is  f90/F90")

vim.o.tabstop    = 4
vim.o.shiftwidth = 4
vim.o.textwidth = 80

--else
--	--print("extension not f90")
--end

---- nvim thinks tabs are illegal in Fortran.  They're not
--vim.cmd("hi link fortranTab NONE")
--vim.o.fortran_have_tabs=1

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
--vim.cmd('match WhiteSpaceBol /^ \\+/')

--vim.cmd.autocmd("FileType netrw nmap <buffer> <C-j> <C-w><C-j>")

---- To work in multiple splits within a window, it has to be an autocmd

--vim.api.nvim_create_augroup("custom_highlighting", {
	vim.cmd.autocmd("VimEnter,WinEnter * match WhiteSpaceBol /^ \\+/")
--})

-- Enable transparent backgrounds (as long as the terminal does too) on Ubuntu
vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")

