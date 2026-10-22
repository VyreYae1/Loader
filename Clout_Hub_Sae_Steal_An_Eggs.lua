-- Clout Hub | SAE | Steal An Egg  (fixed build)
-- FIXES: (1) 7 spots had dropped function arguments / operands, so the file could not even compile and nothing ran;
--        (2) the WindUI download URLs were empty ("" , ""), so the main interface could not load;
--        (3) the AutoRegrab tail had been pasted into the wrong function (E4) and its helpers were used before they were declared;
--        (4) if WindUI cannot be downloaded the script now says so on screen instead of failing silently.
LRM_IsUserPremium=false
LRM_LinkedDiscordID="\048"
LRM_ScriptName="\115\116\101\097\108"
LRM_TotalExecutions=0
LRM_SecondsLeft=math.huge
LRM_UserNote="\078\111\116\032\115\112\101\099\105\102\105\101\100"
LRM_ScriptVersion="\048\046\048\046\048\046\049"
LRM_ExecutionTrace="\102\097\049\095\055\078\078\109\095\119\066\106\065\082\050\095\067\070\095\095\071\048\054\089\090\102\090\048"

do
local type,pcall,rawget,rawset,tonumber,ipairs=type,pcall,rawget,rawset,tonumber,ipairs
local function environmentOf(provider,fallback)
if type(provider)=="function" then local ok,value=pcall(function()return provider()end) if ok and type(value)=="table" then return value end end
return fallback
end
local scriptEnvironment=environmentOf(getfenv,_G)
local environment=environmentOf(getgenv,scriptEnvironment)
local previous=type(environment)=="table" and rawget(environment,"FlowAuth") or nil
if type(previous)=="table" and type(previous.Stop)=="function" then pcall(previous.Stop,previous) end
local active=true
local client={}
local keyedFeatureOrigin="\104\116\116\112\115\058\047\047\102\108\111\119\097\117\116\104\046\110\101\116"
local keyedFeatureGatewayOrigin="\104\116\116\112\115\058\047\047\102\108\111\119\097\117\116\104\046\110\101\116"
local keyedFeatureBusy={}
local function keyedFeatureHash(value)
if type(value)~="string" then return nil end
value=string.lower(value)
if #value~=32 or not string.match(value,"^[a-f0-9]+$") then return nil end
return value
end
function client:GetKeyLink(loaderHash)
loaderHash=keyedFeatureHash(loaderHash)
if not loaderHash then return nil,"invalid_loader_hash" end
return keyedFeatureGatewayOrigin.."/getkey?project_id="..loaderHash
end
function client:RequireKey(loaderHash,key)
if not active then return false,"client_stopped" end
loaderHash=keyedFeatureHash(loaderHash)
if not loaderHash then return false,"invalid_loader_hash" end
local gateway=keyedFeatureGatewayOrigin.."/getkey?project_id="..loaderHash
if key==nil then key=""end
if type(key)~="string" then return false,"key_required",gateway end
key=string.gsub(key,"^%s*(.-)%s*$","%1")
if #key<0 or #key>512 or string.find(key,"%c") then return false,"invalid_key",gateway end
if keyedFeatureBusy[loaderHash] then return false,"feature_loading",gateway end
keyedFeatureBusy[loaderHash]=true
local url=keyedFeatureOrigin.."/v1/loaders/"..loaderHash..".lua"
local source=nil
for attempt=1,2 do
local ok,value=pcall(game.HttpGet,game,url)
if ok and type(value)=="string" and #value>0 and #value<=262144 and not string.find(string.lower(value),"<html",1,true) then source=value break end
if attempt==1 and type(task)=="table" and type(task.wait)=="function" then task.wait(.15) end
end
url=nil
if not source then keyedFeatureBusy[loaderHash]=nil key=nil return false,"loader_download_failed",gateway end
local compiler=loadstring
if type(compiler)~="function" then keyedFeatureBusy[loaderHash]=nil source=nil key=nil return false,"loadstring_unavailable",gateway end
local feature,compileError=compiler(source,"=FlowAuthKeyedFeature")
source=nil
if not feature then keyedFeatureBusy[loaderHash]=nil key=nil return false,"loader_compile_failed: "..tostring(compileError),gateway end
local callOk,featureResult=xpcall(function()return feature(key)end,function(value)return tostring(value)end)
key=nil
feature=nil
keyedFeatureBusy[loaderHash]=nil
if not callOk then return false,featureResult,gateway end
return true,featureResult,gateway
end
function client:Stop()
active=false
if type(environment)=="table" and rawget(environment,"FlowAuth")==self then
pcall(rawset,environment,"FlowAuth",nil)
end
end
if type(environment)=="table" then pcall(rawset,environment,"FlowAuth",client) end
end

local function CloutHubMain(...)
	if type(game) == "nil" then
		return
	end
	local bootOk = false
	pcall(function(...)
		bootOk = (type(game.GetService) == "function")
	end)
	if not bootOk then
		return
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	local e = game:GetService("Players")
	local r = game:GetService("Workspace")
	local y = game:GetService("RunService")
	local u = game:GetService("TweenService")
	local w = game:GetService("UserInputService")
	local j = game:GetService("ReplicatedStorage")
	local k = game:GetService("ProximityPromptService")
	local a = game:GetService("HttpService")
	local TeleportService = game:GetService("TeleportService")
	local o = e.LocalPlayer
	local DISCORD_LINK = "https://discord.gg/TBBAUZu8cW"
	local ADS_MSG = "discord.gg/cyDpbvxeGN - Bug? Join discord & report! - KEYLESS"
	local ADS_MSG_SHORT = "discord.gg/cyDpbvxeGN - Bug? Join discord!"
	
	local SCRIPT_VERSION = ""
	local SCRIPT_BUILD = ""
	local function CopyDiscord(...)
		local clipboardFn = setclipboard or toClipboard or toclipboard or write_clipboard
		pcall(function(...)
			if typeof(clipboardFn) == "function" then
				clipboardFn(DISCORD_LINK)
			end
		end)
	end
	
	pcall(CopyDiscord)
	task.spawn(function()
		task.wait(0.8)
		pcall(CopyDiscord)
	end)
	local Window = nil
	local currentLang = "EN"
	local executorCheckCaller = typeof(checkcaller) == "function" and checkcaller or function()
		return false
	end
	local safeNewCClosure = typeof(newcclosure) == "function" and newcclosure or function(fn)
		return fn
	end
	local V = game:GetService("ProximityPromptService")
	pcall(function(...)
		V.PromptButtonHoldBegan:Connect(function(e, ...)
			pcall(function(...)
				if typeof(fireproximityprompt) == "function" then
					fireproximityprompt(e)
				end
			end)
		end)
	end)
	
	local H = function(...) end
	local t = function(...) end
	local s = nil
	pcall(function(...)
		s = require((j:WaitForChild("Client", 5)):WaitForChild("EggState", 5))
	end)
	if not s then
		pcall(function(...)
			s = require(j.Client.EggState)
		end)
	end
	local p = nil
	pcall(function(...)
		p = require(((j:WaitForChild("Shared", 5)):WaitForChild("Util", 5)):WaitForChild("AssetItems", 5))
	end)
	if not p then
		pcall(function(...)
			p = require(j.Shared.Util.AssetItems)
		end)
	end
	local B = nil
	pcall(function(...)
		B = require((j:WaitForChild("Shared", 5)):WaitForChild("Remotes", 5))
	end)
	if not B then
		pcall(function(...)
			B = require(j.Shared.Remotes)
		end)
	end
	local function J(e, r, ...)
		local y = (j:FindFirstChild("Packages") and j.Packages:FindFirstChild("Networking"))
			or j:FindFirstChild("Network")
		local u = y:FindFirstChild(e) or j:FindFirstChild(e)
		if u then
			return u
		end
		local w = y:FindFirstChild(e, true) or j:FindFirstChild(e, true)
		if w then
			return w
		end
		if r then
			local e = y:FindFirstChild(r) or j:FindFirstChild(r)
			if e then
				return e
			end
			local u = y:FindFirstChild(r, true) or j:FindFirstChild(r, true)
			if u then
				return u
			end
		end
		local k = string.match(e, "[^/]+$")
		if k then
			local e = y:FindFirstChild(k, true) or j:FindFirstChild(k, true)
			if e then
				return e
			end
		end
		return nil
	end

	local K = J("RF/EggWorld/AskPlaceEgg", "AskPlaceEgg")
	local c = J("RF/EggWorld/AskLiveSnapshot", "AskLiveSnapshot")
	local v = J("RF/Homestead/AskState", "RF/Plots/AskState") or J("AskState")
	local i = J("RF/EggWorld/AskFieldEggCarry", "AskFieldEggCarry")
	local R = J("RF/EggWorld/AskFieldEggSnapshot", "AskFieldEggSnapshot")
		or J("Eggs: RequestAreaEggSnapshot", "RequestAreaEggSnapshot")
	local g = J("RF/EggWorld/AskHatch", "AskHatch") or J("Eggs: RequestHatchEgg")
	local Q = J("RF/EggWorld/AskFinishHatch", "AskFinishHatch") or J("Eggs: RequestCompleteHatchEgg")
	local P = J("RE/GuardPatrol/ForestStrike", "ForestStrike") or (B and (B.GuardPatrol and B.GuardPatrol.ForestStrike))
	local N = J("SpeedTollOffer", "RE/GuardPatrol/SpeedTollOffer")
		or (B and (B.GuardPatrol and B.GuardPatrol.SpeedTollOffer))
	local U = J("RF/Treadmill/AskDoff", "AskDoff")
	local l = J("RF/Treadmill/AskDon", "AskDon") or J("RF/Treadmill/AskMount", "AskMount")
	local D = J("RF/Treadmill/AskTierRaise", "Treadmills: RequestUpgrade", "AskTierRaise")
	local C = J("RF/Trailwear/AskPurchase", "Trailwear: RequestPurchase", "AskPurchase")
	local q = J("RF/Trailwear/AskChoose", "Trailwear: RequestEquip", "AskChoose")
	local n = J("RF/Trailwear/AskDoff", "Trailwear: RequestUnequip", "AskDoff")
	H(
		string.format(
			"[RemoteCheck] Carry: %s | Snapshot: %s | Place: %s | Hatch: %s | FinishHatch: %s | Strike: %s | Toll: %s | Doff: %s",
			tostring(i ~= nil),
			tostring(R ~= nil),
			tostring(K ~= nil),
			tostring(g ~= nil),
			tostring(Q ~= nil),
			tostring(P ~= nil),
			tostring(N ~= nil),
			tostring(U ~= nil)
		)
	)

	local f = {
		["Light Dark"] = 1300,
		["LightDark"] = 1300,
		["Titan Temple"] = 1100,
		["Cherry Blossom"] = 1000,
		["Cosmic"] = 900,
		["Prehistoric"] = 800,
		["Abyss Ocean"] = 700,
		["Volcano"] = 600,
		["Snow"] = 500,
		["Jungle"] = 400,
		["Desert"] = 300,
		["Lake"] = 200,
		["Forest"] = 100,
	}
	local M = {
		"Light Dark",
		"Titan Temple",
		"Cherry Blossom",
		"Cosmic",
		"Prehistoric",
		"Abyss Ocean",
		"Volcano",
		"Snow",
		"Jungle",
		"Desert",
		"Lake",
		"Forest",
	}
	local I = {
		["Light Dark"] = 420,
		["LightDark"] = 420,
		["Titan Temple"] = 380,
		["Cherry Blossom"] = 330,
		["Cosmic"] = 280,
		["Prehistoric"] = 240,
		["Abyss Ocean"] = 200,
		["Volcano"] = 180,
		["Snow"] = 160,
		["Jungle"] = 140,
		["Desert"] = 130,
		["Lake"] = 125,
		["Forest"] = 125,
	}
	local L = -360
	local E = 525
	local b = 620
	local A = 130
	local S = CFrame.new(4773.7587890625, 70.392112731934, -315.73501586914)

	local Z = "CloutHub_FlightSpeed.txt"
	local z = "CloutHub_EggSelectConfig.json"
	local d = {
		["Light Dark"] = Color3.fromRGB(168, 85, 247),
		["Titan Temple"] = Color3.fromRGB(245, 158, 11),
		["Cherry Blossom"] = Color3.fromRGB(236, 72, 153),
		["Cosmic"] = Color3.fromRGB(6, 182, 212),
		["Prehistoric"] = Color3.fromRGB(16, 185, 129),
		["Abyss Ocean"] = Color3.fromRGB(59, 130, 246),
		["Volcano"] = Color3.fromRGB(239, 68, 68),
		["Snow"] = Color3.fromRGB(147, 197, 253),
		["Jungle"] = Color3.fromRGB(34, 197, 94),
		["Desert"] = Color3.fromRGB(234, 179, 8),
		["Lake"] = Color3.fromRGB(20, 184, 166),
		["Forest"] = Color3.fromRGB(22, 163, 74),
	}

	local X = { "Divine", "Eternal", "Secret", "Cosmic", "Mythic", "Legendary", "Epic", "Rare", "Uncommon", "Common" }
	local G = {
		["Divine"] = Color3.fromRGB(244, 63, 94),
		["Eternal"] = Color3.fromRGB(217, 70, 239),
		["Secret"] = Color3.fromRGB(249, 115, 22),
		["Cosmic"] = Color3.fromRGB(6, 182, 212),
		["Mythic"] = Color3.fromRGB(139, 92, 246),
		["Legendary"] = Color3.fromRGB(251, 191, 36),
		["Epic"] = Color3.fromRGB(168, 85, 247),
		["Rare"] = Color3.fromRGB(59, 130, 246),
		["Uncommon"] = Color3.fromRGB(34, 197, 94),
		["Common"] = Color3.fromRGB(148, 163, 184),
	}
	local F = {
		["Divine"] = 6,
		["Eternal"] = 5,
		["Secret"] = 4,
		["Cosmic"] = 3,
		["Mythic"] = 2,
		["Legendary"] = 1,
		["Epic"] = 0.5,
		["Rare"] = 0.3,
		["Uncommon"] = 0.1,
		["Common"] = 0,
	}
	
	local h
	local h
	local function loadSavedGlideSpeed(...)
		local e = 500
		pcall(function(...)
			local r = false
			if isfile then
				r = isfile(Z)
			elseif readfile then
				local e, y = pcall(readfile, Z)
				r = e and (y ~= nil)
			end
			if r and readfile then
				local r = readfile(Z)
				local u = tonumber(r)
				if u and (u >= 100 and u <= 1000) then
					e = math.floor(u)
				end
			end
		end)
		return e
	end
	local function Y(e, ...)
		pcall(function(...)
			if writefile then
				local y = math.clamp(math.floor(tonumber(e) or 600), 100, 1000)
				writefile(Z, tostring(y))
			end
		end)
	end
	local function loadConfig(...)
		local e = nil
		pcall(function(...)
			local r = false
			if isfile then
				r = isfile(z)
			elseif readfile then
				local e, y = pcall(readfile, z)
				r = e and (y ~= nil)
			end
			if r and (readfile and a) then
				local r = readfile(z)
				if r and r ~= "" then
					local u = a:JSONDecode(r)
					if type(u) == "table" then
						e = u
					end
				end
			end
		end)
		local r = {
			["Light Dark"] = true,
			["Titan Temple"] = true,
			["Cherry Blossom"] = true,
			["Cosmic"] = false,
			["Prehistoric"] = false,
			["Abyss Ocean"] = false,
			["Volcano"] = false,
			["Snow"] = false,
			["Jungle"] = false,
			["Desert"] = false,
			["Lake"] = false,
			["Forest"] = false,
		}
		local y = {
			["Divine"] = true,
			["Eternal"] = true,
			["Secret"] = true,
			["Cosmic"] = true,
			["Mythic"] = true,
			["Legendary"] = false,
			["Epic"] = false,
			["Rare"] = false,
			["Uncommon"] = false,
			["Common"] = false,
		}
		if type(e) ~= "table" then
			e = {
				["selectedZones"] = r,
				["selectedRarities"] = y,
				["alwaysCollectSecretPlus"] = true,
				["minRarityTier"] = 2,
				["autoTreadmill"] = true,
				["autoUpgradeTreadmill"] = true,
				["autoBuyTrails"] = true,
				["hideNotEnoughMoney"] = true,
				["performanceMode"] = false,
				["disable3D"] = false,
				["antiAFK"] = true,
				["language"] = "EN",
			}
		else
			if type(e.selectedZones) ~= "table" then
				e.selectedZones = r
			end
			if type(e.selectedRarities) ~= "table" then
				e.selectedRarities = y
			else
				for r, w in ipairs(X) do
					if e.selectedRarities[w] == nil then
						e.selectedRarities[w] = (y[w] == true)
					end
				end
			end
			if e.alwaysCollectSecretPlus == nil then
				e.alwaysCollectSecretPlus = true
			end
			if e.minRarityTier == nil then
				e.minRarityTier = 2
			end
			if e.autoTreadmill == nil then
				e.autoTreadmill = true
			end
			if e.autoUpgradeTreadmill == nil then
				e.autoUpgradeTreadmill = true
			end
			if e.autoBuyTrails == nil then
				e.autoBuyTrails = true
			end
			if e.hideNotEnoughMoney == nil then
				e.hideNotEnoughMoney = true
			end
			if e.performanceMode == nil then
				e.performanceMode = false
			end
			if e.disable3D == nil then
				e.disable3D = false
			end
			if e.antiAFK == nil then
				e.antiAFK = true
			end
			if e.language and (e.language == "EN" or e.language == "TH") then
				currentLang = e.language
			end
		end
		return e
	end
	local function x(...)
		pcall(function(...)
			if writefile and (a and h) then
				local r = {
					["selectedZones"] = h.selectedZones or {},
					["selectedRarities"] = h.selectedRarities or {},
					["alwaysCollectSecretPlus"] = (h.alwaysCollectSecretPlus ~= false),
					["minRarityTier"] = h.minRarityTier or 2,
					["autoTreadmill"] = (h.autoTreadmill == true),
					["autoUpgradeTreadmill"] = (h.autoUpgradeTreadmill == true),
					["autoBuyTrails"] = (h.autoBuyTrails == true),
					["hideNotEnoughMoney"] = (h.hideNotEnoughMoney == true),
					["performanceMode"] = (h.performanceMode == true),
					["disable3D"] = (h.disable3D == true),
					["antiAFK"] = (h.antiAFK == true),
					["eggESP"] = (h.eggESP == true),
					["trapESP"] = (h.trapESP == true),
					["playerESP"] = (h.playerESP == true),
					["espMaxStuds"] = h.espMaxStuds or 8000,
					["antiTrap"] = (h.antiTrap ~= false),
					["fullbright"] = (h.fullbright == true),
					["autoClaimRewards"] = (h.autoClaimRewards == true),
					["autoEquipBest"] = (h.autoEquipBest == true),
					["autoSellJunk"] = (h.autoSellJunk == true),
					["bossJoin"] = (h.bossJoin == true),
					["bossFight"] = (h.bossFight == true),
					["bossClaim"] = (h.bossClaim == true),
					["bossHazard"] = (h.bossHazard == true),
					["autoHatch"] = (h.autoHatch == true),
					["autoGlide"] = (h.autoGlide == true),
					["autoPlaceEvery5"] = (h.autoPlaceEvery5 == true),
					["humanize"] = (h.humanize == true),
					["sniper"] = (h.sniper == true),
					["snipeGrab"] = (h.snipeGrab == true),
					["snipeMaxStuds"] = (tonumber(h.snipeMaxStuds) or 2000),
					["webhookUrl"] = (type(h.webhookUrl) == "string" and h.webhookUrl or ""),
					["whSnipe"] = (h.whSnipe ~= false),
					["whSteal"] = (h.whSteal == true),
					["theme"] = (type(h.theme) == "string" and h.theme or "Dark"),
					["keybindsOn"] = (h.keybindsOn ~= false),
					["profSlot"] = (type(h.profSlot) == "string" and h.profSlot or "Slot 1"),
					["kb1Action"] = (type(h.kb1Action) == "string" and h.kb1Action or "None"),
					["kb1Key"] = (type(h.kb1Key) == "string" and h.kb1Key or "F"),
					["kb2Action"] = (type(h.kb2Action) == "string" and h.kb2Action or "None"),
					["kb2Key"] = (type(h.kb2Key) == "string" and h.kb2Key or "G"),
					["cfgAutoLoad"] = (h.cfgAutoLoad ~= false),
					["cfgAutoSave"] = (h.cfgAutoSave ~= false),
					["whBoss"] = (h.whBoss == true),
					["whHaul"] = (h.whHaul == true),
					["whUnload"] = (h.whUnload == true),
					["sellMaxRarity"] = (tonumber(h.sellMaxRarity) or 6),
					["sellKeep"] = (type(h.sellKeep) == "string" and h.sellKeep or ""),
					["stealMinIncome"] = (tonumber(h.stealMinIncome) or 0),
					["stealMuts"] = (type(h.stealMuts) == "string" and h.stealMuts or ""),
					["sellIncomeBelow"] = (tonumber(h.sellIncomeBelow) or 0),
					["sellKeepMut"] = (type(h.sellKeepMut) == "string" and h.sellKeepMut or ""),
					["whStealMinIncome"] = (tonumber(h.whStealMinIncome) or 0),
					["whStealMuts"] = (type(h.whStealMuts) == "string" and h.whStealMuts or ""),
					["whStealRarities"] = (type(h.whStealRarities) == "table" and h.whStealRarities or {}),
					["autoTreadmill"] = (h.autoTreadmill == true),
					["fastCycle"] = true,
					["panicAuto"] = (h.panicAuto == true),
					["panicNames"] = (type(h.panicNames) == "string" and h.panicNames or ""),
					["whPanic"] = (h.whPanic ~= false),
					["webhookPing"] = (type(h.webhookPing) == "string" and h.webhookPing or ""),
					["antiStaff"] = (h.antiStaff == true),
					["staffMinRank"] = (tonumber(h.staffMinRank) or 250),
					["language"] = currentLang or "EN",
				}
				local y = a:JSONEncode(r)
				writefile(z, y)
			end
		end)
	end
	local W = loadConfig()
	h = {
		["godmode"] = true,
		["autoGlide"] = true,
		["autoHatch"] = true,
		["autoPlaceEvery5"] = false,
		["batchStealCount"] = 0,
		["isBatchPlacing"] = false,
		["isHatching"] = false,
		["autoFarmLoop"] = false,
		["pureTweenFarm"] = false,
		["glidingToTarget"] = false,
		["securingEgg"] = false,
		["glideSpeed"] = loadSavedGlideSpeed(),
		["selectedZones"] = W.selectedZones,
		["selectedRarities"] = W.selectedRarities,
		["alwaysCollectSecretPlus"] = W.alwaysCollectSecretPlus,
		["minRarityTier"] = W.minRarityTier,
		["autoTreadmill"] = (W.autoTreadmill ~= false),
		["autoUpgradeTreadmill"] = (W.autoUpgradeTreadmill ~= false),
		["autoBuyTrails"] = (W.autoBuyTrails ~= false),
		["hideNotEnoughMoney"] = true,
		["performanceMode"] = (W.performanceMode == true),
		["disable3D"] = (W.disable3D == true),
		["antiAFK"] = (W.antiAFK ~= false),
		["onTreadmill"] = false,
		["lastTreadmillMount"] = 0,
		["laneZ"] = -360,
		["swapped"] = false,
		["teleporting"] = false,
		["isReturning"] = false,
		["delivering"] = false,
		["holdingEggForGuard"] = false,
		["currentTargetModel"] = nil,
		["targetPosition"] = nil,
		["stateTime"] = os.clock(),
		["statusText"] = "Ready",
		["bestEggInfo"] = "Scanning...",
		["gui"] = nil,
		["alive"] = true,
		["plot"] = nil,
		["pen"] = nil,
		["origin"] = nil,
		["tread"] = nil,
	}
	if type(W) == "table" and (W.cfgAutoLoad ~= false) then
		h.autoHatch = (W.autoHatch ~= false)
		h.autoGlide = (W.autoGlide ~= false)
		h.autoPlaceEvery5 = (W.autoPlaceEvery5 == true)
		h.eggESP = (W.eggESP == true)
		h.trapESP = (W.trapESP == true)
		h.playerESP = (W.playerESP == true)
		h.espMaxStuds = (tonumber(W.espMaxStuds) or 8000)
		h.antiTrap = (W.antiTrap ~= false)
		h.fullbright = (W.fullbright == true)
		h.autoClaimRewards = (W.autoClaimRewards == true)
		h.autoEquipBest = (W.autoEquipBest == true)
		h.autoSellJunk = (W.autoSellJunk == true)
		h.bossJoin = (W.bossJoin == true)
		h.bossFight = (W.bossFight == true)
		h.bossClaim = (W.bossClaim == true)
		h.bossHazard = (W.bossHazard == true)
		h.humanize = (W.humanize == true)
		h.sniper = (W.sniper == true)
		h.snipeGrab = (W.snipeGrab == true)
		h.snipeMaxStuds = (tonumber(W.snipeMaxStuds) or 2000)
		h.theme = (type(W.theme) == "string" and W.theme or "Dark")
		h.webhookUrl = (type(W.webhookUrl) == "string" and W.webhookUrl or "")
		h.whSnipe = (W.whSnipe ~= false)
		h.whSteal = (W.whSteal == true)
		h.keybindsOn = (W.keybindsOn ~= false)
		h.profSlot = (type(W.profSlot) == "string" and W.profSlot or "Slot 1")
		h.kb1Action = (type(W.kb1Action) == "string" and W.kb1Action or "None")
		h.kb1Key = (type(W.kb1Key) == "string" and W.kb1Key or "F")
		h.kb2Action = (type(W.kb2Action) == "string" and W.kb2Action or "None")
		h.kb2Key = (type(W.kb2Key) == "string" and W.kb2Key or "G")
		h.cfgAutoLoad = (W.cfgAutoLoad ~= false)
		h.cfgAutoSave = (W.cfgAutoSave ~= false)
		h.whBoss = (W.whBoss == true)
		h.whHaul = (W.whHaul == true)
		h.whUnload = (W.whUnload == true)
		h.sellMaxRarity = (tonumber(W.sellMaxRarity) or 6)
		h.sellKeep = (type(W.sellKeep) == "string" and W.sellKeep or "")
		h.stealMinIncome = (tonumber(W.stealMinIncome) or 0)
		h.stealMuts = (type(W.stealMuts) == "string" and W.stealMuts or "")
		h.sellIncomeBelow = (tonumber(W.sellIncomeBelow) or 0)
		h.sellKeepMut = (type(W.sellKeepMut) == "string" and W.sellKeepMut or "")
		h.whStealMinIncome = (tonumber(W.whStealMinIncome) or 0)
		h.whStealMuts = (type(W.whStealMuts) == "string" and W.whStealMuts or "")
		h.whStealRarities = (type(W.whStealRarities) == "table" and W.whStealRarities or {})
		h.fastCycle = true
		h.autoRegrab = true
		h.fastStealSpeedBoost = true
		h.panicAuto = (W.panicAuto == true)
		h.panicNames = (type(W.panicNames) == "string" and W.panicNames or "")
		h.whPanic = (W.whPanic ~= false)
		h.webhookPing = (type(W.webhookPing) == "string" and W.webhookPing or "")
		h.antiStaff = (W.antiStaff == true)
		h.staffMinRank = (tonumber(W.staffMinRank) or 250)
	end
	h.fastCycle = true
	h.autoRegrab = true
	h.glideSpeed = math.max(h.glideSpeed or 600, 650)
	h.statsStart = os.clock()
	h.statsSteals = 0
	h._stealFails = 0
	h._regrabFails = 0
	h.statsSnipes = 0
	h.statsSold = 0
	h.statsClaims = 0
	h.statsRarity = {}
	h.statsSoldRarity = {}
	h.logLines = {}
	
	h._adsEnabled = true
	task.spawn(function()
		while h.alive do
			task.wait(300)
			if h._adsEnabled and h.alive then
				pcall(function()
					if Window and Window.Notify then
						
						pcall(function()
							local uiLib = CloutWindLib or Window
							if uiLib and uiLib.Notify then
								uiLib:Notify({Title="CloutHub - Discord", Content="discord.gg/cyDpbvxeGN - Bug? report on Discord", Duration=4, Icon="info"})
							end
						end)
					end
					
					pcall(function()
						game:GetService("StarterGui"):SetCore("SendNotification", {Title="CloutHub | SAE | KEYLESS", Text="discord.gg/cyDpbvxeGN", Duration=3})
					end)
				end)
				
			
			end
		end
	end)
	
	local w4, j4, h4, d4 -- declared here (they were declared further down, after AutoRegrab already used them)
	h.currentTargetUid = nil
	task.spawn(function()
		while h.alive do
			task.wait(0.10)
			pcall(function()
				if not h.autoRegrab then return end
				if w4() then return end
				if not h4 then return end
				local char = o.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if not hrp then return end
				local recs = h4(false)
				if not recs or #recs==0 then return end
				local best, bestD = nil, 26
				for _, rec in ipairs(recs) do
					local isDropped = (rec.State=="Dropped" or rec.State==1 or rec.State=="Slot")
					if isDropped and rec.BoundsCFrame then
						local d = (hrp.Position - rec.BoundsCFrame.Position).Magnitude
						if d < bestD then
							
							local prefer = true
							if h.currentTargetUid and rec.Uid ~= h.currentTargetUid and d > 14 then
								prefer = false
							end
							if prefer then
								best = rec
								bestD = d
							end
						end
					end
				end
				if best then
					h.statusText = "[AutoRegrab] Egg dropped! Re-grabbing... ("..tostring(best.Uid):sub(1,6)..") dist "..math.floor(bestD)
					local model = best.PhysicalModel
					if not model and r:FindFirstChild("AreaEggSlotsClient") then
						for _, m in ipairs(r.AreaEggSlotsClient:GetChildren()) do
							local mp = m:FindFirstChildWhichIsA("BasePart") or m.PrimaryPart
							if mp and (mp.Position - best.BoundsCFrame.Position).Magnitude < 14 then
								model = m
								break
							end
						end
					end
					for attempt=1,4 do
						d4(model, best.BoundsCFrame.Position)
						if i and best.Uid then
							pcall(function()
								if i:IsA("RemoteFunction") then
									i:InvokeServer({Uid=best.Uid})
									i:InvokeServer(best.Uid)
								else
									i:FireServer({Uid=best.Uid})
									i:FireServer(best.Uid)
								end
							end)
						end
						task.wait(0.035)
						if w4(best.Uid) or j4(best.Uid) then
							h.statusText = "[AutoRegrab] [OK] Re-grabbed! ("..tostring(best.Uid):sub(1,6)..")"
							if best.Uid == h.currentTargetUid then h.currentTargetUid=nil end
							break
						end
					end
					h._regrabFails = (h._regrabFails or 0) + ((w4(best.Uid) or j4(best.Uid)) and 0 or 1)
					if not w4(best.Uid) and not j4(best.Uid) then
						h.statusText = "[AutoRegrab] Gagal ("..tostring(h._regrabFails).."/3)"
						if (h._regrabFails or 0) >= 3 then
							h._regrabFails = 0
							h.statusText = "[AutoRegrab] 3x gagal - auto turunin"
							pcall(function()
								local char = o.Character
								local hrp = char and char:FindFirstChild("HumanoidRootPart")
								if hrp then hrp.CFrame = hrp.CFrame - Vector3.new(0, 4, 0) end
								h.currentTargetUid = nil
								task.wait(0.6)
							end)
						end
					else
						h._regrabFails = 0
					end
				end
			end)
		end
	end)
	

	h.execName = "Unknown"
	pcall(function(...)
		local e = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname())
		if type(e) == "string" and e ~= "" then
			h.execName = e
		end
	end)
	local m
	local e4
	local r4
	local y4
	local u4
	local k4
	local a4
	local o4
	local V4
	local H4
	local t4
	local s4
	local p4
	local B4
	local J4
	local K4
	local c4
	local v4
	local i4
	local R4
	local g4
	local Q4
	local P4
	local N4
	local U4
	local l4
	local D4
	local C4
	local q4
	local n4
	local f4
	local M4
	local I4
	local L4
	local E4
	local b4, A4, S4, Z4, z4
	local X4 = {}
	local G4 = 0
	local F4 = nil
	local O4 = 0
	local Y4 = "NONE"
	local T4
	local x4 = nil
	local W4 = nil
	local godToggleSetter = nil
	pcall(function(...)
		local e = game:GetService("Lighting");
		(e:GetPropertyChangedSignal("ClockTime")):Connect(function(...)
			X4 = {}
			G4 = 0
		end)
	end)
	pcall(function(...)
		local function e(e, ...)
			if e:IsA("RemoteEvent") then
				local y = string.lower(e.Name)
				if
					string.find(y, "reset")
					or string.find(y, "night")
					or string.find(y, "spawn")
					or string.find(y, "countdown")
				then
					pcall(function(...)
						e.OnClientEvent:Connect(function(...)
							X4 = {}
							G4 = 0
						end)
					end)
				end
			end
		end
		for y, u in ipairs(j:GetDescendants()) do
			e(u)
		end
		j.DescendantAdded:Connect(e)
	end)
	m = function(e, ...)
		if not e or not e:IsA("Tool") then
			return false
		end
		local r = string.lower(e.Name)
		if
			string.find(r, "sword")
			or string.find(r, "radar")
			or string.find(r, "basket")
			or string.find(r, "punch")
		then
			return false
		end
		if
			e:GetAttribute("EggUid")
			or e:GetAttribute("UID")
			or string.find(r, "egg")
			or e:GetAttribute("Category")
			or e:GetAttribute("ItemType") == "Egg"
		then
			return true
		end
		return false
	end
	e4 = function(...)
		local e = o.Character
		if e then
			for e, y in ipairs(e:GetChildren()) do
				if m(y) then
					local e = y:GetAttribute("UID") or y:GetAttribute("EggUid")
					return y, e or y.Name
				end
			end
		end
		return nil, nil
	end
	r4 = function(...)
		local e = o:FindFirstChild("Backpack")
		if e then
			for e, y in ipairs(e:GetChildren()) do
				if m(y) then
					local e = y:GetAttribute("UID") or y:GetAttribute("EggUid")
					return y, e or y.Name
				end
			end
		end
		return nil, nil
	end
	y4 = function(...)
		local e = 0
		local r = o:FindFirstChild("Backpack")
		if r then
			for r, y in ipairs(r:GetChildren()) do
				if m(y) then
					e = e + 1
				end
			end
		end
		local y = o.Character
		if y then
			for r, y in ipairs(y:GetChildren()) do
				if m(y) then
					e = e + 1
				end
			end
		end
		return e
	end
	u4 = function(e, ...)
		if not e and not (h.pureTweenFarm or h.autoFarmLoop or h.teleporting) then
			return
		end
		local r = o.Character
		local y = r and r:FindFirstChildOfClass("Humanoid")
		local u = o:FindFirstChild("Backpack")
		if y then
			pcall(function(...)
				y:UnequipTools()
			end)
		end
		if r and u then
			for e, r in ipairs(r:GetChildren()) do
				if r:IsA("Tool") then
					pcall(function(...)
						r.Parent = u
					end)
				end
			end
		end
	end
	w4 = function(e, ...)
		if (h.pureTweenFarm or h.autoFarmLoop) and not h.holdingEggForGuard then
			local e = e4()
			if e then
				pcall(u4)
			end
			return false
		end
		local r, y = e4()
		if r then
			if e then
				if y == e or not y then
					return true
				end
			else
				return true
			end
		end
		local u = o.Character
		local w = u and u:FindFirstChild("HumanoidRootPart")
		if w and w.Position.X <= (E + 15) then
			return false
		end
		if s and s.ReadFieldEggs then
			local r, y = pcall(s.ReadFieldEggs)
			if r and (y and y.Records) then
				for r, y in ipairs(y.Records) do
					if
						(y.State == "Carried" or y.State == 2) and (
							y.CarrierUserId == o.UserId or y.Carrier == o.UserId
						)
					then
						if e then
							if y.Uid == e then
								return true
							end
						else
							return true
						end
					end
				end
			end
		end
		return false
	end
	j4 = function(e, ...)
		local r, y = e4()
		if r then
			if not e or y == e or not y then
				return true
			end
		end
		local u = o:FindFirstChild("Backpack")
		if u then
			for r, y in ipairs(u:GetChildren()) do
				if m(y) then
					local r = y:GetAttribute("UID") or y:GetAttribute("EggUid")
					if not e or r == e or y.Name == tostring(e) then
						return true
					end
				end
			end
		end
		if e and (s and s.ReadFieldEggs) then
			local r, y = pcall(s.ReadFieldEggs)
			if r and (y and y.Records) then
				for r, y in ipairs(y.Records) do
					if y.Uid == e then
						if y.State == "Carried" or y.State == 2 then
							local e = y.CarrierUserId or y.Carrier
							if e == o.UserId then
								return true
							end
						end
					end
				end
			end
		end
		return false
	end
	local m4 = false
	local function ek(...)
		if m4 then
			return
		end
		local e = R
			or j:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot", true)
			or j:FindFirstChild("AskFieldEggSnapshot", true)
			or j:FindFirstChild("Eggs: RequestAreaEggSnapshot", true)
		if not e or not e:IsA("RemoteFunction") then
			return
		end
		m4 = true
		task.spawn(function(...)
			local r, y = pcall(function(...)
				return e:InvokeServer()
			end)
			if r and type(y) == "table" then
				local e = {}
				local r = y.Records or y
				if type(r) == "table" then
					for r, y in pairs(r) do
						if type(y) == "table" then
							if not y.Uid and type(r) == "string" then
								y.Uid = r
							end
							table.insert(e, y)
						end
					end
				end
				if #e > 0 then
					F4 = e
					G4 = os.clock()
				end
			end
			m4 = false
		end)
	end
	task.spawn(function(...)
		while true do
			task.wait(0.45)
			pcall(ek)
		end
	end)
	function h4(e, ...)
		local y = os.clock()
		if e or (y - G4 >= 1.5) or not F4 then
			ek()
		end
		local u = (F4 and #F4 > 0) and F4 or nil
		local w = nil
		if s and s.ReadFieldEggs then
			local e, r = pcall(s.ReadFieldEggs)
			if e and type(r) == "table" then
				local e = {}
				local y = r.Records or r
				if type(y) == "table" then
					for r, y in pairs(y) do
						if type(y) == "table" then
							if not y.Uid and type(r) == "string" then
								y.Uid = r
							end
							table.insert(e, y)
						end
					end
				end
				if #e > 0 then
					w = e
				end
			end
		end
		local j = {}
		local k = {}
		if u then
			for e, r in ipairs(u) do
				if r.Uid then
					k[r.Uid] = true
					table.insert(j, r)
				end
			end
		end
		if w then
			for e, r in ipairs(w) do
				if r.Uid and not k[r.Uid] then
					k[r.Uid] = true
					table.insert(j, r)
				end
			end
		end
		local a = r:FindFirstChild("AreaEggSlotsClient")
		if a then
			for e, r in ipairs(a:GetChildren()) do
				local y = r.Name
				if y and y ~= "" then
					local e = r:GetPivot()
					local u = e.Position
					if u.X >= 530 and not string.find(tostring(y), "FirstArea") then
						if not k[y] then
							k[y] = true
							local u = r:GetAttribute("Category") or r:GetAttribute("AssetCategory") or r.Name
							local w = r:GetAttribute("AreaId") or r:GetAttribute("Area")
							local a = r:GetAttribute("Rarity") or r:GetAttribute("RarityTier")
							local V = r:GetAttribute("RarityRank") or r:GetAttribute("Rank")
							local H = r:GetAttribute("Income") or r:GetAttribute("EarningRate")
							local t = r:GetAttribute("Scale") or r:GetAttribute("AssetScale") or 1
							local s = r:GetAttribute("Mutations") or r:GetAttribute("Mutation")
							table.insert(
								j,
								{
									["Uid"] = y,
									["AssetCategory"] = u,
									["AreaId"] = w,
									["Rarity"] = a,
									["Rank"] = V,
									["Income"] = H,
									["BoundsCFrame"] = e,
									["BottomCFrame"] = e,
									["CFrame"] = e,
									["State"] = "Slot",
									["AssetScale"] = t,
									["Mutations"] = s,
									["PhysicalModel"] = r,
								}
							)
						else
							for u, w in ipairs(j) do
								if w.Uid == y then
									w.PhysicalModel = r
									if not w.BoundsCFrame then
										w.BoundsCFrame = e
									end
									if not w.AreaId or w.AreaId == "" or w.AreaId == "Unknown" then
										w.AreaId = r:GetAttribute("AreaId") or r:GetAttribute("Area")
									end
									break
								end
							end
						end
					end
				end
			end
		end
		return j
	end
	k4 = function(e, ...)
		if not e then
			return false, "NoUid"
		end
		local y = h4(false)
		if y and #y > 0 then
			for r, y in ipairs(y) do
				if y.Uid == e then
					if y.State == "Carried" or y.State == 2 then
						local e = y.CarrierUserId or y.Carrier
						if e and e == o.UserId then
							return true, "CarriedBySelf"
						else
							return false, "CarriedByOther"
						end
					end
					if y.State == "Slot" or y.State == "Dropped" or y.State == "GuardCarried" or y.State == 1 then
						return true, "Available"
					end
					local e = y.CarrierUserId or y.Carrier
					if e then
						if e == o.UserId then
							return true, "CarriedBySelf"
						else
							return false, "CarriedByOther"
						end
					end
					return true, "Available"
				end
			end
		end
		local u = r:FindFirstChild("AreaEggSlotsClient")
		if u then
			for r, y in ipairs(u:GetChildren()) do
				if y.Name == tostring(e) or y:GetAttribute("UID") == e or y:GetAttribute("Uid") == e then
					return true, "Available"
				end
			end
		end
		return true, "Unchecked"
	end
	a4 = function(...)
		local e, r = e4()
		if not r then
			local e, y = r4()
			r = y
		end
		if not r then
			return false
		end
		if s and s.ReadFieldEggs then
			local e, u = pcall(s.ReadFieldEggs)
			if e and (u and u.Records) then
				for e, u in ipairs(u.Records) do
					if u.Uid == r then
						local e = tostring(u.AreaId or "")
						if e == "Lake" or string.find(string.lower(e), "lake") ~= nil then
							return true
						end
					end
				end
			end
		end
		if string.find(string.lower(tostring(r)), "lake") ~= nil then
			return true
		end
		return false
	end
	o4 = function(...)
		local e, r = e4()
		if not r then
			local e, y = r4()
			r = y
		end
		if not r then
			return h.glideSpeed or 350
		end
		if s and s.ReadFieldEggs then
			local e, u = pcall(s.ReadFieldEggs)
			if e and (u and u.Records) then
				for e, u in ipairs(u.Records) do
					if u.Uid == r and u.AreaId then
						return I[u.AreaId] or h.glideSpeed or 350
					end
				end
			end
		end
		return h.glideSpeed or 350
	end
	V4 = function(e, y, ...)
		y = y or 8
		local u = Instance.new("Part")
		u.Name = "SafetyFloorPad_AntiVoid"
		u.Size = Vector3.new(28, 1.5, 28)
		u.Position = e - Vector3.new(0, 3.2, 0)
		u.Anchored = true
		u.Transparency = 1
		u.CanCollide = true
		u.Parent = r
		task.delay(y, function(...)
			pcall(function(...)
				u:Destroy()
			end)
		end)
		return u
	end
	H4 = function(e, ...)
		if P and e then
			pcall(function(...)
				local r = o.Character
				local y = r and r:FindFirstChild("HumanoidRootPart")
				local u = y and (y.CFrame * CFrame.new(0, 0, -3)) or CFrame.new()
				if P:IsA("RemoteFunction") then
					P:InvokeServer({ ["EggUid"] = e, ["GuardCFrame"] = u })
				else
					P:FireServer({ ["EggUid"] = e, ["GuardCFrame"] = u })
				end
			end)
		end
	end
	if typeof(hookmetamethod) == "function" and not _G._DesyncAntiRagdollHooked then
		_G._DesyncAntiRagdollHooked = true
		local e
		e = hookmetamethod(
			game,
			"__newindex",
			safeNewCClosure(function(r, y, u, ...)
				if not executorCheckCaller() and typeof(r) == "Instance" then
					if r:IsA("Motor6D") and (y == "Enabled" and u == false) then
						return nil
					end
					if r:IsA("Humanoid") then
						if y == "PlatformStand" and u == true then
							return nil
						end
						if
							y == "Sit"
							and (
								u == true and (h.pureTweenFarm or h.autoFarmLoop or h.isReturning or h.glidingToTarget)
							)
						then
							return nil
						end
					end
				end
				return e(r, y, u)
			end)
		)
	end
	S4 = function(e, ...)
		e = e or o.Character
		if not e then
			return
		end
		local r = e:FindFirstChild("HumanoidRootPart")
		local y = e:FindFirstChild("Torso") or e:FindFirstChild("UpperTorso") or r
		if not y then
			return
		end
		for e, r in ipairs(e:GetDescendants()) do
			if r:IsA("BallSocketConstraint") or r:IsA("HingeConstraint") or r:IsA("NoCollisionConstraint") then
				pcall(function(...)
					r:Destroy()
				end)
			end
		end
		for e, r in ipairs(e:GetDescendants()) do
			if r:IsA("Motor6D") and (r.Part0 and r.Part1) then
				r.Enabled = true
				local e = "RigidJointWeld_" .. r.Name
				local y = r.Part1:FindFirstChild(e)
				if not y then
					local y = Instance.new("WeldConstraint")
					y.Name = e
					y.Part0 = r.Part0
					y.Part1 = r.Part1
					y.Parent = r.Part1
				end
			end
		end
	end
	Z4 = function(e, ...)
		if h and h.onTreadmill then
			return
		end
		e = e or o.Character
		if not e then
			return
		end
		local r = e:FindFirstChildOfClass("Humanoid")
		if r then
			r:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			r:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			r:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
			r:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
			r:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			if r.PlatformStand then
				r.PlatformStand = false
			end
			if r.Sit then
				r.Sit = false
			end
		end
		for e, r in ipairs(e:GetDescendants()) do
			if
				r:IsA("LocalScript")
				and (string.find(string.lower(r.Name), "ragdoll") or string.find(string.lower(r.Name), "fall"))
			then
				r.Disabled = true
			end
		end
		S4(e)
	end
	z4 = function(e, ...)
		if not e then
			return
		end
		Z4(e)
		for e, y in ipairs(e:GetDescendants()) do
			if y:IsA("Motor6D") then
				(y:GetPropertyChangedSignal("Enabled")):Connect(function(...)
					if not y.Enabled then
						y.Enabled = true
					end
				end)
			end
		end
		e.DescendantAdded:Connect(function(y, ...)
			if y:IsA("BallSocketConstraint") or y:IsA("HingeConstraint") or y:IsA("NoCollisionConstraint") then
				task.defer(function(...)
					pcall(function(...)
						y:Destroy()
					end)
					Z4(e)
				end)
			elseif
				y:IsA("LocalScript")
				and (string.find(string.lower(y.Name), "ragdoll") or string.find(string.lower(y.Name), "fall"))
			then
				y.Disabled = true
			end
		end)
		e.ChildAdded:Connect(function(e, ...)
			if e:IsA("Tool") and ((h.pureTweenFarm or h.autoFarmLoop) and not h.holdingEggForGuard) then
				task.defer(function(...)
					u4()
				end)
			end
		end)
	end
	C4 = function(...)
		if h then
			h.onTreadmill = false
		end
		local e = o.Character
		local r = e and e:FindFirstChildOfClass("Humanoid")
		local y = e and e:FindFirstChild("HumanoidRootPart")
		if U then
			task.spawn(function(...)
				pcall(function(...)
					U:InvokeServer()
				end)
			end)
		end
		if r then
			pcall(function(...)
				for r, y in ipairs(r:GetPlayingAnimationTracks()) do
					local u = y.Animation
					local w = u and u.AnimationId or ""
					if
						string.find(w, "10921259953")
						or string.find(string.lower(y.Name), "treadmill")
						or string.find(string.lower(y.Name), "run")
					then
						y:Stop(0)
					end
				end
				r.PlatformStand = false
				r.Sit = false
				r:SetStateEnabled(Enum.HumanoidStateType.Running, true)
				r:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				r:ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
		local u = o:FindFirstChild("PlayerGui")
		if u then
			local e = u:FindFirstChild("SpeedGainAnimation")
			if e then
				pcall(function(...)
					e:Destroy()
				end)
			end
		end
		if y then
			y.AssemblyLinearVelocity = Vector3.zero
			y.AssemblyAngularVelocity = Vector3.zero
		end
		Z4(e)
	end
	local rk = 0
	local yk = false
	E4 = function(...)
		local e = o:FindFirstChild("PlayerGui")
		if not e then
			return false
		end
		local r = false
		pcall(function(...)
			for e, u in ipairs(e:GetChildren()) do
				if u:IsA("ScreenGui") and u.Enabled then
					for e, u in ipairs(u:GetDescendants()) do
						if (u:IsA("TextButton") or u:IsA("ImageButton")) and u.Visible then
							local e = (u:IsA("TextButton") and u.Text) or u.Name
							local w = string.lower(e or "")
							if
								string.find(w, "get out")
								or string.find(w, "treadmill")
								or string.find(w, "doff")
								or string.find(w, "leave")
								or string.find(w, "exit")
							then
								if typeof(firesignal) == "function" and u.Activated then
									pcall(firesignal, u.Activated)
								elseif typeof(firesignal) == "function" and u.MouseButton1Click then
									pcall(firesignal, u.MouseButton1Click)
								elseif typeof(getconnections) == "function" then
									local e = getconnections(u.MouseButton1Click) or getconnections(u.Activated) or {}
									for e, r in ipairs(e) do
										pcall(function(...)
											r:Fire()
										end)
										break
									end
								end
								r = true
								break
							end
						end
					end
					if r then
						break
					end
				end
			end
		end)
		return r
	end
	L4 = function(...)
		local e = o.Character
		local r = e and e:FindFirstChild("HumanoidRootPart")
		if not r then
			return false
		end
		local y = (typeof(I4) == "function") and I4() or nil
		if y then
			local e = y.Position + Vector3.new(0, 1.8, 0)
			local u = ((r.Position - e)).Magnitude
			if u > 6 then
				if h then
					h.onTreadmill = false
				end
				return false
			end
		else
			if r.Position.X > 535 then
				if h then
					h.onTreadmill = false
				end
				return false
			end
		end
		if h and h.onTreadmill then
			return true
		end
		local u = e and e:FindFirstChildOfClass("Humanoid")
		if u then
			for e, r in ipairs(u:GetPlayingAnimationTracks()) do
				local y = r.Animation
				local u = y and y.AnimationId or ""
				local w = string.lower(r.Name or "")
				if string.find(u, "10921259953") or string.find(w, "treadmill") or string.find(w, "run") then
					return true
				end
			end
		end
		local w = o:FindFirstChild("PlayerGui")
		if w and w:FindFirstChild("SpeedGainAnimation") then
			return true
		end
		return false
	end
	M4 = function(...)
		if yk then
			return
		end
		if os.clock() - rk < 0.8 then
			if h then
				h.onTreadmill = false
			end
			return
		end
		yk = true
		rk = os.clock()
		if h then
			h.onTreadmill = false
		end
		E4()
		if U then
			pcall(function(...)
				U:InvokeServer()
			end)
		end
		local e = o.Character
		local r = e and e:FindFirstChildOfClass("Humanoid")
		local y = e and e:FindFirstChild("HumanoidRootPart")
		if r then
			pcall(function(...)
				for r, y in ipairs(r:GetPlayingAnimationTracks()) do
					local u = y.Animation
					local w = u and u.AnimationId or ""
					local j = string.lower(y.Name or "")
					if string.find(w, "10921259953") or string.find(j, "treadmill") or string.find(j, "run") then
						y:Stop(0)
					end
				end
				r.PlatformStand = false
				r.Sit = false
				r:SetStateEnabled(Enum.HumanoidStateType.Running, true)
				r:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				r:ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
		local u = o:FindFirstChild("PlayerGui")
		if u then
			local e = u:FindFirstChild("SpeedGainAnimation")
			if e then
				pcall(function(...)
					e:Destroy()
				end)
			end
		end
		if y then
			y.AssemblyLinearVelocity = Vector3.zero
			y.AssemblyAngularVelocity = Vector3.zero
		end
		Z4(e)
		task.wait(0.025)
		yk = false
	end
	q4 = M4
	n4 = function(...)
		pcall(function(...)
			local e = r:FindFirstChild("Plots")
			if e then
				local r = h and h.plot
				if not r and t4 then
					r = select(1, t4())
				end
				for e, u in ipairs(e:GetChildren()) do
					local w = (r ~= nil and u == r)
					local j = u:FindFirstChild("TreadmillBottom")
					if j and j:IsA("BasePart") then
						if w and (h and h.autoTreadmill) then
							j.CanTouch = true
							j.CanCollide = true
						else
							j.CanTouch = false
							j.CanCollide = false
						end
					end
					local k = u:FindFirstChild("TreadmillUpgrade")
					if k then
						for e, r in ipairs(k:GetDescendants()) do
							if r:IsA("BasePart") then
								if w and (h and h.autoTreadmill) then
									r.CanTouch = true
								else
									r.CanTouch = false
									r.CanCollide = false
								end
							end
						end
					end
				end
			end
		end)
	end
	n4()
	r.DescendantAdded:Connect(function(e, ...)
		pcall(function(...)
			local r = (e.Name == "TreadmillBottom" and e:IsA("BasePart"))
			local y = (e.Name == "TreadmillUpgrade" and e:IsA("Model"))
			if r or y then
				local y = h and h.plot
				if not y and t4 then
					y = select(1, t4())
				end
				local w = y and e:IsDescendantOf(y)
				if w and (h and h.autoTreadmill) then
					if r then
						e.CanTouch = true
						e.CanCollide = true
					else
						for e, r in ipairs(e:GetDescendants()) do
							if r:IsA("BasePart") then
								r.CanTouch = true
							end
						end
					end
				else
					if r then
						e.CanTouch = false
						e.CanCollide = false
					else
						for e, r in ipairs(e:GetDescendants()) do
							if r:IsA("BasePart") then
								r.CanTouch = false
								r.CanCollide = false
							end
						end
					end
				end
			end
		end)
	end)
	D4 = function(...)
		h.onTreadmill = false
		h.teleporting = false
		h.glidingToTarget = false
		h.securingEgg = false
		h.isReturning = false
		h.delivering = false
		h.holdingEggForGuard = false
		h.currentTargetModel = nil
		h.targetPosition = nil
		h.stateTime = os.clock()
		local e = o.Character
		local r = e and e:FindFirstChild("HumanoidRootPart")
		if r then
			pcall(function(...)
				r.Anchored = false
				r.AssemblyLinearVelocity = Vector3.zero
				r.AssemblyAngularVelocity = Vector3.zero
			end)
		end
		pcall(function(...)
			if C4 then
				C4()
			end
		end)
		pcall(function(...)
			if Z4 and e then
				Z4(e)
			end
		end)
		pcall(function(...)
			if u4 and (h.pureTweenFarm or h.autoFarmLoop) then
				u4()
			end
		end)
	end
	d4 = function(e, y, ...)
		if e then
			for e, r in ipairs(e:GetDescendants()) do
				if r:IsA("ProximityPrompt") then
					pcall(function(...)
						r.RequiresLineOfSight = false
						r.HoldDuration = 0
						if typeof(fireproximityprompt) == "function" then
							fireproximityprompt(r, 0)
							fireproximityprompt(r)
						end
					end)
				end
			end
		end
		local u = r:FindFirstChild("AreaEggSlotsClient")
		if u and y then
			for e, r in ipairs(u:GetChildren()) do
				local u = r:FindFirstChildWhichIsA("BasePart") or r.PrimaryPart
				if u and ((u.Position - y)).Magnitude <= 18 then
					for e, r in ipairs(r:GetDescendants()) do
						if r:IsA("ProximityPrompt") then
							pcall(function(...)
								r.RequiresLineOfSight = false
								r.HoldDuration = 0
								if typeof(fireproximityprompt) == "function" then
									fireproximityprompt(r, 0)
									fireproximityprompt(r)
								end
							end)
						end
					end
				end
			end
		end
	end
	b4 = function(e, ...)
		h.godmode = e
		local r = o.Character
		if not r then
			return
		end
		local y = r:FindFirstChildOfClass("Humanoid")
		if y then
			y:SetStateEnabled(Enum.HumanoidStateType.Dead, not e)
			if e and y.Health < 100 then
				y.Health = 100
			end
		end
		for r, y in ipairs(r:GetDescendants()) do
			if y:IsA("BasePart") then
				if e then
					y.CanTouch = false
					y.CanCollide = false
				end
			end
		end
		Z4(r)
	end
	local function enableDesyncGodmode()
		b4(true)
	end
	local function disableDesyncGodmode()
		b4(false)
	end

	A4 = function(...)
		local e = o.Character
		local y = e and e:FindFirstChildOfClass("Humanoid")
		if not e or not y then
			return false
		end
		pcall(function(...)
			y.BreakJointsOnDeath = false
			local w = y:Clone()
			w.Parent = e
			y:Destroy()
			local j = w:FindFirstChildOfClass("Animator")
			if not j then
				j = Instance.new("Animator")
				j.Parent = w
			end
			r.CurrentCamera.CameraSubject = w
			local k = e:FindFirstChild("Animate")
			if k and k:IsA("LocalScript") then
				k.Disabled = true
				task.defer(function(...)
					task.wait(0.008)
					k.Disabled = false
				end)
			end
			w:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			w:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			w:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			w:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			w.JumpPower = math.max(50, w.JumpPower)
			w.JumpHeight = math.max(7.2, w.JumpHeight)
			w:ChangeState(Enum.HumanoidStateType.Running)
		end)
		h.swapped = true
		if h.godmode then
			b4(true)
		end
		z4(e)
		return true
	end
	t4 = function(...)
		if h.plot and (h.plot.Parent and (h.pen and (h.origin and h.plotVerified))) then
			return h.plot, h.pen, h.origin
		end
		local e = r:FindFirstChild("Plots")
		if not e then
			return nil, nil, nil
		end
		local y = o.UserId
		local u = o.Name
		local w = o.DisplayName
		local j = nil
		local k = false
		if v then
			local r, w = pcall(function(...)
				return v:InvokeServer()
			end)
			if r and (type(w) == "table" and type(w.OwnersBySlot) == "table") then
				for r, w in pairs(w.OwnersBySlot) do
					if w == y or tostring(w) == tostring(y) or w == u then
						j = e:FindFirstChild(tostring(r))
						if j then
							k = true
							break
						end
					end
				end
			end
		end
		if not j and c then
			local r, u = pcall(function(...)
				return c:InvokeServer()
			end)
			if r and type(u) == "table" then
				for r, u in pairs(u) do
					if type(u) == "table" and (u.OwnerUserId == y or tostring(u.OwnerUserId) == tostring(y)) then
						local y = u.Slot or r
						j = e:FindFirstChild(tostring(y)) or e:FindFirstChild(tostring(r))
						if j then
							k = true
							break
						end
					end
				end
			end
		end
		if not j then
			for e, r in ipairs(e:GetChildren()) do
				local a = r:GetAttribute("Owner")
					or r:GetAttribute("OwnerUserId")
					or r:GetAttribute("UserId")
					or r:GetAttribute("OwnerId")
					or r:GetAttribute("Player")
				if a and (a == y or tostring(a) == tostring(y) or a == u or tostring(a) == u or a == w) then
					j = r
					k = true
					break
				end
				for e, a in ipairs({
					"Owner",
					"OwnerUserId",
					"OwnerId",
					"UserId",
					"Player",
					"PlayerName",
				}) do
					local o = r:FindFirstChild(a)
					if o and (o.Value == y or tostring(o.Value) == tostring(y) or o.Value == u or o.Value == w) then
						j = r
						k = true
						break
					end
				end
				if j then
					break
				end
			end
		end
		if not j then
			for e, r in ipairs(e:GetChildren()) do
				for e, y in ipairs(r:GetDescendants()) do
					if y:IsA("TextLabel") and y.Text ~= "" then
						local e = string.lower(y.Text)
						if
							string.find(e, string.lower(u), 1, true)
							or (w and string.find(e, string.lower(w), 1, true))
						then
							j = r
							k = true
							break
						end
					end
				end
				if j then
					break
				end
			end
		end
		if not j then
			local r = o.Character
			local y = r and r:FindFirstChild("HumanoidRootPart")
			if y and y.Position.X <= (E + 30) then
				local r = nil
				local u = 999999
				for e, w in ipairs(e:GetChildren()) do
					local j = w:FindFirstChild("CenterPoint") or w.PrimaryPart or w:FindFirstChildWhichIsA("BasePart")
					if j then
						local e = ((y.Position - j.Position)).Magnitude
						if e < u then
							u = e
							r = w
						end
					end
				end
				if r and u < 160 then
					j = r
				end
			end
		end
		if not j then
			j = e:FindFirstChild("2") or e:FindFirstChild("1") or (e:GetChildren())[1]
		end
		if not j then
			return nil, nil, nil
		end
		h.plot = j
		h.plotVerified = k
		h.origin = j:FindFirstChild("CenterPoint")
		local a = j:FindFirstChild("ToUpdate")
		h.pen = (a and a:FindFirstChild("PetArea")) or j:FindFirstChild("PetArea")
		h.tread = j:FindFirstChild("TreadmillBottom")
		if not h.pen and a then
			for e, r in ipairs(a:GetChildren()) do
				if r:IsA("BasePart") and string.find(string.lower(r.Name), "pet") then
					h.pen = r
					break
				end
			end
		end
		if not h.origin then
			h.origin = j:FindFirstChild("CenterPoint") or h.pen or j.PrimaryPart
		end
		if not h.pen then
			h.pen = h.origin
		end
		return h.plot, h.pen, h.origin
	end
	s4 = function(...)
		local e, r, y = t4()
		if r then
			return r.Position + Vector3.new(0, 3.5, 0)
		end
		if y then
			return y.Position + Vector3.new(0, 3.5, 0)
		end
		return Vector3.new(464.7, 71.7, -304)
	end
	p4 = function(e, ...)
		local r, y, u = t4()
		if not y then
			return nil
		end
		local w = y.Size
		local j = math.max(4, w.X / 2 - 5)
		local k = math.max(4, w.Z / 2 - 5)
		for r = 1, 60, 1 do
			local u = math.random(-math.floor(j), math.floor(j))
			local o = math.random(-math.floor(k), math.floor(k))
			local V = y.CFrame * CFrame.new(u, w.Y / 2 + 1, o)
			local H = true
			for e, r in ipairs(e) do
				if ((r - V.Position)).Magnitude < 5.5 then
					H = false
					break
				end
			end
			if H then
				return V
			end
		end
		return y.CFrame * CFrame.new(math.random(-8, 8), w.Y / 2 + 1, math.random(-8, 8))
	end
	B4 = function(...)
		local e, r, y = t4()
		if not y or not K then
			return 0
		end
		local u = 0
		local w = {}
		if c then
			local e, r = pcall(function(...)
				return c:InvokeServer()
			end)
			if e and type(r) == "table" then
				local e = {}
				for r, y in pairs(r) do
					if type(y) == "table" and y.OwnerUserId == o.UserId then
						for r, y in pairs(y.Records or {}) do
							e[r] = y
						end
					end
				end
				for e, r in pairs(e) do
					if r.Placement and r.Placement.LocalCFrame then
						w[#w + 1] = ((y.CFrame * r.Placement.LocalCFrame)).Position
					else
						local r = p4(w)
						if r then
							local j = y.CFrame:ToObjectSpace(r)
							local k, a = pcall(function(...)
								return K:InvokeServer({ ["Uid"] = e, ["LocalCFrame"] = j })
							end)
							if k and a then
								u = u + 1
								w[#w + 1] = r.Position
							end
						end
					end
				end
			end
		end
		local j = {}
		local k = o.Character
		if k then
			for e, r in ipairs(k:GetChildren()) do
				if m(r) then
					table.insert(j, r)
				end
			end
		end
		local a = o:FindFirstChild("Backpack")
		if a then
			for e, r in ipairs(a:GetChildren()) do
				if m(r) then
					table.insert(j, r)
				end
			end
		end
		for e, r in ipairs(j) do
			if not h.alive then
				break
			end
			local j = r:GetAttribute("UID") or r:GetAttribute("EggUid") or r.Name
			local k = p4(w)
			if k then
				local e = y.CFrame:ToObjectSpace(k)
				local r, a = pcall(function(...)
					return K:InvokeServer({ ["Uid"] = j, ["LocalCFrame"] = e })
				end)
				if r and a ~= false then
					u = u + 1
					w[#w + 1] = k.Position
					H(string.format("[PlaceEgg] Placed egg %s from inventory", tostring(j)))
				end
				task.wait(0.008)
			end
		end
		return u
	end
	J4 = function(e, ...)
		if (not e and not h.autoHatch) or not g or not Q or not c then
			return 0
		end
		if h.isHatching then
			return 0
		end
		h.isHatching = true
		local y, u = pcall(function(...)
			return c:InvokeServer()
		end)
		if not y or type(u) ~= "table" then
			return 0
		end
		local w = {}
		for e, r in pairs(u) do
			if type(r) == "table" and r.OwnerUserId == o.UserId then
				for e, r in pairs(r.Records or {}) do
					w[e] = r
				end
			end
		end
		local j = {}
		local k = r:GetServerTimeNow()
		for e, r in pairs(w) do
			if not h.alive then
				break
			end
			if r.Placement then
				local y = nil
				if s then
					local r = s.IsReadyToHatch or s.IsLocalEggReady
					if r then
						local u, w = pcall(r, e)
						if u and type(w) == "boolean" then
							y = w
						end
					end
				end
				if y == nil then
					local e = r.Placement.PlacedAt or r.Placement.Time or 0
					local u = 30
					if p and (p.Assets and p.Assets[r.AssetCategory]) then
						local e = p.Assets[r.AssetCategory]
						u = (e and (e.Egg and e.Egg.GrowthTime)) or 30
					end
					local w = u / math.max(0.01, r.GrowthSpeedMultiplier or 1)
					y = (k - e) >= w
				end
				if y then
					table.insert(j, { ["uid"] = e, ["category"] = r.AssetCategory or "Egg" })
				end
			end
		end
		if #j == 0 then
			h.isHatching = false
			return 0
		end
		H(string.format("[AutoHatch] Found %d eggs ready to hatch! Starting hatch sequence...", #j))
		h.statusText = string.format("[Hatch] Hatching %d ready eggs...", #j)
		local a = 0
		for e, r in ipairs(j) do
			task.spawn(function(...)
				local e, y = pcall(function(...)
					if g:IsA("RemoteFunction") then
						return g:InvokeServer(r.uid)
					else
						g:FireServer(r.uid)
						return true
					end
				end)
				if e and y ~= false then
					task.wait(0.12)
					local e, y = pcall(function(...)
						if Q:IsA("RemoteFunction") then
							return Q:InvokeServer(r.uid)
						else
							Q:FireServer(r.uid)
							return true
						end
					end)
					if e and y ~= false then
						a = a + 1
						h.hatched = (h.hatched or 0) + 1
						H(
							string.format(
								"[+] [AutoHatch] Hatched %s (UID: %s) -> Total Hatched: %d",
								r.category,
								tostring(r.uid),
								h.hatched
							)
						)
					end
				end
			end)
			task.wait(0.008)
		end
		task.wait(0.12)
		h.isHatching = false
		H(string.format("[AutoHatch] Finished! Hatched %d eggs.", a))
		return a
	end
	i4 = function(...)
		local e = {}
		local y = r:FindFirstChild("__DEBRIS")
		if y then
			for r, y in ipairs(y:GetChildren()) do
				local u = y:FindFirstChild("Hitbox")
				if u and u:IsA("BasePart") then
					table.insert(e, u)
				elseif y:IsA("BasePart") and string.find(y.Name:lower(), "hitbox") then
					table.insert(e, y)
				end
			end
		end
		local u = r:FindFirstChild("BossArenaTeleport")
		if u then
			local r = u:FindFirstChild("Hitbox") or u:FindFirstChildWhichIsA("BasePart") or (u:IsA("BasePart") and u)
			if r and r:IsA("BasePart") then
				table.insert(e, r)
			end
		end
		return e
	end
	g4 = function(e, r, u, ...)
		local w = o.Character
		local j = w and w:FindFirstChild("HumanoidRootPart")
		local k = w and w:FindFirstChildOfClass("Humanoid")
		if not j then
			return false
		end
		if k then
			k.AutoRotate = false
		end
		local a = s4()
		e = math.max(100, e or h.glideSpeed or 600)
		local V = h.laneZ or L
		h.isReturning = true
		h.stateTime = os.clock()
		V4(a, 20)
		j.AssemblyLinearVelocity = Vector3.zero
		j.AssemblyAngularVelocity = Vector3.zero
		local H = o4()
		local t = math.max(e, H)
		local s = os.clock() + 25
		while h.alive and (h.isReturning and os.clock() < s) do
			if r and O4 ~= r then
				if k then
					k.AutoRotate = true
				end
				h.isReturning = false
				return false
			end
			if not u and (not h.pureTweenFarm and not h.autoFarmLoop) then
				if k then
					k.AutoRotate = true
				end
				h.isReturning = false
				return false
			end
			local e = j.Position
			local w = ((a - e)).Magnitude
			if (e.X <= (a.X + 3) and math.abs(e.Z - a.Z) <= 8) or w <= 6 then
				break
			end
			local o = y.Heartbeat:Wait()
			e = j.Position
			local H = t
			if e.X <= b and e.X > E then
				local r = math.clamp((e.X - E) / (b - E), 0, 1)
				H = A + ((t - A) * r)
			elseif e.X <= E then
				H = A
			end
			if h.humanize then
				H = H * (0.88 + (math.random() * 0.24))
				if h.nearPlayer then
					H = H * 0.95
				end
			end
			local s = a.Z
			if e.X > 540 then
				s = V
			end
			local B = math.sign(a.X - e.X)
			local J = B * math.min(math.abs(a.X - e.X), H * o)
			local K = e.X + J
			local c = math.sign(a.Y - e.Y)
			local v = c * math.min(math.abs(a.Y - e.Y), (H * o) * 0.5)
			local i = e.Y + v
			if w > 25 and i < (a.Y + 12) then
				i = math.min((a.Y + 12), i + ((H * o) * 1.5))
			end
			local R = s - e.Z
			local g = math.sign(R) * math.min(math.abs(R), H * o)
			local Q = e.Z + g
			local P = i4()
			local N = false
			if e.X > E then
				for e, r in ipairs(P) do
					local y = r.Position
					local u = ((Vector3.new(K, i, Q) - y)).Magnitude
					local w = math.abs(K - y.X)
					local j = math.abs(Q - y.Z)
					if u < 22 or (w < 18 and j < 14) then
						N = true
						local e = y.Y + 16
						if i < e then
							i = math.min(i + ((H * o) * 1.5), e)
						end
						break
					end
				end
			end
			local U = Vector3.new(K, i, Q)
			local l = ((U - e)).Magnitude > 0.05 and ((U - e)).Unit or j.CFrame.LookVector
			j.CFrame = CFrame.lookAt(U, U + l)
			j.AssemblyLinearVelocity = Vector3.zero
			j.AssemblyAngularVelocity = Vector3.zero
			if N then
				h.statusText = string.format("Tweening Home (Z: %.0f) [DODGING TRAP!]", Q)
			else
				h.statusText = string.format("Tweening Home (%.0f studs | Z: %.0f | Spd: %.0f)", w, Q, H)
			end
		end
		j.CFrame = CFrame.new(a)
		j.AssemblyLinearVelocity = Vector3.zero
		j.AssemblyAngularVelocity = Vector3.zero
		if k then
			k.AutoRotate = true
		end
		u4()
		h.isReturning = false
		h.delivering = false
		h.statusText = "Arrived at Base PetArea!"
		return true
	end
	v4 = function(e, r, y, ...)
		local u = o.Character
		local w = u and u:FindFirstChild("HumanoidRootPart")
		local j = u and u:FindFirstChildOfClass("Humanoid")
		if not w or not j then
			return
		end
		local k = s4()
		local a = ((w.Position - k)).Magnitude
		if a > 8 then
			h.statusText = "[Place] Tweening back to base plot..."
			g4(e or h.glideSpeed or 600, r, true)
		end
		V4(k, 15)
		w.CFrame = CFrame.new(k)
		w.AssemblyLinearVelocity = Vector3.zero
		h.statusText = "[Place] Placing All Eggs to Stand..."
		local V = os.clock() + 3
		while y4() > 0 and (os.clock() < V and h.alive) do
			B4()
			task.wait(0.008)
		end
		h.statusText = "[Place] Hatching ready eggs..."
		J4(true)
		u4()
		h.isReturning = false
		h.delivering = false
		h.currentTargetModel = nil
		h.targetPosition = nil
		local H = y4()
		h.statusText = string.format("Placed & Hatched (Left: %d)! Hands Free.", H)
	end
	local uk = 5
	K4 = function(e, ...)
		if h.isBatchPlacing then
			return
		end
		h.isBatchPlacing = true
		H(string.format("[AutoPlace] %d steals done! Batch placing (%s mode)...", uk, tostring(e)))
		local r = O4
		h.pureTweenFarm = (e == "TWEEN")
		h.autoFarmLoop = (e == "WARP")
		local y = o.Character
		local u = y and y:FindFirstChild("HumanoidRootPart")
		local w = y and y:FindFirstChildOfClass("Humanoid")
		local j = s4()
		local k = u and ((u.Position - j)).Magnitude or 999
		if k > 8 then
			h.statusText = "[AutoPlace] Tweening home to base plot..."
			g4(h.glideSpeed or 600, r, true)
		end
		if u then
			V4(j, 20)
			u.CFrame = CFrame.new(j)
			u.AssemblyLinearVelocity = Vector3.zero
			u.AssemblyAngularVelocity = Vector3.zero
			if w then
				w.AutoRotate = true
			end
		end
		task.spawn(function(...)
			pcall(B4)
			pcall(J4, true)
		end)
		u4()
		h.isReturning = false
		h.delivering = false
		h.glidingToTarget = false
		h.securingEgg = false
		h.teleporting = false
		h.currentTargetModel = nil
		h.targetPosition = nil
		for e = ((h.fastCycle and 1) or 2), 1, -1 do
			if not h.alive then
				break
			end
			h.statusText = string.format("[AutoPlace] At Base: Resuming in %ds...", e)
			task.wait(1)
		end
		h.isBatchPlacing = false
		if h.alive and O4 == r then
			H(string.format("[AutoPlace] Done! Continuing %s farm.", e))
			h.statusText = string.format("[AutoPlace] Resuming %s farm...", e)
			if e == "TWEEN" then
				h.pureTweenFarm = true
				h.autoFarmLoop = false
			elseif e == "WARP" then
				h.autoFarmLoop = true
				h.pureTweenFarm = false
			end
			Y4 = e
		end
	end
	c4 = function(e, ...)
		if not h.autoPlaceEvery5 then
			return false
		end
		h.batchStealCount = (h.batchStealCount or 0) + 1
		h.statsSteals = (h.statsSteals or 0) + 1; h._stealFails=0
		if h._stealHook then
			pcall(h._stealHook)
		end
		H(string.format("[AutoPlace] Steal trip %d / %d completed successfully.", h.batchStealCount, uk))
		if h.batchStealCount >= uk then
			h.batchStealCount = 0
			task.spawn(function(...)
				K4(e)
			end)
			return true
		end
		return false
	end
	local function wk(e, r, u, w, ...)
		local j = o.Character
		local k = j and j:FindFirstChild("HumanoidRootPart")
		local a = j and j:FindFirstChildOfClass("Humanoid")
		if not k then
			return false
		end
		if a then
			a.AutoRotate = false
		end
		r = math.max(60, r or h.glideSpeed or 350)
		local V = e.Position
		V4(V, 14)
		pcall(function(...)
			o:RequestStreamAroundAsync(V)
		end)
		k.AssemblyLinearVelocity = Vector3.zero
		k.AssemblyAngularVelocity = Vector3.zero
		local H = h.laneZ or L
		h.glidingToTarget = true
		h.stateTime = os.clock()
		local t = 0
		local s = os.clock() + 15
		while h.alive and (h.glidingToTarget and os.clock() < s) do
			if w and O4 ~= w then
				if a then
					a.AutoRotate = true
				end
				h.glidingToTarget = false
				return false
			end
			if not h.pureTweenFarm and (not h.autoFarmLoop and not h.teleporting) then
				if a then
					a.AutoRotate = true
				end
				h.glidingToTarget = false
				return false
			end
			local e = k.Position
			local j = ((V - e)).Magnitude
			local o = ((Vector2.new(e.X, e.Z) - Vector2.new(V.X, V.Z))).Magnitude
			local s = math.abs(e.Y - V.Y)
			if j <= 6 or (o <= 3.5 and s <= 6) then
				break
			end
			local B = y.Heartbeat:Wait()
			e = k.Position
			j = ((V - e)).Magnitude
			o = ((Vector2.new(e.X, e.Z) - Vector2.new(V.X, V.Z))).Magnitude
			local J = math.abs(e.X - V.X)
			if u and (os.clock() - t > 0.5) then
				t = os.clock()
				local e, r = k4(u)
				if not e and r == "CarriedByOther" then
					if a then
						a.AutoRotate = true
					end
					h.glidingToTarget = false
					return false
				end
			end
			local K = V.Z
			if J > 40 then
				K = H
			end
			local c = math.sign(V.X - e.X)
			local v = c * math.min(math.abs(V.X - e.X), r * B)
			local i = e.X + v
			local R = (o <= 25) and 1.2 or 0.5
			local g = math.sign(V.Y - e.Y)
			local Q = g * math.min(math.abs(V.Y - e.Y), (r * B) * R)
			local P = e.Y + Q
			local N = K - e.Z
			local U = math.sign(N) * math.min(math.abs(N), r * B)
			local l = e.Z + U
			local D = false
			if o > 25 then
				local e = i4()
				for e, y in ipairs(e) do
					local u = y.Position
					local w = ((Vector3.new(i, P, l) - u)).Magnitude
					local j = math.abs(i - u.X)
					local k = math.abs(l - u.Z)
					if w < 22 or (j < 18 and k < 14) then
						D = true
						local e = u.Y + 16
						if P < e then
							P = math.min(P + ((r * B) * 1.5), e)
						end
						break
					end
				end
			end
			local C = Vector3.new(i, P, l)
			local q = ((C - e)).Magnitude > 0.05 and ((C - e)).Unit or k.CFrame.LookVector
			k.CFrame = CFrame.lookAt(C, C + q)
			k.AssemblyLinearVelocity = Vector3.zero
			k.AssemblyAngularVelocity = Vector3.zero
			if D then
				h.statusText = string.format("Gliding Out (Z: %.0f) [DODGING TRAP!]", l)
			else
				h.statusText = string.format("Gliding -> Egg (%.0f studs | H: %.0f)", j, o)
			end
		end
		k.CFrame = e * CFrame.new(0, 0.4, 0)
		k.AssemblyLinearVelocity = Vector3.zero
		k.AssemblyAngularVelocity = Vector3.zero
		if a then
			a.AutoRotate = true
		end
		h.glidingToTarget = false
		return true
	end
	R4 = function(e, r, y, u, ...)
		local w = o.Character
		local j = w and w:FindFirstChild("HumanoidRootPart")
		if j then
			local w = j.Position.X
			local a = e.Position.X
			if w <= 535 and a > 510 then
				local e = CFrame.new(500, 70, -364)
				local a = ((j.Position - e.Position)).Magnitude
				if a > 5 then
					h.statusText = "[AutoSteal] Exiting Base -> Waypoint (500, 70, -364)..."
					H(
						string.format(
							"[AutoSteal] Leaving base (X=%.1f): Gliding to waypoint (500, 70, -364) first (dist=%.1f studs)...",
							w,
							a
						)
					)
					local j = wk(e, r, y, u)
					if not j then
						return false
					end
					task.wait(0.008)
				end
			end
		end
		return wk(e, r, y, u)
	end
	Q4 = function(e, r, ...)
		local u = o.Character
		local w = u and u:FindFirstChild("HumanoidRootPart")
		local j = u and u:FindFirstChildOfClass("Humanoid")
		if not w then
			return false
		end
		if j then
			j.AutoRotate = false
		end
		local k = h.laneZ or L
		local a = Vector3.new(E - 10, 70, k)
		e = math.max(100, e or h.glideSpeed or 350)
		h.isReturning = true
		h.stateTime = os.clock()
		V4(Vector3.new(E, 70, k), 20)
		pcall(u4)
		w.AssemblyLinearVelocity = Vector3.zero
		w.AssemblyAngularVelocity = Vector3.zero
		local V = o4()
		local H = math.max(e, V)
		local s = os.clock() + 15
		while h.alive and (h.isReturning and os.clock() < s) do
			if r and O4 ~= r then
				t("[Return] Aborted by session switch!")
				if j then
					j.AutoRotate = true
				end
				h.isReturning = false
				return false
			end
			if not h.pureTweenFarm and not h.autoFarmLoop then
				t("[Return] Aborted (all farms disabled)")
				if j then
					j.AutoRotate = true
				end
				h.isReturning = false
				return false
			end
			local e = w.Position
			local o = ((a - e)).Magnitude
			if e.X <= (E + 10) or o <= 6 then
				u4()
				break
			end
			if u then
				for e, r in ipairs(u:GetChildren()) do
					if r:IsA("Tool") then
						pcall(u4)
						break
					end
				end
			end
			local V = y.Heartbeat:Wait()
			e = w.Position
			local s = H
			if e.X <= b and e.X > E then
				local r = math.clamp((e.X - E) / (b - E), 0, 1)
				s = A + ((H - A) * r)
			elseif e.X <= E then
				s = A
			end
			if h.humanize then
				s = s * (0.88 + (math.random() * 0.24))
				if h.nearPlayer then
					s = s * 0.95
				end
			end
			local B = math.sign(a.X - e.X)
			local J = B * math.min(math.abs(a.X - e.X), s * V)
			local K = e.X + J
			local c = math.sign(a.Y - e.Y)
			local v = c * math.min(math.abs(a.Y - e.Y), (s * V) * 0.5)
			local i = e.Y + v
			if o > 25 and i < (a.Y + 12) then
				i = math.min((a.Y + 12), i + ((s * V) * 1.5))
			end
			local R = k - e.Z
			local g = math.sign(R) * math.min(math.abs(R), s * V)
			local Q = e.Z + g
			local P = i4()
			local N = false
			for e, r in ipairs(P) do
				local y = r.Position
				local u = ((Vector3.new(K, i, Q) - y)).Magnitude
				local w = math.abs(K - y.X)
				local j = math.abs(Q - y.Z)
				if u < 22 or (w < 18 and j < 14) then
					N = true
					local e = y.Y + 16
					if i < e then
						i = math.min(i + ((s * V) * 1.5), e)
					end
					break
				end
			end
			local U = Vector3.new(K, i, Q)
			local l = ((U - e)).Magnitude > 0.05 and ((U - e)).Unit or w.CFrame.LookVector
			w.CFrame = CFrame.lookAt(U, U + l)
			w.AssemblyLinearVelocity = Vector3.zero
			w.AssemblyAngularVelocity = Vector3.zero
			if N then
				h.statusText = string.format("Tweening Safe Line (Z: %.0f) [DODGING!]", Q)
			else
				h.statusText = string.format("Tweening to Safe Line (%.0f studs | X: %.0f)", o, e.X)
			end
		end
		w.CFrame = CFrame.new(E, 70, k)
		w.AssemblyLinearVelocity = Vector3.zero
		w.AssemblyAngularVelocity = Vector3.zero
		if j then
			j.AutoRotate = true
		end
		u4()
		h.isReturning = false
		h.delivering = false
		if h then
			h.onTreadmill = false
		end
		h.statusText = "Arrived at Safe Line (X=525)! Hands Free."
		return true
	end
	local function jk(e, ...)
		if not e then
			return nil
		end
		local r = e:FindFirstChild("TreadmillBottom")
		if r and r:IsA("BasePart") then
			return r
		end
		r = e:FindFirstChild("TreadmillBottom", true)
		if r and r:IsA("BasePart") then
			return r
		end
		local y = e:FindFirstChild("TreadmillUpgrade", true)
		if y then
			for e, r in ipairs({
				"TreadmillBottom",
				"Belt",
				"RunArea",
				"Run",
				"Platform",
				"Pad",
				"Floor",
				"Base",
			}) do
				local w = y:FindFirstChild(r, true)
				if w and w:IsA("BasePart") then
					return w
				end
			end
			local e = nil
			local r = 999999
			for y, w in ipairs(y:GetDescendants()) do
				if w:IsA("BasePart") and (w.Size.X >= 1.2 and w.Size.Z >= 1.2) then
					if w.Position.Y < r then
						r = w.Position.Y
						e = w
					end
				end
			end
			if e then
				return e
			end
			if y.PrimaryPart then
				return y.PrimaryPart
			end
			local w = y:FindFirstChildWhichIsA("BasePart", true)
			if w then
				return w
			end
		end
		for e, r in ipairs(e:GetDescendants()) do
			if r:IsA("BasePart") and string.find(string.lower(r.Name), "treadmill") then
				return r
			end
		end
		return nil
	end
	I4 = function(...)
		local e = t4()
		if h.tread and h.tread.Parent then
			return h.tread
		end
		local y = nil
		if e then
			y = jk(e)
		end
		if not y then
			local w = r:FindFirstChild("Plots")
			if w then
				local r = string.lower(o.Name)
				local j = o.DisplayName and string.lower(o.DisplayName)
				for e, w in ipairs(w:GetChildren()) do
					local k = jk(w)
					if k then
						local e = false
						for y, w in ipairs(w:GetDescendants()) do
							if w:IsA("TextLabel") and w.Text ~= "" then
								local y = string.lower(w.Text)
								if string.find(y, r, 1, true) or (j and string.find(y, j, 1, true)) then
									e = true
									break
								end
							end
						end
						if e then
							h.plot = w
							h.plotVerified = true
							y = k
							break
						end
					end
				end
				if not y and e then
					y = jk(e)
				end
			end
		end
		h.tread = y
		return y
	end
	f4 = function(e, ...)
		local r = o.Character
		local u = r and r:FindFirstChild("HumanoidRootPart")
		local w = r and r:FindFirstChildOfClass("Humanoid")
		if not u or not w then
			return false
		end
		if w.PlatformStand then
			w.PlatformStand = false
		end
		if w.Sit then
			w.Sit = false
		end
		w:ChangeState(Enum.HumanoidStateType.Running)
		local j = t4()
		local k = I4()
		if not k then
			t("[AutoTreadmill] Treadmill part not found! Retrying next loop...")
			return false
		end
		pcall(function(...)
			for r, y in ipairs(r:GetChildren()) do
				if y:IsA("BasePart") and y.Name ~= "HumanoidRootPart" then
					y.CanCollide = false
				end
			end
		end)
		pcall(function(...)
			k.CanTouch = true
			k.CanCollide = true
			local e = j and j:FindFirstChild("TreadmillUpgrade", true)
			if e then
				for e, y in ipairs(e:GetDescendants()) do
					if y:IsA("BasePart") then
						y.CanTouch = true
						y.CanCollide = true
					end
				end
			end
			if k.Parent and k.Parent:IsA("Model") then
				for e, y in ipairs(k.Parent:GetDescendants()) do
					if y:IsA("BasePart") then
						y.CanTouch = true
						y.CanCollide = true
					end
				end
			end
		end)
		local a = k.Position + Vector3.new(0, 1.8, 0)
		if u.Position.X > 535 then
			h.statusText = "[AutoTreadmill] Returning along highway to base..."
			Q4(h.glideSpeed, e)
			if e and O4 ~= e then
				return false
			end
			if u.Position.X > 535 then
				if u.Position.X <= 560 then
					u.CFrame = CFrame.new(E, 70, h.laneZ or L)
				else
					return false
				end
			end
		end
		if e and O4 ~= e then
			return false
		end
		local V = ((Vector2.new(u.Position.X, u.Position.Z) - Vector2.new(a.X, a.Z))).Magnitude
		if V > 4 then
			h.statusText = "[AutoTreadmill] Elevated flyover to base plot..."
			local r = math.max(250, h.glideSpeed or 400)
			local j = os.clock()
			while
				h.alive
				and (
					((Vector2.new(u.Position.X, u.Position.Z) - Vector2.new(a.X, a.Z))).Magnitude > 4
					and (os.clock() - j < 4)
				)
			do
				if e and O4 ~= e then
					return false
				end
				local j = y.Heartbeat:Wait()
				local k = u.Position
				local o = Vector3.new(a.X, 70, a.Z)
				local V = (o - k)
				local H = V.Unit * math.min(V.Magnitude, r * j)
				local t = k + H
				u.CFrame = CFrame.lookAt(t, t + (V.Magnitude > 0.05 and V.Unit or u.CFrame.LookVector))
				u.AssemblyLinearVelocity = Vector3.zero
				u.AssemblyAngularVelocity = Vector3.zero
				if w then
					if w.PlatformStand then
						w.PlatformStand = false
					end
					if w.Sit then
						w.Sit = false
					end
					w:ChangeState(Enum.HumanoidStateType.Running)
				end
			end
		end
		if e and O4 ~= e then
			return false
		end
		local H = os.clock()
		while h.alive and (math.abs(u.Position.Y - a.Y) > 2 and (os.clock() - H < 1.5)) do
			if e and O4 ~= e then
				return false
			end
			local r = y.Heartbeat:Wait()
			local w = u.Position
			local j = a
			local k = (j - w)
			local o = k.Unit * math.min(k.Magnitude, 150 * r)
			local V = w + o
			u.CFrame = CFrame.new(V)
			u.AssemblyLinearVelocity = Vector3.zero
			u.AssemblyAngularVelocity = Vector3.zero
		end
		u.CFrame = CFrame.new(a)
		u.AssemblyLinearVelocity = Vector3.zero
		u.AssemblyAngularVelocity = Vector3.zero
		local s = ((u.Position - a)).Magnitude
		if s <= 6 then
			pcall(function(...)
				if typeof(firetouchinterest) == "function" then
					firetouchinterest(u, k, 0)
					task.wait(0.01)
					firetouchinterest(u, k, 1)
				end
			end)
			pcall(function(...)
				for r, y in ipairs(k:GetDescendants()) do
					if y:IsA("ProximityPrompt") and y.Enabled then
						if typeof(fireproximityprompt) == "function" then
							fireproximityprompt(y)
						end
					end
				end
				if k.Parent then
					for r, y in ipairs(k.Parent:GetDescendants()) do
						if y:IsA("ProximityPrompt") and y.Enabled then
							if typeof(fireproximityprompt) == "function" then
								fireproximityprompt(y)
							end
						end
					end
				end
			end)
			if l then
				pcall(function(...)
					l:InvokeServer()
				end)
			end
			h.onTreadmill = true
			h.lastTreadmillMount = os.clock()
			h.statusText = "[AutoTreadmill] Running on treadmill (Waiting for eggs...)"
			return true
		else
			h.onTreadmill = false
			t(string.format("[AutoTreadmill] Not yet at treadmill pad (dist=%.1f studs). Will retry!", s))
			return false
		end
	end
	local function kk(...)
		if not h or not h.hideNotEnoughMoney then
			return
		end
		local e = o:FindFirstChild("PlayerGui")
		if not e then
			return
		end
		pcall(function(...)
			for e, y in ipairs(e:GetDescendants()) do
				if y:IsA("TextLabel") and y.Visible then
					local e = (tostring(y.Text or "")):lower()
					if
						e:find("not enough money")
						or e:find("not enough cash")
						or (
							e:find("not enough")
							and (e:find("money") or e:find("cash") or e:find("coin") or e:find("fund"))
						)
					then
						y.Visible = false
						y.TextTransparency = 1
						y.TextStrokeTransparency = 1
						local e = y.Parent
						if e and ((e:IsA("Frame") or e:IsA("CanvasGroup")) and #e:GetChildren() <= 3) then
							e.Visible = false
						end
					end
				end
			end
		end)
	end
	local function ak(...)
		local e = o:FindFirstChild("PlayerGui")
		if not e then
			return
		end
		local function r(e, ...)
			if e:IsA("TextLabel") then
				local function y(...)
					if not h or not h.hideNotEnoughMoney then
						return
					end
					local y = (tostring(e.Text or "")):lower()
					if
						y:find("not enough money")
						or y:find("not enough cash")
						or (
							y:find("not enough")
							and (y:find("money") or y:find("cash") or y:find("coin") or y:find("fund"))
						)
					then
						e.Visible = false
						e.TextTransparency = 1
						e.TextStrokeTransparency = 1
						local r = e.Parent
						if r and ((r:IsA("Frame") or r:IsA("CanvasGroup")) and #r:GetChildren() <= 3) then
							r.Visible = false
						end
					end
				end
				y();
				(e:GetPropertyChangedSignal("Text")):Connect(y);
				(e:GetPropertyChangedSignal("Visible")):Connect(function(...)
					if e.Visible then
						y()
					end
				end)
			end
		end
		pcall(function(...)
			for e, y in ipairs(e:GetDescendants()) do
				task.spawn(r, y)
			end
			e.DescendantAdded:Connect(r)
		end)
		task.spawn(function(...)
			while h and h.alive do
				if h.hideNotEnoughMoney then
					kk()
				end
				task.wait(0.04)
			end
		end)
	end
	task.spawn(ak)
	local function ok(e, ...)
		if not e then
			return 0
		end
		local r = (((tostring(e)):gsub("[$,]", "")):gsub("%s+", "")):lower()
		local y = r:match("[%d%.]+")
		if not y then
			return 0
		end
		local u = tonumber(y)
		if not u then
			return 0
		end
		if r:find("sp") then
			return u * 999999999999999983222784
		elseif r:find("sx") then
			return u * 1000000000000000000000
		elseif r:find("qi") then
			return u * 1000000000000000000
		elseif r:find("qa") or r:find("q") then
			return u * 1000000000000000
		elseif r:find("t") then
			return u * 1000000000000
		elseif r:find("b") then
			return u * 1000000000
		elseif r:find("m") then
			return u * 1000000
		elseif r:find("k") then
			return u * 1000
		end
		return u
	end
	local function Vk(...)
		local e = o:FindFirstChild("leaderstats")
		if e then
			for r, u in ipairs({ "Money", "Cash", "Coins", "Currency" }) do
				local w = e:FindFirstChild(u)
				if w then
					local e = tonumber(w.Value) or ok(w.Value)
					if e and e > 0 then
						return e
					end
				end
			end
		end
		local r = o:FindFirstChild("PlayerGui")
		if r then
			local e = r:FindFirstChild("HUD")
				or r:FindFirstChild("GameHUD")
				or r:FindFirstChild("MainHUD")
				or r:FindFirstChild("Main")
			if e then
				for e, r in ipairs(e:GetDescendants()) do
					if r:IsA("TextLabel") and r.Visible then
						local e = r.Name:lower()
						if e == "money" or e == "cash" or e == "coins" or e == "currency" or e == "value" then
							local e = ok(r.Text)
							if e and e > 0 then
								return e
							end
						end
					end
				end
			end
		end
		return 0
	end
	local function Hk(...)
		local e = h.plot or (t4 and t4())
		if not e then
			return nil
		end
		local r = e:FindFirstChild("TreadmillUpgrade", true)
		if not r then
			return nil
		end
		local y = nil
		for e, r in ipairs(r:GetDescendants()) do
			if r:IsA("TextLabel") or r:IsA("TextButton") then
				local e = tostring(r.Text or "")
				local w = e:match("%$([%d%.,]+%s*[kKmMbBtTqQ]?[aA]?)")
				if w then
					local e = ok(w)
					if e and e > 0 then
						if not y or e > y then
							y = e
						end
					end
				end
			end
		end
		return y
	end
	local tk = 0
	local sk = 10
	local function pk(...)
		if not h.autoUpgradeTreadmill then
			return
		end
		if os.clock() - tk < sk then
			return
		end
		local e = h.plot or (t4 and t4())
		if not e then
			return
		end
		local r = e:FindFirstChild("TreadmillUpgrade", true)
		if not r then
			return
		end
		local y = Vk()
		local u = Hk()
		if u and (u > 0 and y < u) then
			return
		end
		tk = os.clock()
		if D then
			pcall(function(...)
				D:InvokeServer()
			end)
		end
		local w = o.Character
		local j = w and w:FindFirstChild("HumanoidRootPart")
		pcall(function(...)
			for r, y in ipairs(r:GetDescendants()) do
				if y:IsA("ProximityPrompt") and y.Enabled then
					if typeof(fireproximityprompt) == "function" then
						fireproximityprompt(y, 0)
						fireproximityprompt(y)
					end
				end
				if y:IsA("GuiButton") and y.Visible then
					local r = (y:IsA("TextButton") and y.Text) or y.Name
					local u = string.lower(r)
					if
						not string.find(u, "robux")
						and (
							not string.find(u, "r%$")
							and (
								string.find(u, "%$")
								or string.find(u, "upgrade")
								or string.find(u, "cash")
								or (y.BackgroundColor3 and y.BackgroundColor3.G > y.BackgroundColor3.R)
							)
						)
					then
						if typeof(firesignal) == "function" and y.Activated then
							firesignal(y.Activated)
						elseif typeof(firesignal) == "function" and y.MouseButton1Click then
							firesignal(y.MouseButton1Click)
						end
					end
				end
				if y:IsA("BasePart") and (y.Name:find("Pad") and j) then
					if ((j.Position - y.Position)).Magnitude < 10 then
						if typeof(firetouchinterest) == "function" then
							firetouchinterest(j, y, 0)
							task.wait(0.01)
							firetouchinterest(j, y, 1)
						end
					end
				end
			end
		end)
	end
	local Bk = {
		{ ["id"] = "GreyTrail", ["base"] = "Grey", ["name"] = "Grey Trail", ["price"] = 100, ["mult"] = 1.5 },
		{ ["id"] = "GreenTrail", ["base"] = "Green", ["name"] = "Green Trail", ["price"] = 5000, ["mult"] = 2 },
		{ ["id"] = "BlueTrail", ["base"] = "Blue", ["name"] = "Blue Trail", ["price"] = 75000, ["mult"] = 2.5 },
		{
			["id"] = "PurpleTrail",
			["base"] = "Purple",
			["name"] = "Purple Trail",
			["price"] = 1500000,
			["mult"] = 3,
		},
		{
			["id"] = "GoldenTrail",
			["base"] = "Golden",
			["name"] = "Golden Trail",
			["price"] = 1500000,
			["mult"] = 3.5,
		},
		{ ["id"] = "RedTrail", ["base"] = "Red", ["name"] = "Red Trail", ["price"] = 750000000, ["mult"] = 4 },
		{
			["id"] = "GalaxyTrail",
			["base"] = "Galaxy",
			["name"] = "Galaxy Trail",
			["price"] = 20000000000,
			["mult"] = 5,
		},
		{
			["id"] = "SecretTrail",
			["base"] = "Secret",
			["name"] = "Secret Trail",
			["price"] = 500000000000,
			["mult"] = 6,
		},
		{
			["id"] = "EternalTrail",
			["base"] = "Eternal",
			["name"] = "Eternal Trail",
			["price"] = 12500000000000,
			["mult"] = 10,
		},
		{
			["id"] = "DivineTrail",
			["base"] = "Divine",
			["name"] = "Divine Trail",
			["price"] = 300000000000000,
			["mult"] = 14,
		},
		{
			["id"] = "MoonbloomTrail",
			["base"] = "Moonbloom",
			["name"] = "Moonbloom Trail",
			["price"] = 5000000000000000,
			["mult"] = 20,
		},
	}
	local function Jk(...)
		return Bk
	end
	local function Kk(...)
		local e = {}
		local r = o:FindFirstChild("PlayerGui")
		local y = r and (r:FindFirstChild("TrailShop") or r:FindFirstChild("TrailShop", true))
		local u = y and y:FindFirstChild("ScrollingFrame", true)
		if u then
			pcall(function(...)
				for y, u in ipairs(u:GetChildren()) do
					if u:IsA("GuiObject") and (not u:IsA("UIListLayout") and not u:IsA("UIPadding")) then
						local y = u.Name
						for u, w in ipairs(u:GetDescendants()) do
							if w:IsA("GuiButton") or w:IsA("TextButton") then
								local u = (w:IsA("TextButton") and w.Text:lower()) or w.Name:lower()
								if u:find("unequip") or (u:find("equip") and not u:find("unequip")) then
									e[y] = true
									e[y:lower()] = true
									local u = y:gsub("Trail", "")
									e[u] = true
									e[u:lower()] = true
								end
							end
						end
					end
				end
			end)
		end
		return e
	end
	local function ck(e, ...)
		if not e then
			return false
		end
		pcall(function(...)
			if typeof(firebutton1click) == "function" then
				firebutton1click(e)
			elseif typeof(firesignal) == "function" and e.Activated then
				firesignal(e.Activated)
			elseif typeof(firesignal) == "function" and e.MouseButton1Click then
				firesignal(e.MouseButton1Click)
			end
		end)
		return true
	end
	local function vk(...)
		local e = Jk()
		local r = Kk()
		local y = o:FindFirstChild("PlayerGui")
		local u = y and (y:FindFirstChild("TrailShop") or y:FindFirstChild("TrailShop", true))
		local w = u and u:FindFirstChild("ScrollingFrame", true)
		if w then
			for r = #e, 1, -1 do
				local y = e[r]
				local u = w:FindFirstChild(y.id) or w:FindFirstChild(y.base) or w:FindFirstChild(y.name)
				if not u then
					for e, r in ipairs(w:GetChildren()) do
						if
							r:IsA("GuiObject")
							and (
								r.Name:lower() == y.id:lower()
								or r.Name:lower() == y.base:lower()
								or r.Name:lower() == y.name:lower()
							)
						then
							u = r
							break
						end
					end
				end
				if u then
					local e = false
					local r = nil
					for y, u in ipairs(u:GetDescendants()) do
						if u:IsA("GuiButton") or u:IsA("TextButton") then
							local y = (u:IsA("TextButton") and u.Text:lower()) or u.Name:lower()
							if y:find("unequip") then
								e = true
								break
							elseif y:find("equip") and not y:find("unequip") then
								r = u
							end
						end
					end
					if e then
						return true
					end
					if r then
						ck(r)
						if q then
							pcall(function(...)
								q:InvokeServer(y.id)
							end)
						end
						task.wait(0.03)
						return true
					end
				end
			end
		end
		if q then
			for y = #e, 1, -1 do
				local u = e[y]
				local w = r[u.id] or r[u.id:lower()] or r[u.base] or r[u.base:lower()] or r[u.name] or r[u.name:lower()]
				if w then
					pcall(function(...)
						q:InvokeServer(u.id)
					end)
					return true
				end
			end
		end
		return false
	end
	local ik = 0
	local Rk = 8
	local function gk(...)
		if not h.autoBuyTrails then
			return
		end
		vk()
		if os.clock() - ik < Rk then
			return
		end
		local e = Vk()
		if e <= 0 then
			return
		end
		local r = Jk()
		local y = Kk()
		local u = o:FindFirstChild("PlayerGui")
		local w = u and (u:FindFirstChild("TrailShop") or u:FindFirstChild("TrailShop", true))
		local j = w and w:FindFirstChild("ScrollingFrame", true)
		for u = #r, 1, -1 do
			local w = r[u]
			local a = y[w.id] or y[w.id:lower()] or y[w.base] or y[w.base:lower()] or y[w.name] or y[w.name:lower()]
			if not a and (w.price > 0 and e >= w.price) then
				ik = os.clock()
				local e = false
				if j then
					local r = j:FindFirstChild(w.id) or j:FindFirstChild(w.base) or j:FindFirstChild(w.name)
					if not r then
						for e, y in ipairs(j:GetChildren()) do
							if
								y:IsA("GuiObject")
								and (
									y.Name:lower() == w.id:lower()
									or y.Name:lower() == w.base:lower()
									or y.Name:lower() == w.name:lower()
								)
							then
								r = y
								break
							end
						end
					end
					if r then
						for r, y in ipairs(r:GetDescendants()) do
							if y:IsA("GuiButton") or y:IsA("TextButton") then
								local r = (y:IsA("TextButton") and y.Text:lower()) or y.Name:lower()
								if
									not r:find("robux")
									and (not r:find("r%$") and (not r:find("unequip") and not r:find("equip")))
								then
									if r:find("%$") or r:find("buy") then
										ck(y)
										e = true
										break
									end
								end
							end
						end
					end
				end
				if C then
					pcall(function(...)
						C:InvokeServer(w.id)
					end)
					e = true
				end
				if e then
					task.wait(0.04)
					vk()
					break
				end
			end
		end
	end
	P4 = function(...)
		local e = o.Character
		local y = e and e:FindFirstChild("HumanoidRootPart")
		if not y then
			return nil
		end
		local u = {}
		local w = r:FindFirstChild("AreaEggSlotsClient")
		local j = h4(false)
		if j and #j > 0 then
			for e, r in ipairs(j) do
				local w = (r.State == "Slot" or r.State == "Dropped" or r.State == 1)
				local j = (r.AreaId == "Lake")
					or (string.find(string.lower(tostring(r.AreaId)), "lake") ~= nil)
					or (string.find(string.lower(tostring(r.Uid)), "lake") ~= nil)
				local k = X4[r.Uid] and (os.clock() < X4[r.Uid])
				if w and (j and (r.BoundsCFrame and not k)) then
					local e = r.BoundsCFrame.Position
					local w = ((y.Position - e)).Magnitude
					table.insert(
						u,
						{
							["Uid"] = r.Uid,
							["Model"] = nil,
							["Hitbox"] = nil,
							["CFrame"] = r.BoundsCFrame,
							["Position"] = e,
							["Distance"] = w,
							["Area"] = "Lake",
						}
					)
				end
			end
		end
		if #u == 0 and (j and #j > 0) then
			for e, r in ipairs(j) do
				local w = (r.State == "Slot" or r.State == "Dropped" or r.State == 1)
				local j = r.BoundsCFrame and r.BoundsCFrame.Position
				local k = j and (j.X >= 545 and j.X < 850)
				local o = X4[r.Uid] and (os.clock() < X4[r.Uid])
				if w and (k and not o) then
					table.insert(
						u,
						{
							["Uid"] = r.Uid,
							["Model"] = nil,
							["Hitbox"] = nil,
							["CFrame"] = r.BoundsCFrame,
							["Position"] = j,
							["Distance"] = ((y.Position - j)).Magnitude,
							["Area"] = r.AreaId or "Field",
						}
					)
				end
			end
		end
		if #u == 0 then
			return nil
		end
		table.sort(u, function(e, r, ...)
			return e.Distance < r.Distance
		end)
		local k = u[1]
		if k and w then
			for e, r in ipairs(w:GetChildren()) do
				local y = r:FindFirstChildWhichIsA("BasePart") or r.PrimaryPart
				if y and ((y.Position - k.Position)).Magnitude <= 8 then
					k.Model = r
					break
				end
			end
		end
		return k
	end
	local Qk = nil
	local Pk = nil
	local Nk = 350
	local function Uk(...)
		local e = r:FindFirstChild("__OBJECTS") or r:FindFirstChild("Objects")
		local y = e and (e:FindFirstChild("Areas") or e:FindFirstChild("Area"))
		local u = y and (y:FindFirstChild("GuardAreas") or y:FindFirstChild("Guards"))
		if u then
			local e = u:FindFirstChild("Light Dark")
				or u:FindFirstChild("LightDark")
				or u:FindFirstChild("Light_Dark")
				or u:FindFirstChild("Light-Dark")
			if e then
				return e
			end
			for e, r in ipairs(u:GetChildren()) do
				local y = string.lower(r.Name)
				if string.find(y, "light") and string.find(y, "dark") then
					return r
				end
			end
		end
		if y then
			local e = y:FindFirstChild("Light Dark") or y:FindFirstChild("LightDark") or y:FindFirstChild("Light_Dark")
			if e then
				return e
			end
			for e, r in ipairs(y:GetChildren()) do
				local y = string.lower(r.Name)
				if string.find(y, "light") and string.find(y, "dark") then
					return r
				end
			end
		end
		for e, r in ipairs(r:GetChildren()) do
			local y = r.Name
			if y == "__OBJECTS" or y == "Objects" or y == "Areas" or y == "Map" then
				for e, r in ipairs(r:GetDescendants()) do
					local y = string.lower(r.Name)
					if
						y == "light dark"
						or y == "lightdark"
						or (string.find(y, "light") and string.find(y, "dark"))
					then
						if r:IsA("BasePart") or r:IsA("Model") or r:IsA("Folder") then
							return r
						end
					end
				end
			end
		end
		return nil
	end
	local function lk(e, ...)
		if not e then
			return false
		end
		if Qk then
			local r = ((Vector3.new(e.X, 0, e.Z) - Vector3.new(Qk.X, 0, Qk.Z))).Magnitude
			if r <= Nk then
				return true
			end
		end
		local r = Uk()
		if not r then
			if e.X >= 5200 then
				return true
			end
			return false
		end
		local y = false
		pcall(function(...)
			local u, w = nil, nil
			if r:IsA("BasePart") then
				u = r.CFrame
				w = r.Size
			elseif r:IsA("Model") then
				u, w = r:GetBoundingBox()
			else
				local e, y = nil, nil
				for r, u in ipairs(r:GetChildren()) do
					if u:IsA("BasePart") then
						local r = u.CFrame
						local w = u.Size / 2
						local k = r.Position - w
						local a = r.Position + w
						if not e then
							e = k
							y = a
						else
							e = Vector3.new(math.min(e.X, k.X), math.min(e.Y, k.Y), math.min(e.Z, k.Z))
							y = Vector3.new(math.max(y.X, a.X), math.max(y.Y, a.Y), math.max(y.Z, a.Z))
						end
					end
				end
				if e and y then
					u = CFrame.new((e + y) / 2)
					w = y - e
				end
			end
			if u and w then
				Qk = u.Position
				Pk = u
				Nk = math.max(350, math.max(w.X, w.Z) / 2 + 150)
				local r = ((Vector3.new(e.X, 0, e.Z) - Vector3.new(u.Position.X, 0, u.Position.Z))).Magnitude
				if r <= Nk then
					y = true
					return
				end
				local k = u:PointToObjectSpace(e)
				local a = w / 2
				if math.abs(k.X) <= (a.X + 200) and math.abs(k.Z) <= (a.Z + 200) then
					y = true
					return
				end
			end
			for r, u in ipairs(r:GetDescendants()) do
				if u:IsA("BasePart") then
					if ((e - u.Position)).Magnitude <= 250 then
						y = true
						if not Qk then
							Qk = u.Position
						end
						return
					end
				end
			end
		end)
		return y
	end
	local function Dk(e, r, y, ...)
		local u = r and r.X or 0
		local w = string.lower(tostring(e or ""))
		local j = string.lower(tostring(y or ""))
		if j ~= "" and j ~= "egg" then
			if
				string.find(j, "spideron")
				or string.find(j, "crustacia")
				or string.find(j, "bladehide")
				or string.find(j, "mantaris")
				or string.find(j, "rhinotaur")
				or string.find(j, "mutantshark")
				or string.find(j, "mutant shark")
				or string.find(j, "gorillaking")
				or string.find(j, "gorilla king")
				or string.find(j, "nightflame")
			then
				return "Titan Temple"
			end
			if
				string.find(j, "crane")
				or string.find(j, "salamander")
				or string.find(j, "redpanda")
				or string.find(j, "red panda")
				or string.find(j, "snowyowl")
				or string.find(j, "snowy owl")
				or string.find(j, "koiegg")
				or string.find(j, "koi egg")
				or string.find(j, "stagegg")
				or string.find(j, "stag egg")
				or string.find(j, "onitiger")
				or string.find(j, "oni tiger")
				or string.find(j, "kitsune")
			then
				return "Cherry Blossom"
			end
			if
				string.find(j, "centapede")
				or string.find(j, "cosmicgecko")
				or string.find(j, "cosmic gecko")
				or string.find(j, "cosmicgorilla")
				or string.find(j, "cosmic gorilla")
				or string.find(j, "saturno")
				or string.find(j, "saturnita")
				or string.find(j, "vacca")
				or string.find(j, "cosmic skeleton")
				or string.find(j, "skeletonboss")
				or string.find(j, "skeleton boss")
				or string.find(j, "cosmicdragon")
				or string.find(j, "cosmic dragon")
				or string.find(j, "lunardragon")
				or string.find(j, "lunar dragon")
				or string.find(j, "unicornegg")
				or string.find(j, "unicorn egg")
			then
				return "Cosmic"
			end
			if
				string.find(j, "dodo")
				or string.find(j, "pterodactyl")
				or string.find(j, "ankylosaurus")
				or string.find(j, "triceratops")
				or string.find(j, "bronto")
				or string.find(j, "trex")
				or string.find(j, "t-rex")
				or string.find(j, "tralaledon")
				or string.find(j, "mosasaurus")
			then
				return "Prehistoric"
			end
			if
				string.find(j, "parrotfish")
				or string.find(j, "swordfish")
				or string.find(j, "whaleshark")
				or string.find(j, "whale shark")
				or string.find(j, "belugawhale")
				or string.find(j, "beluga whale")
				or string.find(j, "kraken")
				or string.find(j, "elmaja")
				or string.find(j, "el maja")
			then
				return "Abyss Ocean"
			end
			if
				string.find(j, "lava gecko")
				or string.find(j, "lava frog")
				or string.find(j, "flaming bull")
				or string.find(j, "lava iguana")
				or string.find(j, "chillin chilli")
				or string.find(j, "cerberus")
				or string.find(j, "phoenix")
				or string.find(j, "lava dragon")
			then
				return "Volcano"
			end
			if
				string.find(j, "penguin")
				or string.find(j, "walrus")
				or string.find(j, "polar bear")
				or string.find(j, "polarbear")
				or string.find(j, "sabertooth")
				or string.find(j, "mammoth")
				or string.find(j, "yeti")
				or string.find(j, "ice dragon")
				or string.find(j, "icedragon")
			then
				return "Snow"
			end
			if
				string.find(j, "sand spider")
				or string.find(j, "sandspider")
				or string.find(j, "royal sphinx")
				or string.find(j, "sphinx")
				or string.find(j, "tob tobi")
				or string.find(j, "tobtobi")
				or string.find(j, "jerboa")
				or string.find(j, "fennec")
				or string.find(j, "camel")
			then
				return "Desert"
			end
			if
				string.find(j, "chimpanzee")
				or string.find(j, "toucan")
				or string.find(j, "crocodile")
				or string.find(j, "orangutini")
				or string.find(j, "ananassini")
				or string.find(j, "king snake")
				or string.find(j, "kingsnake")
			then
				return "Jungle"
			end
			if
				string.find(j, "duckling")
				or string.find(j, "catfish")
				or string.find(j, "turtle")
				or string.find(j, "trulimero")
				or string.find(j, "trulicina")
				or string.find(j, "swan")
				or string.find(j, "axolotl")
				or string.find(j, "leviathan")
			then
				return "Lake"
			end
			if
				string.find(j, "burrowing owl")
				or string.find(j, "burrowingowl")
				or string.find(j, "brr brr")
				or string.find(j, "patapim")
				or string.find(j, "chicken")
				or string.find(j, "dog")
				or string.find(j, "bird")
				or string.find(j, "raccoon")
				or string.find(j, "fox")
			then
				return "Forest"
			end
			if string.find(j, "shark") then
				return "Abyss Ocean"
			end
			if string.find(j, "snake") then
				return "Desert"
			end
			if string.find(j, "spider") then
				return "Jungle"
			end
			if string.find(j, "gorilla") then
				return "Jungle"
			end
			if string.find(j, "tiger") then
				return "Jungle"
			end
			if string.find(j, "frog") then
				return "Lake"
			end
			if string.find(j, "bear") then
				return "Forest"
			end
		end
		if (string.find(w, "light") and string.find(w, "dark")) or w == "lightdark" then
			return "Light Dark"
		elseif string.find(w, "titan") then
			return "Titan Temple"
		elseif string.find(w, "cherry") then
			return "Cherry Blossom"
		elseif string.find(w, "cosmic") then
			return "Cosmic"
		elseif string.find(w, "prehistoric") or string.find(w, "dino") then
			return "Prehistoric"
		elseif string.find(w, "abyss") or string.find(w, "ocean") then
			return "Abyss Ocean"
		elseif string.find(w, "volcano") or string.find(w, "lava") then
			return "Volcano"
		elseif string.find(w, "snow") or string.find(w, "ice") or string.find(w, "winter") then
			return "Snow"
		elseif string.find(w, "jungle") then
			return "Jungle"
		elseif string.find(w, "desert") or string.find(w, "sand") then
			return "Desert"
		elseif string.find(w, "lake") or string.find(w, "water") then
			return "Lake"
		elseif string.find(w, "forest") then
			return "Forest"
		end
		if u > 0 then
			if u >= 5200 then
				return "Light Dark"
			elseif u >= 4750 then
				return "Titan Temple"
			elseif u >= 4000 then
				return "Cherry Blossom"
			elseif u >= 3350 then
				return "Cosmic"
			elseif u >= 2780 then
				return "Prehistoric"
			elseif u >= 2250 then
				return "Abyss Ocean"
			elseif u >= 1850 then
				return "Volcano"
			elseif u >= 1450 then
				return "Snow"
			elseif u >= 1150 then
				return "Jungle"
			elseif u >= 920 then
				return "Desert"
			elseif u >= 720 then
				return "Lake"
			else
				return "Forest"
			end
		end
		return "Forest"
	end
	N4 = function(...)
		local e = h4(false)
		if not e or #e == 0 then
			e = h4(true)
		end
		if not e or #e == 0 then
			return nil
		end
		local y = o.Character
		local u = y and y:FindFirstChild("HumanoidRootPart")
		local w = u and u.Position or Vector3.new(525, 70, -360)
		local function j(e, ...)
			e = tonumber(e) or 0
			if e >= 1000000000000 then
				return string.format("%.1fT", e / 1000000000000)
			end
			if e >= 1000000000 then
				return string.format("%.1fB", e / 1000000000)
			end
			if e >= 1000000 then
				return string.format("%.1fM", e / 1000000)
			end
			if e >= 1000 then
				return string.format("%.1fK", e / 1000)
			end
			return string.format("%.0f", e)
		end
		local function k(e, r, y, u, ...)
			if e and e.PhysicalModel then
				local u = e.PhysicalModel
				local w = u:GetAttribute("Rarity") or u:GetAttribute("RarityTier") or u:GetAttribute("Tier")
				if w and (tostring(w) ~= "" and tostring(w) ~= "Unknown") then
					y = tostring(w)
				end
				if not r or r == "Egg" or r == "" then
					r = u:GetAttribute("Category") or u:GetAttribute("AssetCategory") or u.Name
				end
			end
			local w = string.lower(tostring(e.Rarity or ""))
			local j = string.lower(tostring(y or ""))
			for e, r in ipairs({ w, j }) do
				if r ~= "" and (r ~= "unknown" and r ~= "nil") then
					if string.find(r, "divine") then
						return 6, "Divine"
					end
					if string.find(r, "eternal") then
						return 5, "Eternal"
					end
					if string.find(r, "secret") then
						return 4, "Secret"
					end
					if string.find(r, "cosmic") then
						return 3, "Cosmic"
					end
					if string.find(r, "mythic") then
						return 2, "Mythic"
					end
					if string.find(r, "legendary") then
						return 1, "Legendary"
					end
					if string.find(r, "epic") then
						return 0.5, "Epic"
					end
					if string.find(r, "rare") then
						return 0.3, "Rare"
					end
					if string.find(r, "uncommon") then
						return 0.1, "Uncommon"
					end
					if string.find(r, "common") then
						return 0, "Common"
					end
				end
			end
			if u and u >= 10 then
				return 6, "Divine"
			elseif u and u >= 9 then
				return 5, "Eternal"
			elseif u and u >= 8 then
				return 4, "Secret"
			elseif u and u >= 7 then
				return 3, "Cosmic"
			elseif u and u >= 6 then
				return 2, "Mythic"
			elseif u and u >= 5 then
				return 1, "Legendary"
			elseif u and u >= 4 then
				return 0.5, "Epic"
			elseif u and u >= 3 then
				return 0.3, "Rare"
			elseif u and u >= 2 then
				return 0.1, "Uncommon"
			elseif u and u >= 1 then
				return 0, "Common"
			end
			local k = string.lower(
				string.format(
					"%s %s %s %s %s",
					tostring(r or ""),
					tostring(e.Uid or ""),
					tostring(e.Name or ""),
					tostring(e.DisplayName or ""),
					tostring(e.EggName or "")
				)
			)
			if
				string.find(k, "nightflame")
				or string.find(k, "unicornegg")
				or string.find(k, "unicorn egg")
				or string.find(k, "shatteredcolossus")
				or string.find(k, "kitsune")
				or string.find(k, "elmaja")
				or string.find(k, "el maja")
			then
				return 6, "Divine"
			end
			if
				string.find(k, "gorillaking")
				or string.find(k, "gorilla king")
				or string.find(k, "lunardragon")
				or string.find(k, "lunar dragon")
				or string.find(k, "onitiger")
				or string.find(k, "oni tiger")
				or string.find(k, "mosasaurus")
			then
				return 5, "Eternal"
			end
			if
				string.find(k, "mutantshark")
				or string.find(k, "mutant shark")
				or string.find(k, "skeletonboss")
				or string.find(k, "skeleton boss")
				or string.find(k, "stagegg")
				or string.find(k, "stag egg")
				or string.find(k, "cosmicdragon")
				or string.find(k, "cosmic dragon")
				or string.find(k, "trex")
				or string.find(k, "t-rex")
				or string.find(k, "tralaledon")
				or string.find(k, "kraken")
			then
				return 4, "Secret"
			end
			if
				string.find(k, "saturnita")
				or string.find(k, "saturno")
				or string.find(k, "mantaris")
				or string.find(k, "rhinotaur")
				or string.find(k, "snowyowl")
				or string.find(k, "snowy owl")
				or string.find(k, "koiegg")
				or string.find(k, "koi egg")
				or string.find(k, "triceratops")
				or string.find(k, "bronto")
				or string.find(k, "whaleshark")
				or string.find(k, "whale shark")
				or string.find(k, "belugawhale")
				or string.find(k, "beluga whale")
			then
				return 3, "Cosmic"
			end
			if
				string.find(k, "bladehide")
				or string.find(k, "redpanda")
				or string.find(k, "red panda")
				or string.find(k, "cosmicgorilla")
				or string.find(k, "cosmic gorilla")
				or string.find(k, "ankylosaurus")
				or string.find(k, "orca")
			then
				return 2, "Mythic"
			end
			if
				string.find(k, "spideron")
				or string.find(k, "crustacia")
				or string.find(k, "salamander")
				or string.find(k, "cosmicgecko")
				or string.find(k, "cosmic gecko")
				or string.find(k, "pterodactyl")
				or string.find(k, "sharkegg")
				or string.find(k, "shark egg")
			then
				return 1, "Legendary"
			end
			if string.find(k, "crane") or string.find(k, "centapede") or string.find(k, "swordfish") then
				return 0.5, "Epic"
			end
			if string.find(k, "dodo") or string.find(k, "parrotfish") then
				return 0.3, "Rare"
			end
			local a = tonumber(e.EarningRate or e.Income or 0)
			if a and a >= 150000000 then
				return 4, "Secret"
			end
			local o = (y and (y ~= "Unknown" and y)) or "Common"
			local V = F[o] or 0
			return V, o
		end
		local function a(r, y, ...)
			local u = {}
			for e, r in ipairs(e) do
				local j = (r.State == "Slot" or r.State == "Dropped" or r.State == "GuardCarried" or r.State == 1)
				local a = (r.BoundsCFrame and r.BoundsCFrame.Position.X < 530)
					or string.find(tostring(r.Uid), "FirstArea")
				local o = X4[r.Uid] and (os.clock() < X4[r.Uid])
				if j and (not a and ((y or not o) and r.BoundsCFrame)) then
					local e = r.AssetCategory or "Egg"
					local y = 0
					local j = 0
					local a = 0
					local o = "Unknown"
					if p then
						pcall(function(...)
							if p.RarityRankForCategory then
								y = p.RarityRankForCategory(e) or 0
							end
							if p.ProfileIncomePerSecond then
								j = p.ProfileIncomePerSecond(e) or 0
							end
							if p.SalePrice then
								a = p.SalePrice(e) or 0
							end
							if p.Assets and p.Assets[e] then
								local y = p.Assets[e]
								o = y.Rarity or (y.Egg and y.Egg.Rarity) or "Unknown"
								if not j or j == 0 then
									j = y.EarningRate or (y.Egg and y.Egg.EarningRate) or 0
								end
							end
						end)
					end
					local V = r.BoundsCFrame.Position.X
					local H = r.BoundsCFrame.Position
					local t = r.AreaId
					if (not t or t == "" or t == "Unknown") and r.PhysicalModel then
						t = r.PhysicalModel:GetAttribute("AreaId") or r.PhysicalModel:GetAttribute("Area")
					end
					local B = string.format(
						"%s %s %s %s",
						tostring(e or ""),
						tostring(r.Uid or ""),
						tostring(r.Name or ""),
						(r.PhysicalModel and r.PhysicalModel.Name) or ""
					)
					local J = Dk(t, H, B)
					local K, c = k(r, e, o, y)
					local v = (K >= 4 or c == "Secret" or c == "Eternal" or c == "Divine")
					local i = (h.selectedZones and h.selectedZones[J] == true)
					local R = (h.selectedRarities and h.selectedRarities[c] == true)
					local g = false
					if v then
						g = true
					else
						if i and R then
							g = true
						end
					end
					
					local k0 = tonumber(r.AssetScale or r.Scale) or 1
					local a0 = 1
					if r.Mutations and type(r.Mutations) == "table" then
						for e2, r2 in pairs(r.Mutations) do
							local y2 = (type(r2) == "table" and tonumber(r2.Multiplier or r2.Value))
								or tonumber(r2)
								or 1.5
							a0 = a0 * y2
						end
					elseif r.Mutation then
						a0 = 1.5
					end
					local o0 = (j * k0) * a0
					local V0 = f[J] or 50
					if o0 <= 0 then
						o0 = (((V0 ^ 2) * k0) * a0) * 10
					end
					if g and h._cfgStealPass and not h._cfgStealPass(r, o0) then
						g = false
					end
					if g then
						local k = k0
						local a = a0
						local o = o0
						local V = V0
						local H = ((w - r.BoundsCFrame.Position)).Magnitude
						table.insert(
							u,
							{
								["Uid"] = r.Uid,
								["Category"] = tostring(e),
								["Area"] = tostring(J),
								["ZoneWeight"] = V,
								["Rarity"] = tostring(c),
								["RarityTier"] = K,
								["Rank"] = y,
								["Income"] = j,
								["RealIncome"] = o,
								["Scale"] = k,
								["MutMultiplier"] = a,
								["CFrame"] = r.BoundsCFrame,
								["Position"] = r.BoundsCFrame.Position,
								["Distance"] = H,
								["Model"] = r.PhysicalModel,
							}
						)
					end
				end
			end
			if #u == 0 then
				return nil
			end
			local function a(e, ...)
				local r = e.RarityTier or 0
				local y = e.ZoneWeight or 50
				if r >= 4 then
					return (400000 + (r * 10000)) + y
				else
					return (y * 11) + (r * 1000)
				end
			end
			table.sort(u, function(e, r, ...)
				local y = a(e)
				local u = a(r)
				if y ~= u then
					return y > u
				end
				if e.ZoneWeight ~= r.ZoneWeight then
					return e.ZoneWeight > r.ZoneWeight
				end
				if math.abs(e.RealIncome - r.RealIncome) > 1 then
					return e.RealIncome > r.RealIncome
				end
				if math.abs(e.Scale - r.Scale) > 0.05 then
					return e.Scale > r.Scale
				end
				return e.Distance < r.Distance
			end)
			local o = u[1]
			local V = {}
			for e = 1, math.min(3, #u), 1 do
				local r = u[e]
				table.insert(
					V,
					string.format(
						"#%d %s[%s|%s] Score:%d $%s/s (%.1fx) dist=%dm",
						e,
						tostring(r.Category),
						tostring(r.Rarity),
						tostring(r.Area),
						a(r),
						j(r.RealIncome),
						tonumber(r.Scale) or 1,
						math.floor(tonumber(r.Distance) or 0)
					)
				)
			end
			if #V > 0 then
				H("[AutoSteal] " .. table.concat(V, " | "))
			end
			return o
		end
		local V = a(false, false)
		if not V then
			X4 = {}
			V = a(false, true)
		end
		if not V then
			e = h4(true)
			V = a(false, true)
		end
		if V and r:FindFirstChild("AreaEggSlotsClient") then
			for e, r in ipairs(r.AreaEggSlotsClient:GetChildren()) do
				local y = r:FindFirstChildWhichIsA("BasePart") or r.PrimaryPart
				if y and ((y.Position - V.Position)).Magnitude <= 12 then
					V.Model = r
					break
				end
			end
		end
		return V
	end
	U4 = function(e, u, w, j, ...)
	
	pcall(function() if e then h.currentTargetUid = e end end)
		local k = o.Character
		local a = k and k:FindFirstChild("HumanoidRootPart")
		local V = k and k:FindFirstChildOfClass("Humanoid")
		if not a or not V then
			return false
		end
		h.securingEgg = true
		h.isReturning = false
		h.stateTime = os.clock()
		h.holdingEggForGuard = true
		local s = u.Position
		V4(s, 14)
		h.currentTargetModel = w
		h.targetPosition = s
		a.AssemblyLinearVelocity = Vector3.zero
		a.AssemblyAngularVelocity = Vector3.zero
		Z4(k)
		pcall(function(...)
			o:RequestStreamAroundAsync(s)
		end)
		if not w and r:FindFirstChild("AreaEggSlotsClient") then
			for e, r in ipairs(r.AreaEggSlotsClient:GetChildren()) do
				local y = r:FindFirstChildWhichIsA("BasePart") or r.PrimaryPart
				if y and ((y.Position - s)).Magnitude <= 16 then
					w = r
					h.currentTargetModel = r
					break
				end
			end
		end
		if w then
			pcall(function(...)
				for r, y in ipairs(w:GetDescendants()) do
					if
						y:IsA("BasePart")
						and (
							y.Transparency > 0.8
							and (y.Name ~= "Hitbox" and (y.Name ~= "Root" and not y.Name:find("Pad")))
						)
					then
						y.Transparency = 0
					end
				end
			end)
		end
		h.statusText = "[1/4] Lifting Egg to Trigger Guard..."
		H(string.format("[GuardStrike] Step 1: Lifting target egg (%s)...", tostring(e)))
		local p = os.clock() + 3.5
		local B = 0
		while not w4() and (os.clock() < p and (h.alive and h.securingEgg)) do
			if j and O4 ~= j then
				t("[GuardStrike] Cancelled by session switch in Step 1")
				break
			end
			if not h.pureTweenFarm and (not h.autoFarmLoop and not h.teleporting) then
				break
			end
			if e and (os.clock() - B > 0.4) then
				B = os.clock()
				local r, y = k4(e)
				if not r and y == "CarriedByOther" then
					t(
						string.format(
							"[GuardStrike] Target egg %s was snatched by another player! Aborting pickup...",
							tostring(e)
						)
					)
					break
				end
			end
			k:PivotTo(u * CFrame.new(0, 0.4, 0))
			d4(w, s)
			if e and i then
				task.spawn(function(...)
					pcall(function(...)
						if i:IsA("RemoteFunction") then
							i:InvokeServer({ ["Uid"] = e })
							i:InvokeServer(e)
						else
							i:FireServer({ ["Uid"] = e })
							i:FireServer(e)
						end
					end)
				end)
			end
			y.Heartbeat:Wait()
		end
		if not w4() then
			t("[GuardStrike] Initial egg pickup timed out or egg was stolen")
			if e then
				X4[e] = os.clock() + 0.8
			end
			h.currentTargetModel = nil
			h.targetPosition = nil
			h.securingEgg = false
			h.holdingEggForGuard = false
			return false
		end
		h.statusText = "[2/4] Waiting for Guard Strike..."
		H("[GuardStrike] Step 2: Egg lifted! Triggering guard strike...")
		local J = os.clock()
		local K = J + 4.5
		local c = false
		while w4() and (os.clock() < K and (h.alive and h.securingEgg)) do
			if j and O4 ~= j then
				t("[GuardStrike] Cancelled by session switch in Step 2")
				break
			end
			if not h.pureTweenFarm and (not h.autoFarmLoop and not h.teleporting) then
				break
			end
			k:PivotTo(u * CFrame.new(0, 0.4, 0))
			V4(s, 14)
			if P and not c then
				task.spawn(function(...)
					pcall(function(...)
						if P:IsA("RemoteFunction") then
							P:InvokeServer()
						else
							P:FireServer()
						end
					end)
				end)
				c = true
			end
			y.Heartbeat:Wait()
		end
		h.statusText = "[3/4] Re-grabbing Egg..."
		H("[GuardStrike] Step 3: Guard struck! Re-grabbing egg...")
		local v = os.clock() + 3
		while not w4() and (os.clock() < v and (h.alive and h.securingEgg)) do
			if j and O4 ~= j then
				t("[GuardStrike] Cancelled by session switch in Step 3")
				break
			end
			if not h.pureTweenFarm and (not h.autoFarmLoop and not h.teleporting) then
				break
			end
			k:PivotTo(u * CFrame.new(0, 0.4, 0))
			d4(w, s)
			if e and i then
				task.spawn(function(...)
					pcall(function(...)
						if i:IsA("RemoteFunction") then
							i:InvokeServer({ ["Uid"] = e })
							i:InvokeServer(e)
						else
							i:FireServer({ ["Uid"] = e })
							i:FireServer(e)
						end
					end)
				end)
			end
			y.Heartbeat:Wait()
		end
		local R = j4(e)
		if not R then
			task.wait(0.008)
			R = j4(e)
		end
		h.currentTargetModel = nil
		h.targetPosition = nil
		h.securingEgg = false
		h.holdingEggForGuard = false
		if j and O4 ~= j then
			return false
		end
		if R then
			pcall(u4)
			H("[GuardStrike] Egg successfully secured after guard strike! Stashed in backpack.")
			h.statusText = "Egg Secured! Tweening along Z=-360..."
		else
			t("[-] Failed to re-grab egg after guard strike (stolen or despawned)")
			h.statusText = "[-] Failed to re-grab egg"
			if e then
				X4[e] = os.clock() + 0.8
			end
		end
		return R
	end
	l4 = function(e, u, ...)
		if h.teleporting or h.glidingToTarget or h.delivering or h.securingEgg then
			return false
		end
		h.teleporting = true
		h.isReturning = false
		h.stateTime = os.clock()
		local w = o.Character
		local j = w and w:FindFirstChild("HumanoidRootPart")
		local k = w and w:FindFirstChildOfClass("Humanoid")
		if not j or not k then
			D4()
			return false
		end
		if k then
			k:UnequipTools()
		end
		h.statusText = "[1/7] Pre-Flight Desync..."
		if not h.swapped then
			A4()
		end
		if not h.godmode then
			b4(true)
		end
		Z4(w)
		if not e then
			e = N4()
		end
		local a = e and e.CFrame or S
		local V = e and e.Uid
		local H = a.Position
		if V then
			local e, r = k4(V)
			if not e and r ~= "CarriedBySelf" then
				t(
					string.format(
						"[Snipe] Target egg %s is already taken (%s)! Selecting next target...",
						tostring(V),
						tostring(r)
					)
				)
				h.statusText = "Target taken by another player!"
				X4[V] = os.clock() + 1.2
				D4()
				return false
			end
		end
		local s = select(2, e4())
		if not s then
			local e = P4()
			if not e then
				t("[-] Lake egg not found")
				h.statusText = "[-] No Lake egg found"
				D4()
				return false
			end
			h.currentTargetModel = e.Model
			h.targetPosition = e.Position
			local r = ((j.Position - e.Position)).Magnitude
			local w = e.CFrame * CFrame.new(0, 0.4, 0)
			pcall(function(...)
				o:RequestStreamAroundAsync(e.Position)
			end)
			V4(e.Position, 8)
			if r > 60 then
				h.statusText = string.format("[2/7] Gliding to Lake Egg (%.0f studs)...", r)
				h.glidingToTarget = true
				local y = R4(w, h.glideSpeed, e.Uid, u)
				h.glidingToTarget = false
				if not y then
					t("[-] Lake starter egg was taken during flight")
					X4[e.Uid] = os.clock() + 5
					D4()
					return false
				end
			else
				h.statusText = "[2/7] Aligning with Lake Egg..."
				j.CFrame = w
				j.AssemblyLinearVelocity = Vector3.zero
				task.wait(0.008)
			end
			j.Anchored = true
			task.wait(0.008)
			j.Anchored = false
			h.holdingEggForGuard = true
			local k = os.clock() + 3
			while not w4() and (os.clock() < k and (h.alive and h.teleporting)) do
				if u and O4 ~= u then
					t("[Snipe] Cancelled by session switch during Lake egg pickup")
					D4()
					return false
				end
				if not h.autoFarmLoop and not h.teleporting then
					D4()
					return false
				end
				d4(e.Model, e.Position)
				if e.Uid and i then
					task.spawn(function(...)
						pcall(function(...)
							if i:IsA("RemoteFunction") then
								i:InvokeServer({ ["Uid"] = e.Uid })
							else
								i:FireServer({ ["Uid"] = e.Uid })
							end
						end)
					end)
				end
				y.Heartbeat:Wait()
			end
			s = select(2, e4())
			if not w4() then
				t("[-] Lake egg pickup failed")
				h._stealFails = (h._stealFails or 0) + 1
				if h._stealFails >= 3 then h._stealFails=0; h.statusText="[Steal] 3x gagal - auto turunin"; pcall(function() local hrp=o.Character and o.Character:FindFirstChild("HumanoidRootPart"); if hrp then hrp.CFrame=hrp.CFrame-Vector3.new(0,5,0) end; task.wait(0.7) end) end
				h.statusText = "[-] Lake pickup failed"
				D4()
				return false
			end
		end
		h.statusText = "[3/7] Pre-streaming Target..."
		pcall(function(...)
			o:RequestStreamAroundAsync(H)
		end)
		V4(H, 12)
		h.statusText = "[4/7] Waiting for physical bounce..."
		j.Anchored = false
		k:ChangeState(Enum.HumanoidStateType.Running)
		local p = (k.WalkSpeed > 0) and k.WalkSpeed or 16
		k.WalkSpeed = 0
		k:Move(Vector3.zero, false)
		j.AssemblyLinearVelocity = Vector3.zero
		j.AssemblyAngularVelocity = Vector3.zero
		task.wait(0.008)
		local B = j.Position
		local J = B.Y
		local K = select(2, e4()) or s
		local c = false
		local v = nil
		if N and N:IsA("RemoteEvent") then
			v = N.OnClientEvent:Connect(function(...)
				c = true
				if v then
					v:Disconnect()
				end
			end)
		end
		h.holdingEggForGuard = true
		H4(K)
		local R = os.clock()
		local g = false
		local Q = os.clock() + 2.5
		local P = false
		while os.clock() < Q and (h.alive and h.teleporting) do
			if u and O4 ~= u then
				t("[Snipe] Cancelled by session switch during strike bounce")
				if v then
					v:Disconnect()
				end
				k.WalkSpeed = p
				D4()
				return false
			end
			local e = os.clock() - R
			local r = j.AssemblyLinearVelocity
			local w = j.Position
			local a = w.Y - J
			local o = ((w - B)).Magnitude
			if e >= 0.08 then
				local e = c or (r.Y >= 10) or (a >= 1.5 and r.Magnitude >= 16) or (o >= 2) or (r.Magnitude >= 20)
				if e then
					g = true
					break
				end
			end
			if e >= 0.5 and not P then
				P = true
				H4(K)
			end
			y.Heartbeat:Wait()
		end
		if v then
			v:Disconnect()
		end
		k.WalkSpeed = p
		h.holdingEggForGuard = false
		if not g then
			t("[-] No bounce detected, aborting")
			h.statusText = "[-] Aborted (No bounce detected)"
			D4()
			pcall(u4)
			return false
		end
		task.wait(0.008)
		if V then
			local e, r = k4(V)
			if not e and r == "CarriedByOther" then
				t(
					string.format(
						"[Snipe] Target egg %s was snatched while bouncing (%s)! Aborting warp...",
						tostring(V),
						tostring(r)
					)
				)
				h.statusText = "Target taken! Aborting warp..."
				X4[V] = os.clock() + 1.2
				D4()
				return false
			end
		end
		h.currentTargetModel = e and e.Model
		h.targetPosition = H
		h.statusText = "[5/7] Warping to Target Egg..."
		V4(H, 8)
		w:PivotTo(a * CFrame.new(0, 0.4, 0))
		j.Anchored = true
		for e, r in ipairs(w:GetDescendants()) do
			if r:IsA("BasePart") then
				r.AssemblyLinearVelocity = Vector3.zero
				r.AssemblyAngularVelocity = Vector3.zero
			end
		end
		h.statusText = "[6/7] Picking up Target Egg..."
		local U = o:FindFirstChild("Backpack")
		for e, y in ipairs(w:GetChildren()) do
			if y:IsA("Tool") then
				pcall(function(...)
					if U then
						y.Parent = U
					else
						y.Parent = r
					end
				end)
			end
		end
		task.wait(0.008)
		j.Anchored = false
		k:ChangeState(Enum.HumanoidStateType.Running)
		local l = U4(V, a, e and e.Model, u)
		j.Anchored = false
		k:ChangeState(Enum.HumanoidStateType.Running)
		for e, r in ipairs(w:GetDescendants()) do
			if r:IsA("BasePart") then
				r.AssemblyLinearVelocity = Vector3.zero
				r.AssemblyAngularVelocity = Vector3.zero
			end
		end
		if not l then
			t("[-] Guard Strike criteria not met")
			h.statusText = "[-] Guard Strike criteria failed"
			D4()
			return false
		else
			h.statusText = "[7/7] Target Secured! Stashing into Backpack..."
			h.teleporting = false
			pcall(u4)
			return true
		end
	end
	T4 = function(e, ...)
		if Y4 == e then
			return
		end
		O4 = O4 + 1
		local r = O4
		Y4 = "SWITCHING"
		h.pureTweenFarm = false
		h.autoFarmLoop = false
		pcall(D4)
		pcall(u4)
		if e == "TWEEN" then
			if W4 then
				W4(false, true)
			end
			if x4 then
				x4(true, true)
			end
		elseif e == "WARP" then
			if x4 then
				x4(false, true)
			end
			if W4 then
				W4(true, true)
			end
		else
			if x4 then
				x4(false, true)
			end
			if W4 then
				W4(false, true)
			end
		end
		task.delay(0.06, function(...)
			if O4 == r then
				Y4 = e
				if e == "TWEEN" or e == "WARP" then
					pcall(b4, true)
					if godToggleSetter then
						pcall(godToggleSetter, true)
					end
				end
				if e == "TWEEN" then
					h.pureTweenFarm = true
					h.autoFarmLoop = false
					pcall(u4)
					H("[FarmController] Pure Auto Steal (Tween) ACTIVATED exclusively.")
				elseif e == "WARP" then
					h.autoFarmLoop = true
					h.pureTweenFarm = false
					pcall(u4)
					H("[FarmController] Snipe Auto Loop (Warp) ACTIVATED exclusively.")
				else
					h.pureTweenFarm = false
					h.autoFarmLoop = false
					if not h.isBatchPlacing then
						h.batchStealCount = 0
					end
					H("[FarmController] All farms DEACTIVATED. Bot idle.")
				end
			end
		end)
	end
	local Ck = os.clock()
	task.spawn(function(...)
		while h.alive do
			local r, y = pcall(function(...)
				if
					h.pureTweenFarm
					and (
						not h.autoFarmLoop
						and (
							Y4 == "TWEEN"
							and (
								not h.isBatchPlacing
								and (
									not h.teleporting
									and (
										not h.glidingToTarget
										and (not h.securingEgg and (not h.delivering and not h.isReturning))
									)
								)
							)
						)
					)
				then
					local r = o.Character
					local y = r and r:FindFirstChild("HumanoidRootPart")
					local u = r and r:FindFirstChildOfClass("Humanoid")
					if y and u then
						pcall(u4)
						local u = w4()
						if not u then
							local u = O4
							local w = N4()
							if w and w.Uid then h.currentTargetUid = w.Uid end
							if w and (h.pureTweenFarm and (Y4 == "TWEEN" and O4 == u)) then
								if h.onTreadmill or L4() then
									h.statusText = "[AutoSteal] Target found! Getting off treadmill..."
									M4()
									task.wait(0.01)
								end
								local j, k = k4(w.Uid)
								if not j and k ~= "CarriedBySelf" then
									H(
										string.format(
											"[AutoSteal] Egg %s already taken (%s). Switching to next target...",
											tostring(w.Uid),
											tostring(k)
										)
									)
									X4[w.Uid] = os.clock() + 1.2
									task.wait(0.008)
									return
								end
								h.currentTargetModel = w.Model
								h.targetPosition = w.Position
								h.glidingToTarget = true
								h.stateTime = os.clock()
								local a = (w.Scale and w.Scale > 1.05) and string.format(" | %.1fx", w.Scale) or ""
								h.statusText = string.format(
									"[AutoSteal] Flying to %s (%s%s)...",
									tostring(w.Category or "Egg"),
									tostring(w.Area or "Field"),
									a
								)
								H(
									string.format(
										"[AutoSteal] Flying to %s | Zone: %s%s | Rank: %d (Corridor Z=-360)",
										tostring(w.Category or "Egg"),
										tostring(w.Area or "Field"),
										a,
										tonumber(w.Rank) or 1
									)
								)
								if not h.swapped then
									A4()
								end
								if not h.godmode then
									b4(true)
								end
								Z4(r)
								pcall(function(...)
									o:RequestStreamAroundAsync(w.Position)
								end)
								local V = w.CFrame * CFrame.new(0, 0.4, 0)
								local s = R4(V, h.glideSpeed, w.Uid, u)
								h.glidingToTarget = false
								if O4 ~= u or not h.pureTweenFarm or Y4 ~= "TWEEN" then
									return
								end
								if not s then
									t("[AutoSteal] Egg was taken during flight. Switching to next target...")
									X4[w.Uid] = os.clock() + 1.2
									D4()
									return
								end
								if
									h.pureTweenFarm and (Y4 == "TWEEN" and ((y.Position - w.Position)).Magnitude <= 22)
								then
									local r = U4(w.Uid, V, w.Model, u)
									if not r and w4() then
										r = true
									end
									if O4 ~= u or not h.pureTweenFarm or Y4 ~= "TWEEN" then
										return
									end
									if r then
										pcall(u4)
										if h.autoGlide then
											h.statusText = "[AutoSteal] Secured! Tweening to Safe Line X=525..."
											H(
												"[AutoSteal] Egg secured after Guard Strike! Returning smoothly to Safe Line X=525 along Z=-360..."
											)
											Q4(h.glideSpeed, u)
											pcall(u4)
											local r = y4()
											h.statusText = string.format("Stashed in Bag (%d Eggs). Next steal...", r)
											H(
												string.format(
													"[AutoSteal] Egg stashed in bag (%d total eggs). Hands-Free ready for next steal...",
													r
												)
											)
										else
											h.statusText = "[AutoSteal] Secured! (Auto Return is OFF)"
											H("[AutoSteal] Egg secured! Staying at target (Auto Return is OFF).")
										end
										pcall(u4)
										h.isReturning = false
										h.delivering = false
										h.glidingToTarget = false
										h.securingEgg = false
										h.currentTargetModel = nil
										h.targetPosition = nil
										if c4("TWEEN") then
											return
										end
									else
										if O4 == u and (h.pureTweenFarm and Y4 == "TWEEN") then
											t("[AutoSteal] Guard Strike or Re-grab failed. Retrying...")
										h._stealFails = (h._stealFails or 0) + 1
										if h._stealFails >= 3 then h._stealFails=0; pcall(function() local hrp=o.Character and o.Character:FindFirstChild("HumanoidRootPart"); if hrp then hrp.CFrame=hrp.CFrame-Vector3.new(0,5,0) end; h.currentTargetUid=nil; task.wait(0.7) end) end
											X4[w.Uid] = os.clock() + 1.2
											D4()
										end
									end
								else
									h.currentTargetModel = nil
									h.targetPosition = nil
									h.glidingToTarget = false
								end
							else
								if os.clock() - Ck > 5 then
									X4 = {}
									Ck = os.clock()
								end
								if h.autoTreadmill and (not h.isBatchPlacing and not h.isHatching) then
									if not h.onTreadmill and not L4() then
										h.statusText = "[AutoTreadmill] No targets. Mounting treadmill..."
										f4(u)
									else
										h.statusText = "[AutoTreadmill] Running on treadmill (Waiting for eggs...)"
									end
								else
									h.statusText = "[AutoSteal] Scanning for targets..."
								end
							end
						end
					end
				end
			end)
			if not r then
				t("[AutoSteal Loop Recovered]:", tostring(y))
				pcall(D4)
			end
			task.wait(0.01)
		end
	end)
	local qk = os.clock()
	task.spawn(function(...)
		while h.alive do
			local r, y = pcall(function(...)
				if
					h.autoFarmLoop
					and (
						not h.pureTweenFarm
						and (
							Y4 == "WARP"
							and (
								not h.isBatchPlacing
								and (
									not h.teleporting
									and (
										not h.glidingToTarget
										and (not h.securingEgg and (not h.delivering and not h.isReturning))
									)
								)
							)
						)
					)
				then
					local r = o.Character
					local y = r and r:FindFirstChild("HumanoidRootPart")
					local u = r and r:FindFirstChildOfClass("Humanoid")
					if y and u then
						pcall(u4)
						local r = w4()
						if not r then
							local r = O4
							local y = N4()
							if y and y.Uid then h.currentTargetUid = y.Uid end
							if y and (h.autoFarmLoop and (Y4 == "WARP" and O4 == r)) then
								if h.onTreadmill or L4() then
									h.statusText = "[SnipeLoop] Target found! Getting off treadmill..."
									M4()
									task.wait(0.01)
								end
								local u = (y.Scale and y.Scale > 1.05) and string.format(" | %.1fx", y.Scale) or ""
								H(
									string.format(
										"[SnipeLoop] Starting Warp Snipe: %s | Zone: %s%s (Rank %d)",
										tostring(y.Category or "Egg"),
										tostring(y.Area or "Field"),
										u,
										tonumber(y.Rank) or 1
									)
								)
								h.statusText =
									string.format("[SnipeLoop] Warping for %s%s...", tostring(y.Category or "Egg"), u)
								local w = l4(y, r)
								if O4 ~= r or not h.autoFarmLoop or Y4 ~= "WARP" then
									return
								end
								if w then
									pcall(u4)
									if h.autoGlide then
										h.statusText = "[SnipeLoop] Target secured! Tweening to Safe Line X=525..."
										Q4(h.glideSpeed, r)
										pcall(u4)
										local y = y4()
										h.statusText = string.format("Stashed in Bag (%d Eggs). Next snipe...", y)
										H(
											string.format(
												"[SnipeLoop] Egg stashed in bag (%d total eggs). Hands-Free ready for next snipe...",
												y
											)
										)
									else
										h.statusText = "[SnipeLoop] Target secured! (Auto Return is OFF)"
										H("[SnipeLoop] Snipe successful! Staying at target (Auto Return is OFF).")
									end
									pcall(u4)
									h.isReturning = false
									h.delivering = false
									if c4("WARP") then
										return
									end
								else
									if O4 == r and (h.autoFarmLoop and Y4 == "WARP") then
										t("[SnipeLoop] Snipe cycle failed. Resetting for next target...")
										if y and y.Uid then
											X4[y.Uid] = os.clock() + 5
										end
										pcall(D4)
									end
								end
							else
								if os.clock() - qk > 5 then
									X4 = {}
									qk = os.clock()
								end
								if h.autoTreadmill and (not h.isBatchPlacing and not h.isHatching) then
									if not h.onTreadmill and not L4() then
										h.statusText = "[AutoTreadmill] No targets. Mounting treadmill..."
										f4(r)
									else
										h.statusText = "[AutoTreadmill] Running on treadmill (Waiting for eggs...)"
									end
								else
									h.statusText = "[SnipeLoop] Searching for targets..."
								end
							end
						end
					end
				end
			end)
			if not r then
				t("[SnipeLoop Loop Recovered]:", tostring(y))
				pcall(D4)
			end
			task.wait(0.01)
		end
	end)
	task.spawn(function(...)
		while h.alive do
			local r, y = pcall(function(...)
				if
					h.autoTreadmill
					and (
						not h.pureTweenFarm
						and (
							not h.autoFarmLoop
							and (
								not h.isBatchPlacing
								and (
									not h.isHatching
									and (
										not h.teleporting
										and (
											not h.glidingToTarget
											and (not h.securingEgg and (not h.delivering and not h.isReturning))
										)
									)
								)
							)
						)
					)
				then
					local e = o.Character
					local y = e and e:FindFirstChild("HumanoidRootPart")
					if y and not w4() then
						if not h.onTreadmill and not L4() then
							h.statusText = "[AutoTreadmill] Idle without farm. Mounting treadmill..."
							f4()
						end
					end
				end
			end)
			task.wait(0.25)
		end
	end)
	task.spawn(function(...)
		while h.alive do
			pcall(function(...)
				if h.autoUpgradeTreadmill then
					pk()
				end
			end)
			task.wait(2.5)
			pcall(function(...)
				if h.autoBuyTrails then
					gk()
				end
			end)
			task.wait(2.5)
		end
	end)
	task.spawn(function(...)
		while h.alive do
			if h.autoHatch and (not h.securingEgg and (not h.teleporting and not h.isHatching)) then
				pcall(function(...)
					J4(false)
				end)
			end
			task.wait(4)
		end
	end)
	local nk = nil
	local function fk(e, ...)
		pcall(function(...)
			if e:IsA("BasePart") then
				e.Material = Enum.Material.SmoothPlastic
				e.Reflectance = 0
				e.CastShadow = false
				if e:IsA("MeshPart") then
					e.TextureID = ""
					pcall(function(...)
						e.RenderFidelity = Enum.RenderFidelity.Performance
					end)
					pcall(function(...)
						e.CollisionFidelity = Enum.CollisionFidelity.Box
					end)
				end
			elseif e:IsA("SpecialMesh") then
				e.TextureId = ""
			elseif e:IsA("Decal") or e:IsA("Texture") or e:IsA("SurfaceAppearance") then
				e.Transparency = 1
			elseif
				e:IsA("ParticleEmitter")
				or e:IsA("Trail")
				or e:IsA("Smoke")
				or e:IsA("Fire")
				or e:IsA("Sparkles")
			then
				e.Enabled = false
			elseif e:IsA("Beam") then
				e.Enabled = false
			elseif e:IsA("Explosion") then
				e.Visible = false
			elseif e:IsA("Light") or e:IsA("PointLight") or e:IsA("SpotLight") or e:IsA("SurfaceLight") then
				e.Enabled = false
			elseif e:IsA("Highlight") and e.Name ~= "EggESP_Highlight" then
				e.Enabled = false
			end
		end)
	end
	local function Mk(...)
		h.performanceMode = true
		pcall(function(...)
			local e = r:FindFirstChild("CloutHub_EggESP")
			if e then
				e:Destroy()
			end
			local y = game:GetService("Lighting")
			y.GlobalShadows = false
			y.FogEnd = 9000000000
			y.Brightness = 1
			y.ClockTime = 14
			y.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
			for e, r in ipairs(y:GetChildren()) do
				if
					r:IsA("PostEffect")
					or r:IsA("BloomEffect")
					or r:IsA("BlurEffect")
					or r:IsA("ColorCorrectionEffect")
					or r:IsA("SunRaysEffect")
					or r:IsA("DepthOfFieldEffect")
					or r:IsA("Atmosphere")
				then
					pcall(function(...)
						r.Enabled = false
					end)
				elseif r:IsA("Sky") then
					pcall(function(...)
						r.Parent = nil
					end)
				end
			end
			local u = workspace:FindFirstChildOfClass("Terrain")
			if u then
				pcall(function(...)
					u.Decoration = false
					u.WaterWaveSize = 0
					u.WaterWaveSpeed = 0
					u.WaterReflectance = 0
					u.WaterTransparency = 0
				end)
			end
			for e, r in ipairs(workspace:GetDescendants()) do
				fk(r)
			end
			if not nk then
				nk = workspace.DescendantAdded:Connect(function(e, ...)
					if h.performanceMode then
						fk(e)
					end
				end)
			end
			pcall(function(...)
				if settings and (settings()).Rendering then
					(settings()).Rendering.QualityLevel = 1
				end
			end)
		end)
	end
	local function Ik(...)
		h.performanceMode = false
		if nk then
			pcall(function(...)
				nk:Disconnect()
			end)
			nk = nil
		end
		pcall(function(...)
			local e = game:GetService("Lighting")
			e.GlobalShadows = true
			for e, r in ipairs(e:GetChildren()) do
				if
					r:IsA("PostEffect")
					or r:IsA("BloomEffect")
					or r:IsA("BlurEffect")
					or r:IsA("ColorCorrectionEffect")
					or r:IsA("SunRaysEffect")
					or r:IsA("DepthOfFieldEffect")
					or r:IsA("Atmosphere")
				then
					pcall(function(...)
						r.Enabled = true
					end)
				end
			end
			local r = workspace:FindFirstChildOfClass("Terrain")
			if r then
				pcall(function(...)
					r.Decoration = true
				end)
			end
		end)
	end
	local Lk = false
	local function Ek(...)
		pcall(function(...)
			local e = game:GetService("VirtualInputManager")
			if e then
				e:SendKeyEvent(true, Enum.KeyCode.Escape, false, game)
				task.wait(0.008)
				e:SendKeyEvent(false, Enum.KeyCode.Escape, false, game)
				task.wait(0.12)
				e:SendKeyEvent(true, Enum.KeyCode.Escape, false, game)
				task.wait(0.008)
				e:SendKeyEvent(false, Enum.KeyCode.Escape, false, game)
				pcall(function(...)
					if typeof(e.SendTouchEvent) == "function" then
						e:SendTouchEvent(99999, 0, 15, 15)
						task.wait(0.008)
						e:SendTouchEvent(99999, 2, 15, 15)
					end
				end)
			end
		end)
		pcall(function(...)
			if typeof(mousemoverel) == "function" then
				mousemoverel(1, 0)
				task.wait(0.008)
				mousemoverel(-1, 0)
			end
		end)
	end
	local function bk(...)
		if Lk then
			return
		end
		Lk = true
		task.spawn(function(...)
			while h and (h.alive and h.antiAFK) do
				local r = 0
				while r < 600 and (h and (h.alive and (h.antiAFK and Lk))) do
					task.wait(2.5)
					r = r + 5
				end
				if not h.antiAFK or not Lk then
					break
				end
				Ek()
			end
			Lk = false
		end)
	end
	local function Ak(...)
		Lk = false
	end
	y.Heartbeat:Connect(function(...)
		local e = o.Character
		local r = e and e:FindFirstChild("HumanoidRootPart")
		local y = e and e:FindFirstChildOfClass("Humanoid")
		if not r then
			return
		end
		if y and not (h and h.onTreadmill) then
			if y.PlatformStand then
				y.PlatformStand = false
				y:ChangeState(Enum.HumanoidStateType.Running)
			end
			if y.Sit and (h.pureTweenFarm or h.autoFarmLoop or h.isReturning or h.glidingToTarget) then
				y.Sit = false
				y:ChangeState(Enum.HumanoidStateType.Running)
			end
		end
		local u = r.Position
		local w = w4()
		if u.Y < 45 then
			r.CFrame = CFrame.new(u.X, 72, u.Z)
			r.AssemblyLinearVelocity = Vector3.zero
			return
		end
		if (h.pureTweenFarm or h.autoFarmLoop) and not h.holdingEggForGuard then
			local r = false
			for e, y in ipairs(e:GetChildren()) do
				if y:IsA("Tool") then
					r = true
					break
				end
			end
			if r then
				u4()
			end
		end
		if
			h.pureTweenFarm
			or h.autoFarmLoop
			or h.teleporting
			or h.glidingToTarget
			or h.delivering
			or h.securingEgg
			or h.isReturning
		then
			return
		end
		if h.alive and (h.autoGlide and (w and (not a4() and u.X > E))) then
			task.spawn(function(...)
				Q4(h.glideSpeed)
				u4()
				h.isReturning = false
				h.delivering = false
			end)
		end
	end)
	local Sk =
		"iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAedEVYdFNvZnR3YXJlAFBhaW50Lk5FVCB2My41LjEw/7R3GwAAA6BJREFUeN7tW01oE1EQnk0qih4sevCiF/Wg4kEPgqeCHsSDhyIeVIoHDx48KIKHIh48ePAgePBiPRQ8eBA8COJBD4L4B8WD4kHxov7cm2yT3WzeZjdps7t58CG72bebzPfevPlmdg3DMFwul8vlcv13qampWSKi82S2kxgiVpLZZ2T2G5lDZHaRmU9mDxEViOgqEZ1Np9N3V1ZWLlutFh1vNJvN5+12+4bf77+s/p5zIuKCiAgiGhcRLkRkCRkH+rYikYjlOE7G87w/wWBwLxKJbIeDk8mky3q31xG/37/FwR1Fq9V6Q0SX1N9tIuKNiKgiIo/bbrfb+zwez44qchRzHMcioh2Xy6Xb7fYDIsrqu5WIeBDRoohwJ2VlZaWRSCS2VNEdzZTL5ctEdF1V5Yj4QUQ8EXG73e51j8ejiojOa/V6/ZaI7tDfvUS0SUQJEXFeRNRUVVW5mZmZe/R7kZ2cTCZ1vV4/yXfO/4eQeC4iWqpQKJRkZWWl9XrdISJDRMKIyKqqqjIjI2Pj4uLiGef8lMvlYg4eE9E1VVVP9ff/c5z4n04Gg0F3PB7/TkR5dF6k4/F4v9frdc3NzbV1XW/R/2lEVBER91RVVV1TU8OHr1gsVpP198lkct5xnM/q73kiOq+O37G6uvrVdV2u1+vv6XkRkS8UCr3xeDybyuVydWVlZZlOp9v0/y/O+X41538j1b+/qKurW1bVjYg4b0xMTKyqPZ8gIs7pYx7e1/V6/bKa1xEi6k9OTnZVVVW/IqI7RLRJRHkikVhyHGdBVff9+/cf6LpOU1NTD/T3NBFxRkR00Xm1Xq/fV0U+JqK/RETJ7OzsM7vdzhw81nW9RURDRHSpWCze13Wd6/X6bVV0u6qq6mUkEtnSdV3S10z9vUtE3InpdPrB8vLybSLiTk5OTg1tQ7eP8+jo6Jqqwscikcj2wsLCGuf8FBFxJycnJ7sNDQ1rV1dXWzQ4JCKHqnK6XC5bVfS06rp+k6ry8ZWVFR4eHl4jIs4jIyN9hmF81HX9B1Xl9MTERD8RcfN4PDupVOq+67pP1H1bJpPpvb6+7hPRfVVVV0ZGRtiVlRWWSCReZ7PZX36//6Cvr48PDQ09y2azVzwez7Kqqk8556fdbvdnItpVVdUaGRmZoKqaoP6sUjKZ3B8YGGBd122qyu3j/Ojo6F1N034MDAyw6elpW1VVLhQKzH1HRkZ6m4qKiicikajlOI7ler3e9y6X643L5dqi/+NyuZ6rqvpOVdV/Kysr51wu17fW3w8AAAD//wMAe7/lQy8mR0AAAAAElFTkSuQmCC"
	local function Zk(e, ...)
		if crypt and crypt.base64decode then
			return crypt.base64decode(e)
		end
		if base64_decode then
			return base64_decode(e)
		end
		if syn and (syn.crypt and (syn.crypt.base64 and syn.crypt.base64.decode)) then
			return syn.crypt.base64.decode(e)
		end
		local r = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		local y = {}
		for e = 1, #r, 1 do
			y[r:sub(e, e)] = e - 1
		end
		e = (e:gsub("[^" .. (r .. "=]"), "")):gsub("=", "")
		local u = {}
		for r = 1, #e, 4 do
			local j = y[e:sub(r, r)] or 0
			local k = y[e:sub(r + 1, r + 1)] or 0
			local a = y[e:sub(r + 2, r + 2)]
			local o = y[e:sub(r + 3, r + 3)]
			table.insert(u, string.char(bit32.bor(bit32.lshift(j, 2), bit32.rshift(k, 4))))
			if a then
				table.insert(u, string.char(bit32.bor(bit32.lshift(bit32.band(k, 15), 4), bit32.rshift(a, 2))))
				if o then
					table.insert(u, string.char(bit32.bor(bit32.lshift(bit32.band(a, 3), 6), o)))
				end
			end
		end
		return table.concat(u)
	end
	local zk = "Clout_Hub_Icon.png"
	local dk = "rbxassetid://10734950309"
	pcall(function(...)
		if writefile and (getcustomasset or getsynasset) then
			local e = getcustomasset or getsynasset
			if not (isfile and isfile(zk)) then
				writefile(zk, Zk(Sk))
			end
			dk = e(zk)
		end
	end)
	
	
	local cloutCore = {}
	local CX = cloutCore
	local espObjects = {}
	local espSet
	local function cxNet(e, ...)
		local r = j:FindFirstChild("Packages")
		local y = r and r:FindFirstChild("Networking")
		return y and y:FindFirstChild(e)
	end
	h.antiTrap = (h.antiTrap ~= false)
	h.espMaxStuds = h.espMaxStuds or 8000
	local function espColor(e, ...)
		local r = string.lower(tostring(e or ""))
		if string.find(r, "divine") then
			return G.Divine, "Divine"
		end
		if string.find(r, "eternal") then
			return G.Eternal, "Eternal"
		end
		if string.find(r, "secret") then
			return G.Secret, "Secret"
		end
		if string.find(r, "cosmic") then
			return G.Cosmic, "Cosmic"
		end
		if string.find(r, "mythic") then
			return G.Mythic, "Mythic"
		end
		if string.find(r, "legendary") then
			return G.Legendary, "Legendary"
		end
		if string.find(r, "epic") then
			return G.Epic, "Epic"
		end
		if string.find(r, "uncommon") then
			return G.Uncommon, "Uncommon"
		end
		if string.find(r, "rare") then
			return G.Rare, "Rare"
		end
		if string.find(r, "common") then
			return G.Common, "Common"
		end
		return nil, nil
	end
	local function espEggData(e, ...)
		local y = e:GetAttribute("Category") or e:GetAttribute("AssetCategory") or e.Name
		local u = e:GetAttribute("AreaId") or e:GetAttribute("Area") or ""
		local w = e:GetAttribute("Rarity") or e:GetAttribute("RarityTier")
		local j = tonumber(e:GetAttribute("RarityRank") or e:GetAttribute("Rank") or 0) or 0
		local k = nil
		local a = nil
		if w ~= nil and (tostring(w) ~= "" and tostring(w) ~= "Unknown") then
			a, k = espColor(w)
		end
		if not a and j >= 1 then
			local o = {
				[10] = "Divine",
				[9] = "Eternal",
				[8] = "Secret",
				[7] = "Cosmic",
				[6] = "Mythic",
				[5] = "Legendary",
				[4] = "Epic",
				[3] = "Rare",
				[2] = "Uncommon",
				[1] = "Common",
			}
			if j >= 10 then
				j = 10
			end
			local V = o[j] or "Common"
			a = G[V]
			k = V
		end
		if not a then
			a = Color3.fromRGB(200, 205, 220)
			k = tostring(w or "Egg")
		end
		return tostring(y), tostring(u), k, a
	end
	local function espFolder(...)
		local e = r:FindFirstChild("CloutHub_EggESP")
		if not e then
			e = Instance.new("Folder")
			e.Name = "CloutHub_EggESP"
			e.Parent = r
		end
		return e
	end
	local function espClear(...)
		local e = r:FindFirstChild("CloutHub_EggESP")
		if e then
			e:Destroy()
		end
		espObjects = {}
	end
	local function espAnyOn(...)
		return (h.eggESP or h.trapESP) or h.playerESP
	end
	local function espRefresh(...)
		if not espAnyOn() then
			return
		end
		local e = espFolder()
		local y = {}
		local u = o.Character
		local w = u and u:FindFirstChild("HumanoidRootPart")
		local j = w and w.Position or Vector3.zero
		local k = h.espMaxStuds or 8000
		local function a(u, w, a, o, V, ...)
			y[u] = true
			local H = espObjects[u]
			if H and (H.hl and (H.hl.Parent and (H.bb and H.bb.Parent))) then
				H.hl.Adornee = w
				H.hl.FillColor3 = o
				H.hl.OutlineColor3 = o
				H.bb.Adornee = a
				H.label.TextColor3 = o
				H.label.Text = V
				return
			end
			if H then
				pcall(function(...)
					if H.hl then
						H.hl:Destroy()
					end
					if H.bb then
						H.bb:Destroy()
					end
				end)
			end
			local t = Instance.new("Highlight")
			t.Name = "EggESP_Highlight"
			t.FillColor3 = o
			t.FillTransparency = 0.55
			t.OutlineColor3 = o
			t.OutlineTransparency = 0
			t.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			t.Adornee = w
			t.Parent = e
			local s = Instance.new("BillboardGui")
			s.Name = "EggESP_Billboard"
			s.Size = UDim2.fromOffset(170, 42)
			s.StudsOffset = Vector3.new(0, 4.5, 0)
			s.AlwaysOnTop = true
			s.LightInfluence = 0
			s.MaxDistance = 10000
			s.Adornee = a
			s.Parent = e
			local p = Instance.new("TextLabel")
			p.Name = "Label"
			p.Size = UDim2.fromScale(1, 1)
			p.BackgroundTransparency = 1
			p.Font = Enum.Font.GothamBold
			p.TextSize = 12
			p.TextColor3 = o
			p.TextStrokeTransparency = 0.35
			p.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			p.Text = V
			p.Parent = s
			espObjects[u] = { ["hl"] = t, ["bb"] = s, ["label"] = p }
		end
		if h.eggESP then
			local u = r:FindFirstChild("AreaEggSlotsClient")
			if u then
				for r, w in ipairs(u:GetChildren()) do
					local H = w.PrimaryPart or w:FindFirstChildWhichIsA("BasePart", true)
					if H then
						local t = ((H.Position - j)).Magnitude
						if t <= k then
							local s, p, B, J = espEggData(w)
							a(
								"e_" .. tostring(w.Name),
								w,
								H,
								J,
								string.format("%s\n[%s] %s | %dm", s, B, p, math.floor(t + 0.5))
							)
						end
					end
				end
			end
		end
		if h.trapESP then
			local u = r:FindFirstChild("__DEBRIS")
			if u then
				for r, w in ipairs(u:GetChildren()) do
					if w.Name == "PlayerTrap" then
						local H = (w:IsA("BasePart") and w) or w:FindFirstChildWhichIsA("BasePart", true)
						if H then
							local t = ((H.Position - j)).Magnitude
							if t <= k then
								local s = tostring(w:GetAttribute("Owner") or "Enemy")
								a(
									"t_" .. tostring(r),
									w,
									H,
									Color3.fromRGB(255, 60, 60),
									string.format("[TRAP] @%s | %dm", s, math.floor(t + 0.5))
								)
							end
						end
					end
				end
			end
		end
		if h.playerESP then
			for u, w in ipairs((game:GetService("Players")):GetPlayers()) do
				if w ~= o and w.Character then
					local H = w.Character:FindFirstChild("HumanoidRootPart")
						or w.Character:FindFirstChildWhichIsA("BasePart", true)
					if H then
						local t = ((H.Position - j)).Magnitude
						if t <= k then
							a(
								"p_" .. tostring(w.Name),
								w.Character,
								H,
								Color3.fromRGB(90, 220, 120),
								string.format(
									"%s (@%s) | %dm",
									tostring(w.DisplayName),
									tostring(w.Name),
									math.floor(t + 0.5)
								)
							)
						end
					end
				end
			end
		end
		for u, w in pairs(espObjects) do
			if not y[u] then
				pcall(function(...)
					if w.hl then
						w.hl:Destroy()
					end
					if w.bb then
						w.bb:Destroy()
					end
				end)
				espObjects[u] = nil
			end
		end
	end
	CX.setTrapESP = function(e, ...)
		h.trapESP = (e == true)
		if espAnyOn() then
			pcall(espRefresh)
		else
			pcall(espClear)
		end
	end
	CX.setPlayerESP = function(e, ...)
		h.playerESP = (e == true)
		if espAnyOn() then
			pcall(espRefresh)
		else
			pcall(espClear)
		end
	end
	espSet = function(e, ...)
		h.eggESP = (e == true)
		if espAnyOn() then
			pcall(espRefresh)
		else
			pcall(espClear)
		end
	end
	task.spawn(function(...)
		while h.alive do
			if espAnyOn() then
				pcall(espRefresh)
			end
			task.wait(0.45)
		end
	end)
	
	CX.killTraps = function(...)
		pcall(function(...)
			local e = r:FindFirstChild("__DEBRIS")
			if not e then
				return
			end
			for y, u in ipairs(e:GetChildren()) do
				if u.Name == "PlayerTrap" and tostring(u:GetAttribute("Owner") or "") ~= o.Name then
					if u:IsA("BasePart") then
						u.CanTouch = false
						u.CanQuery = false
					end
					for e, y in ipairs(u:GetChildren()) do
						if y:IsA("BasePart") then
							y.CanTouch = false
							y.CanQuery = false
							if y.Name == "Hitbox" then
								y.CFrame = CFrame.new(0, -999, 0)
							end
						end
					end
					local w = u:FindFirstChildWhichIsA("TouchTransmitter", true)
					if w then
						pcall(function(...)
							w:Destroy()
						end)
					end
				end
			end
		end)
	end
	task.spawn(function(...)
		local e = r:FindFirstChild("__DEBRIS")
		local u = 0
		while not e and u < 60 do
			u = u + 1
			task.wait(2)
			e = r:FindFirstChild("__DEBRIS")
		end
		if e then
			e.ChildAdded:Connect(function(e, ...)
				if e.Name == "PlayerTrap" and h.antiTrap then
					task.wait(0.008)
					if tostring(e:GetAttribute("Owner") or "") ~= o.Name then
						task.spawn(CX.killTraps)
					end
				end
			end)
		end
		while h.alive do
			if h.antiTrap or ((h.pureTweenFarm or h.autoFarmLoop) or h.teleporting) then
				pcall(CX.killTraps)
			end
			task.wait(0.45)
		end
	end)
	
	CX.saveMod = nil
	pcall(function(...)
		CX.saveMod = require((j:WaitForChild("Shared", 5)):WaitForChild("Save", 5))
	end)
	if not CX.saveMod then
		pcall(function(...)
			CX.saveMod = require(j.Shared.Save)
		end)
	end
	CX.treadmillUp = function(...)
		local e = (cxNet("RF/Treadmill/AskTierRaise")
			or J("RF/Treadmill/AskTierRaise", "AskTierRaise")
			or J("Treadmills: RequestUpgrade"))
		if not e then
			return false
		end
		local y, u = pcall(function(...)
			return e:InvokeServer()
		end)
		if y then
			h.statsTreadmillUps = (h.statsTreadmillUps or 0) + 1
			return true
		end
		return false
	end
	CX.claimOnce = function(...)
		for e, y in ipairs({ "RF/AwayEarnings/AskCollect", "RF/Codex/AskRedeemAll", "RF/GroupPerk/RedeemPerk" }) do
			local e = (cxNet(y) or J(y))
			if e then
				h.statsClaims = (h.statsClaims or 0) + 1
				pcall(function(...)
					e:InvokeServer()
				end)
			end
		end
	end
	CX.equipBest = function(...)
		local e = (
			cxNet("RF/Haul/WearBest")
			or J("RF/Haul/WearBest", "WearBest")
			or J("RF/PenRoster/ConfirmEquipBestBadge")
		)
		if e then
			pcall(function(...)
				e:InvokeServer()
			end)
		end
	end
	local cxLow = {
		["Common"] = true,
		["Uncommon"] = true,
		["Rare"] = true,
		["Epic"] = true,
		["Legendary"] = true,
		["Mythic"] = true,
	}
	CX.sellOk = function(rar, nm, ...)
		local idx = 10
		local rarStr = tostring(rar or "Common")
		for i = 1, #X do
			if X[i] == rarStr then
				idx = i
				break
			end
		end
		if idx < (tonumber(h.sellMaxRarity) or 6) then
			return false
		end
		if type(h.sellKeep) == "string" and h.sellKeep ~= "" and type(nm) == "string" and nm ~= "" then
			local low = string.lower(nm)
			for part in string.gmatch(h.sellKeep, "([^,]+)") do
				local p = string.lower((part:gsub("^%s+", ""):gsub("%s+$", "")))
				if p ~= "" and string.find(low, p, 1, true) then
					return false
				end
			end
		end
		local rec = (...)
		if type(rec) == "table" then
			if type(h.sellKeepMut) == "string" and h.sellKeepMut ~= "" then
				if CX._listMatch(h.sellKeepMut, CX._mutNames(rec)) then
					return false
				end
			end
			local thr = tonumber(h.sellIncomeBelow) or 0
			if thr > 0 then
				local inc = tonumber(rec.EarningRate or rec.Income or rec.IncomePerSecond or 0)
				if inc > 0 and inc >= thr then
					return false
				end
			end
		end
		return true
	end
	CX.sellOnce = function(...)
		local e = nil
		pcall(function(...)
			e = CX.saveMod and CX.saveMod.Get and CX.saveMod.Get()
		end)
		if type(e) ~= "table" then
			return
		end
		local y = (cxNet("RE/PetSatchel/SellPet") or J("RE/PetSatchel/SellPet", "SellPet"))
		local u = (cxNet("RF/EggWorld/AskWearTool") or J("RF/EggWorld/AskWearTool", "AskWearTool"))
		if not y then
			return
		end
		local function w(e, ...)
			if type(e) == "table" then
				e = e.DisplayName or e._id or e.Name
			end
			local y, u = espColor(tostring(e or "Common"))
			return u or tostring(e or "Common")
		end
		local j = e.Inventory
		if type(j) == "table" then
			for e, r in pairs(j) do
				if type(r) == "table" and not r.Locked then
					if CX.sellOk(w(r.Rarity), r.DisplayName, r) then
						h.statsSold = (h.statsSold or 0) + 1
						h.statsSoldRarity = (h.statsSoldRarity or {})
						local rn = w(r.Rarity)
						h.statsSoldRarity[rn] = (h.statsSoldRarity[rn] or 0) + 1
						pcall(function(...)
							y:FireServer(e)
						end)
						task.wait(0.01)
					end
				end
			end
		end
		local k = e.EggInventory
		if type(k) == "table" and u then
			for e, r in pairs(k) do
				if type(r) == "table" and (not r.Placement and not r.Locked) then
					if CX.sellOk(w(r.Rarity or r.RarityId), r.DisplayName, r) then
						h.statsSold = (h.statsSold or 0) + 1
						h.statsSoldRarity = (h.statsSoldRarity or {})
						local rn = w(r.Rarity or r.RarityId)
						h.statsSoldRarity[rn] = (h.statsSoldRarity[rn] or 0) + 1
						pcall(function(...)
							u:InvokeServer(e)
						end)
						pcall(function(...)
							y:FireServer({ e })
						end)
						task.wait(0.1)
					end
				end
			end
		end
	end
	
	CX.panicLeave = function(msg, whMsg, ...)
		CX.logAdd("Panic: auto leaving, " .. msg)
		if h.whPanic ~= false then
			CX.webhook("Clout Hub | Panic", (whMsg or ("Auto left the game, " .. msg)), 15158332)
		end
		pcall(function(...)
			e.LocalPlayer:Kick("auto leave")
		end)
		pcall(function(...)
			game:Shutdown()
		end)
	end
	CX.panicCheck = function(plr, ...)
		if not (h.panicAuto or h.antiStaff) then
			return
		end
		local nm = tostring((plr and plr.Name) or "")
		if nm == "" or (plr == e.LocalPlayer) then
			return
		end
		
		if h.panicAuto and type(h.panicNames) == "string" and h.panicNames ~= "" then
			for part in string.gmatch(h.panicNames, "([^,]+)") do
				local p = (part:gsub("^%s+", ""):gsub("%s+$", ""))
				if p ~= "" and string.lower(nm) == string.lower(p) then
					CX.panicLeave(nm .. " just joined", "Auto left the game, " .. nm .. " showed up")
					return
				end
			end
		end
		
		if h.antiStaff then
			local gid = nil
			pcall(function(...)
				if game.CreatorType == Enum.CreatorType.Group then
					gid = tonumber(game.CreatorId)
				end
			end)
			if gid then
				local rank = 0
				local role = ""
				pcall(function(...)
					rank = tonumber(plr:GetRankInGroup(gid)) or 0
					role = tostring(plr:GetRoleInGroup(gid) or "")
				end)
				local lowRole = string.lower(role)
				local byRank = (rank >= (tonumber(h.staffMinRank) or 250))
				local byRole = false
				for _, key in ipairs({ "admin", "moder", "mod", "staff", "owner", "founder", "developer", "lead", "manager", "operator", "support", "helper" }) do
					if string.find(lowRole, key, 1, true) then
						byRole = true
						break
					end
				end
				if byRank or byRole then
					local detail = nm .. " looks like staff (" .. role .. ", rank " .. tostring(rank) .. ")"
					CX.panicLeave(detail, "Staff member joined, auto leaving: " .. detail)
					return
				end
			end
		end
	end
	e.PlayerAdded:Connect(function(plr, ...)
		pcall(CX.panicCheck, plr)
	end)
	pcall(function(...)
		for _, plr in ipairs(e:GetPlayers()) do
			pcall(CX.panicCheck, plr)
		end
	end)
	task.spawn(function(...)
		local e = 0
		while h.alive do
			if h.autoClaimRewards then
				pcall(CX.claimOnce)
			end
			if h.bossClaim then
				local e, r = pcall(CX.claimMastery)
				if e and (type(r) == "number" and r > 0) then
					h.bossClaimsDone = (h.bossClaimsDone or 0) + r
					CX.logAdd("Boss: claimed " .. r .. " milestone(s)")
					if h.whBoss then
						CX.webhook(
							"Clout Hub | Boss",
							string.format("Claimed %d boss mastery milestone%s", r, (r > 1 and "s" or "")),
							15844367
						)
					end
				end
			end
			if h.autoSellJunk then
				pcall(CX.sellOnce)
			end
			if h.autoTreadmill then
				pcall(CX.treadmillUp)
			end
			e = e + 1
			if (e % 2 == 0) and h.autoEquipBest then
				pcall(CX.equipBest)
			end
			task.wait(10)
		end
	end)
	
	local cxFB = nil
	CX.setFullbright = function(e, ...)
		h.fullbright = (e == true)
		pcall(function(...)
			local y = game:GetService("Lighting")
			if not cxFB then
				cxFB = {
					["Ambient"] = y.Ambient,
					["OutdoorAmbient"] = y.OutdoorAmbient,
					["Brightness"] = y.Brightness,
					["ClockTime"] = y.ClockTime,
				}
			end
			if e then
				y.Ambient = Color3.fromRGB(255, 255, 255)
				y.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
				y.Brightness = 2
				y.ClockTime = 14
			else
				y.Ambient = cxFB.Ambient
				y.OutdoorAmbient = cxFB.OutdoorAmbient
				y.Brightness = cxFB.Brightness
				y.ClockTime = cxFB.ClockTime
			end
		end)
	end
	
	CX.B = { ["claimed"] = {} }
	CX.bossSnap = function(...)
		local e = (cxNet("RF/BossEvent/AskSnapshot") or J("RF/BossEvent/AskSnapshot", "AskSnapshot"))
		if not e then
			return nil
		end
		local y, u = pcall(function(...)
			return e:InvokeServer()
		end)
		if y and type(u) == "table" then
			return u
		end
		return nil
	end
	CX.bossIsOpen = function(...)
		local e = CX.bossSnap()
		if e then
			if e.Open ~= nil then
				return e.Open == true
			end
			if e.BossHealth and e.BossMaxHealth then
				return (tonumber(e.BossHealth) or 0) > 0
			end
		end
		return false
	end
	CX.bossJoinNow = function(...)
		local e = (cxNet("RF/BossEvent/AskEnter") or J("RF/BossEvent/AskEnter", "AskEnter"))
		if not e then
			return false
		end
		local y, u = pcall(function(...)
			return e:InvokeServer()
		end)
		return y and (u ~= false and u ~= nil)
	end
	CX.claimMastery = function(...)
		local e = (
			cxNet("RF/BossMastery/AskClaimMilestone") or J("RF/BossMastery/AskClaimMilestone", "AskClaimMilestone")
		)
		if not e then
			return 0
		end
		local y = 0
		for r, u in ipairs({
			"Mastery3",
			"Mastery5",
			"Mastery10",
			"Mastery15",
			"Mastery20",
			"Mastery30",
		}) do
			if not CX.B.claimed[u] then
				local r, w = pcall(function(...)
					return e:InvokeServer(u)
				end)
				if r and (w ~= false and w ~= nil) then
					CX.B.claimed[u] = true
					y = y + 1
				end
			end
		end
		return y
	end
	CX.bossBat = function(...)
		local e = o.Character
		if not e then
			return nil
		end
		local r = e:FindFirstChildWhichIsA("Tool")
		if r and r:GetAttribute("IsBat") == true then
			return r
		end
		local y = o:FindFirstChild("Backpack")
		if y then
			for r, y in ipairs(y:GetChildren()) do
				if y:IsA("Tool") and y:GetAttribute("IsBat") == true then
					y.Parent = e
					return y
				end
			end
		end
		local u = (cxNet("RF/Codex/AskWearFieldBat") or J("RF/Codex/AskWearFieldBat", "AskWearFieldBat"))
		if u then
			pcall(function(...)
				u:InvokeServer()
			end)
		end
		return nil
	end
	CX.bossTarget = function(...)
		local e = r:FindFirstChild("BossArena")
		if not e then
			return nil, nil
		end
		local y = o.Character
		local u = y and y:FindFirstChild("HumanoidRootPart")
		if not u then
			return nil, nil
		end
		local w = nil
		local j = 999999999
		local k = e:FindFirstChild("CrystalTowers")
		if k then
			for e, r in ipairs(k:GetChildren()) do
				local y = r:FindFirstChild("Hitbox", true)
				if y and y:IsA("BasePart") then
					local k = tonumber(y:GetAttribute("Health"))
					if k == nil or k > 0 then
						local a = ((u.Position - y.Position)).Magnitude
						if a < j then
							j = a
							w = y
						end
					end
				end
			end
		end
		if w then
			return w, "Crystal"
		end
		local a = e:FindFirstChild("Boss")
		if a then
			local e = a:FindFirstChild("UpperHand1.R", true)
				or a.PrimaryPart
				or a:FindFirstChildWhichIsA("BasePart", true)
			if e and e:IsA("BasePart") then
				return e, "Boss"
			end
		end
		return nil, nil
	end
	CX.hazardSet = {}
	CX.hazardHooked = false
	CX.installHazard = function(...)
		if CX.hazardHooked then
			return true
		end
		local e = (hookfunction or replaceclosure or hookfunc)
		if not e then
			return false
		end
		if w.TouchEnabled and not w.KeyboardEnabled then
			return false
		end
		local y = (cxNet("RE/BossEvent/HazardHit") or J("RE/BossEvent/HazardHit", "HazardHit"))
		local u = (cxNet("RE/BossEvent/BlackHoleHit") or J("RE/BossEvent/BlackHoleHit", "BlackHoleHit"))
		if not (y and y:IsA("RemoteEvent")) then
			return false
		end
		CX.hazardSet = { [y] = true }
		if u and u:IsA("RemoteEvent") then
			CX.hazardSet[u] = true
		end
		local j = y.FireServer
		if type(j) ~= "function" then
			return false
		end
		local k = pcall(function(...)
			e(j, function(e, ...)
				if h.bossHazard and CX.hazardSet[e] then
					return
				end
				return j(e, ...)
			end)
		end)
		CX.hazardHooked = (k == true)
		return CX.hazardHooked
	end
	task.spawn(function(...)
		local e = 0
		local u = 0
		while h.alive do
			local w = (o:GetAttribute("InBossArena") == true)
			if w and h.bossFight then
				local k = nil
				local a = nil
				pcall(function(...)
					k, a = CX.bossTarget()
				end)
				if k then
					local V = o.Character
					local H = V and V:FindFirstChild("HumanoidRootPart")
					if H then
						local t = k.Position
						local s = Vector3.new(H.Position.X - t.X, 0, H.Position.Z - t.Z)
						if s.Magnitude < 0.5 then
							s = Vector3.new(0, 0, 1)
						end
						local p = t + (s.Unit * 5)
						local B = (p - H.Position)
						local J = B.Magnitude
						if J > 7 then
							local K = math.clamp(os.clock() - e, 0.001, 0.1)
							local c = math.min(260 * K, J)
							local v = B.Unit
							local i = H.Position + (v * c)
							H.CFrame = CFrame.lookAt(i, i + Vector3.new(v.X, 0, v.Z))
							H.AssemblyLinearVelocity = Vector3.zero
							H.AssemblyAngularVelocity = Vector3.zero
						else
							H.AssemblyLinearVelocity = Vector3.zero
							H.AssemblyAngularVelocity = Vector3.zero
							if os.clock() - u > 0.15 then
								u = os.clock()
								local t = CX.bossBat()
								if t then
									pcall(function(...)
										t:Activate()
									end)
								end
								local t = cxNet("RE/BatSwing/Trigger")
								if t then
									pcall(function(...)
										t:FireServer()
									end)
								end
							end
						end
					end
				else
					task.wait(0.25)
				end
				e = os.clock()
				if w and h.bossFight then
					y.Heartbeat:Wait()
				end
			else
				if h.bossJoin and not w then
					local k, a = pcall(CX.bossIsOpen)
					if k and a == true then
						pcall(CX.bossJoinNow)
					end
				end
				task.wait(2)
			end
		end
	end)
	if h.fullbright then
		task.defer(function(...)
			CX.setFullbright(true)
		end)
	end
	task.spawn(function(...)
		while h.alive do
			task.wait(30)
			if h.cfgAutoSave ~= false then
				pcall(x)
			end
		end
	end)

	local Fk = {}
	
	do
		local httpSvc = game:GetService("HttpService")
		local wrkSvc = game:GetService("Workspace")
		h.humanize = (h.humanize == true)
		h.sniper = (h.sniper == true)
		h.snipeGrab = (h.snipeGrab == true)
		h.snipeMaxStuds = (tonumber(h.snipeMaxStuds) or 2000)
		h.webhookUrl = (type(h.webhookUrl) == "string" and h.webhookUrl or "")
		h.stealMinIncome = (tonumber(h.stealMinIncome) or 0)
		h.stealMuts = (type(h.stealMuts) == "string" and h.stealMuts or "")
		h.sellIncomeBelow = (tonumber(h.sellIncomeBelow) or 0)
		h.sellKeepMut = (type(h.sellKeepMut) == "string" and h.sellKeepMut or "")
		h.whStealMinIncome = (tonumber(h.whStealMinIncome) or 0)
		h.whStealMuts = (type(h.whStealMuts) == "string" and h.whStealMuts or "")
		h.whStealRarities = (type(h.whStealRarities) == "table" and h.whStealRarities or {})
		h.autoTreadmill = (h.autoTreadmill == true)
		h.fastCycle = (h.fastCycle == true)
		h.whSnipe = (h.whSnipe ~= false)
		h.whSteal = (h.whSteal == true)
		h.keybindsOn = (h.keybindsOn ~= false)
		h.profSlot = (type(h.profSlot) == "string" and h.profSlot or "Slot 1")
		h.kb1Action = (type(h.kb1Action) == "string" and h.kb1Action or "None")
		h.kb1Key = (type(h.kb1Key) == "string" and h.kb1Key or "F")
		h.kb2Action = (type(h.kb2Action) == "string" and h.kb2Action or "None")
		h.kb2Key = (type(h.kb2Key) == "string" and h.kb2Key or "G")
		h.cfgAutoLoad = (h.cfgAutoLoad ~= false)
		h.cfgAutoSave = (h.cfgAutoSave ~= false)
		h.whBoss = (h.whBoss == true)
		h.whHaul = (h.whHaul == true)
		h.whUnload = (h.whUnload == true)
		CX.kbActions = {
			"None",
			"Egg ESP",
			"Trap ESP",
			"Player ESP",
			"Fullbright",
			"Trap Crusher",
			"Egg Sniper",
			"Auto Sell Junk",
			"Boss Fight",
			"Unload UI",
		}
		CX.kbKeys = { "F", "G", "H", "J", "K", "L" }
		local httpRequest = nil
		pcall(function(...)
			httpRequest = (syn and syn.request)
				or (http and http.request)
				or (fluxus and fluxus.request)
		end)
		CX.hasHttp = (httpRequest ~= nil)
		function CX.webhook(e, r, u, ...)
			if type(h.webhookUrl) ~= "string" or h.webhookUrl == "" then
				return false
			end
			if not httpRequest then
				return false
			end
			local cxFields = (...)
			local cxEmb = {
				["title"] = tostring(e),
				["description"] = tostring(r),
				["color"] = (tonumber(u) or 3066993),
				["footer"] = { ["text"] = "Clout Hub - " .. os.date("%H:%M:%S") },
				["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
			}
			if type(cxFields) == "table" then
				cxEmb["fields"] = cxFields
			end
			local w = {
				["username"] = "Clout Hub",
				["embeds"] = { cxEmb },
			}
			if type(h.webhookPing) == "string" and h.webhookPing ~= "" then
				w["content"] = h.webhookPing
			end
			local a = httpSvc:JSONEncode(w)
			task.spawn(function(...)
				local e = pcall(function(...)
					httpRequest({
						["Url"] = h.webhookUrl,
						["Method"] = "POST",
						["Headers"] = { ["Content-Type"] = "application/json" },
						["Body"] = a,
					})
				end)
				if not e then
					CX.hasHttp = false
				end
			end)
			return true
		end
		CX._listMatch = function(csv, names)
			if type(csv) ~= "string" or csv == "" then
				return true
			end
			if type(names) ~= "table" or #names == 0 then
				return false
			end
			local lut = {}
			for _, n in ipairs(names) do
				lut[string.lower(tostring(n))] = true
			end
			for part in string.gmatch(csv, "([^,]+)") do
				local q = string.lower((part:gsub("^%s+", ""):gsub("%s+$", "")))
				if q ~= "" then
					for n in pairs(lut) do
						if string.find(n, q, 1, true) then
							return true
						end
					end
				end
			end
			return false
		end
		CX._mutNames = function(rec)
			local out = {}
			if type(rec) ~= "table" then
				return out
			end
			pcall(function(...)
				local m = rec.Mutations or rec.Mutation
				if type(m) == "table" then
					for k2, v2 in pairs(m) do
						if type(k2) == "string" and k2 ~= "" then
							table.insert(out, string.lower(k2))
						elseif type(v2) == "string" and v2 ~= "" then
							table.insert(out, string.lower(v2))
						end
					end
				elseif type(m) == "string" and m ~= "" then
					table.insert(out, string.lower(m))
				end
			end)
			return out
		end
		CX._modelIncome = function(m)
			local inc = 0
			pcall(function(...)
				inc = tonumber(m:GetAttribute("Income") or m:GetAttribute("EarningRate") or m:GetAttribute("IncomePerSecond") or 0)
			end)
			return inc
		end
		CX._modelMutText = function(m)
			local mt = ""
			pcall(function(...)
				mt = tostring(m:GetAttribute("Mutations") or m:GetAttribute("Mutation") or "")
			end)
			return mt
		end
		CX._cfgStealPass = function(rec, realIncome)
			local mi = tonumber(h.stealMinIncome) or 0
			if mi > 0 and (tonumber(realIncome) or 0) < mi then
				return false
			end
			if type(h.stealMuts) == "string" and h.stealMuts ~= "" then
				if not CX._listMatch(h.stealMuts, CX._mutNames(rec)) then
					return false
				end
			end
			return true
		end
		h._cfgStealPass = CX._cfgStealPass
		CX._whStealPass = function(model, rarityName)
			local wantRar = h.whStealRarities
			if type(wantRar) == "table" and rarityName then
				local any = false
				for k2, v2 in pairs(wantRar) do
					if v2 == true then
						any = true
						break
					end
				end
				if any and wantRar[tostring(rarityName)] ~= true then
					return false
				end
			end
			local mi = tonumber(h.whStealMinIncome) or 0
			if mi > 0 and model then
				local inc = CX._modelIncome(model)
				if inc and inc > 0 and inc < mi then
					return false
				end
			end
			if type(h.whStealMuts) == "string" and h.whStealMuts ~= "" and model then
				local mt = CX._modelMutText(model)
				if mt ~= "" and not CX._listMatch(h.whStealMuts, { string.lower(mt) }) then
					return false
				end
			end
			return true
		end
		function CX.maskUrl(...)
			local e = h.webhookUrl
			if type(e) ~= "string" or e == "" then
				return "Not set yet, paste it from clipboard"
			end
			if #e > 42 then
				return (string.sub(e, 1, 42) .. "...")
			end
			return e
		end
		function CX.setWebhookFromClipboard(...)
			local e = nil
			pcall(function(...)
				e = (getclipboard and getclipboard()) or (get_clipboard and get_clipboard())
			end)
			if type(e) == "string" and e:find("discord.com/api/webhooks/") then
				h.webhookUrl = e
				pcall(x)
				CX.logAdd("Webhook set from clipboard")
				return true
			end
			return false
		end
		function CX.logAdd(e, ...)
			table.insert(h.logLines, 1, os.date("%H:%M:%S") .. "  " .. tostring(e))
			while #h.logLines > 14 do
				table.remove(h.logLines)
			end
		end
	h._stealHook = function(...)
		CX.logAdd("Steal trip done, total " .. tostring(h.statsSteals or 0))
		if h.whSteal and (not CX._whStealPass or CX._whStealPass(h.currentTargetModel, nil)) then
			CX.webhook(
				"Clout Hub | Steal",
				string.format("Steal trip number %d just finished", h.statsSteals or 0),
				3066993,
				{
					{ ["name"] = "Steals", ["value"] = tostring(h.statsSteals or 0), ["inline"] = true },
					{ ["name"] = "Sold", ["value"] = tostring(h.statsSold or 0), ["inline"] = true },
					{ ["name"] = "Snipes", ["value"] = tostring(h.statsSnipes or 0), ["inline"] = true },
				}
			)
		end
	end
		function CX.runAction(e, ...)
			if e == "Egg ESP" then
				espSet(not h.eggESP)
			elseif e == "Trap ESP" then
				CX.setTrapESP(not h.trapESP)
			elseif e == "Player ESP" then
				CX.setPlayerESP(not h.playerESP)
			elseif e == "Fullbright" then
				CX.setFullbright(not h.fullbright)
			elseif e == "Trap Crusher" then
				h.antiTrap = not h.antiTrap
			elseif e == "Egg Sniper" then
				h.sniper = not h.sniper
			elseif e == "Auto Sell Junk" then
				h.autoSellJunk = not h.autoSellJunk
			elseif e == "Boss Fight" then
				h.bossFight = not h.bossFight
				if h.bossFight then
					h.bossJoin = true
				end
			elseif e == "Unload UI" then
				if h._unload then
					pcall(h._unload)
				end
			end
			CX.syncUI()
			pcall(x)
		end
		function CX.syncUI(...)
			if not Fk then
				return
			end
			local function s(e, r, ...)
				pcall(function(...)
					if Fk[e] and Fk[e].SetValue then
						Fk[e]:SetValue(r)
					end
				end)
			end
			s("togEggESP", (h.eggESP == true))
			s("togTrapESP", (h.trapESP == true))
			s("togPlayerESP", (h.playerESP == true))
			s("sliderEspDist", (h.espMaxStuds or 8000))
			s("togFullbright", (h.fullbright == true))
			s("togTrapCrusher", (h.antiTrap ~= false))
			s("togAutoClaim", (h.autoClaimRewards == true))
			s("togEquipBest", (h.autoEquipBest == true))
			s("togSellJunk", (h.autoSellJunk == true))
			s("togBossJoin", (h.bossJoin == true))
			s("togBossFight", (h.bossFight == true))
			s("togBossClaim", (h.bossClaim == true))
			s("togBossHazard", (h.bossHazard == true))
			s("togSniper", (h.sniper == true))
			s("togSnipeGrab", (h.snipeGrab == true))
			s("sliderSnipeRange", (h.snipeMaxStuds or 2000))
			s("togHumanize", (h.humanize == true))
			s("togWhSnipe", (h.whSnipe ~= false))
			s("togWhSteal", (h.whSteal == true))
			s("togKeybinds", (h.keybindsOn ~= false))
		end
		function CX.applyW(e, ...)
			if type(e) ~= "table" then
				return
			end
			h.autoHatch = (e.autoHatch ~= false)
			h.autoGlide = (e.autoGlide ~= false)
			h.autoPlaceEvery5 = (e.autoPlaceEvery5 == true)
			h.eggESP = (e.eggESP == true)
			h.trapESP = (e.trapESP == true)
			h.playerESP = (e.playerESP == true)
			h.espMaxStuds = (tonumber(e.espMaxStuds) or 8000)
			h.antiTrap = (e.antiTrap ~= false)
			h.fullbright = (e.fullbright == true)
			h.autoClaimRewards = (e.autoClaimRewards == true)
			h.autoEquipBest = (e.autoEquipBest == true)
			h.autoSellJunk = (e.autoSellJunk == true)
			h.bossJoin = (e.bossJoin == true)
			h.bossFight = (e.bossFight == true)
			h.bossClaim = (e.bossClaim == true)
			h.bossHazard = (e.bossHazard == true)
			h.humanize = (e.humanize == true)
			h.sniper = (e.sniper == true)
			h.snipeGrab = (e.snipeGrab == true)
			h.snipeMaxStuds = (tonumber(e.snipeMaxStuds) or 2000)
			h.theme = (type(e.theme) == "string" and e.theme or "Dark")
			h.webhookUrl = (type(e.webhookUrl) == "string" and e.webhookUrl or "")
			h.whSnipe = (e.whSnipe ~= false)
			h.whSteal = (e.whSteal == true)
			h.keybindsOn = (e.keybindsOn ~= false)
			h.profSlot = (type(e.profSlot) == "string" and e.profSlot or "Slot 1")
			h.kb1Action = (type(e.kb1Action) == "string" and e.kb1Action or "None")
			h.kb1Key = (type(e.kb1Key) == "string" and e.kb1Key or "F")
			h.kb2Action = (type(e.kb2Action) == "string" and e.kb2Action or "None")
			h.kb2Key = (type(e.kb2Key) == "string" and e.kb2Key or "G")
			h.sellMaxRarity = (tonumber(e.sellMaxRarity) or 6)
			h.sellKeep = (type(e.sellKeep) == "string" and e.sellKeep or "")
			h.panicAuto = (e.panicAuto == true)
			h.panicNames = (type(e.panicNames) == "string" and e.panicNames or "")
			h.whPanic = (e.whPanic ~= false)
			h.webhookPing = (type(e.webhookPing) == "string" and e.webhookPing or "")
			h.antiStaff = (e.antiStaff == true)
			h.staffMinRank = (tonumber(e.staffMinRank) or 250)
			espSet(h.eggESP == true)
			CX.setTrapESP(h.trapESP == true)
			CX.setPlayerESP(h.playerESP == true)
			CX.setFullbright(h.fullbright == true)
			pcall(function(...)
				if CloutWindLib and h.theme then
					CloutWindLib:SetTheme(h.theme)
				end
			end)
			CX.syncUI()
		end
		function CX.profileFile(e, ...)
			return "CloutHub_Profile_" .. tostring(e or "Slot 1"):gsub("%s+", "") .. ".json"
		end
		function CX.saveProfile(e, ...)
			if not (readfile and writefile and isfile) then
				return false, "executor has no file functions"
			end
			pcall(x)
			if not isfile(z) then
				return false, "no config file yet"
			end
			writefile(CX.profileFile(e), readfile(z))
			CX.logAdd("Profile saved to " .. tostring(e))
			return true
		end
		function CX.loadProfile(e, ...)
			if not (readfile and isfile) then
				return false, "executor has no file functions"
			end
			local r = CX.profileFile(e)
			if not isfile(r) then
				return false, "that slot is empty"
			end
			local w = readfile(r)
			local y = nil
			pcall(function(...)
				y = httpSvc:JSONDecode(w)
			end)
			if type(y) ~= "table" then
				return false, "file is broken"
			end
			CX.applyW(y)
			if writefile then
				pcall(writefile, z, w)
			end
			CX.logAdd("Profile loaded from " .. tostring(e))
			return true
		end
		CX.logAdd("Hub loaded, welcome back")
		
		task.spawn(function(...)
			while h.alive do
				local e = o.Character
				local r = e and e:FindFirstChild("HumanoidRootPart")
				local y = false
				if r then
					local u = r.Position
					for e, r in ipairs(game:GetService("Players"):GetPlayers()) do
						if r ~= o then
							local e = r.Character
							local w = e and e:FindFirstChild("HumanoidRootPart")
							if w and ((w.Position - u)).Magnitude < 120 then
								y = true
								break
							end
						end
					end
				end
				h.nearPlayer = y
				task.wait(0.6)
			end
		end)
		
		local snipeNames = { ["Secret"] = 8, ["Eternal"] = 9, ["Divine"] = 10 }
		task.spawn(function(...)
			local e = {}
			while h.alive do
				task.wait(0.12)
				if h.sniper then
					local r = o.Character
					local u = r and r:FindFirstChild("HumanoidRootPart")
					local w = wrkSvc and wrkSvc:FindFirstChild("AreaEggSlotsClient")
					if u and w and not (h.delivering or h.securingEgg) then
						local a = u.Position
						for r, y in ipairs(w:GetChildren()) do
							if y:IsA("Model") and not e[y] then
								local r = y:GetAttribute("Rarity")
									or y:GetAttribute("RarityTier")
									or y:GetAttribute("Tier")
								local r = (type(r) == "string" and (snipeNames[r] or 0)) or (tonumber(r) or 0)
								if r >= 8 then
									local V = y.PrimaryPart
										or y:FindFirstChildWhichIsA("BasePart", true)
										or y:FindFirstChildWhichIsA("BasePart")
									if V then
										local H = ((V.Position - a)).Magnitude
										if H <= (h.snipeMaxStuds or 2000) then
											e[y] = true
											y.Destroying:Connect(function(...)
												e[y] = nil
											end)
											h.statsSnipes = (h.statsSnipes or 0) + 1
											local t = (r >= 10 and "Divine" or (r == 9 and "Eternal" or "Secret"))
											h.statsRarity = (h.statsRarity or {})
											h.statsRarity[t] = (h.statsRarity[t] or 0) + 1
											CX.logAdd(
												"Sniper spotted a " .. t .. " egg, " .. math.floor(H) .. " studs away"
											)
											CX.toast("Sniper locked a " .. t .. " egg")
							if h.whSnipe and CX._whStealPass and CX._whStealPass(y, t) then
								local cxF = {
									{ ["name"] = "Rarity", ["value"] = tostring(t), ["inline"] = true },
									{ ["name"] = "Distance", ["value"] = (math.floor(H) .. " studs"), ["inline"] = true },
								}
								local cxInc = CX._modelIncome(y)
								if cxInc and cxInc > 0 then
									table.insert(cxF, { ["name"] = "Income/s", ["value"] = tostring(cxInc), ["inline"] = true })
								end
								local cxMut = CX._modelMutText(y)
								if cxMut and cxMut ~= "" then
									table.insert(cxF, { ["name"] = "Mutation", ["value"] = cxMut, ["inline"] = true })
								end
								CX.webhook(
									"Clout Hub | Sniper",
									string.format(
										"A %s egg just showed up %d studs away",
										t,
										math.floor(H)
									),
									15158332,
									cxF
								)
							end
											if h.snipeGrab then
												local s = V
												task.spawn(function(...)
													pcall(function(...)
														wk(s, (h.glideSpeed or 500), nil, O4)
														if not (h.pureTweenFarm or h.autoFarmLoop) then
															pcall(Q4, (h.glideSpeed or 500))
														end
													end)
												end)
												task.wait((h.fastCycle and 0.25) or 0.8)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)
		
		function CX.bossStatusText(...)
			local e = CX.bossSnap()
			if not e then
				return "Boss: cant read arena data right now"
			end
			local r = ((e.Open == true) and "OPEN" or "CLOSED")
			local y = ""
			if e.BossHealth and e.BossMaxHealth then
				y = string.format(" | HP: %s / %s", tostring(e.BossHealth), tostring(e.BossMaxHealth))
			end
			local a = nil
			for e, r in pairs(e) do
				local V = string.lower(tostring(e))
				if
					(type(r) == "number")
					and (V:find("next") or V:find("cooldown") or V:find("remain") or V:find("timeleft"))
				then
					a = r
				end
			end
			local V = ""
			if a then
				V = string.format(" | Next in: %dm %ds", math.floor(a / 60), (a % 60))
			end
			local H = 0
			for e, r in pairs(CX.B.claimed) do
				H = H + 1
			end
			return ("Boss arena: " .. r .. y .. V .. "\nMilestones claimed this session: " .. H)
		end
		
		task.spawn(function(...)
			local e = (h.statsSold or 0)
			while h.alive do
				task.wait(300)
				local r = (h.statsSold or 0)
				local y = (r - e)
				e = r
				if (h.whHaul == true) and y > 0 then
					CX.webhook(
						"Clout Hub | Haul",
						string.format("Sold %d junk items in the last 5 minutes, %d total this session", y, r),
						15844367
					)
				end
			end
		end)
		
		pcall(function(...)
			w.InputBegan:Connect(function(e, r, ...)
				if r or not h.alive or (h.keybindsOn == false) then
					return
				end
				local y = e.KeyCode and e.KeyCode.Name
				if not y then
					return
				end
				if y == h.kb1Key and h.kb1Action and h.kb1Action ~= "None" then
					CX.runAction(h.kb1Action)
				elseif y == h.kb2Key and h.kb2Action and h.kb2Action ~= "None" then
					CX.runAction(h.kb2Action)
				end
			end)
		end)
	end

	
	task.spawn(function(...)
		while h.alive do
			if
				(
					h.pureTweenFarm
					or h.autoFarmLoop
					or h.teleporting
					or h.glidingToTarget
					or h.securingEgg
					or h.delivering
					or h.isReturning
				) and (h.godmode ~= true)
			then
				pcall(b4, true)
				if godToggleSetter then
					pcall(godToggleSetter, true)
				end
			end
			task.wait(0.25)
		end
	end)
	local Xk = currentLang or "EN"
	local Gk = {
		["EN"] = {
			["StatusTagReady"] = "Status: Ready",
			["Tabs"] = {
				["Farm"] = "Auto Farm",
				["EggSelect"] = "Egg Selection",
				["Character"] = "Character",
				["Settings"] = "Settings",
			},
			["EggSelect"] = {
				["SecZones"] = "Target Zones",
				["SecZonesDesc"] = "Pick the zones you want eggs from (Secret+ ignores this)",
				["DropZonesTitle"] = "Selected Zones",
				["DropZonesDesc"] = "Tap to pick your target zones",
				["SecRarities"] = "Target Rarities",
				["SecRaritiesDesc"] = "Pick which rarities to go for",
				["DropRaritiesTitle"] = "Selected Rarities",
				["DropRaritiesDesc"] = "Tap to pick rarities",
				["AlwaysSecretPlus"] = "Always Steal Secret+ Eggs",
				["AlwaysSecretPlusDesc"] = "Grabs Secret or better eggs from anywhere",
			},
			["Farm"] = {
				["SecModes"] = "Auto Steal Modes",
				["TweenTitle"] = "Auto Steal (Tween)",
				["TweenDesc"] = "Flies out and steals eggs non stop, nice and smooth",
				["TeleportTitle"] = "Auto Steal (Teleport)",
				["TeleportDesc"] = "Warps straight to eggs and steals on repeat",
				["SingleTitle"] = "Single Steal (Teleport)",
				["SingleDesc"] = "Warps in, grabs 1 egg and comes right back",
				["SecPlace"] = "Place & Hatch",
				["PlaceTitle"] = "Place Eggs",
				["PlaceDesc"] = "Flies home and plants every egg in your bag",
				["AutoPlaceTitle"] = "Auto Place (Every 5)",
				["AutoPlaceDesc"] = "Heads home after 5 steals to plant eggs",
				["HatchTitle"] = "Auto Hatch",
				["HatchDesc"] = "Hatches ready eggs for you from anywhere",
				["ReturnTitle"] = "Auto Return",
				["ReturnDesc"] = "Flies you back safe after every steal",
				["AutoTreadmillTitle"] = "Auto Treadmill",
				["AutoTreadmillDesc"] = "Hops on the treadmill while nothing to steal",
				["UpgradeTreadmillTitle"] = "Auto Upgrade Treadmill",
				["UpgradeTreadmillDesc"] = "Upgrades your treadmill when you can afford it",
				["BuyTrailsTitle"] = "Auto Buy & Equip Trails",
				["BuyTrailsDesc"] = "Buys and equips the best trail you can afford",
				["HideNotEnoughMoneyTitle"] = "Hide 'Not Enough Money' UI",
				["HideNotEnoughMoneyDesc"] = "Silences the annoying not enough money popup",
			},
			["Character"] = {
				["SecSafety"] = "Character & Safety",
				["GodmodeTitle"] = "Godmode",
				["GodmodeDesc"] = "Nothing on the map can touch you",
				["UnstickTitle"] = "Get Unstuck",
				["UnstickDesc"] = "Gets you unstuck right away",
				["SecFlight"] = "Flight Settings",
				["SpeedTitle"] = "Flight Speed",
				["SpeedDesc"] = "How fast you fly, sweet spot is 450 to 525",
			},
			["Settings"] = {
				["SecDashboard"] = "Live Dashboard",
				["DashTitle"] = "Live Dashboard",
				["DashDesc"] = "Status: %s\nFarm Mode: %s\nCarried Eggs: %d\nFlight Speed: %d studs/s",
				["SecBlacklist"] = "Zone Preferences",
				["BlacklistToggleTitle"] = "Target Zone: %s",
				["BlacklistToggleDesc"] = "Steal eggs inside %s (Secret+ taken anyway)",
				["SecUI"] = "UI Customization",
				["TranspTitle"] = "Window Transparency",
				["TranspDesc"] = "Make the window see through, 0 to 90 percent",
				["ThemeTitle"] = "Select Theme",
				["SecPerformance"] = "Performance & Graphics",
				["PerformanceTitle"] = "Ultra Potato Mode (Maximum FPS Boost)",
				["PerformanceDesc"] = "Kills textures and effects for a big fps boost",
				["Disable3DTitle"] = "Disable 3D Rendering (GPU Saver 95%)",
				["Disable3DDesc"] = "Stops the 3d view, gpu drops to almost nothing, perfect overnight",
				["LangTitle"] = "Language",
				["BtnTranslate"] = "Switch to Thai",
				["DescTranslate"] = "Switch interface language to Thai",
				["SecSystem"] = "System Controls",
				["AntiAFKTitle"] = "Anti AFK",
				["AntiAFKDesc"] = "Keeps you from getting kicked while afk",
				["ResetTitle"] = "Reset Character State",
				["ResetDesc"] = "Clears everything stuck and frees your character",
				["RejoinTitle"] = "Rejoin Server",
				["RejoinDesc"] = "Hops back into the same server",
				["UnloadTitle"] = "Unload Script",
				["UnloadDesc"] = "Stops everything and closes the menu",
			},
			["Notifications"] = {
				["PlaceStarted"] = "Flying back to base to place eggs...",
				["PlaceDone"] = "Eggs placed on stands and hatch requested!",
				["AutoPlaceStarted"] = "Auto Place (Every 5) enabled",
				["AutoPlaceStopped"] = "Auto Place (Every 5) disabled",
				["NoEggFound"] = "No eligible eggs found matching your filter",
				["UnstickDone"] = "Unstick request sent successfully!",
				["TweenStarted"] = "Auto Steal (Tween) activated",
				["TweenStopped"] = "Auto Steal (Tween) deactivated",
				["TeleportStarted"] = "Auto Steal (Teleport) activated",
				["TeleportStopped"] = "Auto Steal (Teleport) deactivated",
				["HatchStarted"] = "Auto Hatch enabled",
				["HatchStopped"] = "Auto Hatch disabled",
				["ReturnStarted"] = "Auto Return enabled",
				["ReturnStopped"] = "Auto Return disabled",
				["AutoTreadmillStarted"] = "Auto Treadmill enabled (Runs when idle)",
				["AutoTreadmillStopped"] = "Auto Treadmill disabled",
				["UpgradeTreadmillStarted"] = "Auto Upgrade Treadmill enabled",
				["UpgradeTreadmillStopped"] = "Auto Upgrade Treadmill disabled",
				["BuyTrailsStarted"] = "Auto Buy Trails enabled",
				["BuyTrailsStopped"] = "Auto Buy Trails disabled",
				["HideNotEnoughMoneyStarted"] = "Hide 'Not Enough Money' alert enabled",
				["HideNotEnoughMoneyStopped"] = "Hide 'Not Enough Money' alert disabled",
				["GodmodeStarted"] = "Godmode enabled",
				["GodmodeStopped"] = "Godmode disabled",
				["PerformanceStarted"] = "Ultra Potato Mode enabled (Textures & effects removed)",
				["PerformanceStopped"] = "Ultra Potato Mode disabled",
				["Disable3DStarted"] = "3D Rendering disabled (GPU Saver Active)",
				["Disable3DStopped"] = "3D Rendering restored",
				["AntiAFKStarted"] = "Anti AFK on, you wont get kicked",
				["AntiAFKStopped"] = "Anti AFK off",
				["LangSwitched"] = "Language switched to English successfully!",
			},
		},
		["TH"] = {
			["StatusTagReady"] = "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176: \224\184\158\224\184\163\224\185\137\224\184\173\224\184\161\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153",
			["Tabs"] = {
				["Farm"] = "\224\184\163\224\184\176\224\184\154\224\184\154\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161",
				["EggSelect"] = "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\155\224\184\163\224\184\176\224\185\128\224\184\160\224\184\151\224\185\132\224\184\130\224\185\136",
				["Character"] = "\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163",
				["Settings"] = "\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178",
			},
			["EggSelect"] = {
				["SecZones"] = "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\130\224\184\139\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162",
				["SecZonesDesc"] = "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\130\224\184\139\224\184\153\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\185\132\224\184\155\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136 (\224\185\132\224\184\130\224\185\136\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154 Secret \224\184\130\224\184\182\224\185\137\224\184\153\224\185\132\224\184\155\224\184\136\224\184\176\224\185\132\224\184\161\224\185\136\224\184\170\224\184\153\224\185\130\224\184\139\224\184\153)",
				["DropZonesTitle"] = "\224\185\130\224\184\139\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129",
				["DropZonesDesc"] = "\224\184\132\224\184\165\224\184\180\224\184\129\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\130\224\184\139\224\184\153\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136",
				["SecRarities"] = "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154\224\184\132\224\184\167\224\184\178\224\184\161\224\184\171\224\184\178\224\184\162\224\184\178\224\184\129",
				["SecRaritiesDesc"] = "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154\224\184\132\224\184\167\224\184\178\224\184\161\224\184\171\224\184\178\224\184\162\224\184\178\224\184\129\224\184\130\224\184\173\224\184\135\224\185\132\224\184\130\224\185\136\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\184\130\224\185\130\224\184\161\224\184\162",
				["DropRaritiesTitle"] = "\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154\224\184\132\224\184\167\224\184\178\224\184\161\224\184\171\224\184\178\224\184\162\224\184\178\224\184\129\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129",
				["DropRaritiesDesc"] = "\224\184\132\224\184\165\224\184\180\224\184\129\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154\224\184\132\224\184\167\224\184\178\224\184\161\224\184\171\224\184\178\224\184\162\224\184\178\224\184\129\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\184\130\224\185\130\224\184\161\224\184\162",
				["AlwaysSecretPlus"] = "\224\185\128\224\184\129\224\185\135\224\184\154\224\185\132\224\184\130\224\185\136 Secret+ \224\184\151\224\184\184\224\184\129\224\185\130\224\184\139\224\184\153\224\185\128\224\184\170\224\184\161\224\184\173",
				["AlwaysSecretPlusDesc"] = "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154 Secret, Eternal, Divine \224\184\151\224\184\177\224\184\153\224\184\151\224\184\181\224\185\132\224\184\161\224\185\136\224\184\167\224\185\136\224\184\178\224\184\136\224\184\176\224\185\128\224\184\129\224\184\180\224\184\148\224\184\151\224\184\181\224\185\136\224\185\130\224\184\139\224\184\153\224\185\131\224\184\148",
			},
			["Farm"] = {
				["SecModes"] = "\224\185\130\224\184\171\224\184\161\224\184\148\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["TweenTitle"] = "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\154\224\184\180\224\184\153\224\185\128\224\184\163\224\185\135\224\184\167)",
				["TweenDesc"] = "\224\184\154\224\184\180\224\184\153\224\185\132\224\184\155\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\185\129\224\184\165\224\184\176\224\185\128\224\184\129\224\185\135\224\184\154\224\185\131\224\184\170\224\185\136\224\184\129\224\184\163\224\184\176\224\185\128\224\184\155\224\185\139\224\184\178\224\184\173\224\184\162\224\185\136\224\184\178\224\184\135\224\184\149\224\185\136\224\184\173\224\185\128\224\184\153\224\184\183\224\185\136\224\184\173\224\184\135\224\184\149\224\184\178\224\184\161\224\184\151\224\184\178\224\184\135\224\184\148\224\185\136\224\184\167\224\184\153\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\184\170\224\184\185\224\184\135",
				["TeleportTitle"] = "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155)",
				["TeleportDesc"] = "\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\185\132\224\184\155\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\162\224\185\136\224\184\178\224\184\135\224\184\163\224\184\167\224\184\148\224\185\128\224\184\163\224\185\135\224\184\167\224\185\129\224\184\165\224\184\176\224\184\149\224\185\136\224\184\173\224\185\128\224\184\153\224\184\183\224\185\136\224\184\173\224\184\135",
				["SingleTitle"] = "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\185\131\224\184\154\224\185\128\224\184\148\224\184\181\224\184\162\224\184\167",
				["SingleDesc"] = "\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\185\132\224\184\155\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162 1 \224\185\131\224\184\154\224\185\129\224\184\165\224\185\137\224\184\167\224\184\129\224\184\165\224\184\177\224\184\154\224\184\161\224\184\178\224\184\151\224\184\181\224\185\136\224\184\144\224\184\178\224\184\153\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181",
				["SecPlace"] = "\224\184\153\224\184\179\224\184\170\224\185\136\224\184\135\224\185\129\224\184\165\224\184\176\224\184\159\224\184\177\224\184\129\224\185\132\224\184\130\224\185\136",
				["PlaceTitle"] = "\224\184\167\224\184\178\224\184\135\224\185\132\224\184\130\224\185\136\224\185\131\224\184\153\224\184\163\224\184\177\224\184\135",
				["PlaceDesc"] = "\224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154\224\184\154\224\185\137\224\184\178\224\184\153\224\185\129\224\184\165\224\184\176\224\184\153\224\184\179\224\185\132\224\184\130\224\185\136\224\185\131\224\184\153\224\184\149\224\184\177\224\184\167\224\185\132\224\184\155\224\184\167\224\184\178\224\184\135\224\184\154\224\184\153\224\185\129\224\184\151\224\185\136\224\184\153\224\184\159\224\184\177\224\184\129\224\184\151\224\184\181\224\185\136\224\184\167\224\185\136\224\184\178\224\184\135\224\185\129\224\184\165\224\185\137\224\184\167\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\159\224\184\177\224\184\129\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181",
				["AutoPlaceTitle"] = "\224\184\167\224\184\178\224\184\135\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\151\224\184\184\224\184\129 5 \224\184\159\224\184\173\224\184\135)",
				["AutoPlaceDesc"] = "\224\184\129\224\184\165\224\184\177\224\184\154\224\184\154\224\185\137\224\184\178\224\184\153\224\184\151\224\184\184\224\184\129\224\184\132\224\184\163\224\184\177\224\185\137\224\184\135\224\184\151\224\184\181\224\185\136\224\184\130\224\185\130\224\184\161\224\184\162\224\184\132\224\184\163\224\184\154 5 \224\184\159\224\184\173\224\184\135\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\184\153\224\184\179\224\185\132\224\184\130\224\185\136\224\185\132\224\184\155\224\184\167\224\184\178\224\184\135",
				["HatchTitle"] = "\224\184\159\224\184\177\224\184\129\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["HatchDesc"] = "\224\184\170\224\184\177\224\185\136\224\184\135\224\184\159\224\184\177\224\184\129\224\185\132\224\184\130\224\185\136\224\184\151\224\184\181\224\185\136\224\184\158\224\184\163\224\185\137\224\184\173\224\184\161\224\184\159\224\184\177\224\184\129\224\184\173\224\184\162\224\185\136\224\184\178\224\184\135\224\184\149\224\185\136\224\184\173\224\185\128\224\184\153\224\184\183\224\185\136\224\184\173\224\184\135\224\184\136\224\184\178\224\184\129\224\184\151\224\184\184\224\184\129\224\184\151\224\184\181\224\185\136",
				["ReturnTitle"] = "\224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154\224\184\158\224\184\183\224\185\137\224\184\153\224\184\151\224\184\181\224\185\136\224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162",
				["ReturnDesc"] = "\224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154\224\185\128\224\184\130\224\185\137\224\184\178\224\184\158\224\184\183\224\185\137\224\184\153\224\184\151\224\184\181\224\185\136\224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\184\171\224\184\165\224\184\177\224\184\135\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\185\128\224\184\170\224\184\163\224\185\135\224\184\136",
				["AutoTreadmillTitle"] = "\224\184\167\224\184\180\224\185\136\224\184\135\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["AutoTreadmillDesc"] = "\224\185\132\224\184\155\224\184\167\224\184\180\224\185\136\224\184\135\224\184\154\224\184\153\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\151\224\184\181\224\185\136\224\184\154\224\185\137\224\184\178\224\184\153\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\185\132\224\184\130\224\185\136\224\184\149\224\184\178\224\184\161\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\128\224\184\129\224\184\180\224\184\148",
				["UpgradeTreadmillTitle"] = "\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["UpgradeTreadmillDesc"] = "\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\151\224\184\181\224\185\136\224\184\154\224\185\137\224\184\178\224\184\153\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181\224\184\151\224\184\181\224\185\136\224\184\161\224\184\181\224\185\128\224\184\135\224\184\180\224\184\153\224\184\158\224\184\173",
				["BuyTrailsTitle"] = "\224\184\139\224\184\183\224\185\137\224\184\173\224\185\129\224\184\165\224\184\176\224\185\131\224\184\170\224\185\136 Trail \224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["BuyTrailsDesc"] = "\224\184\139\224\184\183\224\185\137\224\184\173\224\185\128\224\184\170\224\185\137\224\184\153\224\184\151\224\184\178\224\184\135\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\185\129\224\184\165\224\184\176\224\184\170\224\184\167\224\184\161\224\185\131\224\184\170\224\185\136\224\184\173\224\184\177\224\184\153\224\184\151\224\184\181\224\185\136\224\184\148\224\184\181\224\184\151\224\184\181\224\185\136\224\184\170\224\184\184\224\184\148\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\128\224\184\135\224\184\180\224\184\153\224\184\158\224\184\173",
				["HideNotEnoughMoneyTitle"] = "\224\184\139\224\185\136\224\184\173\224\184\153\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\185\128\224\184\135\224\184\180\224\184\153\224\185\132\224\184\161\224\185\136\224\184\158\224\184\173",
				["HideNotEnoughMoneyDesc"] = "\224\184\154\224\184\165\224\185\135\224\184\173\224\184\129\224\185\129\224\184\165\224\184\176\224\184\139\224\185\136\224\184\173\224\184\153\224\184\130\224\185\137\224\184\173\224\184\132\224\184\167\224\184\178\224\184\161\224\184\170\224\184\181\224\185\129\224\184\148\224\184\135 'Not enough money' \224\184\136\224\184\178\224\184\129\224\184\149\224\184\177\224\184\167\224\185\128\224\184\129\224\184\161\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
			},
			["Character"] = {
				["SecSafety"] = "\224\184\132\224\184\167\224\184\178\224\184\161\224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162\224\185\129\224\184\165\224\184\176\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163",
				["GodmodeTitle"] = "\224\185\130\224\184\171\224\184\161\224\184\148\224\184\173\224\184\161\224\184\149\224\184\176",
				["GodmodeDesc"] = "\224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153\224\184\148\224\184\178\224\185\128\224\184\161\224\184\136\224\184\136\224\184\178\224\184\129\224\184\170\224\184\180\224\185\136\224\184\135\224\184\129\224\184\181\224\184\148\224\184\130\224\184\167\224\184\178\224\184\135\224\185\129\224\184\165\224\184\176\224\184\129\224\184\177\224\184\154\224\184\148\224\184\177\224\184\129 100%",
				["UnstickTitle"] = "\224\185\129\224\184\129\224\185\137\224\184\149\224\184\177\224\184\167\224\184\149\224\184\180\224\184\148 / \224\184\165\224\184\135\224\184\136\224\184\178\224\184\129\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135",
				["UnstickDesc"] = "\224\184\171\224\184\165\224\184\184\224\184\148\224\184\173\224\184\173\224\184\129\224\184\136\224\184\178\224\184\129\224\184\170\224\184\180\224\185\136\224\184\135\224\184\129\224\184\181\224\184\148\224\184\130\224\184\167\224\184\178\224\184\135\224\184\171\224\184\163\224\184\183\224\184\173\224\184\173\224\184\184\224\184\155\224\184\129\224\184\163\224\184\147\224\185\140\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181",
				["SecFlight"] = "\224\184\129\224\184\178\224\184\163\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\129\224\184\178\224\184\163\224\184\154\224\184\180\224\184\153",
				["SpeedTitle"] = "\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\184\129\224\184\178\224\184\163\224\184\154\224\184\180\224\184\153",
				["SpeedDesc"] = "\224\184\155\224\184\163\224\184\177\224\184\154\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\185\131\224\184\153\224\184\129\224\184\178\224\184\163\224\184\154\224\184\180\224\184\153 (Studs/\224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181)",
			},
			["Settings"] = {
				["SecDashboard"] = "\224\185\129\224\184\148\224\184\138\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\170\224\184\148",
				["DashTitle"] = "\224\185\129\224\184\148\224\184\138\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\170\224\184\148",
				["DashDesc"] = "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176: %s\n\224\185\130\224\184\171\224\184\161\224\184\148\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161: %s\n\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\185\132\224\184\130\224\185\136\224\185\131\224\184\153\224\184\149\224\184\177\224\184\167: %d \224\184\159\224\184\173\224\184\135\n\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\184\129\224\184\178\224\184\163\224\184\154\224\184\180\224\184\153: %d Studs/\224\184\167\224\184\180",
				["SecBlacklist"] = "\224\184\149\224\184\177\224\184\167\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\130\224\184\139\224\184\153\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163",
				["BlacklistToggleTitle"] = "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\131\224\184\153\224\185\130\224\184\139\224\184\153: %s",
				["BlacklistToggleDesc"] = "\224\185\128\224\184\155\224\184\180\224\184\148/\224\184\155\224\184\180\224\184\148 \224\184\129\224\184\178\224\184\163\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\151\224\184\177\224\185\136\224\184\167\224\185\132\224\184\155\224\185\131\224\184\153\224\185\130\224\184\139\224\184\153 %s (\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154 Secret+ \224\184\136\224\184\176\224\185\128\224\184\129\224\185\135\224\184\154\224\185\128\224\184\170\224\184\161\224\184\173)",
				["SecUI"] = "\224\184\155\224\184\163\224\184\177\224\184\154\224\185\129\224\184\149\224\185\136\224\184\135\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135",
				["TranspTitle"] = "\224\184\132\224\184\167\224\184\178\224\184\161\224\185\130\224\184\155\224\184\163\224\185\136\224\184\135\224\185\131\224\184\170\224\184\130\224\184\173\224\184\135\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135",
				["TranspDesc"] = "\224\184\155\224\184\163\224\184\177\224\184\154\224\184\132\224\184\167\224\184\178\224\184\161\224\185\130\224\184\155\224\184\163\224\185\136\224\184\135\224\185\129\224\184\170\224\184\135\224\184\130\224\184\173\224\184\135\224\184\158\224\184\183\224\185\137\224\184\153\224\184\171\224\184\165\224\184\177\224\184\135\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 (0% - 90%)",
				["ThemeTitle"] = "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\152\224\184\181\224\184\161\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135",
				["SecPerformance"] = "\224\184\155\224\184\163\224\184\176\224\184\170\224\184\180\224\184\151\224\184\152\224\184\180\224\184\160\224\184\178\224\184\158\224\185\129\224\184\165\224\184\176\224\184\129\224\184\163\224\184\178\224\184\159\224\184\180\224\184\129",
				["PerformanceTitle"] = "\224\185\130\224\184\171\224\184\161\224\184\148\224\184\160\224\184\178\224\184\158\224\184\129\224\184\178\224\184\129\224\184\130\224\184\177\224\185\137\224\184\153\224\184\170\224\184\184\224\184\148 (Ultra Potato Mode)",
				["PerformanceDesc"] = "\224\184\165\224\184\148\224\184\129\224\184\163\224\184\178\224\184\159\224\184\180\224\184\129 \224\184\165\224\184\154 Texture \224\184\130\224\184\173\224\184\135\224\185\130\224\184\161\224\185\128\224\184\148\224\184\165 \224\184\155\224\184\180\224\184\148\224\185\128\224\184\135\224\184\178 \224\184\155\224\184\180\224\184\148\224\185\129\224\184\170\224\184\135\224\185\132\224\184\159 \224\185\129\224\184\165\224\184\176\224\184\155\224\184\180\224\184\148\224\185\128\224\184\173\224\184\159\224\185\128\224\184\159\224\184\129\224\184\149\224\185\140\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\184\132\224\184\167\224\184\178\224\184\161\224\184\165\224\184\183\224\185\136\224\184\153\224\184\130\224\184\177\224\185\137\224\184\153\224\184\170\224\184\184\224\184\148",
				["Disable3DTitle"] = "\224\184\155\224\184\180\224\184\148\224\185\128\224\184\163\224\184\153\224\185\128\224\184\148\224\184\173\224\184\163\224\185\140 3D / \224\184\136\224\184\173\224\184\148\224\184\179 (\224\184\155\224\184\163\224\184\176\224\184\171\224\184\162\224\184\177\224\184\148 GPU 95%)",
				["Disable3DDesc"] = "\224\184\171\224\184\162\224\184\184\224\184\148\224\184\155\224\184\163\224\184\176\224\184\161\224\184\167\224\184\165\224\184\156\224\184\165\224\184\160\224\184\178\224\184\158 3D \224\184\165\224\184\148\224\184\160\224\184\178\224\184\163\224\184\176\224\184\129\224\184\178\224\184\163\224\185\140\224\184\148\224\184\136\224\184\173\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173 1% \224\185\128\224\184\171\224\184\161\224\184\178\224\184\176\224\184\170\224\184\179\224\184\171\224\184\163\224\184\177\224\184\154\224\185\128\224\184\155\224\184\180\224\184\148\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161\224\184\151\224\184\180\224\185\137\224\184\135\224\185\132\224\184\167\224\185\137\224\184\130\224\185\137\224\184\178\224\184\161\224\184\132\224\184\183\224\184\153 (\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 UI \224\184\162\224\184\177\224\184\135\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153\224\184\155\224\184\129\224\184\149\224\184\180)",
				["LangTitle"] = "\224\184\160\224\184\178\224\184\169\224\184\178",
				["BtnTranslate"] = "\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\185\128\224\184\155\224\185\135\224\184\153\224\184\160\224\184\178\224\184\169\224\184\178\224\184\173\224\184\177\224\184\135\224\184\129\224\184\164\224\184\169",
				["DescTranslate"] = "\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\184\160\224\184\178\224\184\169\224\184\178\224\184\130\224\184\173\224\184\135\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\128\224\184\155\224\185\135\224\184\153\224\184\160\224\184\178\224\184\169\224\184\178\224\184\173\224\184\177\224\184\135\224\184\129\224\184\164\224\184\169",
				["SecSystem"] = "\224\184\136\224\184\177\224\184\148\224\184\129\224\184\178\224\184\163\224\184\163\224\184\176\224\184\154\224\184\154",
				["AntiAFKTitle"] = "\224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153 AFK \224\185\128\224\184\149\224\184\176 (\224\184\129\224\184\148 Esc 2 \224\184\151\224\184\181 / \224\184\163\224\184\173\224\184\135\224\184\163\224\184\177\224\184\154\224\184\161\224\184\183\224\184\173\224\184\150\224\184\183\224\184\173)",
				["AntiAFKDesc"] = "\224\184\129\224\184\148 Esc \224\185\128\224\184\155\224\184\180\224\184\148-\224\184\155\224\184\180\224\184\148\224\185\128\224\184\161\224\184\153\224\184\185\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\184\151\224\184\184\224\184\129 10 \224\184\153\224\184\178\224\184\151\224\184\181 + \224\184\170\224\184\177\224\184\141\224\184\141\224\184\178\224\184\147 Touch \224\184\161\224\184\183\224\184\173\224\184\150\224\184\183\224\184\173 \224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\149\224\184\177\224\184\167\224\184\153\224\184\177\224\184\154 20 \224\184\153\224\184\178\224\184\151\224\184\181 \224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162\224\185\132\224\184\161\224\185\136\224\185\129\224\184\149\224\184\176\224\185\128\224\184\129\224\184\161",
				["ResetTitle"] = "\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163",
				["ResetDesc"] = "\224\184\165\224\185\137\224\184\178\224\184\135\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\160\224\184\178\224\184\162\224\185\131\224\184\153\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\129\224\184\165\224\184\176\224\184\155\224\184\165\224\184\148\224\184\165\224\185\135\224\184\173\224\184\129\224\184\129\224\184\178\224\184\163\224\185\128\224\184\132\224\184\165\224\184\183\224\185\136\224\184\173\224\184\153\224\184\151\224\184\181\224\185\136\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181",
				["RejoinTitle"] = "\224\185\128\224\184\130\224\185\137\224\184\178\224\185\128\224\184\139\224\184\180\224\184\163\224\185\140\224\184\159\224\185\128\224\184\167\224\184\173\224\184\163\224\185\140\224\185\131\224\184\171\224\184\161\224\185\136",
				["RejoinDesc"] = "\224\185\128\224\184\138\224\184\183\224\185\136\224\184\173\224\184\161\224\184\149\224\185\136\224\184\173\224\184\129\224\184\165\224\184\177\224\184\154\224\185\128\224\184\130\224\185\137\224\184\178\224\185\128\224\184\139\224\184\180\224\184\163\224\185\140\224\184\159\224\185\128\224\184\167\224\184\173\224\184\163\224\185\140\224\185\128\224\184\148\224\184\180\224\184\161\224\185\131\224\184\171\224\184\161\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["UnloadTitle"] = "\224\184\155\224\184\180\224\184\148\224\184\170\224\184\132\224\184\163\224\184\180\224\184\155\224\184\149\224\185\140\224\184\170\224\184\161\224\184\154\224\184\185\224\184\163\224\184\147\224\185\140",
				["UnloadDesc"] = "\224\184\171\224\184\162\224\184\184\224\184\148\224\184\129\224\184\178\224\184\163\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153\224\184\130\224\184\173\224\184\135\224\184\165\224\184\185\224\184\155\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\129\224\184\165\224\184\176\224\184\155\224\184\180\224\184\148\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135\224\184\173\224\184\162\224\185\136\224\184\178\224\184\135\224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162",
			},
			["Notifications"] = {
				["PlaceStarted"] = "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154\224\184\154\224\185\137\224\184\178\224\184\153\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\184\153\224\184\179\224\185\132\224\184\130\224\185\136\224\185\132\224\184\155\224\184\167\224\184\178\224\184\135...",
				["PlaceDone"] = "\224\184\167\224\184\178\224\184\135\224\185\132\224\184\130\224\185\136\224\184\154\224\184\153\224\185\129\224\184\151\224\185\136\224\184\153\224\184\159\224\184\177\224\184\129\224\185\129\224\184\165\224\184\176\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\159\224\184\177\224\184\129\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162!",
				["AutoPlaceStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\167\224\184\178\224\184\135\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\151\224\184\184\224\184\129 5 \224\184\159\224\184\173\224\184\135)",
				["AutoPlaceStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\167\224\184\178\224\184\135\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["NoEggFound"] = "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\185\132\224\184\130\224\185\136\224\184\151\224\184\181\224\185\136\224\184\149\224\184\163\224\184\135\224\184\149\224\184\178\224\184\161\224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130\224\185\131\224\184\153\224\184\130\224\184\147\224\184\176\224\184\153\224\184\181\224\185\137",
				["UnstickDone"] = "\224\184\170\224\185\136\224\184\135\224\184\132\224\184\179\224\184\170\224\184\177\224\185\136\224\184\135\224\185\129\224\184\129\224\185\137\224\184\149\224\184\177\224\184\167\224\184\149\224\184\180\224\184\148\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162!",
				["TweenStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\154\224\184\180\224\184\153\224\185\128\224\184\163\224\185\135\224\184\167)",
				["TweenStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\154\224\184\180\224\184\153\224\185\128\224\184\163\224\185\135\224\184\167)",
				["TeleportStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155)",
				["TeleportStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155)",
				["HatchStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\159\224\184\177\224\184\129\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["HatchStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\159\224\184\177\224\184\129\224\185\132\224\184\130\224\185\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["ReturnStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154\224\184\158\224\184\183\224\185\137\224\184\153\224\184\151\224\184\181\224\185\136\224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162",
				["ReturnStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154\224\184\158\224\184\183\224\185\137\224\184\153\224\184\151\224\184\181\224\185\136\224\184\155\224\184\165\224\184\173\224\184\148\224\184\160\224\184\177\224\184\162",
				["AutoTreadmillStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\167\224\184\180\224\185\136\224\184\135\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\167\224\185\136\224\184\178\224\184\135)",
				["AutoTreadmillStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\167\224\184\180\224\185\136\224\184\135\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["UpgradeTreadmillStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["UpgradeTreadmillStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["BuyTrailsStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\139\224\184\183\224\185\137\224\184\173\224\185\129\224\184\165\224\184\176\224\185\131\224\184\170\224\185\136 Trail \224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["BuyTrailsStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\139\224\184\183\224\185\137\224\184\173\224\185\129\224\184\165\224\184\176\224\185\131\224\184\170\224\185\136 Trail \224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180",
				["HideNotEnoughMoneyStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\139\224\185\136\224\184\173\224\184\153\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\185\128\224\184\135\224\184\180\224\184\153\224\185\132\224\184\161\224\185\136\224\184\158\224\184\173",
				["HideNotEnoughMoneyStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\139\224\185\136\224\184\173\224\184\153\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\185\128\224\184\135\224\184\180\224\184\153\224\185\132\224\184\161\224\185\136\224\184\158\224\184\173",
				["GodmodeStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\185\130\224\184\171\224\184\161\224\184\148\224\184\173\224\184\161\224\184\149\224\184\176",
				["GodmodeStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\185\130\224\184\171\224\184\161\224\184\148\224\184\173\224\184\161\224\184\149\224\184\176",
				["PerformanceStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\185\130\224\184\171\224\184\161\224\184\148\224\184\160\224\184\178\224\184\158\224\184\129\224\184\178\224\184\129\224\184\130\224\184\177\224\185\137\224\184\153\224\184\170\224\184\184\224\184\148 (\224\184\165\224\184\154 Texture \224\185\129\224\184\165\224\184\176\224\185\129\224\184\170\224\184\135\224\185\128\224\184\135\224\184\178)",
				["PerformanceStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\185\130\224\184\171\224\184\161\224\184\148\224\184\160\224\184\178\224\184\158\224\184\129\224\184\178\224\184\129\224\184\130\224\184\177\224\185\137\224\184\153\224\184\170\224\184\184\224\184\148",
				["Disable3DStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\185\130\224\184\171\224\184\161\224\184\148\224\184\155\224\184\163\224\184\176\224\184\171\224\184\162\224\184\177\224\184\148 GPU (\224\184\155\224\184\180\224\184\148\224\185\128\224\184\163\224\184\153\224\185\128\224\184\148\224\184\173\224\184\163\224\185\140 3D)",
				["Disable3DStopped"] = "\224\184\132\224\184\183\224\184\153\224\184\132\224\185\136\224\184\178\224\184\129\224\184\178\224\184\163\224\185\129\224\184\170\224\184\148\224\184\135\224\184\156\224\184\165 3D \224\184\149\224\184\178\224\184\161\224\184\155\224\184\129\224\184\149\224\184\180\224\185\129\224\184\165\224\185\137\224\184\167",
				["AntiAFKStarted"] = "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153 AFK (\224\184\129\224\184\148 Esc 2 \224\184\151\224\184\181 \224\184\151\224\184\184\224\184\129 10 \224\184\153\224\184\178\224\184\151\224\184\181 + \224\184\163\224\184\173\224\184\135\224\184\163\224\184\177\224\184\154\224\184\161\224\184\183\224\184\173\224\184\150\224\184\183\224\184\173)",
				["AntiAFKStopped"] = "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 \224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153 AFK",
				["LangSwitched"] = "\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\184\160\224\184\178\224\184\169\224\184\178\224\185\128\224\184\155\224\185\135\224\184\153\224\184\160\224\184\178\224\184\169\224\184\178\224\185\132\224\184\151\224\184\162\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167!",
			},
		},
	}
	Fk = (Fk or {})
	local hk, Ok, Yk, Tk
	local xk = { [1] = "Farm", [2] = "EggSelect", [3] = "Character", [9] = "Settings" }
	local function Wk(e, ...)
		local r = (e == "TH")
		if h.delivering then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\167\224\184\178\224\184\135\224\185\132\224\184\130\224\185\136"
				or "Placing Egg"
		elseif h.securingEgg or h.holdingEggForGuard then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\171\224\184\162\224\184\180\224\184\154\224\185\132\224\184\130\224\185\136"
				or "Securing Egg"
		elseif h.teleporting then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155"
				or "Teleporting"
		elseif h.isReturning then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\154\224\184\180\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154"
				or "Returning"
		elseif h.glidingToTarget then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\154\224\184\180\224\184\153\224\185\132\224\184\155\224\184\130\224\185\130\224\184\161\224\184\162"
				or "Stealing"
		elseif h.onTreadmill or (L4 and L4()) then
			return r
					and "\224\184\173\224\184\162\224\184\185\224\185\136\224\184\154\224\184\153\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135"
				or "On Treadmill"
		elseif Y4 == "TWEEN" and not h.isReturning then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\171\224\184\178\224\185\132\224\184\130\224\185\136"
				or "Searching"
		elseif Y4 == "WARP" and not h.isReturning then
			return r
					and "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\171\224\184\178\224\185\132\224\184\130\224\185\136"
				or "Searching"
		else
			return r
					and "\224\184\158\224\184\163\224\185\137\224\184\173\224\184\161\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153"
				or "Ready"
		end
	end
	local function mk(e, ...)
		pcall(function(...)
			if e:IsA("TextLabel") or e:IsA("TextButton") or e:IsA("TextBox") then
				e.AutoLocalize = false
			end
			for e, y in ipairs(e:GetDescendants()) do
				if y:IsA("TextLabel") or y:IsA("TextButton") or y:IsA("TextBox") then
					y.AutoLocalize = false
				end
			end
		end)
	end
	local function eM(e, r, y, ...)
		if not e then
			return
		end
		pcall(function(...)
			if r and e.SetTitle then
				e:SetTitle(r)
			end
			if y and e.SetDesc then
				e:SetDesc(y)
			end
		end)
		pcall(function(...)
			if e.UIElements then
				if r and (e.UIElements.Title and e.UIElements.Title:IsA("TextLabel")) then
					e.UIElements.Title.AutoLocalize = false
					e.UIElements.Title.Text = r
				end
				if y and (e.UIElements.Desc and e.UIElements.Desc:IsA("TextLabel")) then
					e.UIElements.Desc.AutoLocalize = false
					e.UIElements.Desc.Text = y
				end
			end
		end)
	end
	local function rM(e, r, y, ...)
		pcall(function(...)
			if not e then
				return
			end
			if e.UIElements and (e.UIElements.Title and e.UIElements.Title:IsA("TextLabel")) then
				e.UIElements.Title.TextColor3 = r
			end
			if e.UIElements and e.UIElements.ButtonIcon then
				local y = e.UIElements.ButtonIcon:FindFirstChildOfClass("ImageLabel") or e.UIElements.ButtonIcon
				if y and y:IsA("ImageLabel") then
					y.ImageColor3 = r
				end
			end
			local u = nil
			if e.ButtonFrame and (e.ButtonFrame.UIElements and e.ButtonFrame.UIElements.Main) then
				u = e.ButtonFrame.UIElements.Main
			elseif e.ToggleFrame and (e.ToggleFrame.UIElements and e.ToggleFrame.UIElements.Main) then
				u = e.ToggleFrame.UIElements.Main
			elseif e.ElementFrame then
				u = e.ElementFrame
			elseif e.UIElements and e.UIElements.Main then
				u = e.UIElements.Main
			end
			if u and u:IsA("GuiObject") then
				local e = u:FindFirstChild("AccentCorner") or u:FindFirstChildOfClass("UICorner")
				if e then
					e:Destroy()
				end
				local j = u:FindFirstChild("CloutAccentStroke") or u:FindFirstChildOfClass("UIStroke")
				if j then
					j:Destroy()
				end
				local k = u:FindFirstChild("AccentSquircleOutline")
				if k then
					k:Destroy()
				end
				for e, r in ipairs(u:GetDescendants()) do
					if
						r:IsA("ImageLabel")
						and (
							string.find(tostring(r.Image), "117817408534198")
							or string.find(r.Name:lower(), "outline")
						)
					then
						r.Visible = false
						r.ImageTransparency = 1
					end
				end
				local a = y
				if not a then
					local e, y, u = r:ToHSV()
					a = Color3.fromHSV(e, math.clamp(y * 0.4, 0.18, 0.45), 0.18)
				end
				u.ThemeTag = nil
				u.ImageColor3 = a
				u.ImageTransparency = 0.08
			end
		end)
	end
	local function yM(...)
		rM(Fk.togTween, Color3.fromRGB(0, 195, 255), Color3.fromRGB(24, 40, 46))
		rM(Fk.togTeleport, Color3.fromRGB(168, 85, 247), Color3.fromRGB(36, 24, 46))
		rM(Fk.btnPlaceEgg, Color3.fromRGB(16, 215, 130), Color3.fromRGB(24, 45, 36))
		rM(Fk.togAutoPlaceEvery5, Color3.fromRGB(14, 165, 233), Color3.fromRGB(24, 38, 46))
		rM(Fk.togGodmode, Color3.fromRGB(244, 63, 94), Color3.fromRGB(46, 24, 28))
		rM(Fk.btnUnstick, Color3.fromRGB(249, 115, 22), Color3.fromRGB(46, 32, 24))
		rM(Fk.btnReset, Color3.fromRGB(99, 102, 241), Color3.fromRGB(25, 26, 46))
		rM(Fk.btnLangSettings, Color3.fromRGB(245, 180, 30), Color3.fromRGB(46, 38, 24))
	end
	local function uM(e, ...)
		local r = e or Xk or "EN"
		local y = Gk[r] or Gk.EN
		local u = { hk, Ok, Yk, Tk }
		local w = { "Farm", "EggSelect", "Character", "Settings" }
		for e, r in ipairs(u) do
			local u = w[e]
			local k = y.Tabs[u] or u
			if r then
				r.Title = k
				pcall(function(...)
					if r.SetTitle then
						r:SetTitle(k)
					end
				end)
				pcall(function(...)
					if r.UIElements and r.UIElements.Main then
						for r, y in ipairs(r.UIElements.Main:GetDescendants()) do
							if y:IsA("TextLabel") then
								y.AutoLocalize = false
								y.Text = k
							end
						end
					end
					if r.UIElements and r.UIElements.TabItem then
						for r, y in ipairs(r.UIElements.TabItem:GetDescendants()) do
							if y:IsA("TextLabel") then
								y.AutoLocalize = false
								y.Text = k
							end
						end
					end
				end)
			end
		end
		pcall(function(...)
			if Window and (Window.TabModule and Window.TabModule.Tabs) then
				for r, w in pairs(xk) do
					local u = Window.TabModule.Tabs[r]
					local j = y.Tabs[w] or w
					if u and j then
						u.Title = j
						if u.UIElements and u.UIElements.Main then
							for r, y in ipairs(u.UIElements.Main:GetDescendants()) do
								if y:IsA("TextLabel") then
									y.AutoLocalize = false
									y.Text = j
								end
							end
						end
						if u.UIElements and u.UIElements.TabItem then
							for r, y in ipairs(u.UIElements.TabItem:GetDescendants()) do
								if y:IsA("TextLabel") then
									y.AutoLocalize = false
									y.Text = j
								end
							end
						end
					end
				end
			end
		end)
	end
	local function wM(e, ...)
		local r = Gk[e] or Gk.EN
		uM(e)
		eM(Fk.secModes, r.Farm.SecModes)
		eM(Fk.togTween, r.Farm.TweenTitle, r.Farm.TweenDesc)
		eM(Fk.togTeleport, r.Farm.TeleportTitle, r.Farm.TeleportDesc)
		eM(Fk.secPlace, r.Farm.SecPlace)
		eM(Fk.btnPlaceEgg, r.Farm.PlaceTitle, r.Farm.PlaceDesc)
		eM(Fk.togAutoPlaceEvery5, r.Farm.AutoPlaceTitle, r.Farm.AutoPlaceDesc)
		eM(Fk.togAutoHatch, r.Farm.HatchTitle, r.Farm.HatchDesc)
		eM(Fk.togAutoReturn, r.Farm.ReturnTitle, r.Farm.ReturnDesc)
		eM(Fk.togAutoTreadmill, r.Farm.AutoTreadmillTitle, r.Farm.AutoTreadmillDesc)
		eM(Fk.togAutoUpgradeTreadmill, r.Farm.UpgradeTreadmillTitle, r.Farm.UpgradeTreadmillDesc)
		eM(Fk.togAutoBuyTrails, r.Farm.BuyTrailsTitle, r.Farm.BuyTrailsDesc)
		if r.EggSelect then
			eM(Fk.secEggZones, r.EggSelect.SecZones, r.EggSelect.SecZonesDesc)
			eM(Fk.dropTargetZones, r.EggSelect.DropZonesTitle, r.EggSelect.DropZonesDesc)
			eM(Fk.secEggRarity, r.EggSelect.SecRarities, r.EggSelect.SecRaritiesDesc)
			eM(Fk.secEggRarities, r.EggSelect.SecRarities, r.EggSelect.SecRaritiesDesc)
			eM(Fk.dropTargetRarities, r.EggSelect.DropRaritiesTitle, r.EggSelect.DropRaritiesDesc)
			eM(Fk.togAlwaysSecret, r.EggSelect.AlwaysSecretPlus, r.EggSelect.AlwaysSecretPlusDesc)
		end
		eM(Fk.secSafety, r.Character.SecSafety)
		eM(Fk.togGodmode, r.Character.GodmodeTitle, r.Character.GodmodeDesc)
		eM(Fk.btnUnstick, r.Character.UnstickTitle, r.Character.UnstickDesc)
		eM(Fk.secFlight, r.Character.SecFlight)
		eM(Fk.sliderSpeed, r.Character.SpeedTitle, r.Character.SpeedDesc)
		eM(Fk.secDashboard, r.Settings.SecDashboard)
		eM(Fk.paraLiveDash, r.Settings.DashTitle)
		eM(Fk.secBlacklist, r.Settings.SecBlacklist)
		eM(Fk.secUI, r.Settings.SecUI)
		eM(Fk.dropLang, r.Settings.LangTitle)
		eM(Fk.sliderTransp, r.Settings.TranspTitle, r.Settings.TranspDesc)
		eM(Fk.dropTheme, r.Settings.ThemeTitle)
		eM(Fk.secPerformance, r.Settings.SecPerformance)
		eM(Fk.togPerformance, r.Settings.PerformanceTitle, r.Settings.PerformanceDesc)
		eM(Fk.togDisable3D, r.Settings.Disable3DTitle, r.Settings.Disable3DDesc)
		eM(Fk.secSystem, r.Settings.SecSystem)
		eM(Fk.togAntiAFK, r.Settings.AntiAFKTitle, r.Settings.AntiAFKDesc)
		eM(Fk.btnReset, r.Settings.ResetTitle, r.Settings.ResetDesc)
		eM(Fk.btnRejoin, r.Settings.RejoinTitle, r.Settings.RejoinDesc)
		eM(Fk.btnUnload, r.Settings.UnloadTitle, r.Settings.UnloadDesc)
		yM()
	end
	local function jM(...)
		return function(cb, ...)
			if cb then
				pcall(cb)
			end
		end
	end

	local kM = {}
	kM.Gui = Instance.new("ScreenGui")
	kM.Gui.Name = "Clout_RESTORE_BAR"
	kM.Gui.ResetOnSpawn = false
	kM.Gui.DisplayOrder = 999999
	kM.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	kM.Gui.AutoLocalize = false
	pcall(function(...)
		if syn and syn.protect_gui then
			syn.protect_gui(kM.Gui)
			kM.Gui.Parent = game:GetService("CoreGui")
		else
			kM.Gui.Parent = o:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
		end
	end)
	if not kM.Gui.Parent then
		kM.Gui.Parent = game:GetService("CoreGui")
	end
	kM.Btn = Instance.new("ImageButton")
	kM.Btn.Name = "Clout_SquareLogoButton"
	kM.Btn.Size = UDim2.fromOffset(46, 46)
	kM.Btn.Position = UDim2.new(0, 20, 0, 20)
	kM.Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	kM.Btn.Active = true
	kM.Btn.Selectable = true
	kM.Btn.Visible = false
	kM.Btn.ZIndex = 999999
	kM.Btn.AutoLocalize = false
	kM.Btn.Parent = kM.Gui;
	Instance.new("UICorner", kM.Btn).CornerRadius = UDim.new(0, 10)
	kM.Stroke = Instance.new("UIStroke", kM.Btn)
	kM.Stroke.Color = Color3.fromRGB(0, 185, 255)
	kM.Stroke.Thickness = 1.6
	kM.Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	kM.Logo = Instance.new("ImageLabel", kM.Btn)
	kM.Logo.Name = "LogoIcon"
	kM.Logo.Size = UDim2.fromOffset(36, 36)
	kM.Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
	kM.Logo.AnchorPoint = Vector2.new(0.5, 0.5)
	kM.Logo.BackgroundTransparency = 1
	kM.Logo.Image = dk
	kM.Logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
	kM.Logo.ZIndex = 1000000
	Instance.new("UICorner", kM.Logo).CornerRadius = UDim.new(0, 8)
	kM.isDragging = false
	kM.dragStart = nil
	kM.startPos = nil
	kM.Btn.InputBegan:Connect(function(e, ...)
		if e.UserInputType == Enum.UserInputType.MouseButton1 or e.UserInputType == Enum.UserInputType.Touch then
			kM.isDragging = true
			kM.dragStart = e.Position
			kM.startPos = kM.Btn.Position
		end
	end)
	w.InputEnded:Connect(function(e, ...)
		if e.UserInputType == Enum.UserInputType.MouseButton1 or e.UserInputType == Enum.UserInputType.Touch then
			kM.isDragging = false
		end
	end)
	w.InputChanged:Connect(function(e, ...)
		if
			kM.isDragging
			and (e.UserInputType == Enum.UserInputType.MouseMovement or e.UserInputType == Enum.UserInputType.Touch)
		then
			local y = e.Position - kM.dragStart
			kM.Btn.Position = UDim2.new(
				kM.startPos.X.Scale,
				kM.startPos.X.Offset + y.X,
				kM.startPos.Y.Scale,
				kM.startPos.Y.Offset + y.Y
			)
		end
	end)
	
	local function aM(...)
		h.alive = false
		pcall(x)
		pcall(Ik)
		pcall(Ak)
		pcall(function(...)
			if CX then
				CX.setFullbright(false)
			end
		end)
		pcall(function(...)
			y:Set3dRenderingEnabled(true)
		end)
		pcall(function(...)
			local y = r:FindFirstChild("CloutHub_EggESP")
			if y then
				y:Destroy()
			end
		end)
		pcall(function(...)
			if (h.whUnload == true) and CX and CX.webhook then
				CX.webhook(
					"Clout Hub | Session Ended",
					string.format(
						"Uptime %dm, steals %d, sold %d, snipes %d",
						math.floor((os.clock() - (h.statsStart or os.clock())) / 60),
						(h.statsSteals or 0),
						(h.statsSold or 0),
						(h.statsSnipes or 0)
					),
					9807270
				)
			end
		end)
		pcall(D4)
		pcall(u4)
		if kM and kM.Gui then
			pcall(function(...)
				kM.Gui:Destroy()
			end)
		end
		if h.gui then
			pcall(function(...)
				h.gui:Destroy()
			end)
		end
		pcall(function(...)
			for r, y in ipairs(game.CoreGui:GetChildren()) do
				if y.Name:find("Clout_") or y.Name:find("DesyncSniperUI") or y.Name:find("WindUI") then
					y:Destroy()
				end
			end
		end)
	end
	h._unload = aM
	
	local function oM(...)
		local e = jM()
		local r = nil
		pcall(function(...)
			
			
			local winduiUrls = {
				"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
				"https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua",
			}
			local wsrc = nil
			for _, wurl in ipairs(winduiUrls) do
				local wok2, wres2 = pcall(function(...)
					return game:HttpGet(wurl)
				end)
				if wok2 and type(wres2) == "string" and #wres2 > 100000 then
					wsrc = wres2
					break
				end
			end
			if not wsrc then
				pcall(function(...)
					local sg = game:GetService("StarterGui")
					sg:SetCore("SendNotification", { Title = "Clout Hub", Text = "UI library (WindUI) could not be downloaded, so the basic built-in menu is used. Check your internet and run the script again.", Duration = 10 })
				end)
				warn("[CloutHub] UI library (WindUI) could not be downloaded from any URL in winduiUrls")
				error("windui download failed")
			end
			local wfn = loadstring(wsrc)
			if wfn and setfenv then
				pcall(function(...)
					setfenv(wfn, setmetatable({ ["print"] = function(...) end }, { ["__index"] = getgenv() }))
				end)
				local wok = nil
				local wres = nil
				wok, wres = pcall(wfn)
				if wok and wres then
					r = wres
				end
			end
			if r == nil then
				r = (loadstring(wsrc))()
			end
		end)
		local function j(e, ...)
			if not e then
				return
			end
			local y = false
			if r and r.Notify then
				local u = pcall(function(...)
					r:Notify(e)
					y = true
				end)
			end
			if not y then
				pcall(function(...)
					(game:GetService("StarterGui")):SetCore(
						"SendNotification",
						{
							["Title"] = tostring(e.Title or "Clout Hub"),
							["Text"] = tostring(e.Content or ""),
							["Duration"] = 3,
						}
					)
				end)
			end
		end
		if r then
			pcall(function(...)
				local e = r.Notify
				if e then
					r.Notify = function(r, y, ...)
						local u = pcall(function(...)
							e(r, y)
						end)
						if not u then
							pcall(function(...)
								(game:GetService("StarterGui")):SetCore(
									"SendNotification",
									{
										["Title"] = tostring(y and y.Title or "Clout Hub"),
										["Text"] = tostring(y and y.Content or ""),
										["Duration"] = 3,
									}
								)
							end)
						end
					end
				end
			end)
			local k = workspace.CurrentCamera
			local a = k and k.ViewportSize or Vector2.new(1280, 720)
			local V = w.TouchEnabled and not w.KeyboardEnabled
			local H = V and math.clamp(a.X * 0.7, 440, 500) or 500
			local t = V and math.clamp(a.Y * 0.72, 280, 340) or 340
			local s = UDim2.fromOffset(H, t)
			
			pcall(function(...)
				r:AddTheme({
					["Name"] = "Clout",
					["Accent"] = Color3.fromHex("#141414"),
					["Dialog"] = Color3.fromHex("#161617"),
					["Outline"] = Color3.fromHex("#d4af37"),
					["Text"] = Color3.fromHex("#faf3dd"),
					["Placeholder"] = Color3.fromHex("#a89f8a"),
					["Background"] = Color3.fromHex("#050505"),
					["Button"] = Color3.fromHex("#52525b"),
					["Icon"] = Color3.fromHex("#d4af37"),
					["Toggle"] = Color3.fromHex("#33C759"),
					["Slider"] = Color3.fromHex("#d4af37"),
					["Checkbox"] = Color3.fromHex("#d4af37"),
					["PanelBackground"] = Color3.fromHex("#f5edd0"),
					["PanelBackgroundTransparency"] = 0.95,
					["SliderIcon"] = Color3.fromHex("#8a6d1f"),
					["Primary"] = Color3.fromHex("#d4af37"),
					["LabelBackground"] = Color3.fromHex("#000000"),
					["LabelBackgroundTransparency"] = 0.83,
					["ElementBackground"] = Color3.fromHex("#151515"),
					["ElementBackgroundTransparency"] = 0,
				})
			end)
			local p = r:CreateWindow({
				["Title"] = "CloutHub | SAE | KEYLESS",
				["Author"] = "discord.gg/cyDpbvxeGN - KEYLESS",
				["Folder"] = "Clout_StealAnEgg",
				["Icon"] = "rbxassetid://136538008457744",
				["Theme"] = "Clout",
				["IconSize"] = 28,
				
				["OpenButton"] = {
					["Title"] = "CloutHub | SAE | KEYLESS",
					["Icon"] = "rbxassetid://136538008457744",
					["OnlyIcon"] = true,
					["CornerRadius"] = UDim.new(1, 0),
					["StrokeThickness"] = 2,
					["Color"] = ColorSequence.new(Color3.fromHex("#d4af37"), Color3.fromHex("#8a6d1f")),
					["Draggable"] = true,
					["Enabled"] = true,
				},
				["Size"] = s,
				["MinSize"] = Vector2.new(400, 240),
				["MaxSize"] = Vector2.new(900, 600),
				["Resizable"] = true,
				["SideBarWidth"] = V and 140 or 160,
				["ToggleKey"] = Enum.KeyCode.RightShift,
				["IgnoreAlerts"] = true,
				["Topbar"] = { ["Height"] = 44, ["ButtonsType"] = "Default" },
			})
			Window = p
			CloutWindLib = r
			pcall(function(...)
				if h.theme and h.theme ~= "Dark" then
					r:SetTheme(h.theme)
				end
			end)
			
			pcall(function(...)
				local qg = Instance.new("ScreenGui")
				qg.Name = "Clout_QuickBtn"
				qg.ResetOnSpawn = false
				qg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				qg.IgnoreGuiInset = true
				local qok, qh = pcall(gethui)
				qg.Parent = (qok and qh) or game:GetService("CoreGui")
				local qb = Instance.new("ImageButton")
				qb.Parent = qg
				qb.Size = UDim2.new(0, 46, 0, 46)
				qb.Position = UDim2.new(0, 14, 0.32, 0)
				qb.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
				qb.BackgroundTransparency = 0.2
				qb.Image = "rbxassetid://136538008457744"
				qb.ScaleType = Enum.ScaleType.Fit
				qb.Active = true
				local qc = Instance.new("UICorner")
				qc.CornerRadius = UDim.new(1, 0)
				qc.Parent = qb
				local qdrag = false
				local qmoved = false
				local qstart = nil
				qb.InputBegan:Connect(function(qi, ...)
					if
						qi.UserInputType == Enum.UserInputType.MouseButton1
						or qi.UserInputType == Enum.UserInputType.Touch
					then
						qdrag = true
						qmoved = false
						qstart = qi.Position
						qi.Changed:Connect(function(...)
							if qi.UserInputState == Enum.UserInputState.End then
								qdrag = false
							end
						end)
					end
				end)
				w.InputChanged:Connect(function(qm, ...)
					if
						qdrag
						and (
							qm.UserInputType == Enum.UserInputType.MouseMovement
							or qm.UserInputType == Enum.UserInputType.Touch
						)
					then
						local qd = qm.Position - qstart
						if qd.Magnitude > 8 then
							qmoved = true
						end
						qb.Position = UDim2.new(0, qb.Position.X.Offset + qd.X, 0, qb.Position.Y.Offset + qd.Y)
						qstart = qm.Position
					end
				end)
				qb.MouseButton1Click:Connect(function(...)
					if qmoved then
						return
					end
					pcall(function(...)
						if p.UIElements and p.UIElements.Main then
							p.UIElements.Main.Visible = not p.UIElements.Main.Visible
						end
					end)
				end)
			end)
			p.IgnoreAlerts = true
			pcall(function(...)
				if p.UIElements and p.UIElements.Main then
					p.UIElements.Main.Visible = false
				end
			end)
			local B = p:Tag({ ["Title"] = "Status: Ready", ["Color"] = Color3.fromRGB(0, 255, 160), ["Border"] = true })
			local J = 44
			local K = false
			local c = false
			local v = t
			task.spawn(function(...)
				task.wait(0.1)
				local e = p.UIElements and p.UIElements.Main
				if e then
					if e.AnchorPoint.Y ~= 0 then
						local y = e.Size.Y.Offset > 0 and e.Size.Y.Offset or t
						e.Position = UDim2.new(
							e.Position.X.Scale,
							e.Position.X.Offset,
							e.Position.Y.Scale,
							e.Position.Y.Offset - (y * e.AnchorPoint.Y)
						)
						e.AnchorPoint = Vector2.new(0.5, 0)
					end
					e.ClipsDescendants = false
					mk(e)
				end
			end)
			local function i(...)
				local e = p.UIElements and p.UIElements.Main
				if not e or c then
					return
				end
				c = true
				K = not K
				local r = p.UIElements.SideBarContainer
				local y = p.UIElements.MainBar
				local w = e:FindFirstChild("Background")
				local j = e:FindFirstChild("Main")
				if e.AnchorPoint.Y ~= 0 then
					local r = e.Size.Y.Offset > 0 and e.Size.Y.Offset or v
					e.Position = UDim2.new(
						e.Position.X.Scale,
						e.Position.X.Offset,
						e.Position.Y.Scale,
						e.Position.Y.Offset - (r * e.AnchorPoint.Y)
					)
					e.AnchorPoint = Vector2.new(0.5, 0)
				end
				local k = e.Size.X.Scale
				local a = e.Size.X.Offset
				if K then
					if e.Size.Y.Offset > J then
						v = e.Size.Y.Offset
					end
					e.ClipsDescendants = true
					if w then
						w.ClipsDescendants = true
					end
					if j then
						j.ClipsDescendants = true
					end
					if r then
						r.Visible = false
					end
					if y then
						y.Visible = false
					end
					e.Visible = true
					if j then
						j.Visible = true
					end
					local V = u:Create(
						e,
						TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
						{ ["Size"] = UDim2.new(k, a, 0, J) }
					)
					V:Play()
					task.delay(0.25, function(...)
						c = false
					end)
				else
					e.Visible = true
					if j then
						j.Visible = true
					end
					local V = v or t
					if r then
						r.Visible = true
					end
					if y then
						y.Visible = true
					end
					if p.TabModule and p.TabModule.SelectedTab then
						pcall(function(...)
							p.TabModule:SelectTab(p.TabModule.SelectedTab)
						end)
					end
					local H = u:Create(
						e,
						TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
						{ ["Size"] = UDim2.new(k, a, 0, V) }
					)
					H:Play()
					task.delay(0.25, function(...)
						if not K then
							e.ClipsDescendants = false
							if w then
								w.ClipsDescendants = false
							end
							if j then
								j.ClipsDescendants = false
							end
							if r then
								r.Visible = true
							end
							if y then
								y.Visible = true
							end
							if p.TabModule and p.TabModule.SelectedTab then
								pcall(function(...)
									p.TabModule:SelectTab(p.TabModule.SelectedTab)
								end)
							end
						end
						c = false
					end)
				end
			end
			p.Close = function(e, ...)
				i()
				local r = {}
				function r.Destroy(e, ...)
					aM()
				end
				return r
			end
			local function R(...)
				if p.UIElements and p.UIElements.Main then
					(u:Create(
						kM.Btn,
						TweenInfo.new(0.12, Enum.EasingStyle.Quart),
						{ ["Size"] = UDim2.fromOffset(42, 42) }
					)):Play()
					task.wait(0.01)
					kM.Btn.Size = UDim2.fromOffset(46, 46)
					p.UIElements.Main.Visible = true
					kM.Btn.Visible = false
					if p.TabModule and p.TabModule.SelectedTab then
						pcall(function(...)
							p.TabModule:SelectTab(p.TabModule.SelectedTab)
						end)
					end
				end
			end
			local function g(...)
				if p.UIElements and p.UIElements.Main then
					p.UIElements.Main.Visible = false
					kM.Btn.Visible = true
				end
			end
			kM.Btn.MouseButton1Click:Connect(R)
			p.Destroy = function(e, ...)
				g()
			end
			w.InputBegan:Connect(function(e, r, ...)
				if not r and e.KeyCode == Enum.KeyCode.RightShift then
					if p.UIElements and p.UIElements.Main then
						if p.UIElements.Main.Visible then
							g()
						else
							R()
						end
					end
				end
			end)
			local function Q(e, ...)
				local r = math.clamp(tonumber(e) or 0, 0, 90)
				local y = r / 100
				pcall(function(...)
					local e = p.UIElements and p.UIElements.Main
					if not e then
						return
					end
					if p.AcrylicPaint and p.AcrylicPaint.Frame then
						p.AcrylicPaint.Frame.Visible = (r == 0)
					end
					local u = e:FindFirstChild("Background")
					if u then
						if u:IsA("ImageLabel") then
							u.ImageTransparency = y
						elseif u:IsA("Frame") then
							u.BackgroundTransparency = y
						end
					end
				end)
			end
			local P = Gk[Xk] or Gk.EN
			hk = p:Tab({ ["Title"] = P.Tabs.Farm, ["Icon"] = "solar:box-minimalistic-bold" })
			Ok = p:Tab({ ["Title"] = P.Tabs.EggSelect or "Egg Selection", ["Icon"] = "lucide:egg" })
			Yk = p:Tab({ ["Title"] = P.Tabs.Character, ["Icon"] = "solar:user-bold" })
			local ESPtab = p:Tab({ ["Title"] = "ESP", ["Icon"] = "solar:eye-bold" })
			local Xtratab = p:Tab({ ["Title"] = "Shop & Sell", ["Icon"] = "solar:star-bold" })
			local Bosstab = p:Tab({ ["Title"] = "Boss", ["Icon"] = "solar:fire-bold" })
			local Stattab = p:Tab({ ["Title"] = "Stats", ["Icon"] = "solar:star-bold" })
			local Cfgtab = p:Tab({ ["Title"] = "Config", ["Icon"] = "solar:settings-bold" })
			local Whtab = p:Tab({ ["Title"] = "Webhook", ["Icon"] = "solar:chat-round-bold" })
			Tk = p:Tab({ ["Title"] = P.Tabs.Settings, ["Icon"] = "solar:settings-bold" })
			
			local cxStatusTag = nil
			pcall(function(...)
				cxStatusTag = p:Tag({ ["Title"] = "Idle", ["Color"] = Color3.fromHex("#FFC44D") })
			end)
			task.spawn(function(...)
				while h.alive do
					pcall(function(...)
						if cxStatusTag and cxStatusTag.SetTitle then
							cxStatusTag:SetTitle(tostring(h.statusText or "Idle"))
						end
					end)
					task.wait(1)
				end
			end)
			
		
		pcall(function()
			hk:Paragraph({["Title"]="CloutHub | SAE | KEYLESS", ["Desc"]="discord.gg/cyDpbvxeGN"})
			
			if Window and Window.Tag then
				pcall(function() Window:Tag({Title="discord.gg/cyDpbvxeGN", Color=Color3.fromRGB(255, 215, 0), Border=true}) end)
			end
		end)
		
		task.spawn(function()
			task.wait(1.2)
			pcall(function()
				local lib = CloutWindLib or Window
				if lib and lib.Notify then
					lib:Notify({Title="CloutHub | SAE | KEYLESS", Content="Discord: discord.gg/cyDpbvxeGN\nBug? Join discord & report! (auto copied)", Duration=5, Icon="star"})
				end
			end)
			pcall(function()
				game:GetService("StarterGui"):SetCore("SendNotification", {Title="CloutHub | SAE | KEYLESS", Text="Discord copied: discord.gg/cyDpbvxeGN | Bug? Join discord!", Duration=4})
			end)
			print("prince is the best")
		end)

		Fk.secModes = hk:Section({ ["Title"] = P.Farm.SecModes })
			local N = false
			local U = nil
			local l = nil
			Fk.togTween = hk:Toggle({
				["Title"] = P.Farm.TweenTitle,
				["Desc"] = P.Farm.TweenDesc,
				["Icon"] = "solar:compass-bold",
				["Value"] = h.pureTweenFarm,
				["Callback"] = function(e, ...)
					if N then
						return
					end
					if e then
						T4("TWEEN")
					else
						if Y4 == "TWEEN" or h.pureTweenFarm then
							T4("NONE")
						end
					end
				end,
			})
			U = Fk.togTween
			Fk.togTeleport = hk:Toggle({
				["Title"] = P.Farm.TeleportTitle,
				["Desc"] = P.Farm.TeleportDesc,
				["Icon"] = "solar:magic-stick-3-bold",
				["Value"] = h.autoFarmLoop,
				["Callback"] = function(e, ...)
					if N then
						return
					end
					if e then
						T4("WARP")
					else
						if Y4 == "WARP" or h.autoFarmLoop then
							T4("NONE")
						end
					end
				end,
			})
			l = Fk.togTeleport
			x4 = function(e, ...)
				pcall(function(...)
					if U and U.Set then
						N = true
						U:Set(e)
						N = false
					end
				end)
			end
			W4 = function(e, ...)
				pcall(function(...)
					if l and l.Set then
						N = true
						l:Set(e)
						N = false
					end
				end)
			end
			Fk.secFarmExtras = hk:Section({ ["Title"] = "Farm Extras" })
			Fk.togAutoClaim = hk:Toggle({
				["Title"] = "Auto Claim",
				["Desc"] = "Picks up earnings and rewards for you",
				["Icon"] = "solar:box-bold",
				["Value"] = (h.autoClaimRewards == true),
				["Callback"] = function(e, ...)
					h.autoClaimRewards = e
					pcall(x)
				end,
			})
			Fk.togEquipBest = hk:Toggle({
				["Title"] = "Equip Best Pets",
				["Desc"] = "Equips your strongest pets on its own",
				["Icon"] = "solar:star-bold",
				["Value"] = (h.autoEquipBest == true),
				["Callback"] = function(e, ...)
					h.autoEquipBest = e
					pcall(x)
				end,
			})
			Fk.togFastCycle = hk:Toggle({
				["Title"] = "Fast Cycle",
				["Desc"] = "Shorter waits between steals, grab cooldown under a second",
				["Icon"] = "solar:running-bold",
				["Value"] = (h.fastCycle == true),
				["Callback"] = function(e, ...)
					h.fastCycle = e
					pcall(x)
					CX.logAdd("Fast cycle " .. (e and "on" or "off"))
				end,
			})
			
			Fk.sliderSpeed = hk:Slider({
				["Title"] = P.Character.SpeedTitle,
				["Desc"] = P.Character.SpeedDesc,
				["Step"] = 25,
				["Value"] = { ["Min"] = 100, ["Max"] = 1000, ["Default"] = h.glideSpeed or 600 },
				["Callback"] = function(e, ...)
					h.glideSpeed = e
					Y(e)
				end,
			})
			Fk.secPlace = hk:Section({ ["Title"] = P.Farm.SecPlace })
			Fk.btnPlaceEgg = hk:Button({
				["Title"] = P.Farm.PlaceTitle,
				["Desc"] = P.Farm.PlaceDesc,
				["Icon"] = "solar:box-bold",
				["Callback"] = function(...)
					task.spawn(function(...)
						j({
							["Title"] = "CloutHub | SAE | KEYLESS",
							["Content"] = Gk[Xk].Notifications.PlaceStarted,
							["Icon"] = "loader",
						})
						h.statusText = "[Manual] Tweening to base..."
						v4(h.glideSpeed, nil, true)
						j({
							["Title"] = "CloutHub | SAE | KEYLESS",
							["Content"] = Gk[Xk].Notifications.PlaceDone,
							["Icon"] = "check-circle",
						})
					end)
				end,
			})
			Fk.togAutoPlaceEvery5 = hk:Toggle({
				["Title"] = P.Farm.AutoPlaceTitle or "Auto Place (Every 5)",
				["Desc"] = P.Farm.AutoPlaceDesc or "Heads home every 5 steals to plant",
				["Icon"] = "solar:box-minimalistic-bold",
				["Value"] = h.autoPlaceEvery5,
				["Callback"] = function(e, ...)
					h.autoPlaceEvery5 = e
					if not e then
						h.batchStealCount = 0
					end
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = "Auto Place (Every 5)",
						["Content"] = e and (r.Notifications.AutoPlaceStarted or "Auto Place (Every 5) enabled")
							or (r.Notifications.AutoPlaceStopped or "Auto Place (Every 5) disabled"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.togAutoHatch = hk:Toggle({
				["Title"] = P.Farm.HatchTitle,
				["Desc"] = P.Farm.HatchDesc,
				["Icon"] = "solar:star-bold",
				["Value"] = h.autoHatch,
				["Callback"] = function(e, ...)
					h.autoHatch = e
					j({
						["Title"] = "Auto Hatch",
						["Content"] = e and Gk[Xk].Notifications.HatchStarted or Gk[Xk].Notifications.HatchStopped,
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.togAutoReturn = hk:Toggle({
				["Title"] = P.Farm.ReturnTitle,
				["Desc"] = P.Farm.ReturnDesc,
				["Icon"] = "solar:undo-left-round-bold",
				["Value"] = h.autoGlide,
				["Callback"] = function(e, ...)
					h.autoGlide = e
					j({
						["Title"] = "Auto Return",
						["Content"] = e and Gk[Xk].Notifications.ReturnStarted or Gk[Xk].Notifications.ReturnStopped,
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.togAutoTreadmill = hk:Toggle({
				["Title"] = P.Farm.AutoTreadmillTitle or "Auto Treadmill",
				["Desc"] = P.Farm.AutoTreadmillDesc or "Hops on the treadmill while nothing to steal",
				["Icon"] = "solar:running-bold",
				["Value"] = h.autoTreadmill,
				["Callback"] = function(e, ...)
					h.autoTreadmill = e
					x()
					n4()
					if not e and (h.onTreadmill or L4()) then
						M4()
					end
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = "Auto Treadmill",
						["Content"] = e
								and (r.Notifications.AutoTreadmillStarted or "Auto Treadmill enabled (Runs when idle)")
							or (r.Notifications.AutoTreadmillStopped or "Auto Treadmill disabled"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.togAutoUpgradeTreadmill = hk:Toggle({
				["Title"] = P.Farm.UpgradeTreadmillTitle or "Auto Upgrade Treadmill",
				["Desc"] = P.Farm.UpgradeTreadmillDesc or "Upgrades your treadmill when you can afford it",
				["Icon"] = "solar:double-alt-arrow-up-bold",
				["Value"] = h.autoUpgradeTreadmill,
				["Callback"] = function(e, ...)
					h.autoUpgradeTreadmill = e
					x()
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = (Xk == "TH")
								and "\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\165\224\184\185\224\185\136\224\184\167\224\184\180\224\185\136\224\184\135"
							or "Upgrade Treadmill",
						["Content"] = e
								and (r.Notifications.UpgradeTreadmillStarted or "Auto Upgrade Treadmill enabled")
							or (r.Notifications.UpgradeTreadmillStopped or "Auto Upgrade Treadmill disabled"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.secEggZones = Ok:Section({ ["Title"] = (P.EggSelect and P.EggSelect.SecZones) or "Target Zones" })
			local D = {
				"Light Dark",
				"Titan Temple",
				"Cherry Blossom",
				"Cosmic",
				"Prehistoric",
				"Abyss Ocean",
				"Volcano",
				"Snow",
				"Jungle",
				"Desert",
				"Lake",
				"Forest",
			}
			local C = {}
			local q = {}
			for e, r in ipairs(M) do
				C[r] = r
				q[r] = r
			end
			local n = {}
			for e, r in pairs(h.selectedZones or {}) do
				if r and q[e] then
					table.insert(n, q[e])
				end
			end
			Fk.dropTargetZones = Ok:Dropdown({
				["Title"] = (P.EggSelect and P.EggSelect.DropZonesTitle) or "Selected Zones",
				["Desc"] = (P.EggSelect and P.EggSelect.DropZonesDesc) or "Tap to pick your target zones",
				["Values"] = D,
				["Value"] = n,
				["Multi"] = true,
				["Callback"] = function(e, ...)
					local r = {}
					local function y(e, ...)
						if type(e) == "table" then
							e = e.Title or e.Name or e[1] or ""
						end
						local y = tostring(e or "")
						local w = C[y]
						if not w and (y ~= "" and (y ~= "true" and y ~= "false")) then
							for e, r in ipairs(M) do
								if string.find(string.lower(y), string.lower(r)) then
									w = r
									break
								end
							end
						end
						if w and f[w] then
							r[w] = true
						end
					end
					if type(e) == "table" then
						for e, r in pairs(e) do
							if type(r) == "string" or type(r) == "table" then
								y(r)
							elseif type(e) == "string" and r == true then
								y(e)
							end
						end
					elseif type(e) == "string" then
						y(e)
					end
					h.selectedZones = r
					x()
				end,
			})
			Fk.secEggRarity = Ok:Section({ ["Title"] = (P.EggSelect and P.EggSelect.SecRarities) or "Target Rarities" })
			local I = {
				"Divine (Tier 6)",
				"Eternal (Tier 5)",
				"Secret (Tier 4)",
				"Cosmic (Tier 3)",
				"Mythic (Tier 2)",
				"Legendary (Tier 1)",
				"Epic",
				"Rare",
				"Uncommon",
				"Common",
			}
			local L = {
				["Divine (Tier 6)"] = "Divine",
				["Eternal (Tier 5)"] = "Eternal",
				["Secret (Tier 4)"] = "Secret",
				["Cosmic (Tier 3)"] = "Cosmic",
				["Mythic (Tier 2)"] = "Mythic",
				["Legendary (Tier 1)"] = "Legendary",
				["Epic"] = "Epic",
				["Rare"] = "Rare",
				["Uncommon"] = "Uncommon",
				["Common"] = "Common",
			}
			local E = {
				["Divine"] = "Divine (Tier 6)",
				["Eternal"] = "Eternal (Tier 5)",
				["Secret"] = "Secret (Tier 4)",
				["Cosmic"] = "Cosmic (Tier 3)",
				["Mythic"] = "Mythic (Tier 2)",
				["Legendary"] = "Legendary (Tier 1)",
				["Epic"] = "Epic",
				["Rare"] = "Rare",
				["Uncommon"] = "Uncommon",
				["Common"] = "Common",
			}
			local b = {}
			for e, r in pairs(h.selectedRarities or {}) do
				if r and E[e] then
					table.insert(b, E[e])
				end
			end
			Fk.dropTargetRarities = Ok:Dropdown({
				["Title"] = (P.EggSelect and P.EggSelect.DropRaritiesTitle) or "Selected Rarities",
				["Desc"] = (P.EggSelect and P.EggSelect.DropRaritiesDesc) or "Tap to pick rarities",
				["Values"] = I,
				["Value"] = b,
				["Multi"] = true,
				["Callback"] = function(e, ...)
					local r = {}
					local function y(e, ...)
						if type(e) == "table" then
							e = e.Title or e.Name or e[1] or ""
						end
						local y = string.lower(tostring(e or ""))
						for e, u in ipairs(X) do
							if string.find(y, string.lower(u)) then
								r[u] = true
								break
							end
						end
					end
					if type(e) == "table" then
						for e, r in pairs(e) do
							if type(r) == "string" or type(r) == "table" then
								y(r)
							elseif type(e) == "string" and r == true then
								y(e)
							end
						end
					elseif type(e) == "string" then
						y(e)
					end
					h.selectedRarities = r
					x()
				end,
			})
			Fk.secSafety = Yk:Section({ ["Title"] = P.Character.SecSafety })
			Fk.togGodmode = Yk:Toggle({
				["Title"] = P.Character.GodmodeTitle,
				["Desc"] = P.Character.GodmodeDesc,
				["Icon"] = "solar:shield-check-bold",
				["Value"] = (h.godmode == true),
				["Callback"] = function(e, ...)
					if N then
						return
					end
					if e then
						enableDesyncGodmode()
						j({
							["Title"] = "Godmode",
							["Content"] = Gk[Xk].Notifications.GodmodeStarted,
							["Icon"] = "shield-check",
						})
					else
						disableDesyncGodmode()
						j({
							["Title"] = "Godmode",
							["Content"] = Gk[Xk].Notifications.GodmodeStopped,
							["Icon"] = "shield-off",
						})
					end
				end,
			})
			godToggleSetter = function(e, ...)
				pcall(function(...)
					if Fk.togGodmode and Fk.togGodmode.Set then
						N = true
						Fk.togGodmode:Set(e)
						N = false
					end
				end)
			end
			Fk.btnUnstick = Yk:Button({
				["Title"] = P.Character.UnstickTitle,
				["Desc"] = P.Character.UnstickDesc,
				["Icon"] = "solar:exit-bold",
				["Callback"] = function(...)
					pcall(M4)
					pcall(C4)
					pcall(D4)
					j({
						["Title"] = "Unstick",
						["Content"] = Gk[Xk].Notifications.UnstickDone,
						["Icon"] = "check",
					})
				end,
			})
			Fk.secPanic = Yk:Section({ ["Title"] = "Panic Guard" })
			Fk.togPanic = Yk:Toggle({
				["Title"] = "Auto Leave On Watchlist",
				["Desc"] = "Disconnect the moment a listed player joins",
				["Icon"] = "solar:danger-triangle-bold",
				["Value"] = (h.panicAuto == true),
				["Callback"] = function(e, ...)
					h.panicAuto = e
					pcall(x)
				end,
			})
			Fk.inputPanicNames = Yk:Input({
				["Title"] = "Watchlist Names",
				["Desc"] = "Player names that panic you out, split by commas",
				["Placeholder"] = "AdminGuy, ModGirl",
				["Value"] = (h.panicNames or ""),
				["Callback"] = function(e)
					if e == h.panicNames then
						return
					end
					h.panicNames = e
					pcall(x)
					CX.logAdd("Panic watchlist updated")
				end,
			})
			Fk.togWhPanic = Yk:Toggle({
				["Title"] = "Webhook On Panic",
				["Desc"] = "Tell your discord when a panic leave happens",
				["Value"] = (h.whPanic ~= false),
				["Callback"] = function(e, ...)
					h.whPanic = e
					pcall(x)
				end,
			})
			Fk.togAntiStaff = Yk:Toggle({
				["Title"] = "Auto Leave On Staff",
				["Desc"] = "Dip instantly if a game admin or mod joins",
				["Icon"] = "solar:shield-warning-bold",
				["Value"] = (h.antiStaff == true),
				["Callback"] = function(e, ...)
					h.antiStaff = e
					pcall(x)
				end,
			})
			Fk.sliderStaffRank = Yk:Slider({
				["Title"] = "Min Staff Rank",
				["Desc"] = "Group rank that counts as staff, owner is 255",
				["Step"] = 5,
				["Value"] = { ["Min"] = 50, ["Max"] = 255, ["Default"] = h.staffMinRank or 250 },
				["Callback"] = function(e, ...)
					h.staffMinRank = e
					pcall(x)
				end,
			})
			
			Fk.secDashboard = Stattab:Section({ ["Title"] = P.Settings.SecDashboard })
			Fk.paraLiveDash = Stattab:Paragraph({
				["Title"] = P.Settings.DashTitle,
				["Desc"] = string.format(
					"Status: Ready\nFarm Mode: Idle\nCarried Eggs: 0\nFlight Speed: %d Studs/s",
					h.glideSpeed or 600
				),
			})
			Fk.secUI = Tk:Section({ ["Title"] = P.Settings.SecUI })
			Fk.dropLang = Tk:Dropdown({
				["Title"] = P.Settings.LangTitle,
				["Values"] = { "English", "\224\185\132\224\184\151\224\184\162" },
				["Value"] = (Xk == "EN" and "English" or "\224\185\132\224\184\151\224\184\162"),
				["Callback"] = function(e, ...)
					local r = (e == "\224\185\132\224\184\151\224\184\162") and "TH" or "EN"
					if r ~= Xk then
						Xk = r
						wM(Xk)
						pcall(x)
						j({
							["Title"] = (Xk == "TH") and "\224\184\160\224\184\178\224\184\169\224\184\178"
								or "Language",
							["Content"] = Gk[Xk].Notifications.LangSwitched,
							["Icon"] = "check-circle",
						})
					end
				end,
			})
			Fk.sliderTransp = Tk:Slider({
				["Title"] = P.Settings.TranspTitle,
				["Desc"] = P.Settings.TranspDesc,
				["Step"] = 5,
				["Value"] = { ["Min"] = 0, ["Max"] = 90, ["Default"] = 0 },
				["Callback"] = function(e, ...)
					Q(e)
				end,
			})
			Fk.dropTheme = Tk:Dropdown({
				["Title"] = P.Settings.ThemeTitle,
				["Values"] = { "Dark", "Rose", "Plant", "Red", "Sky", "Purple" },
				["Value"] = "Dark",
				["Callback"] = function(e, ...)
					h.theme = e
					pcall(function(...)
						r:SetTheme(e)
					end)
					pcall(x)
				end,
			})
			Fk.secCommunity = Tk:Section({ ["Title"] = "* Community - PLEASE JOIN DISCORD! *" })
			Fk.btnDiscord = Tk:Button({
				["Title"] = " JOIN DISCORD - discord.gg/cyDpbvxeGN ",
				["Desc"] = "* PLEASE JOIN! Tap to copy discord.gg/cyDpbvxeGN - If bug, report there! *",
				["Icon"] = "solar:link-bold",
				["Callback"] = function(...)
					CopyDiscord()
					j({
						["Title"] = "CloutHub | SAE | KEYLESS",
						["Content"] = "* INVITE COPIED! Please join discord.gg/cyDpbvxeGN - Bug? Report on Discord! *",
						["Icon"] = "check-circle",
					})
				end,
			})
			Fk.secESP = ESPtab:Section({ ["Title"] = "ESP & Visuals" })
			Fk.togEggESP = ESPtab:Toggle({
				["Title"] = "Egg ESP",
				["Desc"] = "Shows all eggs through walls with rarity colors",
				["Icon"] = "solar:eye-bold",
				["Value"] = (h.eggESP == true),
				["Callback"] = function(e, ...)
					espSet(e)
					pcall(x)
					j({
						["Title"] = "Egg ESP",
						["Content"] = e and "Egg ESP on" or "Egg ESP off",
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.togTrapESP = ESPtab:Toggle({
				["Title"] = "Trap ESP",
				["Desc"] = "Spots enemy traps through walls",
				["Icon"] = "solar:eye-bold",
				["Value"] = (h.trapESP == true),
				["Callback"] = function(e, ...)
					CX.setTrapESP(e)
					pcall(x)
				end,
			})
			Fk.togPlayerESP = ESPtab:Toggle({
				["Title"] = "Player ESP",
				["Desc"] = "Spots other players through walls",
				["Icon"] = "solar:eye-bold",
				["Value"] = (h.playerESP == true),
				["Callback"] = function(e, ...)
					CX.setPlayerESP(e)
					pcall(x)
				end,
			})
			Fk.sliderEspDist = ESPtab:Slider({
				["Title"] = "ESP Distance",
				["Desc"] = "How far ESP can see in studs",
				["Step"] = 250,
				["Value"] = { ["Min"] = 500, ["Max"] = 8000, ["Default"] = h.espMaxStuds or 8000 },
				["Callback"] = function(e, ...)
					h.espMaxStuds = e
					pcall(x)
				end,
			})
			Fk.togFullbright = ESPtab:Toggle({
				["Title"] = "Fullbright",
				["Desc"] = "Makes it bright like daytime everywhere",
				["Icon"] = "solar:star-bold",
				["Value"] = (h.fullbright == true),
				["Callback"] = function(e, ...)
					CX.setFullbright(e)
					pcall(x)
				end,
			})
			Fk.secDefense = Yk:Section({ ["Title"] = "Defense" })
			Fk.togTrapCrusher = Yk:Toggle({
				["Title"] = "Trap Crusher",
				["Desc"] = "Breaks enemy trap hitboxes so they cant grab you",
				["Icon"] = "solar:shield-check-bold",
				["Value"] = (h.antiTrap ~= false),
				["Callback"] = function(e, ...)
					h.antiTrap = e
					pcall(x)
					j({
						["Title"] = "Trap Crusher",
						["Content"] = e and "Enemy traps now get destroyed" or "Enemy traps left alone",
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.secBuy = Xtratab:Section({ ["Title"] = "Shop (Buy)" })
			Fk.togTreadmill = Xtratab:Toggle({
				["Title"] = "Auto Upgrade Treadmill",
				["Desc"] = "Raises your treadmill tier whenever the game allows it",
				["Icon"] = "solar:star-bold",
				["Value"] = (h.autoTreadmill == true),
				["Callback"] = function(e, ...)
					h.autoTreadmill = e
					pcall(x)
					CX.logAdd("Auto treadmill upgrade " .. (e and "on" or "off"))
				end,
			})
			Fk.togAutoBuyTrails = Xtratab:Toggle({
				["Title"] = P.Farm.BuyTrailsTitle or "Auto Buy & Equip Trails",
				["Desc"] = P.Farm.BuyTrailsDesc or "Buys and equips the best trail you can afford",
				["Icon"] = "solar:fire-bold",
				["Value"] = h.autoBuyTrails,
				["Callback"] = function(e, ...)
					h.autoBuyTrails = e
					x()
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = (Xk == "TH") and "\224\184\139\224\184\183\224\185\137\224\184\173 Trail"
							or "Buy Trails",
						["Content"] = e and (r.Notifications.BuyTrailsStarted or "Auto Buy Trails enabled")
							or (r.Notifications.BuyTrailsStopped or "Auto Buy Trails disabled"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.secSell = Xtratab:Section({ ["Title"] = "Selling" })
			Fk.togSellJunk = Xtratab:Toggle({
				["Title"] = "Auto Sell Junk",
				["Desc"] = "Sells pets and eggs below Secret from your bag",
				["Icon"] = "solar:fire-bold",
				["Value"] = (h.autoSellJunk == true),
				["Callback"] = function(e, ...)
					h.autoSellJunk = e
					pcall(x)
				end,
			})
			Fk.dropSellMax = Xtratab:Dropdown({
				["Title"] = "Sell Up To Rarity",
				["Desc"] = "Things this rarity or below may be sold",
				["Values"] = X,
				["Value"] = (X[(tonumber(h.sellMaxRarity) or 6)] or "Legendary"),
				["Callback"] = function(e, ...)
					for i = 1, #X do
						if X[i] == e then
							h.sellMaxRarity = i
							break
						end
					end
					pcall(x)
					CX.logAdd("Sell max rarity set to " .. tostring(e))
				end,
			})
			Fk.inputSellKeep = Xtratab:Input({
				["Title"] = "Favorite Pets",
				["Desc"] = "Names here are never sold, split by commas",
				["Placeholder"] = "Rainbow Dragon, Golden Unicorn",
				["Value"] = (h.sellKeep or ""),
				["Callback"] = function(e)
					if e == h.sellKeep then
						return
					end
					h.sellKeep = e
					pcall(x)
					CX.logAdd("Sell favorites updated")
				end,
			})
			Fk.secStealFilters = Ok:Section({ ["Title"] = "Steal Filters" })
			Fk.inputStealMinInc = Ok:Input({
				["Title"] = "Min Income/s",
				["Desc"] = "Only go after targets earning at least this, 0 means any",
				["Placeholder"] = "0",
				["Value"] = tostring(tonumber(h.stealMinIncome) or 0),
				["Callback"] = function(e, ...)
					h.stealMinIncome = (tonumber(e) or 0)
					pcall(x)
					CX.logAdd("Steal min income set to " .. tostring(h.stealMinIncome))
				end,
			})
			Fk.inputStealMuts = Ok:Input({
				["Title"] = "Wanted Mutations",
				["Desc"] = "Only chase these mutations, split by commas, empty means any",
				["Placeholder"] = "Gold, Diamond, Rainbow",
				["Value"] = (h.stealMuts or ""),
				["Callback"] = function(e, ...)
					h.stealMuts = e
					pcall(x)
					CX.logAdd("Steal mutation filter updated")
				end,
			})
			Fk.secSellFilters = Xtratab:Section({ ["Title"] = "Sell Filters" })
			Fk.inputSellIncomeBelow = Xtratab:Input({
				["Title"] = "Sell Below Income/s",
				["Desc"] = "Only sell things earning less than this, 0 turns it off",
				["Placeholder"] = "0",
				["Value"] = tostring(tonumber(h.sellIncomeBelow) or 0),
				["Callback"] = function(e, ...)
					h.sellIncomeBelow = (tonumber(e) or 0)
					pcall(x)
					CX.logAdd("Sell income floor set to " .. tostring(h.sellIncomeBelow))
				end,
			})
			Fk.inputSellKeepMut = Xtratab:Input({
				["Title"] = "Protect Mutations",
				["Desc"] = "Never sell these mutations, split by commas",
				["Placeholder"] = "Gold, Diamond, Rainbow",
				["Value"] = (h.sellKeepMut or ""),
				["Callback"] = function(e, ...)
					h.sellKeepMut = e
					pcall(x)
					CX.logAdd("Protected mutations updated")
				end,
			})
			Fk.secBoss = Bosstab:Section({ ["Title"] = "Boss Event" })
			Fk.togBossJoin = Bosstab:Toggle({
				["Title"] = "Boss Auto Join",
				["Desc"] = "Joins the boss arena every time it opens",
				["Icon"] = "solar:running-bold",
				["Value"] = (h.bossJoin == true),
				["Callback"] = function(e, ...)
					h.bossJoin = e
					pcall(x)
				end,
			})
			Fk.togBossFight = Bosstab:Toggle({
				["Title"] = "Boss Auto Fight",
				["Desc"] = "Breaks crystals and beats the boss for you",
				["Icon"] = "solar:fire-bold",
				["Value"] = (h.bossFight == true),
				["Callback"] = function(e, ...)
					h.bossFight = e
					if e then
						h.bossJoin = true
					end
					pcall(x)
				end,
			})
			Fk.togBossClaim = Bosstab:Toggle({
				["Title"] = "Boss Claim Rewards",
				["Desc"] = "Claims boss mastery rewards on its own",
				["Icon"] = "solar:star-bold",
				["Value"] = (h.bossClaim == true),
				["Callback"] = function(e, ...)
					h.bossClaim = e
					pcall(x)
				end,
			})
			Fk.togBossHazard = Bosstab:Toggle({
				["Title"] = "Boss Hazard Immunity",
				["Desc"] = "Boss hazards cant hurt you, PC only",
				["Icon"] = "solar:shield-check-bold",
				["Value"] = (h.bossHazard == true),
				["Callback"] = function(e, ...)
					h.bossHazard = e
					pcall(x)
					if e and not CX.installHazard() then
						j({
							["Title"] = "Boss Hazards",
							["Content"] = "Not supported on this executor, boss can still hit you",
							["Icon"] = "x-circle",
						})
					end
				end,
			})
			Fk.btnBossJoinNow = Bosstab:Button({
				["Title"] = "Join Boss Right Now",
				["Desc"] = "Sends you to the boss arena if its open",
				["Callback"] = function(...)
					local e = CX.bossJoinNow()
					j({
						["Title"] = "Boss Arena",
						["Content"] = e and "Sent you to the boss arena" or "Arena is closed, opens every 30 min",
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.secSniper = Ok:Section({ ["Title"] = "Egg Sniper" })
			Fk.togSniper = Ok:Toggle({
				["Title"] = "Egg Sniper",
				["Desc"] = "Pings you the second a Secret or better egg shows up",
				["Icon"] = "lucide:egg",
				["Value"] = (h.sniper == true),
				["Callback"] = function(e, ...)
					h.sniper = e
					pcall(x)
				end,
			})
			Fk.togSnipeGrab = Ok:Toggle({
				["Title"] = "Sniper Auto Grab",
				["Desc"] = "Flies over and grabs it, antidetect risk",
				["Icon"] = "solar:bolt-bold",
				["Value"] = (h.snipeGrab == true),
				["Callback"] = function(e, ...)
					h.snipeGrab = e
					pcall(x)
				end,
			})
			Fk.sliderSnipeRange = Ok:Slider({
				["Title"] = "Sniper Range",
				["Desc"] = "How far the sniper scans in studs",
				["Step"] = 100,
				["Value"] = { ["Min"] = 200, ["Max"] = 5000, ["Default"] = h.snipeMaxStuds or 2000 },
				["Callback"] = function(e, ...)
					h.snipeMaxStuds = e
					pcall(x)
				end,
			})
			Fk.secAntiDet = Yk:Section({ ["Title"] = "Anti Detection" })
			Fk.togHumanize = Yk:Toggle({
				["Title"] = "Humanize Movement",
				["Desc"] = "Randomizes your speed, dips 5 percent near players",
				["Icon"] = "solar:shield-check-bold",
				["Value"] = (h.humanize == true),
				["Callback"] = function(e, ...)
					h.humanize = e
					pcall(x)
				end,
			})
			Fk.secLiveStats = Stattab:Section({ ["Title"] = "Session Stats" })
			Fk.paraStats = Stattab:Paragraph({ ["Title"] = "Live Stats", ["Desc"] = "Loading..." })
			Fk.btnResetStats = Stattab:Button({
				["Title"] = "Reset Session Stats",
				["Desc"] = "Clears every counter and the log",
				["Callback"] = function(...)
					h.statsSteals = 0
					h.statsSnipes = 0
					h.statsSold = 0
					h.statsClaims = 0
					h.statsStart = os.clock()
					h.logLines = {}

				end,
			})
			Fk.secBossTrack = Stattab:Section({ ["Title"] = "Boss Live Tracker" })
			Fk.paraBossTrack = Stattab:Paragraph({ ["Title"] = "Boss Status", ["Desc"] = "checking..." })
			Fk.secLiveLog = Stattab:Section({ ["Title"] = "Steal Log" })
			Fk.paraLog = Stattab:Paragraph({ ["Title"] = "Activity Feed", ["Desc"] = "No activity yet" })
			Fk.secProfiles = Cfgtab:Section({ ["Title"] = "Config Profiles" })
			Fk.dropProfSlot = Cfgtab:Dropdown({
				["Title"] = "Profile Slot",
				["Desc"] = "Pick which save slot to use",
				["Values"] = { "Slot 1", "Slot 2", "Slot 3" },
				["Value"] = (h.profSlot or "Slot 1"),
				["Callback"] = function(e, ...)
					h.profSlot = e
					pcall(x)
				end,
			})
			Fk.btnProfSave = Cfgtab:Button({
				["Title"] = "Save To Slot",
				["Desc"] = "Stores all your current settings here",
				["Callback"] = function(...)
					local e, r = CX.saveProfile(h.profSlot or "Slot 1")
					j({
						["Title"] = "Profiles",
						["Content"] = (
							e and ("Saved into " .. (h.profSlot or "Slot 1")) or ("Save failed: " .. tostring(r))
						),
						["Icon"] = (e and "check-circle" or "x-circle"),
					})
				end,
			})
			Fk.btnProfLoad = Cfgtab:Button({
				["Title"] = "Load From Slot",
				["Desc"] = "Applies the settings stored here",
				["Callback"] = function(...)
					local e, r = CX.loadProfile(h.profSlot or "Slot 1")
					j({
						["Title"] = "Profiles",
						["Content"] = (
							e and ("Loaded " .. (h.profSlot or "Slot 1")) or ("Load failed: " .. tostring(r))
						),
						["Icon"] = (e and "check-circle" or "x-circle"),
					})
				end,
			})
			Fk.secCfgManage = Cfgtab:Section({ ["Title"] = "Config Manager" })
			Fk.togAutoLoadCfg = Cfgtab:Toggle({
				["Title"] = "Auto Load Config",
				["Desc"] = "Loads your saved settings when you execute",
				["Value"] = (h.cfgAutoLoad ~= false),
				["Callback"] = function(e, ...)
					h.cfgAutoLoad = e
					pcall(x)
				end,
			})
			Fk.togAutoSaveCfg = Cfgtab:Toggle({
				["Title"] = "Auto Save Config",
				["Desc"] = "Saves your settings every 30 seconds on its own",
				["Value"] = (h.cfgAutoSave ~= false),
				["Callback"] = function(e, ...)
					h.cfgAutoSave = e
					pcall(x)
				end,
			})
			Fk.btnCfgSave = Cfgtab:Button({
				["Title"] = "Save Config Now",
				["Desc"] = "Writes everything to the config file",
				["Callback"] = function(...)
					pcall(x)
					j({
						["Title"] = "Config",
						["Content"] = "Config saved to file",
						["Icon"] = "check-circle",
					})
				end,
			})
			Fk.btnCfgLoad = Cfgtab:Button({
				["Title"] = "Load Config Now",
				["Desc"] = "Applies what is inside the config file",
				["Callback"] = function(...)
					local e = nil
					if readfile and isfile and isfile(z) then
						local r = nil
						pcall(function(...)
							r = game:GetService("HttpService"):JSONDecode(readfile(z))
						end)
						if type(r) == "table" then
							pcall(CX.applyW, r)
							e = true
						end
					end
					j({
						["Title"] = "Config",
						["Content"] = (e and "Config loaded and applied" or "Nothing to load or file is broken"),
						["Icon"] = (e and "check-circle" or "x-circle"),
					})
				end,
			})
			Fk.btnCfgReset = Cfgtab:Button({
				["Title"] = "Reset Config",
				["Desc"] = "Wipes everything back to default",
				["Callback"] = function(...)
					local e = {
						["autoHatch"] = true,
						["autoGlide"] = true,
						["autoPlaceEvery5"] = false,
						["eggESP"] = false,
						["trapESP"] = false,
						["playerESP"] = false,
						["espMaxStuds"] = 8000,
						["antiTrap"] = true,
						["fullbright"] = false,
						["autoClaimRewards"] = false,
						["autoEquipBest"] = false,
						["autoSellJunk"] = false,
						["bossJoin"] = false,
						["bossFight"] = false,
						["bossClaim"] = false,
						["bossHazard"] = false,
						["humanize"] = false,
						["sniper"] = false,
						["snipeGrab"] = false,
						["snipeMaxStuds"] = 2000,
						["theme"] = "Dark",
						["webhookUrl"] = "",
						["whSnipe"] = false,
						["whSteal"] = false,
						["whBoss"] = false,
						["whHaul"] = false,
						["whUnload"] = false,
						["sellMaxRarity"] = 6,
						["sellKeep"] = "",
						["panicAuto"] = false,
						["panicNames"] = "",
						["whPanic"] = true,
						["webhookPing"] = "",
						["antiStaff"] = false,
						["staffMinRank"] = 250,
						["keybindsOn"] = true,
						["profSlot"] = "Slot 1",
						["kb1Action"] = "None",
						["kb1Key"] = "F",
						["kb2Action"] = "None",
						["kb2Key"] = "G",
					}
					pcall(CX.applyW, e)
					pcall(function(...)
						if delfile and isfile and isfile(z) then
							delfile(z)
						end
					end)
					pcall(x)
					j({
						["Title"] = "Config",
						["Content"] = "Config wiped, back to defaults",
						["Icon"] = "check-circle",
					})
				end,
			})
			Fk.secWebhook = Whtab:Section({ ["Title"] = "Discord Webhook" })
			Fk.inputWebhook = Whtab:Input({
				["Title"] = "Webhook URL",
				["Desc"] = "Paste your discord webhook link here",
				["Placeholder"] = "",
				["Value"] = h.webhookUrl,
				["Callback"] = function(e)
					if e == h.webhookUrl then
						return
					end
					if e == "" then
						h.webhookUrl = ""
						pcall(x)
						CX.logAdd("Webhook url cleared")
						if Fk.paraWebhook and Fk.paraWebhook.SetDesc then
							pcall(function(...)
								Fk.paraWebhook:SetDesc(CX.maskUrl())
							end)
						end
						return
					end
					if e:find("webhooks/") then
						h.webhookUrl = e
						pcall(x)
						CX.logAdd("Webhook url saved")
						if Fk.paraWebhook and Fk.paraWebhook.SetDesc then
							pcall(function(...)
								Fk.paraWebhook:SetDesc(CX.maskUrl())
							end)
						end
						j({
							["Title"] = "Webhook",
							["Content"] = "Webhook url saved",
							["Icon"] = "check-circle",
						})
					else
						j({
							["Title"] = "Webhook",
							["Content"] = "That does not look like a discord webhook link",
							["Icon"] = "x-circle",
						})
					end
				end,
			})
			Fk.inputWebhookPing = Whtab:Input({
				["Title"] = "Discord Ping",
				["Desc"] = "Role or user ping added to every webhook message",
				["Placeholder"] = "<@&1234567890>",
				["Value"] = (h.webhookPing or ""),
				["Callback"] = function(e)
					if e == h.webhookPing then
						return
					end
					h.webhookPing = e
					pcall(x)
					CX.logAdd("Webhook ping saved")
				end,
			})
			Fk.paraWebhook = Whtab:Paragraph({ ["Title"] = "Current Webhook", ["Desc"] = CX.maskUrl() })
			Fk.btnWebhookPaste = Whtab:Button({
				["Title"] = "Paste From Clipboard",
				["Desc"] = "Sets your webhook from the clipboard",
				["Callback"] = function(...)
					local e = CX.setWebhookFromClipboard()
					if e and Fk.paraWebhook and Fk.paraWebhook.SetDesc then
						pcall(function(...)
							Fk.paraWebhook:SetDesc(CX.maskUrl())
						end)
					end
					if not e then
						j({
							["Title"] = "Webhook",
							["Content"] = (
								CX.hasHttp and "Clipboard has no webhook url" or "Your executor cant do webhooks"
							),
							["Icon"] = "x-circle",
						})
					end
				end,
			})
			Fk.btnWebhookTest = Whtab:Button({
				["Title"] = "Send Test Message",
				["Desc"] = "Pings your discord to confirm it works",
				["Callback"] = function(...)
					local e = CX.webhook("Clout Hub | Test", "Webhook connected and working", 3066993)
					j({
						["Title"] = "Webhook",
						["Content"] = (e and "Test sent, check your discord" or "Not sent, set a webhook first"),
						["Icon"] = (e and "check-circle" or "x-circle"),
					})
				end,
			})
			Fk.togWhSnipe = Whtab:Toggle({
				["Title"] = "Webhook On Snipe",
				["Desc"] = "Messages you when a rare egg shows up",
				["Value"] = (h.whSnipe ~= false),
				["Callback"] = function(e, ...)
					h.whSnipe = e
					pcall(x)
				end,
			})
			Fk.togWhSteal = Whtab:Toggle({
				["Title"] = "Webhook On Steal",
				["Desc"] = "Messages you when a steal trip finishes",
				["Value"] = (h.whSteal == true),
				["Callback"] = function(e, ...)
					h.whSteal = e
					pcall(x)
				end,
			})
			Fk.togWhBoss = Whtab:Toggle({
				["Title"] = "Webhook On Boss Claim",
				["Desc"] = "Messages you when boss milestones get claimed",
				["Value"] = (h.whBoss == true),
				["Callback"] = function(e, ...)
					h.whBoss = e
					pcall(x)
				end,
			})
			Fk.togWhHaul = Whtab:Toggle({
				["Title"] = "Webhook Haul Summary",
				["Desc"] = "Reports what got sold every 5 minutes",
				["Value"] = (h.whHaul == true),
				["Callback"] = function(e, ...)
					h.whHaul = e
					pcall(x)
				end,
			})
			Fk.togWhUnload = Whtab:Toggle({
				["Title"] = "Webhook On Unload",
				["Desc"] = "Sends a session report when you unload",
				["Value"] = (h.whUnload == true),
				["Callback"] = function(e, ...)
					h.whUnload = e
					pcall(x)
				end,
			})
			Fk.secWhFilter = Whtab:Section({ ["Title"] = "Steal Filter (Webhook)" })
			Fk.dropWhStealRar = Whtab:Dropdown({
				["Title"] = "Rarities To Ping",
				["Desc"] = "Nothing picked means ping every rare find",
				["Values"] = { "Secret", "Eternal", "Divine" },
				["Value"] = (type(h.whStealRarities) == "table" and h.whStealRarities or {}),
				["Multi"] = true,
				["Callback"] = function(e, ...)
					if type(e) == "table" then
						h.whStealRarities = e
					elseif type(e) == "string" then
						local t0 = {}
						t0[e] = true
						h.whStealRarities = t0
					end
					pcall(x)
				end,
			})
			Fk.inputWhStealMinInc = Whtab:Input({
				["Title"] = "Min Income/s To Ping",
				["Desc"] = "Skip webhook pings below this income, 0 means ping all",
				["Placeholder"] = "0",
				["Value"] = tostring(tonumber(h.whStealMinIncome) or 0),
				["Callback"] = function(e, ...)
					h.whStealMinIncome = (tonumber(e) or 0)
					pcall(x)
					CX.logAdd("Webhook income filter set to " .. tostring(h.whStealMinIncome))
				end,
			})
			Fk.inputWhStealMuts = Whtab:Input({
				["Title"] = "Mutations To Ping",
				["Desc"] = "Only ping for these mutations, split by commas, empty means all",
				["Placeholder"] = "Gold, Diamond, Rainbow",
				["Value"] = (h.whStealMuts or ""),
				["Callback"] = function(e, ...)
					h.whStealMuts = e
					pcall(x)
					CX.logAdd("Webhook mutation filter updated")
				end,
			})
			Fk.secKeybinds = Tk:Section({ ["Title"] = "Keybinds" })
			Fk.togKeybinds = Tk:Toggle({
				["Title"] = "Enable Keybinds",
				["Desc"] = "Lets the hotkeys below do their job",
				["Value"] = (h.keybindsOn ~= false),
				["Callback"] = function(e, ...)
					h.keybindsOn = e
					pcall(x)
				end,
			})
			Fk.dropKb1Action = Tk:Dropdown({
				["Title"] = "Keybind 1 Action",
				["Values"] = CX.kbActions,
				["Value"] = (h.kb1Action or "None"),
				["Callback"] = function(e, ...)
					h.kb1Action = e
					pcall(x)
				end,
			})
			Fk.dropKb1Key = Tk:Dropdown({
				["Title"] = "Keybind 1 Key",
				["Values"] = CX.kbKeys,
				["Value"] = (h.kb1Key or "F"),
				["Callback"] = function(e, ...)
					h.kb1Key = e
					pcall(x)
				end,
			})
			Fk.dropKb2Action = Tk:Dropdown({
				["Title"] = "Keybind 2 Action",
				["Values"] = CX.kbActions,
				["Value"] = (h.kb2Action or "None"),
				["Callback"] = function(e, ...)
					h.kb2Action = e
					pcall(x)
				end,
			})
			Fk.dropKb2Key = Tk:Dropdown({
				["Title"] = "Keybind 2 Key",
				["Values"] = CX.kbKeys,
				["Value"] = (h.kb2Key or "G"),
				["Callback"] = function(e, ...)
					h.kb2Key = e
					pcall(x)
				end,
			})
			Fk.paraExecInfo = Stattab:Paragraph({
				["Title"] = "Executor",
				["Desc"] = (tostring(h.execName) .. (CX.hasHttp and "" or " (no http, webhook off)")),
			})
			task.spawn(function(...)
				while h.alive do
					pcall(function(...)
						if Fk.paraStats and Fk.paraStats.SetDesc then
							local e = math.max(0, math.floor(os.clock() - (h.statsStart or os.clock())))
							local r = math.floor(e / 3600)
							local w = math.floor((e % 3600) / 60)
							local rf = {}
							local sr = (h.statsRarity or {})
							for i = 1, #X do
								local cnt = sr[X[i]]
								if (type(cnt) == "number") and (cnt > 0) then
									rf[#rf + 1] = X[i] .. " x" .. cnt
								end
							end
							local snipeLine = ((#rf > 0) and table.concat(rf, ", ")) or "nothing yet"
							local soldPerHour = 0
							if e > 0 then
								soldPerHour = math.floor(((h.statsSold or 0) * 3600) / e)
							end
							Fk.paraStats:SetDesc(
								string.format(
									"Executor: %s\nUptime: %dh %02dm\nSteal Trips: %d\nSnipes Found: %d\nJunk Sold: %d (%d per hour)\nRewards Claimed: %d\nSnipe Rarities: %s",
									tostring(h.execName),
									r,
									w,
									(h.statsSteals or 0),
									(h.statsSnipes or 0),
									(h.statsSold or 0),
									soldPerHour,
									(h.statsClaims or 0),
									snipeLine
								)
							)
						end
						if Fk.paraBossTrack and Fk.paraBossTrack.SetDesc then
							pcall(function(...)
								Fk.paraBossTrack:SetDesc(CX.bossStatusText())
							end)
						end
						if Fk.paraLog and Fk.paraLog.SetDesc then
							Fk.paraLog:SetDesc(
								((#h.logLines > 0) and table.concat(h.logLines, "\n") or "No activity yet")
							)
						end
					end)
					task.wait(1)
				end
			end)
			Fk.secPerformance =
				Tk:Section({ ["Title"] = (P.Settings and P.Settings.SecPerformance) or "Performance & Graphics" })
			Fk.togPerformance = Tk:Toggle({
				["Title"] = (P.Settings and P.Settings.PerformanceTitle) or "Ultra Potato Mode (Maximum FPS Boost)",
				["Desc"] = (P.Settings and P.Settings.PerformanceDesc)
					or "Disables shadows, textures, particles, and shaders for maximum FPS smoothness",
				["Icon"] = "solar:bolt-bold",
				["Value"] = h.performanceMode,
				["Callback"] = function(e, ...)
					h.performanceMode = e
					x()
					if e then
						Mk()
					else
						Ik()
					end
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = "Performance Mode",
						["Content"] = e and (r.Notifications.PerformanceStarted or "Performance Mode enabled")
							or (r.Notifications.PerformanceStopped or "Performance Mode disabled"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.togDisable3D = Tk:Toggle({
				["Title"] = (P.Settings and P.Settings.Disable3DTitle) or "Disable 3D Rendering (GPU Saver 95%)",
				["Desc"] = (P.Settings and P.Settings.Disable3DDesc)
					or "Stops the 3d view, gpu drops to almost nothing, perfect overnight",
				["Icon"] = "solar:monitor-camera-bold",
				["Value"] = h.disable3D,
				["Callback"] = function(e, ...)
					h.disable3D = e
					x()
					pcall(function(...)
						y:Set3dRenderingEnabled(not e)
					end)
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = "3D Rendering",
						["Content"] = e
								and (r.Notifications.Disable3DStarted or "3D Rendering disabled (GPU Saver)")
							or (r.Notifications.Disable3DStopped or "3D Rendering restored"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.secSystem = Tk:Section({ ["Title"] = P.Settings.SecSystem })
			Fk.togAntiAFK = Tk:Toggle({
				["Title"] = (P.Settings and P.Settings.AntiAFKTitle) or "Anti-AFK (Double-Esc 10m / Mobile)",
				["Desc"] = (P.Settings and P.Settings.AntiAFKDesc) or "Keeps you from getting kicked while afk",
				["Icon"] = "solar:shield-check-bold",
				["Value"] = h.antiAFK,
				["Callback"] = function(e, ...)
					h.antiAFK = e
					x()
					if e then
						bk()
					else
						Ak()
					end
					local r = Gk[Xk] or Gk.EN
					j({
						["Title"] = "Anti-AFK",
						["Content"] = e and (r.Notifications.AntiAFKStarted or "Safe Anti-AFK enabled")
							or (r.Notifications.AntiAFKStopped or "Safe Anti-AFK disabled"),
						["Icon"] = e and "check-circle" or "x-circle",
					})
				end,
			})
			Fk.btnReset = Tk:Button({
				["Title"] = P.Settings.ResetTitle,
				["Desc"] = P.Settings.ResetDesc,
				["Icon"] = "solar:restart-bold",
				["Callback"] = function(...)
					pcall(D4)
					pcall(u4)
					j({
						["Title"] = "Reset State",
						["Content"] = "Character state reset successfully",
						["Icon"] = "check-circle",
					})
				end,
			})
			Fk.btnRejoin = Tk:Button({
				["Title"] = P.Settings.RejoinTitle,
				["Desc"] = P.Settings.RejoinDesc,
				["Icon"] = "solar:logout-2-bold",
				["Callback"] = function(...)
					pcall(function(...)
						TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, o)
					end)
				end,
			})
			Fk.btnUnload = Tk:Button({
				["Title"] = P.Settings.UnloadTitle,
				["Desc"] = P.Settings.UnloadDesc,
				["Icon"] = "solar:trash-bin-trash-bold",
				["Callback"] = function(...)
					aM()
				end,
			})
			yM()
			task.spawn(function(...)
				while h.alive do
					pcall(function(...)
						local r = y4()
						local y = (Xk == "TH")
						local u = Wk(Xk)
						if B then
							local e = Color3.fromRGB(0, 255, 160)
							if h.securingEgg or h.teleporting then
								e = Color3.fromRGB(249, 115, 22)
							elseif h.isReturning or h.glidingToTarget then
								e = Color3.fromRGB(59, 130, 246)
							elseif h.delivering then
								e = Color3.fromRGB(16, 185, 129)
							end
							pcall(function(...)
								if B.SetTitle then
									B:SetTitle(
										(
											y and "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176: "
											or "Status: "
										) .. u
									)
								end
								if B.SetColor then
									B:SetColor(e)
								end
							end)
						end
						if Fk.paraLiveDash and Fk.paraLiveDash.SetDesc then
							local e = y
									and "\224\184\171\224\184\162\224\184\184\224\184\148\224\184\158\224\184\177\224\184\129"
								or "Idle"
							if Y4 == "TWEEN" then
								e = y
										and "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136 (\224\184\154\224\184\180\224\184\153\224\185\128\224\184\163\224\185\135\224\184\167)"
									or "Auto Steal (Tween)"
							elseif Y4 == "WARP" then
								e = y
										and "\224\184\130\224\185\130\224\184\161\224\184\162\224\185\132\224\184\130\224\185\136 (\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155)"
									or "Auto Steal (Teleport)"
							end
							local j = y
									and "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176: %s\n\224\185\130\224\184\171\224\184\161\224\184\148\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161: %s\n\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\185\132\224\184\130\224\185\136\224\185\131\224\184\153\224\184\149\224\184\177\224\184\167: %d \224\184\159\224\184\173\224\184\135\n\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\184\154\224\184\180\224\184\153: %d Studs/s"
								or "Status: %s\nFarm Mode: %s\nCarried Eggs: %d\nFlight Speed: %d Studs/s"
							local k = string.format(j, u, e, r, h.glideSpeed or 600)
							pcall(function(...)
								Fk.paraLiveDash:SetDesc(k)
							end)
						end
					end)
					task.wait(0.25)
				end
			end)
			e(R)
			return
		end
		if h.gui then
			pcall(function(...)
				h.gui:Destroy()
			end)
			h.gui = nil
		end
		local k = Instance.new("ScreenGui")
		k.Name = "CloutHub_UI"
		k.ResetOnSpawn = false
		k.DisplayOrder = 99999
		k.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		k.AutoLocalize = false
		local a = o:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
		pcall(function(...)
			if syn and syn.protect_gui then
				syn.protect_gui(k)
				k.Parent = game:GetService("CoreGui")
			else
				k.Parent = a
			end
		end)
		if not k.Parent then
			k.Parent = a
		end
		h.gui = k
		local V = Color3.fromRGB(15, 17, 24)
		local H = Color3.fromRGB(20, 24, 34)
		local t = Color3.fromRGB(22, 26, 38)
		local s = Color3.fromRGB(28, 33, 48)
		local p = Color3.fromRGB(45, 52, 75)
		local B = Color3.fromRGB(240, 243, 255)
		local J = Color3.fromRGB(140, 148, 170)
		local K = Color3.fromRGB(38, 43, 60)
		local c = Color3.fromRGB(150, 158, 180)
		local v = Color3.fromRGB(255, 255, 255)
		local i = 475
		local R = 46
		local g = false
		local Q = Instance.new("Frame")
		Q.Name = "MainFrame"
		Q.Size = UDim2.new(0, 330, 0, i)
		Q.Position = UDim2.new(0.04, 0, 0.22, 0)
		Q.BackgroundColor3 = V
		Q.BorderSizePixel = 0
		Q.Active = true
		Q.Draggable = true
		Q.ClipsDescendants = true
		Q.Parent = k
		local P = Instance.new("UICorner")
		P.CornerRadius = UDim.new(0, 12)
		P.Parent = Q
		local N = Instance.new("UIStroke")
		N.Color = p
		N.Thickness = 1.4
		N.Parent = Q
		local U = Instance.new("Frame")
		U.Name = "Header"
		U.Size = UDim2.new(1, 0, 0, 46)
		U.BackgroundColor3 = H
		U.BorderSizePixel = 0
		U.Parent = Q;
		Instance.new("UICorner", U).CornerRadius = UDim.new(0, 12)
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(1, -90, 0, 22)
		l.Position = UDim2.new(0, 12, 0, 6)
		l.BackgroundTransparency = 1
		l.Text = "CloutHub | SAE | KEYLESS"
		l.TextColor3 = B
		l.TextSize = 14
		l.Font = Enum.Font.GothamBold
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.AutoLocalize = false
		l.Parent = U
		local D = Instance.new("TextLabel")
		D.Size = UDim2.new(1, -90, 0, 14)
		D.Position = UDim2.new(0, 12, 0, 26)
		D.BackgroundTransparency = 1
		D.Text = "discord.gg/cyDpbvxeGN - KEYLESS"
		D.TextColor3 = Color3.fromRGB(0, 255, 160)
		D.TextSize = 11
		D.Font = Enum.Font.Gotham
		D.TextXAlignment = Enum.TextXAlignment.Left
		D.AutoLocalize = false
		D.Parent = U
		local C = Instance.new("TextButton")
		C.Size = UDim2.new(0, 28, 0, 28)
		C.Position = UDim2.new(1, -68, 0, 9)
		C.BackgroundColor3 = t
		C.Text = "-"
		C.TextColor3 = B
		C.TextSize = 16
		C.Font = Enum.Font.GothamBold
		C.AutoButtonColor = false
		C.Parent = U;
		Instance.new("UICorner", C).CornerRadius = UDim.new(0, 6)
		local q = Instance.new("TextButton")
		q.Size = UDim2.new(0, 28, 0, 28)
		q.Position = UDim2.new(1, -36, 0, 9)
		q.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
		q.Text = "X"
		q.TextColor3 = B
		q.TextSize = 12
		q.Font = Enum.Font.GothamBold
		q.AutoButtonColor = false
		q.Parent = U;
		Instance.new("UICorner", q).CornerRadius = UDim.new(0, 6)
		local n = Instance.new("ScrollingFrame")
		n.Size = UDim2.new(1, 0, 1, -46)
		n.Position = UDim2.new(0, 0, 0, 46)
		n.BackgroundTransparency = 1
		n.BorderSizePixel = 0
		n.ScrollBarThickness = 3
		n.ScrollBarImageColor3 = p
		n.CanvasSize = UDim2.new(0, 0, 0, 0)
		n.AutomaticCanvasSize = Enum.AutomaticSize.Y
		n.Parent = Q
		local I = Instance.new("UIListLayout")
		I.SortOrder = Enum.SortOrder.LayoutOrder
		I.Padding = UDim.new(0, 7)
		I.Parent = n
		local L = Instance.new("UIPadding")
		L.PaddingTop = UDim.new(0, 8)
		L.PaddingBottom = UDim.new(0, 12)
		L.PaddingLeft = UDim.new(0, 10)
		L.PaddingRight = UDim.new(0, 10)
		L.Parent = n
		C.MouseButton1Click:Connect(function(...)
			g = not g
			C.Text = g and "+" or "-"
			(u:Create(
				Q,
				TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ ["Size"] = g and UDim2.new(0, 330, 0, R) or UDim2.new(0, 330, 0, i) }
			)):Play()
		end)
		q.MouseButton1Click:Connect(function(...)
			aM()
		end)
		local function E(e, r, ...)
			local y = Instance.new("Frame")
			y.Size = UDim2.new(1, 0, 0, 20)
			y.BackgroundTransparency = 1
			y.LayoutOrder = r
			y.Parent = n
			local u = Instance.new("TextLabel")
			u.Size = UDim2.new(1, 0, 1, 0)
			u.BackgroundTransparency = 1
			u.Text = e
			u.TextColor3 = Color3.fromRGB(0, 185, 255)
			u.TextSize = 11
			u.Font = Enum.Font.GothamBold
			u.TextXAlignment = Enum.TextXAlignment.Left
			u.AutoLocalize = false
			u.Parent = y
			return y
		end
		local function b(e, r, y, w, j, k, ...)
			local a = Instance.new("Frame")
			a.Size = UDim2.new(1, 0, 0, 52)
			a.BackgroundColor3 = t
			a.LayoutOrder = j
			a.Parent = n;
			Instance.new("UICorner", a).CornerRadius = UDim.new(0, 8)
			local o = Instance.new("TextLabel")
			o.Size = UDim2.new(1, -60, 0, 18)
			o.Position = UDim2.new(0, 10, 0, 8)
			o.BackgroundTransparency = 1
			o.Text = e
			o.TextColor3 = w or B
			o.TextSize = 13
			o.Font = Enum.Font.GothamBold
			o.TextXAlignment = Enum.TextXAlignment.Left
			o.AutoLocalize = false
			o.Parent = a
			local V = Instance.new("TextLabel")
			V.Size = UDim2.new(1, -60, 0, 16)
			V.Position = UDim2.new(0, 10, 0, 26)
			V.BackgroundTransparency = 1
			V.Text = r
			V.TextColor3 = J
			V.TextSize = 10
			V.Font = Enum.Font.Gotham
			V.TextXAlignment = Enum.TextXAlignment.Left
			V.AutoLocalize = false
			V.Parent = a
			local H = Instance.new("TextButton")
			H.Size = UDim2.new(0, 44, 0, 24)
			H.Position = UDim2.new(1, -54, 0.5, -12)
			H.BackgroundColor3 = y and w or K
			H.Text = ""
			H.AutoButtonColor = false
			H.Parent = a;
			Instance.new("UICorner", H).CornerRadius = UDim.new(1, 0)
			local s = Instance.new("Frame")
			s.Size = UDim2.new(0, 18, 0, 18)
			s.Position = y and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
			s.BackgroundColor3 = y and v or c
			s.Parent = H;
			Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
			local p = y
			local function i(e, ...)
				p = e
				local r = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
				(u:Create(H, r, { ["BackgroundColor3"] = p and w or K })):Play();
				(u:Create(
					s,
					r,
					{
						["Position"] = p and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
						["BackgroundColor3"] = p and v or c,
					}
				)):Play()
			end
			H.MouseButton1Click:Connect(function(...)
				local e = not p
				i(e)
				k(e)
			end)
			return i
		end
		local function A(e, r, y, u, w, ...)
			local j = Instance.new("Frame")
			j.Size = UDim2.new(1, 0, 0, 48)
			j.BackgroundColor3 = t
			j.LayoutOrder = u
			j.Parent = n;
			Instance.new("UICorner", j).CornerRadius = UDim.new(0, 8)
			local k = Instance.new("TextLabel")
			k.Size = UDim2.new(1, -95, 0, 18)
			k.Position = UDim2.new(0, 10, 0, 6)
			k.BackgroundTransparency = 1
			k.Text = e
			k.TextColor3 = y or B
			k.TextSize = 13
			k.Font = Enum.Font.GothamBold
			k.TextXAlignment = Enum.TextXAlignment.Left
			k.AutoLocalize = false
			k.Parent = j
			local a = Instance.new("TextLabel")
			a.Size = UDim2.new(1, -95, 0, 16)
			a.Position = UDim2.new(0, 10, 0, 24)
			a.BackgroundTransparency = 1
			a.Text = r
			a.TextColor3 = J
			a.TextSize = 10
			a.Font = Enum.Font.Gotham
			a.TextXAlignment = Enum.TextXAlignment.Left
			a.AutoLocalize = false
			a.Parent = j
			local o = Instance.new("TextButton")
			o.Size = UDim2.new(0, 78, 0, 30)
			o.Position = UDim2.new(1, -86, 0.5, -15)
			o.BackgroundColor3 = y
			o.Text = "RUN"
			o.TextColor3 = Color3.fromRGB(255, 255, 255)
			o.TextSize = 11
			o.Font = Enum.Font.GothamBold
			o.AutoButtonColor = false
			o.Parent = j;
			Instance.new("UICorner", o).CornerRadius = UDim.new(0, 6)
			o.MouseButton1Click:Connect(w)
		end
		E("AUTO STEAL MODES", 10)
		local S = false
		local Z = nil
		local z = nil
		Z = b(
			"Auto Steal (Tween)",
			"Flies out and steals eggs non stop",
			h.pureTweenFarm,
			Color3.fromRGB(0, 195, 255),
			11,
			function(e, ...)
				if S then
					return
				end
				if e then
					T4("TWEEN")
				else
					if Y4 == "TWEEN" or h.pureTweenFarm then
						T4("NONE")
					end
				end
			end
		)
		z = b(
			"Auto Steal (Teleport)",
			"Warps to eggs and steals on repeat",
			h.autoFarmLoop,
			Color3.fromRGB(168, 85, 247),
			12,
			function(e, ...)
				if S then
					return
				end
				if e then
					T4("WARP")
				else
					if Y4 == "WARP" or h.autoFarmLoop then
						T4("NONE")
					end
				end
			end
		)
		x4 = function(e, ...)
			pcall(function(...)
				if Z then
					S = true
					Z(e)
					S = false
				end
			end)
		end
		W4 = function(e, ...)
			pcall(function(...)
				if z then
					S = true
					z(e)
					S = false
				end
			end)
		end
		A(
			"Single Steal (Teleport)",
			"Warps in, grabs 1 egg and comes back",
			Color3.fromRGB(59, 130, 246),
			13,
			function(...)
				task.spawn(function(...)
					if Y4 ~= "NONE" then
						T4("NONE")
						task.wait(0.03)
					end
					local e = N4()
					if e then
						local y = l4(e, nil)
						if y then
							pcall(u4)
							if h.autoGlide then
								Q4(h.glideSpeed)
								u4()
							end
						end
					end
				end)
			end
		)
		E("PLACE EGG", 20)
		A("Place Egg", "Flies home, plants eggs and hatches", Color3.fromRGB(16, 215, 130), 21, function(...)
			task.spawn(function(...)
				h.statusText = "[Manual] Depositing eggs..."
				g4(h.glideSpeed)
				v4()
				u4()
				h.isReturning = false
				h.delivering = false
			end)
		end)
		b(
			"Auto Place (Every 5)",
			"Heads home every 5 steals to plant",
			h.autoPlaceEvery5,
			Color3.fromRGB(14, 165, 233),
			22,
			function(e, ...)
				h.autoPlaceEvery5 = e
				if not e then
					h.batchStealCount = 0
				end
			end
		)
		b("Auto Hatch", "Hatches ready eggs on its own", h.autoHatch, Color3.fromRGB(16, 185, 129), 22, function(e, ...)
			h.autoHatch = e
		end)
		b(
			"Auto Return",
			"Flies back safe after each steal",
			h.autoGlide,
			Color3.fromRGB(245, 158, 11),
			23,
			function(e, ...)
				h.autoGlide = e
			end
		)
		b(
			"Auto Treadmill",
			"Hops on the treadmill while nothing to steal",
			h.autoTreadmill,
			Color3.fromRGB(168, 85, 247),
			24,
			function(e, ...)
				h.autoTreadmill = e
				x()
				n4()
				if not e and (h.onTreadmill or L4()) then
					M4()
				end
			end
		)
		E("CHARACTER & SAFETY", 30)
		local g4set = b(
			"Godmode",
			"Nothing can touch or hurt you",
			(h.godmode == true),
			Color3.fromRGB(244, 63, 94),
			31,
			function(e, ...)
				if e then
					enableDesyncGodmode()
				else
					disableDesyncGodmode()
				end
			end
		)
		godToggleSetter = function(e, ...)
			pcall(function(...)
				if g4set then
					S = true
					g4set(e)
					S = false
				end
			end)
		end
		A("Get Out Treadmill", "Gets you unstuck right away", Color3.fromRGB(249, 115, 22), 32, function(...)
			pcall(M4)
			pcall(C4)
			pcall(D4)
		end)
		E("CONTROLS & SETTINGS", 40)
		local F = Instance.new("Frame")
		F.Size = UDim2.new(1, 0, 0, 48)
		F.BackgroundColor3 = t
		F.LayoutOrder = 41
		F.Parent = n;
		Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
		local O = Instance.new("TextLabel")
		O.Size = UDim2.new(1, -130, 0, 18)
		O.Position = UDim2.new(0, 10, 0, 6)
		O.BackgroundTransparency = 1
		O.Text = "Flight Speed"
		O.TextColor3 = B
		O.TextSize = 13
		O.Font = Enum.Font.GothamBold
		O.TextXAlignment = Enum.TextXAlignment.Left
		O.AutoLocalize = false
		O.Parent = F
		local T = Instance.new("TextLabel")
		T.Size = UDim2.new(0, 70, 0, 24)
		T.Position = UDim2.new(1, -80, 0.5, -12)
		T.BackgroundColor3 = V
		T.Text = string.format("%d Studs/s", h.glideSpeed or 600)
		T.TextColor3 = Color3.fromRGB(0, 255, 160)
		T.TextSize = 11
		T.Font = Enum.Font.GothamBold
		T.AutoLocalize = false
		T.Parent = F;
		Instance.new("UICorner", T).CornerRadius = UDim.new(0, 6)
		local W = Instance.new("TextButton")
		W.Size = UDim2.new(0, 24, 0, 24)
		W.Position = UDim2.new(1, -110, 0.5, -12)
		W.BackgroundColor3 = s
		W.Text = "-"
		W.TextColor3 = B
		W.TextSize = 14
		W.Font = Enum.Font.GothamBold
		W.Parent = F;
		Instance.new("UICorner", W).CornerRadius = UDim.new(0, 6)
		local m = Instance.new("TextButton")
		m.Size = UDim2.new(0, 24, 0, 24)
		m.Position = UDim2.new(1, -138, 0.5, -12)
		m.BackgroundColor3 = s
		m.Text = "+"
		m.TextColor3 = B
		m.TextSize = 14
		m.Font = Enum.Font.GothamBold
		m.Parent = F;
		Instance.new("UICorner", m).CornerRadius = UDim.new(0, 6)
		W.MouseButton1Click:Connect(function(...)
			h.glideSpeed = math.max(100, (h.glideSpeed or 600) - 25)
			T.Text = string.format("%d Studs/s", h.glideSpeed)
			Y(h.glideSpeed)
		end)
		m.MouseButton1Click:Connect(function(...)
			h.glideSpeed = math.min(1000, (h.glideSpeed or 600) + 25)
			T.Text = string.format("%d Studs/s", h.glideSpeed)
			Y(h.glideSpeed)
		end)
		A("Reset Character State", "Clears state and frees movement", Color3.fromRGB(99, 102, 241), 42, function(...)
			pcall(D4)
			pcall(u4)
		end)
		b(
			"Egg ESP",
			"Shows all eggs through walls with rarity colors",
			(h.eggESP == true),
			Color3.fromRGB(250, 204, 21),
			44,
			function(e, ...)
				espSet(e)
			end
		)
		b(
			"Trap ESP",
			"Spots enemy traps through walls",
			(h.trapESP == true),
			Color3.fromRGB(239, 68, 68),
			45,
			function(e, ...)
				if CX then
					CX.setTrapESP(e)
				end
			end
		)
		b(
			"Player ESP",
			"Spots other players through walls",
			(h.playerESP == true),
			Color3.fromRGB(34, 197, 94),
			46,
			function(e, ...)
				if CX then
					CX.setPlayerESP(e)
				end
			end
		)
		A("Copy Discord Link", "* PLEASE JOIN! Tap to copy discord.gg/cyDpbvxeGN - If bug, report there! *", Color3.fromRGB(88, 101, 242), 47, function(...)
			CopyDiscord()
			j({
				["Title"] = "CloutHub | SAE | KEYLESS",
				["Content"] = "* INVITE COPIED! Please join discord.gg/cyDpbvxeGN - Bug? Report on Discord! *",
				["Icon"] = "check-circle",
			})
		end)
		A("Unload Script", "Stops everything and closes the menu", Color3.fromRGB(153, 27, 27), 48, function(...)
			aM()
		end)
		E("PROTECTION & EXTRAS", 50)
		b(
			"Trap Crusher",
			"Breaks enemy trap hitboxes so they cant grab you",
			h.antiTrap,
			Color3.fromRGB(239, 68, 68),
			51,
			function(e, ...)
				h.antiTrap = e
			end
		)
		b(
			"Fullbright",
			"Makes it bright like daytime everywhere",
			h.fullbright == true,
			Color3.fromRGB(245, 158, 11),
			52,
			function(e, ...)
				if CX then
					CX.setFullbright(e)
				end
			end
		)
		b(
			"Auto Claim",
			"Picks up earnings and rewards for you",
			h.autoClaimRewards == true,
			Color3.fromRGB(251, 191, 36),
			53,
			function(e, ...)
				h.autoClaimRewards = e
			end
		)
		b(
			"Equip Best Pets",
			"Equips your strongest pets on its own",
			h.autoEquipBest == true,
			Color3.fromRGB(168, 85, 247),
			54,
			function(e, ...)
				h.autoEquipBest = e
			end
		)
		b(
			"Auto Sell Junk",
			"Sells pets and eggs below Secret from your bag",
			h.autoSellJunk == true,
			Color3.fromRGB(234, 88, 12),
			55,
			function(e, ...)
				h.autoSellJunk = e
			end
		)
		E("BOSS EVENT", 56)
		b(
			"Boss Auto Join",
			"Joins the boss arena every time it opens",
			h.bossJoin == true,
			Color3.fromRGB(59, 130, 246),
			57,
			function(e, ...)
				h.bossJoin = e
			end
		)
		b(
			"Boss Auto Fight",
			"Breaks crystals and beats the boss for you",
			h.bossFight == true,
			Color3.fromRGB(244, 63, 94),
			58,
			function(e, ...)
				h.bossFight = e
				if e then
					h.bossJoin = true
				end
			end
		)
		b(
			"Boss Claim Rewards",
			"Claims boss mastery rewards on its own",
			h.bossClaim == true,
			Color3.fromRGB(16, 185, 129),
			59,
			function(e, ...)
				h.bossClaim = e
			end
		)
		b(
			"Boss Hazard Immunity",
			"Boss hazards cant hurt you, PC only",
			h.bossHazard == true,
			Color3.fromRGB(139, 92, 246),
			60,
			function(e, ...)
				h.bossHazard = e
				if e and CX then
					CX.installHazard()
				end
			end
		)
		E("EGG SELECT (ZONES & RARITIES)", 70)
		local e4 = Instance.new("TextButton")
		e4.Size = UDim2.new(1, 0, 0, 48)
		e4.BackgroundColor3 = t
		e4.LayoutOrder = 71
		e4.Text = ""
		e4.AutoButtonColor = false
		e4.Parent = n;
		Instance.new("UICorner", e4).CornerRadius = UDim.new(0, 8)
		local function r4(...)
			local e = 0
			for y, u in ipairs(M) do
				if h.selectedZones and h.selectedZones[u] then
					e = e + 1
				end
			end
			return e
		end
		local w4 = Instance.new("TextLabel")
		w4.Size = UDim2.new(1, -50, 0, 18)
		w4.Position = UDim2.new(0, 10, 0, 6)
		w4.BackgroundTransparency = 1
		w4.Text = string.format("Target Zones (%d/12 Active)", r4())
		w4.TextColor3 = Color3.fromRGB(0, 220, 255)
		w4.TextSize = 13
		w4.Font = Enum.Font.GothamBold
		w4.TextXAlignment = Enum.TextXAlignment.Left
		w4.AutoLocalize = false
		w4.Parent = e4
		local j4 = Instance.new("TextLabel")
		j4.Size = UDim2.new(1, -50, 0, 16)
		j4.Position = UDim2.new(0, 10, 0, 26)
		j4.BackgroundTransparency = 1
		j4.Text = "Click to expand / collapse zone selection"
		j4.TextColor3 = J
		j4.TextSize = 10
		j4.Font = Enum.Font.Gotham
		j4.TextXAlignment = Enum.TextXAlignment.Left
		j4.AutoLocalize = false
		j4.Parent = e4
		local k4 = Instance.new("TextLabel")
		k4.Size = UDim2.new(0, 30, 0, 30)
		k4.Position = UDim2.new(1, -38, 0.5, -15)
		k4.BackgroundTransparency = 1
		k4.Text = "+"
		k4.TextColor3 = J
		k4.TextSize = 12
		k4.Font = Enum.Font.GothamBold
		k4.Parent = e4
		local a4 = Instance.new("Frame")
		a4.Size = UDim2.new(1, 0, 0, 0)
		a4.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
		a4.LayoutOrder = 72
		a4.Visible = false
		a4.ClipsDescendants = true
		a4.Parent = n;
		Instance.new("UICorner", a4).CornerRadius = UDim.new(0, 8)
		local o4 = Instance.new("UIGridLayout")
		o4.CellSize = UDim2.new(0.48, 0, 0, 32)
		o4.CellPadding = UDim2.new(0.04, 0, 0, 6)
		o4.SortOrder = Enum.SortOrder.LayoutOrder
		o4.Parent = a4;
		Instance.new("UIPadding", a4).PaddingTop = UDim.new(0, 8)
		a4.UIPadding.PaddingBottom = UDim.new(0, 8)
		a4.UIPadding.PaddingLeft = UDim.new(0, 8)
		a4.UIPadding.PaddingRight = UDim.new(0, 8)
		local V4 = {}
		for e, r in ipairs(M) do
			local y = Instance.new("TextButton")
			y.LayoutOrder = e
			y.Font = Enum.Font.GothamBold
			y.TextSize = 11
			y.AutoButtonColor = false
			y.AutoLocalize = false
			Instance.new("UICorner", y).CornerRadius = UDim.new(0, 6)
			local function u(...)
				local e = h.selectedZones and h.selectedZones[r] == true
				if e then
					y.BackgroundColor3 = d[r] or Color3.fromRGB(59, 130, 246)
					y.TextColor3 = Color3.new(1, 1, 1)
					y.Text = r .. " [ON]"
				else
					y.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
					y.TextColor3 = Color3.fromRGB(140, 150, 170)
					y.Text = r
				end
			end
			u()
			y.MouseButton1Click:Connect(function(...)
				if not h.selectedZones then
					h.selectedZones = {}
				end
				h.selectedZones[r] = not (h.selectedZones[r] == true)
				u()
				x()
				w4.Text = string.format("Target Zones (%d/12 Active)", r4())
			end)
			y.Parent = a4
			V4[r] = y
		end
		local H4 = false
		e4.MouseButton1Click:Connect(function(...)
			H4 = not H4
			a4.Visible = H4
			a4.Size = H4 and UDim2.new(1, 0, 0, 240) or UDim2.new(1, 0, 0, 0)
			k4.Text = H4 and "-" or "+"
		end)
		local function t4(...)
			local e = 0
			for y, u in ipairs(X) do
				if h.selectedRarities and h.selectedRarities[u] then
					e = e + 1
				end
			end
			return e
		end
		local s4 = Instance.new("TextButton")
		s4.Size = UDim2.new(1, 0, 0, 48)
		s4.BackgroundColor3 = t
		s4.LayoutOrder = 73
		s4.Text = ""
		s4.AutoButtonColor = false
		s4.Parent = n;
		Instance.new("UICorner", s4).CornerRadius = UDim.new(0, 8)
		local p4 = Instance.new("TextLabel")
		p4.Size = UDim2.new(1, -50, 0, 18)
		p4.Position = UDim2.new(0, 10, 0, 6)
		p4.BackgroundTransparency = 1
		p4.Text = string.format("Target Rarities (%d/%d Active)", t4(), #X)
		p4.TextColor3 = Color3.fromRGB(255, 180, 0)
		p4.TextSize = 13
		p4.Font = Enum.Font.GothamBold
		p4.TextXAlignment = Enum.TextXAlignment.Left
		p4.AutoLocalize = false
		p4.Parent = s4
		local B4 = Instance.new("TextLabel")
		B4.Size = UDim2.new(1, -50, 0, 16)
		B4.Position = UDim2.new(0, 10, 0, 26)
		B4.BackgroundTransparency = 1
		B4.Text = "Click to expand / collapse rarity selection"
		B4.TextColor3 = J
		B4.TextSize = 10
		B4.Font = Enum.Font.Gotham
		B4.TextXAlignment = Enum.TextXAlignment.Left
		B4.AutoLocalize = false
		B4.Parent = s4
		local J4 = Instance.new("TextLabel")
		J4.Size = UDim2.new(0, 30, 0, 30)
		J4.Position = UDim2.new(1, -38, 0.5, -15)
		J4.BackgroundTransparency = 1
		J4.Text = "+"
		J4.TextColor3 = J
		J4.TextSize = 12
		J4.Font = Enum.Font.GothamBold
		J4.Parent = s4
		local K4 = Instance.new("Frame")
		K4.Size = UDim2.new(1, 0, 0, 0)
		K4.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
		K4.LayoutOrder = 74
		K4.Visible = false
		K4.ClipsDescendants = true
		K4.Parent = n;
		Instance.new("UICorner", K4).CornerRadius = UDim.new(0, 8)
		local c4 = Instance.new("UIGridLayout")
		c4.CellSize = UDim2.new(0.48, 0, 0, 32)
		c4.CellPadding = UDim2.new(0.04, 0, 0, 6)
		c4.SortOrder = Enum.SortOrder.LayoutOrder
		c4.Parent = K4;
		Instance.new("UIPadding", K4).PaddingTop = UDim.new(0, 8)
		K4.UIPadding.PaddingBottom = UDim.new(0, 8)
		K4.UIPadding.PaddingLeft = UDim.new(0, 8)
		K4.UIPadding.PaddingRight = UDim.new(0, 8)
		for e, r in ipairs(X) do
			local y = Instance.new("TextButton")
			y.LayoutOrder = e
			y.Font = Enum.Font.GothamBold
			y.TextSize = 11
			y.AutoButtonColor = false
			y.AutoLocalize = false
			Instance.new("UICorner", y).CornerRadius = UDim.new(0, 6)
			local function u(...)
				local e = h.selectedRarities and h.selectedRarities[r] == true
				if e then
					y.BackgroundColor3 = G[r] or Color3.fromRGB(249, 115, 22)
					y.TextColor3 = Color3.new(1, 1, 1)
					y.Text = r .. " [ON]"
				else
					y.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
					y.TextColor3 = Color3.fromRGB(140, 150, 170)
					y.Text = r
				end
			end
			u()
			y.MouseButton1Click:Connect(function(...)
				if not h.selectedRarities then
					h.selectedRarities = {}
				end
				h.selectedRarities[r] = not (h.selectedRarities[r] == true)
				u()
				x()
				p4.Text = string.format("Target Rarities (%d/%d Active)", t4(), #X)
			end)
			y.Parent = K4
		end
		local i4 = false
		s4.MouseButton1Click:Connect(function(...)
			i4 = not i4
			K4.Visible = i4
			K4.Size = i4 and UDim2.new(1, 0, 0, 160) or UDim2.new(1, 0, 0, 0)
			J4.Text = i4 and "-" or "+"
		end)
		e(function(...)
			Q.Visible = true
		end)
	end
	H("[+] CloutHub | SAE | KEYLESS loading... discord.gg/cyDpbvxeGN (auto copied)")
	oM()
	task.spawn(function(...)
		task.wait(0.25)
		A4()
		b4(true)
		C4()
		if o.Character then
			z4(o.Character)
		end
		u4()
		H("[+] Auto Humanoid Swap & Rigid Joint Locking Active.")
	end)
	o.CharacterAdded:Connect(function(e, ...)
		task.wait(0.6)
		if h.alive then
			D4()
			n4()
			C4()
			A4()
			b4(true)
			z4(e)
			u4()
		end
	end)
	if h.performanceMode then
		task.spawn(Mk)
	end
	if h.disable3D then
		pcall(function(...)
			y:Set3dRenderingEnabled(false)
		end)
	end
	if h.antiAFK then
		task.spawn(bk)
	end
	H("[+] CloutHub | SAE | KEYLESS ready | discord.gg/cyDpbvxeGN")
end
if type(game) ~= "nil" then
	CloutHubMain()
end