local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ControlFrame = Instance.new("Frame")
local SpeedToggle = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local FlyToggle = Instance.new("TextButton")
local NoclipToggle = Instance.new("TextButton")
local TPToggle = Instance.new("TextButton")
local ESPToggle = Instance.new("TextButton")
local AimToggle = Instance.new("TextButton")
local FOVInput = Instance.new("TextBox")
local ToolBtn = Instance.new("TextButton")
local MinBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "ShaikhulovHUB"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -115, 0.35, -150)
MainFrame.Size = UDim2.new(0, 230, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Title.Size = UDim2.new(0, 185, 0, 24)
Title.Text = "🎯ShaikhulovHUB🎯"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 12
Title.Font = Enum.Font.SourceSansBold

MinBtn.Parent = MainFrame
MinBtn.Position = UDim2.new(0, 185, 0, 0)
MinBtn.Size = UDim2.new(0, 45, 0, 24)
MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MinBtn.Text = "[-]"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 13
MinBtn.Font = Enum.Font.SourceSansBold

ControlFrame.Parent = MainFrame
ControlFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ControlFrame.Position = UDim2.new(0.05, 0, 0, 32)
ControlFrame.Size = UDim2.new(0, 207, 0, 195)

local isSpeedEnabled, isFlyEnabled, isNoclipEnabled, isTPEnabled, isMinimized = false, false, false, false, false
local currentSpeedValue, flySpeed = 100, 50
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

SpeedToggle.Parent = ControlFrame
SpeedToggle.Position = UDim2.new(0, 0, 0, 0)
SpeedToggle.Size = UDim2.new(0, 115, 0, 28)
SpeedToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
SpeedToggle.Text = "Speed: OFF"
SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggle.TextSize = 12
SpeedToggle.Font = Enum.Font.SourceSansBold

SpeedInput.Parent = ControlFrame
SpeedInput.Position = UDim2.new(0, 120, 0, 0)
SpeedInput.Size = UDim2.new(0, 87, 0, 28)
SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
SpeedInput.Text = "100"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 12
SpeedInput.Font = Enum.Font.SourceSans

FlyToggle.Parent = ControlFrame
FlyToggle.Position = UDim2.new(0, 0, 0, 31)
FlyToggle.Size = UDim2.new(1, 0, 0, 28)
FlyToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
FlyToggle.Text = "Fly: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggle.TextSize = 12
FlyToggle.Font = Enum.Font.SourceSansBold

NoclipToggle.Parent = ControlFrame
NoclipToggle.Position = UDim2.new(0, 0, 0, 62)
NoclipToggle.Size = UDim2.new(1, 0, 0, 28)
NoclipToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
NoclipToggle.Text = "Noclip: OFF"
NoclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipToggle.TextSize = 12
NoclipToggle.Font = Enum.Font.SourceSansBold

TPToggle.Parent = ControlFrame
TPToggle.Position = UDim2.new(0, 0, 0, 93)
TPToggle.Size = UDim2.new(1, 0, 0, 28)
TPToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
TPToggle.Text = "Click TP: OFF"
TPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TPToggle.TextSize = 12
TPToggle.Font = Enum.Font.SourceSansBold

ESPToggle.Parent = ControlFrame
ESPToggle.Position = UDim2.new(0, 0, 0, 124)
ESPToggle.Size = UDim2.new(1, 0, 0, 28)
ESPToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ESPToggle.Text = "ESP: OFF"
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.TextSize = 12
ESPToggle.Font = Enum.Font.SourceSansBold

AimToggle.Parent = ControlFrame
AimToggle.Position = UDim2.new(0, 0, 0, 155)
AimToggle.Size = UDim2.new(0, 145, 0, 28)
AimToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
AimToggle.Text = "Aim: OFF (FOV:90)"
AimToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimToggle.TextSize = 11
AimToggle.Font = Enum.Font.SourceSansBold

FOVInput.Parent = ControlFrame
FOVInput.Position = UDim2.new(0, 150, 0, 155)
FOVInput.Size = UDim2.new(0, 57, 0, 28)
FOVInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
FOVInput.Text = "90"
FOVInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVInput.TextSize = 11
FOVInput.Font = Enum.Font.SourceSans

ToolBtn.Parent = MainFrame
ToolBtn.Position = UDim2.new(0.05, 0, 0, 233)
ToolBtn.Size = UDim2.new(0, 207, 0, 30)
ToolBtn.BackgroundColor3 = Color3.fromRGB(70, 35, 120)
ToolBtn.Text = "Give All Tools 🎒"
ToolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToolBtn.TextSize = 12
ToolBtn.Font = Enum.Font.SourceSansBold

ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0.05, 0, 0, 267)
ScrollingFrame.Size = UDim2.new(0, 207, 0, 35)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)

