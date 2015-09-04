-- Credit: Thank to Zipppy, Cloud and Inferno to heal code

require('Dlib')
local version = 3
local UP=Updater.new("anhvu2001ct/Rudo-GoS-Scripts/master/Common/Sona.lua", "Common\\Sona", version)
if UP.newVersion() then PrintChat("Rx Sona is Updated") and UP.update() end

if GetObjectName(GetMyHero()) == "Sona" then
-- Combo
Config = scriptConfig("Sona", "Combo Sona")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
-- Harass Enemy
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
-- Auto Q
QConfig = scriptConfig("AutoSpell", "Auto Spell")
QConfig.addParam("AutoQ", "Enable AutoQ", SCRIPT_PARAM_ONOFF, true)
QConfig.addParam("AutoW", "Enable AutoW", SCRIPT_PARAM_ONOFF, true)
QConfig.addParam("AutoE", "Enable AutoE", SCRIPT_PARAM_ONOFF, true)
-- Kill Steal
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, false)
-- Range Draw
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
-- Damage Draw
DrawConfig = scriptConfig("DrawDMG", "Damage Draw")
DrawConfig.addParam("Q", "Draw Q Dmg", SCRIPT_PARAM_ONOFF, true)
DrawConfig.addParam("R", "Draw R Dmg", SCRIPT_PARAM_ONOFF, true)
-- Auto Level UP
AutoLvlUp = scriptConfig("AutoLevel", "Auto Level Up")
AutoLvlUp.addParam("EnableQ", "Enable Auto LvlUp Q", SCRIPT_PARAM_ONOFF, false)
AutoLvlUp.addParam("EnableW", "Enable Auto LvlUp W", SCRIPT_PARAM_ONOFF, false)
-- Print
local info = "Rx Sona Loaded."
local upv = "Upvote if you like it!"
local sig = "Made by Rudo"
local ver = "Version: 0.3"
textTable = {info,upv,sig,ver}
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])
PrintChat(textTable[4])

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()
DrawDMG()
AutoLevel()
AutoSpell()

local unit = GetCurrentTarget()
        if IWalkConfig.Combo then
              local target = GetTarget(1100, DAMAGE_MAGIC)
                if ValidTarget(target, 845) then
                       
					    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, GetCastRange(myHero,_Q)) and Config.Q then
                        CastSpell(_Q)
						end
                        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, GetCastRange(myHero,_W)) and Config.W then
						CastSpell(_W)
						end
						if CanUseSpell(myHero, _E) == READY and ValidTarget(target, GetCastRange(myHero,_E)) and Config.E then
                        CastSpell(_E)
						end
						local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2400,300,1000,150,false,false)
                        if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_R)) and Config.R then
                        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
						end
                end
        end
end)

OnLoop(function(myHero)

        if IWalkConfig.Harass then
              for i,enemy in pairs(GetEnemyHeroes()) do  
              local target = GetTarget(840, DAMAGE_MAGIC)
                if ValidTarget(target, 840) then
					    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, GetCastRange(myHero,_Q)) and Config.Q then
                        CastSpell(_Q)

				end	

	        end
	end		
end
end)

 function Killsteal()  
              for i,enemy in pairs(GetEnemyHeroes()) do  
			  if ValidTarget(target, 845) then
 if CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (49*GetCastLevel(myHero,_Q) + 5 + 0.5*GetBonusAP(myHero))) then
 CastSpell(_Q)
end 
              end
 			  if ValidTarget(target, 945) then
 if CanUseSpell(myHero,_R) == READY and ValidTarget(enemy, GetCastRange(myHero,_R)) and KSConfig.KSR and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (110*GetCastLevel(myHero,_R) + 20 + 0.5*GetBonusAP(myHero))) then
 CastSpell(_R)
 end
              end
 end
 end
 
  function AutoSpell()
    if (GetCurrentMana(myHero)/GetMaxMana(myHero))>0.1 then
              for i,enemy in pairs(GetEnemyHeroes()) do				  
              local target = GetTarget(840, DAMAGE_MAGIC)
                if ValidTarget(target, 840) then
 if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, GetCastRange(myHero,_Q)) and QConfig.AutoQ then
 CastSpell(_Q)
 end
 end
 end
 if CanUseSpell(myHero, _W) == READY and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.55 and QConfig.AutoW then
    CastSpell(_W)
 end
 if CanUseSpell(myHero, _E) == READY and (GetMoveSpeed(myHero))<0.6 and QConfig.AutoE then
    CastSpell(_E)
 end
    end
 end
 
 function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xff00ff00) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end

 function DrawDMG()
