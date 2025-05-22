local applyMakerBonus = dofile('/opt/canary-dev/data-otservbr-global/scripts/lib/maker_bonus.lua')
print("[DEBUG] ¿Cargó la lib? ->", applyMakerBonus)

local itemsMakers = {
    { itemid = 39693, slot = "backpack" },
    { itemid = 39235, slot = "necklace" }
}

local registered = {}
local registrationTable = {}

for _, i in ipairs(itemsMakers) do
    local key = tostring(i.itemid) .. ":" .. tostring(i.slot)
    if not registered[key] then
        table.insert(registrationTable, {itemid = i.itemid, slot = i.slot})
        registered[key] = true
    end
end

for _, entry in ipairs(registrationTable) do
    local movement = MoveEvent()
    movement:id(entry.itemid)
    if entry.slot then movement:slot(entry.slot) end

    function movement.onEquip(player, item, slot)
        print("[EQUIP DEBUG]", player:getName(), item:getId(), slot)
        applyMakerBonus(player, item, slot, true)
        return true
    end

    function movement.onDeEquip(player, item, slot)
        print("[DEEQUIP DEBUG]", player:getName(), item:getId(), slot)
        applyMakerBonus(player, item, slot, false)
        return true
    end

    movement:register()
end
