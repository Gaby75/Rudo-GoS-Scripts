-- Rx Xerath Version 0.1 by Rudo.
-- Updated for Inspired Ver19 and IOW
--------------------------------------------

---- Create a Menu ----
Xerath = Menu("Rx Xerath", "Xerath")

---- Combo ----
Xerath:SubMenu("cb", "Xerath Combo")
Xerath.cb:Boolean("QCB", "Use Q", true)
Xerath.cb:Boolean("WCB", "Use W", true)
Xerath.cb:Boolean("ECB", "Use E", true)

---- Harass Menu ----
Xerath:SubMenu("hr", "Harass")
Xerath.hr:Boolean("HrQ", "Use Q", true)
Xerath.hr:Boolean("HrW", "Use W", true)
Xerath.hr:Boolean("HrE", "Use E", true)
Xerath.hr:Slider("HrMana", "Enable Harass if My %MP >", 30, 0, 100, 0)

---- Kill Steal Menu ----
Xerath:SubMenu("KS", "Kill Steal")
Xerath.KS:Boolean("KSEb", "Enable KillSteal", true)
Xerath.KS:Boolean("QKS", "KS with Q", true)
Xerath.KS:Boolean("WKS", "KS with W", true)
Xerath.KS:Boolean("EKS", "KS with E", true)
Xerath.KS:Boolean("IgniteKS", "KS with Ignite", true)

---- Lane Clear Menu ----
Xerath:SubMenu("FreezeLane", "Lane Clear")
Xerath.FreezeLane:Boolean("QLC", "Use Q LaneClear", true)
Xerath.FreezeLane:Boolean("WLC", "Use W LaneClear", true)
Xerath.FreezeLane:Slider("LCMana", "Enable LaneClear if My %MP >", 30, 0, 100, 0)

---- Jungle Clear Menu ----
Xerath:SubMenu("JungleClear", "Jungle Clear")
Xerath.JungleClear:Boolean("QJC", "Use Q LaneClear", true)
Xerath.JungleClear:Boolean("WJC", "Use W LaneClear", true)
Xerath.JungleClear:Boolean("EJC", "Use E LaneClear", true)

---- Drawings Clear Menu ----
Xerath:SubMenu("Draws", "Drawings")
Xerath.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Xerath.Draws:Boolean("DrawQ", "Range Q", true)
Xerath.Draws:Boolean("DrawW", "Range W", true)
Xerath.Draws:Boolean("DrawE", "Range E", true)
Xerath.Draws:Boolean("DrawR", "Range R", true)
Xerath.Draws:Boolean("DrawTest", "Draw Test", true)

---- Xerath R Ultimate Menu ----
Xerath:SubMenu("Ultimate", "Settings R")
Xerath.Ultimate:Boolean("UltiEb", "Enable Ultimate", true)
Xerath.Ultimate:List("SetLUR", "Setting Cast R", 1, {"AutoUse R if can kill", "Press T to cast R"})
Xerath.Ultimate:SubMenu("StartAtUR", "Auto Use R")
Xerath.Ultimate.StartAtUR:Boolean("AutoR", "Auto R if Killable", true)
Xerath.Ultimate:SubMenu("StartURK", "Press Key to use R")
Xerath.Ultimate.StartURK:Key("KeyUR", "Cast R if Press T", string.byte("T"))

---- Misc Menu ----
Xerath:SubMenu("Miscset", "Misc")
Xerath.Miscset:SubMenu("AntiSkill", "Stop Skill Enemy")
Xerath.Miscset.AntiSkill:Boolean("EAnti", "Stop Skil Enemy with E",true)
Xerath.Miscset:SubMenu("AutoLvlUp", "Auto Level Up")
Xerath.Miscset.AutoLvlUp:Boolean("AutoSkillUp", "Auto Lvl Up", true)   ------ Full Q Frist then W last is E

---- Use Items Menu ----
Xerath:SubMenu("Items", "Auto Use Items")
Xerath.Items:SubMenu("PotionHP", "Use Potion HP")
Xerath.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
Xerath.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 5, 80, 1)
Xerath.Items:SubMenu("PotionMP", "Use Potion MP")
Xerath.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
Xerath.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 5, 80, 1)

---------- End Menu ----------


local info = "Rx Xerath Loaded."
local upv = "Upvote if you like it!"
local sig = "Made by Rudo"
local ver = "Version: 0.1"
textTable = {info,upv,sig,ver}
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])
PrintChat(textTable[4])

PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Loaded Success </font><font color='#08F7F3'>Enjoy and have a Good Game :3</font>")) 

----- End Print -----

-------------------------------------------------------require('DLib')-------------------------------------------------------

-------------------------------------------------------Starting--------------------------------------------------------------
require('IOW')


CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
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
    ["Xerath"]                      = {_Q, _R},
    ["Ezreal"]                      = {_R},
	["Kennen"]                      = {_R},
    ["Rengar"]                      = {_R},
    ["Twisted Fate"]                = {_R},
	["Tahm Kench"]                  = {_R},
    ["Ezreal"]                      = {_R},
    ["MasterYi"]                    = {_W},
    ["FiddleSticks"]                = {_W, _R},
    ["Janna"]                       = {_R},
    ["Varus"]                       = {_Q, _R},
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
  local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,200,1125,60,true,false)
  if GoS:IsInDistance(target, 1125) and CanUseSpell(myHero,_R) == READY and Xerath.Miscset.AntiSkill.EAnti:Value() and spellType == CHANELLING_SPELLS then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
  end
end)

OnLoop(function(myHero)
		local target = IOW:GetTarget()
	------ Start Combo ------
    if IOW:Mode() == "Combo" then
			
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,750,1100,200,false,true)			
		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 1100) and WPred.HitChance == 1 and Xerath.cb.WCB:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
			
       local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,200,1125,60,true,false)			
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1050) and EPred.HitChance == 1 and Xerath.cb.ECB:Value() then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		
    if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1500) and Xerath.cb.QCB:Value() then
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 750 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,500,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
	end
	end
	
	------ Start Harass ------	
    if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Xerath.hr.HrMana:Value() then
		local target = IOW:GetTarget()
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,750,1100,200,false,true)	
       local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,200,1125,60,true,false)

		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 1100) and WPred.HitChance == 1 and Xerath.hr.HrW:Value() then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	   
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1050) and EPred.HitChance == 1 and Xerath.cb.HrE:Value() then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		
        if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1500) and Xerath.cb.QCB:Value() then
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 750 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,500,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
	    end
	end
	
	------ Start Lane Clear ------	
    if IOW:Mode() == "LaneClear" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= Xerath.FreezeLane.LCMana:Value() then
                for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do    
                        --if GoS:IsInDistance(minion, 1500) then
		local minionPoS = GetOrigin(minion)
		
		if CanUseSpell(myHero, _Q) == READY and Xerath.FreezeLane.QLC:Value() and GoS:ValidTarget(minion, 1500) then
		CastSkillShot(_Q,minionPoS.x, minionPoS.y, minionPoS.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and Xerath.FreezeLane.WLC:Value() and GoS:ValidTarget(minion, 1100) then
		CastSkillShot(_W,minionPoS.x, minionPoS.y, minionPoS.z)
		end
        end
    end
	
	------ Start Jungle Clear ------
    if IOW:Mode() == "LaneClear" then
	for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	local mobPos = GetOrigin(mob)
	
		if CanUseSpell(myHero, _Q) == READY and Xerath.JungleClear.QJC:Value() and GoS:ValidTarget(mob, 1500) then
		CastSkillShot(_Q,mobPos.x, mobPos.y, mobPos.z)
		end
		
		if CanUseSpell(myHero, _W) == READY and Xerath.JungleClear.WJC:Value() and GoS:ValidTarget(mob, 1100) then
		CastSkillShot(_W,mobPos.x, mobPos.y, mobPos.z)
		end
		
        if CanUseSpell(myHero, _E) == READY and Xerath.JungleClear.EJC:Value() and GoS:ValidTarget(mob, 1125) then
		CastSkillShot(_E,mobPos.x, mobPos.y, mobPos.z)
		end
        end
    end	
  
  if Xerath.KS.KSEb:Value() then
	KillSteal()
	end
  
  if Xerath.Draws.DrawsEb:Value() then
	Drawings()
	end
  
  if Xerath.Miscset.AutoLvlUp.AutoSkillUp:Value() then
	AutoLvlUpQ()
	end
  
  if Xerath.Items.PotionHP.PotHP:Value() then
	AutoPotHP()
	end
  
  if Xerath.Items.PotionMP.PotMP:Value() then
	AutoPotMP()
	end
	
  if Xerath.Ultimate.UltiEb:Value() and Xerath.Ultimate.SetLUR:Value() == 1 then
    AutoUR()
  elseif Xerath.Ultimate.UltiEb:Value() and Xerath.Ultimate.SetLUR:Value() == 2 then
  	PressKR()
	end
end)
 

------------------------------------------------------- Start Function -------------------------------------------------------

	------ Start Kill Steal ------
function KillSteal()
 	if Xerath.KS.KSEb:Value() then
 for i,enemy in pairs(GoS:GetEnemyHeroes()) do
 
        -- Kill Steal --
       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,750,1100,200,false,true)	
       local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,200,1125,60,true,false)
	   
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
	        end

		if Ignite and Xerath.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GoS:GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
			
		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 1100) and WPred.HitChance == 1 and Xerath.KS.WKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	   
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 1050) and EPred.HitChance == 1 and  Xerath.KS.EKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + ExtraDmg) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		
        if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 1500) and Xerath.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + ExtraDmg) then
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1500, 250 do
        DelayAction(function()
            local _Qrange = 750 + math.min(700, i/2)
              local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,500,_Qrange,70,false,true)
              if QPred.HitChance == 1 and Xerath.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + ExtraDmg) then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
          end, i)
      end
	    end
	end
 end
