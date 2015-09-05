-- Credit: Thank to Zipppy, Cloud Inferno because help me

require('Dlib')
local version = 5
local UP=Updater.new("anhvu2001ct/Rudo-GoS-Scripts/master/Common/Sona.lua", "Common\\Sona", version)
if UP.newVersion() then UP.update() end
----------------------------------------------------------------------

DelayAction(function ()
        for _, imenu in pairs(menuTable) do
                local submenu = menu.addItem(SubMenu.new(imenu.name))
                for _,subImenu in pairs(imenu) do
                        if subImenu.type == SCRIPT_PARAM_ONOFF then
                                local ggeasy = submenu.addItem(MenuBool.new(subImenu.t, subImenu.value))
                                OnLoop(function(myHero) subImenu.value = ggeasy.getValue() end)
                        elseif subImenu.type == SCRIPT_PARAM_KEYDOWN then
                                local ggeasy = submenu.addItem(MenuKeyBind.new(subImenu.t, subImenu.key))
                                OnLoop(function(myHero) subImenu.key = ggeasy.getValue(true) end)
                        elseif subImenu.type == SCRIPT_PARAM_INFO then
                                submenu.addItem(MenuSeparator.new(subImenu.t))
                        end
                end
        end
        _G.DrawMenu = function ( ... )  end
end, 1000)

-- Main Menu --
local root = menu.addItem(SubMenu.new("Rx Sona"))
    
-- Combo Menu --
local Combo = root.addItem(SubMenu.new("Combo"))
	local QCB = Combo.addItem(MenuBool.new("Use Q",true))
	local WCB = Combo.addItem(MenuBool.new("Use W",true))
	local ECB = Combo.addItem(MenuBool.new("Use E",true))
	local RCB = Combo.addItem(MenuBool.new("Use R",true))
	
-- Harass Menu --
local Harass = root.addItem(SubMenu.new("Harass"))
	local QH = Harass.addItem(MenuBool.new("Use Q",true))
    
-- Auto Spell Menu --
local AtSpell = root.addItem(SubMenu.new("Auto Spell"))
	local ASQ = AtSpell.addItem(MenuBool.new("Auto Q",true))
	local ASW = AtSpell.addItem(MenuBool.new("Auto W",true))
	local ASE = AtSpell.addItem(MenuBool.new("Auto E",true))
	local ASMana = AtSpell.addItem(MenuSlider.new("Auto Spell if My %MP >", 10, 0, 50, 5))
    
-- Drawings Menu --
local Drawings = root.addItem(SubMenu("Drawings"))
	local DrawQ = Drawings.addItem(MenuBool.new("Range Q",true))
	local DrawW = Drawings.addItem(MenuBool.new("Range W",true))
	local DrawE = Drawings.addItem(MenuBool.new("Range E",true))
	local DrawR = Drawings.addItem(MenuBool.new("Range R",true))
	
-- Misc Mennu --
local Misc = root.addItem(SubMenu("Misc"))
   local KS = Misc.addItem(SubMenu("Kill Steal"))
	local QKS = KS.addItem(MenuBool.new("KS with Q",true))
	local RKS = KS.addItem(MenuBool.new("KS with Q",true))
   local AntiSkill = Misc.addItem(SubMenu("Stop Skill Enemy"))
    local RAnti = AntiSkill.addItem(MenuBool.new("R Stop Skill Enemy",true))
   local AutoLvlUp = Misc.addItem(SubMenu("Auto Level Up"))
    local AutoSkillUpQ = AutoLvlUp.addItem(MenuBool.new("AutoLvlUp Q", true))
    local AutoSkillUpW = AutoLvlUp.addItem(MenuBool.new("AutoLvlUp W", true))

-- End Menu --
local info = "Rx Sona Loaded."
local upv = "Upvote if you like it!"
local sig = "Made by Rudo"
local ver = "Version: 0.5"
textTable = {info,upv,sig,ver}
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])
PrintChat(textTable[4])
-- End Print --

	
myIAC = IAC()

CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Ezreal"]                      = {_R},
    ["Katarina"]                    = {_R},
    ["Kennen"]                      = {_R},
    ["FiddleSticks"]                = {_R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Xerath"]                      = {_R},
    ["Rengar"]                      = {_R},
    ["Riven"]                       = {_R},
    ["Shen"]                        = {_R},
    ["Twisted Fate"]                = {_R},
	["Tahm Kench"]                  = {_R},
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
local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2400,250,1000,150,false,true)
  if IsInDistance(target, 1000) and CanUseSpell(myHero,_R) == READY and RAnti.getValue() and spellType == CHANELLING_SPELLS then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

OnLoop(function(myHero)
    if IWalkConfig.Combo then
	local target = GetCurrentTarget()
		
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 845) and QCB.getValue() then
		CastSpell(_Q)
        end
					
		if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 840) and WCB.getValue() then
		CastSpell(_W)
		end
				
		if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 1000) and ECB.getValue() then
		CastSpell(_E)
		end
		
		if CanUseSpell(myHero, _R) == READY and ValidTarget(target, 900) and RCB.getValue() then
		CastSpell(_R)
        end
					
	end
	
	if IWalkConfig.Harass then 
	local target = GetCurrentTarget()
		
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 845) and QH.getValue() then
		CastSpell(_Q)
        end	
	end
	
for i,enemy in pairs(GetEnemyHeroes()) do
		
	  local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
	if CanUseSpell(myHero, _Q) and ValidTarget(enemy, 845) and QKS.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.5*GetBonusAP(myHero) + ExtraDmg) then
		CastSpell(_Q)
	elseif CanUseSpell(myHero, _R) and ValidTarget(enemy, 960) and RKS.getValue() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 20 + 110*GetCastLevel(myHero,_R) + 0.5*GetBonusAP(myHero) + ExtraDmg) then
        CastSpell(_R)
	end
end
	
  if AutoSkillUpQ.getValue() then  
local leveltable = { _Q, _W, _E, _Q, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W, _E, _E, _R, _E, _E} -- <<< Max Q first - Thank Inferno for this code
LevelSpell(leveltable[GetLevel(myHero)]) 
  end
  if AutoSkillUpW.getValue() then  
local leveltable = { _W, _Q, _E, _W, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- <<< Max W first - Thank Inferno
LevelSpell(leveltable[GetLevel(myHero)]) 
  end

local HeroPos = GetOrigin(myHero)
if DrawQ.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,880,3,100,0xff00ff00) end
if DrawW.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,550,3,100,0xff00ff00) end
if DrawE.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,975,3,100,0xff00ff00) end
if DrawR.getValue() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,550,3,100,0xff00ff00) end

    if (GetCurrentMana(myHero)/GetMaxMana(myHero)) > ASMana.getValue() then 
              for i,enemy in pairs(GetEnemyHeroes()) do				  
	local target = GetCurrentTarget()
      if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 845) and ASQ.getValue() then
	  CastSpell(_Q)
 end
 end
 end
 if CanUseSpell(myHero, _W) == READY and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.55 and ASW.getValue then
    CastSpell(_W)
 end
 if CanUseSpell(myHero, _E) == READY and (GetMoveSpeed(myHero))<0.6 and ASE.getValue then
    CastSpell(_E)
 end
    end)

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
    if (CanUseSpell(myHero, _W) == READY) and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > ASMana.getValue() then
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

function GetDrawText(enemy)
	local ExtraDmg = 0
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
	end
	
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end
	
	if CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 20 + 110*GetCastLevel(myHero,_R) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'R = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.50*GetBonusAP(myHero) + 20 + 110*GetCastLevel(myHero,_R) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + R = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.50*GetBonusAP(myHero) + 20 + 110*GetCastLevel(myHero,_R) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + R + Ignite = Kill!', ARGB(255, 200, 160, 0)
	else
		return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end
