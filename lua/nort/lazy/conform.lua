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
                -- svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                -- python = { "isort", "black" },
            },
        })

        local formatandsave = function(args)
            if (args == nil or args.buf == nil) then return end;
            local bufname = vim.api.nvim_buf_get_name(args.buf)
            -- print(bufname)
            if bufname ~= "" and bufname:find("^[CDcd]:[\\/].+") ~= nil then
                local status, err = pcall(conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                    bufnr = args.buf
                }))
                -- if (not status) then print(err.code) end
                --vim.api.nvim_command('write')
            end
        end

        vim.api.nvim_create_autocmd("InsertLeave", {
            pattern = "*",
            callback = formatandsave,
            desc = "Run formatter and save",

        })

        vim.keymap.set({ "n", "v" }, "<leader>f;", formatandsave,
            { desc = "Format file or range (in visual mode) and save" })
    end,
}
