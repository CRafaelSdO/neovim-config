return {
    {
        "nvim-treesitter/nvim-treesitter",

        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",

        opts = {
            ensure_installed = require("crso.meta.stack"):languages(),
            sync_install = false,
            auto_install = true,
        },
    },
}
