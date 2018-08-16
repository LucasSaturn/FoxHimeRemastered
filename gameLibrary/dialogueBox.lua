require "libs/spriteTransparencySet"

local dialogueBoxGraphic
local backgrounds = require('gameLibrary/backgrounds')
local spriteHover = require('libs/spriteHover')

local data = require('saveFiles/textVariables')


hasTextFinishedLoading = true

currentIndexOfGame = 1

local function TestButtonHover(spriteX,spriteY,spriteW,spriteH)
	if(exitDialogueShow==false)then


		if(testMouseOver(spriteX,spriteY,b1,spriteW,spriteH,true)) then love.graphics.draw(_b1,spriteX,spriteY,0,0.8*globalScale,0.8*globalScale)     allowGameScroll = false
		elseif(testMouseOver(spriteX,spriteY,b2,spriteW,spriteH,true)) then love.graphics.draw(_b2,spriteX,spriteY,0,0.8*globalScale,0.8*globalScale) allowGameScroll = false

		--if the home button is being hovered over
		elseif(testMouseOver(spriteX,spriteY,b3,spriteW,spriteH,true)) then 
			love.graphics.draw(_b3,spriteX,spriteY,0,0.8*globalScale,0.8*globalScale) 
			allowGameScroll = false

			if(love.mouse.isDown(1))then
				exitDialogueShow = true
			end



		elseif(testMouseOver(spriteX,spriteY,b4,spriteW,spriteH,true)) then love.graphics.draw(_b4,spriteX,spriteY,0,0.8*globalScale,0.8*globalScale) allowGameScroll = false
		elseif(testMouseOver(spriteX,spriteY,b5,spriteW,spriteH,true)) then love.graphics.draw(_b5,spriteX,spriteY,0,0.8*globalScale,0.8*globalScale) allowGameScroll = false
		elseif(testMouseOver(spriteX,spriteY,b6,spriteW,spriteH,true)) then love.graphics.draw(_b6,spriteX,spriteY,0,0.8*globalScale,0.8*globalScale) allowGameScroll = false
		elseif(sceneTransitionReturn()==false) then  allowGameScroll = true
		end


	end

end



--open function to draw items onscreen
function dialogueBoxDraw()
	--Declare variables to handle dialogue box position
	dialogueBoxX = (screenX-(dialogueBoxGraphic:getWidth()*globalScale))/2
	dialogueBoxY = (returnBackgroundYPos("yPos")+returnBackgroundYPos("height"))-(dialogueBoxGraphic:getHeight()*globalScale)

	--Draw dialogue box
	love.graphics.draw(dialogueBoxGraphic,dialogueBoxX,dialogueBoxY,0,1*globalScale,1*globalScale)
	--Draw hide button
	local HideUIX,HideUIY = dialogueBoxX+(1140*globalScale),dialogueBoxY+(21*globalScale)
	love.graphics.draw(hideUIButton,HideUIX,HideUIY,0,1*globalScale,1*globalScale)



	--draw next string icon
	local NextStrX,NextStrY = dialogueBoxX+(990*globalScale),dialogueBoxY+(205*globalScale)
	love.graphics.draw(nextStringButton,NextStrX,NextStrY,0,0.5*globalScale,0.5*globalScale)


	--draw buttons base
	local baseButtonsX,baseButtonsY = dialogueBoxX+(1080*globalScale),dialogueBoxY+(94*globalScale)
	love.graphics.draw(baseButtons,baseButtonsX,baseButtonsY,0,0.8*globalScale,0.8*globalScale)
	TestButtonHover(baseButtonsX,baseButtonsY,
		0.8*globalScale,
		0.8*globalScale)



	--render the text within the dialogue box
	feedInTextData()
end


