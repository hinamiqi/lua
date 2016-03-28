--main file

--const

grav_const = 100
friction = 0.8
jump_height = 100
start_pos_x = 150
start_pos_y = 0
PLAYER_ON_GROUND = false
txt = ''
move_speed = 100

forces = {}

jump = false
--ground
Ground = { 
			x = 100, 
			y = 300, 
			width = 200,
			height = 50,
			color = { 184, 134, 11 }
		}

--player
Player = { 
			x = start_pos_x, 
			y = start_pos_y, 
			width = 8,
			height = 20,
			head_h = 8,
			color = { 107, 142, 35 },
			head_color = { 210, 180, 140 },
			y_velocity = 0,
			x_velocity = {0, 0}
		}

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

function Controls(dt)
	
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	
	if love.keyboard.isDown('left') then
		if PLAYER_ON_GROUND then
			Player.x_velocity[1] = -1
			Player.x_velocity[2] = 100

		else
			--Player.x_velocity = -4
		end
	end

	if love.keyboard.isDown('right') then
		if PLAYER_ON_GROUND then
			Player.x_velocity[1] = 1
			Player.x_velocity[2] = 100

		else
			--Player.x_velocity = 4
		end
	end
	
	if love.keyboard.isDown('space', ' ') and PLAYER_ON_GROUND then
		Player.y_velocity = -100
		jump = true
	end
	
	if love.keyboard.isDown('r') then
		Player.x = start_pos_x
		Player.y = start_pos_y
		Player.x_velocity = 0
		Player.y_velocity = 0
	end
end

function love.load(arg)
	--world
	
end

function Moving(dt)
	Player.x = Player.x + Player.x_velocity[1] * Player.x_velocity[2] * dt
	Player.y = Player.y + Player.y_velocity * dt
	if Player.x_velocity[2] > 0 then
		Player.x_velocity[2] = Player.x_velocity[2] - 1
	end
	-- if Player.y_velocity[2] > 0 then
		-- Player.y_velocity[2] = Player.y_velocity[2] - 10
	-- end
	-- if Player.y_velocity[2] < 0 then 
		-- Player.y_velocity = {0, 0} 
	-- end
	if Player.x_velocity[2] < 0 then 
		Player.x_velocity = {0, 0} 
	end
	-- if PLAYER_ON_GROUND then
		-- Player.y_velocity = {0, 0}
	

end

function love.update(dt)
	PLAYER_ON_GROUND = CheckCollision(Player.x, Player.y, Player.width, 
	Player.height, Ground.x, Ground.y, Ground.width, Ground.height)
	
	Controls(dt)
	Moving(dt)
	if not PLAYER_ON_GROUND then
		Player.y_velocity = 100
	else
		Player.y_velocity = 0
	end
	-- Jumping(dt)
	--keyboard events
	--text = ""
end

function love.draw(dt)
	
	love.graphics.setBackgroundColor( 176, 224, 230 )
	--ground
	love.graphics.setColor(Ground.color)
	love.graphics.rectangle( 'fill', Ground.x, Ground.y, Ground.width, Ground.height)
	
	
	--player
	love.graphics.setColor(Player.color)
	love.graphics.rectangle( 'fill', Player.x, Player.y, Player.width, Player.height )
	love.graphics.setColor(Player.head_color)
	love.graphics.rectangle( 'fill', Player.x, Player.y, Player.width, Player.height/3  )
	
	-- love.graphics.print('X_velocity: '..Player.x_velocity, 20, 20)
	-- love.graphics.print('Y_velocity: '..Player.y_velocity, 20, 30)

	
end

