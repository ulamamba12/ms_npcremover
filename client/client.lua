local allowedPeds = {}

for _, model in pairs(Config.AllowedPeds) do
    allowedPeds[model] = true
end

-- Dispatch service IDs grouped by emergency type.
-- See DISPATCH_TYPE: police covers cars, helis, bikes, requests, roadblocks and boats.
local DISPATCH = {
    cops      = { 1, 2, 6, 7, 8, 9, 10, 13 },
    swat      = { 4, 12 },
    fire      = { 3 },
    ambulance = { 5 },
    army      = { 14 },
    gangs     = { 11 },
}

local function disableServices(list)
    for _, id in ipairs(list) do
        EnableDispatchService(id, false)
    end
end

-- Persistent world toggles. These are NOT per-frame natives, so they only need
-- to run once on start and be re-applied after a respawn (the game can reset them).
local function applyWorldToggles()
    SetGarbageTrucks(false)
    SetRandomBoats(false)

    if Config.DisableCops then
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        DistantCopCarSirens(false)
        disableServices(DISPATCH.cops)
    end

    if Config.DisableSwat then disableServices(DISPATCH.swat) end
    if Config.DisableFireDepartment then disableServices(DISPATCH.fire) end
    if Config.DisableAmbulance then disableServices(DISPATCH.ambulance) end
    if Config.DisableArmy then disableServices(DISPATCH.army) end
    if Config.DisableGangs then disableServices(DISPATCH.gangs) end
end

AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        applyWorldToggles()
    end
end)

AddEventHandler('playerSpawned', applyWorldToggles)

-- Density multipliers use *ThisFrame natives, so they must be re-applied every frame.
CreateThread(function()
    while true do
        Wait(0)

        SetVehicleDensityMultiplierThisFrame(Config.VehicleDensity)
        SetPedDensityMultiplierThisFrame(Config.PedDensity)
        SetRandomVehicleDensityMultiplierThisFrame(Config.RandomVehicleDensity)
        SetParkedVehicleDensityMultiplierThisFrame(Config.ParkedVehicleDensity)
        SetScenarioPedDensityMultiplierThisFrame(
            Config.ScenarioPedDensity,
            Config.ScenarioPedDensity
        )
    end
end)

CreateThread(function()
    while true do
        Wait(500)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local radius = Config.CleanupRadius or 50.0 -- Default 50 meters

        if Config.DeleteNearbyPeds then
            local handle, ped = FindFirstPed()
            local success

            if handle and handle ~= -1 then
                repeat
                    if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                        local pedCoords = GetEntityCoords(ped)
                        if #(playerCoords - pedCoords) <= radius then
                            local model = GetEntityModel(ped)
                            if not allowedPeds[model] then
                                DeleteEntity(ped)
                            end
                        end
                    end
                    success, ped = FindNextPed(handle)
                until not success
                EndFindPed(handle)
            end
        end

        if Config.DeleteNearbyVehicles then
            local handle, vehicle = FindFirstVehicle()
            local success

            if handle and handle ~= -1 then
                repeat
                    if DoesEntityExist(vehicle) then
                        local driver = GetPedInVehicleSeat(vehicle, -1)
                        if driver ~= 0 and not IsPedAPlayer(driver) then
                            local vehCoords = GetEntityCoords(vehicle)
                            if #(playerCoords - vehCoords) <= radius then
                                DeleteEntity(vehicle)
                            end
                        end
                    end
                    success, vehicle = FindNextVehicle(handle)
                until not success
                EndFindVehicle(handle)
            end
        end
    end
end)
