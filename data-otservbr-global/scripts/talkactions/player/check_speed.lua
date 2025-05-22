local speedCommand = TalkAction("!speed")

function speedCommand.onSay(player, words, param)
    local speed = player:getAttackSpeed()
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Tu velocidad de ataque actual es: " .. tostring(speed) .. " ms por golpe.")
    return false
end

speedCommand:register()
