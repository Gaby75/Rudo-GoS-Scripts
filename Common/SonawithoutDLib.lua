--[[ Rx Sona Without deLibrary Version 1.2 by Rudo.
 Updated Sona for Inspired Ver30 and IOW
 Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------

 ..######...#######..###.....##....###
 .##....##.##.....##.####....##...##.##
 .##.......##.....##.##.##...##..##...##
 ..######..##.....##.##..##..##.##.....##
 .......##.##.....##.##...##.##.#########
 .##....##.##.....##.##....####.##.....##
 ..######...#######..##.....###.##.....##

                                                --]]
---------------------------------------------------

require('Inspired')
---- Create a Menu ----
if GetObjectName(myHero) ~= "Sona" then return end
Sona = Menu("Rx Sona", "Sona")

---- Combo ----
Sona:SubMenu("cb", "Sona Combo")
Sona.cb:Boolean("QCB", "Use Q", true)
Sona.cb:Boolean("WCB", "Use W", true)
Sona.cb:Boolean("ECB", "Use E", true)
Sona.cb:Boolean("RCB", "Use R", true)
Sona.cb:Boolean("FQCCB", "Use Frost Queen's Claim", true)

---- Harass Menu ----
Sona:SubMenu("hr", "Harass")
Sona.hr:Boolean("HrQ", "Use Q", true)

---- Auto Spell Menu ----
Sona:SubMenu("AtSpell", "Auto Spell")
Sona.AtSpell:Boolean("ASEb", "Enable Aut Spell", true)
Sona.AtSpell:Boolean("ASQ", "Use Q", true)
Sona.AtSpell:Boolean("ASW", "Use W", true)
Sona.AtSpell:Slider("ASMana", "Auto Spell if My %MP >", 10, 0, 80, 1)

---- Drawings Menu ----
Sona:SubMenu("Draws", "Drawings")
Sona.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Sona.Draws:Boolean("DrawQ", "Range Q", true)
Sona.Draws:Boolean("DrawW", "Range W", true)
Sona.Draws:Boolean("DrawE", "Range E", true)
Sona.Draws:Boolean("DrawR", "Range R", true)
Sona.Draws:Boolean("DrawText", "Draw Text", true)
Sona.Draws:Boolean("DrawCircleAlly", "Draw Circle Around Ally", true)
Sona.Draws:Info("info", "It Draw Circle if %HP Allies < 70%")
---- Misc Menu ----
Sona:SubMenu("Miscset", "Misc")
Sona.Miscset:SubMenu("KS", "Kill Steal")
Sona.Miscset.KS:Boolean("KSEb", "Enable KillSteal", true)
Sona.Miscset.KS:Boolean("QKS", "KS with Q", true)
Sona.Miscset.KS:Boolean("RKS", "KS with R", true)
Sona.Miscset:SubMenu("AntiSkill", "Stop Skill Enemy")
Sona.Miscset.AntiSkill:Boolean("RAnti", "Stop Skil Enemy with R", true)
Sona.Miscset:SubMenu("AutoLvlUp", "Auto Level Up")
Sona.Miscset.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Sona.Miscset.AutoLvlUp:List("AutoSkillUp", "Settings", 1, {"Q-W-E", "W-Q-E"}) 
Sona.Miscset.KS:Boolean("IgniteKS", "KS with Ignite", true)
   
---- Use Items Menu ----
Sona:SubMenu("Items", "Auto Use Items")
Sona.Items:SubMenu("PotionHP", "Use Potion HP")
Sona.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
Sona.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 5, 80, 1)
Sona.Items:SubMenu("PotionMP", "Use Potion MP")
Sona.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
Sona.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 5, 80, 1)

---------- End Menu ----------


local info = "Rx Sona Loaded."
local upv = "Upvote if you like it >3"
local sig = "Made by Rudo"
textTable = {info,upv,sig}
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])

PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Version 1.2 without deLibrary Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 

----- End Print -----

-------------------------------------------------------require('DLib')-------------------------------------------------------

-------------------------------------------------------Starting--------------------------------------------------------------


require('IOW')
CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["FiddleSticks"]                = {_R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Shen"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Pantheon"]                    = {_R},
    ["Warwick"]                     = {_R},
    ["Xerath"]                      = {_R},
    ["Ezreal"]                      = {_R},
	["Kennen"]                      = {_R},
    ["Rengar"]                      = {_R},
    ["Twisted Fate"]                = {_R},
	["Tahm Kench"]                  = {_R},
    ["Ezreal"]                      = {_R},
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
  local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2400,250,1000,150,false,true)
  if GoS:IsInDistance(target, 1000) and CanUseSpell(myHero,_R) == READY and Sona.Miscset.AntiSkill.RAnti:Value() and spellType == CHANELLING_SPELLS then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

