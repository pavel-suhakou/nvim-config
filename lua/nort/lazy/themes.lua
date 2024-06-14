return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        config = function()
            require("tokyonight").setup({
                --`storm`, `moon`, a darker variant `night` and `day`
                style = "storm",
                transparent = true,
                terminal_colors = true, -- for `:terminal` in Neovim
                styles = {
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        config = function()
            require("rose-pine").setup({
                variant = "moon",
                dark_variant = "moon",
                disable_background = true,
                styles = {
                    italic = false,
                    bold = true,
                    transparency = false,
                },
            })

            -- vim.cmd("colorscheme rose-pine-moon")
        end,
    },
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                styles = {
                    italic = false,
                    bold = true,
                    conditionals = {},
                    comments = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    miscs = {},
                }
            })

            -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
            vim.cmd.colorscheme "catppuccin-mocha"
        end
    }
}
