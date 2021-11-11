package.path = "/Users/yinkaiyi/personal/program/mylua/src/main/lua/?.lua;;"

local luaJson = require "table2json"

local postBody = {["songIds"] = {1, 2},["fileIds"] = {1,1,1,1}}
-- print(type(postBody["songIds"]))
-- print(luaJson.table2json(postBody))

-- for k, v in pairs(postBody) do
--     print(k)
--     print(type(v))
--     if type(v) == "table" then print("这是一个 table") end
-- end

print(array2json("songIds",postBody["songIds"]))

-- for i, v in ipairs(postBody) do
--     print("ipairs可以循环table")
-- end