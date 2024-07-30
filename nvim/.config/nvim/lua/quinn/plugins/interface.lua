return {
    {
        "stevearc/dressing.nvim",
        event = { "VeryLazy" },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "VeryLazy" },
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
            indent = {
                char = "┊",
            },
        },
        main = "ibl",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
                spec = {
                { "<leader>E", "<cmd>Neotree toggle<CR>", desc = "[E]xplorer", mode = "n" },
                { "<leader>F", "<cmd>Format<CR>", desc = "[F]ormat", mode = "n" },
                { "<leader>H", "<cmd>nohl<CR>", desc = "Disable [H]ighlighting", mode = "n" },
                { "<leader>M", "<cmd>make<CR>", desc = "[M]ake", mode = "n" },
                { "<leader>T", "<cmd>term<CR>", desc = "[T]erminal", mode = "n" },
                { "<leader>d", vim.diagnostic.open_float, desc = "Show [d]iagnostic", mode = "n" },
                {
                    group = "[b]uffer",
                    mode = "n",
                    { "<leader>ba", "<cmd>b#<CR>", desc = "[a]lternate buffer" },
                    { "<leader>bd", "<cmd>Bdelete<CR>", desc = "[d]elete" },
                    { "<leader>bw", "<cmd>Bwipeout<CR>", desc = "[w]ipeout" },
                },
                { "<leader>f", "<cmd>HopChar2<CR>", desc = "Hop [f]orward", mode = "n" },
                {
                    group = "search",
                    desc = "[s]earch",
                    mode = "n",
                    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "search [b]uffer" },
                    { "<leader>so", "<cmd>Telescope buffers<CR>", desc = "search [o]pen buffers" },
                    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "search [f]iles" },
                    { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "search [d]iagnostics" },
                    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "search with [g]rep" },
                    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "search [w]ord" },
                    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "search [s]ymbols" },
                },
                { "<leader>w", "<cmd>HopWord<CR>", desc = "Hop [w]ord", mode = "n" },
                { "<leader>.", vim.lsp.buf.code_action, desc = "code actions", mode = "n" },
                { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "search open buffers", mode = "n" },
            },
        },
    },
}
