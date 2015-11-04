--[[ Rx Zilean Version 0.15 by Rudo.
 Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------]]


require('Inspired')
---- Create a Menu ----
if GetObjectName(myHero) ~= "Zilean" then return end
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))
----------------------------------------
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
Zilean.hr:Slider("HrMana", "Harass if %MP >= ", 20, 1, 100, 1)
Zilean.hr:Boolean("HrQ", "Use Q", true)

---- Lane Clear Menu ----
Zilean:Menu("lc", "Lane Clear")
Zilean.lc:Slider("checkMP", "Lane Clear if %MP >= ", 20, 1, 100, 1)
Zilean.lc:Boolean("LcQ", "Use Q", true)

---- Jungle Clear Menu ----
Zilean:Menu("jc", "Jungle Clear")
Zilean.jc:Boolean("JcQ", "Use Q", true)

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
Zilean.Draws:Boolean("DrawQ", "Range Q", true)
Zilean.Draws:ColorPick("Qcol", "Setting Q Color", {255, 30, 144, 255})
Zilean.Draws:Boolean("DrawE", "Range E", true)
Zilean.Draws:ColorPick("Ecol", "Setting E Color", {255, 155, 48, 255})
Zilean.Draws:Boolean("DrawR", "Range R", true)
Zilean.Draws:ColorPick("Rcol", "Setting R Color", {255, 244, 245, 120})
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

---- Auto Level Up Skills Menu ----
Zilean:Menu("AutoLvlUp", "Auto Level Up")
Zilean.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Zilean.AutoLvlUp:DropDown("AutoSkillUp", "Settings", 1, {"Q-W-E", "Q-E-W"}) 

---------- End Menu ----------


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
	["TahmKenchR"]                  = {Name = "Tahm Kench",   Spellslot = _R}, 
    ["VelKozR"]                     = {Name = "VelKoz",       Spellslot = _R}, 
    ["XerathR"]                     = {Name = "Xerath",       Spellslot = _R} 
}

DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(ANTI_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
		local InterruptMenu = MenuConfig("Q-Q to Stop Spell enemy", "Interrupt")
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_Q) and IsReady(_W) and GetCurrentMana(myHero) >= 165 + 5*GetCastLevel(myHero, _Q) then
      if ANTI_SPELLS[spell.name] then
        if ValidTarget(unit, GetCastRange(myHero,_Q)) and GetObjectName(unit) == ANTI_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
        local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),2000,200,900,100,false,true)
		 if QPred.HitChance == 1 then
		 CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		  if not IsReady(_Q) then
		  CastSpell(_W)
		  end
         end
		end
      end
    end
end)

