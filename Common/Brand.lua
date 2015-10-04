-- Rx Brand Version 0.45 by Rudo.
-- Updated Brand for Inspired Ver30 and IOW
-- Go to http://gamingonsteroids.com   To Download more script.
-- Thanks Deftsu for some Code <3 , Zypppy and Noddy because help me in Shoutbox :) . Thank snowbell and Maxxxel for script Brand. :3 And thank Vision for test my script ^_^
----------------------------------------------------
if GetObjectName(myHero) ~= "Brand" then return end
PrintChat(string.format("<font color='#FF0000'>Rx Brand by Rudo </font><font color='#FFFF00'>Version 0.45 Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
---- Create a Menu ----
Brand = Menu("Rx Brand", "Brand")

---- Combo ----
Brand:SubMenu("cb", "Brand Combo")
Brand.cb:Boolean("QCB", "Use Q", true)
Brand.cb:Boolean("WCB", "Use W", true)
Brand.cb:Boolean("ECB", "Use E", true)
Brand.cb:Boolean("RCB", "Use R", true)

---- Harass Menu ----
Brand:SubMenu("hr", "Harass")
Brand.hr:Boolean("HrQ", "Use Q", true)
Brand.hr:Boolean("HrW", "Use W", true)
Brand.hr:Boolean("HrE", "Use E", true)
Brand.hr:Slider("HrMana", "Enable Harass if My %MP >", 30, 0, 100, 1)

---- Auto Spell Menu ----
Brand:SubMenu("AtSpell", "Auto Spell")
Brand.AtSpell:Boolean("ASEb", "Enable Auto Spell", true)
Brand.AtSpell:Boolean("ASQ", "Use Q if can stun", false)
Brand.AtSpell:Slider("ASMana", "Auto Spell if My %MP >", 40, 0, 100, 1)

---- Lane Clear Menu ----
Brand:SubMenu("FreezeLane", "Lane Clear")
Brand.FreezeLane:Boolean("WLC", "Use W LaneClear", true)
Brand.FreezeLane:Boolean("ELC", "Use E LaneClear", true)
Brand.FreezeLane:Slider("LCMana", "Enable LaneClear if My %MP >", 30, 0, 100, 1)

---- Jungle Clear Menu ----
Brand:SubMenu("JungleClear", "Jungle Clear")
Brand.JungleClear:Boolean("QJC", "Use Q LaneClear", true)
Brand.JungleClear:Boolean("WJC", "Use W LaneClear", true)
Brand.JungleClear:Boolean("EJC", "Use E LaneClear", true)

---- Kill Steal Menu ----
Brand:SubMenu("KS", "Kill Steal")
Brand.KS:Boolean("KSEb", "Enable KillSteal", true)
Brand.KS:Boolean("QKS", "KS with Q", true)
Brand.KS:Boolean("WKS", "KS with W", true)
Brand.KS:Boolean("EKS", "KS with E", true)
Brand.KS:Boolean("RKS", "KS with R", true)
Brand.KS:Boolean("IgniteKS", "KS with Ignite", true)

---- Stop Spell Enemy ----
Brand:SubMenu("Interrupt", "Interrupt With WQ")
Brand.Interrupt:Boolean("ItrW", "Use W", true)
Brand.Interrupt:Boolean("ItrE", "Use E", true)
Brand.Interrupt:Boolean("ItrQ", "Use Q", true)

---- Drawings Menu ----
Brand:SubMenu("Draws", "Drawings")
Brand.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Brand.Draws:Slider("QualiDraw", "Quality Drawings", 80, 1, 255, 1)
Brand.Draws:Boolean("DrawQ", "Range Q", true)
Brand.Draws:Boolean("DrawW", "Range W", true)
Brand.Draws:Boolean("DrawE", "Range E", true)
Brand.Draws:Boolean("DrawR", "Range R", true)
Brand.Draws:Boolean("DrawText", "Draw Test", true)

---- Misc Menu ----
Brand:SubMenu("AutoLvlSpell", "Auto Level Up")
Brand.AutoLvlSpell:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)  
Brand.AutoLvlSpell:List("AutoSkillUp", "Settings", 1, {"Q-W-E", "W-Q-E"}) 
---- Use Items Menu ----
Brand:SubMenu("Items", "Auto Use Items")
Brand.Items:SubMenu("PotionHP", "Use Potion HP")
Brand.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
Brand.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 3, 80, 1)
Brand.Items:SubMenu("PotionMP", "Use Potion MP")
Brand.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
Brand.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 3, 80, 1)

