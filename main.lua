-- get dependencies
require('src')
require('assets/textures')
require('assets/world')

-- configures rendering engine

love.window.setVSync(0)

local scale = 3

local tile_size = {
    32,
    16
}

local res = {
    love.graphics.getWidth(),
    love.graphics.getHeight()
}

engine.conf(tile_size, res, scale)


function love.load()

    -- dont mess with the w and h without a new matrix of according size

    --                w, h, l
    world = engine.world(5, 5, 6)

    world:translate(res[1]/2, res[2]/2 - world.grid_size.y)

    world:apply_layer_matrix(5, x5top) -- add middle floor thing

    world:add_tex(dirt)
    world:add_tex(grass)
end

function love.update(dt)
    world:update()
end

function love.draw()
    world:draw()


    love.graphics.print(love.timer.getFPS())
end