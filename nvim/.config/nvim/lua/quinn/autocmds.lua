vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local function nmap(keys, action, desc)
            vim.keymap.set("n", keys, action, { buffer = ev.buf, desc = desc })
        end

        nmap("gD", vim.lsp.buf.declaration, "goto [D]eclaration")
        nmap("gd", vim.lsp.buf.definition, "goto [d]efinition")
        nmap("gi", vim.lsp.buf.implementation, "goto [i]mplementation")
        nmap("K", vim.lsp.buf.hover)
        nmap("<C-k>", vim.lsp.buf.signature_help)
        nmap("<leader>D", vim.lsp.buf.type_definition, "show type [D]efinition")
        nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
    callback = function()
        require("lint").try_lint()
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("UserTermConfig", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
    end,
})
