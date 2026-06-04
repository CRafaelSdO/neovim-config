return {
    {
        "lukas-reineke/indent-blankline.nvim",

        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },

        opts = {
            indent = { char = "│" },

            exclude = {
                filetypes = {
                    "help",
                    "lazy",
                    "mason",
                    "notify",
                },
            },

            scope = {
                enabled = true,
                show_start = false,
            },
        },
    },
}
