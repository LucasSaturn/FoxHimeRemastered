require "gameLibrary/backgrounds"
require "gameLibrary/sceneChange"
require "gameLibrary/gameModeScript"

require "libs/loadText"
require "libs/spriteHover"

require "menuControls/mainMenu"

--declare variables that are screen size
screenX,screenY = love.graphics.getWidth(),love.graphics.getHeight()

--what mode is the game in?
gameMode = 0


-- Load in love.
function love.load()
	--load all of the text variables
	loadText()
	--declare all the variables for the main menu
	menuDeclaration()
	--declare game variables
	GameModeDeclaration()
	
	

	--Lua loves to eat RAM, so collect some of that RAM back boiiii
	collectgarbage()

end

function love.update(dt)
	--Declare variables that represent screen size
	screenX,screenY = love.graphics.getWidth(),love.graphics.getHeight()
end

function love.draw()
	if(gameMode==0) then drawMenu() 
	elseif(gameMode==1) then drawGameMode() end
end

function love.keypressed(key, scancode, isRepeat)
	if(love.keyboard.isDown('1')) then gameMode=1 end
	if(love.keyboard.isDown('5')) then collectgarbage() end


	

end

function love.mousepressed(x, y, button, istouch)
	if(gameMode==0) then menuMousePress(button) else 
		updateText()
	end
end


function love.focus(f)
  if not f then
    -- LOST FOCUS
  else
    -- GAINED FOCUS
  end
end

function love.quit()
	-- Do some stuff with saving, ect
end