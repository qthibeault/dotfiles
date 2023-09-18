return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {},
        cmd = { "Neotree" }
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        cmd = { "Telescope" },
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
        "kylechui/nvim-surround",
        version = "*",
        event = { "VeryLazy" },
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        keys = {"gc", "gcc", "gb", "gbc"},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        opts = {},
    },
}
