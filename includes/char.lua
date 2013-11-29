--characters and sprites
char = {
left;center;right;vis = false;
draw = function()
    if char.vis then
	love.graphics.draw(char.left,4,4)--(4,4) left 
    love.graphics.draw(char.center,135,4)--(135,4) centre
    love.graphics.draw(char.right,266,4)--(266,4) right 
	end
end
}

--character objects
ghost = {--empty character used to clear space
    name = ""; sprite = {
    love.graphics.newImage("sprites/blank_small.png"),
	love.graphics.newImage("sprites/blank_large.png") 
	}
}

itzel = { --Star Serpent
    name = "Itzelcoatl"; sprite = {
	love.graphics.newImage("sprites/itzel_line.png"),
	love.graphics.newImage("sprites/itzel_color.png")
	}
}

kore = { --Mystic 
    name = "Kore"; sprite = {
	love.graphics.newImage("sprites/kore_line1.png"),
	love.graphics.newImage("sprites/kore_color1.png"),
	love.graphics.newImage("sprites/kore_line2.png"),
	love.graphics.newImage("sprites/kore_color2.png"),
	}
}

lucifer = { --False-King 
    name = "Lucifer"; sprite = {
	love.graphics.newImage("sprites/lucifer_line.png"),
	love.graphics.newImage("sprites/lucifer_color.png")
	}
}

function ghost_clear() --clears all character data
    char.left = ghost.sprite[1]
	char.center = ghost.sprite[1]
	char.right = ghost.sprite[1]
	text.label = ghost.name
end