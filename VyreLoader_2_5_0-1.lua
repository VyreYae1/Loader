--[[
	VirexHub  -  Android / Delta edition  -  v2.5.0

	WHAT CHANGED IN 2.5.0
	  Music tab  five new song categories next to Phonk and Funk: Love songs, For myself, Gang vibes, Hits and Rock.
	             The list's Kind selector is now a dropdown (All, every category, Mine) that shows how many songs each
	             one holds; CONFIG.Music.Kinds is the single source of truth for the labels. The new songs are public
	             Creator Store rbxassetid ids found on public lists in those moods, listed under their creators' own
	             names (none under a famous artist's name) and tested on your device like the others. A "Your Spotify"
	             section under "Add a song" copies your playlist links (the hub cannot play Spotify).
	  Fix        a song marked "both" now shows under Phonk and Funk only, not under every category.
	  Information  the What's new, FAQ, Tabs and Sources notes follow the new categories; their numbers are counted.

	WHAT CHANGED IN 2.4.0
	  Music tab  a player (song name, artist, seek bar with time, previous / play-pause / next, shuffle, repeat,
	             volume) and a list of phonk / funk songs to pick from. The songs are public Creator Store rbxassetid
	             ids in CONFIG.Music.Tracks. Each one is tested on your device when you play it (or with "Check all"),
	             and songs that do not load are hidden. You can add your own audio ids in the tab.
	             The tab ring now has 9 tabs; Music sits after Scripts.

	WHAT CHANGED IN 2.3.1
	  Loading music  a phonk / "aura" track plays while the loading screen is up (and only there). With no mp3
	                 of your own it comes from CONFIG.Splash.SoundAssetIds, a list of rbxassetid candidates taken
	                 from public Roblox ID lists. They are tested one by one in the background, so private or
	                 deleted audio is skipped and a dead ID never delays start-up. It loops until you tap, then fades.

	WHAT CHANGED IN 2.3.0  (the 2.1.1 floating-logo build, plus what the other two builds had)
	  Loading screen  the new animated one (wobbling black disc, V-Y-R-E letters that drop in, typed
	                  capsule, local mp3). It waits for a tap on its "Tap here to continue" line, then the
	                  floating logo appears. The separate floating "VYRE tab" of that build is NOT used:
	                  this build's logo already does that job. Only the Splash module, CONFIG.Splash,
	                  CONFIG.Sounds.loading and the hand-off / watchdog in App.boot changed for it.
	  Steal An Egg    built-in panel at the top of the Scripts tab: Farm (Plot & Pets, Selling & Fusion)
	                  and Config (profiles, unload). Profiles live in VirexHub/steal-an-egg.json.
	  Avatar          the 2.0.1 avatar code: when Roblox refuses ApplyDescription the look is built on a
	                  client-only rig and copied onto YOUR character on this device.
	  Scripts tab     catalog in two levels (Main / Bonus, each No key required / Key required) with counts
	                  and a Main / Bonus filter; Information tab and Private Server Finder as before.
	  Safety          an unreadable config.json is kept as config.unreadable.json; sounds that were still
	                  scheduled when the hub closed are skipped; background files an executor refuses are
	                  reported instead of failing silently.

	WHAT CHANGED IN 2.1.1
	  Tap the logo: only the tab ring opens. A tab's menu opens when that tab is tapped.
	  The name is back in a title bar (CONFIG.Title) and a footer reads "<CONFIG.FooterName> - <tab name>".
	  Logo, tab ring and window are smaller (the size numbers are at the top of the Win section).

	One self-contained LocalScript-style file for the Roblox Delta executor on Android.
	Everything is wrapped in module tables (Util, Maid, Env, Store, Motion, Anim, Typo,
	Theme, Sfx, Notify, UI, Bg, Splash, Avatar, Win, Pages, App, Scripts, Music) so the main chunk stays
	far below Luau's local-variable and upvalue limits.

	WHAT CAME FROM WHERE
	  VirexHub_Android_Delta.lua (original)  identity, tabs, title "VIREX / HUB", palettes
	                                         Obsidian + DeepTeal, clock / compact / reduced
	                                         motion / notifications / UI scale / reset / close
	  blxyo_v6_3_free_event.lua              loading-screen structure (welcome chip, emblem with
	                                         orbit ring, sheen title, thin progress track,
	                                         ready hand-off), loading / error / hover sound
	                                         asset IDs, honest step reporting
	  Vyre-Multiverse-44.lua                 click sound ID, FPS / ping readout, time-played
	                                         counter, rejoin action, luminance-based text colour
	  Vyre-Multiverse-41.lua                 script catalog entries (names and links, unchanged) and
	                                         the favourite-star idea; no styling or layout
	  VYRE-INSTANT_STEAL.lua                 visual language only (diamond palette, living
	                                         gradient strokes); none of its game logic is used
	  AVATAR-CHANGER.lua (returnreturnfunction)  HumanoidDescription avatar changer, clothing
	                                         customizer, favourites (ported with validation)
	  VYRE_6_3_STEAL-AN-EGG.lua              built-in Steal An Egg panel in the Scripts tab: Farm (Plot & Pets,
	                                         Selling & Fusion) and Config (profiles, unload). Game logic
	                                         ported from its farm / config modules; the plumbing is this file's.
	  VyreHub_Android_Delta_2_2_0_Loading_screen.lua  the animated loading screen and the loading sound
	  VyreAvatarFarmMultiscript.lua          Steal An Egg panel, Main / Bonus Scripts tab, 2.0.1 avatar code,
	                                         unreadable-config handling

	EXECUTOR FEATURES ARE OPTIONAL. File saving, clipboard, custom assets, HTTP and gethui are
	feature-detected inside pcall. If one is missing, the matching control says so and the
	hub keeps working with session-only settings.

	NOTHING HERE IS SERVER-AUTHORITATIVE. Roblox only lets the server change a real avatar
	(HumanoidDescription calls from a client are refused with "can only be called by the
	backend server"). So the avatar tools first try the engine call, and when Roblox refuses
	they build the outfit on a client-only rig and copy it onto YOUR character on this
	device. Only you see that look, and respawning resets it. Restore puts the original back.

	v2.0.1  fixes "Avatar change failed - Humanoid::ApplyDescription() can only be called by
	        the backend server" by adding that client-side fallback.
	v2.1.0  adds the Scripts tab, the Information tab and the Private Server Finder (Tools).
	v2.2.0  (two separate builds) the Steal An Egg panel; the animated loading screen.
	v2.3.0  this file: all of the above on the floating-logo window of 2.1.1.
]]

local CONFIG = {
	Version = "2.5.0",
	Title = "VIREX / HUB",         -- the name in the title bar at the top of the window
	FooterName = "Vyre / Nexus",   -- the footer at the bottom of the window reads "<FooterName> - <tab name>"
	GuiName = "VirexHub",
	SplashName = "VirexHubSplash",
	Folder = "VirexHub",
	ConfigFile = "VirexHub/config.json",
	BackgroundFolder = "VirexHub/backgrounds",
	CacheFolder = "VirexHub/cache",
	FontFolder = "VirexHub/fonts",
	SaeFile = "VirexHub/steal-an-egg.json",
	SaeSweepFlag = "VirexHub/steal-an-egg-sweep.flag",
	LegacyGuis = { "VirexStyleHub" },
	LegacyFavorites = "Favorites.json", -- read once (never modified) to import old avatar favourites
	LegacyScriptFavorites = "VyreHub_Favorites.json", -- read once (never modified) to import script favorites from Vyre Hub
	ToggleKey = "RightShift",           -- keyboard / mouse users only

	Splash = {
		-- visible text (the brand is VYRE everywhere you can see it)
		Brand = "VYRE",                              -- title: one letter per label, dropped in one by one
		VersionChip = "V1",                          -- white chip at the right end of the capsule
		TypeText = "THANK YOU FOR USING VYRE",       -- typed into the capsule
		HintText = "Tap here to continue",             -- shown when boot is done AND the intro has finished; the tap shows the floating logo
		-- logo inside the disc: "" = the built-in vector V (UI.icon "logo"). Otherwise an rbxassetid://... or a file inside
		-- the executor workspace (loaded through Env.customAsset). If it is empty, missing or fails to load, the V is used.
		LogoImage = "",
		-- loading music (phonk / "aura" vibe). It plays ONLY while the loading screen is up, loops until you tap, then fades.
		-- Roblox cannot play an mp3 from a string, so the file is NOT embedded. Order of sources:
		--   1. SoundFile through getcustomasset   2. SoundUrl (direct link), downloaded once to SoundFile
		--   3. SoundAssetId, then SoundAssetIds: rbxassetid candidates, tried ONE BY ONE in the background (a random place in
		--      the list each launch) until one really loads on this device. Private or deleted audio is skipped.   4. silent
		SoundFile = "VirexHub/sounds/vyre_loading.mp3",
		SoundUrl = "",
		SoundAssetId = "",        -- optional: tried before the list below
		-- Public Creator Store audio found on public ID lists (allthings.how, bloxodes.com; most of them re-checked on
		-- Oct 14, 2026). Roblox can make any audio private or remove it later: that is why every id is tested first.
		-- Add or remove ids freely (digits only, or the full rbxassetid:// form).
		SoundAssetIds = {
			"rbxassetid://95131770144654",  -- AURA = inf (Brazilian Phonk / Funk Epic Aura Music)  AURA x PHONK       1:34
			"rbxassetid://74793860481732",  -- 2 PHUT HON (Epic Aura Music)                         AURA x PHONK       1:55
			"rbxassetid://99979837873059",  -- +100k AURA PHONK                                     SHAKA LE TIGRE     2:33
			"rbxassetid://134289279929880", -- Aura Phonk                                           Young Kapusta      1:40
			"rbxassetid://101382134303698", -- SIGMA ENERGY PHONK (Cold Aura Edit)                  AT Musica          2:13
			"rbxassetid://126132092368935", -- MONTAGEM AURA                                        Menina de Brazil   1:40
			"rbxassetid://77701977147898",  -- SHADOW PHONK BRAZIL (Dark Atmosphere Edit)           AT Musica          1:57
			"rbxassetid://140667339171815", -- Desprezo (Aggressive Phonk), Slowed + Reverb         Alexandre Ze Musician 1:56
			"rbxassetid://140215257631273", -- Eclipse Drift                                        SynthWavesZ        2:07
			"rbxassetid://138178180069464", -- PHONK SOMBRIO                                        NOXDRIFT           2:06
			"rbxassetid://114788894326738", -- Ghost Lane                                           Khai GOD           2:14
			"rbxassetid://134434412138800", -- MEGAPHONK                                            Lowifer            3:49
			"rbxassetid://124170748342120", -- AURA SAIYAN DROP (Brazilian Phonk Music)
			"rbxassetid://14145620056",     -- The Final Phonk                                      Perfect Time Music 1:33
		},
		MusicLoop = true,         -- loop while the loading screen is open (false = play once)
		MusicCheckSeconds = 6,    -- one candidate may take this long to load before the next one is tried
		MusicMaxTries = 8,        -- at most this many candidates are tried per launch (each try is one audio download)
		SoundDownloadSeconds = 6, -- the SoundUrl download never delays start-up longer than this
		-- timings (seconds)
		DropStagger = 0.14,       -- between title letters
		TypeSpeed = 0.045,        -- per typed character
		MaxSeconds = 14,          -- watchdog: forces the "tap to open" state with a warning. It never opens the hub.
		PreloadSeconds = 6,       -- cap for asset preloading
	},

	-- MUSIC tab (the player and its song list). Every row is  { id, title, artist, seconds, kind }  with kind = an id of Kinds
	-- below (or "both" = Phonk and Funk); seconds = 0 means the length is not known yet. They are public Creator Store audio ids taken from
	-- public lists (allthings.how, beebom, nerdschalk, bloxodes). Roblox can make any audio private or remove it at any time,
	-- and none of these could be played from the build sandbox, so every song is tested on YOUR device the first time you
	-- play it (or with "Check all" in the Music tab) and the ones that fail are hidden. Add or remove rows freely (digits
	-- only). You can also add ids from inside the Music tab without editing this file.
	Music = {
		CheckSeconds = 10, -- a song that has not loaded after this long counts as unavailable
		SkipTries = 6,     -- Next / Previous / auto-advance skip at most this many unavailable songs in a row
		ListBatch = 40,    -- the list shows this many songs, then a "Show more" button
		-- the categories of the Music tab. The Kind dropdown, the player's chip, the idle text and the Information page all read
		-- their labels from here. A row's last field is one of these ids, or "both" (= Phonk and Funk, shown under those two).
		Kinds = {
			{ id = "phonk", label = "Phonk" },
			{ id = "funk", label = "Funk" },
			{ id = "love", label = "Love songs" },
			{ id = "self", label = "For myself" },
			{ id = "gang", label = "Gang vibes" },
			{ id = "hits", label = "Hits" },
			{ id = "rock", label = "Rock" },
		},
		-- your own Spotify playlists ("Your Spotify" in the Music tab). The hub cannot play Spotify: the buttons only copy the
		-- link. items is the number the playlist page showed when this build was made; it is not read live.
		Playlists = {
			{ name = "eyahkla osa", items = 567, url = "https://open.spotify.com/playlist/36wb1F1wQAjy9Sitf1EPUF" },
			{ name = "YWGCHINL0RD", items = 61, url = "https://open.spotify.com/playlist/1b3ErwFOKsr72uNJwLbemW" },
		},
		Tracks = {
			-- listed on allthings.how, re-checked there on Oct 14, 2026 (name, artist and length come from that list)
			{ "129098116998483", "TOMA FUNK PHONK", "Symphonk", 150, "both" },
			{ "136932193331774", "ROBLOX PHONK", "Misutra", 155, "phonk" },
			{ "103409297553965", "FUNK FESTA", "Killing Spree Beatz", 157, "funk" },
			{ "14145620056", "The Final Phonk", "Perfect Time Music", 93, "phonk" },
			{ "125476440612900", "67 KID PHONK", "DRIFTGOD", 104, "phonk" },
			{ "95131770144654", "AURA = inf (Brazilian Phonk/Funk Epic Aura Music)", "AURA x PHONK", 94, "both" },
			{ "139266399633943", "Lost Phonk", "Swintro", 228, "phonk" },
			{ "119598380829349", "Rat Dance Phonk", "RickyPedia", 121, "phonk" },
			{ "140504265985079", "Football Edit - Phonk Trap", "Love Sleep Repeat", 125, "phonk" },
			{ "85735197482652", "DRIFT NIGHT PHONK (Car Motion Edit)", "AT Musica", 130, "phonk" },
			{ "128510578554487", "TIKI TIKI FUNK (Sped Up)", "PHONK G1RL", 80, "funk" },
			{ "128438366056581", "Tung Tung Tung Sahur Phonk", "COWBELL REAPER", 62, "phonk" },
			{ "77701977147898", "SHADOW PHONK BRAZIL (Dark Atmosphere Edit)", "AT Musica", 117, "phonk" },
			{ "140691985128867", "HYDERABADI PHONK (MARFA STYLE)", "Dj Nikhil Martyn", 145, "phonk" },
			{ "139777823649977", "#phonkmusic", "PHONK ROYALTY FREE", 128, "phonk" },
			{ "92299938059573", "Miguel Phonk", "Majestic Violin", 110, "phonk" },
			{ "134434412138800", "MEGAPHONK", "Lowifer", 229, "phonk" },
			{ "108154450229025", "Plants vs Zombies Phonk (Slowed)", "Checo's", 147, "phonk" },
			{ "135862064486942", "BRAZILIAN PHONK", "Maxlow", 155, "phonk" },
			{ "140215257631273", "Eclipse Drift", "SynthWavesZ", 127, "phonk" },
			{ "140439256760765", "Blood on the Asphalt", "Aero Phonk", 95, "phonk" },
			{ "139904111224548", "Urban Mirage - Night Drive Edit", "Phonkon", 105, "phonk" },
			{ "138178180069464", "PHONK SOMBRIO", "NOXDRIFT", 126, "phonk" },
			{ "136674057014960", "No Batidao Funk 2 (Super Slowed)", "DeshoDesh", 87, "funk" },
			{ "102866809292046", "Midnight Heat (Ambient Sensual Phonk)", "Mitchell's Multiverse Of Music", 158, "phonk" },
			{ "126132092368935", "MONTAGEM AURA", "Menina de Brazil", 100, "funk" },
			{ "131866006114988", "ACELERA (Brazilian Phonk)", "FLEXUS", 97, "phonk" },
			{ "140134130458943", "Circuit Drift", "Drift Beat Tokyo", 213, "phonk" },
			{ "140667339171815", "Desprezo (Aggressive Phonk, Slowed + Reverb)", "Alexandre Ze Musician", 116, "phonk" },
			{ "134366188285514", "ROBLOX GIGACHAD PHONK", "Misutra", 104, "phonk" },
			{ "140254463357652", "Phonk Mo", "SkitzoBeats2030", 174, "phonk" },
			{ "134289279929880", "Aura Phonk", "Young Kapusta", 100, "phonk" },
			{ "74793860481732", "2 PHUT HON (Brazilian Phonk/Funk Epic Aura Music)", "AURA x PHONK", 115, "both" },
			{ "127741614429245", "TIKI TIKI FUNK", "PHONK G1RL", 89, "funk" },
			{ "114788894326738", "Ghost Lane", "Khai GOD", 134, "phonk" },
			{ "78571301330361", "Nightmare (Drift Phonk)", "Sky-c", 227, "phonk" },
			{ "136350225160627", "BLOODY! FUNK", "Phonkholic", 81, "funk" },
			{ "140415473717614", "Al Nacer (Ultra Slowed)", "DeshoDesh", 89, "phonk" },
			{ "71044023212052", "TIKI TIKI FUNK (Ultra Slowed)", "PHONK G1RL", 137, "funk" },
			{ "71659730326072", "Yara Yara Ya Phonk", "Beaver Boys", 201, "phonk" },
			{ "135822443550596", "MOG PHONK", "SHAKA LE TIGRE", 136, "phonk" },
			{ "99979837873059", "+100k AURA PHONK", "SHAKA LE TIGRE", 153, "phonk" },
			{ "140179571050556", "BRUTALIX", "PHONKTAGRAM", 122, "phonk" },
			{ "101382134303698", "SIGMA ENERGY PHONK (Cold Aura Edit)", "AT Musica", 133, "phonk" },
			{ "133872159686728", "Viral Football Edit Phonk", "Love Sleep Repeat", 117, "phonk" },
			{ "140269857340979", "Baby Boo PHONK", "KRYPTX", 68, "phonk" },
			{ "71551309767068", "Brainrot carnival song (brazilian phonk)", "RocViBabot", 166, "phonk" },
			{ "79029575185337", "EMOTIONAL PHONK BRAZIL (Sad Mood Edit)", "AT Musica", 141, "phonk" },
			{ "118659968747915", "MONTAGEM MIAU", "Penelope Speed", 100, "funk" },
			{ "114152684566510", "Dead Yesterdays (Drift Phonk)", "Sky-c", 237, "phonk" },
			{ "139742201959014", "BAILE SELVAGEM (B)", "Phonk Voltage", 73, "funk" },
			{ "131732248464220", "Six Seven (Phonk)", "Disan Beat", 110, "phonk" },
			{ "95924518033822", "Katseye Phonk Song", "BENJIxScarlett", 81, "phonk" },
			{ "139364733224542", "MENTE MA", "Penelope Speed", 120, "phonk" },
			{ "136259851989379", "No Batidao Montagem (Sped Up)", "DeshoDesh", 89, "funk" },
			{ "125080074540092", "GYM PHONK", "NOXDRIFT", 118, "phonk" },
			{ "89449802432408", "Midnight Fog (Ambient Sensual Phonk)", "Mitchell's Multiverse Of Music", 148, "phonk" },
			{ "138608395929191", "Burning Memory Phonk Funk (slowed)", "DeshoDesh", 73, "both" },
			{ "101554751678049", "SIXSEVEN 67 PHONK ANTHEM (BROOKHAVEN)", "Ondas Electricas", 207, "phonk" },
			{ "109662743902778", "PHONKGINE 22 (Cyber Pulse Theme)", "BLACKHOLE", 157, "phonk" },
			{ "108607548201778", "STREET PHONK BRAZIL (Urban Edit Vibe)", "AT Musica", 137, "phonk" },
			{ "129794577122360", "Tsuru no Oto", "WA-GIRL FUNK", 68, "funk" },
			{ "114525275626826", "BRAINROT DISCO FUNK", "R1R2 Phonk", 191, "funk" },
			{ "73460666355457", "Polish Cow Phonk", "Gaff", 120, "phonk" },
			{ "134653609966867", "Montagem Supersonic", "Z City Phonk", 116, "funk" },
			{ "139161205970637", "Dress To Impress Theme (PHONK EDIT)", "ChillPanic", 163, "phonk" },
			{ "135209837340816", "Phonk Roblox Meme", "BoomCore", 286, "phonk" },
			{ "132045045896336", "Goosebumps All Over (Brazilian phonk & Phonk)", "Lil Rapjoke", 95, "phonk" },
			{ "134406710152287", "Neon Predator Mode", "Neon Cyber District", 172, "phonk" },
			{ "137691412494086", "Drift Storm - Car Bass Boosted 2025", "Phonkon", 129, "phonk" },
			{ "128825897988432", "Pieces (Drift Phonk)", "Sky-c", 152, "phonk" },
			{ "129870811738706", "Gym Football Phonk Motivation", "Love Sleep Repeat", 130, "phonk" },
			{ "140580823167015", "Voltstorm (Overload Phonk Energy)", "ASTRA GRIND", 199, "phonk" },
			{ "92045878932953", "Night Shadow (Ambient Sensual Phonk)", "Mitchell's Multiverse Of Music", 171, "phonk" },
			{ "74339364466686", "Layam (Malayalam Ritual Phonk)", "Ambient Echos Official", 202, "phonk" },
			{ "104918743319996", "Moonlit Tire Marks (Ambient Sensual Phonk)", "Mitchell's Multiverse Of Music", 189, "phonk" },
			{ "111921203483149", "Phonk Troll Face", "SkitzoBeats2030", 313, "phonk" },
			{ "116690587449059", "No Batidao Montagem (Slowed)", "DeshoDesh", 125, "funk" },
			{ "84911925564617", "SIGMA BOY PHONK", "Oro Loco", 161, "phonk" },
			{ "112382718143604", "Ryugu", "WA-GIRL FUNK", 80, "funk" },
			{ "126617625293761", "Football Skills Edit with Phonk", "Love Sleep Repeat", 117, "phonk" },
			{ "104185011771893", "Brainrot Phonk, Pt. 1", "Melodynestia", 120, "phonk" },
			{ "101659475300792", "Lets Pray (Brazilian Phonk)", "Sky-c", 152, "phonk" },
			{ "128386068316811", "FAMA E VENENO", "Menina de Brazil", 117, "phonk" },
			{ "137589724762757", "Phonk of the Ghostly Steam (How It Sounds)", "e$$V", 85, "phonk" },
			{ "135101066737097", "LET ME SHOW YOU HOW ITS DONE", "Kamuragi", 118, "phonk" },
			{ "119560785746143", "MONTAGEM MEOWL", "PHONK G1RL", 100, "funk" },
			{ "137032467545645", "Montagem Brazilian Funk", "Phonkholic", 240, "funk" },
			{ "92040177250773", "No Batidao Phonk 2 (Ultra Slowed)", "DeshoDesh", 98, "both" },
			{ "139236589497100", "Montagem Supersonic (Mega Slowed)", "DeshoDesh", 87, "funk" },
			{ "123808416160601", "REVENGE MODE PHONK (Comeback Energy Edit)", "AT Musica", 156, "phonk" },
			{ "138950692714324", "PIPI KIWI PHONK", "DRIFTGOD", 69, "phonk" },
			{ "87883832538701", "Moonlight Shadows (Ambient Sensual Phonk)", "Mitchell's Multiverse Of Music", 153, "phonk" },
			-- more public lists (beebom, nerdschalk, bloxodes, July - Oct 2026); "unknown artist" / 0 = not given there
			{ "140245756477343", "MONTAGEM BENCAO (slowed)", "PHONKSUKI", 98, "funk" },
			{ "138682744064257", "MONTAGEM SOMBRIA", "XONIFY", 75, "funk" },
			{ "136221009150327", "MONTAGEM DRIFT ETERNO", "XONIFY", 102, "funk" },
			{ "136079183541105", "MONTAGEM SOMBRIA (SLOWED)", "XONIFY", 130, "funk" },
			{ "79148752172118", "MONTAGEM DO KARMA (SLOWED)", "XONIFY", 107, "funk" },
			{ "108197999527217", "MONTAGEM DO CAOS (SLOWED)", "XONIFY", 128, "funk" },
			{ "115735400578427", "MONTAGEM CINZAS NO ASFALTO", "XONIFY", 0, "funk" },
			{ "117225553650826", "MONTAGEM FANTASMA (SLOWED)", "XONIFY", 0, "funk" },
			{ "75493829734428", "MONTAGEM DRIFT ETERNO (SLOWED)", "XONIFY", 0, "funk" },
			{ "133507343227511", "MONTAGEM CONTIGO", "Penelope Speed", 157, "funk" },
			{ "105647322270741", "MONTAGEM NO RITMO (Ultra Slowed)", "FLEXUS", 88, "funk" },
			{ "139959590610806", "FUNK FESTA 2", "Killing Spree Beatz", 94, "funk" },
			{ "77874619166101", "FUNK FESTA 3", "Killing Spree Beatz", 118, "funk" },
			{ "88378288910365", "Toca Toca", "Unknown artist", 0, "funk" },
			{ "86375151296706", "FUNK INFERNA V2 Phonk (Deep Slowed)", "Unknown artist", 0, "both" },
			{ "102827114027930", "Mano Mama Funk Phonk Slowed", "Unknown artist", 0, "both" },
			{ "104603824839639", "BATIDA SELVAGEM (SUPER HIT PHONK MUSIC)", "Unknown artist", 0, "both" },
			{ "124170748342120", "AURA SAIYAN DROP (Brazilian Phonk Music)", "Unknown artist", 0, "phonk" },
			{ "96688874266744", "Noite do Capim (Brazilian Phonk)", "Unknown artist", 0, "phonk" },
			{ "139769280318833", "Spain vs Argentina (Brazilian Phonk)", "Unknown artist", 0, "phonk" },
			{ "102892380593258", "Aggressive Brazilian Phonk", "Unknown artist", 0, "phonk" },
			{ "94935794334796", "Happy Birthday (Brazilian Phonk)", "Unknown artist", 0, "phonk" },
			{ "129276852097746", "Brazilian Phonk Fiesta", "Unknown artist", 0, "phonk" },
			{ "108621585736031", "Brazilian Phonk", "Unknown artist", 0, "phonk" },
			{ "110817176848617", "Montagem Panama (Bass Boosted Phonk)", "Unknown artist", 0, "both" },
			{ "80059228606274", "Festival Phonk", "Unknown artist", 0, "phonk" },
			{ "118241465317467", "Cinematic Phonk Horizon", "Unknown artist", 0, "phonk" },
			{ "80159531756934", "Violin Phonk", "Unknown artist", 0, "phonk" },
			{ "124114599222464", "CodeONIONIONION Phonk", "Unknown artist", 0, "phonk" },
			{ "75764445212230", "Night Drive Phonk", "Unknown artist", 0, "phonk" },
			{ "74624205665267", "Marcha Phonk", "Unknown artist", 0, "phonk" },
			{ "100221387261601", "Drifting Phonk", "Unknown artist", 0, "phonk" },
			{ "111353716537070", "Gulumulu Phonk", "Unknown artist", 0, "phonk" },
			{ "86517694279595", "What the Phonk?", "Unknown artist", 0, "phonk" },
			{ "127096476530496", "Oasis Phonk (Slowed)", "Unknown artist", 0, "phonk" },
			{ "120569165858495", "Oasis Phonk", "Unknown artist", 0, "phonk" },
			{ "103415930328599", "Electric Phantom (Phonk)", "Unknown artist", 0, "phonk" },
			{ "111109407506851", "Rogue City Phonk", "Unknown artist", 0, "phonk" },
			{ "136974179670066", "Chill Phonk (DAMAS)", "Unknown artist", 0, "phonk" },
			{ "112576678639596", "GTA VI Phonk", "Unknown artist", 0, "phonk" },
			{ "86802355429172", "Final Ride Phonk", "Unknown artist", 0, "phonk" },
			{ "83624433031847", "GTR Phonk", "Unknown artist", 0, "phonk" },
			{ "123047130884626", "Doggy Phonk", "Unknown artist", 0, "phonk" },
			{ "79891860327495", "Meowl Phonk", "Unknown artist", 0, "phonk" },
			{ "89824897586105", "Above Phonk", "Unknown artist", 0, "phonk" },
			{ "71837666565538", "Savage Slay Phonk", "Unknown artist", 0, "phonk" },
			{ "101326109963284", "F-Phonk", "Unknown artist", 0, "phonk" },
			{ "99202286140027", "Phonk Addiction", "Unknown artist", 0, "phonk" },
			{ "97192334657561", "Phonk.exe", "Unknown artist", 0, "phonk" },
			{ "72653741821355", "Phonk Drift", "Unknown artist", 0, "phonk" },
			{ "139694762285253", "Phonk City", "Unknown artist", 0, "phonk" },
			{ "114145613542169", "Phonk House", "Unknown artist", 0, "phonk" },
			-- Love songs. Listed on bloxodes.com (artist pages) and allthings.how (pop and rap lists), seen 2026-10-21. Not played here.
			{ "83044441499891", "Rose's Thorn", "Enoch Braxton", 168, "love" },
			{ "90261068165719", "Best Time Ever", "Enoch Braxton", 150, "love" },
			{ "138648311721618", "Paradise Found", "Enoch Braxton", 150, "love" },
			{ "116181497813887", "Sweet serenade", "1 HOUR COLLECTION", 240, "love" },
			{ "131595839693209", "Chocolate & mint", "1 HOUR COLLECTION", 239, "love" },
			{ "131748166999125", "The language of love", "1 HOUR COLLECTION", 232, "love" },
			{ "91114893586212", "Whispers of the heart", "1 HOUR COLLECTION", 207, "love" },
			{ "129430874754117", "Evening sunset", "1 HOUR COLLECTION", 187, "love" },
			{ "132469746985185", "Love whispers", "1 HOUR COLLECTION", 217, "love" },
			{ "113214479120811", "Convenience store love", "Cyberflow", 161, "love" },
			{ "1843523734", "Pocketful Of Love - Instrumental", "Ronald W. Boustead", 154, "love" },
			{ "1841425774", "Tripping on Love b", "Ashley Collins", 182, "love" },
			{ "138108296865882", "You Were My Safe Place", "Da Songs", 196, "love" },
			{ "133844122544081", "I Love Still You", "Chilled Monkey LoFi", 118, "love" },
			{ "140684861805080", "His Love", "GAT CleofeDay", 214, "love" },
			-- For myself. Listed on allthings.how (rap and pop lists) and bloxodes.com (artist pages), seen 2026-10-21. Not played here.
			{ "82566987333046", "to myself", "Eddy Giaguaro aka Sensi Skunk", 271, "self" },
			{ "114213622974713", "The Loneliest Hour", "Chilled Monkey LoFi", 240, "self" },
			{ "139563998613132", "Shadows of What Could Have Been", "Chilled Monkey LoFi", 184, "self" },
			{ "140404470293309", "Late Night Cypher Notes", "Lofi Nocturne", 171, "self" },
			{ "92037635617372", "The Silence You Left Behind", "TBT Music", 263, "self" },
			{ "140593409034670", "Lonely Skyline", "Midnight Hikari", 245, "self" },
			{ "131012909150870", "Empty Room Echoes", "Da Songs", 238, "self" },
			{ "133858810271812", "Low Tide Mind", "SUN.sound", 168, "self" },
			{ "95884668843668", "Undertow", "SUN.sound", 264, "self" },
			{ "80813447706013", "Lights Never Fade", "JBio Station", 201, "self" },
			{ "1837324500", "Sunrise Workout", "Boris Popov", 178, "self" },
			{ "139419290426690", "First Snow", "Timeless Breeze", 127, "self" },
			{ "140660383888658", "Sun on the Porch - Underscore", "John Allan", 111, "self" },
			{ "140375962559637", "Lo-Fi Beats for Calm Focus", "Love Sleep Repeat", 160, "self" },
			{ "75094043560596", "Calm Lofi Hip Hop Background Music", "Love Sleep Repeat", 315, "self" },
			{ "9043887091", "Lo-fi Chill A", "Hip Hop Shop", 137, "self" },
			{ "9047105702", "Light Dreamer", "Afro Dizzy", 150, "self" },
			{ "9047104336", "Sunday In Bed", "Afro Dizzy", 170, "self" },
			{ "9047104752", "Monday Morning", "Afro Dizzy", 142, "self" },
			{ "136228570470406", "Apartment Windows with Modern Chill Jazz", "Spa Fox", 138, "self" },
			{ "103472641865127", "In My Tide", "Baby Your Heart", 174, "self" },
			{ "74705301071164", "Zen Garden Melodies", "Baby Your Heart", 240, "self" },
			{ "110894150142479", "Analog Dreams", "Baby Your Heart", 240, "self" },
			{ "135703094138072", "Dance of the Raindrops", "Baby Your Heart", 240, "self" },
			{ "87892399979599", "Stellar Dreams", "Baby Your Heart", 235, "self" },
			{ "120819152910593", "La Biblioteca Encantada", "Baby Your Heart", 147, "self" },
			{ "139824343487770", "Moonlit Whispers", "Lofi Penguin Chill", 103, "self" },
			{ "97530790542195", "Study Sanctuary", "Lofi Penguin Chill", 173, "self" },
			{ "95190013951139", "Galactic Dusk", "Lofi Penguin Chill", 218, "self" },
			{ "98213092795165", "Eternal Snowfall", "Lofi Penguin Chill", 200, "self" },
			-- Gang vibes. Listed on allthings.how (rap list, page dated 2026-10-14), seen 2026-10-21. Not played here.
			{ "92774322259700", "Rap-hip-hop- type beat- Gomood", "GOMOOD", 121, "gang" },
			{ "83458446126021", "Hip-hop chill br-type-beat-gomood", "GOMOOD", 187, "gang" },
			{ "135608937654783", "Hip-hop-base-type beat-Gomood", "GOMOOD", 78, "gang" },
			{ "128563409090413", "Free (Rap Beat, Hip Hop,Trap Beat style)", "Pearo Prak", 129, "gang" },
			{ "104710949810835", "Street Kings Rap Beat style, Hip Hop", "Pearo Prak", 99, "gang" },
			{ "133707463991288", "hiphop rap beats tony", "BIG PAHA", 64, "gang" },
			{ "137005769881876", "hiphop rap beats risky", "BIG PAHA", 110, "gang" },
			{ "135715206696362", "hiphop rap beats tape", "BIG PAHA", 74, "gang" },
			{ "129727927754845", "Sax 67 - Rap Freestyle Beat", "TOPGMUSIC", 195, "gang" },
			{ "114566674164773", "Grind (GTA-Type Rap Beat)", "Free Content Lab", 187, "gang" },
			{ "137248427115861", "Beat Rap Freestyle (Lealtad) Pista de Rap", "crazymelodyrd", 199, "gang" },
			{ "121346459467899", "Hallo Effect (Hip Hop/Rap/GYM FITNESS TYPE BEAT)", "M.a.t Rhyme$", 262, "gang" },
			{ "100791776007301", "Hardcore rap Beat", "AesUno", 215, "gang" },
			{ "108946028657445", "beat type hip hop 90 old", "jair mauleon", 174, "gang" },
			{ "140336894268417", "Freestyle Hip Hop Beat - Classic Street Flow", "Love Sleep Repeat", 129, "gang" },
			-- Hits. Listed on allthings.how (rap and pop lists) and bloxodes.com (ska genre page), seen 2026-10-21. Not played here.
			{ "125448555766538", "Club hip hop dance party", "Kosta DJK", 168, "hits" },
			{ "72996759431060", "Electronic passage hip hop club", "Kosta DJK", 197, "hits" },
			{ "106388277953916", "Drip,Drop,Hip-Hop", "Boparoo", 121, "hits" },
			{ "140374784621006", "Throne Hip Hop Reign", "Medieval Fantasy Portal", 168, "hits" },
			{ "140175169828824", "Kawaii Future Pop - Upbeat J-Pop Song", "Love Sleep Repeat", 151, "hits" },
			{ "86994568529028", "Attention Span (Pop + Electronic)", "Genre Soup", 165, "hits" },
			{ "139367353722759", "Electronic Candy", "PoPi", 208, "hits" },
			{ "140317576492006", "Crafty Bounce Pop - Fun Background Music", "Happy Voxel", 100, "hits" },
			{ "1838028467", "VIP Me (a)", "Solomon Bear", 175, "hits" },
			{ "89470208267213", "City Pop Fever", "Tokyo Lofi Beats", 160, "hits" },
			{ "1838621326", "Feeling The Vibe (Instrumental)", "Thierry Los", 162, "hits" },
			-- Rock. Listed on bloxodes.com (genre and artist pages) and allthings.how (pop list), seen 2026-10-21. Not played here.
			{ "1845334582", "Power Pop", "Chris Goulstone", 157, "rock" },
			{ "1837688465", "Electro Punk Pop", "Robert Edwards", 171, "rock" },
			{ "1841644499", "Perfect Eleven b", "KPM Main Series", 161, "rock" },
			{ "1837018903", "Summer's Here", "Ryan Keaton", 124, "rock" },
			{ "1837030430", "Go Just Go", "Scott Stallone", 122, "rock" },
			{ "1837019752", "The Runaway", "Matthew Naylor", 118, "rock" },
			{ "1836828620", "Chicane Boys", "Jimmy Kaleth", 143, "rock" },
			{ "1836829135", "Turn Up The Heat", "Jimmy Kaleth", 143, "rock" },
			{ "1842662245", "Rock N Rolla - Non Vocal Mix", "Terry Caster", 166, "rock" },
			{ "1842708934", "Daybreak - Alternative Mix", "Terry Caster", 153, "rock" },
			{ "1846863463", "Bust Out A", "JD Trigger", 162, "rock" },
			{ "1846864111", "Take Me Far Away A", "JD Trigger", 200, "rock" },
			{ "1846864315", "Unnatural Anthem A", "JD Trigger", 214, "rock" },
			{ "1837770977", "Bring It On (b)", "Richard Lewis", 167, "rock" },
			{ "1837759310", "High Octane (a)", "Richard Lewis", 168, "rock" },
			{ "1847485209", "Evelyn A", "Brian James Brasher", 174, "rock" },
			{ "1836106820", "Positive Trendy Rock", "Unknown artist", 172, "rock" },
			{ "1836106785", "Optimistic Trendy Rock", "Unknown artist", 170, "rock" },
			{ "1836107155", "Powerful Trendy Rock", "Unknown artist", 167, "rock" },
		},
	},

	-- UI sounds. IDs come from the scripts you supplied (Multiverse click, Blyxo hover / loading /
	-- error). They could NOT be verified from the build sandbox, so every asset is preloaded at
	-- boot and anything that fails to load is skipped silently (see Settings > Sound status).
	-- Replace an id with any audio asset you own or that is public. Use "" to disable an event.
	-- Fields: id, volume (0-1), speed (pitch), chain (list of {at = seconds, speed = n}).
	Sounds = {
		click    = { id = "rbxassetid://6895079853",   volume = 0.35, speed = 1.00 },
		select   = { id = "rbxassetid://6895079853",   volume = 0.30, speed = 1.18 },
		toggleOn = { id = "rbxassetid://6895079853",   volume = 0.32, speed = 1.32 },
		toggleOff= { id = "rbxassetid://6895079853",   volume = 0.30, speed = 0.82 },
		dropdown = { id = "rbxassetid://6895079853",   volume = 0.28, speed = 1.06 },
		tab      = { id = "rbxassetid://139800881181209", volume = 0.40, speed = 1.00 },
		open     = { id = "rbxassetid://139800881181209", volume = 0.40, speed = 0.92 },
		close    = { id = "rbxassetid://139800881181209", volume = 0.40, speed = 0.74 },
		success  = { id = "rbxassetid://6895079853",   volume = 0.30, speed = 1.20,
			chain = { { at = 0.00, speed = 1.20 }, { at = 0.075, speed = 1.62 } } },
		warning  = { id = "rbxassetid://6895079853",   volume = 0.32, speed = 0.78,
			chain = { { at = 0.00, speed = 0.78 }, { at = 0.10, speed = 0.78 } } },
		error    = { id = "rbxassetid://71028126634386", volume = 0.45, speed = 1.00 },
		-- loading music: the id is filled in at start-up by Splash.resolveSound for a local file / download. An rbxassetid from
		-- CONFIG.Splash.SoundAssetIds is picked in the background instead and leaves this id empty.
		-- No maxSeconds: it loops while the loading screen is up, then fades out when the screen closes.
		loading  = { id = "", volume = 0.45, speed = 1.00 },
	},

	-- Typography. "enum" families use Roblox's built-in fonts (always available).
	-- To add your own fonts later, upload them to Roblox as a Font Family asset (Creator Hub) and
	-- add an entry with  face = "rbxassetid://<family asset id>"  - nothing else has to change.
	Fonts = {
		Default = "gotham",
		Families = {
			{ id = "gotham",  name = "Gotham",       enum = { regular = "Gotham",       medium = "GothamMedium",       bold = "GothamBold" } },
			{ id = "builder", name = "Builder Sans", enum = { regular = "BuilderSans",  medium = "BuilderSansMedium",  bold = "BuilderSansBold" } },
			{ id = "source",  name = "Source Sans",  enum = { regular = "SourceSans",   medium = "SourceSansSemibold", bold = "SourceSansBold" } },
			{ id = "ubuntu",  name = "Ubuntu",       enum = { regular = "Ubuntu",       medium = "Ubuntu",             bold = "Ubuntu" } },
			{ id = "roboto",  name = "Roboto",       enum = { regular = "Roboto",       medium = "Roboto",             bold = "Roboto" } },
			-- { id = "brand", name = "My Brand Font", face = "rbxassetid://0" },   <- example, keep commented until you have an id
		},
	},
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local function optionalService(name)
	local ok, service = pcall(game.GetService, game, name)
	if ok then
		return service
	end
	return nil
end

local GuiService = optionalService("GuiService")
local ContentProvider = optionalService("ContentProvider")
local SoundService = optionalService("SoundService")
local Lighting = optionalService("Lighting")
local TeleportService = optionalService("TeleportService")
local StatsService = optionalService("Stats")

local Util, Maid, Env, Store, Motion, Anim, Typo, Theme, Sfx, Notify, UI, Bg, Splash, Avatar, Win, Pages, App, Scripts, Music =
	{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}

----------------------------------------------------------------------------------------------------
-- Util: small pure helpers shared by every module
----------------------------------------------------------------------------------------------------
Util.logs = {}

function Util.log(level, message)
	local logs = Util.logs
	logs[#logs + 1] = { t = os.clock(), level = level, message = tostring(message) }
	if #logs > 80 then
		table.remove(logs, 1)
	end
end

function Util.try(label, fn, ...)
	local ok, a, b, c = pcall(fn, ...)
	if not ok then
		Util.log("error", tostring(label) .. ": " .. tostring(a))
	end
	return ok, a, b, c
end

function Util.clamp(x, lo, hi)
	if x < lo then
		return lo
	elseif x > hi then
		return hi
	end
	return x
end

function Util.lerp(a, b, t)
	return a + (b - a) * t
end

function Util.round(x, step)
	step = step or 1
	return math.floor(x / step + 0.5) * step
end

function Util.percent(x)
	return math.floor(x * 100 + 0.5)
end

function Util.trim(s)
	s = tostring(s == nil and "" or s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

function Util.split(s, sep)
	local out, pos = {}, 1
	s = tostring(s)
	if sep == nil or sep == "" then
		out[1] = s
		return out
	end
	while true do
		local a, b = string.find(s, sep, pos, true)
		if not a then
			out[#out + 1] = string.sub(s, pos)
			break
		end
		out[#out + 1] = string.sub(s, pos, a - 1)
		pos = b + 1
	end
	return out
end

function Util.cap(s, n)
	s = tostring(s)
	if #s <= n then
		return s
	end
	return string.sub(s, 1, math.max(1, n - 3)) .. "..."
end

function Util.count(t)
	local n = 0
	for _ in pairs(t) do
		n = n + 1
	end
	return n
end

function Util.indexOf(list, value)
	for i = 1, #list do
		if list[i] == value then
			return i
		end
	end
	return nil
end

function Util.copy(t)
	local out = {}
	for k, v in pairs(t) do
		out[k] = v
	end
	return out
end

function Util.deepCopy(t)
	if type(t) ~= "table" then
		return t
	end
	local out = {}
	for k, v in pairs(t) do
		out[k] = Util.deepCopy(v)
	end
	return out
end

function Util.hash(s)
	local h = 5381
	for i = 1, #s do
		h = (h * 33 + string.byte(s, i)) % 4294967296
	end
	return string.format("%08x", h)
end

function Util.duration(seconds)
	seconds = math.max(0, math.floor(seconds))
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	if h > 0 then
		return string.format("%dh %02dm", h, m)
	end
	return string.format("%dm %02ds", m, s)
end

function Util.jsonEncode(value)
	local ok, result = pcall(HttpService.JSONEncode, HttpService, value)
	if ok then
		return result
	end
	return nil, result
end

function Util.jsonDecode(text)
	local ok, result = pcall(HttpService.JSONDecode, HttpService, text)
	if ok then
		return result
	end
	return nil, result
end

-- colour helpers ------------------------------------------------------------------------------
function Util.mix(a, b, t)
	if t <= 0 then
		return a
	elseif t >= 1 then
		return b
	end
	return Color3.new(a.R + (b.R - a.R) * t, a.G + (b.G - a.G) * t, a.B + (b.B - a.B) * t)
end

local function linearChannel(v)
	if v <= 0.04045 then
		return v / 12.92
	end
	return ((v + 0.055) / 1.055) ^ 2.4
end

function Util.lum(c)
	return 0.2126 * linearChannel(c.R) + 0.7152 * linearChannel(c.G) + 0.0722 * linearChannel(c.B)
end

function Util.contrast(a, b)
	local la, lb = Util.lum(a), Util.lum(b)
	if la < lb then
		la, lb = lb, la
	end
	return (la + 0.05) / (lb + 0.05)
end

-- text colour (dark or light) that reads best on `bg`
function Util.onColor(bg, dark, light)
	dark = dark or Color3.fromRGB(12, 14, 20)
	light = light or Color3.fromRGB(248, 250, 253)
	if Util.contrast(bg, dark) >= Util.contrast(bg, light) then
		return dark
	end
	return light
end

function Util.lighten(c, t)
	return Util.mix(c, Color3.new(1, 1, 1), t)
end

function Util.darken(c, t)
	return Util.mix(c, Color3.new(0, 0, 0), t)
end

-- instance helpers (properties are assigned BEFORE parenting, which is cheaper) ----------------
function Util.new(className, props, parent)
	local inst = Instance.new(className)
	if props then
		for key, value in pairs(props) do
			inst[key] = value
		end
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

function Util.corner(parent, radius)
	return Util.new("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parent)
end

function Util.round_corner(parent)
	return Util.new("UICorner", { CornerRadius = UDim.new(1, 0) }, parent)
end

function Util.stroke(parent, color, thickness, transparency)
	return Util.new("UIStroke", {
		Color = color or Color3.new(1, 1, 1),
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, parent)
end

function Util.pad(parent, left, top, right, bottom)
	top = top or left
	right = right or left
	bottom = bottom or top
	return Util.new("UIPadding", {
		PaddingLeft = UDim.new(0, left or 0),
		PaddingTop = UDim.new(0, top or 0),
		PaddingRight = UDim.new(0, right or 0),
		PaddingBottom = UDim.new(0, bottom or 0),
	}, parent)
end

function Util.list(parent, padding, horizontal)
	return Util.new("UIListLayout", {
		FillDirection = horizontal and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, padding or 0),
	}, parent)
end

function Util.isInstance(v)
	return typeof(v) == "Instance"
end

function Util.alive(inst)
	return inst ~= nil and typeof(inst) == "Instance" and inst.Parent ~= nil
end

----------------------------------------------------------------------------------------------------
-- Maid: collects connections / instances / callbacks so teardown is one call
----------------------------------------------------------------------------------------------------
Maid.__index = Maid

function Maid.new()
	return setmetatable({ _items = {}, _n = 0 }, Maid)
end

local function disposeItem(item)
	local kind = typeof(item)
	if kind == "function" then
		pcall(item)
	elseif kind == "RBXScriptConnection" then
		pcall(item.Disconnect, item)
	elseif kind == "Instance" then
		if item.ClassName == "Tween" then
			pcall(item.Cancel, item)
		end
		pcall(item.Destroy, item)
	elseif kind == "thread" then
		pcall(task.cancel, item)
	elseif kind == "table" then
		if type(item.Destroy) == "function" then
			pcall(item.Destroy, item)
		elseif type(item.Disconnect) == "function" then
			pcall(item.Disconnect, item)
		elseif type(item.Cancel) == "function" then
			pcall(item.Cancel, item)
		end
	end
end

function Maid:Give(item)
	if item ~= nil then
		self._n = self._n + 1
		self._items[self._n] = item
	end
	return item
end

function Maid:Connect(signal, fn)
	return self:Give(signal:Connect(fn))
end

function Maid:Clean()
	local items, n = self._items, self._n
	self._items, self._n = {}, 0
	for i = n, 1, -1 do
		disposeItem(items[i])
	end
end

Maid.Destroy = Maid.Clean

----------------------------------------------------------------------------------------------------
-- Env: executor / platform feature detection. Every executor global is read inside pcall.
----------------------------------------------------------------------------------------------------
local function optionalGlobal(getter)
	local ok, value = pcall(getter)
	if ok and type(value) == "function" then
		return value
	end
	return nil
end

Env.fn = {}

function Env.detect()
	local fn = Env.fn
	fn.writefile = optionalGlobal(function() return writefile end)
	fn.readfile = optionalGlobal(function() return readfile end)
	fn.isfile = optionalGlobal(function() return isfile end)
	fn.makefolder = optionalGlobal(function() return makefolder end)
	fn.isfolder = optionalGlobal(function() return isfolder end)
	fn.getcustomasset = optionalGlobal(function() return getcustomasset or getsynasset end)
	fn.setclipboard = optionalGlobal(function() return setclipboard or toclipboard end)
	fn.request = optionalGlobal(function()
		return request or http_request or (syn and syn.request) or (http and http.request)
	end)
	fn.gethui = optionalGlobal(function() return gethui end)
	fn.getgenv = optionalGlobal(function() return getgenv end)
	fn.identify = optionalGlobal(function() return identifyexecutor or getexecutorname end)
	fn.loadstring = optionalGlobal(function() return loadstring end)
	fn.httpget = optionalGlobal(function() return game.HttpGet end)

	Env.executor, Env.executorVersion = "unknown", ""
	if fn.identify then
		local ok, name, version = pcall(fn.identify)
		if ok and type(name) == "string" and name ~= "" then
			Env.executor = name
			if type(version) == "string" then
				Env.executorVersion = version
			end
		end
	end

	Env.touch = UserInputService.TouchEnabled
	Env.keyboard = UserInputService.KeyboardEnabled
	Env.mouse = UserInputService.MouseEnabled
	return Env
end

function Env.canSave()
	local fn = Env.fn
	return fn.writefile ~= nil and fn.readfile ~= nil and fn.isfile ~= nil
end

function Env.canClipboard()
	return Env.fn.setclipboard ~= nil
end

function Env.canCustomAsset()
	return Env.fn.getcustomasset ~= nil and Env.canSave()
end

function Env.canDownload()
	return Env.canCustomAsset() and (Env.fn.request ~= nil)
end

-- Some executors expose the file functions but refuse every call. A harmless folder query tells the two cases apart.
function Env.filesWork()
	local fn = Env.fn
	if not (fn.isfile and fn.isfolder) then
		return false
	end
	local ok = pcall(fn.isfolder, CONFIG.Folder)
	return ok
end

-- the table that survives re-execution (executor global environment, or _G as a fallback)
function Env.global()
	if Env.fn.getgenv then
		local ok, env = pcall(Env.fn.getgenv)
		if ok and type(env) == "table" then
			return env
		end
	end
	return _G
end

function Env.viewport()
	local camera = workspace.CurrentCamera
	if camera then
		local size = camera.ViewportSize
		if size.X > 50 and size.Y > 50 then
			return size
		end
	end
	return Vector2.new(800, 450)
end

function Env.localPlayer()
	local player = Players.LocalPlayer
	if player then
		return player
	end
	local waited = 0
	while not Players.LocalPlayer and waited < 10 do
		task.wait(0.1)
		waited = waited + 0.1
	end
	return Players.LocalPlayer
end

-- where the ScreenGui goes: hidden UI container when the executor offers one, else PlayerGui
function Env.guiParent()
	if Env.fn.gethui then
		local ok, container = pcall(Env.fn.gethui)
		if ok and typeof(container) == "Instance" then
			return container, "gethui"
		end
	end
	local player = Env.localPlayer()
	if player then
		local pg = player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui", 8)
		if pg then
			return pg, "PlayerGui"
		end
	end
	return nil, "none"
end

function Env.readFile(path)
	local fn = Env.fn
	if not (fn.readfile and fn.isfile) then
		return nil, "file access unavailable"
	end
	local okExists, exists = pcall(fn.isfile, path)
	if not okExists or not exists then
		return nil, "missing"
	end
	local ok, data = pcall(fn.readfile, path)
	if ok and type(data) == "string" then
		return data
	end
	return nil, tostring(data)
end

function Env.writeFile(path, data)
	if not Env.fn.writefile then
		return false, "file access unavailable"
	end
	local ok, err = pcall(Env.fn.writefile, path, data)
	if ok then
		return true
	end
	return false, tostring(err)
end

function Env.fileExists(path)
	if not Env.fn.isfile then
		return false
	end
	local ok, exists = pcall(Env.fn.isfile, path)
	return ok and exists == true
end

function Env.ensureFolder(path)
	local fn = Env.fn
	if not (fn.makefolder and fn.isfolder) then
		return false
	end
	local built = ""
	for _, part in ipairs(Util.split(path, "/")) do
		if part ~= "" then
			built = (built == "") and part or (built .. "/" .. part)
			local okExists, exists = pcall(fn.isfolder, built)
			if okExists and not exists then
				pcall(fn.makefolder, built)
			end
		end
	end
	local okFinal, final = pcall(fn.isfolder, path)
	return okFinal and final == true
end

function Env.copy(text)
	if not Env.fn.setclipboard then
		return false
	end
	local ok = pcall(Env.fn.setclipboard, tostring(text))
	return ok
end

function Env.customAsset(path)
	if not Env.fn.getcustomasset then
		return nil, "getcustomasset unavailable"
	end
	local ok, result = pcall(Env.fn.getcustomasset, path)
	if ok and type(result) == "string" and result ~= "" then
		return result
	end
	return nil, tostring(result)
end

-- plain GET used only to download an image the user explicitly typed in (never executed as code)
function Env.httpGet(url)
	local fn = Env.fn
	if fn.request then
		local ok, res = pcall(fn.request, { Url = url, Method = "GET" })
		if not ok then
			return nil, tostring(res)
		end
		if type(res) == "table" then
			local code = tonumber(res.StatusCode or res.status_code) or 0
			if (res.Success == true or (code >= 200 and code < 300)) and type(res.Body) == "string" then
				return res.Body
			end
			return nil, "HTTP " .. tostring(code)
		end
		return nil, "unexpected response"
	end
	return nil, "request function unavailable"
end

----------------------------------------------------------------------------------------------------
-- script launcher helpers (added in 2.1.0). They are used only by the Scripts tab and the Private
-- Server Finder, and only after the user taps a button. Env.httpGet above keeps its own contract
-- (image download, never executed).
----------------------------------------------------------------------------------------------------
function Env.canRun()
	return Env.fn.loadstring ~= nil
end

function Env.canFetch()
	return Env.fn.httpget ~= nil or Env.fn.request ~= nil
end

-- One GET. order: "get" (game:HttpGet, then the request function), "request" (request function, then
-- game:HttpGet) or "request-only". The second function is tried only when the first gave no HTTP status,
-- so a real 404 or 429 is final. Returns { ok, status, body, error, via }.
function Env.fetch(url, order)
	local fn = Env.fn
	local function viaHttpGet()
		if not fn.httpget then
			return { ok = false, via = "HttpGet", error = "HttpGet is not available" }
		end
		local ok, body = pcall(fn.httpget, game, url)
		if ok and type(body) == "string" then
			return { ok = true, via = "HttpGet", body = body }
		end
		return { ok = false, via = "HttpGet", error = tostring(body) }
	end
	local function viaRequest()
		if not fn.request then
			return { ok = false, via = "request", error = "request function is not available" }
		end
		local ok, res = pcall(fn.request, { Url = url, Method = "GET" })
		if not ok then
			return { ok = false, via = "request", error = tostring(res) }
		end
		if type(res) ~= "table" then
			return { ok = false, via = "request", error = "unexpected response" }
		end
		local code = tonumber(res.StatusCode or res.status_code) or 0
		local status = code > 0 and code or nil
		local success = (code >= 200 and code < 300) or (code == 0 and res.Success == true)
		if success and type(res.Body) == "string" then
			return { ok = true, via = "request", status = status, body = res.Body }
		end
		return { ok = false, via = "request", status = status, error = status and ("HTTP " .. status) or "request failed" }
	end
	local first, second = viaHttpGet, viaRequest
	if order == "request" or order == "request-only" then
		first, second = viaRequest, viaHttpGet
	end
	local result = first()
	if result.ok or result.status or order == "request-only" then
		return result
	end
	local fallback = second()
	if fallback.ok or fallback.status then
		return fallback
	end
	result.error = tostring(result.error) .. " / " .. tostring(fallback.error)
	return result
end

-- loadstring wrapper: returns the compiled function, or nil and the reason
function Env.compile(source)
	local compile = Env.fn.loadstring
	if not compile then
		return nil, "loadstring is not available"
	end
	local ok, chunk, err = pcall(compile, source)
	if not ok then
		return nil, tostring(chunk)
	end
	if type(chunk) ~= "function" then
		return nil, tostring(err or "the script could not be compiled")
	end
	return chunk
end

function Env.runSummary()
	local fn = Env.fn
	local function flag(v)
		return v and "yes" or "no"
	end
	return string.format("Run scripts (loadstring) %s | HttpGet %s | request %s", flag(fn.loadstring), flag(fn.httpget), flag(fn.request))
end

function Env.summary()
	local fn = Env.fn
	local function flag(v)
		return v and "yes" or "no"
	end
	return string.format(
		"Executor %s | files %s | clipboard %s | custom assets %s | http %s | hidden ui %s | touch %s",
		Env.executor,
		flag(Env.canSave()),
		flag(Env.canClipboard()),
		flag(fn.getcustomasset ~= nil),
		flag(fn.request ~= nil),
		flag(fn.gethui ~= nil),
		flag(Env.touch)
	)
end

----------------------------------------------------------------------------------------------------
-- Store: validated settings with debounced saving (only when the executor offers file access)
----------------------------------------------------------------------------------------------------
Store.defaults = {
	version = 1,
	theme = "obsidian",
	fx = 2,
	reducedMotion = false,
	lowPower = false,
	notifications = true,
	clock = true,
	compact = false,
	scale = 1,
	sound = true,
	volume = 0.6,
	font = "gotham",
	bgMode = "solid",
	bgImage = "",
	bgSequence = "",
	bgVideo = "",
	bgFps = 8,
	bgCols = 4,
	bgRows = 4,
	glass = 0,
	overlay = 0.35,
	blur = false,
	splash = true,
	splashSound = true,
	favorites = {},
	scriptFavorites = {},
	musicVolume = 0.5,   -- Music tab: volume of the music only
	musicRepeat = "all", -- all | one | off
	musicShuffle = false,
	musicHideBad = true, -- hide songs that did not load on this device
	musicLast = "",      -- the song that was played last (shown, never started by itself)
	musicCustom = {},    -- audio ids you added in the Music tab
	musicBad = {},       -- ids that did not load on this device (a "Check all" can bring them back)
	lastTarget = "",
	logoX = -1,          -- resting spot of the floating logo as a fraction of the screen (-1 = not placed yet)
	logoY = -1,
}

Store.rules = {
	version = { kind = "int", min = 1, max = 99 },
	theme = { kind = "string", max = 32 },
	fx = { kind = "int", min = 0, max = 2 },
	reducedMotion = { kind = "bool" },
	lowPower = { kind = "bool" },
	notifications = { kind = "bool" },
	clock = { kind = "bool" },
	compact = { kind = "bool" },
	scale = { kind = "number", min = 0.9, max = 1.15 },
	sound = { kind = "bool" },
	volume = { kind = "number", min = 0, max = 1 },
	font = { kind = "string", max = 32 },
	bgMode = { kind = "string", max = 16, oneOf = { "solid", "aurora", "sparkle", "image", "sheet", "sequence", "video" } },
	bgImage = { kind = "string", max = 400 },
	bgSequence = { kind = "string", max = 1200 },
	bgVideo = { kind = "string", max = 400 },
	bgFps = { kind = "int", min = 1, max = 24 },
	bgCols = { kind = "int", min = 1, max = 16 },
	bgRows = { kind = "int", min = 1, max = 16 },
	glass = { kind = "number", min = 0, max = 0.6 },
	overlay = { kind = "number", min = 0, max = 0.9 },
	blur = { kind = "bool" },
	splash = { kind = "bool" },
	splashSound = { kind = "bool" },
	favorites = { kind = "idlist", max = 60 },
	scriptFavorites = { kind = "strlist", max = 120 },
	musicVolume = { kind = "number", min = 0, max = 1 },
	musicRepeat = { kind = "string", max = 8, oneOf = { "all", "one", "off" } },
	musicShuffle = { kind = "bool" },
	musicHideBad = { kind = "bool" },
	musicLast = { kind = "string", max = 20 },
	musicCustom = { kind = "strlist", max = 30 },
	musicBad = { kind = "strlist", max = 400 },
	lastTarget = { kind = "string", max = 40 },
	logoX = { kind = "number", min = -1, max = 1 },
	logoY = { kind = "number", min = -1, max = 1 },
}

Store.data = Util.deepCopy(Store.defaults)
Store.listeners = {}
Store.persistent = false
Store.unreadable = nil -- set by Store.load() when config.json exists but cannot be parsed
Store.lastSaveOk = nil
Store.lastError = nil

function Store.clean(key, value)
	local rule = Store.rules[key]
	if not rule then
		return nil
	end
	local kind = rule.kind
	if kind == "bool" then
		if type(value) == "boolean" then
			return value
		end
		return nil
	elseif kind == "int" or kind == "number" then
		if type(value) ~= "number" or value ~= value then
			return nil
		end
		if kind == "int" then
			value = math.floor(value + 0.5)
		end
		return Util.clamp(value, rule.min, rule.max)
	elseif kind == "string" then
		if type(value) ~= "string" then
			return nil
		end
		if #value > (rule.max or 256) then
			value = string.sub(value, 1, rule.max or 256)
		end
		if rule.oneOf and not Util.indexOf(rule.oneOf, value) then
			return nil
		end
		return value
	elseif kind == "idlist" then
		if type(value) ~= "table" then
			return nil
		end
		local out, seen = {}, {}
		for _, id in ipairs(value) do
			if type(id) == "number" and id == math.floor(id) and id > 0 and id < 1e12 and not seen[id] then
				out[#out + 1] = id
				seen[id] = true
				if #out >= (rule.max or 60) then
					break
				end
			end
		end
		return out
	elseif kind == "strlist" then
		if type(value) ~= "table" then
			return nil
		end
		local out, seen = {}, {}
		for _, id in ipairs(value) do
			if type(id) == "string" and #id >= 1 and #id <= 40 and string.match(id, "^[a-z0-9][a-z0-9%-]*$") and not seen[id] then
				out[#out + 1] = id
				seen[id] = true
				if #out >= (rule.max or 60) then
					break
				end
			end
		end
		return out
	end
	return nil
end

function Store.get(key)
	return Store.data[key]
end

function Store.on(key, fn)
	local list = Store.listeners[key]
	if not list then
		list = {}
		Store.listeners[key] = list
	end
	list[#list + 1] = fn
	return function()
		local current = Store.listeners[key]
		if current then
			local index = Util.indexOf(current, fn)
			if index then
				table.remove(current, index)
			end
		end
	end
end

local function fireStore(key, new, old)
	local list = Store.listeners[key]
	if not list then
		return
	end
	local snapshot = {}
	for i = 1, #list do
		snapshot[i] = list[i]
	end
	for i = 1, #snapshot do
		Util.try("store listener " .. key, snapshot[i], new, old)
	end
end

function Store.set(key, value, silent)
	local clean = Store.clean(key, value)
	if clean == nil then
		return false
	end
	local old = Store.data[key]
	Store.data[key] = clean
	if not silent then
		fireStore(key, clean, old)
	end
	Store.queueSave()
	return true
end

function Store.queueSave()
	if not Store.persistent or Store.saveToken then
		return
	end
	Store.saveToken = task.delay(0.8, function()
		Store.saveToken = nil
		Store.save()
	end)
end

function Store.save()
	if not Env.canSave() then
		Store.lastSaveOk = false
		Store.lastError = "file access unavailable"
		return false
	end
	local text, encodeError = Util.jsonEncode(Store.data)
	if not text then
		Store.lastSaveOk, Store.lastError = false, tostring(encodeError)
		return false
	end
	Env.ensureFolder(CONFIG.Folder)
	local ok, err = Env.writeFile(CONFIG.ConfigFile, text)
	Store.lastSaveOk, Store.lastError = ok, err
	return ok
end

function Store.flush()
	if Store.saveToken then
		pcall(task.cancel, Store.saveToken)
		Store.saveToken = nil
	end
	if Store.persistent then
		Store.save()
	end
end

function Store.load()
	Store.data = Util.deepCopy(Store.defaults)
	Store.loadedFromFile = false
	Store.unreadable = nil
	local text = Env.readFile(CONFIG.ConfigFile)
	if text then
		local decoded = Util.jsonDecode(text)
		if type(decoded) == "table" then
			for key in pairs(Store.defaults) do
				local clean = Store.clean(key, decoded[key])
				if clean ~= nil then
					Store.data[key] = clean
				end
			end
			Store.loadedFromFile = true
		else
			Util.log("warn", "config.json could not be parsed; defaults are in use")
			Store.unreadableConfig = text -- a copy is kept next to it before the defaults overwrite it (see below)
			Store.unreadable = "left"     -- until proven otherwise nothing touches the unreadable file
		end
	end

	-- one-time, read-only import of favourites written by the old AVATAR-CHANGER script
	if #Store.data.favorites == 0 then
		local legacy = Env.readFile(CONFIG.LegacyFavorites)
		if legacy then
			local decoded = Util.jsonDecode(legacy)
			local clean = Store.clean("favorites", decoded)
			if clean and #clean > 0 then
				Store.data.favorites = clean
				Util.log("info", "imported " .. #clean .. " avatar favourites from " .. CONFIG.LegacyFavorites)
			end
		end
	end

	-- one-time, read-only import of script favorites written by Vyre Hub (name -> true), mapped to catalog ids
	if #Store.data.scriptFavorites == 0 then
		local legacyScripts = Env.readFile(CONFIG.LegacyScriptFavorites)
		if legacyScripts then
			local decoded = Util.jsonDecode(legacyScripts)
			local ids = Scripts.importLegacy(decoded)
			if #ids > 0 then
				Store.data.scriptFavorites = Store.clean("scriptFavorites", ids) or {}
				Util.log("info", "imported " .. #ids .. " script favorites from " .. CONFIG.LegacyScriptFavorites)
			end
		end
	end

	Store.persistent = Env.canSave()
	if Store.persistent then
		Env.ensureFolder(CONFIG.Folder)
		local copyKept = false
		if Store.unreadableConfig then
			copyKept = Env.writeFile(CONFIG.Folder .. "/config.unreadable.json", Store.unreadableConfig) == true
			Util.log("info", copyKept and "kept the unreadable config as config.unreadable.json" or "could not keep a copy of the unreadable config")
			Store.unreadableConfig = nil
		end
		Store.persistent = Store.save() == true
		if Store.unreadable then
			-- "kept": a copy sits next to the new file | "replaced": no copy, but the broken file was overwritten | "left": nothing was written
			Store.unreadable = copyKept and "kept" or (Store.persistent and "replaced" or "left")
		end
	end
	return Store.data
end

-- restores every preference except the favourites (avatar and script) / last target / the songs you added
function Store.reset()
	for key, default in pairs(Store.defaults) do
		if key ~= "favorites" and key ~= "scriptFavorites" and key ~= "lastTarget" and key ~= "version"
			and key ~= "musicCustom" and key ~= "musicBad" and key ~= "musicLast" then
			Store.set(key, Util.deepCopy(default))
		end
	end
end

do -- [02_motion_typo.lua]

----------------------------------------------------------------------------------------------------
-- Anim: one shared Heartbeat driver. Jobs can be throttled (hz) and gated (e.g. only while visible).
----------------------------------------------------------------------------------------------------
Anim.jobs = {}
Anim.byName = {}
Anim.conn = nil
Anim.seq = 0

function Anim.nextId()
	Anim.seq = Anim.seq + 1
	return Anim.seq
end

local function animStep(dt)
	local jobs = Anim.jobs
	local count = #jobs
	local now = os.clock()
	local anyDead = false
	for i = 1, count do
		local job = jobs[i]
		if job.dead then
			anyDead = true
		else
			job.acc = job.acc + dt
			if job.acc >= job.interval then
				local elapsed = job.acc
				job.acc = 0
				if job.gate == nil or job.gate() then
					local ok, err = pcall(job.fn, elapsed, now)
					if not ok then
						job.dead = true
						anyDead = true
						if Anim.byName[job.name] == job then
							Anim.byName[job.name] = nil
						end
						Util.log("error", "anim job '" .. job.name .. "' stopped: " .. tostring(err))
					end
				end
			end
		end
	end
	if anyDead then
		local alive = {}
		for i = 1, #jobs do
			if not jobs[i].dead then
				alive[#alive + 1] = jobs[i]
			end
		end
		Anim.jobs = alive
	end
	if #Anim.jobs == 0 then
		Anim.stop()
	end
end

function Anim.start()
	if not Anim.conn then
		Anim.conn = RunService.Heartbeat:Connect(animStep)
	end
end

function Anim.stop()
	if Anim.conn then
		Anim.conn:Disconnect()
		Anim.conn = nil
	end
end

-- fn(dt, now). hz = maximum calls per second (nil = every frame). gate() = false skips the call.
function Anim.add(name, fn, hz, gate)
	local existing = Anim.byName[name]
	if existing and not existing.dead then
		existing.fn = fn
		existing.interval = hz and (1 / hz) or 0
		existing.gate = gate
		return existing
	end
	local job = { name = name, fn = fn, interval = hz and (1 / hz) or 0, acc = 0, gate = gate, dead = false }
	Anim.jobs[#Anim.jobs + 1] = job
	Anim.byName[name] = job
	Anim.start()
	return job
end

function Anim.remove(name)
	local job = Anim.byName[name]
	if job then
		job.dead = true
		Anim.byName[name] = nil
	end
end

function Anim.has(name)
	local job = Anim.byName[name]
	return job ~= nil and not job.dead
end

function Anim.stopAll()
	for _, job in ipairs(Anim.jobs) do
		job.dead = true
	end
	Anim.jobs = {}
	Anim.byName = {}
	Anim.stop()
end

----------------------------------------------------------------------------------------------------
-- Motion: tweens with per-(object, property) cancellation, reduced-motion support, easing library
----------------------------------------------------------------------------------------------------
Motion.reduced = false
Motion.fast, Motion.base, Motion.slow = 0.12, 0.2, 0.34
Motion.style = Enum.EasingStyle.Quart
Motion.dir = Enum.EasingDirection.Out

Motion.ease = {
	linear = function(t) return t end,
	outQuad = function(t) return 1 - (1 - t) * (1 - t) end,
	outCubic = function(t)
		local u = 1 - t
		return 1 - u * u * u
	end,
	outQuart = function(t)
		local u = 1 - t
		return 1 - u * u * u * u
	end,
	inOutSine = function(t) return -(math.cos(math.pi * t) - 1) / 2 end,
	inOutCubic = function(t)
		if t < 0.5 then
			return 4 * t * t * t
		end
		local u = -2 * t + 2
		return 1 - u * u * u / 2
	end,
	outBack = function(t)
		local u = t - 1
		return 1 + 2.70158 * u * u * u + 1.70158 * u * u
	end,
}

local activeTweens = setmetatable({}, { __mode = "k" }) -- obj -> { [prop] = { tween, group } }

local function cancelProps(obj, props)
	local entry = activeTweens[obj]
	if not entry then
		return
	end
	local function cancelRecord(key)
		local record = entry[key]
		if record then
			entry[key] = nil
			record.group.dead = true
			pcall(record.tween.Cancel, record.tween)
		end
	end
	if props then
		for key in pairs(props) do
			cancelRecord(key)
		end
	else
		for key in pairs(Util.copy(entry)) do
			cancelRecord(key)
		end
	end
end

function Motion.cancel(obj, props)
	cancelProps(obj, props)
end

-- instant assignment that also cancels any running tween on those properties
function Motion.set(obj, props)
	cancelProps(obj, props)
	for key, value in pairs(props) do
		pcall(function()
			obj[key] = value
		end)
	end
end

-- Animates `props` on `obj`. A newer call for the same property replaces the older tween.
-- onDone() runs once when every property finished (not when interrupted).
function Motion.tween(obj, props, duration, style, direction, onDone)
	if obj == nil then
		return nil
	end
	duration = duration or Motion.base
	cancelProps(obj, props)
	if Motion.reduced or duration <= 0 then
		for key, value in pairs(props) do
			pcall(function()
				obj[key] = value
			end)
		end
		if onDone then
			onDone()
		end
		return nil
	end

	local info = TweenInfo.new(duration, style or Motion.style, direction or Motion.dir)
	local entry = activeTweens[obj]
	if not entry then
		entry = {}
		activeTweens[obj] = entry
	end

	local keys = {}
	for key in pairs(props) do
		keys[#keys + 1] = key
	end
	local group = { remaining = #keys, dead = false }
	local lastTween = nil

	for _, key in ipairs(keys) do
		local ok, tween = pcall(TweenService.Create, TweenService, obj, info, { [key] = props[key] })
		if ok and tween then
			local record = { tween = tween, group = group }
			entry[key] = record
			local connection = nil
			connection = tween.Completed:Connect(function()
				if connection then
					connection:Disconnect()
				end
				if entry[key] == record then
					entry[key] = nil
				end
				if group.dead then
					return
				end
				group.remaining = group.remaining - 1
				if group.remaining <= 0 then
					group.dead = true
					if onDone then
						onDone()
					end
				end
			end)
			tween:Play()
			lastTween = tween
		else
			group.remaining = group.remaining - 1
			pcall(function()
				obj[key] = props[key]
			end)
		end
	end

	if group.remaining <= 0 and not group.dead then
		group.dead = true
		if onDone then
			onDone()
		end
	end
	return lastTween
end

-- Frame-driven animation for things TweenService cannot express (counters, driven gradients ...)
-- step(alpha 0..1 eased). Returns a handle with :Cancel().
function Motion.run(duration, step, easeFn, onDone)
	local handle = { cancelled = false }
	function handle.Cancel()
		handle.cancelled = true
	end
	if Motion.reduced or duration <= 0 then
		step(1)
		if onDone then
			onDone()
		end
		return handle
	end
	easeFn = easeFn or Motion.ease.outCubic
	local started = os.clock()
	local name = "run" .. tostring(Anim.nextId())
	Anim.add(name, function()
		if handle.cancelled then
			Anim.remove(name)
			return
		end
		local a = (os.clock() - started) / duration
		if a >= 1 then
			Anim.remove(name)
			step(1)
			if onDone then
				onDone()
			end
			return
		end
		step(easeFn(a))
	end)
	return handle
end

----------------------------------------------------------------------------------------------------
-- Typo: every text object gets its font through a role, so fonts can change in one place
----------------------------------------------------------------------------------------------------
Typo.roles = {
	display = { size = 30, weight = "bold" },
	title = { size = 20, weight = "bold" },
	heading = { size = 14, weight = "medium" },
	body = { size = 12, weight = "regular", lineHeight = 1.12 },
	caption = { size = 11, weight = "regular", lineHeight = 1.12 },
	label = { size = 11, weight = "bold" },
	button = { size = 13, weight = "medium" },
	buttonSmall = { size = 12, weight = "medium" },
	tab = { size = 13, weight = "medium" },
	stat = { size = 18, weight = "bold" },
}

Typo.families = {}
Typo.order = {}
Typo.family = nil
Typo.registry = {} -- strong on purpose: Roblox may drop Lua wrappers of live instances; Typo.prune() cleans dead ones
Typo.faceSupported = false

local function enumFont(name, fallback)
	local ok, value = pcall(function()
		return Enum.Font[name]
	end)
	if ok and value then
		return value
	end
	return fallback
end

local function fontWeight(weight)
	local names = { regular = "Regular", medium = "Medium", bold = "Bold" }
	local ok, value = pcall(function()
		return Enum.FontWeight[names[weight] or "Regular"]
	end)
	if ok then
		return value
	end
	return nil
end

function Typo.init()
	Typo.families, Typo.order = {}, {}
	Typo.faceSupported = pcall(function()
		return Font.new("rbxasset://fonts/families/GothamSSm.json")
	end)
	for _, def in ipairs(CONFIG.Fonts.Families) do
		local family = { id = def.id, name = def.name, face = def.face }
		if def.enum then
			family.regular = enumFont(def.enum.regular, nil)
			family.medium = enumFont(def.enum.medium, family.regular)
			family.bold = enumFont(def.enum.bold, family.medium or family.regular)
		end
		if family.regular or (family.face and Typo.faceSupported) then
			Typo.families[def.id] = family
			Typo.order[#Typo.order + 1] = def.id
		else
			Util.log("warn", "font family '" .. tostring(def.id) .. "' is not available in this client")
		end
	end
	if not Typo.families.gotham then
		local fallback = { id = "gotham", name = "Gotham", regular = Enum.Font.Gotham, medium = Enum.Font.GothamMedium, bold = Enum.Font.GothamBold }
		Typo.families.gotham = fallback
		table.insert(Typo.order, 1, "gotham")
	end
	Typo.family = Typo.families[Store.get("font")] or Typo.families[CONFIG.Fonts.Default] or Typo.families.gotham
	return Typo
end

function Typo.assign(obj, weight, size)
	local family = Typo.family
	local done = false
	if family.face and Typo.faceSupported then
		local ok = pcall(function()
			obj.FontFace = Font.new(family.face, fontWeight(weight))
		end)
		done = ok
	end
	if not done then
		local base = Typo.families.gotham
		obj.Font = family[weight] or family.regular or base[weight] or Enum.Font.Gotham
	end
	if size then
		obj.TextSize = size
	end
end

-- role: "display" | "title" | "heading" | "body" | "caption" | "label" | "button" | ...
function Typo.apply(obj, role, sizeOverride)
	local spec = Typo.roles[role] or Typo.roles.body
	local size = sizeOverride or spec.size
	Typo.registry[obj] = { role = role, size = size }
	Typo.assign(obj, spec.weight, size)
	obj.LineHeight = spec.lineHeight or 1 -- a little air between wrapped lines of descriptive text
	return obj
end

function Typo.setFamily(id)
	local family = Typo.families[id]
	if not family then
		return false
	end
	Typo.family = family
	for obj, info in pairs(Typo.registry) do
		local spec = Typo.roles[info.role] or Typo.roles.body
		pcall(Typo.assign, obj, spec.weight, info.size)
	end
	return true
end

function Typo.prune()
	for obj in pairs(Typo.registry) do
		if obj.Parent == nil then
			Typo.registry[obj] = nil
		end
	end
end

function Typo.list()
	local out = {}
	for _, id in ipairs(Typo.order) do
		out[#out + 1] = { id = id, label = Typo.families[id].name }
	end
	return out
end
end -- [02_motion_typo.lua]

do -- [03_theme.lua]

----------------------------------------------------------------------------------------------------
-- Theme: role-based palettes, live transitions, gradients and (optional) animated accents.
-- To add a theme, append one row to Theme.catalog. Only the roles you list are required:
--   Background, Panel, Card, Border, Accent, Text, Muted  (everything else is derived)
-- Optional roles: Accent2 (gradient partner), Shine (highlight), AccentSoft, Info ...
----------------------------------------------------------------------------------------------------
local function C(r, g, b)
	return Color3.fromRGB(r, g, b)
end

Theme.catalog = {
	-- the two palettes from the original VirexHub -------------------------------------------------
	{ id = "obsidian", name = "Obsidian", group = "Classic", colors = {
		Background = C(12, 15, 22), Panel = C(19, 23, 33), Card = C(26, 31, 43), Border = C(48, 57, 75),
		Accent = C(112, 97, 255), Accent2 = C(168, 148, 255), Shine = C(226, 220, 255), AccentSoft = C(47, 42, 87),
		Text = C(240, 242, 249), Muted = C(153, 162, 180),
	} },
	{ id = "deepteal", name = "Deep Teal", group = "Classic", colors = {
		Background = C(11, 18, 23), Panel = C(17, 27, 34), Card = C(23, 37, 45), Border = C(42, 65, 71),
		Accent = C(48, 195, 177), Accent2 = C(104, 232, 214), Shine = C(206, 255, 247), AccentSoft = C(29, 67, 67),
		Text = C(237, 245, 245), Muted = C(149, 171, 175),
	} },
	-- premium metals -----------------------------------------------------------------------------
	{ id = "silver", name = "Silver", group = "Premium", colors = {
		Background = C(13, 15, 19), Panel = C(20, 23, 29), Card = C(29, 33, 41), Border = C(62, 68, 80),
		Accent = C(206, 213, 226), Accent2 = C(146, 156, 176), Shine = C(255, 255, 255), AccentSoft = C(50, 55, 67),
		Text = C(238, 241, 246), Muted = C(150, 158, 172),
	} },
	{ id = "gold", name = "Gold", group = "Premium", colors = {
		Background = C(15, 12, 7), Panel = C(23, 18, 10), Card = C(33, 26, 14), Border = C(78, 62, 30),
		Accent = C(230, 184, 78), Accent2 = C(176, 128, 38), Shine = C(255, 238, 176), AccentSoft = C(68, 52, 22),
		Text = C(248, 242, 228), Muted = C(178, 164, 132),
	} },
	{ id = "diamond", name = "Diamond", group = "Premium", colors = {
		Background = C(5, 11, 22), Panel = C(10, 19, 33), Card = C(16, 29, 48), Border = C(36, 70, 104),
		Accent = C(96, 218, 255), Accent2 = C(36, 120, 214), Shine = C(235, 252, 255), AccentSoft = C(22, 56, 84),
		Text = C(236, 249, 255), Muted = C(138, 174, 196),
	} },
	{ id = "emerald", name = "Emerald", group = "Premium", colors = {
		Background = C(6, 15, 11), Panel = C(10, 24, 18), Card = C(15, 34, 26), Border = C(32, 76, 56),
		Accent = C(46, 204, 140), Accent2 = C(16, 140, 96), Shine = C(176, 255, 214), AccentSoft = C(18, 58, 42),
		Text = C(233, 248, 240), Muted = C(136, 172, 152),
	} },
	-- two-colour combinations -------------------------------------------------------------------
	{ id = "gold_black", name = "Gold + Black", group = "Combos", colors = {
		Background = C(4, 4, 4), Panel = C(11, 10, 8), Card = C(19, 17, 13), Border = C(70, 56, 26),
		Accent = C(232, 182, 72), Accent2 = C(140, 104, 30), Shine = C(255, 232, 160), AccentSoft = C(52, 41, 17),
		Text = C(250, 245, 232), Muted = C(158, 148, 126),
	} },
	{ id = "silver_blue", name = "Silver + Blue", group = "Combos", colors = {
		Background = C(8, 12, 22), Panel = C(14, 20, 35), Card = C(21, 29, 50), Border = C(50, 68, 104),
		Accent = C(202, 212, 230), Accent2 = C(70, 120, 255), Shine = C(240, 246, 255), AccentSoft = C(28, 44, 88),
		Text = C(240, 244, 252), Muted = C(144, 160, 188), Info = C(110, 160, 255),
	} },
	{ id = "diamond_purple", name = "Diamond + Purple", group = "Combos", colors = {
		Background = C(10, 7, 22), Panel = C(17, 12, 35), Card = C(26, 18, 52), Border = C(70, 50, 116),
		Accent = C(176, 136, 255), Accent2 = C(120, 214, 255), Shine = C(232, 246, 255), AccentSoft = C(50, 34, 96),
		Text = C(242, 238, 252), Muted = C(158, 146, 190),
	} },
	{ id = "emerald_black", name = "Emerald + Black", group = "Combos", colors = {
		Background = C(3, 7, 5), Panel = C(8, 14, 11), Card = C(13, 22, 17), Border = C(28, 62, 46),
		Accent = C(44, 214, 132), Accent2 = C(14, 120, 80), Shine = C(150, 255, 204), AccentSoft = C(12, 46, 32),
		Text = C(232, 246, 238), Muted = C(128, 160, 142),
	} },
}

Theme.defs = {}
Theme.byId = {}
Theme.live = {}
Theme.target = nil
Theme.id = nil
Theme.glass = 0
Theme.fxLevel = 0
Theme.listeners = {}
Theme.active = function()
	return true
end

-- These registries are strong on purpose (Roblox can drop the Lua wrapper of a live Instance, which
-- would silently unbind a weak key). Theme.prune() removes entries whose instance was destroyed.
local boundProps = {}    -- inst -> { [prop] = {role, mixRole, mixT} }
local alphaProps = {}    -- inst -> { kind }
local gradientBinds = {} -- UIGradient -> builder(live) -> ColorSequence
local fxItems = {}

function Theme.define(spec)
	local c = Util.copy(spec.colors)
	c.Accent2 = c.Accent2 or Util.lighten(c.Accent, 0.25)
	c.Shine = c.Shine or Util.lighten(c.Accent, 0.55)
	c.AccentSoft = c.AccentSoft or Util.mix(c.Card, c.Accent, 0.25)
	c.Elevated = c.Elevated or Util.mix(c.Card, c.Text, 0.06)
	c.Track = c.Track or Util.mix(c.Card, c.Text, 0.17)
	c.Faint = c.Faint or Util.mix(c.Muted, c.Card, 0.5)
	c.Danger = c.Danger or C(235, 87, 99)
	c.Green = c.Green or C(78, 202, 146)
	c.Warn = c.Warn or C(240, 178, 74)
	c.Info = c.Info or c.Accent
	c.OnAccent = c.OnAccent or Util.onColor(c.Accent)
	c.OnDanger = c.OnDanger or Util.onColor(c.Danger)
	c.Scrim = c.Scrim or C(0, 0, 0)
	local def = { id = spec.id, name = spec.name, group = spec.group or "Custom", colors = c }
	if Theme.byId[spec.id] then
		for i, existing in ipairs(Theme.defs) do
			if existing.id == spec.id then
				Theme.defs[i] = def
			end
		end
	else
		Theme.defs[#Theme.defs + 1] = def
	end
	Theme.byId[spec.id] = def
	return def
end

function Theme.init()
	Theme.defs, Theme.byId = {}, {}
	for _, spec in ipairs(Theme.catalog) do
		Theme.define(spec)
	end
	for role, color in pairs(Theme.defs[1].colors) do
		Theme.live[role] = color
	end
	return Theme
end

function Theme.color(role, mixRole, mixT)
	local live = Theme.live
	local base = live[role] or live.Text or Color3.new(1, 1, 1)
	if mixRole and mixT then
		return Util.mix(base, live[mixRole] or base, mixT)
	end
	return base
end

-- keep `inst[prop]` in sync with a theme role (optionally mixed toward a second role)
function Theme.bind(inst, prop, role, mixRole, mixT)
	local list = boundProps[inst]
	if not list then
		list = {}
		boundProps[inst] = list
	end
	list[prop] = { role = role, mixRole = mixRole, mixT = mixT }
	inst[prop] = Theme.color(role, mixRole, mixT)
	return inst
end

function Theme.unbind(inst, prop)
	local list = boundProps[inst]
	if list then
		list[prop] = nil
	end
end

-- changes the role of an existing binding and animates the property to the new colour
function Theme.tweenRole(inst, prop, role, duration, mixRole, mixT)
	local list = boundProps[inst]
	if not list then
		list = {}
		boundProps[inst] = list
	end
	list[prop] = { role = role, mixRole = mixRole, mixT = mixT }
	Motion.tween(inst, { [prop] = Theme.color(role, mixRole, mixT) }, duration or Motion.base)
end

local function glassFor(kind)
	local g = Theme.glass
	if kind == "bg" then
		return g
	elseif kind == "panel" then
		return g * 0.92
	elseif kind == "card" then
		return g * 0.6
	elseif kind == "input" then
		return g * 0.45
	end
	return 0
end

-- background surface whose transparency follows the "panel transparency" setting
function Theme.surface(inst, role, kind, mixRole, mixT)
	Theme.bind(inst, "BackgroundColor3", role, mixRole, mixT)
	alphaProps[inst] = { kind = kind }
	inst.BackgroundTransparency = glassFor(kind)
	return inst
end

function Theme.setGlass(value)
	Theme.glass = Util.clamp(value, 0, 0.6)
	for inst, info in pairs(alphaProps) do
		inst.BackgroundTransparency = glassFor(info.kind)
	end
end

function Theme.gradient(gradient, builder)
	gradientBinds[gradient] = builder
	gradient.Color = builder(Theme.live)
	return gradient
end

local function seq(points)
	local keys = {}
	for i, p in ipairs(points) do
		keys[i] = ColorSequenceKeypoint.new(p[1], p[2])
	end
	return ColorSequence.new(keys)
end

Theme.G = {
	accent = function(l)
		return seq({ { 0, l.Accent }, { 1, l.Accent2 } })
	end,
	metal = function(l)
		return seq({ { 0, l.Shine }, { 0.42, l.Accent }, { 1, l.Accent2 } })
	end,
	stroke = function(l)
		return seq({ { 0, l.Border }, { 0.25, l.Accent }, { 0.5, l.Border }, { 0.75, l.Accent2 }, { 1, l.Border } })
	end,
	aurora = function(l)
		return seq({
			{ 0, l.Background },
			{ 0.35, Util.mix(l.Background, l.Accent, 0.28) },
			{ 0.65, Util.mix(l.Background, l.Accent2, 0.22) },
			{ 1, l.Background },
		})
	end,
	sheen = function(l)
		return seq({ { 0, l.Text }, { 0.4, l.Text }, { 0.5, l.Shine }, { 0.6, l.Text }, { 1, l.Text } })
	end,
	glint = function(l)
		return seq({ { 0, l.Accent }, { 0.4, l.Accent }, { 0.5, l.Shine }, { 0.6, l.Accent }, { 1, l.Accent2 } })
	end,
}

function Theme.refresh()
	for inst, props in pairs(boundProps) do
		for prop, b in pairs(props) do
			inst[prop] = Theme.color(b.role, b.mixRole, b.mixT)
		end
	end
	for gradient, builder in pairs(gradientBinds) do
		gradient.Color = builder(Theme.live)
	end
end

local function fireTheme()
	local def = Theme.byId[Theme.id]
	local snapshot = {}
	for i, fn in ipairs(Theme.listeners) do
		snapshot[i] = fn
	end
	for _, fn in ipairs(snapshot) do
		Util.try("theme listener", fn, Theme.id, def)
	end
end

function Theme.onChange(fn)
	Theme.listeners[#Theme.listeners + 1] = fn
	return function()
		local index = Util.indexOf(Theme.listeners, fn)
		if index then
			table.remove(Theme.listeners, index)
		end
	end
end

function Theme.apply(id, instant)
	local def = Theme.byId[id]
	if not def then
		return false
	end
	local first = Theme.id == nil
	Theme.id = id
	Store.set("theme", id, true)
	local from = Util.copy(Theme.live)
	local to = def.colors
	Theme.target = to
	if instant or first or Motion.reduced then
		Anim.remove("themelerp")
		for role, color in pairs(to) do
			Theme.live[role] = color
		end
		Theme.refresh()
	else
		local started = os.clock()
		Anim.add("themelerp", function()
			local a = Util.clamp((os.clock() - started) / 0.4, 0, 1)
			local e = Motion.ease.outCubic(a)
			for role, color in pairs(to) do
				Theme.live[role] = Util.mix(from[role] or color, color, e)
			end
			Theme.refresh()
			if a >= 1 then
				Anim.remove("themelerp")
			end
		end, 40)
	end
	fireTheme()
	return true
end

function Theme.prune()
	for inst in pairs(boundProps) do
		if inst.Parent == nil then
			boundProps[inst] = nil
		end
	end
	for inst in pairs(alphaProps) do
		if inst.Parent == nil then
			alphaProps[inst] = nil
		end
	end
	for gradient in pairs(gradientBinds) do
		if gradient.Parent == nil then
			gradientBinds[gradient] = nil
		end
	end
end

function Theme.current()
	return Theme.byId[Theme.id]
end

----------------------------------------------------------------------------------------------------
-- Animated accents (spin / sweep / pulse). Level 0 = off, 1 = subtle, 2 = full.
-- Effects are time-based, throttled to 30 Hz, and pause while the hub is hidden.
----------------------------------------------------------------------------------------------------
function Theme.fxSpin(inst, degreesPerSecond, minLevel)
	fxItems[#fxItems + 1] = { kind = "spin", inst = inst, speed = degreesPerSecond, minLevel = minLevel or 2 }
	Theme.syncFx()
end

function Theme.fxSweep(inst, period, rest, minLevel, phase)
	fxItems[#fxItems + 1] = {
		kind = "sweep", inst = inst, period = period, rest = rest or 0.5, minLevel = minLevel or 1, phase = phase or 0,
	}
	Theme.syncFx()
end

function Theme.fxPulse(inst, prop, a, b, period, minLevel)
	fxItems[#fxItems + 1] = {
		kind = "pulse", inst = inst, prop = prop, a = a, b = b, period = period, minLevel = minLevel or 2,
	}
	Theme.syncFx()
end

local function fxRest(item)
	pcall(function()
		if item.kind == "spin" then
			item.inst.Rotation = 0
		elseif item.kind == "sweep" then
			item.inst.Offset = Vector2.new(1, 0)
		elseif item.kind == "pulse" then
			item.inst[item.prop] = item.a
		end
	end)
end

local function fxTick(_, now)
	local level = Theme.fxLevel
	local i = #fxItems
	while i >= 1 do
		local item = fxItems[i]
		local inst = item.inst
		if inst.Parent == nil then
			table.remove(fxItems, i)
		elseif level >= item.minLevel then
			if item.kind == "spin" then
				inst.Rotation = (now * item.speed) % 360
			elseif item.kind == "sweep" then
				local phase = (now / item.period + item.phase) % 1
				local travel = 1 - item.rest
				local a = 1
				if phase < travel then
					a = phase / travel
				end
				inst.Offset = Vector2.new(-1 + 2 * Motion.ease.inOutSine(a), 0)
			else
				local s = 0.5 + 0.5 * math.sin(now * 2 * math.pi / item.period)
				inst[item.prop] = item.a + (item.b - item.a) * s
			end
		end
		i = i - 1
	end
end

function Theme.syncFx()
	local level = Store.get("fx")
	if Store.get("reducedMotion") or Store.get("lowPower") then
		level = 0
	end
	local changed = level ~= Theme.fxLevel
	Theme.fxLevel = level
	if level == 0 then
		Anim.remove("themefx")
		if changed then
			for _, item in ipairs(fxItems) do
				fxRest(item)
			end
		end
	elseif #fxItems > 0 then
		Anim.add("themefx", fxTick, 30, function()
			return Theme.active()
		end)
	end
end

function Theme.clearFx()
	fxItems = {}
	Anim.remove("themefx")
end
end -- [03_theme.lua]

do -- [04_sfx.lua]

----------------------------------------------------------------------------------------------------
-- Sfx: short UI sounds. Every asset is preloaded; anything that fails is skipped silently.
----------------------------------------------------------------------------------------------------
Sfx.holder = nil
Sfx.records = {}   -- asset id -> { id, sound, status = "pending" | "ok" | "failed" | "unknown", length }
Sfx.last = {}      -- event -> os.clock() of the last play (rate limit)
Sfx.tracked = {}

function Sfx.init()
	Sfx.records = {}
	if not SoundService then
		return false
	end
	local ok, holder = pcall(function()
		return Util.new("Folder", { Name = "VirexHubSfx" }, SoundService)
	end)
	if not ok then
		Util.log("warn", "sound holder could not be created: " .. tostring(holder))
		return false
	end
	Sfx.holder = holder
	for _, def in pairs(CONFIG.Sounds) do
		local id = def.id
		if type(id) == "string" and id ~= "" and not Sfx.records[id] then
			local created, sound = pcall(function()
				return Util.new("Sound", { Name = "Sfx" .. Util.hash(id), SoundId = id, Volume = 0 }, holder)
			end)
			if created then
				Sfx.records[id] = { id = id, sound = sound, status = "pending", length = 0 }
			end
		end
	end
	return true
end

-- Preloads every sound. Yields (call from a task). onProgress(done, total) reports REAL completions.
-- Returns loaded, failed, total. Never waits longer than `timeout` seconds.
function Sfx.preload(onProgress, timeout)
	local list, byId = {}, {}
	for id, record in pairs(Sfx.records) do
		list[#list + 1] = record.sound
		byId[id] = record
	end
	local total = #list
	if total == 0 then
		return 0, 0, 0
	end
	if not ContentProvider then
		for _, record in pairs(Sfx.records) do
			record.status = "unknown"
		end
		return 0, 0, total
	end

	local done, finished = 0, false
	task.spawn(function()
		local ok, err = pcall(ContentProvider.PreloadAsync, ContentProvider, list, function(contentId, status)
			done = done + 1
			local record = byId[contentId]
			if not record then
				for id, candidate in pairs(byId) do
					if string.find(tostring(contentId), id, 1, true) then
						record = candidate
					end
				end
			end
			if record then
				if tostring(status) == "Enum.AssetFetchStatus.Success" then
					record.status = "ok"
				else
					record.status = "failed"
				end
			end
			if onProgress then
				onProgress(done, total)
			end
		end)
		if not ok then
			Util.log("warn", "sound preload unavailable: " .. tostring(err))
			for _, record in pairs(Sfx.records) do
				if record.status == "pending" then
					record.status = "unknown"
				end
			end
		end
		finished = true
	end)

	local started = os.clock()
	while not finished and os.clock() - started < (timeout or 6) do
		task.wait(0.05)
	end

	local loaded, failed = 0, 0
	for _, record in pairs(Sfx.records) do
		local ok, length = pcall(function()
			return record.sound.TimeLength
		end)
		if ok and type(length) == "number" then
			record.length = length
		end
		if record.status == "pending" then
			-- preload never reported (timed out): trust the Sound's own state if it has one
			local okLoaded, isLoaded = pcall(function()
				return record.sound.IsLoaded
			end)
			if okLoaded and isLoaded then
				record.status = "ok"
			else
				record.status = finished and "failed" or "unknown"
			end
		end
		if record.status == "ok" then
			loaded = loaded + 1
		elseif record.status == "failed" then
			failed = failed + 1
			Util.log("warn", "sound asset failed to load: " .. record.id)
		end
	end
	return loaded, failed, total
end

local function fireSound(record, def, speed, master, tracked)
	if not Sfx.holder then
		return nil -- the hub was closed while a delayed part of a sound was still pending
	end
	local clone = record.sound:Clone()
	if not clone then
		return nil
	end
	clone.Volume = Util.clamp((def.volume or 0.4) * master * 1.5, 0, 1)
	clone.PlaybackSpeed = speed
	clone.Looped = false
	clone.Parent = Sfx.holder
	local played = pcall(clone.Play, clone)
	if not played and SoundService then
		played = pcall(SoundService.PlayLocalSound, SoundService, clone)
	end
	local length = record.length
	local life = (length > 0 and (length / math.max(speed, 0.1)) or 1.5) + 0.5
	local cut = def.maxSeconds
	if not cut and length > 2.5 then
		cut = 0.9
	end
	if cut and cut < life then
		task.delay(cut, function()
			if clone.Parent then
				Motion.tween(clone, { Volume = 0 }, 0.18)
			end
		end)
		life = cut + 0.3
	end
	task.delay(life, function()
		pcall(clone.Destroy, clone)
	end)
	if tracked then
		Sfx.tracked[#Sfx.tracked + 1] = clone
	end
	return clone
end

-- Plays a named UI sound. Respects the sound toggle, the volume setting and a per-event cooldown.
function Sfx.play(event, force)
	if not force and not Store.get("sound") then
		return false
	end
	local def = CONFIG.Sounds[event]
	if not def or type(def.id) ~= "string" or def.id == "" or not Sfx.holder then
		return false
	end
	local record = Sfx.records[def.id]
	if not record or record.status == "failed" then
		return false
	end
	local master = Store.get("volume")
	if master <= 0.001 then
		return false
	end
	local now = os.clock()
	local previous = Sfx.last[event]
	if previous and now - previous < (def.cooldown or 0.045) then
		return false
	end
	Sfx.last[event] = now

	local steps = def.chain or { { at = 0, speed = def.speed or 1 } }
	for _, step in ipairs(steps) do
		local speed = step.speed or def.speed or 1
		if step.at and step.at > 0 then
			task.delay(step.at, function()
				if Sfx.holder then
					Util.try("sfx " .. event, fireSound, record, def, speed, master, false)
				end
			end)
		else
			Util.try("sfx " .. event, fireSound, record, def, speed, master, false)
		end
	end
	return true
end

-- Plays a sound that the caller wants to be able to fade out (loading music). Returns a handle.
function Sfx.playTracked(event, force)
	local handle = { clone = nil }
	function handle.Stop(fadeSeconds)
		local clone = handle.clone
		if clone and clone.Parent then
			Motion.tween(clone, { Volume = 0 }, fadeSeconds or 0.3, Enum.EasingStyle.Quad)
			task.delay((fadeSeconds or 0.3) + 0.05, function()
				pcall(clone.Destroy, clone)
			end)
		end
		handle.clone = nil
	end
	if not force and not Store.get("sound") then
		return handle
	end
	local def = CONFIG.Sounds[event]
	local record = def and Sfx.records[def.id]
	if not record or record.status == "failed" or not Sfx.holder then
		return handle
	end
	local master = Store.get("volume")
	if master <= 0.001 then
		return handle
	end
	local ok, clone = Util.try("sfx " .. event, fireSound, record, def, def.speed or 1, master, true)
	if ok then
		handle.clone = clone
	end
	return handle
end

function Sfx.stopAll()
	for _, clone in ipairs(Sfx.tracked) do
		pcall(clone.Destroy, clone)
	end
	Sfx.tracked = {}
end

-- human-readable status for Settings > Sound
function Sfx.status()
	local events, ok, failed, pending = {}, 0, 0, 0
	for event, def in pairs(CONFIG.Sounds) do
		local record = def.id ~= "" and Sfx.records[def.id] or nil
		local state = "off"
		if record then
			state = record.status
		end
		events[#events + 1] = { event = event, id = def.id, state = state }
	end
	table.sort(events, function(a, b)
		return a.event < b.event
	end)
	for _, record in pairs(Sfx.records) do
		if record.status == "ok" then
			ok = ok + 1
		elseif record.status == "failed" then
			failed = failed + 1
		else
			pending = pending + 1
		end
	end
	return { events = events, ok = ok, failed = failed, pending = pending, total = ok + failed + pending }
end

function Sfx.summary()
	local s = Sfx.status()
	if not Sfx.holder then
		return "Audio is unavailable in this environment."
	end
	if s.total == 0 then
		return "No sound assets are configured."
	end
	if s.failed == 0 and s.pending == 0 then
		return string.format("All %d sound assets loaded.", s.total)
	end
	return string.format("%d of %d sound assets loaded; %d unavailable (silent).", s.ok, s.total, s.failed + s.pending)
end

function Sfx.destroy()
	Sfx.stopAll()
	if Sfx.holder then
		pcall(Sfx.holder.Destroy, Sfx.holder)
	end
	Sfx.holder = nil
	Sfx.records = {}
end
end -- [04_sfx.lua]

do -- [05_ui_base.lua]

----------------------------------------------------------------------------------------------------
-- UI kit, part 1: input sessions, drawn icons, pressable feedback, button, toggle, slider,
-- stepper, segmented selector. Every control is built as  Hit (TextButton, transparent)  +
-- Face (Frame, scaled on press) so the touch target can be larger than what is drawn.
----------------------------------------------------------------------------------------------------
UI.metrics = { buttonH = 34, radius = 9, rowH = 58, touchMin = 36 }
UI.sessions = {}
UI.layers = {}
UI.scale = function()
	return 1
end

local function isPress(input)
	local t = input.UserInputType
	return t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch
end
UI.isPress = isPress

-- Follows ONE press until it ends. Used by sliders, window drag and press feedback so that a
-- missed InputEnded can never leave a control stuck in its pressed state.
function UI.watchInput(input, onMove, onEnd)
	local session = { done = false, conns = {} }
	local isTouch = input.UserInputType == Enum.UserInputType.Touch
	local function finish(cancelled)
		if session.done then
			return
		end
		session.done = true
		for _, connection in ipairs(session.conns) do
			connection:Disconnect()
		end
		session.conns = {}
		UI.sessions[session] = nil
		if onEnd then
			Util.try("input end", onEnd, cancelled)
		end
	end
	session.finish = finish
	session.conns[#session.conns + 1] = UserInputService.InputChanged:Connect(function(i)
		if session.done or not onMove then
			return
		end
		local t = i.UserInputType
		if i == input or (isTouch and t == Enum.UserInputType.Touch) or (not isTouch and t == Enum.UserInputType.MouseMovement) then
			onMove(i)
		end
	end)
	session.conns[#session.conns + 1] = UserInputService.InputEnded:Connect(function(i)
		local t = i.UserInputType
		if i == input or (isTouch and t == Enum.UserInputType.Touch) or (not isTouch and t == Enum.UserInputType.MouseButton1) then
			finish(false)
		end
	end)
	pcall(function()
		session.conns[#session.conns + 1] = input.Changed:Connect(function()
			local state = input.UserInputState
			if state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
				finish(false)
			end
		end)
	end)
	UI.sessions[session] = true
	return session
end

function UI.endSessions()
	local list = {}
	for session in pairs(UI.sessions) do
		list[#list + 1] = session
	end
	for _, session in ipairs(list) do
		session.finish(true)
	end
end

function UI.findScroller(inst)
	local node = inst.Parent
	while node do
		if node:IsA("ScrollingFrame") then
			return node
		end
		node = node.Parent
	end
	return nil
end

function UI.scrollIntoView(inst)
	local scroller = UI.findScroller(inst)
	if not scroller then
		return
	end
	local s = UI.scale()
	local rel = (inst.AbsolutePosition.Y - scroller.AbsolutePosition.Y) / s + scroller.CanvasPosition.Y
	Motion.tween(scroller, { CanvasPosition = Vector2.new(0, math.max(0, rel - 10)) }, 0.25)
end

-- quick horizontal nudge used for "that control is unavailable" feedback
function UI.shake(inst)
	if Motion.reduced or not inst or not inst.Parent then
		return
	end
	local home = inst.Position
	local function at(dx)
		return UDim2.new(home.X.Scale, home.X.Offset + dx, home.Y.Scale, home.Y.Offset)
	end
	Motion.tween(inst, { Position = at(4) }, 0.05, Enum.EasingStyle.Quad, nil, function()
		Motion.tween(inst, { Position = at(-4) }, 0.07, Enum.EasingStyle.Quad, nil, function()
			Motion.tween(inst, { Position = home }, 0.08, Enum.EasingStyle.Quad)
		end)
	end)
end

----------------------------------------------------------------------------------------------------
-- icons drawn from frames (no image assets, no font glyph dependencies)
----------------------------------------------------------------------------------------------------
local ICONS = {}

ICONS.grid = function(g)
	g.box(5.5, 5.5, 7, 7, 2)
	g.box(14.5, 5.5, 7, 7, 2)
	g.box(5.5, 14.5, 7, 7, 2)
	g.box(14.5, 14.5, 7, 7, 2)
end
ICONS.user = function(g)
	g.dot(10, 6.2, 7)
	g.box(10, 15.2, 14, 6.5, 3.2)
end
ICONS.sparkle = function(g)
	g.bar(10, 10, 2, 18)
	g.bar(10, 10, 18, 2)
	g.bar(10, 10, 2, 12, 45)
	g.bar(10, 10, 2, 12, -45)
	g.dot(10, 10, 5)
end
ICONS.image = function(g)
	g.outline(10, 10, 17, 14, 3, 1.7)
	g.dot(7.4, 7.6, 3.2)
	g.bar(12.6, 12.4, 8, 1.8, -38)
end
ICONS.sliders = function(g)
	g.bar(10, 5, 16, 1.8)
	g.bar(10, 10, 16, 1.8)
	g.bar(10, 15, 16, 1.8)
	g.dot(6, 5, 4.6)
	g.dot(13.5, 10, 4.6)
	g.dot(8.5, 15, 4.6)
end
ICONS.gear = function(g)
	g.ring(10, 10, 11, 2.2)
	g.dot(10, 10, 3.2)
	for i = 0, 7 do
		local a = i * math.pi / 4
		g.bar(10 + 7 * math.sin(a), 10 - 7 * math.cos(a), 2.6, 3.4, i * 45)
	end
end
ICONS.close = function(g)
	g.bar(10, 10, 14, 2, 45)
	g.bar(10, 10, 14, 2, -45)
end
ICONS.minus = function(g)
	g.bar(10, 10, 12, 2)
end
ICONS.plus = function(g)
	g.bar(10, 10, 12, 2)
	g.bar(10, 10, 2, 12)
end
ICONS.restore = function(g)
	g.outline(10, 10, 11.5, 11.5, 2, 1.8)
end
ICONS.chevron = function(g)
	g.bar(7.6, 9.4, 7, 2, 45)
	g.bar(12.4, 9.4, 7, 2, -45)
end
ICONS.check = function(g)
	g.bar(6.5, 12.1, 5, 2.2, 45)
	g.bar(11.8, 10, 10.6, 2.2, -47)
end
ICONS.bang = function(g)
	g.bar(10, 7.4, 2.6, 8.6)
	g.dot(10, 14.8, 3)
end
ICONS.info = function(g)
	g.dot(10, 5.4, 3)
	g.bar(10, 11.8, 2.6, 7.6)
end
ICONS.dots = function(g)
	g.dot(4.5, 10, 3.2)
	g.dot(10, 10, 3.2)
	g.dot(15.5, 10, 3.2)
end
ICONS.logo = function(g)
	-- the VIREX mark: a bold "V" made of two bars with a small diamond above it
	g.bar(6.6, 9.4, 3, 12.6, -24)
	g.bar(13.4, 9.4, 3, 12.6, 24)
	g.bar(10, 3.6, 3.2, 3.2, 45)
end

ICONS.scripts = function(g)
	-- "</>": two angle brackets and a slash
	g.bar(5.4, 7.5, 6.6, 1.9, -49)
	g.bar(5.4, 12.5, 6.6, 1.9, 49)
	g.bar(14.6, 7.5, 6.6, 1.9, 49)
	g.bar(14.6, 12.5, 6.6, 1.9, -49)
	g.bar(10, 10, 1.8, 11, 20)
end
ICONS.star = function(g)
	-- five arms around a centre disc; the colour (Muted / Warn) tells empty from filled
	g.dot(10, 10.6, 7)
	for i = 0, 4 do
		local a = i * 2 * math.pi / 5
		g.bar(10 + 4.2 * math.sin(a), 10.6 - 4.2 * math.cos(a), 3.2, 8.4, i * 72)
	end
end

ICONS.music = function(g)
	-- a beamed pair of notes
	g.dot(6.1, 14.6, 5)
	g.dot(13.4, 12.8, 5)
	g.bar(7.8, 9.4, 1.8, 10.4)
	g.bar(15, 7.6, 1.8, 10.4)
	g.bar(11.4, 3.5, 9.2, 2.4, -14)
end
ICONS.play = function(g)
	g.tri(10.6, 10, 9.4, 12.4, 1)
end
ICONS.pause = function(g)
	g.box(7.2, 10, 3.6, 12.4, 1.4)
	g.box(12.8, 10, 3.6, 12.4, 1.4)
end
ICONS.next = function(g)
	g.tri(8.4, 10, 8.6, 10.8, 1)
	g.box(14.4, 10, 2.3, 10.8, 1)
end
ICONS.prev = function(g)
	g.box(5.6, 10, 2.3, 10.8, 1)
	g.tri(11.6, 10, 8.6, 10.8, -1)
end
ICONS.shuffle = function(g)
	g.bar(9.4, 10, 14.5, 1.9, 36)
	g.bar(9.4, 10, 14.5, 1.9, -36)
	g.tri(16.2, 5.6, 4.2, 4.8, 1)
	g.tri(16.2, 14.4, 4.2, 4.8, 1)
end
ICONS.loop = function(g)
	-- a rounded loop with an arrow head on top (the "repeat" icon; repeat is a Lua keyword)
	g.outline(10, 11, 15.5, 9.5, 4, 1.7)
	g.tri(14.4, 6.2, 4.4, 5, 1)
end

-- returns { Instance, SetRole(role, seconds) }
function UI.icon(name, parent, size, role, o)
	o = o or {}
	local S = size or 20
	local k = S / 20
	local builder = ICONS[name] or ICONS.dots
	local root = Util.new("Frame", {
		Name = "Icon_" .. name,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(S, S),
		AnchorPoint = o.anchor or Vector2.new(0, 0),
		Position = o.position or UDim2.new(0, 0, 0, 0),
		LayoutOrder = o.order or 0,
		Rotation = o.rotation or 0,
		ZIndex = o.zindex or 1,
	}, parent)
	local pieces = {}
	local currentRole = role or "Text"

	local function register(inst, prop)
		pieces[#pieces + 1] = { inst = inst, prop = prop }
		Theme.bind(inst, prop, currentRole)
	end
	local function place(inst, cx, cy, w, h, rot)
		inst.AnchorPoint = Vector2.new(0.5, 0.5)
		inst.Position = UDim2.fromOffset(cx * k, cy * k)
		inst.Size = UDim2.fromOffset(math.max(1, w * k), math.max(1, h * k))
		inst.Rotation = rot or 0
		inst.ZIndex = root.ZIndex
	end
	local g = {}
	function g.bar(cx, cy, w, h, rot)
		local f = Util.new("Frame", { BorderSizePixel = 0 }, root)
		place(f, cx, cy, w, h, rot)
		Util.new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, f)
		register(f, "BackgroundColor3")
	end
	function g.dot(cx, cy, d)
		g.bar(cx, cy, d, d, 0)
	end
	function g.box(cx, cy, w, h, r)
		local f = Util.new("Frame", { BorderSizePixel = 0 }, root)
		place(f, cx, cy, w, h, 0)
		Util.new("UICorner", { CornerRadius = UDim.new(0, math.max(0, r * k)) }, f)
		register(f, "BackgroundColor3")
	end
	function g.ring(cx, cy, d, thickness)
		local f = Util.new("Frame", { BorderSizePixel = 0, BackgroundTransparency = 1 }, root)
		place(f, cx, cy, d, d, 0)
		Util.new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, f)
		local stroke = Util.new("UIStroke", { Thickness = math.max(1, thickness * k), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, f)
		register(stroke, "Color")
	end
	function g.outline(cx, cy, w, h, r, thickness)
		local f = Util.new("Frame", { BorderSizePixel = 0, BackgroundTransparency = 1 }, root)
		place(f, cx, cy, w, h, 0)
		Util.new("UICorner", { CornerRadius = UDim.new(0, math.max(0, r * k)) }, f)
		local stroke = Util.new("UIStroke", { Thickness = math.max(1, thickness * k), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, f)
		register(stroke, "Color")
	end
	-- filled triangle: dir = 1 points right, -1 points left. Frames have no diagonal edges, so it is built from thin
	-- vertical slivers of falling height (no image, no font glyph).
	function g.tri(cx, cy, w, h, dir)
		local n = 12
		local step = w / n
		for i = 0, n - 1 do
			local height = math.max(h * (1 - i / n), h / n)
			local x
			if (dir or 1) >= 0 then
				x = cx - w / 2 + (i + 0.5) * step
			else
				x = cx + w / 2 - (i + 0.5) * step
			end
			local f = Util.new("Frame", { BorderSizePixel = 0 }, root)
			place(f, x, cy, step + 0.45, height, 0)
			register(f, "BackgroundColor3")
		end
	end
	builder(g)

	local api = { Instance = root }
	function api.SetRole(newRole, seconds)
		currentRole = newRole
		for _, piece in ipairs(pieces) do
			if seconds and seconds > 0 then
				Theme.tweenRole(piece.inst, piece.prop, newRole, seconds)
			else
				Theme.bind(piece.inst, piece.prop, newRole)
			end
		end
	end
	return api
end

----------------------------------------------------------------------------------------------------
-- pressable feedback: hover / press overlay + press scale. Returns a state table.
----------------------------------------------------------------------------------------------------
function UI.pressable(hit, face, o)
	o = o or {}
	local state = { pressed = false, hover = false, dragged = false, disabled = false }
	local overlay = Util.new("Frame", {
		Name = "Fx",
		Active = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		ZIndex = face.ZIndex + 4,
	}, face)
	Theme.bind(overlay, "BackgroundColor3", o.overlayRole or "Text")
	if o.radius then
		Util.corner(overlay, o.radius)
	end
	local scaler = Util.new("UIScale", { Scale = 1 }, face)

	local function render()
		local alpha, scale = 1, 1
		if state.disabled then
			alpha = 1
		elseif state.pressed then
			alpha, scale = o.pressAlpha or 0.82, o.pressScale or 0.965
		elseif state.hover then
			alpha = o.hoverAlpha or 0.92
		end
		Motion.tween(overlay, { BackgroundTransparency = alpha }, state.pressed and 0.06 or 0.16)
		if state.pressed then
			Motion.tween(scaler, { Scale = scale }, 0.07)
		else
			Motion.tween(scaler, { Scale = scale }, 0.22, Enum.EasingStyle.Back)
		end
	end
	state.render = render

	hit.InputBegan:Connect(function(input)
		if state.disabled or not isPress(input) then
			return
		end
		state.pressed = true
		state.dragged = false
		local origin = input.Position
		render()
		UI.watchInput(input, function(i)
			if state.dragged then
				return
			end
			local d = i.Position - origin
			if math.abs(d.X) + math.abs(d.Y) > 14 then
				state.dragged = true
				state.pressed = false
				render()
			end
		end, function()
			state.pressed = false
			render()
		end)
	end)

	if UserInputService.MouseEnabled then
		hit.MouseEnter:Connect(function()
			state.hover = true
			render()
		end)
		hit.MouseLeave:Connect(function()
			state.hover = false
			state.pressed = false
			render()
		end)
	end

	-- true when this activation should be ignored because the finger dragged (scroll gesture)
	function state.wasDrag()
		if state.dragged then
			state.dragged = false
			return true
		end
		return false
	end
	return state
end

----------------------------------------------------------------------------------------------------
-- button
----------------------------------------------------------------------------------------------------
-- o: parent, text, kind ("primary" | "secondary" | "ghost" | "danger"), width, height, size,
--    anchor, position, order, icon, small, sound, cooldown, onClick(api)
function UI.button(o)
	local kind = o.kind or "secondary"
	local radius = o.radius or UI.metrics.radius
	local hit = Util.new("TextButton", {
		Name = o.name or "Button",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = o.size or UDim2.fromOffset(o.width or 100, o.height or UI.metrics.buttonH),
		AnchorPoint = o.anchor or Vector2.new(0, 0),
		Position = o.position or UDim2.new(0, 0, 0, 0),
		LayoutOrder = o.order or 0,
		ZIndex = o.zindex or 1,
	}, o.parent)
	local face = Util.new("Frame", {
		Name = "Face",
		Active = false,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BorderSizePixel = 0,
		ZIndex = hit.ZIndex,
	}, hit)
	Util.corner(face, radius)

	local textRole, overlayRole = "Text", "Text"
	if kind == "primary" then
		face.BackgroundColor3 = Color3.new(1, 1, 1)
		local gradient = Util.new("UIGradient", { Rotation = 25 }, face)
		Theme.gradient(gradient, Theme.G.accent)
		textRole, overlayRole = "OnAccent", "OnAccent"
	elseif kind == "danger" then
		Theme.bind(face, "BackgroundColor3", "Danger")
		textRole, overlayRole = "OnDanger", "OnDanger"
	elseif kind == "ghost" then
		face.BackgroundTransparency = 1
		Theme.bind(Util.stroke(face, nil, 1), "Color", "Border")
	else
		Theme.bind(face, "BackgroundColor3", "AccentSoft")
	end

	local label = Util.new("TextLabel", {
		Name = "Label",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = o.text or "",
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = hit.ZIndex + 1,
	}, face)
	Util.pad(label, o.icon and 30 or 8, 0, 8, 0)
	Typo.apply(label, o.small and "buttonSmall" or "button")
	Theme.bind(label, "TextColor3", textRole)

	local api = { Instance = hit, Face = face, Label = label, enabled = true, last = 0, kind = kind }

	-- icon (optional). SetIcon(name) swaps it later, e.g. minimize <-> restore. o.iconRole overrides its colour.
	local function buildIcon(name)
		if api.Icon then
			api.Icon.Instance:Destroy()
			api.Icon = nil
		end
		if not name then
			return
		end
		local iconOnly = (o.text == nil or o.text == "")
		api.Icon = UI.icon(name, face, 16, o.iconRole or textRole, {
			anchor = iconOnly and Vector2.new(0.5, 0.5) or Vector2.new(0, 0.5),
			position = iconOnly and UDim2.fromScale(0.5, 0.5) or UDim2.new(0, 10, 0.5, 0),
			zindex = hit.ZIndex + 1,
		})
	end
	buildIcon(o.icon)
	api.SetIcon = buildIcon

	local state = UI.pressable(hit, face, { radius = radius, overlayRole = overlayRole })

	function api.SetText(text)
		label.Text = tostring(text)
	end
	function api.SetEnabled(enabled, reason)
		api.enabled = enabled and true or false
		api.reason = reason
		state.disabled = not api.enabled
		Motion.tween(label, { TextTransparency = api.enabled and 0 or 0.55 }, 0.15)
		Motion.tween(face, { BackgroundTransparency = (api.enabled or kind == "ghost") and (kind == "ghost" and 1 or 0) or 0.45 }, 0.15)
		state.render()
	end
	function api.SetBusy(busy, text)
		api.busy = busy and true or false
		if busy then
			api.idleText = api.idleText or label.Text
			label.Text = text or "Working..."
			api.SetEnabled(false)
		else
			if api.idleText then
				label.Text = api.idleText
				api.idleText = nil
			end
			api.SetEnabled(true)
		end
	end

	hit.Activated:Connect(function()
		if state.wasDrag() then
			return
		end
		if not api.enabled then
			UI.shake(face)
			if api.reason and os.clock() - (api.lastReason or 0) > 2 then
				api.lastReason = os.clock()
				Notify.warn("Unavailable", api.reason)
			end
			return
		end
		local now = os.clock()
		if now - api.last < (o.cooldown or 0.2) then
			return
		end
		api.last = now
		Sfx.play(o.sound or "click")
		if o.onClick then
			Util.try("button " .. tostring(o.text), o.onClick, api)
		end
	end)
	return api
end

----------------------------------------------------------------------------------------------------
-- toggle (switch)
----------------------------------------------------------------------------------------------------
-- o: parent, value, onChange(value), anchor, position, order, name
function UI.toggle(o)
	local value = o.value and true or false
	local hit = Util.new("TextButton", {
		Name = o.name or "Toggle",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(56, 38),
		AnchorPoint = o.anchor or Vector2.new(0, 0),
		Position = o.position or UDim2.new(0, 0, 0, 0),
		LayoutOrder = o.order or 0,
	}, o.parent)
	local face = Util.new("Frame", {
		Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(46, 26), BackgroundTransparency = 1, BorderSizePixel = 0,
	}, hit)
	local track = Util.new("Frame", { Name = "Track", Size = UDim2.fromScale(1, 1), BorderSizePixel = 0 }, face)
	Util.round_corner(track)
	Theme.bind(track, "BackgroundColor3", "Track")
	local trackStroke = Util.stroke(track, nil, 1, 0.35)
	Theme.bind(trackStroke, "Color", "Border")

	local fill = Util.new("Frame", {
		Name = "On", Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = value and 0 or 1, ZIndex = 2,
	}, face)
	Util.round_corner(fill)
	local gradient = Util.new("UIGradient", { Rotation = 0 }, fill)
	Theme.gradient(gradient, Theme.G.accent)

	local knob = Util.new("Frame", {
		Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(20, 20), BorderSizePixel = 0, ZIndex = 3,
		Position = UDim2.new(0, value and 23 or 3, 0.5, 0),
	}, face)
	Util.round_corner(knob)
	Theme.bind(knob, "BackgroundColor3", value and "OnAccent" or "Muted")

	local state = UI.pressable(hit, face, { radius = 13, overlayRole = "Text", pressScale = 0.97, hoverAlpha = 0.95, pressAlpha = 0.9 })
	local api = { Instance = hit, enabled = true, last = 0 }

	local function render(animate)
		local dur = animate and 0.2 or 0
		Motion.tween(fill, { BackgroundTransparency = value and 0 or 1 }, dur)
		Motion.tween(knob, { Position = UDim2.new(0, value and 23 or 3, 0.5, 0) }, dur, Enum.EasingStyle.Back)
		Theme.tweenRole(knob, "BackgroundColor3", value and "OnAccent" or "Muted", dur)
	end

	function api.Get()
		return value
	end
	function api.Set(newValue, silent)
		newValue = newValue and true or false
		if newValue == value then
			return
		end
		value = newValue
		render(true)
		if not silent and o.onChange then
			Util.try("toggle onChange", o.onChange, value)
		end
	end
	function api.SetEnabled(enabled)
		api.enabled = enabled and true or false
		state.disabled = not api.enabled
		track.BackgroundTransparency = api.enabled and 0 or 0.5
		knob.BackgroundTransparency = api.enabled and 0 or 0.5
	end

	hit.Activated:Connect(function()
		if state.wasDrag() then
			return
		end
		if not api.enabled then
			UI.shake(face)
			return
		end
		local now = os.clock()
		if now - api.last < 0.14 then
			return
		end
		api.last = now
		local target = not value
		Sfx.play(target and "toggleOn" or "toggleOff")
		api.Set(target, false)
	end)
	return api
end

----------------------------------------------------------------------------------------------------
-- slider
----------------------------------------------------------------------------------------------------
-- o: parent, min, max, step, value, width, format(v) -> string, onChange(value, final), anchor, position, order
function UI.slider(o)
	local min, max, step = o.min or 0, o.max or 1, o.step or 0.01
	local value = Util.clamp(o.value or min, min, max)
	local width = o.width or 200
	local format = o.format or function(v)
		return Util.percent((v - min) / (max - min)) .. "%"
	end
	local holder = Util.new("Frame", {
		Name = o.name or "Slider", BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.fromOffset(width, 38),
		AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0), LayoutOrder = o.order or 0,
	}, o.parent)
	local labelWidth = 46
	local track = Util.new("Frame", {
		Name = "Track", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0),
		Size = UDim2.new(1, -(labelWidth + 22), 0, 6), BorderSizePixel = 0,
	}, holder)
	Util.round_corner(track)
	Theme.bind(track, "BackgroundColor3", "Track")
	local fill = Util.new("Frame", {
		Name = "Fill", Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
	}, track)
	Util.round_corner(fill)
	Theme.gradient(Util.new("UIGradient", { Rotation = 0 }, fill), Theme.G.accent)
	local knob = Util.new("Frame", {
		Name = "Knob", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(18, 18), BorderSizePixel = 0, ZIndex = 3,
	}, track)
	Util.round_corner(knob)
	Theme.bind(knob, "BackgroundColor3", "Text")
	Theme.bind(Util.stroke(knob, nil, 2, 0), "Color", "Accent")
	local readout = Util.new("TextLabel", {
		Name = "Value", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(labelWidth, 20), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right, Text = "",
	}, holder)
	Typo.apply(readout, "caption")
	Theme.bind(readout, "TextColor3", "Muted")

	local hit = Util.new("TextButton", {
		Name = "Hit", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(1, -(labelWidth + 4), 1, 0), ZIndex = 5,
	}, holder)

	local api = { Instance = holder, enabled = true }
	local dragging = false
	local lastTick = 0

	local function render(animate)
		local alpha = (value - min) / (max - min)
		local dur = animate and 0.12 or 0
		Motion.tween(fill, { Size = UDim2.fromScale(alpha, 1) }, dur)
		Motion.tween(knob, { Position = UDim2.fromScale(alpha, 0.5) }, dur)
		readout.Text = format(value)
	end

	local function snap(raw)
		local snapped = min + Util.round(raw - min, step)
		snapped = math.floor(snapped * 10000 + 0.5) / 10000
		return Util.clamp(snapped, min, max)
	end

	local function setFromX(x, final)
		local width_ = track.AbsoluteSize.X
		if width_ <= 0 then
			return
		end
		local alpha = Util.clamp((x - track.AbsolutePosition.X) / width_, 0, 1)
		local newValue = snap(min + alpha * (max - min))
		if newValue ~= value then
			value = newValue
			render(false)
			local now = os.clock()
			if now - lastTick > 0.07 then
				lastTick = now
				Sfx.play("select")
			end
			if o.onChange then
				Util.try("slider onChange", o.onChange, value, false)
			end
		end
	end

	-- Touch gestures are disambiguated so that scrolling a page never moves a slider by accident (same idea as Android's
	-- SeekBar inside a scrolling list): a touch decides after ~8 px of movement -- sideways = slider drag, vertical = the page
	-- scrolls. Pressing ON the knob never makes it jump (it keeps its offset to the finger); pressing on the bare track and
	-- dragging sideways, or just tapping, moves the knob to that spot. A mouse press acts at once.
	hit.InputBegan:Connect(function(input)
		if not api.enabled or dragging or not isPress(input) then
			return
		end
		dragging = true
		local isTouch = input.UserInputType == Enum.UserInputType.Touch
		local scroller = UI.findScroller(holder)
		local origin = input.Position
		local decided = not isTouch
		local engaged = false
		local knobX = knob.AbsolutePosition.X + knob.AbsoluteSize.X / 2
		local grabOffset = 0
		if math.abs(origin.X - knobX) <= 20 then
			grabOffset = origin.X - knobX
		end
		local function engage()
			if engaged then
				return
			end
			engaged = true
			decided = true
			if scroller then
				scroller.ScrollingEnabled = false
			end
			Motion.tween(knob, { Size = UDim2.fromOffset(22, 22) }, 0.1)
		end
		if not isTouch then
			engage()
			setFromX(origin.X - grabOffset)
		end
		UI.watchInput(input, function(i)
			local delta = i.Position - origin
			if not decided then
				if math.abs(delta.X) + math.abs(delta.Y) < 8 then
					return
				end
				decided = true
				if math.abs(delta.X) >= math.abs(delta.Y) then
					engage()
					setFromX(i.Position.X - grabOffset)
				end
				return
			end
			if engaged then
				setFromX(i.Position.X - grabOffset)
			end
		end, function(cancelled)
			dragging = false
			if not decided and not cancelled then
				engage()
				setFromX(origin.X - grabOffset) -- a tap
			end
			if engaged then
				if scroller then
					scroller.ScrollingEnabled = true
				end
				Motion.tween(knob, { Size = UDim2.fromOffset(18, 18) }, 0.15)
				if o.onChange then
					Util.try("slider onChange", o.onChange, value, true)
				end
			end
		end)
	end)

	function api.Get()
		return value
	end
	function api.Set(newValue, silent)
		newValue = snap(newValue)
		if newValue == value then
			return
		end
		value = newValue
		render(true)
		if not silent and o.onChange then
			Util.try("slider onChange", o.onChange, value, true)
		end
	end
	function api.SetEnabled(enabled)
		api.enabled = enabled and true or false
		holder.BackgroundTransparency = 1
		track.BackgroundTransparency = api.enabled and 0 or 0.5
		knob.BackgroundTransparency = api.enabled and 0 or 0.5
	end
	render(false)
	return api
end

----------------------------------------------------------------------------------------------------
-- stepper:  [-]  value  [+]
----------------------------------------------------------------------------------------------------
-- o: parent, min, max, step, value, format(v), onChange(v), anchor, position, order
function UI.stepper(o)
	local min, max, step = o.min, o.max, o.step
	local value = Util.clamp(o.value or min, min, max)
	local format = o.format or function(v)
		return tostring(v)
	end
	local holder = Util.new("Frame", {
		Name = o.name or "Stepper", BackgroundTransparency = 1, Size = UDim2.fromOffset(150, 38),
		AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0), LayoutOrder = o.order or 0,
	}, o.parent)
	local readout = Util.new("TextLabel", {
		Name = "Value", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 56, 0, 24), BackgroundTransparency = 1, Text = "",
	}, holder)
	Typo.apply(readout, "heading")
	Theme.bind(readout, "TextColor3", "Text")
	local api = { Instance = holder }
	local function render()
		readout.Text = format(value)
	end
	local function change(delta)
		local newValue = Util.clamp(Util.round(value + delta, step), min, max)
		newValue = Util.round(newValue * 1000) / 1000
		if newValue ~= value then
			value = newValue
			render()
			if o.onChange then
				Util.try("stepper onChange", o.onChange, value)
			end
		else
			Sfx.play("warning")
			UI.shake(holder)
		end
	end
	local minus = UI.button({
		parent = holder, text = "", icon = "minus", width = 42, height = 34, anchor = Vector2.new(0, 0.5),
		position = UDim2.new(0, 0, 0.5, 0), cooldown = 0.08, name = "Minus", onClick = function()
			change(-step)
		end,
	})
	minus.Label.Text = ""
	local plus = UI.button({
		parent = holder, text = "", icon = "plus", width = 42, height = 34, anchor = Vector2.new(1, 0.5),
		position = UDim2.new(1, 0, 0.5, 0), cooldown = 0.08, name = "Plus", onClick = function()
			change(step)
		end,
	})
	plus.Label.Text = ""
	function api.Get()
		return value
	end
	function api.Set(newValue, silent)
		newValue = Util.clamp(newValue, min, max)
		if newValue ~= value then
			value = newValue
			render()
			if not silent and o.onChange then
				Util.try("stepper onChange", o.onChange, value)
			end
		end
	end
	render()
	return api
end

----------------------------------------------------------------------------------------------------
-- segmented selector (2-4 short options)
----------------------------------------------------------------------------------------------------
-- o: parent, options = { {id=, label=}, ... }, value, onChange(id), width, height, anchor, position, order
function UI.segmented(o)
	local options = o.options
	local count = #options
	local index = 1
	for i, opt in ipairs(options) do
		if opt.id == o.value then
			index = i
		end
	end
	local holder = Util.new("Frame", {
		Name = o.name or "Segmented", BorderSizePixel = 0,
		Size = o.size or UDim2.fromOffset(o.width or 220, o.height or 36),
		AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0), LayoutOrder = o.order or 0,
	}, o.parent)
	Util.corner(holder, 10)
	Theme.bind(holder, "BackgroundColor3", "Track", "Panel", 0.4)
	Theme.bind(Util.stroke(holder, nil, 1, 0.4), "Color", "Border")

	local pill = Util.new("Frame", {
		Name = "Pill", BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2,
		Size = UDim2.new(1 / count, -6, 1, -6), Position = UDim2.new((index - 1) / count, 3, 0, 3),
	}, holder)
	Util.corner(pill, 8)
	Theme.gradient(Util.new("UIGradient", { Rotation = 20 }, pill), Theme.G.accent)

	local buttons, labels = {}, {}
	local api = { Instance = holder, enabled = true, last = 0 }

	local function paint(animate)
		local dur = animate and 0.22 or 0
		Motion.tween(pill, { Position = UDim2.new((index - 1) / count, 3, 0, 3) }, dur, Enum.EasingStyle.Quart)
		for i, label in ipairs(labels) do
			Theme.tweenRole(label, "TextColor3", i == index and "OnAccent" or "Muted", dur)
		end
	end

	for i, opt in ipairs(options) do
		local hit = Util.new("TextButton", {
			Name = "Opt_" .. tostring(opt.id), Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
			Size = UDim2.new(1 / count, 0, 1, 0), Position = UDim2.new((i - 1) / count, 0, 0, 0), ZIndex = 3,
		}, holder)
		local label = Util.new("TextLabel", {
			BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = opt.label, ZIndex = 4,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, hit)
		Util.pad(label, 4, 0, 4, 0)
		Typo.apply(label, "buttonSmall")
		Theme.bind(label, "TextColor3", i == index and "OnAccent" or "Muted")
		buttons[i], labels[i] = hit, label
		local state = { dragged = false }
		hit.InputBegan:Connect(function(input)
			if isPress(input) then
				state.dragged = false
				local origin = input.Position
				UI.watchInput(input, function(ev)
					local d = ev.Position - origin
					if math.abs(d.X) + math.abs(d.Y) > 14 then
						state.dragged = true
					end
				end, nil)
			end
		end)
		hit.Activated:Connect(function()
			if state.dragged then
				state.dragged = false
				return
			end
			if not api.enabled then
				UI.shake(holder)
				return
			end
			if i == index then
				return
			end
			local now = os.clock()
			if now - api.last < 0.12 then
				return
			end
			api.last = now
			index = i
			Sfx.play("select")
			paint(true)
			if o.onChange then
				Util.try("segmented onChange", o.onChange, opt.id)
			end
		end)
	end

	function api.Get()
		return options[index].id
	end
	function api.Set(id, silent)
		for i, opt in ipairs(options) do
			if opt.id == id and i ~= index then
				index = i
				paint(true)
				if not silent and o.onChange then
					Util.try("segmented onChange", o.onChange, id)
				end
				return
			end
		end
	end
	function api.SetEnabled(enabled)
		api.enabled = enabled and true or false
		for _, label in ipairs(labels) do
			label.TextTransparency = api.enabled and 0 or 0.55
		end
	end
	paint(false)
	return api
end
end -- [05_ui_base.lua]

do -- [06_ui_more.lua]

----------------------------------------------------------------------------------------------------
-- UI kit, part 2: cards, sections, pages, chips, stat tiles, dropdown, text input, confirm dialog
----------------------------------------------------------------------------------------------------
function UI.prune()
	Theme.prune()
	Typo.prune()
end

-- Card with title + description on the left and an optional control area on the right.
-- o: parent, title, desc, order, control (px reserved on the right), stack (controls below the text),
--    controlHeight (stack mode), minHeight, name
-- returns { Instance, Title, Desc, Controls, SetTitle, SetDesc }
function UI.card(o)
	local controlWidth = o.control or 0
	local card = Util.new("Frame", {
		Name = o.name or "Card",
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, o.minHeight or UI.metrics.rowH),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = o.order or 0,
	}, o.parent)
	Theme.surface(card, "Card", "card")
	Util.corner(card, 12)
	Theme.bind(Util.stroke(card, nil, 1, 0.15), "Color", "Border")
	Util.pad(card, 14, 11, 12, 11)

	local inner = Util.new("Frame", {
		Name = "Inner", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
	}, card)
	Util.list(inner, 9)

	local sideControls = controlWidth > 0 and not o.stack
	local textBlock = Util.new("Frame", {
		Name = "Text", BackgroundTransparency = 1, LayoutOrder = 1, AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, sideControls and -(controlWidth + 12) or 0, 0, 0),
	}, inner)
	Util.list(textBlock, 3)

	local title = Util.new("TextLabel", {
		Name = "Title", BackgroundTransparency = 1, LayoutOrder = 1, Text = o.title or "",
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, textBlock)
	Typo.apply(title, "heading")
	Theme.bind(title, "TextColor3", "Text")

	local desc = Util.new("TextLabel", {
		Name = "Desc", BackgroundTransparency = 1, LayoutOrder = 2, Text = o.desc or "",
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		Visible = (o.desc ~= nil and o.desc ~= ""),
	}, textBlock)
	Typo.apply(desc, "caption")
	Theme.bind(desc, "TextColor3", "Muted")

	local controlHeight = o.controlHeight or 38
	local controls
	if o.stack then
		controls = Util.new("Frame", {
			Name = "Controls", BackgroundTransparency = 1, LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, controlHeight),
		}, inner)
	else
		controls = Util.new("Frame", {
			Name = "Controls", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, controlWidth, 0, controlHeight),
		}, card)
	end

	local api = {
		Instance = card, Title = title, Desc = desc, Controls = controls,
		controlWidth = controlWidth, stacked = o.stack and true or false,
	}
	function api.SetTitle(text)
		title.Text = tostring(text)
	end
	function api.SetDesc(text)
		desc.Text = tostring(text)
		desc.Visible = text ~= nil and text ~= ""
	end
	-- Moves the controls below the text (narrow windows) or back to the right side (wide windows).
	function api.SetStacked(flag)
		flag = flag and true or false
		if controlWidth <= 0 or api.stacked == flag then
			return
		end
		api.stacked = flag
		if flag then
			controls.Parent = inner
			controls.LayoutOrder = 2
			controls.AnchorPoint = Vector2.new(0, 0)
			controls.Position = UDim2.new(0, 0, 0, 0)
			controls.Size = UDim2.new(1, 0, 0, controlHeight)
			textBlock.Size = UDim2.new(1, 0, 0, 0)
		else
			controls.Parent = card
			controls.AnchorPoint = Vector2.new(1, 0.5)
			controls.Position = UDim2.new(1, 0, 0.5, 0)
			controls.Size = UDim2.new(0, controlWidth, 0, controlHeight)
			textBlock.Size = UDim2.new(1, -(controlWidth + 12), 0, 0)
		end
	end
	return api
end

function UI.section(parent, text, order)
	local row = Util.new("Frame", {
		Name = "Section", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), LayoutOrder = order or 0,
	}, parent)
	local bar = Util.new("Frame", {
		Name = "Mark", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 2, 1, -3), Size = UDim2.fromOffset(3, 12),
		BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
	}, row)
	Util.round_corner(bar)
	Theme.gradient(Util.new("UIGradient", { Rotation = 90 }, bar), Theme.G.accent)
	local label = Util.new("TextLabel", {
		Name = "Label", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, 0),
		Size = UDim2.new(1, -12, 0, 18), Text = string.upper(text), TextXAlignment = Enum.TextXAlignment.Left,
	}, row)
	Typo.apply(label, "label")
	Theme.bind(label, "TextColor3", "Muted")
	return row
end

function UI.page(parent, name)
	local page = Util.new("ScrollingFrame", {
		Name = name .. "Page",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarThickness = 3,
		ScrollBarImageTransparency = 0.35,
		Visible = false,
	}, parent)
	Theme.bind(page, "ScrollBarImageColor3", "Accent")
	Util.pad(page, 0, 2, 7, 16)
	Util.list(page, 8)
	return page
end

-- small status pill. o: parent, text, role ("Green" | "Warn" | "Danger" | "Accent" | "Muted"), order, anchor, position
function UI.chip(o)
	local role = o.role or "Accent"
	local chip = Util.new("Frame", {
		Name = "Chip", BorderSizePixel = 0, Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = o.order or 0, AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0),
	}, o.parent)
	Util.round_corner(chip)
	Theme.bind(chip, "BackgroundColor3", "Card", role, 0.2)
	Util.pad(chip, 9, 0, 9, 0)
	local label = Util.new("TextLabel", {
		Name = "Label", BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X,
		Text = o.text or "",
	}, chip)
	Typo.apply(label, "label", 10)
	Theme.bind(label, "TextColor3", role)
	local api = { Instance = chip }
	function api.Set(text, newRole)
		label.Text = tostring(text)
		if newRole then
			Theme.bind(chip, "BackgroundColor3", "Card", newRole, 0.2)
			Theme.tweenRole(label, "TextColor3", newRole, 0.2)
		end
	end
	return api
end

-- compact value tile (FPS, ping ...). o: parent, label, value, order, size
function UI.statTile(o)
	local tile = Util.new("Frame", {
		Name = "Stat", BorderSizePixel = 0, LayoutOrder = o.order or 0, Size = o.size or UDim2.new(1 / 3, -6, 0, 62),
	}, o.parent)
	Theme.surface(tile, "Card", "card")
	Util.corner(tile, 12)
	Theme.bind(Util.stroke(tile, nil, 1, 0.15), "Color", "Border")
	local value = Util.new("TextLabel", {
		Name = "Value", BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 9), Size = UDim2.new(1, -24, 0, 26),
		Text = o.value or "-", TextXAlignment = Enum.TextXAlignment.Left,
	}, tile)
	Typo.apply(value, "stat")
	Theme.bind(value, "TextColor3", "Text")
	local label = Util.new("TextLabel", {
		Name = "Label", BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 37), Size = UDim2.new(1, -24, 0, 16),
		Text = o.label or "", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, tile)
	Typo.apply(label, "caption")
	Theme.bind(label, "TextColor3", "Muted")
	local api = { Instance = tile }
	function api.Set(text, role)
		value.Text = tostring(text)
		if role then
			Theme.tweenRole(value, "TextColor3", role, 0.2)
		end
	end
	return api
end

----------------------------------------------------------------------------------------------------
-- dropdown (popup lives in the window's popup layer so scrolling pages never clip it)
----------------------------------------------------------------------------------------------------
UI.openDropdown = nil

function UI.closeDropdown(immediate)
	local active = UI.openDropdown
	if active then
		UI.openDropdown = nil
		active.close(immediate)
	end
end

-- o: parent, options = { {id=, label=}, ... }, value, onChange(id), width, height, popupWidth, anchor, position, order, name
function UI.dropdown(o)
	local options = o.options
	local current = o.value
	local hit = Util.new("TextButton", {
		Name = o.name or "Dropdown", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.fromOffset(o.width or 170, o.height or 36),
		AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0), LayoutOrder = o.order or 0,
	}, o.parent)
	local face = Util.new("Frame", {
		Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1), BorderSizePixel = 0,
	}, hit)
	Util.corner(face, 10)
	Theme.bind(face, "BackgroundColor3", "Track", "Panel", 0.4)
	Theme.bind(Util.stroke(face, nil, 1, 0.3), "Color", "Border")
	local label = Util.new("TextLabel", {
		Name = "Label", BackgroundTransparency = 1, Size = UDim2.new(1, -36, 1, 0), Position = UDim2.fromOffset(12, 0),
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = "",
	}, face)
	Typo.apply(label, "buttonSmall")
	Theme.bind(label, "TextColor3", "Text")
	local chevron = UI.icon("chevron", face, 16, "Muted", { anchor = Vector2.new(1, 0.5), position = UDim2.new(1, -10, 0.5, 0) })
	local state = UI.pressable(hit, face, { radius = 10, hoverAlpha = 0.94, pressAlpha = 0.88 })
	local api = { Instance = hit, enabled = true, last = 0 }

	local function labelFor(id)
		for _, opt in ipairs(options) do
			if opt.id == id then
				return opt.label
			end
		end
		return o.placeholder or "Select..."
	end
	label.Text = labelFor(current)

	local function open()
		local layer = UI.layers.popup
		if not layer then
			return
		end
		local s = UI.scale()
		local lx = (hit.AbsolutePosition.X - layer.AbsolutePosition.X) / s
		local ly = (hit.AbsolutePosition.Y - layer.AbsolutePosition.Y) / s
		local bw, bh = hit.AbsoluteSize.X / s, hit.AbsoluteSize.Y / s
		local lw, lh = layer.AbsoluteSize.X / s, layer.AbsoluteSize.Y / s
		local rowHeight = 36
		local visibleRows = math.min(#options, 6)
		local listHeight = visibleRows * rowHeight + 10
		local width = math.min(math.max(bw, o.popupWidth or 170), math.max(120, lw - 12))
		local x = Util.clamp(lx + bw - width, 6, math.max(6, lw - width - 6))
		local below = ly + bh + 4
		local anchorY, y = 0, below
		if below + listHeight > lh - 6 then
			local above = ly - 4
			if above - listHeight >= 6 then
				anchorY, y = 1, above
			else
				y = Util.clamp(below, 6, math.max(6, lh - listHeight - 6))
			end
		end

		layer.Visible = true
		local catcher = Util.new("TextButton", {
			Name = "Catcher", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1), ZIndex = 1,
		}, layer)
		local list = Util.new("Frame", {
			Name = "DropdownList", AnchorPoint = Vector2.new(0, anchorY), Position = UDim2.fromOffset(x, y),
			Size = UDim2.fromOffset(width, 0), BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 2,
		}, layer)
		Util.corner(list, 12)
		Theme.bind(list, "BackgroundColor3", "Elevated")
		Theme.bind(Util.stroke(list, nil, 1, 0.1), "Color", "Border")
		local scroller = Util.new("ScrollingFrame", {
			Name = "Options", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3,
			CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3,
			ScrollBarImageTransparency = 0.4,
		}, list)
		Theme.bind(scroller, "ScrollBarImageColor3", "Accent")
		Util.pad(scroller, 5, 5, 5, 5)
		Util.list(scroller, 0)

		for i, opt in ipairs(options) do
			local rowHit = Util.new("TextButton", {
				Name = "Opt_" .. tostring(opt.id), Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
				BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, rowHeight), LayoutOrder = i, ZIndex = 4,
			}, scroller)
			local rowFace = Util.new("Frame", {
				Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, -2, 1, -4), BorderSizePixel = 0, ZIndex = 4,
				BackgroundTransparency = opt.id == current and 0 or 1,
			}, rowHit)
			Util.corner(rowFace, 8)
			Theme.bind(rowFace, "BackgroundColor3", "AccentSoft")
			local rowLabel = Util.new("TextLabel", {
				BackgroundTransparency = 1, Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(10, 0), Text = opt.label,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 5,
			}, rowFace)
			Typo.apply(rowLabel, "buttonSmall")
			Theme.bind(rowLabel, "TextColor3", opt.id == current and "Text" or "Muted")
			if opt.id == current then
				UI.icon("check", rowFace, 16, "Accent", { anchor = Vector2.new(1, 0.5), position = UDim2.new(1, -10, 0.5, 0), zindex = 5 })
			end
			local rowState = UI.pressable(rowHit, rowFace, { radius = 8, hoverAlpha = 0.93, pressAlpha = 0.85, pressScale = 0.98 })
			rowHit.Activated:Connect(function()
				if rowState.wasDrag() then
					return
				end
				Sfx.play("select")
				current = opt.id
				label.Text = opt.label
				UI.closeDropdown()
				if o.onChange then
					Util.try("dropdown onChange", o.onChange, opt.id)
				end
			end)
		end

		local closing = false
		local function close(immediate)
			if closing then
				return
			end
			closing = true
			Motion.tween(chevron.Instance, { Rotation = 0 }, 0.15)
			local function finish()
				catcher:Destroy()
				list:Destroy()
				if not UI.openDropdown then
					layer.Visible = false
				end
				UI.prune()
			end
			if immediate then
				Motion.cancel(list)
				finish()
			else
				Motion.tween(list, { Size = UDim2.fromOffset(width, 0) }, 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.In, finish)
			end
		end
		UI.openDropdown = { close = close, owner = api }
		catcher.Activated:Connect(function()
			Sfx.play("dropdown")
			UI.closeDropdown()
		end)
		Sfx.play("dropdown")
		Motion.tween(chevron.Instance, { Rotation = 180 }, 0.2)
		Motion.tween(list, { Size = UDim2.fromOffset(width, listHeight) }, 0.2)
	end

	hit.Activated:Connect(function()
		if state.wasDrag() then
			return
		end
		if not api.enabled then
			UI.shake(face)
			return
		end
		local now = os.clock()
		if now - api.last < 0.15 then
			return
		end
		api.last = now
		local active = UI.openDropdown
		if active and active.owner == api then
			Sfx.play("dropdown")
			UI.closeDropdown()
			return
		end
		UI.closeDropdown(true)
		open()
	end)

	function api.Get()
		return current
	end
	function api.Set(id, silent)
		current = id
		label.Text = labelFor(id)
		if not silent and o.onChange then
			Util.try("dropdown onChange", o.onChange, id)
		end
	end
	function api.SetOptions(newOptions, selected)
		options = newOptions
		current = selected
		label.Text = labelFor(current)
	end
	function api.SetEnabled(enabled)
		api.enabled = enabled and true or false
		label.TextTransparency = api.enabled and 0 or 0.55
	end
	return api
end

----------------------------------------------------------------------------------------------------
-- multi-select dropdown (added with the built-in Steal An Egg panel)
-- Same look and popup as UI.dropdown, but every row is a check box and the list stays open while you pick.
-- o: parent, options = { {id=, label=}, ... }, value = { id, ... }, placeholder, onChange(list of ids), width, height,
--    popupWidth, anchor, position, order, name
-- api: Get() -> selected ids in option order, Set(list, silent), SetOptions(options, list), SetEnabled(flag)
----------------------------------------------------------------------------------------------------
function UI.multiSelect(o)
	local options = o.options
	local selected = {}
	for _, id in ipairs(o.value or {}) do
		selected[id] = true
	end
	local hit = Util.new("TextButton", {
		Name = o.name or "MultiSelect", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.fromOffset(o.width or 170, o.height or 36),
		AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0), LayoutOrder = o.order or 0,
	}, o.parent)
	local face = Util.new("Frame", {
		Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1), BorderSizePixel = 0,
	}, hit)
	Util.corner(face, 10)
	Theme.bind(face, "BackgroundColor3", "Track", "Panel", 0.4)
	Theme.bind(Util.stroke(face, nil, 1, 0.3), "Color", "Border")
	local label = Util.new("TextLabel", {
		Name = "Label", BackgroundTransparency = 1, Size = UDim2.new(1, -36, 1, 0), Position = UDim2.fromOffset(12, 0),
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = "",
	}, face)
	Typo.apply(label, "buttonSmall")
	Theme.bind(label, "TextColor3", "Text")
	local chevron = UI.icon("chevron", face, 16, "Muted", { anchor = Vector2.new(1, 0.5), position = UDim2.new(1, -10, 0.5, 0) })
	local state = UI.pressable(hit, face, { radius = 10, hoverAlpha = 0.94, pressAlpha = 0.88 })
	local api = { Instance = hit, enabled = true, last = 0 }
	local rows = {} -- only filled while the popup is open

	local function chosen()
		local list = {}
		for _, opt in ipairs(options) do
			if selected[opt.id] then
				list[#list + 1] = opt.id
			end
		end
		return list
	end

	local function paintLabel()
		local names = {}
		for _, opt in ipairs(options) do
			if selected[opt.id] then
				names[#names + 1] = opt.label
			end
		end
		if #names == 0 then
			label.Text = o.placeholder or "Select..."
			Theme.tweenRole(label, "TextColor3", "Muted", 0.12)
		else
			label.Text = (#names <= 2) and table.concat(names, ", ") or (tostring(#names) .. " selected")
			Theme.tweenRole(label, "TextColor3", "Text", 0.12)
		end
	end
	paintLabel()

	local function paintRows()
		for _, row in ipairs(rows) do
			local on = selected[row.id] == true
			Motion.tween(row.face, { BackgroundTransparency = on and 0 or 1 }, 0.12)
			Theme.tweenRole(row.label, "TextColor3", on and "Text" or "Muted", 0.12)
			row.check.Instance.Visible = on
		end
	end

	local function open()
		local layer = UI.layers.popup
		if not layer then
			return
		end
		local s = UI.scale()
		local lx = (hit.AbsolutePosition.X - layer.AbsolutePosition.X) / s
		local ly = (hit.AbsolutePosition.Y - layer.AbsolutePosition.Y) / s
		local bw, bh = hit.AbsoluteSize.X / s, hit.AbsoluteSize.Y / s
		local lw, lh = layer.AbsoluteSize.X / s, layer.AbsoluteSize.Y / s
		local rowHeight = 36
		local visibleRows = math.min(#options, 6)
		local listHeight = visibleRows * rowHeight + 10
		local width = math.min(math.max(bw, o.popupWidth or 170), math.max(120, lw - 12))
		local x = Util.clamp(lx + bw - width, 6, math.max(6, lw - width - 6))
		local below = ly + bh + 4
		local anchorY, y = 0, below
		if below + listHeight > lh - 6 then
			local above = ly - 4
			if above - listHeight >= 6 then
				anchorY, y = 1, above
			else
				y = Util.clamp(below, 6, math.max(6, lh - listHeight - 6))
			end
		end

		layer.Visible = true
		local catcher = Util.new("TextButton", {
			Name = "Catcher", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1), ZIndex = 1,
		}, layer)
		local list = Util.new("Frame", {
			Name = "MultiSelectList", AnchorPoint = Vector2.new(0, anchorY), Position = UDim2.fromOffset(x, y),
			Size = UDim2.fromOffset(width, 0), BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 2,
		}, layer)
		Util.corner(list, 12)
		Theme.bind(list, "BackgroundColor3", "Elevated")
		Theme.bind(Util.stroke(list, nil, 1, 0.1), "Color", "Border")
		local scroller = Util.new("ScrollingFrame", {
			Name = "Options", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3,
			CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3,
			ScrollBarImageTransparency = 0.4,
		}, list)
		Theme.bind(scroller, "ScrollBarImageColor3", "Accent")
		Util.pad(scroller, 5, 5, 5, 5)
		Util.list(scroller, 0)

		rows = {}
		for i, opt in ipairs(options) do
			local on = selected[opt.id] == true
			local rowHit = Util.new("TextButton", {
				Name = "Opt_" .. tostring(opt.id), Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
				BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, rowHeight), LayoutOrder = i, ZIndex = 4,
			}, scroller)
			local rowFace = Util.new("Frame", {
				Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, -2, 1, -4), BorderSizePixel = 0, ZIndex = 4,
				BackgroundTransparency = on and 0 or 1,
			}, rowHit)
			Util.corner(rowFace, 8)
			Theme.bind(rowFace, "BackgroundColor3", "AccentSoft")
			local rowLabel = Util.new("TextLabel", {
				BackgroundTransparency = 1, Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(10, 0), Text = opt.label,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 5,
			}, rowFace)
			Typo.apply(rowLabel, "buttonSmall")
			Theme.bind(rowLabel, "TextColor3", on and "Text" or "Muted")
			local check = UI.icon("check", rowFace, 16, "Accent", { anchor = Vector2.new(1, 0.5), position = UDim2.new(1, -10, 0.5, 0), zindex = 5 })
			check.Instance.Visible = on
			local rowState = UI.pressable(rowHit, rowFace, { radius = 8, hoverAlpha = 0.93, pressAlpha = 0.85, pressScale = 0.98 })
			rows[#rows + 1] = { id = opt.id, face = rowFace, label = rowLabel, check = check }
			rowHit.Activated:Connect(function()
				if rowState.wasDrag() then
					return
				end
				Sfx.play("select")
				if selected[opt.id] then
					selected[opt.id] = nil
				else
					selected[opt.id] = true
				end
				paintLabel()
				paintRows()
				if o.onChange then
					Util.try("multiselect onChange", o.onChange, chosen())
				end
			end)
		end

		local closing = false
		local function close(immediate)
			if closing then
				return
			end
			closing = true
			rows = {}
			Motion.tween(chevron.Instance, { Rotation = 0 }, 0.15)
			local function finish()
				catcher:Destroy()
				list:Destroy()
				if not UI.openDropdown then
					layer.Visible = false
				end
				UI.prune()
			end
			if immediate then
				Motion.cancel(list)
				finish()
			else
				Motion.tween(list, { Size = UDim2.fromOffset(width, 0) }, 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.In, finish)
			end
		end
		UI.openDropdown = { close = close, owner = api }
		catcher.Activated:Connect(function()
			Sfx.play("dropdown")
			UI.closeDropdown()
		end)
		Sfx.play("dropdown")
		Motion.tween(chevron.Instance, { Rotation = 180 }, 0.2)
		Motion.tween(list, { Size = UDim2.fromOffset(width, listHeight) }, 0.2)
	end

	hit.Activated:Connect(function()
		if state.wasDrag() then
			return
		end
		if not api.enabled then
			UI.shake(face)
			return
		end
		local now = os.clock()
		if now - api.last < 0.15 then
			return
		end
		api.last = now
		local active = UI.openDropdown
		if active and active.owner == api then
			Sfx.play("dropdown")
			UI.closeDropdown()
			return
		end
		UI.closeDropdown(true)
		open()
	end)

	function api.Get()
		return chosen()
	end
	function api.Set(list, silent)
		selected = {}
		for _, id in ipairs(type(list) == "table" and list or {}) do
			selected[id] = true
		end
		if UI.openDropdown and UI.openDropdown.owner == api then
			UI.closeDropdown(true)
		end
		paintLabel()
		if not silent and o.onChange then
			Util.try("multiselect onChange", o.onChange, chosen())
		end
	end
	function api.SetOptions(newOptions, list)
		options = newOptions
		selected = {}
		for _, id in ipairs(type(list) == "table" and list or {}) do
			selected[id] = true
		end
		if UI.openDropdown and UI.openDropdown.owner == api then
			UI.closeDropdown(true)
		end
		paintLabel()
	end
	function api.SetEnabled(enabled)
		api.enabled = enabled and true or false
		label.TextTransparency = api.enabled and 0 or 0.55
	end
	return api
end

----------------------------------------------------------------------------------------------------
-- text input
----------------------------------------------------------------------------------------------------
-- o: parent, placeholder, text, width, height, size, numeric, maxLength, onSubmit(text, enter), onChange(text),
--    anchor, position, order
function UI.input(o)
	local holder = Util.new("Frame", {
		Name = o.name or "Input", BorderSizePixel = 0, ClipsDescendants = true,
		Size = o.size or UDim2.fromOffset(o.width or 200, o.height or 36),
		AnchorPoint = o.anchor or Vector2.new(0, 0), Position = o.position or UDim2.new(0, 0, 0, 0), LayoutOrder = o.order or 0,
	}, o.parent)
	Util.corner(holder, 10)
	Theme.surface(holder, "Panel", "input")
	local stroke = Util.stroke(holder, nil, 1, 0.1)
	Theme.bind(stroke, "Color", "Border")
	local box = Util.new("TextBox", {
		Name = "Box", BackgroundTransparency = 1, Size = UDim2.new(1, -20, 1, 0), Position = UDim2.fromOffset(10, 0),
		Text = o.text or "", PlaceholderText = o.placeholder or "", ClearTextOnFocus = false, MultiLine = false,
		TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = false, ClipsDescendants = true,
	}, holder)
	Typo.apply(box, "body", 13)
	Theme.bind(box, "TextColor3", "Text")
	Theme.bind(box, "PlaceholderColor3", "Faint")
	local api = { Instance = holder, Box = box }
	local guard = false

	box:GetPropertyChangedSignal("Text"):Connect(function()
		if guard then
			return
		end
		local text = box.Text
		local cleaned = text
		if o.numeric then
			cleaned = string.gsub(cleaned, "%D", "")
		end
		if o.maxLength and #cleaned > o.maxLength then
			cleaned = string.sub(cleaned, 1, o.maxLength)
		end
		if cleaned ~= text then
			guard = true
			box.Text = cleaned
			guard = false
		end
		if o.onChange then
			Util.try("input onChange", o.onChange, cleaned)
		end
	end)
	box.Focused:Connect(function()
		Theme.tweenRole(stroke, "Color", "Accent", 0.15)
		Motion.tween(stroke, { Thickness = 1.5, Transparency = 0 }, 0.15)
		Sfx.play("select")
		UI.scrollIntoView(holder)
		if Win.onInputFocus then
			Win.onInputFocus(holder, true)
		end
	end)
	box.FocusLost:Connect(function(enter)
		Theme.tweenRole(stroke, "Color", "Border", 0.2)
		Motion.tween(stroke, { Thickness = 1, Transparency = 0.1 }, 0.2)
		if Win.onInputFocus then
			Win.onInputFocus(holder, false)
		end
		if o.onSubmit then
			Util.try("input onSubmit", o.onSubmit, Util.trim(box.Text), enter)
		end
	end)

	function api.Get()
		return Util.trim(box.Text)
	end
	function api.Set(text)
		guard = true
		box.Text = tostring(text or "")
		guard = false
	end
	function api.Focus()
		box:CaptureFocus()
	end
	function api.Flash(role)
		Theme.bind(stroke, "Color", role or "Danger")
		Motion.tween(stroke, { Thickness = 2 }, 0.1)
		task.delay(0.9, function()
			if stroke.Parent then
				Theme.tweenRole(stroke, "Color", "Border", 0.3)
				Motion.tween(stroke, { Thickness = 1 }, 0.3)
			end
		end)
		UI.shake(holder)
	end
	return api
end

----------------------------------------------------------------------------------------------------
-- confirm dialog (one at a time, rendered in the window's modal layer)
----------------------------------------------------------------------------------------------------
UI.modal = nil

function UI.closeModal(immediate)
	local modal = UI.modal
	if not modal then
		return
	end
	UI.modal = nil
	local layer = UI.layers.modal
	local function finish()
		modal.scrim:Destroy()
		modal.card:Destroy()
		if layer then
			layer.Visible = false
		end
		UI.prune()
	end
	if immediate then
		finish()
		return
	end
	Motion.tween(modal.scrim, { BackgroundTransparency = 1 }, 0.14)
	Motion.tween(modal.scale, { Scale = 0.94 }, 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In, finish)
end

-- o: title, text, confirmText, cancelText, danger, onConfirm(), onCancel()
function UI.confirm(o)
	local layer = UI.layers.modal
	if not layer or UI.modal then
		return false
	end
	UI.closeDropdown(true)
	layer.Visible = true
	local s = UI.scale()
	local layerWidth = layer.AbsoluteSize.X / s
	local width = Util.clamp(layerWidth - 40, 240, 350)

	local scrim = Util.new("TextButton", {
		Name = "Scrim", Text = "", AutoButtonColor = false, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1, ZIndex = 1,
	}, layer)
	Theme.bind(scrim, "BackgroundColor3", "Scrim")
	local card = Util.new("Frame", {
		Name = "Confirm", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(width, 0), AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0, ZIndex = 2,
	}, layer)
	Util.corner(card, 14)
	Theme.bind(card, "BackgroundColor3", "Elevated")
	Theme.bind(Util.stroke(card, nil, 1, 0), "Color", o.danger and "Danger" or "Accent", "Border", o.danger and 0.55 or 0.5)
	Util.pad(card, 18, 16, 18, 16)
	local scale = Util.new("UIScale", { Scale = 0.92 }, card)
	Util.list(card, 10)

	local head = Util.new("Frame", { Name = "Head", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = 1 }, card)
	UI.icon(o.danger and "bang" or "info", head, 22, o.danger and "Danger" or "Accent", { anchor = Vector2.new(0, 0.5), position = UDim2.new(0, 0, 0.5, 0) })
	local title = Util.new("TextLabel", {
		BackgroundTransparency = 1, Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -30, 1, 0),
		Text = o.title or "Are you sure?", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, head)
	Typo.apply(title, "heading", 15)
	Theme.bind(title, "TextColor3", "Text")
	local body = Util.new("TextLabel", {
		BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Text = o.text or "", TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, card)
	Typo.apply(body, "body")
	Theme.bind(body, "TextColor3", "Muted")
	local row = Util.new("Frame", { Name = "Buttons", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 40), LayoutOrder = 3 }, card)

	local modal = { scrim = scrim, card = card, scale = scale }
	UI.modal = modal
	local decided = false
	local function decide(confirmed)
		if decided then
			return
		end
		decided = true
		UI.closeModal()
		if confirmed then
			if o.onConfirm then
				Util.try("confirm", o.onConfirm)
			end
		elseif o.onCancel then
			Util.try("cancel", o.onCancel)
		end
	end
	UI.button({
		parent = row, text = o.cancelText or "Cancel", kind = "ghost", size = UDim2.new(0.5, -5, 1, 0), name = "Cancel",
		sound = "close", onClick = function()
			decide(false)
		end,
	})
	UI.button({
		parent = row, text = o.confirmText or "Confirm", kind = o.danger and "danger" or "primary",
		size = UDim2.new(0.5, -5, 1, 0), position = UDim2.new(0.5, 5, 0, 0), name = "Confirm",
		sound = o.danger and "warning" or "success", onClick = function()
			decide(true)
		end,
	})
	scrim.Activated:Connect(function()
		decide(false)
	end)

	Sfx.play("open")
	Motion.tween(scrim, { BackgroundTransparency = 0.5 }, 0.18)
	Motion.tween(scale, { Scale = 1 }, 0.24, Enum.EasingStyle.Back)
	return true
end
end -- [06_ui_more.lua]

do -- [07_notify.lua]

----------------------------------------------------------------------------------------------------
-- Notify: success / warning / error / info toasts. The stack sits at the bottom centre (like an Android snackbar) so it never
-- covers the window's title-bar buttons. Newest goes on TOP of the stack, so entering never shifts the others; leaving
-- collapses the slot so the newer ones glide down. Repeats are merged.
----------------------------------------------------------------------------------------------------
Notify.layer = nil
Notify.items = {}
Notify.max = 4
Notify.width = 300
Notify.counter = 0

local TOAST = {
	success = { role = "Green", icon = "check", sound = "success", duration = 3.4 },
	warning = { role = "Warn", icon = "bang", sound = "warning", duration = 4.8 },
	error = { role = "Danger", icon = "close", sound = "error", duration = 5.6 },
	info = { role = "Info", icon = "info", sound = "select", duration = 3.4 },
}

function Notify.init(gui)
	Notify.destroy()
	local viewport = Env.viewport()
	Notify.width = Util.clamp(viewport.X - 28, 220, 320)
	local layer = Util.new("Frame", {
		Name = "Toasts", BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -14), Size = UDim2.fromOffset(Notify.width, 0),
		AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 200,
	}, gui)
	Util.new("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center,
	}, layer)
	Notify.layer = layer
end

local function removeItem(item)
	local index = Util.indexOf(Notify.items, item)
	if index then
		table.remove(Notify.items, index)
	end
end

local function dismiss(item, instant)
	if item.closing then
		return
	end
	item.closing = true
	removeItem(item)
	local wrapper, card = item.wrapper, item.card
	if not wrapper.Parent then
		return
	end
	local height = wrapper.AbsoluteSize.Y
	local function finish()
		wrapper:Destroy()
		UI.prune()
	end
	if instant or Motion.reduced then
		finish()
		return
	end
	wrapper.AutomaticSize = Enum.AutomaticSize.None
	wrapper.Size = UDim2.new(1, 0, 0, height)
	Motion.tween(card, { Position = UDim2.new(0, Notify.width + 40, 0, 0) }, 0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
	Motion.tween(wrapper, { Size = UDim2.new(1, 0, 0, 0) }, 0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.In, finish)
end

local function tick()
	local now = os.clock()
	local expired = {}
	for _, item in ipairs(Notify.items) do
		if not item.closing and now >= item.expires then
			expired[#expired + 1] = item
		end
	end
	for _, item in ipairs(expired) do
		dismiss(item)
	end
	if #Notify.items == 0 then
		Anim.remove("notify")
	end
end

local function startBar(item, duration)
	local bar = item.bar
	Motion.cancel(bar)
	bar.Size = UDim2.new(1, -28, 0, 2)
	Motion.tween(bar, { Size = UDim2.new(0, 0, 0, 2) }, duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
end

-- kind: "success" | "warning" | "error" | "info"
-- opts: duration (seconds), key (merge key), force (show even when notifications are switched off)
function Notify.push(kind, title, text, opts)
	local spec = TOAST[kind] or TOAST.info
	opts = opts or {}
	if not Notify.layer or not Notify.layer.Parent then
		return nil
	end
	if not Store.get("notifications") and not opts.force then
		return nil
	end
	title, text = tostring(title or ""), tostring(text or "")
	local key = opts.key or (kind .. "|" .. title .. "|" .. text)
	local duration = opts.duration or spec.duration

	for _, item in ipairs(Notify.items) do
		if item.key == key and not item.closing then
			item.count = item.count + 1
			item.badge.Text = "x" .. item.count
			item.badge.Visible = true
			item.expires = os.clock() + duration
			startBar(item, duration)
			if not Motion.reduced then
				Motion.tween(item.scale, { Scale = 1.04 }, 0.08, Enum.EasingStyle.Quad, nil, function()
					Motion.tween(item.scale, { Scale = 1 }, 0.2, Enum.EasingStyle.Back)
				end)
			end
			Sfx.play(spec.sound)
			return item
		end
	end

	Notify.counter = Notify.counter + 1
	local wrapper = Util.new("Frame", {
		Name = "Slot", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = -Notify.counter,
	}, Notify.layer)
	local card = Util.new("TextButton", {
		Name = "Toast", Text = "", AutoButtonColor = false, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.new(0, 0, 0, -44), ZIndex = 201,
	}, wrapper)
	Util.corner(card, 12)
	Theme.bind(card, "BackgroundColor3", "Elevated")
	Theme.bind(Util.stroke(card, nil, 1, 0.05), "Color", spec.role, "Border", 0.6)
	local scale = Util.new("UIScale", { Scale = 1 }, card)

	local accent = Util.new("Frame", {
		Name = "Accent", BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 7, 0.5, 0),
		Size = UDim2.new(0, 3, 1, -22), ZIndex = 202,
	}, card)
	Util.round_corner(accent)
	Theme.bind(accent, "BackgroundColor3", spec.role)

	local disc = Util.new("Frame", {
		Name = "Disc", BorderSizePixel = 0, Position = UDim2.fromOffset(18, 12), Size = UDim2.fromOffset(26, 26), ZIndex = 202,
	}, card)
	Util.round_corner(disc)
	Theme.bind(disc, "BackgroundColor3", "Card", spec.role, 0.28)
	UI.icon(spec.icon, disc, 16, spec.role, { anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 203 })

	local inner = Util.new("Frame", {
		Name = "Inner", BackgroundTransparency = 1, Position = UDim2.fromOffset(54, 0), Size = UDim2.new(1, -92, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 202,
	}, card)
	Util.pad(inner, 0, 11, 0, 14)
	Util.list(inner, 2)
	local heading = Util.new("TextLabel", {
		Name = "Title", BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, Text = title, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 203,
	}, inner)
	Typo.apply(heading, "heading", 13)
	Theme.bind(heading, "TextColor3", "Text")
	local body = Util.new("TextLabel", {
		Name = "Text", BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, Text = text, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top, Visible = text ~= "", ZIndex = 203,
	}, inner)
	Typo.apply(body, "caption", 12)
	Theme.bind(body, "TextColor3", "Muted")

	local badge = Util.new("TextLabel", {
		Name = "Count", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 10),
		Size = UDim2.fromOffset(34, 16), Text = "x2", TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 203,
	}, card)
	Typo.apply(badge, "label", 11)
	Theme.bind(badge, "TextColor3", spec.role)

	local bar = Util.new("Frame", {
		Name = "Timer", BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -5),
		Size = UDim2.new(1, -28, 0, 2), BackgroundTransparency = 0.35, ZIndex = 203,
	}, card)
	Util.round_corner(bar)
	Theme.bind(bar, "BackgroundColor3", spec.role)

	local item = {
		key = key, kind = kind, wrapper = wrapper, card = card, scale = scale, badge = badge, bar = bar,
		count = 1, expires = os.clock() + duration, closing = false,
	}
	Notify.items[#Notify.items + 1] = item
	card.Activated:Connect(function()
		dismiss(item)
	end)

	Motion.tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	startBar(item, duration)
	Sfx.play(spec.sound)
	Anim.add("notify", tick, 6)

	while #Notify.items > Notify.max do
		dismiss(Notify.items[1])
	end
	return item
end

function Notify.success(title, text, opts)
	return Notify.push("success", title, text, opts)
end
function Notify.warn(title, text, opts)
	return Notify.push("warning", title, text, opts)
end
function Notify.error(title, text, opts)
	return Notify.push("error", title, text, opts)
end
function Notify.info(title, text, opts)
	return Notify.push("info", title, text, opts)
end

function Notify.clear(instant)
	local snapshot = {}
	for i, item in ipairs(Notify.items) do
		snapshot[i] = item
	end
	for _, item in ipairs(snapshot) do
		dismiss(item, instant)
	end
end

function Notify.destroy()
	Anim.remove("notify")
	Notify.items = {}
	if Notify.layer then
		pcall(Notify.layer.Destroy, Notify.layer)
		Notify.layer = nil
	end
end
end -- [07_notify.lua]

do -- [08_background.lua]

----------------------------------------------------------------------------------------------------
-- Bg: panel background system.
--   solid     flat theme colour
--   aurora    two drifting theme gradients                (procedural, no assets)
--   sparkle   slowly rising glints                        (procedural, no assets)
--   image     one static image (asset id, rbxassetid, file in VirexHub/backgrounds, or image URL)
--   sheet     sprite-sheet animation (cols x rows grid in ONE image)    <- GIF-like
--   sequence  list of images shown one after another                    <- GIF-like
--   video     Roblox VideoFrame (experimental, needs a Roblox-hosted video asset or a local webm/mp4)
-- Roblox ImageLabels cannot play GIF files and arbitrary video URLs cannot be streamed, which is why the
-- GIF-like modes use sheets / sequences. A dark overlay and a minimum darkness keep text readable.
----------------------------------------------------------------------------------------------------
Bg.layer = nil
Bg.content = nil
Bg.overlay = nil
Bg.mode = "solid"
Bg.token = 0
Bg.status = { kind = "idle", text = "Solid colour background." }
Bg.listeners = {}
Bg.blur = nil
Bg.cacheNote = nil

local MEDIA_MODES = { image = true, sheet = true, sequence = true, video = true }
Bg.MODES = {
	{ id = "solid", label = "Solid" },
	{ id = "aurora", label = "Aurora" },
	{ id = "sparkle", label = "Sparkle" },
	{ id = "image", label = "Image" },
	{ id = "sheet", label = "Sprite sheet" },
	{ id = "sequence", label = "Image sequence" },
	{ id = "video", label = "Video (beta)" },
}

function Bg.onStatus(fn)
	Bg.listeners[#Bg.listeners + 1] = fn
	return function()
		local index = Util.indexOf(Bg.listeners, fn)
		if index then
			table.remove(Bg.listeners, index)
		end
	end
end

function Bg.setStatus(kind, text)
	Bg.status = { kind = kind, text = text }
	for _, fn in ipairs(Util.copy(Bg.listeners)) do
		Util.try("bg status listener", fn, kind, text)
	end
end

function Bg.animated()
	return not Store.get("reducedMotion") and not Store.get("lowPower")
end

function Bg.init(layer)
	Bg.layer = layer
	Theme.G.aurora2 = function(l)
		return ColorSequence.new({
			ColorSequenceKeypoint.new(0, Util.mix(l.Background, l.Accent2, 0.22)),
			ColorSequenceKeypoint.new(0.5, l.Background),
			ColorSequenceKeypoint.new(1, Util.mix(l.Background, l.Accent, 0.26)),
		})
	end
	Bg.content = Util.new("Frame", {
		Name = "BgContent", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 1,
	}, layer)
	Bg.overlay = Util.new("Frame", {
		Name = "BgOverlay", BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1, ZIndex = 2,
	}, layer)
	Util.corner(Bg.overlay, 16)
end

function Bg.clearContent()
	Anim.remove("bg")
	if Bg.content then
		for _, child in ipairs(Bg.content:GetChildren()) do
			child:Destroy()
		end
	end
	UI.prune()
end

function Bg.updateOverlay()
	if not Bg.overlay then
		return
	end
	local amount = 0
	if MEDIA_MODES[Bg.mode] then
		amount = math.max(Store.get("overlay"), 0.2) -- never let media make the UI unreadable
	end
	Motion.tween(Bg.overlay, { BackgroundTransparency = 1 - amount }, 0.25)
end

function Bg.setOverlay(value)
	Store.set("overlay", value)
	Bg.updateOverlay()
end

function Bg.setGlass(value)
	Store.set("glass", value)
	Theme.setGlass(value)
end

----------------------------------------------------------------------------------------------------
-- source resolution (yields when it has to download)
----------------------------------------------------------------------------------------------------
local function detectImageKind(bytes)
	if type(bytes) ~= "string" or #bytes < 12 then
		return nil
	end
	local b1, b2, b3, b4 = string.byte(bytes, 1, 4)
	if b1 == 0x89 and b2 == 0x50 and b3 == 0x4E and b4 == 0x47 then
		return "png"
	elseif b1 == 0xFF and b2 == 0xD8 and b3 == 0xFF then
		return "jpg"
	elseif string.sub(bytes, 1, 4) == "RIFF" and string.sub(bytes, 9, 12) == "WEBP" then
		return "webp"
	elseif string.sub(bytes, 1, 3) == "GIF" then
		return "gif"
	end
	return nil
end

local function robloxAssetFromUrl(text)
	local id = string.match(text, "roblox%.com/asset/?%?id=(%d+)") or string.match(text, "roblox%.com/library/(%d+)")
	if id then
		return "rbxassetid://" .. id
	end
	return nil
end

local GIF_HELP = "GIF files do not animate in Roblox. Convert it to a sprite sheet (one grid image) or an image sequence."

-- returns { ok = true, url = "rbxasset..." , note = "..." } or { ok = false, reason = "..." }
function Bg.resolve(text, wantVideo)
	text = Util.trim(text)
	if text == "" then
		return { ok = false, reason = "Enter an asset ID, file name or image link first." }
	end
	if string.match(text, "^%d+$") then
		return { ok = true, url = "rbxassetid://" .. text, note = "Roblox asset ID" }
	end
	if string.match(text, "^rbxassetid://%d+$") or string.match(text, "^rbxthumb://") or string.match(text, "^rbxasset://") then
		return { ok = true, url = text, note = "Roblox asset" }
	end
	local lower = string.lower(text)
	if string.match(lower, "^https?://") then
		local asset = robloxAssetFromUrl(lower)
		if asset then
			return { ok = true, url = asset, note = "Roblox asset link" }
		end
		if wantVideo then
			return { ok = false, reason = "Video links cannot be streamed. Use a Roblox video asset ID or a local .webm/.mp4 file." }
		end
		if not Env.canDownload() or not Env.filesWork() then
			return { ok = false, reason = "Image links need working executor file + HTTP support, which was not available here. Use a Roblox asset ID instead." }
		end
		if string.match(lower, "%.gif[%?#]?") or string.match(lower, "%.gif$") then
			return { ok = false, reason = GIF_HELP }
		end
		-- a previous download of the same link is reused instead of downloading it again
		for _, ext in ipairs({ "png", "jpg", "webp" }) do
			local cached = CONFIG.CacheFolder .. "/bg_" .. Util.hash(text) .. "." .. ext
			if Env.fileExists(cached) then
				local cachedAsset = Env.customAsset(cached)
				if cachedAsset then
					return { ok = true, url = cachedAsset, note = "cached " .. string.upper(ext) }
				end
			end
		end
		Bg.setStatus("loading", "Downloading image...")
		local body, err = Env.httpGet(text)
		if not body then
			return { ok = false, reason = "Download failed (" .. tostring(err) .. ")." }
		end
		if #body > 12 * 1024 * 1024 then
			return { ok = false, reason = "That image is larger than 12 MB." }
		end
		local kind = detectImageKind(body)
		if kind == "gif" then
			return { ok = false, reason = GIF_HELP }
		elseif not kind then
			return { ok = false, reason = "The link did not return a PNG, JPG or WEBP image." }
		end
		Env.ensureFolder(CONFIG.Folder)
		Env.ensureFolder(CONFIG.CacheFolder)
		local path = CONFIG.CacheFolder .. "/bg_" .. Util.hash(text) .. "." .. kind
		local wrote, writeErr = Env.writeFile(path, body)
		if not wrote then
			return { ok = false, reason = "Could not save the download (" .. tostring(writeErr) .. ")." }
		end
		local asset, assetErr = Env.customAsset(path)
		if not asset then
			return { ok = false, reason = "This executor could not turn the file into an asset (" .. tostring(assetErr) .. ")." }
		end
		return { ok = true, url = asset, note = "downloaded " .. kind:upper() }
	end

	-- a file name / relative path inside the executor workspace
	if not Env.canCustomAsset() then
		return { ok = false, reason = "Local files need executor file + custom-asset support, which was not detected." }
	end
	if not Env.filesWork() then
		return { ok = false, reason = "This executor blocked file access, so local files cannot be used. Roblox asset IDs still work." }
	end
	local candidates = { text, CONFIG.BackgroundFolder .. "/" .. text }
	for _, path in ipairs(candidates) do
		if Env.fileExists(path) then
			local data = Env.readFile(path)
			if wantVideo then
				if not (string.match(lower, "%.webm$") or string.match(lower, "%.mp4$")) then
					return { ok = false, reason = "Video files must be .webm or .mp4." }
				end
			else
				local kind = detectImageKind(data)
				if kind == "gif" then
					return { ok = false, reason = GIF_HELP }
				elseif not kind then
					return { ok = false, reason = "'" .. text .. "' is not a PNG, JPG or WEBP image." }
				end
			end
			local asset, assetErr = Env.customAsset(path)
			if not asset then
				return { ok = false, reason = "This executor could not load that file as an asset (" .. tostring(assetErr) .. ")." }
			end
			return { ok = true, url = asset, note = "local file" }
		end
	end
	return { ok = false, reason = "File not found. Put it in the executor workspace folder '" .. CONFIG.BackgroundFolder .. "'." }
end

-- waits (yields) until an ImageLabel's image is fetched or the timeout passes
function Bg.verifyImage(label, timeout)
	if not ContentProvider then
		return true, "unverified"
	end
	local succeeded, finished = false, false
	task.spawn(function()
		local ok = pcall(ContentProvider.PreloadAsync, ContentProvider, { label }, function(_, status)
			if tostring(status) == "Enum.AssetFetchStatus.Success" then
				succeeded = true
			end
		end)
		if not ok then
			succeeded = true -- preloading unsupported: let Roblox stream it
		end
		finished = true
	end)
	local started = os.clock()
	while not finished and os.clock() - started < (timeout or 8) do
		task.wait(0.05)
	end
	if succeeded then
		return true
	end
	local okLoaded, loaded = pcall(function()
		return label.IsLoaded
	end)
	if okLoaded and loaded then
		return true
	end
	return false
end

----------------------------------------------------------------------------------------------------
-- procedural modes
----------------------------------------------------------------------------------------------------
local function gate()
	return Theme.active()
end

function Bg.buildAurora()
	local layers = {}
	local specs = { { builder = Theme.G.aurora, transparency = 0, speed = 5 }, { builder = Theme.G.aurora2, transparency = 0.45, speed = -7 } }
	for i, spec in ipairs(specs) do
		local frame = Util.new("Frame", {
			Name = "Aurora" .. i, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = spec.transparency, ZIndex = i,
		}, Bg.content)
		Util.corner(frame, 16)
		local gradient = Util.new("UIGradient", { Rotation = i == 1 and 25 or 140 }, frame)
		Theme.gradient(gradient, spec.builder)
		layers[i] = { gradient = gradient, speed = spec.speed, base = i == 1 and 25 or 140 }
	end
	if Bg.animated() then
		Anim.add("bg", function(_, now)
			for i, layer in ipairs(layers) do
				layer.gradient.Rotation = (layer.base + now * layer.speed) % 360
				layer.gradient.Offset = Vector2.new(0.22 * math.sin(now * 0.31 + i), 0.22 * math.cos(now * 0.23 + i * 2))
			end
		end, 20, gate)
	end
	Bg.setStatus("ok", "Aurora - animated theme gradient.")
end

function Bg.buildSparkle()
	local count = Bg.animated() and 24 or 12
	local particles = {}
	local seed = 17
	local function rand()
		seed = (seed * 1103515245 + 12345) % 2147483648
		return seed / 2147483648
	end
	for i = 1, count do
		local size = 2 + math.floor(rand() * 3)
		local dot = Util.new("Frame", {
			Name = "Glint" .. i, BorderSizePixel = 0, Size = UDim2.fromOffset(size, size), AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 0.6, ZIndex = 1, Position = UDim2.fromScale(0.04 + rand() * 0.92, 0.05 + rand() * 0.9),
		}, Bg.content)
		Util.round_corner(dot)
		Theme.bind(dot, "BackgroundColor3", "Shine")
		particles[i] = { dot = dot, x = 0.04 + rand() * 0.92, y = rand(), speed = 0.012 + rand() * 0.02, tw = 0.8 + rand() * 1.6, ph = rand() * 6.28 }
	end
	if Bg.animated() then
		Anim.add("bg", function(_, now)
			for _, p in ipairs(particles) do
				local y = (p.y - p.speed * now) % 1
				p.dot.Position = UDim2.fromScale(p.x, 0.04 + y * 0.92)
				p.dot.BackgroundTransparency = 0.45 + 0.5 * (0.5 + 0.5 * math.sin(now * p.tw + p.ph))
			end
		end, 20, gate)
	end
	Bg.setStatus("ok", "Sparkle - slow rising glints.")
end

----------------------------------------------------------------------------------------------------
-- media modes
----------------------------------------------------------------------------------------------------
local function fail(token, message)
	if token == Bg.token then
		Bg.clearContent()
		Bg.setStatus("error", message)
	end
end

function Bg.buildImage(token)
	local source = Store.get("bgImage")
	if source == "" then
		Bg.setStatus("idle", "No image yet - enter an asset ID, file name or link, then press Apply.")
		return
	end
	Bg.setStatus("loading", "Loading image...")
	local result = Bg.resolve(source, false)
	if token ~= Bg.token then
		return
	end
	if not result.ok then
		return fail(token, result.reason)
	end
	local image = Util.new("ImageLabel", {
		Name = "BgImage", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop,
		Image = result.url, ImageTransparency = 1, ZIndex = 1,
	}, Bg.content)
	Util.corner(image, 16)
	local ok = Bg.verifyImage(image, 9)
	if token ~= Bg.token or not image.Parent then
		return
	end
	if not ok then
		return fail(token, "The image could not be loaded. Check the ID (use the Image asset ID, not a Decal ID) and that the asset is public.")
	end
	Motion.tween(image, { ImageTransparency = 0 }, 0.5)
	Bg.setStatus("ok", "Image loaded (" .. tostring(result.note) .. ").")
end

local function splitList(text)
	local items = {}
	local normalized = string.gsub(text, "[\r\n;]", ",") -- gsub returns (string, count): keep only the string
	for _, piece in ipairs(Util.split(normalized, ",")) do
		piece = Util.trim(piece)
		if piece ~= "" then
			items[#items + 1] = piece
		end
	end
	return items
end

function Bg.buildSheet(token)
	local source = Store.get("bgImage")
	if source == "" then
		Bg.setStatus("idle", "Enter the sprite-sheet image first (asset ID or file), then set columns, rows and speed.")
		return
	end
	Bg.setStatus("loading", "Loading sprite sheet...")
	local result = Bg.resolve(source, false)
	if token ~= Bg.token then
		return
	end
	if not result.ok then
		return fail(token, result.reason)
	end
	local cols, rows, fps = Store.get("bgCols"), Store.get("bgRows"), Store.get("bgFps")
	local clip = Util.new("Frame", {
		Name = "SheetClip", BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 1,
	}, Bg.content)
	local sheet = Util.new("ImageLabel", {
		Name = "Sheet", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(cols, rows),
		Position = UDim2.fromScale(0, 0), ScaleType = Enum.ScaleType.Stretch, Image = result.url, ZIndex = 1,
	}, clip)
	local ok = Bg.verifyImage(sheet, 9)
	if token ~= Bg.token or not sheet.Parent then
		return
	end
	if not ok then
		return fail(token, "The sprite sheet could not be loaded. Check the asset ID or file name.")
	end
	local total = cols * rows
	local last = -1
	local function show(index)
		if index == last then
			return
		end
		last = index
		local col, row = index % cols, math.floor(index / cols)
		sheet.Position = UDim2.fromScale(-col, -row)
	end
	show(0)
	if Bg.animated() and total > 1 then
		Anim.add("bg", function(_, now)
			show(math.floor(now * fps) % total)
		end, math.min(fps, 24), gate)
	end
	Bg.setStatus("ok", string.format("Sprite sheet %dx%d at %d fps%s.", cols, rows, fps, Bg.animated() and "" or " (paused: reduced motion / low power)"))
end

function Bg.buildSequence(token)
	local list = splitList(Store.get("bgSequence"))
	if #list == 0 then
		Bg.setStatus("idle", "Enter 2 or more image IDs or file names separated by commas.")
		return
	end
	if #list > 24 then
		list = { table.unpack(list, 1, 24) }
	end
	Bg.setStatus("loading", "Loading frames (0/" .. #list .. ")...")
	local frames, loaded = {}, 0
	for i, entry in ipairs(list) do
		local result = Bg.resolve(entry, false)
		if token ~= Bg.token then
			return
		end
		if not result.ok then
			return fail(token, "Frame " .. i .. ": " .. result.reason)
		end
		local frame = Util.new("ImageLabel", {
			Name = "Frame" .. i, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
			ScaleType = Enum.ScaleType.Crop, Image = result.url, Visible = i == 1, ZIndex = 1,
		}, Bg.content)
		Util.corner(frame, 16)
		frames[i] = frame
	end
	for i, frame in ipairs(frames) do
		if not Bg.verifyImage(frame, 8) then
			return fail(token, "Frame " .. i .. " could not be loaded.")
		end
		if token ~= Bg.token then
			return
		end
		loaded = loaded + 1
		Bg.setStatus("loading", "Loading frames (" .. loaded .. "/" .. #frames .. ")...")
	end
	local fps = Store.get("bgFps")
	local current = 1
	if Bg.animated() and #frames > 1 then
		Anim.add("bg", function(_, now)
			local index = (math.floor(now * fps) % #frames) + 1
			if index ~= current then
				frames[current].Visible = false
				frames[index].Visible = true
				current = index
			end
		end, math.min(fps, 24), gate)
	end
	Bg.setStatus("ok", string.format("Image sequence: %d frames at %d fps%s.", #frames, fps, Bg.animated() and "" or " (paused: reduced motion / low power)"))
end

function Bg.buildVideo(token)
	local source = Store.get("bgVideo")
	if source == "" then
		Bg.setStatus("idle", "Enter a Roblox video asset ID or a local .webm / .mp4 file name.")
		return
	end
	local created, video = pcall(Instance.new, "VideoFrame")
	if not created then
		return fail(token, "VideoFrame is not available in this Roblox client.")
	end
	Bg.setStatus("loading", "Loading video...")
	local result = Bg.resolve(source, true)
	if token ~= Bg.token then
		video:Destroy()
		return
	end
	if not result.ok then
		video:Destroy()
		return fail(token, result.reason)
	end
	local okProps = pcall(function()
		video.Name = "BgVideo"
		video.BackgroundTransparency = 1
		video.BorderSizePixel = 0
		video.Size = UDim2.fromScale(1, 1)
		video.Looped = true
		video.Volume = 0
		video.Video = result.url
		video.ZIndex = 1
		video.Parent = Bg.content
	end)
	if not okProps then
		video:Destroy()
		return fail(token, "This client rejected the video settings.")
	end
	local started, ready = os.clock(), false
	while os.clock() - started < 12 and token == Bg.token and video.Parent do
		local okLoaded, isLoaded = pcall(function()
			return video.IsLoaded
		end)
		if okLoaded and isLoaded then
			ready = true
			break
		end
		task.wait(0.1)
	end
	if token ~= Bg.token or not video.Parent then
		return
	end
	if not ready then
		return fail(token, "The video did not load in time. It must be a Roblox-hosted video asset (or a valid local webm/mp4).")
	end
	pcall(function()
		video.Playing = Bg.animated()
	end)
	Bg.setStatus("ok", "Video playing (experimental)." .. (Bg.animated() and "" or " Paused: reduced motion / low power."))
end

----------------------------------------------------------------------------------------------------
-- apply / public setters
----------------------------------------------------------------------------------------------------
function Bg.apply()
	if not Bg.content then
		return
	end
	Bg.token = Bg.token + 1
	local token = Bg.token
	Bg.clearContent()
	Bg.mode = Store.get("bgMode")
	if Bg.mode == "solid" then
		Bg.setStatus("idle", "Solid colour background.")
	elseif Bg.mode == "aurora" then
		Bg.buildAurora()
	elseif Bg.mode == "sparkle" then
		Bg.buildSparkle()
	elseif Bg.mode == "image" then
		task.spawn(Bg.buildImage, token)
	elseif Bg.mode == "sheet" then
		task.spawn(Bg.buildSheet, token)
	elseif Bg.mode == "sequence" then
		task.spawn(Bg.buildSequence, token)
	elseif Bg.mode == "video" then
		task.spawn(Bg.buildVideo, token)
	end
	Bg.updateOverlay()
end

function Bg.setMode(mode)
	if Store.set("bgMode", mode) then
		Bg.apply()
	end
end

-- Saves the text for a media mode and applies it. The new value is only kept when it really loads;
-- otherwise the previous background is restored. onResult(ok, message) reports the outcome.
function Bg.useSource(mode, text, onResult)
	text = Util.trim(text)
	local key = (mode == "sequence") and "bgSequence" or (mode == "video") and "bgVideo" or "bgImage"
	local previousValue, previousMode = Store.get(key), Store.get("bgMode")
	Store.set(key, text, true)
	Store.set("bgMode", mode, true)
	Bg.apply()
	local token = Bg.token
	task.spawn(function()
		local waited = 0
		while Bg.status.kind == "loading" and token == Bg.token and waited < 45 do
			task.wait(0.1)
			waited = waited + 0.1
		end
		if token ~= Bg.token then
			if onResult then
				onResult(nil, "A newer background change replaced this one.")
			end
			return
		end
		if Bg.status.kind == "ok" then
			if onResult then
				onResult(true, Bg.status.text)
			end
		else
			local message = Bg.status.text
			Store.set(key, previousValue, true)
			Store.set("bgMode", previousMode, true)
			Bg.apply()
			if onResult then
				onResult(false, message)
			end
		end
	end)
end

function Bg.syncBlur()
	local wanted = Store.get("blur") and Win.visible and not Win.minimized
	if wanted and not Bg.blur then
		local parent = Lighting or workspace.CurrentCamera
		if not parent then
			return
		end
		local ok, effect = pcall(function()
			return Util.new("BlurEffect", { Name = "VirexHubBlur", Size = 0 }, parent)
		end)
		if ok then
			Bg.blur = effect
		end
	end
	if Bg.blur then
		if wanted then
			Motion.tween(Bg.blur, { Size = 14 }, 0.35)
		else
			local effect = Bg.blur
			if not Store.get("blur") then
				Bg.blur = nil
			end
			Motion.tween(effect, { Size = 0 }, 0.25, nil, nil, function()
				if not Bg.blur then
					pcall(effect.Destroy, effect)
				end
			end)
		end
	end
end

function Bg.destroy()
	Anim.remove("bg")
	Bg.token = Bg.token + 1
	if Bg.blur then
		pcall(Bg.blur.Destroy, Bg.blur)
		Bg.blur = nil
	end
	Bg.layer, Bg.content, Bg.overlay = nil, nil, nil
	Bg.listeners = {}
end
end -- [08_background.lua]

do -- [09_splash.lua]

----------------------------------------------------------------------------------------------------
-- Splash: the animated VYRE loading screen and the loading sound (from the 2.2.0 loading-screen build).
--
--   * The intro is a pure function of time (Splash.draw) driven by ONE Anim job ("splash"), so it can
--     be skipped at any moment (Motion.reduced, failures, the watchdog) by drawing its final state.
--   * NOTHING here closes the screen or opens the hub by itself. The floating logo appears when the user taps
--     the capsule / hint once it says so. Splash.ready only records "boot finished".
--   * HONESTY RULE (unchanged): the thin progress line moves only when a real boot step finished.
--   * FAILURE POLICY: if the animated screen cannot be built, a plain one is built; if that fails too,
--     App.boot opens the hub directly. A failing animation frame can never block the "tap" state.
--   * Everything is stored in the Splash table (no new top-level locals: Luau 200-local / 60-upvalue limits).
----------------------------------------------------------------------------------------------------
Splash.gui = nil
Splash.isOpen = false
Splash.closing = false
Splash.createdAt = 0
Splash.fraction = 0
Splash.parts = {}
Splash.handoff = nil      -- App.boot's handoff(): shows the floating logo the first time
Splash.onClosed = nil
Splash.soundState = { id = "", source = "none", note = "" }
Splash.pick = { done = true, id = "", sound = nil, tried = 0, length = 0 } -- the rbxassetid chosen in the background

-- design units; the whole holder is scaled to fit the screen (same idea as the old "fit")
Splash.L = {
	W = 460, H = 420, cx = 230,
	disc = 232, discY = 126, ringK = 0.72, logo = 132,
	titleY = 256, titleSize = 100, titleScale = 1.22, slot = 66, drop = 290,
	capY = 316, capW = 372, capH = 46, capMin = 46, chipW = 60, chipH = 30,
	captionY = 370, lineY = 396, lineW = 236, detailY = 404,
}
Splash.FINAL = 1e6        -- "time" that draws the finished intro

local function snapshotFade(root)
	local list = {}
	local function add(obj, prop)
		list[#list + 1] = { obj = obj, prop = prop, rest = obj[prop] }
	end
	local function visit(obj)
		if obj:IsA("GuiObject") then
			add(obj, "BackgroundTransparency")
			if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
				add(obj, "TextTransparency")
			end
			if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
				add(obj, "ImageTransparency")
			end
		elseif obj:IsA("UIStroke") then
			add(obj, "Transparency")
		end
	end
	visit(root)
	for _, descendant in ipairs(root:GetDescendants()) do
		visit(descendant)
	end
	return list
end

local function fadeTo(list, hidden, duration, style)
	for _, entry in ipairs(list) do
		Motion.tween(entry.obj, { [entry.prop] = hidden and 1 or entry.rest }, duration, style or Enum.EasingStyle.Quad)
	end
end

local function setStatusText(label, text)
	if label.Text == text then
		return
	end
	label.Text = text
	if Splash.parts.drawn and not Motion.reduced then
		label.TextTransparency = 0.7
		Motion.tween(label, { TextTransparency = 0 }, 0.3)
	end
end

----------------------------------------------------------------------------------------------------
-- loading sound: the source is chosen BEFORE Sfx.init so the normal preload / status code sees it
----------------------------------------------------------------------------------------------------
function Splash.looksLikeMp3(body)
	if type(body) ~= "string" or #body < 2048 then
		return false
	end
	if string.sub(body, 1, 3) == "ID3" then
		return true
	end
	local first, second = string.byte(body, 1, 2)
	return first == 255 and second ~= nil and second >= 224
end

-- one bounded download of CONFIG.Splash.SoundUrl into `path`. Returns true when a valid file was written.
function Splash.downloadSound(url, path)
	local job = { done = false, ok = false }
	task.spawn(function()
		pcall(function()
			local result = Env.fetch(url, "request")
			if result and result.ok and Splash.looksLikeMp3(result.body) then
				local folder = string.match(path, "^(.*)/[^/]*$")
				if folder and folder ~= "" then
					Env.ensureFolder(folder)
				end
				job.ok = Env.writeFile(path, result.body) == true
			end
		end)
		job.done = true
	end)
	local limit = tonumber(CONFIG.Splash.SoundDownloadSeconds) or 6
	local started = os.clock()
	while not job.done and os.clock() - started < limit do
		task.wait(0.05)
	end
	return job.done and job.ok
end

-- Source order: 1) local file via getcustomasset  2) CONFIG.Splash.SoundUrl, downloaded once to that file
-- 3) the rbxassetid candidates (SoundAssetId, then SoundAssetIds from a random place in the list): they are tested
-- ONE BY ONE in a background job (Splash.pickMusic) so start-up is never delayed  4) silent. It never throws and never
-- prints an error. A file / download fills CONFIG.Sounds.loading.id so Sfx.init / Sfx.preload / Sound status treat it
-- like every other sound; the rbxassetid list leaves it empty and is played straight from Splash.pick.
function Splash.resolveSound()
	local def = CONFIG.Sounds.loading
	local cfg = CONFIG.Splash
	local state = { id = "", source = "none", note = "" }
	Splash.soundState = state
	if type(def) ~= "table" then
		return state.id, state.source
	end
	local resolved, problem = pcall(function()
		local path = cfg.SoundFile
		if type(path) == "string" and path ~= "" and Env.canCustomAsset() then
			local folder = string.match(path, "^(.*)/[^/]*$")
			if folder and folder ~= "" then
				Env.ensureFolder(folder) -- so the folder exists for the user to drop the file into
			end
			local function useFile()
				local asset, why = Env.customAsset(path)
				if asset then
					state.id, state.source = asset, "file"
				else
					state.note = "getcustomasset failed: " .. tostring(why)
				end
			end
			local data = Env.readFile(path)
			local haveFile = data ~= nil and Splash.looksLikeMp3(data)
			if haveFile then
				useFile()
			end
			if not haveFile and type(cfg.SoundUrl) == "string" and cfg.SoundUrl ~= "" and Env.canFetch() then
				if Splash.downloadSound(cfg.SoundUrl, path) then
					useFile()
				else
					state.note = "download failed"
				end
			end
		end
	end)
	if not resolved then
		state.note = "unexpected: " .. tostring(problem)
	end
	if state.id == "" then
		local pool, seen = {}, {}
		local function add(asset)
			if type(asset) == "number" then
				asset = tostring(asset)
			end
			if type(asset) ~= "string" or asset == "" then
				return
			end
			if string.find(asset, "^%d+$") then
				asset = "rbxassetid://" .. asset
			end
			if not seen[asset] then
				seen[asset] = true
				pool[#pool + 1] = asset
			end
		end
		add(cfg.SoundAssetId)
		local list = cfg.SoundAssetIds
		if type(list) == "table" and #list > 0 then
			local first = math.random(1, #list) -- a different track can start each launch
			for step = 0, #list - 1 do
				add(list[((first - 1 + step) % #list) + 1])
			end
		end
		if #pool > 0 then
			state.source, state.pool = "assetlist", pool
			Splash.pick = { done = false, id = "", sound = nil, tried = 0, length = 0 }
			task.spawn(Splash.pickMusic) -- background: never delays start-up
		end
	end
	def.id = state.id
	Util.log("info", "loading sound source: " .. state.source .. (state.pool and (" (" .. #state.pool .. " candidates)") or "") .. (state.note ~= "" and (" (" .. state.note .. ")") or ""))
	return state.id, state.source
end

-- An rbxassetid Sound that was picked but never started (music off, volume 0, screen closed early) must not stay
-- behind in SoundService. A Sound that is playing lives in Sfx.holder and is removed by its handle's Stop instead.
function Splash.dropPick()
	local sound = Splash.pick.sound
	Splash.pick.sound = nil
	if sound and (not Sfx.holder or sound.Parent ~= Sfx.holder) then
		pcall(sound.Destroy, sound)
	end
end

-- Background job (started by resolveSound; it never blocks start-up). Tries the rbxassetid candidates ONE BY ONE, so in
-- the usual case only a single audio file is downloaded, and keeps the first one Roblox really loads on this device.
-- Private, deleted or blocked audio fails the preload and is skipped. Result: Splash.pick.sound / .id, or nothing.
function Splash.pickMusic()
	local pick, state, cfg = Splash.pick, Splash.soundState, CONFIG.Splash
	local pool = state.pool or {}
	local checkSeconds = tonumber(cfg.MusicCheckSeconds) or 6
	local maxTries = tonumber(cfg.MusicMaxTries) or 8
	if not ContentProvider then
		pick.done = true
		state.note = "audio preload is not available"
		return
	end
	local tried = 0
	for index, asset in ipairs(pool) do
		if tried >= maxTries or App.destroyed or Splash.closing then
			break
		end
		tried = tried + 1
		pick.tried = tried
		local created, sound = pcall(Util.new, "Sound", { Name = "VirexHubMusicTest", SoundId = asset, Volume = 0 }, SoundService)
		if created and sound then
			local job = { done = false, success = false }
			task.spawn(function()
				local okPreload = pcall(ContentProvider.PreloadAsync, ContentProvider, { sound }, function(_, status)
					job.success = tostring(status) == "Enum.AssetFetchStatus.Success"
				end)
				if not okPreload then
					job.success = false
				end
				job.done = true
			end)
			local started = os.clock()
			while not job.done and os.clock() - started < checkSeconds do
				task.wait(0.05)
			end
			local length, loaded = 0, false
			pcall(function()
				length, loaded = sound.TimeLength, sound.IsLoaded
			end)
			if job.success and (length >= 2 or loaded) then
				pick.sound, pick.id, pick.length, pick.done = sound, asset, length, true
				if Splash.closing or App.destroyed then
					Splash.dropPick() -- the screen was closed while this was loading
					return
				end
				Util.log("info", string.format("loading music: %s loaded (candidate %d of %d, %d s)", asset, index, #pool, math.floor(length)))
				return
			end
			pcall(sound.Destroy, sound)
		end
		Util.log("info", "loading music: candidate not available: " .. tostring(asset))
	end
	pick.done = true
	state.note = "none of the " .. tried .. " rbxassetid candidates that were tried could be loaded"
	Util.log("warn", "loading music: " .. state.note)
end

-- Starts the loading music (it loops while the loading screen is up unless CONFIG.Splash.MusicLoop is false).
-- Returns a handle with Stop(fadeSeconds), like Sfx.playTracked. It does not use Sfx.play / Sfx.playTracked because
-- those cut long sounds after 0.9 s unless maxSeconds is set, and a clone is destroyed after ~2 s when the sound's
-- length is still unknown (not preloaded yet).
function Splash.playMusic()
	local handle = { clone = nil, stopped = false }
	function handle.Stop(fadeSeconds)
		handle.stopped = true
		local clone = handle.clone
		handle.clone = nil
		if clone and clone.Parent then
			local fade = fadeSeconds or 0.45
			Motion.tween(clone, { Volume = 0 }, fade, Enum.EasingStyle.Quad)
			task.delay(fade + 0.05, function()
				pcall(clone.Destroy, clone)
			end)
		end
	end
	local def = CONFIG.Sounds.loading
	if type(def) ~= "table" or not Sfx.holder then
		return handle
	end
	if not (Store.get("splashSound") and Store.get("sound")) then
		return handle
	end
	local master = Store.get("volume")
	if master <= 0.001 then
		return handle
	end
	local volume = Util.clamp((def.volume or 0.45) * master * 1.5, 0, 1)
	local loop = CONFIG.Splash.MusicLoop ~= false

	-- starts a Sound that is not playing yet and hands it to the handle
	local function start(sound, fadeIn)
		local ok, problem = pcall(function()
			sound.Volume = fadeIn and 0 or volume
			sound.PlaybackSpeed = def.speed or 1
			sound.Looped = loop
			sound.Parent = Sfx.holder
			sound:Play()
		end)
		if not ok then
			Util.log("warn", "loading sound could not start: " .. tostring(problem))
			pcall(sound.Destroy, sound)
			return
		end
		if fadeIn then
			Motion.tween(sound, { Volume = volume }, 0.9, Enum.EasingStyle.Quad)
		end
		handle.clone = sound
		Sfx.tracked[#Sfx.tracked + 1] = sound
		if not loop then
			pcall(function()
				sound.Ended:Connect(function()
					pcall(sound.Destroy, sound)
				end)
			end)
		end
		task.delay(loop and 1800 or 90, function() -- safety net only; the screen closing normally stops it long before
			pcall(sound.Destroy, sound)
		end)
	end

	-- the rbxassetid list: the track is chosen in the background (Splash.pickMusic); wait for it if it is not ready yet
	if Splash.soundState.source == "assetlist" then
		local pick = Splash.pick
		task.spawn(function()
			local waited = 0
			while not pick.done and waited < 25 and not handle.stopped and not Splash.closing do
				task.wait(0.1)
				waited = waited + 0.1
			end
			if handle.stopped or Splash.closing or not Splash.isOpen or not Sfx.holder or not pick.sound then
				return
			end
			start(pick.sound, true)
		end)
		return handle
	end

	-- a local file / download: played through its preloaded Sfx record
	if type(def.id) ~= "string" or def.id == "" then
		return handle
	end
	local record = Sfx.records[def.id]
	if not record or record.status == "failed" then
		return handle
	end
	local ok, copy = pcall(function()
		return record.sound:Clone()
	end)
	if not ok or not copy then
		Util.log("warn", "loading sound could not start: " .. tostring(copy))
		return handle
	end
	start(copy, false)
	return handle
end

-- Called by the intro at the first letter drop (or at once with reduced motion). Plays at most once.
function Splash.startMusic()
	local parts = Splash.parts
	if parts.musicStarted or parts.failed or Splash.closing or not Splash.isOpen then
		return
	end
	parts.musicStarted = true
	local ok, handle = pcall(Splash.playMusic)
	if ok then
		parts.music = handle
	else
		Util.log("warn", "loading sound: " .. tostring(handle))
	end
end

----------------------------------------------------------------------------------------------------
-- small helpers
----------------------------------------------------------------------------------------------------
function Splash.font(name, fallback)
	local ok, value = pcall(function()
		return Enum.Font[name]
	end)
	if ok and value then
		return value
	end
	return fallback
end

-- largest text size (<= maxSize) at which `text` fits `width` (Gotham-like capitals average ~0.66 em)
function Splash.fitSize(text, width, maxSize)
	local count = math.max(#tostring(text), 1)
	return Util.clamp(math.floor(width / (count * 0.66)), 9, maxSize)
end

-- splits a string into UTF-8 characters
function Splash.chars(text)
	local list = {}
	for ch in string.gmatch(tostring(text or ""), utf8.charpattern) do
		list[#list + 1] = ch
	end
	return list
end

-- when everything happens (seconds after the intro started)
function Splash.plan()
	local cfg = CONFIG.Splash
	local stagger = tonumber(cfg.DropStagger) or 0.14
	local speed = tonumber(cfg.TypeSpeed) or 0.045
	local letters = math.max(#Splash.chars(cfg.Brand), 1)
	local tl = { pop = 0.4, dropStart = 0.34, dropDur = 0.62, stagger = stagger, speed = speed, pulseDur = 0.45, capDur = 0.45, chipDur = 0.32 }
	tl.lastLand = tl.dropStart + (letters - 1) * stagger + tl.dropDur * 0.5
	tl.capStart = tl.lastLand + 0.22
	tl.typeStart = tl.capStart + tl.capDur + 0.05
	tl.typeEnd = tl.typeStart + #Splash.chars(cfg.TypeText) * speed
	tl.chipStart = tl.typeEnd + 0.12
	tl.reveal = tl.chipStart + 0.1
	tl.done = tl.chipStart + tl.chipDur + 0.1
	return tl
end

-- Pose of one title letter. u = 0..1 over its whole drop; dir = +1 / -1 (which way it tilts).
-- Returns y offset in px (negative = above its place), rotation in degrees, scale (tiny squash on landing).
function Splash.dropPose(u, dir)
	if u >= 1 then
		return 0, 0, 1
	end
	local fall = 0.5
	if u < fall then
		local s = u / fall
		return -Splash.L.drop * (1 - s * s), dir * 16 * (1 - s), 1
	end
	local s = (u - fall) / (1 - fall)
	local y = -16 * (1 - s) * (1 - s) * math.abs(math.sin(s * math.pi * 2))
	local rot = dir * 5 * (1 - s) * (1 - s) * math.sin(s * math.pi * 3)
	local k = 1
	if s < 0.22 then
		k = 1 - 0.12 * math.sin(math.pi * (s / 0.22))
	elseif s < 0.52 then
		k = 1 + 0.05 * math.sin(math.pi * ((s - 0.22) / 0.3))
	end
	return y, rot, k
end

----------------------------------------------------------------------------------------------------
-- building the screen
----------------------------------------------------------------------------------------------------
-- disc, ring, logo, title letters and the capsule. Everything starts in its "t = 0" look.
function Splash.buildArt(holder, parts)
	local L = Splash.L
	local cfg = CONFIG.Splash
	local art = {}
	parts.art = art
	local white = Color3.new(1, 1, 1)

	local discHolder = Util.new("Frame", {
		Name = "Disc", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(L.cx, L.discY),
		Size = UDim2.fromOffset(L.disc, L.disc), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 3,
	}, holder)
	art.discScale = Util.new("UIScale", { Scale = 0.001 }, discHolder)
	-- two out-of-phase black ellipses; their union is the wobbly edge
	local function blob(name, rotation)
		local frame = Util.new("Frame", {
			Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
			BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(6, 6, 8), Rotation = rotation, ZIndex = 1,
		}, discHolder)
		Util.round_corner(frame)
		Util.new("UIGradient", {
			Rotation = 40, Color = ColorSequence.new(Color3.fromRGB(28, 28, 34), Color3.fromRGB(3, 3, 4)),
		}, frame)
		return frame
	end
	art.blobA, art.blobB = blob("EdgeA", 0), blob("EdgeB", 45)

	local ringSize = math.floor(L.disc * L.ringK)
	local ring = Util.new("Frame", {
		Name = "Ring", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(ringSize, ringSize), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 3,
	}, discHolder)
	Util.round_corner(ring)
	art.ringStroke = Util.new("UIStroke", { Color = white, Thickness = 2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, ring)
	art.ringGradient = Util.new("UIGradient", {
		Rotation = 0,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.55, 0.1), NumberSequenceKeypoint.new(0.72, 0.85),
			NumberSequenceKeypoint.new(0.88, 0.1), NumberSequenceKeypoint.new(1, 0),
		}),
	}, art.ringStroke)

	-- ring flash after the last letter lands
	art.flash = Util.new("Frame", {
		Name = "Flash", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(L.ringK, L.ringK), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2, Visible = false,
	}, discHolder)
	Util.round_corner(art.flash)
	art.flashStroke = Util.new("UIStroke", { Color = white, Thickness = 3, Transparency = 0.2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, art.flash)

	-- logo: built-in vector V, replaced by CONFIG.Splash.LogoImage only if that image really loads
	local logo = UI.icon("logo", discHolder, L.logo, "Text", {
		anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 4,
	})
	art.logo = logo.Instance
	art.image = Util.new("ImageLabel", {
		Name = "LogoImage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(L.logo, L.logo), BackgroundTransparency = 1, BorderSizePixel = 0, Image = "",
		ScaleType = Enum.ScaleType.Fit, ZIndex = 4, Visible = false,
	}, discHolder)

	-- title: one label per letter
	art.letters = {}
	local brand = Splash.chars(cfg.Brand)
	local slot = math.min(L.slot, math.floor(300 / math.max(#brand, 1)))
	local size = math.min(L.titleSize, math.floor(slot / 0.66))
	local spacing = slot * L.titleScale -- the letters are enlarged by a UIScale (TextSize cannot exceed 100)
	local titleFont = Splash.font("FredokaOne", Enum.Font.GothamBlack)
	for index, ch in ipairs(brand) do
		local x = L.cx + (index - (#brand + 1) / 2) * spacing
		local label = Util.new("TextLabel", {
			Name = "Letter" .. index, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, L.titleY - L.drop),
			Size = UDim2.fromOffset(slot + 30, size + 20), BackgroundTransparency = 1, BorderSizePixel = 0, Text = ch,
			Font = titleFont, TextSize = size, TextColor3 = white, TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 8, Visible = false,
		}, holder)
		Util.new("UIGradient", {
			Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(176, 182, 194)),
		}, label)
		local stroke = Util.new("UIStroke", {
			Color = Color3.new(0, 0, 0), Thickness = 4, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
		}, label)
		pcall(function()
			stroke.LineJoinMode = Enum.LineJoinMode.Round
		end)
		art.letters[index] = {
			label = label, scale = Util.new("UIScale", { Scale = L.titleScale }, label), x = x, dir = (index % 2 == 0) and 1 or -1,
		}
	end

	-- capsule with the typed text and the version chip
	art.capsule = Util.new("Frame", {
		Name = "Capsule", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(L.cx, L.capY),
		Size = UDim2.fromOffset(L.capMin, L.capH), BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(8, 8, 10),
		ClipsDescendants = true, ZIndex = 6, Visible = false,
	}, holder)
	Util.round_corner(art.capsule)
	Util.stroke(art.capsule, Color3.fromRGB(232, 236, 244), 1.5, 0.05)
	art.chars = Splash.chars(cfg.TypeText)
	local textWidth = L.capW - 24 - L.chipW - 24
	art.typed = Util.new("TextLabel", {
		Name = "Typed", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(24, 0),
		Size = UDim2.fromOffset(textWidth, L.capH), Text = "", TextColor3 = white,
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7,
	}, art.capsule)
	Typo.apply(art.typed, "label", Splash.fitSize(cfg.TypeText, textWidth, 17))
	art.chip = Util.new("Frame", {
		Name = "Chip", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(L.chipW, L.chipH),
		BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(240, 242, 246), ZIndex = 7, Visible = false,
	}, art.capsule)
	Util.round_corner(art.chip)
	local chipLabel = Util.new("TextLabel", {
		Name = "Text", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
		Text = tostring(cfg.VersionChip), TextColor3 = Color3.fromRGB(10, 10, 14), ZIndex = 8,
	}, art.chip)
	Typo.apply(chipLabel, "label", 16)
	art.chipScale = Util.new("UIScale", { Scale = 0.001 }, art.chip)
	return art
end

-- Builds the whole screen. plain = true builds the simple fallback (no disc, letters or capsule).
function Splash.build(container, plain)
	local parts = Splash.parts
	local L = Splash.L
	local cfg = CONFIG.Splash
	local viewport = Env.viewport()
	local fit = Util.clamp(math.min((viewport.X - 24) / L.W, (viewport.Y - 24) / L.H), 0.5, 1.1)
	parts.plain, parts.fit = plain and true or false, fit
	parts.tl = Splash.plan()
	parts.stepText = "Starting..."

	local gui = Util.new("ScreenGui", {
		Name = CONFIG.SplashName, DisplayOrder = 1000, IgnoreGuiInset = true, ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	}, nil)
	Splash.gui = gui -- registered early so a failed build can still be cleaned up
	parts.gui = gui
	local backdrop = Util.new("Frame", {
		Name = "Backdrop", Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, BackgroundTransparency = 1, Active = true, ZIndex = 1,
	}, gui)
	Theme.bind(backdrop, "BackgroundColor3", "Background", "Scrim", 0.35)
	local vignette = Util.new("UIGradient", { Rotation = 90 }, backdrop)
	vignette.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.3), NumberSequenceKeypoint.new(1, 0),
	})
	parts.backdrop, parts.backdropRest = backdrop, 0.3

	local holder = Util.new("Frame", {
		Name = "Holder", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(L.W, L.H), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
	}, gui)
	parts.holder = holder
	parts.scale = Util.new("UIScale", { Scale = fit }, holder)

	if plain then
		local title = Util.new("TextLabel", {
			Name = "Title", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(L.cx, L.discY + 30),
			Size = UDim2.fromOffset(L.capW, 70), BackgroundTransparency = 1, BorderSizePixel = 0, Text = tostring(cfg.Brand),
			TextColor3 = Color3.new(1, 1, 1), ZIndex = 8,
		}, holder)
		Typo.apply(title, "display", 56)
	else
		Splash.buildArt(holder, parts)
	end

	-- caption (real boot step names, then the hint) + thin progress line + optional problem line
	parts.captionBox = Util.new("Frame", {
		Name = "Caption", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(L.cx - L.capW / 2, L.captionY),
		Size = UDim2.fromOffset(L.capW, 18), ZIndex = 6, Visible = false,
	}, holder)
	parts.status = Util.new("TextLabel", {
		Name = "Status", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Text = parts.stepText,
		TextColor3 = Color3.fromRGB(228, 231, 238), TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 7,
	}, parts.captionBox)
	Typo.apply(parts.status, "heading", 13)
	parts.track = Util.new("Frame", {
		Name = "Track", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(L.cx, L.lineY), Size = UDim2.fromOffset(L.lineW, 3),
		BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.82, ZIndex = 6, Visible = false,
	}, holder)
	Util.round_corner(parts.track)
	parts.fill = Util.new("Frame", {
		Name = "Fill", Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 7,
	}, parts.track)
	Util.round_corner(parts.fill)
	parts.detail = Util.new("TextLabel", {
		Name = "Detail", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(L.cx - L.capW / 2, L.detailY),
		Size = UDim2.fromOffset(L.capW, 14), Text = "", TextXAlignment = Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 6,
	}, holder)
	Typo.apply(parts.detail, "caption", 11)
	Theme.bind(parts.detail, "TextColor3", "Faint")

	-- tap target over capsule + caption; only visible (and therefore only tappable) once the screen says "tap"
	parts.tap = Util.new("TextButton", {
		Name = "Continue", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Position = UDim2.fromOffset(L.cx - L.capW / 2 - 6, L.capY - 6), Size = UDim2.fromOffset(L.capW + 12, L.captionY + 24 - L.capY),
		ZIndex = 20, Visible = false,
	}, holder)
	parts.tap.Activated:Connect(function()
		Splash.activate()
	end)

	if plain then
		Splash.revealCaption(parts)
	else
		Splash.draw(parts, 0) -- the opening look is drawn BEFORE the gui is shown, so nothing flashes
	end
	parts.fade = snapshotFade(holder)
	gui.Parent = container
	Splash.isOpen = true

	task.defer(Splash.begin, parts)
	-- safety net: the intro can never keep the "tap" state waiting
	task.delay(parts.tl.done + 5, function()
		if Splash.parts == parts and Splash.isOpen and not parts.introDone then
			Splash.skipIntro()
		end
	end)
	return gui
end

-- Creates the loading screen. If the animated one cannot be built a plain one is built instead;
-- if that fails too the error reaches App.boot, which opens the hub directly.
function Splash.create(container)
	Splash.destroy()
	local lastError = nil
	for attempt = 1, 2 do
		Splash.createdAt = os.clock()
		Splash.fraction = 0
		Splash.closing = false
		Splash.parts = {}
		local ok, err = pcall(Splash.build, container, attempt == 2)
		if ok then
			return Splash.gui
		end
		lastError = err
		Util.log("error", (attempt == 1 and "splash (animated): " or "splash (plain): ") .. tostring(err))
		Splash.destroy()
	end
	error(lastError, 0)
end

----------------------------------------------------------------------------------------------------
-- animation
----------------------------------------------------------------------------------------------------
-- Draws the intro at time t (seconds since it started). Idempotent: any t can be drawn at any moment.
function Splash.draw(parts, t)
	local art, tl, L = parts.art, parts.tl, Splash.L
	if not art then
		return
	end
	local ease = Motion.ease

	-- disc: pops in (Back ease), pulses after the last letter lands, with a ring flash
	local pulse = Util.clamp((t - tl.lastLand) / tl.pulseDur, 0, 1)
	art.discScale.Scale = math.max(0.001, ease.outBack(Util.clamp(t / tl.pop, 0, 1)) * (1 + 0.07 * math.sin(math.pi * pulse)))
	if pulse > 0 and pulse < 1 then
		local flashSize = L.ringK * (1 + 0.38 * ease.outQuart(pulse))
		art.flash.Visible = true
		art.flash.Size = UDim2.fromScale(flashSize, flashSize)
		art.flashStroke.Transparency = 0.15 + 0.85 * pulse
	elseif art.flash.Visible then
		art.flash.Visible = false
	end

	-- title letters drop in one by one
	for index, letter in ipairs(art.letters) do
		local u = (t - (tl.dropStart + (index - 1) * tl.stagger)) / tl.dropDur
		if u <= 0 then
			if letter.label.Visible then
				letter.label.Visible = false
			end
		else
			local y, rotation, k = Splash.dropPose(u, letter.dir)
			letter.label.Visible = true
			letter.label.Position = UDim2.fromOffset(letter.x, L.titleY + y)
			letter.label.Rotation = rotation
			letter.scale.Scale = k * L.titleScale
		end
	end
	if t >= tl.dropStart then
		Splash.startMusic() -- the loading music starts with the first letter drop
	end

	-- capsule grows from a small pill to full width, then the text is typed, then the chip pops in
	if t < tl.capStart then
		if art.capsule.Visible then
			art.capsule.Visible = false
		end
	else
		local grow = ease.outQuart(Util.clamp((t - tl.capStart) / tl.capDur, 0, 1))
		art.capsule.Visible = true
		art.capsule.Size = UDim2.fromOffset(math.floor(L.capMin + (L.capW - L.capMin) * grow + 0.5), L.capH)
	end
	local count = 0
	if t >= tl.typeStart then
		count = Util.clamp(math.floor((t - tl.typeStart) / tl.speed) + 1, 0, #art.chars)
	end
	local caret = false
	if t >= tl.capStart + tl.capDur then
		if count < #art.chars then
			caret = true
		elseif t < tl.typeEnd + 0.45 then
			caret = math.floor(t / 0.3) % 2 == 0
		end
	end
	local text = table.concat(art.chars, "", 1, count) .. (caret and "|" or "")
	if art.typed.Text ~= text then
		art.typed.Text = text
	end
	local chip = Util.clamp((t - tl.chipStart) / tl.chipDur, 0, 1)
	if chip <= 0 then
		if art.chip.Visible then
			art.chip.Visible = false
		end
	else
		art.chip.Visible = true
		art.chipScale.Scale = math.max(0.001, ease.outBack(chip))
	end

	if t >= tl.reveal then
		Splash.revealCaption(parts)
	end
end

-- wobble, ring, logo sway and the soft pulse of the hint. Skipped entirely with reduced motion.
function Splash.idle(parts, now)
	local art = parts.art
	if not art or Motion.reduced then
		return
	end
	art.blobA.Size = UDim2.fromScale(1 + 0.035 * math.sin(now * 3.1), 1 + 0.035 * math.sin(now * 2.3 + 1.7))
	art.blobB.Size = UDim2.fromScale(1 + 0.032 * math.sin(now * 2.6 + 0.7), 1 + 0.032 * math.sin(now * 3.4 + 2.6))
	art.blobB.Rotation = 45 + 12 * math.sin(now * 0.7)
	art.ringGradient.Rotation = (now * 90) % 360
	art.logo.Rotation = 2.4 * math.sin(now * 1.7)
	art.image.Rotation = art.logo.Rotation
	if parts.isReady and not Splash.closing and not parts.failed and now - parts.readyAt > 0.4 then
		parts.status.TextTransparency = 0.04 + 0.34 * (0.5 + 0.5 * math.sin((now - parts.readyAt) * 3.2))
	end
end

-- the Anim job: never lets one bad frame stop the screen from reaching its "tap" state
function Splash.tick(now)
	local parts = Splash.parts
	if not Splash.isOpen or not parts.t0 then
		return
	end
	local ok, err = pcall(function()
		local t = now - parts.t0
		if not parts.introDone then
			Splash.draw(parts, t)
			if t >= parts.tl.done then
				Splash.skipIntro()
			end
		end
		Splash.idle(parts, now)
	end)
	if not ok then
		parts.faults = (parts.faults or 0) + 1
		Util.log("error", "splash frame: " .. tostring(err))
		if parts.faults >= 3 then
			parts.t0 = nil
			Anim.remove("splash")
			Splash.skipIntro()
		end
	end
end

Splash.tickFn = function(_, now)
	Splash.tick(now)
end

-- Shows the finished intro at once. Used by reduced motion, by failures and by the watchdog.
function Splash.skipIntro()
	local parts = Splash.parts
	if not Splash.isOpen or parts.introDone then
		return
	end
	parts.introDone = true -- first, so a failing draw can never block the hint
	local ok, err = pcall(Splash.draw, parts, Splash.FINAL)
	if not ok then
		Util.log("error", "splash final state: " .. tostring(err))
	end
	Splash.startMusic() -- idempotent; covers the plain screen and reduced motion (no letter drop to wait for)
	Splash.revealCaption(parts)
	if parts.art and parts.t0 and not Motion.reduced then
		Anim.add("splash", Splash.tickFn, 30) -- keep the wobble going, cheaper
	end
	Splash.refresh()
end

-- shows the caption and the progress line (after the intro, or at once when it is skipped)
function Splash.revealCaption(parts)
	if parts.captionShown or not parts.captionBox then
		return
	end
	parts.captionShown = true
	parts.captionBox.Visible = true
	parts.track.Visible = true
	if parts.drawn and not Motion.reduced then
		parts.status.TextTransparency = 1
		Motion.tween(parts.status, { TextTransparency = 0 }, 0.3)
		parts.track.BackgroundTransparency = 1
		Motion.tween(parts.track, { BackgroundTransparency = 0.82 }, 0.3)
	end
end

-- first frame after the gui is shown
function Splash.begin(parts)
	if Splash.parts ~= parts or not Splash.isOpen or Splash.closing or parts.begun then
		return
	end
	parts.begun = true
	parts.drawn = true
	Motion.tween(parts.backdrop, { BackgroundTransparency = parts.backdropRest }, 0.35, Enum.EasingStyle.Quad)
	task.spawn(function()
		local ok, err = pcall(Splash.loadLogo, parts)
		if not ok then
			Util.log("warn", "logo image: " .. tostring(err))
		end
	end)
	if parts.plain or not parts.art or Motion.reduced then
		Splash.skipIntro()
		return
	end
	parts.t0 = os.clock()
	Anim.add("splash", Splash.tickFn)
end

-- CONFIG.Splash.LogoImage: "" = built-in V. An rbxassetid, or a file in the executor workspace (Env.customAsset).
-- The image replaces the V only after it has really loaded; otherwise the V stays.
function Splash.loadLogo(parts)
	local art = parts.art
	local source = CONFIG.Splash.LogoImage
	if not art or type(source) ~= "string" or source == "" then
		return
	end
	local content = nil
	if string.find(source, "^rbxassetid://") or string.find(source, "^rbxasset://") or string.find(source, "^rbxthumb://") then
		content = source
	elseif string.find(source, "^%d+$") then
		content = "rbxassetid://" .. source
	elseif Env.canCustomAsset() and Env.fileExists(source) then
		content = Env.customAsset(source)
	end
	if not content then
		Util.log("warn", "logo image is not available, the built-in V is used: " .. source)
		return
	end
	art.image.Image = content
	local waited = 0
	while waited < 4 and Splash.parts == parts and Splash.isOpen do
		local ok, loaded = pcall(function()
			return art.image.IsLoaded
		end)
		if ok and loaded then
			art.image.Visible = true
			art.logo.Visible = false
			return
		end
		task.wait(0.1)
		waited = waited + 0.1
	end
	Util.log("warn", "logo image did not load in time, the built-in V is used: " .. source)
end

----------------------------------------------------------------------------------------------------
-- reporting from App.boot
----------------------------------------------------------------------------------------------------
-- Reports REAL progress. text = stage name, done / total = completed boot steps, partial = 0..1 of the current one
function Splash.step(text, done, total, partial)
	local parts = Splash.parts
	if not Splash.isOpen or Splash.closing or not parts.status or parts.isReady or parts.failed then
		return
	end
	if text then
		parts.stepText = text
		if parts.captionShown then
			setStatusText(parts.status, text)
		else
			parts.status.Text = text
		end
	end
	local fraction = Util.clamp((done + (partial or 0)) / math.max(total, 1), 0, 1)
	if fraction > Splash.fraction then
		Splash.fraction = fraction
		Motion.tween(parts.fill, { Size = UDim2.fromScale(fraction, 1) }, 0.4, Enum.EasingStyle.Quart)
	end
end

-- a short problem line under the progress line; ordinary "all fine" details stay hidden
function Splash.detail(text, role)
	local parts = Splash.parts
	if not parts.detail then
		return
	end
	if role == "Warn" or role == "Danger" then
		parts.detail.Text = tostring(text or "")
		Theme.bind(parts.detail, "TextColor3", role)
	else
		parts.detail.Text = ""
	end
end

local function finishClose(onClosed)
	Anim.remove("splash")
	Splash.dropPick()
	local gui = Splash.gui
	Splash.gui, Splash.isOpen = nil, false
	Splash.parts = {}
	if gui then
		pcall(gui.Destroy, gui)
	end
	UI.prune()
	if onClosed then
		Util.try("splash onClosed", onClosed)
	end
end

-- The screen says "tap": boot is done (or forced) AND the intro has finished. Nothing closes by itself.
function Splash.refresh()
	local parts = Splash.parts
	if not Splash.isOpen or Splash.closing or parts.isReady or parts.failed then
		return
	end
	if parts.introDone and (parts.bootDone or parts.forced) then
		Splash.enterReady()
	end
end

function Splash.enterReady()
	local parts = Splash.parts
	parts.isReady = true
	parts.readyAt = os.clock()
	Splash.revealCaption(parts)
	setStatusText(parts.status, tostring(CONFIG.Splash.HintText))
	Motion.tween(parts.track, { BackgroundTransparency = 1 }, 0.4)
	Motion.tween(parts.fill, { BackgroundTransparency = 1 }, 0.4)
	parts.tap.Visible = true
	Sfx.play("success")
end

-- All real work finished. Records it; the hand-off happens only when the user taps.
function Splash.ready(onHandoff, onClosed)
	local parts = Splash.parts
	if not Splash.isOpen or Splash.closing then
		return
	end
	if onHandoff then
		Splash.handoff = onHandoff
	end
	if onClosed then
		Splash.onClosed = onClosed
	end
	parts.bootDone = true
	if Splash.fraction < 1 and not parts.isReady then
		Splash.fraction = 1
		Motion.tween(parts.fill, { Size = UDim2.fromScale(1, 1) }, 0.35, Enum.EasingStyle.Quart)
	end
	Splash.refresh()
end

-- Watchdog (MaxSeconds): only moves the screen to its "tap to open" state. It never opens the hub.
function Splash.force(onHandoff)
	local parts = Splash.parts
	if not Splash.isOpen or Splash.closing or parts.failed then
		return
	end
	if onHandoff then
		Splash.handoff = onHandoff
	end
	parts.forced = true
	Splash.skipIntro()
	Splash.refresh()
end

function Splash.setHandoff(onHandoff, onClosed)
	Splash.handoff = onHandoff
	Splash.onClosed = onClosed
end

-- tap on the capsule / hint
function Splash.activate()
	local parts = Splash.parts
	if not Splash.isOpen or Splash.closing or not parts.isReady then
		return
	end
	Splash.close(Splash.handoff, Splash.onClosed)
end

-- fade-out then destroy. onHandoff() runs when the fade begins (the hub window opens under it).
function Splash.close(onHandoff, onClosed)
	if Splash.closing or not Splash.isOpen then
		if onClosed and not Splash.isOpen then
			Util.try("splash onClosed", onClosed)
		end
		return
	end
	Splash.closing = true
	local parts = Splash.parts
	if parts.music then
		parts.music.Stop(0.45)
	end
	Sfx.play("open")
	if onHandoff then
		Util.try("splash handoff", onHandoff)
	end
	if Motion.reduced or not parts.fade then
		finishClose(onClosed)
		return
	end
	fadeTo(parts.fade, true, 0.32, Enum.EasingStyle.Quad)
	Motion.tween(parts.backdrop, { BackgroundTransparency = 1 }, 0.38, Enum.EasingStyle.Quad)
	Motion.tween(parts.scale, { Scale = parts.fit * 0.94 }, 0.36, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	task.delay(0.42, function()
		finishClose(onClosed)
	end)
end

-- Something essential failed: say so honestly, then close.
function Splash.fail(message, onClosed)
	local parts = Splash.parts
	if not Splash.isOpen or Splash.closing then
		return
	end
	parts.failed = true
	if parts.music then
		parts.music.Stop(0.45)
	end
	Splash.skipIntro()
	Sfx.play("error")
	Splash.revealCaption(parts)
	setStatusText(parts.status, "Startup problem")
	Theme.bind(parts.status, "TextColor3", "Danger")
	Theme.bind(parts.detail, "TextColor3", "Danger")
	parts.detail.Text = Util.cap(tostring(message or "Unknown error"), 90)
	if parts.art then
		Theme.bind(parts.art.ringStroke, "Color", "Danger")
	end
	Theme.bind(parts.fill, "BackgroundColor3", "Danger")
	Motion.tween(parts.fill, { Size = UDim2.fromScale(1, 1) }, 0.3)
	task.delay(2.6, function()
		Splash.close(nil, onClosed)
	end)
end

function Splash.destroy()
	Anim.remove("splash")
	if Splash.parts.music then
		Splash.parts.music.Stop(0)
	end
	Splash.dropPick()
	if Splash.gui then
		pcall(Splash.gui.Destroy, Splash.gui)
	end
	Splash.gui, Splash.isOpen, Splash.closing, Splash.parts = nil, false, false, {}
	Splash.handoff, Splash.onClosed = nil, nil
end
end -- [09_splash.lua]

do -- [10_avatar.lua]

----------------------------------------------------------------------------------------------------
-- Avatar: ported from AVATAR-CHANGER.lua (returnreturnfunction) and extended with input validation,
-- player look-up with a preview, one-operation-at-a-time protection, honest result messages and a
-- favourites list stored in the hub config.
--
-- HOW A LOOK IS APPLIED (reworked in 2.1.0, because Roblox changed what a client may do):
--   1. The call the original script used (Humanoid:ApplyDescriptionClientServer) no longer exists, and
--      Humanoid:ApplyDescription from a client now fails on a character the server created with
--      "can only be called by the backend server". The hub still tries those calls first, once per character,
--      in case an experience or executor allows them.
--   2. When Roblox refuses, the look is built on a client-only rig (Players:CreateHumanoidModelFromDescription)
--      and its accessories, clothing, skin colours and face are copied onto YOUR character on this device.
--      That is a client-side visual change: nobody else can see it, respawning resets it, and the server
--      never hears about it. The hub says so in every message.
-- Body shape, head / limb meshes, scale and animations are not copied by the client-side path.
----------------------------------------------------------------------------------------------------
local MarketplaceService = optionalService("MarketplaceService")

Avatar.busy = false
Avatar.names = {}       -- userId -> username cache
Avatar.current = nil    -- userId of the look that was applied through this hub (nil = your own)
Avatar.listeners = {}
Avatar.hooks = {}       -- status(kind, text) / resolved(userId, name), set by the page
Avatar.ui = {}
Avatar.blocked = setmetatable({}, { __mode = "k" }) -- Humanoid -> why Roblox refused to change it from this client
Avatar.localState = nil -- what the client-side look changed on the character (see Avatar.restoreLocal)
Avatar.connection = nil -- CharacterAdded listener

function Avatar.notify()
	for _, fn in ipairs(Util.copy(Avatar.listeners)) do
		Util.try("avatar listener", fn)
	end
end

function Avatar.onChange(fn)
	Avatar.listeners[#Avatar.listeners + 1] = fn
	return function()
		local index = Util.indexOf(Avatar.listeners, fn)
		if index then
			table.remove(Avatar.listeners, index)
		end
	end
end

local function say(kind, text)
	local fn = Avatar.hooks.status
	if fn then
		Util.try("avatar status", fn, kind, text)
	end
end

local function sawUser(userId, name)
	local fn = Avatar.hooks.resolved
	if fn then
		Util.try("avatar resolved", fn, userId, name)
	end
end

function Avatar.thumb(userId)
	return string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100", math.floor(userId))
end

-- "12345" -> "id", 12345   |   "Roblox" -> "name", "Roblox"   |   bad input -> nil, reason
function Avatar.parseTarget(text)
	text = Util.trim(text)
	if text == "" then
		return nil, "Enter a user ID or a username first."
	end
	if string.match(text, "^%d+$") then
		local id = tonumber(text)
		if #text > 12 or id == nil or id < 1 then
			return nil, "That user ID is out of range."
		end
		return "id", id
	end
	if string.match(text, "^[%w_]+$") and #text >= 3 and #text <= 20 then
		return "name", text
	end
	return nil, "Usernames use letters, numbers and underscores (3-20 characters)."
end

-- yields. Returns name or nil
function Avatar.nameFor(userId)
	if Avatar.names[userId] then
		return Avatar.names[userId]
	end
	local ok, name = pcall(Players.GetNameFromUserIdAsync, Players, userId)
	if ok and type(name) == "string" and name ~= "" then
		Avatar.names[userId] = name
		return name
	end
	return nil
end

-- yields. Returns userId, name  |  nil, reason
function Avatar.resolve(text)
	local kind, value = Avatar.parseTarget(text)
	if not kind then
		return nil, value
	end
	if kind == "id" then
		local name = Avatar.nameFor(value)
		if not name then
			return nil, "Could not find a Roblox user with ID " .. value .. " (or Roblox did not answer)."
		end
		return value, name
	end
	local ok, id = pcall(Players.GetUserIdFromNameAsync, Players, value)
	if not ok or type(id) ~= "number" then
		return nil, "Could not find a Roblox user named '" .. value .. "' (or Roblox did not answer)."
	end
	Avatar.names[id] = value
	return id, value
end

-- returns humanoid, character  |  nil, nil, reason
function Avatar.character()
	local player = Players.LocalPlayer
	local character = player and player.Character
	if not character then
		return nil, nil, "Your character has not loaded yet."
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return nil, nil, "Your character has no Humanoid in this experience."
	end
	return humanoid, character
end

-- yields. Runs fn() in its own thread and gives up after `seconds`, so a Roblox call that never answers can
-- not leave the hub stuck in "busy". Returns true, result  |  false, reason. A result that arrives after the
-- timeout is handed to late(ok, result) so it can be cleaned up.
local TIMED_OUT = "Roblox did not answer in time."

local function within(seconds, fn, late)
	local box = { done = false, late = false }
	task.spawn(function()
		local ok, result = pcall(fn)
		box.done, box.ok, box.result = true, ok, result
		if box.late and late then
			Util.try("avatar late result", late, ok, result)
		end
	end)
	local waited = 0
	while not box.done and waited < seconds and not App.destroyed do
		task.wait(0.1)
		waited = waited + 0.1
	end
	if not box.done then
		box.late = true
		return false, TIMED_OUT
	end
	if not box.ok then
		return false, tostring(box.result)
	end
	return true, box.result
end

-- yields. Tries the documented method name first, then the newer Async name.
function Avatar.description(userId)
	local lastError = "HumanoidDescription lookup is unavailable."
	for _, method in ipairs({ "GetHumanoidDescriptionFromUserId", "GetHumanoidDescriptionFromUserIdAsync" }) do
		local ok, result = within(25, function()
			return Players[method](Players, userId)
		end)
		if ok and typeof(result) == "Instance" then
			return result
		end
		lastError = ok and "Roblox returned no outfit." or tostring(result)
		if result == TIMED_OUT then
			break
		end
	end
	return nil, lastError
end

-- Roblox calls that change the REAL character, newest idea last. The first one is what the original script used.
local ENGINE_METHODS = { "ApplyDescriptionClientServer", "ApplyDescriptionAsync", "ApplyDescription" }

-- yields. Asks Roblox to change the real character. Returns true, methodName  |  false, reason.
-- A refusal is remembered per Humanoid (it stays true until the character respawns), so repeated taps are instant.
function Avatar.applyDescription(humanoid, description)
	local known = Avatar.blocked[humanoid]
	if known then
		return false, known
	end
	local lastError = "no apply method available"
	local tried = {}
	for _, method in ipairs(ENGINE_METHODS) do
		local ok, err = within(30, function()
			humanoid[method](humanoid, description)
		end)
		if ok then
			return true, method
		end
		lastError = tostring(err)
		tried[#tried + 1] = method .. ": " .. Util.cap(lastError, 80)
		if err == TIMED_OUT then
			return false, lastError -- not remembered: the next try may work
		end
	end
	Avatar.blocked[humanoid] = lastError
	Util.log("info", "avatar: Roblox refused the change on the real character (" .. table.concat(tried, " | ") .. ")")
	return false, lastError
end

-- The original script re-parents a fresh copy of "Animate" so animations match the new body.
local function refreshAnimate(character)
	pcall(function()
		task.wait(0.1)
		local animate = character:FindFirstChild("Animate")
		if animate and character.Parent then
			local copy = animate:Clone()
			animate:Destroy()
			copy.Parent = character
		end
	end)
end

----------------------------------------------------------------------------------------------------
-- client-side look: used when Roblox refuses to change the real character
----------------------------------------------------------------------------------------------------
local MARK = "VirexLook" -- attribute on every piece the hub adds, so a later run can recognise and remove them
local LOOK_ALL = { accessories = true, shirt = true, pants = true, graphic = true, colors = true, face = true, meshes = true }
local COLOR_PARTS = {
	HeadColor3 = { "Head" },
	TorsoColor3 = { "Torso", "UpperTorso", "LowerTorso" },
	LeftArmColor3 = { "Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand" },
	RightArmColor3 = { "Right Arm", "RightUpperArm", "RightLowerArm", "RightHand" },
	LeftLegColor3 = { "Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" },
	RightLegColor3 = { "Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot" },
}

-- Forgets the client-side look. removeAdded = also delete the pieces the hub put on the character.
function Avatar.dropLocal(removeAdded)
	local state = Avatar.localState
	Avatar.localState = nil
	if not state then
		return
	end
	for _, inst in ipairs(state.saved) do
		pcall(inst.Destroy, inst)
	end
	if removeAdded then
		for _, inst in ipairs(state.added) do
			pcall(inst.Destroy, inst)
		end
	end
	Avatar.current = nil
	Avatar.notify()
end

-- The state for this character, or nil. A state that belongs to another (respawned) character is dropped.
function Avatar.stateFor(character)
	local state = Avatar.localState
	if not state then
		return nil
	end
	if not character or state.character ~= character or not character.Parent then
		Avatar.dropLocal()
		return nil
	end
	return state
end

-- No yield. Deletes what the hub added and puts back what it took away. Returns true  |  false, reason
function Avatar.restoreLocal()
	local state = Avatar.localState
	if not state then
		return false, "There is nothing to restore."
	end
	local character = state.character
	local alive = character ~= nil and character.Parent ~= nil
	for _, inst in ipairs(state.added) do
		pcall(inst.Destroy, inst)
	end
	for _, inst in ipairs(state.saved) do
		if alive then
			pcall(function()
				inst.Parent = character
			end)
		else
			pcall(inst.Destroy, inst)
		end
	end
	if alive then
		local face = state.face
		if face and face.decal and face.decal.Parent then
			pcall(function()
				face.decal.Texture = face.texture
			end)
		end
		for part, color in pairs(state.partColors) do
			pcall(function()
				if part.Parent then
					part.Color = color
				end
			end)
		end
	end
	Avatar.localState = nil
	Avatar.current = nil
	return true
end

-- True when a piece added by an earlier run of the hub is still on the character.
local function hasLeftovers(character)
	local function scan(parent)
		for _, child in ipairs(parent:GetChildren()) do
			if child:GetAttribute(MARK) then
				return true
			end
		end
		return false
	end
	if scan(character) then
		return true
	end
	local head = character:FindFirstChild("Head")
	return head ~= nil and scan(head)
end

-- Removes the hub's marker from every piece it added, so the pieces count as the character's own again.
local function adoptLook()
	local state = Avatar.localState
	Avatar.localState = nil
	if not state then
		return
	end
	for _, inst in ipairs(state.added) do
		pcall(inst.SetAttribute, inst, MARK, nil)
	end
	for _, inst in ipairs(state.saved) do
		pcall(inst.Destroy, inst)
	end
end

-- Copies the pieces of `rig` named by `scope` onto `character`. No yield. Raises on unexpected errors.
-- Returns counts, welds (the accessories whose weld has to be checked once the engine had a frame).
local function transplant(character, rig, scope, state)
	local counts = { accessories = 0, skipped = 0, meshes = 0, shirt = false, pants = false, graphic = false, colors = false, face = false }
	local welds = {}

	-- takes every matching child of the character out of the way; pieces the hub added are simply deleted
	local function clear(test)
		for _, child in ipairs(character:GetChildren()) do
			if test(child) then
				if child:GetAttribute(MARK) then
					local at = Util.indexOf(state.added, child)
					if at then
						table.remove(state.added, at)
					end
					pcall(child.Destroy, child)
				else
					state.saved[#state.saved + 1] = child
					child.Parent = nil
				end
			end
		end
	end
	local function bring(inst, parent)
		local copy = inst:Clone()
		if not copy then
			return nil
		end
		pcall(copy.SetAttribute, copy, MARK, true)
		copy.Parent = parent or character
		state.added[#state.added + 1] = copy
		return copy
	end
	local function childrenOfClass(parent, className)
		local list = {}
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA(className) then
				list[#list + 1] = child
			end
		end
		return list
	end

	if scope.accessories then
		local fresh = childrenOfClass(rig, "Accessory")
		clear(function(child)
			return child:IsA("Accessory")
		end)
		for _, accessory in ipairs(fresh) do
			local partName = nil
			local handle = accessory:FindFirstChild("Handle")
			local weld = handle and handle:FindFirstChild("AccessoryWeld")
			if weld then
				pcall(function()
					local other = weld.Part1
					if other == handle then
						other = weld.Part0
					end
					partName = other and other.Name
				end)
			end
			local copy = bring(accessory)
			if copy then
				counts.accessories = counts.accessories + 1
				welds[#welds + 1] = { accessory = copy, partName = partName }
			else
				counts.skipped = counts.skipped + 1
			end
		end
	end

	local function swap(className, flag)
		if not scope[flag] then
			return
		end
		local fresh = rig:FindFirstChildOfClass(className)
		clear(function(child)
			return child:IsA(className)
		end)
		if fresh and bring(fresh) then
			counts[flag] = true
		end
	end
	swap("Shirt", "shirt")
	swap("Pants", "pants")
	swap("ShirtGraphic", "graphic")

	if scope.colors then
		local fresh = rig:FindFirstChildOfClass("BodyColors")
		if fresh then
			clear(function(child)
				return child:IsA("BodyColors")
			end)
			local copy = bring(fresh)
			if copy then
				counts.colors = true
				state.colors = copy
			end
		end
	end

	if scope.face then
		local rigHead, head = rig:FindFirstChild("Head"), character:FindFirstChild("Head")
		local fresh = rigHead and rigHead:FindFirstChild("face")
		if fresh and head and fresh:IsA("Decal") then
			local current = head:FindFirstChild("face")
			if current and current:IsA("Decal") then
				if not state.face and not current:GetAttribute(MARK) then
					state.face = { decal = current, texture = current.Texture }
				end
				current.Texture = fresh.Texture
				counts.face = true
			elseif bring(fresh, head) then
				counts.face = true
			end
			counts.faceTexture = fresh.Texture
		end
	end

	if scope.meshes then
		local fresh = childrenOfClass(rig, "CharacterMesh")
		clear(function(child)
			return child:IsA("CharacterMesh")
		end)
		for _, mesh in ipairs(fresh) do
			if bring(mesh) then
				counts.meshes = counts.meshes + 1
			end
		end
	end
	return counts, welds
end

-- Makes sure every copied accessory is welded to THIS character (the engine normally does it when the
-- accessory is parented; if it did not, repair the weld that was copied from the rig or build the same one).
-- Accessories that cannot be attached are removed. Returns how many were removed.
local function weldAccessories(character, welds, state)
	local removed = 0
	for _, entry in ipairs(welds) do
		local accessory = entry.accessory
		local handle = accessory.Parent == character and accessory:FindFirstChild("Handle") or nil
		local usable = false
		if handle then
			local stale = nil
			for _, child in ipairs(handle:GetChildren()) do
				if child:IsA("Weld") or child:IsA("WeldConstraint") then
					local other = child.Part0
					if other == handle then
						other = child.Part1
					end
					if other and other ~= handle and other:IsDescendantOf(character) then
						usable = true
					else
						stale = stale or child
					end
				end
			end
			if not usable then
				local target = entry.partName and character:FindFirstChild(entry.partName) or nil
				if target and stale and target:IsA("BasePart") then
					if stale.Part1 == handle then
						stale.Part0 = target
					else
						stale.Part0 = handle
						stale.Part1 = target
					end
					usable = true
				else
					local handleAttachment, bodyAttachment = nil, nil
					for _, child in ipairs(handle:GetChildren()) do
						if child:IsA("Attachment") then
							for _, part in ipairs(character:GetChildren()) do
								local candidate = part:IsA("BasePart") and part:FindFirstChild(child.Name) or nil
								if candidate and candidate:IsA("Attachment") then
									handleAttachment, bodyAttachment = child, candidate
									break
								end
							end
							if handleAttachment then
								break
							end
						end
					end
					if handleAttachment then
						local weld = Instance.new("Weld")
						weld.Name = "AccessoryWeld"
						weld.Part0 = handle
						weld.Part1 = bodyAttachment.Parent
						weld.C0 = handleAttachment.CFrame
						weld.C1 = bodyAttachment.CFrame
						weld.Parent = handle
						usable = true
					end
				end
			end
		end
		if not usable then
			-- could not be attached, or the experience already deleted it: either way it is not on the character
			removed = removed + 1
			local at = Util.indexOf(state.added, accessory)
			if at then
				table.remove(state.added, at)
			end
			pcall(accessory.Destroy, accessory)
		end
	end
	return removed
end

-- If the engine did not recolour the body from the new BodyColors (it normally does), set the colours directly.
local function paintBody(character, state)
	local colors = state.colors
	if not colors or colors.Parent ~= character then
		return
	end
	for property, names in pairs(COLOR_PARTS) do
		local want = colors[property]
		for _, name in ipairs(names) do
			local part = character:FindFirstChild(name)
			if part and part:IsA("BasePart") and part.Color ~= want then
				if state.partColors[part] == nil then
					state.partColors[part] = part.Color
				end
				part.Color = want
			end
		end
	end
end

local function lookSummary(counts)
	local parts = {}
	if counts.accessories > 0 then
		parts[#parts + 1] = counts.accessories .. (counts.accessories == 1 and " accessory" or " accessories")
	end
	if counts.shirt then
		parts[#parts + 1] = "shirt"
	end
	if counts.pants then
		parts[#parts + 1] = "pants"
	end
	if counts.graphic then
		parts[#parts + 1] = "T-shirt"
	end
	if counts.colors then
		parts[#parts + 1] = "skin colors"
	end
	if counts.face then
		parts[#parts + 1] = "face"
	end
	if counts.meshes > 0 then
		parts[#parts + 1] = "body parts"
	end
	if #parts == 0 then
		return nil
	end
	return table.concat(parts, ", ")
end

-- yields. A rig that exists only on this client, wearing `description`. Returns model  |  nil, reason
function Avatar.buildRig(description, rigType)
	if rigType == nil then
		pcall(function()
			rigType = Enum.HumanoidRigType.R15
		end)
	end
	local lastError = "the outfit builder is unavailable"
	for _, method in ipairs({ "CreateHumanoidModelFromDescriptionAsync", "CreateHumanoidModelFromDescription" }) do
		local ok, model = within(30, function()
			return Players[method](Players, description, rigType)
		end, function(lateOk, lateModel)
			if lateOk and typeof(lateModel) == "Instance" then
				pcall(lateModel.Destroy, lateModel)
			end
		end)
		if ok and typeof(model) == "Instance" and model:IsA("Model") then
			return model
		end
		lastError = ok and "Roblox returned no model." or tostring(model)
		if model == TIMED_OUT then
			break
		end
	end
	return nil, lastError
end

-- yields. Roblox refused to change the real character, so show the look on this client only.
-- scope: which pieces to copy.  must: { { class, label, id } } clothing that has to load, or nothing is changed.
-- Returns ok, message, extra
function Avatar.wearLocal(description, scope, must)
	local humanoid, character, problem = Avatar.character()
	if not humanoid then
		return false, problem
	end
	local rigType = nil
	pcall(function()
		rigType = humanoid.RigType
	end)
	say("working", "Roblox keeps your real avatar on the server, so the look is built for your screen...")
	local rig, rigError = Avatar.buildRig(description, rigType)
	if App.destroyed then
		if rig then
			pcall(rig.Destroy, rig)
		end
		return false, "The hub was closed."
	end
	if not rig then
		return false, "The experience blocked the change, and the look could not be built on your screen either (" .. Util.cap(tostring(rigError), 60) .. ")."
	end
	-- the character can respawn while the outfit loads, so fetch it again
	local liveHumanoid, liveCharacter, stale = Avatar.character()
	if not liveHumanoid or liveCharacter ~= character then
		pcall(rig.Destroy, rig)
		return false, stale or "Your character respawned while the look was loading. Press Apply again."
	end
	for _, need in ipairs(must or {}) do
		if not rig:FindFirstChildOfClass(need.class) then
			pcall(rig.Destroy, rig)
			return false, string.format(
				"%s ID %d did not load. It may be off-sale, removed or not a %s.", need.label, math.floor(need.id), string.lower(need.label)
			)
		end
	end
	local state = Avatar.stateFor(character)
	if not state then
		state = { character = character, added = {}, saved = {}, partColors = {} }
		Avatar.localState = state
	end
	local ok, counts, welds = pcall(transplant, character, rig, scope, state)
	if not ok then
		Util.log("error", "avatar: client-side look failed: " .. tostring(counts))
		pcall(rig.Destroy, rig)
		Avatar.restoreLocal()
		return false, "The look could not be put on your screen (" .. Util.cap(tostring(counts), 60) .. "). Your character was put back."
	end
	local before = (counts.accessories + counts.meshes) + (counts.shirt and 1 or 0) + (counts.pants and 1 or 0)
		+ (counts.graphic and 1 or 0) + (counts.colors and 1 or 0) + (counts.face and 1 or 0)
	task.wait(0.12) -- the engine welds and recolours on its own; check afterwards
	pcall(rig.Destroy, rig)
	if App.destroyed or Avatar.localState ~= state or not character.Parent then
		return false, "Your character respawned while the look was being applied. Press Apply again."
	end
	local removed = weldAccessories(character, welds, state)
	counts.accessories = counts.accessories - removed
	counts.skipped = counts.skipped + removed
	pcall(paintBody, character, state)
	-- the experience may delete pieces it did not make; report only what stayed
	local function stays(className, flag)
		if counts[flag] then
			local piece = character:FindFirstChildOfClass(className)
			counts[flag] = piece ~= nil and piece:GetAttribute(MARK) == true
		end
	end
	stays("Shirt", "shirt")
	stays("Pants", "pants")
	stays("ShirtGraphic", "graphic")
	stays("BodyColors", "colors")
	if counts.face then
		local head = character:FindFirstChild("Head")
		local decal = head and head:FindFirstChild("face")
		counts.face = decal ~= nil and decal:IsA("Decal") and decal.Texture == counts.faceTexture
	end
	if counts.meshes > 0 then
		local kept = 0
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("CharacterMesh") and child:GetAttribute(MARK) then
				kept = kept + 1
			end
		end
		counts.meshes = kept
	end
	local after = (counts.accessories + counts.meshes) + (counts.shirt and 1 or 0) + (counts.pants and 1 or 0)
		+ (counts.graphic and 1 or 0) + (counts.colors and 1 or 0) + (counts.face and 1 or 0)
	if before > 0 and after == 0 then
		Avatar.restoreLocal()
		return false, "The experience removed the new look right away, so nothing changed on your screen."
	end
	local shown = lookSummary(counts)
	local message = shown and ("Applied on your screen: " .. shown .. ".") or "Applied on your screen: that look has no accessories, clothing or custom colors."
	if counts.skipped > 0 then
		message = message .. string.format(" (%d accessories could not be attached.)", counts.skipped)
	end
	return true, message, "Only you can see this look, and respawning resets it."
end

-- Called once by the page: a respawn gives the character back to the experience, so the client-side look is forgotten.
function Avatar.init()
	if Avatar.connection then
		return
	end
	local player = Players.LocalPlayer
	if not player then
		return
	end
	local ok, connection = pcall(function()
		return player.CharacterAdded:Connect(function()
			if Avatar.localState then
				Avatar.dropLocal()
			end
		end)
	end)
	if ok then
		Avatar.connection = connection
	end
end

-- Hub teardown. The look itself stays (it is what the player chose); only the hub's bookkeeping goes.
function Avatar.destroy()
	if Avatar.connection then
		pcall(Avatar.connection.Disconnect, Avatar.connection)
		Avatar.connection = nil
	end
	local state = Avatar.localState
	Avatar.localState = nil
	if state then
		for _, inst in ipairs(state.saved) do
			pcall(inst.Destroy, inst)
		end
	end
	Avatar.listeners = {}
end

-- yields. Runs ONE avatar operation at a time. fn() returns ok, message, extra.
function Avatar.exclusive(fn)
	if Avatar.busy then
		return false, "Another avatar change is still running."
	end
	Avatar.busy = true
	Avatar.notify()
	local ran, ok, message, extra = pcall(fn)
	Avatar.busy = false
	Avatar.notify()
	if not ran then
		Util.log("error", "avatar operation: " .. tostring(ok))
		return false, "Unexpected error: " .. Util.cap(tostring(ok), 80)
	end
	return ok, message, extra
end

-- yields. The real work of "wear this user". Only call inside Avatar.exclusive.
local function wearUser(userId, name)
	local humanoid, _, problem = Avatar.character()
	if not humanoid then
		return false, problem
	end
	say("working", "Fetching " .. (name or ("user " .. userId)) .. "'s outfit...")
	local description, lookupError = Avatar.description(userId)
	if not description then
		return false, "Roblox refused the outfit lookup (" .. Util.cap(tostring(lookupError), 60) .. ")."
	end
	-- the character can respawn while we waited for the network, so fetch it again
	local liveHumanoid, character, stale = Avatar.character()
	if not liveHumanoid then
		return false, stale
	end
	say("working", "Applying the outfit...")
	local applied, how = Avatar.applyDescription(liveHumanoid, description)
	if applied then
		Avatar.dropLocal(true)
		refreshAnimate(character)
		Avatar.current = userId
		return true, "Applied with " .. how .. ".", "The experience decides who can see it and whether it survives a respawn."
	end
	local ok, message, extra = Avatar.wearLocal(description, LOOK_ALL, nil)
	if ok then
		Avatar.current = userId
	end
	return ok, message, extra
end

-- yields. Resolves a typed ID / username, then applies that look.
function Avatar.changeTo(text)
	return Avatar.exclusive(function()
		say("working", "Looking up " .. Util.cap(text, 24) .. "...")
		local userId, name = Avatar.resolve(text)
		if not userId then
			return false, name
		end
		sawUser(userId, name)
		Store.set("lastTarget", tostring(userId))
		return wearUser(userId, name)
	end)
end

-- yields. Applies a look for a user that is already known (favourites).
function Avatar.changeToId(userId, name)
	return Avatar.exclusive(function()
		sawUser(userId, name or Avatar.names[userId])
		Store.set("lastTarget", tostring(userId))
		return wearUser(userId, name or Avatar.names[userId])
	end)
end

-- yields. Picks random IDs until one belongs to a real account, then applies it.
function Avatar.randomUser()
	return Avatar.exclusive(function()
		for attempt = 1, 6 do
			local userId = math.random(10000000, 500000000)
			say("working", string.format("Finding a random player (try %d of 6)...", attempt))
			local name = Avatar.nameFor(userId)
			if name then
				sawUser(userId, name)
				return wearUser(userId, name)
			end
			task.wait(0.3)
		end
		return false, "Could not find an available random player. Try again."
	end)
end

-- yields. Puts your own outfit back.
function Avatar.restoreOwn()
	local player = Players.LocalPlayer
	if not player then
		return false, "There is no local player."
	end
	return Avatar.exclusive(function()
		local _, character = Avatar.character()
		-- a client-side look made in this run: put the character's own pieces back (instant, no network)
		if character and Avatar.stateFor(character) then
			Avatar.restoreLocal()
			return true, "Your original look was restored.", "Everything the hub changed on your screen was put back."
		end
		-- nothing to undo here. If an earlier run of the hub (or a successful engine change) altered the character,
		-- rebuild the player's own avatar from the account instead.
		local leftovers = character ~= nil and hasLeftovers(character)
		if Avatar.current == nil and not leftovers then
			return true, "Nothing to reset: your character still shows its own look."
		end
		local shown = player.DisplayName
		if shown == nil or shown == "" then
			shown = player.Name
		end
		local ok, message, extra = wearUser(player.UserId, shown)
		if ok then
			adoptLook()
			Avatar.current = nil
			message = "Your own avatar was restored."
		end
		return ok, message, extra
	end)
end

-- yields. expectedType: 11 = Shirt, 12 = Pants. Unverifiable IDs are allowed through (flagged).
function Avatar.checkAsset(assetId, expectedType, label)
	if not MarketplaceService then
		return true, false
	end
	local ok, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, assetId, Enum.InfoType.Asset)
	if not ok or type(info) ~= "table" then
		return true, false
	end
	local actual = info.AssetTypeId
	if type(actual) == "number" and actual ~= expectedType then
		return false, string.format("%s ID %d is not a %s item.", label, assetId, string.lower(label))
	end
	return true, true
end

-- yields. Classic clothing. Either id may be nil.
function Avatar.applyClothing(shirtId, pantsId)
	if not shirtId and not pantsId then
		return false, "Enter a Shirt ID, a Pants ID, or both."
	end
	return Avatar.exclusive(function()
		local unverified = false
		if shirtId then
			say("working", "Checking the shirt...")
			local ok, detail = Avatar.checkAsset(shirtId, 11, "Shirt")
			if not ok then
				return false, detail
			end
			unverified = unverified or detail == false
		end
		if pantsId then
			say("working", "Checking the pants...")
			local ok, detail = Avatar.checkAsset(pantsId, 12, "Pants")
			if not ok then
				return false, detail
			end
			unverified = unverified or detail == false
		end
		local humanoid, _, problem = Avatar.character()
		if not humanoid then
			return false, problem
		end
		local doneText = unverified and "Clothing applied (the IDs could not be verified with Roblox)." or "Clothing applied."
		-- 1) the engine path (only where Roblox lets this client change the character)
		if not Avatar.blocked[humanoid] then
			local gotDescription, description = pcall(humanoid.GetAppliedDescription, humanoid)
			if gotDescription and typeof(description) == "Instance" then
				if shirtId then
					description.Shirt = shirtId
				end
				if pantsId then
					description.Pants = pantsId
				end
				say("working", "Applying clothing...")
				local applied = Avatar.applyDescription(humanoid, description)
				if applied then
					Avatar.dropLocal(true)
					local _, character = Avatar.character()
					if character then
						refreshAnimate(character)
					end
					return true, doneText
				end
			end
		end
		-- 2) client-side: build only the requested clothing on a client-only rig and copy it onto the character
		local wanted = Instance.new("HumanoidDescription")
		local must = {}
		if shirtId then
			wanted.Shirt = shirtId
			must[#must + 1] = { class = "Shirt", label = "Shirt", id = shirtId }
		end
		if pantsId then
			wanted.Pants = pantsId
			must[#must + 1] = { class = "Pants", label = "Pants", id = pantsId }
		end
		local ok, message, extra = Avatar.wearLocal(wanted, { shirt = shirtId ~= nil, pants = pantsId ~= nil }, must)
		pcall(wanted.Destroy, wanted)
		if ok then
			message = "Clothing applied on your screen."
			if unverified then
				message = "Clothing applied on your screen (the IDs could not be verified with Roblox)."
			end
		end
		return ok, message, extra
	end)
end

----------------------------------------------------------------------------------------------------
-- favourites
----------------------------------------------------------------------------------------------------
function Avatar.addFavorite(userId)
	local list = Util.copy(Store.get("favorites"))
	if Util.indexOf(list, userId) then
		return false, "Already in your favourites."
	end
	if #list >= 60 then
		return false, "Favourites are full (60)."
	end
	list[#list + 1] = userId
	Store.set("favorites", list)
	return true
end

function Avatar.removeFavorite(userId)
	local list = Util.copy(Store.get("favorites"))
	local index = Util.indexOf(list, userId)
	if not index then
		return false
	end
	table.remove(list, index)
	Store.set("favorites", list)
	return true
end

----------------------------------------------------------------------------------------------------
-- Avatar page
----------------------------------------------------------------------------------------------------
local FAV_RIGHT = 134 -- pixels reserved on the right of a favourites row (Apply + remove)

-- A set of buttons laid out in 1-3 rows. On a narrow page they wrap onto their own lines so no label is ever cut off.
-- plans: widest first; each is { minWidth = pageWidth, slots = { { row, widthScale, widthOffset }, ... } } (one slot per button).
local function buttonRows(parent, name, order, rowCount, plans)
	local host = Util.new("Frame", {
		Name = name, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order,
	}, parent)
	Util.list(host, 8)
	local set = { host = host, rows = {}, items = {}, plans = plans }
	for index = 1, rowCount do
		local row = Util.new("Frame", {
			Name = "Row" .. index, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 36), LayoutOrder = index, Visible = index == 1,
		}, host)
		Util.list(row, 8, true)
		set.rows[index] = row
	end
	function set.place(pageWidth)
		pageWidth = pageWidth or 400
		local plan = plans[#plans]
		for _, candidate in ipairs(plans) do
			if pageWidth >= candidate.minWidth then
				plan = candidate
				break
			end
		end
		local used = {}
		for index, button in ipairs(set.items) do
			local slot = plan.slots[index]
			if slot then
				local inst = button.Instance
				inst.Parent = set.rows[slot[1]]
				inst.Size = UDim2.new(slot[2], slot[3], 1, 0)
				used[slot[1]] = true
			end
		end
		for index, row in ipairs(set.rows) do
			row.Visible = used[index] == true
		end
	end
	function set.add(button)
		set.items[#set.items + 1] = button
		return button
	end
	Pages.gridUpdaters[#Pages.gridUpdaters + 1] = set.place
	return set
end

function Avatar.buildPage(page)
	local ui = {}
	Avatar.ui = ui
	Avatar.init()
	local buttons = {}      -- every button that must be disabled while an operation runs
	local rowButtons = {}   -- favourites rows' Apply buttons (rebuilt with the list)
	local renderedCurrent = nil
	local savingFavorite = false

	-- status line -------------------------------------------------------------------------------
	local statusRoles = { idle = "Muted", working = "Accent", ok = "Green", error = "Danger" }
	local function setStatus(kind, text)
		if not ui.status then
			return
		end
		ui.status.Text = tostring(text)
		Theme.tweenRole(ui.status, "TextColor3", statusRoles[kind] or "Muted", 0.2)
	end

	local function setBusyLook()
		local busy = Avatar.busy
		local reason = busy and "Please wait for the current avatar change to finish." or nil
		for _, button in ipairs(buttons) do
			button.SetEnabled(not busy, reason)
		end
		for _, button in ipairs(rowButtons) do
			button.SetEnabled(not busy, reason)
		end
	end

	-- runs a yielding avatar action with status + toast feedback
	local function run(action)
		if Avatar.busy then
			Notify.warn("Please wait", "Another avatar change is still running.")
			return
		end
		task.spawn(function()
			local ok, message, extra = action()
			message = tostring(message or "")
			if ok then
				setStatus("ok", extra and (message .. " " .. extra) or message)
				Notify.success("Avatar updated", Util.cap(message, 110))
			else
				setStatus("error", message)
				Notify.error("Avatar change failed", Util.cap(message, 120))
			end
		end)
	end

	Avatar.hooks.status = setStatus

	-- target card -------------------------------------------------------------------------------
	UI.section(page, "Change avatar", 1)
	local card = UI.card({
		parent = page, order = 2, stack = true, controlHeight = 0, name = "TargetCard",
		title = "Copy a player's look",
		desc = "Type a user ID or username. VirexHub fetches that player's outfit and puts it on your character on this device. Roblox only lets the server change a real avatar, so only you see it and respawning resets it.",
	})
	local box = card.Controls
	box.AutomaticSize = Enum.AutomaticSize.Y
	box.Size = UDim2.new(1, 0, 0, 0)
	Util.list(box, 8)

	local function submit()
		local text = ui.input.Get()
		local kind, reason = Avatar.parseTarget(text)
		if not kind then
			ui.input.Flash()
			setStatus("error", reason)
			Notify.warn("Check the target", reason)
			return
		end
		run(function()
			return Avatar.changeTo(text)
		end)
	end

	local inputRow = Util.new("Frame", { Name = "InputRow", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 1 }, box)
	ui.input = UI.input({
		parent = inputRow, size = UDim2.new(1, -92, 1, 0), placeholder = "User ID or username", maxLength = 24, name = "Target",
		text = Store.get("lastTarget"),
		onSubmit = function(_, enter)
			if enter then
				submit()
			end
		end,
	})
	ui.apply = UI.button({
		parent = inputRow, text = "Apply", kind = "primary", size = UDim2.fromOffset(84, 38), anchor = Vector2.new(1, 0),
		position = UDim2.new(1, 0, 0, 0), name = "Apply", onClick = submit,
	})
	buttons[#buttons + 1] = ui.apply

	-- preview of the last player that was looked up (validation feedback) -----------------------
	local preview = Util.new("Frame", { Name = "Preview", BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 52), LayoutOrder = 2 }, box)
	Util.corner(preview, 10)
	Theme.bind(preview, "BackgroundColor3", "Panel")
	local previewStroke = Util.stroke(preview, nil, 1, 0.25)
	Theme.bind(previewStroke, "Color", "Border")
	ui.thumb = Util.new("ImageLabel", {
		Name = "Thumb", Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(36, 36), BorderSizePixel = 0, Image = "",
	}, preview)
	Util.round_corner(ui.thumb)
	Theme.bind(ui.thumb, "BackgroundColor3", "Track")
	ui.previewName = Util.new("TextLabel", {
		Name = "Name", BackgroundTransparency = 1, Position = UDim2.fromOffset(54, 8), Size = UDim2.new(1, -64, 0, 18),
		Text = "No player yet", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, preview)
	Typo.apply(ui.previewName, "heading", 13)
	Theme.bind(ui.previewName, "TextColor3", "Text")
	ui.previewSub = Util.new("TextLabel", {
		Name = "Sub", BackgroundTransparency = 1, Position = UDim2.fromOffset(54, 27), Size = UDim2.new(1, -64, 0, 16),
		Text = "Press Apply first.", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, preview)
	Typo.apply(ui.previewSub, "caption", 11)
	Theme.bind(ui.previewSub, "TextColor3", "Muted")

	local previewId = nil
	local function showPreview(userId, name)
		previewId = userId
		ui.thumb.Image = Avatar.thumb(userId)
		ui.previewName.Text = name or ("User " .. userId)
		local worn = Avatar.current == userId
		ui.previewSub.Text = "ID " .. userId .. (worn and "  -  worn now" or "")
		Theme.tweenRole(ui.previewSub, "TextColor3", worn and "Accent" or "Muted", 0.2)
		Theme.tweenRole(previewStroke, "Color", worn and "Accent" or "Border", 0.2)
	end
	Avatar.hooks.resolved = showPreview

	-- action row ---------------------------------------------------------------------------------
	local actions = buttonRows(box, "Actions", 3, 3, {
		{ minWidth = 410, slots = { { 1, 1 / 3, -6 }, { 1, 1 / 3, -6 }, { 1, 1 / 3, -6 } } },
		{ minWidth = 270, slots = { { 1, 0.5, -4 }, { 1, 0.5, -4 }, { 2, 1, 0 } } },
		{ minWidth = 0, slots = { { 1, 1, 0 }, { 2, 1, 0 }, { 3, 1, 0 } } },
	})
	local function actionButton(text, order, handler)
		local button = UI.button({
			parent = actions.rows[1], text = text, small = true, order = order, size = UDim2.new(1 / 3, -6, 1, 0), onClick = handler,
		})
		buttons[#buttons + 1] = button
		return actions.add(button)
	end
	actionButton("Random", 1, function()
		run(function()
			return Avatar.randomUser()
		end)
	end)
	actionButton("Reset to mine", 2, function()
		run(function()
			return Avatar.restoreOwn()
		end)
	end)
	actionButton("Save favourite", 3, function()
		if savingFavorite then
			return
		end
		local text = ui.input.Get()
		local kind, reason = Avatar.parseTarget(text)
		if not kind then
			ui.input.Flash()
			Notify.warn("Check the target", reason)
			return
		end
		savingFavorite = true
		task.spawn(function()
			local userId, name = Avatar.resolve(text)
			savingFavorite = false
			if not userId then
				ui.input.Flash()
				Notify.error("User not found", Util.cap(name, 110))
				return
			end
			showPreview(userId, name)
			local added, why = Avatar.addFavorite(userId)
			if added then
				Notify.success("Saved", name .. " was added to your favourites.")
			else
				Notify.info("Not saved", why or "Already saved.")
			end
		end)
	end)

	actions.place(Win.pageW)

	ui.status = Util.new("TextLabel", {
		Name = "Status", BackgroundTransparency = 1, LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Text = "Ready.", TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, box)
	Typo.apply(ui.status, "caption", 12)
	Theme.bind(ui.status, "TextColor3", "Muted")

	-- clothing ------------------------------------------------------------------------------------
	UI.section(page, "Clothing", 3)
	local clothes = UI.card({
		parent = page, order = 4, stack = true, controlHeight = 0, name = "ClothingCard", title = "Classic shirt and pants",
		desc = "Paste the item ID from the catalog link (the number in the URL). Leave one empty to keep it unchanged. Each ID is checked with Roblox first. Shown on your screen only.",
	})
	local cbox = clothes.Controls
	cbox.AutomaticSize = Enum.AutomaticSize.Y
	cbox.Size = UDim2.new(1, 0, 0, 0)
	Util.list(cbox, 8)
	local clothRow = Util.new("Frame", { Name = "Ids", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 1 }, cbox)
	Util.new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8),
	}, clothRow)
	ui.shirt = UI.input({
		parent = clothRow, size = UDim2.new(0.5, -4, 1, 0), placeholder = "Shirt ID", numeric = true, maxLength = 13, order = 1, name = "Shirt",
	})
	ui.pants = UI.input({
		parent = clothRow, size = UDim2.new(0.5, -4, 1, 0), placeholder = "Pants ID", numeric = true, maxLength = 13, order = 2, name = "Pants",
	})
	local clothAction = buttonRows(cbox, "Buttons", 2, 2, {
		{ minWidth = 300, slots = { { 1, 0.5, -4 }, { 1, 0.5, -4 } } },
		{ minWidth = 0, slots = { { 1, 1, 0 }, { 2, 1, 0 } } },
	})
	buttons[#buttons + 1] = clothAction.add(UI.button({
		parent = clothAction.rows[1], text = "Apply clothing", kind = "primary", small = true, order = 1, size = UDim2.new(0.5, -4, 1, 0),
		onClick = function()
			local shirt, pants = tonumber(ui.shirt.Get()), tonumber(ui.pants.Get())
			if shirt and shirt < 1 then
				shirt = nil
			end
			if pants and pants < 1 then
				pants = nil
			end
			if not shirt and not pants then
				ui.shirt.Flash()
				ui.pants.Flash()
				Notify.warn("Nothing to apply", "Enter a Shirt ID, a Pants ID, or both.")
				return
			end
			run(function()
				return Avatar.applyClothing(shirt, pants)
			end)
		end,
	}))
	buttons[#buttons + 1] = clothAction.add(UI.button({
		parent = clothAction.rows[1], text = "Restore my outfit", kind = "ghost", small = true, order = 2, size = UDim2.new(0.5, -4, 1, 0),
		onClick = function()
			run(function()
				return Avatar.restoreOwn()
			end)
		end,
	}))
	clothAction.place(Win.pageW)

	-- favourites ----------------------------------------------------------------------------------
	UI.section(page, "Favourites", 5)
	local listHost = Util.new("Frame", {
		Name = "Favorites", BackgroundTransparency = 1, LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
	}, page)
	Util.list(listHost, 8)

	local function renderFavorites()
		for _, child in ipairs(listHost:GetChildren()) do
			if not child:IsA("UIListLayout") then
				child:Destroy()
			end
		end
		rowButtons = {}
		UI.prune()
		renderedCurrent = Avatar.current
		local list = Store.get("favorites")
		if #list == 0 then
			UI.card({
				parent = listHost, order = 1, name = "Empty", title = "No favourites yet",
				desc = "Type a player above and press 'Save favourite' to keep them here for one-tap use.",
			})
			return
		end
		local pending = {}
		for index, userId in ipairs(list) do
			local worn = Avatar.current == userId
			local row = Util.new("Frame", { Name = "Fav" .. userId, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 60), LayoutOrder = index }, listHost)
			Theme.surface(row, "Card", "card")
			Util.corner(row, 12)
			local stroke = Util.stroke(row, nil, worn and 1.5 or 1, worn and 0 or 0.15)
			Theme.bind(stroke, "Color", worn and "Accent" or "Border")
			local picture = Util.new("ImageLabel", {
				Name = "Thumb", Position = UDim2.fromOffset(10, 8), Size = UDim2.fromOffset(44, 44), BorderSizePixel = 0,
				Image = Avatar.thumb(userId),
			}, row)
			Util.round_corner(picture)
			Theme.bind(picture, "BackgroundColor3", "Track")
			local nameLabel = Util.new("TextLabel", {
				Name = "Name", BackgroundTransparency = 1, Position = UDim2.fromOffset(64, 10), Size = UDim2.new(1, -(64 + FAV_RIGHT), 0, 20),
				Text = Avatar.names[userId] or ("User " .. userId), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			Typo.apply(nameLabel, "heading", 13)
			Theme.bind(nameLabel, "TextColor3", "Text")
			local idLabel = Util.new("TextLabel", {
				Name = "Id", BackgroundTransparency = 1, Position = UDim2.fromOffset(64, 31), Size = UDim2.new(1, -(64 + FAV_RIGHT), 0, 18),
				Text = "ID " .. userId .. (worn and "  -  worn now" or ""), TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			Typo.apply(idLabel, "caption", 11)
			Theme.bind(idLabel, "TextColor3", worn and "Accent" or "Muted")
			if not Avatar.names[userId] then
				pending[#pending + 1] = { id = userId, label = nameLabel }
			end
			local wear = UI.button({
				parent = row, text = worn and "Worn" or "Apply", small = true, kind = worn and "secondary" or "primary",
				size = UDim2.fromOffset(70, 34), anchor = Vector2.new(1, 0.5), position = UDim2.new(1, -52, 0.5, 0), name = "Wear",
				onClick = function()
					run(function()
						return Avatar.changeToId(userId, Avatar.names[userId])
					end)
				end,
			})
			rowButtons[#rowButtons + 1] = wear
			UI.button({
				parent = row, text = "", icon = "close", kind = "ghost", size = UDim2.fromOffset(34, 34), anchor = Vector2.new(1, 0.5),
				position = UDim2.new(1, -10, 0.5, 0), name = "Remove", sound = "close", onClick = function()
					if Avatar.removeFavorite(userId) then
						Notify.info("Removed", (Avatar.names[userId] or ("User " .. userId)) .. " was removed from favourites.")
					end
				end,
			})
		end
		setBusyLook()
		if #pending > 0 then
			-- one slow worker instead of 60 parallel requests; stops when the list is rebuilt
			Avatar.nameToken = (Avatar.nameToken or 0) + 1
			local token = Avatar.nameToken
			task.spawn(function()
				for _, entry in ipairs(pending) do
					if token ~= Avatar.nameToken then
						return
					end
					local name = Avatar.nameFor(entry.id)
					if name and entry.label.Parent then
						entry.label.Text = name
					end
					task.wait(0.12)
				end
			end)
		end
	end
	ui.render = renderFavorites
	renderFavorites()

	Avatar.onChange(function()
		if not listHost.Parent then
			return
		end
		setBusyLook()
		if Avatar.current ~= renderedCurrent then
			renderFavorites()
			if previewId then
				showPreview(previewId, Avatar.names[previewId])
			end
		end
	end)
	Store.on("favorites", function()
		if listHost.Parent then
			renderFavorites()
		end
	end)
	return ui
end
end -- [10_avatar.lua]

do -- [11_window.lua]

----------------------------------------------------------------------------------------------------
-- Win: the hub window and its floating logo.
--   Window    positioning container (top-centre anchored, UIScale = user scale x fit), holds the shadow
--   Surface   the visible rounded panel (clips everything)
--     BgLayer / Body (title bar + page title + pages + footer) / popup layer / modal layer   (no sidebar)
--   Launcher  the draggable VIREX logo. Tap it and ONLY the radial tab ring opens around it (tap it again to
--             close the ring). The window, that tab's menu, opens when a tab in the ring is tapped.
--             HIDE MENU (top right of the window) hides the window; logo -> tab brings it back.
-- The window keeps its CENTRE when it opens or closes, by tweening Position, Size and Scale together
-- with identical easing.
----------------------------------------------------------------------------------------------------
Win.TITLE_H = 0               -- height of a collapsed window (the window is hidden now, never collapsed)
Win.HEADER_H = 44             -- the draggable title bar: keeps the window grabbable when it is dragged near an edge

-- SIZES (1 = the size of v2.1.0). Lower a number to make that part smaller, raise it to make it bigger.
Win.SHRINK = 0.8              -- window size multiplier (on top of Settings > UI scale)
Win.MAX_W_FRAC = 0.8          -- the window never takes more than this share of the screen width ...
Win.MAX_H_FRAC = 0.84         -- ... or height, so the logo and the game stay visible around it
Win.LOGO_SCALE = 0.84         -- logo + tab ring size multiplier (it was 1.05 in v2.1.0)
Win.CLOSE_RING_ON_PICK = true -- close the tab ring after a tab is tapped, so the ring never covers the menu
Win.COLLAPSED_W = 320
Win.visible = false
Win.minimized = false
Win.x, Win.top = 0, 0         -- top-centre of the window in screen pixels (canonical target)
Win.w, Win.h, Win.s = 760, 510, 1
Win.rail, Win.short = false, false
Win.itemH, Win.gap = 40, 6
Win.ui = {}
Win.nav = {}
Win.pages = {}
Win.currentTab = nil
Win.layoutListeners = {}
Win.focusToken = 0
Win.kbShift = 0
Win.userMoved = false         -- true once the player has dragged the window; until then it stays centred
Win.lastViewport = nil
Win.ringOpen = false         -- the radial tab ring around the logo is open
Win.launcher = nil            -- { root, scale, ring, pop, hub, shown }: the draggable logo
Win.radial = nil              -- { wedges }: nil when the ring could not be built

Win.tabList = {
	{ id = "overview", title = "Overview", desc = "Your current session at a glance.", icon = "grid" },
	{ id = "scripts", title = "Scripts", desc = "Browse, check and run the script catalog.", icon = "scripts" },
	{ id = "music", title = "Music", desc = "Phonk, funk and Spotify playlists.", icon = "music" },
	{ id = "avatar", title = "Avatar", desc = "Try looks, clothing and favourites.", icon = "user" },
	{ id = "appearance", title = "Appearance", desc = "Theme, fonts and motion.", icon = "sparkle" },
	{ id = "background", title = "Background", desc = "Image, overlay and transparency.", icon = "image" },
	{ id = "tools", title = "Tools", desc = "Interface and Roblox actions.", icon = "sliders" },
	{ id = "settings", title = "Settings", desc = "Notifications, sound, scale and more.", icon = "gear" },
	{ id = "information", title = "Information", desc = "What's new, controls, status and notices.", icon = "info" },
}
Win.tabById, Win.tabIndex = {}, {}
for index, def in ipairs(Win.tabList) do
	Win.tabById[def.id] = def
	Win.tabIndex[def.id] = index
end

----------------------------------------------------------------------------------------------------
-- Radial tab ring: geometry only (plain maths, no Roblox objects).
-- Roblox has no polygon / pie-slice object, and this hub uses no image assets, so every wedge is built
-- from rotated rectangles:
--   * two EDGE BANDS run parallel to the wedge's two straight sides (this gives the constant-width gap),
--   * a fan of narrow STRIPS pointing at the ring centre fills the rest; their ends are tangent to the
--     circle, so the rim and the hole for the hub stay round.
-- Angles are degrees measured clockwise from the top, which is also how GuiObject.Rotation works.
-- All numbers are in "design units" (the ring is designed at Win.RADIAL.size and scaled to fit).
----------------------------------------------------------------------------------------------------
Win.RADIAL = {
	size = 200,      -- design diameter of the whole ring
	outer = 97,      -- outer radius of the wedges
	inner = 34,      -- inner radius of the wedges (the logo hub sits inside)
	hub = 28,        -- radius of the logo hub
	gap = 3,         -- constant gap between neighbouring wedges
	band = 14,       -- width of the two edge bands of a wedge
	strip = 8,       -- width of the fan strips
	margin = 1.5,    -- icons and labels keep this far from a wedge edge
	iconSize = 18,
	labelW = 56,
	labelH = 12,
	align = 7,       -- the icon may sit this far off the label's centre line
}

-- Free horizontal run [left, right] of a wedge at height y (y measured UP from the ring centre).
-- Returns nil when the wedge has no room at that height. `hint` picks the nearer run when the
-- wedge is split by the hub hole.
function Win.radialRun(a0, a1, y, hint)
	local R = Win.RADIAL
	local rad, sin, cos = math.rad, math.sin, math.cos
	local need = R.gap / 2 + R.margin
	local lo, hi = -math.huge, math.huge
	local normals = {
		{ cos(rad(a0)), -sin(rad(a0)) },
		{ -cos(rad(a1)), sin(rad(a1)) },
	}
	for _, n in ipairs(normals) do
		local rhs = need - n[2] * y
		if math.abs(n[1]) < 1e-9 then
			if rhs > 0 then
				return nil
			end
		elseif n[1] > 0 then
			lo = math.max(lo, rhs / n[1])
		else
			hi = math.min(hi, rhs / n[1])
		end
	end
	local outer = R.outer - R.margin
	local o2 = outer * outer - y * y
	if o2 <= 0 then
		return nil
	end
	local xo = math.sqrt(o2)
	lo, hi = math.max(lo, -xo), math.min(hi, xo)
	local inner = R.inner + R.margin
	local i2 = inner * inner - y * y
	if i2 > 0 then
		local xi = math.sqrt(i2)
		local aHi, bLo = math.min(hi, -xi), math.max(lo, xi)
		local aw, bw = aHi - lo, hi - bLo
		if aw <= 0 and bw <= 0 then
			return nil
		end
		if aw > 0 and bw > 0 then
			if math.abs((lo + aHi) / 2 - hint) > math.abs((bLo + hi) / 2 - hint) then
				return bLo, hi
			end
			return lo, aHi
		elseif aw > 0 then
			return lo, aHi
		end
		return bLo, hi
	end
	if hi - lo <= 0 then
		return nil
	end
	return lo, hi
end

-- Plan for `count` wedges. The first wedge is centred on the top and the rest follow clockwise.
-- Every wedge: pieces = { {cx, cy, w, h, rotation}, ... } (centre offsets from the ring centre, y down),
-- icon = {x, y}, label = {x, y, w}.
function Win.radialPlan(count)
	local R = Win.RADIAL
	local rad, sin, cos = math.rad, math.sin, math.cos
	local delta = 360 / count
	local half = delta / 2
	local g2 = R.gap / 2
	local plan = {}

	-- smallest angle from a wedge edge at which a fan strip still clears the gap (even at the hole)
	local phi = 4
	while phi < half do
		if R.inner * sin(rad(phi)) - (R.strip / 2) * cos(rad(phi)) >= g2 + 0.4 then
			break
		end
		phi = phi + 0.25
	end
	local bandW = math.max(4, math.min(R.band, R.inner * sin(rad(delta)) - 2 * g2 - 0.5))
	local s0 = math.sqrt(R.inner * R.inner - g2 * g2)
	local lateral = g2 + bandW / 2
	local s1 = math.sqrt(R.outer * R.outer - lateral * lateral)
	local sMid = (s0 + s1) / 2
	local fanSpan = delta - 2 * phi
	local fanSteps = 0
	if fanSpan > 0 then
		fanSteps = math.max(1, math.ceil(fanSpan / math.deg((R.strip - 1) / R.outer)))
	end
	local radialMid = (R.inner + R.outer) / 2
	local stack = R.iconSize + 2 + R.labelH

	for k = 1, count do
		local a0 = (k - 1) * delta - half
		local a1 = a0 + delta
		local mid = a0 + half
		local pieces = {}

		-- edge bands (parallel to the straight sides, offset by half the gap)
		pieces[#pieces + 1] = {
			sin(rad(a0)) * sMid + cos(rad(a0)) * lateral,
			-cos(rad(a0)) * sMid + sin(rad(a0)) * lateral,
			bandW, s1 - s0, a0,
		}
		pieces[#pieces + 1] = {
			sin(rad(a1)) * sMid - cos(rad(a1)) * lateral,
			-cos(rad(a1)) * sMid - sin(rad(a1)) * lateral,
			bandW, s1 - s0, a1,
		}
		-- fan strips pointing at the centre
		if fanSteps > 0 then
			for i = 0, fanSteps do
				local alpha = a0 + phi + fanSpan * i / fanSteps
				pieces[#pieces + 1] = {
					sin(rad(alpha)) * radialMid, -cos(rad(alpha)) * radialMid,
					R.strip, R.outer - R.inner, alpha,
				}
			end
		end

		-- icon + label: one stack, one x. Upper wedges put the label on top (the wedge is wider towards the
		-- rim), the others put the icon on top. The stack slides along the wedge to the roomiest spot.
		local cx, cy = radialMid * sin(rad(mid)), radialMid * cos(rad(mid)) -- centroid, y up
		local labelOnTop = cos(rad(mid)) > 0.3
		local function rows(yTop, yBottom)
			local lo, hi = -math.huge, math.huge
			for i = 0, 2 do
				local a, b = Win.radialRun(a0, a1, yTop + (yBottom - yTop) * i / 2, cx)
				if not a then
					return nil
				end
				lo, hi = math.max(lo, a), math.min(hi, b)
			end
			if hi <= lo then
				return nil
			end
			return lo, hi
		end
		local best
		for dy = -26, 26, 1 do
			local top = cy + dy + stack / 2
			local iconY, labelY
			if labelOnTop then
				labelY = top - R.labelH / 2
				iconY = top - R.labelH - 2 - R.iconSize / 2
			else
				iconY = top - R.iconSize / 2
				labelY = top - R.iconSize - 2 - R.labelH / 2
			end
			local llo, lhi = rows(labelY + R.labelH / 2, labelY - R.labelH / 2)
			local ilo, ihi = rows(iconY + R.iconSize / 2, iconY - R.iconSize / 2)
			if llo and ilo then
				-- label sits in the middle of its run; the icon follows it, within R.align, and inside its own run
				local lx = (llo + lhi) / 2
				local xmin, xmax = ilo + R.iconSize / 2, ihi - R.iconSize / 2
				if xmin <= xmax then
					local ix = math.max(xmin, math.min(xmax, lx))
					if math.abs(ix - lx) > R.align then
						-- pull the label towards the icon instead, as far as its own run allows
						local shift = (ix - lx) - (ix > lx and R.align or -R.align)
						lx = lx + shift
					end
					local room = 2 * math.min(lx - llo, lhi - lx)
					if room >= 30 then
						local score = math.min(room, R.labelW + 8) - 0.04 * math.abs(dy) - 0.05 * math.abs(lx - cx)
						if not best or score > best.score then
							best = { score = score, lx = lx, ix = ix, width = room, iconY = iconY, labelY = labelY }
						end
					end
				end
			end
		end
		local entry = { pieces = pieces, a0 = a0, a1 = a1, mid = mid }
		if best then
			entry.icon = { best.ix, -best.iconY }
			entry.label = { best.lx, -best.labelY, math.max(30, math.min(R.labelW, best.width)) }
			entry.score = best.width
		else
			entry.icon = { cx, -(cy + 8) }
			entry.label = { cx, -(cy - 10), R.labelW }
			entry.score = -99
		end
		plan[k] = entry
	end
	return plan
end

-- popups convert screen pixels to layout units with the window's live scale
UI.scale = function()
	local scaler = Win.scaler
	if scaler and scaler.Parent then
		return scaler.Scale
	end
	return 1
end

----------------------------------------------------------------------------------------------------
-- geometry
----------------------------------------------------------------------------------------------------
-- layout size (in layout units) and total scale for the current viewport / user scale / compact mode
function Win.computeLayout()
	local viewport = Env.viewport()
	local user = Store.get("scale") * Win.SHRINK
	local baseW, baseH = 640, 510 -- one column now (the sidebar is gone), so the window is narrower
	if Store.get("compact") then
		baseW, baseH = 580, 470
	end
	-- the window keeps to a share of the screen, so the logo and the game stay visible around it
	local availW = (viewport.X * Win.MAX_W_FRAC) / user
	local availH = (viewport.Y * Win.MAX_H_FRAC) / user
	local w, h = math.min(baseW, availW), math.min(baseH, availH)
	local minW, minH = 300, 270
	local fit = 1
	if w < minW or h < minH then
		fit = math.min(w / minW, h / minH)
		w, h = math.max(w, minW), math.max(h, minH)
	end
	return math.floor(w + 0.5), math.floor(h + 0.5), user * fit
end

-- size the window should have right now (collapsed to its title bar, or full)
function Win.currentTarget()
	if Win.minimized then
		return math.min(Win.w, Win.COLLAPSED_W), Win.TITLE_H
	end
	return Win.w, Win.h
end

-- keeps the window reachable. widthPx / heightPx are screen pixels.
-- Dragging may push part of the window off screen, but never so far that its title bar can't be grabbed again.
-- `strict` (after a rotation / scale change, on restore and on recentre) pulls the WHOLE window back inside the screen
-- whenever it fits, so a window that nearly fills the screen can't be left hanging over an edge.
function Win.clampPx(x, top, widthPx, heightPx, strict)
	local viewport = Env.viewport()
	local nx, maxTop
	if strict and widthPx <= viewport.X then
		nx = Util.clamp(x, widthPx / 2, viewport.X - widthPx / 2)
	else
		local keep = math.min(220, widthPx - 8)
		nx = Util.clamp(x, keep - widthPx / 2, viewport.X + widthPx / 2 - keep)
	end
	if strict and heightPx <= viewport.Y then
		maxTop = viewport.Y - heightPx
	else
		maxTop = viewport.Y - math.min(heightPx, Win.HEADER_H * Win.s)
	end
	local ny = Util.clamp(top, 0, math.max(0, maxTop))
	return nx, ny
end

-- animates position, size and scale together (same TweenInfo => same progress every frame)
function Win.glide(x, top, width, height, scale, duration, style, direction, onDone)
	local window, scaler = Win.window, Win.scaler
	if not window then
		return
	end
	Motion.tween(window, { Position = UDim2.fromOffset(x, top), Size = UDim2.fromOffset(width, height) }, duration, style, direction)
	Motion.tween(scaler, { Scale = scale }, duration, style, direction, onDone)
end

----------------------------------------------------------------------------------------------------
-- responsive layout: positions every region from (w, h). Immediate, no tweening.
----------------------------------------------------------------------------------------------------
function Win.refreshChrome()
	local ui = Win.ui
	if not ui.clock or not ui.brand then
		return
	end
	local clockOn = Store.get("clock") and Win.w >= 440
	ui.clock.Visible = clockOn
	-- the name in the title bar stops short of the clock and HIDE MENU
	local reserve = (Win.rail and 92 or 104) + 10 + (clockOn and 54 or 0)
	ui.brand.Size = UDim2.new(1, -(26 + reserve + 6), 0, 22)
	ui.pageTitle.Size = UDim2.new(1, -4, 0, Win.short and 22 or 24)
	ui.pageSub.Size = UDim2.new(1, -4, 0, 18)
end

function Win.applyLayout()
	local ui = Win.ui
	if not ui.body then
		return
	end
	local w, h = Win.w, Win.h
	local rail = w < 520 -- narrow window: smaller HIDE MENU button, no clock
	local short = h < 430
	Win.rail, Win.short = rail, short
	ui.body.Position = UDim2.fromOffset(0, 0)
	ui.body.Size = UDim2.fromOffset(w, h)

	-- one column, top to bottom: title bar (name, clock, HIDE MENU), page title, the page itself, footer
	local pad = 12
	local padTop = short and 6 or 8
	local barH = short and 28 or 32
	local titleH = short and 24 or 44
	local footerH = short and 20 or 24
	local headerH = barH + titleH
	ui.content.Position = UDim2.fromOffset(pad, padTop)
	ui.content.Size = UDim2.fromOffset(math.max(120, w - pad * 2), math.max(60, h - padTop - 5))
	Win.pageW = math.max(120, w - pad * 2) - 7 -- usable width of a page (its scroll bar padding removed)
	ui.handle.Size = UDim2.new(1, 0, 0, headerH)

	-- title bar: the name on the left, clock and HIDE MENU on the right
	ui.logoMark.Instance.Position = UDim2.fromOffset(2, barH / 2)
	ui.brand.Position = UDim2.fromOffset(26, barH / 2)
	Typo.apply(ui.brand, "title", short and 14 or 16)
	local hideW = rail and 92 or 104
	ui.hideButton.Instance.Size = UDim2.fromOffset(hideW, 26)
	ui.hideButton.Instance.Position = UDim2.new(1, 0, 0, (barH - 26) / 2)
	ui.clock.Position = UDim2.new(1, -(hideW + 10), 0, barH / 2)

	-- page title (its description only when there is room)
	Typo.apply(ui.pageTitle, "title", short and 16 or 20)
	ui.pageTitle.Position = UDim2.fromOffset(2, barH + (short and 1 or 2))
	ui.pageSub.Position = UDim2.fromOffset(2, barH + 26)
	ui.pageSub.Visible = not short

	-- the page itself and the footer under it
	ui.pageHost.Position = UDim2.fromOffset(0, headerH)
	ui.pageHost.Size = UDim2.new(1, 0, 1, -(headerH + footerH))
	ui.footer.Size = UDim2.new(1, 0, 0, footerH)

	Win.refreshChrome()
	for _, listener in ipairs(Util.copy(Win.layoutListeners)) do
		Util.try("layout listener", listener, w, h, rail, short)
	end
end

-- recompute everything for the current viewport / scale / compact setting
function Win.relayout(animate)
	local window = Win.window
	if not window then
		return
	end
	local w, h, s = Win.computeLayout()
	Win.w, Win.h, Win.s = w, h, s
	Win.applyLayout()
	local cw, ch = Win.currentTarget()
	local viewport = Env.viewport()
	local last = Win.lastViewport
	Win.lastViewport = viewport
	if not Win.userMoved then
		-- never dragged: stay centred whatever the screen / scale does (a collapsed window keeps its title bar's height)
		Win.x = viewport.X / 2
		if not Win.minimized then
			Win.top = math.max(10, (viewport.Y - ch * s) / 2)
		end
	elseif last and last.X > 0 and last.Y > 0 and (last.X ~= viewport.X or last.Y ~= viewport.Y) then
		-- dragged somewhere: keep the same relative spot after a rotation / resize
		Win.x = Win.x * viewport.X / last.X
		Win.top = Win.top * viewport.Y / last.Y
	end
	Win.x, Win.top = Win.clampPx(Win.x, Win.top, cw * s, ch * s, true)
	if animate and Win.visible then
		Win.glide(Win.x, Win.top, cw, ch, s, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	else
		Motion.set(window, { Position = UDim2.fromOffset(Win.x, Win.top), Size = UDim2.fromOffset(cw, ch) })
		Motion.set(Win.scaler, { Scale = s })
	end
	Win.placeLauncher(animate)
end

function Win.scheduleRelayout()
	Win.relayoutToken = (Win.relayoutToken or 0) + 1
	local token = Win.relayoutToken
	task.delay(0.12, function()
		if token == Win.relayoutToken then
			Win.relayout(true)
		end
	end)
end

function Win.onLayout(listener)
	Win.layoutListeners[#Win.layoutListeners + 1] = listener
end

----------------------------------------------------------------------------------------------------
-- tabs
----------------------------------------------------------------------------------------------------
-- the footer under the page: "<FooterName> - <tab name>"
function Win.updateFooter(title)
	local text = Win.ui.footerText
	if text then
		text.Text = CONFIG.FooterName .. (title and (" - " .. title) or "")
	end
end

function Win.selectTab(id, instant)
	local def, page = Win.tabById[id], Win.pages[id]
	if not def or not page or Win.currentTab == id then
		return false
	end
	UI.closeDropdown(true)
	local previous = Win.currentTab
	Win.currentTab = id
	local animate = (not instant) and (not Motion.reduced) and Win.visible
	Util.try("radial tab ring", Win.paintRadial, id, animate)

	local old = previous and Win.pages[previous]
	if old and old ~= page then
		Motion.cancel(old)
		old.Visible = false
		old.Position = UDim2.fromScale(0, 0)
	end
	page.Visible = true
	if animate then
		page.Position = UDim2.fromOffset(0, 16)
		Motion.tween(page, { Position = UDim2.fromScale(0, 0) }, 0.28, Enum.EasingStyle.Quart)
	else
		Motion.set(page, { Position = UDim2.fromScale(0, 0) })
	end

	local ui = Win.ui
	ui.pageTitle.Text = def.title
	ui.pageSub.Text = def.desc
	Win.updateFooter(def.title)
	if animate then
		ui.pageTitle.TextTransparency = 0.8
		ui.pageSub.TextTransparency = 0.8
		Motion.tween(ui.pageTitle, { TextTransparency = 0 }, 0.25)
		Motion.tween(ui.pageSub, { TextTransparency = 0 }, 0.32)
	end
	if previous then
		Sfx.play("tab")
	end
	return true
end

function Win.addPage(id)
	local page = UI.page(Win.ui.pageHost, id)
	Win.pages[id] = page
	return page
end

----------------------------------------------------------------------------------------------------
-- show / hide / minimize / recenter
----------------------------------------------------------------------------------------------------
function Win.show(instant)
	local window, scaler = Win.window, Win.scaler
	if not window or Win.visible then
		return
	end
	Win.visible = true
	window.Visible = true
	local cw, ch = Win.currentTarget()
	if instant or Motion.reduced then
		Motion.set(window, { Position = UDim2.fromOffset(Win.x, Win.top), Size = UDim2.fromOffset(cw, ch) })
		Motion.set(scaler, { Scale = Win.s })
	else
		local fromScale = Win.s * 0.9
		Motion.set(scaler, { Scale = fromScale })
		Motion.set(window, {
			Position = UDim2.fromOffset(Win.x, Win.top + ch * (Win.s - fromScale) / 2 + 10),
			Size = UDim2.fromOffset(cw, ch),
		})
		Win.glide(Win.x, Win.top, cw, ch, Win.s, 0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	end
	Sfx.play("open")
	Bg.syncBlur()
end

function Win.hide(instant)
	local window = Win.window
	if not window or not Win.visible then
		return
	end
	Win.visible = false
	Win.closeRing(instant, true)
	UI.closeDropdown(true)
	UI.closeModal(true)
	UI.endSessions()
	Sfx.play("close")
	local function finish()
		if not Win.visible and Win.window then
			Win.window.Visible = false
		end
	end
	if instant or Motion.reduced then
		finish()
	else
		local cw, ch = Win.currentTarget()
		local toScale = Win.s * 0.92
		Win.glide(Win.x, Win.top + ch * (Win.s - toScale) / 2 + 8, cw, ch, toScale, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In, finish)
	end
	Bg.syncBlur()
end

function Win.toggle()
	if Win.visible then
		Win.hideMenu()
	else
		Win.show()
	end
end

-- HIDE MENU: hides the window (and closes the tab ring). Tap the logo to bring the menu back.
function Win.hideMenu()
	Win.hide()
end

-- older callers asked for a collapsed window; the window is now simply hidden or shown
function Win.setMinimized(flag, instant)
	if flag then
		Win.hide(instant)
	else
		Win.show(instant)
	end
end

function Win.recenter()
	if not Win.window then
		return
	end
	local viewport = Env.viewport()
	local cw, ch = Win.currentTarget()
	Win.userMoved = false
	Win.lastViewport = viewport
	local x = viewport.X / 2
	local top = math.max(10, (viewport.Y - ch * Win.s) / 2)
	Win.x, Win.top = Win.clampPx(x, top, cw * Win.s, ch * Win.s, true)
	Win.kbShift = 0
	Win.glide(Win.x, Win.top, cw, ch, Win.s, 0.42, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	Win.resetLauncher()
end

-- there is no footer card any more; the notices are listed on the Information page
function Win.setStatus(text, role)
	Win.statusText, Win.statusRole = text, role
end

function Win.applyPerformance()
	local lowPower = Store.get("lowPower")
	for _, shadow in ipairs(Win.ui.shadows or {}) do
		shadow.Visible = not lowPower
	end
end

----------------------------------------------------------------------------------------------------
-- on-screen keyboard (Android): keep the focused text box visible
----------------------------------------------------------------------------------------------------
function Win.avoidKeyboard(holder)
	local visible = false
	pcall(function()
		visible = UserInputService.OnScreenKeyboardVisible
	end)
	if not visible or not Win.window then
		return
	end
	local ok, position = pcall(function()
		return UserInputService.OnScreenKeyboardPosition
	end)
	if not ok or typeof(position) ~= "Vector2" then
		return
	end
	local bottom = holder.AbsolutePosition.Y + holder.AbsoluteSize.Y + 14
	local overshoot = bottom - position.Y
	if overshoot <= 0 then
		return
	end
	local shift = math.min(overshoot, math.max(0, Win.top))
	if shift <= 0 then
		return
	end
	Win.kbShift = shift
	Motion.tween(Win.window, { Position = UDim2.fromOffset(Win.x, Win.top - shift) }, 0.24, Enum.EasingStyle.Quart)
end

function Win.releaseKeyboard()
	if Win.kbShift > 0 and Win.window then
		Win.kbShift = 0
		Motion.tween(Win.window, { Position = UDim2.fromOffset(Win.x, Win.top) }, 0.24, Enum.EasingStyle.Quart)
	end
end

-- called by UI.input
function Win.onInputFocus(holder, focused)
	if not Env.touch or not Win.window then
		return
	end
	Win.focusToken = Win.focusToken + 1
	local token = Win.focusToken
	if focused then
		task.delay(0.45, function()
			if token == Win.focusToken and holder.Parent then
				Win.avoidKeyboard(holder)
			end
		end)
	else
		Win.releaseKeyboard()
	end
end

----------------------------------------------------------------------------------------------------
-- construction
----------------------------------------------------------------------------------------------------
local function label(parent, props, role, size, color)
	local obj = Util.new("TextLabel", props, parent)
	Typo.apply(obj, role, size)
	if color then
		Theme.bind(obj, "TextColor3", color)
	end
	return obj
end

-- The page header: drag handle (move the window), clock and HIDE MENU. The page title and subtitle are
-- created next to it in Win.create.
local function buildHeader(content)
	local ui = Win.ui
	local handle = Util.new("TextButton", {
		Name = "DragHandle", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 58), ZIndex = 2,
	}, content)
	ui.handle = handle

	-- the name, top left (the old title bar's "VIREX / HUB"): a small logo mark and the text.
	-- They sit above the drag handle, so dragging them still moves the window.
	ui.logoMark = UI.icon("logo", content, 18, "Accent", {
		anchor = Vector2.new(0, 0.5), position = UDim2.fromOffset(2, 14), zindex = 3,
	})
	ui.brand = label(content, {
		Name = "Brand", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(26, 14),
		Size = UDim2.new(1, -150, 0, 22), Text = CONFIG.Title, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
	}, "title", 16, "Text")

	ui.clock = label(content, {
		Name = "Clock", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -122, 0, 19),
		Size = UDim2.fromOffset(52, 20), Text = os.date("%H:%M"), TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 4,
	}, "buttonSmall", 12, "Muted")

	-- HIDE MENU: hides the window; the logo brings it back
	local hide = UI.button({
		parent = content, name = "HideMenu", text = "HIDE MENU", kind = "ghost", small = true, sound = "close", zindex = 4,
		size = UDim2.fromOffset(112, 30), anchor = Vector2.new(1, 0), position = UDim2.new(1, 0, 0, 4),
		onClick = function()
			Win.hideMenu()
		end,
	})
	local outline = hide.Face:FindFirstChildOfClass("UIStroke")
	if outline then
		Theme.bind(outline, "Color", "Danger")
	end
	Theme.bind(hide.Label, "TextColor3", "Danger")
	ui.hideButton = hide

	-- dragging the header moves the window: threshold first, so a tap never moves it
	handle.InputBegan:Connect(function(input)
		if not UI.isPress(input) or not Win.window then
			return
		end
		Motion.cancel(Win.window, { Position = true })
		Win.releaseKeyboard()
		local startX, startTop = Win.window.Position.X.Offset, Win.window.Position.Y.Offset
		local origin = input.Position
		local moved = false
		UI.watchInput(input, function(i)
			local dx, dy = i.Position.X - origin.X, i.Position.Y - origin.Y
			if not moved then
				if math.abs(dx) + math.abs(dy) < 6 then
					return
				end
				moved = true
				Win.userMoved = true
				UI.closeDropdown(true)
			end
			local size = Win.window.AbsoluteSize
			local nx, ny = Win.clampPx(startX + dx, startTop + dy, size.X, size.Y)
			Win.x, Win.top = nx, ny
			Win.window.Position = UDim2.fromOffset(nx, ny)
		end)
	end)
end

----------------------------------------------------------------------------------------------------
-- The launcher: the draggable VIREX logo and the radial tab ring around it.
--   tap the logo      opens the ring around it (and closes it again); the logo is the hub of the ring
--   tap a wedge       shows that tab's page in the window
--   drag the logo     moves it (and the ring with it); the spot is remembered
-- The ring's shapes come from Win.radialPlan; every wedge is a group of rotated TextButtons, so a tap
-- anywhere on a wedge selects its tab. If the ring cannot be built for any reason, the logo steps
-- through the tabs instead, so the hub stays usable.
----------------------------------------------------------------------------------------------------
local function paintWedge(wedge, animate)
	local role, mixRole, mixT, ink = "Elevated", nil, nil, "Muted"
	if wedge.selected then
		role, ink = "Accent", "OnAccent"
		if wedge.pressed then
			mixRole, mixT = "Shine", 0.3
		elseif wedge.hover > 0 then
			mixRole, mixT = "Shine", 0.16
		end
	elseif wedge.pressed then
		mixRole, mixT, ink = "Text", 0.2, "Text"
	elseif wedge.hover > 0 then
		mixRole, mixT, ink = "Text", 0.1, "Text"
	end
	local seconds = animate and 0.18 or 0
	for _, piece in ipairs(wedge.pieces) do
		Theme.tweenRole(piece, "BackgroundColor3", role, seconds, mixRole, mixT)
	end
	wedge.icon.SetRole(ink, seconds)
	Theme.tweenRole(wedge.label, "TextColor3", ink, seconds)
end

-- screen pixels per design unit: the ring (200 units) must fit the screen, and follows the UI scale setting
function Win.launcherScale()
	local viewport = Env.viewport()
	local fit = (math.min(viewport.X, viewport.Y) - 12) / Win.RADIAL.size
	return math.max(0.5, math.min(Win.LOGO_SCALE * Store.get("scale"), fit))
end

-- keeps the logo (or, while the ring is open, the whole ring) on screen
function Win.clampLauncher(x, y, withRing)
	local viewport = Env.viewport()
	local R = Win.RADIAL
	local reach = (withRing and (R.outer + 4) or (R.hub + 6)) * Win.launcherScale()
	reach = math.min(reach, viewport.X / 2, viewport.Y / 2)
	return Util.clamp(x, reach, viewport.X - reach), Util.clamp(y, reach, viewport.Y - reach)
end

-- where the logo rests while the ring is closed (screen pixels)
function Win.launcherRest()
	local viewport = Env.viewport()
	local fx, fy = Store.get("logoX"), Store.get("logoY")
	if fx >= 0 and fy >= 0 then
		return fx * viewport.X, fy * viewport.Y
	end
	-- not placed yet: top right corner (the Roblox menu buttons are on the left)
	local hubR = Win.RADIAL.hub * Win.launcherScale()
	return viewport.X - hubR - 16, hubR + 14
end

function Win.placeLauncher(animate)
	local launcher = Win.launcher
	if not launcher or not launcher.root.Parent then
		return
	end
	local x, y = Win.launcherRest()
	x, y = Win.clampLauncher(x, y, Win.ringOpen)
	local seconds = animate and 0.25 or 0
	Motion.tween(launcher.scale, { Scale = Win.launcherScale() }, launcher.shown and seconds or 0)
	Motion.tween(launcher.root, { Position = UDim2.fromOffset(x, y) }, seconds, Enum.EasingStyle.Quart)
end

function Win.showLauncher()
	local launcher = Win.launcher
	if not launcher or launcher.shown then
		return
	end
	Win.placeLauncher(false)
	launcher.shown = true
	launcher.root.Visible = true
	local k = launcher.scale.Scale
	Motion.set(launcher.scale, { Scale = k * 0.5 })
	Motion.tween(launcher.scale, { Scale = k }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

function Win.saveLauncher()
	local launcher = Win.launcher
	if not launcher then
		return
	end
	local viewport = Env.viewport()
	Store.set("logoX", Util.clamp(launcher.root.Position.X.Offset / viewport.X, 0, 1))
	Store.set("logoY", Util.clamp(launcher.root.Position.Y.Offset / viewport.Y, 0, 1))
end

function Win.resetLauncher()
	Store.set("logoX", -1)
	Store.set("logoY", -1)
	Win.placeLauncher(true)
end

function Win.openRing(silent)
	local launcher = Win.launcher
	if not launcher or not launcher.ring or Win.ringOpen then
		return
	end
	Win.ringOpen = true
	Win.placeLauncher(true) -- slides the logo inwards when the ring would hang over a screen edge
	launcher.ring.Visible = true
	Motion.set(launcher.pop, { Scale = 0.55 })
	Motion.tween(launcher.pop, { Scale = 1 }, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	if not silent then
		Sfx.play("open")
	end
end

function Win.closeRing(instant, silent)
	local launcher = Win.launcher
	if not launcher or not launcher.ring or not Win.ringOpen then
		return
	end
	Win.ringOpen = false
	local ring = launcher.ring
	local function finish()
		if not Win.ringOpen and ring.Parent then
			ring.Visible = false
		end
	end
	if instant or Motion.reduced then
		finish()
	else
		Motion.tween(launcher.pop, { Scale = 0.55 }, 0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.In, finish)
	end
	Win.placeLauncher(not instant) -- back to where the logo was resting
	if not silent then
		Sfx.play("close")
	end
end

function Win.toggleRing()
	if Win.ringOpen then
		Win.closeRing()
	else
		Win.openRing()
	end
end

-- A tap on the logo ONLY opens or closes the tab ring. It never opens the window: the window (the menu
-- of a tab) comes out when a tab in the ring is tapped (see buildLauncher).
function Win.tapLogo()
	if not Win.window then
		return
	end
	if not Win.radial then
		-- the ring could not be built: the logo steps through the tabs instead, so the hub stays usable
		local index = (Win.tabIndex[Win.currentTab] or 0) % #Win.tabList + 1
		Win.show()
		Win.selectTab(Win.tabList[index].id)
		return
	end
	Win.toggleRing()
end

function Win.paintRadial(id, animate)
	local radial = Win.radial
	if not radial then
		return
	end
	for _, wedge in ipairs(radial.wedges) do
		local selected = wedge.id == id
		if wedge.selected ~= selected then
			wedge.selected = selected
			paintWedge(wedge, animate)
		end
	end
end

local function buildLauncher(gui)
	local R = Win.RADIAL
	local c = R.size / 2
	local function at(x, y)
		return UDim2.fromOffset(c + x, c + y)
	end

	local root = Util.new("Frame", {
		Name = "Launcher", BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromOffset(300, 60), Size = UDim2.fromOffset(R.size, R.size), ZIndex = 20, Visible = false,
	}, gui)
	local launcher = { root = root, scale = Util.new("UIScale", { Scale = 1 }, root), shown = false }
	Win.launcher = launcher

	-- the ring: one wedge per tab around the hub, hidden until the logo is tapped
	local ring
	local ok, err = pcall(function()
		local plan = Win.radialPlan(#Win.tabList)
		ring = Util.new("Frame", {
			Name = "Ring", BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(R.size, R.size), ZIndex = 1, Visible = false,
		}, root)
		launcher.pop = Util.new("UIScale", { Scale = 1 }, ring)
		-- icons and labels sit above the wedges
		local content = Util.new("Frame", {
			Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 6,
		}, ring)

		local wedges = {}
		for index, def in ipairs(Win.tabList) do
			local shape = plan[index]
			local holder = Util.new("Frame", {
				Name = def.title .. "Tab", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 4,
			}, ring)
			local wedge = { id = def.id, pieces = {}, hover = 0, pressed = false, selected = false }
			for _, part in ipairs(shape.pieces) do
				local piece = Util.new("TextButton", {
					Name = "Part", Text = "", AutoButtonColor = false, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
					Position = at(part[1], part[2]), Size = UDim2.fromOffset(part[3], part[4]), Rotation = part[5], ZIndex = 4,
				}, holder)
				Theme.bind(piece, "BackgroundColor3", "Elevated")
				wedge.pieces[#wedge.pieces + 1] = piece
				piece.Activated:Connect(function()
					-- the tab's menu comes out now, not when the logo was tapped
					if not Win.visible then
						Win.show()
					end
					Win.selectTab(def.id)
					if Win.CLOSE_RING_ON_PICK then
						Win.closeRing(false, true) -- silent: the tab sound already played
					end
				end)
				piece.InputBegan:Connect(function(input)
					if not UI.isPress(input) then
						return
					end
					wedge.pressed = true
					paintWedge(wedge, true)
					UI.watchInput(input, nil, function()
						wedge.pressed = false
						paintWedge(wedge, true)
					end)
				end)
				if UserInputService.MouseEnabled then
					piece.MouseEnter:Connect(function()
						wedge.hover = wedge.hover + 1
						paintWedge(wedge, true)
					end)
					piece.MouseLeave:Connect(function()
						wedge.hover = math.max(0, wedge.hover - 1)
						paintWedge(wedge, true)
					end)
				end
			end
			wedge.icon = UI.icon(def.icon, content, R.iconSize, "Muted", {
				anchor = Vector2.new(0.5, 0.5), position = at(shape.icon[1], shape.icon[2]), zindex = 6,
			})
			wedge.label = label(content, {
				Name = def.title .. "Label", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
				Position = at(shape.label[1], shape.label[2]), Size = UDim2.fromOffset(shape.label[3], R.labelH),
				Text = def.title, TextScaled = true, TextWrapped = false, ZIndex = 6,
			}, "tab", 10, "Muted")
			Util.new("UITextSizeConstraint", { MinTextSize = 6, MaxTextSize = 10 }, wedge.label)
			wedges[index] = wedge
		end

		-- thin rim around the ring
		local rim = Util.new("Frame", {
			Name = "Rim", BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = at(0, 0), Size = UDim2.fromOffset((R.outer + 0.25) * 2, (R.outer + 0.25) * 2), ZIndex = 5,
		}, ring)
		Util.round_corner(rim)
		Theme.bind(Util.stroke(rim, nil, 1.5, 0.2), "Color", "Border")

		for _, wedge in ipairs(wedges) do
			paintWedge(wedge, false)
		end
		launcher.ring = ring
		Win.radial = { wedges = wedges }
	end)
	if not ok then
		Util.log("error", "radial tab ring: " .. tostring(err))
		if ring then
			pcall(ring.Destroy, ring)
		end
		launcher.ring, launcher.pop, Win.radial = nil, nil, nil
	end

	-- the hub: the VIREX logo inside a slowly turning accent ring (dark halo so it reads on bright scenes)
	local halo = Util.new("Frame", {
		Name = "HubHalo", BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.78, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5), Position = at(0, 0), Size = UDim2.fromOffset(R.hub * 2 + 10, R.hub * 2 + 10), ZIndex = 6,
	}, root)
	Util.round_corner(halo)
	local hub = Util.new("TextButton", {
		Name = "Hub", Text = "", AutoButtonColor = false, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = at(0, 0), Size = UDim2.fromOffset(R.hub * 2, R.hub * 2), ZIndex = 7,
	}, root)
	Util.round_corner(hub)
	Theme.bind(hub, "BackgroundColor3", "Card")
	local hubStroke = Util.stroke(hub, nil, 2, 0.05)
	local hubGradient = Util.new("UIGradient", { Rotation = 0 }, hubStroke)
	Theme.gradient(hubGradient, Theme.G.stroke)
	Theme.fxSpin(hubGradient, 40, 2)
	UI.icon("logo", hub, 32, "Accent", {
		anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 8,
	})
	launcher.hub = hub

	-- drag to move (threshold first), tap to open / close the ring
	hub.InputBegan:Connect(function(input)
		if not UI.isPress(input) then
			return
		end
		Motion.cancel(root, { Position = true })
		local origin = input.Position
		local startX, startY = root.Position.X.Offset, root.Position.Y.Offset
		local moved = false
		UI.watchInput(input, function(i)
			local dx, dy = i.Position.X - origin.X, i.Position.Y - origin.Y
			if not moved then
				if math.abs(dx) + math.abs(dy) < 8 then
					return
				end
				moved = true
			end
			local nx, ny = Win.clampLauncher(startX + dx, startY + dy, Win.ringOpen)
			root.Position = UDim2.fromOffset(nx, ny)
		end, function(cancelled)
			if moved then
				Win.saveLauncher()
			elseif not cancelled then
				Win.tapLogo()
			end
		end)
	end)
end

-- Builds the whole window inside `gui` (a ScreenGui). Pages are added later with Win.addPage.
function Win.create(gui)
	Win.destroy()
	local maid = Maid.new()
	Win.maid = maid
	Win.gui = gui
	local ui = {}
	Win.ui = ui
	Win.nav, Win.pages, Win.currentTab = {}, {}, nil
	Win.radial, Win.launcher = nil, nil
	Win.visible, Win.minimized, Win.ringOpen = false, false, false

	local w, h, s = Win.computeLayout()
	Win.w, Win.h, Win.s = w, h, s
	local viewport = Env.viewport()
	Win.x, Win.top = Win.clampPx(viewport.X / 2, math.max(10, (viewport.Y - h * s) / 2), w * s, h * s, true)
	Win.userMoved, Win.lastViewport = false, viewport

	local window = Util.new("Frame", {
		Name = "Window", AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
		Position = UDim2.fromOffset(Win.x, Win.top), Size = UDim2.fromOffset(w, h), Visible = false, ZIndex = 1,
	}, gui)
	Win.window = window
	Win.scaler = Util.new("UIScale", { Scale = s }, window)

	-- soft shadow: a few translucent rounded rectangles behind the surface (no image assets needed)
	ui.shadows = {}
	for i, spec in ipairs({ { 3, 0.92 }, { 8, 0.95 }, { 14, 0.968 }, { 22, 0.982 } }) do
		local grow = spec[1]
		local shadow = Util.new("Frame", {
			Name = "Shadow" .. i, BorderSizePixel = 0, BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = spec[2],
			Position = UDim2.fromOffset(-grow, -grow + 8), Size = UDim2.new(1, grow * 2, 1, grow * 2), ZIndex = i,
		}, window)
		Util.corner(shadow, 16 + grow)
		ui.shadows[i] = shadow
	end

	local surface = Util.new("Frame", {
		Name = "Surface", BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Active = true, ZIndex = 10,
	}, window)
	Theme.surface(surface, "Background", "bg")
	Util.corner(surface, 16)
	local stroke = Util.new("UIStroke", { Thickness = 1.5, Transparency = 0.1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, surface)
	local strokeGradient = Util.new("UIGradient", { Rotation = 0 }, stroke)
	Theme.gradient(strokeGradient, Theme.G.stroke)
	Theme.fxSpin(strokeGradient, 24, 2)
	ui.surface = surface

	local bgLayer = Util.new("Frame", {
		Name = "BgLayer", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 1,
	}, surface)
	Bg.init(bgLayer)

	local body = Util.new("Frame", {
		Name = "Body", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromOffset(w, h), ZIndex = 5,
	}, surface)
	ui.body = body

	local content = Util.new("Frame", { Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2 }, body)
	ui.content = content
	buildHeader(content)
	ui.pageTitle = label(content, {
		Name = "PageTitle", BackgroundTransparency = 1, Position = UDim2.fromOffset(2, 4), Size = UDim2.new(1, -4, 0, 28),
		Text = "", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
	}, "title", 21, "Text")
	ui.pageSub = label(content, {
		Name = "PageSubtitle", BackgroundTransparency = 1, Position = UDim2.fromOffset(2, 33), Size = UDim2.new(1, -4, 0, 18),
		Text = "", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
	}, "caption", 11, "Muted")
	ui.pageHost = Util.new("Frame", {
		Name = "Pages", BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 2,
	}, content)

	-- footer: "<FooterName> - <tab name>" (the text is updated by Win.selectTab)
	ui.footer = Util.new("Frame", {
		Name = "Footer", BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 22), ZIndex = 3,
	}, content)
	local footerRule = Util.new("Frame", {
		Name = "Rule", BorderSizePixel = 0, BackgroundTransparency = 0.55, Size = UDim2.new(1, 0, 0, 1), ZIndex = 3,
	}, ui.footer)
	Theme.bind(footerRule, "BackgroundColor3", "Border")
	ui.footerText = label(ui.footer, {
		Name = "FooterText", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 2), Size = UDim2.new(1, 0, 1, -2),
		Text = CONFIG.FooterName, TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
	}, "caption", 11, "Muted")

	-- popup (dropdown) and modal (confirm) layers sit above everything inside the surface
	ui.popupLayer = Util.new("Frame", {
		Name = "Popups", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 50,
	}, surface)
	ui.modalLayer = Util.new("Frame", {
		Name = "Modals", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 60,
	}, surface)
	UI.layers.popup, UI.layers.modal = ui.popupLayer, ui.modalLayer

	Win.applyLayout()
	Win.applyPerformance()

	-- the floating logo (and its tab ring) lives in the ScreenGui, above the window
	buildLauncher(gui)
	Win.placeLauncher(false)

	-- clock (1 Hz, only while the window is shown)
	Anim.add("clock", function()
		local text = os.date("%H:%M")
		if ui.clock.Text ~= text then
			ui.clock.Text = text
		end
	end, 1, function()
		return Win.visible and ui.clock.Visible
	end)

	-- keyboard shortcut (keyboard / mouse devices only)
	local keyOk, keyCode = pcall(function()
		return Enum.KeyCode[CONFIG.ToggleKey]
	end)
	if keyOk and keyCode then
		maid:Connect(UserInputService.InputBegan, function(input, processed)
			if not processed and input.KeyCode == keyCode then
				Win.toggle()
			end
		end)
	end

	-- viewport changes (rotation, window resize)
	local cameraConnection = nil
	local function watchCamera()
		if cameraConnection then
			cameraConnection:Disconnect()
			cameraConnection = nil
		end
		local camera = workspace.CurrentCamera
		if camera then
			cameraConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(Win.scheduleRelayout)
		end
	end
	watchCamera()
	maid:Give(function()
		if cameraConnection then
			cameraConnection:Disconnect()
		end
	end)
	maid:Connect(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
		watchCamera()
		Win.scheduleRelayout()
	end)

	maid:Give(Store.on("scale", function()
		Win.relayout(true)
	end))
	maid:Give(Store.on("compact", function()
		Win.relayout(true)
	end))
	maid:Give(Store.on("clock", function()
		Win.refreshChrome()
	end))
	maid:Give(Store.on("lowPower", function()
		Win.applyPerformance()
	end))
	return window
end

function Win.destroy()
	Anim.remove("clock")
	if Win.maid then
		Win.maid:Clean()
		Win.maid = nil
	end
	if Win.window then
		pcall(Win.window.Destroy, Win.window)
	end
	if Win.launcher and Win.launcher.root then
		pcall(Win.launcher.root.Destroy, Win.launcher.root)
	end
	Win.launcher, Win.radial, Win.ringOpen = nil, nil, false
	Win.window, Win.scaler, Win.gui = nil, nil, nil
	Win.ui = {}
	Win.nav, Win.pages, Win.currentTab = {}, {}, nil
	Win.visible, Win.minimized = false, false
	Win.layoutListeners = {}
	UI.layers.popup, UI.layers.modal = nil, nil
	UI.openDropdown, UI.modal = nil, nil
end
end -- [11_window.lua]

do -- [12_pages.lua]

----------------------------------------------------------------------------------------------------
-- Pages: Overview, Avatar, Appearance, Background, Tools, Settings (Scripts and Information are built in 14_scripts.lua).
-- Every setting goes through Store; side effects live in App.wire() (Store listeners), and every
-- widget listens to its own key so "Reset preferences" updates the whole interface in one pass.
----------------------------------------------------------------------------------------------------
local MarketplaceServiceP = optionalService("MarketplaceService")
local BULLET = "\226\128\162"

Pages.cards = {}
Pages.syncers = {}
Pages.disposers = {}
Pages.gridUpdaters = {}
Pages.build = {}

function Pages.watch(key, fn)
	Pages.disposers[#Pages.disposers + 1] = Store.on(key, fn)
end

function Pages.sync(fn)
	Pages.syncers[#Pages.syncers + 1] = fn
end

function Pages.syncAll()
	for _, fn in ipairs(Util.copy(Pages.syncers)) do
		Util.try("page sync", fn)
	end
end

function Pages.register(card, controlWidth)
	Pages.cards[#Pages.cards + 1] = { card = card, width = controlWidth }
end

-- cards whose controls would squeeze the text too much drop them below it
function Pages.syncCards()
	local width = Win.pageW or 400
	local alive = {}
	for _, entry in ipairs(Pages.cards) do
		if entry.card.Instance.Parent then
			alive[#alive + 1] = entry
			entry.card.SetStacked(width - (entry.width + 38) < 170)
		end
	end
	Pages.cards = alive
	for _, update in ipairs(Pages.gridUpdaters) do
		Util.try("grid update", update, width)
	end
end

function Pages.init()
	Pages.destroy()
	Win.onLayout(function()
		Pages.syncCards()
	end)
end

function Pages.destroy()
	for _, dispose in ipairs(Pages.disposers) do
		pcall(dispose)
	end
	Pages.cards, Pages.syncers, Pages.disposers, Pages.gridUpdaters = {}, {}, {}, {}
	Anim.remove("fps")
	Anim.remove("overview")
end

----------------------------------------------------------------------------------------------------
-- card helpers
----------------------------------------------------------------------------------------------------
local function actionCard(page, order, title, desc, buttonText, onClick, o)
	o = o or {}
	local width = o.width or 124
	local card = UI.card({ parent = page, order = order, title = title, desc = desc, control = width, name = o.name or title })
	local button = UI.button({
		parent = card.Controls, text = buttonText, icon = o.icon, kind = o.kind, small = true, name = "Action", sound = o.sound,
		size = UDim2.new(1, 0, 0, 34), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5), onClick = onClick,
	})
	Pages.register(card, width)
	return card, button
end

local function toggleCard(page, order, title, desc, key, after)
	local card = UI.card({ parent = page, order = order, title = title, desc = desc, control = 62, name = title })
	local toggle = UI.toggle({
		parent = card.Controls, value = Store.get(key), anchor = Vector2.new(1, 0.5), position = UDim2.fromScale(1, 0.5), name = "Toggle",
		onChange = function(value)
			Store.set(key, value)
			if after then
				Util.try("toggle after " .. key, after, value)
			end
		end,
	})
	Pages.watch(key, function(value)
		toggle.Set(value, true)
	end)
	Pages.register(card, 62)
	return card, toggle
end

local function sliderCard(page, order, title, desc, key, o)
	local card = UI.card({ parent = page, order = order, title = title, desc = desc, stack = true, controlHeight = 38, name = title })
	local slider = UI.slider({
		parent = card.Controls, min = o.min, max = o.max, step = o.step, value = Store.get(key), format = o.format, name = "Slider",
		onChange = function(value, final)
			Store.set(key, value)
			if o.onChange then
				Util.try("slider onChange " .. key, o.onChange, value, final)
			end
		end,
	})
	slider.Instance.Size = UDim2.new(1, 0, 0, 38)
	Pages.watch(key, function(value)
		slider.Set(value, true)
	end)
	return card, slider
end

local function percentFormat(value)
	return Util.percent(value) .. "%"
end

local function stepperRow(parent, order, text, key, min, max, step, onChange)
	local row = Util.new("Frame", { Name = key, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = order }, parent)
	local caption = Util.new("TextLabel", {
		Name = "Caption", BackgroundTransparency = 1, Size = UDim2.new(1, -160, 1, 0), Text = text,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, row)
	Typo.apply(caption, "body", 12)
	Theme.bind(caption, "TextColor3", "Text")
	local stepper = UI.stepper({
		parent = row, min = min, max = max, step = step, value = Store.get(key), anchor = Vector2.new(1, 0.5),
		position = UDim2.fromScale(1, 0.5), name = "Stepper",
		onChange = function(value)
			Store.set(key, value)
			if onChange then
				Util.try("stepper onChange " .. key, onChange, value)
			end
		end,
	})
	Pages.watch(key, function(value)
		stepper.Set(value, true)
	end)
	return row, stepper
end

local function textCard(page, order, title, text)
	return UI.card({ parent = page, order = order, title = title, desc = text, name = title })
end

----------------------------------------------------------------------------------------------------
-- shared actions
----------------------------------------------------------------------------------------------------
function Pages.openRobloxSettings()
	if not GuiService then
		Notify.warn("Settings unavailable", "Roblox settings could not be opened here.")
		return
	end
	local called = false
	local attempts = {
		function()
			GuiService:SetMenuIsOpen(true)
		end,
		function()
			GuiService:OpenSettings() -- the call the original script used; kept as a fallback
		end,
	}
	for _, attempt in ipairs(attempts) do
		if pcall(attempt) then
			called = true
			break
		end
	end
	if not called then
		Notify.warn("Settings unavailable", "Roblox settings could not be opened here.")
		return
	end
	task.delay(0.35, function()
		local isOpen = nil
		pcall(function()
			isOpen = GuiService.MenuIsOpen
		end)
		if isOpen == false then
			Notify.warn("Settings unavailable", "Roblox did not open its menu. Use the Roblox menu button instead.")
		end
	end)
end

function Pages.pingMs()
	if StatsService then
		local ok, value = pcall(function()
			return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
		end)
		if ok and type(value) == "number" and value > 0 then
			return math.floor(value + 0.5)
		end
	end
	local player = Players.LocalPlayer
	if player then
		local ok, seconds = pcall(player.GetNetworkPing, player)
		if ok and type(seconds) == "number" and seconds > 0 then
			return math.floor(seconds * 1000 + 0.5)
		end
	end
	return nil
end

function Pages.rejoin()
	if not TeleportService or not Players.LocalPlayer then
		Notify.error("Rejoin unavailable", "TeleportService is not available in this client.")
		return
	end
	UI.confirm({
		title = "Rejoin this server?",
		text = "Roblox reconnects you to this server if it still has room, otherwise to the experience. Unsaved progress in the experience may be lost.",
		confirmText = "Rejoin", cancelText = "Stay", danger = true,
		onConfirm = function()
			Notify.info("Rejoining", "Asking Roblox to reconnect you...")
			local failure = nil
			pcall(function()
				failure = TeleportService.TeleportInitFailed:Connect(function(_, result, message)
					Notify.error("Rejoin failed", Util.cap(tostring(message ~= "" and message or result), 110))
				end)
			end)
			task.delay(20, function()
				if failure then
					pcall(failure.Disconnect, failure)
				end
			end)
			local ok, err = pcall(function()
				if game.JobId ~= "" then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
				else
					TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
				end
			end)
			if not ok then
				Notify.error("Rejoin failed", Util.cap(tostring(err), 110))
			end
		end,
	})
end

----------------------------------------------------------------------------------------------------
-- Private Server Finder (Tools > Roblox). Native: it reads Roblox's own PUBLIC server list for this
-- place (up to 3 pages, a short delay between them, cached for 30 s) and lists the quietest servers
-- that still have room. It never opens private servers, never touches access codes, and runs no
-- external script. Joining uses TeleportToPlaceInstance, with the same failure handling as Rejoin.
----------------------------------------------------------------------------------------------------
Pages.servers = { cache = nil, blockedUntil = 0, pages = 3, delay = 0.7, cacheSeconds = 30, show = 10 }

-- Yields while it reads the list. Returns result, nil on success
-- (result = { servers = sorted list, seen = how many Roblox listed, partial, cached, age }) or nil, reason.
function Pages.findServers()
	local S = Pages.servers
	local now = os.clock()
	if S.cache and S.cache.placeId == game.PlaceId and now - S.cache.at < S.cacheSeconds then
		return { servers = S.cache.servers, seen = S.cache.seen, partial = false, cached = true, age = now - S.cache.at }
	end
	if not Env.fn.request then
		return nil, "This executor has no request function, so the server list cannot be read."
	end
	if now < S.blockedUntil then
		return nil, string.format("Roblox is rate limiting server requests (HTTP 429). Try again in about %d s.", math.ceil(S.blockedUntil - now))
	end

	local servers, seen, cursor, partial = {}, 0, nil, false
	local jobId = game.JobId
	for pageIndex = 1, S.pages do
		local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
		if cursor then
			local okEncode, encoded = pcall(HttpService.UrlEncode, HttpService, cursor)
			url = url .. "&cursor=" .. (okEncode and encoded or cursor)
		end
		local result = Env.fetch(url, "request-only")
		local decoded = result.ok and Util.jsonDecode(result.body) or nil
		local readable = type(decoded) == "table" and type(decoded.data) == "table"
		if not result.ok or not readable then
			if result.status == 429 then
				S.blockedUntil = os.clock() + 30
			end
			if pageIndex == 1 then
				if result.status == 429 then
					return nil, "Roblox is rate limiting server requests (HTTP 429). Try again in about 30 s."
				elseif not result.ok then
					return nil, "Roblox did not return the server list (" .. Util.cap(tostring(result.error), 60) .. ")."
				end
				return nil, "Roblox sent an answer this hub could not read."
			end
			partial = true -- keep what the earlier pages gave us
			break
		end
		for _, item in ipairs(decoded.data) do
			if type(item) == "table" and type(item.id) == "string" and type(item.playing) == "number" and type(item.maxPlayers) == "number" then
				seen = seen + 1
				if item.id ~= jobId and item.playing < item.maxPlayers then
					servers[#servers + 1] = { id = item.id, playing = item.playing, max = item.maxPlayers }
				end
			end
		end
		cursor = type(decoded.nextPageCursor) == "string" and decoded.nextPageCursor or nil
		if not cursor then
			break
		end
		if pageIndex < S.pages then
			task.wait(S.delay)
			if App.destroyed then
				return nil, "The hub was closed."
			end
		end
	end

	table.sort(servers, function(a, b)
		if a.playing ~= b.playing then
			return a.playing < b.playing
		end
		return a.id < b.id
	end)
	local result = { servers = servers, seen = seen, partial = partial, placeId = game.PlaceId, at = os.clock() }
	if not partial then
		S.cache = result
	end
	return result
end

function Pages.buildServerFinder(page, order)
	local S = Pages.servers
	local list = Util.new("Frame", {
		Name = "ServerList", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = order + 1, Visible = false,
	}, page)
	Util.list(list, 8)

	local function clearList()
		for _, child in ipairs(list:GetChildren()) do
			if not child:IsA("UIListLayout") then
				child:Destroy()
			end
		end
	end

	local function join(server)
		if not TeleportService or not Players.LocalPlayer then
			Notify.error("Join unavailable", "TeleportService is not available in this client.")
			return
		end
		UI.confirm({
			title = "Join this server?",
			text = string.format("Roblox moves you to a public server with %d of %d players. Unsaved progress in this experience may be lost.", server.playing, server.max),
			confirmText = "Join", cancelText = "Stay", danger = true,
			onConfirm = function()
				Notify.info("Joining", "Asking Roblox to move you...")
				local failure = nil
				pcall(function()
					failure = TeleportService.TeleportInitFailed:Connect(function(_, result, message)
						S.cache = nil -- the list is out of date now (full or closed server)
						Notify.error("Join failed", Util.cap(tostring(message ~= "" and message or result), 110))
					end)
				end)
				task.delay(20, function()
					if failure then
						pcall(failure.Disconnect, failure)
					end
				end)
				local ok, err = pcall(function()
					TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
				end)
				if not ok then
					Notify.error("Join failed", Util.cap(tostring(err), 110))
				end
			end,
		})
	end

	local function render(result)
		clearList()
		local servers = result.servers
		local shown = math.min(#servers, S.show)
		local summary = string.format("Showing the %d quietest of %d open public servers", shown, #servers)
		if result.cached then
			summary = summary .. string.format(" (list is %d s old)", math.floor(result.age + 0.5))
		end
		summary = summary .. ". Roblox's list changes constantly; a server can fill up before you join."
		if result.partial then
			summary = summary .. " Roblox stopped answering part-way, so this list is incomplete."
		end
		UI.card({ parent = list, order = 0, title = "Quietest public servers", desc = summary, name = "ServerSummary" })
		for index = 1, shown do
			local server = servers[index]
			local card = UI.card({
				parent = list, order = index, name = "Server" .. index, control = 92,
				title = string.format("%d / %d players", server.playing, server.max),
				desc = "Server " .. string.sub(server.id, 1, 8),
			})
			UI.button({
				parent = card.Controls, text = "Join", small = true, kind = "primary", name = "Join",
				size = UDim2.new(1, 0, 0, 34), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
				onClick = function()
					join(server)
				end,
			})
			Pages.register(card, 92)
		end
		list.Visible = true
	end

	local busy, token = false, 0
	local _, button = actionCard(page, order, "Private Server Finder",
		"Lists the 10 quietest public servers of this experience so you can hop to a calmer one. It reads Roblox's own public list only; it cannot open private servers you were not invited to.",
		"Find servers", function(btn)
			if busy then
				return
			end
			if game.PrivateServerId ~= "" then
				Notify.info("Already in a private server", "You are in a private server right now, so there is no public list to search from here. Leave it first to see public servers.")
				return
			end
			busy = true
			token = token + 1
			local mine = token
			btn.SetBusy(true, "Searching...")
			local function finish(result, reason)
				if token ~= mine then
					return
				end
				token = token + 1 -- closes this search: a late answer or the timeout can no longer run it twice
				busy = false
				if Util.alive(btn.Instance) then
					btn.SetBusy(false)
				end
				if App.destroyed or not Util.alive(list) then
					return
				end
				if not result then
					clearList()
					list.Visible = false
					Notify.warn("Server list unavailable", Util.cap(tostring(reason), 130))
				elseif #result.servers == 0 then
					clearList()
					list.Visible = false
					Notify.info("No other servers", "Roblox lists no other open public servers for this experience right now.")
				else
					render(result)
				end
			end
			task.delay(25, function()
				finish(nil, "Roblox took too long to answer.")
			end)
			task.spawn(function()
				local result, reason = Pages.findServers()
				finish(result, reason)
			end)
		end, { width = 132, name = "ServerFinder" })
	if not Env.fn.request then
		button.SetEnabled(false, "This executor has no request function, so the server list cannot be read.")
	elseif not TeleportService then
		button.SetEnabled(false, "TeleportService is not available in this client.")
	end
end

local function storageText()
	if Store.persistent then
		return "Settings are saved to " .. CONFIG.ConfigFile .. " in the executor workspace."
	elseif Env.canSave() then
		return "File saving was detected but the first save failed (" .. tostring(Store.lastError) .. "). Settings last for this session only."
	end
	return "This executor has no file access, so settings last for this session only."
end

----------------------------------------------------------------------------------------------------
-- Overview
----------------------------------------------------------------------------------------------------
function Pages.build.overview(page)
	local player = Players.LocalPlayer
	local info = { name = game.Name ~= "" and game.Name or "Roblox experience" }
	local session

	local function describe()
		local shown = "Player"
		if player then
			shown = player.DisplayName ~= "" and player.DisplayName or player.Name
		end
		session.SetDesc(string.format(
			"%s  %s  Place ID %s  %s  Player %s  %s  Refreshed %s",
			info.name, BULLET, tostring(game.PlaceId), BULLET, shown, BULLET, os.date("%H:%M:%S")
		))
	end
	local function fetchName()
		if not MarketplaceServiceP or game.PlaceId == 0 then
			return
		end
		task.spawn(function()
			local ok, product = pcall(MarketplaceServiceP.GetProductInfo, MarketplaceServiceP, game.PlaceId)
			if ok and type(product) == "table" and type(product.Name) == "string" and product.Name ~= "" then
				info.name = product.Name
				if session.Instance.Parent then
					describe()
				end
			end
		end)
	end

	UI.section(page, "Session", 1)
	session = actionCard(page, 2, "Experience session", "", "Refresh", function()
		describe()
		fetchName()
		Notify.success("Session refreshed", "The session details are up to date.")
	end, { width = 112, name = "Session" })
	describe()
	fetchName()

	-- live readouts: frame rate (measured here), ping (Roblox stat), hub uptime
	local tiles = Util.new("Frame", {
		Name = "Stats", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 3,
	}, page)
	local grid = Util.new("UIGridLayout", {
		CellSize = UDim2.new(1 / 3, -6, 0, 62), CellPadding = UDim2.fromOffset(9, 8), SortOrder = Enum.SortOrder.LayoutOrder,
	}, tiles)
	Pages.gridUpdaters[#Pages.gridUpdaters + 1] = function(width)
		if width < 380 then
			grid.CellSize = UDim2.new(1, 0, 0, 58)
		else
			grid.CellSize = UDim2.new(1 / 3, -6, 0, 62)
		end
	end
	local fps = UI.statTile({ parent = tiles, label = "Frames per second", value = "-", order = 1 })
	local ping = UI.statTile({ parent = tiles, label = "Ping to server", value = "-", order = 2 })
	local uptime = UI.statTile({ parent = tiles, label = "Hub uptime", value = "-", order = 3 })

	local function visible()
		return Win.visible and not Win.minimized and Win.currentTab == "overview"
	end
	local sample = 60
	Anim.add("fps", function(dt)
		if dt > 0 then
			sample = sample * 0.92 + (1 / dt) * 0.08
		end
	end, nil, visible)
	Anim.add("overview", function(_, now)
		local value = math.floor(sample + 0.5)
		fps.Set(tostring(value), value >= 50 and "Green" or (value >= 30 and "Warn" or "Danger"))
		local ms = Pages.pingMs()
		if ms then
			ping.Set(ms .. " ms", ms <= 100 and "Green" or (ms <= 200 and "Warn" or "Danger"))
		else
			ping.Set("-", "Muted")
		end
		uptime.Set(Util.duration(now - App.startedAt), "Text")
	end, 2, visible)

	UI.section(page, "Quick actions", 4)
	actionCard(page, 5, "Open Roblox settings", "Open the platform's built-in settings menu.", "Open settings", Pages.openRobloxSettings,
		{ width = 132, name = "OpenSettings" })
	actionCard(page, 6, "Appearance", "Jump to the controls for theme, window size, and motion.", "Customize", function()
		Win.selectTab("appearance")
	end, { width = 124, name = "Customize" })

	UI.section(page, "About", 7)
	local lines = {
		"VirexHub is client-side interface code for your own sessions. Executor features (saving, clipboard, custom assets) are optional and detected at start. Nothing here changes server-side game rules.",
		string.format("Version %s  %s  Executor: %s  %s  %s", CONFIG.Version, BULLET, Env.executor, BULLET, Store.persistent and "settings saved" or "settings last for this session"),
		"Credits: avatar tools adapted from AVATAR-CHANGER (returnreturnfunction); loading screen modelled on the Blyxo loader; click sound from Vyre Multiverse.",
	}
	textCard(page, 8, "About this hub", table.concat(lines, "\n\n"))
end

----------------------------------------------------------------------------------------------------
-- Avatar (see 10_avatar.lua)
----------------------------------------------------------------------------------------------------
function Pages.build.avatar(page)
	Avatar.buildPage(page)
end

----------------------------------------------------------------------------------------------------
-- Appearance
----------------------------------------------------------------------------------------------------
local function buildThemeGroup(page, order, title, defs, tiles)
	local heading = Util.new("TextLabel", {
		Name = "Group", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18), LayoutOrder = order, Text = title,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	Typo.apply(heading, "caption", 11)
	Theme.bind(heading, "TextColor3", "Muted")
	local host = Util.new("Frame", {
		Name = "Themes", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order + 1,
	}, page)
	local grid = Util.new("UIGridLayout", {
		CellSize = UDim2.fromOffset(118, 76), CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder,
	}, host)
	-- tiles stretch to fill each row (at least 118 px wide), so long names such as "Diamond + Purple" keep their room
	local function sizeTiles(width)
		local columns = math.max(2, math.floor((width + 8) / (118 + 8)))
		grid.CellSize = UDim2.fromOffset(math.floor((width - (columns - 1) * 8) / columns), 76)
	end
	Pages.gridUpdaters[#Pages.gridUpdaters + 1] = sizeTiles
	sizeTiles(Win.pageW or 400)
	for index, def in ipairs(defs) do
		local hit = Util.new("TextButton", {
			Name = "Theme_" .. def.id, Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = index,
		}, host)
		local face = Util.new("Frame", {
			Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1), BorderSizePixel = 0,
		}, hit)
		Util.corner(face, 12)
		Theme.surface(face, "Card", "card")
		local stroke = Util.stroke(face, nil, 1, 0.15)
		Theme.bind(stroke, "Color", "Border")
		-- a miniature of that theme: its background, an accent bar and a highlight dot
		local preview = Util.new("Frame", {
			Name = "Preview", Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 34), BorderSizePixel = 0,
			BackgroundColor3 = def.colors.Background,
		}, face)
		Util.corner(preview, 8)
		Util.stroke(preview, def.colors.Border, 1, 0.2)
		local bar = Util.new("Frame", {
			Name = "Bar", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.new(0.6, 0, 0, 8),
			BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
		}, preview)
		Util.round_corner(bar)
		Util.new("UIGradient", {
			Color = ColorSequence.new(def.colors.Accent, def.colors.Accent2 or def.colors.Accent),
		}, bar)
		local dot = Util.new("Frame", {
			Name = "Dot", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(10, 10),
			BorderSizePixel = 0, BackgroundColor3 = def.colors.Shine or def.colors.Accent,
		}, preview)
		Util.round_corner(dot)
		local name = Util.new("TextLabel", {
			Name = "Name", BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 44), Size = UDim2.new(1, -16, 0, 28), Text = def.name,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, TextWrapped = true,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, face)
		Typo.apply(name, "buttonSmall", 12)
		Theme.bind(name, "TextColor3", "Text")
		local badge = Util.new("Frame", {
			Name = "Selected", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -5, 0, 5), Size = UDim2.fromOffset(20, 20),
			BorderSizePixel = 0, ZIndex = 5, Visible = false,
		}, face)
		Util.round_corner(badge)
		Theme.bind(badge, "BackgroundColor3", "Accent")
		UI.icon("check", badge, 14, "OnAccent", { anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 6 })
		local state = UI.pressable(hit, face, { radius = 12, hoverAlpha = 0.94, pressAlpha = 0.88, pressScale = 0.96 })
		hit.Activated:Connect(function()
			if state.wasDrag() then
				return
			end
			if Theme.id == def.id then
				Sfx.play("click")
				return
			end
			Sfx.play("select")
			Store.set("theme", def.id)
			Notify.info("Theme changed", "Using the " .. def.name .. " theme.", { key = "theme" })
		end)
		tiles[#tiles + 1] = { id = def.id, stroke = stroke, badge = badge }
	end
end

function Pages.build.appearance(page)
	UI.section(page, "Window", 1)
	toggleCard(page, 2, "Compact window", "Use a smaller window size while keeping all controls available.", "compact")
	toggleCard(page, 3, "Clock", "Show or hide the local time next to HIDE MENU.", "clock")

	UI.section(page, "Motion", 4)
	toggleCard(page, 5, "Reduced motion", "Turn off interface tweens and animated accents; changes become immediate.", "reducedMotion", function(value)
		Notify.info("Reduced motion", value and "Animations are off." or "Animations are on.", { key = "motion", force = true })
	end)
	toggleCard(page, 6, "Low power mode", "Removes shadows, animated accents and animated backgrounds to save battery and keep the frame rate steady.", "lowPower")
	local fxCard = UI.card({
		parent = page, order = 7, title = "Animated accents",
		desc = "Moving highlights on the window border, title and selection (premium themes look best on Full).", control = 210, name = "Accents",
	})
	local fxControl = UI.segmented({
		parent = fxCard.Controls, size = UDim2.new(1, 0, 0, 36), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
		options = { { id = 0, label = "Off" }, { id = 1, label = "Subtle" }, { id = 2, label = "Full" } }, value = Store.get("fx"),
		onChange = function(id)
			Store.set("fx", id)
		end,
	})
	Pages.watch("fx", function(value)
		fxControl.Set(value, true)
	end)
	Pages.register(fxCard, 210)

	UI.section(page, "Theme", 8)
	local tiles = {}
	local groups, order = {}, {}
	for _, def in ipairs(Theme.defs) do
		if not groups[def.group] then
			groups[def.group] = {}
			order[#order + 1] = def.group
		end
		table.insert(groups[def.group], def)
	end
	local nextOrder = 9
	for _, group in ipairs(order) do
		buildThemeGroup(page, nextOrder, group, groups[group], tiles)
		nextOrder = nextOrder + 2
	end
	local function paintTiles()
		for _, tile in ipairs(tiles) do
			local selected = Theme.id == tile.id
			Theme.tweenRole(tile.stroke, "Color", selected and "Accent" or "Border", 0.22)
			Motion.tween(tile.stroke, { Thickness = selected and 2 or 1, Transparency = selected and 0 or 0.15 }, 0.22)
			tile.badge.Visible = selected
		end
	end
	paintTiles()
	Pages.disposers[#Pages.disposers + 1] = Theme.onChange(paintTiles)

	UI.section(page, "Typography", nextOrder)
	local fontCard = UI.card({
		parent = page, order = nextOrder + 1, title = "Font family",
		desc = "One font setting for every label in the hub.", control = 180, name = "Font",
	})
	local fontDropdown = UI.dropdown({
		parent = fontCard.Controls, options = Typo.list(), value = Typo.family.id, name = "FontDropdown",
		onChange = function(id)
			Store.set("font", id)
		end,
	})
	fontDropdown.Instance.Size = UDim2.new(1, 0, 0, 36)
	fontDropdown.Instance.AnchorPoint = Vector2.new(0, 0.5)
	fontDropdown.Instance.Position = UDim2.fromScale(0, 0.5)
	Pages.watch("font", function(value)
		fontDropdown.Set(value, true)
	end)
	Pages.register(fontCard, 180)

	local sample = UI.card({
		parent = page, order = nextOrder + 2, name = "FontPreview", title = "Preview",
		desc = "The quick brown fox jumps over the lazy dog. 0123456789",
	})
	Typo.apply(sample.Desc, "body", 14)
	textCard(page, nextOrder + 3, "Using your own font",
		"Roblox cannot load a .ttf or .otf file straight into a script. Upload the font to Roblox as a Font Family (Creator Hub), then add one line with its asset ID to CONFIG.Fonts.Families at the top of this file. Nothing else has to change; it will appear in this list.")
end

----------------------------------------------------------------------------------------------------
-- Background
----------------------------------------------------------------------------------------------------
function Pages.build.background(page)
	UI.section(page, "Background", 1)
	local modeCard = UI.card({
		parent = page, order = 2, title = "Style",
		desc = "Aurora and Sparkle use the theme colours and need no files. Image styles load a picture you provide.", control = 190, name = "Style",
	})
	local ui = {}
	local function modeLabel(id)
		for _, entry in ipairs(Bg.MODES) do
			if entry.id == id then
				return entry.label
			end
		end
		return tostring(id)
	end
	local function sourceKey(mode)
		if mode == "sequence" then
			return "bgSequence"
		elseif mode == "video" then
			return "bgVideo"
		end
		return "bgImage"
	end

	-- source card ---------------------------------------------------------------------------------
	local source = UI.card({ parent = page, order = 3, stack = true, controlHeight = 0, title = "Source", desc = "", name = "Source" })
	local box = source.Controls
	box.AutomaticSize = Enum.AutomaticSize.Y
	box.Size = UDim2.new(1, 0, 0, 0)
	Util.list(box, 8)

	local inputRow = Util.new("Frame", { Name = "InputRow", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 1 }, box)
	ui.input = UI.input({
		parent = inputRow, size = UDim2.new(1, -92, 1, 0), placeholder = "Image ID, file name or link", maxLength = 400, name = "SourceInput",
	})
	ui.apply = UI.button({
		parent = inputRow, text = "Apply", kind = "primary", size = UDim2.fromOffset(84, 38), anchor = Vector2.new(1, 0),
		position = UDim2.new(1, 0, 0, 0), name = "ApplySource", onClick = function()
			local mode = Store.get("bgMode")
			local text = ui.input.Get()
			if text == "" then
				ui.input.Flash()
				Notify.warn("Nothing to apply", "Enter an asset ID, file name or link first.")
				return
			end
			ui.apply.SetBusy(true, "Loading")
			Bg.useSource(mode, text, function(ok, message)
				ui.apply.SetBusy(false)
				if ok == nil then
					return
				end
				if ok then
					Notify.success("Background applied", Util.cap(message, 100))
				else
					Notify.error("Background failed", Util.cap(message, 150))
				end
			end)
		end,
	})
	ui.rowCols = stepperRow(box, 2, "Sheet columns", "bgCols", 1, 16, 1, function()
		if Store.get("bgMode") == "sheet" then
			Bg.apply()
		end
	end)
	ui.rowRows = stepperRow(box, 3, "Sheet rows", "bgRows", 1, 16, 1, function()
		if Store.get("bgMode") == "sheet" then
			Bg.apply()
		end
	end)
	ui.rowFps = stepperRow(box, 4, "Frames per second", "bgFps", 1, 24, 1, function()
		local mode = Store.get("bgMode")
		if mode == "sheet" or mode == "sequence" then
			Bg.apply()
		end
	end)
	local clearRow = Util.new("Frame", { Name = "ClearRow", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 34), LayoutOrder = 5 }, box)
	ui.clear = UI.button({
		parent = clearRow, text = "Clear source", kind = "ghost", small = true, size = UDim2.fromOffset(130, 34), name = "ClearSource",
		onClick = function()
			Store.set(sourceKey(Store.get("bgMode")), "")
			ui.input.Set("")
			Bg.apply()
			Notify.info("Source cleared", "The saved background source was removed.")
		end,
	})
	ui.status = Util.new("TextLabel", {
		Name = "Status", BackgroundTransparency = 1, LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Text = "", TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, box)
	Typo.apply(ui.status, "caption", 12)
	Theme.bind(ui.status, "TextColor3", "Muted")

	local hints = {
		image = { holder = "Image ID, file name or link", desc = "One static picture. Use a Roblox Image asset ID, a PNG/JPG/WEBP in the executor folder 'VirexHub/backgrounds', or an image link." },
		sheet = { holder = "Sprite-sheet image (ID, file or link)", desc = "A GIF-style animation drawn as ONE picture made of a grid of frames. Set the grid and speed below." },
		sequence = { holder = "id1, id2, id3 (at least 2 frames)", desc = "A GIF-style animation from several images shown one after another. Separate the IDs or file names with commas." },
		video = { holder = "Roblox video ID or file.webm", desc = "Experimental. Needs a Roblox-hosted video asset or a local .webm / .mp4 file. Arbitrary video links cannot be streamed." },
	}
	local function refreshPanels()
		local mode = Store.get("bgMode")
		local hint = hints[mode]
		source.Instance.Visible = hint ~= nil
		if hint then
			local desc = hint.desc
			if not Env.canCustomAsset() then
				desc = desc .. " Local files and link downloads need file + custom-asset support, which this executor did not report; Roblox asset IDs still work."
			end
			source.SetTitle("Source: " .. modeLabel(mode))
			source.SetDesc(desc)
			ui.input.Box.PlaceholderText = hint.holder
			ui.input.Set(Store.get(sourceKey(mode)))
		end
		ui.rowCols.Visible = mode == "sheet"
		ui.rowRows.Visible = mode == "sheet"
		ui.rowFps.Visible = mode == "sheet" or mode == "sequence"
	end

	local modeDropdown = UI.dropdown({
		parent = modeCard.Controls, options = Bg.MODES, value = Store.get("bgMode"), name = "ModeDropdown",
		onChange = function(id)
			Store.set("bgMode", id)
			Bg.apply()
			refreshPanels()
		end,
	})
	modeDropdown.Instance.Size = UDim2.new(1, 0, 0, 36)
	modeDropdown.Instance.AnchorPoint = Vector2.new(0, 0.5)
	modeDropdown.Instance.Position = UDim2.fromScale(0, 0.5)
	Pages.register(modeCard, 190)
	Pages.sync(function()
		modeDropdown.Set(Store.get("bgMode"), true)
		refreshPanels()
	end)
	refreshPanels()

	local statusRoles = { idle = "Muted", loading = "Accent", ok = "Green", error = "Danger" }
	local function showStatus(kind, text)
		ui.status.Text = text
		Theme.tweenRole(ui.status, "TextColor3", statusRoles[kind] or "Muted", 0.2)
	end
	showStatus(Bg.status.kind, Bg.status.text)
	Pages.disposers[#Pages.disposers + 1] = Bg.onStatus(showStatus)

	-- readability ----------------------------------------------------------------------------------
	UI.section(page, "Readability", 4)
	sliderCard(page, 5, "Dark overlay", "Darkens picture and video backgrounds so text stays easy to read (never below 20% for media).", "overlay",
		{ min = 0, max = 0.9, step = 0.05, format = percentFormat })
	sliderCard(page, 6, "Panel transparency", "Lets the background show through the panels. Text keeps its contrast.", "glass",
		{ min = 0, max = 0.6, step = 0.05, format = percentFormat })
	toggleCard(page, 7, "Blur the game behind", "Adds a Roblox blur to the game view while the hub is open. Some experiences block new effects.", "blur")

	UI.section(page, "Good to know", 8)
	textCard(page, 9, "GIFs and video",
		"Roblox image labels cannot play .gif files, and video links from the internet cannot be streamed. For an animated background use a sprite sheet or an image sequence (they play at the speed you choose). Video works only with a Roblox-hosted video asset or a local .webm / .mp4 file.")
end

----------------------------------------------------------------------------------------------------
-- Tools
----------------------------------------------------------------------------------------------------
function Pages.build.tools(page)
	UI.section(page, "Interface", 1)
	actionCard(page, 2, "Recenter window", "Move the window back to the center of the screen and put the logo back at the top.", "Recenter", function()
		Win.recenter()
		Notify.info("Window centered", "The window and the logo are back at their default spots.")
	end, { name = "Recenter" })
	actionCard(page, 3, "Hide menu", "Hide the window. Tap the logo, then a tab, to bring it back (the HIDE MENU button does the same).", "Hide", function()
		Win.hideMenu()
	end, { name = "HideMenu" })

	UI.section(page, "Roblox", 4)
	actionCard(page, 5, "Open Roblox settings", "Open Roblox's built-in settings menu.", "Open settings", Pages.openRobloxSettings,
		{ width = 132, name = "OpenSettings" })
	actionCard(page, 6, "Show session details", "Display the current experience, place ID, and player name.", "Show details", function()
		local player = Players.LocalPlayer
		Notify.info("Current session", string.format("%s %s Place %s %s %s", game.Name ~= "" and game.Name or "Experience", BULLET,
			tostring(game.PlaceId), BULLET, player and player.DisplayName or "Player"), { duration = 5 })
	end, { name = "Details" })
	actionCard(page, 7, "Rejoin server", "Ask Roblox to reconnect you to this server. You are asked to confirm first.", "Rejoin", Pages.rejoin,
		{ name = "Rejoin", kind = "danger" })
	Pages.buildServerFinder(page, 8) -- uses LayoutOrder 8 (card) and 9 (results)

	UI.section(page, "Clipboard", 10)
	local canCopy = Env.canClipboard()
	local _, copyPlace = actionCard(page, 11, "Copy place ID", "Copy this experience's place ID to the clipboard.", "Copy", function()
		if Env.copy(tostring(game.PlaceId)) then
			Notify.success("Copied", "Place ID " .. tostring(game.PlaceId) .. " is on your clipboard.")
		else
			Notify.error("Copy failed", "The executor refused the clipboard request.")
		end
	end, { name = "CopyPlace" })
	local _, copyJob = actionCard(page, 12, "Copy server ID", "Copy this server's job ID to the clipboard.", "Copy", function()
		if game.JobId == "" then
			Notify.warn("No server ID", "This session has no job ID (it may be a Studio or private test).")
		elseif Env.copy(game.JobId) then
			Notify.success("Copied", "The server ID is on your clipboard.")
		else
			Notify.error("Copy failed", "The executor refused the clipboard request.")
		end
	end, { name = "CopyJob" })
	if not canCopy then
		copyPlace.SetEnabled(false, "This executor does not provide a clipboard function.")
		copyJob.SetEnabled(false, "This executor does not provide a clipboard function.")
	end
end

----------------------------------------------------------------------------------------------------
-- Settings
----------------------------------------------------------------------------------------------------
function Pages.build.settings(page)
	UI.section(page, "Notifications", 1)
	toggleCard(page, 2, "Hub notifications", "Enable or silence notifications created by this interface.", "notifications", function(value)
		Notify.info("Notifications", value and "Notifications are on." or "Notifications are now off.", { key = "notif", force = true })
	end)

	UI.section(page, "Sound", 3)
	toggleCard(page, 4, "Sound effects", "Short sounds for buttons, tabs, toggles, notifications and opening or closing the hub.", "sound")
	sliderCard(page, 5, "Volume", "Master volume for every hub sound.", "volume", {
		min = 0, max = 1, step = 0.05, format = percentFormat,
		onChange = function(_, final)
			if final then
				Sfx.play("select")
			end
		end,
	})
	toggleCard(page, 6, "Loading screen sound", "Play the loading sound while the hub starts.", "splashSound")
	local soundCard = actionCard(page, 7, "Sound status", Sfx.summary(), "Test sound", function()
		if not Sfx.play("success", false) then
			Notify.warn("No sound played", "Sound is switched off, the volume is zero, or the sound assets did not load.")
		end
	end, { width = 124, name = "SoundStatus" })
	Pages.sync(function()
		soundCard.SetDesc(Sfx.summary())
	end)

	UI.section(page, "Interface scale", 8)
	local scaleCard = UI.card({
		parent = page, order = 9, title = "UI scale", desc = "Make the whole hub larger or smaller.", control = 150, name = "Scale",
	})
	local stepper = UI.stepper({
		parent = scaleCard.Controls, min = 0.9, max = 1.15, step = 0.05, value = Store.get("scale"), anchor = Vector2.new(1, 0.5),
		position = UDim2.fromScale(1, 0.5), format = function(value)
			return Util.percent(value) .. "%"
		end,
		onChange = function(value)
			Store.set("scale", value)
		end,
	})
	Pages.watch("scale", function(value)
		stepper.Set(value, true)
		scaleCard.SetDesc(string.format("Current scale: %d%%", Util.percent(value)))
	end)
	scaleCard.SetDesc(string.format("Current scale: %d%%", Util.percent(Store.get("scale"))))
	Pages.register(scaleCard, 150)

	UI.section(page, "Startup", 10)
	toggleCard(page, 11, "Show loading screen", "The loading screen reports real startup steps. Turning it off skips the screen; the hub starts the same way.", "splash")

	UI.section(page, "Storage", 12)
	textCard(page, 13, "Saved settings", storageText())

	UI.section(page, "Diagnostics", 14)
	actionCard(page, 15, "Environment", Env.summary(), "Copy report", function()
		local text = App.report()
		if Env.copy(text) then
			Notify.success("Report copied", "Paste it wherever you are getting help.")
		else
			Notify.warn("Clipboard unavailable", "This executor has no clipboard function, so the report cannot be copied.")
		end
	end, { width = 132, name = "Report" })

	UI.section(page, "Preferences", 16)
	actionCard(page, 17, "Reset preferences", "Restore the default theme, scale, background, sound and toggle states. Avatar favourites are kept.", "Reset", function()
		UI.confirm({
			title = "Reset preferences?",
			text = "Theme, scale, background, sound and window options go back to their defaults. Your avatar favourites are kept.",
			confirmText = "Reset", cancelText = "Cancel", danger = true,
			onConfirm = function()
				App.resetPreferences()
			end,
		})
	end, { name = "Reset", kind = "danger" })
	actionCard(page, 18, "Close hub", "Remove this interface from the screen. Run the script again to reopen it.", "Close", function()
		UI.confirm({
			title = "Close VirexHub?",
			text = "The hub is removed from the screen. Your saved settings are kept.",
			confirmText = "Close hub", cancelText = "Keep open", danger = true,
			onConfirm = function()
				App.destroy()
			end,
		})
	end, { name = "Close", kind = "danger" })
end
end -- [12_pages.lua]

do -- [14_scripts.lua]

----------------------------------------------------------------------------------------------------
-- Scripts: the third-party script catalog, favorites, link checks, the Execute pipeline, and the
-- Scripts and Information pages. Numbered 14 because it was added after 13_app.lua, but it sits before
-- it because App.start() runs at the end of that section.
--
-- The 40 entries were copied unchanged (names and links) from Vyre-Multiverse-41.lua. They are other
-- people's code: nothing is fetched, checked or run until the user taps Check, Check all or Execute.
--
-- The built-in Steal An Egg panel (Scripts.sae, ported from VYRE 6.3) is NOT part of the catalog: it has no link,
-- downloads and runs nothing, and opens from its own card at the top of the Scripts page.
----------------------------------------------------------------------------------------------------
Scripts.tiers = {
	{ id = "main", title = "Main" },
	{ id = "bonus", title = "Bonus" },
}

Scripts.groups = {
	{ id = "main-free", title = "No key required", group = "main", key = false },
	{ id = "main-key", title = "Key required", group = "main", key = true },
	{ id = "bonus-free", title = "No key required", group = "bonus", key = false },
	{ id = "bonus-key", title = "Key required", group = "bonus", key = true },
}

Scripts.catalog = {
	-- main, no key (Vyre-Multiverse-41: scriptsData)
	{ id = "miranda-op", name = "Miranda OP", url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealeggies", key = false, group = "main" },
	{ id = "miranda-afk", name = "Miranda AFK", url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/afkk", key = false, group = "main" },
	{ id = "polluted-hub", name = "Polluted Hub", url = "https://raw.githubusercontent.com/PollutedHub/Sae/main/SaePolluted", key = false, group = "main" },
	{ id = "chilli-hub", name = "Chilli Hub", url = "https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg", key = false, group = "main" },
	{ id = "universal-sae", name = "Universal SAE", url = "https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg", key = false, group = "main" },
	{ id = "blyxo-hub", name = "Blyxo Hub", url = "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua", key = false, group = "main" },
	{ id = "source-anti-hit", name = "Source Anti Hit", url = "https://gist.githubusercontent.com/sourceshubs/df6e17b3672213791b47a0a8c5398b6e/raw/SourcesHubAntiHitNewest", key = false, group = "main" },
	{ id = "source-instant-steal", name = "Source Instant Steal", url = "https://gist.githubusercontent.com/sourceshubs/9c70c7c483019f2de5d7119ae05ba3f8/raw/SourcesHubStealAnEgg", key = false, group = "main" },
	{ id = "sources-instant", name = "Sources Instant", url = "https://gist.githubusercontent.com/sourceshubs/1737c14cdba5c6fb472a995d555a50f1/raw/SourcesHubInstantStealNew", key = false, group = "main" },
	{ id = "fox", name = "Fox", url = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua", key = false, group = "main" },
	{ id = "virex", name = "Virex", url = "https://cdn.luaprotect.dev/u/8660b0/AvrC3cs5mZ38jbnD", key = false, group = "main" },
	{ id = "decode", name = "Decode", url = "https://raw.githubusercontent.com/ItzYumi/Decode/refs/heads/main/DE%3ACODE.lua", key = false, group = "main" },
	{ id = "lennon-hub-v3", name = "Lennon Hub V3", url = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua", key = false, group = "main" },
	{ id = "yokudo-hub", name = "Yokudo Hub", url = "https://raw.githubusercontent.com/betdoyvaka/stealanegg/main/Loader.lua", key = false, group = "main" },
	{ id = "virex-v2", name = "Virex V2", url = "https://gist.githubusercontent.com/virexx55/836653079c73281295d6bfb5c10be5d9/raw/128b0220c9a36354b5c6504c3669f328e5354805/virex.lua", key = false, group = "main" },
	{ id = "clout-hub", name = "NEW · Clout Hub", url = "https://raw.githubusercontent.com/ClouthubOnTop/Loader/main/main.lua", key = false, group = "main" },
	-- main, key required (scriptsDataKey)
	{ id = "fyy-hub", name = "FYY Hub", url = "https://FyyCommunity.my.id", key = true, group = "main" },
	{ id = "zeroin-hub", name = "Zeroin Hub", url = "https://zeroinhub.com/api/script", key = true, group = "main" },
	{ id = "bigfoot-bf", name = "Bigfoot Bf", url = "https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua", key = true, group = "main" },
	{ id = "clover-hub", name = "Clover Hub", url = "https://cloverhub.app/clover.lua", key = true, group = "main" },
	{ id = "titanic-hub", name = "Titanic Hub", url = "https://raw.githubusercontent.com/TITANIC-HUB/StealAnEgg/main/Loader.lua", key = true, group = "main" },
	{ id = "limbo-hub", name = "Limbo Hub", url = "https://limbohub.my.id/loader.lua", key = true, group = "main" },
	{ id = "kira-hub", name = "Kira Hub", url = "https://raw.githubusercontent.com/shebetterlol889/shh/refs/heads/main/shh", key = true, group = "main" },
	{ id = "equinox-hub", name = "Equinox Hub", url = "https://api.jnkie.com/api/v1/luascripts/public/338ceeba573ee21d1ce80a020b7923d8bde36038de4511162b01f325b16b9c3f/download", key = true, group = "main" },
	{ id = "ajjan-hub", name = "Ajjan Hub", url = "https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua", key = true, group = "main" },
	{ id = "nasi-rendang-hub", name = "Nasi Rendang Hub", url = "https://raw.githubusercontent.com/JualNasiRendang/loader/refs/heads/main/main.lua", key = true, group = "main" },
	{ id = "axon-hub", name = "Axon Hub", url = "https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua", key = true, group = "main" },
	{ id = "speed-hub-x", name = "Speed Hub X", url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", key = true, group = "main" },
	{ id = "neptune-hub", name = "Neptune Hub", url = "https://api.luarmor.net/files/v4/loaders/ed76667e766b5afc5bbfe2761bed56b7.lua", key = true, group = "main" },
	-- bonus, no key (bonusKeyless)
	{ id = "rene-baterbonia", name = "Rene Baterbonia", url = "https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg", key = false, group = "bonus" },
	{ id = "chocola-spawner", name = "Chocola Spawner", url = "https://raw.githubusercontent.com/chocolascript-glitch/Chocola-Pet-Spawner-steal-an-egg/refs/heads/main/script.lua", key = false, group = "bonus" },
	{ id = "exploit-hub", name = "Exploit Hub", url = "https://raw.githubusercontent.com/Main-Scripts-Ready-V9/Exploiter-Loader/refs/heads/main/New.lua", key = false, group = "bonus" },
	{ id = "private-server", name = "Private Server", url = "https://raw.githubusercontent.com/raw-roblox/PrivateServerBypass/refs/heads/main/lua", key = false, group = "bonus" },
	{ id = "source-hub-v1", name = "Source Hub V1", url = "https://pastefy.app/Lk0vDMmN/raw", key = false, group = "bonus" },
	{ id = "source-hub-v2", name = "Source Hub V2", url = "https://api.obscuravm.com/scripts/7924424523909516877", key = false, group = "bonus" },
	{ id = "source-hub-v3", name = "Source Hub V3", url = "https://api.obscuravm.com/scripts/2007463552086815334", key = false, group = "bonus" },
	{ id = "shader", name = "Shader", url = "https://raw.githubusercontent.com/robloxscripts2026/simple-shader/refs/heads/main/lua", key = false, group = "bonus" },
	-- bonus, key required (bonusKey)
	{ id = "infinite-robux", name = "Infinite Robux", url = "https://pastefy.app/CkaV7ET8/raw", key = true, group = "bonus" },
	{ id = "all-games-script", name = "All Games Script", url = "https://raw.githubusercontent.com/leenZzZzZ/ScriptHUB/refs/heads/main/Script%20Hub", key = true, group = "bonus" },
	{ id = "flowauth", name = "Flowauth", url = "https://flowauth.net/v1/loaders/6824c37a4078d7d311677732e231edaa.lua", key = true, group = "bonus" },
}

Scripts.byId, Scripts.byName = {}, {}
Scripts.state = {}      -- id -> { state = "unchecked" | "checking" | "online" | "offline", detail, at, token }
Scripts.views = {}      -- id -> { paint(state), describe() }, set by the Scripts page
Scripts.notes = {}      -- id -> "Last run: ..." text shown on the card
Scripts.confirmed = {}  -- id -> true once the first-run dialog was accepted this session
Scripts.running = {}    -- id -> true while Execute is working on it
Scripts.sweep = { running = false, token = 0 }
Scripts.onState = nil   -- optional function() that refreshes the "Link status" summary
Scripts.checkSeconds = 12
Scripts.gapSeconds = 0.4

for _, entry in ipairs(Scripts.catalog) do
	Scripts.byId[entry.id] = entry
	Scripts.byName[entry.name] = entry
	Scripts.state[entry.id] = { state = "unchecked", detail = "", token = 0 }
end

-- host part of a link, shown in the cards and in the first-run dialog
function Scripts.host(url)
	local host = string.match(tostring(url), "^%a[%w+.%-]*://([^/%?#]+)")
	if not host then
		return "unknown host"
	end
	host = string.gsub(host, "^.*@", "")
	return host
end

----------------------------------------------------------------------------------------------------
-- favorites (Store key "scriptFavorites": a list of catalog ids)
----------------------------------------------------------------------------------------------------
function Scripts.isFavorite(id)
	return Util.indexOf(Store.get("scriptFavorites"), id) ~= nil
end

-- returns true when the script is a favorite afterwards
function Scripts.toggleFavorite(id)
	if not Scripts.byId[id] then
		return false
	end
	local list = Util.copy(Store.get("scriptFavorites"))
	local index = Util.indexOf(list, id)
	if index then
		table.remove(list, index)
	else
		if #list >= Store.rules.scriptFavorites.max then
			Notify.warn("Favorites full", "You can keep up to " .. Store.rules.scriptFavorites.max .. " favorite scripts.")
			return false
		end
		list[#list + 1] = id
	end
	Store.set("scriptFavorites", list)
	return index == nil
end

-- drops favorites whose script is no longer in the catalog; returns how many were removed
function Scripts.pruneFavorites()
	local list, kept = Store.get("scriptFavorites"), {}
	for _, id in ipairs(list) do
		if Scripts.byId[id] then
			kept[#kept + 1] = id
		end
	end
	local removed = #list - #kept
	if removed > 0 then
		Store.set("scriptFavorites", kept, true)
		Util.log("info", "removed " .. removed .. " script favorite(s) that are not in the catalog")
	end
	return removed
end

-- Vyre Hub saved { [scriptName] = true } in VyreHub_Favorites.json; map those names to catalog ids
function Scripts.importLegacy(decoded)
	local ids = {}
	if type(decoded) ~= "table" then
		return ids
	end
	for _, entry in ipairs(Scripts.catalog) do
		if decoded[entry.name] == true then
			ids[#ids + 1] = entry.id
		end
	end
	return ids
end

----------------------------------------------------------------------------------------------------
-- link status (never persisted, never started at boot)
----------------------------------------------------------------------------------------------------
function Scripts.setState(id, state, detail)
	local st = Scripts.state[id]
	if not st then
		return
	end
	st.state, st.detail = state, detail or ""
	if state == "online" or state == "offline" then
		st.at = os.date("%H:%M:%S")
	end
	local view = Scripts.views[id]
	if view then
		Util.try("script card " .. id, view.paint, st)
	end
	if Scripts.onState then
		Util.try("script summary", Scripts.onState)
	end
end

function Scripts.setNote(id, text)
	Scripts.notes[id] = text
	local view = Scripts.views[id]
	if view then
		Util.try("script note " .. id, view.describe)
	end
end

function Scripts.counts()
	local counts = { unchecked = 0, checking = 0, online = 0, offline = 0 }
	for _, entry in ipairs(Scripts.catalog) do
		local state = Scripts.state[entry.id].state
		counts[state] = counts[state] + 1
	end
	return counts
end

-- Blocks (yields) until the link answered or Scripts.checkSeconds passed. Online = HTTP 2xx, nothing more.
function Scripts.check(id)
	local entry, st = Scripts.byId[id], Scripts.state[id]
	if not entry or not st then
		return nil
	end
	if st.state == "checking" then
		return st.state
	end
	st.token = st.token + 1
	local token = st.token
	Scripts.setState(id, "checking", "")
	local finished = false
	task.spawn(function()
		local result = Env.fetch(entry.url, "request")
		if st.token ~= token then
			return -- timed out or superseded; the late answer is ignored
		end
		finished = true
		if result.ok then
			Scripts.setState(id, "online", result.status and ("HTTP " .. result.status) or ("answered via " .. tostring(result.via)))
		else
			Scripts.setState(id, "offline", Util.cap(tostring(result.error), 80))
		end
	end)
	local waited = 0
	while not finished and st.token == token and waited < Scripts.checkSeconds and not App.destroyed do
		task.wait(0.1)
		waited = waited + 0.1
	end
	if not finished and st.token == token and not App.destroyed then
		st.token = st.token + 1
		Scripts.setState(id, "offline", "no answer after " .. Scripts.checkSeconds .. " s")
	end
	return st.state
end

-- sequential, Scripts.gapSeconds apart, cancellable with Scripts.stopCheckAll(); onFinish runs only when the sweep completes
function Scripts.checkAll(onFinish)
	local sweep = Scripts.sweep
	if sweep.running then
		return false
	end
	sweep.running = true
	sweep.token = sweep.token + 1
	local token = sweep.token
	task.spawn(function()
		for _, entry in ipairs(Scripts.catalog) do
			if sweep.token ~= token or App.destroyed then
				break
			end
			Scripts.check(entry.id)
			if sweep.token ~= token or App.destroyed then
				break
			end
			task.wait(Scripts.gapSeconds)
		end
		if sweep.token == token then
			sweep.running = false
			if onFinish then
				Util.try("check all finish", onFinish)
			end
		end
	end)
	return true
end

function Scripts.stopCheckAll()
	local sweep = Scripts.sweep
	sweep.token = sweep.token + 1
	sweep.running = false
end

----------------------------------------------------------------------------------------------------
-- Execute: fetch -> compile -> run, and say which stage failed
----------------------------------------------------------------------------------------------------
function Scripts.launch(entry, button)
	local id = entry.id
	if Scripts.running[id] then
		return
	end
	Scripts.running[id] = true
	local function finish(note)
		Scripts.running[id] = nil
		Scripts.setNote(id, note)
		if button and Util.alive(button.Instance) then
			button.SetBusy(false)
		end
	end
	if button then
		button.SetBusy(true, "Fetching...")
	end

	-- 1. fetch (game:HttpGet, then the executor's request function)
	local fetched = Env.fetch(entry.url, "get")
	if not fetched.ok then
		Notify.error("Fetch failed", entry.name .. ": " .. Util.cap(tostring(fetched.error), 100))
		finish("Last run: fetch failed - " .. Util.cap(tostring(fetched.error), 60))
		return
	end
	if not string.find(fetched.body, "%S") then
		Notify.error("Fetch failed", entry.name .. ": the link answered with an empty file.")
		finish("Last run: fetch failed - empty answer")
		return
	end

	-- 2. compile
	local chunk, compileError = Env.compile(fetched.body)
	if not chunk then
		Notify.error("Compile failed", entry.name .. ": " .. Util.cap(tostring(compileError), 100))
		finish("Last run: compile failed - " .. Util.cap(tostring(compileError), 60))
		return
	end

	-- 3. run (in its own thread, so a script that keeps running never blocks the hub)
	local run = { failed = false }
	task.spawn(function()
		local ok, runError = pcall(chunk)
		if not ok then
			run.failed = true
			Notify.error("Run failed", entry.name .. ": " .. Util.cap(tostring(runError), 100))
			Scripts.setNote(id, "Last run: failed while running - " .. Util.cap(tostring(runError), 60))
		end
	end)
	task.wait(0.3)
	if run.failed then
		finish(Scripts.notes[id])
	else
		Notify.success("Script started", entry.name .. " was fetched, compiled and started. Errors after start-up are reported here.")
		finish("Last run: started at " .. os.date("%H:%M:%S"))
	end
end

-- asks once per script per session, then launches
function Scripts.run(id, button)
	local entry = Scripts.byId[id]
	if not entry or Scripts.running[id] then
		return
	end
	if not Env.canRun() then
		Notify.warn("Execute unavailable", "This executor does not provide loadstring, so scripts cannot be run here.")
		return
	end
	local function go()
		task.spawn(Scripts.launch, entry, button)
	end
	if Scripts.confirmed[id] then
		go()
		return
	end
	local opened = UI.confirm({
		title = "Run this script?",
		text = string.format(
			"Name: %s\nHost: %s\nKey required: %s\n\nThis is third-party code. It runs with full access to your Roblox client and is not checked by VirexHub. Only continue if you trust the source.",
			entry.name, Scripts.host(entry.url), entry.key and "yes" or "no"
		),
		confirmText = "Run", cancelText = "Cancel", danger = true,
		onConfirm = function()
			Scripts.confirmed[id] = true
			go()
		end,
	})
	if not opened then
		Notify.warn("Dialog busy", "Close the open dialog first, then tap Execute again.")
	end
end

----------------------------------------------------------------------------------------------------
-- Steal An Egg: the built-in panel (ported from VYRE_6_3_STEAL-AN-EGG.lua)
--
-- WHAT IS HERE. The Farm tab features from the 6.3 screenshots: Plot & Pets (Auto Place, Auto Hatch,
-- Equip Best Pets) and Selling & Fusion (sell rarities, Auto Sell, Sell Now, Scan Fusion, Fuse Rarities,
-- Auto Fuse), plus the Config tab (profiles, auto load, unload). The game logic follows the 6.3 modules
-- features.farm.plotcare / pets / sell / fuse and core.net / data / profiles. Only the plumbing changed:
-- BX.try -> Util.try, BX.scope loops -> Sae.loop, win.notify -> Notify, and the 6.3 widget library ->
-- this file's UI kit. There is no key and no premium check, and nothing is downloaded.
--
-- HONESTY NOTES. The panel uses Steal An Egg's own client modules and remotes (ReplicatedStorage paths
-- and remote names copied from 6.3). Those calls could NOT be run from the build sandbox, and a game
-- update can rename them. Outside Steal An Egg the panel finds nothing and says so. Everything is
-- stopped when the hub closes (Sae.stopAll).
----------------------------------------------------------------------------------------------------
local Sae = {
	running = true,       -- false after stopAll(): every loop ends and every action refuses
	loops = {},           -- running worker loops (so stopAll can end them)
	cache = {},           -- game module cache: key -> { mod = ... } | { missing = true, at = ... }
	searchedAt = {},      -- module name -> last time ReplicatedStorage was searched for it
	valueCache = {},      -- egg uid -> income per second
	valueCount = 0,
	ownerCache = nil,
	ownerAt = 0,
	profileCache = nil,
	profileAt = 0,
}
Scripts.sae = Sae

-- the entry the Scripts page lists (it is NOT in Scripts.catalog: it has no link to check or run)
Sae.entry = { id = "vyre-sae", name = "Steal An Egg (VYRE 6.3)", key = false, group = "builtin", builtin = true }
Scripts.byId[Sae.entry.id] = Sae.entry

Sae.K = {
	RETRY_AFTER = 2,      -- seconds before a missing game module is looked for again
	SEARCH_EVERY = 30,    -- seconds between full ReplicatedStorage searches for one module name
	PROFILE_TTL = 5,
	OWNER_TTL = 3,
	NET_TTL = 30,
	VALUE_CACHE_MAX = 600,
	-- Auto Place / Auto Hatch (6.3 plotcare)
	TICK = 5, HATCH_GAP = 1.5, FINISH_TRIES = 4, PLACE_GAP = 0.6, WEAR_WAIT = 1.5, SPACING = 7, MARGIN = 4,
	CLEARANCE = 5.5, SPOT_TRIES = 3, REFUSED_WAIT = 30, NEAR = 35, WALK_TIMEOUT = 8, RANGE_WAIT = 4,
	-- selling and fusion (6.3 sell / fuse)
	SELL_BATCH = 512, SELL_EVERY = 30, FUSE_EVERY = 20, FUSE_REVEAL = 1.0,
	-- profiles
	MAX_PROFILES = 30, NAME_LENGTH = 24,
}

function Sae.alive()
	return Sae.running and not App.destroyed
end

function Sae.log(level, fmt, ...)
	local ok, text = pcall(string.format, fmt, ...)
	Util.log(level, "steal an egg: " .. (ok and text or tostring(fmt)))
end

-- 6.3 slowed its timers on small touch screens; same rule here
function Sae.scale(seconds)
	local view = Env.viewport()
	local small = math.min(view.X, view.Y) < 500
	local low = Env.touch and not Env.keyboard and small
	return seconds * (low and 2.2 or 1.35)
end

-- Runs fn() now and then every `interval` seconds on its own thread until handle.Stop() (or the hub closes).
-- Errors are caught and logged, so one bad pass never ends the loop.
function Sae.loop(name, interval, fn)
	local handle = { alive = true, conns = {} }
	function handle.Stop()
		if not handle.alive then
			return
		end
		handle.alive = false
		for _, conn in ipairs(handle.conns) do
			pcall(function()
				conn:Disconnect()
			end)
		end
		handle.conns = {}
	end
	local keep = {}
	for _, other in ipairs(Sae.loops) do
		if other.alive then
			keep[#keep + 1] = other
		end
	end
	keep[#keep + 1] = handle
	Sae.loops = keep
	task.spawn(function()
		while handle.alive and Sae.alive() do
			local ok, err = pcall(fn)
			if not ok then
				Sae.log("error", "%s: %s", name, tostring(err))
			end
			local waited = 0
			while handle.alive and Sae.alive() and waited < interval do
				task.wait(0.25)
				waited = waited + 0.25
			end
		end
	end)
	return handle
end

-- first executor global function found under any of the given names
function Sae.fn(...)
	local global = Env.global()
	for _, name in ipairs({ ... }) do
		local value = nil
		pcall(function()
			value = global[name]
		end)
		if type(value) == "function" then
			return value, name
		end
	end
	return nil, nil
end

----------------------------------------------------------------------------------------------------
-- net (6.3 core.net): the game's remotes live in ReplicatedStorage.Packages.Networking
----------------------------------------------------------------------------------------------------
Sae.net = { container = nil, containerAt = 0 }

function Sae.net.root()
	local net = Sae.net
	local now = os.clock()
	if net.container and net.container.Parent and (now - net.containerAt) < Sae.K.NET_TTL then
		return net.container
	end
	local storage = game:GetService("ReplicatedStorage")
	local packages = storage:FindFirstChild("Packages")
	local found = packages and packages:FindFirstChild("Networking")
	net.container, net.containerAt = found, now
	return found
end

function Sae.net.find(name)
	local root = Sae.net.root()
	return root and root:FindFirstChild(name) or nil
end

-- RemoteFunction: returns what the server answered (a, b), or false and the reason
function Sae.net.call(name, ...)
	local remote = Sae.net.find(name)
	if not remote then
		return false, "remote not found: " .. tostring(name)
	end
	local ok, a, b = pcall(function(...)
		return remote:InvokeServer(...)
	end, ...)
	if not ok then
		return false, tostring(a)
	end
	return a, b
end

-- RemoteEvent: returns true, or false and the reason
function Sae.net.fire(name, ...)
	local remote = Sae.net.find(name)
	if not remote then
		return false, "remote not found: " .. tostring(name)
	end
	local ok, err = pcall(function(...)
		remote:FireServer(...)
	end, ...)
	if not ok then
		return false, tostring(err)
	end
	return true
end

-- a node under ReplicatedStorage by path (nil when any step is missing)
function Sae.atPath(path)
	local node = game:GetService("ReplicatedStorage")
	for _, part in ipairs(path) do
		if not node then
			return nil
		end
		node = node:FindFirstChild(part)
	end
	return node
end

-- Does this look like Steal An Egg? Needs the Networking folder plus one of the game's own pieces.
-- Nothing is required here, and the game-data functions below refuse to run when this is false, so the
-- hub never requires unrelated modules in other games.
function Sae.detected()
	if Sae.net.root() == nil then
		return false
	end
	return Sae.atPath({ "Client", "EggState" }) ~= nil
		or Sae.atPath({ "Client", "PlotState" }) ~= nil
		or Sae.net.find("RF/Haul/WearBest") ~= nil
		or Sae.net.find("RE/PetSatchel/SellSelection") ~= nil
end

----------------------------------------------------------------------------------------------------
-- game data (6.3 core.data): the game's own client modules, read with require
----------------------------------------------------------------------------------------------------
Sae.paths = {
	assets = { "Data", "Assets" },
	eggState = { "Client", "EggState" },
	assetEarnings = { "Shared", "Util", "AssetEarnings" },
	plotState = { "Client", "PlotState" },
	save = { "Shared", "Save" },
	fusionFlags = { "Shared", "Flags", "ShrineFusionFlags" },
}

-- When require fails (some executors cannot require game modules) 6.3 looked the tables up in the heap.
-- Each shape recognises one table. The sweep is guarded by a flag file so a crash cannot repeat itself.
Sae.heapShapes = {
	assets = function(t)
		local dir = rawget(t, "Directory")
		if type(dir) ~= "table" then
			return false
		end
		for _, entry in pairs(dir) do
			return type(entry) == "table" and type(entry.Rarity) == "table"
		end
		return false
	end,
	assetEarnings = function(t)
		return type(rawget(t, "LiveRatePerSecond")) == "function"
	end,
	eggState = function(t)
		return type(rawget(t, "ReadFieldEggs")) == "function"
	end,
}
Sae.heap = { tried = false, found = {} }

function Sae.harvestHeap()
	local heap = Sae.heap
	if heap.tried then
		return
	end
	heap.tried = true
	local getgc = Sae.fn("getgc")
	if not getgc then
		Sae.log("warn", "require failed and this executor has no getgc - game data stays unavailable")
		return
	end
	local files = Env.canSave()
	if files and Env.readFile(CONFIG.SaeSweepFlag) == "sweeping" then
		Sae.log("warn", "skipping the heap sweep: the client stopped during the last one")
		return
	end
	if files then
		Env.ensureFolder(CONFIG.Folder)
		Env.writeFile(CONFIG.SaeSweepFlag, "sweeping")
	end
	local okScan, objects = pcall(getgc, true)
	if files then
		Env.writeFile(CONFIG.SaeSweepFlag, "done")
	end
	if not okScan or type(objects) ~= "table" then
		Sae.log("warn", "getgc gave nothing usable")
		return
	end
	local scanned, hits = 0, {}
	for _, obj in ipairs(objects) do
		if type(obj) == "table" then
			scanned = scanned + 1
			for key, shape in pairs(Sae.heapShapes) do
				if not heap.found[key] then
					local ok, matched = pcall(shape, obj)
					if ok and matched then
						heap.found[key] = obj
						hits[#hits + 1] = key
					end
				end
			end
		end
	end
	Sae.log("info", "heap sweep: %d tables, recovered %s", scanned, #hits > 0 and table.concat(hits, ", ") or "nothing")
end

function Sae.searchModule(name)
	for _, d in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if d:IsA("ModuleScript") and d.Name == name then
			return d
		end
	end
	return nil
end

-- require with a raised thread identity where the executor offers one (the game's modules expect it)
function Sae.requireGame(inst)
	local setIdentity = Sae.fn("setthreadidentity", "set_thread_identity", "setidentity", "setthreadcontext")
	local getIdentity = Sae.fn("getthreadidentity", "get_thread_identity", "getidentity", "getthreadcontext")
	if not (setIdentity and getIdentity) then
		return require(inst)
	end
	local okPrevious, previous = pcall(getIdentity)
	if not okPrevious or type(previous) ~= "number" then
		return require(inst)
	end
	local result
	local ok, err = pcall(function()
		setIdentity(2)
		result = require(inst)
	end)
	pcall(setIdentity, previous)
	if not ok then
		error(err, 0)
	end
	return result
end

-- a game module by key (see Sae.paths); nil when it is not there (cached for a moment)
function Sae.resolve(key)
	local held = Sae.cache[key]
	if held and held.mod then
		return held.mod
	end
	if held and held.missing and (os.clock() - (held.at or 0)) < Sae.K.RETRY_AFTER then
		return nil
	end
	Sae.cache[key] = nil
	local path = Sae.paths[key]
	if not path then
		return nil
	end
	if not Sae.detected() then
		Sae.cache[key] = { missing = true, at = os.clock() }
		return nil
	end
	local inst = Sae.atPath(path)
	if not (inst and inst:IsA("ModuleScript")) then
		local name = path[#path]
		local last = Sae.searchedAt[name]
		if not last or (os.clock() - last) > Sae.K.SEARCH_EVERY then
			Sae.searchedAt[name] = os.clock()
			local found = Sae.searchModule(name)
			if found then
				Sae.log("warn", "%s was not a module at %s - using %s", name, table.concat(path, "."), found:GetFullName())
				inst = found
			end
		end
	end
	if not inst then
		Sae.cache[key] = { missing = true, at = os.clock() }
		return nil
	end
	local mod
	local ok = Util.try("steal an egg require " .. key, function()
		mod = Sae.requireGame(inst)
	end)
	if not ok or type(mod) ~= "table" then
		if Sae.heapShapes[key] then
			Sae.harvestHeap()
			if Sae.heap.found[key] then
				Sae.log("info", "%s recovered from the heap", key)
				Sae.cache[key] = { mod = Sae.heap.found[key] }
				return Sae.heap.found[key]
			end
		end
		Sae.cache[key] = { missing = true, at = os.clock() }
		return nil
	end
	Sae.cache[key] = { mod = mod }
	return mod
end

function Sae.assetsDir()
	local assets = Sae.resolve("assets")
	return assets and assets.Directory or nil
end

-- the player's save data (pets, eggs, fusion slots ...)
function Sae.profile()
	local save = Sae.resolve("save")
	if save and type(save.Get) == "function" then
		local ok, data = pcall(save.Get, Players.LocalPlayer)
		if ok and type(data) == "table" then
			return data
		end
	end
	local now = os.clock()
	if Sae.profileCache and (now - Sae.profileAt) < Sae.K.PROFILE_TTL then
		return Sae.profileCache
	end
	local got = Sae.net.call("RF/ProfileMirror/FetchProfile")
	if type(got) ~= "table" then
		return nil
	end
	Sae.profileCache, Sae.profileAt = got, now
	return got
end

-- returns full (true/false/nil), count, limit
function Sae.eggInventory()
	local count, limit
	Util.try("steal an egg inventory count", function()
		local save = Sae.resolve("save")
		local data = save and type(save.Get) == "function" and save.Get(Players.LocalPlayer)
		if type(data) == "table" and type(data.EggInventory) == "table" then
			count = 0
			for _ in pairs(data.EggInventory) do
				count = count + 1
			end
		end
	end)
	Util.try("steal an egg inventory limit", function()
		local flags = Sae.resolve("fusionFlags")
		local flag = flags and flags.EggInventoryLimit
		limit = flag and type(flag.Get) == "function" and tonumber(flag:Get()) or nil
	end)
	limit = limit or 115
	if not count then
		return nil, nil, limit
	end
	return count >= limit, count, limit
end

----------------------------------------------------------------------------------------------------
-- pet catalog fallback, rarities and egg value
----------------------------------------------------------------------------------------------------
-- pet catalog copied from the 6.3 build (features.catalogdata): { category, display name, rarity id, rarity number, base income per second }
-- It is only a fallback for rarity and income when the game's own modules cannot be read.
Sae.bakedRows = {
	{ "Abyssal Overlord", "Abyss Overlord", "Secret", 8, 1250000 },
	{ "Abyssal Overlord OP", "Abyss Overlord", "Secret", 8, 100000000 },
	{ "Alabaster Whale", "Beluga Whale", "Cosmic", 7, 850000 },
	{ "Alien Skeleton Boss", "Cosmic Skeleton Boss", "Secret", 8, 45000000 },
	{ "Ankylosaurus", "Ankylosaurus", "Mythic", 6, 120000 },
	{ "Archdemon Dragon", "Archdemon Dragon", "Divine", 10, 1250000000 },
	{ "Ascended Vermilion Phoenix", "Phoenix", "Eternal", 9, 85000000 },
	{ "Ash Gecko", "Lava Gecko", "Rare", 3, 180 },
	{ "Baby Aurora Dragon", "Baby Aurora Dragon", "Legendary", 5, 5000000 },
	{ "Balrog", "Balrog", "Eternal", 9, 200000000 },
	{ "Bananita Dolphinita", "Bananita Dolphinita", "Epic", 4, 400 },
	{ "Basilisk", "Leviathan", "Cosmic", 7, 220000 },
	{ "Bear", "Bear", "Epic", 4, 240 },
	{ "Belula Beluga", "Belula Beluga", "Mythic", 6, 40000 },
	{ "Blade Head", "Bladehide", "Mythic", 6, 750000 },
	{ "Bomboclat Crocolat", "Bombo Croco", "Secret", 8, 20000000 },
	{ "Bronto", "Bronto", "Cosmic", 7, 1500000 },
	{ "Brr Brr Patapim", "Brr Brr Patapim", "Legendary", 5, 1800 },
	{ "Burrowing Owl", "Burrowing Owl", "Rare", 3, 35 },
	{ "Camel", "Camel", "Rare", 3, 75 },
	{ "Catfish", "Catfish", "Uncommon", 2, 12 },
	{ "Cave Dragon", "Cosmic Dragon", "Secret", 8, 60000000 },
	{ "Centapede", "Centapede", "Epic", 4, 1500 },
	{ "Cerberus", "Cerberus", "Secret", 8, 8000000 },
	{ "Chicken", "Chicken", "Common", 1, 1 },
	{ "Chillin Chilli", "Chillin Chilli", "Mythic", 6, 55000 },
	{ "Chimpanzee", "Chimpanzee", "Rare", 3, 90 },
	{ "Colossal Mammoth", "King Mammoth", "Cosmic", 7, 400000 },
	{ "Crab", "Crustacia", "Legendary", 5, 130000 },
	{ "Crane", "Crane", "Epic", 4, 4000 },
	{ "Crawler", "Crawler", "Cosmic", 7, 1500000 },
	{ "Crocodile", "Crocodile", "Epic", 4, 420 },
	{ "Crocodon", "Crocodon", "Secret", 8, 30000000 },
	{ "Cthulhu", "Cthulhu", "Divine", 10, 3000000000 },
	{ "Cyclops Gorilla", "Cosmic Gorilla", "Mythic", 6, 180000 },
	{ "DeathstalkerScorpion", "Scorpion", "Mythic", 6, 18500 },
	{ "Demon Hound", "Demon Hound", "Cosmic", 7, 25000000 },
	{ "Demon Imp", "Demon Imp", "Cosmic", 7, 700000 },
	{ "Depths Cthulhu", "Luminous Cthulhu", "Divine", 10, 6500000000 },
	{ "Depths Electric Eel", "Luminous Electric Eel", "Eternal", 9, 1750000000 },
	{ "Depths Manta Ray", "Luminous Spirit Manta", "Secret", 8, 500000000 },
	{ "Depths Megalodon", "Luminous Abyss Shark", "Secret", 8, 600000000 },
	{ "Depths Riptide Octopus", "Depths Riptide Octopus", "Cosmic", 7, 430000000 },
	{ "Depths Spike", "Luminous Spike", "Secret", 8, 350000000 },
	{ "Depths Terra Snapper", "Luminous Terra Snapper", "Eternal", 9, 2500000000 },
	{ "DesertLark", "Bird", "Uncommon", 2, 8 },
	{ "Dodo", "Dodo", "Rare", 3, 280 },
	{ "Dog", "Dog", "Common", 1, 2 },
	{ "Dragon", "Lava Dragon", "Eternal", 9, 100000000 },
	{ "Dreadclaw", "Dreadclaw", "Cosmic", 7, 2200000 },
	{ "Dreadscale", "Dreadscale", "Divine", 10, 2000000000 },
	{ "Dream Axolotl", "Axolotl", "Legendary", 5, 2800 },
	{ "Drill Monster", "Drilla", "Cosmic", 7, 100000000 },
	{ "Duckling", "Duckling", "Common", 1, 4 },
	{ "El Maja", "El Maja", "Eternal", 9, 130000000 },
	{ "Electric Eel", "Electric Eel", "Secret", 8, 200000000 },
	{ "Ember Dragon", "Ember Dragon", "Secret", 8, 600000000 },
	{ "Eternal Lunar Dragon", "Eternal Lunar Dragon", "Eternal", 9, 250000000 },
	{ "FennecFox", "Fennec", "Uncommon", 2, 18 },
	{ "Finned Thresher", "Shark", "Legendary", 5, 15000 },
	{ "Flaming Bull", "Flaming Bull", "Legendary", 5, 9500 },
	{ "Frog", "Frog", "Common", 1, 3 },
	{ "Froggo", "Froggo", "Mythic", 6, 50000 },
	{ "Galaxy Gecko", "Cosmic Gecko", "Legendary", 5, 30000 },
	{ "Godzilla", "Nightflame", "Divine", 10, 3000000000 },
	{ "Gorilla", "Gorilla", "Legendary", 5, 4800 },
	{ "Hellhound", "Hellhound", "Cosmic", 7, 1800000 },
	{ "Ice Dragon", "Ice Dragon", "Eternal", 9, 65000000 },
	{ "Imp", "Imp", "Cosmic", 7, 16000000 },
	{ "Irihorus", "Royal Sphinx", "Cosmic", 7, 280000 },
	{ "Jellyfish", "Pure Jellyfish", "Secret", 8, 225000000 },
	{ "Jerboa", "Jerboa", "Common", 1, 6 },
	{ "Kaiju Spider", "Spideron", "Legendary", 5, 95000 },
	{ "King Kong", "Gorilla King", "Eternal", 9, 880000000 },
	{ "Kitsune", "Kitsune", "Divine", 10, 1800000000 },
	{ "Koi", "Koi", "Cosmic", 7, 12000000 },
	{ "Kraken", "Kraken", "Secret", 8, 15000000 },
	{ "Krakenoid", "Krakenoid", "Eternal", 9, 500000000 },
	{ "La Vacca Saturno Saturnita", "La Vacca Saturno Saturnita", "Cosmic", 7, 2200000 },
	{ "Lava Iguana", "Lava Iguana", "Legendary", 5, 11000 },
	{ "Lava frog", "Lava frog", "Epic", 4, 850 },
	{ "Mammoth", "Mammoth", "Mythic", 6, 42000 },
	{ "Mangolini Parrochini", "Mangolini Parrochini", "Cosmic", 7, 800000 },
	{ "Manta Ray", "Spirit Manta", "Mythic", 6, 75000 },
	{ "Mantis", "Mantaris", "Cosmic", 7, 11000000 },
	{ "Mawbreaker", "Mawbreaker", "Secret", 8, 60000000 },
	{ "Mecha Crawler", "Mecha Crawler", "Secret", 8, 320000000 },
	{ "Mecha Crocodon", "Mecha Crocodon", "Eternal", 9, 680000000 },
	{ "Mecha Dreadscale", "Mecha Dreadscale", "Divine", 10, 4000000000 },
	{ "Mecha Froggo", "Mecha Froggo", "Secret", 8, 155000000 },
	{ "Mecha Krakenoid", "Mecha Krakenoid", "Eternal", 9, 1000000000 },
	{ "Mecha Scorpio", "Mecha Scorpio", "Secret", 8, 45000000 },
	{ "Megalodon", "Abyss Shark", "Cosmic", 7, 2500000 },
	{ "Mire Fox", "Fox", "Epic", 4, 180 },
	{ "Mosasaurus", "Mosasaurus", "Eternal", 9, 180000000 },
	{ "Oni Tiger", "Oni Tiger", "Eternal", 9, 600000000 },
	{ "Orangutini Ananassini", "Orangutini Ananassini", "Legendary", 5, 5500 },
	{ "Orca", "Orca", "Mythic", 6, 80000 },
	{ "Parrotfish", "Parrotfish", "Rare", 3, 220 },
	{ "Penguin", "Penguin", "Rare", 3, 140 },
	{ "Polar Bear", "Polar Bear", "Legendary", 5, 7000 },
	{ "Pterodactyl", "Pterodactyl", "Legendary", 5, 22000 },
	{ "Raccoon", "Raccoon", "Rare", 3, 45 },
	{ "Rattlesnake", "Snake", "Legendary", 5, 3600 },
	{ "RazorFang", "RazorFang", "Secret", 8, 350000000 },
	{ "Red Panda", "Red Panda", "Mythic", 6, 450000 },
	{ "Rhino", "Rhinotaur", "Cosmic", 7, 17500000 },
	{ "Rift Eye", "Rift Eye", "Legendary", 5, 11000 },
	{ "Riftwing", "Riftwing", "Mythic", 6, 220000 },
	{ "Ring Guard", "Ring Guard", "Cosmic", 7, 15000000 },
	{ "Ringlord", "Ringlord", "Secret", 8, 825000000 },
	{ "Riptide Octopus", "Riptide Octopus", "Cosmic", 7, 1500000 },
	{ "Sabertooth Tiger", "Sabertooth Tiger", "Mythic", 6, 35000 },
	{ "Salamander", "Salamander", "Legendary", 5, 74000 },
	{ "Sand Spider", "Sand Spider", "Mythic", 6, 16000 },
	{ "ScorchedDragon", "Scorched Dragon", "Secret", 8, 35000000 },
	{ "Scorpio", "Scorpio", "Legendary", 5, 10000 },
	{ "Shadow Dragon", "Shadow Dragon", "Mythic", 6, 25000000 },
	{ "Shardling", "Shardling", "Mythic", 6, 450000 },
	{ "Shardwing", "Shardwing", "Secret", 8, 145000000 },
	{ "Shark", "Mutant Shark", "Secret", 8, 215000000 },
	{ "Shattered Colossus", "Shattered Colossus", "Divine", 10, 3500000000 },
	{ "Shattered Drake", "Shattered Drake", "Eternal", 9, 800000000 },
	{ "Shattered Ram", "Shattered Ram", "Cosmic", 7, 8000000 },
	{ "Snowy Owl", "Snowy Owl", "Cosmic", 7, 7500000 },
	{ "Spider", "Spider", "Mythic", 6, 22000 },
	{ "Spike", "Spike", "Legendary", 5, 15000 },
	{ "Stag", "Stag", "Secret", 8, 145000000 },
	{ "Strawberry Elephant", "Strawberry Elephant", "Eternal", 9, 110000000 },
	{ "Swan", "Swan", "Epic", 4, 320 },
	{ "Swordfish", "Swordfish", "Epic", 4, 1100 },
	{ "Terra Snapper", "Terra Snapper", "Eternal", 9, 750000000 },
	{ "Tiger", "Tiger", "Mythic", 6, 28000 },
	{ "Tob Tobi Tob Tob", "Tob Tobi Tob Tob", "Epic", 4, 325 },
	{ "Toucan", "Toucan", "Rare", 3, 110 },
	{ "Tralaledon", "Tralaledon", "Secret", 8, 32000000 },
	{ "Triceratops", "Triceratops", "Cosmic", 7, 1200000 },
	{ "Trulimero Trulicina", "Trulimero Trulicina", "Epic", 4, 260 },
	{ "Tung Tung Sahur", "Tung Tung Sahur", "Rare", 3, 100 },
	{ "Turtle", "Turtle", "Rare", 3, 60 },
	{ "TyrannosaurusRex", "TRex", "Secret", 8, 25000000 },
	{ "Unicorn", "Unicorn", "Divine", 10, 1000000000 },
	{ "Ventinal", "Ventinal", "Cosmic", 7, 585000 },
	{ "Void Angler", "Void Angler", "Legendary", 5, 30000 },
	{ "Void Dragon", "Void Dragon", "Eternal", 9, 120000000 },
	{ "Void Serpent", "Void Serpent", "Eternal", 9, 900000000 },
	{ "Voidmaw", "Voidmaw", "Mythic", 6, 50000 },
	{ "Walrus", "Walrus", "Epic", 4, 600 },
	{ "Warden", "King Snake", "Secret", 8, 3500000 },
	{ "Wendigo", "Wendigo", "Secret", 8, 15000000 },
	{ "Whale Shark", "Whale Shark", "Cosmic", 7, 700000 },
	{ "World Eater", "World Eater", "Eternal", 9, 500000000 },
	{ "Yeti", "Yeti", "Secret", 8, 5000000 },
}

Sae.baked = {}
for _, row in ipairs(Sae.bakedRows) do
	Sae.baked[row[1]] = { name = row[2], rarityId = row[3], rarityNum = row[4], rate = row[5] }
end

-- the standard ladder, used to fill the rarity lists when the game's own list cannot be read
Sae.fallbackRarities = {
	{ id = "Common", num = 1 }, { id = "Uncommon", num = 2 }, { id = "Rare", num = 3 }, { id = "Epic", num = 4 },
	{ id = "Legendary", num = 5 }, { id = "Mythic", num = 6 }, { id = "Cosmic", num = 7 }, { id = "Secret", num = 8 },
	{ id = "Eternal", num = 9 }, { id = "Divine", num = 10 },
}

-- rarity id of a pet / egg category ("" is never returned; nil means unknown)
function Sae.rarityOf(category)
	local dir = Sae.assetsDir()
	local entry = dir and category and dir[category]
	local rarity = type(entry) == "table" and entry.Rarity or nil
	if type(rarity) == "table" then
		return tostring(rarity._id or rarity.DisplayName or "")
	end
	local baked = category and Sae.baked[tostring(category)]
	return baked and tostring(baked.rarityId or "") or nil
end

function Sae.nameOf(category)
	local dir = Sae.assetsDir()
	local entry = dir and category and dir[category]
	if type(entry) == "table" and entry.DisplayName then
		return tostring(entry.DisplayName)
	end
	local baked = category and Sae.baked[tostring(category)]
	return baked and baked.name or tostring(category)
end

-- rows { id, label, num } for the rarity pickers: game list, else the baked list, always topped up with the standard ladder
function Sae.rarityOptions()
	local seen, rows = {}, {}
	for _, entry in pairs(Sae.assetsDir() or {}) do
		local rarity = type(entry) == "table" and entry.Rarity or nil
		if type(rarity) == "table" then
			local id = tostring(rarity._id or rarity.DisplayName or "")
			if id ~= "" and not seen[id] then
				seen[id] = true
				rows[#rows + 1] = { id = id, label = tostring(rarity.DisplayName or id), num = tonumber(rarity.RarityNumber) or 0 }
			end
		end
	end
	if #rows == 0 then
		for _, baked in pairs(Sae.baked) do
			local id = tostring(baked.rarityId or "")
			if id ~= "" and not seen[id] then
				seen[id] = true
				rows[#rows + 1] = { id = id, label = id, num = tonumber(baked.rarityNum) or 0 }
			end
		end
	end
	local order = {}
	for _, row in ipairs(Sae.fallbackRarities) do
		order[row.id] = row.num
		if not seen[row.id] then
			seen[row.id] = true
			rows[#rows + 1] = { id = row.id, label = row.id, num = row.num }
		end
	end
	for _, row in ipairs(rows) do
		if (tonumber(row.num) or 0) == 0 then
			row.num = order[row.id] or 99
		end
	end
	table.sort(rows, function(a, b)
		if a.num ~= b.num then
			return a.num < b.num
		end
		return a.label < b.label
	end)
	return rows
end

-- the player's eggs: { [uid] = { Placement, AssetCategory, AssetScale, Mutations, ... } }
function Sae.ownerEggs(userId)
	userId = userId or (Players.LocalPlayer and Players.LocalPlayer.UserId)
	if not userId then
		return {}
	end
	local eggState = Sae.resolve("eggState")
	if eggState and type(eggState.ReadOwnerEggs) == "function" then
		local ok, recs = pcall(eggState.ReadOwnerEggs, userId)
		if ok and type(recs) == "table" then
			return recs
		end
	end
	local now = os.clock()
	if Sae.ownerCache and (now - Sae.ownerAt) < Sae.K.OWNER_TTL then
		return Sae.ownerCache
	end
	local snapshot = Sae.net.call("RF/EggWorld/AskLiveSnapshot")
	local mine = {}
	if type(snapshot) == "table" then
		for _, row in pairs(snapshot) do
			if type(row) == "table" and tonumber(row.OwnerUserId) == tonumber(userId) then
				mine = type(row.Records) == "table" and row.Records or {}
				break
			end
		end
	end
	Sae.ownerCache, Sae.ownerAt = mine, now
	return mine
end

-- income per second of one egg record (used to place the best eggs first); 0 when nothing can price it
function Sae.eggValue(rec)
	local uid = rec.Uid and tostring(rec.Uid) or nil
	local hit = uid and Sae.valueCache[uid]
	if hit then
		return hit
	end
	local scale = tonumber(rec.AssetScale) or 1
	local value = 0
	local earnings = Sae.resolve("assetEarnings")
	if earnings then
		local item = { Category = rec.AssetCategory, Scale = scale, Mutations = rec.Mutations or {} }
		local ok, rate = pcall(earnings.LiveRatePerSecond, item, nil, nil, Players.LocalPlayer)
		if ok and type(rate) == "number" then
			value = rate
		elseif type(earnings.MutationOnlyRatePerSecond) == "function" then
			local okMutation, mutationRate = pcall(earnings.MutationOnlyRatePerSecond, item)
			if okMutation and type(mutationRate) == "number" then
				value = mutationRate
			end
		end
	end
	if value == 0 then
		value = tonumber(rec.RatePerSecond or rec.IncomePerSecond or rec.EarningsPerSecond or rec.Rate or rec.Income
			or rec.Value or rec.CashPerSecond) or 0
	end
	if value == 0 then
		local dir = Sae.assetsDir()
		local entry = dir and rec.AssetCategory and dir[rec.AssetCategory]
		if type(entry) == "table" then
			local egg = type(entry.Egg) == "table" and entry.Egg or {}
			local base = tonumber(entry.EarningRate) or tonumber(entry.EarningsRate) or tonumber(entry.IncomeRate)
				or tonumber(entry.RatePerSecond) or tonumber(entry.Income) or tonumber(entry.Earnings)
				or tonumber(egg.EarningRate) or tonumber(egg.Income)
			if base then
				value = base * scale
			end
		end
	end
	if value == 0 then
		local baked = rec.AssetCategory and Sae.baked[tostring(rec.AssetCategory)]
		if baked and tonumber(baked.rate) then
			value = tonumber(baked.rate) * scale
		end
	end
	if uid and value > 0 then
		if Sae.valueCount >= Sae.K.VALUE_CACHE_MAX then
			Sae.valueCache, Sae.valueCount = {}, 0
		end
		Sae.valueCache[uid] = value
		Sae.valueCount = Sae.valueCount + 1
	end
	return value
end

function Sae.inArena()
	local player = Players.LocalPlayer
	return player ~= nil and player:GetAttribute("InBossArena") == true
end

----------------------------------------------------------------------------------------------------
-- Plot & Pets: Auto Place, Auto Hatch (6.3 features.farm.plotcare) and Equip Best Pets (features.farm.pets)
----------------------------------------------------------------------------------------------------
Sae.care = {
	placeOn = false, hatchOn = false,
	placeLoop = nil, hatchLoop = nil,
	busyPlace = false, busyHatch = false,
	cooldownUntil = 0,
	nearNeeded = Sae.K.NEAR,
	lastPlace = "off", lastHatch = "off",
	stats = { placed = 0, placeRefused = 0, hatched = 0, hatchRefused = 0, finishRetries = 0 },
}

function Sae.care.owned()
	local recs = {}
	Util.try("steal an egg owner eggs", function()
		recs = Sae.ownerEggs(Players.LocalPlayer and Players.LocalPlayer.UserId) or {}
	end)
	return recs, Sae.resolve("eggState")
end

-- begin the hatch, then finish it (the server needs a moment in between)
function Sae.care.hatchOne(eggState, uid)
	local care = Sae.care
	local ok, msg, result = false, nil, nil
	Util.try("steal an egg begin hatch", function()
		ok, msg, result = eggState.BeginHatch(uid)
	end)
	if not ok then
		care.stats.hatchRefused = care.stats.hatchRefused + 1
		care.lastHatch = "refused: " .. tostring(msg or "no reason given")
		Sae.log("warn", "BeginHatch refused for %s: %s", tostring(uid), tostring(msg))
		return false
	end
	for attempt = 1, Sae.K.FINISH_TRIES do
		task.wait(Sae.K.HATCH_GAP)
		if not care.hatchOn then
			return false
		end
		local finished, finishMsg, granted = false, nil, nil
		Util.try("steal an egg finish hatch", function()
			finished, finishMsg, granted = eggState.FinishHatch(uid)
		end)
		if finished then
			care.stats.hatched = care.stats.hatched + 1
			care.lastHatch = string.format("hatched %d this session", care.stats.hatched)
			Sae.log("info", "hatched %s -> %s%s", tostring(uid), tostring(granted), result and (" (" .. tostring(result) .. ")") or "")
			return true
		end
		care.stats.finishRetries = care.stats.finishRetries + 1
		Sae.log("warn", "FinishHatch %d/%d for %s: %s", attempt, Sae.K.FINISH_TRIES, tostring(uid), tostring(finishMsg))
		care.lastHatch = "finishing: " .. tostring(finishMsg or "waiting")
	end
	return false
end

function Sae.care.hatchPass()
	local care = Sae.care
	if not care.hatchOn or care.busyHatch then
		return
	end
	care.busyHatch = true
	Util.try("steal an egg hatch pass", function()
		local recs, eggState = care.owned()
		if not (eggState and eggState.IsReadyToHatch and eggState.BeginHatch and eggState.FinishHatch) then
			care.lastHatch = "hatch API unavailable"
			return
		end
		local placed, ready = 0, {}
		for uid, rec in pairs(recs) do
			if type(rec) == "table" and rec.Placement ~= nil then
				placed = placed + 1
				local isReady = false
				Util.try("steal an egg ready check", function()
					isReady = eggState.IsReadyToHatch(uid) == true
				end)
				if isReady then
					ready[#ready + 1] = uid
				end
			end
		end
		if #ready == 0 then
			care.lastHatch = placed == 0 and "nothing placed" or (tostring(placed) .. " growing")
			return
		end
		for _, uid in ipairs(ready) do
			if not care.hatchOn then
				break
			end
			care.hatchOne(eggState, uid)
		end
	end)
	care.busyHatch = false
end

-- free spots on the player's plot, as CFrames relative to the plot centre
function Sae.care.freeSpots(plot)
	local K = Sae.K
	local area, center = plot.PetArea, plot.CenterPoint
	if not (area and center and area:IsA("BasePart")) then
		return {}
	end
	local taken = {}
	local folder = workspace:FindFirstChild("PlacedEggRenders")
	local prefix = tostring(Players.LocalPlayer and Players.LocalPlayer.UserId) .. "_"
	if folder then
		for _, model in ipairs(folder:GetChildren()) do
			if model:IsA("Model") and string.sub(model.Name, 1, #prefix) == prefix then
				Util.try("steal an egg pivot", function()
					taken[#taken + 1] = model:GetPivot().Position
				end)
			end
		end
	end
	local half = area.Size * 0.5
	local spots = {}
	for x = -half.X + K.MARGIN, half.X - K.MARGIN, K.SPACING do
		for z = -half.Z + K.MARGIN, half.Z - K.MARGIN, K.SPACING do
			local world = (area.CFrame * CFrame.new(x, half.Y, z)).Position
			local clear = true
			for _, p in ipairs(taken) do
				local flat = Vector3.new(p.X - world.X, 0, p.Z - world.Z)
				if flat.Magnitude < K.CLEARANCE then
					clear = false
					break
				end
			end
			if clear then
				spots[#spots + 1] = center.CFrame:ToObjectSpace(CFrame.new(world))
			end
		end
	end
	return spots
end

-- uid of the egg tool the character is holding (waits up to `timeout` seconds for it to appear)
function Sae.care.wornEggToolUid(timeout)
	local deadline = os.clock() + (timeout or 0)
	repeat
		local player = Players.LocalPlayer
		local char = player and player.Character
		if char then
			for _, child in ipairs(char:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("ItemType") == "AssetEgg" then
					local uid = child:GetAttribute("UID")
					if type(uid) == "string" and uid ~= "" then
						return uid
					end
				end
			end
		end
		if os.clock() >= deadline then
			break
		end
		task.wait(0.05)
	until false
	return nil
end

-- eggs that are not on the plot yet, best income first
function Sae.care.unplaced(recs)
	local list = {}
	for uid, rec in pairs(recs) do
		if type(rec) == "table" and rec.Placement == nil then
			local value = 0
			Util.try("steal an egg value", function()
				value = Sae.eggValue({ Uid = uid, AssetCategory = rec.AssetCategory, AssetScale = rec.AssetScale, Mutations = rec.Mutations }) or 0
			end)
			list[#list + 1] = { uid = uid, value = tonumber(value) or 0, name = tostring(rec.AssetCategory) }
		end
	end
	table.sort(list, function(a, b)
		return a.value > b.value
	end)
	return list
end

function Sae.care.placeOne(eggState, plot, egg)
	local care = Sae.care
	local K = Sae.K
	local worn, wearMsg = false, nil
	Util.try("steal an egg wear", function()
		worn, wearMsg = eggState.WearEggTool(egg.uid)
	end)
	if not worn then
		return false, "could not hold the egg: " .. tostring(wearMsg or "refused")
	end
	local toolUid = care.wornEggToolUid(K.WEAR_WAIT) or egg.uid
	local spots = care.freeSpots(plot)
	if #spots == 0 then
		Util.try("steal an egg doff", function()
			eggState.DoffEggTool(toolUid)
		end)
		return false, "no free space on the plot"
	end
	local lastMsg
	for i = 1, math.min(K.SPOT_TRIES, #spots) do
		local spot = spots[((care.stats.placed + i - 1) % #spots) + 1]
		local ok, msg = false, nil
		Util.try("steal an egg plant", function()
			ok, msg = eggState.PlantEgg(toolUid, spot)
		end)
		if ok then
			care.stats.placed = care.stats.placed + 1
			Sae.log("info", "placed %s (%s)", egg.name, tostring(toolUid))
			return true
		end
		lastMsg = msg
		Sae.log("warn", "PlantEgg refused (%s): %s", egg.name, tostring(msg))
	end
	Util.try("steal an egg doff", function()
		eggState.DoffEggTool(toolUid)
	end)
	return false, tostring(lastMsg or "refused")
end

function Sae.care.isRangeRefusal(msg)
	return type(msg) == "string" and string.find(string.lower(msg), "closer", 1, true) ~= nil
end

-- walk to the plot when the character is far away; returns true, or false and the reason
function Sae.care.walkToPlot(plot)
	local care = Sae.care
	local player = Players.LocalPlayer
	local char = player and player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local anchor = plot.CenterPoint or plot.PetArea
	if not (hum and root and anchor and anchor:IsA("BasePart")) then
		return false, "no character or plot to walk to"
	end
	local target = anchor.Position
	local function flatDistance()
		local d = root.Position - target
		return Vector3.new(d.X, 0, d.Z).Magnitude
	end
	if flatDistance() <= care.nearNeeded then
		return true
	end
	if hum.Health <= 0 then
		return false, "character is dead"
	end
	care.lastPlace = "walking to your plot"
	Sae.log("info", "walking to the plot to place (%.0f studs away)", flatDistance())
	local deadline = os.clock() + Sae.K.WALK_TIMEOUT
	local lastIssue = 0
	while os.clock() < deadline do
		if not care.placeOn or Sae.inArena() then
			return false, "interrupted"
		end
		if os.clock() - lastIssue >= 1 then
			lastIssue = os.clock()
			hum:MoveTo(target)
		end
		if flatDistance() <= care.nearNeeded then
			hum:MoveTo(root.Position)
			return true
		end
		task.wait(0.1)
	end
	return false, "could not walk to your plot"
end

function Sae.care.placePass()
	local care = Sae.care
	if not care.placeOn or care.busyPlace then
		return
	end
	if os.clock() < care.cooldownUntil then
		return
	end
	if Sae.inArena() then
		care.lastPlace = "waiting - in the boss arena"
		return
	end
	care.busyPlace = true
	Util.try("steal an egg place pass", function()
		local K = Sae.K
		local recs, eggState = care.owned()
		local plotState = Sae.resolve("plotState")
		if not (eggState and eggState.WearEggTool and eggState.PlantEgg and eggState.DoffEggTool and plotState) then
			care.lastPlace = "place API unavailable"
			return
		end
		local plot
		Util.try("steal an egg plot", function()
			plot = plotState.ResolvePlot()
		end)
		if type(plot) ~= "table" then
			care.lastPlace = "could not find your plot"
			return
		end
		local todo = care.unplaced(recs)
		if #todo == 0 then
			care.lastPlace = "no eggs to place"
			return
		end
		local near, whyFar = care.walkToPlot(plot)
		if not near then
			care.lastPlace = "waiting: " .. tostring(whyFar)
			care.cooldownUntil = os.clock() + K.RANGE_WAIT
			return
		end
		for _, egg in ipairs(todo) do
			if not care.placeOn then
				break
			end
			local ok, stop = care.placeOne(eggState, plot, egg)
			if not ok then
				care.stats.placeRefused = care.stats.placeRefused + 1
				if care.isRangeRefusal(stop) then
					care.lastPlace = "getting closer to your plot"
					care.cooldownUntil = os.clock() + K.RANGE_WAIT
					if care.nearNeeded > 8 then
						care.nearNeeded = 8
						Sae.log("info", "still out of range - walking to the plot centre from now on")
					end
				else
					care.lastPlace = "stopped: " .. tostring(stop)
					care.cooldownUntil = os.clock() + K.REFUSED_WAIT
				end
				break
			end
			care.lastPlace = string.format("placed %d this session", care.stats.placed)
			task.wait(K.PLACE_GAP)
		end
	end)
	care.busyPlace = false
end

-- a timed loop plus an immediate pass whenever the game says the player's eggs changed
function Sae.care.arm(name, pass)
	local handle = Sae.loop("auto " .. name, Sae.scale(Sae.K.TICK), pass)
	Util.try("steal an egg watch " .. name, function()
		local eggState = Sae.resolve("eggState")
		local signal = eggState and eggState.OwnerRefreshed
		if signal and type(signal.Connect) == "function" then
			local connection = signal:Connect(function(userId)
				local player = Players.LocalPlayer
				if not player or userId ~= player.UserId then
					return
				end
				task.spawn(function()
					Util.try("steal an egg owner refreshed " .. name, pass)
				end)
			end)
			handle.conns[#handle.conns + 1] = connection
		end
	end)
	return handle
end

function Sae.care.setPlace(on)
	local care = Sae.care
	on = on and true or false
	if on == care.placeOn then
		return true
	end
	care.placeOn = on
	if care.placeLoop then
		care.placeLoop.Stop()
		care.placeLoop = nil
	end
	if on then
		care.cooldownUntil = 0
		care.lastPlace = "starting"
		care.placeLoop = care.arm("place", care.placePass)
	else
		care.lastPlace = "off"
	end
	Sae.log("info", "auto place %s", on and "ON" or "OFF")
	return true
end

function Sae.care.setHatch(on)
	local care = Sae.care
	on = on and true or false
	if on == care.hatchOn then
		return true
	end
	care.hatchOn = on
	if care.hatchLoop then
		care.hatchLoop.Stop()
		care.hatchLoop = nil
	end
	if on then
		care.lastHatch = "starting"
		care.hatchLoop = care.arm("hatch", care.hatchPass)
	else
		care.lastHatch = "off"
	end
	Sae.log("info", "auto hatch %s", on and "ON" or "OFF")
	return true
end

function Sae.care.status()
	local care = Sae.care
	return string.format("Place: %s  |  Hatch: %s", care.lastPlace, care.lastHatch)
end

Sae.pets = { stats = { asked = 0, equipped = 0, refused = 0 } }

function Sae.pets.equipBest()
	local stats = Sae.pets.stats
	stats.asked = stats.asked + 1
	local ok, msg = Sae.net.call("RF/Haul/WearBest")
	if ok == true then
		stats.equipped = stats.equipped + 1
		Sae.log("info", "equipped best pets")
		return true, "Equipped your best pets"
	end
	stats.refused = stats.refused + 1
	Sae.log("warn", "WearBest refused: %s %s", tostring(ok), tostring(msg or ""))
	return false, "Refused: " .. tostring(msg or ok)
end

----------------------------------------------------------------------------------------------------
-- Selling (6.3 features.farm.sell)
----------------------------------------------------------------------------------------------------
Sae.sell = {
	petRarities = {}, eggRarities = {},
	auto = { pets = false, eggs = false },
	loop = nil,
	stats = { petsSold = 0, eggsSold = 0, passes = 0 },
}

function Sae.toSet(list)
	local set = {}
	for _, value in pairs(type(list) == "table" and list or {}) do
		set[tostring(value)] = true
	end
	return set
end

function Sae.sell.setPetRarities(list)
	Sae.sell.petRarities = Sae.toSet(list)
end

function Sae.sell.setEggRarities(list)
	Sae.sell.eggRarities = Sae.toSet(list)
end

-- sends the uids to the seller in batches; returns true, or false and the reason
function Sae.sell.fire(uids, eggs)
	local K = Sae.K
	for i = 1, #uids, K.SELL_BATCH do
		local chunk = {}
		table.move(uids, i, math.min(i + K.SELL_BATCH - 1, #uids), 1, chunk)
		local ok, why = Sae.net.fire("RE/PetSatchel/SellSelection", { Assets = eggs and {} or chunk, Eggs = eggs and chunk or {} })
		if not ok then
			return false, why
		end
	end
	return true
end

-- waits for the save data to update, then counts how many of the uids are still there (nil = could not tell)
function Sae.sell.countLeft(field, uids)
	task.wait(1.5)
	local data = Sae.profile()
	local inventory = data and data[field]
	if type(inventory) ~= "table" then
		return nil
	end
	local left = 0
	for _, uid in ipairs(uids) do
		if inventory[uid] ~= nil then
			left = left + 1
		end
	end
	return left
end

function Sae.sell.sellPets()
	local sell = Sae.sell
	if next(sell.petRarities) == nil then
		return false, "Pick pet rarities to sell first"
	end
	local data = Sae.profile()
	local inventory = data and data.Inventory
	if type(inventory) ~= "table" then
		return false, "Could not read your pets"
	end
	local equipped = {}
	for _, uid in ipairs(type(data.EquippedAssets) == "table" and data.EquippedAssets or {}) do
		equipped[tostring(uid)] = true
	end
	local uids = {}
	for uid, item in pairs(inventory) do
		if type(item) == "table" and not equipped[tostring(uid)]
			and item.InFuse ~= true and item.IsFavorite ~= true and item.Favorite ~= true
			and sell.petRarities[Sae.rarityOf(item.Category) or ""] then
			uids[#uids + 1] = tostring(uid)
		end
	end
	if #uids == 0 then
		return true, "No pets to sell"
	end
	local ok, why = sell.fire(uids, false)
	if not ok then
		return false, "Sell refused: " .. tostring(why)
	end
	local left = sell.countLeft("Inventory", uids)
	local sold = left and (#uids - left) or #uids
	sell.stats.petsSold = sell.stats.petsSold + sold
	Sae.log("info", "sold %d/%d pets%s", sold, #uids, left and "" or " (unverified)")
	if left and sold == 0 then
		return false, "The game did not sell them (stand near the seller?)"
	end
	return true, string.format("Sold %d pets", sold)
end

function Sae.sell.sellEggs()
	local sell = Sae.sell
	if next(sell.eggRarities) == nil then
		return false, "Pick egg rarities to sell first"
	end
	local data = Sae.profile()
	local inventory = data and data.EggInventory
	if type(inventory) ~= "table" then
		return false, "Could not read your eggs"
	end
	local uids = {}
	for uid, egg in pairs(inventory) do
		if type(egg) == "table" and sell.eggRarities[Sae.rarityOf(egg.AssetCategory) or ""] then
			uids[#uids + 1] = tostring(uid)
		end
	end
	if #uids == 0 then
		return true, "No eggs to sell"
	end
	local ok, why = sell.fire(uids, true)
	if not ok then
		return false, "Sell refused: " .. tostring(why)
	end
	local left = sell.countLeft("EggInventory", uids)
	local sold = left and (#uids - left) or #uids
	sell.stats.eggsSold = sell.stats.eggsSold + sold
	Sae.log("info", "sold %d/%d eggs%s", sold, #uids, left and "" or " (unverified)")
	if left and sold == 0 then
		return false, "The game did not sell them (stand near the seller?)"
	end
	return true, string.format("Sold %d eggs", sold)
end

-- one worker loop serves both Auto Sell Pets and Auto Sell Eggs
function Sae.sell.refreshLoop()
	local sell = Sae.sell
	local want = sell.auto.pets or sell.auto.eggs
	if want and not sell.loop then
		sell.loop = Sae.loop("auto sell", Sae.K.SELL_EVERY, function()
			sell.stats.passes = sell.stats.passes + 1
			if sell.auto.pets then
				Util.try("steal an egg auto sell pets", sell.sellPets)
			end
			if sell.auto.eggs then
				Util.try("steal an egg auto sell eggs", sell.sellEggs)
			end
		end)
	elseif not want and sell.loop then
		sell.loop.Stop()
		sell.loop = nil
	end
end

function Sae.sell.setAuto(which, on)
	Sae.sell.auto[which] = on and true or false
	Sae.log("info", "auto sell %s %s", which, on and "ON" or "OFF")
	Sae.sell.refreshLoop()
end

----------------------------------------------------------------------------------------------------
-- Fusion (6.3 features.farm.fuse)
----------------------------------------------------------------------------------------------------
Sae.fuse = { rarities = {}, autoOn = false, loop = nil, busy = false, stats = { fused = 0, refused = 0 } }

-- how many copies one fusion needs (the game's own balance flag, 3 when it cannot be read)
function Sae.fuse.inputCount()
	local n = 3
	Util.try("steal an egg fuse input count", function()
		local storage = game:GetService("ReplicatedStorage")
		local shared = storage:FindFirstChild("Shared")
		local flags = shared and shared:FindFirstChild("Flags")
		local balance = flags and flags:FindFirstChild("GameplayBalance")
		if balance then
			local mod = Sae.requireGame(balance)
			if type(mod) == "table" and type(mod.Fusion) == "table" then
				n = tonumber(mod.Fusion.INPUT_COUNT) or n
			end
		end
	end)
	return math.max(1, math.floor(n))
end

function Sae.fuse.setRarities(list)
	Sae.fuse.rarities = Sae.toSet(list)
end

-- groups of the same pet you hold enough spare copies of: { category, name, rarity, uids, spare, sets }
function Sae.fuse.scan()
	local data = Sae.profile()
	local inventory = data and data.Inventory
	if type(inventory) ~= "table" then
		return nil, "Could not read your pets"
	end
	local equipped = {}
	for _, uid in ipairs(type(data.EquippedAssets) == "table" and data.EquippedAssets or {}) do
		equipped[tostring(uid)] = true
	end
	local need = Sae.fuse.inputCount()
	local groups = {}
	for uid, item in pairs(inventory) do
		if type(item) == "table" and item.Category and not equipped[tostring(uid)]
			and item.InFuse ~= true and item.IsFavorite ~= true and item.Favorite ~= true then
			local group = groups[item.Category]
			if not group then
				group = { category = item.Category, name = Sae.nameOf(item.Category), rarity = Sae.rarityOf(item.Category), uids = {} }
				groups[item.Category] = group
			end
			group.uids[#group.uids + 1] = tostring(uid)
		end
	end
	local out = {}
	for _, group in pairs(groups) do
		group.spare = #group.uids
		group.sets = math.floor(#group.uids / need)
		if group.sets > 0 then
			out[#out + 1] = group
		end
	end
	table.sort(out, function(a, b)
		if a.sets ~= b.sets then
			return a.sets > b.sets
		end
		return a.name < b.name
	end)
	return out, need
end

-- a reward from an earlier fusion that was never collected
function Sae.fuse.collectPending()
	local data = Sae.profile()
	if data and data.FusionEggReward and data.FusionEggReward ~= false then
		local ok, why = Sae.net.call("RF/Fusery/FinishReveal")
		Sae.log("info", "collected a pending fuse reward: %s %s", tostring(ok), tostring(why or ""))
	end
end

function Sae.fuse.ejectAll()
	local data = Sae.profile()
	local slots = data and type(data.FusionSlots) == "table" and data.FusionSlots or {}
	for _, uid in ipairs(slots) do
		Sae.net.call("RF/Fusery/EjectPet", uid)
	end
end

-- fuses one set of `category`; returns ok, message
function Sae.fuse.fuseOne(category)
	local fuse = Sae.fuse
	if fuse.busy then
		return false, "Already fusing"
	end
	fuse.busy = true
	local ran, res = Util.try("steal an egg fuse one", function()
		local data = Sae.profile()
		if not data then
			return { false, "Could not read your save" }
		end
		if data.FusionLocked then
			return { false, "The fuse machine is locked" }
		end
		local okInventory, _, eggCount, eggLimit = pcall(Sae.eggInventory)
		if okInventory and eggCount and eggLimit and eggCount >= eggLimit then
			return { false, "Your egg inventory is full" }
		end
		fuse.collectPending()
		local groups, need = fuse.scan()
		local group
		for _, candidate in ipairs(groups or {}) do
			if candidate.category == category then
				group = candidate
				break
			end
		end
		if not group then
			return { false, "Not enough spare " .. Sae.nameOf(category) }
		end
		fuse.ejectAll()
		for i = 1, need do
			local okLoad, why = Sae.net.call("RF/Fusery/LoadPet", group.uids[i], false)
			if not okLoad then
				fuse.ejectAll()
				fuse.stats.refused = fuse.stats.refused + 1
				return { false, "Load refused: " .. tostring(why or "?") }
			end
		end
		local okBegin, whyBegin = Sae.net.call("RF/Fusery/BeginFuse")
		if not okBegin then
			fuse.ejectAll()
			fuse.stats.refused = fuse.stats.refused + 1
			return { false, "Fuse refused: " .. tostring(whyBegin or "?") }
		end
		task.wait(Sae.K.FUSE_REVEAL)
		local okReveal, whyReveal = Sae.net.call("RF/Fusery/FinishReveal")
		fuse.stats.fused = fuse.stats.fused + 1
		Sae.log("info", "fused %dx %s (reveal %s %s)", need, group.name, tostring(okReveal), tostring(whyReveal or ""))
		return { true, string.format("Fused %dx %s", need, group.name) }
	end)
	fuse.busy = false
	if not ran or type(res) ~= "table" then
		return false, "Fuse failed"
	end
	return res[1], res[2]
end

-- Auto Fuse: one set of the first group whose rarity is selected, then wait for the next pass
function Sae.fuse.autoPass()
	local fuse = Sae.fuse
	if next(fuse.rarities) == nil then
		return
	end
	local groups = fuse.scan()
	for _, group in ipairs(groups or {}) do
		if group.rarity and fuse.rarities[group.rarity] then
			local _, msg = fuse.fuseOne(group.category)
			Sae.log("info", "auto fuse %s: %s", group.name, tostring(msg))
			return
		end
	end
end

function Sae.fuse.setAuto(on)
	local fuse = Sae.fuse
	fuse.autoOn = on and true or false
	if fuse.autoOn and not fuse.loop then
		fuse.loop = Sae.loop("auto fuse", Sae.K.FUSE_EVERY, function()
			Util.try("steal an egg auto fuse", fuse.autoPass)
		end)
	elseif not fuse.autoOn and fuse.loop then
		fuse.loop.Stop()
		fuse.loop = nil
	end
	Sae.log("info", "auto fuse %s", fuse.autoOn and "ON" or "OFF")
end

----------------------------------------------------------------------------------------------------
-- Profiles (6.3 core.profiles, simplified): all profiles live in ONE json file, so only readfile /
-- writefile / isfile are needed. Without file access they last for the session.
----------------------------------------------------------------------------------------------------
Sae.store = { data = nil }

function Sae.cleanName(text)
	local name = Util.trim(text)
	name = string.gsub(name, "%c", "")
	name = string.gsub(name, "%s+", " ")
	name = Util.trim(string.sub(name, 1, Sae.K.NAME_LENGTH))
	if name == "" then
		return "Default"
	end
	return name
end

function Sae.store.load()
	local store = Sae.store
	if store.data then
		return store.data
	end
	local data = { profiles = {}, autoLoad = "" }
	if Env.canSave() then
		local text = Env.readFile(CONFIG.SaeFile)
		if text and text ~= "" then
			local decoded = Util.jsonDecode(text)
			if type(decoded) == "table" then
				if type(decoded.profiles) == "table" then
					for name, entry in pairs(decoded.profiles) do
						if type(name) == "string" and type(entry) == "table" then
							data.profiles[name] = entry
						end
					end
				end
				if type(decoded.autoLoad) == "string" then
					data.autoLoad = decoded.autoLoad
				end
			else
				Sae.log("warn", "the profiles file could not be read - starting with none")
			end
		end
	end
	store.data = data
	return data
end

-- writes the file and reads it back; true also when the executor cannot save (the session keeps them)
function Sae.store.save()
	local data = Sae.store.data
	if not data then
		return false, "Nothing to save"
	end
	if not Env.canSave() then
		return true, "session only"
	end
	local body = Util.jsonEncode({ v = 1, profiles = data.profiles, autoLoad = data.autoLoad })
	if not body then
		return false, "Could not encode the profiles"
	end
	Env.ensureFolder(CONFIG.Folder)
	if not Env.writeFile(CONFIG.SaeFile, body) then
		return false, "Could not write the profiles file"
	end
	if Env.readFile(CONFIG.SaeFile) ~= body then
		return false, "Written but readback differs - not saved"
	end
	return true
end

function Sae.store.names()
	local names = {}
	for name in pairs(Sae.store.load().profiles) do
		names[#names + 1] = name
	end
	table.sort(names, function(a, b)
		local la, lb = string.lower(a), string.lower(b)
		if la ~= lb then
			return la < lb
		end
		return a < b
	end)
	return names
end

function Sae.store.put(name, values)
	local data = Sae.store.load()
	local previous = data.profiles[name]
	if previous == nil and Util.count(data.profiles) >= Sae.K.MAX_PROFILES then
		return false, string.format("You can keep up to %d profiles", Sae.K.MAX_PROFILES)
	end
	data.profiles[name] = { saved = os.time(), values = values }
	local ok, why = Sae.store.save()
	if not ok then
		data.profiles[name] = previous
		return false, why
	end
	return true
end

-- returns true and whether it was the auto-load profile, or false and the reason
function Sae.store.remove(name)
	local data = Sae.store.load()
	local previous = data.profiles[name]
	if previous == nil then
		return false, "No profile called " .. tostring(name)
	end
	local wasAuto = data.autoLoad == name
	data.profiles[name] = nil
	if wasAuto then
		data.autoLoad = ""
	end
	local ok, why = Sae.store.save()
	if not ok then
		data.profiles[name] = previous
		if wasAuto then
			data.autoLoad = name
		end
		return false, why
	end
	return true, wasAuto
end

function Sae.store.setAutoLoad(name)
	local data = Sae.store.load()
	local previous = data.autoLoad
	data.autoLoad = name or ""
	local ok, why = Sae.store.save()
	if not ok then
		data.autoLoad = previous
		return false, why
	end
	if data.autoLoad ~= "" then
		return true, "Auto-loading " .. data.autoLoad
	end
	return true, "Auto-load off"
end

-- everything stops: loops end, switches go off. Called when the hub closes / unloads.
function Sae.stopAll()
	if not Sae.running then
		return
	end
	Sae.running = false
	Sae.care.placeOn, Sae.care.hatchOn = false, false
	Sae.sell.auto.pets, Sae.sell.auto.eggs = false, false
	Sae.fuse.autoOn = false
	for _, handle in ipairs(Sae.loops) do
		pcall(handle.Stop)
	end
	Sae.loops = {}
end

----------------------------------------------------------------------------------------------------
-- the panel: a Farm tab and a Config tab, built with this file's UI kit
-- host: a Frame with a vertical list layout. hooks.back() is called by the Back button.
-- Returns { onOpen, collect, apply, loadProfile } - every control is built once and kept.
----------------------------------------------------------------------------------------------------
Sae.NONE = "__none"

function Sae.buildPanel(host, hooks)
	hooks = hooks or {}
	local NONE = Sae.NONE
	local panel = { controls = {}, options = {}, signature = "", lastStatus = "" }
	local controls = panel.controls
	local state = { autoLoadOn = false, pendingName = "" }

	local function report(title, ok, text)
		if ok then
			Notify.success(title, tostring(text), { duration = 3 })
		else
			Notify.warn(title, tostring(text), { duration = 5 })
		end
	end

	-- every action needs the game's own client; outside Steal An Egg it says so instead of failing quietly
	local function needGame(title)
		if Sae.detected() then
			return true
		end
		Notify.warn(title, "Steal An Egg was not found in this game, so this does nothing here.", { key = "sae-not-found" })
		return false
	end

	-- rarity lists: the game's own list when it can be read, else the baked one (see Sae.rarityOptions)
	function panel.refreshOptions()
		local options, parts = {}, {}
		for _, row in ipairs(Sae.rarityOptions()) do
			options[#options + 1] = { id = row.id, label = row.label }
			parts[#parts + 1] = row.id .. ":" .. row.label
		end
		local signature = table.concat(parts, "|")
		if signature == panel.signature then
			return false
		end
		panel.signature, panel.options = signature, options
		for _, key in ipairs({ "sellPets", "sellEggs", "fuse" }) do
			local picker = controls[key]
			if picker then
				picker.SetOptions(options, picker.Get())
			end
		end
		return true
	end
	panel.refreshOptions()

	-- card builders -----------------------------------------------------------------------------------
	local function toggleRow(parent, order, title, desc, onChange)
		local card = UI.card({ parent = parent, order = order, title = title, desc = desc, control = 62, name = title })
		local toggle = UI.toggle({
			parent = card.Controls, value = false, anchor = Vector2.new(1, 0.5), position = UDim2.fromScale(1, 0.5), name = "Toggle",
			onChange = onChange,
		})
		Pages.register(card, 62)
		return toggle, card
	end

	local function buttonRow(parent, order, title, desc, text, kind, onClick)
		local card = UI.card({ parent = parent, order = order, title = title, desc = desc, control = 124, name = title })
		local button = UI.button({
			parent = card.Controls, text = text, kind = kind, small = true, name = "Action",
			size = UDim2.new(1, 0, 0, 34), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5), onClick = onClick,
		})
		Pages.register(card, 124)
		return button, card
	end

	local function pickerRow(parent, order, title, desc, onChange)
		local card = UI.card({ parent = parent, order = order, title = title, desc = desc, control = 190, name = title })
		local picker = UI.multiSelect({
			parent = card.Controls, options = panel.options, value = {}, placeholder = "Select", name = "Picker", onChange = onChange,
		})
		picker.Instance.Size = UDim2.new(1, 0, 0, 36)
		picker.Instance.AnchorPoint = Vector2.new(0, 0.5)
		picker.Instance.Position = UDim2.fromScale(0, 0.5)
		Pages.register(card, 190)
		return picker, card
	end

	local function newView(name, order, visible)
		local view = Util.new("Frame", {
			Name = name, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
			LayoutOrder = order, Visible = visible,
		}, host)
		Util.list(view, 8)
		return view
	end

	-- header, tabs ------------------------------------------------------------------------------------
	local head = UI.card({
		parent = host, order = 1, name = "SaeHeader", title = "Steal An Egg",
		desc = "Built in from VYRE 6.3. It only does something inside the Steal An Egg game.", control = 92,
	})
	UI.button({
		parent = head.Controls, text = "Back", kind = "ghost", small = true, name = "Back",
		size = UDim2.new(1, 0, 0, 34), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
		onClick = function()
			if hooks.back then
				hooks.back()
			end
		end,
	})
	Pages.register(head, 92)

	local farm = newView("FarmView", 3, true)
	local config = newView("ConfigView", 4, false)
	panel.tabs = UI.segmented({
		parent = host, name = "SaeTabs", order = 2, size = UDim2.new(1, 0, 0, 38), value = "farm",
		options = { { id = "farm", label = "Farm" }, { id = "config", label = "Config" } },
		onChange = function(id)
			UI.closeDropdown(true)
			farm.Visible = id == "farm"
			config.Visible = id == "config"
		end,
	})

	-- Farm: status -------------------------------------------------------------------------------------
	local statusCard = UI.card({ parent = farm, order = 1, title = "Status", desc = "", control = 104, name = "SaeStatus" })
	UI.button({
		parent = statusCard.Controls, text = "Recheck", kind = "ghost", small = true, name = "Recheck",
		size = UDim2.new(1, 0, 0, 34), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
		onClick = function()
			Sae.cache = {}
			Sae.searchedAt = {}
			task.spawn(function()
				panel.refreshOptions()
				panel.refreshStatus()
				report("Steal An Egg", Sae.detected(), Sae.detected() and "Steal An Egg found." or "Steal An Egg was not found in this game.")
			end)
		end,
	})
	Pages.register(statusCard, 104)

	function panel.refreshStatus()
		if not Util.alive(statusCard.Instance) then
			return
		end
		local text = table.concat({
			Sae.detected() and "Steal An Egg found." or "Steal An Egg not found - open this inside the game.",
			Sae.care.status(),
			string.format("Sold %d pets and %d eggs  |  Fused %d times", Sae.sell.stats.petsSold, Sae.sell.stats.eggsSold, Sae.fuse.stats.fused),
		}, "\n")
		if text ~= panel.lastStatus then
			panel.lastStatus = text
			statusCard.SetDesc(text)
		end
	end
	panel.refreshStatus()
	Sae.loop("panel status", 1.5, function()
		if farm.Visible and host.Visible then
			panel.refreshStatus()
		end
	end)

	-- Farm: Plot & Pets --------------------------------------------------------------------------------
	UI.section(farm, "Plot & Pets", 2)
	controls.autoPlace = toggleRow(farm, 3, "Auto Place", "Walks to your plot and places the eggs you hold, best income first.", function(on)
		if on and not needGame("Auto Place") then
			controls.autoPlace.Set(false, true)
			return
		end
		Sae.care.setPlace(on)
	end)
	controls.autoHatch = toggleRow(farm, 4, "Auto Hatch", "Hatches the eggs on your plot as soon as they are ready.", function(on)
		if on and not needGame("Auto Hatch") then
			controls.autoHatch.Set(false, true)
			return
		end
		Sae.care.setHatch(on)
	end)
	buttonRow(farm, 5, "Equip Best Pets", "Asks the game to wear your best pets.", "Equip", nil, function(button)
		if not needGame("Pets") then
			return
		end
		button.SetBusy(true, "Working...")
		task.spawn(function()
			local ok, msg = Sae.pets.equipBest()
			report("Pets", ok, msg)
			if Util.alive(button.Instance) then
				button.SetBusy(false)
			end
		end)
	end)

	-- Farm: Selling & Fusion ---------------------------------------------------------------------------
	UI.section(farm, "Selling & Fusion", 6)
	controls.sellPets = pickerRow(farm, 7, "Sell Pet Rarities", "Pets of these rarities are sold. Equipped, favorite and fusing pets are kept.", function(list)
		Sae.sell.setPetRarities(list)
	end)
	controls.sellEggs = pickerRow(farm, 8, "Sell Egg Rarities", "Eggs of these rarities are sold.", function(list)
		Sae.sell.setEggRarities(list)
	end)
	controls.autoSellPets = toggleRow(farm, 9, "Auto Sell Pets", "Sells the selected pet rarities every 30 seconds.", function(on)
		if on and not needGame("Auto Sell Pets") then
			controls.autoSellPets.Set(false, true)
			return
		end
		Sae.sell.setAuto("pets", on)
	end)
	controls.autoSellEggs = toggleRow(farm, 10, "Auto Sell Eggs", "Sells the selected egg rarities every 30 seconds.", function(on)
		if on and not needGame("Auto Sell Eggs") then
			controls.autoSellEggs.Set(false, true)
			return
		end
		Sae.sell.setAuto("eggs", on)
	end)
	buttonRow(farm, 11, "Sell Pets Now", "Sells the selected pet rarities once.", "Sell", nil, function(button)
		if not needGame("Sell") then
			return
		end
		button.SetBusy(true, "Selling...")
		task.spawn(function()
			local ok, msg = Sae.sell.sellPets()
			report("Sell", ok, msg)
			if Util.alive(button.Instance) then
				button.SetBusy(false)
			end
		end)
	end)
	buttonRow(farm, 12, "Sell Eggs Now", "Sells the selected egg rarities once.", "Sell", nil, function(button)
		if not needGame("Sell") then
			return
		end
		button.SetBusy(true, "Selling...")
		task.spawn(function()
			local ok, msg = Sae.sell.sellEggs()
			report("Sell", ok, msg)
			if Util.alive(button.Instance) then
				button.SetBusy(false)
			end
		end)
	end)
	buttonRow(farm, 13, "Scan Fusion", "Lists the pets you have 3 spare copies of.", "Scan", nil, function(button)
		if not needGame("Fusion") then
			return
		end
		button.SetBusy(true, "Scanning...")
		task.spawn(function()
			local groups, why = Sae.fuse.scan()
			if not groups then
				Notify.warn("Fusion", tostring(why or "Could not read your pets"), { duration = 4 })
			elseif #groups == 0 then
				Notify.info("Fusion", "Nothing to fuse yet", { duration = 3 })
			else
				local parts = {}
				for i, group in ipairs(groups) do
					if i > 6 then
						parts[#parts + 1] = string.format("+%d more", #groups - 6)
						break
					end
					parts[#parts + 1] = string.format("%s x%d", group.name, group.sets)
				end
				Notify.info("Fusion", table.concat(parts, ", "), { duration = 8 })
			end
			if Util.alive(button.Instance) then
				button.SetBusy(false)
			end
		end)
	end)
	controls.fuse = pickerRow(farm, 14, "Fuse Rarities", "Only spare pets of these rarities are fused.", function(list)
		Sae.fuse.setRarities(list)
	end)
	controls.autoFuse = toggleRow(farm, 15, "Auto Fuse", "Fuses spare pets of the rarities above.", function(on)
		if on and not needGame("Auto Fuse") then
			controls.autoFuse.Set(false, true)
			return
		end
		Sae.fuse.setAuto(on)
	end)

	-- Config: profiles ---------------------------------------------------------------------------------
	local function say(ok, text)
		report("Config", ok, text)
	end

	local store = Sae.store.load()
	state.autoLoadOn = store.autoLoad ~= "" and store.profiles[store.autoLoad] ~= nil

	if not Env.canSave() then
		UI.card({
			parent = config, order = 1, name = "SaeNoFiles", title = "Profiles last for this session",
			desc = "This executor cannot save files, so profiles are forgotten when the hub closes.",
		})
	end
	UI.section(config, "Profiles", 2)

	local nameCard = UI.card({
		parent = config, order = 3, name = "ProfileName", title = "Profile Name",
		desc = "What to call the next save. Blank saves as Default.", control = 190,
	})
	local nameInput = UI.input({
		parent = nameCard.Controls, placeholder = "farm setup", maxLength = Sae.K.NAME_LENGTH, name = "NameInput",
		size = UDim2.new(1, 0, 0, 36), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
		onChange = function(text)
			state.pendingName = text
		end,
	})
	Pages.register(nameCard, 190)

	local function profileOptions()
		local options = { { id = NONE, label = "None" } }
		for _, name in ipairs(Sae.store.names()) do
			options[#options + 1] = { id = name, label = name }
		end
		return options
	end

	local loadDrop, autoToggle

	-- every setting a profile keeps
	function panel.collect()
		return {
			autoPlace = controls.autoPlace.Get(),
			autoHatch = controls.autoHatch.Get(),
			sellPetRarities = controls.sellPets.Get(),
			sellEggRarities = controls.sellEggs.Get(),
			autoSellPets = controls.autoSellPets.Get(),
			autoSellEggs = controls.autoSellEggs.Get(),
			fuseRarities = controls.fuse.Get(),
			autoFuse = controls.autoFuse.Get(),
		}
	end

	-- puts a saved profile on the controls (rarities first, so the switches start with the right lists)
	function panel.apply(values)
		values = type(values) == "table" and values or {}
		local function ids(list)
			local out = {}
			for _, id in ipairs(type(list) == "table" and list or {}) do
				if type(id) == "string" then
					out[#out + 1] = id
				end
			end
			return out
		end
		controls.sellPets.Set(ids(values.sellPetRarities), false)
		controls.sellEggs.Set(ids(values.sellEggRarities), false)
		controls.fuse.Set(ids(values.fuseRarities), false)
		controls.autoPlace.Set(values.autoPlace == true, false)
		controls.autoHatch.Set(values.autoHatch == true, false)
		controls.autoSellPets.Set(values.autoSellPets == true, false)
		controls.autoSellEggs.Set(values.autoSellEggs == true, false)
		controls.autoFuse.Set(values.autoFuse == true, false)
	end

	function panel.loadProfile(name)
		local entry = Sae.store.load().profiles[name]
		if type(entry) ~= "table" then
			return false, "No profile called " .. tostring(name)
		end
		panel.apply(entry.values)
		return true, "Loaded " .. name
	end

	buttonRow(config, 4, "Save Profile", "Store current settings under the name above.", "Save", nil, function()
		local name = Sae.cleanName(state.pendingName)
		local ok, why = Sae.store.put(name, panel.collect())
		if not ok then
			say(false, why)
			return
		end
		loadDrop.SetOptions(profileOptions(), loadDrop.Get())
		if state.autoLoadOn then
			Sae.store.setAutoLoad(name)
			loadDrop.Set(name, true)
		end
		say(true, string.format("Saved as %q", name))
	end)

	buttonRow(config, 5, "Delete Profile", "Removes the profile selected under Load Profile.", "Delete", nil, function()
		local name = loadDrop.Get()
		if name == NONE then
			say(false, "Pick a profile under Load Profile first")
			return
		end
		local ok, wasAuto = Sae.store.remove(name)
		if not ok then
			say(false, wasAuto)
			return
		end
		loadDrop.SetOptions(profileOptions(), NONE)
		if wasAuto then
			state.autoLoadOn = false
			autoToggle.Set(false, true)
		end
		say(true, string.format("Deleted %q", name))
	end)

	-- Config: loading ----------------------------------------------------------------------------------
	UI.section(config, "Loading", 6)
	local loadCard = UI.card({ parent = config, order = 7, name = "LoadProfile", title = "Load Profile", control = 190 })
	loadDrop = UI.dropdown({
		parent = loadCard.Controls, options = profileOptions(), value = state.autoLoadOn and store.autoLoad or NONE, name = "LoadDropdown",
		onChange = function(id)
			if id == NONE then
				return
			end
			local ok, msg = panel.loadProfile(id)
			if ok and state.autoLoadOn then
				local saved, why = Sae.store.setAutoLoad(id)
				msg = saved and (msg .. " - auto load on") or tostring(why or msg)
			end
			say(ok, msg)
		end,
	})
	loadDrop.Instance.Size = UDim2.new(1, 0, 0, 36)
	loadDrop.Instance.AnchorPoint = Vector2.new(0, 0.5)
	loadDrop.Instance.Position = UDim2.fromScale(0, 0.5)
	Pages.register(loadCard, 190)

	autoToggle = toggleRow(config, 8, "Auto Load Profile", "Load the selected profile on start.", function(on)
		local name = loadDrop.Get()
		if on and name == NONE then
			state.autoLoadOn = false
			autoToggle.Set(false, true)
			say(false, "Pick a profile first")
			return
		end
		state.autoLoadOn = on and true or false
		local ok, msg = Sae.store.setAutoLoad(state.autoLoadOn and name or "")
		say(ok, msg)
	end)
	if state.autoLoadOn then
		autoToggle.Set(true, true)
	end

	buttonRow(config, 9, "Unload " .. CONFIG.Title, "Close the hub and stop its workers.", "Unload", "danger", function()
		local opened = UI.confirm({
			title = "Unload " .. CONFIG.Title .. "?",
			text = "This closes the hub and stops everything it is running, including Auto Place, Auto Hatch, Auto Sell and Auto Fuse. Run the script again to bring it back.",
			confirmText = "Unload", cancelText = "Keep open", danger = true,
			onConfirm = function()
				App.destroy("unloaded from the Steal An Egg config")
			end,
		})
		if not opened then
			Notify.warn("Dialog busy", "Close the open dialog first, then tap Unload again.")
		end
	end)

	-- auto load on start (Config > Auto Load Profile) ---------------------------------------------------
	if state.autoLoadOn then
		task.delay(1.5, function()
			if not (Sae.alive() and Util.alive(host)) then
				return
			end
			local name = Sae.store.load().autoLoad
			if name ~= "" then
				local ok, msg = panel.loadProfile(name)
				say(ok, ok and (msg .. " (auto load)") or msg)
			end
		end)
	end

	-- called whenever the panel is opened: refresh what the game may have finished loading since the hub started
	function panel.onOpen()
		Util.try("steal an egg panel refresh", function()
			panel.refreshOptions()
			panel.refreshStatus()
		end)
	end

	panel.nameInput = nameInput
	return panel
end

----------------------------------------------------------------------------------------------------
-- Scripts page
----------------------------------------------------------------------------------------------------
local STATE_CHIP = {
	unchecked = { "NOT CHECKED", "Muted" },
	checking = { "CHECKING", "Info" },
	online = { "ONLINE", "Green" },
	offline = { "OFFLINE", "Danger" },
}

function Pages.build.scripts(page)
	Scripts.pruneFavorites()
	local cards, tierRows, groupRows = {}, {}, {}
	local search, filter, tier, empty, applyFilter
	local showPanel -- opens (true) or closes (false) the built-in Steal An Egg panel
	local builtinList = { Sae.entry } -- listed first, above Main; it is not a catalog entry, so it is never counted with the catalog
	local builtinRow

	-- the numbers on the headers are counted from the catalog, never typed by hand
	local tierCount, groupCount = {}, {}
	for _, entry in ipairs(Scripts.catalog) do
		tierCount[entry.group] = (tierCount[entry.group] or 0) + 1
		for groupIndex, group in ipairs(Scripts.groups) do
			if entry.group == group.group and entry.key == group.key then
				groupCount[groupIndex] = (groupCount[groupIndex] or 0) + 1
			end
		end
	end

	-- the catalog list and the Steal An Egg panel share this page; only one of them is visible at a time
	local root = Util.new("Frame", {
		Name = "CatalogView", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1,
	}, page)
	Util.list(root, 8)

	-- toolbar: search, Main / Bonus and the key filter. Wide windows use two rows, narrow ones stack all three ----
	local toolbar = Util.new("Frame", {
		Name = "Toolbar", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 128), LayoutOrder = 1,
	}, root)
	local function refilter()
		if applyFilter then
			applyFilter()
		end
	end
	search = UI.input({
		parent = toolbar, name = "Search", placeholder = "Search scripts", maxLength = 40,
		onChange = refilter,
	})
	tier = UI.segmented({
		parent = toolbar, name = "Tier", value = "all",
		options = { { id = "all", label = "All" }, { id = "main", label = "Main" }, { id = "bonus", label = "Bonus" } },
		onChange = refilter,
	})
	filter = UI.segmented({
		parent = toolbar, name = "Filter", value = "all",
		options = {
			{ id = "all", label = "All" }, { id = "free", label = "No key" },
			{ id = "key", label = "Key" }, { id = "fav", label = "Favorites" },
		},
		onChange = refilter,
	})
	local function layoutToolbar(width)
		local searchBox, tierBox, filterBox = search.Instance, tier.Instance, filter.Instance
		searchBox.Size, searchBox.Position = UDim2.new(1, 0, 0, 38), UDim2.new(0, 0, 0, 0)
		if width >= 520 then
			toolbar.Size = UDim2.new(1, 0, 0, 82)
			tierBox.Size, tierBox.Position = UDim2.new(0.4, -4, 0, 36), UDim2.new(0, 0, 0, 46)
			filterBox.Size, filterBox.Position = UDim2.new(0.6, -4, 0, 36), UDim2.new(0.4, 4, 0, 46)
		else
			toolbar.Size = UDim2.new(1, 0, 0, 128)
			tierBox.Size, tierBox.Position = UDim2.new(1, 0, 0, 36), UDim2.new(0, 0, 0, 46)
			filterBox.Size, filterBox.Position = UDim2.new(1, 0, 0, 36), UDim2.new(0, 0, 0, 92)
		end
	end
	Pages.gridUpdaters[#Pages.gridUpdaters + 1] = layoutToolbar
	layoutToolbar(Win.pageW or 400)

	-- link status summary + Check all -----------------------------------------------------------------
	local sweepCard = UI.card({ parent = root, order = 2, title = "Link status", desc = "", control = 112, name = "LinkStatus" })
	local sweepButton = UI.button({
		parent = sweepCard.Controls, text = "Check all", small = true, name = "CheckAll",
		size = UDim2.new(1, 0, 0, 34), anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
		onClick = function(button)
			if Scripts.sweep.running then
				Scripts.stopCheckAll()
				button.SetText("Check all")
				Notify.info("Check stopped", "The remaining links were left unchecked.")
			elseif Scripts.checkAll(function()
				if Util.alive(button.Instance) then
					button.SetText("Check all")
				end
			end) then
				button.SetText("Stop")
			end
		end,
	})
	Pages.register(sweepCard, 112)
	if not Env.canFetch() then
		sweepButton.SetEnabled(false, "This executor has no HttpGet or request function, so links cannot be checked.")
	end
	Scripts.onState = function()
		if not Util.alive(sweepCard.Instance) then
			return
		end
		local counts = Scripts.counts()
		sweepCard.SetDesc(string.format(
			"%d online, %d offline, %d checking, %d not checked. Nothing is checked until you ask, and Online only means the link answered with HTTP 2xx - not that the script works.",
			counts.online, counts.offline, counts.checking, counts.unchecked
		))
	end
	Scripts.onState()

	-- cards ---------------------------------------------------------------------------------------------
	local function buildCard(entry, order)
		local host = Scripts.host(entry.url)
		local card = UI.card({
			parent = root, order = order, name = "Script_" .. entry.id, title = entry.name, desc = host,
			stack = true, controlHeight = 68,
		})
		local chips = Util.new("Frame", { Name = "Chips", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22) }, card.Controls)
		Util.list(chips, 6, true)
		local statusChip = UI.chip({ parent = chips, text = STATE_CHIP.unchecked[1], role = STATE_CHIP.unchecked[2], order = 1 })
		UI.chip({ parent = chips, text = entry.key and "KEY" or "NO KEY", role = entry.key and "Warn" or "Accent", order = 2 })

		local row = Util.new("Frame", {
			Name = "Actions", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 0, 36),
		}, card.Controls)
		local star = UI.button({
			parent = row, name = "Star", icon = "star", iconRole = "Muted", kind = "ghost", sound = "select",
			size = UDim2.fromOffset(40, 36),
			onClick = function()
				Scripts.toggleFavorite(entry.id)
			end,
		})
		local check = UI.button({
			parent = row, name = "Check", text = "Check", kind = "ghost", small = true,
			size = UDim2.new(0.4, -21, 1, 0), position = UDim2.new(0, 46, 0, 0),
			onClick = function()
				task.spawn(Scripts.check, entry.id)
			end,
		})
		local run = UI.button({
			parent = row, name = "Execute", text = "Execute", kind = "primary", small = true,
			size = UDim2.new(0.6, -31, 1, 0), position = UDim2.new(0.4, 31, 0, 0),
			onClick = function(button)
				Scripts.run(entry.id, button)
			end,
		})
		if not Env.canFetch() then
			check.SetEnabled(false, "This executor has no HttpGet or request function, so links cannot be checked.")
		end
		if not Env.canRun() then
			run.SetEnabled(false, "This executor does not provide loadstring, so scripts cannot be run here.")
		end

		local function describe()
			local st = Scripts.state[entry.id]
			local lines = { host }
			if st.state == "online" or st.state == "offline" then
				lines[#lines + 1] = string.format(
					"%s at %s%s", st.state == "online" and "Online" or "Offline", st.at or "-", st.detail ~= "" and (" - " .. st.detail) or ""
				)
			end
			if Scripts.notes[entry.id] then
				lines[#lines + 1] = Scripts.notes[entry.id]
			end
			card.SetDesc(table.concat(lines, "\n"))
		end
		Scripts.views[entry.id] = {
			describe = describe,
			paint = function(st)
				local chip = STATE_CHIP[st.state] or STATE_CHIP.unchecked
				statusChip.Set(chip[1], chip[2])
				describe()
			end,
		}
		cards[entry.id] = { card = card, lower = string.lower(entry.name), star = star }
	end

	-- the built-in Steal An Egg entry: it has no link, so it opens the panel instead of running a script ----
	local function buildBuiltin(order)
		local entry = Sae.entry
		local card = UI.card({
			parent = root, order = order, name = "Script_" .. entry.id, title = entry.name,
			desc = "Built in. Farm: Plot & Pets, Selling & Fusion. Config: profiles. Works only inside Steal An Egg.",
			stack = true, controlHeight = 68,
		})
		local chips = Util.new("Frame", { Name = "Chips", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22) }, card.Controls)
		Util.list(chips, 6, true)
		UI.chip({ parent = chips, text = "BUILT-IN", role = "Info", order = 1 })
		UI.chip({ parent = chips, text = "NO KEY", role = "Accent", order = 2 })
		local row = Util.new("Frame", {
			Name = "Actions", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 0, 36),
		}, card.Controls)
		local star = UI.button({
			parent = row, name = "Star", icon = "star", iconRole = "Muted", kind = "ghost", sound = "select",
			size = UDim2.fromOffset(40, 36),
			onClick = function()
				Scripts.toggleFavorite(entry.id)
			end,
		})
		UI.button({
			parent = row, name = "Open", text = "Open", kind = "primary", small = true,
			size = UDim2.new(1, -46, 1, 0), position = UDim2.new(0, 46, 0, 0),
			onClick = function()
				showPanel(true)
			end,
		})
		cards[entry.id] = { card = card, lower = string.lower(entry.name), star = star }
	end

	-- headers and cards, two levels: Main / Bonus (UI.section), then No key required / Key required (a chip row) ----
	local function groupHeader(text, role, order)
		local row = Util.new("Frame", {
			Name = "GroupHeader", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26), LayoutOrder = order,
		}, root)
		UI.chip({
			parent = row, text = text, role = role,
			anchor = Vector2.new(0, 0.5), position = UDim2.new(0, 12, 0.5, 0),
		})
		return row
	end

	-- the built-in Steal An Egg card comes first, above Main
	builtinRow = UI.section(root, string.format("Built-in  -  %d", #builtinList), 100)
	buildBuiltin(101)

	local built = 0
	for tierIndex, tierDef in ipairs(Scripts.tiers) do
		tierRows[tierIndex] = UI.section(root, string.format("%s  -  %d", tierDef.title, tierCount[tierDef.id] or 0), tierIndex * 1000)
		for groupIndex, group in ipairs(Scripts.groups) do
			if group.group == tierDef.id then
				local base = tierIndex * 1000 + (group.key and 2 or 1) * 100
				groupRows[groupIndex] = groupHeader(
					string.format("%s  -  %d", string.upper(group.title), groupCount[groupIndex] or 0),
					group.key and "Warn" or "Accent", base
				)
				local position = 0
				for _, entry in ipairs(Scripts.catalog) do
					if entry.group == group.group and entry.key == group.key then
						position = position + 1
						buildCard(entry, base + position)
						built = built + 1
						if built % 10 == 0 then
							task.wait() -- keep the loading screen responsive while the cards are built
						end
					end
				end
			end
		end
	end
	empty = UI.card({ parent = root, order = 9000, title = "No scripts to show", desc = "", name = "NoScripts" })
	empty.Instance.Visible = false

	-- the Steal An Egg panel sits next to the list and replaces it while it is open -----------------------
	local eggHost = Util.new("Frame", {
		Name = "SaeView", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = 2, Visible = false,
	}, page)
	Util.list(eggHost, 8)
	local panel
	local built, builtError = pcall(function()
		panel = Sae.buildPanel(eggHost, {
			back = function()
				showPanel(false)
			end,
		})
	end)
	if not built then
		panel = nil
		Util.log("error", "steal an egg panel could not be built: " .. tostring(builtError))
	end
	local savedCanvas = Vector2.new(0, 0)
	showPanel = function(open)
		UI.closeDropdown(true)
		if open then
			if not panel then
				Notify.error("Steal An Egg", "The panel could not be built. The Settings environment report has the log.")
				return
			end
			savedCanvas = page.CanvasPosition
			root.Visible = false
			eggHost.Visible = true
			page.CanvasPosition = Vector2.new(0, 0)
			task.spawn(panel.onOpen)
		else
			eggHost.Visible = false
			root.Visible = true
			page.CanvasPosition = savedCanvas
		end
	end
	-- when the hub closes (Pages.destroy), every Steal An Egg loop stops
	Pages.disposers[#Pages.disposers + 1] = Sae.stopAll

	-- filtering: search, Main / Bonus and the key filter all apply together; headers with nothing to show are hidden ----
	local entryList = {}
	for _, entry in ipairs(builtinList) do
		entryList[#entryList + 1] = entry
	end
	for _, entry in ipairs(Scripts.catalog) do
		entryList[#entryList + 1] = entry
	end
	applyFilter = function()
		local query = string.lower(search.Get())
		local mode, tierMode = filter.Get(), tier.Get()
		local shown, perGroup, perTier = 0, {}, {}
		for _, entry in ipairs(entryList) do
			local view = cards[entry.id]
			if view then
				local visible = true
				if tierMode ~= "all" and entry.group ~= tierMode then
					visible = false
				elseif mode == "free" and entry.key then
					visible = false
				elseif mode == "key" and not entry.key then
					visible = false
				elseif mode == "fav" and not Scripts.isFavorite(entry.id) then
					visible = false
				end
				if visible and query ~= "" and not string.find(view.lower, query, 1, true) then
					visible = false
				end
				view.card.Instance.Visible = visible
				if visible then
					shown = shown + 1
					perTier[entry.group] = (perTier[entry.group] or 0) + 1
					for groupIndex, group in ipairs(Scripts.groups) do
						if entry.group == group.group and entry.key == group.key then
							perGroup[groupIndex] = (perGroup[groupIndex] or 0) + 1
						end
					end
				end
			end
		end
		for tierIndex, tierDef in ipairs(Scripts.tiers) do
			tierRows[tierIndex].Visible = (perTier[tierDef.id] or 0) > 0
		end
		for groupIndex, row in pairs(groupRows) do
			row.Visible = (perGroup[groupIndex] or 0) > 0
		end
		local builtinView = cards[Sae.entry.id]
		builtinRow.Visible = builtinView ~= nil and builtinView.card.Instance.Visible
		empty.Instance.Visible = shown == 0
		if shown == 0 then
			empty.SetDesc(mode == "fav" and tierMode == "all" and query == "" and "No favorites yet. Tap the star on a script to keep it here."
				or "Nothing matches your search and filters.")
		end
	end

	local function paintStars()
		for id, view in pairs(cards) do
			if view.star.Icon then
				view.star.Icon.SetRole(Scripts.isFavorite(id) and "Warn" or "Muted", 0.15)
			end
		end
	end
	for id, view in pairs(cards) do
		if view.star.Icon and Scripts.isFavorite(id) then
			view.star.Icon.SetRole("Warn")
		end
	end
	Pages.watch("scriptFavorites", function()
		paintStars()
		applyFilter()
	end)
	applyFilter()
end

----------------------------------------------------------------------------------------------------
-- Information page (written from what this file actually does)
----------------------------------------------------------------------------------------------------
function Pages.build.information(page)
	local DOT = "\226\128\162"
	local order = 0
	local function nextOrder()
		order = order + 1
		return order
	end
	local function section(title)
		UI.section(page, title, nextOrder())
	end
	local function note(title, body)
		return UI.card({ parent = page, order = nextOrder(), title = title, desc = body, name = title })
	end
	local function bullets(...)
		return DOT .. " " .. table.concat({ ... }, "\n" .. DOT .. " ")
	end
	local function yesNo(flag, yes, no)
		return flag and yes or no
	end

	-- every number below is counted from the catalog
	local counts = { main = 0, bonus = 0, key = 0, mainFree = 0, mainKey = 0, bonusFree = 0, bonusKey = 0 }
	for _, entry in ipairs(Scripts.catalog) do
		counts[entry.group] = counts[entry.group] + 1
		if entry.key then
			counts.key = counts.key + 1
		end
		local slot = entry.group .. (entry.key and "Key" or "Free")
		counts[slot] = counts[slot] + 1
	end

	local saeFound = false
	Util.try("steal an egg detect", function()
		saeFound = Scripts.sae.detected()
	end)

	section("About")
	note("VirexHub", "A touch-first interface for the Delta executor on Android. It combines a script launcher, an avatar changer, themes and backgrounds, and a few Roblox tools in one window. It runs on your device only; nothing here changes server-side game rules.")
	note("This build", string.format("Version %s  %s  Executor: %s  %s  %s\nOwner / maintainer: TODO - add the name here (it is not given in the project files).",
		CONFIG.Version, DOT, Env.executor, DOT, Store.persistent and "settings saved to a file" or "settings last for this session"))

	-- every Music number below is counted from CONFIG.Music (never typed)
	local music = { classic = 0, extra = 0, kinds = {}, tagged = {}, labels = {}, fresh = {}, spotify = {}, playlists = CONFIG.Music.Playlists or {} }
	for _, kind in ipairs(CONFIG.Music.Kinds) do
		music.kinds[#music.kinds + 1] = { id = kind.id, count = 0 }
		music.labels[#music.labels + 1] = kind.label
		if kind.id ~= "phonk" and kind.id ~= "funk" then
			music.fresh[#music.fresh + 1] = kind.label
		end
	end
	for _, row in ipairs(CONFIG.Music.Tracks) do
		if row[5] == "phonk" or row[5] == "funk" or row[5] == "both" then
			music.classic = music.classic + 1
		else
			music.extra = music.extra + 1
		end
		for _, kind in ipairs(music.kinds) do
			if Music.inKind({ kind = row[5], custom = false }, kind.id) then
				kind.count = kind.count + 1
			end
		end
	end
	for index, kind in ipairs(music.kinds) do
		music.tagged[index] = music.labels[index] .. " (" .. kind.count .. ")"
	end
	for _, item in ipairs(music.playlists) do
		music.spotify[#music.spotify + 1] = item.name
	end
	local newMusic = {
		"Music tab categories (songs in each): " .. table.concat(music.tagged, ", ") .. ". A song that is both Phonk and Funk is counted in both and shows under those two only.",
		"The Kind selector in the Song list card is now a dropdown: All, each category above and Mine, each with its count. Next, Previous and auto-advance stay inside the category you pick.",
		"The " .. music.extra .. " songs in " .. table.concat(music.fresh, ", ") .. " are public Creator Store tracks found on public ID lists in those moods, listed under their creators' own names and not under famous artists. Like the others they are checked on your device when you play them, and the ones that do not load are hidden.",
	}
	if #music.spotify > 0 then
		newMusic[#newMusic + 1] = "Your Spotify, under Add a song: a Copy link button for each of your playlists (" .. table.concat(music.spotify, ", ") .. "). The hub cannot play Spotify; it only copies the link, so paste it in your browser or the Spotify app. It needs an executor with a clipboard function."
	end
	newMusic[#newMusic + 1] = "Fix: a song marked both Phonk and Funk no longer shows under every category."

	section("What's new")
	note("Version " .. CONFIG.Version, bullets(table.unpack(newMusic)))
	note("Version 2.4.0", bullets(
		"New Music tab (third in the ring, after Scripts): a player with the song name, artist, a seek bar with the time, previous / play-pause / next, shuffle, repeat and its own volume.",
		"Below it, a list of " .. music.classic .. " phonk and funk songs to pick from (All / Phonk / Funk / Mine, and search). They are public Creator Store rbxassetid IDs from public lists (CONFIG.Music.Tracks).",
		"Roblox can make audio private or remove it at any time, so a song is checked on your device when you play it. One that does not load is marked unavailable, skipped and hidden. Check all tests the whole list (it downloads each song once).",
		"Add your own song by pasting an audio ID. The music keeps playing while the window is hidden and never starts by itself."
	))
	note("Version 2.3.1", bullets(
		"Loading music: with no mp3 of your own, a random phonk / \"aura\" track plays on the loading screen (and only there). It comes from a built-in list of rbxassetid IDs (CONFIG.Splash.SoundAssetIds), loops until you tap, then fades out.",
		"Every ID is tested in the background first, one at a time, so private or deleted audio is skipped and start-up is never delayed. If none loads, the screen is silent. Turn the music off in Settings > Loading screen sound."
	))
	note("Version 2.3.0", bullets(
		"New loading screen: a wobbling black disc, the letters V-Y-R-E dropping in, and a typed thank-you capsule. It stays until you tap its \"" .. CONFIG.Splash.HintText .. "\" line; then the floating logo appears.",
		"Loading sound: put vyre_loading.mp3 in the executor folder VirexHub/sounds (or set CONFIG.Splash.SoundUrl) to use your own music.",
		"Built-in Steal An Egg panel (from VYRE 6.3) in the Scripts tab: Farm (Plot & Pets, Selling & Fusion) and Config (profiles, unload). No key.",
		"Its BUILT-IN card is the first one on the Scripts page, above Main. It is not a catalog entry, so the catalog counts are unchanged. It shows under All only; search, the key filter and Favorites apply to it.",
		"Avatar changes use the 2.0.1 fallback: the engine call is tried first; if Roblox refuses it, the look is built on a client-only rig and copied onto your character on this device.",
		"A settings file that cannot be read is kept as config.unreadable.json instead of being lost."
	))
	note("Version 2.1.1", bullets(
		"Tap the logo: only the tab ring opens. A tab's menu opens when you tap that tab.",
		"The name is back in a title bar, and a footer shows " .. CONFIG.FooterName .. " - tab name.",
		"Smaller logo, tab ring and window.",
		"Floating logo with a radial tab ring and HIDE MENU; no sidebar."
	))
	note("Version 2.1.0", bullets(
		string.format("Scripts tab: %d catalog entries in two levels. Main has %d (%d no key, %d key required) and Bonus has %d (%d no key, %d key required). Every header shows its count.",
			#Scripts.catalog, counts.main, counts.mainFree, counts.mainKey, counts.bonus, counts.bonusFree, counts.bonusKey),
		"Filters work together: search, All / Main / Bonus, and All / No key / Key / Favorites. Headers with nothing to show are hidden.",
		"Favorite stars, saved with your settings. Stars from Vyre Hub (" .. CONFIG.LegacyScriptFavorites .. ") are imported once, read-only.",
		"Link checks only when you ask: Check on a card, or Check all. Nothing is contacted at start-up.",
		"Execute asks first (name, host, key) and reports whether fetch, compile or run failed.",
		"Tools: Private Server Finder lists the quietest public servers and joins one after you confirm.",
		"New Information tab (this page)."
	))
	note("Earlier", bullets(
		"2.0.1: avatar changes work again (the fallback described above).",
		"2.0.0: rebuilt interface with loading screen, themes, backgrounds, avatar tools, sounds, fonts and settings."
	))

	section("Feature directory")
	note("Tabs", bullets(
		"Overview: session details, live FPS, ping and hub uptime.",
		"Scripts: browse, check and run the script catalog, and open the built-in Steal An Egg panel (Farm and Config tabs).",
		"Music: play songs from the categories " .. table.concat(music.labels, ", ") .. " (play / pause, previous, next, seek, shuffle, repeat, volume), pick the category in the Kind dropdown, add your own audio IDs" .. (#music.spotify > 0 and ", copy your Spotify playlist links." or "."),
		"Avatar: copy a player's look, apply a classic shirt and pants, keep avatar favorites.",
		"Appearance: compact window, clock, motion options, themes and fonts.",
		"Background: solid, aurora, sparkle, picture, sprite sheet, image sequence or video background, with overlay, transparency and blur.",
		"Tools: recenter the window or hide the menu, Roblox settings, session details, Rejoin, Private Server Finder, copy place or server ID.",
		"Settings: notifications, sound and volume, UI scale, loading screen, saved-settings status, environment report, reset, close.",
		"Information: this page."
	))

	section("Feature status")
	note("Right now on this device", bullets(
		string.format("Script catalog: %d entries (%d Main, %d Bonus), %d of them marked as needing a key.", #Scripts.catalog, counts.main, counts.bonus, counts.key),
		"Execute: " .. yesNo(Env.canRun(), "available (loadstring found).", "unavailable - this executor has no loadstring."),
		"Link checks: " .. yesNo(Env.canFetch(), "available.", "unavailable - no HttpGet or request function."),
		"Steal An Egg panel: " .. yesNo(saeFound, "the game was found, so the panel can work.", "the game was not found - open the hub inside Steal An Egg to use the panel."),
		"Favorites and settings: " .. yesNo(Store.persistent, "saved to " .. CONFIG.ConfigFile .. ".", "kept for this session only."),
		"Private Server Finder: " .. yesNo(Env.fn.request ~= nil, "available (public servers only).", "unavailable - needs the executor's request function."),
		"Avatar tools: the engine call is tried first. If Roblox refuses it, the look is built on a client-only rig and copied onto your character on this device. Only you see it, respawning resets it, and Restore undoes it.",
		"Sounds: asset IDs could not be verified when the hub was written. Failed loads stay silent (Settings > Sound status)."
	))

	section("Controls")
	note("Window", bullets(
		"Loading screen: tap \"" .. CONFIG.Splash.HintText .. "\" when it appears; the floating logo shows up as the screen fades.",
		"Tap the logo: only the tab ring opens around it. Tap a tab and that tab's menu opens in the window. Tap the logo again to close the ring.",
		"Drag the logo to move it anywhere (the spot is remembered). Drag the title bar at the top of the window to move the window.",
		"HIDE MENU hides the window; tap the logo, then a tab, to bring it back.",
		"Keyboard or mouse only: " .. CONFIG.ToggleKey .. " shows or hides the window.",
		"Settings > Close hub removes the interface; run the script again to reopen it.",
		"Pages scroll."
	))
	note("Scripts", bullets(
		string.format("Main / Bonus: Main holds %d scripts, Bonus holds %d. Each is split into No key required and Key required.", counts.main, counts.bonus),
		"Search, the All / Main / Bonus selector and the All / No key / Key / Favorites selector combine.",
		"Star: add or remove a favorite.",
		"Open (Steal An Egg, built-in): shows the panel with its Farm and Config tabs. Back returns to the list. The built-in card is listed under All only.",
		"Check: ask the link if it answers. Check all (Link status card) does that for every script, one after another; tap it again to stop.",
		"Execute: fetch, compile and run the script. You are asked the first time each session."
	))

	section("Known issues")
	note("Limits to expect", bullets(
		"Catalog links belong to other people and can move, stop working or start asking for a key. Online means HTTP 2xx only.",
		"Universal SAE and Rene Baterbonia share one link, as in the source list.",
		"Check uses a normal GET. A host may answer it differently than a game client, so Offline is not proof a script is dead.",
		string.format("Private Server Finder lists public servers. Roblox can rate-limit it (HTTP 429), results are cached for %d seconds, and a server can fill up before you join.", Pages.servers.cacheSeconds),
		"A look made by the avatar fallback is visible only to you and resets when your character respawns. Some experiences also block the blur effect.",
		"Loading music IDs come from public lists. Roblox can make audio private or remove it at any time; the hub then tries the next ID and plays nothing if none loads.",
		"The Music tab's songs come from the same kind of public lists and could not be played from the build sandbox. A song that does not load on your device is hidden; if many fail, your executor or the game may block audio from Roblox.",
		"Executors differ: without loadstring, Execute is off; without a request function, the Private Server Finder is off.",
		"The Steal An Egg panel only works inside Steal An Egg and says so elsewhere. It uses the game's own modules and remotes; those calls were not run when the panel was built, so a game update can break parts of it."
	))

	section("FAQ")
	note("Why is Execute greyed out?", "This executor has no loadstring function. Tap the button to see the reason. Everything else in the hub still works.")
	note("A script failed. What does the message mean?", "Fetch failed: the link could not be downloaded. Compile failed: what came back was not valid code (for example a web page). Run failed: the script started and then raised an error.")
	note("Where are my favorites kept?", "In " .. CONFIG.ConfigFile .. " in the executor workspace, when file access works. Reset preferences keeps your avatar and script favorites.")
	note("Where are my Steal An Egg profiles kept?", "In " .. CONFIG.SaeFile .. " in the executor workspace, when file access works. Without file access they last until the hub closes.")
	note("Why is the loading screen silent?", "Music is off in Settings (Loading screen sound or Sound effects), the volume is 0, or none of the listed IDs could be loaded on this device. To always have music, put your own mp3 at VirexHub/sounds/vyre_loading.mp3.")
	note("Why are there no songs by The Weeknd, Drake and the other artists?", "The built-in song list only has audio that public lists describe as Creator Store tracks by their creators. Songs listed under a well-known artist's name are not included. The tracks in " .. table.concat(music.fresh, ", ") .. " are listed under other creators, in similar moods. To hear the real songs use Spotify" .. (#music.spotify > 0 and " (the Copy link buttons in the Music tab copy your own playlist links)" or "") .. ". The IDs come from public lists, so Roblox can remove them or make them private at any time, and songs that do not load on your device are hidden.")
	note("I used Vyre Hub before. Are my stars here?", "On the first launch with no script favorites, VirexHub reads " .. CONFIG.LegacyScriptFavorites .. " once (read-only) and stars the scripts with matching names.")

	section("Compatibility")
	note("This executor", Env.summary())
	note("Script launcher", Env.runSummary() .. "\nInterface container: " .. tostring(App.parentKind))
	note("Tested on", "Written for Delta on Android. Other executors may work if they provide the same functions. It has not been confirmed on every Roblox or Delta version.")

	section("Notices")
	note("Third-party scripts are unverified", "Scripts in the catalog are written and hosted by other people. VirexHub does not review them. Once you run one, it has full access to your Roblox client.")
	note("Built-in Steal An Egg panel", "No key and no premium check, and nothing is downloaded. It works only inside Steal An Egg and says so elsewhere. It calls the game's own modules and remotes; those calls were not run when the panel was built, and a game update can break them. If the game's modules cannot be loaded with require, it looks them up once per session in the client's memory (getgc); the flag file " .. CONFIG.SaeSweepFlag .. " stops a scan that froze the client from repeating.")
	note("Protect your account", "Never share your cookies, passwords or login tokens, and never paste them anywhere a script or a website asks for them.")

	section("Credits")
	note("Sources used", bullets(
		"VirexHub (original): identity, tabs, palettes.",
		"Blyxo loader: loading-screen structure and sounds.",
		"VYRE loading screen (2.2.0 build): the animated loading screen and its sound handling.",
		"Loading music: public Creator Store tracks by AURA x PHONK, SHAKA LE TIGRE, Young Kapusta, AT Musica, Menina de Brazil, Alexandre Ze Musician, SynthWavesZ, NOXDRIFT, Khai GOD, Lowifer and Perfect Time Music, found on the public ID lists at allthings.how and bloxodes.com. Each track belongs to its artist.",
		"Music tab songs: public Creator Store tracks found on the public ID lists at allthings.how and bloxodes.com. Each track belongs to its creator.",
		"Vyre-Multiverse-44: click sound, FPS / ping readout, rejoin idea.",
		"Vyre-Multiverse-41: the script catalog entries (names and links unchanged) and the favorite-star idea.",
		"VYRE-INSTANT_STEAL: visual language only.",
		"VYRE_6_3_STEAL-AN-EGG: the Farm and Config features of the built-in panel (its game logic).",
		"AVATAR-CHANGER (returnreturnfunction): avatar tools."
	))
	note("Script authors", "Each script in the catalog belongs to its author. TODO: add maintainer and contributor names here once they are confirmed.")
end
end -- [14_scripts.lua]

do -- [15_music.lua]

----------------------------------------------------------------------------------------------------
-- Music: a small player and a list of songs in the categories of CONFIG.Music.Kinds (Phonk, Funk, Love songs, ...).
--   Player  song name, artist, seek bar with time, previous / play-pause / next, shuffle, repeat, volume.
--   List    CONFIG.Music.Tracks (public Creator Store audio) plus the audio IDs you add yourself.
--           Filter: the Kind dropdown (All, every CONFIG.Music.Kinds entry, Mine), search, "Check all".
-- Roblox can make any audio private or remove it at any time, and the IDs here come from public lists that could
-- not be played from the build sandbox. So a song is only trusted once it really loads on THIS device: playing a
-- song loads it first (Music.probe); a song that does not load is marked unavailable, skipped by Next / Previous /
-- auto-advance and hidden from the list ("Hide unavailable songs"). Unavailable ids are remembered between launches
-- (Store "musicBad"); "Check all" tests every song that is not confirmed yet and can bring them back.
-- One Sound plays everything. The music keeps playing while the window is hidden, and nothing starts by itself.
----------------------------------------------------------------------------------------------------
local MarketplaceServiceM = optionalService("MarketplaceService")

Music.tracks = {}       -- { id, title, artist, seconds, kind, custom, index, status = "unknown" | "ok" | "bad" }
Music.byId = {}         -- id (digits) -> track
Music.index = nil       -- the song that is loaded / playing / paused (index into Music.tracks)
Music.state = "idle"    -- "idle" | "loading" | "playing" | "paused"
Music.sound = nil       -- the one Sound that plays everything
Music.token = 0         -- changes with every song change, so a late load result can be told apart and ignored
Music.history = {}      -- songs played before this one (Previous, when shuffle is on)
Music.bag = {}          -- shuffle: songs that have not been played yet in this round
Music.bagActive = false
Music.queueKind = "all" -- Next / Previous / auto-advance stay inside this category: all | custom | an id of CONFIG.Music.Kinds
Music.names = {}        -- custom id -> name found through MarketplaceService
Music.startedAt = 0
Music.checking = nil    -- { cancel, done, total, bad } while "Check all" runs
Music.proven = false    -- true once ANY song has loaded on this device in this session
Music.TIMEOUT = "it did not load in time"
Music.ui = nil
Music.onChange = nil    -- set by the page: fn(track or nil)

local function cleanId(value)
	local digits = string.gsub(tostring(value or ""), "%D", "")
	if #digits < 5 or #digits > 16 then
		return nil
	end
	return digits
end
Music.cleanId = cleanId

function Music.fmt(seconds)
	seconds = math.max(0, math.floor((tonumber(seconds) or 0) + 0.5))
	return string.format("%d:%02d", math.floor(seconds / 60), seconds % 60)
end

function Music.volume()
	local value = Store.get("musicVolume")
	if type(value) ~= "number" then
		return 0.5
	end
	return Util.clamp(value, 0, 1)
end

function Music.fire(track)
	if Music.onChange then
		Util.try("music ui", Music.onChange, track)
	end
end

function Music.inKind(track, kind)
	if kind == "all" then
		return true
	end
	if kind == "custom" then
		return track.custom
	end
	if track.kind == "both" then
		return kind == "phonk" or kind == "funk" -- a "both" song belongs to Phonk and Funk only
	end
	return track.kind == kind
end

function Music.counts()
	local total, ok, bad = #Music.tracks, 0, 0
	for _, track in ipairs(Music.tracks) do
		if track.status == "ok" then
			ok = ok + 1
		elseif track.status == "bad" then
			bad = bad + 1
		end
	end
	return total, ok, bad
end

-- (re)builds Music.tracks from CONFIG.Music.Tracks and the ids saved in Store "musicCustom", keeping what is already
-- known about each song (status) and the currently loaded one.
function Music.rebuild()
	local previous = Music.byId
	local currentId = Music.index and Music.tracks[Music.index] and Music.tracks[Music.index].id or nil
	local dead = {}
	for _, id in ipairs(Store.get("musicBad") or {}) do
		dead[id] = true
	end
	local tracks, byId = {}, {}
	local function add(id, title, artist, seconds, kind, custom)
		id = cleanId(id)
		if not id or byId[id] then
			return
		end
		local old = previous[id]
		local track = {
			id = id,
			title = tostring(title or ("Song " .. id)),
			artist = tostring(artist or "Unknown artist"),
			seconds = tonumber(seconds) or 0,
			kind = kind or "phonk",
			custom = custom and true or false,
			status = old and old.status or (dead[id] and "bad" or "unknown"),
			pendingBad = old and old.pendingBad or nil,
			index = #tracks + 1,
		}
		if old and old.seconds and old.seconds > track.seconds then
			track.seconds = old.seconds
		end
		tracks[#tracks + 1] = track
		byId[id] = track
	end
	for _, row in ipairs(CONFIG.Music.Tracks) do
		add(row[1], row[2], row[3], row[4], row[5], false)
	end
	for _, id in ipairs(Store.get("musicCustom") or {}) do
		add(id, Music.names[id] or ("Song " .. id), "Added by you", 0, "custom", true)
	end
	Music.tracks, Music.byId = tracks, byId
	if currentId then
		local still = byId[currentId]
		Music.index = still and still.index or nil
		if not still and Music.state ~= "idle" then
			Music.stop() -- the song that was playing has been removed
		end
	end
end

-- picks the song that was played last as the (idle) current song
function Music.restoreLast()
	local last = Store.get("musicLast")
	local track = last and Music.byId[last] or nil
	if track and track.status ~= "bad" then
		Music.index = track.index
	end
end

-- Unavailable ids are only remembered between launches once a song HAS loaded on this device in this session, so a
-- dropped connection or blocked audio can never wipe the list, and a timeout is never remembered at all.
function Music.persistBad(track)
	local list = Util.copy(Store.get("musicBad") or {})
	if not Util.indexOf(list, track.id) then
		list[#list + 1] = track.id
		Store.set("musicBad", list)
	end
end

function Music.unpersistBad(track)
	local list = Util.copy(Store.get("musicBad") or {})
	local at = Util.indexOf(list, track.id)
	if at then
		table.remove(list, at)
		Store.set("musicBad", list)
	end
end

-- marks a song as working ("ok") or unavailable ("bad")
function Music.mark(track, status, reason)
	local changed = track.status ~= status
	track.reason = reason
	track.status = status
	if status == "bad" then
		if reason ~= Music.TIMEOUT then
			if Music.proven then
				Music.persistBad(track)
			else
				track.pendingBad = true -- remembered as soon as one song has loaded
			end
		end
	else
		track.pendingBad = nil
		Music.unpersistBad(track)
		if status == "ok" and not Music.proven then
			Music.proven = true
			for _, other in ipairs(Music.tracks) do
				if other.pendingBad then
					other.pendingBad = nil
					Music.persistBad(other)
				end
			end
		end
	end
	if changed then
		Music.fire(track)
	end
end

----------------------------------------------------------------------------------------------------
-- the Sound
----------------------------------------------------------------------------------------------------
function Music.ensureSound()
	local sound = Music.sound
	if sound and sound.Parent then
		return sound
	end
	local ok, created = pcall(function()
		return Util.new("Sound", { Name = "VirexHubMusic", Volume = Music.volume(), Looped = false }, SoundService or App.gui)
	end)
	if not ok or not created then
		Util.log("warn", "music: the Sound could not be created: " .. tostring(created))
		return nil
	end
	Music.sound = created
	pcall(function()
		created.Ended:Connect(function()
			Music.onEnded()
		end)
	end)
	return created
end

function Music.applyVolume()
	local sound = Music.sound
	if sound then
		pcall(function()
			sound.Volume = Music.volume()
		end)
	end
end

function Music.applyRepeat()
	local sound = Music.sound
	if sound then
		pcall(function()
			sound.Looped = Store.get("musicRepeat") == "one"
		end)
	end
end

-- Waits until Roblox has really loaded `sound` (or `seconds` pass).
-- Returns true, length   or   false, reason.
function Music.probe(sound, seconds)
	local started = os.clock()
	local job = { done = false, success = false }
	if ContentProvider then
		task.spawn(function()
			local okPreload = pcall(ContentProvider.PreloadAsync, ContentProvider, { sound }, function(_, status)
				job.success = tostring(status) == "Enum.AssetFetchStatus.Success"
			end)
			if not okPreload then
				job.success = false
			end
			job.done = true
		end)
	end
	while not job.done and os.clock() - started < seconds do
		if not ContentProvider then
			local ready = false
			pcall(function()
				ready = sound.IsLoaded and sound.TimeLength >= 1
			end)
			if ready then
				job.done, job.success = true, true
			end
		end
		task.wait(0.05)
	end
	local length, loaded = 0, false
	pcall(function()
		length, loaded = sound.TimeLength, sound.IsLoaded
	end)
	if job.success and length < 1 then
		-- the preload finished a moment before the length was filled in
		local waited = 0
		while length < 1 and waited < 0.6 do
			task.wait(0.05)
			waited = waited + 0.05
			pcall(function()
				length = sound.TimeLength
			end)
		end
	end
	if length >= 1 or (job.success and loaded) then
		return true, length
	end
	if not job.done then
		return false, Music.TIMEOUT
	end
	return false, "Roblox could not load it (private or removed)"
end

----------------------------------------------------------------------------------------------------
-- what plays next
----------------------------------------------------------------------------------------------------
-- indexes (in list order) that Next / Previous / auto-advance may use: the category of the last pick, no unavailable songs
function Music.queue()
	local list = {}
	for i, track in ipairs(Music.tracks) do
		if track.status ~= "bad" and Music.inKind(track, Music.queueKind) then
			list[#list + 1] = i
		end
	end
	return list
end

function Music.firstPlayable()
	return Music.queue()[1]
end

function Music.dropFromBag(index)
	for at = #Music.bag, 1, -1 do
		if Music.bag[at] == index then
			table.remove(Music.bag, at)
		end
	end
end

function Music.resetBag()
	Music.bag, Music.bagActive = {}, false
end

-- The song after `from`. nil = nothing to play (end of the list with repeat off, or no playable song).
-- `auto` = the song ended by itself (so "repeat off" may stop); a tap on Next wraps around instead.
function Music.pickNext(from, auto)
	local queue = Music.queue()
	if #queue == 0 then
		return nil
	end
	if Store.get("musicShuffle") then
		-- a "bag": every song once per round in random order, then the bag is filled again
		local bag = {}
		for _, i in ipairs(Music.bag) do
			local track = Music.tracks[i]
			if track and track.status ~= "bad" and i ~= from and Music.inKind(track, Music.queueKind) then
				bag[#bag + 1] = i
			end
		end
		if #bag == 0 then
			if Music.bagActive and auto and Store.get("musicRepeat") == "off" then
				Music.bagActive = false
				Music.bag = {}
				return nil
			end
			for _, i in ipairs(queue) do
				if i ~= from or #queue == 1 then
					bag[#bag + 1] = i
				end
			end
			Music.bagActive = true
		end
		local choice = table.remove(bag, math.random(1, #bag))
		Music.bag = bag
		return choice
	end
	local position
	for at, i in ipairs(queue) do
		if i == from then
			position = at
			break
		end
	end
	if not position then
		-- `from` is not in this queue: continue with the first queued song after it
		position = 0
		for at, i in ipairs(queue) do
			if i > (from or 0) then
				position = at - 1
				break
			end
		end
	end
	local target = position + 1
	if target > #queue then
		if auto and Store.get("musicRepeat") == "off" then
			return nil
		end
		target = 1
	end
	return queue[target]
end

-- The song before `from`. Returns index, wentBack (true = it came from the history, so it is not pushed again).
function Music.pickPrevious(from)
	if Store.get("musicShuffle") then
		while #Music.history > 0 do
			local i = table.remove(Music.history)
			local track = Music.tracks[i]
			if track and track.status ~= "bad" and i ~= from then
				return i, true
			end
		end
	end
	local queue = Music.queue()
	if #queue == 0 then
		return nil, false
	end
	local position
	for at, i in ipairs(queue) do
		if i == from then
			position = at
			break
		end
	end
	if not position then
		return queue[#queue], false
	end
	position = position - 1
	if position < 1 then
		position = #queue
	end
	return queue[position], false
end

----------------------------------------------------------------------------------------------------
-- playback
----------------------------------------------------------------------------------------------------
-- opts: origin = "pick" (a tap on a song: a failure is reported and playback stops) | "auto" (Next / Previous / song ended:
-- unavailable songs are skipped), dir = 1 | -1 (direction used when skipping), tries (skips so far), back (do not
-- add the song we leave to the history)
function Music.play(index, opts)
	opts = opts or {}
	local track = Music.tracks[index]
	if not track then
		return false
	end
	local sound = Music.ensureSound()
	if not sound then
		Notify.warn("Music", "This executor could not create a Sound, so music cannot play.", { key = "music-nosound" })
		return false
	end
	if Music.index and Music.index ~= index and not opts.back then
		Music.history[#Music.history + 1] = Music.index
		if #Music.history > 50 then
			table.remove(Music.history, 1)
		end
	end
	Music.token = Music.token + 1
	local token = Music.token
	Music.index = index
	Music.state = "loading"
	pcall(function()
		sound:Stop()
		sound.Looped = Store.get("musicRepeat") == "one"
		sound.Volume = Music.volume()
		sound.SoundId = "rbxassetid://" .. track.id
		sound.TimePosition = 0
	end)
	Store.set("musicLast", track.id)
	Music.fire()
	task.spawn(Music.finishLoad, token, index, opts)
	return true
end

function Music.finishLoad(token, index, opts)
	local sound, track = Music.sound, Music.tracks[index]
	if not sound or not track then
		return
	end
	local ok, info = Music.probe(sound, tonumber(CONFIG.Music.CheckSeconds) or 10)
	if token ~= Music.token or App.destroyed then
		return -- another song was picked while this one was loading
	end
	if not ok then
		Music.mark(track, "bad", info)
		if opts.origin == "auto" and (opts.tries or 0) < (tonumber(CONFIG.Music.SkipTries) or 6) then
			local target, back
			if opts.dir == -1 then
				target, back = Music.pickPrevious(index)
			else
				target = Music.pickNext(index, true)
			end
			if target and target ~= index then
				Music.play(target, { origin = "auto", dir = opts.dir, tries = (opts.tries or 0) + 1, back = back or opts.dir == -1 })
				return
			end
		end
		Music.state = "idle"
		Music.fire(track)
		Notify.warn("Song unavailable", Util.cap(track.title, 38) .. " could not be loaded: " .. tostring(info) .. ".", { key = "music-bad" })
		return
	end
	if info and info >= 1 then
		track.seconds = math.floor(info + 0.5)
	end
	Music.mark(track, "ok")
	pcall(function()
		sound.TimePosition = 0
		sound:Play()
	end)
	Music.state = "playing"
	Music.startedAt = os.clock()
	Music.fire(track)
end

function Music.stop()
	Music.token = Music.token + 1
	local sound = Music.sound
	if sound then
		pcall(function()
			sound:Stop()
			sound.TimePosition = 0
		end)
	end
	Music.state = "idle"
	Music.fire()
end

-- the play / pause button
function Music.toggle()
	local sound = Music.sound
	if Music.state == "playing" and sound then
		pcall(sound.Pause, sound)
		Music.state = "paused"
		Music.fire()
	elseif Music.state == "paused" and sound then
		pcall(sound.Resume, sound)
		Music.state = "playing"
		Music.startedAt = os.clock()
		Music.fire()
	elseif Music.state == "loading" then
		Music.stop() -- a second tap while a song is still loading cancels it
	else
		local index = Music.index
		local track = index and Music.tracks[index] or nil
		if not track or track.status == "bad" then
			index = Music.firstPlayable()
		end
		if index then
			Music.play(index, { origin = "pick" })
		else
			Notify.warn("Music", "There is no song to play.", { key = "music-empty" })
		end
	end
end

function Music.next(auto)
	local target = Music.pickNext(Music.index, auto)
	if target then
		Music.play(target, { origin = "auto", dir = 1 })
	else
		Music.stop()
	end
end

function Music.previous()
	local sound = Music.sound
	if sound and Music.index and (Music.state == "playing" or Music.state == "paused") then
		local position = 0
		pcall(function()
			position = sound.TimePosition
		end)
		if position > 3 then
			pcall(function()
				sound.TimePosition = 0
			end)
			Music.startedAt = os.clock()
			Music.fire()
			return
		end
	end
	local target, back = Music.pickPrevious(Music.index)
	if target then
		Music.play(target, { origin = "auto", dir = -1, back = back })
	end
end

function Music.length()
	local length = 0
	local sound = Music.sound
	if sound and (Music.state == "playing" or Music.state == "paused") then
		pcall(function()
			length = sound.TimeLength
		end)
	end
	if length <= 0 then
		local track = Music.index and Music.tracks[Music.index] or nil
		length = track and track.seconds or 0
	end
	return length
end

function Music.position()
	local position = 0
	local sound = Music.sound
	if sound and (Music.state == "playing" or Music.state == "paused") then
		pcall(function()
			position = sound.TimePosition
		end)
	end
	return position
end

function Music.seek(alpha)
	local sound = Music.sound
	if not sound or (Music.state ~= "playing" and Music.state ~= "paused") then
		return
	end
	local length = 0
	pcall(function()
		length = sound.TimeLength
	end)
	if length <= 0 then
		return
	end
	pcall(function()
		sound.TimePosition = Util.clamp(alpha, 0, 1) * math.max(0, length - 0.3)
	end)
	Music.startedAt = os.clock() -- the "song ended" check waits a moment after a seek
	Music.fire()
end

-- the song reached its end (repeat one is handled by Sound.Looped and never gets here)
function Music.onEnded()
	if Music.state ~= "playing" then
		return
	end
	Music.state = "idle"
	Music.next(true)
end

-- safety net in case the Ended event does not arrive: not playing, back at the start, and the song is known
function Music.checkEnded()
	local sound = Music.sound
	if Music.state ~= "playing" or not sound or os.clock() - Music.startedAt < 2.5 then
		return
	end
	local playing, length, position = true, 0, 0
	pcall(function()
		playing, length, position = sound.IsPlaying, sound.TimeLength, sound.TimePosition
	end)
	if not playing and length > 0 and position < 0.5 then
		Music.onEnded()
	end
end

----------------------------------------------------------------------------------------------------
-- check the whole list (the same load test as a tap, one song after another, on throw-away Sounds)
----------------------------------------------------------------------------------------------------
function Music.checkAll()
	if Music.checking then
		return
	end
	local list = {}
	for _, track in ipairs(Music.tracks) do
		if track.status ~= "ok" then
			list[#list + 1] = track
		end
	end
	local job = { cancel = false, done = 0, total = #list, bad = 0 }
	Music.checking = job
	Music.fire()
	task.spawn(function()
		for _, track in ipairs(list) do
			if job.cancel or App.destroyed or Music.checking ~= job then
				break
			end
			local created, probe = pcall(Util.new, "Sound", { Name = "VirexHubMusicTest", SoundId = "rbxassetid://" .. track.id, Volume = 0 }, SoundService)
			if created and probe then
				local ok, info = Music.probe(probe, tonumber(CONFIG.Music.CheckSeconds) or 10)
				pcall(probe.Destroy, probe)
				if job.cancel or App.destroyed then
					break
				end
				if ok then
					if info and info >= 1 then
						track.seconds = math.floor(info + 0.5)
					end
					Music.mark(track, "ok")
				else
					Music.mark(track, "bad", info)
					job.bad = job.bad + 1
				end
			end
			job.done = job.done + 1
			Music.fire(track)
			task.wait(0.05)
		end
		if Music.checking == job then
			Music.checking = nil
		end
		if App.destroyed then
			return
		end
		Music.fire()
		if job.cancel then
			Notify.info("Check stopped", job.done .. " of " .. job.total .. " songs were checked.", { key = "music-check" })
		else
			Notify.success("Songs checked", string.format("%d of %d songs could not be loaded and are %s.", job.bad, job.total,
				Store.get("musicHideBad") and "hidden" or "marked unavailable"), { key = "music-check" })
		end
	end)
end

-- names for the songs you added (asset name from MarketplaceService; the id is shown if that fails)
function Music.lookupName(id)
	if Music.names[id] or not MarketplaceServiceM then
		return
	end
	task.spawn(function()
		local ok, info = pcall(function()
			return MarketplaceServiceM:GetProductInfo(tonumber(id))
		end)
		if ok and type(info) == "table" and type(info.Name) == "string" and info.Name ~= "" then
			Music.names[id] = Util.cap(info.Name, 60)
			local track = Music.byId[id]
			if track then
				track.title = Music.names[id]
				Music.fire(track)
			end
		end
	end)
end

function Music.lookupNames()
	task.spawn(function()
		for _, track in ipairs(Music.tracks) do
			if App.destroyed then
				return
			end
			if track.custom and not Music.names[track.id] then
				Music.lookupName(track.id)
				task.wait(0.25)
			end
		end
	end)
end

----------------------------------------------------------------------------------------------------
-- lifecycle
----------------------------------------------------------------------------------------------------
function Music.start()
	Anim.add("music", function()
		local ok, problem = pcall(function()
			if Music.state ~= "playing" then
				return
			end
			Music.checkEnded()
			local ui = Music.ui
			if ui and ui.refreshTime and Win.visible and Win.currentTab == "music" then
				ui.refreshTime()
			end
		end)
		if not ok then
			Util.log("warn", "music tick: " .. tostring(problem))
		end
	end, 5, function()
		return Music.state == "playing"
	end)
end

function Music.destroy()
	Anim.remove("music")
	Music.token = Music.token + 1
	Music.state = "idle"
	if Music.checking then
		Music.checking.cancel = true
		Music.checking = nil
	end
	local sound = Music.sound
	Music.sound = nil
	if sound then
		pcall(sound.Stop, sound)
		pcall(sound.Destroy, sound)
	end
	Music.onChange = nil
	Music.ui = nil
end

----------------------------------------------------------------------------------------------------
-- the Music page
----------------------------------------------------------------------------------------------------
function Pages.build.music(page)
	local batch = tonumber(CONFIG.Music.ListBatch) or 40
	local ui = { rows = {}, filter = "all", query = "", limit = batch, shown = 0, visible = 0, rendered = false, seeking = false }
	Music.ui = ui
	Music.rebuild()
	Music.restoreLast()
	Music.start()

	local renderList, refreshPlayer, refreshCounts, paintRow
	local kindDrop

	-- the category names come from CONFIG.Music.Kinds (the single source of truth for the labels)
	local function labelOf(id)
		for _, entry in ipairs(CONFIG.Music.Kinds) do
			if entry.id == id then
				return entry.label
			end
		end
		return nil
	end
	local function kindLabel(kind)
		if kind == "both" then
			return (labelOf("phonk") or "Phonk") .. " / " .. (labelOf("funk") or "Funk")
		end
		return labelOf(kind) or "Your song"
	end
	-- the Kind dropdown: All, every category, Mine; each with the number of songs it holds (counted from Music.tracks)
	local function kindOptions()
		local counts, mine = {}, 0
		for _, song in ipairs(Music.tracks) do
			if song.custom then
				mine = mine + 1
			end
			for _, entry in ipairs(CONFIG.Music.Kinds) do
				if Music.inKind(song, entry.id) then
					counts[entry.id] = (counts[entry.id] or 0) + 1
				end
			end
		end
		local options = { { id = "all", label = "All (" .. #Music.tracks .. ")" } }
		for _, entry in ipairs(CONFIG.Music.Kinds) do
			options[#options + 1] = { id = entry.id, label = entry.label .. " (" .. (counts[entry.id] or 0) .. ")" }
		end
		options[#options + 1] = { id = "custom", label = "Mine (" .. mine .. ")" }
		return options
	end
	local function refreshKinds()
		if kindDrop then
			kindDrop.SetOptions(kindOptions(), ui.filter)
		end
	end

	------------------------------------------------------------------------------------------------
	-- now playing
	------------------------------------------------------------------------------------------------
	UI.section(page, "Now playing", 1)
	local card = Util.new("Frame", { Name = "Player", BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 204), LayoutOrder = 2 }, page)
	Theme.surface(card, "Card", "card")
	Util.corner(card, 12)
	Theme.bind(Util.stroke(card, nil, 1, 0.15), "Color", "Border")

	-- album tile: no image assets, so it is an accent gradient with the note icon
	local art = Util.new("Frame", {
		Name = "Art", BorderSizePixel = 0, Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(64, 64),
		BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2,
	}, card)
	Util.corner(art, 10)
	Theme.gradient(Util.new("UIGradient", { Rotation = 35 }, art), Theme.G.accent)
	UI.icon("music", art, 32, "OnAccent", { anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 3 })

	ui.title = Util.new("TextLabel", {
		Name = "SongTitle", BackgroundTransparency = 1, Position = UDim2.fromOffset(92, 14), Size = UDim2.new(1, -106, 0, 24),
		Text = "Pick a song", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2,
	}, card)
	Typo.apply(ui.title, "title", 17)
	Theme.bind(ui.title, "TextColor3", "Text")
	ui.artist = Util.new("TextLabel", {
		Name = "Artist", BackgroundTransparency = 1, Position = UDim2.fromOffset(92, 40), Size = UDim2.new(1, -106, 0, 18),
		Text = "Music", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2,
	}, card)
	Typo.apply(ui.artist, "body", 13)
	Theme.bind(ui.artist, "TextColor3", "Muted")
	ui.status = Util.new("TextLabel", {
		Name = "Status", BackgroundTransparency = 1, Position = UDim2.fromOffset(92, 60), Size = UDim2.new(1, -106, 0, 16),
		Text = "", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2,
	}, card)
	Typo.apply(ui.status, "caption", 11)
	Theme.bind(ui.status, "TextColor3", "Faint")

	-- seek bar -----------------------------------------------------------------------------------
	local bar = Util.new("Frame", {
		Name = "Seek", BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 92), Size = UDim2.new(1, -28, 0, 24), ZIndex = 2,
	}, card)
	local track = Util.new("Frame", {
		Name = "Track", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 5),
		BorderSizePixel = 0, ZIndex = 2,
	}, bar)
	Util.round_corner(track)
	Theme.bind(track, "BackgroundColor3", "Track")
	local fill = Util.new("Frame", {
		Name = "Fill", Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3,
	}, track)
	Util.round_corner(fill)
	Theme.gradient(Util.new("UIGradient", { Rotation = 0 }, fill), Theme.G.accent)
	local knob = Util.new("Frame", {
		Name = "Knob", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(13, 13),
		BorderSizePixel = 0, ZIndex = 4,
	}, track)
	Util.round_corner(knob)
	Theme.bind(knob, "BackgroundColor3", "Text")
	local seekHit = Util.new("TextButton", {
		Name = "Hit", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1), ZIndex = 6,
	}, bar)

	ui.elapsed = Util.new("TextLabel", {
		Name = "Elapsed", BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 114), Size = UDim2.fromOffset(70, 16),
		Text = "0:00", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2,
	}, card)
	Typo.apply(ui.elapsed, "caption", 11)
	Theme.bind(ui.elapsed, "TextColor3", "Muted")
	ui.total = Util.new("TextLabel", {
		Name = "Total", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 114),
		Size = UDim2.fromOffset(70, 16), Text = "0:00", TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2,
	}, card)
	Typo.apply(ui.total, "caption", 11)
	Theme.bind(ui.total, "TextColor3", "Muted")

	local function seekFromX(x)
		local width = track.AbsoluteSize.X
		if width <= 0 then
			return nil
		end
		local alpha = Util.clamp((x - track.AbsolutePosition.X) / width, 0, 1)
		fill.Size = UDim2.fromScale(alpha, 1)
		knob.Position = UDim2.fromScale(alpha, 0.5)
		ui.elapsed.Text = Music.fmt(alpha * Music.length())
		return alpha
	end

	-- Same touch rules as the sliders: a sideways drag seeks, a vertical drag scrolls the page, a tap seeks to that spot.
	seekHit.InputBegan:Connect(function(input)
		if ui.seeking or not UI.isPress(input) then
			return
		end
		if Music.state ~= "playing" and Music.state ~= "paused" then
			UI.shake(bar) -- nothing is playing, so there is nothing to seek in
			return
		end
		ui.seeking = true
		local isTouch = input.UserInputType == Enum.UserInputType.Touch
		local scroller = UI.findScroller(bar)
		local origin = input.Position
		local decided, engaged = not isTouch, false
		local alpha = nil
		local function engage()
			if engaged then
				return
			end
			engaged, decided = true, true
			if scroller then
				scroller.ScrollingEnabled = false
			end
			Motion.tween(knob, { Size = UDim2.fromOffset(17, 17) }, 0.1)
		end
		if not isTouch then
			engage()
			alpha = seekFromX(origin.X)
		end
		UI.watchInput(input, function(i)
			local delta = i.Position - origin
			if not decided then
				if math.abs(delta.X) + math.abs(delta.Y) < 8 then
					return
				end
				decided = true
				if math.abs(delta.X) >= math.abs(delta.Y) then
					engage()
					alpha = seekFromX(i.Position.X)
				end
				return
			end
			if engaged then
				alpha = seekFromX(i.Position.X)
			end
		end, function(cancelled)
			ui.seeking = false
			if not decided and not cancelled then
				engage()
				alpha = seekFromX(origin.X) -- a tap
			end
			if engaged then
				if scroller then
					scroller.ScrollingEnabled = true
				end
				Motion.tween(knob, { Size = UDim2.fromOffset(13, 13) }, 0.15)
				if alpha and not cancelled then
					Music.seek(alpha)
				end
			end
		end)
	end)

	function ui.refreshTime()
		if ui.seeking then
			return
		end
		local length = Music.length()
		local position = Music.position()
		ui.elapsed.Text = Music.fmt(position)
		ui.total.Text = length > 0 and Music.fmt(length) or "--:--"
		local alpha = length > 0 and Util.clamp(position / length, 0, 1) or 0
		fill.Size = UDim2.fromScale(alpha, 1)
		knob.Position = UDim2.fromScale(alpha, 0.5)
	end

	-- transport: shuffle, previous, play / pause, next, repeat ----------------------------------------
	local row = Util.new("Frame", {
		Name = "Transport", BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 138), Size = UDim2.new(1, -28, 0, 56), ZIndex = 2,
	}, card)

	local function iconButton(name, icon, size, iconSize, x, o)
		o = o or {}
		local hit = Util.new("TextButton", {
			Name = name, Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(x, 0.5), Size = UDim2.fromOffset(size, size), ZIndex = 3,
		}, row)
		local face = Util.new("Frame", {
			Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, ZIndex = 3, BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = o.primary and 0 or 1,
		}, hit)
		Util.corner(face, size / 2)
		if o.primary then
			Theme.gradient(Util.new("UIGradient", { Rotation = 25 }, face), Theme.G.accent)
		end
		local api = { Instance = hit, Face = face, role = o.primary and "OnAccent" or (o.role or "Text") }
		local function build(iconName)
			if api.Icon then
				api.Icon.Instance:Destroy()
			end
			api.Icon = UI.icon(iconName, face, iconSize, api.role, {
				anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 4,
			})
		end
		build(icon)
		api.SetIcon = build
		function api.SetRole(role)
			api.role = role
			api.Icon.SetRole(role, 0.15)
		end
		local state = UI.pressable(hit, face, { radius = size / 2, overlayRole = o.primary and "OnAccent" or "Text" })
		hit.Activated:Connect(function()
			if state.wasDrag() then
				return
			end
			Sfx.play("click")
			if o.onClick then
				Util.try("music " .. name, o.onClick)
			end
		end)
		return api
	end

	ui.shuffle = iconButton("Shuffle", "shuffle", 36, 20, 0.1, {
		role = "Muted",
		onClick = function()
			Store.set("musicShuffle", not Store.get("musicShuffle"))
		end,
	})
	ui.prev = iconButton("Previous", "prev", 40, 22, 0.3, {
		onClick = function()
			Music.previous()
		end,
	})
	ui.play = iconButton("PlayPause", "play", 52, 26, 0.5, {
		primary = true,
		onClick = function()
			Music.toggle()
		end,
	})
	ui.next = iconButton("Next", "next", 40, 22, 0.7, {
		onClick = function()
			Music.next(false)
		end,
	})
	ui.loop = iconButton("Repeat", "loop", 36, 20, 0.9, {
		role = "Accent",
		onClick = function()
			local mode = Store.get("musicRepeat")
			Store.set("musicRepeat", mode == "all" and "one" or (mode == "one" and "off" or "all"))
		end,
	})
	ui.loopBadge = Util.new("TextLabel", {
		Name = "One", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.56),
		Size = UDim2.fromOffset(10, 10), Text = "1", ZIndex = 7, Visible = false,
	}, ui.loop.Instance)
	Typo.apply(ui.loopBadge, "label", 9)
	Theme.bind(ui.loopBadge, "TextColor3", "Accent")
	ui.shuffleRole, ui.loopRole, ui.playIcon = "Muted", "Accent", "play"

	------------------------------------------------------------------------------------------------
	-- volume
	------------------------------------------------------------------------------------------------
	local volumeCard = UI.card({
		parent = page, order = 3, title = "Music volume", desc = "Only the music. The interface sounds keep their own volume in Settings.",
		stack = true, controlHeight = 38, name = "Music volume",
	})
	local volume = UI.slider({
		parent = volumeCard.Controls, min = 0, max = 1, step = 0.01, value = Store.get("musicVolume"), name = "Slider",
		onChange = function(value)
			Store.set("musicVolume", value)
		end,
	})
	volume.Instance.Size = UDim2.new(1, 0, 0, 38)

	------------------------------------------------------------------------------------------------
	-- song list: the rows are built lazily (the first time the tab is opened) and only a batch at a time
	------------------------------------------------------------------------------------------------
	UI.section(page, "Songs", 4)
	ui.list = Util.new("Frame", {
		Name = "SongList", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 10 + #(CONFIG.Music.Playlists or {}), -- after the "Your Spotify" cards
	}, page)
	Util.list(ui.list, 6)

	local function matches(song, index)
		if not Music.inKind(song, ui.filter) then
			return false
		end
		if Store.get("musicHideBad") and song.status == "bad" and Music.index ~= index then
			return false
		end
		if ui.query ~= "" then
			local text = string.lower(song.title .. " " .. song.artist)
			if not string.find(text, ui.query, 1, true) then
				return false
			end
		end
		return true
	end

	local function removeCustom(id)
		local list = {}
		for _, existing in ipairs(Store.get("musicCustom")) do
			if existing ~= id then
				list[#list + 1] = existing
			end
		end
		Store.set("musicCustom", list) -- the "musicCustom" watcher below rebuilds the list
	end

	local function buildRow(index, order)
		local song = Music.tracks[index]
		local rowButton = Util.new("TextButton", {
			Name = "Song", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 48), LayoutOrder = order,
		}, ui.list)
		local face = Util.new("Frame", {
			Name = "Face", Active = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1), BorderSizePixel = 0,
		}, rowButton)
		Util.corner(face, 10)
		Theme.surface(face, "Card", "card")
		local stroke = Util.stroke(face, nil, 1, 0.3)
		Theme.bind(stroke, "Color", "Border")
		local number = Util.new("TextLabel", {
			Name = "No", BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 0), Size = UDim2.fromOffset(30, 48),
			Text = tostring(order), ZIndex = 2,
		}, face)
		Typo.apply(number, "caption", 11)
		Theme.bind(number, "TextColor3", "Faint")
		local note = UI.icon("music", face, 16, "Accent", { anchor = Vector2.new(0.5, 0.5), position = UDim2.fromOffset(21, 24), zindex = 2 })
		note.Instance.Visible = false
		local rightPad = song.custom and 56 or 30
		local title = Util.new("TextLabel", {
			Name = "Title", BackgroundTransparency = 1, Position = UDim2.fromOffset(42, 7), Size = UDim2.new(1, -(42 + rightPad), 0, 18),
			Text = song.title, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2,
		}, face)
		Typo.apply(title, "heading", 13)
		Theme.bind(title, "TextColor3", "Text")
		local sub = Util.new("TextLabel", {
			Name = "Sub", BackgroundTransparency = 1, Position = UDim2.fromOffset(42, 26), Size = UDim2.new(1, -(42 + rightPad), 0, 16),
			Text = "", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 2,
		}, face)
		Typo.apply(sub, "caption", 11)
		Theme.bind(sub, "TextColor3", "Muted")
		local dot = Util.new("Frame", {
			Name = "Ok", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, song.custom and -46 or -14, 0.5, 0),
			Size = UDim2.fromOffset(7, 7), BorderSizePixel = 0, Visible = false, ZIndex = 2,
		}, face)
		Util.round_corner(dot)
		Theme.bind(dot, "BackgroundColor3", "Green")

		if song.custom then
			local remove = Util.new("TextButton", {
				Name = "Remove", Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
				AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(30, 30), ZIndex = 5,
			}, rowButton)
			UI.icon("close", remove, 14, "Muted", { anchor = Vector2.new(0.5, 0.5), position = UDim2.fromScale(0.5, 0.5), zindex = 6 })
			remove.Activated:Connect(function()
				Sfx.play("click")
				removeCustom(song.id)
			end)
		end

		local entry = { hit = rowButton, face = face, stroke = stroke, title = title, sub = sub, note = note, number = number, dot = dot, track = song, index = index }
		local press = UI.pressable(rowButton, face, { radius = 10 })
		rowButton.Activated:Connect(function()
			if press.wasDrag() then
				return
			end
			if Music.index == index and (Music.state == "playing" or Music.state == "paused") then
				Music.toggle() -- a tap on the song that is already playing pauses / resumes it
				return
			end
			Sfx.play("select")
			if Music.queueKind ~= ui.filter then
				Music.queueKind = ui.filter -- Next / Previous stay inside the category that is shown
				Music.resetBag()
			end
			Music.dropFromBag(index)
			Music.play(index, { origin = "pick" })
		end)
		paintRow(entry)
		return entry
	end

	function paintRow(entry)
		local song = entry.track
		local current = Music.index == entry.index
		local bad = song.status == "bad"
		Theme.tweenRole(entry.stroke, "Color", current and "Accent" or "Border", 0.15)
		entry.stroke.Transparency = current and 0.1 or 0.3
		Theme.tweenRole(entry.face, "BackgroundColor3", current and "AccentSoft" or "Card", 0.15)
		Theme.tweenRole(entry.title, "TextColor3", current and "Accent" or "Text", 0.15)
		entry.title.Text = song.title
		entry.title.TextTransparency = bad and 0.55 or 0
		entry.note.Instance.Visible = current
		entry.number.Visible = not current
		entry.dot.Visible = song.status == "ok"
		if bad then
			entry.sub.Text = "Unavailable"
			Theme.bind(entry.sub, "TextColor3", "Danger")
		else
			entry.sub.Text = song.artist .. (song.seconds > 0 and ("  -  " .. Music.fmt(song.seconds)) or "")
			Theme.bind(entry.sub, "TextColor3", "Muted")
		end
		if current then
			local role = Music.state == "playing" and "Accent" or "Muted"
			if entry.noteRole ~= role then
				entry.noteRole = role
				entry.note.SetRole(role, 0.15)
			end
		end
	end

	local function placeMore(remaining)
		if ui.more then
			ui.more:Destroy()
			ui.more = nil
		end
		if remaining <= 0 then
			return
		end
		local button = UI.button({
			parent = ui.list, text = "Show more (" .. remaining .. ")", kind = "ghost", small = true, name = "More",
			size = UDim2.new(1, 0, 0, 36), order = 100000,
			onClick = function()
				ui.limit = ui.limit + batch
				renderList(true)
			end,
		})
		ui.more = button.Instance
	end

	function renderList(append)
		if not ui.list or not ui.list.Parent then
			return
		end
		local wanted = {}
		for i, song in ipairs(Music.tracks) do
			if matches(song, i) then
				wanted[#wanted + 1] = i
			end
		end
		ui.visible = #wanted
		if not append then
			for _, entry in pairs(ui.rows) do
				pcall(function()
					entry.hit:Destroy()
				end)
			end
			ui.rows, ui.shown = {}, 0
			UI.prune()
		end
		local target = math.min(#wanted, ui.limit)
		for n = ui.shown + 1, target do
			ui.rows[wanted[n]] = buildRow(wanted[n], n)
		end
		ui.shown = target
		placeMore(#wanted - target)
		if #wanted == 0 then
			if not ui.empty then
				ui.empty = Util.new("TextLabel", {
					Name = "Empty", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 44), LayoutOrder = 1,
					Text = "No songs here. Try another filter, or add a song by its audio ID.", TextWrapped = true,
				}, ui.list)
				Typo.apply(ui.empty, "body", 12)
				Theme.bind(ui.empty, "TextColor3", "Muted")
			end
		elseif ui.empty then
			ui.empty:Destroy()
			ui.empty = nil
		end
		refreshCounts()
	end

	------------------------------------------------------------------------------------------------
	-- list controls
	------------------------------------------------------------------------------------------------
	local findCard = UI.card({
		parent = page, order = 5, title = "Song list", desc = "", stack = true, controlHeight = 80, name = "Song list",
	})
	ui.findCard = findCard
	local pendingRender = 0
	kindDrop = UI.dropdown({
		parent = findCard.Controls, name = "Kind", value = "all", height = 34, options = kindOptions(),
		onChange = function(id)
			ui.filter = id
			ui.limit = batch
			renderList()
		end,
	})
	kindDrop.Instance.Size = UDim2.new(1, 0, 0, 34) -- UI.dropdown sizes itself in pixels; this makes it as wide as the card, like the control it replaces
	UI.input({
		parent = findCard.Controls, name = "Search", placeholder = "Search songs", maxLength = 40,
		size = UDim2.new(1, 0, 0, 34), position = UDim2.fromOffset(0, 46),
		onChange = function(text)
			ui.query = string.lower(text)
			ui.limit = batch
			pendingRender = pendingRender + 1
			local mine = pendingRender
			task.delay(0.3, function() -- wait until the typing pauses
				if mine == pendingRender and not App.destroyed then
					renderList()
				end
			end)
		end,
	})

	local hideCard = UI.card({
		parent = page, order = 6, title = "Hide unavailable songs", desc = "Songs that do not load on this device are left out of the list.",
		control = 62, name = "Hide unavailable songs",
	})
	local hideToggle = UI.toggle({
		parent = hideCard.Controls, value = Store.get("musicHideBad"), anchor = Vector2.new(1, 0.5), position = UDim2.fromScale(1, 0.5),
		name = "Toggle",
		onChange = function(value)
			Store.set("musicHideBad", value)
		end,
	})
	Pages.register(hideCard, 62)

	local checkCard = UI.card({ parent = page, order = 7, title = "Check songs", desc = "", control = 124, name = "Check songs" })
	ui.checkCard = checkCard
	ui.checkButton = UI.button({
		parent = checkCard.Controls, text = "Check all", small = true, name = "Action", size = UDim2.new(1, 0, 0, 34),
		anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
		onClick = function()
			if Music.checking then
				Music.checking.cancel = true -- the same button stops a check that is running
				return
			end
			local pending = 0
			for _, song in ipairs(Music.tracks) do
				if song.status ~= "ok" then
					pending = pending + 1
				end
			end
			if pending == 0 then
				Notify.info("Songs checked", "Every song in the list already loads on this device.", { key = "music-check" })
				return
			end
			UI.confirm({
				title = "Check " .. pending .. " songs?",
				text = "Each song is loaded once, one after another, so only the ones that work on this device stay in the list. "
					.. "That downloads roughly " .. math.ceil(pending * 2) .. " MB, so use Wi-Fi if you can. You can stop at any time.",
				confirmText = "Check",
				onConfirm = function()
					Music.checkAll()
				end,
			})
		end,
	})
	Pages.register(checkCard, 124)

	local addCard = UI.card({
		parent = page, order = 8, title = "Add a song", desc = "Paste the number of a Roblox audio asset. It is checked when you play it.",
		stack = true, controlHeight = 36, name = "Add a song",
	})
	local addInput = UI.input({
		parent = addCard.Controls, name = "Id", placeholder = "Audio ID", numeric = true, maxLength = 16, size = UDim2.new(1, -86, 0, 36),
	})
	local function addSong()
		local id = cleanId(addInput.Get())
		if not id then
			addInput.Flash("Danger")
			Notify.warn("Audio ID", "Paste the number of a Roblox audio asset (5 to 16 digits).", { key = "music-id" })
			return
		end
		if Music.byId[id] then
			Notify.info("Already in the list", Util.cap(Music.byId[id].title, 40), { key = "music-dup" })
			return
		end
		local list = Util.copy(Store.get("musicCustom"))
		if #list >= Store.rules.musicCustom.max then
			Notify.warn("List full", "You can keep up to " .. Store.rules.musicCustom.max .. " songs of your own.", { key = "music-full" })
			return
		end
		list[#list + 1] = id
		Store.set("musicCustom", list)
		addInput.Set("")
		Notify.success("Song added", "Find it under Mine. It is checked when you play it.", { key = "music-added" })
		Music.lookupName(id)
	end
	UI.button({
		parent = addCard.Controls, text = "Add", kind = "primary", small = true, name = "Add", size = UDim2.fromOffset(78, 36),
		anchor = Vector2.new(1, 0), position = UDim2.new(1, 0, 0, 0), onClick = addSong,
	})

	------------------------------------------------------------------------------------------------
	-- your Spotify playlists (CONFIG.Music.Playlists): the hub cannot play Spotify, the buttons only copy the link
	------------------------------------------------------------------------------------------------
	local playlists = CONFIG.Music.Playlists or {}
	if #playlists > 0 then
		UI.section(page, "Your Spotify", 9)
		local canCopy = Env.canClipboard()
		for i, playlist in ipairs(playlists) do
			local spotifyCard = UI.card({
				parent = page, order = 9 + i, title = playlist.name, name = "Spotify " .. playlist.name,
				desc = playlist.items .. " items on Spotify. The hub cannot play Spotify; Copy link puts the playlist link on your clipboard.",
				control = 124,
			})
			local copyButton = UI.button({
				parent = spotifyCard.Controls, text = "Copy link", small = true, name = "Action", size = UDim2.new(1, 0, 0, 34),
				anchor = Vector2.new(0, 0.5), position = UDim2.fromScale(0, 0.5),
				onClick = function()
					if Env.copy(playlist.url) then
						Notify.success("Link copied", "Paste it in your browser or the Spotify app to open " .. playlist.name .. ".", { key = "music-spotify" })
					else
						Notify.error("Copy failed", "The executor refused the clipboard request.", { key = "music-spotify" })
					end
				end,
			})
			if not canCopy then
				copyButton.SetEnabled(false, "This executor does not provide a clipboard function.")
			end
			Pages.register(spotifyCard, 124)
		end
	end

	------------------------------------------------------------------------------------------------
	-- refresh
	------------------------------------------------------------------------------------------------
	function refreshPlayer()
		local song = Music.index and Music.tracks[Music.index] or nil
		local state = Music.state
		ui.title.Text = song and song.title or "Pick a song"
		ui.artist.Text = song and song.artist or "Music"
		local text, role = "", "Faint"
		if state == "loading" then
			text, role = "Loading...", "Muted"
		elseif state == "playing" then
			text, role = "Playing", "Green"
		elseif state == "paused" then
			text, role = "Paused", "Warn"
		elseif song and song.status == "bad" then
			text, role = "Unavailable", "Danger"
		elseif song then
			text = kindLabel(song.kind)
		end
		ui.status.Text = text
		Theme.bind(ui.status, "TextColor3", role)

		local wanted = (state == "playing" or state == "loading") and "pause" or "play"
		if ui.playIcon ~= wanted then
			ui.playIcon = wanted
			ui.play.SetIcon(wanted)
		end
		local shuffleRole = Store.get("musicShuffle") and "Accent" or "Muted"
		if ui.shuffleRole ~= shuffleRole then
			ui.shuffleRole = shuffleRole
			ui.shuffle.SetRole(shuffleRole)
		end
		local mode = Store.get("musicRepeat")
		local loopRole = mode == "off" and "Muted" or "Accent"
		if ui.loopRole ~= loopRole then
			ui.loopRole = loopRole
			ui.loop.SetRole(loopRole)
		end
		ui.loopBadge.Visible = mode == "one"
		ui.refreshTime()
	end

	function refreshCounts()
		local total, ok, bad = Music.counts()
		ui.findCard.SetDesc(string.format("%d songs  -  %d shown  -  tap one to play", total, ui.visible or 0))
		local job = Music.checking
		if job then
			ui.checkCard.SetDesc(string.format("Checking %d of %d...  %d unavailable so far. Tap Stop to cancel.", job.done, job.total, job.bad))
			ui.checkButton.SetText("Stop")
		else
			ui.checkCard.SetDesc(string.format("%d work  -  %d unavailable  -  %d not checked yet. A song is also checked the first time you play it.", ok, bad, total - ok - bad))
			ui.checkButton.SetText("Check all")
		end
	end

	Music.onChange = function(song)
		refreshPlayer()
		if song then
			local entry = ui.rows[song.index]
			if entry then
				paintRow(entry)
			end
		end
		local current = Music.index
		if ui.lastIndex ~= current then
			local old = ui.lastIndex and ui.rows[ui.lastIndex] or nil
			if old then
				paintRow(old)
			end
			ui.lastIndex = current
		end
		local entry = current and ui.rows[current] or nil
		if entry then
			paintRow(entry)
		end
		refreshCounts()
	end

	Pages.watch("musicVolume", function(value)
		volume.Set(value, true)
		Music.applyVolume()
	end)
	Pages.watch("musicRepeat", function()
		Music.applyRepeat()
		refreshPlayer()
	end)
	Pages.watch("musicShuffle", function()
		Music.resetBag()
		refreshPlayer()
	end)
	Pages.watch("musicHideBad", function(value)
		hideToggle.Set(value, true)
		if ui.rendered then
			renderList()
		end
	end)
	Pages.watch("musicCustom", function()
		Music.rebuild()
		refreshKinds()
		if ui.rendered then
			renderList()
		end
		refreshPlayer()
		refreshCounts()
	end)

	-- the song rows are built the first time the tab is shown
	local function ensureRendered()
		if not ui.rendered then
			ui.rendered = true
			renderList()
		end
	end
	page:GetPropertyChangedSignal("Visible"):Connect(function()
		if page.Visible then
			ensureRendered()
		end
	end)
	if page.Visible then
		ensureRendered()
	end

	refreshPlayer()
	refreshCounts()
	Music.lookupNames()
end

end -- [15_music.lua]

do -- [13_app.lua]

----------------------------------------------------------------------------------------------------
-- App: boot sequence, duplicate-run protection, settings wiring, diagnostics, teardown.
-- The loading screen shows REAL work only: every bar step is a boot stage that actually finished
-- (or a real sound-preload completion). A watchdog hands off to the hub if startup stalls.
----------------------------------------------------------------------------------------------------
App.startedAt = os.clock()
App.gui = nil
App.maid = nil
App.token = nil
App.booted = false
App.destroyed = false
App.handedOff = false
App.parentKind = "none"
App.warnings = {}

function App.warn(text)
	App.warnings[#App.warnings + 1] = text
	Util.log("warn", text)
end

----------------------------------------------------------------------------------------------------
-- duplicate-run protection
----------------------------------------------------------------------------------------------------
-- Removes ScreenGuis left behind by an earlier run (or by the original script) in every place a hub can live.
function App.removeLeftovers()
	local names = { CONFIG.GuiName, CONFIG.SplashName }
	for _, legacy in ipairs(CONFIG.LegacyGuis) do
		names[#names + 1] = legacy
	end
	local parents = {}
	if Env.fn.gethui then
		local ok, container = pcall(Env.fn.gethui)
		if ok and typeof(container) == "Instance" then
			parents[#parents + 1] = container
		end
	end
	local player = Players.LocalPlayer
	local playerGui = player and player:FindFirstChildOfClass("PlayerGui")
	if playerGui then
		parents[#parents + 1] = playerGui
	end
	for _, parent in ipairs(parents) do
		for _, name in ipairs(names) do
			local guard = 0
			local found = parent:FindFirstChild(name)
			while found and guard < 8 do
				pcall(found.Destroy, found)
				guard = guard + 1
				found = parent:FindFirstChild(name)
			end
		end
	end
end

-- If a previous run registered itself, ask it to tear down first; then register this run.
function App.claim()
	local global = Env.global()
	local previous = global.__VirexHub
	if type(previous) == "table" and type(previous.destroy) == "function" then
		pcall(previous.destroy, "replaced by a newer run")
	end
	App.removeLeftovers()
	App.token = {}
	global.__VirexHub = {
		version = CONFIG.Version,
		token = App.token,
		destroy = function(reason)
			App.destroy(reason or "api")
		end,
		toggle = function()
			Win.toggle()
		end,
	}
end

----------------------------------------------------------------------------------------------------
-- settings side effects (one place). Widgets only call Store.set; these listeners do the rest.
----------------------------------------------------------------------------------------------------
function App.wire()
	local maid = App.maid
	local function on(key, fn)
		maid:Give(Store.on(key, fn))
	end
	on("reducedMotion", function(value)
		Motion.reduced = value
		Theme.syncFx()
		Bg.apply()
	end)
	on("lowPower", function()
		Theme.syncFx()
		Bg.apply()
	end)
	on("fx", function()
		Theme.syncFx()
	end)
	on("theme", function(id)
		Theme.apply(id)
	end)
	on("glass", function(value)
		Theme.setGlass(value)
	end)
	on("overlay", function()
		Bg.updateOverlay()
	end)
	on("blur", function()
		Bg.syncBlur()
	end)
	on("font", function(id)
		Typo.setFamily(id)
	end)
end

function App.resetPreferences()
	Store.reset()
	Bg.apply()
	Pages.syncAll()
	Win.recenter()
	Win.setMinimized(false)
	Notify.success("Preferences reset", "The hub is back to its default settings.")
end

----------------------------------------------------------------------------------------------------
-- diagnostics (Settings > Environment > Copy report)
----------------------------------------------------------------------------------------------------
function App.report()
	local lines = {}
	local function add(text)
		lines[#lines + 1] = text
	end
	add("VirexHub " .. CONFIG.Version)
	add(Env.summary())
	add("Interface parent: " .. tostring(App.parentKind))
	add("Settings: " .. (Store.persistent and ("saved to " .. CONFIG.ConfigFile) or "session only"))
	add("Sound: " .. Sfx.summary())
	add("Background: " .. tostring(Bg.status.kind) .. " - " .. tostring(Bg.status.text))
	add(string.format(
		"Theme %s | font %s | scale %d%% | compact %s | reduced motion %s | low power %s | accents %d",
		tostring(Theme.id), tostring(Store.get("font")), Util.percent(Store.get("scale")), tostring(Store.get("compact")),
		tostring(Store.get("reducedMotion")), tostring(Store.get("lowPower")), Store.get("fx")
	))
	local viewport = Env.viewport()
	add(string.format(
		"Viewport %dx%d | window %dx%d at scale %d%% | rail %s | short %s | minimized %s",
		math.floor(viewport.X), math.floor(viewport.Y), math.floor(Win.w), math.floor(Win.h), Util.percent(Win.s),
		tostring(Win.rail), tostring(Win.short), tostring(Win.minimized)
	))
	add("Recent log:")
	for index = math.max(1, #Util.logs - 25), #Util.logs do
		local entry = Util.logs[index]
		add(string.format("  [%.1fs] %s: %s", entry.t - App.startedAt, entry.level, entry.message))
	end
	return table.concat(lines, "\n")
end

----------------------------------------------------------------------------------------------------
-- teardown
----------------------------------------------------------------------------------------------------
function App.destroy(reason)
	if App.destroyed then
		return
	end
	App.destroyed = true
	Util.log("info", "destroy: " .. tostring(reason))
	pcall(Store.flush)
	pcall(UI.endSessions)
	pcall(UI.closeDropdown, true)
	pcall(UI.closeModal, true)
	pcall(Pages.destroy)
	pcall(Music.destroy)
	pcall(Avatar.destroy)
	pcall(Splash.destroy)
	pcall(Notify.destroy)
	pcall(Win.destroy)
	pcall(Bg.destroy)
	pcall(Sfx.destroy)
	pcall(Theme.clearFx)
	Anim.stopAll()
	if App.maid then
		pcall(App.maid.Clean, App.maid)
		App.maid = nil
	end
	Store.listeners = {}
	if App.gui then
		pcall(App.gui.Destroy, App.gui)
		App.gui = nil
	end
	local global = Env.global()
	local registered = global.__VirexHub
	if type(registered) == "table" and registered.token == App.token then
		global.__VirexHub = nil
	end
end

----------------------------------------------------------------------------------------------------
-- boot
----------------------------------------------------------------------------------------------------
function App.boot()
	-- environment + settings first: the loading screen needs the theme, fonts and the user's choices
	Env.detect()
	App.claim()
	Store.load()
	if Store.unreadable == "kept" then
		App.warn("Saved settings could not be read, so defaults are in use. The old file was kept as " .. CONFIG.Folder .. "/config.unreadable.json.")
	elseif Store.unreadable == "replaced" then
		App.warn("Saved settings could not be read, so defaults are in use and the unreadable file was replaced.")
	elseif Store.unreadable == "left" then
		App.warn("Saved settings could not be read, so defaults are in use for this session. The file was left as it is.")
	end
	Motion.reduced = Store.get("reducedMotion")
	Theme.init()
	Typo.init()
	if not Theme.apply(Store.get("theme"), true) then
		Theme.apply("obsidian", true)
	end
	Theme.setGlass(Store.get("glass"))
	Theme.active = function()
		return Win.visible
	end
	-- the loading sound's source (local mp3 -> download -> rbxassetid -> silent) is chosen BEFORE Sfx.init,
	-- so the normal preload and Sound status see it
	pcall(Splash.resolveSound)
	Sfx.init()

	local parent, parentKind = Env.guiParent()
	App.parentKind = parentKind
	if not parent then
		Util.log("error", "no place to put the interface (PlayerGui / gethui unavailable)")
		warn("[VirexHub] could not find a place to show the interface.")
		App.destroy("no gui parent")
		return
	end

	local useSplash = Store.get("splash")
	if useSplash then
		local ok, err = pcall(Splash.create, parent)
		if not ok then
			useSplash = false
			Util.log("error", "splash: " .. tostring(err))
		end
	end
	local total = 5
	local function step(text, done, partial)
		if useSplash then
			Splash.step(text, done, total, partial)
		end
	end
	local function fatal(message)
		Util.log("error", message)
		warn("[VirexHub] " .. message)
		if useSplash and Splash.isOpen then
			Splash.fail(message, function()
				App.destroy("startup failed")
			end)
		else
			App.destroy("startup failed")
		end
	end

	-- hand-off: runs ONLY when the user taps "Tap here to continue" on the loading screen - or at once when the
	-- loading screen is off. The floating logo appears as the loading screen fades. Nothing else ever calls it.
	local function handoff()
		if App.handedOff or App.destroyed then
			return
		end
		App.handedOff = true
		-- only the logo appears: tap it for the tab ring, then tap a tab for that tab's menu
		Win.showLauncher()
		task.delay(0.6, function()
			if App.destroyed then
				return
			end
			Notify.success("Hub ready", "Tap the logo to open the tab ring.")
			for index = 1, math.min(#App.warnings, 2) do
				Notify.warn("Startup notice", Util.cap(App.warnings[index], 140), { duration = 7 })
			end
		end)
	end
	Splash.setHandoff(handoff, nil)
	-- watchdog: it only forces the "tap to continue" state (with a warning). It never hands off by itself while the
	-- loading screen is up.
	task.delay(CONFIG.Splash.MaxSeconds, function()
		if App.destroyed or App.handedOff then
			return
		end
		App.warn("Startup took longer than expected; some optional parts may still be loading.")
		if Win.window and useSplash and Splash.isOpen then
			Splash.force(handoff)
		elseif Win.window then
			handoff()
		else
			fatal("Startup timed out before the window was ready.")
		end
	end)

	-- 1. window --------------------------------------------------------------------------------------
	step("Building window", 0, 0)
	local gui = Util.new("ScreenGui", {
		Name = CONFIG.GuiName, ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 100,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	}, nil)
	gui.Parent = parent
	App.gui = gui
	local okWindow, windowError = pcall(function()
		Win.create(gui)
		Notify.init(gui)
		Pages.init()
	end)
	if not okWindow then
		fatal("The window could not be built: " .. Util.cap(tostring(windowError), 80))
		return
	end
	task.wait()
	if App.destroyed then
		return -- closed while starting: every later stage would build into a window that no longer exists
	end

	-- 2. pages (one real sub-step per page) ----------------------------------------------------------
	local count = #Win.tabList
	for index, def in ipairs(Win.tabList) do
		step("Building " .. def.title, 1, (index - 1) / count)
		if App.destroyed then
			return
		end
		local page = Win.addPage(def.id)
		local okPage, pageError = pcall(Pages.build[def.id], page)
		if not okPage then
			Util.log("error", "page " .. def.id .. ": " .. tostring(pageError))
			App.warn("The " .. def.title .. " page could not be built.")
			UI.card({ parent = page, order = 1, title = "This page could not be built", desc = Util.cap(tostring(pageError), 160) })
		end
		task.wait()
	end
	if App.destroyed then
		return
	end
	Win.selectTab("overview", true)
	Pages.syncCards()
	Win.applyLayout()

	-- 3. sounds (real preload progress; failures just stay silent) ----------------------------------------
	Bg.apply() -- starts loading the saved background in the background of the next step
	step("Loading sounds", 2, 0)
	local loaded, failed, soundCount = Sfx.preload(function(done, n)
		step("Loading sounds", 2, done / math.max(n, 1))
	end, CONFIG.Splash.PreloadSeconds)
	if App.destroyed then
		return
	end
	if useSplash then
		Splash.detail(Sfx.summary(), failed > 0 and "Warn" or "Faint")
	end
	if failed > 0 then
		App.warn(string.format("%d of %d sound assets could not be loaded; those sounds stay silent.", failed, soundCount))
	elseif loaded < soundCount then
		App.warn("Some sound assets did not finish loading in time; they will play only if they load later.")
	end
	Pages.syncAll()

	-- 4. background (waits for the real result, bounded) -----------------------------------------------
	step("Preparing background", 3, 0)
	local waited = 0
	while Bg.status.kind == "loading" and waited < 10 and not App.destroyed do
		task.wait(0.1)
		waited = waited + 0.1
	end
	if App.destroyed then
		return
	end
	if Bg.status.kind == "error" then
		App.warn("Background: " .. Bg.status.text)
	end

	-- 5. finish ------------------------------------------------------------------------------------------
	step("Almost ready", 4, 0)
	App.wire()
	Theme.syncFx()
	if Env.canSave() and not Store.persistent then
		App.warn("Settings could not be saved to a file, so they last for this session only.")
	end
	if #App.warnings > 0 then
		Win.setStatus(string.format("%d notice%s", #App.warnings, #App.warnings > 1 and "s" or ""), "Warn")
	end
	if App.destroyed then
		return
	end
	App.booted = true
	if useSplash and Splash.isOpen then
		Splash.ready(handoff) -- the logo stays hidden until the user taps; nothing auto-closes
	else
		handoff() -- "Show loading screen" is off (or it could not be built): show the logo directly, as before
	end
end

function App.start()
	App.startedAt = os.clock()
	App.destroyed = false
	App.handedOff = false
	App.maid = Maid.new()
	task.spawn(function()
		local ok, err = pcall(App.boot)
		if not ok then
			Util.log("error", "boot: " .. tostring(err))
			warn("[VirexHub] startup failed: " .. tostring(err))
			if Splash.isOpen then
				Splash.fail(tostring(err), function()
					App.destroy("boot error")
				end)
			else
				App.destroy("boot error")
			end
		end
	end)
end

App.start()
end -- [13_app.lua]

