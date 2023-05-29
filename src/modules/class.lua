local class = {}
class.__index = class

-- makes default class
function class:init() end

-- derives a new class
function class:derive(type, cls)
    local cls = cls or {}
    cls.type = type
    cls.__index = cls
    cls.parent = self
    cls.id = engine.util.UUID()

    setmetatable(cls, self)

    return cls
end

-- makes a new instance of class
function class:__call(...)
    local inst = setmetatable({}, self)

    inst:init(...)
    inst.id = engine.util.UUID()
    return inst
end

-- gets class
function class:GID()
    return self.id
end

return class