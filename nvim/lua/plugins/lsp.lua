return {

	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "folke/lazydev.nvim" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("neodev").setup({})
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
			})

			local function on_attach(client, bufnr)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"K",
					"<cmd>lua vim.lsp.buf.hover()<CR>",
					{ noremap = true, silent = true }
				)

				local ft = vim.bo.filetype
				if ft ~= "python" and ft ~= "javascript" and ft ~= "html" and ft ~= "css" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = "*",
						callback = function(args)
							require("conform").format({ bufnr = args.buf })
						end,
					})
				end
			end

			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})
			require("lspconfig").emmet_ls.setup({
				filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
						},
					},
				},
			})

			require("lspconfig").cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			require("lspconfig").clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			require("lspconfig").ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("lspconfig").bashls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					bashIde = {
						globPattern = "**/*.{sh,bash}",
						backgroundAnalysisMaxFiles = 500,
						enableShellcheck = true,
					},
				},
				filetypes = { "sh", "bash" },
				root_dir = function(fname)
					return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
				end,
				cmd = { "bash-language-server", "start" },
			})

			require("lspconfig").html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = require("lspconfig").util.root_pattern(".git", "package.json", "index.html", "."),
				filetypes = { "html", "htm", "xhtml", "shtml", "jsp", "hbs", "handlebars" },
				settings = {
					html = {
						validate = {
							scripts = true,
							styles = true,
						},
						hover = {
							documentation = true,
							references = true,
						},
						format = {
							enable = true,
							wrapLineLength = 120,
							unformatted = "wbr",
							contentUnformatted = "pre,code,textarea",
							indentInnerHtml = true,
						},
						suggest = {
							html5 = true,
						},
						Angular = {
							suggest = false,
						},
						embeddedLanguages = {
							css = true,
							javascript = true,
						},
						autoClosingTags = true,
						trace = {
							server = "verbose",
						},
					},
				},
			})
		end,
	},
}
