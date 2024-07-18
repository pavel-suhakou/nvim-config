Keys = vim.keymap
function Get_opts(desc)
    local opts = { noremap = true, silent = true }
    opts.desc = desc
    return opts
end

Keys.set("n", "<leader>pv", vim.cmd.Ex)

Keys.set("n", "J", "mzJ`z", { desc = "Join strings and center cursor" })

Keys.set("x", "<leader>p", '"_dP', { desc = "Paste into selection and keep register" })

Keys.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
Keys.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
Keys.set("n", "<leader>Y", '"+Y', { desc = "Copy to system clipboard" })

Keys.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

--------------------------------------------------
--- telescope plugin keymaps

local builtin = require('telescope.builtin')

-- file navigation keymaps
Keys.set('n', '<leader>fj', builtin.find_files,
    { desc = "Lists files in your current working directory, respects .gitignore (telescope)" })
-- same as find_files ?
Keys.set('n', '<leader>jf', builtin.git_files,
    { desc = "Fuzzy search through the output of git ls-files command, respects .gitignore" })
Keys.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers (telescope)" })

-- git keymaps
Keys.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits (telescope)" })
Keys.set('n', '<leader>gh', builtin.git_bcommits, { desc = "Git buffer commits (telescope)" })
Keys.set('v', '<leader>gr', builtin.git_bcommits_range,
    { desc = "Git buffer commits in a range of lines (visual mode) (telescope)" })
Keys.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches (telescope)" })
Keys.set('n', '<leader>gs', builtin.git_status, { desc = "Git status (telescope)" })
Keys.set('n', '<leader>gt', builtin.git_stash, { desc = "Git stashes (telescope)" })

-- grep keymaps
Keys.set('n', '<leader>fw', function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
    end,
    { desc = "Searches for <cword> the string under cursor or selection (telescope)" })
Keys.set('n', '<leader>fW', function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
    end,
    { desc = "Searches for <cWORD> the string under cursor or selection(telescope)" })
Keys.set("n", "<leader>fz", ":Telescope live_grep<CR>", { desc = "Live grep (telescope)" })
Keys.set('n', '<leader>fs', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end,
    { desc = "Searches for the string under cursor or selection (telescope)" })

-- helper keymaps
Keys.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help tags (telescope)" })
Keys.set('n', '<leader>fk', builtin.keymaps, { desc = "Search keymaps (telescope)" })

--- nvim-lspconfig plugin callback
function Lsp_keymaps(bufnr)
    local function opts(desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true }
    end

    Keys.set("n", "gD", vim.lsp.buf.declaration, opts("Gt decl"))
    Keys.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts("LSP references (telescope)"))
    Keys.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts("LSP definitions (telescope)"))
    Keys.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts("Go to implementation (telescope)"))
    Keys.set("n", "<leader>td", "<cmd>Telescope lsp_type_definitions<CR>", opts("Go to type definitions (telescope)"))

    Keys.set("n", "<leader>sd", builtin.lsp_document_symbols, opts("Document symbols"))
    Keys.set("n", "<leader>sw", builtin.lsp_dynamic_workspace_symbols, opts("Workspace symbols"))

    Keys.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
    Keys.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Sig help"))
    Keys.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))

    Keys.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts("Show code actions"))
    Keys.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename (LSP)"))

    -- Keys.set("n", "<leader>ee", vim.diagnostic.open_float, opts("See diags"))
    Keys.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", opts("Show diagnostics (telescope)"))
    Keys.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", opts("Show diagnostics (telescope)"))
    -- Keys.set("n", "<leader>d", vim.diagnostic.open_float, opts("Show line diagnostics"))
    Keys.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
    Keys.set("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
    Keys.set("n", "<leader>q", vim.diagnostic.setloclist, opts("Diags->loc list"))

    Keys.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Workspace add"))
    Keys.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Workspace remove"))
    Keys.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("Workspace dirs"))

    --- also see keymaps in completions.lua
end

