--[[ Rx Karthus version 0.162
     Version 0.162: Update for Inspired_new and edit some things.
     Go to http://gamingonsteroids.com To Download more script.
     Credits: Deftsu, Zypppy, Cloud.
----------------------------------------------------]]
---- Requirement
require('OpenPredict')
require('DamageLib')
require('Inspired')
----> End
local RxKarthusLoaded = true

if myHero.charName ~= "Karthus" then return end
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#3366FF'>Cloud </font><font color='#FFFFFF'>, </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))

class "RxKarthus"
function RxKarthus:__init()
LoadIOW()
Karthus = MenuConfig("Karthus", "Rx Karthus")
tslowhp = TargetSelector(875, 8, DAMAGE_MAGIC)

---- Combo ----
Karthus:Menu("cb", "Karthus Combo")
Karthus.cb:Boolean("QCB", "Use Q", true)
Karthus.cb:Boolean("WCB", "Use W", true)
Karthus.cb:Boolean("ECB", "Use E", true)

---- Harass Menu ----
Karthus:Menu("hr", "Harass")
Karthus.hr:Boolean("HrQ", "Use Q", true)
Karthus.hr:Slider("HrMana", "Enable Harass if %My MP >=", 30, 0, 100, 1)

---- Lane Clear Menu ----
Karthus:Menu("FreezeLane", "Lane Jungle Clear")
Karthus.FreezeLane:Slider("LJCMana", "Enable if %My MP >=", 20, 0, 100, 1)
Karthus.FreezeLane:Boolean("QLJC", "Use Q", true)
Karthus.FreezeLane:Boolean("ELJC", "Use E", true)
Karthus.FreezeLane:Slider("CELC", "Use E if Minions Around >=", 3, 1, 10, 1)

---- Last Hit Menu ----
Karthus:Menu("LHMinion", "Last Hit Minion")
Karthus.LHMinion:Boolean("QLH", "Use Q Last Hit", true)
Karthus.LHMinion:Slider("LHMana", "LastHit if %My MP >=", 10, 0, 100, 1)

---- Kill Steal Menu ----
Karthus:Menu("KS", "Kill Steal")
Karthus.KS:Boolean("KSEb", "Enable KillSteal", true)
Karthus.KS:Boolean("QKS", "KS with Q", true)
Karthus.KS:Boolean("IgniteKS", "KS with Ignite", true)

---- Draw Enemy can KS with R Menu ----
Karthus:Menu("InfoR", "Draw Enemy can KS with R")
Karthus.InfoR:Boolean("EninfoR", "Draw R Info", true)
Karthus.InfoR:Info("infoR1", "If you can see Enemy can KS with R")
Karthus.InfoR:Info("infoR2", "Press R to Killable enemy")
PermaShow(Karthus.InfoR.EninfoR)

---- Drawings Menu ----
Karthus:Menu("Draws", "Drawings")
Karthus.Draws:Menu("Range", "Skills Range")
Karthus.Draws.Range:Slider("QualiDraw", "Range Quality", 110, 1, 255, 1)
Karthus.Draws.Range:Boolean("DrawQ", "Q Range", true)
Karthus.Draws.Range:ColorPick("Qcol", "Q Color", {140, 135, 206, 250})
Karthus.Draws.Range:Boolean("DrawW", "W Range", true)
Karthus.Draws.Range:ColorPick("Wcol", "W Color", {255, 29, 29, 30})
Karthus.Draws.Range:Boolean("DrawE", "W Range", true)
Karthus.Draws.Range:ColorPick("Ecol", "E Color", {255, 178, 58, 238})
Karthus.Draws:Menu("Texts", "Draws Text")
Karthus.Draws.Texts:Boolean("DrawTexts", "Enable Draws Text", true)
Karthus.Draws.Texts:Boolean("EnmHP", "Draw HP Enemy", true)
Karthus.Draws.Texts:Boolean("DamageR", "Draw R Damage", true)

