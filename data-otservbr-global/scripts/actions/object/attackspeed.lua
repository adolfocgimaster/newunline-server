local SPEED_SCROLL_ID = 7410
local FASTER_ATTACK_SPEED = 500

local speedUpgrade = Action()

function speedUpgrade.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    print("[DEBUG] speedUpgrade.onUse called")

    if not target then
        print("[DEBUG] No target item.")
        player:sendCancelMessage("Debes usar esto sobre un ítem.")
        return true
    end

    if not target:isItem() then
        print("[DEBUG] Target no es un item.")
        player:sendCancelMessage("Debes usar esto sobre un ítem.")
        return true
    end

    local itemType = target:getType()
    print("[DEBUG] Target ID:", target:getId(), "Name:", itemType:getName())

    local weaponType = itemType:getWeaponType()
    print("[DEBUG] Weapon type:", weaponType)

    if weaponType == WEAPON_NONE then
        print("[DEBUG] No es un arma.")
        player:sendCancelMessage("Este ítem no es un arma.")
        return true
    end

    local currentSpeed = target:getAttribute(ITEM_ATTRIBUTE_ATTACKSPEED)
    print("[DEBUG] Current attack speed:", currentSpeed)

    if currentSpeed and currentSpeed <= FASTER_ATTACK_SPEED then
        print("[DEBUG] Ya tiene attack speed mejorado.")
        player:sendCancelMessage("Esta arma ya tiene velocidad mejorada.")
        return true
    end

    local set = target:setAttribute(ITEM_ATTRIBUTE_ATTACKSPEED, FASTER_ATTACK_SPEED)
    print("[DEBUG] setAttribute result:", set)

    local desc = target:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
    print("[DEBUG] Current description:", desc)

    if not desc:lower():find("speed") then
        local newDesc = desc .. "\nUpgraded with 2x increased attack speed."
        target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, newDesc)
        print("[DEBUG] Description updated:", newDesc)
    end

    item:remove(1)
    print("[DEBUG] Upgrade scroll removed")

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Has mejorado la velocidad de esta arma.")
    toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)

    return true
end

speedUpgrade:id(SPEED_SCROLL_ID)
speedUpgrade:register()
