return function(c, f, ...)
    -- set bench count to get average
    local n = 50
    -- localize time
    local time = 0

    -- benchmark n times
    for i = 1, n do
        -- get clock prior to execution
        local t = clock()

        -- execute function c times
        for i = 1,c do
            f(...)
        end

        -- add difference between prior and current clock to time
        time = time + (clock() - t)
    end
    
    -- return average time
    return time/count
end