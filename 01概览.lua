-- lua脚本文件的执行
-- lua 01basic.lua
-- 语句可以不加";"

--[[变量--]]
-- 变量定义
a = 3
a = "xcgj"

-- print 输出后自动换行
print(a) -- xcgj

-- 定义变量的注意点
-- 1.
a, b = 1, 3 -- 等同于 a=1, b=3
a, b = b, a -- 变量交换
-- 2.
-- lua里面定义的变量都是全局变量，
-- 但是在函数外使用函数定义的变量需要先调用函数后才会生效
-- 函数内定义全局变量
function func1()
	x=100
end
print(x) -- nil

-- 调用函数的全局变量
function func2()
	y=50
end
func2()
print(y) -- 50

-- 3.
-- 定义局部变量在变量名前加 local
-- local b

--[[类型--]]
-- nil == NULL

-- boolean -- true false

-- number -- double

-- string -- "" '' [[]]
-- 1.
str = "aaa"
-- 2.
str = 'bbb'
-- 3.可以保留文本格式，换行制表符等
str = [[ccc
				ddd]] 
-- 4.避免重复。等号可以无限加
str = [=[eee
			]]
				fff]=] 

-- function
-- 1.定义有名函数
function fun1()
	-- code
end
-- 2.定义匿名函数，赋值给变量
fun2 = function()
	-- code
end	
fun3 = fun2

-- userdata -- void*

-- thread

-- table
-- 1.结构体1
person = {
		age = 10,
		id = 200
	}
person.name = 'tom' -- 表内自动加字段
print(person.age, person.id) -- 10 200
print(person.a) -- nil
-- 2.结构体2
man = {}
man.id = 10
man.age = 20
man.name = "mike"
-- 3.数组，默认下标从1开始，可以自定下标
color = {"red", "green", "black"}
print(color[1]) -- red
color[0] = 'blue'
color[-1] = "yellow"
color[100] = "white"
color[a] = "grey"
print(color[a]) -- grey
-- 4.数组和结构体混用，用数组下标输出，计数会忽略键值对
mixtab = {1,2,name=jack,3,nickname='jacky',4,"abc",5,6,7,8,9,nil,0}
print(mixtab[5]) -- abc
print(mixtab[11]) -- nil
print(mixtab[12]) -- 0
print(mixtab[name]) -- nil
print(mixtab[nickname]) -- jacky
print(mixtab.nickname) -- jacky