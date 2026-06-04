return {
    {
        "kevinhwang91/nvim-ufo",

        event = { "BufReadPost", "BufNewFile" },

        dependencies = "kevinhwang91/promise-async",

        opts = {
            provider_selector = function(_, _, _)
                return function(buf_number)
                    local ufo = require("ufo")

                    local ranges = ufo.getFolds(buf_number, "treesitter")

                    if not ranges or #ranges == 0 then
                        ranges = ufo.getFolds(buf_number, "indent")
                    end

                    if not ranges or #ranges == 0 then
                        return {}
                    end

                    for _, range in ipairs(ranges) do
                        if range.endLine > range.startLine then
                            range.endLine = range.endLine - 1
                        end
                    end

                    return ranges
                end
            end,

            fold_virt_text_handler = function(virtual_text, _, _, _, _)
                local new_virtual_text = {}

                for _, chunk in ipairs(virtual_text) do
                    table.insert(new_virtual_text, chunk)
                end

                table.insert(new_virtual_text, { " 󰇘 ", "Comment" })

                return new_virtual_text
            end,
        },
    },
}
