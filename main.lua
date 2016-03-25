--testing Love!

function love.load()
  MyGlobalTable = { 
    { 'Stuff inside a sub-table', 'More stuff inside a sub-table' },
    { 'Stuff inside the second sub-table', 'Even more stuff' }
  }
end

function love.draw()
  for i=1,#MyGlobalTable do
    local subtable = MyGlobalTable[i]
    for j=1,#subtable do   -- nested loop!
      love.graphics.print(subtable[j], 100 * i, 50 * j)
    end
  end
end