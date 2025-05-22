local state = {
    floating = {
        buf = -1,
        win = -1
    },
}

local M = {}

M.floating_window = function(opts)
    opts = opts or {}
    local width = math.floor(vim.o.columns * 0.7)
    local height = math.floor(vim.o.lines * 0.7)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })
    return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("FloatingWin", function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = M.floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end, {})
vim.keymap.set({ "n", "t" }, "<A-t>", "<cmd>FloatingWin<CR>i")
return M
