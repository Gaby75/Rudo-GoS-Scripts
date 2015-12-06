--[[Rx Karthus by Rudo
    Version 0.1: Released
    Go to http://gamingonsteroids.com To Download more script.
    Thank: Deftsu, Zypppy, and Cloud for Karthus plugins
----------------------------------------------------]]

if GetObjectName(GetMyHero()) ~= "Karthus" then return end

require('Inspired')
local WebVersion = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/Karthus.version"
local CheckWebVer = require("GOSUtility").request("https://raw.githubusercontent.com",WebVersion.."?no-cache="..(math.random(100000))) -- Copy from Inspired >3
local ScriptVersion = 0.1 -- Current Version
AutoUpdate("/anhvu2001ct/Rudo-GoS-Scripts/master/Common/Karthus.lua",WebVersion,"Karthus.lua",ScriptVersion)
PrintChat(string.format("<font color='#C926FF'>Script Current Version:</font><font color='#FF8000'> %s </font>| <font color='#C926FF'>Newest Version:</font><font color='#FF8000'> %s </font>", ScriptVersion, tonumber(CheckWebVer)))
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#3366FF'>Cloud </font><font color='#FFFFFF'>, </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))

---- Create a Menu ----
Karthus = MenuConfig("Rx Karthus", "Karthus")
tslowhp = TargetSelector(875, 8, DAMAGE_MAGIC) -- 8 = TARGET_LOW_HP
Karthus:TargetSelector("ts", "Target Selector", tslowhp)

---- Combo ----
Karthus:Menu("cb", "Karthus Combo")
Karthus.cb:Boolean("QCB", "Use Q", true)
Karthus.cb:Boolean("WCB", "Use W", true)
Karthus.cb:Boolean("ECB", "Use E", true)

---- Harass Menu ----
Karthus:Menu("hr", "Harass")
Karthus.hr:Boolean("HrQ", "Use Q", true)
Karthus.hr:Slider("HrMana", "Enable Harass if My %MP >", 30, 0, 100, 1)

---- Lane Clear Menu ----
Karthus:Menu("FreezeLane", "Lane Clear")
Karthus.FreezeLane:Slider("LCMana", "Enable LaneClear if %My MP >=", 20, 0, 100, 1)
Karthus.FreezeLane:Boolean("QLC", "Use Q LaneClear", true)
Karthus.FreezeLane:Boolean("ELC", "Use E LaneClear", true)
Karthus.FreezeLane:Slider("CELC", "Use E if Minions Around >=", 3, 1, 10, 1)

---- Last Hit Menu ----
Karthus:Menu("LHMinion", "Last Hit Minion")
Karthus.LHMinion:Boolean("QLH", "Use Q Last Hit", true)
Karthus.LHMinion:Slider("LHMana", "Enable LastHit if %My MP >=", 10, 0, 100, 1)
PermaShow(Karthus.LHMinion.QLH)

---- Jungle Clear Menu ----
Karthus:Menu("JungleClear", "Jungle Clear")
Karthus.JungleClear:Boolean("QJC", "Use Q Jungle Clear", true)
Karthus.JungleClear:Boolean("EJC", "Use E Jungle Clear", true)

---- Kill Steal Menu ----
Karthus:Menu("KS", "Kill Steal")
Karthus.KS:Boolean("KSEb", "Enable KillSteal", true)
Karthus.KS:Boolean("QKS", "KS with Q", true)
Karthus.KS:Boolean("IgniteKS", "KS with Ignite", true)
PermaShow(Karthus.KS.IgniteKS)
PermaShow(Karthus.KS.QKS)

---- Draw Enemy can KS with R Menu ----
Karthus:Menu("InfoR", "Draw Enemy can KS with R")
Karthus.InfoR:Boolean("EninfoR", "Draw R Info", true)
Karthus.InfoR:Info("infoR1", "If you can see Enemy can KS with R")
Karthus.InfoR:Info("infoR2", "Press R to Killable enemy")
PermaShow(Karthus.InfoR.EninfoR)

