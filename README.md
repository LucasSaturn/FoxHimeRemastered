## FoxHimeRemastered

######Project description
A remaster project of the FoxHime visual novel, written in Love2D. This utilizes assets from the original visual novel, but with completely remastered dialogue, and higher resolution assets.

##How to use the source code

######Basic information
The code is currently in early development, using the NeptuneNovelEngine. This engine is built upon Love2D, and as such is programmed in Lua. 

None of the code is currently commented, but this will be ammended in a later build.

##Libraries utilized

######SpriteHover.Lua

This script allows Love2D to test whether a mouse is hovering over an object. This basically declutters the code, so a single function can be run, rather than testing each object with different code.

https://github.com/LucasSaturn/spriteHover.lua

######spriteTransparencySet.Lua

This script is a simple 3 line function to set the transparency of the draw call. This means you don't have to remember the function; it just automatically does everything for you. This script will be updated to take more parameters, so you don't have to remember to run the function twice (first to set transparency, then to reset).
