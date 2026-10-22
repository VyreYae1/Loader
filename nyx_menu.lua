--[[
    NYX MENU v2  |  Roblox client script (Luau)
    Run it with your executor.  Show/hide: RightShift or the round "N" button.

    Combat  : aimbot, silent aim, auto fire, hitbox expander
    Visuals : ESP (chams, boxes, tracers, names, health, distance), crosshair, camera tools, fullbright
    Player  : walkspeed, jumppower, fly, noclip, infinite jump, bhop, gravity, click-TP, teleport, spectate
    FPS     : FPS boost, FPS cap, FPS/ping counter
    Misc    : anti-AFK, hotkeys, save/load config, respawn, rejoin, unload

    Self-contained: no loadstring / HttpGet, no external libraries, no Drawing API.
    A few features need executor functions (silent aim: hookmetamethod, FPS cap: setfpscap,
    config: writefile/readfile). The menu checks and tells you if one is missing.
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
local HttpService      = game:GetService("HttpService")

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
    -- silent aim
    SilentAim = false, SilentPart = "Head", SilentFOV = 120, HitChance = 100, ShowSilentFOV = true,
    -- auto fire
    AutoFire = false, TrigHold = false, TrigHeadOnly = false, FireDelay = 40, FireRate = 90,
    -- hitbox expander
    Hitbox = false, HitboxSize = 10,
    -- esp / visuals
    ESP = false, Chams = true, Boxes = false, Tracers = false, TracerFrom = "Bottom",
    Names = true, Health = true, Distance = true, HideTeam = true, ESPColor = "Red", ESPDist = 2000,
    Crosshair = false, CrossSize = 10,
    Fullbright = false, CamFOVOn = false, CamFOV = 90, FreeZoom = false, CamClip = false,
    -- player
    SpeedOn = false, Speed = 50, JumpOn = false, Jump = 90,
    InfJump = false, Bhop = false, Noclip = false, GravityOn = false, Gravity = 60,
    Fly = false, FlySpeed = 70,
    ClickTP = false, PickName = "-", Spectate = false,
    -- fps
    FPSBoost = false, FPSCapOn = false, FPSCap = 240, ShowStats = false,
    -- misc
    AntiAFK = true, Hotkeys = true,
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

-- UI components register themselves here: key -> setter / redraw (used by hotkeys + config load)
local toggles, refreshers = {}, {}

---------------------------------------------------------------------
-- containers + overlay widgets
---------------------------------------------------------------------
local Gui = new("ScreenGui", {
    Name = "NyxMenu",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
})
mount(Gui, true, LocalPlayer:WaitForChild("PlayerGui"))

-- full-screen layer under the window: FOV circles, ESP boxes/tracers, crosshair
local Overlay = new("Frame", {
    Name = "Overlay", BackgroundTransparency = 1, BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1), ZIndex = 0,
}, Gui)

local ESPFolder = new("Folder", { Name = "NyxESP" })
mount(ESPFolder, false, Workspace)

local function makeCircle(color)
    local f = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromOffset(300, 300), Visible = false,
    }, Overlay)
    round(f)
    local stroke = new("UIStroke", { Thickness = 1.5, Color = color, Transparency = 0.1 }, f)
    return f, stroke
end
local SILENT_COLOR = Color3.fromRGB(80, 200, 255)
local FovCircle, FovStroke = makeCircle(Theme.Accent)
local SilentCircle, SilentStroke = makeCircle(SILENT_COLOR)

local CrossParts = {}
for i = 1, 4 do
    CrossParts[i] = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0, Visible = false,
    }, Overlay)
end

local function updateCrosshair(show, vpSize)
    for _, p in ipairs(CrossParts) do
        p.Visible = show
    end
    if not show then return end
    local c = vpSize / 2
    local len, gap, th = S.CrossSize, 4, 2
    CrossParts[1].Size = UDim2.fromOffset(len, th)
    CrossParts[1].Position = UDim2.fromOffset(c.X - gap - len / 2, c.Y)
    CrossParts[2].Size = UDim2.fromOffset(len, th)
    CrossParts[2].Position = UDim2.fromOffset(c.X + gap + len / 2, c.Y)
    CrossParts[3].Size = UDim2.fromOffset(th, len)
    CrossParts[3].Position = UDim2.fromOffset(c.X, c.Y - gap - len / 2)
    CrossParts[4].Size = UDim2.fromOffset(th, len)
    CrossParts[4].Position = UDim2.fromOffset(c.X, c.Y + gap + len / 2)
end

