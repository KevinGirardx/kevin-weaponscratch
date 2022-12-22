local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kevin-weaponscratch:scratchserial', function (data)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local weapon = Player.Functions.GetItemByName(data.weapon)
    print(data.slot)
    if weapon then
        print(data.serial)
        if data.serial == Config.Properties.scratchedtext then
            TriggerClientEvent('QBCore:Notify', PlayerId, 'Serial already scratched..', 'error')
        else
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[weapon.name], 'remove')
            Player.Functions.RemoveItem(weapon.name, 1, data.slot)
            Wait(400)

            local info = {}
            info.serie = Config.Properties.scratchedtext
            info.quality = data.quality
            info.ammo = data.ammo
            Player.Functions.AddItem(weapon.name, 1, data.slot, info)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[weapon.name], 'add')
        end
    end
end)