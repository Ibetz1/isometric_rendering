return function(x, y)
    -- define vector table
    local vec = {
        x = x or 0,
        y = y or x or 0,
        type = 'vec2'
    }

    -- define meta data for vec
    local meta = {
        -- redefine add func for vec
        __add = function(a, b)
            if type(b) == 'vec2' then 
                return vec2(a.x + b.x, a.y + b.y)
            else
                return vec2(a.x + b, a.y + b)
            end
        end,

        -- redefine subtraction function for vec
        __sub = function(a, b)
            if type(b) == 'vec2' then 
                return vec2(a.x - b.x, a.y - b.y)
            else
                return vec2(a.x - b, a.y - b)
            end
        end,

        -- redefine multiplication function for vec
        __mul = function(a, b) 
            if type(b) == 'vec2' then 
                return vec2(a.x * b.x, a.y * b.y)
            else
                return vec2(a.x * b, a.y * b)
            end
        end,

        -- redefine subtraction function for vec
        __div = function(a, b) 
            if type(b) == 'vec2' then 
                return vec2(a.x / b.x, a.y / b.y)
            else
                return vec2(a.x / b, a.y / b)
            end
        end
    }

    -- return vector with metadata applied
    return setmetatable(vec, meta)
end