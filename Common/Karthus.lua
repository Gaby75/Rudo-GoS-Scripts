--[[ Rx Karthus version 0.163
     Version 0.163: Update some code
     Go to http://gamingonsteroids.com To Download more script.
     Credits: Deftsu, Zypppy, Cloud.
----------------------------------------------------]]

-- Requirement
require "Inspired" 
require "OpenPredict"
print("<font color='#FFFFFF'>Credits to </font><font color='#3366FF'>Cloud </font><font color='#FFFFFF'>, </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>")

class "RxKarthus"
function RxKarthus:__init()
---- Create Menu ----
Karthus = MenuConfig("Karthus", "Rx Karthus")
tslowhp = TargetSelector(GetCastRange(myHero, _Q), 8, DAMAGE_MAGIC) -- 8 = TARGET_LOW_HP

-- [[ Combo ]] --
Karthus:Menu("cb", "Karthus Combo")
Karthus.cb:Boolean("QCB", "Use Q", true)
Karthus.cb:Boolean("WCB", "Use W", true)
Karthus.cb:Boolean("ECB", "Use E", true)

-- [[ Harass ]] --
Karthus:Menu("hr", "Harass")
Karthus.hr:Boolean("HrQ", "Use Q", true)
Karthus.hr:Slider("HrMana", "Enable Harass if %My MP >=", 30, 0, 100, 1)

-- [[ LaneJungle Clear ]] --
Karthus:Menu("FreezeLane", "Lane Jungle Clear")
Karthus.FreezeLane:Slider("LJCMana", "Enable if %My MP >=", 20, 0, 100, 1)
Karthus.FreezeLane:Boolean("QLJC", "Use Q", true)
Karthus.FreezeLane:Boolean("ELJC", "Use E", true)
Karthus.FreezeLane:Slider("CELC", "Use E if Minions Around >=", 3, 1, 10, 1)

-- [[ LastHit ]] --
Karthus:Menu("LHMinion", "Last Hit Minion")
Karthus.LHMinion:Boolean("QLH", "Use Q Last Hit", true)
Karthus.LHMinion:Slider("LHMana", "LastHit if %My MP >=", 10, 0, 100, 1)

-- [[ KillSteal ]] --
Karthus:Menu("KS", "Kill Steal")
Karthus.KS:Boolean("QKS", "KS with Q", true)
Karthus.KS:Boolean("IgniteKS", "KS with Ignite", true)

-- [[ Drawings ]] --
Karthus:Menu("Draws", "Drawings")
Karthus.Draws:Menu("Range", "Skills Range")
Karthus.Draws.Range:Slider("QualiDraw", "Range Quality", 55, 1, 100, 1)
Karthus.Draws.Range:Boolean("DrawQ", "Q Range", true)
Karthus.Draws.Range:ColorPick("Qcol", "Q Color", {140, 135, 206, 250})
Karthus.Draws.Range:Boolean("DrawW", "W Range", true)
Karthus.Draws.Range:ColorPick("Wcol", "W Color", {255, 29, 29, 30})
Karthus.Draws.Range:Boolean("DrawE", "W Range", true)
Karthus.Draws.Range:ColorPick("Ecol", "E Color", {255, 178, 58, 238})
Karthus.Draws:Menu("Texts", "Draws Text")
Karthus.Draws.Texts:Boolean("EnmHP", "Draw HP Enemy", true)
Karthus.Draws.Texts:Boolean("DamageR", "Draw R Damage", true)
Karthus.Draws.Texts:Boolean("EninfoR", "Draw R Info", true)
Karthus.Draws.Texts:Info("infoR1", "If you can see Enemy can KS with R")
Karthus.Draws.Texts:Info("infoR2", "Press R to Killable enemy")

-- [[ Misc ]] --
Karthus:Menu("Miscset", "Misc")
Karthus.Miscset:Boolean("AutoSkillUpQ", "Auto Lvl Up Q-E-W", true)
Karthus.Miscset:Boolean("StopE", "Auto Stop E", true)
Karthus.Miscset:Info("SEI", "Auto Stop E if no creeps/enemy in E range")
Karthus.Miscset:Info("StopEInfo", "If you want to spam Seraph's Embrace you must OFF it")
Karthus.Miscset:Slider("hc", "Q HitChance", 2, 1, 10, 0.5)
PermaShow(Karthus.Miscset.StopE)

