---@diagnostic disable: lowercase-global
function love.draw()
    local gridXCount = 20
    local gridYCount = 15
    local cellSize = 15

    love.graphics.setColor(0.28, 0.28, 0.28)
    love.graphics.rectangle("fill", 0, 0, gridXCount * cellSize, gridYCount * cellSize)

    for segmentIndex, segment in ipairs(snakeSegments) do
        love.graphics.setColor(0.6, 1, 0.32)
        love.graphics.rectangle(
            "fill",
            (segment.x - 1) * cellSize,
            (segment.y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
        )
    end
end

function love.load()
    -- global
    timer = 0
    snakeSegments = {
        { x = 3, y = 1 },
        { x = 2, y = 1 },
        { x = 1, y = 1 },
    }
    -- 'up', 'down', 'left', or 'right'
    directionQueue = { 'right' }
end

function love.update(dt)
    timer = timer + dt
    if timer >= 0.15 then
        timer = timer - 0.15

        if #directionQueue > 1 then
            table.remove(directionQueue, 1) -- pop earliest dir pressed
        end

        local nextXPosition = snakeSegments[1].x
        local nextYPosition = snakeSegments[1].y

        if directionQueue[1] == 'up' then
            nextYPosition = nextYPosition - 1
        elseif directionQueue[1] == 'down' then
            nextYPosition = nextYPosition + 1
        elseif directionQueue[1] == 'left' then
            nextXPosition = nextXPosition - 1
        elseif directionQueue[1] == 'right' then
            nextXPosition = nextXPosition + 1
        end

        table.insert(snakeSegments, 1, {
            x = nextXPosition, y = nextYPosition
        })                          -- enqueue (first element)
        table.remove(snakeSegments) -- dequeue (last element)
    end
end

function love.keypressed(key)
    lastAddedDir = directionQueue[#directionQueue]
    if (key == 'up' or key == 'w') and lastAddedDir ~= 'down' then
        table.insert(directionQueue, 'up')
    elseif (key == 'down' or key == 's') and lastAddedDir ~= 'up' then
        table.insert(directionQueue, 'down')
    elseif (key == 'left' or key == 'a') and lastAddedDir ~= 'right' then
        table.insert(directionQueue, 'left')
    elseif (key == 'right' or key == 'd') and lastAddedDir ~= 'left' then
        table.insert(directionQueue, 'right')
    end
end
