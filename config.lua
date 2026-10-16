Config = {}

Config.Command        = 'bodybuilder' -- toggle command
Config.EnabledOnStart = false         -- true = active as soon as the player spawns
Config.Notify         = true

-- Damage resistance (0.25 = 25% less damage)
Config.Resistance = {
    punch  = 0.25, -- unarmed
    heavy  = 0.25, -- bats, crowbars, hammers, etc.
    knife  = 0.10, -- blades
    bullet = 0.05, -- keep between 0.00 and 0.05
}

-- Weapons counted as knives
Config.Knives = {
    `WEAPON_KNIFE`, `WEAPON_SWITCHBLADE`, `WEAPON_DAGGER`,
    `WEAPON_MACHETE`, `WEAPON_HATCHET`, `WEAPON_BATTLEAXE`,
}

-- Weapons counted as heavy melee
Config.Heavy = {
    `WEAPON_BAT`, `WEAPON_CROWBAR`, `WEAPON_HAMMER`, `WEAPON_GOLFCLUB`,
    `WEAPON_NIGHTSTICK`, `WEAPON_WRENCH`, `WEAPON_POOLCUE`, `WEAPON_FLASHLIGHT`,
}

-- Weapon groups counted as bullets (pistol, SMG, rifle, MG, shotgun, sniper)
Config.BulletGroups = {
    [416676503] = true, [3337201093] = true, [970310034] = true,
    [1159398588] = true, [860033945] = true, [3082541095] = true,
}

-- Optional per-weapon overrides, e.g. [`WEAPON_PISTOL`] = 0.0
Config.WeaponOverrides = {}
