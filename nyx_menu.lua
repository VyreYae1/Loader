--[[
    NYX MENU  |  Roblox client script (Luau)
    Run it with your executor.  Show/hide: RightShift or the round "N" button.

    Combat  : aimbot (FOV, smoothness, prediction, head/body, team + wall check, sticky lock)
    Visuals : ESP (chams, names, health, distance), colors, range, fullbright, camera FOV
    Player  : walkspeed, jumppower, fly, noclip, infinite jump
    Misc    : anti-AFK, respawn, unload

    Self-contained: no external libraries, no Drawing API.
    Running it again replaces the old copy.
]]

local env = (getgenv and getgenv()) or _G
if env.NyxMenuUnload then
    pcall(env.NyxMenuUnload)
end

---------------------------------------------------------------------
-- services
---------------------------------------------------------------------
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local Workspace        = game:GetService("Workspace")
local VirtualUser      = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera

---------------------------------------------------------------------
-- settings (everything the UI edits lives in this table)
---------------------------------------------------------------------
local S = {
    -- aimbot
    Aimbot = false, HoldToAim = true, AimPart = "Head",
    FOV = 150, Smooth = 35, Prediction = 0,
    ShowFOV = true, TeamCheck = true, WallCheck = true, Sticky = true,
    -- esp / world
    ESP = false, Chams = true, Names = true, Health = true, Distance = true,
    HideTeam = true, ESPColor = "Red", ESPDist = 2000,
    Fullbright = false, CamFOVOn = false, CamFOV = 90,
    -- player
    SpeedOn = false, Speed = 50, JumpOn = false, Jump = 90,
    InfJump = false, Noclip = false, Fly = false, FlySpeed = 70,
    -- misc
    AntiAFK = true,
}

local menuOpen = false     -- is the window showing
local currentTarget = nil  -- part the aimbot is locked on

local Theme = {
    Bg     = Color3.fromRGB(17, 17, 23),
    Row    = Color3.fromRGB(30, 30, 41),
    Off    = Color3.fromRGB(58, 58, 76),
    Stroke = Color3.fromRGB(52, 52, 70),
    Accent = Color3.fromRGB(142, 108, 255),
    Lock   = Color3.fromRGB(255, 84, 96),
    Text   = Color3.fromRGB(236, 236, 246),
    Sub    = Color3.fromRGB(148, 148, 172),
}
local TWEEN = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