function Omnisharp_lsp_keymaps(bufnr)
    local function opts(desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true }
    end

    Keys.set("n", "gD", vim.lsp.buf.declaration, opts("Gt decl"))
    Keys.set("n", "gr", "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<CR>",
        opts("LSP references (telescope)"))
    Keys.set("n", "gd", "<cmd>lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = \"vsplit\" })<CR>",
        opts("LSP definitions (telescope)"))
    Keys.set("n", "gi", "<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<cr>",
        opts("Go to implementation (telescope)"))
    Keys.set("n", "<leader>td", "<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>",
        opts("Go to type definitions (telescope)"))


    Keys.set("n", "<leader>sd", builtin.lsp_document_symbols, opts("Document symbols"))
    Keys.set("n", "<leader>sw", builtin.lsp_dynamic_workspace_symbols, opts("Workspace symbols"))

    Keys.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
    Keys.set({ "n", "i" }, "<C-k>", function()
        require('lsp_signature').toggle_float_win()
    end, opts("Sig help"))
    Keys.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))

    Keys.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts("Show code actions"))
    Keys.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename (LSP)"))

    -- Keys.set("n", "<leader>ee", vim.diagnostic.open_float, opts("See diags"))
    Keys.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts("Show diagnostics (telescope)"))
    Keys.set("n", "<leader>d", vim.diagnostic.open_float, opts("Show line diagnostics"))
    Keys.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
    Keys.set("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
    Keys.set("n", "<leader>q", vim.diagnostic.setloclist, opts("Diags->loc list"))

    Keys.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Workspace add"))
    Keys.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Workspace remove"))
    Keys.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("Workspace dirs"))

    --- also see keymaps in completions.lua
end

-- defined in conform.lua
-- vim.keymap.set({ "n", "v" }, "<leader>f;", formatandsave,
--     { desc = "Format file or range (in visual mode) and save" })

-- Oil
Keys.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
--- nvim-tree (file tree on the left) keymaps
-- local ntree_api = require("nvim-tree.api")
-- local function opts(desc)
--     return {
--         desc = "nvim-tree: " .. desc,
--         -- buffer = bufnr,
--         noremap = true,
--         silent = true,
--         nowait = true,
--     }
-- end
-- Keys.set("n", "<leader>eh", ntree_api.tree.toggle_help, opts("help"))
-- Keys.set("n", "<leader>eo", ntree_api.tree.open, opts("open"))
-- Keys.set("n", "<leader>ek", ntree_api.tree.close, opts("kill"))

Keys.set({ "n", "v" }, '<leader>m', require('nvim-emmet').wrap_with_abbreviation,
    { desc = "Expand html with Emmet" })

-- Close quickfix window with q
-- see https://www.reddit.com/r/neovim/comments/1datzv6/comment/l7msz9k/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "checkhealth",
        "fugitive*",
        "git",
        "help",
        "lspinfo",
        "netrw",
        "notify",
        "qf",
        "query",
    },
    callback = function()
        vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close the current buffer", buffer = true })
    end,
})

-- Obsidian
-- Jump between markdown headers
-- vim.keymap.set("n", "gj", [[/^##\+ .*<CR>]], { buffer = true, silent = true })
-- vim.keymap.set("n", "gk", [[?^##\+ .*<CR>]], { buffer = true, silent = true })
-- vim.keymap.set("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
--     { desc = "Obsidian Check Checkbox" })
-- vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
-- vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
-- vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
-- vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
-- vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
-- vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
-- vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

function Git_signs_onattach(bufnr)
    local gs = require('gitsigns')

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "stage hunk" })
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "reset (undo) hunk" })
    map('n', '<leader>hS', gs.stage_buffer, { desc = "stage buffer" })
    map('n', '<leader>ha', gs.stage_hunk, { desc = "stage hunk" })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "undo stage hunk" })
    map('n', '<leader>hR', gs.reset_buffer, { desc = "git reset buffer (revert changes)" })
    map('n', '<leader>hp', gs.preview_hunk, { desc = "preview hunk" })
    map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "blame line" })
    map('n', '<leader>tB', gs.toggle_current_line_blame, { desc = "toggle current line blame" })
    map('n', '<leader>hd', gs.diffthis, { desc = "diff" })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "hunk diff" })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "select hunk" })
end
