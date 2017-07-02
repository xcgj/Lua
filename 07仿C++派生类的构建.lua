-- [[仿C++派生类的构建--]]

--[[
基本思想：
MyComplex table 通过metatable 关联 Complex table
MYComplex的创建对象函数里面的临时 table 通过 metatable 关联 MyComplex table
临时table 赋值给对象时，会调用一次 临时table 的构造函数，临时table 是空的，会去MyComplex找构造
	MyComplex 的构造函数用:设置为普通函数，设法先调用一次Complex(父类)的构造，实现C++类的仿制
	然后定义 临时table 所需的变量
打印函数dump的调用：对象会先去MyComplex找，没找到会再去Complex找，通过metatable一层层往上找
__add()函数的重载：由于__add()这些函数是在metatable中定义的，他们的调用位置和父类table基本没什么关系，
	不能算作是父类的函数，应该算是metatable的功能函数，因此每次产生子类都需要在子类的mutatable中重写

  父类  --->  子类  --->  孙子类
CoComplex--->MyComplex--->在MyComplex.create()中的temptable(最后用来创建对象了)
对象表面上看起来像是由MyComplex定义的，但实际上是由MyComplex的子类创建的--如果一个metatable就是一层关系的话
--]]

--  06仿C++基类.lua 执行了代码，并有Complex返回
-- 直接获得头文件中Complex的首地址
-- require()类似#include
local Complex = require("06仿C++基类")

-- 从Complex类派生
local mt = { __index=Complex }
local MyComplex = { super = Complex } -- 为了使父类的构造先执行
setmetatable(MyComplex, mt)

-- MyComplex的构造，提供给子类使用
function MyComplex:constructor()
	super:constructor()
	self.i = 10
	self.j = 20
end	

-- 通过临时产生的table子类创建对象
MyComplex.create = function()
	local temptable = {}
	local mt = {
		__index = MyComplex,
		__add = function(a, b)	-- 重写函数
			local ret = MyComplex.create()
			ret.i = a.i + b.i
			ret.j = a.j + b.j
			return ret
		end
	}
	setmetatable(temptable, mt)
	temptable:constructor()
	return temptable
end

-- 测试
local a = MyComplex.create()
a:dump()
local b = MyComplex.create()
local c = a + b
c:dump()