local unit = GetCurrentTarget()
if ValidTarget(unit, 1150) then
local Qdmg = CalcDamage(myHero, unit, 0, (49*GetCastLevel(myHero,_Q) + 5 + 0.5*GetBonusAP(myHero)))
	if CanUseSpell(myHero,_Q) == READY and DrawConfig.Q then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),Qdmg,0,0xff00ff00)
	end

local Rdmg = CalcDamage(myHero, unit, 0,  (110*GetCastLevel(myHero,_R) + 20 + 0.5*GetBonusAP(myHero)))
	if CanUseSpell(myHero,_R) == READY and DrawConfig.R then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit),Rdmg,0,0xff00f000)	
	end
end
end

function AutoLevel()    
 if    AutoLvlUp.EnableQ
 and GetLevel(myHero) >= 1  and GetLevel(myHero) < 2 then
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
 if    AutoLvlUp.EnableW
 and GetLevel(myHero) >= 1  and GetLevel(myHero) < 2 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
	LevelSpell(_Q)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
	LevelSpell(_E)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
	LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
	LevelSpell(_W)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_Q)
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

require 'deLibrary'

------------------------------------------------------------------------------------------------------------------
-- You can change everything below this line
------------------------------------------------------------------------------------------------------------------

-- Assigned buttons
local Button = {
Show_Help =                                 Keys.F1,
Draw_HUD =                                  Keys.F4,
AutoHeal =                                  Keys.F2,
DrawHealCircles =                           Keys.F3,
SwitchNaviSystem =                          Keys.F5,
}

-- Settings for control champion features
-- Peace/Battle Form
local FormControl = {
RangeToChange =             1250,
BattleMinimumHoldTime =     3000,
BattleRandomHoldTime =      2000,
}
-- W AutoHeal
local AutoHealControl = {
OurHealthCap =      20,
InPeaceMode =       50,
InBattleMode =      80,
--Untested next
UseNaviSystem =     false,
MaxDistForNavi =    1100,
DoCheckDistNavi =   false,
}

