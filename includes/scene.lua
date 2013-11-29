--scene "background images"
scene = {
drop;vis = false;
draw = function()
    if scene.vis then
        love.graphics.draw(scene.drop,0,0)
	end
end;
animate = function(frame,rate,dropper)
    scene.drop = dropper[page.c] --draw scene
    for i=1, frame do
	    if wait(rate) then --within time rate	
		page.c = page.c + 1 
		reset() --reset timer
		end	
	end
end
}

panel = {
graphic={};vis=false;x={};y={}; --grid co-ordinates
set = function(i,graphic,grid_x,grid_y)
    panel.graphic[i] = graphic 
    --set panel x
    if grid_x == 'A' then
	    panel.x[i] = 4
    elseif grid_x == 'B' then
        panel.x[i] = 135
    elseif grid_x == 'C' then
        panel.x[i] = 266
	else --no argument given 
	    panel.x[i] = 0
    end	
	--set panel y
	if grid_y == 1 then
	    panel.y[i] = 5
	elseif grid_y == 2 then
	    panel.y[i] = 102
	elseif grid_y == 3 then
	    panel.y[i] = 199
	else --no argument given
	    panel.y[i] = 0
	end
end;
draw = function()
    if panel.vis then
	    for i=1,#panel.graphic do
            love.graphics.draw(panel.graphic[i],panel.x[i],panel.y[i])
		end
	end
end
}

drop = {
--backdrops
black = love.graphics.newImage("backgrounds/black.png"),
--backdrops [1] = line_art [2] = pop_color
aztec = { --aztecc pyramid
    love.graphics.newImage("backgrounds/aztec_line.png"),
    love.graphics.newImage("backgrounds/aztec_color.png")
	};
ash = { --ash temple
    love.graphics.newImage("backgrounds/ash_line.png"),
    love.graphics.newImage("backgrounds/ash_color.png")
	};
blood = { --blood river
    love.graphics.newImage("backgrounds/blood_line.png"),
    love.graphics.newImage("backgrounds/blood_color.png")
	};
crystal = { --crystal skulls
    love.graphics.newImage("backgrounds/crystal_line.png"),
    love.graphics.newImage("backgrounds/crystal_color.png")
	};
shrine = { --mythos shrine
    love.graphics.newImage("backgrounds/shrine_line.png"),
    love.graphics.newImage("backgrounds/shrine_color.png")
	};
desert = { --desert canyons
    love.graphics.newImage("backgrounds/desert_line.png"),
    love.graphics.newImage("backgrounds/desert_color.png")
	};
ruin = { --temple ruins
    love.graphics.newImage("backgrounds/ruin_line.png"),
    love.graphics.newImage("backgrounds/ruin_color.png")
	};
canyon = { --canyons black
    love.graphics.newImage("backgrounds/canyon_line.png"),
    love.graphics.newImage("backgrounds/canyon_color.png")
	};
}

graphic = {
--panel background
pan={
    g = love.graphics.newImage("panels/pan_g.png"),
	c = love.graphics.newImage("panels/pan_c.png"),
	h = love.graphics.newImage("panels/pan_h.png"),
	v = love.graphics.newImage("panels/pan_v.png")
    };
--panel graphic pictures
coatl = love.graphics.newImage("panels/coatl_statue.png");
--animated panels
devil = { 
        love.graphics.newImage("panels/devil_eyes.png"),
		love.graphics.newImage("panels/devil_mask.png"),
		love.graphics.newImage("panels/devil_face.png")
        }
}

--test output
test = {
grid;vis = false;
draw = function()
    if test.vis then
	love.graphics.setFont(font[2])
	 love.graphics.draw(test.grid,0,0)
	  love.graphics.print('text.n: '..text.n,4,4)
       love.graphics.print('text.c: '..text.c,4,16)
        love.graphics.print('text.cat: '..text.cat:len(),4,28)
         love.graphics.print('text.msg: '..text.msg:len(),4,40)
	    love.graphics.print('page_count: '..page.c,266,28)
	   love.graphics.print('next_page: '..tostring(next_page),4,52)
	  love.graphics.print('user_txt1: '..tostring(user_data.txt[1]),4,64)--unpredictable
	  love.graphics.print('user_txt2: '..tostring(user_data.txt[2]),4,76)
	   love.graphics.print('user_txt3: '..tostring(user_data.txt[3]),4,88)
	    love.graphics.print('user_txt4: '..tostring(user_data.txt[4]),4,100)
	     love.graphics.print('user_num1: '..tostring(user_data.num[1]),4,112)
		   love.graphics.print('user_num2: '..tostring(user_data.num[2]),4,124)
		    love.graphics.print('page_label: '..page.label,266,16)
			love.graphics.print('game_time:'..game_time,266,4)
	end
end
}