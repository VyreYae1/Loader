-- ============================================================
--  SIMPLE ROBLOX UI LIBRARY
--  Put this LocalScript inside StarterPlayer > StarterPlayerScripts
--  Press RightShift to show/hide the menu
-- ============================================================

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- Clean up any previous instance
if PlayerGui:FindFirstChild("SimpleUI") then
	PlayerGui.SimpleUI:Destroy()
end

-- ---------------------------- THEME ----------------------------
local COLORS = {
	Bg      = Color3.fromRGB(18, 18, 22),
	Sidebar = Color3.fromRGB(26, 26, 32),
	Element = Color3.fromRGB(38, 38, 46),
	Hover   = Color3.fromRGB(52, 52, 62),
	Accent  = Color3.fromRGB(120, 100, 255),
	Text    = Color3.fromRGB(235, 235, 240),
	Dim     = Color3.fromRGB(150, 150, 160),
}

-- ---------------------------- HELPERS ----------------------------
local function make(class, props)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do
		o[k] = v
	end
	return o
end

local function addCorner(parent, r)
	return make("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = parent })
end

local function tween(obj, time, props)
	return TweenService:Create(
		obj,
		TweenInfo.new(time or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	):Play()
end

-- ---------------------------- ROOT ----------------------------
local gui = make("ScreenGui", {
	Name = "SimpleUI",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = PlayerGui,
})

local main = make("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(500, 330),
	Position = UDim2.new(0.5, -250, 0.5, -165),
	BackgroundColor3 = COLORS.Bg,
	BorderSizePixel = 0,
	Parent = gui,
})
addCorner(main, 12)
make("UIStroke", { Color = Color3.fromRGB(55, 55, 68), Thickness = 1, Parent = main })

-- ---------------------------- TITLE BAR ----------------------------
local titleBar = make("Frame", {
	Size = UDim2.new(1, 0, 0, 36),
	BackgroundColor3 = COLORS.Sidebar,
	BorderSizePixel = 0,
	Parent = main,
})
addCorner(titleBar, 12)
-- square off the bottom corners of the title bar
make("Frame", {
	Size = UDim2.new(1, 0, 0, 12),
	Position = UDim2.new(0, 0, 1, -12),
	BackgroundColor3 = COLORS.Sidebar,
	BorderSizePixel = 0,
	Parent = titleBar,
})

make("TextLabel", {
	Size = UDim2.new(1, -80, 1, 0),
	Position = UDim2.new(0, 14, 0, 0),
	BackgroundTransparency = 1,
	Text = "My Game Menu",
	TextColor3 = COLORS.Text,
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = titleBar,
})

local closeBtn = make("TextButton", {
	Size = UDim2.fromOffset(22, 22),
	Position = UDim2.new(1, -30, 0.5, -11),
	BackgroundColor3 = COLORS.Element,
	Text = "✕",
	TextColor3 = COLORS.Dim,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	AutoButtonColor = false,
	Parent = titleBar,
})
addCorner(closeBtn, 6)
closeBtn.MouseEnter:Connect(function() tween(closeBtn, 0.12, { BackgroundColor3 = Color3.fromRGB(200, 60, 60), TextColor3 = Color3.new(1,1,1) }) end)
closeBtn.MouseLeave:Connect(function() tween(closeBtn, 0.12, { BackgroundColor3 = COLORS.Element, TextColor3 = COLORS.Dim }) end)
closeBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- ---------------------------- DRAGGING ----------------------------
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
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- ---------------------------- LAYOUT ----------------------------
local sidebar = make("Frame", {
	Size = UDim2.new(0, 130, 1, -36),
	Position = UDim2.new(0, 0, 0, 36),
	BackgroundColor3 = COLORS.Sidebar,
	BorderSizePixel = 0,
	Parent = main,
})

local content = make("Frame", {
	Size = UDim2.new(1, -140, 1, -46),
	Position = UDim2.new(0, 138, 0, 40),
	BackgroundTransparency = 1,
	Parent = main,
})

-- ---------------------------- LIBRARY ----------------------------
local Library = {}
Library.Tabs    = {}
Library.Current = nil

function Library:AddTab(name)
	local index = #self.Tabs

	local btn = make("TextButton", {
		Size = UDim2.new(1, -16, 0, 34),
		Position = UDim2.new(0, 8, 0, 8 + index * 38),
		BackgroundColor3 = COLORS.Element,
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = COLORS.Dim,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false,
		Parent = sidebar,
	})
	make("UIPadding", { PaddingLeft = UDim.new(0, 12), Parent = btn })
	addCorner(btn, 8)

	local page = make("ScrollingFrame", {
		Name = name .. "Page",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = COLORS.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		Parent = content,
	})
	make("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page,
	})
	make("UIPadding", {
		PaddingTop = UDim.new(0, 2),
		PaddingLeft = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 8),
		Parent = page,
	})

	local entry = { btn = btn, page = page }
	table.insert(self.Tabs, entry)

	btn.MouseButton1Click:Connect(function()
		for _, other in ipairs(self.Tabs) do
			other.btn.BackgroundTransparency = 1
			other.btn.TextColor3 = COLORS.Dim
			other.page.Visible = false
		end
		btn.BackgroundTransparency = 0
		btn.BackgroundColor3 = COLORS.Element
		btn.TextColor3 = COLORS.Text
		page.Visible = true
		self.Current = entry
	end)

	-- auto-select first tab
	if index == 0 then
		btn.BackgroundTransparency = 0
		btn.BackgroundColor3 = COLORS.Element
		btn.TextColor3 = COLORS.Text
		page.Visible = true
		self.Current = entry
	end

	return entry
