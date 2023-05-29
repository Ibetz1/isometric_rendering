local function copy_table(t)
    -- localize new table
    local nt = {}

    -- iterate table to be cloned
    for k,v in pairs(t) do
        -- check for sub tables
        if otype(v) == 'table' then
            -- recursevly clone sub tables 
            -- and change v to cloned version
            v = copy_table(v) 
        end

        -- add key and value to new table
        nt[k] = v
    end


    return nt
end

return copy_table