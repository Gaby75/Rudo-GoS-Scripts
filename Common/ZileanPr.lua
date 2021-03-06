--[[ Rx Zilean Version 0.571 by Rudo.
     Ver 0.571: Edit somethings
     Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------]]
if GetObjectName(GetMyHero()) ~= "Zilean" then return end

require('Inspired')
---- Script Update ----
local WebLuaFile = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/Zilean.lua"
local WebVersion = "/anhvu2001ct/Rudo-GoS-Scripts/master/Common/Zilean.version"
local ScriptName = "Zilean.lua"
local ScriptVersion = 0.571 -- Newest Version
local CheckWebVer = require("GOSUtility").request("https://raw.githubusercontent.com",WebVersion.."?no-cache="..(math.random(100000))) -- Copy from Inspired >3
if ScriptVersion < tonumber(CheckWebVer) then
PrintChat(string.format("<font color='#00B359'>Script need update.</font><font color='#FF2626'> Waiting to AutoUpdate.</font>")) 
AutoUpdate(WebLuaFile,WebVersion,ScriptName,ScriptVersion)
else
PrintChat(string.format("<font color='#FFFF26'>You are using newest Version. Don't need to update</font>")) 
end
PrintChat(string.format("<font color='#C926FF'>Script Current Version:</font><font color='#FF8000'> %s </font>| <font color='#C926FF'>Newest Version:</font><font color='#FF8000'> %s </font>", ScriptVersion, tonumber(CheckWebVer))) 

PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))

----------------------------------------
require('IPrediction')
local QPred = { name = "ZileanQ", speed = math.huge, delay = 0.5, range = 900, width = 100, collision = false, aoe = true, type = "circular"}
QPrediction = IPrediction.Prediction(QPred)

-----------------------
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

---------- Create a Menu ----------
Zilean = MenuConfig("Rx Zilean", "Zilean")
tslowhp = TargetSelector(900, TARGET_MOST_AD, DAMAGE_MAGIC)
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
Zilean.hr:Slider("HrMana", "Harass if %MP >= ", 10, 1, 100, 1)
Zilean.hr:Boolean("HrQ", "Use Q", true)

---- Lane Clear Menu ----
Zilean:Menu("lc", "Lane Clear")
Zilean.lc:Slider("checkMP", "Lane Clear if %MP >= ", 15, 1, 100, 1)
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
Zilean.Draws:Boolean("DrawQR", "Range Q + R", true)
Zilean.Draws:ColorPick("QRcol", "Setting Q + R Color", {255, 244, 245, 120})
Zilean.Draws:Boolean("DrawE", "Range E", true)
Zilean.Draws:ColorPick("Ecol", "Setting E Color", {255, 155, 48, 255})
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

