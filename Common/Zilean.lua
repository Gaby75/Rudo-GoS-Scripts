--[[ Rx Zilean Version 0.573 by Rudo.
     Ver 0.573: Added Auto R.
     Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------]]
if GetObjectName(GetMyHero()) ~= "Zilean" then return end

require('Inspired')
--[[---- Script Update ----
local WebLuaFile = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/Zilean.lua"
local WebVersion = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/Zilean.version"
local ScriptName = "Zilean.lua"
local ScriptVersion = 0.573
local CheckWebVer = require("GOSUtility").request("https://raw.githubusercontent.com",WebVersion.."?no-cache="..(math.random(100000))) -- Copy from Inspired <3
if ScriptVersion < tonumber(CheckWebVer) then
PrintChat(string.format("<font color='#00B359'>Script need update.</font><font color='#FF2626'> Waiting to AutoUpdate.</font>")) 
AutoUpdate(WebLuaFile,WebVersion,ScriptName,ScriptVersion)
else
PrintChat(string.format("<font color='#FFFF26'>You are using newest Version. Don't need to update</font>")) 
end --]]

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))

-----------------------
require('DeftLib')
require('DamageLib')
-- Deftsu CHANELLING_SPELLS but no stop Varus Q and Fidd W
ANTI_SPELLS = {
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R}, 
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["KarthusFallenOne"]            = {Name = "Karthus",      Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R}, 
    ["EzrealTrueshotBarrage"]       = {Name = "Ezreal",       Spellslot = _R}, 
    ["TahmKenchR"]                  = {Name = "TahmKench",    Spellslot = _R}, 
    ["VelKozR"]                     = {Name = "VelKoz",       Spellslot = _R}, 
    ["XerathR"]                     = {Name = "Xerath",       Spellslot = _R} 
}

----------------------------------------
class "Zilean"
function Zilean:__init()
  OnTick(function(myHero) self:Fight(myHero) end)
  OnDraw(function(myHero) self:Draws(myHero) end)
  
---------- Create a Menu ----------
Zilean = MenuConfig("Rx Zilean", "Zilean")
tslowhp = TargetSelector(900, 8, DAMAGE_MAGIC) -- 8 = TARGET_LOW_HP
Zilean:TargetSelector("ts", "Target Selector", tslowhp)

---- Combo ----
Zilean:Menu("cb", "Zilean Combo")
Zilean.cb:Boolean("QCB", "Use Q", true)
Zilean.cb:Boolean("WCB", "Use W", true)
Zilean.cb:Boolean("ECB", "Use E", true)
Zilean.cb:Info("infoE", "If MyTeam >= EnemyTeam then E target lowest HP")
Zilean.cb:Info("infoE", "If MyTeam < EnemyTeam then E ally or myHero near mouse, move your mouse >3")
Zilean.cb:Info("infoE", "If not AllyAround my Hero then Use E in myHero")

---- Harass Menu ----
Zilean:Menu("hr", "Harass")
Zilean.hr:Slider("HrMana", "Harass if %MP >= ", 10, 1, 100, 1)
Zilean.hr:Boolean("HrQ", "Use Q", true)

---- Lane Clear Menu ----
Zilean:Menu("ljc", "Lane, Jungle Clear")
Zilean.ljc:Slider("checkMP", "Lane Clear if %MP >= ", 15, 1, 100, 1)
Zilean.ljc:Boolean("LJcQ", "Use Q", true)

---- Auto Spell Menu ----
Zilean:Menu("AtSpell", "Auto Spell")
Zilean.AtSpell:Boolean("ASEb", "Enable Auto Spell", true)
Zilean.AtSpell:Slider("ASMP", "Auto Spell if %MP >=", 15, 1, 100, 1)
Zilean.AtSpell:SubMenu("ATSQ", "Auto Spell Q")
Zilean.AtSpell.ATSQ:Boolean("ASQ", "Auto Q", true)
Zilean.AtSpell.ATSQ:Info("info1", "Auto Q if can stun enemy")
Zilean.AtSpell.ATSQ:Info("info2", "Q to enemy have a bomb")
Zilean.AtSpell:SubMenu("ATSE", "Auto Spell E")
Zilean.AtSpell.ATSE:Boolean("ASE", "Auto E for Run", true)
Zilean.AtSpell.ATSE:Key("KeyE", "Press 'T' to RUN!", string.byte("T"))
Zilean.AtSpell.ATSE:Info("info3", "This is a Mode 'RUNNING!'")
PermaShow(Zilean.AtSpell.ATSE.ASE)
PermaShow(Zilean.AtSpell.ATSE.KeyE)

