local speedCommand = TalkAction("!speed")

function speedCommand.onSay(player, words, param)
    local speed = player:getAttackSpeed()
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Tu velocidad de ataque actual es: " .. tostring(speed) .. " ms por golpe.")
    print(speed)
    return false
end

speedCommand:register()
