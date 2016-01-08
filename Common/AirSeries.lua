--[[ Script Update for New Inspired. ]]--

require("Inspired_new")

print("----------------------------------------------")
local seconds = {}
local check = {}
local enemies = { }
local allies = { }
local HeroesIcon = { }
local RECALLING = { }
local smite, danger, chibi, recallNormal, recallKill
local max, min, ceil, floor = math.max, math.min, math.ceil, math.floor

local AirSupportedChamps = {
    ["Sona"]      = true,
    ["Karthus"]   = true, 
    ["Zilean"]    = true
}

local UltTracker = {
    ["Ashe"]   = true,
    ["Draven"] = true,
    ["Ezreal"] = true,
    ["Jinx"]   = true
}
local SpellData = {
        ["Ashe"] = {
	Delay = 250,
	MissileSpeed = 1600,
	Width = 130
        },
        
        ["Draven"] = {
	Delay = 400,
	MissileSpeed = 2000,
	Width = 160
        },
        
        ["Ezreal"] = {
	Delay = 1000,
	MissileSpeed = 2000,
	Width = 160
        },
        
        ["Jinx"] = {
	Delay = 600,
    MissileSpeed = 1700,
	Width = 140
        } 
}

local BasePOS = { -- C-p BaseVector of Deftsu Kappa
     [SUMMONERS_RIFT] = {
	[100] = Vector(14300, 171, 14380),
	[200] = Vector(410, 182, 420)
     },

     [CRYSTAL_SCAR] = {
	[100] = Vector(13321, -37, 4163),
	[200] = Vector(527, -35, 4163)
     },
     
     [TWISTED_TREELINE] = {
	[100] = Vector(14320, 151, 7235),
	[200] = Vector(1060, 150, 7297)
     }
}
local BaseEnemy = BasePOS[GetMapID()][GetTeam(myHero)]

local enemyTeam
if GetTeam(myHero) == 100 then
 enemyTeam = 200
 PrintChat("My Champ: "..GetObjectName(myHero).." | MY TEAM: BLUE_TEAM")
else
 enemyTeam = 100
 PrintChat("My Champ: "..GetObjectName(myHero).." | MY TEAM: RED_TEAM") 
end

if UltTracker[myHero.charName] == true then
Delays = SpellData[myHero.charName].Delay/1000
Width  = SpellData[myHero.charName].Width
Speed  = SpellData[myHero.charName].MissileSpeed
end

-------------------------> END Requirement

class "AirSeries"
function AirSeries:__init()
 Callback.Add("Load", function() self:Load() end)
 Callback.Add("Draw", function() self:Drawings() end)
 Callback.Add("Tick", function() self:Tick() end)
 Callback.Add("ProcessRecall", function(unit,recall) _Awaraness:RecallProcess(unit,recall) end)
 Callback.Add("DrawMinimap", function() _Awaraness:DrawMiniMap() end)
 --Callback.Add("CreateObj", function(o) self:CreateObj(o) end)
 --Callback.Add("DeleteObj", function(o) self:DeleteObj(o) end)
 Callback.Add("UnLoad", function() self:UnLoad() end)
end

function AirSeries:Load()
 LoadIOW()
 self:CreateMenu()
 self:LoadHeroes()
 self:LoadSprite()
 self:LoadPlugins()
end

function AirSeries:CreateMenu()
  --[[ AirSeries Menu ]]--
  AirS = MenuConfig("AirS", "Air Series")
  AirS:Description("Welcome To RxAir Series | Made By: Mainto Rudo")
  AirS:Menu("RAS", "Settings")	
  AirS.RAS:Section("set", "Plugins ON/OFF")
  AirS.RAS.set:Boolean("Tracker", "Load Air Awaraness", true)
  if AirSupportedChamps[myHero.charName] == true then AirS.RAS.set:Boolean("champ", "Load Air Support Champs", true) else AirS.RAS.set:Info("info", "RxAir Series Not Supported For "..myHero.charName) end
  AirS.RAS:Section("draw", "ON/OFF Series Drawings")
  AirS.RAS.draw:Info("e1", "This Boolean Will Turn ON/OFF")
  AirS.RAS.draw:Info("e2", "Drawings Of Series Plugins. Recommened Enable")
  AirS.RAS.draw:Boolean("e3", "Enable Drawings?", true)
