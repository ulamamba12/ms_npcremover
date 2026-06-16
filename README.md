# ms_npcremover

A lightweight and configurable FiveM resource designed to reduce or completely remove ambient GTA V population, including pedestrians, traffic vehicles, parked vehicles, scenario peds, and emergency service AI.

Built using native FiveM functions with no framework dependencies.

## Features

- Remove ambient pedestrians
- Remove NPC drivers
- Remove parked vehicles
- Remove scenario peds
- Disable police AI spawning (cars, helis, bikes, roadblocks, boats)
- Disable ambulance AI dispatches
- Disable fire department AI dispatches
- Disable SWAT, army and gang AI dispatches
- Control vehicle density
- Control pedestrian density
- Fully configurable
- Lightweight and optimized
- Framework independent

## Dependencies

None.

This resource works as a standalone script and does not require:

- QBCore
- QBX
- ESX
- ox_lib
- ox_inventory

## Installation

### 1. Download the Resource

Place the resource inside your server's resources folder.

```text
resources/[standalone]/ms_npcremover
```

### 2. Add to server.cfg

```cfg
ensure ms_npcremover
```

### 3. Restart Your Server

## Resource Structure

```text
ms_npcremover/
│
├── client/
│   └── client.lua
│
├── shared/
│   └── shared.lua
│
└── fxmanifest.lua
```

## Configuration

All settings can be configured inside:

```lua
shared/shared.lua
```

Example settings may include:

```lua
Config.VehicleDensity = 0.0
Config.PedDensity = 0.0
Config.RandomVehicleDensity = 0.0
Config.ParkedVehicleDensity = 0.0
Config.ScenarioPedDensity = 0.0
```

### Density Values

| Value | Description |
| ------- | ------- |
| 0.0 | Disabled |
| 0.1 | Very Low |
| 0.3 | Low |
| 0.5 | Medium |
| 1.0 | GTA V Default |

## Recommended Configurations

### Empty World

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
- No parked vehicles
- No scenario NPCs

### Light Population

```lua
Config.VehicleDensity = 0.2
Config.PedDensity = 0.2
Config.RandomVehicleDensity = 0.2
Config.ParkedVehicleDensity = 0.2
Config.ScenarioPedDensity = 0.1
```

Result:

- Reduced city population
- Better server immersion
- Improved client performance

## Performance

This resource is designed to be extremely lightweight.

Expected resource usage:

```text
0.00 ms - 0.02 ms
```

Performance may vary depending on player count and nearby entities.

## Compatibility

Compatible with:

- OneSync
- OneSync Infinity
- QBCore
- QBX
- ESX
- Standalone Servers

## Version

Current Version:

```text
1.0.0
```

## Author

**Maula-Store**

## License

This project is free to use, modify, and distribute.

## Support

If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository or You can open ticket on my discord server thanks...

---

Made with ❤️ by Maula-Store
