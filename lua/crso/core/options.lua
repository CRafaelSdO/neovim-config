local g = vim.g
local opt = vim.opt

-- Leader global e local
g.mapleader = " "
g.maplocalleader = "\\"

-- Otimização
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

-- Comportamento
opt.shortmess:append("sI")
opt.undofile = true
opt.updatetime = 250
opt.timeout = false
-- Busca
opt.ignorecase = true
opt.smartcase = true
-- Navegação
opt.mouse = "a"
opt.whichwrap:append("<>[]hlb")

-- Indentação e Espaçamento
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- UI
opt.showmode = false
opt.ruler = false
opt.laststatus = 3
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.fillchars = {
	eob = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	foldinner = " ",
}

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})