-- Configurable delays (If your fps don't drop, can lower this values.)
local UpdateBattleMode_RepeatTimer = 120
local DoLoop_RepeatTimer = 20

------------------------------------------------------------------------------------------------------------------
-- You can change everything above this line
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Inside Function Control -- STARTED
------------------------------------------------------------------------------------------------------------------

-- Button Toggles/Settings
local Setting = {
Show_Help =                                         true,
Draw_HUD =                                          true,
AutoHeal =                                          true,
DrawHealCircles =                                   true,
}

-- Switches
local Switch = {
BattleMode = false,
}

local ButtonFunction = {
Show_Help =                                         function() Setting.Show_Help        = not Setting.Show_Help         end,
Draw_HUD =                                          function() Setting.Draw_HUD         = not Setting.Draw_HUD          end,
AutoHeal =                                          function() Setting.AutoHeal         = not Setting.AutoHeal          end,
DrawHealCircles =                                   function() Setting.DrawHealCircles  = not Setting.DrawHealCircles   end,
SwitchNaviSystem =                                  function() AutoHealControl.UseNaviSystem  = not AutoHealControl.UseNaviSystem   end,
}

------------------------------------------------------------------------------------------------------------------
-- Inside Function Control -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Key Control -- STARTED
------------------------------------------------------------------------------------------------------------------

local KPC = attachKeyPressor()
KPC.AddEventSingle(Button.Show_Help,            ButtonFunction.Show_Help)
KPC.AddEventSingle(Button.Draw_HUD,             ButtonFunction.Draw_HUD)
KPC.AddEventSingle(Button.AutoHeal,             ButtonFunction.AutoHeal)
KPC.AddEventSingle(Button.DrawHealCircles,      ButtonFunction.DrawHealCircles)
if AutoHealControl.UseNaviSystem then KPC.AddEventSingle(Button.SwitchNaviSystem,     ButtonFunction.SwitchNaviSystem) end

------------------------------------------------------------------------------------------------------------------
-- Key Control -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Drawings (Every plugin) -- STARTED
------------------------------------------------------------------------------------------------------------------

-- Help Window
function Draw_Help()
    local borders = 2
    local offset = {x = 10+borders, y = 10+borders}
    local size = {x = 210+borders*2, y = 70+borders*2}
    
    -- Borders/Background
    FillRect(offset.x-borders,offset.y-borders,size.x,size.y,TColors.Black(0xA0))
    -- Top text
    DrawTextSmall("SONA HELPER",                          60+offset.x,    0+offset.y, Colors.Lime)
    DrawTextSmall("BY INFERNO",                             108+offset.x,   7+offset.y, Colors.Red)
    -- Mid text
    DrawTextSmall("KEYS TO OPERATE SCRIPT:",                6+offset.x,     21+offset.y, Colors.White)
    DrawTextSmall("F1: SHOW/HIDE THIS WINDOW",              12+offset.x,    28+offset.y, Colors.White)
    DrawTextSmall("F2: TOGGLE AUTOHEAL ON/OFF",             12+offset.x,    35+offset.y, Colors.White)
    DrawTextSmall("F3: TOGGLE AUTOHEAL HELPER ON/OFF",      12+offset.x,    42+offset.y, Colors.White)
    DrawTextSmall("F4: TOGGLE HUD ON/OFF",                  12+offset.x,    49+offset.y, Colors.White)
    -- Postfix
    DrawTextSmall("HEAL YOUR ELO!",                         126+offset.x,   63+offset.y, Colors.Yellow)
end

function Draw_HUD()
    DrawTextSmall("Autoheal: "..(Setting.AutoHeal and "On" or "Off"), 396, 942, Setting.AutoHeal and Colors.Lime or Colors.Red)
    if AutoHealControl.UseNaviSystem then
        DrawTextSmall("N.A.V.I", 396, 935, Colors.Green)
    end
end

------------------------------------------------------------------------------------------------------------------
-- Drawings (Every plugin) -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Drawings (This plugin) -- STARTED
------------------------------------------------------------------------------------------------------------------
local function GetHealPotential(target, percent)
    local hp = GetPercentHP(target)
    local dist = GetDistance(target)
    if hp >= percent or hp == 0 or dist >= AutoHealControl.MaxDistForNavi then
        return 0
    else
        return 1 / ((AutoHealControl.MaxDistForNavi - dist) / (percent - hp))
    end
end

local function getCircleColor(target, percent, colorfrom, colorto)
    local StartR, StartG, StartB = colorfrom[1], colorfrom[2], colorfrom[3]
    local EndR, EndG, EndB = colorto[1], colorto[2], colorto[3]
    local Multiplier = GetPercentHP(target) / percent -- It should be Percent - 0 / HealHP - 0, but since it is 0...
    
    -- Protection from stupidity
    Multiplier = Multiplier > 1 and 1 or Multiplier
    Multiplier = Multiplier < 0 and 0 or Multiplier
    -- Done

    local ResR, ResG, ResB = Multiplier * (StartR - EndR) + EndR, Multiplier * (StartG - EndG) + EndG, Multiplier * (StartB - EndB) + EndB
    return ARGB(0xFF, ResR, ResG, ResB)
end

function doDrawHealCircles(potential)
    local DrawPercent = AutoHealControl.InBattleMode
    local AllyList = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, 2500, false) and GetPercentHP(a) < DrawPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetPercentHP(a) < GetPercentHP(b) end)
    -- This is valid function that will return table of allies that is sorted by health.
    -- Because AllyHeroes don't check for 'alive/dead' and so on, we checking everyting inside function.
    if (AllyList == nil) then return end

    local cStart =  Switch.BattleMode and {0,255,0} or {0,128,0}
    local cEnd =    Switch.BattleMode and {255,0,0} or {128,0,0}
    
    for i=1, #AllyList do
        DrawCircle(GetOrigin(AllyList[i]), 1000, 2, 0, getCircleColor(AllyList[i], DrawPercent, cStart, cEnd))
    end
    
    if potential then
        local PrimaryTarget = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, AutoHealControl.MaxDistForNavi, false) and GetPercentHP(a) < DrawPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetHealPotential(a, DrawPercent) > GetHealPotential(b, DrawPercent) end)
        if PrimaryTarget ~= nil then
            DrawCircle(GetOrigin(PrimaryTarget[1]), 125, 5, 0, getCircleColor(PrimaryTarget[1], DrawPercent, cStart, cEnd))
        end
    end
