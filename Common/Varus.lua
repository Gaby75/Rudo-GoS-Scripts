--[[ Rx Varus Version 0.3 by Rudo.
 Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------]]


require('Inspired')
---- Create a Menu ----
if GetObjectName(myHero) ~= "Varus" then return end
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu </font><font color='#FFFFFF'>and Thank </font><font color='#912CEE'>Inspired </font><font color='#FFFFFF'>for help me </font>"))
----------------------------------------
Varus = MenuConfig("Rx Varus", "Varus")
tslowhp = TargetSelector(1625, 8, DAMAGE_PHYSICAL) -- 8 = TARGET_LOW_HP
Varus:TargetSelector("ts", "Target Selector", tslowhp)

---- Combo ----
Varus:Menu("cb", "Varus Combo")
Varus.cb:Boolean("QCB", "Use Q", true)
Varus.cb:Boolean("ECB", "Use E", true)
Varus.cb:Boolean("RCB", "Use R", false)

---- Harass Menu ----
Varus:Menu("hr", "Harass")
Varus.hr:Boolean("HrQ", "Use Q", true)
Varus.hr:Boolean("HrE", "Use E", true)

---- Lane Clear Menu ----
Varus:Menu("lc", "Lane Clear")
Varus.lc:Slider("checkLMP", "LaneClear if %MP >= ", 20, 1, 100, 1)
Varus.lc:Boolean("LcE", "Use E", true)

---- Jungle Clear Menu ----
Varus:Menu("jc", "Jungle Clear")
Varus.jc:Slider("checkJMP", "LaneClear if %MP >= ", 20, 1, 100, 1)
Varus.jc:Boolean("JcE", "Use E", true)

---- Drawings Menu ----
Varus:Menu("Draws", "Drawings")
Varus.Draws:Boolean("DrawsEb", "Enable Drawings", true)
Varus.Draws:Slider("QualiDraw", "Quality Drawings", 110, 1, 255, 1)
Varus.Draws:Boolean("DrawQ", "Range Q Max", true)
Varus.Draws:ColorPick("Qcol", "Setting Q Max Color", {255, 30, 144, 255})
Varus.Draws:Boolean("DrawQminE", "Range Q Min and E", true)
Varus.Draws:ColorPick("EQcol", "Setting Q Min and E Color", {255, 155, 48, 255})
Varus.Draws:Boolean("DrawR", "Range R", true)
Varus.Draws:ColorPick("Rcol", "Setting R Color", {255, 248, 245, 120})
Varus.Draws:Boolean("DrawText", "Draw Text", true)
Varus.Draws:Slider("PosHitx", "Change Text Hit PoS-X", 76, 1, 110, 1)
Varus.Draws:Slider("PosHity", "Change Text Hit PoS-Y", 43, 1, 110, 1)
PermaShow(Varus.Draws.DrawText)

---- Misc Menu ----
Varus:Menu("Miscset", "Misc")
Varus.Miscset:Menu("KS", "Kill Steal")
Varus.Miscset.KS:Boolean("KSEb", "Enable KillSteal", true)
Varus.Miscset.KS:Boolean("QKS", "KS with Q", true)
Varus.Miscset.KS:Boolean("EKS", "KS with E", true)
Varus.Miscset.KS:Boolean("RKS", "KS with R", false)
Varus.Miscset.KS:Boolean("IgniteKS", "KS with IgniteKS", true)
Varus.Miscset:Menu("AutoLvlUp", "Auto Level Up")
Varus.Miscset.AutoLvlUp:Boolean("UpSpellEb", "Enable Auto Lvl Up", true)
Varus.Miscset.AutoLvlUp:DropDown("AutoSkillUp", "Settings", 1, {"Q-W-E", "Q-E-W"}) 
PermaShow(Varus.Miscset.KS.IgniteKS)
PermaShow(Varus.Miscset.KS.RKS)
   
---- Use Items Menu ----
Varus:Menu("Items", "Auto Use Items")
Varus.Items:Menu("PotionHP", "Use Potion HP")
Varus.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
Varus.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 5, 80, 1)
Varus.Items:Menu("PotionMP", "Use Potion MP")
Varus.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
Varus.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 5, 80, 1)
Varus.Items:Menu("Attack", "Items Offensive in Combo")
Varus.Items:Info("infoItems", "Use PActivator for auto use Items")

