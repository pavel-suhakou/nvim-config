vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor after certain actions
vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", ",<C-d>zz")
-- vim.keymap.set("n", "<C-u>", ",<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste and replace selection
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Replace selected" })

-- yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy to system clipboard" })

-- vim.keymap.set("n", "Q", "<nop>")

-- navigate quickfix and location list
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Jump up in quickfix list" })
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Jump down in quickfix list" })
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Jump up in loc list" })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Jump down in loc list" })

-- lazygit
vim.keymap.set("n", "<leader>gg", function()
    Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (root dir)" })
vim.keymap.set("n", "<leader>gG", function()
    Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })
