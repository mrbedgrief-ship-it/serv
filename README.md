# CripCraft Zone Frontier

## What this project is
CripCraft is now a **Windows-first playable Minecraft game prototype** built for a **complete beginner**. It is no longer pretending to be a big network. It is now a **small local game pack + local server pack** with a launcher that starts the game flow for you.

The mood is:
- dark
- atmospheric
- post-apocalyptic
- survival
- bunker/outpost based
- inspired by “zone survival” games, but using original names and original branding

The playable starting experience is:
1. open the CripCraft launcher,
2. click **Play**,
3. the local server starts,
4. Prism Launcher opens the **CripCraft Zone Frontier** game instance,
5. you spawn in **Outpost Blackline**,
6. you go into the dangerous zone,
7. you loot, survive, and return.

## Architecture choice
This rebuild uses **one local Forge server + one matching Prism Launcher client instance**.

Why this choice:
1. It is much easier for a beginner than a multi-server network.
2. It lets the launcher actually start a real game flow.
3. It keeps client and server versions aligned.
4. It keeps the project honest and much closer to a small standalone game prototype.

## Exact versions
- **Minecraft:** 1.20.1
- **Mod loader:** Forge
- **Forge version:** 47.4.10
- **Java required:** 17
- **Client launcher used by this project:** Prism Launcher portable 9.4

## Is this singleplayer-first, local-server-first, or both?
This project is **local-server-first with a packaged client instance**.

That means:
- the launcher starts the local server,
- then it launches the matching modded client instance,
- then the game connects to `localhost`.

## What the project includes now
- A real Windows launcher UI with working buttons.
- A real local Forge server pack.
- A real Prism client instance template.
- A real first playable area called **Outpost Blackline**.
- A real dangerous outside area called **Zone Survival**.
- A real starter loop: leave safety, scavenge, survive, come back.
- Honest beginner documentation.

## Real mods used
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
2. **JEI**
   - Exact file: `jei-1.20.1-forge-15.20.0.128.jar`
   - Put it in: `mods/client-only/`
   - Download page: <https://modrinth.com/mod/jei/version/MdKE2PdF>

## Very important: turn shaders OFF
For this prototype:
- do **not** use shaders,
- do **not** use OptiFine,
- do **not** use Iris,
- test with shaders OFF.

If the game looks gray, broken, or full of shader errors:
1. close the game,
2. turn shaders OFF,
3. try again.

Plain-language version:
**Turn shaders off before testing.**

## Folder guide
- `launcher/` - the CripCraft launcher UI plus Prism Launcher files/data.
- `client-pack/` - client notes and the Prism instance template.
- `server/template/` - world + server template files.
- `server/runtime/` - the installed Forge server after setup.
- `mods/shared/` - jars used on both server and client.
- `mods/client-only/` - optional client helper mods.
- `client-pack/mods/` - synced client mods folder.
- `scripts/` - setup, repair, checks, play, and start scripts.
- `configs/mod-manifest.json` - exact filenames and download pages.

## Exact beginner setup for Windows
1. Install **Java 17**.
2. Double-click `scripts/setup.bat`.
3. Wait for setup to:
   - download the Forge server installer,
   - install the local Forge server,
   - download Prism Launcher portable,
   - create the CripCraft playable client instance.
4. If setup opens browser pages for missing mods, download those exact jar files and place them into:
   - `mods/shared/`
   - `mods/client-only/`
5. Double-click `launcher/start-launcher.bat`.
6. Click **Check Files**.
7. If the status looks good, click **Play**.
8. If Prism asks you to sign into your Minecraft account the first time, do that there.
9. Wait for the server window to say `Done`.
10. The client should launch and connect to `localhost` automatically.

## How the Play button works
When you click **Play**:
1. CripCraft starts the local server in a new window.
2. CripCraft waits a few seconds.
3. CripCraft launches the Prism game instance.
4. Prism launches Minecraft Forge 1.20.1.
5. The game tries to join `localhost`.

If the first join happens before the server is fully ready:
- wait for the server window to say `Done`,
- then click **Reconnect** once.

## How to start the game manually if needed
1. Double-click `scripts/play-cripcraft.bat`.

## How to start only the server manually if needed
1. Double-click `scripts/start-server.bat`.

## How to connect manually if needed
If auto-join does not happen:
1. Open Multiplayer.
2. Add Server.
3. Address: `localhost`
4. If needed, try `127.0.0.1`.

## First 5 minutes: what should happen
1. You spawn safely inside **Outpost Blackline**.
2. You see CripCraft branding and rules.
3. You find starter supplies in the outpost.
4. You press the Zone Survival button.
5. You reach the quarantine outpost.
6. You loot the crates.
7. You walk outside the fence into danger.
8. You scavenge, survive, and come back with loot.

## What to do if mods mismatch
- Make sure you are launching the **CripCraft Zone Frontier** Prism instance.
- Make sure the shared mod jars match `configs/mod-manifest.json`.
- Run `scripts/repair.bat`.
- Click **Play** again.

## What to do if Java is missing
- Install Java 17.
- Close the launcher.
- Open it again.

## What to do if the launcher opens but Play fails
Check these in order:
1. Click **Check Files**.
2. If Prism is missing, run `scripts/setup.bat`.
3. If the game instance is missing, run `scripts/setup.bat` again.
4. If mods are missing, download the exact files listed in `configs/mod-manifest.json`.
5. Run `scripts/repair.bat`.
6. Click **Play** again.

## What to do if the world looks empty, gray, or broken
1. Turn shaders OFF.
2. Make sure you launched the CripCraft Prism instance, not vanilla Minecraft.
3. Stop the server.
4. Run `scripts/repair.bat`.
5. Start the game again.

## Honest limits
This is still a prototype.
It is **not**:
- a finished standalone commercial game,
- a giant modpack,
- a full quest campaign,
- a multiplayer network,
- or a custom executable game engine.

It **is**:
- a real local playable Minecraft-based game prototype,
- with a launcher,
- a matching modded client instance,
- a matching local server,
- a safe starting area,
- and one real survival loop.
