local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kevin-weaponscratch:scratchserial', function (data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local weapon = Player.Functions.GetItemByName(data.weapon)
    if weapon then
        if weapon.info.isScratched then
            TriggerClientEvent('QBCore:Notify', PlayerId, 'Serial already scratched..', 'error')
        else
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[weapon.name], 'remove')
            local oldSerial = weapon.info.serie
            local oldQuality = weapon.info.quality
            local oldAmmo = weapon.info.ammo
            Player.Functions.RemoveItem(weapon.name, 1, data.slot)
            Wait(400)

            local info = {}
            info.serie = oldSerial
            info.isScratched = true
            info.quality = oldQuality
            info.ammo = oldAmmo
            Player.Functions.AddItem(weapon.name, 1, data.slot, info)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[weapon.name], 'add')
        end
    end
end)