---- Misc Menu ----
Karthus:Menu("Miscset", "Misc")
Karthus.Miscset:Boolean("AutoSkillUpQ", "Auto Lvl Up Q-E-W", true)
Karthus.Miscset:Boolean("StopE", "Auto Stop E", true)
Karthus.Miscset:Info("SEI", "Auto Stop E if no creeps/enemy in E range")
Karthus.Miscset:Info("StopEInfo", "If you want to spam Seraph's Embrace you must OFF it")
Karthus.Miscset:Slider("hc", "Setting Q HitChance ", 2, 1, 10, 0.5)
PermaShow(Karthus.Miscset.StopE)

Karthus:Info("info1", "Use PActivator for Auto Use Items")
----> End Menu
Callback.Add("Tick", function(myHero) self:Fight(myHero) end)
Callback.Add("Draw", function(myHero) self:Draws(myHero) end)
end

---[[ Location ]]---
local KarthusQ = { delay = 0.75, speed = math.huge, width = 160, range = GetCastRange(myHero,_Q) }

local function IsInRange(unit, range)
    return unit.valid and IsInDistance(unit, range)
end

local function QCheck(unit, pos)
 local Mno, Enm = CountObjectsNearPos(pos, 170, 170, minionManager.objects, MINION_ENEMY), CountObjectsNearPos(pos, 165, 165, GetEnemyHeroes(), MINION_ENEMY)
 local CheckQDmg = GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap
 if GetDistance(unit.pos, pos) <= 160 then
  if Mno == 1 and Enm < 1 then return CheckQDmg else return CheckQDmg/2 end
 else
  if Mno < 1 and Enm < 1 then return CheckQDmg else return CheckQDmg/2 end
 end
end
--- End Local ---

function RxKarthus:Fight(myHero)
 self:Combo()
 self:Harass()
 self:LaneJungleClear()
 self:LastHit()
 self:KillSteal()
 self:AutoStopE()
 self:AutoLvlUp()
end

