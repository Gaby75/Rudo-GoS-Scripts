-- Credit: Thank Cloud because help me

require('Dlib')
local version = 1
local UP=Updater.new("anhvu2001ct/Rudo-GoS-Scripts/master/Common/Veigar.lua", "Common\\Veigar", version)
if UP.newVersion() then PrintChat("Rx Veigar is Updated") and UP.update() end
--------------------------------------------------------------
if GetObjectName(GetMyHero()) == "Veigar" then

unit = GetCurrentTarget()
mymouse = GetMousePos() 
myIAC = IAC()
supportedHero = {["Veigar"] = true}
class "Veigar"

--Initializing "Veigar"
function Veigar:__init()
-- To save FPS we make everything with functions! Thus the only onloop is used for Veigar:Loop!
OnLoop(function(myHero) self:Loop(myHero) end)
-- Combo
Config = scriptConfig("Veigar", "Veigar Combo")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
-- Lane Clear
LaneClearConfig = scriptConfig("LClear", "Lane Clear")
LaneClearConfig.addParam("LHQ", "Last Hit Q", SCRIPT_PARAM_ONOFF, true)
LaneClearConfig.addParam("LCW", "Lane Clear W", SCRIPT_PARAM_ONOFF, true)
-- Jungle Clear
JungClearConfig = scriptConfig("JClear", "Jungle Clear")
JungClearConfig.addParam("JCQ", "Jungle Clear Q", SCRIPT_PARAM_ONOFF, true)
JungClearConfig.addParam("JCW", "Jungle Clear W", SCRIPT_PARAM_ONOFF, true)
JungClearConfig.addParam("JCE", "Jungle Clear E", SCRIPT_PARAM_ONOFF, true)
-- Kill Steal
KSConfig = scriptConfig("KillSte", "Kill Steal")
KSConfig.addParam("KSQ", "Use Q KS", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSW", "Use W KS", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Use R KS", SCRIPT_PARAM_ONOFF, true)
-- Misc
MiscConfig = scriptConfig("Misc", "Misc Settings")
MiscConfig.addParam("EI", "Interrupt With E", SCRIPT_PARAM_ONOFF, true)
MiscConfig.addParam("Item", "Use Zhonya", SCRIPT_PARAM_ONOFF, true)
-- Auto Level UP
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("LvlUp","Max Q first then W",SCRIPT_PARAM_ONOFF, true)
-- Drawings
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawDMG", "Draw damage", SCRIPT_PARAM_ONOFF, true)
end

-- End Menu

function Veigar:Loop(myHero)
if _G.IWalkConfig.Combo and Config.Q or Config.W or Config.E or Config.R then 
    local target = GetTarget(1500, DAMAGE_MAGIC)
  if ValidTarget(unit, 1300)  then
self:Combo()
end
end
-- End Combo

if LaneClearConfig.LCW then
  self:LaneClear()
end
-- End LaneClear

if _G.IWalkConfig.LastHit and LaneClearConfig.LHQ then
  self:LastHit()
end
-- End Last Hit

if JungClearConfig.JCQ or JungClearConfig.JCW or JungClearConfig.JCE then
  self:JungleClear()
end
-- End JungleClear

if KSConfig.KSQ or KSConfig.KSW or KSConfig.KSR then
  self:KillSteal()
end
-- End Kill Steal

if MiscConfig.Item then
   self:Misc()
end
-- End Misc

if LevelConfig.LvlUp then
  self:LevelUp()
end
-- End Auto Level Up

if DrawingsConfig.DrawQ or DrawingsConfig.DrawW or DrawingsConfig.DrawE or DrawingsConfig.DrawR then
  self:Drawings()
end
-- End Drawings

if DrawingsConfig.DrawDMG then
  self:Drawing()
end
-- End DrawDMG
end

-- Start Auto Level Up
function Veigar:LevelUp()     
if LevelConfig.LvlUp then
if GetLevel(myHero) == 1 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end
end
end

-- Misc Settings
function Veigar:Misc()
if GetItemSlot(myHero,3157) > 0 and Config.Item and ValidTarget(unit, 1000) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.13 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3157))
        end
end

