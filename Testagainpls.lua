Config = scriptConfig("Teemo", "Teemo:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("DMG", "DMG", SCRIPT_PARAM_ONOFF, true)

 
 
myIAC = IAC()
 
OnLoop(function(myHero)
Drawings()
Killsteal()
local target = GetCurrentTarget()
 
        if IWalkConfig.Combo then
              local target = GetTarget(1000, DAMAGE_MAGICAL)
                if ValidTarget(target, 1000) then
                       
                     
						if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, GetCastRange(myHero,_Q)) and Config.Q then
                        CastTargetSpell(target, _Q)
						end
                end
        end
end)
		
function Killsteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
	
                 if CanUseSpell(myHero,_Q) and ValidTarget(enemy, GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (45*GetCastLevel(myHero,_Q) + 35 + 0.8*(GetBonusAP(myHero)))) then
                 CastTargetSpell(target, _Q)
end
end
end

        if ValidTarget(target, 2000) and Config.DMG then
  if CanUseSpell(myHero,_Q) == READY then 
local trueDMG = CalcDamage(myHero, target, 0, (45*GetCastLevel(myHero,_Q) + 35 + 0.8*(GetBonusAP(myHero))))
    DrawDmgOverHpBar(target,GetCurrentHP(target),trueDMG,0,0xff00ff00) then
    end
    
end
 
function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
end