local BonusAP = GetBonusAP(myHero)
local CheckQDmg = (GetCastLevel(myHero, _Q)*40) + 35 + (0.90*BonusAP)
-------------------------------------------
OnTick(function(myHero)
		        local target = tslowhp:GetTarget()
			if target then
    	------ Start Combo ------
    if IOW:Mode() == "Combo" then
        if IsReady(_Q) and Zilean.cb.QCB:Value() and ValidTarget(target, 900) and IsObjectAlive(target) then
		        local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),2000,200,900,100,false,true)		
		 if QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		 end
		end
		
        if IsReady(_W) and not IsReady(_Q) and GetCurrentMana(myHero) >= 110 + 5*GetCastLevel(myHero, _Q) and Zilean.cb.WCB:Value() and IsInDistance(target, 900) then
		CastSpell(_W)
		end
		
		
	   for i,enemy in pairs(GetEnemyHeroes()) do
		if IsReady(_E) and Zilean.cb.ECB:Value() and IsInDistance(enemy, 1200) then 
		 for _,ally in pairs(GetAllyHeroes()) do
		local Al = AlliesAround(myHeroPos(), GetCastRange(myHero, _E))
		local Enm = EnemiesAround(myHeroPos(), GetCastRange(myHero, _E))
		  if Al >= 1 and 1 + Al >= Enm then
		  CastTargetSpell(target, _E)
		  elseif Al < Enm then
		   if ally ~= myHero then
		    if IsInDistance(ally, GetCastRange(myHero, _E)) then
		     if GetDistance(ClosestAlly(GetMousePos()), GetMousePos()) <= 250 and GotBuff(ClosestAlly(GetMousePos()), "TimeWarp") <= 0 then
		  CastTargetSpell(ClosestAlly(GetMousePos()), _E)
		     elseif GetDistance(myHeroPos(), GetMousePos()) <= 250 and GetDistance(ClosestAlly(GetMousePos()), GetMousePos()) > 250 and GotBuff(myHero, "TimeWarp") <= 0 then
		  CastTargetSpell(myHero, _E)
		     end
		    end
		   end
		  elseif Al <= 0 and IsInDistance(target, 1200) and not IsInDistance(target, 880) then
		  CastTargetSpell(myHero, _E)
		  end
		 end
		end
	   end
	end

	if IOW:Mode() == "Harass" and Zilean.hr.HrMana:Value() then
	------ Start Harass ------
        if IsReady(_Q) and ValidTarget(target, 900) and Zilean.cb.QCB:Value() and IsObjectAlive(target) then
		local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),2000,200,900,100,false,true) 
		 if QPred.HitChance == 1 then
        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
         end
        end		 
	end
			end
	
	if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Zilean.lc.checkMP:Value() then	 
	------ Start Lane Clear ------	
	 for _,minion in pairs(minionManager.objects) do
	  if GetTeam(minion) == MINION_ENEMY then
		if IsInDistance(minion, 900) then
		 if IsReady(_Q) and Zilean.lc.LcQ:Value() then
		 local BestPos, BestHit = GetFarmPosition(900, 300)
		  if BestPos and BestHit > 0 then
		  CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
		  end
		 end
		end
	  end
	 end
	end

	if IOW:Mode() == "LaneClear" then	 
	------ Start Jungle Clear ------	
	 for _,mobs in pairs(minionManager.objects) do
	  if GetTeam(mobs) == MINION_JUNGLE then
		if IsInDistance(mobs, 900) then
		 if IsReady(_Q) and Zilean.jc.JcQ:Value() then
		 local BestPos, BestHit = GetJFarmPosition(900, 300)
		  if BestPos and BestHit > 0 then
		  CastSkillShot(_Q, BestPos.x, BestPos.y, BestPos.z)
		  end
		 end
		end
	  end
	 end
	end
	
----------------------------------------------------------------------
	
	------ Start AutoSpell ------
if Zilean.AtSpell.ASEb:Value() then
  for i, enemy in pairs(GetEnemyHeroes()) do
 
if IsReady(_E) and GetPercentMP(myHero) >= Zilean.AtSpell.ASMP:Value() and Zilean.AtSpell.ATSE.ASE:Value() and Zilean.AtSpell.ATSE.KeyE:Value() and GotBuff(myHero, "recall") <= 0 and GotBuff(myHero, "TimeWarp") <= 0 then
   CastTargetSpell(myHero, _E)
end

if Zilean.AtSpell.ATSE.KeyE:Value() then MoveToXYZ(GetMousePos().x, GetMousePos().y, GetMousePos().z) end

if IsReady(_Q) and GetPercentMP(myHero) >= Zilean.AtSpell.ASMP:Value() and Zilean.AtSpell.ATSQ.ASQ:Value() and GotBuff(myHero, "recall") <= 0 and ValidTarget(enemy, 880) and GotBuff(enemy, "zileanqenemybomb") > 0 then
local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),2000,300,900,100,false,true)
if QPred.HitChance == 1 then
  CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
  end
end

 	------ Start Kill Steal ------
