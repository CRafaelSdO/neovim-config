return {
    {
        "mfussenegger/nvim-lint",

        dependencies = { "mason-org/mason.nvim" },

        config = function()
            require("lint").linters_by_ft = require("crso.meta.stack"):linters_by_ft()
        end,
    },

    {
        "rshkarin/mason-nvim-lint",

        event = { "BufReadPre", "BufNewFile" },

        dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-lint" },

        opts = {
            automatic_installation = true,
        },
    },
}
