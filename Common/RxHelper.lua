--[[ Rx Helper Version 0.121
     Ver 0.122: Fix error
     Ver 0.121: Delete Minimap Icon because crashes the game, add draw circle.
     Download Sprites Here: https://drive.google.com/file/d/0B6Je7vbhD0EaRjZmcW40UHRqM3M/view
     Go to http://gamingonsteroids.com to Download more script. 
------------------------------------------------------------------------------------]]

require('Inspired')

---- Script Update ----
AutoUpdate("/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.lua","/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.version","RxHelper.lua",0.121)

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#8000FF'>Deftsu </font><font color='#FFFFFF'>for DAwareness, </font><font color='#5900B3'>Inspired </font><font color='#FFFFFF'>for Inspired.lua and </font><font color='#FF0000'>Feretorix</font>"))
---------------------------------------------------------------------
local seconds = {}
local check = {}
local enemies = {}
local smite = CreateSpriteFromFile("\\RxHelper\\FoundSmite.png")
local danger = CreateSpriteFromFile("\\RxHelper\\danger.png")
if smite <= 0 then print("'FoundSmite.png' Not found, go to Origin topic to download Sprites") end
if danger <= 0 then print("'danger.png' Not found, go to Origin topic to download Sprites") end

---- Create Menu -----
RxHelper = MenuConfig("Rx Helper", "Helper")
RxHelper:Info("info7", "Minimap Icon will crashes the game, waitting...")
RxHelper:Info("info8", "Now use draw circle minimap.")
RxHelper:Boolean("sprites", "Draw Circle Minimap", true)
RxHelper:ColorPick("col1", "Color 1 Default:Green", {255, 0, 255, 127})
RxHelper:ColorPick("col2", "Color 2 Default:Orange", {255, 255, 140, 0})
RxHelper:ColorPick("col3", "Color 3 Default:Red", {255, 255, 0, 0})
RxHelper:Info("info1", "Circle Color1: If not found enemy < 12s")
RxHelper:Info("info2", "Circle Color2: If not found enemy < 25s")
RxHelper:Info("info3", "Circle Color2: If not found enemy >= 25s")
RxHelper:Boolean("seconds", "Draw time Minimap", true)
RxHelper:Info("info4", "Draw time not found enemy on Minimap")
RxHelper:Boolean("smite", "Draw text enemy have Smite", true)
RxHelper:Info("info5", "Draw if found enemy have Smite in 2500 range")
RxHelper:Boolean("simple", "Draw text 'Dangerous!'", true)
RxHelper:Info("info6", "Check human around myHero and draw if MyTeam < EnemyTeam")
PermaShow(RxHelper.sprites)
PermaShow(RxHelper.seconds)

------ Starting -------
OnTick(function()
enemies = GetEnemyHeroes()
  for i, enemy in pairs(enemies) do
   if NotFound(enemy) then
	 if check[i] == nil then
	  check[i] = GetTickCount()
     end
	 seconds[i] = (GetTickCount() - check[i])/1000
   else
    check[i] = nil
    seconds[i] = 0
   end
  end
end)

OnDraw(function()
 for i, enemy in pairs(enemies) do
  if IsObjectAlive(enemy) and IsVisible(enemy) and IsInDistance(enemy, 2500) and RxHelper.smite:Value() then
   if GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite") then
    if smite > 0 then DrawSprite(smite, 940, 80, 0, 0, 400, 44, ARGB(255,255,255,255)) end
   end
  end
 end

 if EnemiesAround(myHeroPos(), 3500) > AlliesAround(myHeroPos(), 2500) +1 and RxHelper.simple:Value() then
 local Org = WorldToScreen(1, myHeroPos())
  if danger > 0 then
   DrawSprite(danger, Org.x-70, Org.y+25, 0, 0, 140, 28, ARGB(255,255,255,255))
  end
 end
end)

OnDrawMinimap(function()
 for i, enemy in pairs(enemies) do
  if enemy ~= nil and NotFound(enemy) then
  local Orgenemy = WorldToMinimap(GetOrigin(enemy))
   if RxHelper.sprites:Value() then
   local speed = seconds[i]*GetMoveSpeed(enemy)
   local color
    if seconds[i] < 12 then
     color = RxHelper.col1:Value()
    elseif seconds[i] >= 12 and seconds[i] < 25 then
     color = RxHelper.col2:Value()
    else
     color = RxHelper.col3:Value()
    end
     if speed > 0 and speed <= 5800 then DrawCircleMinimap(GetOrigin(enemy), speed, 1, 80, ARGB(255,0,245,255)) end
	 if speed > 1050 or (speed <= 0 and seconds[i] > 0) then DrawCircleMinimap(GetOrigin(enemy), 1050, 1, 80, color) end
   end
   
   if RxHelper.seconds:Value() then DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-9, Orgenemy.y-9, ARGB(255,255,255,255)) end
  end
 end
end)

function NotFound(enemy)
    return IsDead(enemy) == false and IsVisible(enemy) == false
end

PrintChat(string.format("<font color='#FF0000'>Rx Helper </font><font color='#FFFF00'>Version 0.121 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck </font><font color='#CD2990'>%s</font>",GetObjectBaseName(myHero))) 