if Zilean.KS.KSEb:Value() then
 for i,enemy in pairs(GetEnemyHeroes()) do
        -- Kill Steal --

		if Ignite and Zilean.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end

	if IsReady(_Q) and ValidTarget(enemy, 880) and Zilean.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, CheckQDmg + Ludens()) then
	 	local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),2000,300,900,100,false,true)
	 if QPred.HitChance == 1 then
		CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	 end
	end
 end
end

 	------ Start Auto Level Up _Settings Full Q or Full W first ------	
if Zilean.AutoLvlUp.UpSpellEb:Value() then
  if Zilean.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First then W
  elseif Zilean.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q First then E
  end
   LevelSpell(leveltable[GetLevel(myHero)])
end
end)
	
------------------------------------------------------- Start Function -------------------------------------------------------
	
	------ Start Drawings ------
OnDraw(function(myHero)
 if Zilean.Draws.DrawsEb:Value() then
if Zilean.Draws.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.Qcol:Value()) end
if Zilean.Draws.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.Ecol:Value()) end
if Zilean.Draws.DrawR:Value() and IsReady(_R) then DrawCircle(myHeroPos(),GetCastRange(myHero,_R),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.Rcol:Value()) end

            if Zilean.Draws.DrawText:Value() then
	
	for _,myally in pairs(GetAllyHeroes()) do
		 if GetObjectName(myHero) ~= GetObjectName(myally) then	
	    if IsObjectAlive(myally) then
		    local alliesPos = WorldToScreen(1,GetOrigin(myally))
		    local maxhpA = GetMaxHP(myally)
		    local currhpA = GetCurrentHP(myally)
			local percentA = 100*currhpA/maxhpA
			local per = '%'
	        if GetLevel(myHero) >= 6 then
			 if percentA <= 20 then
			DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(myally), currhpA, maxhpA, per, percentA, per),21,alliesPos.x,alliesPos.y+5,0xffff0000)
			 else
			DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(myally), currhpA, maxhpA, per, percentA, per),18,alliesPos.x,alliesPos.y,0xffffffff)
		     end
			end
		end
	end	
    end
		
  drawtexts = ""
    for nID, ally in pairs(GetAllyHeroes()) do
	 if IsObjectAlive(ally) then
	  if GetObjectName(myHero) ~= GetObjectName(ally) then
		if IsReady(_R) and IsInDistance(ally, 2500) then
		    local maxhpA = GetMaxHP(ally)
		    local currhpA = GetCurrentHP(ally)
			local percentA = 100*currhpA/maxhpA
		 if percentA <= 20 then
		drawtexts = drawtexts..GetObjectName(ally)
		drawtexts = drawtexts.." %HP < 20%. Should Use R\n"
		 end
  DrawText(drawtexts,27,0,110,0xff00ff00) 
		end
	  end
	 end
    end
	
	local myTextPos = WorldToScreen(1,myHeroPos())
	local permh = '%'
	if IsObjectAlive(myHero) then
	 if GetPercentHP(myHero) <= 20 and GetLevel(myHero) >= 6 then
    DrawText(string.format("%sHP = %d%s CAREFUL!", permh, GetPercentHP(myHero), permh),21,myTextPos.x,myTextPos.y+5,0xffff0000)
	 end
	end
            end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
		local CheckQ = CalcDamage(myHero, enemy, 0, CheckQDmg)
		local Check = GetMagicShield(enemy)+GetDmgShield(enemy)
		local currhp = math.max(CheckQ, GetCurrentHP(enemy))
    if IsReady(_Q) then
		  DrawDmgOverHpBar(enemy,currhp,0,CheckQ + Ludens(),0xffffffff)
    else
          DrawDmgOverHpBar(enemy,currhp,GetBaseDamage(myHero),0,0xffffffff)
    end
		end
	end
 end
end)	
PrintChat(string.format("<font color='#FF0000'>Rx Zilean by Rudo </font><font color='#FFFF00'>Version 0.15: Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
