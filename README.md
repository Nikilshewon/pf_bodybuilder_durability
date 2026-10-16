# Bodybuilder Durability

A lightweight FiveM resource that makes a player tougher like a bodybuilder. Health, healing, and movement/stamina stay completely normal. Only incoming damage is reduced.

## Features
- 👊 Ordinary punches: 30% damage resistance
- 🥊 Heavy melee (bats, crowbars, hammers...): 35% damage resistance
- 🔪 Knives: 10% damage resistance
- 🔫 Bullets: 0-5% damage resistance
- ❤️ Normal health and healing
- 🏃 Normal movement and stamina
- ⚙️ Fully configurable in `config.lua`

## Install
1. Drop the `pf_bodybuilder_durability` folder into your `resources` directory.
2. Add to `server.cfg`:
   ```
   ensure pf_bodybuilder_durability
   ```
3. Restart the server (or `refresh` then `ensure pf_bodybuilder_durability`).

## Usage
- `/bodybuilder` toggles the effect on/off for yourself.
- Set `Config.EnabledOnStart = true` to have it active automatically.

## Hits to kill (100 HP, default settings)
| Hit | Damage taken | Hits to kill |
|---|---|---|
| Punch (10) | 7.5 | 14 |
| Heavy melee (20) | 15 | 7 |
| Knife (35) | 31.5 | 4 |
| Pistol (25) | 25 / 23.75 | 4 / 5 |
| Rifle (30) | 30 / 28.5 | 4 / 4 |
| Shotgun (45) | 45 / 42.75 | 3 / 3 |

Bullet columns show 0% / 5% resistance.

## Configuration (`config.lua`)
| Option | Description |
|---|---|
| `Config.Command` | Toggle command name |
| `Config.EnabledOnStart` | Active on spawn |
| `Config.Notify` | Show on/off notification |
| `Config.Resistance` | `punch`, `heavy`, `knife`, `bullet` (0.25 = 25%) |
| `Config.Knives` / `Config.Heavy` | Weapon lists for each class |
| `Config.BulletGroups` | Weapon groups treated as bullets |
| `Config.WeaponOverrides` | Per-weapon resistance, e.g. `[`WEAPON_PISTOL`] = 0.0` |

## Exports (client)
```lua
exports.bodybuilder_durability:isActive()
exports.bodybuilder_durability:setActive(true)
```

## How it works
When you're hit, the script records the attacker's weapon, then refunds the resisted portion of the lost health on the next frame. Fractional damage is carried between hits so averages match the table above.

## Notes
- Client-side: affects only the local player.
- Resistance is a refund, so it can't save you from a one-hit kill.
- Real in-game weapon damage varies slightly with distance and body part, so hit counts can drift by one.
- Check `Config.BulletGroups` against your server's weapon pack.

## License
Free to use and modify. Credit appreciated.
