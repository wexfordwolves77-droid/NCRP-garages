ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('garage:storeVehicle', function(vehicleProps)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plate = vehicleProps.plate
    MySQL.update('UPDATE owned_vehicles SET stored = true WHERE plate = ?', {plate})
end)

RegisterNetEvent('garage:retrieveVehicle', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.update('UPDATE owned_vehicles SET stored = false WHERE plate = ?', {plate})
end)

ESX.RegisterServerCallback('garage:getVehicles', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ?', {xPlayer.identifier})
    cb(result)
end)
