--[[ Rx Zilean Version 0.15 by Rudo.
 Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------]]


require('Inspired')
---- Create a Menu ----
if GetObjectName(myHero) ~= "Zilean" then return end
PrintChat(string.format("<font color='#FF0000'>Rx Zilean by Rudo </font><font color='#FFFF00'>Version 0.15: Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
----------------------------------------
Zilean = Menu("Rx Zilean", "Zilean")

---- Combo ----
Zilean:SubMenu("cb", "Zilean Combo")
Zilean.cb:Boolean("QCB", "Use Q", true)
Zilean.cb:Boolean("WCB", "Use W", true)
Zilean.cb:Boolean("ECB", "Use E", true)

---- Harass Menu ----
Zilean:SubMenu("hr", "Harass")
Zilean.hr:Boolean("HrQ", "Use Q", true)

---- Lane Clear Menu ----
Zilean:SubMenu("lc", "Lane Clear")
Zilean.lc:Slider("checkMP", "LaneClear if %MP >= ", 20, 1, 100, 1)
Zilean.lc:Boolean("LcQ", "Use Q", true)

---- Auto Spell Menu ----
Zilean:SubMenu("AtSpell", "Auto Spell")
Zilean.AtSpell:Boolean("ASEb", "Enable Auto Spell", true)
Zilean.AtSpell:Slider("ASMP", "Auto Spell if %MP >=", 30, 10, 100, 1)
Zilean.AtSpell:SubMenu("ATSQ", "Auto Spell Q")
Zilean.AtSpell.ATSQ:Boolean("ASQ", "Use Q", true)
Zilean.AtSpell.ATSQ:Info("info1", "Auto Q if can stun enemy")
Zilean.AtSpell.ATSQ:Info("info2", "Q to enemy have a bomb")
Zilean.AtSpell:SubMenu("ATSE", "Auto Spell E")
Zilean.AtSpell.ATSE:Boolean("ASE", "Use E", true)
Zilean.AtSpell.ATSE:Key("KeyE", "Press 'T' to Auto E", string.byte("T"))
Zilean.AtSpell.ATSE:Info("info3", "This is a Mode 'RUNNING!'")

---- Drawings Menu ----
Zilean:SubMenu("Draws", "Drawings")
Zilean.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Zilean.Draws:Slider("QualiDraw", "Quality Drawings", 110, 1, 255, 1)
Zilean.Draws:Boolean("DrawQ", "Range Q", true)
Zilean.Draws:Boolean("DrawE", "Range E", true)
Zilean.Draws:Boolean("DrawR", "Range R", true)
Zilean.Draws:Boolean("DrawText", "Draw Text", true)

---- Misc Menu ----
Zilean:SubMenu("Miscset", "Misc")
Zilean.Miscset:SubMenu("KS", "Kill Steal")
Zilean.Miscset.KS:Boolean("KSEb", "Enable KillSteal", true)
Zilean.Miscset.KS:Boolean("QKS", "KS with Q", true)
Zilean.Miscset.KS:Boolean("IgniteKS", "KS with IgniteKS", true)
Zilean.Miscset:SubMenu("AntiSkill", "Stop Skill Enemy")
Zilean.Miscset.AntiSkill:Boolean("EbAnti", "Q Stop Spell Enemy", true)
Zilean.Miscset.AntiSkill:Info("info4", "Q-Q to Stun enemy")
Zilean.Miscset:SubMenu("AutoLvlUp", "Auto Level Up")
Zilean.Miscset.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Zilean.Miscset.AutoLvlUp:List("AutoSkillUp", "Settings", 1, {"Q-W-E", "Q-E-W"}) 
   
---- Use Items Menu ----
Zilean:SubMenu("Items", "Auto Use Items")
Zilean.Items:SubMenu("PotionHP", "Use Potion HP")
Zilean.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
Zilean.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 5, 80, 1)
Zilean.Items:SubMenu("PotionMP", "Use Potion MP")
Zilean.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
Zilean.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 5, 80, 1)
---------- End Menu ----------


-------------------------------------------------------Starting--------------------------------------------------------------

require('IOW')
CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["FiddleSticks"]                = {_R},
    ["Galio"]                       = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Shen"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Pantheon"]                    = {_R},
    ["Warwick"]                     = {_R},
    ["Xerath"]                      = {_R},
	["Kennen"]                      = {_R},
    ["Twisted Fate"]                = {_R},
	["Tahm Kench"]                  = {_R},
}

local callback = nil
 
