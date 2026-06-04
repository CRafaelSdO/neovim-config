---@param mode string|string[] The mode the map applies to (e.g., 'n' for normal, 'i' for insert, 'v' for visual, or a table like {'n', 'v'})
---@param lhs string The custom keystroke or shortcut you want to use
---@param rhs string|function The command or Lua function triggered by the shortcut
---@param desc string The description os the map
---@param opts? vim.keymap.set.Opts Tabela com opções adicionais (expr, silent, buffer, remap, etc.)
local function set(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_deep_extend("force", {
        desc = desc,
        silent = true,
    }, opts or {})

    vim.keymap.set(mode, lhs, rhs, opts)
end

-------------------------------------------------------------------------------
-- TABS
-------------------------------------------------------------------------------
set("n", "<leader>tn", "<cmd>tabnew<cr>", "Tabs: Open a new tab")
set("n", "<leader>tc", "<cmd>tabclose<cr>", "Tabs: Close current tab")

set("n", "<leader>tl", "<cmd>tabnext<cr>", "Tabs: Go to next tab")
set("n", "<leader>th", "<cmd>tabprevious<cr>", "Tabs: Go to previous tab")

-------------------------------------------------------------------------------
-- WINDOWS
-------------------------------------------------------------------------------
set("n", "<leader>wh", "<cmd>split<cr>", "Windows: Split horizontally")
set("n", "<leader>wv", "<cmd>vsplit<cr>", "Windows: Split vertically")
set("n", "<leader>wc", "<cmd>close<cr>", "Windows: Close current window")

set("n", "<C-h>", "<C-w>h", "Windows: Focus left window")
set("n", "<C-j>", "<C-w>j", "Windows: Focus bottom window")
set("n", "<C-k>", "<C-w>k", "Windows: Focus top window")
set("n", "<C-l>", "<C-w>l", "Windows: Focus right window")

-------------------------------------------------------------------------------
-- BUFFERS
-------------------------------------------------------------------------------
set("n", "<leader>bn", "<cmd>enew<cr>", "Buffers: Open a new empty buffer")

set("n", "<leader>bd", function()
    require("bufdelete").bufdelete(0, false)
end, "Buffers: Close current buffer")

set("n", "<leader>bD", function()
    require("bufdelete").bufdelete(0, true)
end, "Buffers: Close current buffer (forced)")

set("n", "<leader>bw", function()
    require("bufdelete").bufdelete(0, false)
end, "Buffers: Wipeout current buffer")

set("n", "<leader>bW", function()
    require("bufdelete").bufdelete(0, true)
end, "Buffers: Wipeout current buffer (forced)")

set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", "Buffers: Next buffer")
set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Buffers: Previous buffer")

-------------------------------------------------------------------------------
-- NAVEGAÇÃO NO MODO DE INSEÇÃO
-------------------------------------------------------------------------------
set("i", "<C-h>", "<Left>", "Mover para a esquerda")
set("i", "<C-j>", "<Down>", "Mover para baixo")
set("i", "<C-k>", "<Up>", "Mover para cima")
set("i", "<C-l>", "<Right>", "Mover para a direita")

set("i", "<C-b>", "<C-o>b", "Voltar uma palavra")
set("i", "<C-f>", "<C-o>w", "Avançar uma palavra")

set("i", "<C-a>", "<Home>", "Ir para o início da linha")
set("i", "<C-d>", "<End>", "Ir para o final da linha")

-------------------------------------------------------------------------------
-- SISTEMA
-------------------------------------------------------------------------------
set("n", "<C-s>", "<cmd>w<cr>", "System: Save file")
set("i", "<C-s>", "<Esc><cmd>w<cr>a", "System: Save file and continue typing")

set("n", "<esc>", "<cmd>noh<cr>", "System: Clear search highlight")

set("t", "<esc>", function()
    local buf_name = vim.api.nvim_buf_get_name(0)

    if buf_name:match("lazygit") then
        return "<esc>"
    end

    return [[<C-\><C-n>]]
end, "Sair do modo terminal", { expr = true })

set("n", "<leader>q", "<cmd>q<cr>", "System: Quit Neovim")

set("n", "<leader>e", function()
    local mini_files = require("mini.files")

    if not mini_files.close() then
        mini_files.open(vim.api.nvim_buf_get_name(0))
    end
end, "Toggle mini.files (Diretório atual)")

-------------------------------------------------------------------------------
-- COMMENTS
-------------------------------------------------------------------------------
set("n", "<leader>;", "gcc", "Comments: Toggle line comment", { remap = true })
set("v", "<leader>;", "gc", "Comments: Toggle block comment", { remap = true })

-------------------------------------------------------------------------------
-- TELESCOPE
-------------------------------------------------------------------------------
set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, "Telescope: Find Files")

set("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
end, "Telescope: Live Grep text")

set("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
end, "Telescope: List active buffers")

set("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
end, "Telescope: Search Help Docs")

set("n", "<leader>fc", function()
    require("telescope.builtin").commands()
end, "Telescope: Neovim Commands")

set("n", "<leader>fk", function()
    require("telescope.builtin").keymaps()
end, "Telescope: Active Keymaps")

set("n", "<leader>ft", function()
    require("telescope-tabs").list_tabs()
end, "Telescope: List active tabs")

-------------------------------------------------------------------------------
-- LAZYGIT & GITSIGNS
-------------------------------------------------------------------------------
set("n", "<leader>gg", "<cmd>LazyGit<cr>", "Git: Open LazyGit dashboard")

set("n", "<leader>hp", function()
    require("gitsigns").gitsigns.preview_hunk()
end, "Git: Preview change popup")

set("n", "]c", function()
    if vim.wo.diff then
        return "]c"
    end

    vim.schedule(function()
        require("gitsigns").next_hunk()
    end)

    return "<Ignore>"
end, "Git: Next change hunk")

set("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    end

    vim.schedule(function()
        require("gitsigns").prev_hunk()
    end)

    return "<Ignore>"
end, "Git: Previous change hunk")

-------------------------------------------------------------------------------
-- NVIM-UFO
-------------------------------------------------------------------------------
set("n", "zR", function()
    require("ufo").openAllFolds()
end, "Ufo: Open all code folds")

set("n", "zM", function()
    require("ufo").closeAllFolds()
end, "Ufo: Close all code folds")
