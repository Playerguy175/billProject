local all
local tim = 0

local b2 = love.graphics.newImage("ball2.png")
local de = love.graphics.newImage("desk.png")
local gav = love.graphics.newImage("gaval.png")
local yes = love.graphics.newImage("yes.png")

local win
return {function (dt,_all)
    all = _all
    tim = tim + dt

    if tim < 2 then
        if tim < 1 then
            love.graphics.setColor(1,1,1,tim)
        else
            love.graphics.setColor(1,1,1,2-tim)
        end
        love.graphics.printCentered("President",love.width/2,love.height/2,2,2)
    end
    
    if tim > 2 then
        if not win then
            if all.president ~= all.party and love.math.random(1,2) == 1 or love.math.random(1,3) == 1 then
                return "lose"
            end
            win = true
        end
        love.graphics.draw(b2,love.width/2,love.height/2,math.sin(tim*4)/4,-love.width/400,love.width/400,16,16)

        love.graphics.setColor(0.8,0.6,0.4)
        love.graphics.draw(de,love.width/2.8,love.height/2.8,0, love.width/400,love.width/400,16,16)

        love.graphics.setColor(0.4,0.3,0.2)
        love.graphics.draw(gav,love.width/1.84,love.height/1.85, -1.5-3*(tim%1)*((tim%1)-1) ,love.width/400,love.width/400,8,14)

        love.graphics.setColor(1,1,1,tim-3.5)
        love.graphics.draw(yes,love.width/1.84,love.height/3.4,0,love.width/400,love.width/400,8,14)

        if tim > 5.5 then
            love.graphics.setColor(1,1,1,tim-5.5)
            love.graphics.printCentered("Thanks for playing! :P",love.width/2,love.height/1.2,2,2)
        end

        if tim > 8.5 then
            return "mainmenu"
        end
    end
end,function (key,down)
    
end}