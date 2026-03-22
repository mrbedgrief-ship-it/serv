fill 186 69 -14 214 69 14 cracked_deepslate_tiles
fill 186 70 -14 214 84 14 air
fill 186 70 -14 186 78 14 polished_deepslate
fill 214 70 -14 214 78 14 polished_deepslate
fill 186 70 -14 214 78 -14 polished_deepslate
fill 186 70 14 214 78 14 polished_deepslate
fill 190 70 -14 210 78 -14 iron_bars
fill 190 70 14 210 78 14 iron_bars
fill 186 70 -4 186 76 4 iron_bars
fill 214 70 -4 214 76 4 iron_bars
fill 194 70 -8 206 70 8 smooth_basalt
fill 194 71 -8 206 76 8 air
fill 194 77 -8 206 77 8 deepslate_bricks
setblock 200 71 0 waystones:waystone
setblock 200 71 -9 warped_sign[rotation=8]{front_text:{messages:['{"text":"ZONE SURVIVAL","color":"green","bold":true}','{"text":"Loot, survive, return","color":"white"}','{"text":"Starter crates inside","color":"yellow"}','{"text":"Danger outside the gate","color":"red"}']}}
setblock 200 71 10 warped_sign[rotation=0]{front_text:{messages:['{"text":"Return to Hub","color":"aqua","bold":true}','{"text":"Press the button","color":"yellow"}','{"text":"Use when safe","color":"gray"}','{"text":"Hub is Adventure mode","color":"gray"}']}}
setblock 200 70 11 command_block{Command:"tp @p[distance=..2,x=200,y=71,z=11] 0 82 0",auto:0b,TrackOutput:0b}
setblock 200 71 11 stone_button[face=floor,facing=north,powered=false]
setblock 196 71 -5 chest[facing=south]{Items:[{Slot:0b,id:"minecraft:bread",Count:8b},{Slot:1b,id:"minecraft:cooked_beef",Count:8b},{Slot:2b,id:"minecraft:bow",Count:1b},{Slot:3b,id:"minecraft:arrow",Count:16b}]}
setblock 204 71 -5 barrel[facing=south]{Items:[{Slot:0b,id:"minecraft:stone_axe",Count:1b},{Slot:1b,id:"minecraft:torch",Count:24b},{Slot:2b,id:"minecraft:oak_planks",Count:32b},{Slot:3b,id:"minecraft:coal",Count:8b}]}
setblock 198 71 5 red_bed[part=foot,facing=south]
setblock 198 71 6 red_bed[part=head,facing=south]
setblock 202 71 5 red_bed[part=foot,facing=south]
setblock 202 71 6 red_bed[part=head,facing=south]
setblock 200 71 -3 campfire[lit=true]
fill 194 70 15 206 70 22 coarse_dirt
fill 194 71 22 206 75 22 cobbled_deepslate_wall
fill 194 71 15 194 75 22 cobbled_deepslate_wall
fill 206 71 15 206 75 22 cobbled_deepslate_wall
setblock 200 71 18 polished_blackstone_brick_wall
setblock 200 71 17 warped_sign[rotation=8]{front_text:{messages:['{"text":"Front Gate","color":"aqua","bold":true}','{"text":"Walk outside for the real","color":"gray"}','{"text":"survival loop: loot, mine,","color":"gray"}','{"text":"fight mobs, return alive","color":"yellow"}']}}
fill 193 70 -20 207 70 -15 netherrack
fill 194 71 -19 206 71 -16 soul_soil
setblock 200 72 -18 soul_campfire[lit=true]
