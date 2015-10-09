-- ---------------------------------------------------------
--  .d8b.  db      d888888b  .d8b.  .d8888. d88888b .d8888. 
-- d8' `8b 88        `88'   d8' `8b 88'  YP 88'     88'  YP 
-- 88ooo88 88         88    88ooo88 `8bo.   88ooooo `8bo.   
-- 88~~~88 88         88    88~~~88   `Y8b. 88~~~~~   `Y8b. 
-- 88   88 88booo.   .88.   88   88 db   8D 88.     db   8D 
-- YP   YP Y88888P Y888888P YP   YP `8888Y' Y88888P `8888Y' 
-- ---------------------------------------------------------
GetCurrentMP = GetCurrentMana
GetMaxMP = GetMaxMana
GetAD = GetBaseDamage
GetBAD = GetBonusDmg
GetAP = GetBonusAP 

-- Part of improving the speed of functions/finalizing some of them
local mathfloor = math.floor
local pairs = pairs
local GetCurrentHP = GetCurrentHP
local GetMaxHP = GetMaxHP
local GetCurrentMana = GetCurrentMana
local GetMaxMana = GetMaxMana
local GetBaseDamage = GetBaseDamage
local GetBonusDmg = GetBonusDmg
local GetBonusAP = GetBonusAP
local GotBuff = GotBuff
local GetNetworkID = GetNetworkID
local GetTeam = GetTeam
local GetOrigin = GetOrigin
local IsDead = IsDead
local IsVisible = IsVisible
local IsTargetable = IsTargetable
local IsImmune = IsImmune
local GetCritChance = GetCritChance
local GetItemSlot = GetItemSlot
local GetArmor = GetArmor
local GetArmorPenPercent = GetArmorPenPercent
local GetArmorPenFlat = GetArmorPenFlat
local GetMagicResist = GetMagicResist
local GetMagicPenPercent = GetMagicPenPercent
local GetMagicPenFlat = GetMagicPenFlat
local CastSkillShot = CastSkillShot
local CastTargetSpell = CastTargetSpell
local CastSpell = CastSpell
local CanUseSpell = CanUseSpell
local GetTickCount = GetTickCount

-- -----------------------------------------------------------------------------
--  .o88b.  .d88b.  d8b   db .d8888. d888888b  .d8b.  d8b   db d888888b .d8888. 
-- d8P  Y8 .8P  Y8. 888o  88 88'  YP `~~88~~' d8' `8b 888o  88 `~~88~~' 88'  YP 
-- 8P      88    88 88V8o 88 `8bo.      88    88ooo88 88V8o 88    88    `8bo.   
-- 8b      88    88 88 V8o88   `Y8b.    88    88~~~88 88 V8o88    88      `Y8b. 
-- Y8b  d8 `8b  d8' 88  V888 db   8D    88    88   88 88  V888    88    db   8D 
--  `Y88P'  `Y88P'  VP   V8P `8888Y'    YP    YP   YP VP   V8P    YP    `8888Y' 
-- -----------------------------------------------------------------------------
myHero = GetMyHero()

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- d8b   db  .d88b.  d8b   db         d888b   .d8b.  .88b  d88. d88888b      d88888b db    db d8b   db  .o88b. d888888b d888888b  .d88b.  d8b   db .d8888. 
-- 888o  88 .8P  Y8. 888o  88        88' Y8b d8' `8b 88'YbdP`88 88'          88'     88    88 888o  88 d8P  Y8 `~~88~~'   `88'   .8P  Y8. 888o  88 88'  YP 
-- 88V8o 88 88    88 88V8o 88        88      88ooo88 88  88  88 88ooooo      88ooo   88    88 88V8o 88 8P         88       88    88    88 88V8o 88 `8bo.   
-- 88 V8o88 88    88 88 V8o88 C8888D 88  ooo 88~~~88 88  88  88 88~~~~~      88~~~   88    88 88 V8o88 8b         88       88    88    88 88 V8o88   `Y8b. 
-- 88  V888 `8b  d8' 88  V888        88. ~8~ 88   88 88  88  88 88.          88      88b  d88 88  V888 Y8b  d8    88      .88.   `8b  d8' 88  V888 db   8D 
-- VP   V8P  `Y88P'  VP   V8P         Y888P  YP   YP YP  YP  YP Y88888P      YP      ~Y8888P' VP   V8P  `Y88P'    YP    Y888888P  `Y88P'  VP   V8P `8888Y' 
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
function dev_round(number, precise)
    -- If no precise specified, set to 0
    precise = precise or 0
    number = number * 10^precise + 0.5
    mathfloor(number)
    return number / 10^precise
end

function dev_tableSize(tbl)
    local ret = 0
    for i,v in pairs(tbl) do
        ret = ret + 1
    end
    return ret
end

-- ---------------------------------------------------------------------------------------------------------
-- d8b   db d88888b  .d8b.  d8888b.       .d88b.  d88888b d88888b d888888b  .o88b. d888888b  .d8b.  db      
-- 888o  88 88'     d8' `8b 88  `8D      .8P  Y8. 88'     88'       `88'   d8P  Y8   `88'   d8' `8b 88      
-- 88V8o 88 88ooooo 88ooo88 88oobY'      88    88 88ooo   88ooo      88    8P         88    88ooo88 88      
-- 88 V8o88 88~~~~~ 88~~~88 88`8b        88    88 88~~~   88~~~      88    8b         88    88~~~88 88      
-- 88  V888 88.     88   88 88 `88.      `8b  d8' 88      88        .88.   Y8b  d8   .88.   88   88 88booo. 
-- VP   V8P Y88888P YP   YP 88   YD       `Y88P'  YP      YP      Y888888P  `Y88P' Y888888P YP   YP Y88888P 
-- ---------------------------------------------------------------------------------------------------------
-- Return percentage HP of target (0 to 100)
function GetPercentHP(unit)
    if unit == nil then return 0 end
    return (GetCurrentHP(unit) / GetMaxHP(unit)) * 100
