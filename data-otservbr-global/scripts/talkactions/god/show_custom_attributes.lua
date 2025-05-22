local showCustom = TalkAction("/showcustom")

local customKeys = {
    "brutal_maker",
    "attackUpgrade", "defenseUpgrade", "armorUpgrade",
    "maxHealthUpgrade", "maxManaUpgrade",
    "originalAttack", "originalDefense", "originalArmor",
    "originalHealth", "originalMana"
}

function showCustom.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        player:sendCancelMessage("No access.")
        return false
    end

    -- Apunta al item frente a ti
    local pos = player:getPosition()
    pos:getNextPosition(player:getDirection(), 1)
    local tile = Tile(pos)
    if not tile then
        player:sendCancelMessage("No tile found.")
        return false
    end
    local item = tile:getTopDownItem() or tile:getTopItem()
    if not item or not item:isItem() then
        player:sendCancelMessage("No item found.")
        return false
    end

    local msg = "Custom Attributes for item [" .. item:getId() .. "] " .. (item:getName() or "") .. ":\n"
    local found = false
    for _, key in ipairs(customKeys) do
        local v = item:getCustomAttribute(key)
        if v ~= nil then
            msg = msg .. key .. " = " .. tostring(v) .. "\n"
            found = true
        end
    end
    if not found then
        msg = msg .. "No known custom attributes found."
    end

    player:popupFYI(msg)
    print("[SHOWCUSTOM] ItemId:", item:getId(), msg)
    return false
end

showCustom:register()
