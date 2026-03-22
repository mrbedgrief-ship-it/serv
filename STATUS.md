# CripCraft Prototype Status

## WORKING NOW
- Windows launcher wrapper with Play / Check Files / Open Guide / Exit buttons.
- File checks for Java, server jar, datapack, and EULA state.
- Setup script that downloads the official Minecraft Java server jar for 1.20.4.
- Single-server local architecture designed for `localhost` testing.
- Custom datapack that builds a safe CripCraft hub on first load.
- Hub buttons that teleport players into Zone Survival and back to the hub.
- Welcome titles, MOTD guidance, starter messages, and rank scaffold teams.
- Protected hub flow by forcing Adventure mode in the hub and Survival in the mode area.

## PARTIALLY WORKING
- Rank scaffold exists as Minecraft teams and documentation, but not as a full permissions plugin system.
- Zone Survival is a playable survival prototype with a starter bunker and return button, not a finished content-rich mode.
- Branding is text-and-build based; no custom texture pack or custom launcher executable is included.

## PLACEHOLDERS
- Donation/store integration.
- Multi-server proxy network.
- Online account system beyond normal Minecraft Java Edition login.
- NPCs, quests, cosmetics, and advanced menus.
- Additional modes such as Infected Escape or Horror Hunt.

## MISSING DOWNLOADS
- Java 21 for Windows, if not already installed.
- Official Minecraft Java server jar, downloaded by `scripts/setup.bat`.
- Minecraft Java Edition client on the player's computer.

## KNOWN ISSUES
- The first server start can take a little while because Minecraft generates the world.
- The launcher is a PowerShell app started by a `.bat` file, not a packaged `.exe`.
- Local firewall prompts may appear on first launch.
- If Java is missing from PATH, the launcher will warn you.

## NEXT STEPS
- Add a proper Paper-based plugin layer for permissions, menus, and scoreboard polish.
- Replace button-based travel with a GUI selector plugin later.
- Add a second playable mode only after the first mode is stable.
- Package the launcher into an `.exe` once the workflow is proven stable.
