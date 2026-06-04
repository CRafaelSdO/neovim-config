local M = {}

M._languages_meta = {
	vim = {},
	vimdoc = {},
	query = {},

	markdown = {
		lsp = "marksman",
		linter = "markdownlint",
	},

	markdown_inline = {
		lsp = "marksman",
		linter = "markdownlint",
	},

	lua = {
		lsp = "lua_ls",
		linter = "luacheck",
	},

	yaml = {
		lsp = "yamlls",
		linter = "yamllint",
	},
}

M._lsps_opts = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },

				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},

				telemetry = { enable = false },
			},
		},
	},

	yamlls = {
		settings = {
			yaml = {
				validate = true,
				format = { enabled = false },
				customTags = { "!reference sequence" },

				schemas = function()
					return require("schemastore").yaml.schemas()
				end,
			},
		},
	},
}

function M:languages()
	return vim.tbl_keys(self._languages_meta)
end

function M:lsps()
	local lsps = {}

	for _, meta in pairs(self._languages_meta) do
		if meta.lsp then
			table.insert(lsps, meta.lsp)
		end
	end

    return lsps
end

function M:lsps_opts()
	local lsps_opts = {}

	for _, meta in pairs(self._languages_meta) do
		if meta.lsp then
			lsps_opts[meta.lsp] = self._lsps_opts[meta.lsp] and self._lsps_opts[meta.lsp] or {}
		end
	end

	return lsps_opts
end

function M:linter_by_ft()
	local linter_by_ft = {}

	for language, meta in pairs(self._languages_meta) do
		linter_by_ft[meta.ft or language] = type(meta.linter) == "table" and meta.linter or { meta.linter }
	end

	return linter_by_ft
end

return M
