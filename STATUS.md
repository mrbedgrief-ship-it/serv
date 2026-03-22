# CripCraft Prototype Status

## WORKING NOW
- One real local Forge server architecture for Minecraft 1.20.1.
- Forge server setup script that installs Forge 47.4.10 into `server/runtime/`.
- Local testing login mode with `online-mode=false`.
- Real in-world CripCraft Hub bunker spawn.
- Real Zone Survival starter area reachable from the hub.
- Windows launcher with Play / Check Files / Open Guide / Repair / Setup / Exit.
- Client-pack folder that gathers the required and optional client jars.
- Beginner docs that explicitly say to turn shaders OFF.

## PARTIALLY WORKING
- Waystones is included as a real shared mod, but the prototype still uses a simple hub button flow as the main guaranteed travel method.
- Zone Survival is a small survival-adventure loop, not a large finished modpack campaign.
- Optional client helper mods are documented and checked, but still require manual download by the user.

## NOT IMPLEMENTED YET
- Separate proxy hub network.
- Custom mobs, quests, NPCs, or faction systems.
- Packaged `.exe` launcher.
- Automatic client-side Forge profile installation.
- Payments, donation store, or web account systems.

## REQUIRED MANUAL DOWNLOADS
- Java 17 for Windows.
- Forge installer jar for 1.20.1-47.4.10 (the setup script downloads this automatically).
- Balm shared mod jar.
- Waystones shared mod jar.
- Optional Jade client jar.
- Optional JEI client jar.
- Minecraft Java Edition client.

## KNOWN ISSUES
- This prototype is designed for local testing only, not public hosting.
- Shaders should be OFF. OptiFine/Iris/shader packs can break the look of the test.
- The Forge installer still needs one manual client step for beginners: click `Install client`.
- Optional client-only mods improve the experience but are not required to join.

## NEXT STEPS
- Replace the button teleport with a fuller Waystones progression flow.
- Add more structures and loot to the survival zone.
- Add a second real mode only after the first one is stable.
- Package the launcher as a cleaner Windows app.
