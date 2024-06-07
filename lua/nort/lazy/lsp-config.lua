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
                    max_width = 40, -- max_width of signature floating_window, line will be wrapped
                    -- the value need >= 40
                }, bufnr)

                local function opts(desc)
                    return { desc = desc, buffer = bufnr, noremap = true, silent = true }
                end
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Gt decl"))
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Gt def"))
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Gt impl"))
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts("Gt type def"))
                vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Sig help"))

                vim.keymap.set({ "n", "v" }, "<space>.", vim.lsp.buf.code_action, opts("Show code actions"))
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts("Rename"))
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Refs"))

                vim.keymap.set("n", "<space>ee", vim.diagnostic.open_float, opts("See diags"))
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Prev diag"))
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Next diag"))
                vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts("Diags->loc list"))

                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts("Workspace add"))
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts("Workspace remove"))
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts("Workspace dirs"))
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
