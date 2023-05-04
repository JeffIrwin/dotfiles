
--print("hello from after/ftplugin/fortran.lua")

-- For more advanced free-form vs fixed-form detection, see:
--
--     /mnt/c/Program Files (x86)/Vim/vim80/ftplugin/fortran.vim
--
-- However, this fast simple method should work for me

local ext = vim.fn.expand("%:e")
if ext == "f90" or ext == "F90" then
	--print("extension is  f90/F90")

	--vim.o.tabstop    = 4
	--vim.o.shiftwidth = 4
	--vim.o.textwidth = 80

	-- omfg it was impossible to figure out that i needed to put this here
	vim.o.expandtab = false

	-- TODO: is it possible to put these in a global after/init.lua file?  I like
	-- these as sane defaults for all filetypes, not just Fortran
	vim.o.textwidth = 80

else
	--print("extension not f90")
	--
	-- Keep defaults, e.g. textwidth = 72
end

