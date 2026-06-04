return {
    {
        "folke/which-key.nvim",

        event = "VeryLazy",
        opts = { preset = "helix" },

        config = function(_, opts)
            local wk = require("which-key")

            wk.setup(opts)

            wk.add({
                -- Agrupamentos do <leader>
                { "<leader>b", group = "Buffers" },
                { "<leader>c", group = "Code (LSP)" },
                { "<leader>cw", group = "Workspace" },
                { "<leader>f", group = "Telescope / Find" },
                { "<leader>g", group = "Git" },
                { "<leader>h", group = "Git Hunks" },
                { "<leader>t", group = "Tabs" },
                { "<leader>w", group = "Windows" },
                { "<leader>s", group = "Surround" },

                -- Agrupamentos sem <leader>
                { "[", group = "Prev" },
                { "]", group = "Next" },
                { "g", group = "Goto / Comments" },
                { "z", group = "Folds (UFO)" },
            })
        end,
    },
}
