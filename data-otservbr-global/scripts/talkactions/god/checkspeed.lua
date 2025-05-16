local talk = TalkAction("/checkspeed")

function talk.onSay(player, words, param)
    print("[DEBUG] Comando /checkspeed ejecutado.")

    -- Obtener la posición frente al jugador
    local position = player:getPosition()
    local direction = player:getDirection()

    -- Obtener la posición del tile frente al jugador
    position = position:getNextPosition(direction)

    -- Obtener el tile en esa posición
    local tile = Tile(position)
    if not tile then
        player:sendCancelMessage("No hay tile enfrente.")
        print("[DEBUG] No se encontró un tile enfrente.")
        return false
    end

    -- Buscar un ítem válido en el tile
    local item = nil
    for _, thing in ipairs(tile:getThings()) do
        if thing:isItem() then  -- Verifica que es un ítem
            item = thing
            break
        end
    end

    if not item then
        player:sendCancelMessage("No se encontró ningún ítem enfrente.")
        print("[DEBUG] No se encontró ningún ítem válido.")
        return false
    end

    -- Obtener atributos del ítem
    local itemId = item:getId()
    local itemName = item:getName()
    local attackSpeed = item:getAttribute(ITEM_ATTRIBUTE_ATTACKSPEED)

    local itemType = ItemType(itemId)
    local weaponType = itemType and itemType:getWeaponType() or -1

    local weaponTypeName = ({
        [-1] = "No definido",
        [WEAPON_SWORD] = "Sword",
        [WEAPON_CLUB] = "Club",
        [WEAPON_AXE] = "Axe",
        [WEAPON_DIST] = "Distance",
        [WEAPON_WAND] = "Wand",
        [WEAPON_AMMO] = "Ammo",
    })[weaponType] or "Otro"

    local message = string.format(
        "Item: %s (ID: %d)\nWeapon Type: %s\nAttack Speed: %s",
        itemName,
        itemId,
        weaponTypeName,
        attackSpeed and tostring(attackSpeed) or "no definido"
    )

    print("[DEBUG] Mensaje generado:", message)
    player:popupFYI(message)
    return false
end

talk:separator(" ")
talk:register()
