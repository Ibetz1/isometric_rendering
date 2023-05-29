-- localize modded functions
_G["otype"] = type

-- redefines type function to allow custom type
function type(obj)
    -- check if obj is table with type
    if otype(obj) == 'table' and obj.type then
        -- return custom type
        return obj.type
    end

    -- return default type
    return otype(obj)
end

-- globalize love functions
mouse = love.mouse
key_board = love.keyboard
graphics = love.graphics
window = love.window

-- globalize math functions
ceil = math.ceil
floor = math.floor
random = math.random
randomseed = math.randomseed

-- globalize os functions
time = os.time
clock = os.clock