local StatsLabel = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 6),
    Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X,
    BackgroundColor3 = Theme.Bg, BackgroundTransparency = 0.25, BorderSizePixel = 0,
    Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = Theme.Text, Text = "",
    Visible = false, ZIndex = 8,
}, Gui)
round(StatsLabel, 6)
new("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, StatsLabel)

-- small toast at the top of the screen
local function notify(text)
    local n = new("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, -40),
        Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Theme.Row, BorderSizePixel = 0, Text = text,
        Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = Theme.Text, ZIndex = 20,
    }, Gui)
    round(n, 8)
    new("UIPadding", { PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14) }, n)
    new("UIStroke", { Color = Theme.Accent, Thickness = 1 }, n)
    TweenService:Create(n, TWEEN, { Position = UDim2.new(0.5, 0, 0, 36) }):Play()
    task.delay(2.8, function()
        if not n.Parent then return end
        TweenService:Create(n, TWEEN, { Position = UDim2.new(0.5, 0, 0, -40) }):Play()
        task.delay(0.25, function()
            if n.Parent then n:Destroy() end
        end)
    end)
end

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
local orig = {
    Speed = 16, Jump = 50, UseJP = true, FOV = Camera.FieldOfView, Gravity = Workspace.Gravity,
    MaxZoom = LocalPlayer.CameraMaxZoomDistance, MinZoom = LocalPlayer.CameraMinZoomDistance,
    Occlusion = LocalPlayer.DevCameraOcclusionMode,
}

local function pickedPlayer()
    local p = Players:FindFirstChild(S.PickName)
    if p and p:IsA("Player") and p ~= LocalPlayer then
        return p
    end
    return nil
end

---------------------------------------------------------------------
-- aimbot (camera steering) - shared target helpers
---------------------------------------------------------------------
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true
rayParams.RespectCanCollide = true

local function partNameFor(choice)
    return choice == "Head" and "Head" or "HumanoidRootPart"
end

local function isTouchOnly()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

-- screen point the FOV circles are centered on (crosshair in locked-mouse games)
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

-- returns true + distance-to-crosshair when the part is a legal target inside `fov` pixels
local function targetValid(part, center, fov)
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
    if d > fov then return false end
    if S.WallCheck and not isVisible(part) then return false end
    return true, d
end

-- closest legal target to the crosshair
local function pickBest(partName, fov, center)
    local best, bestD = nil, nil
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            local part = char and char:FindFirstChild(partName)
            if part then
                local ok, d = targetValid(part, center, fov)
                if ok and (not bestD or d < bestD) then
                    best, bestD = part, d
                end
            end
        end
    end
    return best
end

local function pickTarget(center)
    local partName = partNameFor(S.AimPart)
    -- sticky: keep the current lock until it leaves a slightly widened FOV
    if S.Sticky and currentTarget and currentTarget.Name == partName
        and targetValid(currentTarget, center, S.FOV * 1.25) then
        return currentTarget
    end
    return pickBest(partName, S.FOV, center)
end

---------------------------------------------------------------------
-- auto fire (triggerbot)
---------------------------------------------------------------------
local trigParams = RaycastParams.new()
trigParams.FilterType = Enum.RaycastFilterType.Exclude
trigParams.IgnoreWater = true

local VIM = nil
pcall(function() VIM = game:GetService("VirtualInputManager") end)

-- one left click: executor click -> VirtualInputManager -> equipped tool, whichever exists
local function clickOnce()
    if mouse1click then
        mouse1click()
    elseif VIM then
        local p = UserInputService:GetMouseLocation()
        VIM:SendMouseButtonEvent(p.X, p.Y, 0, true, game, 0)
        task.wait()
        VIM:SendMouseButtonEvent(p.X, p.Y, 0, false, game, 0)
    else
        local char = LocalPlayer.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end
end

local function playerFromPart(part)
    local inst = part
    local depth = 0
    while inst and inst ~= Workspace and depth < 8 do
        if inst:IsA("Model") then
            local plr = Players:GetPlayerFromCharacter(inst)
            if plr then return plr, inst end
        end
        inst = inst.Parent
        depth = depth + 1
    end
    return nil
end

-- is a legal enemy the first thing under the crosshair?
local function triggerOnTarget(center)
    local ray = Camera:ViewportPointToRay(center.X, center.Y)
    local ignore = { Camera }
    if LocalPlayer.Character then ignore[2] = LocalPlayer.Character end
    trigParams.FilterDescendantsInstances = ignore
    local hit = Workspace:Raycast(ray.Origin, ray.Direction * 3000, trigParams)
    if not hit then return false end
    local plr, char = playerFromPart(hit.Instance)
    if not plr or plr == LocalPlayer then return false end
    if S.TeamCheck and sameTeam(plr) then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if S.TrigHeadOnly and hit.Instance.Name ~= "Head" then return false end
    return true
end

local trig = { since = nil, last = 0 }

---------------------------------------------------------------------
-- silent aim (needs hookmetamethod): redirects the GAME's own raycasts / Mouse.Hit
-- The hooks only read env.NyxSilent, so re-running this script reuses them safely.
---------------------------------------------------------------------
local Silent = { on = false, part = nil, pos = nil, look = nil, chance = 100, mouse = LocalPlayer:GetMouse() }
env.NyxSilent = Silent