OnProcessSpell(function(unit, spell)    
        if not callback or not unit or GetObjectType(unit) ~= Obj_AI_Hero  or GetTeam(unit) == GetTeam(GetMyHero()) then return end
        local unitChanellingSpells = CHANELLING_SPELLS[GetObjectName(unit)]
 
        if unitChanellingSpells then
            for _, spellSlot in pairs(unitChanellingSpells) do
                if spell.name == GetCastName(unit, spellSlot) then callback(unit, CHANELLING_SPELLS) end
            end
	end
end)
 
function addAntiSkillCallback( callback0 )
        callback = callback0
end

addAntiSkillCallback(function(target, spellType)
  local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,300,900,100,false,true)
  if GoS:IsInDistance(target, 900) and Zilean.Miscset.AntiSkill.EbAnti:Value() then
  	if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and spellType == CHANELLING_SPELLS then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    end
    if CanUseSpell(myHero, _W) == READY and  CanUseSpell(myHero, _Q) ~= READY and spellType == CHANELLING_SPELLS then
    CastSpell(_W)
    end
    if CanUseSpell(myHero, _Q) == READY and GotBuff(target, "zileanqenemybomb") and spellType == CHANELLING_SPELLS then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
    end
  end
end)

local BonusAP = GetBonusAP(myHero)
local CheckQDmg = (GetCastLevel(myHero, _Q)*40) + 35 + (0.90*BonusAP)
-------------------------------------------
OnLoop(function(myHero)
		        local target = GetCurrentTarget()
		        local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,300,900,100,false,true)
    	------ Start Combo ------
    if IOW:Mode() == "Combo" then
        if  CanUseSpell(myHero, _Q) == READY and Zilean.cb.QCB:Value() and GoS:ValidTarget(target, 870) and QPred.HitChance == 1 and IsObjectAlive(target) then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
        if CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) ~= READY and Zilean.cb.WCB:Value() and GoS:IsInDistance(target, 900) then
		CastSpell(_W)
		end
		if CanUseSpell(myHero, _E) == READY and Zilean.cb.ECB:Value() and GoS:GetDistance(myHero, target) >= 880 then
		CastTargetSpell(myHero, _E)
		end
	end

	if IOW:Mode() == "Harass" then
	------ Start Harass ------
        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, 870) and Zilean.cb.QCB:Value() then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end	
	end

	if IOW:Mode() == "LaneClear" then	 
	------ Start Lane Clear ------	
	for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		  if GoS:IsInDistance(minion, 900) then
		   if Zilean.lc.LcQ:Value() and CanUseSpell(myHero, _Q) == READY then
		 local minionsPos = GetOrigin(minion)
		 local hpMinions = GetCurrentHP(minion)
		 local CheckKillMinions = GoS:CalcDamage(myHero, minion, 0, 100 + CheckQDmg*2)
		 if hpMinions <= CheckKillMinions and CanUseSpell(myHero, _W) == READY then
		 CastSkillShot(_Q,minionsPos.x, minionsPos.y, minionsPos.z)
		 elseif CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _Q) == READY and hpMinions <= CheckKillMinions then
		 CastSkillShot(_Q,minionsPos.x, minionsPos.y, minionsPos.z)
		 end
		   end
		  end
	end
	end
	
	--------------------------
if Zilean.Draws.DrawsEb:Value() then
	Drawings()
	end
	
if Zilean.AtSpell.ASEb:Value() then
	AutoSpell()
	end
	
if Zilean.Miscset.KS.KSEb:Value() then
	KillSteal()
	end
	
if Zilean.Miscset.AutoLvlUp.UpSpellEb:Value() then
    AutoUpSpell()
	end
	
if Zilean.Items.PotionHP.PotHP:Value() then	
	UsePotHP()
	end
	
if Zilean.Items.PotionMP.PotMP:Value() then	
	UsePotMP()
	end
end)
	
------------------------------------------------------- Start Function -------------------------------------------------------

	------ Start AutoSpell ------
function AutoSpell()
  for _, enemy in pairs(Gos:GetEnemyHeroes()) do
if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Zilean.AtSpell.ASMP:Value() and CanUseSpell(myHero, _E) == READY and Zilean.AtSpell.ATSE.ASE:Value() and Zilean.AtSpell.ATSE.KeyE:Value() and GotBuff(myHero, "recall") <= 0 and GotBuff(myHero, "TimeWarp") <= 0 then
   CastTargetSpell(myHero, _E)
end
if Zilean.AtSpell.ATSE.KeyE:Value() and GotBuff(myHero, "recall") <= 0 then
   MoveToXYZ(GetMousePos().x, GetMousePos().y, GetMousePos().z)
end
if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Zilean.AtSpell.ASMP:Value() and CanUseSpell(myHero, _Q) == READY and Zilean.AtSpell.ATSQ.ASQ:Value() and GotBuff(myHero, "recall") <= 0 and GotBuff(enemy, "zileanqenemybomb") > 0 and GoS:ValidTarget(enemy, 880) then
local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2000,300,900,100,false,true)
if QPred.HitChance == 1 then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
  end
