local combat = Combat()

local spell = Spell("instant")

function spell.onCastSpell(player, var)
    player:setAttackSpeed(400) -- velocidad temporal aumentada

    addEvent(function()
        player:setAttackSpeed(player:getVocation():getAttackSpeed()) -- restaurar
    end, 5000)

    return combat:execute(player, var)
end

spell:group("support")
spell:id(80)
spell:name("Rapid Smithing")
spell:words("revo max hur")
spell:level(0)
spell:mana(0)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()
