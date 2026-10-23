-- ============================================================
--  LiquidGlassUI.lua
--  iOS-style "Liquid Glass" premium UI for Roblox
--  Press RightShift to toggle the menu
-- ============================================================

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local Lighting         = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("LiquidGlassUI") then
	PlayerGui.LiquidGlassUI:Destroy()
end
local oldBlur = Lighting:FindFirstChild("LiquidGlassBlur")
if oldBlur then oldBlur:Destroy() end

-- Frosted blur behind the menu
local blur = Instance.new("BlurEffect")
blur.Name = "LiquidGlassBlur"
blur.Size = 0
blur.Parent = Lighting

-- ============================================================
--  FONTS (SF Pro–like with fallback)
-- ============================================================
local function pickFont(name, fallback)
	local ok, v = pcall(function() return Enum.Font[name] end)
	return ok and v or fallback
end
local FONT      = pickFont("BuilderSans",        Enum.Font.Gotham)
local FONT_MED  = pickFont("BuilderSansMedium",  Enum.Font.GothamMedium)
local FONT_BOLD = pickFont("BuilderSansBold",    Enum.Font.GothamBold)

-- ============================================================
--  COLORS (iOS system palette)
-- ============================================================
local C = {
	Glass1   = Color3.fromRGB(46, 46, 58),
	Glass2   = Color3.fromRGB(20, 20, 28),
	Text     = Color3.fromRGB(255, 255, 255),
	Subtext  = Color3.fromRGB(168, 168, 184),
	Blue     = Color3.fromRGB(10, 132, 255),
	Green    = Color3.fromRGB(48, 209, 88),
	Red      = Color3.fromRGB(255, 69, 58),
	TrackOff = Color3.fromRGB(120, 120, 128),
	White    = Color3.new(1, 1, 1),
	Black    = Color3.new(0, 0, 0),
}

-- ============================================================
--  HELPERS
-- ============================================================
local function new(class, props)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do o[k] = v end
	return o
end

local function corner(parent, r)
	return new("UICorner", { CornerRadius = UDim.new(0, r or 12), Parent = parent })
end

local function stroke(parent, thickness, transparency, color)
	return new("UIStroke", {
		Thickness = thickness or 1,
		Transparency = transparency or 0.85,
		Color = color or C.White,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function gradient(parent, top, bottom, topT, botT, rot)
	return new("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, top),
			ColorSequenceKeypoint.new(1, bottom),
		}),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, topT or 0.15),
			NumberSequenceKeypoint.new(1, botT or 0.4),
		}),
		Rotation = rot or 90,
		Parent = parent,
	})
end

local function tween(obj, dur, props)
	TweenService:Create(
		obj,
		TweenInfo.new(dur or 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		props
	):Play()
end

-- ============================================================
--  ROOT
-- ============================================================
local gui = new("ScreenGui", {
	Name = "LiquidGlassUI",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = PlayerGui,
})

-- Soft shadow under the window
local shadow = new("Frame", {
	Size = UDim2.fromOffset(580, 460),
	Position = UDim2.new(0.5, -290, 0.5, -218),
	BackgroundColor3 = C.Black,
	BackgroundTransparency = 0.72,
	BorderSizePixel = 0,
	Parent = gui,
})
corner(shadow, 40)

-- ============================================================
--  MAIN GLASS WINDOW
-- ============================================================
local main = new("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(580, 460),
	Position = UDim2.new(0.5, -290, 0.5, -230),
	BackgroundColor3 = C.Glass1,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Parent = gui,
})
corner(main, 34)
gradient(main, C.Glass1, C.Glass2, 0.18, 0.42)
stroke(main, 1.5, 0.72)

local uiScale = new("UIScale", { Scale = 0.94, Parent = main })
tween(uiScale, 0.45, { Scale = 1 })

-- Top sheen highlight (fake light refraction)
local sheen = new("Frame", {
	Size = UDim2.new(1, -8, 0, 90),
	Position = UDim2.new(0, 4, 0, 4),
	BackgroundColor3 = C.White,
	BackgroundTransparency = 0.96,
	BorderSizePixel = 0,
	Parent = main,
})
corner(sheen, 32)
new("UIGradient", {
	Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.92),
		NumberSequenceKeypoint.new(1, 1),
	}),
	Rotation = 90,
	Parent = sheen,
})

