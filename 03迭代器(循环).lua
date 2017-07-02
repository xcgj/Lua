--[[迭代器(循环)--]]
-- 1.
for i=1, 5, 2 do -- i等于1到5，闭区间。2表示步长，不写默认为1，可以负数，小数
	print("i = ", i)
end
-- 2.ipairs，获取数组部分的值
t = {1,a="aa",2,3,c=10,4,d="ss",5}
for k, v in ipairs(t) do
	print("ipairs:", k, v)
end
-- 3.pairs获取数组和映射表
for k, v in pairs(t) do
	print("pairs:", k, v)
end