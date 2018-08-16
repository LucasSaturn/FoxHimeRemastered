local conf = require('conf')

globalScale = 1

local backgroundGraphic
local newBGToLoad

local timeIntoTransition = 0
local timeToTake = 1
local runSceneTransition = true

currentImage = ""

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

function returnBackgroundYPos(returnHeightOrYPos)
	if(returnHeightOrYPos=="yPos") then return (screenY-(backgroundGraphic:getHeight()*globalScale))/2
	elseif(returnHeightOrYPos=="height") then return backgroundGraphic:getHeight()*globalScale end

	return ""
	
end

function backgroundDraw()
	--run function to find the largest scale on the background, and then centre it in frame
	globalScale = figureOutLargestScaleBG(backgroundGraphic:getWidth(),backgroundGraphic:getHeight(),screenX,screenY)
	local backgroundX = (screenX-(backgroundGraphic:getWidth()*globalScale))/2
	local backgroundY = returnBackgroundYPos("yPos")
	--Draw background
	love.graphics.draw(backgroundGraphic,backgroundX,backgroundY,0,globalScale,globalScale)

	if(runSceneTransition==true) then fadeInNewBg(backgroundX,backgroundY) end

	love.graphics.print( timeIntoTransition, 0,0)
	love.graphics.print(tostring(runSceneTransition), 0,25)
	love.graphics.print(tostring(allowGameScroll), 0,50)

end



function backgroundDeclaration()
	--declare background assets available for use
	backgroundAssets = {"bg_001a","bg_001b","bg_001c","bg_001d","bg_001e","bg_001f"}
	--Declare background tile graphic
	backgroundGraphic = love.graphics.newImage("assets/images/scenes/bg_blank.png")
	newBGToLoad = love.graphics.newImage("assets/images/scenes/"..backgroundAssets[1]..".png")
end


function changeBackgroundAsset(newfile)
	newBGToLoad = love.graphics.newImage("assets/images/scenes/"..newfile..".png")
	currentImage = newfile
	collectgarbage()
end

function fadeInNewBg(backgroundX,backgroundY)
	timeIntoTransition = timeIntoTransition+love.timer.getDelta()

	--Draw background
	currentAlpha = figureOutAlpha()
	love.graphics.setColor(255, 255, 255, currentAlpha)
	love.graphics.draw(newBGToLoad,backgroundX,backgroundY,0,globalScale,globalScale)
	love.graphics.setColor(255, 255, 255, 255)

	if(timeToTake<timeIntoTransition) then
		backgroundGraphic = newBGToLoad
		allowGameScroll = true
		runSceneTransition = false
	end
end

function figureOutAlpha()
	return timeIntoTransition/timeToTake
end

function startSceneTransition()
	runSceneTransition = true
	allowGameScroll = false
	timeIntoTransition = 0
end

function sceneTransitionReturn()
	return runSceneTransition
end