---------------------------------------------------------------------
-- tiny helpers
---------------------------------------------------------------------
local connections = {}
local function keep(conn)
    connections[#connections + 1] = conn
    return conn
end

local function new(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        inst[k] = v
    end
    inst.Parent = parent
    return inst
end

local function round(inst, px)
    return new("UICorner", { CornerRadius = px and UDim.new(0, px) or UDim.new(1, 0) }, inst)
end

-- parents to gethui()/CoreGui when the executor allows it, else to the fallback
local function mount(inst, hidden, fallback)
    local ok = pcall(function()
        inst.Parent = (hidden and gethui and gethui()) or game:GetService("CoreGui")
    end)
    if not ok or not inst.Parent then
        inst.Parent = fallback
    end
end

---------------------------------------------------------------------
-- containers
---------------------------------------------------------------------
local Gui = new("ScreenGui", {
    Name = "NyxMenu",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
})
mount(Gui, true, LocalPlayer:WaitForChild("PlayerGui"))

local ESPFolder = new("Folder", { Name = "NyxESP" })
mount(ESPFolder, false, Workspace)

local FovCircle = new("Frame", {
    Name = "FovCircle",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.fromOffset(300, 300),
    Visible = false,
}, Gui)
round(FovCircle)
local FovStroke = new("UIStroke", { Thickness = 1.5, Color = Theme.Accent, Transparency = 0.1 }, FovCircle)

---------------------------------------------------------------------
-- player helpers
---------------------------------------------------------------------
local function getHum()
    local c = LocalPlayer.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function sameTeam(plr)
    return plr.Team ~= nil and plr.Team == LocalPlayer.Team
end

-- values we overwrite, so switching a feature off puts them back
local orig = { Speed = 16, Jump = 50, UseJP = true, FOV = Camera.FieldOfView }

---------------------------------------------------------------------
-- aimbot
---------------------------------------------------------------------
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true
rayParams.RespectCanCollide = true

local function aimPartName()
    return S.AimPart == "Head" and "Head" or "HumanoidRootPart"
end

local function isTouchOnly()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

-- screen point the FOV circle is centered on (crosshair in locked-mouse games)
local function getAimCenter()
    if isTouchOnly() or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        return Camera.ViewportSize / 2
    end
    return UserInputService:GetMouseLocation()
end

local function aimActive()
    if not S.Aimbot then return false end
    if not S.HoldToAim or isTouchOnly() then return true end
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end

local function isVisible(part)
    local origin = Camera.CFrame.Position
    local ignore = { Camera }
    if LocalPlayer.Character then
        ignore[#ignore + 1] = LocalPlayer.Character
    end
    rayParams.FilterDescendantsInstances = ignore
    local hit = Workspace:Raycast(origin, part.Position - origin, rayParams)
    return hit == nil or hit.Instance:IsDescendantOf(part.Parent)
end

-- returns true + distance-to-crosshair when the part is a legal target
local function targetValid(part, center, fovMul)
    if not part or not part.Parent then return false end
    local char = part.Parent
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    local plr = Players:GetPlayerFromCharacter(char)
    if not plr or plr == LocalPlayer then return false end
    if S.TeamCheck and sameTeam(plr) then return false end
    local v, onScreen = Camera:WorldToViewportPoint(part.Position)
    if not onScreen then return false end
    local d = (Vector2.new(v.X, v.Y) - center).Magnitude
    if d > S.FOV * fovMul then return false end
    if S.WallCheck and not isVisible(part) then return false end
    return true, d
end

local function pickTarget(center)
    local partName = aimPartName()
    -- sticky: keep the current lock until it leaves a slightly widened FOV
    if S.Sticky and currentTarget and currentTarget.Name == partName
        and targetValid(currentTarget, center, 1.25) then
        return currentTarget
    end
    local best, bestD = nil, nil
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            local part = char and char:FindFirstChild(partName)
            if part then
                local ok, d = targetValid(part, center, 1)
                if ok and (not bestD or d < bestD) then
                    best, bestD = part, d
                end
            end
        end
    end
    return best
end

---------------------------------------------------------------------
-- ESP (Highlight chams + billboard text, works through walls)
---------------------------------------------------------------------
local COLOR_NAMES = { "Red", "Green", "Cyan", "Purple", "White", "Rainbow", "Team" }
local COLORS = {
    Red    = Color3.fromRGB(255, 70, 80),
    Green  = Color3.fromRGB(80, 255, 130),
    Cyan   = Color3.fromRGB(70, 220, 255),
    Purple = Color3.fromRGB(170, 120, 255),
    White  = Color3.fromRGB(255, 255, 255),
}

local function espColor(plr)
    local mode = S.ESPColor
    if mode == "Rainbow" then
        return Color3.fromHSV((os.clock() * 0.2) % 1, 0.85, 1)
    elseif mode == "Team" then
        return plr.Team and plr.TeamColor.Color or COLORS.White
    end
    return COLORS[mode] or COLORS.White
end

local espObjects = {}
local espWasOn = false

local function makeESP(plr)
    if plr == LocalPlayer or espObjects[plr] then return end

    local hl = new("Highlight", {
        Name = "H_" .. plr.Name,
        FillTransparency = 0.6,
        OutlineTransparency = 0,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        Enabled = false,
    }, ESPFolder)

    local bb = new("BillboardGui", {
        Name = "B_" .. plr.Name,
        AlwaysOnTop = true,
        LightInfluence = 0,
        Size = UDim2.fromOffset(150, 44),
        StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0),
        Enabled = false,
    }, ESPFolder)
    new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 1),
    }, bb)

    local name = new("TextLabel", {
        LayoutOrder = 1, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16),
        Font = Enum.Font.GothamBold, TextSize = 13, TextStrokeTransparency = 0.4,
        TextColor3 = Color3.new(1, 1, 1), Text = "",
    }, bb)
    local info = new("TextLabel", {
        LayoutOrder = 2, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 13),
        Font = Enum.Font.GothamMedium, TextSize = 11, TextStrokeTransparency = 0.4,
        TextColor3 = Color3.new(1, 1, 1), Text = "",
    }, bb)
    local barBg = new("Frame", {
        LayoutOrder = 3, Size = UDim2.fromOffset(64, 5),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0,
    }, bb)
    local bar = new("Frame", {
        Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(80, 255, 120), BorderSizePixel = 0,
    }, barBg)

    espObjects[plr] = { hl = hl, bb = bb, name = name, info = info, barBg = barBg, bar = bar }
