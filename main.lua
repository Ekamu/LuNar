--LuNar Lua+Narrative: A Simple Visual Novel Engine by Ekamu
require "includes/text"
require "includes/char"
require "includes/scene"
require "includes/lunar"

function love.load()
--timer
lunar_time = 0 ;t = 0 --global timers
w = 0 ;start = 0 --wait timers
--testing grid
test.grid   = love.graphics.newImage("resources/grid.png") 
--loaders
text.load();bubble.load();ghost_clear() 
--set
next_page = true; scene.drop  = drop.black; page.c = 0; page.label = "title" --initialize title page
text.vis = false; char.vis = false; scene.vis = false; test.vis = false
end

function love.update(dt)
--update loop
    game_time,delta_time = global_time(dt) --run global timer
	text.msg = kana(text.msg) --convert to ASCI Kana
    text_loop(dt)
    next_page = not text_prog() --no more text in progress
    lunar() --run visual novel
end

function love.draw()
--background
scene.draw()
--sprites
char.draw()
--test data
test.draw()
--panels
panel.draw()
--text
bubble.draw()
text.draw()
end