function feedInTextData()
	if(currentImage~=backgroundAssets[sceneChanges[currentIndexOfGame]])then
		startSceneTransition()
		changeBackgroundAsset(backgroundAssets[sceneChanges[currentIndexOfGame]])
	end

	nameColours   = {{0.2,0.2,0.2},
	{0.054,0.615,0.556},
	{0.075,0.376,0.784}}

	characterNameColour = {1,1,1}

	if(characterNames[currentIndexOfGame]=="???") then characterNameColour = nameColours[1] 
	elseif(characterNames[currentIndexOfGame]=="Mori") then characterNameColour = nameColours[2] 
	elseif(characterNames[currentIndexOfGame]=="Yan") then characterNameColour = nameColours[3] 
	end


	renderText(characterNameColour,characterNames[currentIndexOfGame], gameStrings[currentIndexOfGame],"")
end


function renderText(characterColour,characterName,stringToPrintA,stringToPrintB)
	--render character name
	love.graphics.setFont(NotoSansHansReg)
	local charNameX,charNameY = dialogueBoxX+(236*globalScale),dialogueBoxY+(70*globalScale)
	--PRINT MORI'S COLOUR FOR THE TIME BEING
	love.graphics.setColor(characterColour)
	love.graphics.print(characterName, charNameX, charNameY,
		0,globalScale,globalScale)
	love.graphics.setColor(1,1,1)





	--render character text
	--render character name
	love.graphics.setFont(NotoSansHansReg)
	local charTextX,charTextY = dialogueBoxX+(260*globalScale),dialogueBoxY+(107*globalScale)
	--print text white
	love.graphics.setColor(1,1,1)
	love.graphics.print(stringToPrintA, charTextX, charTextY,
		0,globalScale*0.9,globalScale*0.9)
end




function dialogueBoxDeclaration()
	--Declare dialogue box graphic
	dialogueBoxGraphic = love.graphics.newImage("assets/images/textbox.png")
	hideUIButton  = love.graphics.newImage("assets/images/hideUI.png")
	nextStringButton  = love.graphics.newImage("assets/images/nextTextButton.png")
	baseButtons  = love.graphics.newImage("assets/images/UI/buttonsTrans.png")


	--declare ImageData for all the onscreen buttons
	b1,b2,b3,b4,b5,b6 = love.image.newImageData("assets/images/UI/button_1.png"),
	love.image.newImageData("assets/images/UI/button_2.png"),
	love.image.newImageData("assets/images/UI/button_3.png"),
	love.image.newImageData("assets/images/UI/button_4.png"),
	love.image.newImageData("assets/images/UI/button_5.png"),
	love.image.newImageData("assets/images/UI/button_6.png")

	_b1,_b2,_b3,_b4,_b5,_b6 = love.graphics.newImage("assets/images/UI/button_1.png"),
	love.graphics.newImage("assets/images/UI/button_2.png"),
	love.graphics.newImage("assets/images/UI/button_3.png"),
	love.graphics.newImage("assets/images/UI/button_4.png"),
	love.graphics.newImage("assets/images/UI/button_5.png"),
	love.graphics.newImage("assets/images/UI/button_6.png")



	exitDialogueBoxGraphic = love.graphics.newImage("assets/images/onScreenDialogue.png")
	blackout = love.graphics.newImage("assets/images/blackout.png")


	--declare a new font
	NotoSansHansReg = love.graphics.newFont("assets/fonts/NotoSansHans-Regular.otf", 24)
end





function drawExitDialogueBox()
	--Declare variables to handle dialogue box position
	local exitX = (screenX-(exitDialogueBoxGraphic:getWidth()*globalScale))/2
	local exitY = (screenY-(exitDialogueBoxGraphic:getHeight()*globalScale))/2

	spriteTransparency(0.5)
	love.graphics.draw(blackout,0,0,0,1*globalScale,1*globalScale)
	spriteTransparency(1)

	--Draw dialogue box
	love.graphics.draw(exitDialogueBoxGraphic,exitX,exitY,0,1*globalScale,1*globalScale)
	
end