end

 	------ Start Kill Steal ------
function KillSteal()
for i,enemy in pairs(GoS:GetEnemyHeroes()) do

        -- Kill Steal --
 	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2000,300,900,100,false,true)
	  local LudensEcho = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		LudensEcho = LudensEcho + 0.1*BonusAP + 100
		end

		if Ignite and Zilean.Miscset.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end

	if CanUseSpell(myHero, _Q) and GoS:ValidTarget(enemy, 880) and Zilean.Miscset.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) and QPred.HitChance == 1 then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
end
end

 	------ Start Auto Level Up _Settings Full Q or Full W first ------
function AutoUpSpell()
  if Zilean.Miscset.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First then W
  elseif Zilean.Miscset.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q First then E
  end
   LevelSpell(leveltable[GetLevel(myHero)])
end

 	------ Start Use Items _Use Health Potion_ ------
function UsePotHP()
global_ticks = 0
currentTicks = GetTickCount()
 if Zilean.Items.PotionHP.PotHP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < Zilean.Items.PotionHP.CheckHP:Value() then  
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
 if Zilean.Items.PotionMP.PotMP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 < Zilean.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
  end			
	
	
	------ Start Drawings ------
function Drawings()
if Zilean.Draws.DrawQ:Value() and CanUseSpell(myHero, _Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),1,Zilean.Draws.QualiDraw:Value(),0xff1E90FF) end
if Zilean.Draws.DrawE:Value() and CanUseSpell(myHero, _E) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),1,Zilean.Draws.QualiDraw:Value(),0xff9B30FF) end
if Zilean.Draws.DrawR:Value() and CanUseSpell(myHero, _R) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),1,Zilean.Draws.QualiDraw:Value(),0xffF8F578) end

            if Zilean.Draws.DrawText:Value() then
	for _, enemy in pairs(Gos:GetEnemyHeroes()) do
		 if GoS:ValidTarget(enemy) then
		local LudensEcho = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		LudensEcho = LudensEcho + 0.1*BonusAP + 100
	    end
	local EnbIgnite = 0
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	EnbIgnite = EnbIgnite + 20*GetLevel(myHero)+50
	end
		    local originEnemies = GetOrigin(enemy)
		    local EnmTextPos = WorldToScreen(1,originEnemies.x, originEnemies.y, originEnemies.z)
		    if CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
			DrawText("Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
	        elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 2*CheckQDmg + LudensEcho) then
			DrawText("Q-W-Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho + EnbIgnite) then
			DrawText("Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 2*CheckQDmg + LudensEcho + EnbIgnite) then
			DrawText("Q-W-Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFFD700)
			end
	
		    local maxhp = GetMaxHP(enemy)
		    local currhp = GetCurrentHP(enemy)
			local percent = 100*currhp/maxhp
			local originEnemies = GetOrigin(enemy)
		    local EnmTextPos = WorldToScreen(1,originEnemies.x, originEnemies.y, originEnemies.z)
		    DrawText(string.format("%s HP: %d / %d | Percent HP = %d", GetObjectName(enemy), currhp, maxhp, percent),16,EnmTextPos.x,EnmTextPos.y+23,0xffffffff)
         end
	end	
	
   if GetLevel(myHero) >= 6 then	
	for _, myally in pairs(GoS:GetAllyHeroes()) do
		 if GetObjectName(myHero) ~= GetObjectName(myally) then	
	    if IsObjectAlive(myally) then
		    local originAllies = GetOrigin(myally)
		    local AllyTextPos = WorldToScreen(1,originAllies.x, originAllies.y, originAllies.z)
		    local maxhpA = GetMaxHP(myally)
		    local currhpA = GetCurrentHP(myally)
			local percentA = 100*currhpA/maxhpA
			local line = 0
			if percentA < 20 then
			line = line + 17
			DrawText(string.format("%s HP: %d | Percent HP < 20", GetObjectName(myally), currhpA),17,AllyTextPos.x,AllyTextPos.y+line,0xffffffff)
			end
	    end
		 end
	end
   end	
            end
			
	 for _, enemy in pairs(Gos:GetEnemyHeroes()) do
		 if GoS:ValidTarget(enemy) then
		 local currhp = GetCurrentHP(enemy)
		local LudensEcho = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		LudensEcho = LudensEcho + 0.1*BonusAP + 100
	    end   
    if CanUseSpell(myHero, _Q) == READY then
		  DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQDmg + LudensEcho,0xffffffff)
    else
          DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),LudensEcho,0xffffffff)
    end
		 end
	 end
end			
