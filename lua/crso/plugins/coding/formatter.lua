return {
    {
        "stevearc/conform.nvim",

        dependencies = { "mason-org/mason.nvim" },

        opts = {
            formatters_by_ft = require("crso.meta.stack"):formatters_by_ft(),

            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
    },

    {
        "zapling/mason-conform.nvim",

        event = { "BufReadPre", "BufNewFile" },

        dependencies = { "mason-org/mason.nvim", "stevearc/conform.nvim" },

        opts = { ignore_install = {} },
    },
}
