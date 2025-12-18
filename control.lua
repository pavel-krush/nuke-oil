local NUKE_RADIUS = 12 -- real radius is 35, but let's destroy patches in smaller area
local OIL_RESOURCE_NAME = "crude-oil"

local function destroy_oil_patches(surface, position, radius)
    local oil_patches = surface.find_entities_filtered{
        area = {
            {position.x - radius, position.y - radius},
            {position.x + radius, position.y + radius}
        },
        type = "resource",
        name = OIL_RESOURCE_NAME
    }

    for _, oil_patch in pairs(oil_patches) do
    	local pos = oil_patch.position
        oil_patch.destroy()
        surface.create_entity{
            name = "big-explosion",
            position = pos
        }
    end
end

local function on_script_trigger(event)
    if event.effect_id == "nuke-oil-destroy" then
        local surface = game.surfaces[event.surface_index]

        if surface and event.source_position then
            destroy_oil_patches(surface, event.source_position, NUKE_RADIUS)
        end
    end
end

script.on_event(defines.events.on_script_trigger_effect, on_script_trigger)
