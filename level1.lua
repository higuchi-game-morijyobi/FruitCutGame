level1.lua

local fruits = require("fruits")

--■■BGM音声を再生するAPI■■  タイトル
local title_bgm = media.playSound("bgm/alno9.wma")

local composer = require( "composer" )
local scene = composer.newScene()


local physics = require "physics"
physics.start(); physics.pause()

-- 物理エンジンをスタート
physics.start()
--●重力を設定●
physics.setGravity(0,9)
-- 物理エンジンを一時停止
physics.pause()
-- 物理エンジンの表示モード
physics.setDrawMode("hybrid")

bom = false


local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )

	local sceneGroup = self.view

     function setbackground()
	
	local background = display.newImageRect( IMAGE_DIR.."kittin.png", screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0
	background.y = 0

	grass = display.newImageRect( IMAGE_DIR.."manaita.png", screenW, 82 )
	grass.anchorX = 0
	grass.anchorY = 1
	grass.x, grass.y = 0, display.contentHeight
	
	local grassShape = { -halfW,-grass.contentHeight/2, halfW,-grass.contentHeight/2, halfW,grass.contentHeight/2, -halfW,grass.contentHeight/2}

end
setbackground()
--◆o◆左右の透明なかべ◆o◆

function setwall()
  	w1 = display.newRect(0, display.contentHeight / 2, 5, display.contentHeight)
  	w1:setFillColor(255, 0, 0)
  	w2 = display.newRect(display.contentWidth, display.contentHeight / 2, 5, display.contentHeight)
  	w2:setFillColor(255, 0, 0)
       
       return setwall
     end
       local wall = setwall()

      --〒score表示の初期設定〒
      fruits.setScore()

	sceneGroup:insert( background )
	sceneGroup:insert( grass)
	end

	local timerIcon = display.newImage("images/clock.png",display.contentWidth * 0.1, display.contentHeight * 0.1)
 
	local CountDownTimer = 30
 
	local  time_limit = CountDownTimer
 
	local timerLabel = display.newText(CountDownTimer,display.contentWidth*0.25 ,display.contentHeight*0.1 ,nil,36)
timerLabel:setTextColor(255, 0, 0)
 
	--　残り時間を減らす関数
	local function timeCheck()
   
   	CountDownTimer = CountDownTimer-1
  		if CountDownTimer>=10 then
    			timerLabel.text = CountDownTimer
  		elseif (CountDownTimer>0) then
     			timerLabel.text = "0" .. CountDownTimer
  		elseif (CountDownTimer==0) then
    			timerLabel.text = "0" .. CountDownTimer
  		end  
	end

	--1秒ごとにtimeCheck関数を呼び出す　呼び出し間隔、呼び出すfunction名、繰返し回数:time_limit
	GameTimer1 = timer.performWithDelay (1000,timeCheck,time_limit)

 -- 1秒ごとに実行される関数　　
  function update(event)
    print(os.clock())
    
    --ランダムなx位置に出現
    local fruit = fruits.newFruit()
    
    print(fruits.bom)
    
      if (fruits.bom == true) then
        local x = 0
        print("ゆれてー")
              
        local function listener1( obj )
           transition.to(background,{time=100,x = -30})
           transition.to(background,{time=100,x = 0})
          end
          local function listener2( obj )
            transition.to(background,{time=100,x = 0})
            end
          
          transition.to(background,{time=100,x = 30,onComplete=listener1  })
          
          x = x + 1
          print("ゆれろー")
        
        fruits.bom = false
        print(bom)
      end
        
    end
  tm = timer.performWithDelay(1500,update,0) 


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
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end


function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
