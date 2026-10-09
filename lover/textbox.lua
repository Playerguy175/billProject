local box = require("lover.InputField")()
local canv = love.graphics.newCanvas()
local function updateSize()
    local wid,hei = love.textbox.width,love.textbox.height
    canv = love.graphics.newCanvas(wid,hei)
    box:setWidth(wid)
    local font = love.graphics.newFont("lover/SpaceMono-Regular.ttf",hei*.6)
    love.mainFont = font
    box:setFont(font)
    love.graphics.setFont(font)
end

local t = {
    ["isOn"] = {false,function (new) end},
    ["width"] = {400,function (new)
        updateSize()
    end},
    ["height"] = {love.height/48,function (new)
        error("no lol")
    end},
    ["x"] = {200,function (new) end},
    ["y"] = {250,function (new) end},
    ["draw"] = {function ()
        local cx,cy,cw,ch = love.textbox.x,love.textbox.y,love.textbox.width,love.textbox.height
        love.graphics.stencil(function ()
            love.graphics.rectangle("fill",cx,cy,cw,ch)
        end)
        love.graphics.setStencilTest("greater",0)
        for _, x, y, w, h in box:eachSelection() do
            love.graphics.rectangle("fill", x+cx, y+cy, w, h)
        end
        for _, text, x, y in box:eachVisibleLine() do
            love.graphics.print(text, x+cx, y+cy)
        end
        local x, y, h = box:getCursorLayout()
        love.graphics.rectangle("fill", x+cx, y+cy, 1, h)
        love.graphics.setStencilTest()
    end,function (new)
        error("dont do that >:(")
    end},
    ["text"] = {"",function (new)
        box:setText(new)
    end,function ()
        return box.text
    end},
    ["center"] = {false,function (new)
        if new then
            box:setAlignment("center")
        else
            box:setAlignment("left")
        end
    end,function ()
        return box.alignment=="center"
    end}
}
love.textbox = setmetatable({},{
    ["__index"] = function(_,v)
        local d = rawget(t,v)
        assert(type(d)=="table",tostring(v).." -> "..tostring(d))
        if d then
            if d[3] then
                return d[3]()
            end
            return d[1]
        end
    end,
    ["__newindex"] = function(_,v,o)
        local d = rawget(t,v)
        if d then
            assert(type(d[1])==type(o),"Tried to set '"..v.."' to '"..tostring(o).."', needs to be type '"..type(d[1]).."'!")
            d[1] = o
            d[2](o)
        end
    end
})
updateSize()

love.keyboard.setKeyRepeat(true)

love.key(function (key,down,isRepeat)
    if love.textbox.isOn and down then
        box:keypressed(key, isRepeat)
    end
end)
love.typed(function (txt)
    if love.textbox.isOn then
        box:textinput(txt)
    end
end)
love.mouse(function (type,x,y,b,amt)
    if love.textbox.isOn then
        if type == "down" then
            box:mousepressed(x-love.textbox.x,y-love.textbox.y,b,amt)
        elseif type == "move" then
            box:mousemoved(x-love.textbox.x,y-love.textbox.y)
        elseif type == "up" then
            box:mousereleased(x-love.textbox.x,y-love.textbox.y,b)
        end
    end
end)