---------- Items Offensive ----------
Varus.Items.Attack:Boolean("Cutlass", "Use Bilgewater Cutlass", true)
Varus.Items.Attack:Boolean("BladeORKing", "Use Blade of the Ruined King", true)
Varus.Items.Attack:Boolean("Youmuu", "Use Youmuu's Ghostblade", true)
PermaShow(Varus.Items.Attack.Cutlass)
PermaShow(Varus.Items.Attack.BladeORKing)
PermaShow(Varus.Items.Attack.Youmuu)

------------------------------------------------------------------------

---------- End Menu ----------


-------------------------------------------------------Starting--------------------------------------------------------------

require('DeftLib')
local BonusAP = GetBonusAP(myHero)
local BonusAD = GetBonusDmg(myHero)
-------------------------------------------
OnTick(function(myHero)
		        local target = tslowhp:GetTarget()
 if target then
 		        local EPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1500,250,925,235,false,true)
		        local RPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1950,250,1200,100,false,true)
    	------ Start Combo ------
    if IOW:Mode() == "Combo" and IsObjectAlive(target) then 
		if IsReady(_E) and Varus.cb.ECB:Value() and EPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_E)) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		if IsReady(_Q) and Varus.cb.QCB:Value() and ValidTarget(target, 1625) then
		CastSkillShot(_Q, GetMousePos().x, GetMousePos().y, GetMousePos().z)
      for i=400, 1600, 400 do
        DelayAction(function()
              local _Qrange = 825 + math.min(800, i/2)
              local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1850,0,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
        end, i)
      end	
        end 
	end

	if IOW:Mode() == "Harass" and IsObjectAlive(target) then
	------ Start Harass ------
		if IsReady(_E) and Varus.hr.HrE:Value() and EPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_E)) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
		end
		if IsReady(_Q) and Varus.cb.QCB:Value() and ValidTarget(target, 1625) then
		CastSkillShot(_Q, GetMousePos().x, GetMousePos().y, GetMousePos().z)
      for i=400, 1600, 400 do
        DelayAction(function()
              local _Qrange = 825 + math.min(800, i/2)
              local QPred = GetPredictionForPlayer(myHeroPos(),target,GetMoveSpeed(target),1850,0,_Qrange,70,false,true)
              if QPred.HitChance == 1 then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
        end, i)
      end	
        end
	end
 end
	
		if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Varus.lc.checkLMP:Value() then
	------ Start LaneClear ------
	for _,minion in pairs(minionManager.objects) do
	 if GetTeam(minion) == MINION_ENEMY then
		  if IsInDistance(minion, 950) then
		 local minionsPos = GetOrigin(minion)
		if IsReady(_E) and Varus.lc.LcE:Value() then
		CastSkillShot(_E, minionsPos.x, minionsPos.y, minionsPos.z)
		end
		  end
	 end	  
	end
		end
		
		if IOW:Mode() == "LaneClear" and GetPercentMP(myHero) >= Varus.jc.checkJMP:Value() then
	------ Start JungClear ------
	for _,mob in pairs(minionManager.objects) do
	 if GetTeam(mob) == MINION_JUNGLE then
		  if IsInDistance(mob, 950) then
		 local mobPos = GetOrigin(mob)
		if IsReady(_E) and Varus.jc.JcE:Value() then
		CastSkillShot(_E, mobPos.x, mobPos.y, mobPos.z)
		end
		  end
	 end
	end
		end
		
-----------------------------------------------------------------------------------------------------------

	 	------ Start Kill Steal ------	
