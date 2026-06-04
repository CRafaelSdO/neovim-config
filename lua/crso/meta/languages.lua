local M = {}

M._languages_meta = {
	vim = {},
	vimdoc = {},
	query = {},
	markdown = {},
	markdown_inline = {},
	lua = {},
	yaml = {},
}

function M:languages()
	return vim.tbl_keys(self._languages_meta)
end

return M
