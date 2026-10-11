local all
local hou = true

return {function (dt,_all)
    all = _all

    local Ht, St = "House ("..(all.houseRep > 50 and "Republican" or "Democrat")..")", "Senate ("..(all.senateRep > 50 and "Republican" or "Democrat")..")"

    local dw,dh = string.size(Ht)
    local rw,rh = string.size(St)

    love.graphics.printCentered("Choose starting house:",love.width/2,love.height/2-dh*2)

    love.graphics.setColor(0.5,0.5,0.5)
    if hou then
        love.graphics.setColor(1,1,1)
    end
    love.graphics.print(Ht,love.width/2-dw-50,love.height/2-dh/2)

    love.graphics.setColor(0.5,0.5,0.5)
    if not hou then
        love.graphics.setColor(1,1,1)
    end
    love.graphics.print(St,love.width/2+50,love.height/2-rh/2)

end,function (key,down)
    if down then
        if key == "left" or key == "a" or key == "right" or key == "d" then
            hou = not hou
            love.beep()
        elseif key == "return" then
            if hou then
                return "house/start"
            else
                return "senate/start"
            end
        end
    end
end}