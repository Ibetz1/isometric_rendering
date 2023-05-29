local graphics = {}

-- renders a built in or custom matrix
function graphics.draw_mat(m, f, x, y, w, h, s)
    -- localize x, y, w and h
    local x, y = x or 0, y or 0
    local w, h = w or tile_size[1], h or tile_size[1]

    -- localize axis
    local xv, yv = m.x, m.y

    -- localize scale
    local s = s or 1


    -- render the matrix as a polygon
    graphics.polygon(f, 
        xv[1] * w * s + x, yv[1] * h * s + y,
        xv[2] * w * s + x, yv[2] * h * s + y,
        xv[3] * w * s + x, yv[3] * h * s + y,
        xv[4] * w * s + x, yv[4] * h * s + y
    )
end

return graphics