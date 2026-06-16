Config = {}

-- Density 0.0 - 1.0

Config.VehicleDensity = 0.0
Config.PedDensity = 0.3
Config.RandomVehicleDensity = 0.0
Config.ParkedVehicleDensity = 0.0
Config.ScenarioPedDensity = 0.3

-- Disable emergency services
Config.DisableCops = true
Config.DisableAmbulance = true
Config.DisableFireDepartment = true

-- Remove generated NPCs
Config.DeleteNearbyPeds = false
Config.DeleteNearbyVehicles = true

-- Radius cleanup
Config.CleanupRadius = 150.0

-- Allowed Type of NPC Spawn
Config.AllowedPeds = {
    -- contoh:
--     `a_f_m_bevhills_01`,
--     `a_m_m_prolhost_01`,
--     `a_m_m_soucent_01`,
--     `a_m_m_soucent_03`,
--     `a_f_y_business_02`,
}