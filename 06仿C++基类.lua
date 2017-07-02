-- 仿照C++的类的结构创建一个 复数 类

Complex = {} -- 定义table变量，在该文件被调用的时候，可以以函数的形式返回这个table

-- 构造函数
function Complex:constructor()
	self.i = 0
	self.j = 0
end
	
-- 创建对象的函数
function Complex.create()
	local temptable = {}
	local mt = {
		__index = Complex,
		__add = function(a, b)
			local result = Complex.create() -- 此处已经用metatable绑定了Complex
			result.i = a.i + b.i
			result.j = a.j + b.j
			return result
			end
	}
	setmetatable(temptable, mt) -- 临时table用metatable绑定Complex
	temptable:constructor() -- 构造，产生i和j
	return temptable
end

-- 打印函数
function Complex:dump()
	print(self.i .. "+" .. self.j .. "i")
end

--[[
print("Complex OK")

local a = Complex.create();
a.i = 5
a.j = 6
local b = Complex.create();
b.i = 1
b.j = 3
c = a + b
a:dump()
c:dump()
--]]

return Complex
