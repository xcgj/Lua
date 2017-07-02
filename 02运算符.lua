--[[运算符--]]
--在lua中，只有变量的值是nil才是false，0是true
a = 0
if a then
	print("true")
end

-- 逻辑运算符and和or，被赋值变量的值等于最后的表达式的值
x = 1
y = 2
-- 1.
b = x and y	-- x不为nil，b的值等于y的值
print("b = ", b) -- 2
-- 2.
b = z and y
print("b = ", b) -- nil，短路原则
-- 3.
z = false
b = z and y
print("b = ", b) -- false
-- 4.
-- 当n为true == m?n:p
-- 	如果m是true，结果为n
-- 	如果m是false，结果为p
-- 当n为flase
-- 	结果为p
b = m and n or p
print("b = ", b)
-- 5.
b = m or n and p
print("b = ", b)

-- .. 连接运算符
-- 1.
x = 'aaa'
y = 'bbb'
z = 100
print(x .. y .. z) -- aaabbb100
-- 2.整数转字符串
x = ''
y = 55
y = x .. y
print("y = ", y) -- 55
print("type(y) is:", type(y)) -- string
-- 3.字符串转整数
x = "66"
x = x + 0
print("x = ", x) -- 66
print("type(x) is:", type(x)) -- number

-- # 求长度
-- 1.字符串
x = "xcgj"
print("length of x is:", #x) -- 4
-- 2.表
-- 只计算非nil值[下标]的个数，不计算键值对，下标<=0 等的情况
table = {"name", 1, 2, 3, age = 10}
table[100] = 30;
table[0] = 20;
table[-3] = 90;
table.id = "qwe"
print("length of table is:", #table) -- 4