local function installSilentHooks()
    if env.NyxSilentHooked then return true end
    if not (hookmetamethod and getnamecallmethod and checkcaller) then return false end

    local ok = pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local st = env.NyxSilent
            if st and st.on and st.pos and st.look and self == Workspace
                and (method == "Raycast" or method == "FindPartOnRay"
                    or method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist")
                and not checkcaller() then
                local a = table.pack(...)
                if method == "Raycast" then
                    local origin, dir = a[1], a[2]
                    if typeof(origin) == "Vector3" and typeof(dir) == "Vector3" and dir.Magnitude > 0
                        and dir.Unit:Dot(st.look) > 0.8 and math.random(100) <= st.chance then
                        a[2] = (st.pos - origin).Unit * dir.Magnitude
                        return oldNamecall(self, table.unpack(a, 1, a.n))
                    end
                else
                    local ray = a[1]
                    if typeof(ray) == "Ray" and ray.Direction.Magnitude > 0
                        and ray.Direction.Unit:Dot(st.look) > 0.8 and math.random(100) <= st.chance then
                        a[1] = Ray.new(ray.Origin, (st.pos - ray.Origin).Unit * ray.Direction.Magnitude)
                        return oldNamecall(self, table.unpack(a, 1, a.n))
                    end
                end
            end
            return oldNamecall(self, ...)
        end)

        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            local st = env.NyxSilent
            if st and st.on and st.part and self == st.mouse and (key == "Hit" or key == "Target")
                and not checkcaller() then
                if key == "Hit" then
                    return CFrame.new(st.pos)
                end
                return st.part
            end
            return oldIndex(self, key)
        end)
    end)

    if ok then env.NyxSilentHooked = true end
    return ok
end

---------------------------------------------------------------------
-- hitbox expander (client-side: enlarges enemy HumanoidRootParts)
---------------------------------------------------------------------
local hitboxOrig = {}

local function restoreHitbox(root, o)
    if root.Parent then
        pcall(function()
            root.Size = o.Size
            root.Transparency = o.Transparency
            root.CanCollide = o.CanCollide
            root.Massless = o.Massless
        end)
    end
end

local function restoreHitboxes()
    for root, o in pairs(hitboxOrig) do
        restoreHitbox(root, o)
    end
    hitboxOrig = {}
end

local function updateHitboxes()
    if not S.Hitbox then
        if next(hitboxOrig) ~= nil then restoreHitboxes() end
        return
    end
    local size = Vector3.new(S.HitboxSize, S.HitboxSize, S.HitboxSize)
    local active = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not (S.TeamCheck and sameTeam(plr)) then
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                active[root] = true
                if not hitboxOrig[root] then
                    hitboxOrig[root] = {
                        Size = root.Size, Transparency = root.Transparency,
                        CanCollide = root.CanCollide, Massless = root.Massless,
                    }
                end
                if root.Size ~= size then root.Size = size end
                if root.Transparency ~= 0.85 then root.Transparency = 0.85 end
                if root.CanCollide then root.CanCollide = false end
                if not root.Massless then root.Massless = true end
            end
        end
    end
    -- put back anyone who died, left, or became a teammate
    for root, o in pairs(hitboxOrig) do
        if not active[root] then
            restoreHitbox(root, o)
            hitboxOrig[root] = nil
        end
    end
end

---------------------------------------------------------------------
-- ESP (Highlight chams + billboard text + 2D boxes + tracers)
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
local espDraw = {}      -- visible players from the last ESP pass (boxes/tracers follow them every frame)
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

    local box = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false,
    }, Overlay)
    local boxStroke = new("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1) }, box)
    local tracer = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0, Size = UDim2.fromOffset(0, 2), Visible = false,
    }, Overlay)

    espObjects[plr] = {
        hl = hl, bb = bb, name = name, info = info, barBg = barBg, bar = bar,
        box = box, boxStroke = boxStroke, tracer = tracer,
    }
end

local function removeESP(plr)
    local o = espObjects[plr]
    if o then
        o.hl:Destroy()
        o.bb:Destroy()
        o.box:Destroy()
        o.tracer:Destroy()
        espObjects[plr] = nil
    end
end

local function hideESPObject(o)
    o.hl.Enabled = false
    o.bb.Enabled = false
    o.box.Visible = false
    o.tracer.Visible = false
end

-- slow pass (~30 Hz): who is visible, chams, text
local function updateESP()
    if not S.ESP then
        if espWasOn then
            for _, o in pairs(espObjects) do
                hideESPObject(o)
            end
            espDraw = {}
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
            hideESPObject(o)
        end
    end

    -- Roblox only draws 31 Highlights at once, so the nearest 30 get chams
    table.sort(list, function(a, b) return a.dist < b.dist end)

    for i, e in ipairs(list) do
        local o, hum = e.o, e.hum
        local color = espColor(e.plr)
        e.color = color

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
    espDraw = list
end

