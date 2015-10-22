--[[ Rx Varus Version 0.25 by Rudo.
 Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------]]


require('Inspired')
---- Create a Menu ----
if GetObjectName(myHero) ~= "Varus" then return end
PrintChat(string.format("<font color='#FF0000'>Rx Varus by Rudo </font><font color='#FFFF00'>Version 0.25: Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
----------------------------------------
Varus = Menu("Rx Varus", "Varus")

---- Combo ----
Varus:SubMenu("cb", "Varus Combo")
Varus.cb:Boolean("QCB", "Use Q", true)
Varus.cb:Boolean("ECB", "Use E", true)
Varus.cb:Boolean("RCB", "Use R", true)

---- Harass Menu ----
Varus:SubMenu("hr", "Harass")
Varus.hr:Boolean("HrQ", "Use Q", true)
Varus.hr:Boolean("HrE", "Use E", true)

---- Lane Clear Menu ----
Varus:SubMenu("lc", "Lane Clear")
Varus.lc:Slider("checkLMP", "LaneClear if %MP >= ", 20, 1, 100, 1)
Varus.lc:Boolean("LcE", "Use E", true)

---- Jungle Clear Menu ----
Varus:SubMenu("jc", "Jungle Clear")
Varus.jc:Slider("checkJMP", "LaneClear if %MP >= ", 20, 1, 100, 1)
Varus.jc:Boolean("JcE", "Use E", true)

---- Drawings Menu ----
Varus:SubMenu("Draws", "Drawings")
Varus.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Varus.Draws:Slider("QualiDraw", "Quality Drawings", 110, 1, 255, 1)
Varus.Draws:Boolean("DrawQ", "Range Q Max", true)
Varus.Draws:Boolean("DrawQminE", "Range Q Min and E", true)
Varus.Draws:Boolean("DrawR", "Range R", true)
Varus.Draws:Boolean("DrawText", "Draw Text", true)
Varus.Draws:Slider("PosHitx", "Change Text PoS-X", 76, 1, 110, 1)
Varus.Draws:Slider("PosHity", "Change Text PoS-Y", 43, 1, 110, 1)

---- Misc Menu ----
Varus:SubMenu("Miscset", "Misc")
Varus.Miscset:SubMenu("KS", "Kill Steal")
Varus.Miscset.KS:Boolean("KSEb", "Enable KillSteal", true)
Varus.Miscset.KS:Boolean("QKS", "KS with Q", true)
Varus.Miscset.KS:Boolean("EKS", "KS with E", true)
Varus.Miscset.KS:Boolean("RKS", "KS with R", false)
Varus.Miscset.KS:Boolean("IgniteKS", "KS with IgniteKS", true)
Varus.Miscset:SubMenu("AutoLvlUp", "Auto Level Up")
Varus.Miscset.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Varus.Miscset.AutoLvlUp:List("AutoSkillUp", "Settings", 1, {"Q-W-E", "Q-E-W"}) 
   
---- Use Items Menu ----
Varus:SubMenu("Items", "Auto Use Items")
Varus.Items:SubMenu("PotionHP", "Use Potion HP")
Varus.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
Varus.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 5, 80, 1)
Varus.Items:SubMenu("PotionMP", "Use Potion MP")
Varus.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
Varus.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 5, 80, 1)
Varus.Items:SubMenu("Def", "Items Deffensive")
Varus.Items:SubMenu("Attack", "Items Offensive in Combo")