---- Drawings Menu ----
Karthus:Menu("Draws", "Drawings")
Karthus.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Karthus.Draws:Menu("Range", "Skills Range")
Karthus.Draws.Range:Slider("QualiDraw", "Range Quality", 110, 1, 255, 1)
Karthus.Draws.Range:Boolean("DrawQ", "Q Range", true)
Karthus.Draws.Range:ColorPick("Qcol", "Setting Q Color", {255, 135, 206, 250})
Karthus.Draws.Range:Boolean("DrawW", "W Range", true)
Karthus.Draws.Range:ColorPick("Wcol", "Setting W Color", {255, 29, 29, 30})
Karthus.Draws.Range:Boolean("DrawE", "W Range", true)
Karthus.Draws.Range:ColorPick("Ecol", "Setting E Color", {255, 178, 58, 238})
Karthus.Draws:Menu("Texts", "Draws Text")
Karthus.Draws.Texts:Boolean("DrawTexts", "Enable Draws Text", true)
Karthus.Draws.Texts:Boolean("EnmHP", "Draw HP Enemy", true)
Karthus.Draws.Texts:Boolean("DamageR", "Draw R Damage", true)
PermaShow(Karthus.Draws.Texts.DamageR)

---- Misc Menu ----
Karthus:Menu("Miscset", "Auto Level Up")
Karthus.Miscset:Boolean("AutoSkillUpQ", "Auto Lvl Up Q-E-W", true)
Karthus.Miscset:Boolean("StopE", "Auto Stop E", true)
Karthus.Miscset:Info("SEI", "Auto Stop E if no creeps/enemy in E range")
Karthus.Miscset:Info("StopEInfo", "If you want to spam Seraph's Embrace you must OFF it")
PermaShow(Karthus.Miscset.StopE)

Karthus:Info("info1", "Use PActivator for Auto Use Items")

---------- End Menu ----------

-------------------------------------------------------Starting--------------------------------------------------------------
require('Deftlib')
require('DamageLib')

OnTick(function(myHero)
local CheckQDmg = 2*(GetCastLevel(myHero, _Q)*20 + 20 + 0.30*GetBonusAP(myHero))
	------ Start Combo ------
local target = tslowhp:GetTarget()
 if target then
  if IOW:Mode() == "Combo" then
 local WPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,250,GetCastRange(myHero,_W),800,false,true)
 local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,775,GetCastRange(myHero,_W),160,false,true)
   if IsReady(_W) and GetCurrentMana(myHero) >= 130 and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_W)) and WPred.HitChance >= 1 and Karthus.cb.WCB:Value() then
		CastSkillShot(_W, WPred.PredPos)
   end
		
   if IsReady(_Q) and IsInRange(target, GetCastRange(myHero,_Q)) and QPred.HitChance >= 1 and Karthus.cb.QCB:Value() then
    CastSkillShot(_Q, QPred.PredPos)
   end
		
   if IsReady(_E) and IsInRange(target, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.cb.ECB:Value() then
		CastSpell(_E)
   end

	end
	
	------ Start Harass ------
  if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Karthus.hr.HrMana:Value() then
   local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,775,GetCastRange(myHero,_W),160,false,true)
   if IsReady(_Q) and IsInRange(target, GetCastRange(myHero,_Q)) and QPred.HitChance >= 1 and Karthus.hr.HrQ:Value() then
     CastSkillShot(_Q, QPred.PredPos)
   end
  end
 end
	
	------ Start Lane Clear ------
if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Karthus.FreezeLane.LCMana:Value() then
 for i=1, minionManager.maxObjects do
 local creeps = minionManager.objects[i]
  if GetTeam(creeps) ~= GetTeam(myHero) and IsInRange(creeps, GetCastRange(myHero,_Q)) then
   if IsReady(_Q) and Karthus.FreezeLane.QLC:Value() then
    if GetCurrentHP(creeps) < CalcDamage(myHero, creeps, GetBaseDamage(myHero), CheckQDmg) +8+4*GetLevel(myHero) then
	local Checkmnos = MinionsAround(GetOrigin(creeps), 190, MINION_ENEMY)
    local Enm = EnemiesAround(GetOrigin(creeps), 190)
    local QDmgPredict = GetCurrentHP(creeps) - GetDamagePrediction(creeps, 250 + GetDistance(creeps)/math.random(2215,2255))
    local DmgCheck
    if Checkmnos >= 2 and Enm >= 1 then
	  DmgCheck = CheckQDmg/2
	elseif Checkmnos <= 1 and Enm < 1 then
	  DmgCheck = CheckQDmg
	elseif Checkmnos >= 2 and Enm < 1 then
	  DmgCheck = CheckQDmg/2
	elseif Checkmnos <= 1 and Enm >= 1 then
	  DmgCheck = CheckQDmg/2
	end
     if QDmgPredict > 0 and QDmgPredict <= DmgCheck then
      CastSkillShot(_Q, GetOrigin(creeps))
     else
      IOW.attacksEnabled = false
     end
	else
	 CastSkillShot(_Q, GetOrigin(creeps))
	 IOW.attacksEnabled = true
    end
   end
		
   if IsReady(_E) and Karthus.FreezeLane.ELC:Value() and IsObjectAlive(creeps) and MinionsAround(GetOrigin(myHero), GetCastRange(myHero,_E), MINION_ENEMY) >= Karthus.FreezeLane.CELC:Value() and GotBuff(myHero, "KarthusDefile") <= 0 then
    CastSpell(_E)	
   end
  end
 end