-- НАСТРОЙКИ ESP
local ESPSettings = {
    Enabled = false,
    BoxColor = Color3.fromRGB(255, 255, 255),
    Tracers = true,
    Names = true,
    Distance = true,
    HealthBar = true
}

-- НАСТРОЙКИ AIM
local AimSettings = {
    Enabled = false,
    FOV = 90,
    AimPart = "Head",
    VisibleCheck = true
}

local espObjects = {}
local aimFOVCircle = Drawing.new("Circle")
aimFOVCircle.Visible = false
aimFOVCircle.Color = Color3.fromRGB(255, 255, 255)
aimFOVCircle.Thickness = 1
aimFOVCircle.Filled = false
aimFOVCircle.Radius = 90
aimFOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)

-- ESP ФУНКЦИИ
local function createESP(target)
    local char = target.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    local head = char:FindFirstChild("Head")
    if not hrp or not hum or not head then return end

    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESPSettings.BoxColor
    box.Thickness = 2
    box.Filled = false

    local nameTag = Drawing.new("Text")
    nameTag.Visible = false
    nameTag.Color = Color3.fromRGB(255, 255, 255)
    nameTag.Size = 14
    nameTag.Center = true
    nameTag.Outline = true

    local distTag = Drawing.new("Text")
    distTag.Visible = false
    distTag.Color = Color3.fromRGB(200, 200, 200)
    distTag.Size = 12
    distTag.Center = true
    distTag.Outline = true

    local healthBar = Drawing.new("Line")
    healthBar.Visible = false
    healthBar.Thickness = 3

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = Color3.fromRGB(255, 255, 255)
    tracer.Thickness = 1

    espObjects[target] = {box, nameTag, distTag, healthBar, tracer, target, hrp, hum, head}
end

local function updateESP()
    local camera = workspace.CurrentCamera
    for target, espData in pairs(espObjects) do
        local box, nameTag, distTag, healthBar, tracer, _, hrp, hum, head = unpack(espData)
        if target.Parent and target.Character and hrp and hum and head then
            local pos, onScreen = camera:WorldToViewportPoint(hrp.Position)

            if onScreen and ESPSettings.Enabled then
                local scale = 1000 / (camera.CFrame.Position - hrp.Position).Magnitude
                local boxSize = Vector2.new(3 * scale, 5 * scale)

                box.Visible = true
                box.Size = boxSize
                box.Position = Vector2.new(pos.X - boxSize.X / 2, pos.Y - boxSize.Y / 2)

                if ESPSettings.Names then
                    nameTag.Visible = true
                    nameTag.Text = target.DisplayName
                    nameTag.Position = Vector2.new(pos.X, pos.Y - boxSize.Y / 2 - 16)
                end

                if ESPSettings.Distance then
                    local dist = math.floor((hrp.Position - camera.CFrame.Position).Magnitude)
                    distTag.Visible = true
                    distTag.Text = dist .. "m"
                    distTag.Position = Vector2.new(pos.X, pos.Y + boxSize.Y / 2 + 4)
                end

                if ESPSettings.HealthBar and hum then
                    local healthPercent = hum.Health / hum.MaxHealth
                    healthBar.Visible = true
                    healthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                    healthBar.From = Vector2.new(pos.X - boxSize.X / 2 - 6, pos.Y + boxSize.Y / 2)
                    healthBar.To = Vector2.new(pos.X - boxSize.X / 2 - 6, pos.Y + boxSize.Y / 2 - boxSize.Y * healthPercent)
                end

                if ESPSettings.Tracers then
                    tracer.Visible = true
                    tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    tracer.To = Vector2.new(pos.X, pos.Y)
                end
            else
                box.Visible = false
                nameTag.Visible = false
                distTag.Visible = false
                healthBar.Visible = false
                tracer.Visible = false
            end
        end
    end