end

local function removeESP(plr)
    local o = espObjects[plr]
    if o then
        o.hl:Destroy()
        o.bb:Destroy()
        espObjects[plr] = nil
    end
end

local function updateESP()
    if not S.ESP then
        if espWasOn then
            for _, o in pairs(espObjects) do
                o.hl.Enabled = false
                o.bb.Enabled = false
            end
            espWasOn = false
        end
        return
    end
    espWasOn = true

    local camPos = Camera.CFrame.Position
    local list = {}
    for plr, o in pairs(espObjects) do
        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local visible = hum ~= nil and root ~= nil and hum.Health > 0
        if visible and S.HideTeam and sameTeam(plr) then visible = false end
        local dist = 0
        if visible then
            dist = (root.Position - camPos).Magnitude
            if dist > S.ESPDist then visible = false end
        end
        if visible then
            list[#list + 1] = { plr = plr, o = o, char = char, hum = hum, root = root, dist = dist }
        else
            o.hl.Enabled = false
            o.bb.Enabled = false
        end
    end

    -- Roblox only draws 31 Highlights at once, so the nearest 30 get chams
    table.sort(list, function(a, b) return a.dist < b.dist end)

    for i, e in ipairs(list) do
        local o, hum = e.o, e.hum
        local color = espColor(e.plr)

        if o.hl.Adornee ~= e.char then o.hl.Adornee = e.char end
        o.hl.FillColor = color
        o.hl.OutlineColor = color
        o.hl.Enabled = S.Chams and i <= 30

        local anchor = e.char:FindFirstChild("Head") or e.root
        if o.bb.Adornee ~= anchor then o.bb.Adornee = anchor end
        local showText = S.Names or S.Health or S.Distance
        o.bb.Enabled = showText

        if showText then
            o.name.Visible = S.Names
            o.name.Text = e.plr.DisplayName
            o.name.TextColor3 = color

            local parts = {}
            if S.Health then
                parts[#parts + 1] = string.format("%d HP", math.floor(hum.Health + 0.5))
            end
            if S.Distance then
                parts[#parts + 1] = string.format("%d st", math.floor(e.dist + 0.5))
            end
            o.info.Text = table.concat(parts, " | ")
            o.info.Visible = #parts > 0

            o.barBg.Visible = S.Health
            local f = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
            o.bar.Size = UDim2.fromScale(f, 1)
            o.bar.BackgroundColor3 = Color3.fromHSV(f * 0.33, 0.85, 1)
        end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    makeESP(p)
end
keep(Players.PlayerAdded:Connect(makeESP))
keep(Players.PlayerRemoving:Connect(removeESP))

---------------------------------------------------------------------
-- world: fullbright
---------------------------------------------------------------------
local lightBackup = nil

local function setFullbright(on)
    if on then
        if not lightBackup then
            lightBackup = {
                Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
                FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows,
                Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
            }
        end
    elseif lightBackup then
        for k, v in pairs(lightBackup) do
            pcall(function() Lighting[k] = v end)
        end
        lightBackup = nil
    end
end

local function applyFullbright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.Ambient = Color3.fromRGB(190, 190, 190)
    Lighting.OutdoorAmbient = Color3.fromRGB(190, 190, 190)
end

---------------------------------------------------------------------
-- movement: speed / jump / fly / noclip / infinite jump / anti-AFK
---------------------------------------------------------------------
local controls = nil  -- Roblox PlayerModule controls (keyboard + thumbstick)
pcall(function()
    local scripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local pmod = scripts and scripts:FindFirstChild("PlayerModule")
    if pmod then
        controls = require(pmod):GetControls()
    end
end)

local function getMoveVector()
    if controls then
        local ok, v = pcall(function() return controls:GetMoveVector() end)
        if ok and typeof(v) == "Vector3" then return v end
    end
    local x = (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0)
    local z = (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
    return Vector3.new(x, 0, z)
end

local flyActive = false
keep(RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and root) then return end

    if S.SpeedOn and hum.WalkSpeed ~= S.Speed then
        hum.WalkSpeed = S.Speed
    end
    if S.JumpOn then
        if not hum.UseJumpPower then hum.UseJumpPower = true end
        if hum.JumpPower ~= S.Jump then hum.JumpPower = S.Jump end
    end

    if S.Fly then
        local cam = Workspace.CurrentCamera
        if not cam then return end
        flyActive = true
        hum.PlatformStand = true

        local cf = cam.CFrame
        local mv = getMoveVector()
        local dir = cf.RightVector * mv.X + cf.LookVector * (-mv.Z)
        local typing = UserInputService:GetFocusedTextBox() ~= nil
        local up = UserInputService.TouchEnabled and hum.Jump
        if not typing then
            up = up or UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.E)
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                dir = dir - Vector3.new(0, 1, 0)
            end
        end
        if up then
            dir = dir + Vector3.new(0, 1, 0)
        end

        if dir.Magnitude > 0.01 then
            root.AssemblyLinearVelocity = dir.Unit * S.FlySpeed
        else
            root.AssemblyLinearVelocity = Vector3.zero
        end
        root.AssemblyAngularVelocity = Vector3.zero

        local flat = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
        if flat.Magnitude > 0.05 then
            root.CFrame = CFrame.lookAt(root.Position, root.Position + flat)
        end
    elseif flyActive then
        flyActive = false
        hum.PlatformStand = false
        root.AssemblyLinearVelocity = Vector3.zero
    end
end))

keep(RunService.Stepped:Connect(function()
    if not S.Noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") and d.CanCollide then
            d.CanCollide = false
        end
    end
end))

keep(UserInputService.JumpRequest:Connect(function()
    if not S.InfJump then return end
    local hum = getHum()
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

keep(LocalPlayer.Idled:Connect(function()
    if not S.AntiAFK then return end
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end))

---------------------------------------------------------------------
-- per-frame: aimbot steering, FOV circle, camera FOV, fullbright, ESP
---------------------------------------------------------------------
local espAccum = 0

local function onRender(dt)
    Camera = Workspace.CurrentCamera
    if not Camera then return end

    if S.CamFOVOn then Camera.FieldOfView = S.CamFOV end
    if S.Fullbright then applyFullbright() end

    local center = getAimCenter()
    local showCircle = S.Aimbot and S.ShowFOV
    FovCircle.Visible = showCircle
    if showCircle then
        FovCircle.Position = UDim2.fromOffset(center.X, center.Y)
        FovCircle.Size = UDim2.fromOffset(S.FOV * 2, S.FOV * 2)
    end

    -- aim is paused while the menu is open so it can't yank the camera mid-click
    local target = nil
    if aimActive() and not menuOpen then
        target = pickTarget(center)
        if target then
            local aimPos = target.Position + target.AssemblyLinearVelocity * S.Prediction
            local cf = Camera.CFrame
            if (aimPos - cf.Position).Magnitude > 0.5 then
                local goal = CFrame.lookAt(cf.Position, aimPos)
                -- frame-rate independent smoothing: 0 = instant snap, 95 = very slow
                local hold = math.clamp(S.Smooth / 100, 0, 0.97)
                Camera.CFrame = cf:Lerp(goal, 1 - hold ^ (dt * 60))
            end
        end
    end
    currentTarget = target
    FovStroke.Color = target and Theme.Lock or Theme.Accent

    espAccum = espAccum + dt
    if espAccum >= 1 / 30 then
        espAccum = 0
        pcall(updateESP)
    end
end

RunService:BindToRenderStep("NyxRender", Enum.RenderPriority.Camera.Value + 1, onRender)

---------------------------------------------------------------------
-- unload (restores everything it touched)
---------------------------------------------------------------------
local function unload()
    pcall(function() RunService:UnbindFromRenderStep("NyxRender") end)
    for _, c in ipairs(connections) do
        pcall(function() c:Disconnect() end)
    end
    pcall(function()
        local hum = getHum()
        if hum then
            hum.PlatformStand = false
            if S.SpeedOn then hum.WalkSpeed = orig.Speed end
            if S.JumpOn then
                hum.JumpPower = orig.Jump
                hum.UseJumpPower = orig.UseJP
            end
        end
        if S.CamFOVOn and Camera then Camera.FieldOfView = orig.FOV end
        setFullbright(false)
    end)
    pcall(function() Gui:Destroy() end)
    pcall(function() ESPFolder:Destroy() end)
    env.NyxMenuUnload = nil
end
env.NyxMenuUnload = unload

---------------------------------------------------------------------
-- UI: window, tabs, components
---------------------------------------------------------------------
local vp = Camera.ViewportSize
if vp.X < 100 or vp.Y < 100 then vp = Vector2.new(1280, 720) end
local W = math.min(330, vp.X - 20)
local H = math.clamp(vp.Y - 70, 240, 410)

local Window = new("Frame", {
    Name = "Window",
    Active = true,
    Visible = false,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromOffset(vp.X / 2, vp.Y / 2),
    Size = UDim2.fromOffset(W, H),
    BackgroundColor3 = Theme.Bg,
    BorderSizePixel = 0,
}, Gui)
round(Window, 12)
new("UIStroke", { Color = Theme.Stroke, Thickness = 1 }, Window)
local WinScale = new("UIScale", { Scale = 1 }, Window)
-- invisible Modal button: frees the mouse in first-person / shift-lock games while the menu is up
new("TextButton", { Name = "ModalUnlock", Modal = true, BackgroundTransparency = 1, Text = "", Size = UDim2.fromOffset(0, 0) }, Window)

local function setMenu(open)
    menuOpen = open
    if open then
        Window.Visible = true
        WinScale.Scale = 0.92
        TweenService:Create(WinScale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
    else
        TweenService:Create(WinScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.92 }):Play()
        task.delay(0.12, function()
            if not menuOpen then Window.Visible = false end
        end)
    end
end

local function makeDraggable(handle, target, onTap)
    local dragging, moved = false, false
    local dragStart, startPos
    handle.InputBegan:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
            dragging, moved = true, false
            dragStart, startPos = input.Position, target.Position
        end
    end)
    keep(UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            if d.Magnitude > 6 then moved = true end
            if moved or not onTap then
                target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end
    end))
    keep(UserInputService.InputEnded:Connect(function(input)
        local t = input.UserInputType
        if dragging and (t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch) then
            dragging = false
            if not moved and onTap then onTap() end
        end
    end))
end

-- title bar
local TitleBar = new("Frame", { Name = "TitleBar", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38) }, Window)
new("TextLabel", {
    BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -60, 1, 0),
    Text = "NYX  //  menu", Font = Enum.Font.GothamBold, TextSize = 15,
    TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
}, TitleBar)
local CloseBtn = new("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(26, 26),
    BackgroundColor3 = Theme.Row, Text = "x", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = Theme.Sub, AutoButtonColor = false,
}, TitleBar)
round(CloseBtn, 7)
CloseBtn.Activated:Connect(function() setMenu(false) end)
makeDraggable(TitleBar, Window)

