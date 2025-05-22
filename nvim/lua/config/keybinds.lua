local keymap = vim.keymap.set
local builtin = require("telescope.builtin")
--lif  changing bindings
keymap({ "n", "x", "v", "t" }, "dd", '"_dd', { noremap = true })
keymap({ "n", "x", "v", "t" }, "d", '"_d', { noremap = true })
vim.keymap.set("n", "<leader>P", '"0p', { desc = "Paste last yank" })
keymap("n", "<C-q>", ":bd<CR>", { noremap = true, silent = true })
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })
keymap("n", "<C-J>", "<C-w>w", { noremap = true })
keymap("n", "<C-e>", ":qa!<CR>", { noremap = true })
-- Insert/Visual/Normal mode shared keymaps
keymap({ "i", "v", "x", "n" }, "<C-c>", "<Esc>:")
keymap({ "i", "v", "x", "n" }, "<C-n>", "<Esc>")
keymap({ "i", "v", "n" }, "<C-s>", "<Esc>:w<CR>")
--INDENTING IDK IM JUST TRYING .. local keymap = keymap
keymap("v", "<", "<gv", { noremap = true, silent = true })
--improved new line ...

keymap("n", "o", "m`o<Esc>``", { noremap = true })
keymap("n", "O", "m`O<Esc>``", { noremap = true })
--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })
--keymaps for telescope

keymap("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true })
keymap("n", "<leader>ff", builtin.oldfiles, { noremap = true, silent = true })

--use xclip for copying and pasting type shii...
keymap(
	"n",
	"tt",
	":w !xclip -selection clipboard<CR>",
	{ noremap = true, silent = true, desc = "Copy to clipboard (xclip)" }
)

keymap(
	"n",
	"tp",
	":r !xclip -selection clipboard -o<CR>",
	{ noremap = true, silent = true, desc = "Paste from clipboard (xclip)" }
)
--termux-clipboard-BINDINGS
keymap(
	{ "n", "v", "t" },
	"tc",
	":w !termux-clipboard-set<CR>",
	{ noremap = true, silent = true, desc = "Copy to Termux clipboard" }
)
keymap(
	{ "n", "v", "t" },
	"tv",
	":r !termux-clipboard-get<CR>",
	{ noremap = true, silent = true, desc = "Paste from Termux clipboard" }
)
---FZF LUA BINDINGS BABY
keymap("n", "<C-f>", ":FzfLua files cwd=~/ <CR>")
keymap("n", "<space>fc", ":FzfLua files cwd=./ <CR>")
--keymap for mini.fiiles
keymap("n", "<leader>mf", ":lua MiniFiles.open()<CR>", { noremap = true })
--see the buffer files
keymap("n", "<leader>bf", ":Telescope buffers<CR>")
keymap("n", "<leader>lr", ":luafile %<CR>")
--move between buffers
keymap("n", "<C-b>", ":bn<CR>", { noremap = true })
--keymap for format
keymap("n", "<leader>lf", function()
	require("conform").format({ bufnr = 0 })
end)

keymap("i", "<C-h>", function()
	vim.lsp.buf.signature_help()
end, { silent = true })
--harpoon keybinds
keymap("n", "<leader>mh", function()
	require("harpoon.mark").add_file()
end)
--toggle_quick_menu of harppoon
keymap("n", "<leader>ht", function()
	require("harpoon.ui").toggle_quick_menu()
end)

vim.keymap.set("n", "k", function()
	return vim.v.count > 0 and "k" or "gk"
end, { expr = true })

vim.keymap.set("n", "j", function()
	return vim.v.count > 0 and "j" or "gj"
end, { expr = true })
keymap("n", "<leader>gd", "<C-]>", { noremap = true })
keymap("n", "<leader>dg", "<C-t>", { noremap = true })
vim.keymap.set("n", "ciw", '"_ciw', { noremap = true })
vim.keymap.set("n", "caw", '"_caw', { noremap = true })
vim.keymap.set("n", "caw", '"_caw', { noremap = true })
-- nhellormal mode: remap gs to original `s`
vim.keymap.set("n", "os", "s", { noremap = true })
vim.keymap.set("n", "oS", "S", { noremap = true })