---------- Items Deffensive ----------
Varus.Items.Def:Info("info0", "QSS + Mercurial Scimitar + Cleanse = Soon")
--[[--- QSS -----
Varus.Items.Def:SubMenu("UseQSS", "Use Quicksilver Sash")
Varus.Items.Def.UseQSS:Boolean("QSS", "Enable", true)
Varus.Items.Def.UseQSS:Info("Info1", "Choose Your Bad Status want to Purifiers")
Varus.Items.Def.UseQSS:Boolean("blind", "Blind", false)
Varus.Items.Def.UseQSS:Boolean("charm", "Charm", true)
Varus.Items.Def.UseQSS:Boolean("fear", "Fear", true)
Varus.Items.Def.UseQSS:Boolean("flee", "Flee", true)
Varus.Items.Def.UseQSS:Boolean("snare", "Snare", false)
Varus.Items.Def.UseQSS:Boolean("taunt", "Taunt", true)
Varus.Items.Def.UseQSS:Boolean("stun", "Stun", true)
Varus.Items.Def.UseQSS:Boolean("suppression", "Suppression", true)
Varus.Items.Def.UseQSS:Boolean("silence", "Silence", false)
Varus.Items.Def.UseQSS:Boolean("exhaust", "Exhaust", true)
Varus.Items.Def.UseQSS:Boolean("ZedUlt", "Zed Ultimate", true)
----- MS -----
Varus.Items.Def:SubMenu("UseMS", "Use Mercurial Scimitar")
Varus.Items.Def.UseMS:Boolean("MS", "Enable", true)
Varus.Items.Def.UseMS:Info("Info2", "Choose Your Bad Status want to Purifiers")
Varus.Items.Def.UseMS:Boolean("blind", "Blind", false)
Varus.Items.Def.UseMS:Boolean("charm", "Charm", true)
Varus.Items.Def.UseMS:Boolean("fear", "Fear", true)
Varus.Items.Def.UseMS:Boolean("flee", "Flee", true)
Varus.Items.Def.UseMS:Boolean("snare", "Snare", false)
Varus.Items.Def.UseMS:Boolean("taunt", "Taunt", true)
Varus.Items.Def.UseMS:Boolean("stun", "Stun", true)
Varus.Items.Def.UseMS:Boolean("suppression", "Suppression", true)
Varus.Items.Def.UseMS:Boolean("silence", "Silence", false)
Varus.Items.Def.UseMS:Boolean("exhaust", "Exhaust", true)
Varus.Items.Def.UseMS:Boolean("ZedUlt", "Zed Ultimate", true)

----- Cleanse -----
Varus.Items.Def:SubMenu("UseClse", "Use Cleanse")
Varus.Items.Def.UseClse:Boolean("Clse", "Enable", true)
Varus.Items.Def.UseClse:Info("Info3", "Choose Your Bad Status want to Purifiers")
Varus.Items.Def.UseClse:Boolean("blind", "Blind", false)
Varus.Items.Def.UseClse:Boolean("charm", "Charm", true)
Varus.Items.Def.UseClse:Boolean("fear", "Fear", true)
Varus.Items.Def.UseClse:Boolean("flee", "Flee", true)
Varus.Items.Def.UseClse:Boolean("snare", "Snare", false)
Varus.Items.Def.UseClse:Boolean("taunt", "Taunt", true)
Varus.Items.Def.UseClse:Boolean("stun", "Stun", true)
Varus.Items.Def.UseClse:Boolean("exhaust", "Exhaust", true)
Varus.Items.Def.UseClse:Boolean("silence", "Silence", false)

------------------------------------------------------------------------]]

---------- Items Offensive ----------
Varus.Items.Attack:Boolean("Cutlass", "Use Bilgewater Cutlass", true)
Varus.Items.Attack:Boolean("BladeORKing", "Use Blade of the Ruined King", true)
Varus.Items.Attack:Boolean("Youmuu", "Use Youmuu's Ghostblade", true)
------------------------------------------------------------------------

---------- End Menu ----------


-------------------------------------------------------Starting--------------------------------------------------------------

