return {
    {
        "MunifTanjim/nui.nvim"
    },
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
        priority = 1000,
        lazy = false,
        setup = function()
        end
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
        "famiu/bufdelete.nvim",
        config = false,
        cmd = { "Bdelete", "Bwipeout" },
    },
    {
        "folke/which-key.nvim",
        dependencies = { },
        opts = {
            E = { ":Neotree toggle<CR>", "[E]xplorer" },
            H = { ":nohl<CR>", "Disable [H]ighlighting" },
            M = { ":make<CR>", "[M]ake"},
            T = { ":term<CR>", "[T]erminal"},
            d = { vim.diagnostic.open_float, "Show [d]iagnostic" },
            b = {
                name = "[b]uffer",
                a = { ":b#<CR>", "[a]lternate buffer" },
                d = { ":Bdelete<CR>", "[d]elete" },
                w = { ":Bwipeout<CR>", "[w]ipeout" },
            },
            s = {
                name = "[s]earch",
                b = { ":Telescope current_buffer_fuzzy_find<CR>", "search [b]uffer" },
                o = { ":Telescope buffers<CR>", "search [o]pen buffers" },
                f = { ":Telescope find_files<CR>", "search [f]iles" },
                d = { ":Telescope diagnostics<CR>", "search [d]iagnostics" },
                g = { ":Telescope live_grep<CR>", "search with [g]rep" },
                w = { ":Telescope grep_string<CR>", "search [w]ord" },
                s = { ":Telescope lsp_document_symbols<CR>", "search [s]ymbols" },
            },
            ["."] = { vim.lsp.buf.code_action, "code actions" },
            ["<leader>"] = { ":Telescope buffers<CR>", "search open buffers" }
        },
        config = function(_, opts)
            require("which-key").setup()
            require("which-key").register(opts, { prefix = "<leader>" })
        end,
    },
}
