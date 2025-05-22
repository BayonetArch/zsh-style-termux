return {
	"vague2k/vague.nvim",
	config = function()
		require("vague").setup({ transparent = true })
		vim.cmd("colorscheme vague")
		vim.cmd(":hi statusline guibg=NONE")
		vim.opt.conceallevel = 0
		vim.opt.concealcursor = ""
	end,
}
