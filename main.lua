local push = require("vendor.push")

local player = require("src.player")
local ground = require("src.ground")

local gameWidth, gameHeight = 128, 128
local windowWidth, windowHeight = 512, 512

local background = love.graphics.newImage("assets/gfx/background.png")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
        fullscreen = false,
        pixelperfect = true,
    })

    player = Player:new("assets/gfx/player.png")
    ground = Ground:new(0, gameHeight -16, "assets/gfx/ground.png")
end

function love.update(dt)
    player:update(dt)
    ground:update(dt)
end

function love.draw()
    push:start()
    love.graphics.draw(background, 0, 0)
    ground:draw()
    player:draw()
    push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "space" then
        Ground:toggle()
        Player:toggle()
    end
end