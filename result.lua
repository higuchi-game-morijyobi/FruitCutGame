
-----------------------------------------------------------------------------------------
--
-- result.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

--音の読み込み
local title_bgm=media.playSound("bgm/AQUARIUM.mp3")
local SE_SELECT = media.newEventSound("se/SE_Select.mp3")

local fruits = require("fruits")

--------------------------------------------

local screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5

local title_button= display.newImage("images/title_button.png" ,halfW, screenH*0.7)
local resultText=display.newText("りざると！",halfW, screenH*0.1,nil,48)
      resultText:setTextColor(255, 0, 0)

local ScoreText=display.newText("score:"..fruits.textscore(),halfW, screenH*0.3,nil,48)
      ScoreText:setTextColor(255, 0, 0)



function scene:create( event )

	local sceneGroup = self.view
  
--背景を設置する関数
function set_background()
  
  
  background = display.newImageRect( "images/manaita_tate.png", screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0
  background.y = 0
  
  
end
  title_button:addEventListener("touch",title_button_push)
  
  
  set_background()
	sceneGroup:insert( background )
end
--タイトル戻るを押したなら
function title_button_push(event)
    
     media.playEventSound(SE_SELECT)
     media.stopSound()
     
     composer.gotoScene( "menu","fade", 500 )
     resultText.isVisible=false
     title_button.isVisible=false
     ScoreText.isVisible =false
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		physics.stop()
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
  if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
