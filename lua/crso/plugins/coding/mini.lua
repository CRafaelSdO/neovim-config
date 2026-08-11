return {
    {
        "echasnovski/mini.surround",

        version = "*",
        event = "BufEnter",
        opts = {
            mappings = {
                add = "<leader>sa",
                delete = "<leader>sd",
                find = "<leader>sf",
                find_left = "<leader>sF",
                highlight = "<leader>sh",
                replace = "<leader>sr",
            },
        },
    },

    {
        "echasnovski/mini.ai",

        version = "*",
        event = "BufEnter",
        config = true,
    },

    {
        "echasnovski/mini.pairs",

        version = "*",
        event = "InsertEnter",
        config = true,
    },
}
