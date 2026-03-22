scoreboard objectives add cc_sidebar dummy
team add player
team modify player color gray
team modify player prefix {"text":"[Player] ","color":"gray"}
team add crip
team modify crip color dark_aqua
team modify crip prefix {"text":"[Crip] ","color":"dark_aqua"}
team add neon
team modify neon color aqua
team modify neon prefix {"text":"[Neon] ","color":"aqua"}
team add legend
team modify legend color light_purple
team modify legend prefix {"text":"[Legend] ","color":"light_purple"}
team add overlord
team modify overlord color gold
team modify overlord prefix {"text":"[Overlord] ","color":"gold"}
gamerule doImmediateRespawn true
gamerule keepInventory true
gamerule commandBlockOutput false
gamerule announceAdvancements false
gamerule sendCommandFeedback false
gamerule doWeatherCycle false
gamerule doDaylightCycle false
time set night
weather clear
forceload add 0 0
forceload add 12 0
function cripcraft:build_hub
function cripcraft:build_zone
setworldspawn 0 82 0
