--[[ Rx Sona Without deLibrary Version 1.5 by Rudo.
 Updated Sona for News Inspired
 Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------

 ..######...#######..###.....##....###
 .##....##.##.....##.####....##...##.##
 .##.......##.....##.##.##...##..##...##
 ..######..##.....##.##..##..##.##.....##
 .......##.##.....##.##...##.##.#########
 .##....##.##.....##.##....####.##.....##
 ..######...#######..##.....###.##.....##

                                                
---------------------------------------------------]]

require('Inspired')
---- Create a Menu ----
if GetObjectName(myHero) ~= "Sona" then return end
local Sona = MenuConfig("Rx Sona", "Sona")
tslowhp = TargetSelector(GetCastRange(myHero, _R), 8, DAMAGE_MAGIC)
Sona:TargetSelector("ts", "Selector Target for R", tslowhp)

---- Combo ----
Sona:Menu("cb", "Sona Combo")
Sona.cb:Boolean("QCB", "Use Q", true)
Sona.cb:Boolean("WCB", "Use W", true)
Sona.cb:Boolean("ECB", "Use E", true)
Sona.cb:Boolean("RCB", "R Combo", false)
Sona.cb:Info("infoR", "R Combo will Cast R to Enemy lowestHP (R TargetSelector)")
PermaShow(Sona.cb.RCB)

---- Harass Menu ----
Sona:Menu("hr", "Harass")
Sona.hr:Boolean("HrQ", "Use Q", true)
Sona.hr:Slider("HrMana", "Harass if %My MP >=", 20, 1, 100, 1)

---- Auto Spell Menu ----
Sona:Menu("AtSpell", "Auto Spell")
Sona.AtSpell:Boolean("ASEb", "Enable Auto Spell", true)
Sona.AtSpell:Boolean("ASQ", "Auto Q", true)
Sona.AtSpell:Boolean("ASW", "Auto W", true)
Sona.AtSpell:Slider("myHrHP", "Auto W if %My HP  =<", 55, 1, 100, 1)
Sona.AtSpell:Info("info1", "If no Enemy Heroes in 1250 range then Auto E if %HP Allies <= 50%")
Sona.AtSpell:Info("info2", "If Enemy Heroes in 1250 range then Auto E if %HP Allies <= 70%")
Sona.AtSpell:Slider("ASMana", "Auto Spell if My %MP >=", 10, 0, 80, 1)
PermaShow(Sona.AtSpell.ASQ)
PermaShow(Sona.AtSpell.ASW)

---- Drawings Menu ----
Sona:Menu("Draws", "Drawings")
Sona.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Sona.Draws:Slider("QualiDraw", "Quality Drawings", 110, 1, 255, 1)
Sona.Draws:Boolean("DrawQ", "Range Q", true)
Sona.Draws:ColorPick("Qcol", "Setting Q Color", {255, 30, 144, 255})
Sona.Draws:Boolean("DrawW", "Range W", true)
Sona.Draws:ColorPick("Wcol", "Setting W Color", {255, 124, 252, 0})
Sona.Draws:Boolean("DrawE", "Range E", true)
Sona.Draws:ColorPick("Ecol", "Setting E Color", {255, 155, 48, 255})
Sona.Draws:Boolean("DrawR", "Range R", true)
Sona.Draws:ColorPick("Rcol", "Setting R Color", {255, 248, 245, 120})
Sona.Draws:Boolean("DrawText", "Draw Text", true)
Sona.Draws:Boolean("DrawCircleAlly", "Draw Circle Around Ally", true)
Sona.Draws:ColorPick("Alcol", "Circle Around Ally Color", {255, 173, 255, 47})
Sona.Draws:Info("info", "Draw Circle if %HP Allies <= 40%")
PermaShow(Sona.Draws.DrawText)
PermaShow(Sona.Draws.DrawCircleAlly)

---- Kill Steal Menu ----
Sona:Menu("KS", "Kill Steal")
Sona.KS:Boolean("KSEb", "Enable KillSteal", true)
Sona.KS:Boolean("QKS", "KS with Q", true)
Sona.KS:Boolean("RKS", "KS with R", false)
Sona.KS:Slider("RAround", "R KS if can Hit Enemy >=", 2, 1, 5, 1)
Sona.KS:Boolean("IgniteKS", "KS with Ignite", true)
PermaShow(Sona.KS.RKS)
PermaShow(Sona.KS.IgniteKS)

---- Auto Level Up Menu ----
Sona:Menu("AutoLvlUp", "Auto Level Up")
Sona.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Sona.AutoLvlUp:DropDown("AutoSkillUp", "Settings", 1, {"Q-W-E", "W-Q-E"}) 