end

function AirSeries:LoadHeroes()
 for i, enemy in pairs(GetEnemyHeroes()) do
  table.insert(enemies, enemy)
 end

 for l, ally in pairs(GetAllyHeroes()) do
  table.insert(allies, ally)
 end
end

function AirSeries:LoadPlugins()
 if AirS.RAS.set.Tracker:Value() then _Awaraness() end
 if AirSupportedChamps[myHero.charName] == true and AirS.RAS.set.champ:Value() then
  if myHero.charName == "Sona" then
   champ = _Sona()
  elseif myHero.charName == "Karthus" then
   champ = _Karthus()
  elseif myHero.charName == "Zilean" then
   champ = _Zilean()
  end
 end
  if champ ~= nil then PrintChat(string.format("<font color=\"#00F5FF\">[Air Series] - </font><font color=\"#FFFF00\"><b>%s </b><font><font color=\"#00F5FF\">Loaded. </font>",champ.ScriptName)) end
end

function AirSeries:LoadSprite()
 if FileExist(SPRITE_PATH.."\\RxHelper\\FoundSmite.png") then smite = Sprite("RxHelper\\FoundSmite.png", 400, 51, 0, 0) else print("'FoundSmite.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\danger.png") then danger = Sprite("RxHelper\\danger.png", 400, 51, 0, 0) else print("'danger.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\OPMCb.png") then chibi = Sprite("RxHelper\\OPMCb.png", 400, 51, 0, 0) else print("'OPMCb.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\Recalling1.png") then recallNormal = Sprite("RxHelper\\Recalling1.png", 331, 52, 0, 0) else print("'Recalling1.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\Recalling2.png") then recallKill = Sprite("RxHelper\\Recalling2.png", 331, 52, 0, 0) else print("'Recalling2.png' Not Found. Download it and reload script!") end
 for i, enemy in pairs(enemies) do
  if FileExist(SPRITE_PATH.."\\RxHelper\\"..enemy.charName.."_GoS_MiniMH.png") then
   table.insert(HeroesIcon, Sprite("RxHelper\\"..enemy.charName.."_GoS_MiniMH.png", 21.6, 21.6, 0, 0, 0.4))
  else
   self:Print("'"..enemy.charName.."_GoS_MiniMH.png' Not Found. Download it and Reload script.")
  end
 end
end

function AirSeries:Drawings()
 if AirS.RAS.draw.e3:Value() then
  _Awaraness:Draws()
 end
end

function AirSeries:Tick()
  for i, enemy in pairs(enemies) do
   if self:NotFound(enemy) then
	 if check[i] == nil then
	  check[i] = os.clock()
     end
	 seconds[i] = os.clock() - check[i]
   else
    check[i] = nil
    seconds[i] = 0
   end
  end
end

--[[function AirSeries:CreateObj(o)
 _Awaraness:AddWards(o)
end

function AirSeries:DeleteObj(o)
 _Awaraness:DelWards(o)
end]]

function AirSeries:UnLoad()
 for i = 1, #HeroesIcon do 
  ReleaseSprite(HeroesIcon[i])
 end
end

function AirSeries:NotFound(unit)
 if unit.visible == false and unit.dead == false then return true else return false end
end

