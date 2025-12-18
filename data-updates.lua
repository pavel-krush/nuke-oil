local insert = table.insert

insert(data.raw.projectile["atomic-bomb-wave"].action,
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
        {
          type = "script",
          effect_id = "nuke-oil-destroy"
        }
      }
    }
  })

if data.raw.projectile["atomic-artillery-wave"] then
  insert(data.raw.projectile["atomic-artillery-wave"].action,
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "script",
            effect_id = "nuke-oil-destroy"
          }
        }
      }
    })
end
