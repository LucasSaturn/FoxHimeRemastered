local spriteHover = require('libs/spriteHover')


local backgroundGraphic
local backgroundScaleFactor

local menuButtonBlank = love.image.newImageData(275,75)

local pentagonSpinValue = {0,0,0,0}

local function figureOutLargestScaleBG(WidthBackground, HeightBackground, screenX, screenY)
	--calculate the scale between the size of the sprite, and the screen resolution
	local xScale,yScale = screenX/WidthBackground,screenY/HeightBackground
	--if the x scale is largest, return that
	if(xScale<yScale) then return xScale
	--else, return the y scale
	else return yScale end 
	--oof, the if statement died, return 1
	return 1
end


local function drawBackground()
	--run function to find the smallest scale on the background, and then centre it in frame
	backgroundScaleFactor = figureOutLargestScaleBG(backgroundGraphic:getWidth(),backgroundGraphic:getHeight(),screenX,screenY)
	local backgroundX = (screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2
	local backgroundY = (screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2
	--Draw background
	love.graphics.draw(backgroundGraphic,backgroundX,backgroundY,0,backgroundScaleFactor,backgroundScaleFactor)
end



local function drawMenuTextPents()
	

	love.graphics.draw(pentGraphic,1049*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		288*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		pentagonSpinValue[1],

		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[1]/6.28319)),
		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[1]/6.28319)),
		
		53,55)

	love.graphics.draw(pentGraphic,1049*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		363*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		pentagonSpinValue[2],

		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[2]/6.28319)),
		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[2]/6.28319)),
		
		53,55)

	love.graphics.draw(pentGraphic,1049*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		438*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		pentagonSpinValue[3],

		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[3]/6.28319)),
		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[3]/6.28319)),
		
		53,55)

	love.graphics.draw(pentGraphic,1049*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		513*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		pentagonSpinValue[4],

		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[4]/6.28319)),
		(backgroundScaleFactor*0.75)+((backgroundScaleFactor*0.25)*(pentagonSpinValue[4]/6.28319)),
		
		53,55)

end



local function renderMenuText()
	love.graphics.setFont(GenJyuuGothic)
	love.graphics.print("Start", 1090*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		265*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		0,backgroundScaleFactor,backgroundScaleFactor)

	love.graphics.print("Config", 1090*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		340*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		0,backgroundScaleFactor,backgroundScaleFactor)

	love.graphics.print("CG Mode", 1090*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		415*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		0,backgroundScaleFactor,backgroundScaleFactor)

	love.graphics.print("Exit", 1090*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2), 
		490*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		0,backgroundScaleFactor,backgroundScaleFactor)
end



function menuDeclaration()
	--Declare background tile graphic
	backgroundGraphic = love.graphics.newImage("assets/images/mainMenu/bg2.png")
	--declare pentagons behind text
	pentGraphic = love.graphics.newImage("assets/images/mainMenu/pent.png")
	--declare music source, as stream file
	musicSrc = love.audio.newSource("assets/music/Continue_Life.wav", "static")
	musicSrc:play()
	--declare local text font
	GenJyuuGothic = love.graphics.newFont("assets/fonts/GenJyuuGothic-Bold.ttf", 30)
end



function spinPentagon()
	local spinSpeed = 15
	local maxVal = 6.28319

	if(testForMenuButton()=="START") then
		if(pentagonSpinValue[1]<maxVal) then pentagonSpinValue[1] = pentagonSpinValue[1]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[1]>0) then
		pentagonSpinValue[1] = pentagonSpinValue[1]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[1]>maxVal) then pentagonSpinValue[1] = maxVal
	elseif(pentagonSpinValue[1]<0) then pentagonSpinValue[1] = 0
	end





	if(testForMenuButton()=="CONFIG") then
		if(pentagonSpinValue[2]<maxVal) then pentagonSpinValue[2] = pentagonSpinValue[2]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[2]>0) then
		pentagonSpinValue[2] = pentagonSpinValue[2]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[2]>maxVal) then pentagonSpinValue[2] = maxVal
	elseif(pentagonSpinValue[2]<0) then pentagonSpinValue[2] = 0
	end




	if(testForMenuButton()=="CG_MODE") then
		if(pentagonSpinValue[3]<maxVal) then pentagonSpinValue[3] = pentagonSpinValue[3]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[3]>0) then
		pentagonSpinValue[3] = pentagonSpinValue[3]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[3]>maxVal) then pentagonSpinValue[3] = maxVal
	elseif(pentagonSpinValue[3]<0) then pentagonSpinValue[3] = 0
	end




	if(testForMenuButton()=="EXIT") then
		if(pentagonSpinValue[4]<maxVal) then pentagonSpinValue[4] = pentagonSpinValue[4]+(love.timer.getDelta()*spinSpeed) end
	elseif(pentagonSpinValue[4]>0) then
		pentagonSpinValue[4] = pentagonSpinValue[4]-(love.timer.getDelta()*spinSpeed)
	end

	if(pentagonSpinValue[4]>maxVal) then pentagonSpinValue[4] = maxVal
	elseif(pentagonSpinValue[4]<0) then pentagonSpinValue[4] = 0
	end
end





function drawMenu()
	drawBackground()
	drawMenuTextPents()
	renderMenuText()

	spinPentagon()

	drawTextTopLeft()
end

function drawTextTopLeft()
	local x = ((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2)+7

	if(testForMenuButton()=="START") then
		love.graphics.print("START", x, 0)
	elseif(testForMenuButton()=="CONFIG") then
		love.graphics.print("CONFIG", x, 0)
	elseif(testForMenuButton()=="CG_MODE") then
		love.graphics.print("CG MODE", x, 0)
	elseif(testForMenuButton()=="EXIT") then
		love.graphics.print("EXIT", x, 0)
	end
end



function testForMenuButton()
	if(testMouseOver(996*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2),
		250*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then

		
		return "START"

	elseif(testMouseOver(996*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2),
		325*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then

		
		return "CONFIG"

	elseif(testMouseOver(996*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2),
		400*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then

		
		return "CG_MODE"

	elseif(testMouseOver(996*backgroundScaleFactor+((screenX-(backgroundGraphic:getWidth()*backgroundScaleFactor))/2),
		475*backgroundScaleFactor+((screenY-(backgroundGraphic:getHeight()*backgroundScaleFactor))/2),
		menuButtonBlank,backgroundScaleFactor,backgroundScaleFactor,false)) then

		
		return "EXIT"

	end
end

function menuMousePress(button)
	if(button==1)then
		if(testForMenuButton()=="START") then gameMode=1
		elseif(testForMenuButton()=="EXIT") then love.event.quit() end
	end
end