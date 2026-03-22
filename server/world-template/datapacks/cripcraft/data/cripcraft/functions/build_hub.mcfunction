forceload add 0 0
fill -12 78 -12 12 78 12 polished_blackstone_bricks
fill -12 79 -12 12 90 12 air
fill -12 77 -12 12 77 12 black_concrete
fill -12 79 -12 -12 84 12 blackstone
fill 12 79 -12 12 84 12 blackstone
fill -12 79 -12 12 84 -12 blackstone
fill -12 79 12 12 84 12 blackstone
fill -2 79 -2 2 79 2 tinted_glass
fill -1 78 -1 1 78 1 iron_block
setblock 0 79 0 beacon{Levels:1}
setworldspawn 0 81 0
setblock 0 79 -10 warped_sign[rotation=8]{front_text:{messages:['{"text":"CRIPCRAFT HUB","color":"aqua","bold":true}','{"text":"Dark Neon Prototype","color":"gray"}','{"text":"Use the pads below","color":"yellow"}','{"text":"to travel","color":"yellow"}']}}
setblock -6 79 9 warped_sign[rotation=0]{front_text:{messages:['{"text":"Rules","color":"aqua","bold":true}','{"text":"1. Be respectful","color":"gray"}','{"text":"2. Local prototype","color":"gray"}','{"text":"3. Use 1.20.4","color":"gray"}']}}
setblock 6 79 9 warped_sign[rotation=0]{front_text:{messages:['{"text":"Ranks","color":"light_purple","bold":true}','{"text":"Player","color":"gray"}','{"text":"Crip / Neon","color":"aqua"}','{"text":"Legend / Overlord","color":"gold"}']}}
setblock -5 79 -6 command_block{Command:"tp @p[distance=..2,x=-5,y=80,z=-6] 200 71 0",auto:0b,TrackOutput:0b}
setblock -5 80 -6 stone_button[face=floor,facing=north,powered=false]
setblock -5 79 -8 warped_sign[rotation=8]{front_text:{messages:['{"text":"Zone Survival","color":"green","bold":true}','{"text":"Playable now","color":"white"}','{"text":"Press the button","color":"yellow"}','{"text":"Enter the zone","color":"dark_green"}']}}
setblock 5 79 -6 command_block{Command:"tellraw @p[distance=..2,x=5,y=80,z=-6] {\"text\":\"MiniGames Hub placeholder: not implemented yet. Use Zone Survival today.\",\"color\":\"yellow\"}",auto:0b,TrackOutput:0b}
setblock 5 80 -6 stone_button[face=floor,facing=north,powered=false]
setblock 5 79 -8 warped_sign[rotation=8]{front_text:{messages:['{"text":"MiniGames Hub","color":"light_purple","bold":true}','{"text":"Placeholder","color":"gray"}','{"text":"Not implemented yet","color":"red"}','{"text":"Info only","color":"gray"}']}}
setblock 0 80 10 respawn_anchor[charges=4]