-- fast pass (every frame): 2D boxes + tracers so they don't lag behind movement
local function updateDraw(vpSize)
    if not S.ESP then return end
    local origin = nil
    if S.Tracers then
        if S.TracerFrom == "Center" then
            origin = vpSize / 2
        elseif S.TracerFrom == "Mouse" then
            origin = UserInputService:GetMouseLocation()
        else
            origin = Vector2.new(vpSize.X / 2, vpSize.Y)
        end
    end
    for _, e in ipairs(espDraw) do
        local o = e.o
        local rp = e.root.Position
        local top = Camera:WorldToViewportPoint(rp + Vector3.new(0, 2.8, 0))
        local bot = Camera:WorldToViewportPoint(rp - Vector3.new(0, 3.2, 0))
        local inFront = top.Z > 0 and bot.Z > 0
        local color = e.color or COLORS.White

        if S.Boxes and inFront then
            local h = math.abs(bot.Y - top.Y)
            o.box.Size = UDim2.fromOffset(h * 0.55, h)
            o.box.Position = UDim2.fromOffset((top.X + bot.X) / 2, (top.Y + bot.Y) / 2)
            o.boxStroke.Color = color
            o.box.Visible = true
        else
            o.box.Visible = false
        end

        if origin and inFront then
            local b = Vector2.new(bot.X, bot.Y)
            local d = b - origin
            o.tracer.Size = UDim2.fromOffset(d.Magnitude, 2)
            o.tracer.Position = UDim2.fromOffset((origin.X + b.X) / 2, (origin.Y + b.Y) / 2)
            o.tracer.Rotation = math.deg(math.atan2(d.Y, d.X))
            o.tracer.BackgroundColor3 = color
            o.tracer.Visible = true
        else
            o.tracer.Visible = false
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
        if S.FPSBoost then Lighting.GlobalShadows = false end
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
-- FPS boost (reversible, processed in small chunks so it never freezes the game)
---------------------------------------------------------------------
local fps = {
    backup = {},        -- [instance] = remembered properties
    list = nil, pos = 0,         -- instances still waiting to be optimized
    restore = nil, rpos = 0,     -- instances still waiting to be put back
    quality = nil, water = nil, shadows = nil,
}
local CHUNK = 400

local function fpsOptimize(inst)
    if fps.backup[inst] then return end
    local b = nil
    if inst:IsA("Terrain") then
        return
    elseif inst:IsA("BasePart") then
        b = { k = 1, a = inst.Material, b = inst.Reflectance, c = inst.CastShadow }
        inst.Material = Enum.Material.SmoothPlastic
        inst.Reflectance = 0
        inst.CastShadow = false
    elseif inst:IsA("Decal") then
        b = { k = 2, a = inst.Transparency }
        inst.Transparency = 1
    elseif inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Beam")
        or inst:IsA("Smoke") or inst:IsA("Fire") or inst:IsA("Sparkles") or inst:IsA("PostEffect") then
        b = { k = 3, a = inst.Enabled }
        inst.Enabled = false
    end
    if b then fps.backup[inst] = b end
end

local function fpsRestoreOne(inst, b)
    if not inst.Parent then return end
    if b.k == 1 then
        inst.Material = b.a
        inst.Reflectance = b.b
        inst.CastShadow = b.c
    elseif b.k == 2 then
        inst.Transparency = b.a
    elseif b.k == 3 then
        inst.Enabled = b.a
    end
end

