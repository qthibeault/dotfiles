local function feedkey(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "2.*",
            },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_opts = {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
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
                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif vim.fn["vsnip#available"](1) == 1 then
                    --         feedkey("<Plug>(vsnip-expand-or-jump)", "")
                    --     elseif has_words_before() then
                    --         cmp.complete()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
                    -- ["<S-Tab>"] = cmp.mapping(function()
                    --     if cmp.visible() then
                    --         cmp.select_prev_item()
                    --     elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    --         feedkey("<Plug>(vsnip-jump-prev)", "")
                    --     end
                    -- end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            }

            local cmdline_opts = {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            }

            cmp.setup(cmp_opts)
            cmp.setup.cmdline(":", cmdline_opts)
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {},
            },
            { "neovim/nvim-lspconfig" },
            {
                "folke/neodev.nvim",
                opts = {},
            },
            { "simrat39/rust-tools.nvim" },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

            local opts = {
                ensure_installed = { "lua_ls", "clangd", "pyright", "rust_analyzer" },
                handlers = {
                    function(server_name)
                        local lsp_opts = {
                            capabilities = default_capabilities,
                        }

                        lspconfig[server_name].setup(lsp_opts)
                    end,

                    ["lua_ls"] = function()
                        local lsp_opts = {
                            settings = {
                                Lua = {
                                    workspace = { checkThirdParty = false },
                                    telemetry = { enable = false },
                                },
                            },
                        }

                        lspconfig.lua_ls.setup(lsp_opts)
                    end,

                    ["rust_analyzer"] = function()
                        local lsp_opts = {
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
                        }

                        require("rust-tools").setup(lsp_opts)
                    end,

                    ["clangd"] = function()
                        local lsp_opts = {
                            capabilities = vim.tbl_extend("force", default_capabilities, { encoding = "utf-8" }),
                        }

                        lspconfig.clangd.setup(lsp_opts)
                    end,
                },
            }

            mason_lspconfig.setup(opts)
            lspconfig.hls.setup({ capabilities = default_capabilities })
        end,
    },
    {
        "mhartington/formatter.nvim",
        cmd = { "Format" },
        opts = function()
            local filetypes = require("formatter.filetypes")
            local fourmolu = function()
                return {
                    exe = "fourmolu",
                    args = {},
                    stdin = false,
                }
            end

            return {
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = { filetypes.lua.stylua },
                    python = { filetypes.python.black },
                    rust = { filetypes.rust.rustfmt },
                    c = { filetypes.c.clangformat },
                    cpp = { filetypes.c.clangformat },
                    haskell = { fourmolu },
                    ["*"] = { filetypes.any.remove_trailing_whitespace },
                },
            }
        end,
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "ruff" },
            }
        end,
    },
}
