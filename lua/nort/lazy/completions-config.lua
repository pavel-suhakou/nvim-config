-- See :h (:vert h) cmp.txt
-- cmp-config cmp-config.view.docs
return {
    {
        -- shows autocompletion options UI
        "hrsh7th/nvim-cmp",
        config = function()
            -- Set up nvim-cmp.
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local str = require("cmp.utils.str")
            local types = require("cmp.types")

            local completion_window = cmp.config.window.bordered()
            -- zindex
            completion_window.col_offset = 30
            completion_window.max_width = 25
            completion_window.max_height = 15
            local documentation_window = cmp.config.window.bordered()
            documentation_window.max_width = 45
            documentation_window.max_height = 40

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = completion_window,
                    documentation = documentation_window,
                },
                view = {
                    docs = {
                        -- auto_open = false
                    }
                },
                completion = {
                    -- completeopt = "menu,menuone,preview", --remove comment to pre-select first item
                    -- autocomplete = false
                    -- keyword_length = 2
                },
                formatting = {
                    fields = {
                        cmp.ItemField.Kind,
                        cmp.ItemField.Abbr,
                        cmp.ItemField.Menu,
                    },
                    format = lspkind.cmp_format({
                        mode = "symbol",          -- show only symbol annotations
                        maxwidth = 25,            -- max character number for completions (can also be a function)
                        ellipsis_char = "...",    -- append when popup menu exceed maxwidth
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(entry, vim_item)
                            -- Get the full snippet (and only keep first line)
                            local word = entry:get_insert_text()
                            if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                                word = str.get_word(word)
                            end

                            word = str.oneline(word)

                            if
                                entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
                                and string.sub(vim_item.abbr, -1, -1) == "~"
                            then
                                word = word .. "~"
                            end
                            vim_item.abbr = word

                            return vim_item
                        end,
                    }),
                },
                experimental = {
                    ghost_text = false,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                                ""
                            )
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
                                ""
                            )
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<C-g>'] = function()
                        if cmp.visible_docs() then
                            cmp.close_docs()
                        else
                            cmp.open_docs()
                        end
                    end,
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip", group_index = 1 },
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "async_path", group_index = 3 },
                    { name = "buffer", group_index = 4 },
                }),
            })

            -- cmp.setup.filetype({ 'markdown', 'help' }, {
            --     window = {
            --         documentation = cmp.config.disable
            --     }
            -- })

            -- `/` cmdline setup.
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git",        group_index = 1 },
                    { name = "async_path", group_index = 2 },
                }),
            })

            cmp.setup.filetype("lua", {
                sources = {
                    { name = "luasnip",    group_index = 1 },
                    { name = "nvim_lsp",   group_index = 2 },
                    { name = "async_path", group_index = 3 },
                },
            })

            cmp.setup.filetype("zig", {
                sources = {
                    { name = "luasnip",    group_index = 1 },
                    { name = "nvim_lsp",   group_index = 2 },
                    { name = "async_path", group_index = 3 },
                },
            })

            cmp.setup.filetype("tex", {
                sources = {
                    { name = "luasnip",    group_index = 1 },
                    { name = "vimtex",     group_index = 2 },
                    { name = "nvim_lsp",   group_index = 3 },
                    { name = "async_path", group_index = 4 },
                    -- { name = "buffer" },
                },
            })

            cmp.setup.filetype("cs", {
                sources = {
                    { name = "luasnip",    group_index = 1 },
                    { name = "omnisharp",  group_index = 2 },
                    -- { name = "nvim_lsp" },
                    { name = "async_path", group_index = 3 },
                },
            })
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "onsails/lspkind.nvim",

            "hrsh7th/cmp-nvim-lsp",
            { "hrsh7th/cmp-nvim-lua", ft = "lua" },
            { "micangl/cmp-vimtex",   ft = "tex" },
            "https://codeberg.org/FelipeLema/cmp-async-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "tamago324/cmp-zsh",
            "petertriho/cmp-git",
            {
                -- provides snippets to nvim-cmp to render UI
                "L3MON4D3/LuaSnip",
                config = function()
                    vim.api.nvim_create_autocmd("InsertLeave", {
                        callback = function()
                            if
                                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                                and not require("luasnip").session.jump_active
                            then
                                require("luasnip").unlink_current()
                            end
                        end,
                    })
                end,
                dependencies = {
                    {
                        -- inserts snippet into text
                        "saadparwaiz1/cmp_luasnip",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load({
                                exclude = vim.g.vscode_snippets_exclude or {},
                                paths = vim.g.vscode_snippets_path or "",
                            })
                        end,
                        dependencies = {
                            "rafamadriz/friendly-snippets",
                        },
                    },
                },
            },
        },
    },
}
