print("[MAKER TAGGING SYSTEM] Loaded!")

local bit = bit or bit32  -- usa la librería correcta según tu versión

local MAKER_TAGS = {
    -- Brutal speed makers
    [39991] = { name = "Brutal Weapon Maker 1.75x", prefix = "brutal", tags = { brutal_maker = 1.75 }, slots = {"left", "right", "twohanded"}, desc = "Special abilities: 1.75x attack speed." },
    [39990] = { name = "Brutal Weapon Maker 2.5x", prefix = "brutal", tags = { brutal_maker = 2.5 }, slots = {"left", "right", "twohanded"}, desc = "Special abilities: 2.5x attack speed." },
    -- Skills (blessed)
    [39992] = { name = "Blessed Backpack Maker 5", prefix = "blessed", tags = { skill_sword = 5, skill_axe = 5, skill_club = 5, skill_dist = 5, skill_shield = 5 }, slots = {"backpack"}, desc = "Special abilities: extra 5 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    [39993] = { name = "Blessed Backpack Maker 10", prefix = "blessed", tags = { skill_sword = 10, skill_axe = 10, skill_club = 10, skill_dist = 10, skill_shield = 10 }, slots = {"backpack"}, desc = "Special abilities: extra 10 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    [39994] = { name = "Blessed Helmet Maker 10", prefix = "blessed", tags = { skill_sword = 10, skill_axe = 10, skill_club = 10, skill_dist = 10, skill_shield = 10 }, slots = {"head"}, desc = "Special abilities: extra 10 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    [39995] = { name = "Blessed Ring Maker 5", prefix = "blessed", tags = { skill_sword = 5, skill_axe = 5, skill_club = 5, skill_dist = 5, skill_shield = 5 }, slots = {"ring"}, desc = "Special abilities: extra 5 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    -- Magic/Shield
    [39996] = { name = "Magically Backpack Maker 5", prefix = "magically", tags = { magic_level = 5, skill_shield = 5 }, slots = {"backpack"}, desc = "Special abilities: extra 5 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    [39997] = { name = "Magically Backpack Maker 10", prefix = "magically", tags = { magic_level = 10, skill_shield = 10 }, slots = {"backpack"}, desc = "Special abilities: extra 10 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    [39998] = { name = "Magically Helmet Maker 10", prefix = "magically", tags = { magic_level = 10, skill_shield = 10 }, slots = {"head"}, desc = "Special abilities: extra 10 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    [39999] = { name = "Magically Ring Maker 5", prefix = "magically", tags = { magic_level = 5, skill_shield = 5 }, slots = {"ring"}, desc = "Special abilities: extra 5 sword, axe, club, distance, shield skills and 5 magic levels(only mages). Compound on helmet or backpack." },
    -- Speed (shoes)
    [40000] = { name = "Speedy Shoes Maker 20%", prefix = "speedy", tags = { walk_speed_percent = 0.20 }, slots = {"feet"}, desc = "Special abilities: Walking speed 20%" },
    [40001] = { name = "Speedy Shoes Maker 35%", prefix = "speedy", tags = { walk_speed_percent = 0.35 }, slots = {"feet"}, desc = "Special abilities: Walking speed 35%" },
    [40002] = { name = "Speedy Shoes Maker 50%", prefix = "speedy", tags = { walk_speed_percent = 0.50 }, slots = {"feet"}, desc = "Special abilities: Walking speed 50%" },
    -- Cooldown (necklace)
    [40003] = { name = "Charmed Amulet Maker 25%", prefix = "charmed", tags = { spell_cooldown_percent = 0.25 }, slots = {"necklace"}, desc = "Special abilities: Cooldown Reduction 25%." },
    [40004] = { name = "Charmed Amulet Maker 35%", prefix = "charmed", tags = { spell_cooldown_percent = 0.35 }, slots = {"necklace"}, desc = "Special abilities: Cooldown Reduction 35%." },
    [40005] = { name = "Charmed Amulet Maker 50%", prefix = "charmed", tags = { spell_cooldown_percent = 0.50 }, slots = {"necklace"}, desc = "Special abilities: Cooldown Reduction 50%." },
    -- Supreme/rigid/mystic (HP/MP %)
    [40006] = { name = "Supreme Legs Maker 5%", prefix = "supreme", tags = { supreme_hp_percent = 0.05, supreme_mp_percent = 0.05 }, slots = {"legs"}, desc = "Special abilities: Maximum health and mana +5%. Compound on helmets or legs." },
    [40007] = { name = "Supreme Helmet Maker 5%", prefix = "supreme", tags = { supreme_hp_percent = 0.05, supreme_mp_percent = 0.05 }, slots = {"head"}, desc = "Special abilities: Maximum health and mana +5%. Compound on helmets or legs." },
    [40008] = { name = "Mystic Armor Maker +15%", prefix = "mystic", tags = { supreme_mp_percent = 0.15 }, slots = {"armor"}, desc = "Special abilities: Maximum mana +15%" },
    [40009] = { name = "Mystic Armor Maker +25%", prefix = "mystic", tags = { supreme_mp_percent = 0.25 }, slots = {"armor"}, desc = "Special abilities: Maximum mana +25%" },
    [40010] = { name = "Rigid Armor Maker +15%", prefix = "rigid", tags = { supreme_hp_percent = 0.15 }, slots = {"armor"}, desc = "Special abilities: Maximum health +15%" },
    [40011] = { name = "Rigid Armor Maker +25%", prefix = "rigid", tags = { supreme_hp_percent = 0.25 }, slots = {"armor"}, desc = "Special abilities: Maximum health +25%" },
    [40012] = { name = "Supreme Armor Maker +30%", prefix = "supreme", tags = { supreme_hp_percent = 0.30, supreme_mp_percent = 0.30 }, slots = {"armor"}, desc = "Special abilities: Maximum health and mana +30%" },
    -- Regen (Warlock, pueden ser varias slots)
    [40013] = { name = "Warlock Helmet Maker 8", prefix = "warlock", tags = { hp_regen = 8, mp_regen = 8 }, slots = {"head"}, desc = "Special abilities: Health recovery +8 max. mana recovery +8 max. Compound on helmets, legs, dolls, rings or quivers." },
    [40014] = { name = "Warlock Legs Maker 8", prefix = "warlock", tags = { hp_regen = 8, mp_regen = 8 }, slots = {"legs"}, desc = "Special abilities: Health recovery +8 max. mana recovery +8 max. Compound on helmets, legs, dolls, rings or quivers." },
    [40015] = { name = "Warlock Ring Maker 8", prefix = "warlock", tags = { hp_regen = 8, mp_regen = 8 }, slots = {"ring"}, desc = "Special abilities: Health recovery +8 max. mana recovery +8 max. Compound on helmets, legs, dolls, rings or quivers." },
    [40016] = { name = "Warlock Ring Maker 15", prefix = "warlock", tags = { hp_regen = 15, mp_regen = 15 }, slots = {"ring"}, desc = "Special abilities: Health recovery +15 max. mana recovery +15 max. Compound on rings, dolls or quivers." },
    [40017] = { name = "Warlock Doll Maker 8", prefix = "warlock", tags = { hp_regen = 8, mp_regen = 8 }, slots = {"head", "legs"}, desc = "Special abilities: Health recovery +8 max. mana recovery +8 max. Compound on helmets, legs, dolls, rings or quivers." },
    [40018] = { name = "Warlock Doll Maker 15", prefix = "warlock", tags = { hp_regen = 15, mp_regen = 15 }, slots = {"head", "legs"}, desc = "Special abilities: Health recovery +15 max. mana recovery +15 max. Compound on rings, dolls or quivers." },
    [40019] = { name = "Warlock Quiver Maker 8", prefix = "warlock", tags = { hp_regen = 8, mp_regen = 8 }, slots = {"ammo"}, desc = "Special abilities: Health recovery +8 max. mana recovery +8 max. Compound on helmets, legs, dolls, rings or quivers." },
    [40020] = { name = "Warlock Quiver Maker 15", prefix = "warlock", tags = { hp_regen = 15, mp_regen = 15 }, slots = {"ammo"}, desc = "Special abilities: Health recovery +15 max. mana recovery +15 max. Compound on rings, dolls or quivers." },
    -- Shield/physical/magic reduction
    [40021] = { name = "Magically-Shielded Shield Maker 20%", prefix = "magically-shielded", tags = { magic_reduction = 0.20 }, slots = {"left", "right"}, desc = "Special abilities: 20% Extra magical damage reduction." },
    [40022] = { name = "Magically-Shielded Shield Maker 30%", prefix = "magically-shielded", tags = { magic_reduction = 0.30 }, slots = {"left", "right"}, desc = "Special abilities: 30% Extra magical damage reduction." },
    [40023] = { name = "Double-Forced Shield Maker 20%", prefix = "double-forced shielded", tags = { physical_reduction = 0.20 }, slots = {"left", "right"}, desc = "Special abilities: 20% Extra physical damage reduction." },
    [40024] = { name = "Double-Forced Shield Maker 30%", prefix = "double-forced shielded", tags = { physical_reduction = 0.30 }, slots = {"left", "right"}, desc = "Special abilities: 30% Extra physical damage reduction." },
}


-- Slot name to slotPosition
local slotTable = {
    head = 49, 
    legs = 112, 
    armor = 56, 
    feet = 176,
    twohanded = 2096,
    right = 48, 
    left = 48, 
    ring = 304, 
    ammo = 48,
    backpack = 52, 
    necklace = 50
}


local function isValidBrutalWeapon(itemType)
    local weaponType = itemType:getWeaponType()
    return weaponType == WEAPON_CLUB or weaponType == WEAPON_SWORD or weaponType == WEAPON_AXE or weaponType == WEAPON_DISTANCE
end

local function isValidShield(itemType)
    return itemType:getWeaponType() == WEAPON_SHIELD
end

local function upgradeHandler(player, upgradeItem, fromPos, target, toPos, isHotkey)
    print("[MAKER TAGGING] Action triggered by", player:getName())
    
    local makerCfg = MAKER_TAGS[upgradeItem:getId()]
    if not makerCfg then
        print("[MAKER TAGGING][ERROR] Maker config no encontrada.")
        player:sendTextMessage(MESSAGE_STATUS, "Este Maker no es válido.")
        return false
    end

        -- Antes de aplicar tags
    for tag, _ in pairs(makerCfg.tags) do
        if target:getCustomAttribute(tag) ~= nil then
            print("[MAKER TAGGING][FAIL] Item ya tiene el tag:", tag)
            player:sendTextMessage(MESSAGE_STATUS, "Este item ya tiene un maker aplicado.")
            return false
        end
    end

    local itemType = ItemType(target:getId())
    local itemSlotPos = itemType:getSlotPosition()
    print("[MAKER TAGGING][CHECK] Item slotPos:", itemSlotPos, "| Config slots:", table.concat(makerCfg.slots, ", "))

    -- Checa si el slot del item es permitido (DEBE detenerse aquí si no match)
    local match = false
    for _, slot in ipairs(makerCfg.slots) do
        print("[MAKER TAGGING][CHECK] Testing slot:", slot, "| const:", slotTable[slot] or "nil")
        if slotTable[slot] and itemSlotPos == slotTable[slot] then
            print("[MAKER TAGGING][MATCH] Slot allowed:", slot)
            match = true
            break
        else
            print("[MAKER TAGGING][NO MATCH] This slot not matched:", slot)
        end
    end

    if not match then
        print("[MAKER TAGGING][FAIL] Slot not allowed for this maker. itemSlotPos:", itemSlotPos)
        player:sendTextMessage(MESSAGE_STATUS, "Este objeto no es válido para este maker (slot incorrecto).")
        return false
    end

    -- Brutal Maker: Solo para armas reales
    if makerCfg.tags.brutal_maker then
        if not isValidBrutalWeapon(itemType) then
            print("[MAKER TAGGING][FAIL] Brutal Maker solo puede aplicarse a armas reales (no shields ni spellbooks).")
            player:sendTextMessage(MESSAGE_STATUS, "Solo puedes usar el Brutal Maker en armas (club, sword, axe, distance).")
            return false
        end
    end

    -- Double-Force o Magically Shielded: Solo en shields
    if makerCfg.tags.physical_reduction or makerCfg.tags.magic_reduction then
        if not isValidShield(itemType) then
            print("[MAKER TAGGING][FAIL] Este maker solo puede aplicarse en shields.")
            player:sendTextMessage(MESSAGE_STATUS, "Solo puedes usar este maker en escudos.")
            return false
        end
    end

    -- Aplica los tags al item
    for tag, value in pairs(makerCfg.tags) do
        print("[MAKER TAGGING][TAG] Set", tag, "=", value)
        target:setCustomAttribute(tag, value)
    end

    -- Marca la descripción visual para look
    local desc = (target:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or "")

    -- Evita agregar la descripción dos veces
    if not desc:find(makerCfg.desc, 1, true) then
        desc = desc .. "\n" .. makerCfg.desc
    end

    -- Siempre agrega la “It Belongs to …” al final
    desc = desc .. "\nIt Belongs to " .. player:getName() .. "."

    target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
    target:setAttribute(ITEM_ATTRIBUTE_NAME, (makerCfg.prefix or "[MAKER]") .. " " .. (target:getName() or "item"))
    player:sendTextMessage(MESSAGE_STATUS, "Maker aplicado correctamente: " .. makerCfg.name)
    print("[MAKER TAGGING][SUCCESS] Maker aplicado:", makerCfg.name)
    upgradeItem:remove(1)
    return true
end

for makerId, _ in pairs(MAKER_TAGS) do
    local act = Action()
    act:id(makerId)
    act:onUse(upgradeHandler)
    act:register()
end

print("[MAKER TAGGING SYSTEM] All makers registered.")