-- floating toggle button (handy on mobile); drag to move, tap to open/close
local OpenBtn = new("TextButton", {
    Name = "OpenBtn", Size = UDim2.fromOffset(40, 40), Position = UDim2.new(0, 12, 0.5, -20),
    BackgroundColor3 = Theme.Accent, Text = "N", Font = Enum.Font.GothamBold, TextSize = 18,
    TextColor3 = Color3.new(1, 1, 1), AutoButtonColor = false, ZIndex = 5,
}, Gui)
round(OpenBtn)
makeDraggable(OpenBtn, OpenBtn, function() setMenu(not menuOpen) end)

keep(UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift and not UserInputService:GetFocusedTextBox() then
        setMenu(not menuOpen)
    end
end))

-- tabs
local TabBar = new("Frame", { Position = UDim2.fromOffset(8, 40), Size = UDim2.new(1, -16, 0, 28), BackgroundTransparency = 1 }, Window)
new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, TabBar)
local PageHolder = new("Frame", {
    Position = UDim2.fromOffset(8, 74), Size = UDim2.new(1, -16, 1, -82),
    BackgroundTransparency = 1, ClipsDescendants = true,
}, Window)

local pages, tabBtns = {}, {}
local tabOrder = { "Combat", "Visuals", "Player", "Misc" }

