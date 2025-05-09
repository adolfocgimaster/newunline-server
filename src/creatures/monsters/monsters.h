/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef SRC_CREATURES_MONSTERS_MONSTERS_H_
#define SRC_CREATURES_MONSTERS_MONSTERS_H_

#include "creatures/creature.h"
#include "declarations.hpp"

class Loot {
	public:
		Loot() = default;

		// non-copyable
		Loot(const Loot&) = delete;
		Loot& operator=(const Loot&) = delete;

		LootBlock lootBlock;
};

class BaseSpell;
struct spellBlock_t {
	constexpr spellBlock_t() = default;
	~spellBlock_t();
	spellBlock_t(const spellBlock_t& other) = delete;
	spellBlock_t& operator=(const spellBlock_t& other) = delete;
	spellBlock_t(spellBlock_t&& other) :
		spell(other.spell),
		chance(other.chance),
		speed(other.speed),
		range(other.range),
		minCombatValue(other.minCombatValue),
		maxCombatValue(other.maxCombatValue),
		combatSpell(other.combatSpell),
		isMelee(other.isMelee) {
		other.spell = nullptr;
	}

	BaseSpell* spell = nullptr;
	uint32_t chance = 100;
	uint32_t speed = 2000;
	uint32_t range = 0;
	int32_t minCombatValue = 0;
	int32_t maxCombatValue = 0;
	bool combatSpell = false;
	bool isMelee = false;
};

class MonsterType
{
	struct MonsterInfo {
		LuaScriptInterface* scriptInterface;

		std::map<CombatType_t, int32_t> elementMap;
		std::map<CombatType_t, int32_t> reflectMap;
		std::map<CombatType_t, int32_t> healingMap;

		std::vector<voiceBlock_t> voiceVector;

		std::vector<LootBlock> lootItems;
		std::vector<std::string> scripts;
		std::vector<spellBlock_t> attackSpells;
		std::vector<spellBlock_t> defenseSpells;
		std::vector<summonBlock_t> summons;

		Skulls_t skull = SKULL_NONE;
		Outfit_t outfit = {};
		RaceType_t race = RACE_BLOOD;
		RespawnType respawnType = {};

		LightInfo light = {};
		uint16_t lookcorpse = 0;
		uint16_t baseSpeed = 110;

		uint64_t experience = 0;

		uint32_t manaCost = 0;
		uint32_t yellChance = 0;
		uint32_t yellSpeedTicks = 0;
		uint32_t staticAttackChance = 95;
		uint32_t maxSummons = 0;
		uint32_t changeTargetSpeed = 0;
		uint32_t conditionImmunities = 0;
		uint32_t damageImmunities = 0;

		// Bestiary
		uint8_t bestiaryOccurrence = 0;
		uint8_t bestiaryStars = 0;
		uint16_t bestiaryToUnlock = 0;
		uint16_t bestiaryFirstUnlock = 0;
		uint16_t bestiarySecondUnlock = 0;
		uint16_t bestiaryCharmsPoints = 0;
		uint16_t raceid = 0;
		std::string bestiaryLocations;
		std::string bestiaryClass; // String (addString)
		BestiaryType_t bestiaryRace = BESTY_RACE_NONE; // Number (addByte)

		int32_t creatureAppearEvent = -1;
		int32_t creatureDisappearEvent = -1;
		int32_t creatureMoveEvent = -1;
		int32_t creatureSayEvent = -1;
		int32_t thinkEvent = -1;
		int32_t targetDistance = 1;
		int32_t runAwayHealth = 0;
		int32_t health = 100;
		int32_t healthMax = 100;
		int32_t changeTargetChance = 0;
		int32_t defense = 0;
		int32_t armor = 0;
		int32_t strategiesTargetNearest = 0;
		int32_t strategiesTargetHealth = 0;
		int32_t strategiesTargetDamage = 0;
		int32_t strategiesTargetRandom = 0;
		bool targetPreferPlayer = false;
		bool targetPreferMaster = false;

		Faction_t faction = FACTION_DEFAULT;
		phmap::flat_hash_set<Faction_t> enemyFactions;

