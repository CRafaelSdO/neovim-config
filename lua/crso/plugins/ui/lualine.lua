return {
    {
        "nvim-lualine/lualine.nvim",

        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",

        opts = function()
            local colors = require("catppuccin.palettes").get_palette()

            local shared = {
                b = { fg = colors.text, bg = colors.surface0 },
                c = { fg = colors.text, bg = colors.crust },
                x = { fg = colors.text, bg = colors.crust },
                y = { fg = colors.text, bg = colors.surface0 },
                z = { fg = colors.text, bg = colors.surface0 },
            }

            local custom_theme = {
                normal = vim.tbl_extend("force", {
                    a = { fg = colors.crust, bg = colors.blue, bold = true },
                }, shared),

                insert = vim.tbl_extend("force", {
                    a = { fg = colors.crust, bg = colors.green, bold = true },
                }, shared),

                visual = vim.tbl_extend("force", {
                    a = { fg = colors.crust, bg = colors.mauve, bold = true },
                }, shared),

                command = vim.tbl_extend("force", {
                    a = { fg = colors.crust, bg = colors.peach, bold = true },
                }, shared),

                terminal = vim.tbl_extend("force", {
                    a = { fg = colors.crust, bg = colors.red, bold = true },
                }, shared),

                inactive = vim.tbl_extend("force", {
                    a = { fg = colors.subtext0, bg = colors.mantle },
                }, shared),
            }

            return {
                options = {
                    theme = custom_theme,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,

                    ignore_focus = { "neo-tree", "lazy", "mason", "alpha" },
                },

                sections = {
                    lualine_a = {
                        { "mode", icon = "" },
                    },

                    lualine_b = {
                        {
                            "",
                            draw_empty = true,
                            separator = { right = "" },
                            color = { bg = colors.surface2 },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            colored = true,
                            padding = { left = 1, right = 0 },
                        },
                        {
                            "filename",
                            path = 1,
                            newfile_status = true,
                            symbols = { modified = "", readonly = "", unnamed = "", newfile = "" },
                        },
                    },

                    lualine_c = {
                        { "branch", icon = "" },
                        {
                            "diff",
                            always_visible = true,
                            symbols = { added = "", modified = "", removed = "" },
                        },
                    },

                    lualine_x = {
                        { "encoding", fmt = string.upper },
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = "", warn = "", info = "", hint = "󰌵" },
                        },
                        {
                            function()
                                return ""
                            end,
                            padding = { left = 0, right = 1 },
                            color = { fg = colors.crust, bg = colors.lavender },
                            separator = { left = "" },
                        },
                        {
                            "lsp_status",
                            icon = "",
                            padding = { left = 0, right = 1 },
                            color = { fg = colors.lavender, bg = colors.surface0 },
                        },
                    },

                    lualine_y = {
                        {
                            function()
                                return ""
                            end,
                            color = { fg = colors.crust, bg = colors.red },
                            padding = { left = 0, right = 1 },
                        },
                        {
                            function()
                                return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                            end,
                            color = { fg = colors.red },
                        },
                    },

                    lualine_z = {
                        {
                            function()
                                return ""
                            end,
                            color = { fg = colors.crust, bg = colors.peach },
                            padding = { left = 0, right = 1 },
                        },
                        {
                            "location",
                            color = { fg = colors.peach },
                        },
                    },
                },
            }
        end,
    },
}
