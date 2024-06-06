return {
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        config = function()
            require('telescope').setup({})

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fj', builtin.find_files, 
                { desc = "Lists files in your current working directory, respects .gitignore" })
            vim.keymap.set('n', '<leader>gf', builtin.git_files,
                { desc = "Fuzzy search through the output of git ls-files command, respects .gitignore" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
            vim.keymap.set('n', '<leader>fw', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end,
                { desc = "Searches for <cword> the string under your cursor or selection in your current working directory" })
            vim.keymap.set('n', '<leader>fW', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end,
                { desc = "Searches for <cWORD> the string under your cursor or selection in your current working directory" })
            vim.keymap.set('n', '<leader>fs', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end,
                { desc = "Searches for the string under your cursor or selection in your current working directory" })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help tags" })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Search keymaps" })

        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    }
                }
            }
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    }
}
