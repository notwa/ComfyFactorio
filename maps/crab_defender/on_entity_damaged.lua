require 'maps.crab_defender.boss_biters'

local Event = require 'utils.event'
local explosive_bullets = require 'maps.crab_defender.explosive_gun_bullets'
local bouncy_shells = require 'maps.crab_defender.bouncy_shells'
local FDT = require 'maps.crab_defender.table'

local function protect_market(event)
    if event.entity.name ~= 'market' then
        return
    end
    if event.cause then
        if event.cause.force.name == 'enemy' then
            return
        end
    end
    event.entity.health = event.entity.health + event.final_damage_amount
    return true
end

local function on_entity_damaged(event)
    if not event.entity then
        return
    end
    if not event.entity.valid then
        return
    end

    if protect_market(event) then
        return
    end

    if not event.cause then
        return
    end
    local explosive_bullets_unlocked = FDT.get('explosive_bullets_unlocked')
    local bouncy_shells_unlocked = FDT.get('bouncy_shells_unlocked')

    --if event.cause.unit_number then
    --	if this.boss_biters[event.cause.unit_number] then
    --		boss_biter.damaged_entity(event)
    --	end
    --end

    if event.cause.name ~= 'character' then
        return
    end

    if explosive_bullets_unlocked then
        if explosive_bullets(event) then
            return
        end
    end
    if bouncy_shells_unlocked then
        if bouncy_shells(event) then
            return
        end
    end
end

Event.add(defines.events.on_entity_damaged, on_entity_damaged)