Sona:Info("info3", "Use PActivator for Auto Items")
   
---------- End Menu ----------

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))

----- End Print -----

-------------------------------------------------------require('DLib')-------------------------------------------------------

-------------------------------------------------------Starting--------------------------------------------------------------


require('DeftLib')
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
	--["Tahm Kench"]                  = {_R},
    --["VelKoz"]                      = {_R},
    --["Xerath"]                      = {_R},
}

DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(ANTI_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
		local InterruptMenu = MenuConfig("Stop Spell Enemy with R", "Interrupt")
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_R) then
      if ANTI_SPELLS[spell.name] then
        if ValidTarget(unit, 980) and GetObjectName(unit) == ANTI_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
        local RPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),2400,300,1000,150,false,true)
		 if RPred.HitChance == 1 then
		 CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
         end
		end
      end
    end
end)


local BonusAP = GetBonusAP(myHero)
local CheckQDmg = 40*GetCastLevel(myHero, _Q) + 0.50*BonusAP
local CheckRDmg = 50 + 100*GetCastLevel(myHero, _R) + 50 + 0.50*BonusAP

OnTick(function(myHero)
		        local target = GetCurrentTarget()
	------ Start Combo ------
    if IOW:Mode() == "Combo" then
	
		if IsReady(_Q) and ValidTarget(target, 845) and Sona.cb.QCB:Value() then
		CastSpell(_Q)
        end
					
		if IsReady(_W) and ValidTarget(target, 840) and Sona.cb.WCB:Value() then
		CastSpell(_W)
		end
				
		if IsReady(_E) and ValidTarget(target, 1000) and Sona.cb.ECB:Value() then
		CastSpell(_E)
		end
		
		local tglowhp = tslowhp:GetTarget()
        if tglowhp and IsReady(_R) and ValidTarget(tglowhp, 950) and Sona.cb.RCB:Value() then
		local RPred = GetPredictionForPlayer(myHeroPos(),tglowhp,GetMoveSpeed(tglowhp),2400,300,1000,150,false,true)
		if RPred.HitChance == 1 then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
		end
	end
		
					
	if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Sona.hr.HrMana:Value() then
	------ Start Harass ------
        if IsReady(_Q) and ValidTarget(target, 845) and Sona.hr.HrQ:Value() then
		CastSpell(_Q)
        end	
	end
	
if Sona.AtSpell.ASEb:Value() and GetPercentMP(myHero) >= Sona.AtSpell.ASMana:Value() then
		------ Start Auto Spell ------
             for i,enemy in pairs(GetEnemyHeroes()) do				  
    if IsReady(_Q) and ValidTarget(enemy, 842) and Sona.AtSpell.ASQ:Value() then
	  CastSpell(_Q)
    end

    if IsReady(_W) and GetPercentHP(myHero) <= Sona.AtSpell.myHrHP:Value() and Sona.AtSpell.ASW:Value() then
    CastSpell(_W)
    end
            for _, ally in pairs(GetAllyHeroes()) do
		if IsInDistance(enemy, 1250) then	   
    if IsReady(_W) and ValidTarget(ally, 1000) and GetPercentHP(ally) <= 70 and Sona.AtSpell.ASW:Value() then
    CastSpell(_W)
    end

       elseif GetDistance(myHero, enemy) > 1250 then
    if IsReady(_W) and ValidTarget(ally, 1000) and GetPercentHP(ally) <= 50 and Sona.AtSpell.ASW:Value() then
    CastSpell(_W)
    end
       end
            end 
             end
end
	
if Sona.KS.KSEb:Value() then
	 	------ Start Kill Steal ------
 for i,enemy in pairs(GetEnemyHeroes()) do

        -- Kill Steal --

		if Ignite and Sona.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end

	if IsReady(_Q) and ValidTarget(enemy, 845) and Sona.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckQDmg + Ludens()) then
		CastSpell(_Q) 
    elseif IsReady(_R) and ValidTarget(enemy, 950) and Sona.KS.RKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckRDmg + Ludens()) then 
	  if EnemiesAround(GetOrigin(enemy), 150) >= Sona.KS.RAround:Value() then
		if IsObjectAlive(enemy) and IsInDistance(enemy, GetCastRange(myHero,_R)) then
		  local RPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),2400,200,1000,150,false,true)
		 if RPred.HitChance == 1 then
		CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
		 end
		end
	  end
	end
 end 
end
	