end
	
	------ Start Jungle Clear ------
if IOW:Mode() == "LaneClear" then
 for _, mobs in pairs(minionManager.objects) do
  if GetTeam(mobs) == MINION_JUNGLE and IsInRange(creeps, GetCastRange(myHero,_Q)) then
   if IsReady(_Q) and Karthus.JungleClear.QJC:Value() then
	CastSkillShot(_Q, GetOrigin(mobs))
   end
		
   if IsReady(_E) and IsInDistance(mobs, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.JungleClear.EJC:Value() then
    CastSpell(_E)	
   end
  end
 end
end
	
	------ Start Last Hit ------
if IOW:Mode() == "LastHit" and GetPercentMP(myHero) >= Karthus.LHMinion.LHMana:Value() then
 for i=1, minionManager.maxObjects do
 local minions = minionManager.objects[i]
  if GetTeam(minions) ~= GetTeam(myHero) and IsInRange(minions, GetCastRange(myHero,_Q)) then
  local Checkmnos = MinionsAround(GetOrigin(minions), 190, MINION_ENEMY)
  local Enm = EnemiesAround(GetOrigin(minions), 190)
   if IsReady(_Q) and Karthus.LHMinion.QLH:Value() then
   local QDmgPredict = GetCurrentHP(minions) - GetDamagePrediction(minions, 250 + GetDistance(minions)/math.random(2215,2255))
   local DmgCheck
    if Checkmnos >= 2 and Enm >= 1 then
	  DmgCheck = CheckQDmg/2
	elseif Checkmnos <= 1 and Enm < 1 then
	  DmgCheck = CheckQDmg
	elseif Checkmnos >= 2 and Enm < 1 then
	  DmgCheck = CheckQDmg/2
	elseif Checkmnos <= 1 and Enm >= 1 then
	  DmgCheck = CheckQDmg/2
	end
    if QDmgPredict > 0 and QDmgPredict <= DmgCheck then
     CastSkillShot(_Q, GetOrigin(minions))
    else
     IOW.attacksEnabled = false
    end
   end
  end
 end
end

	------ Start Kill Steal ------
if Karthus.KS.KSEb:Value() then
 for i, enemy in pairs(GetEnemyHeroes()) do	
  if Ignite and Karthus.KS.IgniteKS:Value() then
   if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
    CastTargetSpell(enemy, Ignite)
   end
  end
	
  if IsReady(_Q) and IsInRange(enemy, GetCastRange(myHero, _Q)) and GetHP2(enemy) <= getdmg("Q",enemy) and Karthus.KS.QKS:Value() then
   local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,775,GetCastRange(myHero,_W),160,false,true)
   if QPred.HitChance >= 1 then
    CastSkillShot(_Q, QPred.PredPos)
   end
  end
 end
end

	------ Start Auto Lvl Up ------ --- Full Q First then E, last is W	
	if Karthus.Miscset.AutoSkillUpQ:Value() then
 if GetLevel(myHero) == 1 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
	LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
	LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
	LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
 end
    end	

