-- talkaction: /itemtags <slot|itemid>
local itemTags = TalkAction("/itemtags")

function itemTags.onSay(player, words, param)
    local item
    local txt = ""

    -- Permite buscar por nombre de slot o por itemid
    local slotNames = {
        head = CONST_SLOT_HEAD, armor = CONST_SLOT_ARMOR, legs = CONST_SLOT_LEGS, feet = CONST_SLOT_FEET,
        left = CONST_SLOT_LEFT, right = CONST_SLOT_RIGHT, ring = CONST_SLOT_RING, ammo = CONST_SLOT_AMMO,
        backpack = CONST_SLOT_BACKPACK, necklace = CONST_SLOT_NECKLACE
    }

    if slotNames[param] then
        item = player:getSlotItem(slotNames[param])
        if not item then
            player:sendTextMessage(MESSAGE_STATUS, "No item equipped in slot: " .. param)
            return false
        end
        txt = "Custom attributes for item in slot [" .. param .. "]:\n"
    else
        local id = tonumber(param)
        if id then
            for i = 1, player:getInventorySlots() do
                local invItem = player:getSlotItem(i)
                if invItem and invItem:getId() == id then
                    item = invItem
                    txt = "Custom attributes for item ID [" .. id .. "] in slot " .. i .. ":\n"
                    break
                end
            end
        end
    end

    if not item then
        player:sendTextMessage(MESSAGE_STATUS, "Item not found. Use: /itemtags head | armor | legs | ... | <itemid>")
        return false
    end

    local found = false
    for _, key in ipairs({
        "brutal_maker", "supreme_hp_percent", "supreme_mp_percent", "skill_sword", "skill_axe", "skill_club", "skill_dist", "skill_shield",
        "magic_level", "walk_speed_percent", "spell_cooldown_percent", "hp_regen", "mp_regen", "magic_reduction", "physical_reduction"
    }) do
        local val = item:getCustomAttribute(key)
        if val ~= nil then
            txt = txt .. "• " .. key .. " = " .. tostring(val) .. "\n"
            found = true
        end
    end

    if not found then
        txt = txt .. "No custom attributes found."
    end

    player:sendTextMessage(MESSAGE_STATUS, txt)
    print("[ITEMTAGS DEBUG]\n" .. txt)
    return false
end

itemTags:register()