end
 
	------ Start Drawings ------
function Drawings()
    if Xerath.Draws.DrawsEb:Value() then
 local HeroPos = GetOrigin(myHero)
 local rRange = 2000 + GetCastLevel(myHero, _R) * 1200
if Xerath.Draws.DrawQ:Value() and CanUseSpell(myHero, _Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,750,3,100,0xff66CCFF) end
if Xerath.Draws.DrawQ:Value() and CanUseSpell(myHero, _Q) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1450,3,100,0xff3399FF) end
if Xerath.Draws.DrawW:Value() and CanUseSpell(myHero, _W) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1100,3,100,0xff00CC99) end
if Xerath.Draws.DrawE:Value() and CanUseSpell(myHero, _E) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,1050,3,100,0xff9999FF) end
if Xerath.Draws.DrawR:Value() and CanUseSpell(myHero, _R) == READY then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,rRange,3,100,0xffFFFF00) end
 if Xerath.Draws.DrawTest:Value() then
	for _, enemy in pairs(GoS:GetEnemyHeroes()) do
		if GoS:ValidTarget(enemy) then
		    local enemyPos = GetOrigin(enemy)
			local drawpos = WorldToScreen(1,enemyPos.x, enemyPos.y, enemyPos.z)
			local enemyText, color = GetDrawText(enemy)
			DrawText(enemyText, 20, drawpos.x, drawpos.y, color)
		end
	end
 end
  end
 end

function GetDrawText(enemy)
	local ExtraDmg = 0
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
	end
	
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end
	
	if CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg2) then
		return 'W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 3*(135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero)) + ExtraDmg2) then
		return '3xR = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + E = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg2) then
		return 'W + E = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + 3*(135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero)) + ExtraDmg2) then
		return 'Q + W + E + 3xR = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W + E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + 3*(135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero)) + ExtraDmg2) then
		return 'Q + W + E + 3xR + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg2) then
		return 'W + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + W + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 40 + 40*GetCastLevel(myHero,_Q) + 0.75*GetBonusAP(myHero) + 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + E + Ignite = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_W) == READY and CanUseSpell(myHero,_E) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 50 + 30*GetCastLevel(myHero,_E) + 0.45*GetBonusAP(myHero) + 30 + 30*GetCastLevel(myHero,_W) + 0.60*GetBonusAP(myHero) + ExtraDmg2) then
		return 'W + E + Ignite = Kill!', ARGB(255, 200, 160, 0)		
	else
		return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end

	------ Start Auto Level Up _ Full Q First ------
function AutoLvlUpQ()
 if Xerath.Miscset.AutoLvlUp.AutoSkillUp:Value() then
if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end
  end
end

 	------ Start Use Items _Use Health Potion_ ------
function AutoPotHP()
global_ticks = 0
currentTicks = GetTickCount()
 if Xerath.Items.PotionHP.PotHP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < Xerath.Items.PotionHP.CheckHP:Value() then  
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
 if Xerath.Items.PotionMP.PotMP:Value() then
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 < Xerath.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
  end		

 	------ Start Settings Ultimate ------
	
	   -- Auto Ultimate if Killable --
function AutoUR()
 if Xerath.Ultimate.UltiEb:Value() and Xerath.Ultimate.SetLUR:Value() == 1 then
 	waitTickCount = 0
  if waitTickCount < GetTickCount() then
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end

	local target = GoS:GetTarget(2000 + GetCastLevel(myHero, _R) * 1200, DAMAGE_MAGIC)
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,2000 + GetCastLevel(myHero, _R) * 1200,375,false,true)
    if CanUseSpell(myHero, _R) == READY and Xerath.Ultimate.StartAtUR.AutoR:Value() and RPred.HitChance == 1 and GoS:ValidTarget(target, 2000 + GetCastLevel(myHero, _R) * 1200) and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < GoS:CalcDamage(myHero, enemy, 0, 3*(135 + 55*GetCastLevel(myHero,_R) + 0.433*GetBonusAP(myHero)) + ExtraDmg2) then
	waitTickCount = GetTickCount() + 1400
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	end
  end
 end
end
  
 	   -- Press Keys Ultimate --
function PressKR()
 if Xerath.Ultimate.UltiEb:Value() and Xerath.Ultimate.SetLUR:Value() == 2 then
  if waitTickCount < GetTickCount() then
 	local target = GoS:GetTarget(2000 + GetCastLevel(myHero, _R) * 1200, DAMAGE_MAGIC)
	local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,700,2000 + GetCastLevel(myHero, _R) * 1200,375,false,true)
    if CanUseSpell(myHero, _R) == READY and Xerath.Ultimate.StartURK.KeyUR:Value() and RPred.HitChance == 1 and GoS:ValidTarget(target, 2000 + GetCastLevel(myHero, _R) * 1200) then
	waitTickCount = GetTickCount() + 1400
	CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	DelayAction(function() CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)end, 700)
	end
  end
 end
end
