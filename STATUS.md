# CripCraft Prototype Status

## WORKING NOW
- Windows launcher with Play / Check Files / Repair / Setup / Open Guide / Exit.
- Play button starts the local server and launches the Prism game instance.
- Local Forge server architecture for Minecraft 1.20.1.
- Prism Launcher portable download/setup flow.
- CripCraft client instance template for Prism Launcher.
- Safe spawn area: Outpost Blackline.
- Playable outside zone: Zone Survival.
- Beginner docs with shaders-OFF warning.

## PARTIALLY WORKING
- The first auto-join can happen before the local server is fully finished loading, so the player may need to click Reconnect once.
- Waystones is installed, but the main guaranteed travel method is still the direct bunker button flow.
- Optional client mods still require manual download.

## NOT IMPLEMENTED YET
- Packaged `.exe` launcher.
- Dedicated online multiplayer hosting.
- Large quest chains or story campaign.
- Custom enemies or advanced anomaly systems.
- Payment, store, or account web systems.

## REQUIRED MANUAL DOWNLOADS
- Java 17 for Windows.
- Balm shared mod jar.
- Waystones shared mod jar.
- Optional Jade client jar.
- Optional JEI client jar.
- Minecraft Java Edition account/client for Prism Launcher sign-in.

## KNOWN ISSUES
- Shaders should be OFF for testing.
- The first Prism launch may ask the user to sign into Minecraft.
- The local server can take a short time to reach `Done` on first start.
- This prototype is for local Windows play, not polished public release.

## NEXT STEPS
- Make the Play flow wait more intelligently for server readiness.
- Add more loot spots and structures in the outside zone.
- Add a stronger return/progression loop.
- Package the launcher as a cleaner desktop app.
