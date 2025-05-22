return {
	--for auto closing tags
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	--fzf lua for searching files and stuffss
	{

		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	--golf game (not really)
	{
		"vuciv/golf",
	},
	--color highlighter for css colors and shit
	--dressing.nvim for menu style type shi
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded",
				},
				hint_enable = false, -- if you only want the popup and not inline hints
			})
		end,
	},

	{
		"ellisonleao/glow.nvim",

		cmd = "Glow",

		config = function()
			require("glow").setup({

				install_path = "~/.local/bin", -- default path for installing glow binary
				border = "shadow", -- floating window border config
				style = "dark", -- filled automatically with your current editor background, you can override using glow json style
				pager = false,
				width = 80,
				height = 100,
				width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
				height_ratio = 0.7,
			})
		end,
	},

	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				---Render style
				---@usage 'background'|'foreground'|'virtual'
				render = "background",

				---Set virtual symbol (requires render to be set to 'virtual')
				virtual_symbol = "■",

				---Set virtual symbol suffix (defaults to '')
				virtual_symbol_prefix = "",

				---Set virtual symbol suffix (defaults to ' ')
				virtual_symbol_suffix = " ",

				---Set virtual symbol position()
				---@usage 'inline'|'eol'|'eow'
				---inline mimics VS Code style
				---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
				---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
				virtual_symbol_position = "inline",

				---Highlight hex colors, e.g. '#FFFFFF'
				enable_hex = true,

				---Highlight short hex colors e.g. '#fff'
				enable_short_hex = true,

				---Highlight rgb colors, e.g. 'rgb(0 0 0)'
				enable_rgb = true,

				---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
				enable_hsl = true,

				---Highlight ansi colors, e.g '\033[0;34m'
				enable_ansi = true,

				-- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
				enable_hsl_without_function = true,

				---Highlight CSS variables, e.g. 'var(--testing-color)'
				enable_var_usage = true,

				---Highlight named colors, e.g. 'green'
				enable_named_colors = true,

				---Highlight tailwind colors, e.g. 'bg-blue-500'
				enable_tailwind = true,

				---Set custom colors
				---Label must be properly escaped with '%' to adhere to `string.gmatch`
				--- :help string.gmatch
				custom_colors = {
					{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
					{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
				},

				-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
				exclude_filetypes = {},
				exclude_buftypes = {},
				-- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
				exclude_buffer = function(bufnr) end,
			})
		end,
	},
}