local function selectTab(name)
    for n, p in pairs(pages) do
        p.Visible = (n == name)
    end
    for n, b in pairs(tabBtns) do
        local on = (n == name)
        TweenService:Create(b, TWEEN, {
            BackgroundColor3 = on and Theme.Accent or Theme.Row,
            TextColor3 = on and Color3.new(1, 1, 1) or Theme.Sub,
        }):Play()
    end
end

for i, name in ipairs(tabOrder) do
    local btn = new("TextButton", {
        LayoutOrder = i, Size = UDim2.new(1 / #tabOrder, -3, 1, 0), BackgroundColor3 = Theme.Row,
        Text = name, Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Sub, AutoButtonColor = false,
    }, TabBar)
    round(btn, 7)
    local page = new("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false,
    }, PageHolder)
    new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, page)
    new("UIPadding", { PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 4) }, page)
    btn.Activated:Connect(function() selectTab(name) end)
    pages[name], tabBtns[name] = page, btn
end

-- components -------------------------------------------------------
local orders = {}
local function nextOrder(page)
    orders[page] = (orders[page] or 0) + 1
    return orders[page]
end

local function Section(page, text)
    new("TextLabel", {
        LayoutOrder = nextOrder(page), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18),
        Text = string.upper(text), Font = Enum.Font.GothamBold, TextSize = 11,
        TextColor3 = Theme.Accent, TextXAlignment = Enum.TextXAlignment.Left,
    }, page)
