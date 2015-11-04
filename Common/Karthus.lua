--[[Rx Karthus Version 0.96 by Rudo.
    Version 0.96: Improve LaneClear, LastHit again
    DrawDmgR when Lv6: You must F6x2 to Reload script if your Ap have a change.
    Go to http://gamingonsteroids.com To Download more script.
    Thanks Deftsu for some Code and DeftLib. Thank Cloud for Karthus Plugin. Thank Inspired for help me in shoul
----------------------------------------------------]]
require('Inspired')
if GetObjectName(myHero) ~= "Karthus" then return end
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
Karthus.FreezeLane:Boolean("QLC", "Use Q LaneClear", true)
Karthus.FreezeLane:Boolean("ELC", "Use E LaneClear", true)
Karthus.FreezeLane:Slider("CELC", "Use E if Minions Around >=", 4, 1, 10, 1)
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

-------------------------------------------------------Starting--------------------------------------------------------------
require('Deftlib')

local BonusAP = GetBonusAP(myHero)
local CheckQDmg = 2*(GetCastLevel(myHero, _Q)*20 + 20 + 0.30*BonusAP)
local CheckEDmg = GetCastLevel(myHero, _E)*20 + 10 + 0.20*BonusAP
local CheckRDmg = GetCastLevel(myHero, _R)*150 + 100 + 0.60*BonusAP
OnTick(function(myHero)
	------ Start Combo ------
    if IOW:Mode() == "Combo" then
local target = tslowhp:GetTarget()
	if target then
 local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,900,GetCastRange(myHero,_Q),150,false,true)
 local WPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_W),800,false,true)
		if IsReady(_W) and GetCurrentMana(myHero) >= 130 and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_W)) and WPred.HitChance == 1 and Karthus.cb.WCB:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
		
		if IsReady(_Q) and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Karthus.cb.QCB:Value() then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
		
		if IsReady(_E) and IsObjectAlive(target) and IsInDistance(target, 15 - GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.cb.ECB:Value() then
		CastSpell(_E)
	    end

		if Karthus.cb.ECB:Value() and not IsInDistance(target, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") >= 1 then
		CastSpell(_E)
		end
	end
	end
	
	------ Start Harass ------
    if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Karthus.hr.HrMana:Value() then
local target = tslowhp:GetTarget()
	if target then
 local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),math.huge,900,GetCastRange(myHero,_Q),150,false,true)
		if IsReady(_Q) and IsObjectAlive(target) and ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Karthus.hr.HrQ:Value() then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
	end
	end
	
	------ Start Lane Clear ------