function AirSeries:UltiDamage(unit)
  local EnemiesInWay = CountObjectsOnLineSegment(myHero.pos, BaseEnemy, Width, GetEnemyHeroes(), enemyTeam)
  local MinionsInWay = CountObjectsOnLineSegment(myHero.pos, BaseEnemy, Width, minionManager.objects, enemyTeam)

 if myHero.charName == "Ashe" then
  return myHero:CalcMagicDamage(unit, 75 + 175*GetCastLevel(myHero,_R) + GetBonusAP(myHero))
 elseif myHero.charName == "Draven" then
  return myHero:CalcDamage(unit, 75 + 100*GetCastLevel(myHero,_R) + 1.1*(GetBonusDmg(myHero)+GetBaseDamage(myHero))) - 8*min(MinionsInWay,5)*myHero:CalcDamage(unit, 75 + 100*GetCastLevel(myHero,_R) + 1.1*(GetBonusDmg(myHero)+GetBaseDamage(myHero)))/100
 elseif myHero.charName == "Ezreal" then
  return myHero:CalcMagicDamage(unit, 200 + 150*GetCastLevel(myHero,_R) + 0.9*GetBonusAP(myHero)+GetBonusDmg(myHero)+GetBaseDamage(myHero)) - 10*min(MinionsInWay+EnemiesInWay,3)*myHero:CalcMagicDamage(unit, 200 + 150*GetCastLevel(myHero,_R) + 0.9*GetBonusAP(myHero)+GetBonusDmg(myHero)+GetBaseDamage(myHero))/100
 elseif myHero.charName == "Jinx" then
  return myHero:CalcDamage(unit, 150+100*GetCastLevel(myHero, _R)+GetBaseDamage(myHero)+GetBonusDmg(myHero)+(20+5*GetCastLevel(myHero, _R))*(unit.maxHealth-unit.health))
 else
  return 0
 end
end

class "_Awaraness"
function _Awaraness:__init()
 RAA = MenuConfig("track", "Air Awaraness")
 RAA:Description("RAS Series: Air Awaraness Loaded. HaveFun")
 
 --[[ Recall Tracker ]]
 RAA:Menu("RT", "Recall Tracker")
 RAA.RT:Section("r1", "Track with Sprite")
 RAA.RT.r1:Info("e1", "Draw sprite to check enemy recalling")
 RAA.RT.r1:Boolean("e2", "Enable", true)
 RAA.RT.r1:Info("e3", "Recall Shadow")
 RAA.RT.r1:DropDown("e4", 1, {"No Shadow", "Shadow"})
 RAA.RT:Section("r2", "Track with PrintChat")
 RAA.RT.r2:Info("e1", "PrintChat to check enemy recalling")
 RAA.RT.r2:Boolean("e2", "Enable", true)
 
 --[[ MiniMapHack ]] --
 RAA:Menu("MH", "MiniMap Checker")
 RAA.MH:Section("m1", "Hero Icons")
 RAA.MH.m1:Info("e1", "Draw MiniMap Icons at last enemy position")
 RAA.MH.m1:Boolean("e2", "Enable", true)
 RAA.MH:Section("m2", "Time not found")
 RAA.MH.m2:Info("e1", "Draw time not see enemy in MiniMap")
 RAA.MH.m2:Boolean("e2", "Enable", true)
 RAA.MH:Section("m3", "Draw Circle MiniMap")
 RAA.MH.m3:Info("e1", "Draw Moving Circle")
 RAA.MH.m3:Boolean("e2", "Enable", true)
 RAA.MH.m3:Boolean("e3", "Draw Colorful Circle", true)
 RAA.MH.m3:Info("e4", "Green color: Not found at 10s before")
 RAA.MH.m3:Info("e5", "Orange color: Not found at 25s before")
 RAA.MH.m3:Info("e6", "Red color: Not found > 25s before")
 RAA.MH.m3:Slider("e7", "Circle Quality", 255, 1, 255)
 RAA.MH.m3:Info("e8", "Highest Quality: 1")
end

function _Awaraness:Draws()
 if RAA.RT.r1.e2:Value() then self:DrawRecall() end
end