-- ============================================================
--  TITLE BAR
-- ============================================================
local titleBar = new("Frame", {
	Size = UDim2.new(1, 0, 0, 56),
	BackgroundTransparency = 1,
	Active = true,
	Parent = main,
})

new("TextLabel", {
	Size = UDim2.new(1, -120, 0, 22),
	Position = UDim2.new(0, 22, 0, 10),
	BackgroundTransparency = 1,
	Text = "Settings",
	TextColor3 = C.Text,
	Font = FONT_BOLD,
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = titleBar,
})
new("TextLabel", {
	Size = UDim2.new(1, -120, 0, 16),
	Position = UDim2.new(0, 22, 0, 32),
	BackgroundTransparency = 1,
	Text = "Liquid Glass",
	TextColor3 = C.Subtext,
	Font = FONT,
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = titleBar,
})

-- Close button (iOS circular glass)
local closeBtn = new("TextButton", {
	Size = UDim2.fromOffset(32, 32),
	Position = UDim2.new(1, -46, 0, 12),
	BackgroundColor3 = C.White,
	BackgroundTransparency = 0.86,
	Text = "",
	AutoButtonColor = false,
	Parent = titleBar,
})
corner(closeBtn, 16)
stroke(closeBtn, 1, 0.85)
new("TextLabel", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Text = "✕",
	TextColor3 = C.Text,
	Font = FONT_MED,
	TextSize = 14,
	Parent = closeBtn,
})

local function setVisible(v)
	gui.Enabled = v
	tween(blur, 0.35, { Size = v and 16 or 0 })
	if v then
		uiScale.Scale = 0.94
		tween(uiScale, 0.45, { Scale = 1 })
	end
end

closeBtn.MouseButton1Click:Connect(function() setVisible(false) end)
closeBtn.MouseEnter:Connect(function()
	tween(closeBtn, 0.15, { BackgroundColor3 = C.Red, BackgroundTransparency = 0.15 })
end)
closeBtn.MouseLeave:Connect(function()
	tween(closeBtn, 0.15, { BackgroundColor3 = C.White, BackgroundTransparency = 0.86 })
end)

-- ============================================================
--  DRAGGING
-- ============================================================
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging  = true
		dragStart = input.Position
		startPos  = main.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if not dragging then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		local d = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + d.X,
			startPos.Y.Scale, startPos.Y.Offset + d.Y
		)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- ============================================================
--  SEGMENTED CONTROL + PAGES
-- ============================================================
local TAB_NAMES = { "General", "Appearance", "About" }

local segmentHolder = new("Frame", {
	Size = UDim2.new(1, -32, 0, 38),
	Position = UDim2.new(0, 16, 0, 66),
	BackgroundColor3 = C.Black,
	BackgroundTransparency = 0.68,
	BorderSizePixel = 0,
	Parent = main,
})
corner(segmentHolder, 12)
stroke(segmentHolder, 1, 0.9)

local indicator = new("Frame", {
	Size = UDim2.new(1/#TAB_NAMES, 0, 1, -8),
	Position = UDim2.new(0, 0, 0, 4),
	BackgroundColor3 = C.White,
	BackgroundTransparency = 0.86,
	BorderSizePixel = 0,
	ZIndex = 2,
	Parent = segmentHolder,
})
corner(indicator, 9)
stroke(indicator, 1, 0.85)

local tabs = {}
for i, name in ipairs(TAB_NAMES) do
	local btn = new("TextButton", {
		Size = UDim2.new(1/#TAB_NAMES, 0, 1, 0),
		Position = UDim2.new((i-1)/#TAB_NAMES, 0, 0, 0),
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = (i == 1) and C.Text or C.Subtext,
		Font = FONT_MED,
		TextSize = 13,
		AutoButtonColor = false,
		ZIndex = 3,
		Parent = segmentHolder,
	})
	tabs[i] = btn
end

-- Content area
local content = new("Frame", {
	Size = UDim2.new(1, -32, 1, -120),
	Position = UDim2.new(0, 16, 0, 112),
	BackgroundTransparency = 1,
	Parent = main,
})

local pages = {}
for i = 1, #TAB_NAMES do
	local page = new("ScrollingFrame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = (i == 1),
		Parent = content,
	})
	new("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page,
	})
	new("UIPadding", {
		PaddingTop = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 8),
		Parent = page,
	})
	pages[i] = page