if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Karthus.FreezeLane.LCMana:Value() then
 for _,creeps in pairs(minionManager.objects) do
  if GetTeam(creeps) == MINION_ENEMY then
		if IsReady(_Q) and IsInDistance(creeps, 875) and Karthus.FreezeLane.QLC:Value() then
			local BestPos, BestHit = GetFarmPosition(875, 145)
			local CheckQLCT = 0
		 if GetLevel(myHero) <= 7 then
		    CheckQLCT = CheckQLCT + 30*(GetCastLevel(myHero, _Q)) 
		 else
		    CheckQLCT = CheckQLCT + 50*(GetCastLevel(myHero, _Q)) 
		 end 	
		 if GetCurrentHP(creeps)+GetMagicShield(creeps)+GetDmgShield(creeps) <= CalcDamage(myHero, creeps, 0, CheckQLCT + CheckQDmg + Ludens()) and IsObjectAlive(creeps) then
			local CheckQArm = 0
			IOW.attacksEnabled = false
			local CheckLC = math.max(10, 1.8*GetLevel(myHero))
		  if MinionsAround(GetOrigin(creeps), 190, MINION_ENEMY) >= 2 or EnemiesAround(GetOrigin(creeps), 190) >= 1 then
			 CheckQArm = CheckQArm + CheckQDmg/2
		  else 
			 CheckQArm = CheckQArm + CheckQDmg
		  end
		  if GetCurrentHP(creeps)+GetMagicShield(creeps)+GetDmgShield(creeps) <= CalcDamage(myHero, creeps, 0, CheckLC + CheckQArm + Ludens()) then
				CastSkillShot(_Q, GetOrigin(creeps).x, GetOrigin(creeps).y, GetOrigin(creeps).z)
		  end
		 elseif GetCurrentHP(creeps)+GetMagicShield(creeps)+GetDmgShield(creeps) > CalcDamage(myHero, creeps, 0, CheckQLCT + CheckQDmg + Ludens()) then
				CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
				IOW.attacksEnabled = true
				--CastSkillShot(_Q, GetOrigin(creeps).x, GetOrigin(creeps).y, GetOrigin(creeps).z)
		 end
		end
		
		if IsReady(_E) and Karthus.FreezeLane.ELC:Value() and IsObjectAlive(creeps) and MinionsAround(GetOrigin(myHero), GetCastRange(myHero,_E), MINION_ENEMY) >= Karthus.FreezeLane.CELC:Value() and GotBuff(myHero, "KarthusDefile") <= 0 then
				CastSpell(_E)	
	    end
		if Karthus.FreezeLane.ELC:Value() and not IsInDistance(creeps, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") >= 1 then
        		CastSpell(_E)	
		end 
  end
 end
end
	
	------ Start Jungle Clear ------
    if Karthus.JungleClear.JEb:Value() and IOW:Mode() == "LaneClear" then
    for _,mobs in pairs(minionManager.objects) do
	if GetTeam(mobs) == MINION_JUNGLE then
	 if IsObjectAlive(mobs) then
		if IsInDistance(mobs, 875) and IsReady(_Q) and Karthus.JungleClear.QJC:Value() then
		 local BestPos, BestHit = GetJFarmPosition(875, 145)
		 if BestPos and BestHit > 0 then 
				CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
		 end
		end
		
		if IsReady(_E) and IsInDistance(mobs, 5-GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") <= 0 and Karthus.JungleClear.EJC:Value() then
				CastSpell(_E)	
	    end
		if Karthus.JungleClear.EJC:Value() and not IsInDistance(mobs, GetCastRange(myHero,_E)) and GotBuff(myHero, "KarthusDefile") > 0 then
        		CastSpell(_E) 
		end
     end		
	end
	end
	end
	
	------ Start Last Hit ------
if IOW:Mode() == "LastHit" then
if GetPercentMP(myHero) < Karthus.LHMinion.LHMana:Value() then
IOW.attacksEnabled = true
elseif GetPercentMP(myHero) >= Karthus.LHMinion.LHMana:Value() then
 for _,minions in pairs(minionManager.objects) do
  if GetTeam(minions) == MINION_ENEMY then
	 if IsInDistance(minions, 875) and IsObjectAlive(minions) then
		local CheckQLHT = 0
		 if GetLevel(myHero) <= 7 then
		    CheckQLHT = CheckQLHT + 30*(GetCastLevel(myHero, _Q)) 
		 else
		    CheckQLHT = CheckQLHT + 50*(GetCastLevel(myHero, _Q)) 
		 end 	
		if IsReady(_Q) and Karthus.LHMinion.QLH:Value() then
		 local CheckKillMinions = CalcDamage(myHero, minions, 0, CheckQLHT + CheckQDmg + Ludens()) 
		if GetCurrentHP(minions)+GetMagicShield(minions)+GetDmgShield(minions) <= CheckKillMinions then
			local CheckQLH = 0
			IOW.attacksEnabled = false
			local CheckLH = math.max(10, 1.8*GetLevel(myHero))
		  if MinionsAround(GetOrigin(minions), 190, MINION_ENEMY) >= 2 or EnemiesAround(GetOrigin(minions), 190) >= 1 then
			 CheckQLH = CheckQLH + CheckQDmg/2
		  else 
			 CheckQLH = CheckQLH + CheckQDmg
		  end
		  if GetCurrentHP(minions)+GetMagicShield(minions)+GetDmgShield(minions) <= CalcDamage(myHero, minions, 0,CheckLH + CheckQLH + Ludens()) then
				CastSkillShot(_Q, GetOrigin(minions).x, GetOrigin(minions).y, GetOrigin(minions).z)
		  end
		elseif GetCurrentHP(minions)+GetMagicShield(minions)+GetDmgShield(minions) > CheckKillMinions then
		IOW.attacksEnabled = false
		end
	    end
	 end
  end
 end
end
end

	------ Start Kill Steal ------
	if Karthus.KS.KSEb:Value() then
 for i,enemy in pairs(GetEnemyHeroes()) do	
		if Ignite and Karthus.KS.IgniteKS:Value() then
                  if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end
	
   if IsReady(_Q) and IsInDistance(enemy, 875) and IsObjectAlive(enemy) and Karthus.KS.QKS:Value() then
	if GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckQDmg + Ludens()) then
	  local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,900,GetCastRange(myHero,_Q),150,false,true)
	 if QPred.HitChance == 1 and ValidTarget(enemy, GetCastRange(myHero, _Q)) then 
	   CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
	 end
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
end)

------------------------------------------------------

OnDraw(function(myHero)
	------ Start Info R ------
if Karthus.InfoR.EninfoR:Value() then
 if IsObjectAlive(myHero) or not IsDead(myHero) then
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
                info = info.." R KILL!\n"
            end
            -- info = info..GetObjectName(enemy).."    HP:"..hp.."  dmg: "..realdmg.." "..Killable.."\n"
        end
  end
  DrawText(info,30,0,110,0xffff0000) 
  end
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
	local CheckQ = CalcDamage(myHero, enemy, 0, CheckQDmg + Ludens())
	local CheckR = CalcDamage(myHero, enemy, 0, CheckRDmg + Ludens())
		if IsReady(_Q) and IsReady(_R) then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,CheckR - Check,0xffffffff)
		elseif IsReady(_R) and not IsReady(_Q) then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,CheckR - Check,0xffffffff)
		elseif IsReady(_Q) and not IsReady(_R) then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,CheckQ - Check,0xffffffff)
		else
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero) - Check, 0,0xffffffff)
		end
		 end
	end
end
end)

if GetLevel(myHero) >= 6 then PrintChat(string.format("<font color='#FFFFFF'>DrawDmgR when Level >= 6: You must F6x2 to Reload script if your Ap have a change. </font>")) end 
PrintChat(string.format("<font color='#FF0000'>Rx Karthus by Rudo </font><font color='#FFFF00'>Version 0.96 Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
