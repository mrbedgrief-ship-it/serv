tag @s add cc_joined
team join player @s
spawnpoint @s 0 81 0
gamemode adventure @s
title @s title {"text":"CripCraft","color":"aqua","bold":true}
title @s subtitle {"text":"Dark Neon Local Prototype","color":"dark_gray"}
tellraw @s {"text":"Welcome to CripCraft! Start in the hub, then press the Zone Survival button.","color":"aqua"}
tellraw @s {"text":"Prototype note: ranks are scaffolded only. Store/payments are NOT implemented.","color":"yellow"}
scoreboard objectives setdisplay sidebar cc_sidebar
scoreboard players set @s cc_sidebar 1
