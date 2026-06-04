local Sign = require("crso.types.Sign")
local PriorityEvaluator = require("crso.types.PriorityEvaluator")

local get_buf = vim.api.nvim_win_get_buf
local get_extmarks = vim.api.nvim_buf_get_extmarks

local git_pe = PriorityEvaluator(
	"GitSigns",
	{ "Untracked", "Add", "Change", "Delete", "Changedelete", "Topdelete" },
	function(type, pe)
		local priority = 0

		if type == "" then
			return priority
		end

		if type:find("^Staged") then
			type = type:match("Staged(%a+)")
			priority = -1
		else
			priority = 5
		end

		return priority + (pe.priorities[type] or 0)
	end
)
local diagnostic_pe = PriorityEvaluator("DiagnosticSign", { "Hint", "Info", "Warn", "Error" })

_G.status_column = function(line_number, window_id)
	local extmarks = get_extmarks(
		get_buf(window_id),
		-1,
		{ line_number - 1, 0 },
		{ line_number - 1, -1 },
		{ details = true }
	)

	local git_s = Sign()
	local diagnostic_s = Sign()

	for _, mark in ipairs(extmarks) do
		local hl_group = mark[4].sign_hl_group
		local text = mark[4].sign_text

		local git_p = git_pe:evaluate(hl_group)
		local diagnostic_p = diagnostic_pe:evaluate(hl_group)

		if git_p > git_s.priority then
			git_s = Sign(git_p, hl_group, text)
		end

		if diagnostic_p > diagnostic_s.priority then
			diagnostic_s = Sign(diagnostic_p, hl_group, text)
		end
	end

	return table.concat({
		"%=",
		diagnostic_s:render(),
		"%l",
		git_s:render(),
		"%C",
	})
end
