local x = 0

local op = {}
op[1] = {"Start","start"}
op[2] = {"Options"}
op[3] = {"Exit","end"}
local i = 1

return {function (dt)
    local y = 10
    love.graphics.setColor(1,1,1)
    love.graphics.print("[name]",10,y,0,1.5,1.5)
    y = y + 1.5*love.textbox.height
    for v,o in pairs(op) do
        if v == i then
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(0.5,0.5,0.5)
        end
        love.graphics.print(o[1],10,y)
        y = y + 1*love.textbox.height
    end
end,function (key,down)
    if down then
        if key == "down" or key == "s" then
            i = i%#op+1
            love.beep()
        elseif key == "up" or key == "w" then
            i = (i-2)%#op+1
            love.beep()
        elseif key == "space" or key == "return" then
            love.beep()
            return op[i][2]
        end
    end
end}