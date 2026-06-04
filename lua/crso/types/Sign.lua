local Obj = require("crso.types.Obj")

---@class Sign
---@field priority number
---@field hl_group string
---@field text string
---@overload fun(priority?: number, hl_group?: string, text?: string): Sign
local class = Obj:extend("Sign")

class.priority = 0
class.hl_group = ""
class.text = " "

---@param priority? number Priodidade
---@param hl_group? string Grupo de realce
---@param text? string Texto renderizado
function class:init(priority, hl_group, text)
	self.priority = priority or self.priority
	self.hl_group = hl_group or self.hl_group
	self.text = (text and vim.trim(text) ~= "") and vim.trim(text) or self.text
end

---@return string
function class:render()
	if self.text == " " then
		return " "
	end

	return "%#" .. self.hl_group .. "#" .. self.text .. "%*"
end

return class