if Varus.Miscset.KS.KSEb:Value() then
for _,enemy in pairs(GetEnemyHeroes()) do

	local stacksW = GotBuff(enemy, "varuswdebuff") 
	local CheckWDmg = ((0.75*GetCastLevel(myHero, _W) + 1.25)/100)*(GetMaxHP(enemy))
	local CheckQDmg = 55*GetCastLevel(myHero, _Q) - 40 + 1.6*BonusAD
	local CheckEDmg = 35*GetCastLevel(myHero, _E) + 30 + 0.6*BonusAD
	local CheckRDmg = 100*GetCastLevel(myHero, _R) + 50 + 1.0*BonusAP
	local CheckQ2 = 0
	local CheckE2 = 0
	local CheckR2 = 0
	if stacksW >= 3 then
	CheckQ2 = CheckQ2 + CheckQDmg + 3*CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + 3*CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + 3*CheckWDmg
	elseif stacksW >= 2 and stacksW < 3 then
	CheckQ2 = CheckQ2 + CheckQDmg + 2*CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + 2*CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + 2*CheckWDmg
	elseif stacksW >= 1 and stacksW < 2 then
	CheckQ2 = CheckQ2 + CheckQDmg + CheckWDmg
	CheckE2 = CheckE2 + CheckEDmg + CheckWDmg
	CheckR2 = CheckR2 + CheckRDmg + CheckWDmg
	else
	CheckQ2 = CheckQ2 + CheckQDmg
	CheckE2 = CheckE2 + CheckEDmg
	CheckR2 = CheckR2 + CheckRDmg
	end

		if Ignite and Varus.Miscset.KS.IgniteKS:Value() then
                  if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
        end

	if IsReady(_Q) and Varus.Miscset.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, CheckQ2, 0) and IsObjectAlive(enemy) and ValidTarget(enemy, 1625) then
		CastSkillShot(_Q, GetMousePos().x, GetMousePos().y, GetMousePos().z)
      for i=400, 1600, 400 do
        DelayAction(function()
               if GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, CheckQ2, 0) then
              local _Qrange = 825 + math.min(800, i/2)
              local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),1850,0,_Qrange,70,false,true)
              if QPred.HitChance == 1 and ValidTarget(enemy, 1625) then
                CastSkillShot2(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
              end
			   end
        end, i)
      end	
	end
 if IsReady(_E) and IsReady(_R) or IsReady(_E) and not IsReady(_R) then
  if IsObjectAlive(enemy) and IsInDistance(enemy, GetCastRange(myHero,_E)) and Varus.Miscset.KS.EKS:Value() then
   if GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, CheckE2, 0) then
	    local EPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),1500,250,925,235,false,true)
	if EPred.HitChance == 1 and ValidTarget(enemy, GetCastRange(myHero,_E)) then
		CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
	end
   end
  end
 end
 
 if IsReady(_R) and not IsReady(_E) then
  if IsObjectAlive(enemy) and IsInDistance(enemy, 1200) and Varus.Miscset.KS.RKS:Value() then
   if GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, CheckR2, 0) then
	local RPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),1950,250,1200,100,false,true)
	if RPred.HitChance == 1 and ValidTarget(enemy, 1150) then
		CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
	end
   end
  end
 end
end
end

	 	------ Start Auto Level Up _Settings Full Q or Full W first ------	
if Varus.Miscset.AutoLvlUp.UpSpellEb:Value() then
  if Varus.Miscset.AutoLvlUp.AutoSkillUp:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First then W
  elseif Varus.Miscset.AutoLvlUp.AutoSkillUp:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W} -- Full Q First then E
  end
   LevelSpell(leveltable[GetLevel(myHero)])
end
	
	 	------ Start Use Items _Use Health Potion_ ------
		
if Varus.Items.PotionHP.PotHP:Value() then	
global_ticks = 0
currentTicks = GetTickCount()
 if Varus.Items.PotionHP.PotHP:Value() and GotBuff(myHero, "recall") <= 0 then
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if GetPercentHP(myHero) < Varus.Items.PotionHP.CheckHP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2003))
						end
					end
				end
			end
			
end	

 	------ Start Use Items _Use Mana Potion_ ------	
	
if Varus.Items.PotionMP.PotMP:Value() then	
global_ticks = 0
currentTicks = GetTickCount()
 if Varus.Items.PotionMP.PotMP:Value() and GotBuff(myHero, "recall") <= 0 then
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if GetPercentMP(myHero) < Varus.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
end	

 	------ Start Use Items Offensive ------

        --- Bilgewater Cutlass ---	
if Varus.Items.Attack.Cutlass:Value() then
	local BC = GetItemSlot(myHero, 3144)
local target = GetCurrentTarget()
	if IOW:Mode() == "Combo" then
		if BC > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY and ValidTarget(target, 550) and GotBuff(myHero, "recall") <= 0 then
			CastTargetSpell(target, GetItemSlot(myHero, 3144))
		end
	end
end

        --- Blade of the Ruined King ---
if Varus.Items.Attack.BladeORKing:Value() then
	local BORKing = GetItemSlot(myHero, 3153)
local target = GetCurrentTarget()
	if IOW:Mode() == "Combo" then
		if BORKing > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY and ValidTarget(target, 550) and GotBuff(myHero, "recall") <= 0 then
			CastTargetSpell(target, GetItemSlot(myHero, 3153))
		end
	end
end
	
        --- Youmuu's Ghostblade ---	
if Varus.Items.Attack.Youmuu:Value() then
	local YoumuuGhost = GetItemSlot(myHero, 3142)
local target = GetCurrentTarget()
	if IOW:Mode() == "Combo" then
		if YoumuuGhost > 0 and CanUseSpell(myHero, GetItemSlot(myHero, 3142)) == READY and ValidTarget(target, 1300) and GotBuff(myHero, "recall") <= 0 then
			CastSpell(GetItemSlot(myHero, 3142))
		end
	end
