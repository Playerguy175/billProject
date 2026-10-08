local i = 1

local msg = {}
local key = {}

msg[1] = "Bill Name: "
key[1] = "billName"



local all = nil
return {function (dt,_all)
    all = _all

    local he = string.height(msg[i])

    love.graphics.setColor(1,1,1)
    love.textbox.isOn = true

    local of = string.width("Bill Name: ")
    love.textbox.x = of
    love.textbox.y = he + 30
    love.textbox.width = love.width-of

    love.graphics.print(all.."\nBill Name: ",10,10)
    love.textbox.draw()
end,function (key,down)
    if down then
        if key == "return" then
            all[key[i]] = love.textbox.text
            love.textbox.text = ""
            i = i + 1
        end
    end
end}