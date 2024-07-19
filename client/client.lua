local QBCore = exports['qb-core']:GetCoreObject()

local ScratchTable = nil
local usingox = GetResourceState('ox_inventory') == 'started'

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(ScratchTable)
    end
end)

local function ShowWeapons()
    if IsPedArmed(cache.ped, 7) then
        TriggerEvent('weapons:ResetHolster')
        SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
    end

    local resgisteredMenu = {
        id = 'kevin-weaponscratch',
        title = 'Available Weapons',
        options = {}
    }
    local options = {}

    if usingox then
        local playeritems = exports.ox_inventory:GetPlayerItems()
        local items = exports.ox_inventory:Items()

        for _, v in pairs(playeritems) do
            if items[v.name] and items[v.name].weapon and v.metadata.serial ~= 'Scratched' then
                options[#options+1] = {
                    title = items[v.name]["label"],
                    description = 'Scratch Weapon Serial',
                    metadata = {
                        {label = 'Serial', value = v.metadata.serial},
                        {label = 'Slot', value = v.slot},
                    },
                    serverEvent = 'kevin-weaponscratch:scratchserial',
                    args = {
                        weapon = v.name,
                        slot = v.slot
                    }
                }
            end
        end
    else
        local playeritems = QBCore.Functions.GetPlayerData().items

        for _, v in pairs(playeritems) do
            if QBCore.Shared.Items[v.name]["type"] == 'weapon' and v.info.serie ~= 'Scratched' then
                options[#options+1] = {
                    title = QBCore.Shared.Items[v.name]["label"],
                    description = 'Scratch Weapon Serial',
                    metadata = {
                        {label = 'Serial', value = v.info.serie},
                        {label = 'Slot', value = v.slot},
                    },
                    serverEvent = 'kevin-weaponscratch:scratchserial',
                    args = {
                        weapon = v.name,
                        slot = v.slot
                    }
                }
            end
        end
    end

    resgisteredMenu["options"] = options
    lib.registerContext(resgisteredMenu)
    lib.showContext('kevin-weaponscratch')
end

CreateThread(function ()
    local coords = vector4(726.12, -1074.31, 28.31, 183.06)
    local hash = `prop_toolchest_05`
    QBCore.Functions.LoadModel(hash)
    ScratchTable = CreateObject(hash, coords.x, coords.y, coords.z -1, true, true, true)
    SetEntityHeading(ScratchTable, coords.w)
    FreezeEntityPosition(ScratchTable, true)

    exports['qb-target']:AddTargetEntity(ScratchTable, {
        options = {
            {
                icon = 'fas fa-screwdriver',
                label = 'Use Tools',
                action = function()
                    ShowWeapons()
                end,
            },
        },
        distance = 2.0
    })
end)
