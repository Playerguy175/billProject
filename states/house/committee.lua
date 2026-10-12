local all

local b1,b2,b3 = love.graphics.newImage("ball1.png"),love.graphics.newImage("ball2.png"),love.graphics.newImage("ball3.png")

local aud
local tim = 0
local deg = 1.57
local tar = nil
local speed = 1

return {function (dt,_all)
    all = _all
    tim = tim + dt

    if aud == nil then
        aud = {}
        local nR = math.floor(all.houseRep/10+.5)
        for i = 1,nR do
            if all.party == "Democrat" then
                aud[i] = {false,love.math.random(15,50),love.math.random(90,100)/100,love.math.random(0,20)/100,love.math.random(0,20)/100,love.math.random(0,100)/100}
            else
                aud[i] = {true,love.math.random(50,85),love.math.random(90,100)/100,love.math.random(0,20)/100,love.math.random(0,20)/100,love.math.random(0,100)/100}
            end
        end
        for i = nR+1,10 do
            if all.party == "Republican" then
                aud[i] = {false,love.math.random(15,50),love.math.random(0,20)/100,love.math.random(0,20)/100,love.math.random(90,100)/100,love.math.random(0,100)/100}
            else
                aud[i] = {true,love.math.random(50,85),love.math.random(0,20)/100,love.math.random(0,20)/100,love.math.random(90,100)/100,love.math.random(0,100)/100}
            end
        end
    end

    if tim < 5 then
        if tim < 2 then
            love.graphics.setColor(1,1,1,tim-.5)
        else
            love.graphics.setColor(1,1,1,4-tim)
        end
        love.graphics.printCentered("Convince the Counsil!",love.width/2,love.height/2,2,2)
    elseif tim < 90 then
        deg = (deg + dt*speed)%(math.pi*2)

        if tar == nil then
            tar = love.math.random(28,600)/100
        end

        local dis = love.width*5/36
        love.graphics.circle("line",love.width/2,love.height/2,love.width/9)
        love.graphics.circle("line",love.width/2,love.height/2,love.width/6)
        love.graphics.arc("fill",love.width/2,love.height/2,love.width/80,-1.57,-1.57+2*math.pi*(1-(tim-5)/85),100)

        love.graphics.circle("line",love.width/2+dis*math.cos(deg),love.height/2-dis*math.sin(deg),love.width/80)
        if math.abs(tar-deg) < .20 then
            love.graphics.setColor(1,1,0)
        end
        love.graphics.circle("fill",love.width/2+dis*math.cos(tar),love.height/2-dis*math.sin(tar),love.width/80)
    elseif tim < 93 then
        love.graphics.setColor(1,1,1,tim-91)
        local amt = 0
        for v,o in pairs(aud) do
            if o[2] > 50 then
                amt = amt + 1
            end
        end
        love.graphics.printCentered(amt.."/10 "..(amt >= 5 and ":)" or ":("),love.width/2,love.height/2,2,2)
    else
        local amt = 0
        for v,o in pairs(aud) do
            if o[2] >= 50 then
                amt = amt + 1
            end
        end
        if amt >= 5 then
            return "house/start"
        else
            return "mainmenu"
        end
        
    end

    for v,o in pairs(aud) do
        if tim > 5 and tim < 90 then
            o[2] = o[2] / 1.03^dt
        end
        o[6] = (o[6] + dt)%1
        love.graphics.setColor(o[3],o[4],o[5])

        local cen = {love.width/2,love.height/1.8}
        local dis = love.width/4
        cen = {cen[1]+dis*math.cos(v*math.pi/7-.9),cen[2]-dis*math.sin(v*math.pi/7-.9)}

        local sx = -1
        if v > 5 then
            sx = 1
        end

        if o[2] < 33 then
            love.graphics.draw(b3,cen[1],cen[2],.4*math.sin(2*math.pi*o[6]),sx*love.width/800,love.width/800,16,16)
        elseif o[2] < 67 then
            love.graphics.draw(b2,cen[1],cen[2],0,sx*love.width/800,love.width/800,16,16)
        else
            love.graphics.draw(b1,cen[1],cen[2]+ love.width*o[6]*(o[6]-1)/20 ,0,sx*love.width/800,love.width/800,16,16)
        end
    end
end,function (key,down)
    if down and tim > 5 and tim < 90 and (key == "space" or key == "return") then
        speed = -speed
        if math.abs(tar-deg) < .20 then
            speed = speed + math.sign(speed)*.1
            for v,o in pairs(aud) do
                if o[1] then
                    o[2] = o[2] + love.math.random(4,6)
                else
                    o[2] = o[2] + love.math.random(1,3)
                end
            end
        else
            speed = math.sign(speed)
            for v,o in pairs(aud) do
                if o[1] then
                    o[2] = o[2] - love.math.random(7,9)
                else
                    o[2] = o[2] - love.math.random(10,12)
                end
            end
        end
        tar = nil
    end
end}