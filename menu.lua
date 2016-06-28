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
