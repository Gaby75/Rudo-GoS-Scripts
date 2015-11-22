--[[ Rx AntiGank | MinimapHack
     Ver 0.1: Released
     Go to http://gamingonsteroids.com to Download more script. 
------------------------------------------------------------------------------------]]

require('Inspired')

---- Script Update ----
local WebLuaFile = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/MinimapHack.lua"
local WebVersion = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/MinimapHack.version"
local ScriptName = "MinimapHack.lua"
local ScriptVersion = 0.1 -- Newest Version
local CheckWebVer = require("GOSUtility").request("https://raw.githubusercontent.com",WebVersion.."?no-cache="..(math.random(100000))) -- Copy from Inspired >3
if ScriptVersion < tonumber(CheckWebVer) then
PrintChat(string.format("<font color='#00B359'>Script need update.</font><font color='#FF2626'> Waiting AutoUpdate.</font>")) 
AutoUpdate(WebLuaFile,WebVersion,ScriptName,ScriptVersion)
else
PrintChat(string.format("<font color='#FFFF26'>You are using newest Version. Don't need to update</font>")) 
end
PrintChat(string.format("<font color='#C926FF'>Script Current Version:</font><font color='#FF8000'> %s </font>| <font color='#C926FF'>Newest Version:</font><font color='#FF8000'> %s </font>", ScriptVersion, tonumber(CheckWebVer)))

PrintChat("Credits to Deftsu for MapHack, Inspired for AutoUpdate and Feretorix for Draw Minimap") 
---------------------------------------------------------------------
local speed = 0
local checktime = {}
local check = {}
local enemies = {}

---- Create Menu -----
MinimapHack = MenuConfig("Rx Minimap Hack", "MinimapHack")
MinimapHack:Boolean("circle", "Enable Draw Circle", true)
MinimapHack:ColorPick("col", "Setting Circle Color", {255, 153, 229, 255})
MinimapHack:Slider("QualiDraw", "Circle Quality", 80, 1, 255, 1)
MinimapHack:Slider("min", "Circle minium range", 300, 50, 1000, 10)
MinimapHack:Slider("max", "Circle maximum range", 5400, 4500, 6500, 10)

------ Starting -------
OnTick(function(myHero)
enemies = GetEnemyHeroes()
  for i, enemy in pairs(enemies) do
   if IsVisible(enemy) == false and IsDead(enemy) == false then
	 if check[i] == nil then
	  check[i] = GetTickCount()
     end
	 checktime[i] = (GetTickCount() - check[i])/1000
   else
   check[i] = nil
   checktime[i] = 0
  end
 end
end)

OnDrawMinimap(function() 
    for i, enemy in pairs(enemies) do
        if IsVisible(enemy) == false and IsDead(enemy) == false and check[i] ~= -1 and checktime ~= 0 then
          speed = GetMoveSpeed(enemy) * checktime[i]
           if speed >= MinimapHack.min:Value() and speed <= MinimapHack.max:Value() then
          if MinimapHack.circle:Value() then DrawCircleMinimap(GetOrigin(enemy), speed, 0, MinimapHack.QualiDraw:Value(), MinimapHack.col:Value()) end
		   end
        end
    end
end)

OnTick(function(myHero)
  for i, enemy in pairs(enemies) do
   if IsObjectAlive(enemy) and IsInDistance(enemy, 2000) then
    if GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite") then
	 DrawText("Found enemy have Smite in 2500 range",24,660,150,0xffff2626)
	end
   end
  end
end)
PrintChat(string.format("<font color='#FF0000'>Rx AntiGank | GoS MinimapHack </font><font color='#FFFF00'>Version %s: Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>", ScriptVersion)) 
