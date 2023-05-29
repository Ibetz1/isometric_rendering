local iso_screen_coord = engine.geo.convert_sc

-- creates an axis for a 2d matrix with metadata
local function matrix_axis(...)
    local axis = {...}

    local meta = {
        -- redefine add func for vec
        __add = function(a, b)
            -- localize width of axis
            local d = #a

            -- iterate to length
            for i = 1, d do

                -- localize axis value at i
                local v = a[i]

                -- add b to axis value
                a[i] = v + b
            end

            -- return new axis
            return a
        end,

        -- redefine subtraction function for vec
        __sub = function(a, b)
            -- localize width of axis
            local d = #a

            -- iterate to length
            for i = 1, d do

                -- localize axis value at i
                local v = a[i]

                -- sub b from axis value
                a[i] = v - b
            end

            -- return new axis
            return a
        end,

        -- redefine multiplication function for vec
        __mul = function(a, b)
            -- localize width of axis
            local d = #a

            -- iterate to length
            for i = 1, d do

                -- localize axis value at i
                local v = a[i]

                -- mult b into axis value
                a[i] = v * b
            end

            -- return new axis
            return a
        end,

        -- redefine division function for vec
        __div = function(a, b)
            -- localize width of axis
            local d = #a

            -- iterate to length
            for i = 1, d do

                -- localize axis value at i
                local v = a[i]

                -- div b into axis value
                a[i] = v / b
            end

            -- return new axis
            return a
        end
    }

    setmetatable(axis, meta)

    return axis
end

-- creates a 2d matrix with the axis function
local function matN(x, y)
    local mat = {
        x = matrix_axis(unpack(x)),
        y = matrix_axis(unpack(y))
    }

    local meta = {
        -- redefine add func for vec
        __add = function(a, b)
            return matN(
                a.x + b,
                a.y + b
            )
        end,

        -- redefine subtraction function for vec
        __sub = function(a, b)
            return matN(
                a.x - b,
                a.y - b
            )
        end,

        -- redefine multiplication function for vec
        __mul = function(a, b)
            return matN(
                a.x * b,
                a.y * b
            )
        end,

        -- redefine division function for vec
        __div = function(a, b)
            return matN(
                a.x / b,
                a.y / b
            )
        end
    }

    setmetatable(mat, meta)
    
    return mat
end

-- generates a poly matrix from a matrix
local function poly_mat(m)
    -- localize poly matrix
    local mat = {}

    -- localize matrix length
    local d = #m.x

    -- local x and y axis of matrix
    local x = m.x
    local y = m.y

    -- iterate to matrix length
    for i = 1,d do
        -- localize x and y values of matrix
        local x, y = x[i], y[i]

        -- combine x and y values into poly matrix
        table.insert(mat, x)
        table.insert(mat, y)
    end

    -- return the poly matrix
    return mat
end

-- transforms a matrix to isometric coords
local function transform_matrix(m)
    -- localize new matrix
    local n_mat = {
        x = {}, y = {}
    }

    -- localize length of axis
    local len = #m.x

    -- iterate to end of axis
    for i = 1,len do

        -- localize x and y values
        local x = m.x[i]
        local y = m.y[i]

        -- convert the screen coords
        local x, y = iso_screen_coord(x, y)

        -- add converted x and y values to new matrix
        n_mat.x[i] = x
        n_mat.y[i] = y
    end

    -- convert maodified axis to matrix axis
    n_mat.x = matrix_axis(unpack(n_mat.x))
    n_mat.y = matrix_axis(unpack(n_mat.y))

    -- return new matrix
    return n_mat
end

return {
    new_axis = matrix_axis,
    new_mat = matN,
    poly_mat = poly_mat,
    mat_trans = transform_matrix
}