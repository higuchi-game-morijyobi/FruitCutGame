level1.lua

local composer = require( "composer" )
local scene = composer.newScene()


local physics = require "physics"
physics.start(); physics.pause()




local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
