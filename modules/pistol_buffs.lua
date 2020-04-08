

local event = require 'utils.event'


local function on_entity_damaged(event)
	if not event.cause then return end
	if event.cause.name ~= "character" then return end
	if event.damage_type.name ~= "physical" then return end

	local player = event.cause
	if player.shooting_state.state == defines.shooting.not_shooting then return end
	local weapon = player.get_inventory(defines.inventory.character_guns)[player.selected_gun_index]
	local ammo = player.get_inventory(defines.inventory.character_ammo)[player.selected_gun_index]
  if not weapon.valid_for_read or not ammo.valid_for_read then return end
	if weapon.name ~= "pistol" then return end
	if ammo.name ~= "firearm-magazine" and ammo ~= "piercing-rounds-magazine" and ammo ~= "uranium-rounds-magazine" then return end
	event.entity.damage(event.final_damage_amount * 4, player.force, "physical")
end

event.add(defines.events.on_entity_damaged, on_entity_damaged)
