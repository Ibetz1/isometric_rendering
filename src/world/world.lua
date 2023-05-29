-- localized utilities
local vec2 = engine.util.vec2
local render_matrix = engine.graphics.draw_mat
local class = engine.util.class
local iso_grid_size = engine.geo.grid_size

local world = class:derive('world')

-- world object core --
-----------------------
configure_rendering()

-- initiates world
function world:init(w, h, l)
    -- define layers table
    self.layers = {}

    -- define texture key
    self.tex_key = {}

    -- define width, height and layer values
    self.w, self.h, self.l = w or 2, h or 2, l or 1

    -- define total screen area of grid
    self.grid_size = vec2(iso_grid_size(w, h, _W_LOCAL_.scale, _W_LOCAL_.tile_size[1]))

    -- define mouse coords
    self.mouse = vec2()

    -- define translation vector
    self.translation = vec2()

    -- create layers and add them
    for l = 1, self.l do
        -- make layer for world layers table
        self.layers[l] = make_layer(self.w, self.h)

        -- temporary layer matrices
        if l > 1 then
            self:apply_layer_matrix(l, x5wall)
        else
            self:apply_layer_matrix(l, x5solid)
        end
    end
end

-- updates world
function world:update()
    self:update_layers()
    self:update_mouse()
end

-- draws world
function world:draw()
    self:render_layers()
end



-- world rendering functions --
-------------------------------

function world:blank_matrix(base)
    -- create matrix table
    local mat = {}

    -- localize w and h
    local w, h = self.w, self.h

    -- localize base and default
    local base = base or 0

    -- iterate to w on x axis
    for x = 1, w do
        -- add collumn to matrix
        mat[x] = {}

        -- iterate to h on y axis
        for y = 1, h do

            -- set base val to 0
            mat[x][y] = base
        end
    end

    return mat
end

-- applies changes the map of a layer
function world:apply_layer_matrix(l, m)
    local layer = self.layers[l]

    -- sets layer matrix to matrix passed via parameter
    layer.matrix = engine.util.clone_table(m)

    -- creates an offset matrix for the layer
    layer.offset_matrix = self:blank_matrix(0)
end

-- draws a tile at x, y and the layer
function world:render_tile(x, y, l)
    -- define layer matrix and matrix value
    local layer = self.layers[l]
    local matrix_value = layer.matrix[x][y]

    -- return if no block is found
    if matrix_value == 0 then return end

    -- define the texture to be rendered
    local tex = self.tex_key[matrix_value]

    -- define screen x and y coords
    local sx, sy = engine.geo.block_sc(x - 1, y - 1, _W_LOCAL_.scale, _W_LOCAL_.tile_size[1])

    -- localize translation coords
    local tx, ty = self.translation.x, self.translation.y

    -- set default z value
    local z = (l - self.l) * _W_LOCAL_.tile_size[2] * _W_LOCAL_.scale

    -- set z offset
    local z_off = layer.offset_matrix[x][y]

    -- render texture
    tex:render(sx + self.translation.x, sy + self.translation.y - z - z_off, _W_LOCAL_.scale)
end

-- renders a shadow tile at x and y
function world:draw_shadow(x, y, i)
    graphics.setColor(1, 1, 1, 1)

    -- localize the index
    local i = i or 3

    -- localize the matrix (wtih index)
    local mat = face_sides[i]

    -- render the matrix
    render_matrix(face_sides[i], 'fill', x + _W_LOCAL_.tile_size[2] * _W_LOCAL_.scale, y, _W_LOCAL_.tile_size[1], _W_LOCAL_.tile_size[1], _W_LOCAL_.scale)

    graphics.setColor(1, 1, 1, 1)
end

-- update tiles
function world:update_layers()
    -- iterate to w/h on x/y axis
    for x = 1, self.w do
        for y = 1, self.h do

            -- iterate to layer count on l axis
            for l = 1, self.l do
                local layer = self.layers[l]

                -- check mouse on tile (temporary)
                if self:mouse_tile(x, y, l) then
                    -- set offset matrix at position to 20 of mouse is hovering 
                    layer.offset_matrix[x][y] = 20
                else
                    -- set offset matrix at postion to 0 if no interaction
                    layer.offset_matrix[x][y] = 0
                end

            end
        end
    end
end

-- render world (based on layers)
function world:render_layers()
    -- iterate to w/h on x/y axis
    for x = 1, self.w do
        for y = 1, self.h do

            -- iterate to layer count on l axis
            for l = 1, self.l do
                self:render_tile(x, y, l)
            end
        end
    end
end


-- world utilities --
---------------------

-- gets the projection coords of a tile
function world:get_tile_projection(x, y, dx, dy, l, o)
    -- project x val
    local px = x + (dx * l - o) - dx

    -- project y val
    local py = y + (dy * l - o) - dy
    
    return px, py
end

-- check for tile_neigbor at dx and dy
function world:check_tile_neigbor(x, y, dx, dy, l)
    -- localize matrix
    local mat = self.layers[l].matrix

    -- get offset position
    local px, py = x + dx, y + dy


    -- check for nil value or 0 value at offset position
    return mat[px] == nil or mat[px][py] == nil or mat[px][py] == 0
end

-- check if tile top is exposed
function world:check_tile_exposed(x, y, l)
    -- define layer above
    local top_layer = self.layers[l + 1]

    -- check if top layer exists
    return top_layer == nil or top_layer.matrix[x][y] == 0
end

-- get tile mouse is on
function world:mouse_tile(x, y, l)
    -- localize functions/values
    local check_exposed = self.check_tile_exposed

    -- define the mouse buffer (the buffer between mouse and depth)
    local mbuf = self.l - l

    -- apply mouse buffer to mouse coords
    local mx, my = self.mouse.x - mbuf, self.mouse.y - mbuf

    -- check for equality in x and y val and check for tile exposure
    return x == mx and y == my and check_exposed(self, x, y, l) == true
end

-- translate world in screen coords
function world:translate(x, y)
    -- set world translation
    self.translation.x, self.translation.y = x, y
end

-- updates mouse position
function world:update_mouse()
    -- gets mouse position
    local mx, my = mouse:getPosition()

    -- subtracts world translation
    mx, my = mx - self.translation.x, my - self.translation.y

    -- sets mouse x and y to converted coordinates
    self.mouse.x, self.mouse.y = engine.geo.invert_sc(mx, my, 0)
end

-- kills tile
function world:kill_tile(x, y, l)
    -- sets matrix at x, y on layer l to 0
    self.layers[l].matrix[x][y] = 0
end

-- adds texture to world
function world:add_tex(t, i)
    -- localize key
    local k = self.tex_key

    -- localizes index
    local i = i or #k + 1

    -- add texture to textures at index
    k[i] = t

    -- return the index
    return i
end



return world