end

-- Return percentage VP of target (0 to 100)
function GetPercentMP(unit)
    if unit == nil then return 0 end
    return (GetCurrentMP(unit) / GetMaxMP(unit)) * 100
end
GetPercentMana = GetPercentMP

-- Return full AD of target (Base AD + Bonus AD)
function GetFullAD(unit)
    if unit == nil then return 0 end
    return GetAD(unit) + GetBAD(unit)
end

-- Return True if unit is recalling
function IsRecalling(unit)
    if unit == nil then return false end
    return GotBuff(unit,"recall") > 0
end

-- Return True if unit is our hero
function IsMe(unit)
    if unit == nil then return false end
    return GetNetworkID(unit) == GetNetworkID(myHero)
end

-- Return True if unit is our ally
function IsAlly(unit)
    if unit == nil then return false end
    return GetTeam(unit) == GetTeam(myHero)
end

-- Return True if unit is our enemy
function IsEnemy(unit)
    if unit == nil then return false end
    return GetTeam(unit) ~= GetTeam(myHero)
end

-- Checks a validness of target
-- 1) NIL unit is INVALID
-- 2) Unit without ORIGIN is INVALID
-- 3) DEAD units is INVALID
-- 4) INVISIBLE units is INVALID
-- 5) NOT TARGETTABLE units isINVALID
-- 6) IMMUNE units is INVALID
-- 7) ALLIES (with exception) is INVALID
-- 8) The ones who is out of range is INVALID
function IsValidTarget(unit, range, checkTeam)
    range = range or 99999
    checkTeam = checkTeam == nil and true or checkTeam
    
    if (unit ~= nil) and (GetOrigin(unit) ~= nil) and (not IsDead(unit)) and (IsVisible(unit)) and (IsTargetable(unit)) and (not IsImmune(unit,myHero)) and (GetTeam(unit) ~= GetTeam(myHero) or not checkTeam) and (GetDistance(unit) <= range) then
        return true
    end
    return false
