local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kevin-weaponscratch:scratchserial', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local weapon = Player.Functions.GetItemBySlot(data.slot)
    if weapon.name ~= data.weapon then return end
    if weapon.serial ~= 'Scratched' then
        if not Player.Functions.RemoveItem(weapon.name, 1, weapon.slot) then return end
        TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[weapon.name], 'remove')
        Wait(400)
        local info = {}
        info.serie = 'Scratched'
        info.quality = weapon.quality
        info.ammo = weapon.ammo
        Player.Functions.AddItem(weapon.name, 1, weapon.slot, info)
        TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[weapon.name], 'add')
    end
end)
