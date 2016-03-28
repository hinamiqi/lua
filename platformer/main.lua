--main file
require "player"
require "level"

function love.load()

	love.graphics.setBackgroundColor(176, 224, 230 )
	gravity = 300
	--loading classes
	level.load()
	player.load()
	
end



function love.update(dt)
	UPDATE_PLAYER(dt)
	Controls(dt)

end


function love.draw()
	DRAW_PLAYER()
	DRAW_LEVEL()
end

function Controls(dt)
	
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('r') then
		player.load()
	end
end
