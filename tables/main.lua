-- Load some default values for our rectangle.
function love.load()
	-- load our background (something is better than nothing!)
	bg = love.graphics.newImage("bg.png")



    -- create the triangle we control
    base = 80
    hght = 80

    -- Draw the player
    player = {} -- new table for player
    
    -- Add the three points that make the player
    point = {x=300, y=300}
    table.insert(player, point)

    point = {x=player[1].x + base, y=player[1].y}
    table.insert(player, point)

    point = {x=player[1].x + base/2, y=player[1].y + hght}
    table.insert(player, point)

    -- Draw the enemy1
    enemy1 = {} -- new table for enemy1
    
    -- Add the three points that make enemy1
    point = {x=100, y=100}
    table.insert(enemy1, point)

    point = {x=enemy1[1].x + 40, y=enemy1[1].y}
    table.insert(enemy1, point)

    point = {x=enemy1[1].x + 40/2, y=enemy1[1].y + 40}
    table.insert(enemy1, point)

end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    base = base + 1
    hght = hght + 1
end
 
-- Draw a coloured triangle.
function love.draw()
	love.graphics.setColor(255,255,0,255)
	drawPointSet(player)
	love.graphics.setColor(0,255,255,255)
	drawPointSet(enemy1)
end

function drawPointSet(pointSet)
	local vertices = {}
    for i,v in ipairs(pointSet) do
    	table.insert(vertices, pointSet[i].x)
    	table.insert(vertices, pointSet[i].y)
    end
    
    love.graphics.polygon('fill', vertices)
end