if Sona.AutoLvlUp.UpSpellEb:Value() then
	 	------ Start Auto Level Up _Settings Full Q or Full W first ------
  if Sona.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First
  elseif Sona.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W , _R, _W , _W, _Q , _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- Full W First
  end
   LevelSpell(leveltable[GetLevel(myHero)])
end
end)
 

------------------------------------------------------
	
OnDraw(function(myHero)
	------ Start Drawings ------
  if Sona.Draws.DrawsEb:Value() then
if Sona.Draws.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Qcol:Value()) end
if Sona.Draws.DrawW:Value() and IsReady(_W) then DrawCircle(myHeroPos(),GetCastRange(myHero,_W),1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Wcol:Value()) end
if Sona.Draws.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),2,Sona.Draws.QualiDraw:Value(),Sona.Draws.Ecol:Value()) end
if Sona.Draws.DrawR:Value() and IsReady(_R) then DrawCircle(myHeroPos(),GetCastRange(myHero,_R),1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Rcol:Value()) end
 if Sona.Draws.DrawCircleAlly:Value() then
 	for _, myally in pairs(GetAllyHeroes()) do
		 if GetObjectName(myHero) ~= GetObjectName(myally) then	
	    if IsObjectAlive(myally) then
		    local maxhpA = GetMaxHP(myally)
		    local currhpA = GetCurrentHP(myally)
			local percentA = 100*currhpA/maxhpA
		  if percentA <= 40 then
		    DrawCircle(GetOrigin(myally),1000,1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Alcol:Value())
		  end
		end
	     end
 	end
 end
 if Sona.Draws.DrawText:Value() then
	for _, enemy in pairs(GetEnemyHeroes()) do
		 if ValidTarget(enemy) then
			local CheckQR = CalcDamage(myHero, enemy, 0, CheckQDmg + CheckRDmg + Ludens())
			local CheckQ = CalcDamage(myHero, enemy, 0, CheckQDmg + Ludens())
			local CheckR = CalcDamage(myHero, enemy, 0, CheckRDmg + Ludens())
			local Check = GetMagicShield(enemy)+GetDmgShield(enemy)
			if IsReady(_R) and IsReady(_Q) then
			DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,CheckQR - Check,0xffffffff)
			elseif IsReady(_R) and not IsReady(_Q) then
			DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,CheckR - Check,0xffffffff)
			elseif IsReady(_Q) and not IsReady(_R) then
			DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,CheckQ - Check,0xffffffff)
			end
		 end
	end
	for _, myally in pairs(GetAllyHeroes()) do
		 if GetObjectName(myHero) ~= GetObjectName(myally) then	
	    if IsObjectAlive(myally) then
		    local originAllies = GetOrigin(myally)
		    local AllyTextPos = WorldToScreen(1,originAllies.x, originAllies.y, originAllies.z)
		    local maxhpA = GetMaxHP(myally)
		    local currhpA = GetCurrentHP(myally)
			local percentA = 100*currhpA/maxhpA
			local perc = '%'
			local CheckW = 100 - percentA
			local WDmg = 10 + 20*GetCastLevel(myHero,_W) + 0.20*BonusAP
			local HealW = WDmg + (WDmg*CheckW)/100
			local WMax = 15 + 30*GetCastLevel(myHero,_W) + 0.30*BonusAP
			local CurrentW = math.min(HealW, WMax)
			DrawText(string.format("%s HP: %d | %sHP = %s%d", GetObjectName(myally), currhpA, perc, perc, percentA),16,AllyTextPos.x,AllyTextPos.y,0xffffffff)
			DrawText(string.format("Heal of W = %d HP", CurrentW),18,AllyTextPos.x,AllyTextPos.y+20,0xffffffff)
	    end
		 end
	end 
	    if IsObjectAlive(myHero) then
		    local myorigin = GetOrigin(myHero)
		    local mytextPos = WorldToScreen(1,myorigin.x, myorigin.y, myorigin.z)
			local perHP = GetPercentHP(myHero)
			local CheckFW = 100 - perHP
			local DmgW = 10 + 20*GetCastLevel(myHero,_W) + 0.20*BonusAP
			local HealW = DmgW + (DmgW*CheckFW)/100
			local MaxW = 15 + 30*GetCastLevel(myHero,_W) + 0.30*BonusAP
			local checkhealW = math.min(HealW, MaxW)
			local checkshieldW = 15 + 20*GetCastLevel(myHero,_W) + 0.20*BonusAP
			DrawText(string.format("Heal of W: %d HP | Shield of W: %d Armor", checkhealW, checkshieldW),18,mytextPos.x,mytextPos.y,0xffffffff)
	    end	
 end
  end
end)
PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Version 1.5 without deLibrary Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
