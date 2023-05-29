randomseed(time())
return function()
    -- define template for UUID
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

    -- return interpolated template
    return string.gsub(template, '[xy]', function (c)
        -- utilize RNG and UUID implimentations with RNG to get random val
        -- (dont really understand this, it came from stack overflow)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)

        -- format random values to string
        return string.format('%x', v)
    end)
end