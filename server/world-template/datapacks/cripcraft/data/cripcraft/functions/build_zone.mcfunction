forceload add 12 0
fill 190 69 -10 210 69 10 deepslate_tiles
fill 190 70 -10 210 80 10 air
fill 190 70 -10 190 76 10 polished_deepslate
fill 210 70 -10 210 76 10 polished_deepslate
fill 190 70 -10 210 76 -10 polished_deepslate
fill 190 70 10 210 76 10 polished_deepslate
fill 196 70 -10 204 74 -10 cyan_stained_glass_pane
fill 196 70 10 204 74 10 cyan_stained_glass_pane
fill 190 70 -4 190 74 4 cyan_stained_glass_pane
fill 210 70 -4 210 74 4 cyan_stained_glass_pane
setblock 200 70 0 lodestone
setblock 200 70 -8 warped_sign[rotation=8]{front_text:{messages:['{"text":"ZONE SURVIVAL","color":"green","bold":true}','{"text":"Playable mode","color":"white"}','{"text":"Search, survive, return","color":"yellow"}','{"text":"Use the bunker chest","color":"gray"}']}}
setblock 200 70 8 warped_sign[rotation=0]{front_text:{messages:['{"text":"Return to Hub","color":"aqua","bold":true}','{"text":"Press the button","color":"yellow"}','{"text":"to go back safely","color":"gray"}','{"text":"Adventure mode there","color":"gray"}']}}
setblock 200 69 9 command_block{Command:"tp @p[distance=..2,x=200,y=70,z=9] 0 81 0",auto:0b,TrackOutput:0b}
setblock 200 70 9 stone_button[face=floor,facing=north,powered=false]
setblock 198 70 -6 chest[facing=south]{Items:[{Slot:0b,id:"minecraft:bread",Count:8b},{Slot:1b,id:"minecraft:stone_sword",Count:1b},{Slot:2b,id:"minecraft:torch",Count:16b},{Slot:3b,id:"minecraft:cooked_beef",Count:8b},{Slot:4b,id:"minecraft:shield",Count:1b}]}
setblock 202 70 -6 barrel[facing=south]{Items:[{Slot:0b,id:"minecraft:oak_log",Count:16b},{Slot:1b,id:"minecraft:cobblestone",Count:32b},{Slot:2b,id:"minecraft:water_bucket",Count:1b},{Slot:3b,id:"minecraft:iron_pickaxe",Count:1b}]}
fill 194 69 -6 206 69 6 cracked_deepslate_tiles
setblock 200 70 -5 campfire[lit=true]
setblock 199 70 -4 red_bed[part=foot,facing=south]
setblock 199 70 -3 red_bed[part=head,facing=south]
setblock 201 70 -4 red_bed[part=foot,facing=south]
setblock 201 70 -3 red_bed[part=head,facing=south]