require('IOW')
local BonusAP = GetBonusAP(myHero)
local BonusAD = GetBonusDmg(myHero)
Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil)) -- Credit to Deftsu
Cleanse = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerboost") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerboost") and SUMMONER_2 or nil)) -- Credit to Deftsu
-------------------------------------------
OnLoop(function(myHero)
		        local target = GetCurrentTarget()
		        local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1500,250,925,235,false,true)
		        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1950,250,1200,100,false,true)
    	------ Start Combo ------
    if IOW:Mode() == "Combo" and IsObjectAlive(target) then
		if CanUseSpell(myHero, _E) == READY and Varus.cb.ECB:Value() and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		if CanUseSpell(myHero, _Q) == READY and Varus.cb.QCB:Value() and GoS:ValidTarget(target, 1625) then
		CastSkillShot(_Q, GetMousePos().x, GetMousePos().y, GetMousePos().z)
      for i=400, 1600, 200 do
        GoS:DelayAction(function()
              local _Qrange = 825 + math.min(800, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1850,0,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
        end, i)
      end	
        end 
	end

	if IOW:Mode() == "Harass" and IsObjectAlive(target) then
	------ Start Harass ------
		if CanUseSpell(myHero, _E) == READY and Varus.hr.HrE:Value() and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		if CanUseSpell(myHero, _Q) == READY and Varus.cb.QCB:Value() and GoS:ValidTarget(target, 1625) then
		CastSkillShot(_Q, GetMousePos().x, GetMousePos().y, GetMousePos().z)
      for i=400, 1600, 200 do
        GoS:DelayAction(function()
              local _Qrange = 825 + math.min(800, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1850,0,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
        end, i)
      end	
        end
	end
	
		if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Varus.lc.checkLMP:Value() then
	------ Start LaneClear ------
	for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		  if GoS:IsInDistance(minion, 950) then
		 local minionsPos = GetOrigin(minion)
		if CanUseSpell(myHero, _E) == READY and Varus.lc.LcE:Value() then
		CastSkillShot(_E, minionsPos.x, minionsPos.y, minionsPos.z)
		end
		  end
	end
		end
		
		if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Varus.jc.checkJMP:Value() then
	------ Start JungClear ------
	for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		  if GoS:IsInDistance(mob, 950) then
		 local mobPos = GetOrigin(mob)
		if CanUseSpell(myHero, _E) == READY and Varus.jc.JcE:Value() then
		CastSkillShot(_E, mobPos.x, mobPos.y, mobPos.z)
		end
		  end
	end
		end
		
	--------------------------
if Varus.Draws.DrawsEb:Value() then
	Drawings()
	end
	
if Varus.Miscset.KS.KSEb:Value() then
	KillSteal()
	end
	
if Varus.Miscset.AutoLvlUp.UpSpellEb:Value() then
    AutoUpSpell()
	end
	
if Varus.Items.PotionHP.PotHP:Value() then	
	UsePotHP()
	end
	
if Varus.Items.PotionMP.PotMP:Value() then	
	UsePotMP()
	end

--[[
if Varus.Items.Def.UseClse.Clse:Value() then
	Clse()
	end
end
	
if Varus.Items.Def.UseQSS.QSS:Value() then
	QSS()
	end
	
if Varus.Items.Def.UseMS.MS:Value() then
	MS()
	end]]
	
if Varus.Items.Attack.Cutlass:Value() then
	Cutlass()
	end
	
if Varus.Items.Attack.BladeORKing:Value() then
	BladeORKing()
	end
	
if Varus.Items.Attack.Youmuu:Value() then
	Youmuu()
	end
end)

------------------------------------------------------- Start Function -------------------------------------------------------

	------ Start Drawings ------
function Drawings()
if Varus.Draws.DrawQ:Value() and CanUseSpell(myHero, _Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1625,1,Varus.Draws.QualiDraw:Value(),0xff1E90FF) end
if Varus.Draws.DrawQminE:Value() then
if CanUseSpell(myHero, _E) == READY or CanUseSpell(myHero, _Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),2,Varus.Draws.QualiDraw:Value(),0xff9B30FF) end
end
if Varus.Draws.DrawR:Value() and CanUseSpell(myHero, _R) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1200,1,Varus.Draws.QualiDraw:Value(),0xffF8F578) end

            if Varus.Draws.DrawText:Value() then
	for _, enemy in pairs(Gos:GetEnemyHeroes()) do
		 if GoS:ValidTarget(enemy) then
		 
	local EnbIgnite = 0
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	EnbIgnite = EnbIgnite + 20*GetLevel(myHero)+50
	end
	local hp1 = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)
	local hp2 = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)
	local stacksW = GotBuff(enemy, "varuswdebuff") 
	local CheckWDmg = ((0.75*GetCastLevel(myHero, _W) + 1.25)/100)*(GetMaxHP(enemy))
	local CheckQDmg = 55*GetCastLevel(myHero, _Q) - 40 + 1.6*BonusAD
	local CheckEDmg = 35*GetCastLevel(myHero, _E) + 30 + 0.6*BonusAD
	local CheckRDmg = 100*GetCastLevel(myHero, _R) + 50 + 1.0*BonusAP
	local CheckQ2 = 0
	local CheckE2 = 0
	local CheckR2 = 0
	if stacksW == 3 then
	CheckQ2 = CheckQ2 + CheckQDmg + 3*CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + 3*CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + 3*CheckWDmg
	elseif stacksW == 2 then
	CheckQ2 = CheckQ2 + CheckQDmg + 2*CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + 2*CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + 2*CheckWDmg
	elseif stacksW == 1 then
	CheckQ2 = CheckQ2 + CheckQDmg + CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + CheckWDmg
	elseif stacksW <= 0 then
	CheckQ2 = CheckQ2 + CheckQDmg
	CheckE2 = CheckE2 + CheckEDmg
	CheckR2 = CheckR2 + CheckRDmg
	end
		    local originEnemies = GetOrigin(enemy)
		    local EnmTextPos = WorldToScreen(1,originEnemies.x, originEnemies.y, originEnemies.z)
		    if CanUseSpell(myHero, _Q) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckQ2, 0) then
			DrawText("Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _E) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckE2, 0) then
			DrawText("E = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckQ2 + CheckE2, 0) then
			DrawText("Q + E = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckQ2, EnbIgnite) then
			DrawText("Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _E) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckE2, EnbIgnite) then
			DrawText("E + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckQ2 + CheckE2, EnbIgnite) then
			DrawText("Q + E + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _R) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckR2, 0) then
			DrawText("R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _R) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckQ2, EnbIgnite) then
			DrawText("R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckE2 + CheckR2, 0) then
			DrawText("E + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckQ2 + CheckR2, 0) then
			DrawText("Q + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _E) == READY and hp1 < GoS:CalcDamage(myHero, enemy, CheckQ2 + CheckE2 + CheckR2, 0) then
			DrawText("Q + E + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckE2 + CheckR2, EnbIgnite) then
			DrawText("E + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckQ2 + CheckR2, EnbIgnite) then
			DrawText("Q + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _E) == READY and EnbIgnite > 0 and hp2 < GoS:CalcDamage(myHero, enemy, CheckQ2 + CheckE2 + CheckR2, EnbIgnite) then
			DrawText("Q + E + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			else
			DrawText("Can't Kill this Target!!",19,EnmTextPos.x,EnmTextPos.y,0xffC0FF3E)
			end
    local CheckW = 4*GetCastLevel(myHero, _W) + 6 + 0.25*BonusAP
	local Check2 = GetMagicShield(enemy)+GetDmgShield(enemy)
		if CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckQ2 + CheckE2 + CheckR2 - Check2, 0,0xffffffff)
		elseif CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _Q) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckQ2 + CheckR2 - Check2, 0,0xffffffff)
		elseif CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _E) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckR2 + CheckE2 - Check2, 0,0xffffffff)
		elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckQ2 + CheckE2 - Check2, 0,0xffffffff)
		elseif CanUseSpell(myHero, _R) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckR2 - Check2, 0,0xffffffff)
		elseif CanUseSpell(myHero, _Q) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckQ2 - Check2, 0,0xffffffff)
		elseif CanUseSpell(myHero, _E) == READY then
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckE2 - Check2, 0,0xffffffff)
		end
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero) + CheckW - Check2,0,0xffffffff)	
		  
	local checkEnmHp = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)
	local checkDmg = GetBaseDamage(myHero) + CheckW
	local hit
	if checkEnmHp > checkDmg then
	hit = checkEnmHp/checkDmg
	elseif checkEnmHp <= checkDmg then
	hit = 1
	end
		DrawText(string.format("~ %d Hit = KILL!", hit),16,EnmTextPos.x-Varus.Draws.PosHitx:Value(),EnmTextPos.y-Varus.Draws.PosHity:Value(),0xffffffff)
		 end
	end
            end
end


 	------ Start Auto Level Up _Settings Full Q or Full W first ------
function AutoUpSpell()
  if Varus.Miscset.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First then W
  elseif Varus.Miscset.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q First then E
  end
   LevelSpell(leveltable[GetLevel(myHero)])
end

 	------ Start Use Items _Use Health Potion_ ------
function UsePotHP()
global_ticks = 0
currentTicks = GetTickCount()
 if Varus.Items.PotionHP.PotHP:Value() and GotBuff(myHero, "recall") <= 0 then
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < Varus.Items.PotionHP.CheckHP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2003))
						end
					end
				end
			end
			
  end	
  
 	------ Start Use Items _Use Mana Potion_ ------