---- Drawings Menu ----
Zilean:Menu("Draws", "Drawings")
Zilean.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Zilean.Draws:Slider("QualiDraw", "Quality Drawings", 110, 1, 255, 1)
Zilean.Draws:Boolean("DrawQR", "Range Q + R", true)
Zilean.Draws:ColorPick("QRcol", "Setting Q + R Color", {255, 244, 245, 120})
Zilean.Draws:Boolean("DrawE", "Range E", true)
Zilean.Draws:ColorPick("Ecol", "Setting E Color", {255, 155, 48, 255})
Zilean.Draws:Boolean("DrawText", "Draw Text", true)
Zilean.Draws:Info("infoR", "Draw Text If Allies in 2500 Range and %HP Allies <= 20%")
PermaShow(Zilean.Draws.DrawText)

---- Kill Steal Menu ----
Zilean:Menu("KS", "Kill Steal")
Zilean.KS:Boolean("KSEb", "Enable KillSteal", true)
Zilean.KS:Boolean("QKS", "KS with Q", true)
Zilean.KS:Boolean("IgniteKS", "KS with IgniteKS", true)
PermaShow(Zilean.KS.IgniteKS)
PermaShow(Zilean.KS.QKS)

---- Misc Menu ----
Zilean:Menu("Misc", "Misc Mode")
Zilean.Misc:Menu("AutoR", "Auto Use R")
Zilean.Misc.AutoR:Boolean("EnbR", "Enable Auto R", true)
PermaShow(Zilean.Misc.AutoR.EnbR)
Zilean.Misc.AutoR:Slider("myHP", "If %MyHP < x%", 5, 1, 100, 1)
Zilean.Misc.AutoR:Boolean("DrawR", "Enable Draw HP use R ", true)
Zilean.Misc.AutoR:Info("DRInfo", "It will draw x%HP, if MyHP <= HP then auto R")
Zilean.Misc.AutoR:Info("DRInfo2", "You muse enable AutoR and draw HP to see this")
Zilean.Misc:Menu("AutoLvlUp", "Auto Level Up")
Zilean.Misc.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Zilean.Misc.AutoLvlUp:DropDown("AutoSkillUp", "Settings", 1, {"Q-W-E", "Q-E-W"}) 
end
---------- End Menu ----------


-------------------------------------------------------Starting Funciton--------------------------------------------------------------

function Zilean:Fight(myHero)

    if IOW:Mode() == "Combo" then
      self:Combo()
    end

      if Zilean.KS.KSEb:Value() then self:KillSteal() end
	  if Zilean.AtSpell.ASEb:Value() then self:AutoSpell() end

    if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Zilean.hr.HrMana:Value() then
      self:Harass()
    end
   
    if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Zilean.ljc.checkMP:Value() then
      self:LaneJungleClear()
    end
	
	  if Zilean.Misc.AutoLvlUp.UpSpellEb:Value() then self:LevelUp() end
	  
	  if Zilean.Misc.AutoR.EnbR:Value() then self:AutoR() end
	  
end

function Zilean:CastW()
local target = tslowhp:GetTarget()
 if target and IsInRange(target, 900) then
  CastSpell(_W)
 end
end

function Zilean:CastQ(target)
local target = tslowhp:GetTarget()
 if target and IsInRange(target, 900) then
  local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1800,250,GetCastRange(myHero,_Q),160,false,true)
  if QPred.HitChance >= 1 then
   CastSkillShot(_Q, QPred.PredPos)
  end
 end
end

function Zilean:Combo()
 if IsReady(_Q) and Zilean.cb.QCB:Value() then
    self:CastQ()
 end
 
 if IsReady(_W) and Zilean.cb.WCB:Value() and GetCurrentMana(myHero) >= 110 + 5*GetCastLevel(myHero, _Q) and not IsReady(_Q) then
    self:CastW()
 end
 
 if IsReady(_E) and Zilean.cb.ECB:Value() then
    self:CastECb()
 end
end

function Zilean:AutoR()
 if EnemiesAround(myHeroPos(), 1000) >= 1 and GetPercentHP(myHero) <= Zilean.Misc.AutoR.myHP:Value() then CastTargetSpell(myHero, _R) end
 if GotBuff(myHero, "karthusfallenonetarget") >= 1 and KarthusDmg(myHero) > GetHP2(myHero) then CastTargetSpell(myHero, _R) end
end

