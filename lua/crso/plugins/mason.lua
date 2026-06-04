return {
    "mason-org/mason.nvim",

    lazy = false,

    init = function()
        -- Configuração do PATH
        local is_windows = vim.fn.has("win32") ~= 0
        local sep = is_windows and "\\" or "/"
        local delim = is_windows and ";" or ":"

        vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
    end,

    opts = {
        ui = {
            border = "rounded",

            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ",
            },
        },

        max_concurrent_installers = 10,
    },
}
