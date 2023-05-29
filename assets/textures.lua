love.graphics.setDefaultFilter('nearest', 'nearest')

tex_sheet = engine.util.tile_set('assets/block.png', 32, 32)

dirt = engine.tex(tex_sheet.image, tex_sheet[1])
grass = engine.tex(tex_sheet.image, tex_sheet[2])
