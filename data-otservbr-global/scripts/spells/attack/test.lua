local baseDamage = 50       -- Daño base fijo
local levelMult = 1.2       -- Multiplicador del nivel
local magiclvlMult = 1.5    -- Multiplicador del Magic Level
local offset = 10           -- Aleatoriedad extra


local Spell_part1 = Combat()
Spell_part1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_THUNDER)
Spell_part1:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
Spell_part1:setArea(createCombatArea({
{1, 0, 1},
{0, 1, 0},
{0, 2, 0}
}))

function getDmg_Spell_part1(cid, level, maglevel)
	return baseDamage + math.pow(level, levelMult) + math.pow(maglevel, magiclvlMult) + math.random(level + offset)
end
Spell_part1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "getDmg_Spell_part1")

local Spell_part2 = Combat()
Spell_part2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
Spell_part2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
Spell_part2:setArea(createCombatArea({
{2}
}))

function getDmg_Spell_part2(cid, level, maglevel)
	return baseDamage + math.pow(level, levelMult) + math.pow(maglevel, magiclvlMult) + math.random(level + offset)
end
Spell_part2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "getDmg_Spell_part2")

-- =============== CORE FUNCTIONS ===============
local function RunPart(c,cid,var,dirList,dirEmitPos) -- Part
	if (Creature(cid):isCreature(cid)) then
		c:execute(cid, var)
		if (dirList ~= nil) then -- Emit distance effects
			local i = 2;
			while (i < #dirList) do
				dirEmitPos:sendDistanceEffect({x=dirEmitPos.x-dirList[i],y=dirEmitPos.y-dirList[i+1],z=dirEmitPos.z},dirList[1])
				i = i + 2
			end
		end
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local startPos = creature:getPosition(cid)
	local creatureId = creature:getId()
	RunPart(Spell_part2, creatureId, var, startPos)
	addEvent(RunPart, 100 * 1, Spell_part1, creatureId, var, startPos)
	return true
end

-- Spell properties
spell:group("attack", "focus")
spell:id(1291)
spell:name("test")
spell:words("tes")
spell:level(100)
spell:mana(100)
spell:isPremium(true)
spell:isSelfTarget(false)
spell:cooldown(1)
spell:groupCooldown(1)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "sorcerer;true", "master sorcerer;true", "paladin;true", "royal paladin;true")
spell:register()