--------------------------------------------Starting Funciton--------------------------------------------------
OnTick(function(myHero)
local target = tslowhp:GetTarget()
 --[[ <-- COMBO --> ]]--
 if IOW:Mode() == "Combo" then
  if target and IsReady(_Q) and Zilean.cb.QCB:Value() and ValidTarget(target, 900) and IsObjectAlive(target) then
  local hitchance, pos = QPrediction:Predict(target)
   if hitchance > 2 then
    CastSkillShot(_Q, pos)
   end
  end

  if target and IsReady(_W) and Zilean.cb.WCB:Value() and GetCurrentMana(myHero) >= 110 + 5*GetCastLevel(myHero, _Q) and not IsReady(_Q) then
   if ValidTarget(target, 900) and IsObjectAlive(target) then
    CastSpell(_W)
   end
  end

  if IsReady(_E) and Zilean.cb.ECB:Value() then
  local unit = GetCurrentTarget()
   for i, enemy in pairs(GetEnemyHeroes()) do
    if IsInDistance(enemy, 1300) then 
     for l, ally in pairs(GetAllyHeroes()) do
     local Al = AlliesAround(myHeroPos(), GetCastRange(myHero, _E))
     local Enm = EnemiesAround(myHeroPos(), GetCastRange(myHero, _E))
      if target and Al >= 1 and 1 + Al >= Enm and GotBuff(target, "Stun") <= 0 then
       CastTargetSpell(target, _E)
      elseif Al >= 1 and Al < Enm then
       if ally ~= myHero then
        if IsInDistance(ally, GetCastRange(myHero, _E)) then
         if GetDistance(ClosestAlly(GetMousePos()), GetMousePos()) <= 160 and CheckE(ClosestAlly(GetMousePos())) then
          CastTargetSpell(ClosestAlly(GetMousePos()), _E)
         elseif GetDistance(myHeroPos(), GetMousePos()) <= 160 and GetDistance(ClosestAlly(GetMousePos()), GetMousePos()) > 160 and CheckE(myHero) then
          CastTargetSpell(myHero, _E)
         end
        end
       end
      elseif Al <= 0 and IsInDistance(unit, 1300) and CheckE(myHero) and not IsInDistance(unit, 880) then
       CastTargetSpell(myHero, _E)
      end
     end
    end
   end
  end
 end

 --[[ <-- HARASS --> ]]--
 if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= Zilean.hr.HrMana:Value() then
  if target and IsReady(_Q) and Zilean.hr.HrQ:Value() and ValidTarget(target, 900) and IsObjectAlive(target) then
  local hitchance, pos = QPrediction:Predict(target)
   if hitchance > 2 then
    CastSkillShot(_Q, pos)
   end
  end
 end
 
 --[[ <-- KILL STEAL --> ]]--
 if Zilean.KS.KSEb:Value() then
  for i, enemy in pairs(GetEnemyHeroes()) do
   if Ignite and Zilean.KS.IgniteKS:Value() then
    if IsReady(Ignite) and 20*GetLevel(myHero)+50 >= GetHP(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
     local DmgCheck = 0
      if CheckQ(enemy) and getdmg("Q",enemy) >= GetHP2(enemy) then
       DmgCheck = DmgCheck + getdmg("Q",enemy)
      elseif CheckQ(enemy) and getdmg("Q",enemy) < GetHP2(enemy) then
       DmgCheck = DmgCheck + 0
      elseif getdmg("Q",enemy) >= GetHP2(enemy) and not CheckQ(enemy) then
       DmgCheck = DmgCheck + 0
      elseif getdmg("Q",enemy) < GetHP2(enemy) and not CheckQ(enemy) then
       DmgCheck = DmgCheck + 0
      end
	   if DmgCheck < GetHP2(enemy) then CastTargetSpell(enemy, Ignite) end
    end
   end

   if IsReady(_Q) and Zilean.KS.QKS:Value() and GetHP2(enemy) <= getdmg("Q",enemy) and ValidTarget(enemy, 900) and IsObjectAlive(enemy) then
    local hitchance, pos = QPrediction:Predict(enemy)
    if hitchance > 2 then
     CastSkillShot(_Q, pos)
    end
    if IsReady(_W) and GetCurrentMana(myHero) >= 110 + 5*GetCastLevel(myHero, _Q) and not IsReady(_Q) then
     CastSpell(_W)
    end
   end
  end
 end

 --[[ <-- LANE CLEAR --> ]]-- 
 if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Zilean.lc.checkMP:Value() then
  if IsReady(_Q) and Zilean.lc.LcQ:Value() then
   for _, minion in pairs(minionManager.objects) do
    if GetTeam(minion) == MINION_ENEMY then
     if IsInDistance(minion, 900) then
      local BestPos, BestHit = GetFarmPosition(900, 300)
      if BestPos and BestHit > 0 then
       CastSkillShot(_Q, BestPos)
      end
     end
    end
   end
  end
 end

 --[[ <-- JUNGLE CLEAR --> ]]--
 if IOW:Mode() == "LaneClear" then
  if IsReady(_Q) and Zilean.jc.JcQ:Value() then
   for _, mobs in pairs(minionManager.objects) do
    if GetTeam(mobs) == MINION_JUNGLE then
     if IsInDistance(mobs, 900) then
      local BestPos, BestHit = GetJFarmPosition(900, 300)
      if BestPos and BestHit > 0 then
       CastSkillShot(_Q, BestPos)
      end
     end
    end
   end
  end
 end

 --[[ <-- AUTO SPELL --> ]]--
 if Zilean.AtSpell.ASEb:Value() then
  for i, enemy in pairs(GetEnemyHeroes()) do
   if IsReady(_Q) and GetPercentMP(myHero) >= Zilean.AtSpell.ASMP:Value() and Zilean.AtSpell.ATSQ.ASQ:Value() and GotBuff(myHero, "recall") <= 0 and ValidTarget(enemy, 900) and CheckQ(enemy) then
   local hitchance, pos = QPrediction:Predict(enemy)
    if hitchance > 2 then
    CastSkillShot(_Q, pos)
    end
   end
  end
  if IsReady(_E) and GetPercentMP(myHero) >= Zilean.AtSpell.ASMP:Value() and Zilean.AtSpell.ATSE.ASE:Value() and Zilean.AtSpell.ATSE.KeyE:Value() and GotBuff(myHero, "recall") <= 0 and CheckE(myHero) then CastTargetSpell(myHero, _E) end
  if Zilean.AtSpell.ATSE.KeyE:Value() then MoveToXYZ(GetMousePos()) end
 end

 --[[ <-- AUTO LvlUP --> ]]-- 
 if Zilean.AutoLvlUp.UpSpellEb:Value() then
  if Zilean.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First then W
  elseif Zilean.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q First then E
  end
   LevelSpell(leveltable[GetLevel(myHero)])
 end
end) -- End OnTick

------------- << Drawings >> -------------
OnDraw(function(myHero)
 if Zilean.Draws.DrawsEb:Value() then
 
 --[[ <-- SKILL RANGE --> ]]-- 
  if IsReady(_Q) or IsReady(_R) then
   if Zilean.Draws.DrawQR:Value() then DrawCircle(myHeroPos(),GetCastRange(myHero,_Q),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.QRcol:Value()) end
  end
  if Zilean.Draws.DrawE:Value() and IsReady(_E) then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),1,Zilean.Draws.QualiDraw:Value(),Zilean.Draws.Ecol:Value()) end

 --[[ <-- DRAW TESTS --> ]]--  
  if Zilean.Draws.DrawText:Value() then
  
  ---- Draw HP ----
   for i, enemy in pairs(GetEnemyHeroes()) do
    for l, myally in pairs(GetAllyHeroes()) do
     if GetObjectName(myHero) ~= GetObjectName(myally) then	
      if IsObjectAlive(myally) then
       local alliesPos = WorldToScreen(1,GetOrigin(myally))
       local maxhpA = GetMaxHP(myally)
       local currhpA = GetCurrentHP(myally)
       local percentA = 100*currhpA/maxhpA
       local per = '%'
	   local minhp = math.max(1,percentA)
        if GetLevel(myHero) >= 6 then
         if percentA > 20 then
          DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(myally), currhpA, maxhpA, per, minhp, per),18,alliesPos.x,alliesPos.y,0xffffffff)
         else
          DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", GetObjectName(myally), currhpA, maxhpA, per, minhp, per),21,alliesPos.x,alliesPos.y,0xffff0000)
         end
         if GotBuff(myally, "karthusfallenonetarget") >= 1 and (GetCastLevel(myHero, _R)*150 + 100 + 0.60*BonusAP) >= GetHP2(myally) then
          DrawText("This Unit can die with Karthus R",22,alliesPos.x,alliesPos.y+12,0xffff0000)
         end
        end
      end
     end	
    end

   local myTextPos = WorldToScreen(1,myHeroPos())
   local pmh = '%'
   local miniumhp = math.max(1,GetPercentHP(myHero))
    if IsObjectAlive(myHero) then
     if GetPercentHP(myHero) <= 20 and GetLevel(myHero) >= 6 then
      DrawText(string.format("%sHP = %d%s CAREFUL!", pmh, miniumhp, pmh),21,myTextPos.x,myTextPos.y,0xffff0000)
     end
     if GotBuff(myHero, "karthusfallenonetarget") >= 1 and (GetCastLevel(myHero, _R)*150 + 100 + 0.60*BonusAP) >= GetHP2(myHero) then
      DrawText("Karthus R can 'KILL!' You",22,myTextPos.x,myTextPos.y+12,0xffff0000)
     end
    end
	
  ---- R Info ----
	drawtexts = ""
    for nID, ally in pairs(GetAllyHeroes()) do
     if IsObjectAlive(ally) then
      if GetObjectName(myHero) ~= GetObjectName(ally) then
       if IsReady(_R) and IsInDistance(ally, 2500) then
        if GetPercentHP(ally) <= 20 then
         drawtexts = drawtexts..GetObjectName(ally)
         drawtexts = drawtexts.." %HP < 20%. Should Use R\n"
        end
         DrawText(drawtexts,27,0,110,0xff00ff00) 
       end
      end
     end
    end
   end
   
   for i, enemy in pairs(GetEnemyHeroes()) do
    if ValidTarget(enemy) then
     local Check = GetMagicShield(enemy)+GetDmgShield(enemy)
     if IsReady(_Q) or CheckQ(enemy) then
      DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),0,getdmg("Q",enemy) - Check,0xffffffff)
     else
      DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero) - Check,0,0xffffffff)
     end
    end
   end
  end
 end
end)
----------------------- << Interrupt >> ----------------------- 
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
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and GetCurrentMana(myHero) >= 165 + 5*GetCastLevel(myHero, _Q) then
     if IsReady(_Q) or CheckQ(unit) then
      if IsReady(_W) or CheckQ(unit) then
       if ANTI_SPELLS[spell.name] then
        if ValidTarget(unit, GetCastRange(myHero,_Q)) and GetObjectName(unit) == ANTI_SPELLS[spell.name].Name and InterruptMenu[GetObjectName(unit).."Inter"]:Value() then 
        local hitchance, pos = QPrediction:Predict(unit)
         if hitchance > 2 then
         CastSkillShot(_Q, pos)
          if IsReady(_W) and not IsReady(_Q) then
          CastSpell(_W)
          end
         end
        end
       end
      end
     end
    end
end)
--------------------------------------------------------------------------
function CheckE(who)
  return GotBuff(who, "TimeWarp") <= 0
end

function CheckQ(who)
  return GotBuff(who, "zileanqenemybomb") >= 1
end

PrintChat(string.format("<font color='#FF0000'>Rx Zilean by Rudo </font><font color='#FFFF00'>Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
