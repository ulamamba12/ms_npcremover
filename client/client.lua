local allowedPeds = {}

for _, model in pairs(Config.AllowedPeds) do
    allowedPeds[model] = true
end

CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        SetVehicleDensityMultiplierThisFrame(Config.VehicleDensity)
        SetPedDensityMultiplierThisFrame(Config.PedDensity)
        SetRandomVehicleDensityMultiplierThisFrame(Config.RandomVehicleDensity)
        SetParkedVehicleDensityMultiplierThisFrame(Config.ParkedVehicleDensity)
        SetScenarioPedDensityMultiplierThisFrame(
            Config.ScenarioPedDensity,
            Config.ScenarioPedDensity
        )

        SetGarbageTrucks(false)
        SetRandomBoats(false)

        if Config.DisableCops then
            SetCreateRandomCops(false)
            SetCreateRandomCopsNotOnScenarios(false)
            SetCreateRandomCopsOnScenarios(false)
            DistantCopCarSirens(false)
        end

        if Config.DisableAmbulance then
            EnableDispatchService(5, false)
        end

        if Config.DisableFireDepartment then
            EnableDispatchService(3, false)
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(500)

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