local all
local dem = true

local dw,dh = string.size("Democrat")
local rw,rh = string.size("Republican")

return {function (dt,_all)
    all = _all

    love.graphics.printCentered("Choose your party:",love.width/2,love.height/2-dh*2)

    love.graphics.setColor(0.5,0.5,0.5)
    if dem then
        love.graphics.setColor(1,1,1)
    end
    love.graphics.print("Democrat",love.width/2-dw-50,love.height/2-dh/2)

    love.graphics.setColor(0.5,0.5,0.5)
    if not dem then
        love.graphics.setColor(1,1,1)
    end
    love.graphics.print("Republican",love.width/2+50,love.height/2-rh/2)

end,function (key,down)
    if down then
        if key == "left" or key == "a" or key == "right" or key == "d" then
            dem = not dem
            love.beep()
        elseif key == "return" then
            all.party = dem and "Democrat" or "Republican"
            return "mainmenu"
        end
    end
end}