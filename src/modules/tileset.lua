return function(ipath, qw, qh)
    -- localize the image
    local image = graphics.newImage(ipath)

    -- get image w and h
    local iw, ih = image:getDimensions()

    -- get the horizontal and verticle count
    local h_count, v_count = math.ceil(iw/qw), math.ceil(ih/qh)

    -- localize the sheet
    local sheet = {
        -- add quad w and h to sheet
        quad_w = quad_w, 
        quad_h = quad_h,

        -- add image w and h to sheet
        image_w = iw,
        image_h = ih,

        -- add image to sheet
        image = image
    }

    -- iterate to verticle count
    for y = 0, h_count - 1 do

        -- iterate to horizontal count
        for x = 0, v_count do

            -- localize the index
            local i = #sheet + 1

            -- create the quad
            sheet[i] = graphics.newQuad(x*qw, y*qh, qw, qh, iw, ih)
        end
    end

    -- return the sheet
    return sheet
end