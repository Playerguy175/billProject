require("lover")

local state = "mainmenu"

local function ret(nS)
    if nS then
        if nS == "end" then
            love.event.quit()
        else
            state = nS
        end
    end
end

love.tick(function (dt)
    ret(require("states/"..state)[1](dt))
end)

love.key(function (key,down)
    ret(require("states/"..state)[2](key,down))
end)

love.tick(function (dt)
    love.graphics.setColor(1,1,1,0.5)
    love.graphics.print("a (bad) nick production",love.width-215,love.height-25,0,0.5,0.5)
end)