return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local iceberg_dark = require("lualine.themes.iceberg_dark")
		iceberg_dark.command = {
			a = { fg = "#000000", bg = "#a6e3a1", gui = "bold" },
			b = { fg = "#ffffff", bg = "#3a3a3a" },
			c = { fg = "#ffffff", bg = "#2a2a2a" },
		}
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = iceberg_dark,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", path = 4, symbols = { modified = " ●" } } },

				lualine_c = {},
				lualine_x = {
					{
						function()
							return os.date("🕐 %H:%M")
						end,
						separator = { left = "", right = "" },
						padding = { left = 1, right = 1 },
					},
				},
				lualine_y = { "diagnostics" },

				lualine_z = { "filetype" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
