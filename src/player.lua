Player = {}
Player.__index = Player

local anim8 = require("vendor.anim8")
local paused = false

function Player:new(imagePath)
    local grid = anim8.newGrid(16, 16, 64, 32)
    local animations = {
        idle = anim8.newAnimation(grid('1-4', 1), 0.4),
        walking = anim8.newAnimation(grid('1-4', 2), 0.2)
    }
    local obj = {
        x = 0,
        y = 100,
        speed = 25,
        idle = true,
        sprite = love.graphics.newImage(imagePath),
        animations = animations,
        currentAnimation = animations.walking,
        distance = 0,
    }
    setmetatable(obj, Player)
    return obj
end

function Player:draw()
    love.graphics.print("Distance: " .. math.floor(self.distance) .. "m", 5, 5)
    self.currentAnimation:draw(self.sprite, self.x, self.y)
end

function Player:update(dt)
    if not paused then
        self.currentAnimation = self.animations.walking
        self.distance = self.distance + self.speed / 8 * dt
    else
        self.currentAnimation = self.animations.idle
    end
    self.currentAnimation:update(dt)
end

function Player:toggle()
    paused = not paused
end

return Player