vim.opt.backup = false -- Do not make backup files
vim.opt.hidden = true -- Allow switching from unsaved buffers
vim.opt.undofile = true -- Create persistent undo history
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo" -- Store undo files in user cache
vim.opt.exrc = true -- Enable local config files
vim.opt.clipboard = "unnamedplus" -- Enable system clipboard

vim.opt.cursorline = true -- Highlight the line the cursor is currently on
vim.opt.number = true -- Show line numbers
vim.opt.wrap = false -- Do not wrap long lines
vim.opt.breakindent = true -- Indent wrapped lines further
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.scrolloff = 1 -- Keep one line below cursor while scrolling
vim.opt.sidescrolloff = 5 -- Keep 5 columns left/right of cursor while scrolling

vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Do not ignore case when capital is present
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.incsearch = true -- Show search matches while typing

vim.opt.updatetime = 250 -- Reduce time before CursorHover event is emitted
vim.opt.timeoutlen = 500 -- Decrease timeout duration for multi-key mappings

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Show tab characters as 4 spaces
vim.opt.shiftwidth = 4 -- Indent with 4 spaces
vim.opt.autoindent = true -- New lines inherit indentation of previous line
vim.opt.smartindent = true -- Improve auto-indent

vim.opt.splitright = true -- Always split to the right
vim.opt.splitbelow = true -- Always split below

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append("c")

vim.cmd([[colorscheme arctic]])
