text = {--table for text interface
load = function() --loads text system data and resources
    text.input ="";text.label ="";text.msg ="";text.cat ="";text.vis = false;
    text.t = 0;text.c = 0;text.n = 0;text.speed = 10;text.max = 150;text.line = 25;
	text.cmd = love.graphics.newImage("resources/cmdbox.png");
    font = {
    love.graphics.newImageFont("resources/font1.png"," ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    .."abcdefghijklmnopqrstuvwxyz"..'0123456789.,""!?()_/-+:;\\<>'),
    love.graphics.newImageFont("resources/font2.png"," ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    .."abcdefghijklmnopqrstuvwxyz"..'0123456789.,""!?()_/-+:;\\<>'),
    } 	
end;
draw = function()
        if text.vis then
		    love.graphics.draw(text.cmd,0,284)--cmd interface
		    love.graphics.setFont(font[2])--white text
		    love.graphics.print(text.label,10,288)--label
            love.graphics.print(text.input,146,288)--input
        end
	end;	
clear = function()
    --reset concat text
    text.input = ""
	text.cat = ""
	--reset counters
	text.c = 0
	text.n = 0
    end;
}

bubble = { --speach bubble
set; style;
load = function()
    bx = 0;by = 0;tx = 0;ty = 0;
    bubble.lu = { --left up
	love.graphics.newImage('resources/msgbox_lu.png'),--normal
	love.graphics.newImage('resources/msgbox_lus.png')--small 
	};
    bubble.ru = { --right up
	love.graphics.newImage('resources/msgbox_ru.png'),--normal
    love.graphics.newImage('resources/msgbox_rus.png')--small 	
	};
    bubble.ld = { --left down
	love.graphics.newImage('resources/msgbox_ld.png'),--normal
	love.graphics.newImage('resources/msgbox_lds.png')--small
	};
    bubble.rd = { --right down 
	love.graphics.newImage('resources/msgbox_rd.png'),
	love.graphics.newImage('resources/msgbox_rds.png')
	};
	bubble.msg = { --naration message/UI
	up = love.graphics.newImage('resources/msgbox_um.png'),
	down = love.graphics.newImage('resources/msgbox_dm.png')
	}
end;
select = function(px,py,style) --selects which speach bubble to use and where
    --position along y (bubble oriented)
    if py == 'top' then 
	    by = 8; ty = 14 
	elseif py == 'mid'  then 
	    by = 110; ty = 122 
	elseif py == 'low'  then 
	    by = 194; ty = 206 
	end
	--position along x (character oriented)
	if py == 'low' then
        if px == 'lhs' then 
		    --normal lhs positioning
	        bx = 4; tx = 11 
	    elseif px == 'rhs' then
		    --normal rhs positioning
    	    bx = 135; tx = 142 
	    end
	else --switch x position for top and mid
        if px == 'rhs' then 
		    --rhs replace lhs 
	        bx = 4; tx = 11 
	    elseif px == 'lhs' then 
		    --lhs replace rhs
    	    bx = 135; tx = 142 
	    end
	end
	--set speach bubble
	bubble.style = style --capture style argument
	if py == 'top' then
	if style == 'nar' then bubble.set = bubble.msg.up end
	    if px == 'lhs' then
		    if style == 'talk' then
                bubble.set = bubble.ld[1]
			elseif style == 'think' then
			    bubble.set = bubble.ld[2]
			end
		elseif px == 'rhs' then
		    if style == 'talk' then
		        bubble.set = bubble.rd[1]
			elseif style == 'think' then
			    bubble.set = bubble.rd[2]
			end
		end
	else --mid and low use flipped bubble
	if style == 'nar' then bubble.set = bubble.msg.down end
	    if px == 'lhs' then
		    if style == 'talk' then
		        bubble.set = bubble.lu[1]
			elseif style == 'think' then
			    bubble.set = bubble.lu[2]
			end
		elseif px == 'rhs' then
		    if style == 'talk' then
		        bubble.set = bubble.ru[1]
			elseif style == 'think' then
			    bubble.set = bubble.ru[2]
			end
		end
	end
end;
draw = function()
    if text.vis then
	    if bubble.set ~= nil then
	        love.graphics.draw(bubble.set,bx,by)--speach balloon
			--set font for speach bubble
			if bubble.style == 'talk' then
			    love.graphics.setFont(font[1])--black text
			elseif bubble.style == 'think' then
			    love.graphics.setFont(font[2])--white text
			elseif bubble.style == 'nar' then
			    love.graphics.setFont(font[2])--white text
			end
            love.graphics.print(text.cat,tx,ty)--draw text (use text.msg in lunar())
	    end
    end
end
}

page = {--table for page number and label
c = 0 ;label = "" ;input = false
}

user_data = {--table for user input data
txt = {} ;num = {};
clear = function()
    for i=1,4 do
        user_data.txt[i] = nil
    end
	for j=1,2 do
	    user_data.num[j] = nil
	end
end
}

function love.keypressed(key)
    --input command control
	if text.vis then
	--enter user input
        if  key and key:match('^[%w%s]$') then --patern means only small letters and numbers
	        if text.input:len() < 31 then --limit to 31 characters
                text.input = text.input..key 
	        end
        end
	--delete user input
        if  key == 'backspace' then
            text.input = text.input:sub(1, -2) 
        end
	--store user input
	    if key == 'lctrl' or key == 'rctrl' then
            if  store_input() ~= nil then --if user input exists			
		        store_input() 
		    end
		end
	end
	--next page control
	if page.input then
	    if key == 'right' and next_page then --next text
	        text_reset('next')
	    elseif key == 'left' and page.c > 0 then --previouse text
	        text_reset('prev')
	    end
        --force control
        if key == 'up' then --skip text
	        text_reset('next')
        elseif key == 'down' then --go to title
            jump("title",0) 
        end
    end	
end

function text_loop(dt)--draw text one at a time
    if text.vis then
        text.t = text.t + (text.speed*dt)
        if text.t > 0.2 then-- 0.2 seconds.
            text.t = 0
	        --add the letter      
	        if text.cat:len() <= text.max and text.cat:len() <= text.msg:len() then
                text.cat = text.cat..text.msg.sub(text.msg,text.c,text.c) 
                text.c = text.c + 1 --next letter (text count)
		        text.n = text.n + 1 --next letter (line count)
	            if text.n == text.line then --end of line
	                text.cat = text.cat.."\n" --draw on new line
	                text.n = 0
	            end
	        end
        end
    end
end

function text_prog()--checks if text loop is still in progress
    if text.cat:len() <= text.max and text.cat:len() <= text.msg:len() then
	return true
	end
	return false
end

function store_input() --Lexer converts user input into tokens 
local i = 0 --position for text
	for t in text.input:gmatch('%a+') do
	    if i < 4 then --limit to 4 words
	        i = i + 1
	        user_data.txt[i] = t --store in text user_data
		end
	end 
local j = 0 --position for numbers
	for n in text.input:gmatch('%d+') do
	    if j < 2 then --limit to 2 numbers
	        j = j + 1
	        user_data.num[j] = n --store in number user data
		end
	end
text.input = "" --clear user input
end

function reset() --reset all sensitive variables
user_data.clear() 
text.clear()
start = 0 --reset wait timer counter
end

function text_reset(navigator)--reset text data and go to next or previous page
    if navigator == 'next' then
        reset()
	    page.c = page.c + 1
	elseif navigator == 'prev' then
        reset() 
	    page.c = page.c - 1
	end
end

function jump(label,n)--jump to specific page label and number
    reset()
    page.label = label ;page.c = n 
end

--lexicon comparison
function lex_txt(str,i)--compares user_data string_text
    if user_data.txt[i] == str then
    return true
    else
    return false
    end
end

function lex_num(num,j)--compares user_data string_numbers
    if user_data.num[j] == num then
	return true
	else
	return false
	end
end