local all = nil
local tim = 0

local arr = love.graphics.newImage("arrow.png")
local dir = {"Senate Committee","Senate Floor","Senate Vote"}

return {function (dt,_all)
    all = _all
    all.senate = true
    tim = tim + dt
    if tim < 2 then
        love.graphics.setColor(1,1,1,tim)
    else
        love.graphics.setColor(1,1,1,3-tim)
    end
    if tim > 3.5 then
        if all.stat == nil then
            all.stat = 1
        elseif all.stat < 4 then
            all.stat = all.stat + 1
        else
            return "mainmenu"
        end
        return "senate/"..string.sub(string.lower(dir[all.stat]),8)
    end

    love.graphics.printCentered(dir[1],love.width/2,love.height/2-love.width*3/16,2,2)
    love.graphics.printCentered(dir[2],love.width/2,love.height/2-love.width/16,2,2)
    love.graphics.printCentered(dir[3],love.width/2,love.height/2+love.width/16,2,2)

    love.graphics.draw(arr,love.width/2,love.height/2 - love.width/8,0,love.height/1000,love.height/1000,arr:getWidth()/2,arr:getHeight()/2)
    love.graphics.draw(arr,love.width/2,love.height/2,0,love.height/1000,love.height/1000,arr:getWidth()/2,arr:getHeight()/2)
end,function (down,key)
    
end}