function UsePotMP()
global_ticks = 0
currentTicks = GetTickCount()
 if Varus.Items.PotionMP.PotMP:Value() and GotBuff(myHero, "recall") <= 0 then
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 < Varus.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
  end			

 	------ Start Use Items Deffensive ------

        --[[- Cleanse ---

function Clse()
if Cleanse and CanUseSpell(myHero, Cleanse) == READY then
		if Varus.Items.Def.UseClse.blind:Value() and GotBuff(myHero, "blind") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.charm:Value() and GotBuff(myHero, "charm") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.fear:Value() and GotBuff(myHero, "fear") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.flee:Value() and GotBuff(myHero, "flee") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.snare:Value() and GotBuff(myHero, "snare") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.taunt:Value() and GotBuff(myHero, "taunt") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.stun:Value() and GotBuff(myHero, "stun") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseMS.suppression:Value() and GotBuff(myHero, "suppression") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.silence:Value() and GotBuff(myHero, "silence") > 0 then
			CastSpell(Cleanse)
		elseif Varus.Items.Def.UseClse.exhaust:Value() and GotBuff(myHero, "summonerexhaust") > 0 then
			CastSpell(Cleanse)
		end
	end		
end
	
        --- QSS ---
function QSS()
local QSilverS = GetItemSlot(myHero, 3140)
	if QSilverS > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3140)) == READY and GotBuff(myHero, "recall") <= 0 then
		if Varus.Items.Def.UseQSS.blind:Value() and GotBuff(myHero, "blind") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.charm:Value() and GotBuff(myHero, "charm") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.fear:Value() and GotBuff(myHero, "fear") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.flee:Value() and GotBuff(myHero, "flee") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.snare:Value() and GotBuff(myHero, "snare") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.taunt:Value() and GotBuff(myHero, "taunt") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.stun:Value() and GotBuff(myHero, "stun") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.suppression:Value() and GotBuff(myHero, "suppression") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.silence:Value() and GotBuff(myHero, "silence") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.exhaust:Value() and GotBuff(myHero, "summonerexhaust") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
		if Varus.Items.Def.UseQSS.ZedUlt:Value() and GotBuff(myHero, "zedultexecute") > 0 then
			CastSpell(GetItemSlot(myHero, 3140))
		end
	end
