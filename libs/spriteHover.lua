--Declare a function
function testMouseOver(spriteX,spriteY,spriteImageData,scaleX,scaleY,requireAlpha)
	--local variable that stores the mouse position
	local x, y = love.mouse.getPosition()
	--local variable that stores the sprite width and height
	local spriteW,spriteH = spriteImageData:getWidth(),spriteImageData:getHeight()


	--if the mouse is within the bounding box, continue
	if(x>spriteX and x<spriteX+(spriteW*scaleX) and y>spriteY and y<spriteY+(spriteH*scaleY)) then
		--where is the mouse within the sprite, in terms of texture
		localX,localY = (x-spriteX)/scaleX, (y-spriteY)/scaleY
		--at the current mouse position, is there a pixel in the texture?
		r,g,b,a = spriteImageData:getPixel(localX,localY)
	
		--if it is transparent then
		if(a==0 and requireAlpha==true) then
			return false
		else 
			return true
		end
	end

	--if the mouse isn't over, or the alpha doesn't exist
	--return false
	return false
end