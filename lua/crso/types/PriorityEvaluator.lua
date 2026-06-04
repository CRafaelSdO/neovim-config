local Obj = require("crso.types.Obj")

---@class PriorityEvaluator
---@field prefix string
---@field priorities table<string, number>
---@field custom_calc? fun(type: string, manager: PriorityEvaluator): number
---@overload fun(prefix: string, priority_list: string[], custom_calc?: fun(type: string, manager: PriorityEvaluator): number): PriorityEvaluator
local class = Obj:extend("PriorityEvaluator")

---@param prefix string O prefixo puro (ex: "GitSigns" ou "DiagnosticSign")
---@param priority_list string[] Lista de prioridades da menor para a maior
---@param custom_calc? fun(type: string, manager: PriorityEvaluator): number Função opcional para cálculo de priorodade personalizado
function class:init(prefix, priority_list, custom_calc)
	self.prefix = prefix or ""
	self.priorities = {}
	self.custom_calc = custom_calc

	for index, value in ipairs(priority_list) do
		self.priorities[value] = index
	end
end

---@param hl_group? string
---@return number
function class:evaluate(hl_group)
	if not hl_group or not hl_group:find("^" .. self.prefix) then
		return 0
	end

	local type = hl_group:match(self.prefix .. "(%a+)") or ""

	if self.custom_calc then
		return self.custom_calc(type, self)
	end

	return self.priorities[type] or 0
end

return class
