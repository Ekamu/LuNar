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
	--Japanese ImageFonts (Hiragana)
	love.graphics.newImageFont("resources/font3.png"," qwertyuiopasdfghjkl;nm,./zxcvbQWERT"
    .."!@#$%^&*{}|YUIOPASDFGHJKL:ZXCVBNM<>?"..'0123456789`~()-+'),
	love.graphics.newImageFont("resources/font4.png"," qwertyuiopasdfghjkl;nm,./zxcvbQWERT"
    .."!@#$%^&*{}|YUIOPASDFGHJKL:ZXCVBNM<>?"..'0123456789`~()-+'),
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
			    love.graphics.setFont(font[3])--black text
			elseif bubble.style == 'think' then
			    love.graphics.setFont(font[4])--white text
			elseif bubble.style == 'nar' then
			    love.graphics.setFont(font[4])--white text
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
                text.cat = text.cat..text.msg:sub(text.c,text.c) 
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

function kana(txt)
txt = txt:gsub('ka','y')--6
txt = txt:gsub('ga','Y')--7
txt = txt:gsub('ki','u')--8
txt = txt:gsub('gi','U')--9
txt = txt:gsub('ku','i')--10
txt = txt:gsub('gu','I')--11
txt = txt:gsub('ke','o')--12
txt = txt:gsub('ge','O')--13
txt = txt:gsub('ko','p')--14
txt = txt:gsub('go','P')--15
txt = txt:gsub('sa','a')--16
txt = txt:gsub('za','A')--17
txt = txt:gsub('si','s')--18
txt = txt:gsub('ji','S')--19
txt = txt:gsub('su','d')--20
txt = txt:gsub('zu','D')--21
txt = txt:gsub('se','f')--22
txt = txt:gsub('ze','F')--23
txt = txt:gsub('so','g')--24
txt = txt:gsub('zo','G')--25
txt = txt:gsub('ta','h')--26
txt = txt:gsub('da','H')--27
txt = txt:gsub('ti','j')--28
txt = txt:gsub('di','J')--29
txt = txt:gsub('tu','k')--30
txt = txt:gsub('du','K')--31
txt = txt:gsub('te','l')--32
txt = txt:gsub('de','L')--33
txt = txt:gsub('to',';')--34
txt = txt:gsub('do',':')--35
txt = txt:gsub('na','n')--36
txt = txt:gsub('ni','m')--37
txt = txt:gsub('nu',',')--38
txt = txt:gsub('ne','.')--39
txt = txt:gsub('no','/')--40
txt = txt:gsub('ma','Q')--41
txt = txt:gsub('mi','W')--42
txt = txt:gsub('mu','E')--43
txt = txt:gsub('me','R')--44
txt = txt:gsub('mo','T')--45
txt = txt:gsub('ha','z')--46
txt = txt:gsub('ba','Z')--47
txt = txt:gsub('pa','N')--48
txt = txt:gsub('hi','x')--49
txt = txt:gsub('bi','X')--50
txt = txt:gsub('pi','M')--51
txt = txt:gsub('fu','c')--52
txt = txt:gsub('bu','C')--53
txt = txt:gsub('pu','<')--54
txt = txt:gsub('he','v')--55
txt = txt:gsub('be','V')--56
txt = txt:gsub('pe','>')--57
txt = txt:gsub('ho','b')--58
txt = txt:gsub('bo','B')--59
txt = txt:gsub('po','?')--60
txt = txt:gsub('ra','$')--61
txt = txt:gsub('ri','%')--62
txt = txt:gsub('ru','^')--63
txt = txt:gsub('re','&')--64
txt = txt:gsub('ro','*')--65
txt = txt:gsub('ya','!')--66
txt = txt:gsub('yu','@')--67
txt = txt:gsub('yo','#')--68
txt = txt:gsub('wa','{')--68
txt = txt:gsub('wo','}')--68
txt = txt:gsub('n','|')--68
txt = txt:gsub('a','q')--1
txt = txt:gsub('i','w')--2
txt = txt:gsub('e','r')--4
txt = txt:gsub('u','e')--3
txt = txt:gsub('o','t')--5
txt = txt:gsub('!','-')--69
txt = txt:gsub('?','+')--70
txt = txt:gsub(',','~')--71
txt = txt:gsub('%.','`')--72
return txt
end

--[[
ascikana = {
--vowels
['a'] = 'q',--1
['i'] = 'w',--2
['u'] = 'e',--3
['e'] = 'r',--4
['o'] = 't',--5
--phonetics
['ka'] = 'y',--6
['ga'] = 'Y',--7
['ki'] = 'u',--8
['gi'] = 'U',--9
['ku'] = 'i',--10
['gu'] = 'I',--11
['ke'] = 'o',--12
['ge'] = 'O',--13
['ko'] = 'p',--14
['go'] = 'P',--15
['sa'] = 'a',--16
['za'] = 'A',--17
['si'] = 's',--18
['ji'] = 'S',--19
['su'] = 'd',--20
['zu'] = 'D',--21
['se'] = 'f',--22
['ze'] = 'F',--23
['so'] = 'g',--24
['zo'] = 'G',--25
['ta'] = 'h',--26
['da'] = 'H',--27
['ti'] = 'j',--28
['di'] = 'J',--29
['tu'] = 'k',--30
['du'] = 'K',--31
['te'] = 'l',--32
['de'] = 'L',--33
['to'] = ';',--34
['do'] = ':',--35
['na'] = 'n',--36
['ni'] = 'm',--37
['nu'] = ',',--38
['ne'] = '.',--39
['no'] = '/',--40
['ma'] = 'Q',--41
['mi'] = 'W',--42
['mu'] = 'E',--43
['me'] = 'R',--44
['mo'] = 'T',--45
['ra'] = '$',--46
['ri'] = '%',--47
['ru'] = '^',--48
['re'] = '&',--49
['ro'] = '*',--50
['ha'] = 'z',--51
['ba'] = 'Z',--52
['pa'] = 'N',--53
['hi'] = 'x',--54
['bi'] = 'X',--55
['pi'] = 'M',--56
['hu'] = 'c',--57
['bu'] = 'C',--58
['pu'] = '<',--59
['he'] = 'v',--60
['be'] = 'V',--61
['pe'] = '>',--62
['ho'] = 'b',--63
['bo'] = 'B',--64
['po'] = '?',--65
['ya'] = '!',--66
['yu'] = '@',--67
['yo'] = '#',--68
['wa'] = '{',--69
['wo'] = '}',--70
['n']  = '|',--71
--special symbols
['%.'] = '`',--72
[','] = '~',--73
['!'] = '-',--74
['?'] = '+',--75
['(('] = '(',--76
['))'] = ')',--77
}

function kana(txt)
    for k,v in pairs(ascikana) do
    txt = txt:gsub(k,v)
    end
    return txt
end]]