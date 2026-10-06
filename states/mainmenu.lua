local x = 0

local op = {}
op[1] = {"Start","start"}
op[2] = {"Options"}
op[3] = {"Exit","end"}
local i = 1

return {function (dt)
    love.graphics.setColor(1,1,1)
    love.graphics.print("[name]",10,10,0,1.5,1.5)
    for v,o in pairs(op) do
        if v == i then
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(0.5,0.5,0.5)
        end
        love.graphics.print(o[1],10,60+v*30)
    end
end,function (key,down)
    if down then
        if key == "down" or key == "s" then
            i = i%#op+1
        elseif key == "up" or key == "w" then
            i = (i-2)%#op+1
        elseif key == "space" or key == "return" then
            return op[i][2]
        end
    end
end}