end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  .o88b.  .d8b.  db       .o88b. db    db db       .d8b.  d888888b d888888b  .d88b.  d8b   db      d88888b db    db d8b   db  .o88b. d888888b d888888b  .d88b.  d8b   db .d8888. 
-- d8P  Y8 d8' `8b 88      d8P  Y8 88    88 88      d8' `8b `~~88~~'   `88'   .8P  Y8. 888o  88      88'     88    88 888o  88 d8P  Y8 `~~88~~'   `88'   .8P  Y8. 888o  88 88'  YP 
-- 8P      88ooo88 88      8P      88    88 88      88ooo88    88       88    88    88 88V8o 88      88ooo   88    88 88V8o 88 8P         88       88    88    88 88V8o 88 `8bo.   
-- 8b      88~~~88 88      8b      88    88 88      88~~~88    88       88    88    88 88 V8o88      88~~~   88    88 88 V8o88 8b         88       88    88    88 88 V8o88   `Y8b. 
-- Y8b  d8 88   88 88booo. Y8b  d8 88b  d88 88booo. 88   88    88      .88.   `8b  d8' 88  V888      88      88b  d88 88  V888 Y8b  d8    88      .88.   `8b  d8' 88  V888 db   8D 
--  `Y88P' YP   YP Y88888P  `Y88P' ~Y8888P' Y88888P YP   YP    YP    Y888888P  `Y88P'  VP   V8P      YP      ~Y8888P' VP   V8P  `Y88P'    YP    Y888888P  `Y88P'  VP   V8P `8888Y' 
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Return number: Damage Per Second of target. Used aganist AD carries.
function GetDPS(obj, critCount, itemCount)
    if obj == nil then return 0 end
    critCount = critCount == nil and true or critCount
    itemCount = itemCount == nil and true or itemCount
    
    local DMG = GetFullAD(obj)
    if (critCount) then
        local critChance = GetCritChance(obj)
        local critPower = GetItemSlot(obj,3031) > 0 and 1.5 or 1 -- Infinity Edge gives bigger attack power
        DMG = DMG * (1 + critChance) * critPower
    end
    if (itemCount) then
        if (GetItemSlot(obj,3087) > 0) then --Statikk Shiv
            DMG = DMG + 10 -- Because you need 10 hits to build +100 damage, so every hit is ~10 damage incoming.
        end
        if (GetItemSlot(obj,3115) > 0) then --Nashor Tooth
            DMG = DMG + 15 + GetBonusAP(obj) * 0.15
        end
        if (GetItemSlot(obj,3042) > 0) then --Muramana
            DMG = DMG + GetCurrentMana(obj) * 0.06
        end
        if (GetItemSlot(obj,1043) > 0) then --Recurve Bow
            DMG = DMG + 10
        end
        if (GetItemSlot(obj,3153) > 0) then --BOTRK
            DMG = DMG + 10
        end
        if (GetItemSlot(obj,3085) > 0) then --Runaan's Hurricane
            DMG = DMG + 10
        end
    end
    
    return DMG * GetAttackSpeed(obj)
end

-- Return number: Effective HP of target.
function GetEffectiveHP(obj, calc_phys, calc_magic, unique)
    if obj == nil then return 0 end
    
    calc_phys = calc_phys == nil and true or calc_phys
    calc_magic = calc_magic == nil and true or calc_magic
    unique = unique == nil and true or unique
    
    local EHP = GetCurrentHP(obj)
    if (calc_phys) then
        local objArmor = unique and GetArmor(obj) * GetArmorPenPercent(myHero) - GetArmorPenFlat(myHero) or GetArmor(obj)
        local multiplier = objArmor / 100
        EHP = EHP * (1 + multipier)
    end
    if (calc_magic) then
        local objResist = unique and GetMagicResist(obj) * GetMagicPenPercent(myHero) - GetMagicPenFlat(myHero) or GetMagicResist(obj)
        local multiplier = objResist / 100
        EHP = EHP * (1 + multipier)
    end
    return EHP
end

-- Return number: Distance to target (or between points)
function GetDistance(obj1, obj2)
    return math.sqrt(GetDistanceSqr(obj1,obj2))
end
function GetDistanceSqr(obj1,obj2)
    -- Can't calculate distance to non-existant object
    if obj1 == nil then return 0 end
    
    -- If we got Origin, then do nothing. Else, we thinking that we have Object and getting Origin for him.
    obj1 = GetOrigin(obj1) == nil and obj1 or GetOrigin(obj1)
    
    -- Set second object to our hero, if it is not specified.
    obj2 = obj2 or myHero
    obj2 = GetOrigin(obj2) == nil and obj2 or GetOrigin(obj2)
    
    local dx = obj1.x - obj2.x
    local dz = (obj1.z or obj1.y) - (obj2.z or obj2.y)
    return dx*dx + dz*dz
end

-- Return number: Damage to target, calculated.
function CalcDamage_Physical(from, to, count)
    -- Can't calculate damage, if there is non-existant target.
    if from == nil or to == nil then return 0 end

    local AD = count or 0
    local AR = GetArmor(to) * GetArmorPenPercent(from) - GetArmorPenFlat(from)
    local Damage_Reduction = 1 / (1 + (AR/100))
    
    return AD * Damage_Reduction * (GotBuff(from,"exhausted") > 0 and 0.4 or 1)
end

function CalcDamage_Magical(from, to, count)
    -- Can't calculate damage, if there is non-existant target.
    if from == nil or to == nil then return 0 end
    
    local AP = count or 0
    local MR = GetMagicResist(to) * GetMagicPenPercent(from) - GetMagicPenFlat(from)
    local Damage_Reduction = 1 / (1 + (MR/100))
    
    return AP * Damage_Reduction
end

function CalcDamage_True(from, to, count)
    -- Can't calculate damage, if there is non-existant target.
    if from == nil or to == nil then return 0 end
    
    return count == nil and 0 or count
end

function CalcDamage(from, to, ad_dmg, ap_dmg, true_dmg)
    return CalcDamage_Physical(from, to, ad_dmg) + CalcDamage_Magical(from, to, ap_dmg) + CalcDamage_True(from, to, true_dmg)
end

function CastItems(items, brake)
    for i,v in pairs(items) do
        local slot = GetItemSlot(myHero,v)
        if slot ~= 0 and CanUseSpell(myHero, slot) == READY then
            CastSpell(slot)
            if brake then return end
        end
    end
end

function CastItemsTarget(target, items, brake)
    for i,v in pairs(items) do
        local slot = GetItemSlot(myHero,v)
        if slot ~= 0 and CanUseSpell(myHero, slot) == READY then
            CastTargetSpell(target, slot)
            if brake then return end
        end
    end
end

function CastItemsPosition(position, items, brake)
    for i,v in pairs(items) do
        local slot = GetItemSlot(myHero,v)
        if slot ~= 0 and CanUseSpell(myHero, slot) == READY then
            CastSkillShot(slot, position.x, position.y, position.z)
            if brake then return end
        end
    end
end

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  .d8b.  d888888b d888888b  .d8b.   .o88b. db   db  .d8b.  d8888b. db      d88888b           dD      .88b  d88.  .d8b.  d8b   db  .d8b.   d888b  d88888b d8888b. .d8888. 
-- d8' `8b `~~88~~' `~~88~~' d8' `8b d8P  Y8 88   88 d8' `8b 88  `8D 88      88'              d8'      88'YbdP`88 d8' `8b 888o  88 d8' `8b 88' Y8b 88'     88  `8D 88'  YP 
-- 88ooo88    88       88    88ooo88 8P      88ooo88 88ooo88 88oooY' 88      88ooooo         d8'       88  88  88 88ooo88 88V8o 88 88ooo88 88      88ooooo 88oobY' `8bo.   
-- 88~~~88    88       88    88~~~88 8b      88~~~88 88~~~88 88~~~b. 88      88~~~~~        d8'        88  88  88 88~~~88 88 V8o88 88~~~88 88  ooo 88~~~~~ 88`8b     `Y8b. 
-- 88   88    88       88    88   88 Y8b  d8 88   88 88   88 88   8D 88booo. 88.           d8'         88  88  88 88   88 88  V888 88   88 88. ~8~ 88.     88 `88. db   8D 
-- YP   YP    YP       YP    YP   YP  `Y88P' YP   YP YP   YP Y8888P' Y88888P Y88888P      C8'          YP  YP  YP YP   YP VP   V8P YP   YP  Y888P  Y88888P 88   YD `8888Y' 
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Delay Manager.
local DelayManager_Actions = {}
-- DM itself
DelayManager = {} --API Table

