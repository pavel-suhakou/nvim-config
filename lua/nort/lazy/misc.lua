return {
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    {
        "RRethy/vim-illuminate",
        event = "BufEnter",
        config = function()
            -- change the highlight style to be lighter
            local set_hl_style = function()
                vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
                vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
                vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine" })
            end
            set_hl_style()

            --- auto update the it on colorscheme change
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
                pattern = { "*" },
                callback = set_hl_style
            })

            require("illuminate").configure({
                delay = 500,
            })
        end
    },
    {
        -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file, or, in the case the current file is new, blank, or otherwise insufficient, by looking at other files of the same type in the current and parent directories. Modelines and EditorConfig are also consulted
        "tpope/vim-sleuth",
        event = "InsertEnter",
    }
}
