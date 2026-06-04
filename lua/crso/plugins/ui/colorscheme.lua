return {
    {
        "catppuccin/nvim",

        name = "catppuccin",
        lazy = false,
        priority = 1000,

        opts = {
            flavour = "mocha",

            background = {
                light = "frappe",
                dark = "mocha",
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            integrations = {
                gitsigns = true,
                treesitter = true,
                blink_cmp = true,

                mini = {
                    enabled = true,
                    indentscope = true,
                },

                custom_highlights = function(colors)
                    return {
                        WinSeparator = { fg = colors.crust, bg = colors.crust },
                    }
                end,
            },
        },

        config = function(_, opts)
            require("catppuccin").setup(opts)

            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },
}
