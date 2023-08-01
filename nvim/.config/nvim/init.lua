local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local lazyurl = "https://github.com/folke/lazy.nvim"

    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyurl,
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local plugins = {
    { "folke/lazy.nvim" },
    { "MunifTanjim/nui.nvim" },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    {
        "goolord/alpha-nvim",
        event = { "VimEnter" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                icons_enabled = false,
                theme = "auto",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
    {
        "rockyzhang24/arctic.nvim",
        branch = "v2",
        dependencies = { "rktjmp/lush.nvim" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre" },
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre" },
        opts = {
            char = "┊",
            show_trailing_blankline_indent = false,
        },
        main = "indent_blankline",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre" },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = { "lua", "vim", "vimdoc", "query" },
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = { "python" },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["aa"] = { query = "@parameter.outer", desc = "Select around paremeter" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inside parameter" },
                        ["af"] = { query = "@function.outer", desc = "Select around function" },
                        ["if"] = { query = "@function.inner", desc = "Select inside function" },
                        ["ac"] = { query = "@class.outer", desc = "Select around class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inside class" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = { query = "@parameter.inner", desc = "Swap parameter next" },
                    },
                    swap_previous = {
                        ["<leader>A"] = { query = "@parameter.inner", desc = "Swap parameter previous" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = { query = "@function.outer", desc = "Next function start" },
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_next_end = {
                        ["]M"] = { query = "@function.outer", desc = "Next function end" },
                        ["]["] = { query = "@class.outer", desc = "Next class end" },
                    },
                    goto_previous_start = {
                        ["[m"] = { query = "@function.outer", desc = "Previous function start" },
                        ["[["] = { query = "@class.outer", desc = "Previous class start" },
                    },
                    goto_previous_end = {
                        ["[M"] = { query = "@function.outer", desc = "Previous function end" },
                        ["[]"] = { query = "@class.outer", desc = "Previous class end" },
                    },
                },
            },
        },
    },
    {
        "kylechui/nvim-surround",
        event = { "VeryLazy" },
        version = "*",
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        opts = {},
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
        },
        config = function()
            local function feedkey(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            local function has_words_before()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")
            local cmp_opts = {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                }, {
                    { name = "buffer" },
                }),
            }

            cmp.setup(cmp_opts)
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason-lspconfig.nvim" },
            { "folke/neodev.nvim", opts = {} },
            { "simrat39/rust-tools.nvim" },
        },
        build = function()
            vim.cmd("MasonInstall stylua")
        end,
        config = function()
            require("mason").setup({})
            require("mason-lspconfig").setup({ ensure_installed = { "lua_ls" } })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local installed = require("mason-lspconfig").get_installed_servers()
            local lspconfig = require("lspconfig")
            local custom_handlers = {
                ["lua_ls"] = function()
                    lspconfig["lua_ls"].setup({
                        settings = {
                            Lua = {
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
                ["rust_analyzer"] = function()
                    require("rust-tools").setup({
                        tools = {
                            runnables = {
                                use_telescope = true,
                            },
                            inlay_hints = {
                                auto = true,
                                show_parameter_hints = false,
                                parameter_hints_prefix = "",
                                other_hints_prefix = "",
                            },
                        },
                        server = {
                            settings = {
                                ["rust-analzyer"] = {
                                    checkOnSave = {
                                        command = "clippy",
                                    },
                                },
                            },
                        },
                    })
                end,
                ["clangd"] = function()
                    lspconfig["clangd"].setup({
                        capabilities = vim.tbl_extend("force", capabilities, { encoding = "utf-8" }),
                    })
                end,
            }

            local handlers = {}

            for _, server in ipairs(installed) do
                handlers[server] = function()
                    lspconfig[server].setup({ capabilities = capabilities })
                end
            end

            for server, custom_handler in pairs(custom_handlers) do
                handlers[server] = custom_handler
            end

            for _, handler in pairs(handlers) do
                handler()
            end
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics

            null_ls.setup({})
            null_ls.register({
                name = "default-lua",
                sources = { formatting.stylua },
            })
            null_ls.register({
                name = "default-python",
                sources = {
                    diagnostics.ruff,
                    formatting.ruff,
                    formatting.black,
                },
            })
            null_ls.register({
                name = "default-haskell",
                sources = { formatting.fourmolu },
            })
            null_ls.register({
                name = "default-rust",
                sources = { formatting.rustfmt },
            })
        end,
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        opts = {},
        keys = {
            { "<leader>f", ":HopChar2<CR>", desc = "Hop forward" },
            { "<leader>w", ":HopWord<CR>", desc = "Hop word" },
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        keys = {"gc", "gcc", "gb", "gbc"},
    },
    {
        "folke/which-key.nvim",
        opts = {
            H = { ":nohl<CR>", "Disable [H]ighlighting" },
            d = { vim.diagnostic.open_float, "Show [d]iagnostic" },
            b = {
                name = "[b]uffer",
                a = { ":b#", "[a]lternate buffer" },
            },
            s = {
                name = "[s]earch",
                b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "search [b]uffer" },
                o = { "<cmd>Telescope buffers<CR>", "search [o]pen buffers" },
                f = { "<cmd>Telescope find_files<CR>", "search [f]iles" },
                d = { "<cmd>Telescope diagnostics<CR>", "search [d]iagnostics" },
                g = { "<cmd>Telescope live_grep<CR>", "search with [g]rep" },
                w = { "<cmd>Telescope grep_string<CR>", "search [w]ord" },
                s = { "<cmd>Telescope lsp_document_symbols<CR>", "search [s]ymbols" },
            },
        },
        config = function(_, opts)
            require("which-key").setup()
            require("which-key").register(opts, { prefix = "<leader>" })
        end,
    },
}

require("lazy").setup(plugins)

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

vim.opt.termguicolors = true
vim.cmd("colorscheme arctic")

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

vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })
vim.keymap.set("v", "J", ":move .+1<CR>==gv", { silent = true, noremap = true })
vim.keymap.set("v", "K", ":move .-2<CR>==gv", { silent = true, noremap = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local function nmap(keys, action, desc)
            vim.keymap.set("n", keys, action, { buffer = ev.buf, desc = desc })
        end

        local function format()
            vim.lsp.buf.format({ async = true })
        end

        nmap("gD", vim.lsp.buf.declaration, "goto [D]eclaration")
        nmap("gd", vim.lsp.buf.definition, "goto [d]efinition")
        nmap("gi", vim.lsp.buf.implementation, "goto [i]mplementation")
        nmap("K", vim.lsp.buf.hover)
        nmap("<C-k>", vim.lsp.buf.signature_help)
        nmap("<leader>D", vim.lsp.buf.type_definition, "show type [D]efinition")
        nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
        nmap("<leader>F", format, "[F]ormat")
    end,
})

vim.api.nvim_create_augroup("UserAutoFormat", { clear = true })
