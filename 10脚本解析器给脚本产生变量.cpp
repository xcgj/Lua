#include <stdio.h>
#include <lua5.2/lua.h>
#include <lua5.2/lualib.h>
#include <lua5.2/lauxlib.h>

/* 业务：
 * 利用lua脚本解析器虚拟栈的特性，给lua脚本增加变量、table
 * void lua_setglobal (lua_State *L, const char *name);从堆栈上弹出一个值，并将其设到全局变量 name 中
 * void lua_newtable (lua_State *L);创建一个空 table ，并将之压入堆栈
 * void lua_settable (lua_State *L, int index);
 *		作一个等价于 t[k] = v 的操作， 这里 t 是一个给定有效索引 index 处的值， v 指栈顶的值， 而 k 是栈顶之下的那个值。 
 * 		这个函数会把键和值都从堆栈中弹出
 */

// 从解析器给lua增加一个table变量
void addValToLua(lua_State * lua)
{
//#if 1 //变量
	//先在栈中放入一个变量
	lua_pushnumber(lua, 100);
	//再弹出这个变量赋值给a
	lua_setglobal (lua, "a");
//#elif 1 //b.c
	//先在栈中放入一个空的table
	lua_newtable (lua);
	//再弹出这个table赋值给b
	lua_setglobal (lua, "b");
//#elif 1 //d.e
	//先在栈中放入一个空的匿名的table
	lua_newtable (lua);
	//再放入两个值，分别作为键和值
	lua_pushstring(lua, "e");//如果放入1，就是数组，调用时用print(d[1])
	lua_pushnumber(lua, 300);
	//再弹出这两个值赋值给空table
	lua_settable (lua, -3);// -3：空table所在的栈的下标，从栈顶开始倒计数
	//再弹出这个匿名的table赋值给d
	lua_setglobal (lua, "d");
//#endif
}

int main(int argc, char * argv[])
{
	if (argc == 1)
	{
		printf("命令行缺少参数\n");
		return -1;
	}
	// 打开lua脚本解析器 5.2版本
	//lua_State* lua = lua_open(); // 5.1版本
	lua_State* lua = luaL_newstate();
	// 打开lua相关库
	luaL_openlibs(lua);
	// 从解析器给lua增加一个table变量
	addValToLua(lua);
	// 从命令行获取脚本文件，打开文件，执行脚本命令，是阻塞调用的
	luaL_dofile(lua, argv[1]);
	// 关闭解析器
	lua_close(lua);
	return 0;
}