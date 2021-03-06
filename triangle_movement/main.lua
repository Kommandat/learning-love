-- Load some default values for our rectangle.
function love.load()

    -- set 1 m to 64 px
    love.physics.setMeter(64) 
    -- create world with vertical gravity of 0
    gravity = 0
    world = love.physics.newWorld(0, gravity*64, true) 

    objects = {} -- table to hold all our physical objects
 
    windowWidth  = 650
    windowHeight = 650
    border = 25
    sideLength = 100

    ---------------------------------------
    -- CREATING THE BORDER
    -- First ground and ceiling
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, windowWidth/2, windowHeight-border/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    objects.ground.shape = love.physics.newRectangleShape(windowWidth, border) --make a rectangle with a width of 650 and a height of 25
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) --attach shape to body
    
    objects.ceiling = {}
    objects.ceiling.body = love.physics.newBody(world, windowWidth/2, border/2)
    objects.ceiling.shape = love.physics.newRectangleShape(windowWidth, border) --make a rectangle with a width of 650 and a height of 25
    objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape) --attach shape to body    

    -- Next both walls
    objects.leftwall = {}
    objects.leftwall.body = love.physics.newBody(world, border/2, windowHeight/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    objects.leftwall.shape = love.physics.newRectangleShape(border, windowHeight - 2*border) --make a rectangle with a width of 650 and a height of 25
    objects.leftwall.fixture = love.physics.newFixture(objects.leftwall.body, objects.leftwall.shape) --attach shape to body
    
    objects.rightwall = {}
    objects.rightwall.body = love.physics.newBody(world, windowWidth-border/2, windowHeight/2)
    objects.rightwall.shape = love.physics.newRectangleShape(border, windowHeight - 2*border) --make a rectangle with a width of 650 and a height of 25
    objects.rightwall.fixture = love.physics.newFixture(objects.rightwall.body, objects.rightwall.shape) --attach shape to body
 
    ---------------------------------------

    -- Let's create the player
    objects.player = {}
    objects.player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
    -- Set vertices 
    centroidLength = sideLength/(3^(1/2))
    objects.player.shape  = love.physics.newPolygonShape(0, centroidLength, -sideLength/2, -centroidLength/2, sideLength/2, -centroidLength/2) --the ball's shape has a radius of 20
    objects.player.shape2 = love.physics.newPolygonShape(0, centroidLength, 100, 100, sideLength/2, -centroidLength/2) --the ball's shape has a radius of 20
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 1) -- Attach fixture to body and give it a density of 1.
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape2, 1) -- Attach fixture to body and give it a density of 1.
    objects.player.fixture:setRestitution(0.9) --let the ball bounce

    -- Let's create a couple blocks to play around with
    objects.block1 = {}
    objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
    objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
    objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

    objects.block2 = {}
    objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
    objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
    objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
    
    --initial graphics setup
    love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
    love.window.setMode(650, 650) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.update(dt)
  world:update(dt) --this puts the world into motion
 
  --here we are going to create some keyboard events
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
    objects.player.body:applyTorque(400, 0)
  elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
    objects.player.body:applyTorque(-400, 0)
  elseif love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
    objects.player.body:applyForce(0, -400)
  elseif love.keyboard.isDown("down") then 
    objects.player.body:applyForce(0, 400)
  elseif love.keyboard.isDown("r") then
    objects.player.body:setPosition(650/2, 650/2)
    objects.player.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
    objects.player.body:setAngularVelocity(0)
  end
end
 
function love.draw()
    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinat

    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinat

    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", objects.rightwall.body:getWorldPoints(objects.rightwall.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinat

    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", objects.leftwall.body:getWorldPoints(objects.leftwall.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinat

    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.polygon("fill", objects.player.body:getWorldPoints(objects.player.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinat

    love.graphics.setColor(0, 47, 14) --set the drawing color to red for the ball
    love.graphics.polygon("fill", objects.player.body:getWorldPoints(objects.player.shape2:getPoints())) -- draw a "filled in" polygon using the ground's coordinat

    love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
    love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
    love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
end
