function make_layer(w, h)
    -- make an array of cells
    local layer = engine.util.array(w, h)

    -- iteratre through the array
    for x = 1, #layer do
        for y = 1, #layer[x] do
            -- localize cel
            local cel = layer[x][y]

            -- define isometric cel position (unscaled)
            cel.screen_coord = engine.geo.convert_sc(x, y)
        end
    end

    return layer
end