---------- End Menu ----------

-------------------------------------------------------Starting--------------------------------------------------------------
require('Inspired')
require('IOW')

local BonusAP = GetBonusAP(myHero)
local CheckQDmg = (GetCastLevel(myHero, _Q)*40) + 40 + (0.65*BonusAP)
local CheckWDmg = (GetCastLevel(myHero, _W)*45) + 30 + (0.60*BonusAP)
local CheckEDmg = (GetCastLevel(myHero, _E)*35) + 35 + (0.55*BonusAP)
local CheckRDmg = (GetCastLevel(myHero, _R)*100) + 50 + (0.50*BonusAP)
local killable=0

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
    ["Ryze"]                        = {_R},
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
 
function addInterrupterCallback( callback0 )
        callback = callback0
end

addInterrupterCallback(function(target, spellType)
  if GoS:IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and Brand.Interrupt.ItrE:Value() and spellType == CHANELLING_SPELLS then
  CastTargetSpell(myHero, _E)
  local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,850,GetCastRange(myHero,_W),250,false,true)
  elseif GoS:IsInDistance(target, GetCastRange(myHero,_W)) and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) ~= READY and WPred.HitChance == 1 and Brand.Interrupt.ItrW:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
  end
if GotBuff(target, "brandablaze")~=0 then
local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_Q),60,true,false)
if GoS:IsInDistance(target, GetCastRange(myHero,_Q)) and CanUseSpell(myHero,_Q) == READY and QPred.HitChance == 1 and Brand.Interrupt.ItrQ:Value() and spellType == CHANELLING_SPELLS then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
end)

OnLoop(function(myHero)
	------ Start Combo ------
    if IOW:Mode() == "Combo" and killable==0 then
		local target = GetCurrentTarget()
		
	local LudensEcho = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	LudensEcho = LudensEcho + 0.1*BonusAP + 100
	end		
			
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,850,GetCastRange(myHero,_W),250,false,true)			
		if CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and WPred.HitChance == 1 and Brand.cb.WCB:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
			
		if CanUseSpell(myHero,_E) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and Brand.cb.ECB:Value() then
		CastTargetSpell(_E)
		end
		
	   local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_Q),60,true,false)
	    if GotBuff(target, "brandablaze") ~= 0 and CanUseSpell(myHero,_Q) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Brand.cb.QCB:Value() then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end

		if GoS:ValidTarget(target, GetCastRange(myHero,_R)) and Brand.cb.RCB:Value() and GetCurrentHP(target)+GetMagicShield(target)+GetDmgShield(target)+GetHPRegen(target) < GoS:CalcDamage(myHero, target, 0, CheckRDmg + LudensEcho) then
	    if CanUseSpell(myHero,_R) == READY and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY then
		CastTargetSpell(_R)
		end
		end
	end
	
	------ Start Harass ------
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Brand.hr.HrMana:Value() then
		local target = GetCurrentTarget()			
			
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,850,GetCastRange(myHero,_W),250,false,true)			
		if CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and WPred.HitChance == 1 and Brand.hr.HrW:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
			
		if CanUseSpell(myHero,_E) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and Brand.hr.HrE:Value() then
		CastTargetSpell(_E)
		end
		
	   local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_Q),60,true,false)
	    if GotBuff(target, "brandablaze") ~= 0 and CanUseSpell(myHero,_Q) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Brand.hr.HrQ:Value() then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
	end
	
	------ Start LaneClear ------
   if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Brand.FreezeLane.LCMana:Value() then
	for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
                        -- if GoS:IsInDistance(minion, 1500) then
		local minionPoS = GetOrigin(minion)
		
		if CanUseSpell(myHero,_W) == READY and Brand.FreezeLane.WLC:Value() and GoS:ValidTarget(minion, GetCastRange(myHero,_W)) then
		CastSkillShot(_W,minionPoS.x, minionPoS.y, minionPoS.z)	
		end
		
		if GotBuff(minion, "brandablaze") ~=0 and CanUseSpell(myHero,_E) == READY and GoS:ValidTarget(minion, GetCastRange(myHero,_E)) and Brand.FreezeLane.ELC:Value() then
		CastSkillShot(_E,minionPoS.x, minionPoS.y, minionPoS.z)	
	    end
    end
   end 

	------ Start JungleClear ------  
   if IOW:Mode() == "LaneClear"then
    for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do	
		local mobPoS = GetOrigin(mob)
		
		if CanUseSpell(myHero,_W) == READY and Brand.JungleClear.WJC:Value() and GoS:ValidTarget(mob, GetCastRange(myHero,_W)) then
		CastSkillShot(_W,mobPoS.x, mobPoS.y, mobPoS.z)	
		end
		
		if CanUseSpell(myHero,_E) == READY and Brand.JungleClear.EJC:Value() and GoS:ValidTarget(mob, GetCastRange(myHero,_E)) then
		CastSkillShot(_W,mobPoS.x, mobPoS.y, mobPoS.z)	
		end
		
		if GotBuff(mob, "brandablaze") ~=0 and CanUseSpell(myHero,_Q) == READY and Brand.JungleClear.QJC:Value() and GoS:ValidTarget(mob, GetCastRange(myHero,_Q)) then
		CastSkillShot(_Q,mobPoS.x, mobPoS.y, mobPoS.z)	
		end
	end
   end
   
  if Brand.KS.KSEb:Value() then
	KillSteal()
	end
	
  if Brand.AtSpell.ASEb:Value() then
	AutoSpell()
	end
	
  if Brand.Draws.DrawsEb:Value() then
	Drawings()
	end