end

local function Note(page, text)
    new("TextLabel", {
        LayoutOrder = nextOrder(page), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, Text = text,
        Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.Sub, TextXAlignment = Enum.TextXAlignment.Left,
    }, page)
end

local function Toggle(page, text, key, onChange)
    local row = new("TextButton", {
        LayoutOrder = nextOrder(page), Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = Theme.Row,
        Text = "", AutoButtonColor = false,
    }, page)
    round(row, 8)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -60, 1, 0),
        Text = text, Font = Enum.Font.GothamMedium, TextSize = 13,
        TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    local pill = new("Frame", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.fromOffset(34, 18), BackgroundColor3 = Theme.Off, BorderSizePixel = 0,
    }, row)
    round(pill)
    local knob = new("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.fromOffset(14, 14), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
    }, pill)
    round(knob)

    local function draw(animate)
        local on = S[key]
        local color = on and Theme.Accent or Theme.Off
        local pos = on and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        if animate then
            TweenService:Create(pill, TWEEN, { BackgroundColor3 = color }):Play()
            TweenService:Create(knob, TWEEN, { Position = pos }):Play()
        else
            pill.BackgroundColor3 = color
            knob.Position = pos
        end
    end
    draw(false)

    row.Activated:Connect(function()
        S[key] = not S[key]
        draw(true)
        if onChange then onChange(S[key]) end
    end)
