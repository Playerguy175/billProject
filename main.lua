require("lover")

local state = "mainmenu"

love.tick(function (dt)
    local nS = require("states/"..state)[1](dt)
    if nS then
        state = nS
    end
end)

love.key(function (key,down)
    require("states/"..state)[2](key,down)
end)