if Brand.AutoLvlSpell.UpSpellEb:Value() then
	AutoUpSpell()
	end
	
  if Brand.Items.PotionHP.PotHP:Value() then --- Menu Auto PotionHP
	AutoPotHP()
	end
	
  if Brand.Items.PotionMP.PotMP:Value() then --- Menu Auto PotionMP
	AutoPotMP()
	end
end)

------------------------------------------------------- Start Function -------------------------------------------------------

	------ Start Auto Spell ------
function AutoSpell()
	if Brand.AtSpell.ASEb:Value() then
 if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > Brand.AtSpell.ASMana:Value() then
                for i,enemy in pairs(GoS:GetEnemyHeroes()) do				  
	local target = GetCurrentTarget()
	local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2000,250,GetCastRange(myHero,_Q),60,true,false)
	if GotBuff(target, "brandablaze") ~= 0 and CanUseSpell(myHero,_Q) == READY and GoS:ValidTarget(target, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Brand.AtSpell.ASQ:Value() then
	CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	end
                end
 end
	end
end

 	------ Start Auto Level Up _Settings Full Q or Full W first ------
function AutoUpSpell()
 if Brand.AutoLvlSpell.UpSpellEb:Value() then
  if Brand.AutoLvlSpell.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First
  elseif Sona.Miscset.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W , _R, _W , _W, _Q , _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- Full W First
  end
   LevelSpell(leveltable[GetLevel(myHero)])
 end
end

 	------ Start Use Items _Use Health Potion_ ------
function AutoPotHP()
global_ticks = 0
currentTicks = GetTickCount()
 if Brand.Items.PotionHP.PotHP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < Brand.Items.PotionHP.CheckHP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2003))
						end
					end
				end
			end
			
  end	
  
 	------ Start Use Items _Use Mana Potion_ ------
function AutoPotMP()
global_ticks = 0
currentTicks = GetTickCount()
 if Brand.Items.PotionMP.PotMP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 < Brand.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
  end
   
	------ Start Drawings ------
function Drawings()
  if Brand.Draws.DrawsEb:Value() then
