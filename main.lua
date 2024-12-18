---@diagnostic disable: lowercase-global

function moveFood()
	local possibleFoodPositions = {}
	for foodX = 1, gridXCount do
		for foodY = 1, gridYCount do
			local possible = true

			for segmentIndex, segment in ipairs(snakeSegments) do
				if foodX == segment.x and foodY == segment.y then
					possible = false
				end
			end

			if possible then
				table.insert(possibleFoodPositions, { x = foodX, y = foodY })
			end
		end
	end

	foodPosition = possibleFoodPositions[love.math.random(#possibleFoodPositions)]
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
	directionQueue = { "right" }

	gridXCount = 20
	gridYCount = 15
	moveFood()
end

function love.draw()
	local cellSize = 15

	local function drawCell(x, y)
		love.graphics.rectangle("fill", (x - 1) * cellSize, (y - 1) * cellSize, cellSize - 1, cellSize - 1)
	end

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, gridXCount * cellSize, gridYCount * cellSize)

	for segmentIndex, segment in ipairs(snakeSegments) do
		love.graphics.setColor(0.6, 1, 0.32)
		drawCell(segment.x, segment.y)
	end

	love.graphics.setColor(1, 0.3, 0.3)
	drawCell(foodPosition.x, foodPosition.y)
end

function love.update(dt)
	timer = timer + dt
	if timer >= 0.15 then
		timer = timer - 0.15

		-- read from direction queue
		if #directionQueue > 1 then
			table.remove(directionQueue, 1) -- pop earliest dir pressed
		end

		-- calculate new head pos
		local nextXPosition = snakeSegments[1].x
		local nextYPosition = snakeSegments[1].y
		if directionQueue[1] == "up" then
			nextYPosition = nextYPosition - 1
		elseif directionQueue[1] == "down" then
			nextYPosition = nextYPosition + 1
		elseif directionQueue[1] == "left" then
			nextXPosition = nextXPosition - 1
		elseif directionQueue[1] == "right" then
			nextXPosition = nextXPosition + 1
		end

		-- determine game over
		local canMove = true
		for segmentIndex, segment in ipairs(snakeSegments) do
			if segmentIndex ~= #snakeSegments and nextXPosition == segment.x and nextYPosition == segment.y then
				canMove = false
			end
		end

		-- move the snake or restart
		if canMove then
			table.insert(snakeSegments, 1, {
				x = nextXPosition,
				y = nextYPosition,
			}) -- enqueue (first element)
		else
			love.load()
		end

		-- eat the food
		if snakeSegments[1].x == foodPosition.x and snakeSegments[1].y == foodPosition.y then
			moveFood()
		else
			table.remove(snakeSegments) -- dequeue (last element)
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

	lastAddedDir = directionQueue[#directionQueue]
	if (key == "up" or key == "w") and lastAddedDir ~= "up" and lastAddedDir ~= "down" then
		table.insert(directionQueue, "up")
	elseif (key == "down" or key == "s") and lastAddedDir ~= "down" and lastAddedDir ~= "up" then
		table.insert(directionQueue, "down")
	elseif (key == "left" or key == "a") and lastAddedDir ~= "left" and lastAddedDir ~= "right" then
		table.insert(directionQueue, "left")
	elseif (key == "right" or key == "d") and lastAddedDir ~= "right" and lastAddedDir ~= "left" then
		table.insert(directionQueue, "right")
	end
end
