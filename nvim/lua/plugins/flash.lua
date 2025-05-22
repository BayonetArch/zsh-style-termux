return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		-- Flash Jump (default)
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},

		-- Flash Treesitter (functions, loops, etc.)
		{
			"S",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},

		-- Flash Remote (jump across windows)
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},

		-- Flash Treesitter Search
		{
			"<leader>S",
			function()
				require("flash").treesitter_search()
			end,
			desc = "Flash Treesitter Search",
		},
	},
}
