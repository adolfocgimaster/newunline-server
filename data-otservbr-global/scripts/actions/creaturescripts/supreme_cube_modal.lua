local creatureEvent = CreatureEvent("supremeCubeModal")

function creatureEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
    if modalWindowId ~= 1001 then
        return false
    end

    if buttonId ~= 0 then
        return true
    end

    local towns = _G.supremeCubeData and _G.supremeCubeData[player:getId()]
    if not towns then
        player:sendCancelMessage("Teleport failed.")
        return true
    end

    local selectedTown = towns[choiceId + 1]
    if not selectedTown then
        player:sendCancelMessage("Invalid selection.")
        return true
    end

    local config = {
        price = 50000,
        storage = 9007,
        cooldown = 2
    }

    if not player:removeMoneyBank(config.price) then
        player:sendCancelMessage("Transaction failed.")
        return true
    end

    player:teleportTo(selectedTown.teleport)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to " .. selectedTown.name)
    player:setStorageValue(config.storage, os.time() + config.cooldown)
    _G.supremeCubeData[player:getId()] = nil
    return true
end

creatureEvent:register()
