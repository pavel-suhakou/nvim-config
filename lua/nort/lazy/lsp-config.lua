Workspace = vim.loop.cwd()

return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
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
        event = "VeryLazy",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "tsserver", "omnisharp" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
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

            local on_omnisharp_attach = function(_, bufnr)
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

                Omnisharp_lsp_keymaps(bufnr)
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

            -- https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options

            -- local git_dir
            -- for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
            --     if vim.fn.isdirectory(dir .. "/.git") == 1 then
            --         git_dir = dir
            --         break
            --     end
            -- end
            -- if git_dir then
            --     print("Found git repository at ", git_dir)
            -- end
            -- local current_dir = git_dir or vim.fn.getcwd()

            lspoptions = {
                filetypes = { "cs", "vb", "sln" },
                -- root_dir = function(fname)
                --     return current_dir
                -- end,
                on_attach = on_omnisharp_attach,
                capabilities = capabilities,
                settings = {
                    RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = false,
                        EnableImportCompletion = true,
                    },
                    FormattingOptions = {
                        -- Enables support for reading code style, naming convention and analyzer
                        -- settings from .editorconfig.
                        EnableEditorConfigSupport = true,
                        -- Specifies whether 'using' directives should be grouped and sorted during
                        -- document formatting.
                        -- OrganizeImports = nil,
                    },
                },
            }

            local is_mono_sln = os.getenv("is_mono_sln")
            if (is_mono_sln ~= nil and is_mono_sln ~= "") then
                lspoptions.cmd = { "omnisharp-mono" }
            else
                local omnisharp_bin = "";
                if (vim.loop.os_uname().sysname == "Windows_NT") then
                    omnisharp_bin =
                    "C:\\Users\\Admin\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll";
                end

                lspoptions.cmd = { "dotnet", omnisharp_bin } -- .. " -s " .. Workspace }, -- "omnisharp-mono"
            end

            local csharp_sln = os.getenv("csharp_sln")
            if (csharp_sln ~= nil and csharp_sln ~= "") then
                lspoptions.init_options = {
                    "-s " .. csharp_sln
                }

                lspoptions.MsBuild = {
                    csharp_sln,
                    -- TargetFrameworkRootPath = "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319",
                    -- ToolsVersion = "12.0",
                    -- MSBuildSDKsPath = "",
                }
            end

            -- lspconfig["omnisharp"].setup(lspoptions)
        end,
        dependencies = {
            "ray-x/lsp_signature.nvim",
            "Hoffs/omnisharp-extended-lsp.nvim"
        }
    },
    {
        "dgagn/diagflow.nvim",
        event = "LspAttach",
        config = function()
            require("diagflow").setup()
        end
    },
}
