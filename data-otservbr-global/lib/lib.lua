-- Core API functions implemented in Lua
-- Load storages first
dofile(DATA_DIRECTORY.. '/lib/core/load.lua')

-- Compatibility library for our old Lua API
dofile(DATA_DIRECTORY.. '/lib/compat/compat.lua')

-- Tables library
dofile(DATA_DIRECTORY.. '/lib/tables/load.lua')

-- Others library
dofile(DATA_DIRECTORY.. '/lib/others/load.lua')

-- Quests library
dofile(DATA_DIRECTORY.. '/lib/quests/quest.lua')


local STORAGE_BRUTAL  = 101013
local BASE_ATTACK_SPEED = 2000

function applyMakerBonus(player, item, slot, apply)
    if not item then
        print("[MAKER BONUS][DEBUG] No item encontrado para aplicar bonus.")
        return
    end
    print("[MAKER BONUS][DEBUG] Revisando item ID:", item:getId(), "| Slot:", slot, "| apply:", tostring(apply))

    -- BRUTAL (attack speed)
    local brutal = item:getCustomAttribute("brutal_maker")
    if brutal then
        local newSpeed = math.floor(BASE_ATTACK_SPEED / brutal)
        local stored = player:getStorageValue(STORAGE_BRUTAL)
        print("[BRUTAL][DEBUG] newSpeed:", newSpeed, "| stored:", stored)

        if apply and stored ~= newSpeed then
            print("[BRUTAL][APPLY] Cambiando attackSpeed a:", newSpeed)
            player:setAttackSpeed(newSpeed)
            player:setStorageValue(STORAGE_BRUTAL, newSpeed)
            player:sendTextMessage(MESSAGE_STATUS, "[Maker] Brutal x"..brutal.." ("..newSpeed.." ms)")
        elseif not apply and stored ~= -1 then
            print("[BRUTAL][REMOVE] Restaurando attackSpeed a base:", BASE_ATTACK_SPEED)
            player:setAttackSpeed(BASE_ATTACK_SPEED)
            player:setStorageValue(STORAGE_BRUTAL, -1)
            player:sendTextMessage(MESSAGE_STATUS, "[Maker] Brutal removed.")
        end
    else
        print("[BRUTAL][DEBUG] No hay atributo brutal_maker en este item.")
    end
end

