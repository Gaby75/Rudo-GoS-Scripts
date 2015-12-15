--[[ Rx Helper Version 0.11
     Ver 0.11: Added Minimap Icons
	 Download Sprites Here: https://drive.google.com/file/d/0B6Je7vbhD0EaRjZmcW40UHRqM3M/view
     Go to http://gamingonsteroids.com to Download more script. 
------------------------------------------------------------------------------------]]

require('Inspired')

---- Script Update ----
AutoUpdate("/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.lua","/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.version","RxHelper.lua",0.11)

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#8000FF'>Deftsu </font><font color='#FFFFFF'>for DAwareness, </font><font color='#5900B3'>Inspired </font><font color='#FFFFFF'>for Inspired.lua and </font><font color='#FF0000'>Feretorix</font>"))
---------------------------------------------------------------------
local seconds = {}
local check = {}
local enemies = {}
local smite = CreateSpriteFromFile("\\RxHelper\\FoundSmite.png")
local danger = CreateSpriteFromFile("\\RxHelper\\danger.png")

---- Create Menu -----
RxHelper = MenuConfig("Rx Helper", "Helper")
RxHelper:Boolean("sprites", "Draw Enemy Icon On Minimap", true)
RxHelper:Boolean("seconds", "Draw time Minimap", true)
RxHelper:Info("time", "Draw time not found enemy on Minimap")
RxHelper:Boolean("smite", "Draw text enemy have Smite", true)
RxHelper:Info("info6", "Draw if found enemy have Smite in 2500 range")
RxHelper:Boolean("simple", "Draw text 'Dangerous!'", true)
RxHelper:Info("info6", "Check human around myHero and draw if MyTeam < EnemyTeam")
PermaShow(RxHelper.seconds)

------ Starting -------
OnTick(function(myHero)
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

OnDraw(function(myHero)
 for i, enemy in pairs(enemies) do
  if IsObjectAlive(enemy) and IsVisible(enemy) and IsInDistance(enemy, 2500) and RxHelper.smite:Value() then
   if GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite") then
    if smite > 0 then DrawSprite(smite, 900, 67, 0, 0, 400, 51, ARGB(255,255,255,255)) else print("'FoundSmite.png' Not found, go to Origin topic to download Sprites") end
   end
  end
 end

 if EnemiesAround(myHeroPos(), 3500) > AlliesAround(myHeroPos(), 2500) +1 and RxHelper.simple:Value() then
 local Org = WorldToScreen(1, myHeroPos())
  if danger > 0 then
   DrawSprite(danger, Org.x-80, Org.y+12, 0, 0, 140, 28, ARGB(255,255,255,255))
  else
   print("'danger.png' Not found, go to Origin topic to download Sprites")
  end
 end
end)

OnDrawMinimap(function()
 for i, enemy in pairs(enemies) do
  if enemy ~= nil and NotFound(enemy) then
  local sprites = CreateSpriteFromFile("\\RxHelper\\"..GetObjectName(enemy).."_GoS_MiniMH.png")
  local Orgenemy = WorldToMinimap(GetOrigin(enemy))
   if RxHelper.sprites:Value() and sprites > 0 then
    DrawSprite(sprites, Orgenemy.x-10, Orgenemy.y-10, 0, 0, 20, 20, ARGB(255,255,255,255))
   else
    PrintChat("("..GetObjectName(enemy).."_GoS_MiniMH.png) Not found, go to Origin topic to download Sprites.\n")
   end
   
   if RxHelper.seconds:Value() then DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-5, Orgenemy.y+6, ARGB(255,255,255,255)) end
  end
 end
end)

function NotFound(enemy)
    return IsDead(enemy) == false and IsVisible(enemy) == false
end

PrintChat(string.format("<font color='#FF0000'>Rx Helper </font><font color='#FFFF00'>Version 0.11 Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
print("Recommend use with DAwaraness")