function _Awaraness:DrawRecall()
local mypos = WorldToScreen(1, myHero.pos)
local i = 0
local col1, col2, col3
if RAA.RT.r1.e4:Value() == 1 then col1 = 0xff00FF7F col2 = 0xffFF7F00 col3 = 0xffFF0000 else col1 = 0x5000FF7F col2 = 0x50FF7F00 col3 = 0x50FF0000 end
 for R, recall in pairs(RECALLING) do
 i=i+1
 local leftTime = recall.starttime - os.clock() + recall.info.totalTime/1000
 if leftTime < 0 then leftTime = 0 end
  ---- [[ Normal Champions]] ----
  if UltTracker[myHero.charName] == nil then
  recallNormal:Draw(450, 390+55*i, ARGB(255,255,255,255))
  DrawText(string.format("%s", R), 20, 456.6, 392+55*i, ARGB(255,255,255,255))
  DrawText(string.format("%s HP", ceil(recall.Champ.health)), 21, 459, 412.5+55*i, ARGB(255,255,255,255))
  if recall.info.isStart then
   DrawText(string.format("%.1fs", leftTime), 20, 608, 386+55*i, ARGB(255,255,218,185))
   FillRect(556,408.3+55*i, 211*leftTime/(recall.info.totalTime/1000), 17.5, col1)
  else
   if recall.killtime == nil then
    if min(8,recall.info.passedTime/1000) == recall.info.totalTime/1000 or recall.info.isFinish and recall.info.isStart == false then
     recall.result = "Finished"
     recall.killtime =  GetTickCount()+2000
    elseif recall.info.isFinish == false then
     recall.result = "Cancelled"
     recall.killtime =  GetTickCount()+2000
    end
   end
    DrawText(recall.result, 20, 608, 386+55*i, ARGB(255,255,218,185))
  end

  ---- [[ BaseUlti Champions ]] ----
  else

  if GetCastLevel(myHero, _R) > 0 and recall.Champ.health + recall.Champ.shieldAD + recall.Champ.hpRegen*8 < AirSeries:UltiDamage(recall.Champ) and (GetDistance(BaseEnemy)/Speed + Delays) <= recall.info.totalTime/1000 then
  recallKill:Draw(450, 390+55*i, ARGB(255,255,255,255))
  DrawText(string.format("%s", R), 20, 456.6, 392+55*i, ARGB(255,255,0,0))
  DrawText(string.format("%s HP", ceil(recall.Champ.health)), 21, 459, 412.5+55*i, ARGB(255,255,0,0))
  if recall.info.isStart then
   DrawText(string.format("%.1fs", leftTime), 20, 608, 386+55*i, ARGB(255,255,218,185))
   FillRect(556,408.3+55*i, 211*leftTime/(recall.info.totalTime/1000), 17.5, col2)
   FillRect(556+(211*(GetDistance(BaseEnemy)/Speed + Delays)/(recall.info.totalTime/1000)),408.3+55*i, 2, 17.5, col3)
  else
   if recall.killtime == nil then
    if min(8,recall.info.passedTime/1000) == recall.info.totalTime/1000 or recall.info.isFinish and recall.info.isStart == false then
     recall.result = "Finished"
     recall.killtime =  GetTickCount()+2000
    elseif recall.info.isFinish == false then
     recall.result = "Cancelled"
     recall.killtime =  GetTickCount()+2000
    end
   end
    DrawText(recall.result, 20, 608, 386+55*i, ARGB(255,255,218,185))
  end

  else
  recallNormal:Draw(450, 390+55*i, ARGB(255,255,255,255))
  DrawText(string.format("%s", R), 20, 456.6, 392+55*i, ARGB(255,255,255,255))
  DrawText(string.format("%s HP", ceil(recall.Champ.health)), 21, 459, 412.5+55*i, ARGB(255,255,255,255))
  if recall.info.isStart then
   DrawText(string.format("%.1fs", leftTime), 20, 608, 386+55*i, ARGB(255,255,218,185))
   FillRect(556,408.3+55*i, 211*leftTime/(recall.info.totalTime/1000), 17.5, col1)
  else
   if recall.killtime == nil then
    if min(8,recall.info.passedTime/1000) == recall.info.totalTime/1000 or recall.info.isFinish and recall.info.isStart == false then
     recall.result = "Finished"
     recall.killtime =  GetTickCount()+2000
    elseif recall.info.isFinish == false then
     recall.result = "Cancelled"
     recall.killtime =  GetTickCount()+2000
    end
   end
    DrawText(recall.result, 20, 608, 386+55*i, ARGB(255,255,218,185))
  end
  end
  end
   if recall.killtime ~= nil and GetTickCount() > recall.killtime then
    RECALLING[R] = nil
   end
 end