end

local function removeESP(target)
    if espObjects[target] then
        for _, obj in pairs(espObjects[target]) do
            if typeof(obj) ~= "table" then obj:Remove() end
        end
        espObjects[target] = nil
    end
end

-- SILENT AIM ФУНКЦИИ
local function getClosestInFOV()
    local camera = workspace.CurrentCamera
    local mousePos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    local closest = nil
    local minDist = AimSettings.FOV

    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local part = p.Character:FindFirstChild(AimSettings.AimPart)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude

                if dist < minDist and onScreen then
                    if AimSettings.VisibleCheck then
                        local ray = Ray.new(camera.CFrame.Position, (part.Position - camera.CFrame.Position).Unit * 1000)
                        local hit = workspace:FindPartOnRay(ray, player.Character)
                        if hit and hit:IsDescendantOf(p.Character) then
                            minDist = dist
                            closest = part
                        end
                    else
                        minDist = dist
                        closest = part
                    end
                end
            end
        end
    end
    return closest
end

-- HOOK ДЛЯ SILENT AIM
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if method == "FireServer" and AimSettings.Enabled and tostring(self) == "RemoteEvent" then
        local targetPart = getClosestInFOV()
        if targetPart then
            local newArgs = {}
            for i, v in ipairs(args) do
                if typeof(v) == "Vector3" then
                    newArgs[i] = targetPart.Position
                else
                    newArgs[i] = v
                end
            end
            return oldNamecall(self, unpack(newArgs))
        end
    end
    return oldNamecall(self, ...)
end)

-- КНОПКИ И СОБЫТИЯ
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Size = isMinimized and UDim2.new(0, 230, 0, 24) or UDim2.new(0, 230, 0, 310)
    ControlFrame.Visible = not isMinimized
    ScrollingFrame.Visible = not isMinimized
    ToolBtn.Visible = not isMinimized
    MinBtn.Text = isMinimized and "[+]" or "[-]"
end)

SpeedToggle.MouseButton1Click:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        isSpeedEnabled = not isSpeedEnabled
        SpeedToggle.Text = isSpeedEnabled and "Speed: ON" or "Speed: OFF"
        SpeedToggle.BackgroundColor3 = isSpeedEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(45, 45, 50)
        hum.WalkSpeed = isSpeedEnabled and currentSpeedValue or 16
    end
end)

SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then
        currentSpeedValue = num
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum and isSpeedEnabled then hum.WalkSpeed = currentSpeedValue end
    end
end)

FlyToggle.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    isFlyEnabled = not isFlyEnabled
    FlyToggle.Text = isFlyEnabled and "Fly: ON" or "Fly: OFF"
    FlyToggle.BackgroundColor3 = isFlyEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(45, 45, 50)
    if isFlyEnabled then
        local bvl = Instance.new("BodyVelocity")
        bvl.Name = "UIFlyForce"
        bvl.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bvl.Velocity = Vector3.new(0, 0, 0)
        bvl.Parent = hrp
    elseif hrp:FindFirstChild("UIFlyForce") then
        hrp.UIFlyForce:Destroy()
    end
end)

NoclipToggle.MouseButton1Click:Connect(function()
    isNoclipEnabled = not isNoclipEnabled
    NoclipToggle.Text = isNoclipEnabled and "Noclip: ON" or "Noclip: OFF"
    NoclipToggle.BackgroundColor3 = isNoclipEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(45, 45, 50)
end)

TPToggle.MouseButton1Click:Connect(function()
    isTPEnabled = not isTPEnabled
    TPToggle.Text = isTPEnabled and "Click TP: ON" or "Click TP: OFF"
    TPToggle.BackgroundColor3 = isTPEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(45, 45, 50)
end)

ESPToggle.MouseButton1Click:Connect(function()
    ESPSettings.Enabled = not ESPSettings.Enabled
    ESPToggle.Text = ESPSettings.Enabled and "ESP: ON" or "ESP: OFF"
    ESPToggle.BackgroundColor3 = ESPSettings.Enabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(45, 45, 50)
end)

