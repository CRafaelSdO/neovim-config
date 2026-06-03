-- Configuração do Clipboard para sincronização com o sistema quando no WSL
vim.g.clipboard = {
    name = "WSL-Clipboard",

    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },

    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },

    cache_enabled = 0,
}
