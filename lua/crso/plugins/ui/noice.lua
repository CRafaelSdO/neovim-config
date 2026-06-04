return {
    {
        "folke/noice.nvim",

        event = "VeryLazy",

        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },

        opts = {
            lsp = {
                override = {
                    ["vim.lsp.handlers['textDocument/hover']"] = true,
                    ["vim.lsp.handlers['textDocument/signatureHelp']"] = true,
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },

            cmdline = { enabled = true },
            messages = { enabled = true },
            popupmenu = { enabled = true },

            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },

            routes = {
                {
                    filter = {
                        event = "msg_show",

                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; before #" },
                            { find = "; after #" },
                        },
                    },

                    opts = { skip = true },
                },
            },
        },
    },
}
