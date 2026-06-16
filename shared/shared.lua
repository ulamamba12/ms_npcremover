Config = {}

-- ============================================
-- DENSITY SETTINGS
-- ============================================

Config.VehicleDensity = 0.0
Config.PedDensity = 0.5
Config.RandomVehicleDensity = 0.0
Config.ParkedVehicleDensity = 0.0
Config.ScenarioPedDensity = 0.5

-- ============================================
-- DISABLE SERVICES
-- ============================================

Config.DisableCops = true           -- Disable ALL police (cops, dispatch, sirens)
Config.DisableAmbulance = true      -- Disable ambulance dispatch
Config.DisableFireDepartment = true -- Disable fire department dispatch

-- Additional flags for emergency services
Config.DisableSwat = false          -- Disable SWAT response
Config.DisableArmy = false          -- Disable military response
Config.DisableGangs = false         -- Disable gang spawns

-- ============================================
-- WORLD SETTINGS
-- ============================================

Config.DisableGarbageTrucks = true  -- Disable garbage trucks
Config.DisableRandomBoats = true    -- Disable random boats
Config.DisableDistantSirens = true  -- Disable distant sirens

-- ============================================
-- CLEANUP SETTINGS
-- ============================================

Config.DeleteNearbyPeds = false
Config.DeleteNearbyVehicles = true
Config.CleanupRadius = 50.0

-- ============================================
-- ALLOWED PEDS (Not deleted)
-- ============================================

Config.AllowedPeds = {
    -- Add ped models you want to keep
    -- Example:
    -- "a_m_m_farmer_01",
    -- "a_f_y_beach_01",
}