end
end)

	------ Start Drawings ------
OnDraw(function(myHero)
if Varus.Draws.DrawsEb:Value() then 
if Varus.Draws.DrawQ:Value() and IsReady(_Q) then DrawCircle(myHeroPos(),1625,1,Varus.Draws.QualiDraw:Value(),Varus.Draws.Qcol:Value()) end
if IsReady(_W) or IsReady(_Q) then
if Varus.Draws.DrawQminE:Value() then DrawCircle(myHeroPos(),GetCastRange(myHero,_E),2,Varus.Draws.QualiDraw:Value(),Varus.Draws.EQcol:Value()) end
end
if Varus.Draws.DrawR:Value() and IsReady(_R) then DrawCircle(myHeroPos(),1200,1,Varus.Draws.QualiDraw:Value(),Varus.Draws.Rcol:Value()) end
            if Varus.Draws.DrawText:Value() then
	for _, enemy in pairs(GetEnemyHeroes()) do
		 if ValidTarget(enemy) then
	local stacksW = GotBuff(enemy, "varuswdebuff") 
	local CheckWDmg = ((0.75*GetCastLevel(myHero, _W) + 1.25)/100)*(GetMaxHP(enemy))
	local CheckQDmg = 55*GetCastLevel(myHero, _Q) - 40 + 1.6*BonusAD
	local CheckEDmg = 35*GetCastLevel(myHero, _E) + 30 + 0.6*BonusAD
	local CheckRDmg = 100*GetCastLevel(myHero, _R) + 50 + 1.0*BonusAP
	local CheckQA = 0
	local CheckEA = 0
	local CheckRA = 0
	if stacksW >= 3 then
	CheckQA = CheckQA + CheckQDmg + 3*CheckWDmg
	CheckEA = CheckEA + CheckEDmg + 3*CheckWDmg
	CheckRA = CheckRA + CheckRDmg + 3*CheckWDmg
	elseif stacksW >= 2 and stacksW < 3 then
	CheckQA = CheckQA + CheckQDmg + 2*CheckWDmg
	CheckEA = CheckEA + CheckEDmg + 2*CheckWDmg
	CheckRA = CheckRA + CheckRDmg + 2*CheckWDmg
	elseif stacksW >= 1 and stacksW < 2 then
	CheckQA = CheckQA + CheckQDmg + CheckWDmg
	CheckEA = CheckEA + CheckEDmg + CheckWDmg
	CheckRA = CheckRA + CheckRDmg + CheckWDmg
	else
	CheckQA = CheckQA + CheckQDmg
	CheckEA = CheckEA + CheckEDmg
	CheckRA = CheckRA + CheckRDmg
	end
    local CheckW = 4*GetCastLevel(myHero, _W) + 6 + 0.25*BonusAP 
	local Check2 = GetMagicShield(enemy)+GetDmgShield(enemy)
	local CheckR
	local CheckE
	local CheckQ
	
		if IsReady(_R) then
		CheckR = CalcDamage(myHero, enemy, CheckRA, 0)
		else
		CheckR = 0
		end
		if IsReady(_Q) then
		CheckQ = CalcDamage(myHero, enemy, CheckQA, 0)
		else
		CheckQ = 0
		end
		if IsReady(_E) then
		CheckE = CalcDamage(myHero, enemy, CheckEA, 0)
		else
		CheckE = 0
		end

		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),CheckQ + CheckE + CheckR - Check2, 0,0xffffffff)
		  DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),GetBaseDamage(myHero) + CheckW - Check2,0,0xffffffff)	
		  
	local checkEnmHp = GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy)
	local checkDmg = GetBaseDamage(myHero) + CheckW
	local hit = 0
	local EnmTextPos = WorldToScreen(1, GetOrigin(enemy).x, GetOrigin(enemy).y, GetOrigin(enemy).z)
	if checkEnmHp > checkDmg then
	hit = hit + checkEnmHp/checkDmg
	else
	hit = hit + 1
	end
		DrawText(string.format("~ %d Hit = KILL!", hit),16,EnmTextPos.x-Varus.Draws.PosHitx:Value(),EnmTextPos.y-Varus.Draws.PosHity:Value(),0xffffffff)
		 end
	end
            end
end
end)

PrintChat(string.format("<font color='#FF0000'>Rx Varus by Rudo </font><font color='#FFFF00'>Version 0.3: Loaded Success </font><font color='#08F7F3'>Enjoy it and Good Luck :3</font>")) 