function RxKarthus:Combo(target)
local target = tslowhp:GetTarget()
 if target and IOW:Mode() == "Combo" then
 local WPred = GetPredictionForPlayer(myHero.pos,target,target.ms,math.huge,250,GetCastRange(myHero, _W),100,false,true)
 local QPred = GetCircularAOEPrediction(target, KarthusQ)
 
  if IsReady(_W) and myHero.mana >= 130 and target.alive and IsInRange(target, GetCastRange(myHero, _W)) and WPred.HitChance >= 1 and Karthus.cb.WCB:Value() then
   CastSkillShot(_W, WPred.PredPos)
  end
  
  if IsReady(_E) and IsInRange(target, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.cb.ECB:Value() then
   CastSpell(_E)
  end
  
  if IsReady(_Q) and IsInRange(target, GetCastRange(myHero,_Q)) and QPred and QPred.hitChance >= Karthus.Miscset.hc:Value()/10 and Karthus.cb.QCB:Value() then
   CastSkillShot(_Q, QPred.castPos)
  end
 end
end

function RxKarthus:Harass(target)
local target = tslowhp:GetTarget()
 if target and IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Karthus.hr.HrMana:Value() then
   local QPred = GetCircularAOEPrediction(target, KarthusQ)
  if IsReady(_Q) and IsInRange(target, GetCastRange(myHero,_Q)) and QPred and QPred.hitChance >= Karthus.Miscset.hc:Value()/10 and Karthus.hr.HrQ:Value() then
   CastSkillShot(_Q, QPred.castPos)
  end
 end
end

function RxKarthus:LaneJungleClear()
local CheckQDmg = GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap
 for C = 1, minionManager.maxObjects do
 local creep = minionManager.objects[C]
  if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Karthus.FreezeLane.LJCMana:Value() then
   if creep.team ~= myHero.team and creep.health > 0 then
    if IsInRange(creep, GetCastRange(myHero, _Q)) then
     if IsReady(_Q) and Karthus.FreezeLane.QLJC:Value() then
	  local QPred = GetCircularAOEPrediction(creep, KarthusQ)
      if creep.health < myHero:CalcMagicDamage(creep, CheckQDmg) +20+8*GetLevel(myHero) then
       local QDmgPredict = creep.health - GetDamagePrediction(creep, 750)
       if QDmgPredict > 0 and QPred and QDmgPredict < myHero:CalcMagicDamage(creep, QCheck(creep, QPred.castPos)) then
        CastSkillShot(_Q, QPred.castPos)
       end
      else
       if QPred then DelayAction(function() CastSkillShot(_Q, QPred.castPos) end, 350) end
      end
     end
		
     if IsReady(_E) and Karthus.FreezeLane.ELJC:Value() and (MinionsAround(myHero.pos, GetCastRange(myHero,_E), MINION_ENEMY) >= Karthus.FreezeLane.CELC:Value() or MinionsAround(myHero.pos, GetCastRange(myHero,_E), MINION_JUNGLE) >= 1) and GotBuff(myHero, "KarthusDefile") <= 0 then
      CastSpell(_E)	
     end
    end
   end
  end
 end
end

function RxKarthus:LastHit()
 for C = 1, minionManager.maxObjects do
 local creep = minionManager.objects[C]
  if GetPercentMP(myHero) >= Karthus.LHMinion.LHMana:Value() then
   if IOW:Mode() == "LastHit" and creep.team ~= myHero.team and IsInRange(creep, GetCastRange(myHero,_Q)) and creep.health > 0 and IsReady(_Q) and Karthus.LHMinion.QLH:Value() then
    local QDmgPredict = creep.health - GetDamagePrediction(creep, 750)
    local QPred = GetCircularAOEPrediction(creep, KarthusQ) 
    if QDmgPredict > 0 and QPred and QDmgPredict < myHero:CalcMagicDamage(creep, QCheck(creep, QPred.castPos)) then
     CastSkillShot(_Q, QPred.castPos)
    else
     IOW.attacksEnabled = false
    end
   end
  else
   IOW.attacksEnabled = true
  end
 end
end

function RxKarthus:KillSteal()
 if Karthus.KS.KSEb:Value() then
  for i, enemy in pairs(GetEnemyHeroes()) do	
   if Ignite and Karthus.KS.IgniteKS:Value() then
    if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*2.5 and IsInRange(enemy, 600) then
     CastTargetSpell(enemy, Ignite)
    end
   end

   if IsReady(_Q) and IsInRange(enemy, GetCastRange(myHero, _Q)) and GetHP2(enemy) <= myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap) and Karthus.KS.QKS:Value() then
    local QPred = GetCircularAOEPrediction(enemy, KarthusQ)
    if QPred.hitChance >= 0.1 then
     CastSkillShot(_Q, QPred.castPos)
    end
   end
  end
 end
end

function RxKarthus:AutoStopE()
 if Karthus.Miscset.AutoSkillUpQ:Value() then
  local leveltable = {_Q, _E, _Q, _W, _Q , _R, _Q , _E, _Q , _E, _R, _E, _E, _W, _W, _R, _W, _W}
  LevelSpell(leveltable[GetLevel(myHero)])
 end	
end

function RxKarthus:AutoLvlUp()
 if GotBuff(myHero, "KarthusDefile") >= 1 then
  if IOW:Mode() == "Combo" and EnemiesAround(myHero.pos, GetCastRange(myHero, _E)) <= 0 then CastSpell(_E) end
  if IOW:Mode() == "LaneClear" and MinionsAround(myHero.pos, GetCastRange(myHero, _E), MINION_ENEMY) < Karthus.FreezeLane.CELC:Value() and MinionsAround(myHero.pos, GetCastRange(myHero, _E), MINION_JUNGLE) < 1 then CastSpell(_E) end
  if Karthus.Miscset.StopE:Value() and MinionsAround(myHero.pos, GetCastRange(myHero, _E), MINION_ENEMY) < 2 and MinionsAround(myHero.pos, GetCastRange(myHero, _E), MINION_JUNGLE) < 1 and EnemiesAround(myHero.pos, GetCastRange(myHero, _E)) <= 0 then CastSpell(_E) end
 end
