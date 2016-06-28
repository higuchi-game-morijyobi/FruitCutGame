------------------------------------------
--
--menu.lua
--
-------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn

local title_bgm=media.playSound("bgm/main.wav")
local se_decide=media.newEventSound("se/decide.wav")
--クリック音再生
local function onPlayBtnRelease()
media.playEventSound(se_decide)
media.stopSound()
composer.gotoScene( "level1", "fade", 500 )

return true	
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("images/fruits_sarada.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	local titleLogo = display.newImageRect( "images/Game2.png", 264, 42 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 100
	
	playBtn = widget.newButton{
		label="Play Now",
		labelColor = { default={255}, over={128} },
		defaultFile="images/button.png",
		overFile="images/button-over.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease
	}
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 125
	
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playBtn )
end

function scene:show( event )
local sceneGroup = self.view
local phase = event.phase
		
if phase == "will" then
elseif phase == "did" then
end	
end