end

local function Slider(page, text, key, min, max, step, suffix)
    local decimals = step < 1 and 2 or 0
    local row = new("Frame", {
        LayoutOrder = nextOrder(page), Size = UDim2.new(1, 0, 0, 46),
        BackgroundColor3 = Theme.Row, BorderSizePixel = 0,
    }, page)
    round(row, 8)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 4), Size = UDim2.new(0.6, 0, 0, 18),
        Text = text, Font = Enum.Font.GothamMedium, TextSize = 13,
        TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    local valueLabel = new("TextLabel", {
        BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 4),
        Size = UDim2.new(0.4, -10, 0, 18), Text = "", Font = Enum.Font.GothamMedium, TextSize = 12,
        TextColor3 = Theme.Sub, TextXAlignment = Enum.TextXAlignment.Right,
    }, row)
    local bar = new("Frame", {
        Position = UDim2.new(0, 10, 0, 31), Size = UDim2.new(1, -20, 0, 6),
        BackgroundColor3 = Theme.Off, BorderSizePixel = 0,
    }, row)
    round(bar)
    local fill = new("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0 }, bar)
    round(fill)
    local knob = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 2,
    }, bar)
    round(knob)
    -- big transparent hit area so it's easy to grab with a thumb
    local hit = new("TextButton", {
        BackgroundTransparency = 1, Text = "", Position = UDim2.fromOffset(0, 22),
        Size = UDim2.new(1, 0, 1, -22), ZIndex = 3,
    }, row)

    local function refresh()
        local v = S[key]
        local a = (v - min) / (max - min)
        fill.Size = UDim2.fromScale(a, 1)
        knob.Position = UDim2.fromScale(a, 0.5)
        valueLabel.Text = string.format("%." .. decimals .. "f", v) .. (suffix or "")
    end
    refresh()

    local function setFromX(x)
        local a = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = min + (max - min) * a
        v = math.floor(v / step + 0.5) * step
        S[key] = math.clamp(v, min, max)
        refresh()
    end

    local dragging = false
    hit.InputBegan:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
            dragging = true
            page.ScrollingEnabled = false
            setFromX(input.Position.X)
        end
    end)
    keep(UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch then
            setFromX(input.Position.X)
        end
    end))
    keep(UserInputService.InputEnded:Connect(function(input)
        local t = input.UserInputType
        if dragging and (t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch) then
            dragging = false
            page.ScrollingEnabled = true
        end
    end))
end

local function Cycle(page, text, key, options)
    local row = new("Frame", {
        LayoutOrder = nextOrder(page), Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = Theme.Row, BorderSizePixel = 0,
    }, page)
    round(row, 8)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -120, 1, 0),
        Text = text, Font = Enum.Font.GothamMedium, TextSize = 13,
        TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    local btn = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(100, 22),
        BackgroundColor3 = Theme.Off, Text = tostring(S[key]), Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = Theme.Text, AutoButtonColor = false,
    }, row)
    round(btn, 6)
    btn.Activated:Connect(function()
        local i = (table.find(options, S[key]) or 0) % #options + 1
        S[key] = options[i]
        btn.Text = S[key]
    end)
end

local function Button(page, text, callback)
    local b = new("TextButton", {
        LayoutOrder = nextOrder(page), Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = Theme.Row,
        Text = text, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.Text, AutoButtonColor = false,
    }, page)
    round(b, 8)
    b.Activated:Connect(function()
        TweenService:Create(b, TWEEN, { BackgroundColor3 = Theme.Accent }):Play()
        task.delay(0.2, function()
            if b.Parent then
                TweenService:Create(b, TWEEN, { BackgroundColor3 = Theme.Row }):Play()
            end
        end)
        callback()
    end)