Karthus:Info("info1", "Use PActivator for Auto Use Items")
Callback.Add("Tick", function(myHero) self:Tick(myHero) end)
Callback.Add("Draw", function(myHero) self:Drawings(myHero) end)
end

--- [[ Location ]] ---
local QRange, WRange, ERange, pn = GetCastRange(myHero, _Q), GetCastRange(myHero, _W), GetCastRange(myHero, _E), '%'
local KarthusQ, leveltable = { delay = 0.75, speed = math.huge, width = 160, range = QRange }, {_Q, _E, _Q, _W, _Q , _R, _Q , _E, _Q , _E, _R, _E, _E, _W, _W, _R, _W, _W}
local function IsInRange(unit, range)
    return unit.valid and IsInDistance(unit, range)
end

local function RCheck()
 if IsReady(_R) or (GotBuff(myHero, "karthusfallenonecastsound") > 0) then return true else return false end
end

local function QCheck(unit, pos)
 local Mno, Enm = MinionsAround(pos, 183, MINION_ENEMY), CountObjectsNearPos(pos, 175, 175, GetEnemyHeroes(), MINION_ENEMY)
 local CheckQDmg = GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap
 if GetDistance(unit.pos, pos) <= 167 then
  if Mno + Enm == 1 then return CheckQDmg else return CheckQDmg/2 end
 else
  if Mno + Enm < 1 then return CheckQDmg else return CheckQDmg/2 end
 end
end

function RxKarthus:Tick(myHero)
 if IOW:Mode() == "Combo" then self:Combo()
 elseif IOW:Mode() == "Harass" then self:Harass()
 elseif IOW:Mode() == "LaneClear" then self:LaneClear() self:JungleClear()
 elseif IOW:Mode() == "LastHit" then self:LastHit()
 end
 self:KillSteal()
 if GotBuff(myHero, "KarthusDefile") >= 1 then self:AutoStopE() end
 self:AutoLvlUp()
end

function RxKarthus:Combo(target)
 local target = tslowhp:GetTarget()
 if target then
  local WPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,250,WRange,100,false,true)
  local QPred = GetCircularAOEPrediction(target, KarthusQ)
  if IsReady(_W) and myHero.mana >= 130 and IsInRange(target, WRange) and WPred.HitChance >= 1 and Karthus.cb.WCB:Value() then
   CastSkillShot(_W, WPred.PredPos)
  end
  
  if IsReady(_E) and IsInRange(target, ERange) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.cb.ECB:Value() then
   CastSpell(_E)
  end
	
  if IsReady(_Q) and IsInRange(target, QRange) and QPred and QPred.hitChance >= Karthus.Miscset.hc:Value()/10 and Karthus.cb.QCB:Value() then
   CastSkillShot(_Q, QPred.castPos)
  end
 end
end

function RxKarthus:Harass(target)
 local target = tslowhp:GetTarget()
 if target and GetPercentMP(myHero) >= Karthus.hr.HrMana:Value() then
  local QPred = GetCircularAOEPrediction(target, KarthusQ)
  if IsReady(_Q) and IsInRange(target, GetCastRange(myHero,_Q)) and QPred and QPred.hitChance >= Karthus.Miscset.hc:Value()/10 and Karthus.hr.HrQ:Value() then
    CastSkillShot(_Q, QPred.castPos)
  end
 end
end

function RxKarthus:LaneClear()
 for C=1, minionManager.maxObjects do
 local creep = minionManager.objects[C]
  if GetPercentMP(myHero) >= Karthus.FreezeLane.LJCMana:Value() and creep.team == MINION_ENEMY and creep.health > 0 then
   if IsInRange(creep, QRange) and IsReady(_Q) and Karthus.FreezeLane.QLJC:Value() then
   local QPred = GetCircularAOEPrediction(creep, KarthusQ)
    if creep.health < myHero:CalcMagicDamage(creep, GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap) +myHero.damage/2+12+7.5*GetLevel(myHero) then
    local QDmgPredict, ac = GetHealthPrediction(creep, 750)
     if QDmgPredict > 0 and QPred and QDmgPredict < myHero:CalcMagicDamage(creep, QCheck(creep, QPred.castPos)) then
      CastSkillShot(_Q, QPred.castPos)
     end
    else
     if QPred then DelayAction(function() CastSkillShot(_Q, QPred.castPos) end, 350) end
    end
   end
	
    if IsReady(_E) and IsInRange(creep, ERange) and Karthus.FreezeLane.ELJC:Value() and (MinionsAround(myHero.pos, ERange, MINION_ENEMY) >= Karthus.FreezeLane.CELC:Value() or MinionsAround(myHero.pos, ERange, MINION_JUNGLE) >= 1) and GotBuff(myHero, "KarthusDefile") <= 0 then
     CastSpell(_E)	
    end
  end
 end
