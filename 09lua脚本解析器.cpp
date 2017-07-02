#include <stdio.h>
#include <lua5.2/lua.h>
#include <lua5.2/lualib.h>
#include <lua5.2/lauxlib.h>

/* 业务：实现lua脚本解析器调用C/C++函数的功能
 * 思路：
 * 在执行脚本文件前，先解析lua函数，注册这个函数使其和C/C++函数绑定
 * 	当脚本解析器解析脚本获取函数后，将lua函数传入指定函数x
 * 	在函数x中，从脚本解析器对象lua(放在一个虚拟栈中，不按照后进先出规则)中获取lua函数的参数
 * 	在函数x中，调用C/C++函数，传入获取到的lua参数，获得函数返回值
 * 	在函数x中，将返回值放回栈，传给lua函数
 * 准备就绪后，调用dofile函数执行脚本
 */

// C/C++函数
int add(int a, int b)
{
	return a+b;
}

// 注册lua函数，返回值类型和参数类型固定，不可修改
int addForLua(lua_State * lua)
{
	//获取栈中元素的个数，即lua函数的参数个数，栈空间默认20
	//int n = lua_gettop(lua);//如果参数个数固定可不写
	double a = lua_tonumber(lua, 1);//复制栈底第一个参数，lua函数左边的先入栈
	double b = lua_tonumber(lua, 2);//复制栈底第二一个参数，
	//传参计算结果	
	double c = (double)add((int)a, (int)b);
	
	//如果栈空间不够用，可以申请扩大空间
	//lua_checkstack(lua, 30);//确保栈上至少有30个空位，没有就申请，不会缩小
	
	//将计算结果放入栈
	lua_pushnumber(lua, c);
	return 1;//结果是几个就返回数字几
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
	//注册lua和C/C++的函数
	lua_register(lua, "add", addForLua);
	// 从命令行获取脚本文件，打开文件，执行脚本命令，是阻塞调用的
	luaL_dofile(lua, argv[1]);
	// 关闭解析器
	lua_close(lua);
	return 0;
}