AimToggle.MouseButton1Click:Connect(function()
    AimSettings.Enabled = not AimSettings.Enabled
    AimToggle.Text = AimSettings.Enabled and "Aim: ON (FOV:"..AimSettings.FOV..")" or "Aim: OFF (FOV:"..AimSettings.FOV..")"
    AimToggle.BackgroundColor3 = AimSettings.Enabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(45, 45, 50)
end)

FOVInput.FocusLost:Connect(function()
    local num = tonumber(FOVInput.Text)
    if num then
        AimSettings.FOV = num
        AimToggle.Text = "Aim: " .. (AimSettings.Enabled and "ON" or "OFF") .. " (FOV:"..AimSettings.FOV..")"
    end
end)

ToolBtn.MouseButton1Click:Connect(function()
    local bp = player:FindFirstChild("Backpack")
    if bp then
        local storageSources = {game:GetService("ReplicatedStorage"), game:GetService("Lighting")}
        for _, source in pairs(storageSources) do
            for _, obj in pairs(source:GetDescendants()) do
                if obj:IsA("Tool") or obj:IsA("HopperBin") then
                    local clone = obj:Clone()
                    clone.Parent = bp
                end
            end
        end
    end
end)

mouse.Button1Down:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if isTPEnabled and hrp and mouse.Target then
        hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z)
    end
end)

-- ГЛАВНЫЙ ЦИКЛ
game:GetService("RunService").Heartbeat:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if isSpeedEnabled and hum and hum.WalkSpeed ~= currentSpeedValue then hum.WalkSpeed = currentSpeedValue end
    if isFlyEnabled and hrp and hrp:FindFirstChild("UIFlyForce") then
        hrp.UIFlyForce.Velocity = (hum and hum.MoveDirection.Magnitude > 0) and workspace.CurrentCamera.CFrame.LookVector * flySpeed or Vector3.new(0, 0, 0)
    end
    if isNoclipEnabled and char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ESP И FOV ОБНОВЛЕНИЕ
game:GetService("RunService").RenderStepped:Connect(function()
    updateESP()
    if AimSettings.Enabled then
        aimFOVCircle.Visible = true
        aimFOVCircle.Radius = AimSettings.FOV
        aimFOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
    else
        aimFOVCircle.Visible = false
    end
end)

_G.HubSF = ScrollingFrame

local function flingPlayer(target)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local tHrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not hum or not tHrp then return end
    local oldCFrame = hrp.CFrame
    local oldState = hum:GetState()
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    local tPos = tHrp.Position
    hrp.CFrame = CFrame.new(tPos.X, tPos.Y, tPos.Z)
    for i = 1, 15 do
        if not tHrp then break end
        hrp.Velocity = Vector3.new(9999, 9999, 9999)
        hrp.RotVelocity = Vector3.new(9999, 9999, 9999)
        hrp.CFrame = tHrp.CFrame * CFrame.Angles(math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)), math.rad(math.random(-180, 180)))
        task.wait(0.02)
    end
    hrp.Velocity = Vector3.new(0, 0, 0)
    hrp.RotVelocity = Vector3.new(0, 0, 0)
    hrp.CFrame = oldCFrame
    hum:ChangeState(oldState)
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = true end
    end
end

local function updatePlayerList()
    local ScrollingFrame = _G.HubSF
    if not ScrollingFrame then return end
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then
            local pBtn = Instance.new("TextButton")
            pBtn.Parent = ScrollingFrame
            pBtn.Size = UDim2.new(1, 0, 0, 26)
            pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 11
            pBtn.Font = Enum.Font.SourceSans
            pBtn.MouseButton1Click:Connect(function()
                pBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                pBtn.Text = "ATTACK..."
                flingPlayer(p)
                task.wait(0.5)
                pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            end)
        end
    end
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
end

-- ИНИЦИАЛИЗАЦИЯ ESP И СПИСКА ИГРОКОВ
for _, p in pairs(game.Players:GetPlayers()) do
    if p ~= player then
        createESP(p)
        p.CharacterAdded:Connect(function() createESP(p) end)
    end
end

game.Players.PlayerAdded:Connect(function(p)
    if p ~= player then
        createESP(p)
        p.CharacterAdded:Connect(function() createESP(p) end)
    end
    updatePlayerList()
end)

game.Players.PlayerRemoving:Connect(function(p)
    removeESP(p)
    updatePlayerList()
end)

updatePlayerList()
