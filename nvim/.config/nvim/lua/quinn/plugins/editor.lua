return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {},
        cmd = { "Neotree" },
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Telescope" },
        opts = {},
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        cmd = { "HopChar2", "HopWord" },
        opts = {},
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
        keys = { "gc", "gcc", "gb", "gbc" },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
}