		bool canPushItems = false;
		bool canPushCreatures = false;
		bool pushable = true;
		bool isSummonable = false;
		bool isIllusionable = false;
		bool isConvinceable = false;
		bool isAttackable = true;
		bool isHostile = true;
		bool hiddenHealth = false;
		bool isBlockable = false;
		bool isFamiliar = false;
		bool isRewardBoss = false;
		bool canWalkOnEnergy = true;
		bool canWalkOnFire = true;
		bool canWalkOnPoison = true;
		bool isForgeCreature = true;

		MonstersEvent_t eventType = MONSTERS_EVENT_NONE;
	};

	public:
		MonsterType() = default;
		explicit MonsterType(const std::string &initName) : name(initName), typeName(initName), nameDescription(initName) {};

		// non-copyable
		MonsterType(const MonsterType&) = delete;
		MonsterType& operator=(const MonsterType&) = delete;

		bool loadCallback(LuaScriptInterface* scriptInterface);

		std::string name;
		std::string typeName;
		std::string nameDescription;

		MonsterInfo info;

		uint16_t getBaseSpeed() const {
			return info.baseSpeed;
		}

		void setBaseSpeed(const uint16_t initBaseSpeed) {
			info.baseSpeed = initBaseSpeed;
		}

		void loadLoot(MonsterType* monsterType, LootBlock lootblock);

		bool canSpawn(const Position& pos);
};

class MonsterSpell
{
	public:
		MonsterSpell() = default;

		MonsterSpell(const MonsterSpell&) = delete;
		MonsterSpell& operator=(const MonsterSpell&) = delete;

		std::string name = "";
		std::string scriptName = "";

		uint8_t chance = 100;
		uint8_t range = 0;

		uint16_t interval = 2000;

		int32_t minCombatValue = 0;
		int32_t maxCombatValue = 0;
		int32_t attack = 0;
		int32_t skill = 0;
		int32_t length = 0;
		int32_t spread = 0;
		int32_t radius = 0;
		int32_t conditionMinDamage = 0;
		int32_t conditionMaxDamage = 0;
		int32_t conditionStartDamage = 0;
		int32_t tickInterval = 0;
		int32_t speedChange = 0;
		int32_t duration = 0;

		bool isScripted = false;
		bool needTarget = false;
		bool needDirection = false;
		bool combatSpell = false;
		bool isMelee = false;

		Outfit_t outfit = {};
		std::string outfitMonster = "";
		uint16_t outfitItem = 0;

		ShootType_t shoot = CONST_ANI_NONE;
		MagicEffectClasses effect = CONST_ME_NONE;
		ConditionType_t conditionType = CONDITION_NONE;
		CombatType_t combatType = COMBAT_UNDEFINEDDAMAGE;
};

class Monsters
{
	public:
		Monsters() = default;
		// non-copyable
		Monsters(const Monsters&) = delete;
		Monsters& operator=(const Monsters&) = delete;

		static Monsters& getInstance() {
			// Guaranteed to be destroyed
			static Monsters instance;
			// Instantiated on first use
			return instance;
		}

		bool loadFromXml(bool reloading = false);
		bool isLoaded() const {
			return loaded;
		}
		bool reload();

		MonsterType* getMonsterType(const std::string& name);
		MonsterType* getMonsterTypeByRaceId(uint16_t thisrace);
		void addMonsterType(const std::string& name, MonsterType* mType);
		bool deserializeSpell(MonsterSpell* spell, spellBlock_t& sb, const std::string& description = "");

		std::unique_ptr<LuaScriptInterface> scriptInterface;
		std::map<std::string, MonsterType*> monsters;

	private:
		ConditionDamage* getDamageCondition(ConditionType_t conditionType,
											int32_t maxDamage, int32_t minDamage, int32_t startDamage, uint32_t tickInterval);
		bool deserializeSpell(const pugi::xml_node& node, spellBlock_t& sb, const std::string& description = "");

		MonsterType* loadMonster(const std::string& file, const std::string& monsterName, bool reloading = false);

		void loadLootContainer(const pugi::xml_node& node, LootBlock&);
		bool loadLootItem(const pugi::xml_node& node, LootBlock&);

		std::map<std::string, std::string> unloadedMonsters;

		bool loaded = false;
};

constexpr auto g_monsters = &Monsters::getInstance;

#endif  // SRC_CREATURES_MONSTERS_MONSTERS_H_
