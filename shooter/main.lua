--Main file

debug = true

--Player
player = { 
			x = 200, 
			y = 710, 
			speed = 150, 
			img = nil 
		}

isAlive = true
score = 0

--Timers
canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

createBulletTimerMax = 0.1
createBulletTimer = createBulletTimerMax

--Image storage
bulletImg = nil
--enemyImg = nil
enemyImgs = {}
enemyBullets = {}

--Entity storage
bullets = {} 
enemies = {}
obstacles = {}

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function CheckCollisionCircle(x1,y1,r1,x2,y2,r2)
	return 
end

function love.load(arg)
	player.img = love.graphics.newImage('assets/plane.png')
	bulletImg = love.graphics.newImage('assets/bullet.png')
	--enemyImg = love.graphics.newImage('assets/enemy.png')
	for i = 0,8 do
		enemySkin = love.graphics.newImage('assets/Enemy_0'..i..'.png')
		table.insert(enemyImgs, enemySkin)
	end
	
	for i = 1,15 do
		enemyBullet = love.graphics.newImage('assets/bullet_'..i..'.png')
		table.insert(enemyBullets, enemyBullet)
	end
	
end

function love.draw(dt)
	
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	
	for i, obst in ipairs(obstacles) do
		love.graphics.draw(obst.img, obst.x, obst.y)
	end
	
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
	
	if isAlive then
		W = player.img:getWidth()
		H = player.img:getHeight()
		love.graphics.draw(player.img, player.x, player.y)
		love.graphics.rectangle( 'line', player.x+W/3, player.y+H/3, W/3, H/3 )
	else
		love.graphics.print("Press 'R' to restart", 
		love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
	end
	
	love.graphics.print("Score: "..score, 0, 0)
end

function love.update(dt)
	--Timings
	canShootTimer = canShootTimer - (1*dt)
	createEnemyTimer = createEnemyTimer - (1 * dt)
	createBulletTimer = createBulletTimer - (1 * dt)
	
	if canShootTimer < 0 then
		canShoot = true
	end
	
	--Moving
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax
		--create the guy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)
		enemySkin = math.random(1,9)
		newEnemy = { x = randomNumber, y = -10, img = enemyImgs[enemySkin] }
		table.insert(enemies, newEnemy)
	end
	
	if createBulletTimer < 0 then
		createBulletTimer = createBulletTimerMax
		--create the guy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)
		bulletSkin = math.random(1,15)
		newEnemyBullet = {x = randomNumber, y = -10, img = enemyBullets[bulletSkin]}
		table.insert(obstacles, newEnemyBullet)
	end
	
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)
		if bullet.y < 0 then
			table.remove(bullets, i)
		end
	end
	
	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y +(200 * dt)
		
		if enemy.y > 850 then 
			table.remove(enemies, i)
		end
	
	end

	--Controls

	if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then
		--create bullets
		newBullet = {x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
	end
	
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	
	if love.keyboard.isDown('left','a') then
		if player.x > 0 then
			player.x = player.x - (player.speed*dt)
		end
	elseif love.keyboard.isDown('right','d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed*dt)
		end
	end
	
	--Game over
	if not isAlive and love.keyboard.isDown('r') then
		--remove everything
		bullets = {}
		enemies = {}
		
		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax
		
		player.x = 50
		player.y = 710
		
		score = 0
		isAlive = true
	end
	
	--Collisions
	for i, enemy in ipairs(enemies) do
		
		for a, obst in ipairs(obstacles) do
		
			for j, bullet in ipairs(bullets) do
				if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), 
				enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), 
				bullet.img:getHeight()) then
					table.remove(bullets, j)
					table.remove(enemies, i)
					score = score + 1
				end
			end
			
			
			W = player.img:getWidth()
			H = player.img:getHeight()
			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), 
			enemy.img:getHeight(), player.x+W/3, player.y+H/3, W/3, H/3) and isAlive then
				table.remove(enemies, i)
				isAlive = false
			end
			
			if CheckCollision(obst.x, obst.y, obst.img:getWidth(), 
			obst.img:getHeight(), player.x+W/3, player.y+H/3, W/3, H/3) and isAlive then
				table.remove(obstacles, a)
				isAlive = false
			end
		end
	end


end