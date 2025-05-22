vim.g.mapleader = " "
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.sidescroll = 5
vim.opt.sidescrolloff = 5
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autoread = true
vim.bo.autoread = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.fillchars = { eob = " " }
vim.opt.foldlevel = 99
-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.cmd([[

se tabstop=4
se shiftwidth=4
se expandtab
se smartindent
se autoindent
se nu
se relativenumber
tnoremap <Esc> <C-\><C-n>
]])
