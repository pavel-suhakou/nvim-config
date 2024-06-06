return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                python = { "isort", "black" },
            },
        })

        local formatandsave = function(args)
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
                bufnr = args.buf
            })
            vim.api.nvim_command('write')
        end

        vim.api.nvim_create_autocmd("InsertLeave", {
            pattern = "*",
            callback = formatandsave
        })

        vim.keymap.set({ "n", "v" }, "<leader>f;", formatandsave, { desc = "Format file or range (in visual mode)" })
    end,
}
