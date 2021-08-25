---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by yky.
--- DateTime: 2021/6/26 16:01
---
print("hello world")

score = 0
str1 = "haha"

print(type(score))
print(type(str1))

-- .. 的作用类似于其他变成语言的 +
house = "house"
print("this is my ".. house)

-- 除法 //, 5.1的lua版本没有双斜杠这个运算符，所以可以用math.floor 或者 math.ceil
val1 = 10
val2 = 3
print(val1 // val2)
print(math.floor(val1/val2))
print(math.ceil(val1/val2))

-- lua的条件判断，关键词 then，end
-- elseif 是连在一起，分开会让lua以为是连续的两个if，每一个if，不管是if还是elseif，后面都需要跟一个then
if val2 == val1 - 7  then
    print("yes")
elseif val2 ~= val1 then
    print("no")
end

-- 逻辑运算符 and or not
if val1 > 0 and val2 > 0 then
    print("都大于0")
end

val3 = -5
if val1 > 0 or val3 > 0 then
    print("其中一个大于0")
end

-- string 函数
-- 替换 string.gsub(str，oldCharacter, newCharacter)
-- 截取 string.sub(str, index1, index2)，闭区间
-- 长度 string.len(str) 语法糖 #str
-- 查找 string.find(str, target)
str = "123456798"
print(string.sub(str, 1,2))
-- 这里明明返回的是一个num
print(type(string.find(str, "1")))
-- 但是if判断语句居然成功了
if string.find(str, "1") then
    print("yep")
end

-- multi-line string，如果像下面这样写多行string会报错
--str2 = " 123
--13213135"
-- 应该用中括号
str3 = [[6
sdfsdfsdfsdsd
sdfsdffsdfsdf]]

print(str3)

-- multi-assign 多变量声明，快速交换两个变量的值
x, y = 1, 2
x, y = y, x
print("x:"..x..", y:"..y)

-- 常用的函数
print(os.date())
-- print(os.difftime())
print(os.time())

-- 循环
for i = 1, 10 do
    print(i)
end

-- 也有类似go的循环
--for i, v in ipairs() do
--
--end

count = 1
while count < 5 do
    print("count:"..count)
    count = count +1
end


-- 变量的范围，在lua中，好像没有局部变量的概念，一个变量在任何地方被声明后，在后面的语句中好像都可以调用
for i = 1, 10 do
    tempInner = i
end
print("tempInner:" ..tempInner)
-- 如果想要变成局部变量，那么需要
for i = 1, 10 do
    local tempInner2 = i
end
-- 这条语句会报错
-- print("tempInner:" ..tempInner2)

-- lua的标准输入，是阻塞的
--putIn = io.read("*n")
--print(putIn)

-- 函数
function test1()
    print("这里是test1函数，正在调用")
end

test1()

function test2(param)
    print("这里是test2函数，正在调用，参数:"..param)
    return 1000
end

local res = test2("tset")
print("test2函数的返回值:".. res)

-- table 的用法 ，像数组，但是也像map
table1 = { 9, 55, 2, 33, 67}
print("table1[1]:"..table1[1])

table2 = {["key1"]=99, ["key2"]=55}
print("key2:"..table2["key2"])
-- 数组for循环，array是有序的，数组可以用ipairs 或者是pairs
for k, v in ipairs(table1) do
    print("array key:"..k..";val:"..v)
end
-- map for循环 注意i的区别，同时map是无序的
for k, v in pairs(table2) do
    print("map key:"..k..";val:"..v)
end
--不用中括号和双引号，table也是可以的
table3 = {x = 1, y = 2}

local loc = {x = 10, y = 12}
print(loc)




-- metatable 也是一个table，这个table中定义了一些和该metatable关联的变量，在特定情况下的一些操作，比如非数字变量进行加法操作时
-- 就会去检查metatable中的__add 如果发现这个函数被定义了，那么就去调用他
-- meta methods，我的理解就是自定义一些运算规则
-- 下面这一行是重要的，因为它声明了一个结构，可以理解成后面的函数是golang里的方法，而不仅仅是一个函数
local vector3d = {}
local meta = {}

function vector3d.new(x, y, z)
    local v = {x = x, y = y, z = z}
    -- 把vector3d这个变量和meta联系起来了
    setmetatable(v, meta)
    return v
end

-- 这个函数定义了，如果两个变量同属于vector3d，那么他们的add方法定义成如下
function vector3d.add(v1, v2)
    return vector3d.new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
end
meta.__add = vector3d.add
-- 注意 tostring的方法最后是有返回值的
function vector3d.tostring(v)
    return "x:"..v.x.."; y:"..v.y.."; z:"..v.z
end
meta.__tostring = vector3d.tostring

velocity1 = vector3d.new(10, 5, 6)
velocity2 = vector3d.new(8, 2, 4)
res = velocity1 + velocity2
print(res.x)
print(res)



-- 面向对象编程，lua也可以new一个新的对象，创建新的对象的时候，不需要额外指定一个meta来作为metatable
-- 上面需要额外指定的原因是，vector3d并不是一个对象，它只是一个table
-- lua中的self 相当于其他面向对象编程的this
print("开始面向对象编程")
fighter = {
    name = "",
    age = 0,
    gender = 0
}

-- --------------------------------以下是lua的方法，就类比golang的方法和函数的区别
function fighter:punch()
    print("fighter:"..self.name.."is going to punch")
end

function fighter:tostring()
    print("这是fighter:"..self.name..";年龄"..self.age..";性别"..self.gender)
end


-- 类比java的构造方法
function fighter:new(t)
    -- 注意这个初始化的写法，如果t是空，那么就分配一个空table，如果不是空就是他本身
    t = t or {}
    -- 注意这里设置了metatable，只有把metatable设置为self才可以调用对象自身的方法
    setmetatable(t, self)
    -- 所有定义的函数可以理解成放在了一个map里，这里就是当需要调用的val或者是函数没有在对象体内声明的时候，会去metatable里找
    self.__index = self
    return t
end


fighter1 = fighter:new({name = "hahaha", age = 111, gender = 0})
fighter1:tostring()
fighter1:punch()


-- lua的可变参数
function manyParameters(...)
    local arguments = {...}
    for i, v in ipairs(arguments) do
        print(v)
    end
    a, b, c = ...
    print(a)
    print(b)
    print(c)
end

manyParameters(1,2,6,7)

-- lua 的类型判断
ans = {
    a="v2",
}
for i, v in pairs(ans) do
    -- ngx.log(ngx.INFO, "i: "..i.." v: "..v)
    print("i: "..i.." v: "..v)
end

if type(ans) == "table" then
    print("这是一个 table")
end


print(package.cpath)
