local supremeCube = Action()

local config = {
    price = 50000,
    storage = 9007,
    cooldown = 2,
    towns = {
        { name = "Ab'Dendriel", teleport = Position(32732 , 31634 , 7) },
        { name = "Aurora", teleport = Position(29146, 32242, 7) },
        { name = "Dry Creek", teleport = Position(29727, 31412, 7) },
        { name = "Greenville", teleport = Position(29897, 31540, 6) },
        { name = "Ankrahmun", teleport = Position(33194 , 32853 , 8) },
        { name = "Carlin", teleport = Position(32360 , 31782 , 7) },
        { name = "Darashia", teleport = Position(33213 , 32454 , 1) },
        { name = "Edron", teleport = Position(33217 , 31814 , 8) },
        { name = "Farmine", teleport = Position(33023 , 31521 , 11) },
        { name = "Issavi", teleport = Position(33921 , 31477 , 5) },
        { name = "Kazordoon", teleport = Position(32649 , 31925 , 11) },
        { name = "Krailos", teleport = Position(33657 , 31665 , 8) },
        { name = "Liberty Bay", teleport = Position(32317 , 32826 , 7) },
        { name = "Marapur", teleport = Position(33842 , 32853 , 7) },
        { name = "Port Hope", teleport = Position(32594 , 32745 , 7) },
        { name = "Rathleton", teleport = Position(33594 , 31899 , 6) },
        { name = "Roshamuul", teleport = Position(33513 , 32363 , 6) },
        { name = "Svargrond", teleport = Position(32212 , 31132 , 7) },
        { name = "Thais", teleport = Position(32369 , 32241 , 7) },
        { name = "Venore", teleport = Position(32957 , 32076 , 7) },
        { name = "Yalahar", teleport = Position(32787 , 31276 , 7) },
    }
}

function supremeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
        player:sendCancelMessage("You must be in a protection zone.")
        return false
    end

    if player:isPzLocked() or player:getCondition(CONDITION_INFIGHT) then
        player:sendCancelMessage("You can't use this while in a fight.")
        return false
    end

    if player:getMoney() + player:getBankBalance() < config.price then
        player:sendCancelMessage("You don't have enough money.")
        return false
    end

    local cooldown = player:getStorageValue(config.storage)
    if cooldown > os.time() then
        local remaining = cooldown - os.time()
        player:sendCancelMessage("You can use it again in " .. remaining .. " seconds.")
        return false
    end

    local towns = {}
    local house = player:getHouse()
    if house then
        table.insert(towns, { name = "House", teleport = house:getExitPosition() })
    end
    for _, town in ipairs(config.towns) do
        table.insert(towns, town)
    end

    _G.supremeCubeData = _G.supremeCubeData or {}
    _G.supremeCubeData[player:getId()] = towns

    local window = ModalWindow(1001, "Supreme Cube", "Select a city - Price: " .. config.price .. " gold.")
    for i, town in ipairs(towns) do
        window:addChoice(i - 1, town.name)
    end
    window:addButton(0, "Select")
    window:addButton(1, "Cancel")
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(1)
    window:sendToPlayer(player)

    return true
end

supremeCube:id(31633) -- Reemplaza con el ID real del ítem
supremeCube:register()
