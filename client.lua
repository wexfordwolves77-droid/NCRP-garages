local garages = {
    {name = "Legion Square", coords = vector3(215.9, -810.65, 30.73)},
    {name = "Sandy Shores", coords = vector3(1737.76, 3710.56, 34.13)},
    {name = "Paleto Bay", coords = vector3(-75.15, 6276.96, 31.09)},
    {name = "Airport", coords = vector3(-1034.6, -2733.6, 13.8)},
    {name = "Vespucci", coords = vector3(-1184.25, -1510.0, 4.65)},
    {name = "Mirror Park", coords = vector3(1037.6, -766.9, 57.3)},
    {name = "Del Perro", coords = vector3(-1472.5, -537.2, 34.5)},
    {name = "Rockford Hills", coords = vector3(-1570.1, -558.1, 108.5)},
    {name = "Alta", coords = vector3(-321.8, -133.2, 38.0)},
    {name = "Downtown Vinewood", coords = vector3(294.5, -1344.9, 31.0)},
    {name = "East Vinewood", coords = vector3(894.2, -2106.1, 30.8)},
    {name = "La Mesa", coords = vector3(832.1, -1002.4, 26.5)},
    {name = "El Burro Heights", coords = vector3(1385.8, -2057.1, 52.0)},
    {name = "Strawberry", coords = vector3(236.4, -1398.7, 30.5)},
    {name = "Davis", coords = vector3(401.4, -1631.6, 29.3)},
    {name = "Harmony", coords = vector3(570.0, 2736.5, 42.0)},
    {name = "Grapeseed", coords = vector3(1707.5, 4776.5, 42.0)},
    {name = "Fort Zancudo", coords = vector3(-2047.5, 3132.5, 32.8)}
}

Citizen.CreateThread(function()
    for _, garage in pairs(garages) do
        local blip = AddBlipForCoord(garage.coords)
        SetBlipSprite(blip, 357)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garage.name)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterCommand("garage", function()
    ESX.TriggerServerCallback('garage:getVehicles', function(vehicles)
        for _, v in pairs(vehicles) do
            if v.stored then
                print("Stored Vehicle: " .. v.plate)
            else
                print("Out Vehicle: " .. v.plate)
            end
        end
    end)
end)

RegisterCommand("store", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    TriggerServerEvent('garage:storeVehicle', props)
    DeleteVehicle(vehicle)
end)

RegisterCommand("retrieve", function()
    local plate = "ABC123" -- Replace with UI or input
    TriggerServerEvent('garage:retrieveVehicle', plate)
    ESX.Game.SpawnVehicle(plate, GetEntityCoords(PlayerPedId()), 0.0, function(vehicle)
        SetVehicleNumberPlateText(vehicle, plate)
    end)
end)
