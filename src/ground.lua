Ground = {}
Ground.__index = Ground

local push = require("vendor.push")

local paused = false

function Ground:new(x, y, imagePath)
    local obj = {
        x = x,
        y = y,
        sprite = love.graphics.newImage(imagePath),
        speed = 25,
    }

    setmetatable(obj, Ground)
    return obj
end

function Ground:draw()
    local screenWidth = push:getWidth()
    local imgWidth = self.sprite:getWidth()

    for i = 0, math.ceil(screenWidth / imgWidth) + 1 do
        love.graphics.draw(self.sprite, self.x + i * imgWidth, self.y)
    end
end

function Ground:update(dt)
    local imgWidth = self.sprite:getWidth()
    if not paused then
        self.x = self.x - self.speed * dt
    end

    if self.x <= -imgWidth then
        self.x = self.x + imgWidth
    end
end

function Ground:toggle()
    paused = not paused
end

return Ground