end

------------------------------------------------------

function RxKarthus:Draws(myHero)
 self:InfoR()
 self:DrawRange()
 self:RDamage()
 self:HPBar()
end

function RxKarthus:InfoR()
 if Karthus.InfoR.EninfoR:Value() and GetLevel(myHero) >= 6 and not IsDead(myHero) then
 info = ""
  for i, enemy in pairs(GetEnemyHeroes()) do
   if enemy.alive and GetHP2(enemy) < myHero:CalcMagicDamage(enemy, GetCastLevel(enemy, _R)*150 + 100 + 0.6*myHero.ap) then
   info = info..GetObjectName(enemy)
    if enemy.visible == false then
     info = info.." Not see in map maybe"
    end
     info = info.." R KILL!\n"
   end
  end
  DrawText(info,30,0,110,GoS.Red) 
 end
end

function RxKarthus:DrawRange()
 if Karthus.Draws.Range.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHero.pos,GetCastRange(myHero,_Q),1,Karthus.Draws.Range.QualiDraw:Value(),Karthus.Draws.Range.Qcol:Value()) end
 if Karthus.Draws.Range.DrawW:Value() and IsReady(_W) then DrawCircle(myHero.pos,GetCastRange(myHero,_W),2,Karthus.Draws.Range.QualiDraw:Value(),Karthus.Draws.Range.Wcol:Value()) end
 if Karthus.Draws.Range.DrawE:Value() and IsReady(_E) then DrawCircle(myHero.pos,GetCastRange(myHero,_E),1,Karthus.Draws.Range.QualiDraw:Value(),Karthus.Draws.Range.Ecol:Value()) end
end

function RxKarthus:RDamage()
 if Karthus.Draws.Texts.DrawTexts:Value() then
  for i = 1, heroManager.iCount do
  local enemy = heroManager:GetHero(i)
   if IsReady(_R) and myHero.dead == false then
    if enemy.valid and GetHP2(enemy) <= myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.6*myHero.ap) then
     DrawText("Enemy R = KILL",20,enemy.pos2D.x,enemy.pos2D.y+23,GoS.Red)
	 DrawText("R = Kill Enemy",20,myHero.pos2D.x,myHero.pos2D.y+23,GoS.Red)
    end
   end
  end

  if GetCastLevel(myHero, _R) > 0 and myHero.dead == false and Karthus.Draws.Texts.DamageR:Value() then
   local RDmg = GetCastLevel(myHero, _R)*150 + 100 + 0.60*myHero.ap
   DrawText(string.format("Damage R = %d Dmg", RDmg),16,myHero.pos2D.x,myHero.pos2D.y,GoS.White)
  end
 end
end

function RxKarthus:HPBar()
 for i, enemy in pairs(GetEnemyHeroes()) do
  if IsInRange(enemy, 3000) then
   if IsReady(_Q) and IsReady(_R) then
    enemy:DrawDmg(math.min(enemy.health,myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.6*myHero.ap)),GoS.White)
   elseif IsReady(_R) and not IsReady(_Q) then
    enemy:DrawDmg(math.min(enemy.health,myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.6*myHero.ap)),GoS.White)
   elseif IsReady(_Q) and not IsReady(_R) then
    enemy:DrawDmg(math.min(enemy.health,myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap)),GoS.White)
   else
    enemy:DrawDmg(myHero.damage,GoS.White)
   end
  end
 end
end

if RxKarthusLoaded then _G.RxKarthus() end
PrintChat(string.format("<font color='#FF0000'>Rx Karthus by Rudo </font><font color='#FFFF00'>Version 0.162 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck %s</font>",GetObjectBaseName(myHero))) 
print("Recommend Farm with LastHit.")
