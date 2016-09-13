-- luacheck: globals game script defines

local function worth_processing( player )
  return player.valid and player.connected --> player in game
     and not player.vehicle --> not driving a vehicle
     and player.selected --> they selected a target
     and player.character and player.character.valid --> they have valid avatar
     and not player.walking_state.walking --> which is not moving
end

local atan2     , pi     , floor
    = math.atan2, math.pi, math.floor

local function orient_players( event )
  if event.tick % 30 == 0 then -- update twice per second

    for _, player in pairs( game.players ) do
      if worth_processing( player ) then

        local location = player.position          --> where the player is
        local target   = player.selected.position --> what they should be looking at

        local angle = atan2(location.y - target.y, location.x - target.x)
              angle = (angle/pi + 1)*4 - 5.5
              angle = angle <  0 and angle + 8 or angle
              angle = angle >= 8 and angle - 8 or angle

        player.character.direction = floor(angle)
        -- should probably also set player.character.orientation for smoother
        -- direction but that will require more math...?

      end
    end--for player

  end
end

script.on_event( defines.events.on_tick, orient_players )