function Zilean:CastECb()
local target = tslowhp:GetTarget()
local unit = GetCurrentTarget()
 for i, enemy in pairs(GetEnemyHeroes()) do
  if IsInDistance(enemy, 1300) then 
   for l, ally in pairs(GetAllyHeroes()) do
     local Al = AlliesAround(myHeroPos(), GetCastRange(myHero, _E))
     local Enm = EnemiesAround(myHeroPos(), GetCastRange(myHero, _E))
    if target and Al >= 1 and 1 + Al >= Enm and GotBuff(target, "Stun") <= 0 then
       CastTargetSpell(target, _E)
    elseif Al >= 1 and Al < Enm then
     if ally ~= myHero then
      if IsInDistance(ally, GetCastRange(myHero, _E)) then
       if GetDistance(ClosestAlly(GetMousePos()), GetMousePos()) <= 160 and CheckE(ClosestAlly(GetMousePos())) then
        CastTargetSpell(ClosestAlly(GetMousePos()), _E)
       elseif GetDistance(myHeroPos(), GetMousePos()) <= 160 and GetDistance(ClosestAlly(GetMousePos()), GetMousePos()) > 160 and CheckE(myHero) then
        CastTargetSpell(myHero, _E)
       end
      end
     end
    elseif Al <= 0 and IsInDistance(unit, 1300) and CheckE(myHero) and not IsInDistance(unit, 880) then
      CastTargetSpell(myHero, _E)
    end
   end
  end
 end
end

function Zilean:KillSteal()
 for i, enemy in pairs(GetEnemyHeroes()) do
  if Ignite and Zilean.KS.IgniteKS:Value() then
   if IsReady(Ignite) and 20*GetLevel(myHero)+50 >= GetHP(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
	CastTargetSpell(enemy, Ignite)
   end
  end

  if IsReady(_Q) and Zilean.KS.QKS:Value() and GetHP2(enemy) <= getdmg("Q",enemy) and IsInRange(enemy, 900) then
   local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),1800,250,GetCastRange(myHero,_Q),160,false,true)
   if QPred.HitChance >= 1 then
    CastSkillShot(_Q, QPred.PredPos)
   end
   if IsReady(_W) and GetCurrentMana(myHero) >= 110 + 5*GetCastLevel(myHero, _Q) and not IsReady(_Q) then
    CastSpell(_W)
   end
  end
 end
end

function Zilean:AutoQ(enemy)
 for i, enemy in pairs(GetEnemyHeroes()) do
  if IsReady(_Q) and GetPercentMP(myHero) >= Zilean.AtSpell.ASMP:Value() and Zilean.AtSpell.ATSQ.ASQ:Value() and GotBuff(myHero, "recall") <= 0 and IsInRange(enemy, 900) and CheckQ(enemy) then
   local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),1800,250,GetCastRange(myHero,_Q),160,false,true)
   if QPred.HitChance >= 1 then
    CastSkillShot(_Q, QPred.PredPos)
   end
  end
 end
end
 
function Zilean:AutoE()
 if IsReady(_E) and GetPercentMP(myHero) >= Zilean.AtSpell.ASMP:Value() and Zilean.AtSpell.ATSE.ASE:Value() and Zilean.AtSpell.ATSE.KeyE:Value() and GotBuff(myHero, "recall") <= 0 and CheckE(myHero) then
   CastTargetSpell(myHero, _E)
 end
  if Zilean.AtSpell.ATSE.KeyE:Value() then MoveToXYZ(GetMousePos()) end
end

function Zilean:Harass()
 if IsReady(_Q) and Zilean.hr.HrQ:Value() then
    self:CastQ()
 end
end

function Zilean:LaneJungleClear()
 for _, minimobs in pairs(minionManager.objects) do
  if GetTeam(minimobs) == MINION_ENEMY or GetTeam(minimobs) == MINION_JUNGLE then
   if IsInRange(minimobs, 900) and IsReady(_Q) and Zilean.ljc.LJcQ:Value() then
    CastSkillShot(_Q, GetOrigin(minimobs))
   end
  end
 end
end

function Zilean:AutoSpell()
 self:AutoQ()
 self:AutoE()
 end
 
function Zilean:LevelUp()
 if Zilean.Misc.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First then W
  elseif Zilean.Misc.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q First then E
 end
   LevelSpell(leveltable[GetLevel(myHero)])
end

-------------------------------------------

function Zilean:Draws(myHero)
 if Zilean.Draws.DrawsEb:Value() then

   self:Range()
   self:DmgHPBar()
  if Zilean.Draws.DrawText:Value() then
   self:DrawHP()
   self:InfoR()
   self:DrawRHP()
  end
  
 end
end

function Zilean:Range()
 if IsReady(_Q) or IsReady(_R) then
  if Zilean.Draws.DrawQR:Value() then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.QRcol:Value()) end
  end
 if Zilean.Draws.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.Ecol:Value()) end
end

