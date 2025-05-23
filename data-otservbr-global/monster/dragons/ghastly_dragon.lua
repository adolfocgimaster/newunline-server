local mType = Game.createMonsterType("Shadow Draptor")
local monster = {}

monster.description = "a shadow draptor"
monster.experience = 4600
monster.outfit = {
	lookType = 427,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 643
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Ghastly Dragon Lair, Corruption Hole, Razachai including the Inner Sanctum, \z
		Zao Palace, Deeper Banuta, Chyllfroest."
	}

monster.health = 7800
monster.maxHealth = 7800
monster.race = "undead"
monster.corpse = 10445
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 5
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 366,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "EMBRACE MY GIFTS!", yell = true},
	{text = "I WILL FEAST ON YOUR SOUL!", yell = true}
}

monster.loot = {
	{name = "gold coin", chance = 99500, maxCount = 266},
	{name = "platinum coin", chance = 29840, maxCount = 2},
	{name = "small emerald", chance = 40000, maxCount = 5},
	{name = "soul orb", chance = 12170},
	{name = "dark armor", chance = 35000},
	{name = "plate legs", chance = 50000},
	{name = "demonic essence", chance = 8920},
	{name = "great mana potion", chance = 30560, maxCount = 2},
	{name = "terra legs", chance = 3130},
	{name = "terra boots", chance = 9510},
	{name = "great spirit potion", chance = 29460, maxCount = 2},
	{name = "ultimate health potion", chance = 24700},
	{id = 8896, chance = 10000}, -- slightly rusted armor
	{name = "shiny stone", chance = 860},
	{name = "guardian boots", chance = 200},
	{name = "zaoan armor", chance = 870},
	{name = "zaoan helmet", chance = 150},
	{name = "zaoan shoes", chance = 870},
	{name = "zaoan legs", chance = 1400},
	{name = "drakinata", chance = 1470},
	{name = "zaoan sword", chance = 100},
	{name = "twin hooks", chance = 15100},
	{name = "zaoan halberd", chance = 15020},
	{name = "spellweaver's robe", chance = 690},
	{name = "ghastly dragon head", chance = 6650},
	{name = "undead heart", chance = 19830},
	{name = "jade hat", chance = 810}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -603},
	{name ="ghastly dragon curse", interval = 2000, chance = 5, range = 5, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -920, maxDamage = -1280, range = 5, effect = CONST_ME_SMALLCLOUDS, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -80, maxDamage = -230, range = 7, effect = CONST_ME_MAGIC_RED, target = true},
	{name ="ghastly dragon wave", interval = 2000, chance = 10, minDamage = -120, maxDamage = -250, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -110, maxDamage = -180, radius = 4, effect = CONST_ME_MORTAREA, target = false},
	{name ="speed", interval = 2000, chance = 20, speedChange = -800, range = 7, effect = CONST_ME_SMALLCLOUDS, target = true, duration = 30000}
}

monster.defenses = {
	defense = 35,
	armor = 30
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 50},
	{type = COMBAT_HOLYDAMAGE , percent = -15},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