-- Start Kill Steal
function Veigar:KillSteal()
for i,enemy in pairs(GetEnemyHeroes()) do
     local z = (GetCastLevel(myHero,_R)*60)+20+(GetBonusAP(myHero)*.100)
         local H = (GetCastLevel(myHero,_Q)*50)+10+(GetBonusAP(myHero)*.60)
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2200,200,900,70,false,true)
    if CanUseSpell(myHero, _Q) == READY and WPred.HitChance == 1 and IsInDistance(enemy, 870) and KSConfig.KSQ and ValidTarget(enemy,850)and CalcDamage(myHero, enemy, H) > GetCurrentHP(enemy) then
    CastSkillShot(_Q,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
                    local EPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),0,1390,900,225,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(enemy, 850) and KSConfig.KSR and ValidTarget(enemy,850)and CalcDamage(myHero, enemy, z) > GetCurrentHP(enemy) then
    CastSkillShot(_W,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
end

    if CanUseSpell(myHero,_R) and ValidTarget(enemy, GetCastRange(myHero,_R)) and KSConfig.KSR and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (160*GetCastLevel(myHero,_R) + 20 + 0.8*GetBonusAP(enemy)+GetBaseAP(enemy) + 1*GetBonusAP(myHero))) then
          CastTargetSpell(enemy, _R)
    end
end
end

-- Start Drawings
function Veigar:Drawings()
local HeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_W),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_E),3,100,0xffff00ff) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,GetCastRange(myHero,_R),3,100,0xffff00ff) end 
end

-- Start DrawDMG
function Veigar:Drawing()
  if ValidTarget(unit, 1500) then
trueDMG = 0
targetPos = GetOrigin(unit)
drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
hp = GetCurrentHP(unit)
-- Q
if CanUseSpell(myHero,_Q) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (50*GetCastLevel(myHero,_Q)+10+(0.6*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end
-- W
if CanUseSpell(myHero,_W) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (60*GetCastLevel(myHero,_W)+20+(1*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end
if CanUseSpell(myHero,_R) == READY then 
local trueDMG = trueDMG + CalcDamage(myHero, unit, 0, (160*GetCastLevel(myHero,_W)+20+(0.8*GetBonusAP(unit)+GetBaseAP(unit))+(1*(GetBonusAP(myHero)))))
        DrawDmgOverHpBar(unit,GetCurrentHP(unit),trueDMG,0,0xff00ff00)
end
end
end


-- Start JungleClear
function Veigar:JungleClear()
   if _G.IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 900) then
        local EnemyPos = GetOrigin(Q)
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and JungClearConfig.JCQ and IsInDistance(Q, 900) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY  and JungClearConfig.JCW and IsInDistance(Q, 900) then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
                        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _E) == READY  and JungClearConfig.JCE and IsInDistance(Q, 750) then
            CastSkillShot(_E,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end
end

-- Start LaneClear
function Veigar:LaneClear()
   if _G.IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 900) then
        local EnemyPos = GetOrigin(Q)
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY and LaneClearConfig.LCW and IsInDistance(Q, 900) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end
end

-- Start LastHit
function Veigar:LastHit()
if _G.IWalkConfig.LastHit then
      if LaneClearConfig.LHQ then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 850) then
        local z = (GetCastLevel(myHero,_Q)*80)+10+(GetBonusDmg(myHero)*.6)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)


        if Dmg > hp then
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and Config.LQ and IsInDistance(Q, 900) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end
end
end
end

-- Start Combo
function Veigar:Combo()
  if Config.Q then
  local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),2200,200,900,70,true,false)
  if QPred.HitChance == 1 and GotBuff(unit, "AhriSeduce") == 1 and ValidTarget(unit, 850) then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
end
end
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),0,1390,900,225,false,true)
                          if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 950) and ValidTarget(unit, 900) and WPred.HitChance == 1 then
CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
end
end
                 if Config.E then
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),0,550,700,80,false,true)
                 if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 730) and Config.Co and ValidTarget(unit, 700) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end

      if ValidTarget(unit, 1000) then
            if Config.R and (GetCurrentHP(unit) < CalcDamage(myHero, unit, 0, (160*GetCastLevel(myHero,_R) + 20 + 0.8*GetBonusAP(unit)+GetBaseAP(unit) + 1*GetBonusAP(myHero))))<0.4  then
        CastSpell(_R)

end
end
end
addInterrupterCallback(function(unit, spellType)
  if IsInDistance(unit, 800) and CanUseSpell(myHero,_E) == READY then
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),0,550,GetCastRange(myHero, _E),80,true,true)
 if MiscConfig.EI and EPred.HitChance == 1 and ValidTarget(unit, 650) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)   
end
end
end)


----- End ----
if supportedHero[GetObjectName(myHero)] == true then
if _G[GetObjectName(myHero)] then
  _G[GetObjectName(myHero)]()
end 
end
PrintChat(string.format("<font color='#FF0000'>Rx Scripts </font><font color='#FFFF00'>Veigar by Rudo : </font><font color='#08F7F3'>Loaded Success</font>")) 
end

if GetObjectName(GetMyHero()) ~= "Veigar" then 
PrintChat("Script only Support for Veigar")
end
