local i = 0

return {function (dt,all)
    love.graphics.setColor(1,1,1)
    love.textbox.isOn = true

    local of = string.width("Bill Name: ")
    love.textbox.x = of
    love.textbox.y = 0
    love.textbox.width = love.width-of

    love.graphics.print("Bill Name: ")
    love.textbox.draw()
end,function (key,down)
    
end}