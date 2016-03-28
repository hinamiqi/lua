-- level module

level = {}


function level.load()

	
	-- level.x = 0
	-- level.y = 300 
	-- level.width = 300
	-- level.height = 50
	-- level.color = { 184, 134, 11 }
	block1 = {}
	block2 = {}
	
	block1.x = 0
	block1.y = 300
	block1.width = 300
	block1.height = 50
	block1.color = { 184, 134, 11 }
	table.insert(level, block1)
	block2.x = 250
	block2.y = 200
	block2.width = 300
	block2.height = 50
	block2.color = { 184, 134, 11 }
	table.insert(level, block2)

end

function level.draw()
	for i, block in ipairs(level) do 
		love.graphics.setColor(block.color)
		love.graphics.rectangle( 'fill', block.x, block.y, block.width, block.height )
		love.graphics.print("yay!", 20, 20*i)
	end

end

function UPDATE_LEVEL(dt)


end


function DRAW_LEVEL()
	level.draw()

end