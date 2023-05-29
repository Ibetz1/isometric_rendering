return function(w, h)
    -- localize w and h (with default of 3)
    local w, h = w or 3, h or 3

    -- define a as table
    local a = {
        -- define array type
        type = 'array2D'
    }

    -- iterate to w on x axis
    for x = 1,w do
        -- add table to array for collumns
        a[x] = {}

        -- iterate to h on y axis
        for y  = 1,h do

            -- add table to array on y axis based on collum
            a[x][y] = {}
        end
    end

    -- returns array
    return a
end