end

local function selectTab(i)
	tween(indicator, 0.32, { Position = UDim2.new((i-1)/#TAB_NAMES, 0, 0, 4) })
	for j, t in ipairs(tabs) do
		tween(t, 0.2, { TextColor3 = (j == i) and C.Text or C.Subtext })
	end
	for j, p in ipairs(pages) do
		p.Visible = (j == i)
	end
end

for i, btn in ipairs(tabs) do
	btn.MouseButton1Click:Connect(function() selectTab(i) end)
end

-- ============================================================
--  UI COMPONENTS
-- ============================================================

-- LABEL
local function AddLabel(page, text)
	local lbl = new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = C.Subtext,
		Font = FONT_MED,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = page,
	})
	new("UIPadding", { PaddingLeft = UDim.new(0, 6), Parent = lbl })
	return lbl
end

-- BUTTON
local function AddButton(page, text, callback, primary)
	local btn = new("TextButton", {
		Size = UDim2.new(1, 0, 0, 48),
		BackgroundColor3 = primary and C.Blue or C.White,
		BackgroundTransparency = primary and 0 or 0.92,
		Text = text,
		TextColor3 = C.Text,
		Font = FONT_MED,
		TextSize = 15,
		AutoButtonColor = false,
		Parent = page,
	})
	corner(btn, 14)
	stroke(btn, 1, primary and 0.85 or 0.88)

	local sc = new("UIScale", { Scale = 1, Parent = btn })

	btn.MouseEnter:Connect(function()
		if primary then
			tween(btn, 0.15, { BackgroundColor3 = Color3.fromRGB(30, 145, 255) })
		else
			tween(btn, 0.15, { BackgroundTransparency = 0.86 })
		end
	end)
	btn.MouseLeave:Connect(function()
		if primary then
			tween(btn, 0.15, { BackgroundColor3 = C.Blue })
		else
			tween(btn, 0.15, { BackgroundTransparency = 0.92 })
		end
	end)
	btn.MouseButton1Down:Connect(function() tween(sc, 0.1, { Scale = 0.97 }) end)
	btn.MouseButton1Up:Connect(function()   tween(sc, 0.18, { Scale = 1 }) end)
	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
	return btn
end

-- TOGGLE (iOS switch)
local function AddToggle(page, text, default, callback)
	local state = default and true or false

	local row = new("TextButton", {
		Size = UDim2.new(1, 0, 0, 56),
		BackgroundColor3 = C.White,
		BackgroundTransparency = 0.93,
		Text = "",
		AutoButtonColor = false,
		Parent = page,
	})
	corner(row, 16)
	stroke(row, 1, 0.88)

	new("TextLabel", {
		Size = UDim2.new(1, -90, 1, 0),
		Position = UDim2.new(0, 18, 0, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = C.Text,
		Font = FONT_MED,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = row,
	})

	local track = new("Frame", {
		Size = UDim2.fromOffset(51, 31),
		Position = UDim2.new(1, -69, 0.5, -15.5),
		BackgroundColor3 = state and C.Green or C.TrackOff,
		BorderSizePixel = 0,
		Parent = row,
	})
	corner(track, 16)

	local knob = new("Frame", {
		Size = UDim2.fromOffset(27, 27),
		Position = state and UDim2.new(1, -29, 0.5, -13.5) or UDim2.new(0, 2, 0.5, -13.5),
		BackgroundColor3 = C.White,
		BorderSizePixel = 0,
		Parent = track,
	})
	corner(knob, 14)
	stroke(knob, 1, 0.9, C.Black)

	local function set(v)
		state = v
		tween(track, 0.25, { BackgroundColor3 = state and C.Green or C.TrackOff })
		tween(knob, 0.25, {
			Position = state and UDim2.new(1, -29, 0.5, -13.5) or UDim2.new(0, 2, 0.5, -13.5)
		})
		if callback then callback(state) end
	end

	row.MouseButton1Click:Connect(function() set(not state) end)
	return { Set = set, Get = function() return state end }
end

-- SLIDER (iOS style)
local function AddSlider(page, text, min, max, default, callback)
	local row = new("Frame", {
		Size = UDim2.new(1, 0, 0, 76),
		BackgroundColor3 = C.White,
		BackgroundTransparency = 0.93,
		BorderSizePixel = 0,
		Parent = page,
	})
	corner(row, 16)
	stroke(row, 1, 0.88)

	new("TextLabel", {
		Size = UDim2.new(1, -90, 0, 20),
		Position = UDim2.new(0, 18, 0, 12),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = C.Text,
		Font = FONT_MED,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = row,
	})

	local valueLabel = new("TextLabel", {
		Size = UDim2.new(0, 70, 0, 20),
		Position = UDim2.new(1, -88, 0, 12),
		BackgroundTransparency = 1,
		Text = tostring(default),
		TextColor3 = C.Subtext,
		Font = FONT_MED,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = row,
	})

	local trackArea = new("Frame", {
		Size = UDim2.new(1, -36, 0, 28),
		Position = UDim2.new(0, 18, 0, 40),
		BackgroundTransparency = 1,
		Active = true,
		Parent = row,
	})

	local trackBg = new("Frame", {
		Size = UDim2.new(1, 0, 0, 6),
		Position = UDim2.new(0, 0, 0.5, -3),
		BackgroundColor3 = C.White,
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		Parent = trackArea,
	})
	corner(trackBg, 3)

	local fill = new("Frame", {
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = C.Blue,
		BorderSizePixel = 0,
		Parent = trackBg,
	})
	corner(fill, 3)

	local thumb = new("Frame", {
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.new(0, -14, 0.5, -14),
		BackgroundColor3 = C.White,
		BorderSizePixel = 0,
		Parent = trackArea,
	})
	corner(thumb, 14)
	stroke(thumb, 1, 0.88, C.Black)

	local value = default
	local draggingSlider = false

	local function set(v)
		value = math.clamp(v, min, max)
		local a = (value - min) / (max - min)
		fill.Size = UDim2.new(a, 0, 1, 0)
		thumb.Position = UDim2.new(a, -14, 0.5, -14)
		valueLabel.Text = tostring(math.floor(value * 100 + 0.5) / 100)
		if callback then callback(value) end
	end

	local function updateFromX(x)
		local rel = (x - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X
		set(min + (max - min) * math.clamp(rel, 0, 1))
	end

	trackArea.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = true
			updateFromX(input.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			updateFromX(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = false
		end
	end)

	set(default)
	return { Set = set, Get = function() return value end }
end

-- ============================================================
--  KEYBOARD TOGGLE
-- ============================================================
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		setVisible(not gui.Enabled)
	end
end)

-- ============================================================
--  DEMO CONTENT
-- ============================================================
AddLabel(pages[1], "GENERAL")
AddToggle(pages[1], "Enable Feature", false, function(v) print("Feature:", v) end)
AddToggle(pages[1], "Notifications", true, function(v) print("Notifications:", v) end)
AddSlider(pages[1], "Volume", 0, 100, 65, function(v) print("Volume:", v) end)
AddSlider(pages[1], "Sensitivity", 0.1, 5, 1, function(v) print("Sensitivity:", v) end)
AddButton(pages[1], "Apply Settings", function() print("Applied!") end, true)

AddLabel(pages[2], "APPEARANCE")
AddToggle(pages[2], "Dark Mode", true, function(v) print("Dark mode:", v) end)
AddSlider(pages[2], "Opacity", 0, 100, 80, function(v) print("Opacity:", v) end)
AddSlider(pages[2], "Corner Radius", 0, 40, 16, function(v) print("Radius:", v) end)
AddButton(pages[2], "Reset to Defaults", function() print("Reset") end)

AddLabel(pages[3], "ABOUT")
AddLabel(pages[3], "LiquidGlassUI  v1.0.0")
AddLabel(pages[3], "Designed with iOS-inspired glassmorphism.")
AddButton(pages[3], "Visit GitHub", function() print("https://github.com") end, true)
AddButton(pages[3], "Close Menu", function() setVisible(false) end)