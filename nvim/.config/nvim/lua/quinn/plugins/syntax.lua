return {
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

}
