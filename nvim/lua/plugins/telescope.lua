-- Place this in your Neovim configuration file (init.lua or similar)

-- Telescope and FZF configuration
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
                -- Alternative build options if cmake doesn't work for you:
                -- build = "make", -- for Unix systems
                -- or
                -- build = "cd build && gcc -O3 -Wall -Werror -fpic -std=gnu99 -shared ../src/fzf.c -o libfzf.so",
            },
        },
        config = function()
            -- Load telescope
            local telescope = require("telescope")

            -- Configure telescope before loading extensions
            telescope.setup({
                defaults = {
                    prompt_prefix = "➤ ",
                    selection_caret = "→ ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    sorting_strategy = "descending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = { mirror = false, preview_width = 0.5 },
                        vertical = { mirror = false },
                        width = 0.8,
                        height = 0.9,
                        prompt_position = "bottom",
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = {},
                    path_display = { "truncate" },
                    winblend = 0,
                    border = true,
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },
                },
                pickers = {
                    buffers = {
                        preview = { "false" },
                        sorting_strategy = "ascending",
                        layout_strategy = "horizontal",
                        layout_config = {
                            horizontal = { mirror = false, preview_width = 0 },
                            vertical = { mirror = false },
                            width = 0.5,
                            height = 0.4,
                            prompt_position = "top",
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = require("telescope.themes").get_dropdown({}),
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            -- Load extensions AFTER setup
            telescope.load_extension("ui-select")

            -- Safely load fzf extension with detailed error handling
            local status_ok, _ = pcall(function()
                telescope.load_extension("fzf")
            end)

            if not status_ok then
                vim.notify("Failed to load telescope-fzf-native extension. Make sure it's properly built.",
                    vim.log.levels.WARN)
                -- You could add debug info here
                -- vim.notify("Checking if the extension is available...", vim.log.levels.INFO)
                -- local extension_path = vim.fn.stdpath("data") .. "/lazy/telescope-fzf-native.nvim/build/libfzf.so"
                -- vim.notify("Extension path: " .. extension_path .. " exists: " .. tostring(vim.fn.filereadable(extension_path)), vim.log.levels.INFO)
            end
        end,
        -- Define keymaps
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Help Tags" },
        },
    }
}