if Brand.Draws.DrawQ:Value() and CanUseSpell(myHero,_Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),1,Brand.Draws.QualiDraw:Value(),0xffEE0000) end
if Brand.Draws.DrawW:Value() and CanUseSpell(myHero,_W) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),1,Brand.Draws.QualiDraw:Value(),0xffCCFF66) end
if Brand.Draws.DrawE:Value() and CanUseSpell(myHero,_E) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),1,Brand.Draws.QualiDraw:Value(),0xffCC3399) end
if Brand.Draws.DrawR:Value() and CanUseSpell(myHero,_R) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),1,Brand.Draws.QualiDraw:Value(),0xffFFFF33) end
if Brand.Draws.DrawText:Value() then
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
		    if CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + LudensEcho) then
			DrawText("E = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + LudensEcho) then
			DrawText("W = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
			DrawText("Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckWDmg + LudensEcho) then
			DrawText("E + W = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckQDmg + LudensEcho) then
			DrawText("E + Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + LudensEcho) then
			DrawText("W + Q = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + CheckEDmg + LudensEcho) then
			DrawText("Q + W + E = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckRDmg + LudensEcho) then
			DrawText("R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckRDmg + LudensEcho) then
			DrawText("E + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckRDmg + LudensEcho) then
			DrawText("W + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + LudensEcho) then
			DrawText("Q + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckWDmg + CheckRDmg + LudensEcho) then
			DrawText("E + W + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckQDmg + CheckRDmg + LudensEcho) then
			DrawText("E + Q + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + CheckRDmg + LudensEcho) then
			DrawText("W + Q + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + CheckEDmg + CheckRDmg + LudensEcho) then
			DrawText("Q + W + E + R = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + LudensEcho) then
			DrawText("E + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + LudensEcho) then
			DrawText("W + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
			DrawText("Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckWDmg + LudensEcho) then
			DrawText("E + W + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckQDmg + LudensEcho) then
			DrawText("E + Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + LudensEcho) then
			DrawText("W + Q + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + CheckEDmg + LudensEcho) then
			DrawText("Q + W + E + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckRDmg + LudensEcho) then
			DrawText("R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + CheckRDmg + LudensEcho) then
			DrawText("E + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckRDmg + LudensEcho) then
			DrawText("W + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + LudensEcho) then
			DrawText("Q + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckRDmg + CheckEDmg + LudensEcho) then
			DrawText("E + W + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + CheckEDmg + LudensEcho) then
			DrawText("E + Q + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + CheckWDmg + LudensEcho) then
			DrawText("W + Q + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			elseif EnbIgnite > 0 and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < EnbIgnite + GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + CheckQDmg + CheckEDmg + CheckRDmg + LudensEcho) then
			DrawText("Q + W + E + R + Ignite = Killable!",19,EnmTextPos.x,EnmTextPos.y,0xffFF6600)
			else
			DrawText("Can't Kill this Target!",19,EnmTextPos.x,EnmTextPos.y,0xff00FF66)
			end
		    local maxhp = GetMaxHP(enemy)
		    local currhp = GetCurrentHP(enemy)
			local percent = 100*currhp/maxhp
		    DrawText(string.format("%s HP: %d / %d | Percent HP = %d", GetObjectName(enemy), currhp, maxhp, percent),16,EnmTextPos.x,EnmTextPos.y+23,0xffffffff)
			local CheckQWERDmg = CheckQDmg + CheckWDmg + CheckEDmg + CheckRDmg + LudensEcho
			local CheckQWEDmg = CheckQDmg + CheckWDmg + CheckEDmg + LudensEcho
			local CheckWRDmg = CheckWDmg + CheckRDmg + LudensEcho
			local CheckQRDmg = CheckQDmg + CheckRDmg + LudensEcho
			local CheckERDmg = CheckEDmg + CheckRDmg + LudensEcho
			local CheckQWDmg = CheckQDmg + CheckWDmg + LudensEcho
			local CheckWEDmg = CheckWDmg + CheckEDmg + LudensEcho
			local CheckQEDmg = CheckQDmg + CheckEDmg + LudensEcho
		    if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQWERDmg,0xffffffff)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _E) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQWEDmg,0xffffffff)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckWRDmg,0xffffffff)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQRDmg,0xffffffff)
			elseif CanUseSpell(myHero, _E) == READY and CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckERDmg,0xffffffff)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQWDmg,0xffffffff)
			elseif CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _E) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckWEDmg,0xffffffff)
			elseif CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQEDmg,0xffffffff)
			elseif CanUseSpell(myHero, _R) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckRDmg + LudensEcho,0xffffffff)
			elseif CanUseSpell(myHero, _W) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckWDmg + LudensEcho,0xffffffff)
			elseif CanUseSpell(myHero, _Q) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckQDmg + LudensEcho,0xffffffff)
			elseif CanUseSpell(myHero, _E) == READY then
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),CheckEDmg + LudensEcho,0xffffffff)
			else
			DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),LudensEcho,0xffffffff)
			end
		end
		 end
	end
  end
end

	------ Start Kill Steal ------
function KillSteal()
 	if Brand.KS.KSEb:Value() then
 for i,enemy in pairs(GoS:GetEnemyHeroes()) do
 
    	local LudensEcho = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	LudensEcho = LudensEcho + 0.1*BonusAP + 100
	end
 
        -- Kill Steal --
	   local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),2000,250,GetCastRange(myHero,_Q),60,true,false)
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,850,GetCastRange(myHero,_W),250,false,true)	
	   
            if Ignite and Brand.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
                  CastTargetSpell(enemy, Ignite)
                  end
            end
		
	if CanUseSpell(myHero,_E) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_E)) and Brand.KS.EKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckEDmg + LudensEcho) then
	CastTargetSpell(_E)
	killable=1
	
	elseif CanUseSpell(myHero,_W) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_W)) and WPred.HitChance == 1 and Brand.KS.WKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckWDmg + LudensEcho) then
	CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
	killable=1
	
	elseif CanUseSpell(myHero,_Q) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 and Brand.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy) < GoS:CalcDamage(myHero, enemy, 0, CheckQDmg + LudensEcho) then
	CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	killable=1
	
	elseif CanUseSpell(myHero,_R) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_R)) and Brand.KS.RKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+(GetHPRegen(enemy)/5) < GoS:CalcDamage(myHero, enemy, 0, ((CheckRDmg + LudensEcho)*2)) and ((CountEnemyHeroInRange(enemy,400)>=2 and CountEnemyHeroInRange(enemy,400)<=4) or (CountEnemyMinionInRange(enemy,400)>=1)) and GetCurrentMana(myHero)>=100 then
	CastTargetSpell(_R)
	killable=1
	
	elseif CanUseSpell(myHero,_R) == READY and GoS:ValidTarget(enemy, GetCastRange(myHero,_R)) and Brand.KS.RKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)+(GetHPRegen(enemy)/5) < GoS:CalcDamage(myHero, enemy, 0, ((CheckRDmg + LudensEcho)*3)) and ((CountEnemyHeroInRange(enemy,400)==2) or (CountEnemyMinionInRange(enemy,400)<=3 and (CountEnemyMinionInRange(enemy,400)>=1) and GotBuff(enemy,"brandablaze")~=0 )) and GetCurrentMana(myHero)>=100 then
	CastTargetSpell(_R)
	killable=1
	
	else
	killable=0
	end
 end
 	end