end

-- ---------- LABEL ----------
function Library:AddLabel(tab, text)
	local lbl = make("TextLabel", {
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = COLORS.Dim,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = tab.page,
	})
	return lbl
end

-- ---------- BUTTON ----------
function Library:AddButton(tab, text, callback)
	local btn = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = COLORS.Element,
		Text = text,
		TextColor3 = COLORS.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		AutoButtonColor = false,
		Parent = tab.page,
	})
	addCorner(btn, 8)

	btn.MouseEnter:Connect(function() tween(btn, 0.12, { BackgroundColor3 = COLORS.Hover }) end)
	btn.MouseLeave:Connect(function() tween(btn, 0.12, { BackgroundColor3 = COLORS.Element }) end)
	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)

	return btn
end

-- ---------- TOGGLE ----------
function Library:AddToggle(tab, text, default, callback)
	local state = default and true or false

	local holder = make("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = COLORS.Element,
		Active = true,
		Parent = tab.page,
	})
	addCorner(holder, 8)

	make("TextLabel", {
		Size = UDim2.new(1, -70, 1, 0),
		Position = UDim2.new(0, 12, 0, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = COLORS.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = holder,
	})

	local switch = make("Frame", {
		Size = UDim2.fromOffset(38, 20),
		Position = UDim2.new(1, -50, 0.5, -10),
		BackgroundColor3 = state and COLORS.Accent or COLORS.Hover,
		Parent = holder,
	})
	addCorner(switch, 10)

	local knob = make("Frame", {
		Size = UDim2.fromOffset(16, 16),
		Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Parent = switch,
	})
	addCorner(knob, 8)

	local function set(v)
		state = v
		tween(switch, 0.15, { BackgroundColor3 = state and COLORS.Accent or COLORS.Hover })
		tween(knob, 0.15, {
			Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		})
		if callback then callback(state) end
	end

	holder.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			set(not state)
		end
	end)

	return { Set = set, Get = function() return state end }
end

-- ---------- SLIDER ----------
function Library:AddSlider(tab, text, min, max, default, callback)
	local holder = make("Frame", {
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundColor3 = COLORS.Element,
		Parent = tab.page,
	})
	addCorner(holder, 8)

	make("TextLabel", {
		Size = UDim2.new(1, -90, 0, 22),
		Position = UDim2.new(0, 12, 0, 6),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = COLORS.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = holder,
	})

	local valueLabel = make("TextLabel", {
		Size = UDim2.new(0, 80, 0, 22),
		Position = UDim2.new(1, -92, 0, 6),
		BackgroundTransparency = 1,
		Text = tostring(default),
		TextColor3 = COLORS.Accent,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = holder,
	})

	local area = make("Frame", {
		Size = UDim2.new(1, -24, 0, 18),
		Position = UDim2.new(0, 12, 0, 28),
		BackgroundTransparency = 1,
		Active = true,
		Parent = holder,
	})

	local track = make("Frame", {
		Size = UDim2.new(1, 0, 0, 6),
		Position = UDim2.new(0, 0, 0.5, -3),
		BackgroundColor3 = COLORS.Hover,
		Parent = area,
	})
	addCorner(track, 3)

	local fill = make("Frame", {
		Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
		BackgroundColor3 = COLORS.Accent,
		Parent = track,
	})
	addCorner(fill, 3)

	local dragging = false
	local value    = default

	local function set(v)
		value = math.clamp(v, min, max)
		local alpha = (value - min) / (max - min)
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		valueLabel.Text = tostring(math.floor(value * 100 + 0.5) / 100)
		if callback then callback(value) end
	end

	local function updateFromX(mouseX)
		local rel = (mouseX - track.AbsolutePosition.X) / track.AbsoluteSize.X
		set(min + (max - min) * math.clamp(rel, 0, 1))
	end

	area.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			updateFromX(input.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
			updateFromX(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	set(default)
	return { Set = set, Get = function() return value end }
end

-- ---------------------------- TOGGLE MENU ----------------------------
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end
end)

-- ============================================================
--  EXAMPLE USAGE  (delete / replace this section)
-- ============================================================
local mainTab    = Library:AddTab("Main")
local settingsTab = Library:AddTab("Settings")

Library:AddLabel(mainTab, "Welcome! This is a demo menu.")

Library:AddButton(mainTab, "Say Hello", function()
	print("Hello from the UI!")
end)

Library:AddButton(mainTab, "Reset Character", function()
	if LocalPlayer.Character then
		LocalPlayer.Character:BreakJoints()
	end
end)

Library:AddToggle(mainTab, "Demo Toggle", false, function(state)
	print("Toggle is now:", state)
end)

Library:AddSlider(mainTab, "Demo Slider", 0, 100, 50, function(value)
	print("Slider value:", value)
end)

Library:AddLabel(settingsTab, "Settings go here.")

Library:AddToggle(settingsTab, "Show FPS", false, function(state)
	-- hook your own logic here
end)

Library:AddSlider(settingsTab, "Volume", 0, 10, 5, function(value)
	-- hook your own logic here
end)