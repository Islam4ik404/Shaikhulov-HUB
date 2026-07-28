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
local ToolBtn = Instance.new("TextButton")
local MinBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "ShaikhulovHUB"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -110, 0.4, -155)
MainFrame.Size = UDim2.new(0, 220, 0, 470)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Title.Size = UDim2.new(0, 185, 0, 35)
Title.Text = "🎯ShaikhulovHUB🎯"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold

MinBtn.Parent = MainFrame
MinBtn.Position = UDim2.new(0, 185, 0, 0)
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MinBtn.Text = "[-]"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 12
MinBtn.Font = Enum.Font.SourceSansBold

ControlFrame.Parent = MainFrame
ControlFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ControlFrame.Position = UDim2.new(0.05, 0, 0, 45)
ControlFrame.Size = UDim2.new(0, 200, 0, 210)

local isSpeedEnabled, isFlyEnabled, isNoclipEnabled, isTPEnabled, isMinimized = false, false, false, false, false
local currentSpeedValue, flySpeed = 100, 50
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

SpeedToggle.Parent = ControlFrame
SpeedToggle.Position = UDim2.new(0, 0, 0, 5)
SpeedToggle.Size = UDim2.new(0, 110, 0, 35)
SpeedToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
SpeedToggle.Text = "Speed: OFF"
SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggle.TextSize = 12
SpeedToggle.Font = Enum.Font.SourceSansBold

SpeedInput.Parent = ControlFrame
SpeedInput.Position = UDim2.new(0, 115, 0, 5)
SpeedInput.Size = UDim2.new(0, 85, 0, 35)
SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
SpeedInput.Text = "100"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 12
SpeedInput.Font = Enum.Font.SourceSans

FlyToggle.Parent = ControlFrame
FlyToggle.Position = UDim2.new(0, 0, 0, 45)
FlyToggle.Size = UDim2.new(1, 0, 0, 35)
FlyToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
FlyToggle.Text = "Fly: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggle.TextSize = 12
FlyToggle.Font = Enum.Font.SourceSansBold

NoclipToggle.Parent = ControlFrame
NoclipToggle.Position = UDim2.new(0, 0, 0, 85)
NoclipToggle.Size = UDim2.new(1, 0, 0, 35)
NoclipToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
NoclipToggle.Text = "Noclip: OFF"
NoclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipToggle.TextSize = 12
NoclipToggle.Font = Enum.Font.SourceSansBold

TPToggle.Parent = ControlFrame
TPToggle.Position = UDim2.new(0, 0, 0, 125)
TPToggle.Size = UDim2.new(1, 0, 0, 35)
TPToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
TPToggle.Text = "Click TP: OFF"
TPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TPToggle.TextSize = 12
TPToggle.Font = Enum.Font.SourceSansBold

ToolBtn.Parent = ControlFrame
ToolBtn.Position = UDim2.new(0, 0, 0, 165)
ToolBtn.Size = UDim2.new(1, 0, 0, 35)
ToolBtn.BackgroundColor3 = Color3.fromRGB(70, 35, 120)
ToolBtn.Text = "Give All Tools 🎒"
ToolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToolBtn.TextSize = 12
ToolBtn.Font = Enum.Font.SourceSansBold

ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0.05, 0, 0, 265)
ScrollingFrame.Size = UDim2.new(0, 200, 0, 190)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Size = isMinimized and UDim2.new(0, 220, 0, 35) or UDim2.new(0, 220, 0, 470)
    ControlFrame.Visible = not isMinimized
    ScrollingFrame.Visible = not isMinimized
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
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 12
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

updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
