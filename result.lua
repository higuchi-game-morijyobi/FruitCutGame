
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

