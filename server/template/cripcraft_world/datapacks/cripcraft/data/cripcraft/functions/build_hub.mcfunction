fill -14 78 -14 14 78 14 polished_blackstone_bricks
fill -14 79 -14 14 90 14 air
fill -14 79 -14 14 79 14 smooth_basalt
fill -14 80 -14 -14 88 14 polished_blackstone_bricks
fill 14 80 -14 14 88 14 polished_blackstone_bricks
fill -14 80 -14 14 88 -14 polished_blackstone_bricks
fill -14 80 14 14 88 14 polished_blackstone_bricks
fill -14 89 -14 14 89 14 polished_blackstone_bricks
fill -3 79 -3 3 79 3 cyan_stained_glass
fill -2 80 -2 2 88 2 air
fill -10 80 -13 -4 85 -13 black_stained_glass_pane
fill 4 80 -13 10 85 -13 black_stained_glass_pane
fill -2 80 -14 2 84 -14 air
fill -14 80 -2 -14 84 2 iron_bars
fill 14 80 -2 14 84 2 iron_bars
setblock 0 79 0 beacon{Levels:1}
setblock 0 80 0 iron_block
setblock 0 82 -11 waystones:waystone
setblock -10 80 10 chest[facing=south]{Items:[{Slot:0b,id:"minecraft:bread",Count:12b},{Slot:1b,id:"minecraft:stone_pickaxe",Count:1b},{Slot:2b,id:"minecraft:torch",Count:24b},{Slot:3b,id:"minecraft:cooked_beef",Count:8b},{Slot:4b,id:"minecraft:water_bucket",Count:1b}]}
setblock 10 80 10 barrel[facing=south]{Items:[{Slot:0b,id:"minecraft:oak_log",Count:16b},{Slot:1b,id:"minecraft:cobblestone",Count:32b},{Slot:2b,id:"minecraft:shield",Count:1b},{Slot:3b,id:"minecraft:stone_sword",Count:1b}]}
setblock 0 80 11 respawn_anchor[charges=4]
setblock 0 80 -9 warped_sign[rotation=8]{front_text:{messages:['{"text":"CRIPCRAFT HUB","color":"aqua","bold":true}','{"text":"Forge 1.20.1 local test","color":"gray"}','{"text":"Turn shaders OFF","color":"yellow"}','{"text":"Use Zone Survival below","color":"green"}']}}
setblock -9 80 12 warped_sign[rotation=0]{front_text:{messages:['{"text":"Rules","color":"aqua","bold":true}','{"text":"1. Local test build","color":"gray"}','{"text":"2. No shaders","color":"gray"}','{"text":"3. Explore the zone","color":"gray"}']}}
setblock 9 80 12 warped_sign[rotation=0]{front_text:{messages:['{"text":"Ranks","color":"light_purple","bold":true}','{"text":"Player / Crip","color":"gray"}','{"text":"Neon / Legend","color":"aqua"}','{"text":"Overlord later","color":"gold"}']}}
setblock -6 79 -4 command_block{Command:"tp @p[distance=..2,x=-6,y=80,z=-4] 200 71 0",auto:0b,TrackOutput:0b}
setblock -6 80 -4 stone_button[face=floor,facing=north,powered=false]
setblock -6 80 -7 warped_sign[rotation=8]{front_text:{messages:['{"text":"ZONE SURVIVAL","color":"green","bold":true}','{"text":"Real playable mode","color":"white"}','{"text":"Press the button","color":"yellow"}','{"text":"Enter the quarantine zone","color":"dark_green"}']}}
setblock 6 79 -4 command_block{Command:"tellraw @p[distance=..2,x=6,y=80,z=-4] {\"text\":\"Waystones is installed. Right-click the hub waystone to activate it after setup.\",\"color\":\"aqua\"}",auto:0b,TrackOutput:0b}
setblock 6 80 -4 stone_button[face=floor,facing=north,powered=false]
setblock 6 80 -7 warped_sign[rotation=8]{front_text:{messages:['{"text":"WAYSTONES NOTE","color":"aqua","bold":true}','{"text":"Right-click the hub","color":"gray"}','{"text":"waystone to activate it","color":"gray"}','{"text":"after you join","color":"gray"}']}}
fill -3 80 13 3 80 13 soul_lantern
