-- fruits.lua
-- 呪文　fruits モジュール  ...はこのファイルのこと
module(..., package.seeall)

-- ランダムの種を時間に設定する
math.randomseed( os.time() )

-- 物理エンジンを導入
physics = require "physics"

-- 画像フォルダ
IMAGE_DIR = "images/"

-- 効果音フォルダ
SE_DIR = "se/"

-- 効果音を読み込む
local SE_Cut1 = audio.loadSound(SE_DIR.."SE_Cut1.mp3")
local SE_Cut2 = audio.loadSound(SE_DIR.."SE_Cut2.mp3")

--▲▲▲--こっから--▲▲▲
local SE_Ex1 = audio.loadSound(SE_DIR.."SE_Explosion1.mp3")
local SE_Ex2 = audio.loadSound(SE_DIR.."SE_Explosion2.mp3")
--▲▲▲--ここまで--▲▲▲

--グループ作成
local myGroup = display.newGroup()

--コンボ
local combo = 0
local comboFlg = false

bom = false

--スコア
local score=0
-- スコアの初期設定をする
function setScore()
   --scoreで与えられた得点と表示させる
     tfScoreDisplay = display.newText("score:"..score,display.contentWidth *0.75 , display.contentHeight*0.05,native.systemFont,30)
       tfScoreDisplay.align = "right"
         
	   return  tfScoreDisplay
	   end

