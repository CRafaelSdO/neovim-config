local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("yank_highlight", { clear = true }),

    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 150,
        })
    end,
})

autocmd({ "BufWritePost", "InsertLeave" }, {
    group = augroup("lint", { clear = true }),

    callback = function()
        local lint = require("lint")

        local linters = lint._resolve_linter_by_ft(vim.bo.filetype)

        for _, linter in ipairs(linters) do
            if vim.fn.executable(linter) == 1 then
                lint.try_lint(linter)
            end
        end
    end,
})