local function fpsStart()
    local list = {}
    for _, root in ipairs({ Workspace, Lighting }) do
        for _, d in ipairs(root:GetDescendants()) do
            list[#list + 1] = d
        end
    end
    fps.list, fps.pos = list, 0

    pcall(function()
        local r = settings().Rendering
        fps.quality = fps.quality or r.QualityLevel
        r.QualityLevel = Enum.QualityLevel.Level01
    end)
    pcall(function()
        local t = Workspace.Terrain
        fps.water = fps.water or { t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance }
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
    end)
    if fps.shadows == nil then
        fps.shadows = (lightBackup and lightBackup.GlobalShadows) or Lighting.GlobalShadows
    end
    Lighting.GlobalShadows = false
end

local function fpsStop()
    fps.list = nil
    local items = {}
    for inst, b in pairs(fps.backup) do
        items[#items + 1] = { inst, b }
    end
    fps.backup = {}
    fps.restore, fps.rpos = items, 0

    pcall(function()
        if fps.quality then settings().Rendering.QualityLevel = fps.quality end
        if fps.water then
            local t = Workspace.Terrain
            t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance = fps.water[1], fps.water[2], fps.water[3]
        end
    end)
    fps.quality, fps.water = nil, nil
    if fps.shadows ~= nil and not S.Fullbright then
        Lighting.GlobalShadows = fps.shadows
    end
    fps.shadows = nil
end

local function fpsTick()
    if fps.list then
        local list, n = fps.list, 0
        while fps.pos < #list and n < CHUNK do
            fps.pos = fps.pos + 1
            local inst = list[fps.pos]
            if inst and inst.Parent then pcall(fpsOptimize, inst) end
            n = n + 1
        end
        if fps.pos >= #list then fps.list = nil end
    end
    if fps.restore then
        local items, n = fps.restore, 0
        while fps.rpos < #items and n < CHUNK do
            fps.rpos = fps.rpos + 1
            local it = items[fps.rpos]
            pcall(fpsRestoreOne, it[1], it[2])
            n = n + 1
        end
        if fps.rpos >= #items then fps.restore = nil end
    end
end

-- finish any pending restore immediately (used on unload)
local function fpsFlush()
    local items = fps.restore
    if items then
        for i = fps.rpos + 1, #items do
            pcall(fpsRestoreOne, items[i][1], items[i][2])
        end
        fps.restore = nil
    end
end

-- new things that spawn while the boost is on get optimized too
keep(Workspace.DescendantAdded:Connect(function(d)
    if S.FPSBoost then pcall(fpsOptimize, d) end
end))

local function applyFpsCap(on)
    if not setfpscap then
        if on then
            notify("FPS cap needs setfpscap (your executor doesn't have it)")
            toggles.FPSCapOn(false)
        end
        return
    end
    pcall(setfpscap, on and S.FPSCap or 60)
end

local function getPing()
    local ok, v = pcall(function()
        return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    if ok and type(v) == "number" then
        return math.floor(v + 0.5)
    end
    return 0
end

---------------------------------------------------------------------
-- movement: speed / jump / fly / noclip / bhop / gravity / infinite jump / anti-AFK
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
    local typing = UserInputService:GetFocusedTextBox() ~= nil

    if S.SpeedOn and hum.WalkSpeed ~= S.Speed then
        hum.WalkSpeed = S.Speed
    end
    if S.JumpOn then
        if not hum.UseJumpPower then hum.UseJumpPower = true end
        if hum.JumpPower ~= S.Jump then hum.JumpPower = S.Jump end
    end
    if S.GravityOn and Workspace.Gravity ~= S.Gravity then
        Workspace.Gravity = S.Gravity
    end
    if S.Bhop and not S.Fly and not typing and UserInputService:IsKeyDown(Enum.KeyCode.Space)
        and hum.FloorMaterial ~= Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    if S.Fly then
        local cam = Workspace.CurrentCamera
        if not cam then return end
        flyActive = true
        hum.PlatformStand = true

        local cf = cam.CFrame
        local mv = getMoveVector()
        local dir = cf.RightVector * mv.X + cf.LookVector * (-mv.Z)
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

-- slower background jobs: FPS-boost chunks + hitbox refresh (10 Hz)
local slowAcc = 0
keep(RunService.Heartbeat:Connect(function(dt)
    fpsTick()
    slowAcc = slowAcc + dt
    if slowAcc >= 0.1 then
        slowAcc = 0
        pcall(updateHitboxes)
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
-- teleport helpers
---------------------------------------------------------------------
local function teleportToPicked()
    local p = pickedPlayer()
    local theirRoot = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if theirRoot and myRoot then
        myRoot.CFrame = theirRoot.CFrame * CFrame.new(0, 0, 4)
    else
        notify("pick a player first (or they have no character yet)")
    end
end

local function clickTeleport()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local mp = UserInputService:GetMouseLocation()
    local ray = Camera:ViewportPointToRay(mp.X, mp.Y)
    rayParams.FilterDescendantsInstances = { char, Camera }
    local hit = Workspace:Raycast(ray.Origin, ray.Direction * 5000, rayParams)
    if hit then
        root.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3.5, 0))
    end
end

---------------------------------------------------------------------
-- config save / load (needs writefile / readfile)
---------------------------------------------------------------------
local CONFIG_FILE = "nyx_menu_config.json"

local function saveConfig()
    if not writefile then
        notify("saving needs writefile (your executor has no file access)")
        return
    end
    local data = {}
    for k, v in pairs(S) do
        local t = type(v)
        if t == "boolean" or t == "number" or t == "string" then
            data[k] = v
        end
    end
    local ok = pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(data)) end)
    notify(ok and "config saved" or "couldn't save config")
end

local function loadConfig()
    if not (readfile and isfile) then
        notify("loading needs readfile (your executor has no file access)")
        return
    end
    if not isfile(CONFIG_FILE) then
        notify("no saved config yet - hit Save first")
        return
    end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
    if not ok or type(data) ~= "table" then
        notify("config file is unreadable")
        return
    end
    for k, v in pairs(data) do
        if S[k] ~= nil and type(S[k]) == type(v) then
            if toggles[k] then
                toggles[k](v)
            else
                S[k] = v
                if refreshers[k] then refreshers[k]() end
            end
        end
    end
    notify("config loaded")
end

---------------------------------------------------------------------
-- per-frame: aimbot, silent aim target, auto fire, FOV circles, ESP, camera, stats
---------------------------------------------------------------------
local espAccum, statAcc, statFrames = 0, 0, 0

local function onRender(dt)
    Camera = Workspace.CurrentCamera
    if not Camera then return end
    local vpSize = Camera.ViewportSize

    if S.CamFOVOn then Camera.FieldOfView = S.CamFOV end
    if S.Fullbright then applyFullbright() end

    if S.Spectate then
        local p = pickedPlayer()
        local h = p and p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        if h and Camera.CameraSubject ~= h then Camera.CameraSubject = h end
    end

    local center = getAimCenter()

    -- aimbot FOV circle
    local showAimCircle = S.Aimbot and S.ShowFOV
    FovCircle.Visible = showAimCircle
    if showAimCircle then
        FovCircle.Position = UDim2.fromOffset(center.X, center.Y)
        FovCircle.Size = UDim2.fromOffset(S.FOV * 2, S.FOV * 2)
    end

    -- silent aim: pick the target; the hooks read Silent.*
    local showSilentCircle = S.SilentAim and S.ShowSilentFOV
    SilentCircle.Visible = showSilentCircle
    if showSilentCircle then
        SilentCircle.Position = UDim2.fromOffset(center.X, center.Y)
        SilentCircle.Size = UDim2.fromOffset(S.SilentFOV * 2, S.SilentFOV * 2)
    end
    local sPart = nil
    if S.SilentAim then
        sPart = pickBest(partNameFor(S.SilentPart), S.SilentFOV, center)
    end
    if sPart then
        Silent.part = sPart
        Silent.pos = sPart.Position + sPart.AssemblyLinearVelocity * S.Prediction
        Silent.look = Camera.CFrame.LookVector
        Silent.chance = S.HitChance
        Silent.on = true
    else
        Silent.part, Silent.pos, Silent.on = nil, nil, false
    end
    SilentStroke.Color = sPart and Theme.Lock or SILENT_COLOR

    -- aimbot steering (paused while the menu is open so it can't yank the camera mid-click)
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

    -- auto fire: crosshair must stay on an enemy for FireDelay, then clicks every FireRate
    local fireAllowed = S.AutoFire and not menuOpen
        and (not S.TrigHold or isTouchOnly() or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2))
    if fireAllowed and triggerOnTarget(center) then
        local now = os.clock()
        trig.since = trig.since or now
        if now - trig.since >= S.FireDelay / 1000 and now - trig.last >= S.FireRate / 1000 then
            trig.last = now
            task.spawn(clickOnce)
        end
    else
        trig.since = nil
    end

    updateCrosshair(S.Crosshair, vpSize)

    espAccum = espAccum + dt
    if espAccum >= 1 / 30 then
        espAccum = 0
        pcall(updateESP)
    end
    pcall(updateDraw, vpSize)

    statFrames = statFrames + 1
    statAcc = statAcc + dt
    if statAcc >= 0.5 then
        if S.ShowStats then
            StatsLabel.Text = string.format("%d FPS  |  %d ms", math.floor(statFrames / statAcc + 0.5), getPing())
        end
        statFrames, statAcc = 0, 0
    end
    StatsLabel.Visible = S.ShowStats
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
    Silent.on = false
    env.NyxSilent = nil

    pcall(function()
        local hum = getHum()
        if hum then
            hum.PlatformStand = false
            if S.SpeedOn then hum.WalkSpeed = orig.Speed end
            if S.JumpOn then
                hum.JumpPower = orig.Jump
                hum.UseJumpPower = orig.UseJP
            end
            if S.Spectate and Camera then Camera.CameraSubject = hum end
        end
        if S.CamFOVOn and Camera then Camera.FieldOfView = orig.FOV end
        if S.GravityOn then Workspace.Gravity = orig.Gravity end
        if S.FreeZoom then
            LocalPlayer.CameraMaxZoomDistance = orig.MaxZoom
            LocalPlayer.CameraMinZoomDistance = orig.MinZoom
        end
        if S.CamClip then LocalPlayer.DevCameraOcclusionMode = orig.Occlusion end
        if S.FPSCapOn and setfpscap then setfpscap(60) end
        setFullbright(false)
        restoreHitboxes()
    end)
    pcall(function()
        if S.FPSBoost then fpsStop() end
        fpsFlush()
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
    Text = "NYX  //  menu v2", Font = Enum.Font.GothamBold, TextSize = 15,
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

-- keyboard: RightShift = menu, optional hotkeys, ctrl+click teleport
local HOTKEYS = {
    [Enum.KeyCode.F] = "Fly",
    [Enum.KeyCode.N] = "Noclip",
    [Enum.KeyCode.X] = "SpeedOn",
}
keep(UserInputService.InputBegan:Connect(function(input, processed)
    if UserInputService:GetFocusedTextBox() then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        setMenu(not menuOpen)
        return
    end
    if processed then return end
    if S.Hotkeys then
        local key = HOTKEYS[input.KeyCode]
        if key and toggles[key] then
            toggles[key](not S[key])
        end
    end
    if S.ClickTP and input.UserInputType == Enum.UserInputType.MouseButton1
        and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        clickTeleport()
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
local tabOrder = { "Combat", "Visuals", "Player", "FPS", "Misc" }

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
        LayoutOrder = i, Size = UDim2.new(1 / #tabOrder, -4, 1, 0), BackgroundColor3 = Theme.Row,
        Text = name, Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.Sub, AutoButtonColor = false,
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

    -- one setter used by clicks, hotkeys and config loading
    local function set(v)
        S[key] = v
        draw(true)
        if onChange then onChange(v) end
    end
    toggles[key] = set
    refreshers[key] = function() draw(false) end

    row.Activated:Connect(function() set(not S[key]) end)
end

local function Slider(page, text, key, min, max, step, suffix, onChange)
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
        local a = math.clamp((v - min) / (max - min), 0, 1)
        fill.Size = UDim2.fromScale(a, 1)
        knob.Position = UDim2.fromScale(a, 0.5)
        valueLabel.Text = string.format("%." .. decimals .. "f", v) .. (suffix or "")
    end
    refresh()
    refreshers[key] = refresh

    local function setFromX(x)
        local a = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = min + (max - min) * a
        v = math.floor(v / step + 0.5) * step
        S[key] = math.clamp(v, min, max)
        refresh()
        if onChange then onChange(S[key]) end
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
    refreshers[key] = function() btn.Text = tostring(S[key]) end
    btn.Activated:Connect(function()
        local i = (table.find(options, S[key]) or 0) % #options + 1
        S[key] = options[i]
        btn.Text = S[key]
    end)
end

-- cycles through the players currently in the server
local function PlayerPick(page, text, key)
    local row = new("Frame", {
        LayoutOrder = nextOrder(page), Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = Theme.Row, BorderSizePixel = 0,
    }, page)
    round(row, 8)
    new("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -140, 1, 0),
        Text = text, Font = Enum.Font.GothamMedium, TextSize = 13,
        TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    local btn = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(120, 22),
        BackgroundColor3 = Theme.Off, Text = tostring(S[key]), Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = Theme.Text, AutoButtonColor = false, TextTruncate = Enum.TextTruncate.AtEnd,
    }, row)
    round(btn, 6)
    refreshers[key] = function() btn.Text = tostring(S[key]) end
    btn.Activated:Connect(function()
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then names[#names + 1] = p.Name end
        end
        table.sort(names)
        if #names == 0 then
            S[key] = "-"
        else
            S[key] = names[(table.find(names, S[key]) or 0) % #names + 1]
        end
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
local pCombat, pVisuals, pPlayer, pFPS, pMisc = pages.Combat, pages.Visuals, pages.Player, pages.FPS, pages.Misc

-- COMBAT
Section(pCombat, "Aimbot")
Toggle(pCombat, "Aimbot", "Aimbot")
Toggle(pCombat, "Hold RMB to aim", "HoldToAim")
Cycle(pCombat, "Aim part", "AimPart", { "Head", "Body" })
Slider(pCombat, "FOV radius", "FOV", 30, 500, 5, " px")
Slider(pCombat, "Smoothness", "Smooth", 0, 95, 1, "%")
Slider(pCombat, "Prediction", "Prediction", 0, 0.3, 0.01, " s")
Toggle(pCombat, "Show FOV circle", "ShowFOV")

Section(pCombat, "Silent aim")
Toggle(pCombat, "Silent aim", "SilentAim", function(on)
    if on and not installSilentHooks() then
        toggles.SilentAim(false)
        notify("silent aim needs hookmetamethod (your executor doesn't have it)")
    end
end)
Cycle(pCombat, "Silent part", "SilentPart", { "Head", "Body" })
Slider(pCombat, "Silent FOV", "SilentFOV", 30, 500, 5, " px")
Slider(pCombat, "Hit chance", "HitChance", 1, 100, 1, "%")
Toggle(pCombat, "Show silent FOV", "ShowSilentFOV")

Section(pCombat, "Auto fire")
Toggle(pCombat, "Auto fire", "AutoFire")
Toggle(pCombat, "Only while RMB held", "TrigHold")
Toggle(pCombat, "Head only", "TrigHeadOnly")
Slider(pCombat, "Fire delay", "FireDelay", 0, 300, 5, " ms")
Slider(pCombat, "Fire rate", "FireRate", 40, 500, 5, " ms")

Section(pCombat, "Hitbox")
Toggle(pCombat, "Hitbox expander", "Hitbox", function(on)
    if not on then restoreHitboxes() end
end)
Slider(pCombat, "Hitbox size", "HitboxSize", 2, 40, 1, "")

Section(pCombat, "Filters")
Toggle(pCombat, "Team check", "TeamCheck")
Toggle(pCombat, "Wall check", "WallCheck")
Toggle(pCombat, "Sticky target", "Sticky")
Note(pCombat, "Aimbot: hold RMB (or turn that off for always-on; touch is always on). Aim pauses while this menu is open. Silent aim / auto fire / hitbox results depend on how the game's guns work.")

-- VISUALS
Section(pVisuals, "ESP / wallhack")
Toggle(pVisuals, "ESP", "ESP")
Toggle(pVisuals, "Chams (glow)", "Chams")
Toggle(pVisuals, "Boxes", "Boxes")
Toggle(pVisuals, "Tracers", "Tracers")
Cycle(pVisuals, "Tracer from", "TracerFrom", { "Bottom", "Center", "Mouse" })
Toggle(pVisuals, "Names", "Names")
Toggle(pVisuals, "Health", "Health")
Toggle(pVisuals, "Distance", "Distance")
Toggle(pVisuals, "Hide teammates", "HideTeam")
Cycle(pVisuals, "ESP color", "ESPColor", COLOR_NAMES)
Slider(pVisuals, "Max distance", "ESPDist", 100, 5000, 50, " st")

Section(pVisuals, "Screen")
Toggle(pVisuals, "Crosshair", "Crosshair")
Slider(pVisuals, "Crosshair size", "CrossSize", 4, 30, 1, " px")
Toggle(pVisuals, "Fullbright", "Fullbright", setFullbright)
Toggle(pVisuals, "Custom camera FOV", "CamFOVOn", function(on)
    if on then
        orig.FOV = Camera.FieldOfView
    else
        Camera.FieldOfView = orig.FOV
    end
end)
Slider(pVisuals, "Camera FOV", "CamFOV", 40, 120, 1, "")
Toggle(pVisuals, "Unlock camera zoom", "FreeZoom", function(on)
    if on then
        orig.MaxZoom, orig.MinZoom = LocalPlayer.CameraMaxZoomDistance, LocalPlayer.CameraMinZoomDistance
        LocalPlayer.CameraMaxZoomDistance = 1000
        LocalPlayer.CameraMinZoomDistance = 0.5
    else
        LocalPlayer.CameraMaxZoomDistance = orig.MaxZoom
        LocalPlayer.CameraMinZoomDistance = orig.MinZoom
    end
end)
Toggle(pVisuals, "Camera through walls", "CamClip", function(on)
    if on then
        orig.Occlusion = LocalPlayer.DevCameraOcclusionMode
        LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
    else
        LocalPlayer.DevCameraOcclusionMode = orig.Occlusion
    end
end)

-- PLAYER
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
Toggle(pPlayer, "Bunny hop (hold Space)", "Bhop")
Toggle(pPlayer, "Noclip", "Noclip")
Toggle(pPlayer, "Gravity", "GravityOn", function(on)
    if on then orig.Gravity = Workspace.Gravity else Workspace.Gravity = orig.Gravity end
end)
Slider(pPlayer, "Gravity value", "Gravity", 0, 400, 5, "")

Section(pPlayer, "Flight")
Toggle(pPlayer, "Fly", "Fly")
Slider(pPlayer, "Fly speed", "FlySpeed", 10, 250, 1, "")
Note(pPlayer, "Fly: WASD / thumbstick moves toward where you look. Space or E = up, Ctrl or Q = down (jump button on mobile).")

Section(pPlayer, "Teleport")
Toggle(pPlayer, "Ctrl + click teleport", "ClickTP")
PlayerPick(pPlayer, "Target player", "PickName")
Button(pPlayer, "Teleport to target", teleportToPicked)
Toggle(pPlayer, "Spectate target", "Spectate", function(on)
    if on then
        if not pickedPlayer() then
            toggles.Spectate(false)
            notify("pick a target player first")
        end
    else
        local hum = getHum()
        if hum then Camera.CameraSubject = hum end
    end
end)

-- FPS
Section(pFPS, "Performance")
Toggle(pFPS, "FPS boost", "FPSBoost", function(on)
    if on then
        fpsStart()
        notify("FPS boost on - optimizing the map in the background")
    else
        fpsStop()
        notify("FPS boost off - restoring the map")
    end
end)
Toggle(pFPS, "Unlock FPS cap", "FPSCapOn", applyFpsCap)
Slider(pFPS, "FPS cap", "FPSCap", 30, 360, 10, "", function()
    if S.FPSCapOn then applyFpsCap(true) end
end)
Toggle(pFPS, "Show FPS / ping", "ShowStats")
Note(pFPS, "FPS boost: lowest render quality, no shadows, flat materials, no decals / particles / post effects. Turning it off puts everything back.")

-- MISC
Section(pMisc, "Utility")
Toggle(pMisc, "Anti-AFK", "AntiAFK")
Toggle(pMisc, "Hotkeys (F / N / X)", "Hotkeys")
Section(pMisc, "Config")
Button(pMisc, "Save config", saveConfig)
Button(pMisc, "Load config", loadConfig)
Section(pMisc, "Session")
Button(pMisc, "Respawn character", function()
    local hum = getHum()
    if hum then hum.Health = 0 end
end)
Button(pMisc, "Rejoin server", function()
    local TeleportService = game:GetService("TeleportService")
    if #Players:GetPlayers() <= 1 then
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)
Button(pMisc, "Unload menu", unload)
Note(pMisc, "Hotkeys: F = fly, N = noclip, X = walkspeed, RightShift = menu. Drag the title bar or the N button to move them.")

selectTab("Combat")
setMenu(true)
print("[nyx] menu v2 loaded")
