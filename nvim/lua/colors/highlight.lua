vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.schedule(function()
			local path = vim.fn.expand("%:.")
			local icon = ""
			local msg = string.format(" %s  file written: ./%s", icon, path)
			vim.api.nvim_echo({ { msg, "Directory" } }, false, {})
		end)
	end,
})
--highlight when yanking

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 180 })
	end,
})

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#FF4500" })

vim.opt.shortmess:append("c")
vim.opt.shortmess:append("I")
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local last_pos = vim.fn.line([['"]])
		if last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

vim.cmd([[
  highlight TelescopePromptPrefix guifg=#938373

  highlight TelescopeSelectionCaret guifg=#D6A02E
]])

-- Gruvbox Hard palette colors
local gruvbox = {
	bg = "#1d2021", -- Dark background
	fg = "#ebdbb2", -- Light foreground
	accent = "#fabd2f", -- Yellow accent
	selection = "#3c3836", -- Dark selection
	border = "#665c54", -- Gray/brown border
	detail = "#928374", -- Subtle details
	source = "#83a598", -- Blue-ish tone for source text
	ghost = "#3c3836", -- Ghost text similar to selection
}

-- Override blink.cmp highlight groups
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = gruvbox.bg, fg = gruvbox.fg })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = gruvbox.bg, fg = gruvbox.border })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = gruvbox.selection, fg = gruvbox.accent, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = gruvbox.accent })
vim.api.nvim_set_hl(0, "BlinkCmpScrollBarGutter", { bg = gruvbox.bg })
vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = gruvbox.fg })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { fg = gruvbox.detail, strikethrough = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = gruvbox.accent, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = gruvbox.detail })
vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = gruvbox.source })
vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = gruvbox.detail })
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = gruvbox.ghost })

-- Optionally, for documentation and signature help windows:
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = gruvbox.bg, fg = gruvbox.fg })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = gruvbox.border })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = gruvbox.bg, fg = gruvbox.fg })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = gruvbox.border })
-- customize the ghost text
vim.cmd([[
  highlight BlinkCmpGhostText guifg= #f5e0dc
  ]])
-- for  idk what
vim.cmd([[
  autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
]])

--cursor line
vim.o.cursorline = true
--   vim.cmd("highlight CursorLine guibg=#1a1a1a")
vim.api.nvim_create_autocmd("CompleteChanged", {
	callback = function()
		local cmp = require("cmp")
		if cmp.visible() and cmp.get_selected_entry() == nil then
			cmp.select_next_item()
		end
	end,
})
require("flash").toggle()
