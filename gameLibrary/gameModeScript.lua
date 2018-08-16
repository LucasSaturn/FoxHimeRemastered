require "gameLibrary/dialogueBox"

allowGameScroll = true
exitDialogueShow = false

function GameModeDeclaration()
	dialogueBoxDeclaration()
	backgroundDeclaration(1)
end

function drawGameMode()
	backgroundDraw() 
	dialogueBoxDraw()
	if(exitDialogueShow==true)then drawExitDialogueBox() end
end

function updateText()
	if(allowGameScroll==true) then
		currentIndexOfGame = currentIndexOfGame+1
	end
end

