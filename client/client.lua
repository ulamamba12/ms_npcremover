-- ============================================
-- CONFIG LOADING
-- ============================================

local allowedPeds = {}

for _, model in pairs(Config.AllowedPeds) do
    allowedPeds[model] = true
end

-- ============================================
-- ONE-TIME SETUP FUNCTION
-- ============================================

function ApplyWorldSettings()
    -- Disable garbage trucks (only once, not every frame)
    SetGarbageTrucks(false)
    
    -- Disable random boats (only once, not every frame)
    SetRandomBoats(false)

    -- Disable cops if configured (only once, not every frame)
    if Config.DisableCops then
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        DistantCopCarSirens(false)
    end

    -- Disable ambulance if configured (only once, not every frame)
    if Config.DisableAmbulance then
        EnableDispatchService(5, false)  -- 5 = Ambulance dispatch
    end

    -- Disable fire department if configured (only once, not every frame)
    if Config.DisableFireDepartment then
        EnableDispatchService(3, false)  -- 3 = Fire department dispatch
    end

    -- Additional: Disable police dispatch if you have this flag
    if Config.DisableCops then
        -- Disable ALL police dispatch services
        EnableDispatchService(0, false)  -- 0 = All dispatch services
        
        -- OR disable individually for more control:
        -- EnableDispatchService(1, false)  -- Police cars
        -- EnableDispatchService(2, false)  -- Police helicopters
        -- EnableDispatchService(4, false)  -- Police backup
        -- EnableDispatchService(6, false)  -- Police boats
    end

    print("[INFO] World settings applied successfully!")
end

-- ============================================
-- RUN SETUP ON RESOURCE START
-- ============================================

CreateThread(function()
    -- Wait for game to fully load
    Citizen.Wait(1000)
    ApplyWorldSettings()
end)

-- ============================================
-- RE-APPLY ON PLAYER SPAWN (Game resets these after respawn)
-- ============================================

RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    -- Wait a bit after spawn
    Citizen.Wait(500)
    ApplyWorldSettings()
    print("[INFO] World settings re-applied after player spawn!")
end)

-- ============================================
-- PER-FRAME LOOP (ONLY density multipliers that need per-frame refresh)
-- ============================================

CreateThread(function()
    while true do
        Citizen.Wait(0)  -- Runs every frame

        -- ============================================
        -- DENSITY MULTIPLIERS (These genuinely need per-frame re-application)
        -- ============================================
        
        SetVehicleDensityMultiplierThisFrame(Config.VehicleDensity)
        SetPedDensityMultiplierThisFrame(Config.PedDensity)
        SetRandomVehicleDensityMultiplierThisFrame(Config.RandomVehicleDensity)
        SetParkedVehicleDensityMultiplierThisFrame(Config.ParkedVehicleDensity)
        SetScenarioPedDensityMultiplierThisFrame(
            Config.ScenarioPedDensity,
            Config.ScenarioPedDensity
        )

        -- ============================================
        -- REMOVED FROM HERE (Now in ApplyWorldSettings):
        -- SetGarbageTrucks(false)      -- MOVED to ApplyWorldSettings
        -- SetRandomBoats(false)        -- MOVED to ApplyWorldSettings
        -- SetCreateRandomCops(false)   -- MOVED to ApplyWorldSettings
        -- DistantCopCarSirens(false)   -- MOVED to ApplyWorldSettings
        -- EnableDispatchService        -- MOVED to ApplyWorldSettings
        -- ============================================
    end
end)

-- ============================================
-- PED AND VEHICLE CLEANUP THREAD (Runs every 500ms)
-- ============================================

CreateThread(function()
    while true do
        Citizen.Wait(500)  -- Runs every 500ms (not every frame)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local radius = Config.CleanupRadius or 50.0

        -- ============================================
        -- DELETE NEARBY PEDS
        -- ============================================
        
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

        -- ============================================
        -- DELETE NEARBY VEHICLES
        -- ============================================
        
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