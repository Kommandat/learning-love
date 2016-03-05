function love.load()
    local size = 25;
    local x, y = 0, 0;
    
    world = love.physics.newWorld(0, 0*64, true)
    body = love.physics.newBody(world, 350, 250, "dynamic");

    for i=0, 2, 1 do
        local shape = love.physics.newRectangleShape(x, y, size, size, 0);
        local fixture = love.physics.newFixture(body, shape, 1);
    
        x = x + size;
    end
end

function love.draw()
    local fixtures = body:getFixtureList();
    
    for idx, fixture in pairs(fixtures) do
        local shape = fixture:getShape();
        
        local x, y = body:getWorldPoints(shape:getPoints());
        
        love.graphics.setColor(255, 0, 0, 255);
        love.graphics.rectangle("line", x, x, 25, 25);
        
        love.graphics.setColor(255, 0, 0, 50);
        love.graphics.rectangle("fill", y, y, 25, 25);
    end    
end

function love.update(dt)
    body:applyTorque(100);
end