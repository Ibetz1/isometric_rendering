-- ABOUT --
-----------
-- this is an engine to render isometric textures in
-- a 2D graphics library. It uses matrix transforms and
-- some clever scaling to render said textures with close
-- to 0 impact on performance


-- localize love functions
mouse = love.mouse
key_board = love.keyboard
graphics = love.graphics
window = love.window

-- localize math functions
ceil = math.ceil
floor = math.floor
random = math.random
randomseed = math.randomseed

-- localize os functions
time = os.time
clock = os.clock

-- localize basic config vars
_G["_W_LOCAL_"] = {}
_G["_W_LOCAL_"].tile_size = nil
_G["_W_LOCAL_"].res = nil
_G["_W_LOCAL_"].scale = nil

-- configures constants for engine
function configure_rendering(t, r, s)
    -- pass tilesize, res and scale or apply default
    local t = t or {1, 1}
    local r = r or {1, 1}
    local s = s or 1

    _G["_W_LOCAL_"].tile_size = t
    _G["_W_LOCAL_"].res = r
    _G["_W_LOCAL_"].scale = s
end


-- DO NOT ALTER, LOADED IN SPECIFIC ORDER
_G["engine"] = {}

-- package utils (needs to be done like this because they depend on eachother)
engine.util = {}
engine.util.clone_table = require("src/modules/table")
engine.util.array       = require("src/modules/array2D")
engine.util.UUID        = require("src/modules/UUID")
engine.util.class       = require("src/modules/class")
engine.util.vec2        = require("src/modules/vector")
engine.util.timef       = require("src/modules/benchmark")
engine.util.tile_set    = require("src/modules/tileset")

-- internals
require('src/internal')
engine.geo      = require('src/geometry')
engine.mat      = require('src/matrix')
engine.graphics = require('src/graphics')

-- initialize shapes with matrices
engine.shape = {}
do
    local matrices = require("src/shapes")

    -- make indexable
    engine.shape.top_face   = engine.mat.mat_trans(matrices.top_face)
    engine.shape.left_face  = engine.mat.mat_trans(matrices.left_face)
    engine.shape.right_face = engine.mat.mat_trans(matrices.right_face)

    -- make iterable
    engine.shape[1] = engine.shape.left_face
    engine.shape[2] = engine.shape.right_face
    engine.shape[3] = engine.shape.top_face
end

require("src/world/layer") -- prereq for world
engine.world = require("src/world/world")
engine.tex   = require("src/texture")
engine.conf  = configure_rendering