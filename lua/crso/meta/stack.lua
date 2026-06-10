local M = {}

---@class StackMeta
---@field parsers string[] Tree-sitter parsers list
---@field lsps? string[] LSP list (opcional)
---@field linters? string[] Linting tools list (opcional)
---@field formatters? string[] Formatters list (opcional)

---@type table<string, StackMeta>
M._stack_meta = {
    vim = {
        parsers = { "vim" },
    },

    help = {
        parsers = { "vimdoc" },
    },

    query = {
        parsers = { "query" },
    },

    markdown = {
        parsers = { "markdown", "markdown_inline" },
        lsps = { "marksman" },
        linters = { "markdownlint" },
        formatters = { "prettier" },
    },

    lua = {
        parsers = { "lua" },
        lsps = { "lua_ls" },
        linters = { "luacheck" },
        formatters = { "stylua" },
    },

    python = {
        parsers = { "python" },
        lsps = { "basedpyright", "ruff" },
        formatters = { "ruff_format", "ruff_organize_imports" },
    },

    sh = {
        parsers = { "bash" },
        lsps = { "bashls" },
        linters = { "shellcheck" },
        formatters = { "shfmt" },
    },

    toml = {
        parsers = { "toml" },
        lsps = { "taplo" },
    },

    yaml = {
        parsers = { "yaml" },
        lsps = { "yamlls" },
        linters = { "yamllint" },
        formatters = { "yamlfmt" },
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

    basedpyright = {
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = "standard",
                },
            },
        },
    },

    bashls = {
        filetypes = { "sh", "bash", "zsh" },
    },

    taplo = {
        settings = {
            taplo = {
                cfg = {
                    schema = {
                        catalogs = { "https://schemastore.org" },
                    },
                },
            },
        },
    },

    yamlls = function()
        return {
            settings = {
                yaml = {
                    validate = true,
                    format = { enable = false },
                    customTags = { "!reference sequence" },
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        }
    end,
}

-- Extends a list-like table with the values of another list-like table that aren't on it yet.
--
-- NOTE: This mutates dst!
-- @param dst string[] List which will be modified and appended to
-- @param src string[] List from which values will be inserted
local function list_extend(dst, src)
    for _, value in ipairs(src) do
        if not vim.tbl_contains(dst, value) then
            table.insert(dst, value)
        end
    end
end

function M:parsers()
    local parsers = {}

    for _, meta in pairs(self._stack_meta) do
        list_extend(parsers, meta.parsers)
    end

    return parsers
end

function M:lsps()
    local lsps = {}

    for _, meta in pairs(self._stack_meta) do
        if meta.lsps then
            list_extend(lsps, meta.lsps)
        end
    end

    return lsps
end

function M:lsps_opts()
    local lsps_opts = {}

    for _, meta in pairs(self._stack_meta) do
        if meta.lsps then
            for _, lsp in ipairs(meta.lsps) do
                if not lsps_opts[lsp] then
                    lsps_opts[lsp] = self._lsps_opts[lsp] or {}
                end
            end
        end
    end

    return lsps_opts
end

function M:linters_by_ft()
    local linters_by_ft = {}

    for ft, meta in pairs(self._stack_meta) do
        if meta.linters then
            linters_by_ft[ft] = meta.linters
        end
    end

    return linters_by_ft
end

function M:formatters_by_ft()
    local formatters_by_ft = {}

    for ft, meta in pairs(self._stack_meta) do
        if meta.formatters then
            formatters_by_ft[ft] = meta.formatters
        end
    end

    return formatters_by_ft
end

return M
