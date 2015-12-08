--[[ Rx Helper Version 0.11
     Ver 0.11: Released
     Go to http://gamingonsteroids.com to Download more script. 
------------------------------------------------------------------------------------]]

require('Inspired')

---- Script Update ----
local WebLuaFile = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.lua"
local WebVersion = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/RxHelper.version"
local ScriptName = "RxHelper.lua"
local ScriptVersion = 0.11
local CheckWebVer = require("GOSUtility").request("https://raw.githubusercontent.com",WebVersion.."?no-cache="..(math.random(100000))) -- Copy from Inspired <3
AutoUpdate(WebLuaFile,WebVersion,ScriptName,ScriptVersion)
PrintChat(string.format("<font color='#C926FF'>Script Current Version:</font><font color='#FF8000'> %s </font>| <font color='#C926FF'>Newest Version:</font><font color='#FF8000'> %s </font>", ScriptVersion, tonumber(CheckWebVer)))

if not FileExist(SCRIPT_PATH.."\\DAwareness.lua") then
    print("Go to http://gamingonsteroids.com/topic/8815-d3utility-dawareness to download it and put in script folder then load script again.")
else
    require('DAwareness')
end
if not pcall(require, "DAwareness" ) then return end

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#8000FF'>Deftsu </font><font color='#FFFFFF'>for DAwareness and </font><font color='#5900B3'>Inspired </font><font color='#FFFFFF'>for Inspired.lua</font>"))
---------------------------------------------------------------------
local seconds = {}
local check = {}
local enemies = {}

---- Create Menu -----
RxHelper = MenuConfig("Rx Helper", "Helper")
RxHelper:Menu("circle", "Draw Circle")
RxHelper.circle:Boolean("CircleEnable", "Enable Draw Circle", true)
RxHelper.circle:ColorPick("col1", "Circle Color 1 (Default: Green)", {255, 0, 255, 127})
RxHelper.circle:ColorPick("col2", "Circle Color 2 (Default: Orange)", {255, 255, 127, 0})
RxHelper.circle:ColorPick("col3", "Circle Color 3 (Default: Red)", {255, 255, 0, 0})
RxHelper.circle:Info("info1", "Color 1: Not found enemy in the past 10s")
RxHelper.circle:Info("info2", "Color 1: Not found enemy in the past 20s")
RxHelper.circle:Info("info3", "Color 1: Not found enemy in the past > 20s")
RxHelper.circle:Slider("QualiDraw", "Circle Quality", 80, 1, 255, 1)
RxHelper.circle:Info("info4", "Circle Highest Quality: 1")
RxHelper:Menu("texts", "Draw Texts")
RxHelper.texts:Boolean("seconds", "Draw time Minimap", true)
RxHelper.texts:Info("time", "Draw time not found enemy on Minimap")
RxHelper.texts:Boolean("smite", "Draw text enemy have Smite", true)
RxHelper.texts:Info("info6", "Draw if found enemy have Smite in 2500 range")
RxHelper.texts:Boolean("simple", "Draw text 'Dangerous!'", true)
RxHelper.texts:Info("info6", "Check human around myHero and draw if MyTeam < EnemyTeam")
PermaShow(RxHelper.circle.CircleEnable)
PermaShow(RxHelper.texts.seconds)

------ Starting -------
OnTick(function(myHero)
enemies = GetEnemyHeroes()
  for i, enemy in pairs(enemies) do
   if IsVisible(enemy) == false and IsDead(enemy) == false then
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
  if IsObjectAlive(enemy) and IsVisible(enemy) and IsInDistance(enemy, 2500) and RxHelper.texts.smite:Value() then
   if GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite") then
    DrawText("Found enemy have Smite in 2500 range",24,660,150,0xffff2626)
   end
  end
 end
 
 if EnemiesAround(myHeroPos(), 3500) > AlliesAround(myHeroPos(), 2500) +1 and RxHelper.texts.simple:Value() then
   DrawText("Dangerous!", 23, WorldToScreen(1, myHeroPos()).x, WorldToScreen(1, myHeroPos()).y+22, ARGB(255, 255, 0, 0))
 end
end)

OnDrawMinimap(function() 
    for i, enemy in pairs(enemies) do
        if enemy ~= nil and not IsDead(enemy) and IsVisible(enemy) == false then
          local DeftCheck = GetMoveSpeed(enemy)*seconds[i]
		  local color
          if seconds[i] < 10 then
		  color = RxHelper.circle.col1:Value()
		  elseif seconds[i] >= 10 and seconds[i] < 20 then
		  color = RxHelper.circle.col2:Value()
		  else
		  color = RxHelper.circle.col3:Value()
          end
		  local time = WorldToMinimap(GetOrigin(enemy))
          if DeftCheck > 1100 and RxHelper.circle.CircleEnable:Value() then DrawCircleMinimap(GetOrigin(enemy), 1100, 1, RxHelper.circle.QualiDraw:Value(), color) end
		  if RxHelper.texts.seconds:Value() then DrawText(math.floor(seconds[i]).."s", 12, time.x-8, time.y-6, ARGB(255,255,255,255)) end
        end
    end
end)

PrintChat(string.format("<font color='#FF0000'>Rx Helper </font><font color='#FFFF00'>Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
