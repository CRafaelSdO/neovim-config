local set = vim.keymap.set

local function on_init(client, _)
    if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

local function on_attach(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    ---------------------------------------------------------------------------
    -- NAVIGATION AND DOCUMENTATION
    ---------------------------------------------------------------------------
    set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
    set("n", "gT", vim.lsp.buf.type_definition, opts("Go to type definition"))

    ---------------------------------------------------------------------------
    -- CODE ACTIONS
    ---------------------------------------------------------------------------
    set("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename Symbol"))
    set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))

    ---------------------------------------------------------------------------
    -- WORKSPACE
    ---------------------------------------------------------------------------
    set("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts("Workspace: Add folder"))
    set("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts("Workspace: Remove folder"))

    set("n", "<leader>cwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("Workspace: List folders"))
end

return {
    {
        "mason-org/mason-lspconfig.nvim",

        event = { "BufReadPre", "BufNewFile" },

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
            "b0o/SchemaStore.nvim",
        },

        opts = {
            ensure_installed = require("crso.meta.languages"):lsps(),
            automatic_enable = true,
        },

        config = function(_, opts)
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
                on_init = on_init,
                on_attach = on_attach,
            })

            for lsp, lsp_opts in pairs(require("crso.meta.languages"):lsps_opts()) do
                vim.lsp.config(lsp, lsp_opts)
            end

            require("mason-lspconfig").setup(opts)
        end,
    },
}