end

        --- MS ---
function MS()
local MercurialS = GetItemSlot(myHero, 3139)
	if MercurialS > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3139)) == READY and GotBuff(myHero, "recall") <= 0 then
		if Varus.Items.Def.UseMS.blind:Value() and GotBuff(myHero, "blind") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.charm:Value() and GotBuff(myHero, "charm") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.fear:Value() and GotBuff(myHero, "fear") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.flee:Value() and GotBuff(myHero, "flee") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.snare:Value() and GotBuff(myHero, "snare") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.taunt:Value() and GotBuff(myHero, "taunt") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.stun:Value() and GotBuff(myHero, "stun") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.suppression:Value() and GotBuff(myHero, "suppression") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.silence:Value() and GotBuff(myHero, "silence") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.exhaust:Value() and GotBuff(myHero, "summonerexhaust") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
		if Varus.Items.Def.UseMS.ZedUlt:Value() and GotBuff(myHero, "zedultexecute") > 0 then
			CastSpell(GetItemSlot(myHero, 3139))
		end
	end
end ]]

 	------ Start Use Items Offensive ------

        --- Bilgewater Cutlass ---
function Cutlass()
local BC = GetItemSlot(myHero, 3144)
local target = GetCurrentTarget()
	if IOW:Mode() == "Combo" then
		if BC > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY and GoS:ValidTarget(target, 550) and GotBuff(myHero, "recall") <= 0 then
			CastTargetSpell(target, GetItemSlot(myHero, 3144))
		end
	end
