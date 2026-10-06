local x = 0

return {function ()
    love.graphics.print("Hi! "..x)
end,function (key,down)
    if down and key == "space" then
        x = x + 1
    end
end}