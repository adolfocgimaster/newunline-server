local testSlots = TalkAction("/slotsdebug")

function testSlots.onSay(player, words, param)
    -- Cambia estos IDs por IDs reales de tu server para cada tipo de equipo
    local testItems = {
        armor = 3388,    -- Demon armor
        legs = 3389,     -- Demon legs
        head = 3390,     -- Demon helmet
        feet = 3555,     -- Boots of haste, por ejemplo
        left = 3334,     -- Shield
        right = 3423,    -- Sword, usa el mismo si no tienes ambos
        ring = 25698,     -- Ring of healing
        backpack = 9601, -- Backpack normal
        necklace = 3013, -- Garlic necklace
        ammo = 3447,     -- Arrow
    }

    for name, id in pairs(testItems) do
        local slotPos = ItemType(id):getSlotPosition()
        print("[SLOT DEBUG]", name, "ItemID:", id, "SlotPosition:", slotPos)
        player:sendTextMessage(MESSAGE_STATUS, name .. ": ItemID " .. id .. " slotPos " .. slotPos)
    end
    return false
end

testSlots:register()
