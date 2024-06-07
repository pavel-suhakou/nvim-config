return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            git = {
                enable = true,
                ignore = true,
            },
            filesystem_watchers = {
                enable = true,
            },
            sort = {
                sorter = "modification_time", -- name
            },
            view = {
                adaptive_size = false,
                side = "left",
                width = 30,
                preserve_window_proportions = true,
            },
            actions = {
                open_file = {
                    resize_window = true,
                },
            },
            renderer = {
                group_empty = true,
            },
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                -- default keymaps
                api.config.mappings.default_on_attach(bufnr)
            end,
            -- icons = {
            -- 	show = {
            -- 		file = true,
            -- 		folder = true,
            -- 		folder_arrow = true,
            -- 		git = true,
            -- 	},
            --
            -- 	glyphs = {
            -- 		default = "󰈚",
            -- 		symlink = "",
            -- 		folder = {
            -- 			default = "",
            -- 			empty = "",
            -- 			empty_open = "",
            -- 			open = "",
            -- 			symlink = "",
            -- 			symlink_open = "",
            -- 			arrow_open = "",
            -- 			arrow_closed = "",
            -- 		},
            -- 		git = {
            -- 			unstaged = "✗",
            -- 			staged = "✓",
            -- 			unmerged = "",
            -- 			renamed = "➜",
            -- 			untracked = "★",
            -- 			deleted = "",
            -- 			ignored = "◌",
            -- 		},
            -- 	},
            -- },
        })
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}
