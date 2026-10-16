local active = Config.EnabledOnStart
local pending = nil -- { weapon = hash, time = ms }
local carry = 0.0 -- fractional damage carried between hits

local function toSet(list)
    local s = {}
    for _, h in ipairs(list) do s[h] = true end
    return s
end

local KNIFE, HEAVY = toSet(Config.Knives), toSet(Config.Heavy)

local function getResist(weapon)
    local override = Config.WeaponOverrides[weapon]
    if override then return override end
    if weapon == `WEAPON_UNARMED` then return Config.Resistance.punch end
    if KNIFE[weapon] then return Config.Resistance.knife end
    if HEAVY[weapon] then return Config.Resistance.heavy end
    if Config.BulletGroups[GetWeapontypeGroup(weapon)] then return Config.Resistance.bullet end
    return 0.0
end

local function notify(msg)
    if not Config.Notify then return end
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, true)
end

-- Record what hit us (attacker's weapon at the moment of damage)
AddEventHandler('gameEventTriggered', function(name, args)
    if not active or name ~= 'CEventNetworkEntityDamage' then return end
    if args[1] ~= PlayerPedId() then return end

    local attacker = args[2]
    if attacker and attacker ~= 0 and DoesEntityExist(attacker) and IsEntityAPed(attacker) then
        pending = { weapon = GetSelectedPedWeapon(attacker), time = GetGameTimer() }
    end
end)

-- Refund a percentage of lost health; healing/regen/movement untouched
CreateThread(function()
    local lastHealth = GetEntityHealth(PlayerPedId())
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local hp = GetEntityHealth(ped)

        if pending then
            if hp < lastHealth and hp > 0 and (GetGameTimer() - pending.time) < 250 then
                local lost = lastHealth - hp
                local exact = lost * (1.0 - getResist(pending.weapon)) + carry
                local taken = math.floor(exact)
                carry = exact - taken
                local refund = lost - taken
                if refund > 0 then
                    hp = math.min(hp + refund, GetEntityMaxHealth(ped))
                    SetEntityHealth(ped, hp)
                end
                pending = nil
            elseif (GetGameTimer() - pending.time) >= 250 then
                pending = nil
            end
        end

        lastHealth = hp
    end
end)

RegisterCommand(Config.Command, function()
    active = not active
    pending = nil
    carry = 0.0
    notify(active and '~g~Bodybuilder durability ON' or '~r~Bodybuilder durability OFF')
end, false)

exports('isActive', function() return active end)
exports('setActive', function(state) active = state and true or false end)
