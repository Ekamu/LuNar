function global_time(dt)
t = t + dt 
    if t > 0.2 then
	t = 0
    lunar_time = lunar_time + 1
    end
    return lunar_time, dt --aprox 1 milisecond (10 = 1 second) 
end

function wait(stop)--wait miliseconds until stop
w = w + delta_time
	if w > 0.2 then --every milisecond
	w = 0
	    if start < stop then
	        start = start + 1 --global wait count
		end
	end
	--check outside loop
	if start == stop then
	return true --reached time limit
	end
	return false --not yet (no "else" must return value)
end

function lunar()--visual novel goes in here
--title page
if page.label == "title" then
    if page.c == 0 then
	    --setup character text and scene
        ghost_clear()
        panel.set(1,graphic.pan.v)		
		panel.set(2,graphic.coatl,'B',1)
        scene.drop = drop.ruin[2]		
        scene.vis = true;char.vis = false;text.vis = false;panel.vis = true;page.input = false --disable user input
	    text_reset('next')--go to next page
	elseif page.c == 1 then
	    if wait(20) then jump('demo',0) end
	end
end
--page labels have unique page counts
if page.label == "demo" then
	if page.c == 0 then
	    ghost_clear()
		char.left = kore.sprite[2]
		char.right = itzel.sprite[2]
		scene.drop  = drop.crystal[2]
	    char.vis = true;text.vis = true;page.input = true;panel.vis = false
	    text_reset('next')
    elseif page.c == 1 then
	    text.label = kore.name
		bubble.select('lhs','top','talk')
        text.msg = "the quick brown fox jumped over the lazy dog"--some trial and error
	elseif page.c == 2 then
	    text.label = itzel.name
		bubble.select('rhs','mid','think')
	    text.msg = "i heard that on 123456789 times this week" 
	elseif page.c == 3 then
	    ghost_clear()
	    char.left = lucifer.sprite[2]
		char.center = kore.sprite[4] 
		scene.drop = drop.aztec[2]
		text_reset('next')
	elseif page.c == 4 then
	    text.label = lucifer.name
		bubble.select('lhs','low','talk')
		text.msg = "compute this ladies"..
		"0010010001010100101000100100101000101"..
		"0010010001010100101000100100101000101"..
		"0010010001010100101000100100101000101"..
		"0010010001010100101000100100101000101"..
		"0010010001010100101000100100101000101"
	elseif page.c == 5 then
	    text.label = kore.name
		bubble.select('rhs','low','nar')
		text.msg = "thats impossible!"
	elseif page.c == 6 then
	    jump('title',0)
	end
end
end