end

function _Awaraness:DrawMiniMap()
 for i, enemy in pairs(enemies) do
  if AirS.RAS.draw.e3:Value() and enemy ~= nil and AirSeries:NotFound(enemy) then
  local Orgenemy = WorldToMinimap(enemy.pos)
  local ms
  if enemy.ms == 0 then ms = 325 else ms = enemy.ms end
  local speed = seconds[i]*ms +1010
  local color
   if RAA.MH.m1.e2:Value() then HeroesIcon[i]:Draw(Orgenemy.x-10.8, Orgenemy.y-10.8, ARGB(255,255,255,255)) end

   if RAA.MH.m3.e3:Value() then
    if seconds[i] > 0 and seconds[i] < 12 then
     color = ARGB(255,0,255,127)
    elseif seconds[i] >= 12 and seconds[i] < 25 then
     color = ARGB(255,255,127,36)
    else
     color = ARGB(255,255,0,0)
    end
     DrawCircleMinimap(enemy.pos, 1000, 1, RAA.MH.m3.e7:Value(), color)
   end

   if RAA.MH.m3.e2:Value() then
    if speed < 5000 then DrawCircleMinimap(enemy.pos, speed, 1, 255, ARGB(50,0,245,255)) end
   end

   if RAA.MH.m2.e2:Value() then DrawText(floor(seconds[i]).."s", 12, Orgenemy.x-9, Orgenemy.y+9, ARGB(255,255,255,0)) DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-9, Orgenemy.y+9, ARGB(140,255,255,0))  end
  end
 end
end

function _Awaraness:RecallProcess(unit,recall)
 if unit.team ~= myHero.team then
    rec = {}
    rec.Champ = unit
    rec.info = recall
    rec.starttime = os.clock()
    rec.killtime = nil
    rec.result = nil
    RECALLING[unit.charName] = rec

  if RAA.RT.r2.e2:Value() then
   if recall.isStart then PrintChat(string.format("<font color =\"#00F5FF\">[AirSeries]: </font><font color =\"#FFA500\">(%s) </font><font color =\"#FFFFF0\">Started Recalling | HP: %s", unit.charName, ceil(unit.health)))
   else
   if min(8,recall.passedTime/1000) == recall.totalTime/1000 or recall.isFinish == true then PrintChat(string.format("<font color =\"#00F5FF\">[AirSeries]: </font><font color =\"#FFA500\">(%s) </font><font color =\"#FFFFF0\">Finished Recall", unit.charName))
   elseif recall.isFinish == false then PrintChat(string.format("<font color =\"#00F5FF\">[AirSeries]: </font><font color =\"#FFA500\">(%s) </font><font color =\"#FFFFF0\">Cancelled Recall", unit.charName)) end
   end
  end
 end
end

class "_Zilean"
function _Zilean:__init()
 self.ScriptName = "Rx Zilean"
 self.cm = MenuConfig("Air "..myHero.charName)
end

if not _G.RxAirSeriesLoaded then _G.AirSeries() end
PrintChat(string.format("<font color=\"#00F5FF\">[Air Series]: </font><font color=\"#00FF7F\">Loaded. Enjoy and Good Luck </font><font color=\"#FF7F00\">%s<font>",myHero.name))