end

function RxKarthus:JungleClear()
 for C, creep in pairs(minionManager.objects) do
  if GetPercentMP(myHero) >= Karthus.FreezeLane.LJCMana:Value() and creep.team == MINION_JUNGLE and creep.health > 0 and IsInRange(creep, QRange) and IsReady(_Q) and Karthus.FreezeLane.QLJC:Value() then
   local QPred = GetCircularAOEPrediction(creep, KarthusQ)
   CastSkillShot(_Q, QPred.castPos)
  end
 end
end

function RxKarthus:LastHit()
 for C=1, minionManager.maxObjects do
 local creep = minionManager.objects[C]
  if GetPercentMP(myHero) >= Karthus.LHMinion.LHMana:Value() then
   if creep.team ~= myHero.team and creep.health > 0 then
     if IsInRange(creep, QRange) and IsReady(_Q) and Karthus.LHMinion.QLH:Value() then
      local QDmgPredict, ac = GetHealthPrediction(creep, 750)
      local QPred = GetCircularAOEPrediction(creep, KarthusQ)
      if QDmgPredict > 0 and QPred and QDmgPredict < myHero:CalcMagicDamage(creep, QCheck(creep, QPred.castPos)) then
       CastSkillShot(_Q, QPred.castPos)
      else
       IOW.attacksEnabled = false
      end
     end
    end
  else
   IOW.attacksEnabled = true
  end
 end
end

function RxKarthus:KillSteal()
 for i, enemy in pairs(GetEnemyHeroes()) do	
  if Ignite and Karthus.KS.IgniteKS:Value() then
   if IsReady(Ignite) and 20*GetLevel(myHero)+50 > (enemy.health+enemy.shieldAD)+enemy.hpRegen*2.5 and IsInRange(enemy, 600) then
    CastTargetSpell(enemy, Ignite)
   end
  end

 local QPred = GetCircularAOEPrediction(enemy, KarthusQ)
  if IsReady(_Q) and IsInRange(enemy, QRange) and (enemy.health+enemy.shieldAD+enemy.shieldAP) < myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap) and QPred and QPred.hitChance >= 0.1 and Karthus.KS.QKS:Value() then
   CastSkillShot(_Q, QPred.castPos)
  end
 end
end

function RxKarthus:AutoStopE()
 if IOW:Mode() == "Combo" and EnemiesAround(myHero.pos, ERange) <= 0 then CastSpell(_E) end
 if IOW:Mode() == "LaneClear" and MinionsAround(myHero.pos, ERange, MINION_ENEMY) < Karthus.FreezeLane.CELC:Value() and MinionsAround(myHero.pos, ERange, MINION_JUNGLE) < 1 then CastSpell(_E) end
 if Karthus.Miscset.StopE:Value() and MinionsAround(myHero.pos, ERange, MINION_ENEMY) < 2 and MinionsAround(myHero.pos, ERange, MINION_JUNGLE) < 1 and EnemiesAround(myHero.pos, ERange) <= 0 then CastSpell(_E) end
end

function RxKarthus:AutoLvlUp()
 if Karthus.Miscset.AutoSkillUpQ:Value() then
  LevelSpell(leveltable[GetLevel(myHero)])
 end
end

------------------------------------------------------
function RxKarthus:Drawings(myHero)
 self:RInfo()
 self:Range()
 self:RDamage()
 self:HPBar()
end

