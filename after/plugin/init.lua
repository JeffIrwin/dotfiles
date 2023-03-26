
-- Some settings have to be applied afterwards, otherwise they are overridden by
-- defaults

--print("hello from after")

-- nvim thinks tabs are illegal in Fortran.  They're not
vim.cmd("hi link fortranTab NONE")

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

