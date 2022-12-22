local QBCore = exports['qb-core']:GetCoreObject()

local ScratchTable = nil

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(ScratchTable)
    end
end)

CreateThread(function ()
    local coords = Config.Properties.toolboxlocation
    local hash = Config.Properties.toolboxhash
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

function ShowWeapons()
    local player = PlayerPedId()
    local playeritems = QBCore.Functions.GetPlayerData().items
    if IsPedArmed(player, 7) then
        SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    end
    local header = {
        {
            isMenuHeader = true,
            icon = "fas fa-bars",
            header = "Available Weapons",
            txt = "",
        }
    }
    for k, v in pairs(playeritems) do
        if QBCore.Shared.Items[v.name]["type"] == 'weapon' then
            header[#header+1] = {
                header = QBCore.Shared.Items[v.name]["label"],
                txt = 'Inventory Slot: '..v.slot..'<br><span style="color:#64e887; font-weight: bold;">Serial: '..v.info.serie.."<br><span style='color:#e86464; font-weight: bold; text-transform: uppercase;'>Scratch Serial",
                icon = 'fas fa-circle',
                params = {
                    isServer = true,
                    event = 'kevin-weaponscratch:scratchserial',
                    args = {
                        weapon = v.name,
                        ammo = v.info.ammo,
                        quality = v.info.quality,
                        serial = v.info.serie,
                        slot = v.slot
                    }
                }
            }
        end
    end
    header[#header+1] = {
        header = "Close Drawer",
        icon = "fas fa-xmark",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(header)
end