local BonusAP = GetBonusAP(myHero)
local CheckQDmg = (GetCastLevel(myHero, _Q)*40) + (0.50*BonusAP)
local CheckRDmg = (GetCastLevel(myHero, _R)*100) + 50 + (0.50*BonusAP)

OnLoop(function(myHero)
		        local target = IOW:GetTarget()
	------ Start Combo ------
    if IOW:Mode() == "Combo" then
	
		if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 845) and Sona.cb.QCB:Value() then
		CastSpell(_Q)
        end
					
		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 840) and Sona.cb.WCB:Value() then
		CastSpell(_W)
		end
				
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1000) and Sona.cb.ECB:Value() then
		CastSpell(_E)
		end
		
		local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2400,300,1000,150,false,true)
        if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(target, 950) and Sona.cb.RCB:Value() then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
		
		if Sona.cb.FQCCB:Value() then
			local frostquc = GetItemSlot(myHero, 3096)
		if frostquc >= 0 then
			local FPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1800,200,880,270,false,true)
		if CanUseSpell(GetItemSlot(myHero, 3096)) == READY and GoS:ValidTarget(target, 880) and FPred.HitChance == 1 then  
		        CastSkillShot(GetItemSlot(myHero, 3096,FPred.PredPos.x,FPred.PredPos.y,FPred.PredPos.z))
		end
		end
		end
	end	
					
	if IOW:Mode() == "Harass" then
	------ Start Harass ------
        if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 845) and Sona.hr.HrQ:Value() then
		CastSpell(_Q)
        end	
	end
	
if Sona.AtSpell.ASEb:Value() then
	AutoSpell()
	end
	
if Sona.Miscset.KS.KSEb:Value() then
	KillSteal()
	end
	
if Sona.Miscset.AutoLvlUp.UpSpellEb:Value() then
	AutoUpSpell()
	end
	
if Sona.Items.PotionHP.PotHP:Value() then	
	UsePotHP()
	end
	
if Sona.Items.PotionMP.PotMP:Value() then	
	UsePotMP()
	end
	
if Sona.Draws.DrawsEb:Value() then
	Drawings()
	end
end)
 

------------------------------------------------------- Start Function -------------------------------------------------------

	------ Start Auto Spell ------
function AutoSpell()
	if Sona.AtSpell.ASEb:Value() then
 if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > Sona.AtSpell.ASMana:Value() then
               for i,enemy in pairs(GoS:GetEnemyHeroes()) do				  
	local target = GetCurrentTarget()
      if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 845) and Sona.AtSpell.ASQ:Value() then
	  CastSpell(_Q)
 end

  if CanUseSpell(myHero, _W) == READY and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.55 and Sona.AtSpell.ASW:Value() then
    CastSpell(_W)
  end
               for _, ally in pairs(GoS:GetAllyHeroes()) do
		if GoS:IsInDistance(myHero, enemy) <= 1250 then	   
  if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(myHero, ally) <= 1000 and (GetCurrentHP(ally)/GetMaxHP(ally))<0.80 and Sona.AtSpell.ASW:Value() then
    CastSpell(ally, _W)
  end
        end
       if GoS:IsInDistance(myHero, enemy) > 1250 then	   
  if CanUseSpell(myHero, _W) == READY and GoS:IsInDistance(myHero, ally) <= 1000 and (GetCurrentHP(ally)/GetMaxHP(ally))<0.50 and Sona.AtSpell.ASW:Value() then
    CastSpell(ally, _W)
  end
       end
                end 
				end
 end
 	end
 end
 
 	------ Start Kill Steal ------
function KillSteal()
 	if Sona.Miscset.KS.KSEb:Value() then
for i,enemy in pairs(GoS:GetEnemyHeroes()) do

        -- Kill Steal --
 	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2400,200,1000,150,false,true)
	  local LudensEcho = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		LudensEcho = LudensEcho + 0.1*GetBonusAP(myHero) + 100
		end

		if Ignite and Sona.Miscset.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
                  CastTargetSpell(enemy, Ignite)
                  end
                end

	if CanUseSpell(myHero, _Q) and GoS:ValidTarget(enemy, 845) and Sona.Miscset.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
		CastSpell(_Q)
    elseif CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(enemy, 950) and Sona.Miscset.KS.RKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckRDmg + LudensEcho) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	end
end
	end
end

 	------ Start Auto Level Up _Settings Full Q or Full W first ------
function AutoUpSpell()
 if Sona.Miscset.AutoLvlUp.UpSpellEb:Value() then
  if Sona.Miscset.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First
  elseif Sona.Miscset.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W , _R, _W , _W, _Q , _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- Full W First
  end
   LevelSpell(leveltable[GetLevel(myHero)])
 end
