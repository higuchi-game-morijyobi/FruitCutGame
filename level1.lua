level1.lua

local composer = require( "composer" )
local scene = composer.newScene()


local physics = require "physics"
physics.start(); physics.pause()




local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )

	local sceneGroup = self.view

	
	local background = display.newRect( 0, 0, screenW, screenH )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( .5 )
