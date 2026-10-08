local t = 0
love.timer.getTime()

local year = os.date("%Y")+love.math.random(4,24)
local houseRep = love.math.random(10,90)
local senateRep = love.math.random(10,90)
local president = love.math.random(0,1)==1 and "Republican" or "Democrat"

local txt = [[
The year is ]]..year..[[.|||||||||||||||||| The country is in shambles.||||||||||||||||||
You have an idea for a bill to change the world.||||||||||||||||||

The current president is a ]]..president..[[.||||||||||||||||||
The House is ]]..(houseRep > 50 and houseRep.."% Republican" or (100-houseRep).."% Democrat")..[[.||||||||||||||||||
The Senate is ]]..(senateRep > 50 and senateRep.."% Republican" or (100-senateRep).."% Democrat")..[[.||||||||||||||||||

Good luck.||||||||||||||||||
]]

local lastLen = 0
return {function (dt,all)
    all.year = year
    all.houseRep = houseRep
    all.senateRep = senateRep
    all.president = president
    all.text = txt

    t = t + dt
    love.graphics.setColor(1,1,1)
    local cur = string.gsub(string.sub(txt,1,math.floor(t*24)),"|","")
    if #cur > lastLen then
        love.beep()
        lastLen = #cur
    end
    love.graphics.print(cur,10,10)
    if t > #txt/24 then
        return "billcreation"
    end
end,function (key,down)
    if down then
        if key == "escape" then
            return "mainmenu"
        elseif key == "return" then
            t = t + 3
        end
    end
end}