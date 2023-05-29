-- define ratios between orthographic and isometric geometry
local x_rat = engine.util.vec2(0.5, 0.25)
local y_rat = engine.util.vec2(-0.5, 0.25)

-- convert orthographic to isometric coords (made to fit grid)
local function iso_screen_coord(x, y)
    -- localize px and py
    local px, py

    -- check for vector
    if type(x) == 'vec2' then
        x, y = x.x, x.y
    end

    -- define x and y values
    local px = x_rat.x * x + y_rat.x * y
    local py = x_rat.y * x + y_rat.y * y

    return px, py
end

-- get rendering coord for a block
local function block_coord(x, y, scale, tile_size)
    -- convert x and y to iso coord and then apply scale and tile_size
    local px, py = iso_screen_coord(x, y) 

    -- apply scale
    px, py = px * scale * tile_size, py * scale * tile_size

    -- offset coords to render from center and return
    return px - (tile_size * scale)/2, py
end

-- convert screen coords to an isometric tile
local function inverse_screen_coord(x, y, o)

    -- define layer offset
    local o = o or 1

    -- localize tilesize multiplied with scale
    local t_size = _W_LOCAL_.tile_size[1] * _W_LOCAL_.scale

    -- get the multiplier for sudo matrix
    local mult = 1/(t_size*t_size/4)

    -- get sudo matrix values
    local matx = t_size/4*mult*x
    local maty = t_size/2*mult*y

    -- return sudo matrix as x and y val
    return ceil(matx + maty) + o, ceil(-matx + maty) + o
end

-- get a iso grid size
local function iso_grid_size(w, h, scale, tile_size)
    -- get the rect grid width/height
    return w * tile_size * scale, h * tile_size/2 * scale
end

return {
    convert_sc = iso_screen_coord,
    block_sc   = block_coord,
    invert_sc  = inverse_screen_coord,
    grid_size  = iso_grid_size,
}