end

 	------ Start Use Items _Use Health Potion_ ------
function UsePotHP()
global_ticks = 0
currentTicks = GetTickCount()
 if Sona.Items.PotionHP.PotHP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < Sona.Items.PotionHP.CheckHP:Value() then  
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
 if Sona.Items.PotionMP.PotMP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 < Sona.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
  end			
	
	------ Start Drawings ------
function Drawings()
  if Sona.Draws.DrawsEb:Value() then
if Sona.Draws.DrawQ:Value() and CanUseSpell(myHero, _Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),2,175,0xff3366FF) end
if Sona.Draws.DrawW:Value() and CanUseSpell(myHero, _W) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),2,175,0xff99FF66) end
if Sona.Draws.DrawE:Value() and CanUseSpell(myHero, _E) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),2,175,0xff8201B2) end
if Sona.Draws.DrawR:Value() and CanUseSpell(myHero, _R) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),2,175,0xffFFFF33) end
 if Sona.Draws.DrawCircleAlly:Value() then
 	for _, myally in pairs(GoS:GetAllyHeroes()) do
	    if IsObjectAlive(myally) then
		    local originAllies = GetOrigin(myally)
		    local maxhpA = GetMaxHP(myally)
		    local currhpA = GetCurrentHP(myally)
			local percentA = 100*currhpA/maxhpA
		 if percentA < 70 then
		    DrawCircle(originAllies.x,originAllies.y,originAllies.z,1000,1,150,0xff00FFFF)
		 end
	    end
 	end
 end
 if Sona.Draws.DrawText:Value() then
	for _, enemy in pairs(Gos:GetEnemyHeroes()) do
		 if GoS:ValidTarget(enemy) then
		local LudensEcho = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		LudensEcho = LudensEcho + 0.1*GetBonusAP(myHero) + 100
	    end
	local EnbIgnite = 0
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	EnbIgnite = EnbIgnite + 20*GetLevel(myHero)+50
	end
		    local originEnemies = GetOrigin(enemy)
		    local EnmTextPos = WorldToScreen(1,originEnemies.x, originEnemies.y, originEnemies.z)
		    if CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
			DrawText("Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
			DrawText("Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckRDmg + LudensEcho) then
			DrawText("R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + LudensEcho) then
			DrawText("Q + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckRDmg + LudensEcho) then
			DrawText("R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + LudensEcho) then
			DrawText("Q + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			else
			DrawText("Can't Kill this Target!",19,EnmTextPos.x,EnmTextPos.y,0xff00FF66)
			end
		    local maxhp = GetMaxHP(enemy)
		    local currhp = GetCurrentHP(enemy)
			local percent = 100*currhp/maxhp
		    DrawText(string.format("%s HP: %d / %d | Percent HP = %d", GetObjectName(enemy), currhp, maxhp, percent),16,EnmTextPos.x,EnmTextPos.y+23,0xffffffff)
			local CheckQRDmg = CheckQDmg + CheckRDmg + LudensEcho
		    if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQRDmg,0xffffffff)
			elseif CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckRDmg + LudensEcho,0xffffffff)
			elseif CanUseSpell(myHero, _Q) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQDmg + LudensEcho,0xffffffff)
			else
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),LudensEcho,0xffffffff)
			end
		 end
	end
	for _, myally in pairs(GoS:GetAllyHeroes()) do
	    if IsObjectAlive(myally) then
		    local originAllies = GetOrigin(myally)
		    local AllyTextPos = WorldToScreen(1,originAllies.x, originAllies.y, originAllies.z)
		    local maxhpA = GetMaxHP(myally)
		    local currhpA = GetCurrentHP(myally)
			local percentA = 100*currhpA/maxhpA
		 if GetObjectName(myHero) ~= GetObjectName(myally) then	
			DrawText(string.format("Ally HP: %d / %d | Percent HP = %d", currhpA, maxhpA, percentA),16,AllyTextPos.x,AllyTextPos.y,0xffffffff)
	     end
		end
	end
	    if IsObjectAlive(myHero) then
		    local myorigin = GetOrigin(myHero)
		    local mytextPos = WorldToScreen(1,myorigin.x, myorigin.y, myorigin.z)
			local checkhealW = (GetCastLevel(myHero, _W)*20) + 10 (0.20*BonusAP)
			local checkshieldW = (GetCastLevel(myHero, _W)*20) + 15 (0.20*BonusAP)
			DrawText(string.format("Heal of W: %d HP | Shield of W: %d Armor", checkhealE, checkshieldE),18,mytextPos.x,mytextPos.y,0xffffffff)
	    end
 end
  end
end
