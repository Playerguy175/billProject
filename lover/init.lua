--an old project of mine to make making games on love2d easier

love.window.setFullscreen(true)
love.graphics.setDefaultFilter("nearest","nearest")

local ticks = {}
function love.tick(func)
    ticks[#ticks+1] = func
end

local list = {}
function love.typed(func)
    list[#list+1] = func
end

function love.textinput(...)
    for v,o in ipairs(list) do
        o(...)
    end
end

love.keys = {}
local keys = {}
function love.key(func)
    keys[#keys+1] = func
end

function love.keypressed(k,bar,isRep)
    love.keys[k] = true
    for v,o in ipairs(keys) do
        o(k,true,isRep)
    end
end

function love.keyreleased(k)
    love.keys[k] = false
    for v,o in ipairs(keys) do
        o(k,false)
    end
end

local mouses = {}
function love.mouse(func)
    mouses[#mouses+1] = func
end
local mouseR = function (type,...)
    for v,o in pairs(mouses) do
        o(type,...)
    end
end
function love.mousepressed(...)
    mouseR("down",...)
end
function love.mousemoved(...)
    mouseR("move",...)
end
function love.mousereleased(...)
    mouseR("up",...)
end

function love.resize(w,h)
    rawset(love,"width",w)
    rawset(love,"height",h)
end
love.width,love.height = love.graphics.getWidth(),love.graphics.getHeight()

love.random = love.math.random

table.rom = function (self)
    local key = {}
    setmetatable(key,{
        ["__newindex"] = function() end,
        ["__index"] = function(t,v)
            return self[v]
        end
    })
    return key
end

require("lover.textbox")

function love.errorhandler(msg)
    print(tostring(msg))
    local time = love.timer.getTime()
    while love.timer.getTime() - time < 3 do end
end

local function setUpNet(ip)
    love.net = require("lover/cnet")(ip)
    love.net.setServerIp = setUpNet
end
setUpNet()
love.tick(function ()
    love.net.tick()
end)

vec = require("lover/vec").n

math.sign = function (x)
    if x > 0 then
        return 1
    end
    if x < 0 then
        return -1
    end
    return 0
end

math.clip = function (x,l)
    if x > l then
        return l
    end
    if x < -l then
        return -l
    end
    return x
end

local intro = require("lover.intro")

local start = false
function love.run()

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    return function()
        -- time shit
        if love.timer then dt = love.timer.step() end

        if not start then
            if intro() then
                start = true
            end
            return
        end

        --start draw
        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())
        end

        --cannon event
        if love.event then
            love.event.pump()
            for name, a,b,c,d,e,f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a or 0
                    end
                end
                love.handlers[name](a,b,c,d,e,f)
            end
        end

        --its tick'n time
        for v,o in ipairs(ticks) do
            o(dt)
        end

        --end draw
        if love.graphics and love.graphics.isActive() then
            love.graphics.present()
        end

        --limit tps
        if love.timer then love.timer.sleep(0.001) end
    end
end

setmetatable(love,{
    ["__newindex"] = function(t,v,o)
        error("tried to edit love!")
    end
})