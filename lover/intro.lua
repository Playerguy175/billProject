local tim = 0

local intI = love.graphics.newImage("lover/nickco.png")
love.timer.step()
local dt = 0

local sound = love.audio.newSource("lover/whoosh.mp3","static")
-- Main loop time.
return function()
	-- time shit
	if love.timer then dt = love.timer.step() end

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

	local w,h = love.graphics.getWidth(),love.graphics.getHeight()
	local scale = math.min(w,h)/200

	--draw intro
	tim = tim + dt

	if sound and tim > 1.2 then
		sound:play()
		sound = nil
	end

	if tim < 2 then
		love.graphics.setColor(1,1,1,tim-1)
	elseif tim < 4 then
		love.graphics.setColor(1,1,1,4-tim)
	end
	love.graphics.draw(intI,w/2,h/2,0,scale,scale,64,64)
	

	--end draw
	if love.graphics and love.graphics.isActive() then
		love.graphics.present()
	end

	--limit tps
	if love.timer then love.timer.sleep(0.001) end

	if tim > 4.5 then
		return true
	end
	return false
end