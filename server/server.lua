local QBCore = exports['qb-core']:GetCoreObject()
local usingox = GetResourceState('ox_inventory') == 'started'

RegisterNetEvent('kevin-weaponscratch:scratchserial', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if usingox then
        local weapon = exports.ox_inventory:GetSlot(src, data.slot)
        if weapon.name ~= data.weapon then return end
        local Item = Player.Functions.GetItemByName('steelfile')
        if Item then
            if weapon.metadata.serial ~= 'Scratched' then
                weapon.metadata.serial = 'Scratched'
                exports.ox_inventory:SetMetadata(source, weapon.slot, weapon.metadata)
                TriggerClientEvent("QBCore:Notify", src, 'Successfully scratched weapon serial number', "success")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, 'You do not have any tools for this..', "error")
        end
    else
        local weapon = Player.Functions.GetItemBySlot(data.slot)
        if weapon.name ~= data.weapon then return end
        local Item = Player.Functions.GetItemByName('steelfile')
        if Item then
            if weapon.info.serial ~= 'Scratched' then
                if not Player.Functions.RemoveItem(weapon.name, 1, weapon.slot) then return end
                TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[weapon.name], 'remove')
                Wait(400)
                local info = {}
                info.serie = 'Scratched'
                info.quality = weapon.info.quality
                info.ammo = weapon.info.ammo
                Player.Functions.AddItem(weapon.name, 1, weapon.slot, info)
                TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[weapon.name], 'add')
            end
        else
            TriggerClientEvent("QBCore:Notify", src, 'You do not have any tools for this..', "error")
        end
    end
end)