function RxKarthus:RInfo()
 if Karthus.Draws.Texts.EninfoR:Value() and RCheck() and myHero.dead == false then
 info = ""
  for i, enemy in pairs(GetEnemyHeroes()) do
   if enemy.alive and (enemy.health+enemy.shieldAD+enemy.shieldAP)+enemy.hpRegen*3 < myHero:CalcMagicDamage(enemy, GetCastLevel(enemy, _R)*150 + 100 + 0.6*myHero.ap) then
   info = info..enemy.charName
    if enemy.visible == false then
     info = info.." Not see in map maybe"
    end
     info = info.." R KILL!\n"
   end
  end
 DrawText(info,30,0,110,GoS.Red) 
 end
end

function RxKarthus:Range()
 if Karthus.Draws.Range.DrawQ:Value() and IsReady(_Q) then DrawCircle3D(myHero.x,myHero.y,myHero.z,QRange,1,Karthus.Draws.Range.Qcol:Value(),Karthus.Draws.Range.QualiDraw:Value()) end
 if Karthus.Draws.Range.DrawW:Value() and IsReady(_W) then DrawCircle3D(myHero.x,myHero.y,myHero.z,WRange,1,Karthus.Draws.Range.Wcol:Value(),Karthus.Draws.Range.QualiDraw:Value()) end
 if Karthus.Draws.Range.DrawE:Value() and IsReady(_E) then DrawCircle3D(myHero.x,myHero.y,myHero.z,ERange,1,Karthus.Draws.Range.Ecol:Value(),Karthus.Draws.Range.QualiDraw:Value()) end
end

function RxKarthus:RDamage()
local myPos = WorldToScreen(1, myHero.pos)
 for i, enemy in pairs(GetEnemyHeroes()) do
  local enmPos = WorldToScreen(1, enemy.pos)
  if myHero.alive and RCheck() and enemy.valid and (enemy.health+enemy.shieldAD+enemy.shieldAP)+enemy.hpRegen*3 <= myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.60*myHero.ap) then
   DrawText("Enemy R = KILL",20,enmPos.x,enmPos.y+23,GoS.Red)
  end

  if myHero.dead == false and Karthus.Draws.Texts.EnmHP:Value() and IsInRange(enemy, 2500) then
   DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", enemy.charName, enemy.health, enemy.maxHealth, pn, GetPercentHP(enemy), pn),16,enmPos.x,enmPos.y,GoS.White)
  end
  
  if RCheck() and myHero.dead == false and (enemy.health+enemy.shieldAD+enemy.shieldAP)+enemy.hpRegen*3 <= myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.60*myHero.ap) and enemy.valid then
   DrawText("R = Kill Enemy",20,myPos.x,myPos.y+23,GoS.Red) 
  end
 end

 if myHero.dead == false and GetCastLevel(myHero, _R) > 0 then
  if Karthus.Draws.Texts.DamageR:Value() then
   DrawText("Damage R = "..math.ceil(GetCastLevel(myHero, _R)*150 + 100 + 0.60*myHero.ap).." Dmg",16,myPos.x,myPos.y,GoS.White)
  end
 end
end

function RxKarthus:HPBar()
 for i, enemy in pairs(GetEnemyHeroes()) do
  if IsInRange(enemy, 2500) then
   if IsReady(_Q) and IsReady(_R) then
    DrawDmgOverHpBar(enemy,enemy.health,0,myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.60*myHero.ap),GoS.White)
   elseif IsReady(_R) and not IsReady(_Q) then
    DrawDmgOverHpBar(enemy,enemy.health,0,myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _R)*150 + 100 + 0.60*myHero.ap),GoS.White)
   elseif IsReady(_Q) and not IsReady(_R) then
    DrawDmgOverHpBar(enemy,enemy.health,0,myHero:CalcMagicDamage(enemy, GetCastLevel(myHero, _Q)*40 + 40 + 0.6*myHero.ap),GoS.White)
   else
    DrawDmgOverHpBar(enemy,enemy.health,myHero.damage, 0,GoS.White)
   end
  end
 end
end

if myHero.charName == "Karthus" then RxKarthus() end
PrintChat(string.format("<font color='#FF0000'>Rx Karthus by Rudo </font><font color='#FFFF00'>Version 0.163 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck %s</font>",myHero.name)) 
print("Recommend Farm with LastHit.")
