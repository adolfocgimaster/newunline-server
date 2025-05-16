local login = CreatureEvent("PlayerLogin")

function login.onLogin(player)
    player:registerEvent("supremeCubeModal")
    player:registerEvent("TeleportBossModal")
    return true
end

login:register()
