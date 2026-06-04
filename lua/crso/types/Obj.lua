---@class Obj
---@field className string The actual name of the class
local class = {}

class.__index = class
class.className = "Obj"

-- Does nothing.
-- You have to implement this yourself for extra functionality when initializing
---@param self Obj
function class:init(...) end

-- Instanciate an object of the current class
---@param ... unknown
---@return Obj
function class:new(...)
	local obj = setmetatable({}, self)

	obj:init(...)

	return obj
end

-- You can call the class to initialize it without using `Obj:init`.
---@param self Obj
---@param ... unknown
---@return Obj
function class:__call(...)
	return self:new(...)
end

-- Create a new class/object by extending the base Object class.
-- The extended object will have a field called `super` that will access the super class.
---@generic T
---@param self Obj
---@param className string The new class name
---@return T
function class:extend(className)
	local cls = {}

	for key, value in pairs(self) do
		if key:find("__") == 1 then
			cls[key] = value
		end
	end

	cls.__index = cls
	cls.super = self
	cls.className = className or self.className

	return setmetatable(cls, self)
end

-- Implement a mixin onto this Object.
---@param self Obj
---@param ... unknown
function class:implement(...)
	for _, cls in ipairs({ ... }) do
		for key, value in pairs(cls) do
			if not self[key] and type(value) == "function" then
				self[key] = value
			end
		end
	end
end

-- Checks if the object is an instance
-- This will start with the lowest class and loop over all the superclasses.
---@param self Obj
---@param Type Obj
---@return boolean
function class:is(Type)
	local metatable = getmetatable(self)

	while metatable do
		if metatable == Type then
			return true
		end

		metatable = getmetatable(metatable)
	end

	return false
end

-- The default tostring implementation for an object.
-- You can override this to provide a different tostring.
---@param self Obj
---@return string
function class:__tostring()
	local metatable = getmetatable(self)

	setmetatable(self, nil)

	local address = tostring(self):match("^table: (.*)")

	setmetatable(self, metatable) -- Devolve a metatabela

	return self.className .. "@" .. address
end

return class
