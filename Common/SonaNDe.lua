--[[ Rx Sona Without deLibrary Version 0.1 by Rudo.
     0.1: Released
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

if GetObjectName(GetMyHero()) ~= "Sona" then return end

require('Inspired')
AutoUpdate("/anhvu2001ct/Rudo-GoS-Scripts/master/Common/SonaNDe.lua","/anhvu2001ct/Rudo-GoS-Scripts/master/Common/SonaNDe.version","SonaNDe.lua",0.1)
---- Create a Menu ----
Sona = MenuConfig("Rx Sona", "Sona")

---- Combo ----
Sona:Menu("cb", "Combo")
Sona.cb:Boolean("QCB", "Use Q", true)
Sona.cb:Boolean("WCB", "Use W", true)
Sona.cb:Boolean("ECB", "Use E", true)
tslowhp = TargetSelector(GetCastRange(myHero, _R), TARGET_LOW_HP, DAMAGE_MAGIC)
Sona.cb:DropDown("RCB", "Choose your R mode", 1, {"Can Hit x enemy", "Target Selection"})

---- Harass Menu ----
Sona:Menu("hr", "Harass")
Sona.hr:Boolean("HrQ", "Use Q", true)
Sona.hr:Slider("HrMana", "Harass if %My MP >=", 20, 1, 100, 1)

---- Auto Spell Menu ----
Sona:Menu("AtSpell", "Auto Spell")
Sona.AtSpell:Slider("ASMana", "Auto Spell if My %MP >=", 10, 1, 90, 1)
Sona.AtSpell:Menu("QAuto", "Auto Q")
Sona.AtSpell.QAuto:Boolean("ASQ", "Enable", true)
Sona.AtSpell:Menu("WAuto", "Auto W")
Sona.AtSpell.WAuto:Menu("me", "Auto W My Hero")
Sona.AtSpell.WAuto.me:Boolean("ASW", "Enable Auto W(check myHero HP)", true)
Sona.AtSpell.WAuto.me:Slider("myHrHP", "Auto W if %My HP  =<", 55, 1, 100, 1)
Sona.AtSpell.WAuto:Menu("ally", "Auto W Ally")
Sona.AtSpell.WAuto.ally:Boolean("AllyEb", "Enable AutoW(check Ally HP)", true)
Sona.AtSpell.WAuto.ally:Info("info0", "Setting %x HP ally in battle mode or normal mode") 
Sona.AtSpell.WAuto.ally:Slider("battlemode", "Battle Mode", 70, 2, 100, 1)
Sona.AtSpell.WAuto.ally:Info("info1", "Battle Mode: if Enemy Heroes in 1250 range then Auto W if %HP Ally <= %x HP")
Sona.AtSpell.WAuto.ally:Slider("normalmode", "Normal Mode", 50, 2, 100, 1)
Sona.AtSpell.WAuto.ally:Info("info2", "Normal Mode: if no Enemy Heroes in 1250 range then Auto W if %HP Ally <= %x HP")
PermaShow(Sona.AtSpell.QAuto.ASQ)
PermaShow(Sona.AtSpell.WAuto.me.ASW)
PermaShow(Sona.AtSpell.WAuto.ally.AllyEb)

---- Kill Steal Menu ----
Sona:Menu("KS", "Kill Steal")
Sona.KS:Boolean("KSEb", "Enable KillSteal", true)
Sona.KS:Boolean("IgniteKS", "KS with Ignite", true)
Sona.KS:Boolean("QKS", "KS with Q", true)
PermaShow(Sona.KS.IgniteKS)

---- Auto Level Up Menu ----
Sona:Menu("AutoLvlUp", "Auto Level Up")
Sona.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Sona.AutoLvlUp:DropDown("AutoSkillUp", "Settings", 1, {"Q-W-E", "W-Q-E"}) 

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
Sona.Draws:Slider("HPAllies", "Draw if %HP Ally <= x%", 40, 6, 70, 2)
Sona.Draws:ColorPick("Alcol", "Circle Around Ally Color", {255, 173, 255, 47})
PermaShow(Sona.Draws.DrawText)
PermaShow(Sona.Draws.DrawCircleAlly)

---- Misc Menu ----
Sona:Menu("misc", "Misc")
Sona.misc:Boolean("smite", "Check enemy have Smite", true)
Sona.misc:Info("infoS", "It will draw text if find enemy have Smite in 2500 Range")
Sona.misc:Boolean("checkteam", "Enable check ENEMY GANKING", true)
Sona.misc:Info("infoteam", "This function will check human around you")
Sona.misc:Info("infocteam", "If enemy team > your team then draw text 'GANKED!!'")

Sona:Info("info3", "Use PActivator for Auto Items")
   
---------- End Menu ----------

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))

