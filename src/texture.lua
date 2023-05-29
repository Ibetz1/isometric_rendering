-- localized components
local class = engine.util.class

-- creates texture class
local texture = class:derive('texture')

-- initiates texture class
function texture:init(tex, quad)
    -- set mask to default
    self:set_mask()

    -- set quad for texture (for tile maps)
    self.quad = quad

    -- set texture sheet
    self.tex = tex
end

-- sets texture mask
function texture:set_mask(r, g, b, a)
    -- localize rgb values
    local r, g = r or 1, b or 1
    local b, a = g or 1, a or 1

    -- set mask to rgb values
    self.mask = {r, g, b, a}
end

-- renders texture
function texture:render(x, y, scale)
    -- set color to mask
    graphics.setColor(self.mask)

    -- check for nil quad, otherwise render with quad
    if self.quad == nil then
        -- draw texture with quad
        graphics.draw(self.tex, x, y, 0, scale)
    else
        -- draw texture without quad
        graphics.draw(self.tex, self.quad, x, y, 0, scale)
    end

    -- reset color
    graphics.setColor(1, 1, 1, 1)
end

return texture