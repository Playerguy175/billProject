local beeps = {}
for v,o in pairs(love.filesystem.getDirectoryItems("beep")) do --beep noises from https://www.soundjay.com/beep-sounds-3.html
    local a = love.audio.newSource("beep/"..o,"static")
    beeps[#beeps+1] = a
    a:setPitch(2)
end
function love.beep()
    beeps[love.math.random(1,#beeps)]:play()
end

require("lover")

local state = "mainmenu"

local all = {}

local function ret(nS)
    if nS then
        if nS == "end" then
            love.event.quit()
        else
            package.loaded["states/"..nS] = nil
            state = nS
        end
    end
end

love.tick(function (dt)
    love.graphics.setColor(1,1,1,1)
    ret(require("states/"..state)[1](dt,all))
end)

love.key(function (key,down)
    ret(require("states/"..state)[2](key,down))
end)

love.tick(function (dt)
    love.graphics.setColor(1,1,1,0.5)
    local sx,sy = string.size("a (bad) nick production")
    love.graphics.print("a (bad) nick production",love.width,love.height)
end)