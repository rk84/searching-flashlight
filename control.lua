require "defines"

MOD = { NAME = "Searching flashlight", IF = "sf" }

script.on_event(defines.events.on_tick, function(event)
  if event.tick % 10 == 0 then
    local angle = 0
    local math = math
    local players = game.players
    for i=1, #players do
      if players[i].connected and not players[i].vehicle and players[i].selected
         and players[i].character and not players[i].walking_state.walking then
         
        angle = math.atan2(players[i].position.y - players[i].selected.position.y, players[i].position.x - players[i].selected.position.x)
        angle = (angle/math.pi + 1)*4 - 5.5
        angle = angle < 0 and angle + 8 or angle
        angle = angle >= 8 and angle - 8 or angle
        players[i].character.direction = math.floor(angle)
      end
    end
  end
end)
