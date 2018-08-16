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

--draw a pentagon onscreen
local function drawPentagon(xPos,yPos,yScale,index,scaleFactors)
	--draw it at xPosition
		--yPosition multiplied by how far down
		--index of pentagon
		--all the scalefactors of each pentaon
	love.graphics.draw(pentGraphic,xPos, yPos*yScale,pentagonSpinValue[index],scaleFactors[index], scaleFactors[index],53,55)
end

--the function to send the draw calls for pentagons
local function drawMenuTextPents()
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
end



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



function menuDeclaration()
	--Declare background tile graphic
	backgroundGraphic = love.graphics.newImage("assets/images/mainMenu/bg2.png")
	--declare pentagons behind text
	pentGraphic = love.graphics.newImage("assets/images/mainMenu/pent.png")
	--declare local text font
	GenJyuuGothic = love.graphics.newFont("assets/fonts/GenJyuuGothic-Bold.ttf", 30)
end



function spinPentagon()
	local spinSpeed = 15
	local maxVal = 6.28319

	if(currentHoveredButton=="START") then
		if(pentagonSpinValue[1]<maxVal) then pentagonSpinValue[1] = pentagonSpinValue[1]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[1]>0) then
		pentagonSpinValue[1] = pentagonSpinValue[1]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[1]>maxVal) then pentagonSpinValue[1] = maxVal
	elseif(pentagonSpinValue[1]<0) then pentagonSpinValue[1] = 0
	end





	if(currentHoveredButton=="CONFIG") then
		if(pentagonSpinValue[2]<maxVal) then pentagonSpinValue[2] = pentagonSpinValue[2]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[2]>0) then
		pentagonSpinValue[2] = pentagonSpinValue[2]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[2]>maxVal) then pentagonSpinValue[2] = maxVal
	elseif(pentagonSpinValue[2]<0) then pentagonSpinValue[2] = 0
	end




	if(currentHoveredButton=="CG_MODE") then
		if(pentagonSpinValue[3]<maxVal) then pentagonSpinValue[3] = pentagonSpinValue[3]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[3]>0) then
		pentagonSpinValue[3] = pentagonSpinValue[3]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[3]>maxVal) then pentagonSpinValue[3] = maxVal
	elseif(pentagonSpinValue[3]<0) then pentagonSpinValue[3] = 0
	end




	if(currentHoveredButton=="EXIT") then
		if(pentagonSpinValue[4]<maxVal) then pentagonSpinValue[4] = pentagonSpinValue[4]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[4]>0) then
		pentagonSpinValue[4] = pentagonSpinValue[4]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[4]>maxVal) then pentagonSpinValue[4] = maxVal
	elseif(pentagonSpinValue[4]<0) then pentagonSpinValue[4] = 0
	end
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
	drawBackground()
	drawMenuTextPents()
	renderMenuText()

	spinPentagon()

	drawTextTopLeft()

	--set variable that contains currently hovered button
	currentHoveredButton = testForMenuButton()
end
