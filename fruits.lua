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

-- 果物をタッチした時の動作
function onFruit(event)
  -- タッチし終えたとき
  if("ended" == event.phase) then
      -- タッチしたスプライトを取得する
          local fruit = event.target 
	      
	          
--◆◆◆２．爆弾をタッチ時の動作
        if fruit ~= nil and fruit.type == 16 then
			        
        score = math.floor(score / 2)
        tfScoreDisplay.text = score
        bom = true
							        
        exeffect = display.newImageRect(IMAGE_DIR.."Explosion.png",64,64)
        exeffect.x = fruit.x
        exeffect.y = fruit.y
        transition.to(exeffect,{time=500,xScale=3,yScale=3})
        transition.to(exeffect,{time = 500,alpha=0,delay=500})

--爆発SE
        if(math.random(1,2)==1)then
            audio.play(SE_Ex1)
          else
            audio.play(SE_Ex2)
            end

            print("MISS")
        end

     transition.to(fruit.L,{time = 500,rotation=-25,alpha=0.8 ,x=-100})
     transition.to(fruit.R,{time = 500,rotation= 25,alpha=0.8 ,x=100})

--斬るエフェクト
         effect = display.newImageRect(IMAGE_DIR.."effectCut.png",64,64)

         effect.x = fruit.x
         effect.y = fruit.y

           effect.rotation = math.random(60)-30

           transition.to(effect,{time=500,xScale=3,yScale=3})

           transition.to(effect,{time = 500,alpha=0,delay=500})
--爆発音
       if(math.random(1,2)==1)then
         audio.play(SE_Cut1)
       else
         audio.play(SE_Cut2)
      end

--◆◆◆４．フルーツごとに点数を変更
         if fruit ~= nil and (fruit.type == 1 or fruit.type == 5 or fruit.type == 9 
         or fruit.type == 11 or fruit.type == 12 or fruit.type == 14) then
         addScore(5)
       combo = combo + 1
         elseif fruit ~= nil and (fruit.type == 3 or fruit.type == 4 or fruit.type == 7
         or fruit.type == 10 or fruit.type == 13) then
         addScore(10)
       combo = combo + 1
         elseif fruit ~= nil and (fruit.type == 2 or fruit.type == 6 or fruit.type == 8
         or fruit.type == 15) then
         addScore(15)
       combo = combo + 1
       elseif fruit ~= nil and fruit.type == 16 then
-- コンボ数初期化&爆弾タッチ時処理
        combo = 0
      score = math.floor(score/2)
            tfScoreDisplay.text = "score:"..score

	if comboFlg == true then
          comboDisplay.text = false
        end
            print("bom")
        end

    print("コンボ数" ..combo)
--イベントに反応しないようにする
     fruit:removeEventListener("touch",onFruit)

--大体の処理が終わった頃(2000ms後)、消去
      local tm = timer.performWithDelay(1000,removeFruit)
         tm.params = {fruit = event.target}


        end  
 end

 --剛体グループの設定　果物はグループ番号2,果物が干渉する剛体は1と4
 physicsGroupFruit = {categoryBits=2,maskBits=5}

 -- 座標(x,y)に果物を生成する関数
 -- ◆◆◆５．いろんな方向から果物飛ばす

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

function update(event)
  
    for i=1,myGroup.numChildren do
        local child = myGroup[i]
    if child~=nul and (child.x > display.contentWidth or child.y >display.contentHeight) then
          transition.cancel(child.L)
        transition.cancel(child.R)
			      
--自分を削除
          display.remove(child)
        child=nil
      print("remove?"..i.."")
           end
     end
end
--

function Visible()
  myGroup.isVisible=false
    tfScoreDisplay.isVisible =false
      if comboFlg == true then
          comboDisplay.isVisible = false
	    end
	    end


	    tm = timer.performWithDelay(500,update,0)
