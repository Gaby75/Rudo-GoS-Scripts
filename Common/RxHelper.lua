--[[ Rx Helper Version 0.13
     Ver 0.13: Updated for Inspired_new, add some features.
     Download Sprites Here: https://drive.google.com/file/d/0B6Je7vbhD0EaRjZmcW40UHRqM3M/view
     Go to http://gamingonsteroids.com to Download more script. 
------------------------------------------------------------------------------------]]
require('Inspired')

print("----------------------------------------------")
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#8000FF'>Deftsu </font><font color='#FFFFFF'>, </font><font color='#5900B3'>Inspired </font>"))
local seconds, check, enemies, allies, HeroesIcon, RECALLING = { }, { }, { }, { }, { }, { }
local pn, ScriptVersion, danger, chibi, recallNormal, recallKill = '%', 0.13
-- Data From BaseUlt of Deftsu
local SpellData = { -- SpellData and add Width
        ["Ashe"]   = { Delay = 250, MissileSpeed  = 1600, Width = 130 },
        ["Draven"] = { Delay = 400, MissileSpeed  = 2000, Width = 160 },
        ["Ezreal"] = { Delay = 1000, MissileSpeed = 2000, Width = 160 },
        ["Jinx"]   = { Delay = 600, MissileSpeed  = 1700, Width = 140 }
}
local BasePOS = { -- BaseVector
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
if SpellData[myHero.charName] ~= nil then
local Speed = SpellData[myHero.charName].MissileSpeed
local Delay = SpellData[myHero.charName].Delay/1000
local Width = SpellData[myHero.charName].Width
end
local BaseEnemy = BasePOS[GetMapID()][GetTeam(myHero)]

class "RxHelper"
function RxHelper:__init()
--[[ Create Menu ]]--
self.cf = MenuConfig("RAA", "[Rx Helper] - Ver: "..ScriptVersion)

--[[ MiniMap Menu ]]--
self.cf:Menu("mnm", "Draw MiniMap")
self.cf.mnm:Boolean("icon", "Draw Icon Minimap", true)
self.cf.mnm:Boolean("seconds", "Draw time NotFound Minimap", true)
self.cf.mnm:Boolean("circle", "Draw moving circle", true)
self.cf.mnm:Boolean("colcir", "Draw colorful circle", true)
self.cf.mnm:Info("info1", "Green color: Not found at 10s before")
self.cf.mnm:Info("info2", "Orange color: Not found at 25s before")
self.cf.mnm:Info("info3", "Red color: Not found > 25s before")
self.cf.mnm:Slider("qlt", "Circle Quality", 255, 1, 255, 1)
self.cf.mnm:Info("info4", "Highest Quality: 1")

--[[ Tracker Menu ]]--
self.cf:Menu("track", "Tracker")
self.cf.track:Boolean("simple", "Draw text 'Dangerous!'", true)
self.cf.track:Info("info1", "Check human around myHero and draw if MyTeam < EnemyTeam")
self.cf.track:Info("info2", "Or draw if find enemy have smite in 2500 range.")
self.cf.track:Boolean("HitE", "Draw x hit to kill enemy ", true)
self.cf.track:Boolean("HpE", "Draw HP Enemy", false)
self.cf.track:Boolean("HpA", "Draw HP Ally", false)
self.cf.track:Info("info3", "----------------------------")
self.cf.track:Boolean("enb1", "Recalling - Sprite", true)
self.cf.track:DropDown("sd", "Recalling... During", 1, {"No", "Yes"})
self.cf.track:Boolean("enb2", "Recalling - PrintChat", true)
----> End Menu
Callback.Add("Load", function() self:Load() end)
Callback.Add("Tick", function() self:Tick() end)
Callback.Add("Draw", function() self:Drawings() end)
Callback.Add("DrawMinimap", function() self:DrawMiniMap() end)
Callback.Add("ProcessRecall", function(unit, proc) self:RecallProc(unit, proc) end)
end

function RxHelper:Load()
 LoadIOW()
 self:LoadHeroes()
 self:LoadSprite()
end

function RxHelper:LoadHeroes()
 for i, enemy in pairs(GetEnemyHeroes()) do
  table.insert(enemies, enemy)
 end

 for l, ally in pairs(GetAllyHeroes()) do
  table.insert(allies, ally)
 end
end

function RxHelper:LoadSprite()
 if FileExist(SPRITE_PATH.."\\RxHelper\\danger.png") then danger = Sprite("RxHelper\\danger.png", 140, 28, 0, 0) else print("'danger.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\OPMCb.png") then chibi = Sprite("RxHelper\\OPMCb.png", 32, 35, 0, 0) else print("'OPMCb.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\Recalling1.png") then recallNormal = Sprite("RxHelper\\Recalling1.png", 331, 52, 0, 0) else print("'Recalling1.png' Not Found. Download it and reload script!") end
 if FileExist(SPRITE_PATH.."\\RxHelper\\Recalling2.png") then recallKill = Sprite("RxHelper\\Recalling2.png", 331, 52, 0, 0) else print("'Recalling2.png' Not Found. Download it and reload script!") end
 for i, enemy in pairs(enemies) do
  if FileExist(SPRITE_PATH.."\\RxHelper\\"..enemy.charName.."_GoS_MiniMH.png") then
   table.insert(HeroesIcon, Sprite("RxHelper\\"..enemy.charName.."_GoS_MiniMH.png", 54, 54, 0, 0, 0.4))
  else
   print("'"..enemy.charName.."_GoS_MiniMH.png' Not Found. Download it and Reload script.")
  end
 end
end

--[[ Local Functions]]--
local function RecallDmg(unit)
  local EnemiesInWay = CountObjectsOnLineSegment(myHero.pos, BaseEnemy, Width, enemies, MINION_ENEMY)
  local MinionsInWay = CountObjectsOnLineSegment(myHero.pos, BaseEnemy, Width, minionManager.objects, MINION_ENEMY)

 if myHero.charName == "Ashe" then
  return myHero:CalcMagicDamage(unit, 75 + 175*GetCastLevel(myHero,_R) + myHero.ap)
 elseif myHero.charName == "Draven" then
  return myHero:CalcDamage(unit, 75 + 100*GetCastLevel(myHero,_R) + 1.1*myHero.totalDamage) - 8*min(MinionsInWay,5)*myHero:CalcDamage(unit, 75 + 100*GetCastLevel(myHero,_R) + 1.1*myHero.totalDamage)/100
 elseif myHero.charName == "Ezreal" then
  return myHero:CalcMagicDamage(unit, 200 + 150*GetCastLevel(myHero,_R) + 0.9*myHero.ap + myHero.totalDamage) - 10*min(MinionsInWay+EnemiesInWay,3)*myHero:CalcMagicDamage(unit, 200 + 150*GetCastLevel(myHero,_R) + 0.9*myHero.ap + myHero.totalDamage)/100
 elseif myHero.charName == "Jinx" then
  return myHero:CalcDamage(unit, 150+100*GetCastLevel(myHero, _R) + myHero.totalDamage + (20+5*GetCastLevel(myHero, _R))*(unit.maxHealth-unit.health))
 else
  return 0
 end
end

local function IsInRange(unit, range)
    return unit.valid and IsInDistance(unit, range)
end

local function NotFound(unit)
    return unit.dead == false and unit.visible == false
end

-----------------
function RxHelper:Tick()
 for i, enemy in pairs(enemies) do
  if NotFound(enemy) then
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

function RxHelper:Drawings()
 self:DrawTexts()
 self:DrawRecall()
end

function RxHelper:DrawTexts()
local mypos = WorldToScreen(1, myHero.pos)
 for i, enemy in pairs(enemies) do
 local enmPos = WorldToScreen(1, enemy.pos)
  if self.cf.track.simple:Value() and enemy.valid and ((IsInDistance(enemy, 2500) and (GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite"))) or EnemiesAround(myHeroPos(), 3500) > 1+ AlliesAround(myHeroPos(), 2500)) then
   danger:Draw(mypos.x-70, mypos.y+25, GoS.White)
  end
  if NotFound(enemy) then
   local org = WorldToScreen(1, enemy.pos)
   chibi:Draw(org.x-16, org.y-17.5, GoS.White)
   DrawCircle(enemy.pos, 70, 1, 80, GoS.Red)
  end
  if IsInRange(enemy, 3000) then
   if self.cf.track.HitE:Value() then
    local Hit = (enemy.health + enemy.shieldAD)/myHero:CalcDamage(enemy, myHero.totalDamage)
    DrawText(math.ceil(Hit).." Hit = Kill!", 17, enmPos.x-76, enmPos.y-43, GoS.White)
   end
   if self.cf.track.HpE:Value() then
    DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", enemy.charName, enemy.health, enemy.maxHealth, pn, GetPercentHP(enemy), pn),16,enmPos.x,enmPos.y,GoS.White)
   end
  end
 end
 for l, ally in pairs(allies) do
  local alyPos = WorldToScreen(1, ally.pos)
  if self.cf.track.HpE:Value() and IsInRange(ally, 2200) then
   DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", ally.charName, ally.health, ally.maxHealth, pn, GetPercentHP(ally), pn),16,alyPos.x,alyPos.y,GoS.White)
  end
 end
end

function RxHelper:DrawRecall()
local col1, col2, col3
local i = 0
if self.cf.track.sd:Value() == 1 then col1 = 0xff00FF7F col2 = 0xffFF7F00 col3 = 0xffFF0000 else col1 = 0x507FFFD4 col2 = 0x50FF7F00 col3 = 0x50FF0000 end
 if self.cf.track.enb1:Value() then
  for R, recall in pairs(RECALLING) do
  i=i+1
  local leftTime = recall.starttime - os.clock() + recall.info.totalTime/1000
  if leftTime < 0 then leftTime = 0 end
   ---- [[ Normal Champions]] ----
   if SpellData[myHero.charName] == nil then
   recallNormal:Draw(450, 390+55*i, GoS.White)
   DrawText(string.format("%s", R), 20, 456.6, 392+55*i, GoS.White)
   DrawText(string.format("%s HP", math.ceil(recall.Champ.health)), 21, 459, 412.5+55*i, GoS.White)
   if recall.info.isStart then
    DrawText(string.format("%.1fs", leftTime), 20, 608, 386+55*i, ARGB(255,255,218,185))
    FillRect(556,408.3+55*i, 211*leftTime/(recall.info.totalTime/1000), 17.5, col1)
   else
    if recall.killtime == nil then
     if math.min(8,recall.info.passedTime/1000) == recall.info.totalTime/1000 or recall.info.isFinish and recall.info.isStart == false then
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

   if GetCastLevel(myHero, _R) > 0 and recall.Champ.health + recall.Champ.shieldAD + recall.Champ.hpRegen*8 < self:RecallDmg(recall.Champ) and (GetDistance(BaseEnemy)/Speed + Delay) <= recall.info.totalTime/1000 then
    recallKill:Draw(450, 390+55*i, GoS.White)
    DrawText(string.format("%s", R), 20, 456.6, 392+55*i, GoS.Red)
    DrawText(string.format("%s HP", math.ceil(recall.Champ.health)), 21, 459, 412.5+55*i, GoS.Red)
   if recall.info.isStart then
    DrawText(string.format("%.1fs", leftTime), 20, 608, 386+55*i, ARGB(255,255,218,185))
    FillRect(556,408.3+55*i, 211*leftTime/(recall.info.totalTime/1000), 17.5, col2)
    FillRect(556+(211*(GetDistance(BaseEnemy)/Speed + Delay)/(recall.info.totalTime/1000)),408.3+55*i, 2, 17.5, col3)
   else
    if recall.killtime == nil then
     if math.min(8,recall.info.passedTime/1000) == recall.info.totalTime/1000 or recall.info.isFinish and recall.info.isStart == false then
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
    recallNormal:Draw(450, 390+55*i, GoS.White)
    DrawText(string.format("%s", R), 20, 456.6, 392+55*i, GoS.White)
    DrawText(string.format("%s HP", math.ceil(recall.Champ.health)), 21, 459, 412.5+55*i, GoS.White)
   if recall.info.isStart then
    DrawText(string.format("%.1fs", leftTime), 20, 608, 386+55*i, ARGB(255,255,218,185))
    FillRect(556,408.3+55*i, 211*leftTime/(recall.info.totalTime/1000), 17.5, col1)
   else
    if recall.killtime == nil then
     if math.min(8,recall.info.passedTime/1000) == recall.info.totalTime/1000 or recall.info.isFinish and recall.info.isStart == false then
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
end

function RxHelper:DrawMiniMap()
 for i, enemy in pairs(enemies) do
  if NotFound(enemy) then
  local Orgenemy = WorldToMinimap(enemy.pos)
  local ms
  if enemy.ms == 0 then ms = 325 else ms = enemy.ms end
  local speed = seconds[i]*ms +1010
  local color
   if self.cf.mnm.icon:Value() then HeroesIcon[i]:Draw(Orgenemy.x-10.8, Orgenemy.y-10.8, GoS.White) end

   if self.cf.mnm.colcir:Value() then
    if seconds[i] > 0 and seconds[i] < 12 then
     color = ARGB(255,0,255,127)
    elseif seconds[i] >= 12 and seconds[i] < 25 then
     color = ARGB(255,255,127,36)
    else
     color = GoS.Red
    end
     DrawCircleMinimap(enemy.pos, 1000, 1, self.cf.mnm.qlt:Value(), color)
   end

   if self.cf.mnm.circle:Value() then
    if speed < 5000 then DrawCircleMinimap(enemy.pos, speed, 1, 255, ARGB(50,0,245,255)) end
   end

   if self.cf.mnm.seconds:Value() then DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-9, Orgenemy.y+9, ARGB(255,255,255,0)) DrawText(math.floor(seconds[i]).."s", 12, Orgenemy.x-9, Orgenemy.y+9, ARGB(140,255,255,0)) end
  end
 end
end

function RxHelper:RecallProc(unit, proc)
 if unit.team ~= myHero.team then
    rec = {}
    rec.Champ = unit
    rec.info = proc
    rec.starttime = os.clock()
    rec.killtime = nil
    rec.result = nil
    RECALLING[unit.charName] = rec

  if self.cf.track.enb2:Value() then
   if proc.isStart then PrintChat(string.format("<font color =\"#00F5FF\">[RxHelper]: </font><font color =\"#FFA500\">(%s) </font><font color =\"#FFFFF0\">Started Recalling | HP: %s</font>", unit.charName, math.ceil(unit.health)))
   else
   if math.min(8,proc.passedTime/1000) == proc.totalTime/1000 or proc.isFinish == true then PrintChat(string.format("<font color =\"#00F5FF\">[RxHelper]: </font><font color =\"#FFA500\">(%s) </font><font color =\"#FFFFF0\"><i>Finished</i> Recall", unit.charName))
   elseif proc.isFinish == false then PrintChat(string.format("<font color =\"#00F5FF\">[RxHelper]: </font><font color =\"#FFA500\">(%s) </font><font color =\"#FFFFF0\"><i>Cancelled</i> Recall</font>", unit.charName)) end
   end
  end
 end
end

if _G.RxHelper then _G.RxHelper() end
PrintChat(string.format("<font color='#FF0000'>Rx Helper </font><font color='#FFFF00'>Version 0.13 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck </font><font color='#CD2990'>%s</font>",GetObjectBaseName(myHero))) 
