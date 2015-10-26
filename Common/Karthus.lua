-- Rx Karthus Version 0.7 by Rudo.
-- Updated Karthus for Inspired Ver30 and IOW V2
-- Go to http://gamingonsteroids.com   To Download more script.
-- Thanks Deftsu for some Code and DeftLib  . Thank Cloud for Karthus Plugin. ^.^
----------------------------------------------------
require('MenuConfig')
require('Inspired')
if GetObjectName(myHero) ~= "Karthus" then return end
PrintChat(string.format("<font color='#FF0000'>Rx Karthus by Rudo </font><font color='#FFFF00'>Version 0.7 Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#3366FF'>Cloud </font><font color='#FFFFFF'> and </font><font color='#00FFCC'> Deftsu </font>"))
---- Create a Menu ----
Karthus = MenuConfig("Rx Karthus", "Karthus")
Karthus:TargetSelector("ts", "Target Selector", TARGET_LOW_HP, 875, DAMAGE_MAGIC)

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
Karthus.FreezeLane:Boolean("QLC", "Use Q LaneClear", true)
Karthus.FreezeLane:Boolean("ELC", "Use E LaneClear", true)
Karthus.FreezeLane:Slider("LCMana", "Enable LaneClear if My %MP >", 20, 0, 100, 1)

---- Last Hit Menu ----
Karthus:Menu("LHMinion", "Last Hit Minion")
Karthus.LHMinion:Boolean("QLH", "Use Q Last Hit", true)
Karthus.LHMinion:Slider("LHMana", "Enable LastHit if %My MP >", 20, 0, 100, 1)
PermaShow(Karthus.LHMinion.QLH)

---- Jungle Clear Menu ----
Karthus:Menu("JungleClear", "Jungle Clear")
Karthus.JungleClear:Boolean("JEb", "Enable Jungle Clear", true)
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
Karthus.InfoR:Info("infoR1", "If you can see Enemy can KS with R")
Karthus.InfoR:Info("infoR2", "Press R to Killable enemy")
Karthus.InfoR:Boolean("EninfoR", "Enable Draw Enemy can KS with R", true)

---- Drawings Menu ----
Karthus:Menu("Draws", "Drawings")
Karthus.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Karthus.Draws:Slider("QualiDraw", "Quality Drawings", 110, 1, 255, 1)
Karthus.Draws:Boolean("DrawQ", "Range Q", true)
Karthus.Draws:ColorPick("Qcol", "Setting Q Color", {255, 135, 206, 250})
Karthus.Draws:Boolean("DrawW", "Range W", true)
Karthus.Draws:ColorPick("Wcol", "Setting W Color", {255, 29, 29, 30})
Karthus.Draws:Boolean("DrawE", "Range E", true)
Karthus.Draws:ColorPick("Ecol", "Setting E Color", {255, 178, 58, 238})
Karthus.Draws:Boolean("DrawTexts", "Draw Text", true)
PermaShow(Karthus.Draws.DrawTexts)

---- Misc Menu ----
Karthus:Menu("Miscset", "Auto Level Up")
Karthus.Miscset:Boolean("AutoSkillUpQ", "Auto Lvl Up Q-E-W", true)  

Karthus:Info("info1", "Use PActivator for Auto Use Items")

---------- End Menu ----------
-- karthusfallenonecastsound --
-------------------------------------------------------Starting--------------------------------------------------------------
require('Deftlib')
require('IOW')