function Zilean:DrawHP()
 for l, myally in pairs(GetAllyHeroes()) do
  if GetObjectName(myHero) ~= GetObjectName(myally) and IsObjectAlive(myally) and IsInDistance(myally, 4000) then	
  local alliesPos = WorldToScreen(1,GetOrigin(myally))
   if GetLevel(myHero) >= 6 then
    local per = '%'
    local minhp = math.max(1,GetPercentHP(myally))
    local color
    if GetPercentHP(myally) > 20 then color = 0xffffffff else color = 0xffff0000 end
    if GotBuff(myally, "karthusfallenonetarget") >= 1 and KarthusDmg(myally) >= GetHP2(myally) then
     DrawText("This Unit can die with Karthus R",22,alliesPos.x,alliesPos.y+12,0xffff0000)
    end
     DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(myally), GetCurrentHP(myally), GetMaxHP(myally), per, minhp, per), 18, alliesPos.x, alliesPos.y, color)
   end
  end	
 end


  if IsObjectAlive(myHero) and GetLevel(myHero) >= 6  then
   local myTextPos = WorldToScreen(1, myHeroPos())
   local pmh = '%'
   local miniumhp = math.max(1, GetPercentHP(myHero))
    if GetPercentHP(myHero) <= 20 then DrawText(string.format("%sHP = %d%s CAREFUL!", pmh, miniumhp, pmh), 21, myTextPos.x-20, myTextPos.y+15, 0xffff0000) end
   if GotBuff(myHero, "karthusfallenonetarget") >= 1 and KarthusDmg(myHero) >= GetHP2(myHero) then
    DrawText("Karthus R can 'KILL!' You", 22, myTextPos.x-20, myTextPos.y+30, 0xffff0000)
   end
  end
end

function Zilean:InfoR()
    drawtexts = ""
 for l, myally in pairs(GetAllyHeroes()) do
  if GetObjectName(myHero) ~= GetObjectName(myally) and IsObjectAlive(myally) and IsInDistance(myally, 2500) and GetPercentHP(myally) < 20 then
    drawtexts = drawtexts..GetObjectName(myally).." %HP < 20%. Should Use R\n"
  end
 end
    DrawText(drawtexts,27,0,110,0xff00ff00) 
end

function Zilean:DrawRHP()
 if IsObjectAlive(myHero) and IsReady(_R) and Zilean.Misc.AutoR.DrawR:Value() and Zilean.Misc.AutoR.EnbR:Value() then
  local myTextPos = WorldToScreen(1, myHeroPos())
  DrawText(string.format("AutoR if HP < %d | %s%s", GetMaxHP(myHero)*Zilean.Misc.AutoR.myHP:Value()/100, Zilean.Misc.AutoR.myHP:Value(), '%'), 20, myTextPos.x-20, myTextPos.y, 0xffffffff)
 end
end

function Zilean:DmgHPBar()
 for i, enemy in pairs(GetEnemyHeroes()) do
  if ValidTarget(enemy, 4000) then
   if IsReady(_Q) or CheckQ(enemy) then
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("Q",enemy),0xffffffff)
   else
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero),0,0xffffffff)
   end
  end
 end
end

if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end
----------------------------------
	InterruptMenu = MenuConfig("Q-Q to Stop Spell enemy", "Interrupt")
	InterruptMenu:Info("InfoQ", "If you don't see any ON/OFF => No enemy can Interrupt.")
	
DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(ANTI_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
		end
    end
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and GetCurrentMana(myHero) >= 165 + 5*GetCastLevel(myHero, _Q) then
     if IsReady(_Q) or CheckQ(unit) then
      if IsReady(_W) or CheckQ(unit) then
       if ANTI_SPELLS[spell.name] then
        if ValidTarget(unit, GetCastRange(myHero,_Q)) and GetObjectName(unit) == ANTI_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
         local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),1800,250,GetCastRange(myHero,_Q),160,false,true)
		  if QPred.HitChance >= 1 then CastSkillShot(_Q, QPred.PredPos) end
         if IsReady(_W) and not IsReady(_Q) then
          CastSpell(_W)
         end
        end
       end
      end
     end
    end
end)
--------------------------------------------------------------------------

function CheckE(who)
 if GotBuff(who, "TimeWarp") <= 0 then
	return true
 else
	return false
 end
end

function CheckQ(who)
 if GotBuff(who, "zileanqenemybomb") >= 1 then
	return true
 else
	return false
 end
end

function IsInRange(unit, range)
    return ValidTarget(unit, range) and IsObjectAlive(unit)
end

function KarthusDmg(unit)
local Damage
 for i, enemy in pairs(GetEnemyHeroes()) do
  if GetObjectName(enemy) == "Karthus" and enemy ~= nil then
   Damage = CalcDamage(enemy, unit, 0, GetCastLevel(enemy, _R)*150 + 100 + 0.6*GetBonusAP(enemy))
  end 
 end
    return Damage
end

PrintChat(string.format("<font color='#FF0000'>Rx Zilean by Rudo </font><font color='#FFFF00'>Version 0.573 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck %s</font>",GetObjectBaseName(myHero))) 
