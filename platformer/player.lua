--player module

player = {}

function player.load()
	player.x = 50
	player.y = 50 
	player.width = 8
	player.height = 20
	player.head_h = 8
	player.color = { 107, 142, 35 }
	player.head_color = { 210, 180, 140 }
	player.y_velocity = 0
	player.x_velocity = 0
	player.friction = 10
	player.speed = 5000
	player.jump_height = 10000
end

function player.draw()
	love.graphics.setColor(player.color)
	love.graphics.rectangle( 'fill', player.x, player.y, player.width, player.height )
	love.graphics.setColor(player.head_color)
	love.graphics.rectangle( 'fill', player.x, player.y, player.width, player.height/3  )

end

function player.physics(dt)
	PLAYER_ON_GROUND = localCheckCollision()
	player.x = player.x + player.x_velocity * dt
	player.y = player.y + player.y_velocity * dt
	player.x_velocity = player.x_velocity * (1 - math.min(player.friction * dt, 1))
	player.y_velocity = player.y_velocity + gravity * dt
	if PLAYER_ON_GROUND then
		-- player.y = level.y - player.height
		player.y = PLAYER_ON_GROUND.y - player.height
		player.y_velocity = 0
	end
	
end

function localCheckCollision()
	for i, block in ipairs(level) do 
		if CheckCollision(player.x, player.y, player.width, 
				player.height, block.x, block.y, block.width, block.height) then
				if player.y - player.height < block.y then 
					return block
				end
		end
	end

end

-- Collision detection function.
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end


function player.move(dt)
	
	if love.keyboard.isDown('right') and player.x_velocity < player.speed then
		if PLAYER_ON_GROUND then
			player.x_velocity = player.x_velocity + player.speed * dt
		else
			player.x_velocity = player.x_velocity + 0.1 * player.speed * dt
		end
	end
	
	if love.keyboard.isDown('left') and player.x_velocity > -player.speed then
		if PLAYER_ON_GROUND then
			player.x_velocity = player.x_velocity - player.speed * dt
		else
			player.x_velocity = player.x_velocity - 0.1 * player.speed * dt
		end
	end

	if love.keyboard.isDown('space', ' ') and PLAYER_ON_GROUND then
		player.y_velocity = player.y_velocity - player.jump_height * dt
	end
end

function UPDATE_PLAYER(dt)
	player.physics(dt)
	player.move(dt)

end


function DRAW_PLAYER()
	player.draw()

end