local BonusAP = GetBonusAP(myHero)
local CheckQDmg = 2*((GetCastLevel(myHero, _Q)*20) + 20 + (0.30*BonusAP))
local CheckEDmg = (GetCastLevel(myHero, _E)*20) + 10 + (0.20*BonusAP)
local CheckRDmg = (GetCastLevel(myHero, _R)*150) + 100 + (0.60*BonusAP)
local target = GetCurrentTarget()
OnTick(function(myHero)
	------ Start Combo ------
    if IOW:Mode() == "Combo" then
 local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,900,GetCastRange(myHero,_Q),145,false,true)
 local WPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_W),800,false,true)
		if IsReady(_W) and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_W)) and WPred.HitChance == 1 and Karthus.cb.WCB:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
		if IsReady(_Q) and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Karthus.cb.QCB:Value() then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if IsReady(_E) and IsObjectAlive(target) and IsInDistance(target, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.cb.ECB:Value() then
		CastSpell(_E)
	    end

		if Karthus.cb.ECB:Value() and IsObjectAlive(target) and not IsInDistance(target, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") > 0 then
		CastSpell(_E)
		end
	end
	
	------ Start Harass ------
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Karthus.hr.HrMana:Value() then
 local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,900,GetCastRange(myHero,_Q),145,false,true)
		if IsReady(_Q) and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Karthus.hr.HrQ:Value() then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
	end
	
	------ Start Lane Clear ------
    if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Karthus.FreezeLane.LCMana:Value() then
	local creeps = IOW:GetLaneClear()
	if creeps then
		if IsInDistance(creeps, 875) and IsReady(_Q) and Karthus.FreezeLane.QLC:Value() then
		 local BestPos, BestHit = GetFarmPosition(875, 145)
		 if BestPos and BestHit > 0 then 
				CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
		 end
		end
		
		if IsReady(_E) and IsInDistance(creeps, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.FreezeLane.ELC:Value() then
				CastSpell(_E)	
	    end
		if Karthus.FreezeLane.ELC:Value() and not IsInDistance(creeps, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") > 0 then
        		CastSpell(_E)	
		end 
	end
	end
	
	------ Start Jungle Clear ------
    if Karthus.JungleClear.JEb:Value() and IOW:Mode() == "LaneClear" then
    for _,mobs in pairs(minionManager.objects) do
		if IsInDistance(mobs, 875) and IsReady(_Q) and Karthus.JungleClear.QJC:Value() then
		 local BestPos, BestHit = GetJFarmPosition(875, 145)
		 if BestPos and BestHit > 0 then 
				CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
		 end
		end
		
		if IsReady(_E) and IsInDistance(mobs, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.JungleClear.EJC:Value() then
				CastSpell(_E)	
	    end
		if Karthus.JungleClear.EJC:Value() and not IsInDistance(mobs, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") > 0 then
        		CastSpell(_E)	
		end	 
	end
	end
	
	------ Start Last Hit ------
	if IOW:Mode() == "LastHit" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Karthus.LHMinion.LHMana:Value() then
	local minions = IOW:GetLastHit()
	if minions then
	 if IsInDistance(minions, 875) then
		if IsReady(_Q) then
		 local hpMinions = GetCurrentHP(minions)+GetMagicShield(minions)+GetDmgShield(minions)
		 local CheckKillMinions = CalcDamage(myHero, minions, 0, CheckQDmg + Ludens()) 
		if hpMinions < CheckKillMinions then
		 local originMLH = GetOrigin(minions)
		if Karthus.LHMinion.QLH:Value() then
				CastSkillShot(_Q, originMLH.x, originMLH.y, originMLH.z)
		end
		end
	    end
	 end
	end
	end

	------ Start Kill Steal ------
	if Karthus.KS.KSEb:Value() then
function KillSteal()
 for i,enemy in pairs(GetEnemyHeroes()) do	
		if Ignite and Karthus.KS.IgniteKS:Value() then
                  if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end
	
   if IsReady(_Q) and IsInDistance(enemy, 875) and IsObjectAlive(enemy) and Karthus.KS.QKS:Value() then
	if GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckQDmg + Ludens()) then
	  local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,900,GetCastRange(myHero,_Q),145,false,true)
	 if QPred.HitChance == 1 and ValidTarget(enemy, GetCastRange(myHero, _Q)) then 
	   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
	 end
	end
   end
 end
end
	end

	------ Start Auto Lvl Up ------	
	if Karthus.Miscset.AutoSkillUpQ:Value() then
function AutoLvlUp() --- Full Q First then E, last is W
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
    end	
-------------------------------------
if GotBuff(myHero, "karthusfallenonecastsound") >= 1 then
IOW.attacksEnabled = false
IOW.movementEnabled = false
else
IOW.attacksEnabled = true
IOW.movementEnabled = true
end
end)

------------------------------------------------------

OnDraw(function(myHero)
	------ Start Info R ------
if Karthus.InfoR.EninfoR:Value() then
   if GetLevel(myHero) >= 6 then
   
    info = ""
    for nID, enemy in pairs(GetEnemyHeroes()) do
        if IsObjectAlive(enemy) then
            realdmg = CalcDamage(myHero, enemy, 0, CheckRDmg + Ludens())
            hp = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)
            if realdmg > hp then
                info = info..GetObjectName(enemy)
                if not IsVisible(enemy) then
                    info = info.." Not see enemy in map maybe"
                end
                info = info.." - R KILL!\n"
            end
            -- info = info..GetObjectName(enemy).."    HP:"..hp.."  dmg: "..realdmg.." "..Killable.."\n"
        end
  end
  DrawText(info,30,0,110,0xffff0000) 
   end
end

	------ Start Drawings ------
if Karthus.Draws.DrawsEb:Value() then 
if Karthus.Draws.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Karthus.Draws.QualiDraw:Value(),Karthus.Draws.Qcol:Value()) end
if Karthus.Draws.DrawW:Value() and IsReady(_W) then DrawCircle(myHeroPos(),GetCastRange(myHero,_W),3,Karthus.Draws.QualiDraw:Value(),Karthus.Draws.Wcol:Value()) end
if Karthus.Draws.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),1,Karthus.Draws.QualiDraw:Value(),Karthus.Draws.Ecol:Value()) end
if Karthus.Draws.DrawTexts:Value() then
	for _, enemy in pairs(GetEnemyHeroes()) do
		 if ValidTarget(enemy) then
		    local originEnm = GetOrigin(enemy)
		    local EnmTextPos = WorldToScreen(1,originEnm.x, originEnm.y, originEnm.z)
			if IsReady(_R) and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckRDmg + Ludens()) then
			DrawText("Enemy R = KILL",20,EnmTextPos.x,EnmTextPos.y+23,0xffff0000)
			end
			
			local maxhp = GetMaxHP(enemy)
		    local currhp = GetCurrentHP(enemy)
			local percent = 100*currhp/maxhp
			local pn = '%'
			DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(enemy), currhp, maxhp, pn, percent, pn),16,EnmTextPos.x,EnmTextPos.y,0xffffffff) 
		 end
			
			if GetLevel(myHero) >= 6 and IsObjectAlive(myHero) then
			local myTextPos = WorldToScreen(1,myHeroPos().x, myHeroPos().y, myHeroPos().z)
			local RDmg = CheckRDmg + Ludens()
			DrawText(string.format("Damage R = %d Dmg", RDmg),16,myTextPos.x,myTextPos.y,0xffffffff) 
			if IsReady(_R) and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckRDmg + Ludens()) then
			if ValidTarget(enemy) then
			DrawText(string.format("R = Kill Enemy"),20,myTextPos.x,myTextPos.y+23,0xffff0000) 
			end
			end
			end
	end
end
	for _, enemy in pairs(GetEnemyHeroes()) do
		 if ValidTarget(enemy) then
	local Check = GetMagicShield(enemy)+GetDmgShield(enemy)
		if IsReady(_Q) and IsReady(_R) then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckRDmg + Ludens() - Check, 0,0xffffffff)
		elseif IsReady(_R) and not IsReady(_Q) then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckRDmg + Ludens() - Check, 0,0xffffffff)
		elseif IsReady(_Q) and not IsReady(_R) then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckQDmg + Ludens() - Check, 0,0xffffffff)
		else
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero) - Check, 0,0xffffffff)
		end
		 end
	end
end
end)
