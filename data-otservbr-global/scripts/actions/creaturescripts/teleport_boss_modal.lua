local creatureEvent = CreatureEvent("TeleportBossModal")

function creatureEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
    print("[DEBUG] onModalWindow triggered. Modal ID:", modalWindowId, "Button:", buttonId, "Choice:", choiceId)

    if modalWindowId ~= 20251 then
        return false
    end

    if buttonId ~= 0 then
        print("[DEBUG] Player clicked Cancel.")
        return true
    end

    local bosses = _G.bossTeleportData and _G.bossTeleportData[player:getId()]
    if not bosses then
        player:sendCancelMessage("Teleport failed.")
        print("[DEBUG] No boss data found for player ID:", player:getId())
        return true
    end

    local selected = bosses[choiceId + 1]
    if not selected then
        player:sendCancelMessage("Invalid selection.")
        print("[DEBUG] Invalid choice ID:", choiceId)
        return true
    end

    local config = {
        price = 10000,
        storage = 9100,
        cooldown = 10
    }

    if not player:removeMoneyBank(config.price) then
        player:sendCancelMessage("Transaction failed.")
        print("[DEBUG] Could not remove money.")
        return true
    end

    print("[DEBUG] Teleporting player to:", selected.name)
    player:teleportTo(selected.position)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleported to " .. selected.name)
    player:setStorageValue(config.storage, os.time() + config.cooldown)
    _G.bossTeleportData[player:getId()] = nil
    return true
end


creatureEvent:register()
