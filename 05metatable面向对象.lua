-- [[metatable--]]
-- 1.__index
t1 = {
		a = 1;
		b = 2
	}
t2 = {}
mt = { __index = t1 } -- __index是关键字，不能修改
-- 设置mt为t2的metatable
setmetatable(t2, mt)
print(t2.a) -- 1
-- 首先在t2表中查找a，没找到
-- 再去t2的metatable(mt)中查找关联的表t1
-- 找到了t1中的a，返回
-- 行为类似于：t2表通过mt的关系，继承了t1

-- 2.另外的写法
t2 = {}
t1 = {
	a = 1,
	b = 2,
	__index = t1
}
setmetatable(t2, t1)
print(t2.a)
-- 查找路径：t2-->metatable(t1)-->t1-->a

-- 3.__add、__sub等函数模拟操作符重载
p1 = {x = 100, y = 200}
p2 = {x = 50, y = 60}
mt1 = {
	__add = function(a, b)
		local ret = {}
		ret.x = a.x+b.x
		ret.y = a.y+b.y
		return ret
	end
}
mt2 = {
	__add = function(a, b)
		return {x = 0, y = 0}
	end
}
-- 设置metatable
setmetatable(p1, mt1)
ret = p2 + p1
print(ret.x, ret.y) -- 150 260
-- 重新设置metatable
setmetatable(p1, mt1)
setmetatable(p2, mt2)
ret = p1 + p2
print(ret.x, ret.y) -- 150 260
-- 重新设置metatable
setmetatable(p1, mt2)
setmetatable(p2, mt1)
ret = p1 + p2
print(ret.x, ret.y) -- 0 0
-- 结论：
-- 只要有一个table的metatable中有__add方法，就能使用重载
-- 两个table中都有__add方法时，优先使用第一个table的mutatablle


-- 面向对象解析 ----------------------------
person = {}
person.name = ""
person.location = ""
-- person的全局函数
person.move1 = function(This, newloc) This.location = newloc end
-- person的成员函数
function person:move2(newloc)
	self.location = newloc
end

-- 利用函数建立与访问对象的关系
person.create = function()
	local temp = {} -- 用来返回结果集，给对象初始化metatable绑定
	local mt = {__index = person}
	setmetatable(temp, mt)
	return temp
end

-- 调用函数创建2个对象，对象是全局变量有自己的存储空间，但通过mt继承了person
aaa = person.create()
bbb = person.create()

-- 调用person函数
-- 1) 用 . 访问相当于调用类的静态成员函数
aaa.move1(aaa, "shanghai") -- 如果参数没有aaa，将直接访问person的location，而不是aaa table变量
bbb.move1(bbb, "hangzhou")
-- 2) 用 : 访问相当于调用类的普通成员函数
aaa:move2("shanghai") -- 访问成员变量，函数自带this指针
bbb:move2("hangzhou")	