end
------------------------------------------------------------------------------------------------------------------
-- Drawings (This plugin) -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Functions and Actions (This plugin) -- STARTED
------------------------------------------------------------------------------------------------------------------
local function CastW(target, checkDist)
    if (checkDist and GetDistance(target) > 1000) then return end
    if (CanUseSpell(myHero, _W) == READY) then
        CastTargetSpell(target, _W)
    end
end

function doAutoHeal(potential)
    -- Don't cast W if we hurted badly.
    if GetPercentHP(myHero) <= AutoHealControl.OurHealthCap then return end

    -- Set HealPercent depending on current mode
    local HealPercent = Switch.BattleMode and AutoHealControl.InBattleMode or AutoHealControl.InPeaceMode

    local AllyList
    if not potential then
    AllyList = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, 1000, false) and GetPercentHP(a) < HealPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetPercentHP(a) < GetPercentHP(b) end)
    else
    AllyList = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, AutoHealControl.MaxDistForNavi, false) and GetPercentHP(a) < HealPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetHealPotential(a, HealPercent) > GetHealPotential(b, HealPercent) end)
    end
    -- This is valid function that will return table of allies that is sorted by health.
    -- Because AllyHeroes don't check for 'alive/dead' and so on, we checking everyting inside function.
    if (AllyList == nil) then return end
    
    if not potential then
        for i=1, #AllyList do
            CastW(AllyList[i])
        end
    else
        CastW(AllyList[1], AutoHealControl.DoCheckDistNavi)
    end
end

local UpdateBattleMode_NextUpdate = 0
local UpdateBattleMode_LastBattle = 0
function UpdateBattleMode()
    -- FPS Protection Part
    local cTick = GetTickCount()
    if cTick < UpdateBattleMode_NextUpdate then return end
    UpdateBattleMode_NextUpdate = cTick + UpdateBattleMode_RepeatTimer
    -- All code below will be delayed
    
    if (HeroManager.EnemyHeroes(function(a) return IsValidTarget(a, FormControl.RangeToChange) end) ~= nil) then
        UpdateBattleMode_LastBattle = cTick + math.random(FormControl.BattleMinimumHoldTime,FormControl.BattleMinimumHoldTime+FormControl.BattleRandomHoldTime)
    end
    Switch.BattleMode = cTick < UpdateBattleMode_LastBattle
end
------------------------------------------------------------------------------------------------------------------
-- Functions and Actions (This plugin) -- ENDED
------------------------------------------------------------------------------------------------------------------

local DoLoop_NextCheckTime = 0
function DoLoop()
    -- Drawings
        if Setting.Show_Help            then Draw_Help()                end
        if Setting.DrawHealCircles      then doDrawHealCircles(AutoHealControl.UseNaviSystem) end
        if Setting.Draw_HUD             then Draw_HUD()                 end
    -- End drawings

    -- FPS Protection Part
        local cTick = GetTickCount()
        if cTick < DoLoop_NextCheckTime then return end
        DoLoop_NextCheckTime = cTick + DoLoop_RepeatTimer
    -- All code below will be delayed.

    -- Actual action code
        UpdateBattleMode()
        if not IsDead(myHero) and not IsRecalling(myHero) then --If Hero is ready
            if Setting.AutoHeal         then doAutoHeal(AutoHealControl.UseNaviSystem) end
        end
    -- End of script
end
OnLoop(function(arg) DoLoop() end)

PrintChat(string.format("<font color='#FF0000'>Rx Scripts </font><font color='#FFFF00'>Sona by Rudo : </font><font color='#08F7F3'>Loaded Success</font>")) 

end

if GetObjectName(GetMyHero()) ~="Sona" then
PrintChat("Script only Support for Sona")
end

