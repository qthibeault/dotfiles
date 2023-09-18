-- Normal mode maps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic" })
vim.keymap.set("n", "L", ":bnext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "H", ":bprev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, noremap = true })

-- Visual mode maps
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })
vim.keymap.set("v", "J", ":move .+1<CR>==gv", { silent = true, noremap = true })
vim.keymap.set("v", "K", ":move .-2<CR>==gv", { silent = true, noremap = true })

-- Terminal buffer maps
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
