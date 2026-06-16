# NPC Controller (Native FiveM)

A lightweight FiveM resource built entirely with GTA V/FiveM natives. This script allows you to control and remove ambient NPCs, parked vehicles, scenario peds, emergency service AI, and other world population elements.

No framework required.

## Features

- Remove walking NPCs
- Remove NPC drivers
- Remove parked NPC vehicles
- Remove scenario NPCs (sitting, smoking, talking, sweeping, etc.)
- Remove random boats
- Remove random aircraft
- Disable police AI
- Disable ambulance AI
- Disable fire department AI
- NPC whitelist system
- Fully configurable
- Optimized for performance
- Framework independent

---

## Resource Structure

```text
ms_npcremover/
│
├── fxmanifest.lua
├── shared/shared.lua
└── client/client.lua
```

---

## Installation

### 1. Create the Resource Folder

```text
resources/[standalone]/npc_controller
```

### 2. Add the Script Files

Place all script files inside the resource folder.

### 3. Add to server.cfg

```cfg
ensure npc_controller
```

### 4. Restart the Server

---

# Configuration

## config.lua

```lua
Config = {}

-- Density values (0.0 - 1.0)

Config.VehicleDensity = 0.0
Config.PedDensity = 0.0
Config.RandomVehicleDensity = 0.0
Config.ParkedVehicleDensity = 0.0
Config.ScenarioPedDensity = 0.0

-- Disable Emergency Services

Config.DisableCops = true
Config.DisableAmbulance = true
Config.DisableFireDepartment = true

-- Cleanup spawned entities

Config.DeleteNearbyPeds = true
Config.DeleteNearbyVehicles = true

-- Cleanup radius

Config.CleanupRadius = 150.0

-- Allowed ped models

Config.AllowedPeds = {
    -- `s_m_y_cop_01`,
    -- `s_m_m_paramedic_01`,
}
```

---

# Density Settings

## Density Scale

| Value | Description |
|---------|-------------|
| 0.0 | No spawning |
| 0.1 | Very low |
| 0.3 | Low |
| 0.5 | Medium |
| 1.0 | GTA V default |

---

## Vehicle Density

```lua
Config.VehicleDensity = 0.0
```

Controls the amount of traffic vehicles driving around the map.

---

## Ped Density

```lua
Config.PedDensity = 0.0
```

Controls the amount of ambient walking pedestrians.

---

## Random Vehicle Density

```lua
Config.RandomVehicleDensity = 0.0
```

Controls random traffic generation.

---

## Parked Vehicle Density

```lua
Config.ParkedVehicleDensity = 0.0
```

Controls parked vehicles generated throughout the map.

---

## Scenario Ped Density

```lua
Config.ScenarioPedDensity = 0.0
```

Controls NPCs performing world scenarios.

Examples:

- Sitting on benches
- Smoking
- Talking with other NPCs
- Cleaning sidewalks
- Repairing vehicles
- Using phones

---

# Emergency Services

## Disable Police AI

```lua
Config.DisableCops = true
```

Disables random police AI spawning and patrols.

---

## Disable Ambulance AI

```lua
Config.DisableAmbulance = true
```

Disables ambulance AI dispatches.

---

## Disable Fire Department AI

```lua
Config.DisableFireDepartment = true
```

Disables fire department AI dispatches.

---

# Cleanup System

## Ped Cleanup

```lua
Config.DeleteNearbyPeds = true
```

Deletes nearby non-player NPCs.

---

## Vehicle Cleanup

```lua
Config.DeleteNearbyVehicles = true
```

Deletes nearby vehicles driven by NPCs.

---

## Cleanup Radius

```lua
Config.CleanupRadius = 150.0
```

Defines the cleanup range around players.

Examples:

```lua
50.0
```

Small cleanup area.

```lua
150.0
```

Recommended for roleplay servers.

```lua
300.0
```

Large cleanup area with higher processing cost.

---

# NPC Whitelist

Allow specific NPC models to remain in the world.

Example:

```lua
Config.AllowedPeds = {
    `s_m_y_cop_01`,
    `s_m_m_paramedic_01`,
}
```

These NPCs will not be deleted by the cleanup system.

---

# Example Configurations

## Completely Empty World

```lua
Config.VehicleDensity = 0.0
Config.PedDensity = 0.0
Config.RandomVehicleDensity = 0.0
Config.ParkedVehicleDensity = 0.0
Config.ScenarioPedDensity = 0.0
```

Result:

- No traffic
- No pedestrians
- No scenario NPCs
- No parked vehicles

---

## Semi-Realistic Population

```lua
Config.VehicleDensity = 0.2
Config.PedDensity = 0.2
Config.RandomVehicleDensity = 0.2
Config.ParkedVehicleDensity = 0.2
Config.ScenarioPedDensity = 0.1
```

Result:

- Light traffic
- Some pedestrians
- Better performance than vanilla GTA V

---

## Police Only

```lua
Config.AllowedPeds = {
    `s_m_y_cop_01`,
}
```

Result:

- Most NPCs are removed
- Police NPCs remain active

---

# Performance

Expected resource usage:

```text
0.00 ms - 0.02 ms
```

Actual usage depends on the number of entities around players and server population.

---

# Compatibility

- OneSync
- OneSync Infinity
- QBCore
- QBX
- ESX
- Ox Inventory
- Ox Lib
- Standalone Servers

---

# Future Improvements

Potential additions:

- Zone-based population control
- NPC blacklist system
- Vehicle model whitelist
- Dynamic density adjustments
- Population profiles (City, RP, Zombie, Survival)
- Server-side population management

---

# License

Free to use, modify, and distribute.