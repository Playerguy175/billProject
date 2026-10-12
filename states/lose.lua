local all
local tim = 0

local b2 = love.graphics.newImage("ball2.png")
local de = love.graphics.newImage("desk.png")
local gav = love.graphics.newImage("gaval.png")
local no = love.graphics.newImage("no.png")

return {function (dt,_all)
    all = _all
    tim = tim + dt
    love.graphics.draw(b2,love.width/2,love.height/2,math.sin(tim*4)/4,-love.width/400,love.width/400,16,16)

    love.graphics.setColor(0.8,0.6,0.4)
    love.graphics.draw(de,love.width/2.8,love.height/2.8,0, love.width/400,love.width/400,16,16)

    love.graphics.setColor(0.4,0.3,0.2)
    love.graphics.draw(gav,love.width/1.84,love.height/1.85, -1.5-3*(tim%1)*((tim%1)-1) ,love.width/400,love.width/400,8,14)

    love.graphics.setColor(1,1,1,tim-1.5)
    love.graphics.draw(no,love.width/1.84,love.height/3.4,0,love.width/400,love.width/400,8,14)

    if tim > 4.5 then
        return "mainmenu"
    end
end,function (key,down)
    
end}