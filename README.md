# CripCraft Forge Local Prototype

## What this project is
CripCraft is a **real local Windows-first Minecraft Forge prototype**. It is intentionally smaller than a full commercial network so it can be **tested today by a beginner**. This rebuild uses **one real Forge server**, a **real in-world hub bunker**, **real Forge mods**, and one honest playable mode called **Zone Survival**.

## Architecture choice
I chose **one Forge 1.20.1 server** instead of a proxy network.

Why:
1. Forge proxy stacks are much more fragile for a first local prototype.
2. A beginner can test one server much more easily on Windows.
3. This keeps the project honest: one server, one world, one clear starting area, one real gameplay loop.
4. It removes the fake “network” feeling from the old broken version.

## Target versions
- **Minecraft version:** 1.20.1
- **Forge version:** 47.4.10
- **Java version:** 17

## Real mods used in this prototype
### Required on both server and client
1. **Balm**
   - Exact file: `balm-forge-1.20.1-7.3.38-all.jar`
   - Put it in: `mods/shared/`
   - Download page: <https://modrinth.com/mod/balm/version/7.3.38%2Bforge-1.20.1>
2. **Waystones**
   - Exact file: `waystones-forge-1.20.1-14.1.16.jar`
   - Put it in: `mods/shared/`
   - Download page: <https://modrinth.com/mod/waystones/version/14.1.16%2Bforge-1.20.1>

### Optional but recommended on the client only
1. **Jade**
   - Exact file: `Jade-1.20.1-Forge-11.13.1.jar`
   - Put it in: `mods/client-only/`
   - Download page: <https://modrinth.com/mod/jade/version/9gf6jOO0>
2. **Just Enough Items (JEI)**
   - Exact file: `jei-1.20.1-forge-15.20.0.128.jar`
   - Put it in: `mods/client-only/`
   - Download page: <https://modrinth.com/mod/jei/version/MdKE2PdF>

## What is already working
- A single-server Forge layout for local testing.
- Local username verification disabled for localhost testing (`online-mode=false`).
- A real CripCraft Hub bunker built into the starting world by the included datapack.
- A real Zone Survival area with a safe outpost, loot chests, rules boards, and a return path.
- A Windows launcher with these working buttons:
  - Play
  - Check Files
  - Open Guide
  - Repair / Setup
  - Exit
- Setup, repair, check, and server-start scripts for Windows.
- A client-pack folder that gathers the jars the player needs to copy into `.minecraft\mods`.
- Honest beginner documentation.

## Partially working
- The hub is a **real in-world hub area**, not a separate proxy hub server.
- Zone Survival is a **real playable survival-adventure starter loop**, not a full finished game mode with quests or waves.
- The launcher is a real PowerShell desktop launcher, but it is **not** packaged as a `.exe` yet.

## Not finished
- No separate proxy network.
- No automatic mod downloading from inside the launcher.
- No custom mobs, quests, NPCs, or payment systems.
- No public internet deployment setup.
- No shader support. This prototype is built to work **without shaders**.

## Very important: turn shaders OFF
If your game looks gray, broken, or has shader errors:
1. Close Minecraft.
2. Turn shaders OFF.
3. Remove OptiFine / Iris / shader packs for this test.
4. Start the Forge profile again.

Plain-language note for beginners:
**Turn shaders off before testing.**

## Folder guide
- `launcher/` - the Windows launcher files.
- `scripts/` - setup, repair, check, and start scripts.
- `server/template/` - the Forge server template that gets copied into the runtime server.
- `server/runtime/` - the actual installed server created during setup.
- `mods/shared/` - mod jars that belong on both server and client.
- `mods/client-only/` - optional client helper mods.
- `client-pack/mods/` - the ready-to-copy client mod folder.
- `configs/mod-manifest.json` - exact mod filenames and download pages.

## Exact beginner steps for Windows
1. Install **Java 17**.
2. Double-click `scripts/setup.bat`.
3. Let it download the Forge installer and install the Forge server into `server/runtime/`.
4. If the script says mods are missing, download the exact jars it lists and place them into the matching folders:
   - `mods/shared/`
   - `mods/client-only/`
5. Double-click `downloads/forge-1.20.1-47.4.10-installer.jar`.
6. In the Forge installer, click **Install client**.
7. Copy every file from `client-pack/mods/` into `%APPDATA%\.minecraft\mods\`.
8. Double-click `launcher/start-launcher.bat`.
9. Click **Check Files**.
10. If the launcher says you are ready, click **Play**.
11. Wait for the server window to say `Done`.
12. Open the normal Minecraft Launcher.
13. Select the **Forge 1.20.1** profile.
14. Make sure shaders are OFF.
15. Join `localhost`.
16. If that fails, try `127.0.0.1`.

## How to launch the server manually
Double-click:
- `scripts/start-server.bat`

## How to connect
Inside Minecraft:
1. Multiplayer
2. Add Server
3. Server address: `localhost`
4. If needed: `127.0.0.1`

## First 2 minutes: what should happen in-game
1. You spawn inside the **CripCraft Hub bunker**.
2. You see branding, rules, and a clear briefing.
3. You get a safe place to look around instead of a void or empty gray spawn.
4. You press the **Zone Survival** button.
5. You arrive at the quarantine outpost.
6. You loot the starter crates and head outside.
7. You survive, gather resources, fight mobs, and return to the hub when you want.

## What to do if the world looks broken
Try these in order:
1. Turn shaders OFF.
2. Make sure you launched the **Forge 1.20.1** profile, not Vanilla.
3. Make sure the shared mod jars are in both the server and client setup.
4. Stop the server.
5. Run `scripts/repair.bat`.
6. Start the server again.

## What to do if mods mismatch
- Check that the server and client use the same Minecraft version: **1.20.1**.
- Check that the server and client use the same Forge version: **47.4.10**.
- Check that the exact shared mod jar filenames match `configs/mod-manifest.json`.
- Re-copy `client-pack/mods/` into `%APPDATA%\.minecraft\mods\`.

## What to do if the server closes immediately
Common causes:
- Java 17 is missing.
- Forge server install did not finish.
- Shared mod files are missing from `mods/shared/`.
- Another server is already using port 25565.

## Honest self-audit of the old broken version
The old version had these problems:
- It was not a real Forge-first prototype.
- It overclaimed polish.
- The starting experience could feel empty or broken.
- It did not clearly separate client and server mod requirements.
- It did not tell beginners strongly enough to turn shaders OFF.

This rebuild fixes those by:
- using Forge first,
- keeping one server only,
- giving the player a built spawn bunker,
- defining exact versions,
- and documenting the missing manual downloads honestly.
