--[[ Rx Sona NoAutoUpdate version 0.31 by Rudo.
     0.31: Edit somethings
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
local WebVersion = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/SonaNDe.version"
local CheckWebVer = require("GOSUtility").request("https://raw.githubusercontent.com",WebVersion.."?no-cache="..(math.random(100000))) -- Copy from Inspired >3
local ScriptVersion = 0.31 -- Current Version
PrintChat(string.format("<font color='#C926FF'>Script Current Version:</font><font color='#FF8000'> %s </font>| <font color='#C926FF'>Newest Version:</font><font color='#FF8000'> %s </font>", ScriptVersion, tonumber(CheckWebVer)))
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu, Inspired, Zypppy. </font>"))
---- Create a Menu ----
Sona = MenuConfig("Rx Sona", "Sona")

---- Combo ----
Sona:Menu("cb", "Combo")
Sona.cb:Boolean("QCB", "Use Q", true)
Sona.cb:Boolean("WCB", "Use W", true)
Sona.cb:Boolean("ECB", "Use E", true)
Sona.cb:Boolean("RCB", "Enable use R in Combo", true)
Sona.cb:Slider("RCBxEnm", "Use R if can hit x enemy", 2, 1, 5, 1)
PermaShow(Sona.cb.RCB)

---- Harass Menu ----
Sona:Menu("hr", "Harass")
Sona.hr:Boolean("HrQ", "Use Q", true)
Sona.hr:Slider("HrMana", "Harass if %My MP >=", 20, 1, 100, 1)

---- LastHit Menu ----
Sona:Menu("lh", "Last Hit")
Sona.lh:Boolean("LasthitQ", "Enable Q LastHit", true)
Sona.lh:Slider("LhMana", "LastHit if %My MP >=", 20, 1, 100, 1)
PermaShow(Sona.lh.LasthitQ)

---- Auto Spell Menu ----
Sona:Menu("AtSpell", "Auto Spell")
Sona.AtSpell:Slider("ASMana", "Auto Spell if My %MP >=", 15, 1, 90, 1)
Sona.AtSpell:Menu("QAuto", "Auto Q")
Sona.AtSpell.QAuto:Boolean("ASQ", "Enable Auto Q", true)
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
Sona.Draws:Slider("QualiDraw", "Circle Quality (Highest = 1)", 110, 1, 255, 1)
Sona.Draws:Menu("Range", "Skills Range")
Sona.Draws.Range:Boolean("DrawQ", "Range Q", true)
Sona.Draws.Range:ColorPick("Qcol", "Setting Q Color", {255, 30, 144, 255})
Sona.Draws.Range:Boolean("DrawW", "Range W", true)
Sona.Draws.Range:ColorPick("Wcol", "Setting W Color", {255, 124, 252, 0})
Sona.Draws.Range:Boolean("DrawE", "Range E", true)
Sona.Draws.Range:ColorPick("Ecol", "Setting E Color", {255, 155, 48, 255})
Sona.Draws.Range:Boolean("DrawR", "Range R", true)
Sona.Draws.Range:ColorPick("Rcol", "Setting R Color", {255, 248, 245, 120})
Sona.Draws:Menu("Texts", "Draw Text")
Sona.Draws.Texts:Boolean("HPAlly", "Draw HP Ally", true)
Sona.Draws.Texts:Boolean("WAlly", "Draw W Heal Ally", true)
Sona.Draws.Texts:Boolean("WSmyH", "Draw W Heal and W Shiled myHero", true)
Sona.Draws:Menu("CircleAlly", "Draw Circle Around Ally")
Sona.Draws.CircleAlly:Boolean("DrawCircleAlly", "Enable draw circle ally", true)
Sona.Draws.CircleAlly:Slider("HPAllies", "Draw if %HP Ally <= x%", 40, 6, 70, 2)
Sona.Draws.CircleAlly:ColorPick("Alcol", "Circle Around Ally Color", {255, 173, 255, 47})
PermaShow(Sona.Draws.CircleAlly.DrawCircleAlly)

---- Misc Menu ----
Sona:Menu("misc", "Misc")
Sona.misc:Boolean("smite", "Check enemy have Smite", true)
Sona.misc:Info("infoS", "It will draw text if found enemy have Smite in 2500 Range")
Sona.misc:Boolean("checkteam", "Enable check ENEMY GANKING", true)
Sona.misc:Info("infoteam", "This function will check human around you in 4000 range")
Sona.misc:Info("infocteam", "If enemy team > your team then draw text 'GANKED!!'")

Sona:Info("info3", "Use PActivator for Auto Items")
   
---------- End Menu ----------

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
    ["TahmKenchR"]                  = {Name = "TahmKench",    Spellslot = _R}, 
    ["VelKozR"]                     = {Name = "VelKoz",       Spellslot = _R}, 
    ["XerathR"]                     = {Name = "Xerath",       Spellslot = _R} 
}

	InterruptMenu = MenuConfig("R Stop Spell enemy", "Interrupt")
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

local HealWAlly = {}
local allies = {}
local HealWMH
local ShieldW = nil


OnTick(function(myHero)
local WDmg = 10 + 20*GetCastLevel(myHero,_W) + 0.2*GetBonusAP(myHero)
local WMax = 15 + 30*GetCastLevel(myHero,_W) + 0.3*GetBonusAP(myHero)
if ShieldW == nil then ShieldW = 15 + 20*GetCastLevel(myHero,_W) + 0.2*GetBonusAP(myHero) end

local target = GetCurrentTarget()

 if IOW:Mode() == "Combo" then	
	------ Start Combo ------
  if IsReady(_Q) and ValidTarget(target, 822) and IsObjectAlive(target) and Sona.cb.QCB:Value() then
   CastSpell(_Q)
  end
  
  if IsReady(_W) and ValidTarget(target, 1000) and Sona.cb.WCB:Value() and (GetCurrentHP(myHero) + 10 + 20*GetCastLevel(myHero, _W)) <= GetMaxHP(myHero) then
   CastSpell(_W)
  end
  
  if IsReady(_E) and ValidTarget(target, 1500) and Sona.cb.ECB:Value() then
   if AlliesAround(myHeroPos(), GetCastRange(myHero, _E)) >= 1 or not IsInDistance(target, 850) then
    CastSpell(_E)
   end
  end

  if IsReady(_R) then
   for i, enemy in pairs(GetEnemyHeroes()) do
    if Sona.cb.RCB:Value() and ValidTarget(enemy, 1000) and IsObjectAlive(enemy) then
    local Enm = EnemiesAround2(GetOrigin(enemy), 150)
     if Enm >= Sona.cb.RCBxEnm:Value() then
     local hitchance, pos = QPrediction:Predict(enemy)
      if hitchance > 2 then
        CastSkillShot(_R, pos)
      end
     end
    end
   end
  end
end
		
					
 if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Sona.hr.HrMana:Value() then
    ------ Start Harass ------
  if IsReady(_Q) and ValidTarget(target, 822) and IsObjectAlive(target) and Sona.hr.HrQ:Value() then
   CastSpell(_Q)
  end	
 end

 if IOW:Mode() == "LastHit" and GetPercentMP(myHero) >= Sona.lh.LhMana:Value() then
    ------ Start LastHit ------
  for I = 1, minionManager.maxObjects do
  local minion = minionManager.objects[I]
   if IsReady(_Q) and IsInDistance(minion, GetCastRange(myHero, _Q)) and Sona.lh.LasthitQ:Value() then 
   local closest = ClosestMinion(myHeroPos(), MINION_ENEMY)
   local closestagain = ClosestMinion(GetOrigin(closest), MINION_ENEMY)
    if EnemiesAround(myHeroPos(), 825) <= 1 and GetCurrentHP(closest) <= CalcDamage(myHero, closest, 0, 40*GetCastLevel(myHero,_Q) + 0.5*GetBonusAP(myHero) + Ludens()) and IsObjectAlive(closest) then
      CastSpell(_Q)
    elseif EnemiesAround(myHeroPos(), 825) <= 0 and IsObjectAlive(closestagain) then
     if GetCurrentHP(closest) <= CalcDamage(myHero, closest, 0, QDmg) or GetCurrentHP(closestagain) <= CalcDamage(myHero, closestagain, 0, 40*GetCastLevel(myHero,_Q) + 0.5*GetBonusAP(myHero) + Ludens()) then
      CastSpell(_Q)
     end
    end
   end
  end
 end
 
 if GetPercentMP(myHero) >= Sona.AtSpell.ASMana:Value() and GotBuff(myHero, "recall") <= 0 then
    ------ Start Auto Spell ------
  for i, enemy in pairs(GetEnemyHeroes()) do				  
   if IsReady(_Q) and ValidTarget(enemy, 823) and Sona.AtSpell.QAuto.ASQ:Value() then
    CastSpell(_Q)
   end

   if IsReady(_W) and GetPercentHP(myHero) <= Sona.AtSpell.WAuto.me.myHrHP:Value() and Sona.AtSpell.WAuto.me.ASW:Value() then
    CastSpell(_W)
   end
   
   for l, ally in pairs(GetAllyHeroes()) do
    if IsReady(_W) and Sona.AtSpell.WAuto.ally.AllyEb:Value() and IsObjectAlive(ally) then
     if IsInDistance(enemy, 1250) and IsObjectAlive(enemy) then	   
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
      CastTargetSpell(enemy, Ignite)
    end
   end
  end

  if IsReady(_Q) and ValidTarget(enemy, 822) and Sona.KS.QKS:Value() and IsObjectAlive(enemy) and GetHP2(enemy) < getdmg("Q",enemy) then
  local name1 = ClosestEnemy(myHeroPos())
  local name2 = ClosestEnemy(GetOrigin(name1))
   if GetObjectName(enemy) == GetObjectName(name1) or GetObjectName(enemy) == GetObjectName(name2) then
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
allies = GetAllyHeroes()
 for l, ally in pairs(allies) do
  if GetObjectName(myHero) ~= GetObjectName(ally) then	
   if IsObjectAlive(ally) then
    local WCheck = 100 - GetPercentHP(ally)
    local WHeal = WDmg + (WDmg*WCheck)/200
    HealWAlly[l] = math.min(WHeal, WMax)
   else
   HealWAlly[l] = 0
   end
  end
 end
   if IsObjectAlive(myHero) then
    local CheckW = 100 - GetPercentHP(myHero)
    local HealW = WDmg + (WDmg*CheckW)/200
    HealWMH = math.min(HealW, WMax)
   else
   HealWMH = 0
   end
--- end OnTick ---
end)
 

------------------------------------------------------
	
OnDraw(function(myHero)
	------ Start Drawings ------
 if Sona.Draws.DrawsEb:Value() then
if Sona.Draws.Range.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Range.Qcol:Value()) end
if Sona.Draws.Range.DrawW:Value() and IsReady(_W) then DrawCircle(myHeroPos(),GetCastRange(myHero,_W),1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Range.Wcol:Value()) end
if Sona.Draws.Range.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),2,Sona.Draws.QualiDraw:Value(),Sona.Draws.Range.Ecol:Value()) end
if Sona.Draws.Range.DrawR:Value() and IsReady(_R) then DrawCircle(myHeroPos(),GetCastRange(myHero,_R),1,Sona.Draws.QualiDraw:Value(),Sona.Draws.Range.Rcol:Value()) end
  if Sona.Draws.CircleAlly.DrawCircleAlly:Value() then
   for l, ally in pairs(allies) do
    if GetObjectName(myHero) ~= GetObjectName(ally) then
     if IsObjectAlive(ally) and IsInDistance(ally, 2000) then	
      if GetPercentHP(ally) <= Sona.Draws.CircleAlly.HPAllies:Value() then
       DrawCircle(GetOrigin(ally), 1000, 1, Sona.Draws.QualiDraw:Value(), Sona.Draws.CircleAlly.Alcol:Value())
      end
     end
    end
   end
  end
  
   for l, ally in pairs(allies) do
    if GetObjectName(myHero) ~= GetObjectName(ally) then	
     if IsObjectAlive(ally) then
      local AllyTextPos = WorldToScreen(1, GetOrigin(ally))
      local perc = '%'
      if Sona.Draws.Texts.HPAlly:Value() then DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(ally), GetCurrentHP(ally), GetMaxHP(ally), perc, GetPercentHP(ally), perc),16,AllyTextPos.x,AllyTextPos.y,0xffffffff) end 
      if GetCastLevel(myHero, _W) >= 1 and Sona.Draws.Texts.WAlly:Value() then DrawText(string.format("Heal of W = %d HP", HealWAlly[l]),18,AllyTextPos.x,AllyTextPos.y+20,0xffffffff) end
     end
    end
   end 
   
   if IsObjectAlive(myHero) then
    local Enm = EnemiesAround(myHeroPos(), 4000)
    local Ally = AlliesAround(myHeroPos(), 2500)
    local mytextPos = WorldToScreen(1, myHeroPos())
    if GetCastLevel(myHero, _W) >= 1 and Sona.Draws.Texts.WSmyH:Value() then DrawText(string.format("Heal of W: %d HP | Shield of W: %d Armor", HealWMH, ShieldW),18,mytextPos.x,mytextPos.y,0xffffffff) end
    if Sona.misc.checkteam:Value() and Enm > 0 and Enm > 1+Ally then DrawText("GANKED!!",23,mytextPos.x,mytextPos.y+22,0xffff0000) end
   end
   
   for i, enemy in pairs(GetEnemyHeroes()) do
    if ValidTarget(enemy, 2500) and IsObjectAlive(enemy) then
     if GetCastName(enemy, SUMMONER_1):lower():find("smite") or GetCastName(enemy, SUMMONER_2):lower():find("smite") then
      if Sona.misc.smite:Value() then DrawText("Found enemy have Smite in 2500 range",24,660,150,0xffff2626) end
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

PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Version 0.3 Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