end

        --- Youmuu's Ghostblade ---
		
function Youmuu()
local YoumuuGhost = GetItemSlot(myHero, 3142)
local target = GetCurrentTarget()
	if IOW:Mode() == "Combo" then
		if YoumuuGhost > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3142)) == READY and GoS:ValidTarget(target, 1300) and GotBuff(myHero, "recall") <= 0 then
			CastSpell(GetItemSlot(myHero, 3142))
		end
	end
end

        --- Blade of the Ruined King ---
		
function BladeORKing()
local BORKing = GetItemSlot(myHero, 3153)
local target = GetCurrentTarget()
	if IOW:Mode() == "Combo" then
		if BORKing > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY and GoS:ValidTarget(target, 550) and GotBuff(myHero, "recall") <= 0 then
			CastTargetSpell(target, GetItemSlot(myHero, 3153))
		end
	end
end
		
 	------ Start Kill Steal ------
function KillSteal()
for _,enemy in pairs(GoS:GetEnemyHeroes()) do

        -- Kill Steal --
	local hp1 = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)
	local hp2 = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)
	local EPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1500,250,925,235,false,true)
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1950,250,1200,100,false,true)
	local stacksW = GotBuff(enemy, "varuswdebuff") 
	local CheckWDmg = ((0.75*GetCastLevel(myHero, _W) + 1.25)/100)*(GetMaxHP(enemy))
	local CheckQDmg = 55*GetCastLevel(myHero, _Q) - 40 + 1.6*BonusAD
	local CheckEDmg = 35*GetCastLevel(myHero, _E) + 30 + 0.6*BonusAD
	local CheckRDmg = 100*GetCastLevel(myHero, _R) + 50 + 1.0*BonusAP
	local CheckQ2 = 0
	local CheckE2 = 0
	local CheckR2 = 0
	if stacksW == 3 then
	CheckQ2 = CheckQ2 + CheckQDmg + 3*CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + 3*CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + 3*CheckWDmg
	elseif stacksW == 2 then
	CheckQ2 = CheckQ2 + CheckQDmg + 2*CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + 2*CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + 2*CheckWDmg
	elseif stacksW == 1 then
	CheckQ2 = CheckQ2 + CheckQDmg + CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + CheckWDmg
	elseif stacksW <= 0 then
	CheckQ2 = CheckQ2 + CheckQDmg
	CheckE2 = CheckE2 + CheckEDmg
	CheckR2 = CheckR2 + CheckRDmg
	end

		if Ignite and Varus.Miscset.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end

	if CanUseSpell(myHero, _Q) == READY and Varus.Miscset.KS.QKS:Value() and hp1 < GoS:CalcDamage(myHero, enemy, CheckQ2, 0) and IsObjectAlive(enemy) and GoS:ValidTarget(enemy, 1625) then
		CastSkillShot(_Q, GetMousePos().x, GetMousePos().y, GetMousePos().z)
      for i=400, 1600, 200 do
        GoS:DelayAction(function()
               if hp1 < GoS:CalcDamage(myHero, enemy, CheckQ2, 0) then
              local _Qrange = 825 + math.min(800, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1850,0,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
			   end
        end, i)
      end	
	 end
	if CanUseSpell(myHero, _E) == READY and IsObjectAlive(enemy) and GoS:ValidTarget(enemy, GetCastRange(myHero,_E)) and Varus.Miscset.KS.EKS:Value() and hp1 < GoS:CalcDamage(myHero, enemy, CheckE2, 0) and EPred.HitChance == 1 then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
	elseif CanUseSpell(myHero, _R) == READY and IsObjectAlive(enemy) and GoS:ValidTarget(enemy, 1150) and Varus.Miscset.KS.RKS:Value() and hp1 < GoS:CalcDamage(myHero, enemy, CheckR2, 0) and RPred.HitChance == 1 then
		CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	end
end
end


---------------------------------------------------
if GetObjectName(myHero) ~= "Varus" then
local nameMyHero = GetObjectName(myHero)
PrintChat(string.format("<font color='#FF0000'>This Script </font><font color='#FFFF00'>Don't Support for </font><font color='#08F7F3'> %s </font>", nameMyHero)) 
end
