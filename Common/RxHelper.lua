--[[ Rx Helper Version 0.124
     Ver 0.124: Added OnePuchManChibiIcon when not see enemy Kappa.
     Download Sprites Here: https://drive.google.com/file/d/0B6Je7vbhD0EaRjZmcW40UHRqM3M/view
     Go to http://gamingonsteroids.com to Download more script. 
------------------------------------------------------------------------------------]]

require('Inspired')

---- Script Update ----
--AutoUpdate("/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.lua","/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.version","RxHelper.lua",0.121)

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#8000FF'>Deftsu </font><font color='#FFFFFF'>for DAwareness, </font><font color='#5900B3'>Inspired </font><font color='#FFFFFF'>for Inspired.lua and </font><font color='#FF0000'>Feretorix</font>"))
---------------------------------------------------------------------
local seconds = {}
local check = {}
local enemies = {}
local smite = CreateSpriteFromFile("\\RxHelper\\FoundSmite.png",1)
local danger = CreateSpriteFromFile("\\RxHelper\\danger.png",1)
local Icon = CreateSpriteFromFile("\\RxHelper\\Icon3.png",1)
local human = CreateSpriteFromFile("\\RxHelper\\OPMCb.png",1)
if smite <= 0 then print("'FoundSmite.png' Not found, go to Origin topic to download Sprites.rar") end
if danger <= 0 then print("'danger.png' Not found, go to Origin topic to download Sprites.rar") end
if Icon <= 0 then print("'Icon.png' Not found, go to Origin topic to download Sprites.rar") end
if human <= 0 then print("'OPMCb.png' Not found, go to Origin topic to download Sprites.rar") end

---- Create Menu -----
RxHelper = MenuConfig("Rx Helper", "Helper")
RxHelper:Info("info7", "Minimap Icon will crashes the game, waitting...")
RxHelper:Info("info8", "Now use simple Icon.")
RxHelper:Boolean("icon", "Draw Icon Minimap", true)
RxHelper:Boolean("circle", "Draw moving circle", true)
RxHelper:Boolean("colcir", "Draw colorful circle", true)
RxHelper:Info("info", "Green color: Not found at 10s before")
RxHelper:Info("info2", "Orange color: Not found at 25s before")
RxHelper:Info("info3", "Red color: Not found > 25s before")
RxHelper:Boolean("seconds", "Draw time Minimap", true)
RxHelper:Boolean("sprite", "Draw sprite if not see enemy", true)
RxHelper:Boolean("circleA", "Draw circle if not see enemy", true)
RxHelper:Info("info4", "Draw time not found enemy on Minimap")
RxHelper:Boolean("smite", "Draw text enemy have Smite", true)
RxHelper:Info("info5", "Draw if found enemy have Smite in 2500 range")
RxHelper:Boolean("simple", "Draw text 'Dangerous!'", true)
RxHelper:Info("info6", "Check human around myHero and draw if MyTeam < EnemyTeam")
PermaShow(RxHelper.icon)
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
  
  if enemy ~= nil and NotFound(enemy) then
  local Orgenemy = WorldToScreen(1, GetOrigin(enemy))
   if human > 0 and RxHelper.sprite:Value() then DrawSprite(human, Orgenemy.x-16, Orgenemy.y-17.5, 0, 0, 32, 35, ARGB(255,255,255,255)) end
    if RxHelper.circleA:Value() then DrawCircle(GetOrigin(enemy), 80, 1, 50, ARGB(255,255,0,0)) end
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
  local ms
  if GetMoveSpeed(enemy) == 0 then ms = 325 else ms = GetMoveSpeed(enemy) end
  local speed = seconds[i]*ms +971
   if RxHelper.icon:Value() and Icon > 0 then
    DrawSprite(Icon, Orgenemy.x-10, Orgenemy.y-10, 0, 0, 20, 20, ARGB(255,255,255,255))
   end
   
   if RxHelper.colcir:Value() then
    local color
    if seconds[i] > 0 and seconds[i] < 12 then
     color = ARGB(255,0,255,127)
    elseif seconds[i] >= 12 and seconds[i] < 25 then
     color = ARGB(255,255,127,36)
    else
     color = ARGB(255,255,0,0)
    end
     DrawCircleMinimap(GetOrigin(enemy), 970, 1, 80, color)
   end
	
   if RxHelper.circle:Value() then
    if speed < 5800 then DrawCircleMinimap(GetOrigin(enemy), speed, 1, 80, ARGB(255,0,245,255)) end
   end
   
   if RxHelper.seconds:Value() then DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-7.5, Orgenemy.y+7.3, ARGB(255,255,255,0)) DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-7.5, Orgenemy.y+7.3, ARGB(160,255,255,0)) end
  end
 end
end)

function NotFound(enemy)
    return IsDead(enemy) == false and IsVisible(enemy) == false
end

PrintChat(string.format("<font color='#FF0000'>Rx Helper </font><font color='#FFFF00'>Version 0.124 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck </font><font color='#CD2990'>%s</font>",GetObjectBaseName(myHero))) 