end

-- pages ------------------------------------------------------------
local pCombat, pVisuals, pPlayer, pMisc = pages.Combat, pages.Visuals, pages.Player, pages.Misc

Section(pCombat, "Aimbot")
Toggle(pCombat, "Aimbot", "Aimbot")
Toggle(pCombat, "Hold RMB to aim", "HoldToAim")
Cycle(pCombat, "Aim part", "AimPart", { "Head", "Body" })
Slider(pCombat, "FOV radius", "FOV", 30, 500, 5, " px")
Slider(pCombat, "Smoothness", "Smooth", 0, 95, 1, "%")
Slider(pCombat, "Prediction", "Prediction", 0, 0.3, 0.01, " s")
Section(pCombat, "Filters")
Toggle(pCombat, "Show FOV circle", "ShowFOV")
Toggle(pCombat, "Team check", "TeamCheck")
Toggle(pCombat, "Wall check", "WallCheck")
Toggle(pCombat, "Sticky target", "Sticky")
Note(pCombat, "Hold RMB to aim (turn it off to aim whenever enabled; touch devices are always on). Aim pauses while this menu is open.")

Section(pVisuals, "Wallhack / ESP")
Toggle(pVisuals, "ESP", "ESP")
Toggle(pVisuals, "Chams (see-through glow)", "Chams")
Toggle(pVisuals, "Names", "Names")
Toggle(pVisuals, "Health", "Health")
Toggle(pVisuals, "Distance", "Distance")
Toggle(pVisuals, "Hide teammates", "HideTeam")
Cycle(pVisuals, "ESP color", "ESPColor", COLOR_NAMES)
Slider(pVisuals, "Max distance", "ESPDist", 100, 5000, 50, " st")
Section(pVisuals, "World")
Toggle(pVisuals, "Fullbright", "Fullbright", setFullbright)
Toggle(pVisuals, "Custom camera FOV", "CamFOVOn", function(on)
    if on then
        orig.FOV = Camera.FieldOfView
    else
        Camera.FieldOfView = orig.FOV
    end
end)
Slider(pVisuals, "Camera FOV", "CamFOV", 40, 120, 1, "")

Section(pPlayer, "Movement")
Toggle(pPlayer, "WalkSpeed", "SpeedOn", function(on)
    local hum = getHum()
    if not hum then return end
    if on then orig.Speed = hum.WalkSpeed else hum.WalkSpeed = orig.Speed end
end)
Slider(pPlayer, "Speed", "Speed", 16, 250, 1, "")
Toggle(pPlayer, "JumpPower", "JumpOn", function(on)
    local hum = getHum()
    if not hum then return end
    if on then
        orig.Jump, orig.UseJP = hum.JumpPower, hum.UseJumpPower
    else
        hum.JumpPower = orig.Jump
        hum.UseJumpPower = orig.UseJP
    end
end)
Slider(pPlayer, "Jump", "Jump", 50, 300, 1, "")
Toggle(pPlayer, "Infinite jump", "InfJump")
Toggle(pPlayer, "Noclip", "Noclip")
Section(pPlayer, "Flight")
Toggle(pPlayer, "Fly", "Fly")
Slider(pPlayer, "Fly speed", "FlySpeed", 10, 250, 1, "")
Note(pPlayer, "Fly: WASD / thumbstick moves toward where you look. Space or E = up, Ctrl or Q = down (jump button on mobile).")

Section(pMisc, "Utility")
Toggle(pMisc, "Anti-AFK", "AntiAFK")
Button(pMisc, "Respawn character", function()
    local hum = getHum()
    if hum then hum.Health = 0 end
end)
Button(pMisc, "Unload menu", unload)
Note(pMisc, "RightShift or the round N button shows/hides the menu. Drag the title bar or the N button to move them.")

selectTab("Combat")
setMenu(true)
print("[nyx] menu loaded")
