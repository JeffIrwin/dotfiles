
-- TODO: this isn't included anywhere because it wasn't working anyway.  All
-- this stuff is done from top-level init.lua

return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").lua_ls.setup {}
		end,
	}
}

----require("lspconfig").lua_ls.setup {}
----
--pint("hello")
