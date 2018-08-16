function loadText()
	if(love.filesystem.getInfo("textVariables.lua")~=nil) then
		gameStrings = love.filesystem.load("textVariables.lua")
		gameStrings.gameStrings()
		gameStrings.characterNames()
		gameStrings.sceneChanges()
	end
end