-------------------------------------------------------Starting--------------------------------------------------------------
require('IPrediction')
local QPred = { name = "SonaR", speed = 2400, delay = 0.3, range = 1000, width = 150, collision = false, aoe = true, type = "linear"}
QPrediction = IPrediction.Prediction(QPred)
------------------------------------------
require('DeftLib')
require('DamageLib')
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
    ["TahmKenchR"]                  = {Name = "TahmKench",   Spellslot = _R}, 
    ["VelKozR"]                     = {Name = "VelKoz",       Spellslot = _R}, 
    ["XerathR"]                     = {Name = "Xerath",       Spellslot = _R} 
}

	InterruptMenu = MenuConfig("Q-Q to Stop Spell enemy", "Interrupt")
	InterruptMenu:Info("InfoQ", "If you don't see any ON/OFF => No enemy can Interrupt.")
DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(ANTI_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        InterruptMenu:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_R) then
      if ANTI_SPELLS[spell.name] then
        if ValidTarget(unit, 990) and GetObjectName(unit) == ANTI_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
         local hitchance, pos = QPrediction:Predict(unit)
         if hitchance > 2 then
		  CastSkillShot(_R, pos)
         end
		end
      end
    end
end)

local BonusAP = GetBonusAP(myHero)
local HealWAlly = {}
local HealWMH
local ShieldW

