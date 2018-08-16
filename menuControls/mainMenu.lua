--local spriteHover script
local spriteHover = require('libs/spriteHover')

--background variables
local backgroundGraphic
local backgroundScaleFactor

--empty image file to test hover
local menuButtonBlank = love.image.newImageData(275,75)

--rotation of pentagons
local pentagonSpinValue = {0,0,0,0}

--variable that lists whether a button is hovered over
local currentHoveredButton = ""


--declares all relevant menu items
function menuDeclaration()
	--Declare background tile graphic
	backgroundGraphic = love.graphics.newImage("assets/images/mainMenu/bg2.png")
	--declare pentagons behind text
	pentGraphic = love.graphics.newImage("assets/images/mainMenu/pent.png")
	--declare local text font
	GenJyuuGothic = love.graphics.newFont("assets/fonts/GenJyuuGothic-Bold.ttf", 30)
end



--[[ 
  ____             _                                   _                        _           _             
 | __ )  __ _  ___| | ____ _ _ __ ___  _   _ _ __   __| |    _ __ ___ _ __   __| | ___ _ __(_)_ __   __ _ 
 |  _ \ / _` |/ __| |/ / _` | '__/ _ \| | | | '_ \ / _` |   | '__/ _ \ '_ \ / _` |/ _ \ '__| | '_ \ / _` |
 | |_) | (_| | (__|   < (_| | | | (_) | |_| | | | | (_| |   | | |  __/ | | | (_| |  __/ |  | | | | | (_| |
 |____/ \__,_|\___|_|\_\__, |_|  \___/ \__,_|_| |_|\__,_|   |_|  \___|_| |_|\__,_|\___|_|  |_|_| |_|\__, |
                       |___/                                                                        |___/ 

--]]

--this function figures out the largest size that the background can be
	--this is in terms of fitting a 16:9 image inside the window
local function figureOutLargestScaleBG(WidthBackground, HeightBackground, screenX, screenY)
	--calculate the scale between the size of the sprite, and the screen resolution
	local xScale,yScale = screenX/WidthBackground,screenY/HeightBackground
	--if the x scale is largest, return that
	if(xScale<yScale) then return xScale
	--else, return the y scale
	else return yScale end 
	--oof, something broke, return 1 as a failsafe
	return 1
end

--draw the background
local function drawBackground()
	--run function to find the smallest scale on the background, and then centre it in frame
	backgroundScaleFactor = figureOutLargestScaleBG(backgroundGraphic:getWidth(),backgroundGraphic:getHeight(),screenX,screenY)
	local backgroundX = (screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2
	local backgroundY = (screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2
	--Draw background
	love.graphics.draw(backgroundGraphic,backgroundX,backgroundY,0,backgroundScaleFactor,backgroundScaleFactor)
end






--[[ 
	
  ____            _                                                 _           _             
 |  _ \ ___ _ __ | |_ __ _  __ _  ___  _ __      _ __ ___ _ __   __| | ___ _ __(_)_ __   __ _ 
 | |_) / _ \ '_ \| __/ _` |/ _` |/ _ \| '_ \    | '__/ _ \ '_ \ / _` |/ _ \ '__| | '_ \ / _` |
 |  __/  __/ | | | || (_| | (_| | (_) | | | |   | | |  __/ | | | (_| |  __/ |  | | | | | (_| |
 |_|   \___|_| |_|\__\__,_|\__, |\___/|_| |_|   |_|  \___|_| |_|\__,_|\___|_|  |_|_| |_|\__, |
                           |___/                                                        |___/ 

--]]

--draw a pentagon onscreen
local function drawPentagon(xPos,yPos,yScale,index,scaleFactors)
	--draw it at xPosition
		--yPosition multiplied by how far down
		--index of pentagon
		--all the scalefactors of each pentaon
	love.graphics.draw(pentGraphic,xPos, yPos*yScale,pentagonSpinValue[index],scaleFactors[index], scaleFactors[index],53,55)
end

--individual spinning function
local function spinPentagonIfStatements(string,index,spinSpeed,maxVal)
	--if the currently hovered button is right then
	if(currentHoveredButton==string) then
		--if the value is less than the maximum value, add delta time onto the spin value
		if(pentagonSpinValue[index]<maxVal) then pentagonSpinValue[index] = pentagonSpinValue[index]+(love.timer.getDelta()*spinSpeed) end
	--the button isn't hovered
	elseif(pentagonSpinValue[index]>0) then
		--remove the delta time
		pentagonSpinValue[index] = pentagonSpinValue[index]-(love.timer.getDelta()*spinSpeed)
	end

	--if the pentagon spin value is too high, cap it
	if(pentagonSpinValue[index]>maxVal) then pentagonSpinValue[index] = maxVal
	--alternatively, if the pentagon spin value is too low, cap it
	elseif(pentagonSpinValue[index]<0) then pentagonSpinValue[index] = 0
	end
end

--main spin function to call individual spinning function
local function spinPentagonHost()
	local spinSpeed = 15
	local maxVal = 6.28319

	spinPentagonIfStatements("START",1,spinSpeed,maxVal)
	spinPentagonIfStatements("CONFIG",2,spinSpeed,maxVal)
	spinPentagonIfStatements("CG_MODE",3,spinSpeed,maxVal)
	spinPentagonIfStatements("EXIT",4,spinSpeed,maxVal)
end

--the function to send the draw calls for pentagons
local function drawMenuPentagons()
	--the local x positions
	local xPosition = 1049*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2)
	local yPositionUnscaled = backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2)
	--scalefactors for each of the spinning pentagons
	local scaleFactors = {	(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[1]/6.28319)),
							(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[2]/6.28319)),
							(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[3]/6.28319)),
							(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[4]/6.28319))}

	--draw all the pentagons onscreen
	drawPentagon(xPosition,yPositionUnscaled,288,1,scaleFactors)
	drawPentagon(xPosition,yPositionUnscaled,363,2,scaleFactors)
	drawPentagon(xPosition,yPositionUnscaled,438,3,scaleFactors)
	drawPentagon(xPosition,yPositionUnscaled,513,4,scaleFactors)

	--run code to rotate the correct pentagons
	spinPentagonHost()
end







--[[
  _____         _                          _           _             
 |_   _|____  _| |_     _ __ ___ _ __   __| | ___ _ __(_)_ __   __ _ 
   | |/ _ \ \/ / __|   | '__/ _ \ '_ \ / _` |/ _ \ '__| | '_ \ / _` |
   | |  __/>  <| |_    | | |  __/ | | | (_| |  __/ |  | | | | | (_| |
   |_|\___/_/\_\\__|   |_|  \___|_| |_|\__,_|\___|_|  |_|_| |_|\__, |
                                                               |___/ 
--]]

local function renderMenuText()
	--declare local variables for position
	local xPosition = 1090*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2)
	local yPositionUnscaled = backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2)
	--set font
	love.graphics.setFont(GenJyuuGothic)
	--draw all the text
	love.graphics.print("Start",   xPosition,  265*yPositionUnscaled,  0,  backgroundScaleFactor,backgroundScaleFactor)
	love.graphics.print("Config",  xPosition,  340*yPositionUnscaled,  0,  backgroundScaleFactor,backgroundScaleFactor)
	love.graphics.print("CG Mode", xPosition,  415*yPositionUnscaled,  0,  backgroundScaleFactor,backgroundScaleFactor)
	love.graphics.print("Exit",    xPosition,  490*yPositionUnscaled,  0,  backgroundScaleFactor,backgroundScaleFactor)
end

--draw simple text to say which is hovered
function drawTextTopLeft()
	local x = ((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2)+7

	if(currentHoveredButton=="START") then
		love.graphics.print("START", x, 0)
	elseif(currentHoveredButton=="CONFIG") then
		love.graphics.print("CONFIG", x, 0)
	elseif(currentHoveredButton=="CG_MODE") then
		love.graphics.print("CG MODE", x, 0)
	elseif(currentHoveredButton=="EXIT") then
		love.graphics.print("EXIT", x, 0)
	end
end


--is mouse hovered over one of the buttons
function testForMenuButton()
	local xPosition = 996*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2)
	local yPositionUnscaled = backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2)

	if(testMouseOver(xPosition,250*yPositionUnscaled,
			menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then
		return "START"
	elseif(testMouseOver(xPosition,325*yPositionUnscaled,
			menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then
		return "CONFIG"
	elseif(testMouseOver(xPosition,400*yPositionUnscaled,
			menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then
		return "CG_MODE"
	elseif(testMouseOver(xPosition,475*yPositionUnscaled,
			menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then
		return "EXIT"
	end

	return ""
end



--is the mouse button down?
	--if so, do stuff
function menuMousePress(button)
	if(button==1)then
		if(currentHoveredButton=="START") then gameMode=1
		elseif(currentHoveredButton=="EXIT") then love.event.quit() end
	end
end

--this is a single function that will call all the
	-- functions to draw in the correct order
function drawMenu()
	--draws background sprites
	drawBackground()

	--draws menu text
	renderMenuText()
	--draw text that says what is hovered over
	drawTextTopLeft()

	--draws pentagons (this links to a function 
		--that rotates the pentagons)
	drawMenuPentagons()

	--set variable that contains currently hovered button
	currentHoveredButton = testForMenuButton()
end
