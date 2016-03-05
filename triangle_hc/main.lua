HC = require 'HC'

-- array to hold collision messages
local text = {}

function love.load()

	windowWidth  = 650
    windowHeight = 650
    cx = windowWidth/2
    cy = windowHeight/2
    sideLength = 100

    -- add our player to the scene
    centroidLength = sideLength/(3^(1/2))
    player = HC.polygon(cx, cy+centroidLength, cx-sideLength/2, cy-centroidLength/2, cx+sideLength/2, cy-centroidLength/2)
    player:moveTo(love.mouse.getPosition())

    -- add our "enemy"
    sideLength = 50
    cx = cx - 200
    cy = cy - 200
    centroidLength = sideLength/(3^(1/2))
    enemy = HC.polygon(cx, cy+centroidLength, cx-sideLength/2, cy-centroidLength/2, cx+sideLength/2, cy-centroidLength/2)

    --initial graphics setup
    love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
    love.window.setMode(windowWidth, windowHeight) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.update()
    -- move player to mouse position
    player:moveTo(love.mouse.getPosition())

    -- check for collisions
    for shape, delta in pairs(HC.collisions(player)) do
        text[#text+1] = string.format("Colliding. Separating vector = (%s,%s)",
                                      delta.x, delta.y)
        HC.remove(shape)
    end

    while #text > 40 do
        table.remove(text, 1)
    end
end

function love.draw()
    -- print messages
    for i = 1,#text do
        love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end

    -- shapes can be drawn to the screen
    love.graphics.setColor(255,255,255)
    player:draw('fill')
    love.graphics.setColor(255,0,0)
    enemy:draw('fill')
end