DelayManager.AddAction = function(delay, func)
    DelayManager_Actions[#DelayManager_Actions+1] = {execTime = GetTickCount() + delay, execute = func}
end
DelayManager.DoLoop = function()
    local cTime = GetTickCount() --Don't call TickCount more than nessesary
    for i,v in pairs(DelayManager_Actions) do
        if v.execTime <= cTime then
            v.execute()
            DelayManager_Actions[i] = nil
        end
    end
end
OnLoop(function(a)
    DelayManager.DoLoop()
end)
-- Delay Manager END

-- Debug Attachment
function attachDebugger(x,y,color,size)
    local Debugger = {}
    -- Initalize position. Or do it ~middle top on screen 1920*1080
    Debugger.x = x or 760
    Debugger.y = y or 10
    -- Initalize color. Or set it to white.
    Debugger.color = color == nil and ARGB(0xff, 0xff, 0xff, 0xff) or color
    -- Initalize size. Or set it to 14.
    Debugger.size = size == nil and 14 or size
    
    -- Initalize spacers between lines.
    Debugger.spacer = 4
    Debugger.spaceX = 0
    Debugger.spaceY = Debugger.size+Debugger.spacer
    
    -- Do a temporary variables.
    Debugger.tempx = x
    Debugger.tempy = y
        
    -- Do a inside variables
    Debugger.StringCount = 0
    
    Debugger.Write =        function(str)
                                DrawText(str, Debugger.size, Debugger.tempx, Debugger.tempy, Debugger.color)
                                Debugger.tempx = Debugger.tempx + Debugger.spaceX
                                Debugger.tempy = Debugger.tempy + Debugger.spaceY
                                Debugger.StringCount = Debugger.StringCount + 1
                            end
    Debugger.WriteTable=    function(tbl, off)
                                off = off == nil and "" or off
                                for i,v in pairs(tbl) do
                                    if type(v) == "table" then
                                        Debugger.Write(off.."- "..i)
                                        Debugger.StringCount = Debugger.StringCount + 1
                                        Debugger.WriteTable(v, off.."+ ")
                                    else
                                        Debugger.Write(off..i..": "..tostring(v))
                                        Debugger.StringCount = Debugger.StringCount + 1
                                    end
                                end
                            end
    Debugger.Reset =        function()
                                Debugger.tempx = Debugger.x
                                Debugger.tempy = Debugger.y
                                Debugger.StringCount = 0
                            end

    return Debugger
end

-- ---------------------------------------------------
-- d88888b db    db d88888b d8b   db d888888b .d8888. 
-- 88'     88    88 88'     888o  88 `~~88~~' 88'  YP 
-- 88ooooo Y8    8P 88ooooo 88V8o 88    88    `8bo.   
-- 88~~~~~ `8b  d8' 88~~~~~ 88 V8o88    88      `Y8b. 
-- 88.      `8bd8'  88.     88  V888    88    db   8D 
-- Y88888P    YP    Y88888P VP   V8P    YP    `8888Y' 
-- ---------------------------------------------------                                                   
-- OnMaterializeObj(object)
-- Calls everytime object is materialized (Created and have it's parameters like NetworkID and such).
local OnMaterializeObj_Functions = {}
function OnMaterializeObj(funk)
    OnMaterializeObj_Functions[#OnMaterializeObj_Functions+1] = funk
end

local OnMaterializeObj_Unmaterialized = {}
OnLoop(function(a)
    for i,v in pairs(OnMaterializeObj_Unmaterialized) do
        if (GetNetworkID(v) ~= 0) then
            for _,func in pairs(OnMaterializeObj_Functions) do
                func(v)
            end            
            OnMaterializeObj_Unmaterialized[i] = nil
        end
    end
end)

OnCreateObj(function(obj)
    OnMaterializeObj_Unmaterialized[#OnMaterializeObj_Unmaterialized+1] = obj
end)
-- END of OnMaterializeObj
