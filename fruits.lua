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

-- スコアを加算しスコア・コンボを表示する
function addScore(point)
  
		score = score + point + (combo * 10)
	tfScoreDisplay.text = "score:"..score
	--◆◆◆６．コンボによるスコア変化
	if combo == 1 then
		comboDisplay = display.newText((combo+1).."コンボ",
		display.contentWidth * 0.8, display.contentHeight * 0.15, native.systemFont, 30)
		comboFlg = true
	elseif combo > 1 then
		comboDisplay.text = (combo+1).."コンボ"
	end
					       
     return score
end

function textscore()
  return score
end

local function removeFruit(event)
  
  local params = event.source.params
  local fruit = params.fruit
     
       -- 移動などのアニメーションを停止する
       transition.cancel(fruit.L)
       transition.cancel(fruit.R)
       -- 自分自身を削除する
       display.remove(fruit)
       fruit = nil
        
end

function newFruit()
 fruit = display.newGroup()
  
   --出現位置設定
       fruit.x = display.contentWidth * 0.1 + display.contentWidth * 0.05 * math.random(0, 5)
           fruit.y = display.contentHeight
	    fruit02 = display.newGroup()
	        fruit02.x = display.contentWidth * 0.7 + display.contentWidth * 0.05 * math.random(0, 5)
		    fruit02.y = display.contentHeight
		     
		      local type = math.random(1,16)
		       --果物の種類
		        fruit.type = type
			 fruit02.type = type
			  
			   local left = IMAGE_DIR..string.format("fruit%d.png",type*2-1)
			    local right = IMAGE_DIR..string.format("fruit%d.png",type*2)
			     
			      fruit.L = display.newImageRect(fruit,left,32,64)
			       fruit.R = display.newImageRect(fruit,right,32,64)
			        
				 fruit.L.anchorX,fruit.L.anchorY = 1,0.5
				  fruit.R.anchorX,fruit.R.anchorY = 0,0.5
				   
				    fruit.L.x,fruit.L.y = x, y
				     fruit.R.x,fruit.R.y = x, y
				      
				       fruit02.L = display.newImageRect(fruit02,left,32,64)
				       fruit02.R = display.newImageRect(fruit02,right,32,64)

				       fruit02.L.anchorX,fruit02.L.anchorY = 1, 0.5
				       fruit02.R.anchorX,fruit02.R.anchorY = 0, 0.5

				       fruit02.L.x, fruit02.L.y = x, y
				       fruit02.R.x, fruit02.R.y = x, y
				        
					 physics.addBody(fruit,{radius=10,filter=physicsGroupFruit} )
					  
					   --ベクトル速度
					    fruit:setLinearVelocity(math.random(30,50),-1*math.random(450,500))
					     
					      --フルーツをタッチしたらonFruitを呼ぶ
					       fruit:addEventListener("touch",onFruit)
					        
						 --myGroupにmyImageを挿入
						  myGroup:insert(fruit)
						   
						      --円の剛体をボールに
						        physics.addBody(fruit02,{radius = 10, filter = physicsGroupFruit})
							  --ベクトル速度
							    fruit02:setLinearVelocity( math.random(-50, -30),-1 * math.random(450, 500))

							      --果物タッチで呼び出し
							        fruit02:addEventListener("touch", onFruit)
								  
								    --myGroupにmyImageを挿入
								      myGroup:insert(fruit02)
								       
								        print(myGroup.numChildren)
									 
									 return fruit

									 end
