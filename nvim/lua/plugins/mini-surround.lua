return {
	"echasnovski/mini.surround",
	version = "*",
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "gsa", -- add surround
				delete = "gsd", -- delete surround
				find = "gsf", -- find right
				find_left = "gsF", -- find left
				highlight = "gsh", -- highlight
				replace = "gsr", -- replace surround
				update_n_lines = "gsn",
			},
		})
	end,
}