if GotBuff(myHero, "KarthusDefile") >= 1 then
if IOW:Mode() == "Combo" and EnemiesAround(GetOrigin(myHero), GetCastRange(myHero, _E)) <= 0 then CastSpell(_E) end
if IOW:Mode() == "LaneClear" and MinionsAround(GetOrigin(myHero), GetCastRange(myHero, _E), MINION_ENEMY) <= Karthus.FreezeLane.CELC:Value() then CastSpell(_E) end
if Karthus.Miscset.StopE:Value() and MinionsAround(GetOrigin(myHero), GetCastRange(myHero, _E), MINION_ENEMY) < 2 and MinionsAround(GetOrigin(myHero), GetCastRange(myHero, _E), MINION_JUNGLE) < 1 and EnemiesAround(GetOrigin(myHero), GetCastRange(myHero, _E)) <= 0 then CastSpell(_E) end end
end)

------------------------------------------------------

OnDraw(function(myHero)
	------ Start Info R ------
if Karthus.InfoR.EninfoR:Value() and GetLevel(myHero) >= 6 and not IsDead(myHero) then
                        info = ""
  for nID, enemy in pairs(GetEnemyHeroes()) do
   if IsObjectAlive(enemy) then
    if getdmg("R",enemy) > GetHP2(enemy) then
    info = info..GetObjectName(enemy)
     if not IsVisible(enemy) then
      info = info.." Not see enemy in map maybe"
     end
      info = info.." R KILL!\n"
    end
   end
  end
 DrawText(info,30,0,110,0xffff0000) 
end

	------ Start Drawings ------
if Karthus.Draws.DrawsEb:Value() then 
if Karthus.Draws.Range.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Karthus.Draws.Range.QualiDraw:Value(),Karthus.Draws.Range.Qcol:Value()) end
if Karthus.Draws.Range.DrawW:Value() and IsReady(_W) then DrawCircle(myHeroPos(),GetCastRange(myHero,_W),2,Karthus.Draws.Range.QualiDraw:Value(),Karthus.Draws.Range.Wcol:Value()) end
if Karthus.Draws.Range.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),1,Karthus.Draws.Range.QualiDraw:Value(),Karthus.Draws.Range.Ecol:Value()) end
if Karthus.Draws.Texts.DrawTexts:Value() then
 for i, enemy in pairs(GetEnemyHeroes()) do
  if ValidTarget(enemy) then
   local EnmTextPos = WorldToScreen(1,GetOrigin(enemy))
   if IsReady(_R) and GetHP2(enemy) <= getdmg("R",enemy) then
    DrawText("Enemy R = KILL",20,EnmTextPos.x,EnmTextPos.y+23,0xffff0000)
   end
			
   if Karthus.Draws.Texts.EnmHP:Value() then
   local maxhp = GetMaxHP(enemy)
   local currhp = GetCurrentHP(enemy)
   local percent = 100*currhp/maxhp
   local pn = '%'
    DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(enemy), currhp, maxhp, pn, percent, pn),16,EnmTextPos.x,EnmTextPos.y,0xffffffff)
   end
  end
			
  if GetLevel(myHero) >= 6 and IsObjectAlive(myHero) then
   local myTextPos = WorldToScreen(1,myHeroPos())
   if Karthus.Draws.Texts.DamageR:Value() then local RDmg = GetCastLevel(myHero, _R)*150 + 100 + 0.60*GetBonusAP(myHero) + Ludens()
    DrawText(string.format("Damage R = %d Dmg", RDmg),16,myTextPos.x,myTextPos.y,0xffffffff) end
   if IsReady(_R) and GetHP2(enemy) <= getdmg("R",enemy) then
    if ValidTarget(enemy) then
     DrawText(string.format("R = Kill Enemy"),20,myTextPos.x,myTextPos.y+23,0xffff0000) 
    end
   end
  end
 end
end

 for i, enemy in pairs(GetEnemyHeroes()) do
  if ValidTarget(enemy) then
   local Check = GetMagicShield(enemy)+GetDmgShield(enemy)
   if IsReady(_Q) and IsReady(_R) then
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("R",enemy) - Check,0xffffffff)
   elseif IsReady(_R) and not IsReady(_Q) then
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("R",enemy) - Check,0xffffffff)
   elseif IsReady(_Q) and not IsReady(_R) then
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("Q",enemy) - Check,0xffffffff)
   else
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero) - Check, 0,0xffffffff)
   end
  end
 end
end
end) -- End Drawings

function IsInRange(unit, range)
	return ValidTarget(unit, range) and IsObjectAlive(unit)
end
PrintChat(string.format("<font color='#FF0000'>Rx Karthus by Rudo </font><font color='#FFFF00'>Version 0.98 Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
