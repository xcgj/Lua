--[[热更新--]]
-- 程序启动后，获取到更新包，程序不退出删除旧内容，加载新内容

-- 加载旧模块
require("08package")

local score = calcscore()
print(score)

-- 读取新模块，会阻塞，此时打开另外的终端，修改 08package.lua 中的数据
io.read()
print("read end")

-- 先从table表中将旧模块删除
package.loaded["08package"] = nil

-- 重新加载模块
require("08package")

local score = calcscore()
print(score)