end
-------------------------------------------------------------------------------------------------------------------------
function CountEnemyHeroInRange(object,range)
  object = object or myHero
  local enemyInRange = 0
  for i, enemy in pairs(GoS:GetEnemyHeroes()) do
    if (enemy~=nil and GetTeam(myHero)~=GetTeam(enemy) and IsDead(enemy)==false) and GoS:GetDistance(object, enemy)<= range then
    	enemyInRange = enemyInRange + 1
    end
  end
  return enemyInRange
end
-------------------------------------------------------------------------------------------------------------------------
function CountEnemyMinionInRange(object,range)
	local minion = nil
	local minionInRange=0
	for k,v in pairs(GoS:GetAllMinions()) do
		local objTeam = GetTeam(v)
		if not minion and v and objTeam == GetTeam(object) then 
			minion = v 
		end
		if minion and v and objTeam == GetTeam(object) and GoS:GetDistanceSqr(GetOrigin(minion),GetOrigin(object)) > GoS:GetDistanceSqr(GetOrigin(v),GetOrigin(object)) then
			minion = v
		end
		if minion and v and objTeam == GetTeam(object) and GoS:GetDistance(GetOrigin(minion),GetOrigin(object))<=range then
			minionInRange=minionInRange+1
		end
	end
  return minionInRange
end
