local forceSpeed = TalkAction("/forcespeed")

function forceSpeed.onSay(player, words, param)
    local item = player:getSlotItem(CONST_SLOT_LEFT) -- O RIGHT, prueba ambos
    if item and item:getCustomAttribute("brutal_maker") then
        local maker = item:getCustomAttribute("brutal_maker")
        local newSpeed = math.floor(2000 / maker)
        player:setAttackSpeed(newSpeed)
        player:sendTextMessage(MESSAGE_STATUS, "Forzado speed: " .. newSpeed)
    else
        player:setAttackSpeed(2000)
        player:sendTextMessage(MESSAGE_STATUS, "Forzado normal: 2000")
    end
    return false
end

forceSpeed:register()
