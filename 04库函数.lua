--[[基本库函数--]]
-- assert() 错误判断
-- load() 类似函数指针，将特定字符串加载成一个函数，返回值是加载好的函数
function func()
	print("xcgj")
end

retload = load(string.dump(func)) -- 先将func函数转成特定字符串，再加载，赋值给retload
retload() -- 相当于调用func函数

-- loadstring() 给函数体字符串提供函数框架，转成函数
ret = loadstring([[
	print("loadstring test")
	return 0;
]])
ret() -- 提供了函数框架给上面的代码执行，调用了函数

-- pcall() 提供函数运行环境
function func1(a, b)
end
pcall(func1, x, y) -- 给函数圈起来运行，以免影响外面的程序，x,y是传入的参数

-- xpcall() 函数调用和出错回调机制
function errdeal()
end
xpcall(func, errdeal) -- func函数运行出错时，回调errdeal函数

-- rawequal() 比较两个table的内容
t1 = {1,id=5,3,4,6,7}
t2 = t1 -- 首地址赋值
if t1 == t2 then -- 首地址比较
end
if rawequal(t1, t2) then -- table内容比较
end

-- unpack() 解析table中的数组元素
print(unpack(t1)) -- 打印table的数组内容，不打印映射表
subtable = {unpack(t1, 2, 5)} -- 表示下标从2开始到下标为5 的所有数组元素，放入表subtable
print("subtable元素个数：", #subtable) -- 4


--[[table库函数--]]
-- table.concat() 将table中的数组元素按格式拼接成字符串
str = table.concat(t1, "-") -- 默认拼接所有有效数组元素，左闭右开
print(str) -- 1-3-4-6-7
str = table.concat(t1, "-", 2, 4) -- 指定拼接范围，左闭右开
print(str) -- 3-4-6

-- table.insert() 插入数据
-- 默认尾部插入，可以指定插入位置
print(#t1)
table.insert(t1, 2, 10)
t1[#t1+1] = 20; -- 尾部插入。。。

-- table.maxn() 求最大下标
-- 和 # 求长度不一样，#是求出数组的最大， 而maxn也能求映射表
t1[1000] = 99
len = table.maxn(t1)
print(len) -- 1000
print(#t1) -- 7

-- table.remove() 默认移除最后一个元素
-- 指定位置移除
table.remove(t1, 5)
t1[#t1] = nil -- 尾部移除。。。

-- table.sort() 默认小到大排序，比较参数是个函数
--传参数大到小排序
table.sort(t1, function(x, y) return x > y end)


--[[string库函数--]]
-- string.byte() 拆分字符串成整数
str = "abc"
a, b, c = string.byte(str, 1, 2) -- 表示只取第一个到第二个-->c==nil，参数2、3不写表示全部拆分
print(type(a), a) -- number 97

-- string.char() 数字拼接成字符串
str = string.char(97,97,97,97)
print(str) -- aaaa

-- string.dump() 将一个完整的函数加载成一串特定字符串
-- 可用于客户端于服务器间的数据传输，
-- 客户端将函数dump()打包成字符串
-- 服务器接收后load()一下变成一个函数，直接调用

-- string.format(formatString, ...) 类似sprintf()
-- string.gmatch(s, pattern) 正则匹配
-- string.len(s) 获取长度
-- string.lower(s) 转小写
-- string.rep(s, n) 重复拼接
-- string.reverse(s) 反转
-- string.sub(s, i [,j]) 获取子串
-- string.upper(s) 转大写