local all = nil
return {function (dt,_all)
    all = _all

    local text = "Enter your bill name:"
    local eybnS = {string.size(text)}

    love.graphics.print(text,love.width/2 - eybnS[1]/2,love.height/2 - eybnS[2])
    love.textbox.x = love.width*.05
    love.textbox.y = love.height/2
    love.textbox.width = love.width*.9
    love.textbox.center = true
    love.textbox.isOn = true
    
    love.textbox.draw()
end,function (key,down)
    if down and key == "return" and love.textbox.text ~= "" then
        all.billName = love.textbox.text
        love.textbox.isOn = false
        return "partyselect"
    end
end}