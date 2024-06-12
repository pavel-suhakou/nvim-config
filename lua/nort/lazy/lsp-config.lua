return {
    {
        "williamboman/mason.nvim",
        ui = {
            icons = {
                package_pending = " ",
                package_installed = "󰄳 ",
                package_uninstalled = " 󰚌",
            },
        },
        config = function()
            require("mason").setup({})
        end,
        dependencies = {
            "tpope/vim-dispatch", -- both are for omnisharp
            "Shougo/vimproc.vim",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "tsserver", "omnisharp" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.emmet_language_server.setup({})

            local on_attach = function(_, bufnr)
                require("lsp_signature").on_attach({
                    max_height = 12,
                    max_width = 60, -- max_width of signature floating_window, line will be wrapped
                    -- the value need >= 40
                    -- floating_window_above_cur_line = false,
                    -- hint_enable = false,
                    -- zindex = 0,
                    -- transparency = 90,
                    -- toggle_key = "<C-h>"
                }, bufnr)

                Lsp_keymaps(bufnr)
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspoptions = { on_attach = on_attach, capabilities = capabilities }

            lspconfig["tsserver"].setup(lspoptions)

            -- zig tools - zig language server
            -- see options https://github.com/zigtools/zls
            lspconfig["zls"].setup(lspoptions)

            local on_init = function(client, _)
                if client.supports_method("textDocument/semanticTokens") then
                    client.server_capabilities.semanticTokensProvider = nil
                end
            end
            lspoptions = {
                cmd = { "lua-language-server", "--stdio" },
                on_init = on_init,
                on_attach = on_attach,
                capabilities = capabilities,

                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                            disable = { 'missing-fields' }
                        },
                        telemetry = { enable = false },
                        workspace = {
                            library = {
                                vim.fn.expand("$VIMRUNTIME/lua"),
                                vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                                vim.fn.stdpath("data") .. "/lazy",
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                        },
                    },
                },
            }
            lspconfig["lua_ls"].setup(lspoptions)

            lspoptions = {
                cmd = { "omnisharp" }, -- "omnisharp-mono"
                on_attach = on_attach,
                capabilities = capabilities,
                enable_import_completion = true,
                organize_imports_on_format = true,
                enable_roslyn_analyzers = true,
                settings = {
                    RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = false,
                        -- AnalyzeOpenDocumentsOnly = nil,
                        EnableImportCompletion = true,
                    },
                },
            }
            lspconfig["omnisharp"].setup(lspoptions)
        end,
        dependencies = {
            "ray-x/lsp_signature.nvim",
        }
    },
}