OnTick(function(myHero)
local target = GetCurrentTarget()
local unit = tslowhp:GetTarget()

 if IOW:Mode() == "Combo" then	
	------ Start Combo ------
  if IsReady(_Q) and ValidTarget(target, 845) and IsObjectAlive(target) and Sona.cb.QCB:Value() then
   CastSpell(_Q)
  end
  
  if IsReady(_W) and ValidTarget(target, 1000) and Sona.cb.WCB:Value() and (GetCurrentHP(myHero) + 10 + 20*GetCastLevel(myHero, _W)) <= GetMaxHP(myHero) then
   CastSpell(_W)
  end

  if IsReady(_R) then
   for i, enemy in pairs(GetEnemyHeroes()) do
    if ValidTarget(enemy, 1000) and IsObjectAlive(enemy) then
     if Sona.cb.RCB:Value() == 1 then
	 Sona.cb:Slider("RCBxEnm", "Use R if can hit x enemy", 2, 1, 5, 1)
     local hitchance, pos = QPrediction:Predict(enemy)
      if hitchance > 2 then
      local Enm = EnemiesAround(GetOrigin(enemy), 150)
       if 1+Enm >= Sona.cb.RCBxEnm:Value() then
        CastSkillShot(_R, pos)
       end
      end
     end
    end
   end
   if Sona.cb.RCB:Value() ~= 1 and Sona.cb.RCB:Value() == 2 then
   Sona:TargetSelector("ts", "Target Selector", tslowhp)
    if unit and ValidTarget(unit, 1000) and IsObjectAlive(unit) then
    local hitchance, pos = QPrediction:Predict(unit)
     if hitchance > 2 then
      CastSkillShot(_R, pos)
     end
    end
   end
  end
end
		
					
 if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Sona.hr.HrMana:Value() then
    ------ Start Harass ------
  if IsReady(_Q) and ValidTarget(target, 845) and IsObjectAlive(target) and Sona.hr.HrQ:Value() then
   CastSpell(_Q)
  end	
 end
	
 if GetPercentMP(myHero) >= Sona.AtSpell.ASMana:Value() and GotBuff(myHero, "recall") <= 0 then
    ------ Start Auto Spell ------
  for i, enemy in pairs(GetEnemyHeroes()) do				  
   if IsReady(_Q) and ValidTarget(enemy, 845) and Sona.AtSpell.QAuto.ASQ:Value() then
    CastSpell(_Q)
   end

   if IsReady(_W) and GetPercentHP(myHero) <= Sona.AtSpell.WAuto.me.myHrHP:Value() and Sona.AtSpell.WAuto.me.ASW:Value() then
    CastSpell(_W)
   end
   
   for l, ally in pairs(GetAllyHeroes()) do
    if IsReady(_W) and Sona.AtSpell.WAuto.ally.AllyEb:Value() then
     if IsInDistance(enemy, 1250) then	   
      if IsInDistance(ally, GetCastRange(myHero, _W)) and GetPercentHP(ally) <= Sona.AtSpell.WAuto.ally.battlemode:Value() then
       CastSpell(_W)
      end
     elseif GetDistance(myHero, enemy) > 1250 then
      if IsInDistance(ally, GetCastRange(myHero, _W)) and GetPercentHP(ally) <= Sona.AtSpell.WAuto.ally.normalmode:Value() then
       CastSpell(_W)
      end
     end
    end 
   end
  end
 end
	
 if Sona.KS.KSEb:Value() then
	 	------ Start Kill Steal ------
  for i, enemy in pairs(GetEnemyHeroes()) do
   if Ignite and Sona.KS.IgniteKS:Value() then
    if IsReady(Ignite) and 20*GetLevel(myHero)+50 >= GetHP(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
     if GetObjectName(enemy) == GetObjectName(ClosestEnemy(GetOrigin(myHero))) then
      CastTargetSpell(enemy, Ignite)
     end
    end
   end
  end

  if IsReady(_Q) and ValidTarget(enemy, 845) and Sona.KS.QKS:Value() and IsObjectAlive(enemy) and GetHP2(enemy) < getdmg("Q",enemy) then
   if GetObjectName(enemy) == GetObjectName(ClosestEnemy(GetOrigin(myHero))) then
    CastSpell(_Q)
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

---------- Calculate Check Heal of W ----------
 for l, ally in pairs(GetAllyHeroes()) do
  if GetObjectName(myHero) ~= GetObjectName(ally) then	
   if IsObjectAlive(ally) then
    local WCheck = 100 - GetPercentHP(ally)
    local WDmg = 10 + 20*GetCastLevel(myHero,_W) + 0.20*BonusAP
    local WHeal = WDmg + (WDmg*WCheck)/200
    local WMax = 15 + 30*GetCastLevel(myHero,_W) + 0.30*BonusAP
    HealWAlly[l] = math.min(WHeal, WMax)
   end
  end
 end
   if IsObjectAlive(myHero) then
    local CheckW = 100 - GetPercentHP(myHero)
    local DmgW = 10 + 20*GetCastLevel(myHero,_W) + 0.20*BonusAP
    local HealW = DmgW + (DmgW*CheckW)/200
    local MaxW = 15 + 30*GetCastLevel(myHero,_W) + 0.30*BonusAP
    HealWMH = math.min(HealW, MaxW)
    ShieldW = 15 + 20*GetCastLevel(myHero,_W) + 0.20*BonusAP
   end
--- end OnTick ---
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
   for l, ally in pairs(GetAllyHeroes()) do
    if GetObjectName(myHero) ~= GetObjectName(ally) then	
     if IsObjectAlive(ally) then
      if GetPercentHP(ally) <= Sona.Draws.HPAllies:Value() then
       DrawCircle(GetOrigin(ally), 1000, 1, Sona.Draws.QualiDraw:Value(), Sona.Draws.Alcol:Value())
      end
     end
    end
   end
  end
  
  if Sona.Draws.DrawText:Value() then
   for l, ally in pairs(GetAllyHeroes()) do
    if GetObjectName(myHero) ~= GetObjectName(ally) then	
     if IsObjectAlive(ally) then
      local AllyTextPos = WorldToScreen(1, GetOrigin(ally))
      local perc = '%'
      DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(ally), GetCurrentHP(ally), GetMaxHP(ally), perc, GetPercentHP(ally), perc),16,AllyTextPos.x,AllyTextPos.y,0xffffffff)
      DrawText(string.format("Heal of W = %d HP", HealWAlly[l]),18,AllyTextPos.x,AllyTextPos.y+20,0xffffffff)
     end
    end
   end 
   
   if IsObjectAlive(myHero) then
    local Enm = EnemiesAround(GetOrigin(myHero), 4200)
    local Ally = AlliesAround(GetOrigin(myHero), 2100)
    local mytextPos = WorldToScreen(1, GetOrigin(myHero))
    DrawText(string.format("Heal of W: %d HP | Shield of W: %d Armor", HealWMH, ShieldW),18,mytextPos.x,mytextPos.y,0xffffffff)
    if Sona.misc.checkteam:Value() and Enm > 0 and Enm > 1+Ally then DrawText("GANKED!!",22,mytextPos.x,mytextPos.y+22,0xffff0000) end
   end
   
   for i, enemy in pairs(GetEnemyHeroes()) do
    if ValidTarget(enemy, 2000) and IsVisible(enemy) then
     if GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite") then
      if Sona.misc.smite:Value() then DrawText("Found enemy have Smite in 2500 range",24,660,150,0xffff2626) end
     end
    end
   end
  end
  
  for i, enemy in pairs(GetEnemyHeroes()) do
   if ValidTarget(enemy) then
   local Check = GetMagicShield(enemy)+GetDmgShield(enemy)
    if IsReady(_R) and IsReady(_Q) then
     DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("R",enemy) - Check,0xffffffff)
    elseif IsReady(_R) and not IsReady(_Q) then
     DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("R",enemy) - Check,0xffffffff)
	elseif IsReady(_Q) and not IsReady(_R) then
     DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("Q",enemy) - Check,0xffffffff)
    else
     DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,GetBaseDamage(myHero) - Check,0xffffffff)
    end
   end
  end
 end
end)

PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
