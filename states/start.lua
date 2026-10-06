local x = 0

local newTree
newTree = function (title,_par)
    local o = {}

    local ch = {}
    local Fu = {}

    Fu.add = function (title)
        local c = newTree(title,o)
        ch[#ch+1] = c
        return c
    end

    Fu.pairs = function ()
        return pairs(ch)
    end

    Fu.len = function ()
        return #ch
    end

    Fu.get = function (i)
        return ch[i]
    end

    return setmetatable(o,{
        ["__index"] = function(t,v)
            local fu = Fu[v]
            if fu then
                return fu
            end
            return ch[v]
        end,
        ["__tostring"] = function(t)
            return "T:"..title
        end
    })
end

local i = 1

local root = newTree("Choose your party!")
root.add("Democrat")
root.add("Republican")

return {function (dt)
    love.graphics.setColor(1,1,1)
    love.graphics.print("[name]",10,10,0,1.5,1.5)
    for v,o in pairs(op) do
        if v == i then
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(0.5,0.5,0.5)
        end
        love.graphics.print(o[1],10,60+v*30)
    end
end,function (key,down)
    if down then
        if key == "down" or key == "s" then
            i = i%root.len()+1
        elseif key == "up" or key == "w" then
            i = (i-2)%root.len()+1
        elseif key == "space" or key == "return" then
            root = root.get(i)
        end
    end
end}