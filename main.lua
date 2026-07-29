local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TitleBar = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ControlFrame = Instance.new("Frame")
local MinBtn = Instance.new("TextButton")

-- ЦВЕТА (ФИОЛЕТОВАЯ ТЕМА)
local COLOR_BG_DARK = Color3.fromRGB(15, 10, 30)
local COLOR_BG_LIGHT = Color3.fromRGB(30, 20, 50)
local COLOR_ACCENT_PURPLE = Color3.fromRGB(138, 43, 226)
local COLOR_ACCENT_BRIGHT = Color3.fromRGB(186, 85, 211)
local COLOR_ACTIVE = Color3.fromRGB(138, 43, 226)
local COLOR_INACTIVE = Color3.fromRGB(50, 30, 80)
local COLOR_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_TEXT_LIGHT = Color3.fromRGB(200, 200, 255)

-- Определяем устройство
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled

-- АДАПТИВНЫЕ РАЗМЕРЫ
local UI_WIDTH = isMobile and 200 or 240
local UI_HEIGHT = isMobile and 520 or 550
local UI_POS_X = isMobile and 0.5 or 0.5
local UI_POS_Y = isMobile and 0.5 or 0.4
local TEXT_SIZE_TITLE = isMobile and 13 or 16
local TEXT_SIZE_BUTTON = isMobile and 10 or 11
local BUTTON_HEIGHT = isMobile and 32 or 35

ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "PurpleHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = COLOR_BG_DARK
MainFrame.Position = UDim2.new(UI_POS_X, -UI_WIDTH/2, UI_POS_Y, -UI_HEIGHT/2)
MainFrame.Size = UDim2.new(0, UI_WIDTH, 0, UI_HEIGHT)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- ЗАГОЛОВОК
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = COLOR_ACCENT_PURPLE
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.75, 0, 1, 0)
Title.Text = "⚡ HUB ⚡"
Title.TextColor3 = COLOR_TEXT
Title.TextSize = TEXT_SIZE_TITLE
Title.Font = Enum.Font.GothamBold

MinBtn.Parent = TitleBar
MinBtn.Position = UDim2.new(0.75, 0, 0, 2)
MinBtn.Size = UDim2.new(0.25, -5, 0, 41)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
MinBtn.Text = "[-]"
MinBtn.TextColor3 = COLOR_TEXT
MinBtn.TextSize = 12
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinBtn

-- СЕПАРАТОР
local Separator = Instance.new("Frame")
Separator.Parent = MainFrame
Separator.Position = UDim2.new(0, 0, 0, 45)
Separator.Size = UDim2.new(1, 0, 0, 1)
Separator.BackgroundColor3 = COLOR_ACCENT_BRIGHT
Separator.BorderSizePixel = 0

-- MOVEMENT LABEL
local MovementLabel = Instance.new("TextLabel")
MovementLabel.Parent = MainFrame
MovementLabel.Position = UDim2.new(0.05, 0, 0, 52)
MovementLabel.Size = UDim2.new(0.9, 0, 0, 20)
MovementLabel.BackgroundTransparency = 1
MovementLabel.Text = "📍 MOVEMENT"
MovementLabel.TextColor3 = COLOR_ACCENT_BRIGHT
MovementLabel.TextSize = 9
MovementLabel.Font = Enum.Font.GothamBold
MovementLabel.TextXAlignment = Enum.TextXAlignment.Left

ControlFrame.Parent = MainFrame
ControlFrame.BackgroundTransparency = 1
ControlFrame.Position = UDim2.new(0.05, 0, 0, 72)
ControlFrame.Size = UDim2.new(0.9, 0, 0, 265)
ControlFrame.BorderSizePixel = 0

local isSpeedEnabled, isFlyEnabled, isNoclipEnabled, isTPEnabled, isMinimized = false, false, false, false, false
local currentSpeedValue, flySpeed = 100, 60
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- FLY ПЕРЕМЕННЫЕ
local flyActive = false
local flyDirection = Vector3.new(0, 0, 0)

-- HELPER FUNCTION для кнопок
local function createButton(parent, name, position, size, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = parent
    btn.Position = position
    btn.Size = size
    btn.BackgroundColor3 = COLOR_INACTIVE
    btn.Text = text
    btn.TextColor3 = COLOR_TEXT
    btn.TextSize = TEXT_SIZE_BUTTON
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    return btn
end

-- SPEED
local SpeedToggle = createButton(ControlFrame, "SpeedToggle", UDim2.new(0, 0, 0, 0), UDim2.new(0.48, -2, 0, BUTTON_HEIGHT), "Speed: OFF")
local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = ControlFrame
SpeedInput.Position = UDim2.new(0.52, 2, 0, 0)
SpeedInput.Size = UDim2.new(0.48, -2, 0, BUTTON_HEIGHT)
SpeedInput.BackgroundColor3 = COLOR_INACTIVE
SpeedInput.Text = "100"
SpeedInput.TextColor3 = COLOR_TEXT
SpeedInput.TextSize = TEXT_SIZE_BUTTON
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.BorderSizePixel = 0
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 5)
InputCorner.Parent = SpeedInput

-- FLY
local FlyToggle = createButton(ControlFrame, "FlyToggle", UDim2.new(0, 0, 0, BUTTON_HEIGHT + 5), UDim2.new(1, 0, 0, BUTTON_HEIGHT), "Fly: OFF")

-- FLY SPEED
local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Parent = ControlFrame
FlySpeedLabel.Position = UDim2.new(0, 0, 0, (BUTTON_HEIGHT + 5) * 2 + 2)
FlySpeedLabel.Size = UDim2.new(0.48, 0, 0, 20)
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.Text = "Fly Speed:"
FlySpeedLabel.TextColor3 = COLOR_TEXT_LIGHT
FlySpeedLabel.TextSize = 8
FlySpeedLabel.Font = Enum.Font.Gotham
FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local FlySpeedInput = Instance.new("TextBox")
FlySpeedInput.Parent = ControlFrame
FlySpeedInput.Position = UDim2.new(0.52, 2, 0, (BUTTON_HEIGHT + 5) * 2 + 2)
FlySpeedInput.Size = UDim2.new(0.48, -2, 0, 20)
FlySpeedInput.BackgroundColor3 = COLOR_INACTIVE
FlySpeedInput.Text = "60"
FlySpeedInput.TextColor3 = COLOR_TEXT
FlySpeedInput.TextSize = 9
FlySpeedInput.Font = Enum.Font.Gotham
FlySpeedInput.BorderSizePixel = 0
local FlySpeedCorner = Instance.new("UICorner")
FlySpeedCorner.CornerRadius = UDim.new(0, 5)
FlySpeedCorner.Parent = FlySpeedInput

-- NOCLIP
local NoclipToggle = createButton(ControlFrame, "NoclipToggle", UDim2.new(0, 0, 0, (BUTTON_HEIGHT + 5) * 3 + 5), UDim2.new(1, 0, 0, BUTTON_HEIGHT), "Noclip: OFF")

-- TELEPORT
local TPToggle = createButton(ControlFrame, "TPToggle", UDim2.new(0, 0, 0, (BUTTON_HEIGHT + 5) * 4 + 5), UDim2.new(1, 0, 0, BUTTON_HEIGHT), "Click TP: OFF")

-- ПК УПРАВЛЕНИЕ ИНФОРМАЦИЯ
local PCControlsLabel = Instance.new("TextLabel")
PCControlsLabel.Parent = ControlFrame
PCControlsLabel.Position = UDim2.new(0, 0, 0, (BUTTON_HEIGHT + 5) * 5 + 10)
PCControlsLabel.Size = UDim2.new(1, 0, 0, 45)
PCControlsLabel.BackgroundColor3 = Color3.fromRGB(60, 40, 80)
PCControlsLabel.Text = "🖥️ FLY: WASDMove\nSPACE Up / CTRL Down\n📱 TAP Joystick"
PCControlsLabel.TextColor3 = COLOR_TEXT_LIGHT
PCControlsLabel.TextSize = 8
PCControlsLabel.Font = Enum.Font.Gotham
PCControlsLabel.TextWrapped = true
local ControlsCorner = Instance.new("UICorner")
ControlsCorner.CornerRadius = UDim.new(0, 5)
ControlsCorner.Parent = PCControlsLabel

-- COMBAT LABEL
local CombatLabel = Instance.new("TextLabel")
CombatLabel.Parent = MainFrame
CombatLabel.Position = UDim2.new(0.05, 0, 0, 350)
CombatLabel.Size = UDim2.new(0.9, 0, 0, 20)
CombatLabel.BackgroundTransparency = 1
CombatLabel.Text = "⚔️ COMBAT"
CombatLabel.TextColor3 = COLOR_ACCENT_BRIGHT
CombatLabel.TextSize = 9
CombatLabel.Font = Enum.Font.GothamBold
CombatLabel.TextXAlignment = Enum.TextXAlignment.Left

-- TOOLS BUTTON
local ToolBtn = createButton(MainFrame, "ToolBtn", UDim2.new(0.05, 0, 0, 370), UDim2.new(0.9, 0, 0, BUTTON_HEIGHT + 5), "🎒 TOOLS")
ToolBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
ToolBtn.TextSize = TEXT_SIZE_BUTTON

-- PLAYERS LABEL
local PlayersLabel = Instance.new("TextLabel")
PlayersLabel.Parent = MainFrame
PlayersLabel.Position = UDim2.new(0.05, 0, 0, 410)
PlayersLabel.Size = UDim2.new(0.9, 0, 0, 20)
PlayersLabel.BackgroundTransparency = 1
PlayersLabel.Text = "👾 PLAYERS"
PlayersLabel.TextColor3 = COLOR_ACCENT_BRIGHT
PlayersLabel.TextSize = 9
PlayersLabel.Font = Enum.Font.GothamBold
PlayersLabel.TextXAlignment = Enum.TextXAlignment.Left

ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0.05, 0, 0, 430)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0, isMobile and 70 or 90)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 2
ScrollingFrame.ScrollBarImageColor3 = COLOR_ACCENT_PURPLE

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

-- MINIMIZE
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Size = isMinimized and UDim2.new(0, UI_WIDTH, 0, 45) or UDim2.new(0, UI_WIDTH, 0, UI_HEIGHT)
    ControlFrame.Visible = not isMinimized
    ScrollingFrame.Visible = not isMinimized
    MovementLabel.Visible = not isMinimized
    CombatLabel.Visible = not isMinimized
    PlayersLabel.Visible = not isMinimized
    ToolBtn.Visible = not isMinimized
    Separator.Visible = not isMinimized
    MinBtn.Text = isMinimized and "[+]" or "[-]"
end)

-- SPEED
SpeedToggle.MouseButton1Click:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        isSpeedEnabled = not isSpeedEnabled
        SpeedToggle.Text = isSpeedEnabled and "✓ Speed" or "Speed"
        SpeedToggle.BackgroundColor3 = isSpeedEnabled and COLOR_ACTIVE or COLOR_INACTIVE
        hum.WalkSpeed = isSpeedEnabled and currentSpeedValue or 16
    end
end)

SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then
        currentSpeedValue = num
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum and isSpeedEnabled then 
            hum.WalkSpeed = currentSpeedValue 
        end
    end
end)

-- FLY УЛУЧШЕННЫЙ
FlyToggle.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    isFlyEnabled = not isFlyEnabled
    FlyToggle.Text = isFlyEnabled and "✓ Fly: ON" or "Fly: OFF"
    FlyToggle.BackgroundColor3 = isFlyEnabled and COLOR_ACTIVE or COLOR_INACTIVE
    
    if isFlyEnabled then
        local bvl = Instance.new("BodyVelocity")
        bvl.Name = "UIFlyForce"
        bvl.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bvl.Velocity = Vector3.new(0, 0, 0)
        bvl.Parent = hrp
        
        flyActive = true
        flyDirection = Vector3.new(0, 0, 0)
    else
        if hrp:FindFirstChild("UIFlyForce") then
            hrp.UIFlyForce:Destroy()
        end
        flyActive = false
        flyDirection = Vector3.new(0, 0, 0)
    end
end)

-- NOCLIP
NoclipToggle.MouseButton1Click:Connect(function()
    isNoclipEnabled = not isNoclipEnabled
    NoclipToggle.Text = isNoclipEnabled and "✓ Noclip" or "Noclip"
    NoclipToggle.BackgroundColor3 = isNoclipEnabled and COLOR_ACTIVE or COLOR_INACTIVE
end)

-- TELEPORT
TPToggle.MouseButton1Click:Connect(function()
    isTPEnabled = not isTPEnabled
    TPToggle.Text = isTPEnabled and "✓ TP" or "TP"
    TPToggle.BackgroundColor3 = isTPEnabled and COLOR_ACTIVE or COLOR_INACTIVE
end)

-- GIVE TOOLS
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

-- CLICK TELEPORT
mouse.Button1Down:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if isTPEnabled and hrp and mouse.Target then
        hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z)
    end
end)

-- ПК УПРАВЛЕНИЕ FLY (WASD, SPACE, CTRL)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not flyActive then return end
    
    if input.KeyCode == Enum.KeyCode.W then
        flyDirection = flyDirection + workspace.CurrentCamera.CFrame.LookVector * 0.1
    elseif input.KeyCode == Enum.KeyCode.S then
        flyDirection = flyDirection - workspace.CurrentCamera.CFrame.LookVector * 0.1
    elseif input.KeyCode == Enum.KeyCode.A then
        flyDirection = flyDirection - workspace.CurrentCamera.CFrame.RightVector * 0.1
    elseif input.KeyCode == Enum.KeyCode.D then
        flyDirection = flyDirection + workspace.CurrentCamera.CFrame.RightVector * 0.1
    elseif input.KeyCode == Enum.KeyCode.Space then
        flyDirection = flyDirection + Vector3.new(0, 0.1, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        flyDirection = flyDirection - Vector3.new(0, 0.1, 0)
    end
end)

-- HEARTBEAT (ALL FEATURES)
game:GetService("RunService").Heartbeat:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    -- SPEED
    if isSpeedEnabled and hum and hum.WalkSpeed ~= currentSpeedValue then
        hum.WalkSpeed = currentSpeedValue
    end
    
    -- FLY УЛУЧШЕННЫЙ
    if isFlyEnabled and hrp and hrp:FindFirstChild("UIFlyForce") then
        local flySpeedNum = tonumber(FlySpeedInput.Text) or 60
        
        -- Обновляем скорость полета
        if hrp:FindFirstChild("UIFlyForce") then
            -- Если идёт движение - летим в направлении
            if flyDirection.Magnitude > 0 then
                hrp.UIFlyForce.Velocity = flyDirection * flySpeedNum
            else
                -- Если нет движения - летим по направлению камеры
                if hum and hum.MoveDirection.Magnitude > 0 then
                    hrp.UIFlyForce.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeedNum * 0.5
                else
                    hrp.UIFlyForce.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
        
        -- Плавно уменьшаем направление
        flyDirection = flyDirection * 0.9
    end
    
    -- NOCLIP
    if isNoclipEnabled and char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end
end)

_G.HubSF = ScrollingFrame

-- СУПЕР ФЛИНГ
local function superFlingPlayer(target)
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
    
    local tHum = target.Character:FindFirstChildOfClass("Humanoid")
    if tHum then tHum:ChangeState(Enum.HumanoidStateType.Physics) end
    for _, part in pairs(target.Character:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    
    local tPos = tHrp.Position
    hrp.CFrame = CFrame.new(tPos.X, tPos.Y, tPos.Z)
    
    for i = 1, 30 do
        if not tHrp or not tHrp.Parent then break end
        
        tHrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
        tHrp.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
        
        tHrp.CFrame = tHrp.CFrame * CFrame.Angles(
            math.rad(math.random(-360, 360)), 
            math.rad(math.random(-360, 360)), 
            math.rad(math.random(-360, 360))
        )
        
        task.wait(0.01)
    end
    
    if tHrp then
        tHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        tHrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
    
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    hrp.CFrame = oldCFrame
    hum:ChangeState(oldState)
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = true end
    end
    if target.Character then
        for _, part in pairs(target.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- UPDATE PLAYER LIST
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
            pBtn.Size = UDim2.new(1, 0, 0, 28)
            pBtn.BackgroundColor3 = COLOR_INACTIVE
            pBtn.Text = "👤 " .. p.DisplayName
            pBtn.TextColor3 = COLOR_TEXT
            pBtn.TextSize = 9
            pBtn.Font = Enum.Font.Gotham
            pBtn.BorderSizePixel = 0
            pBtn.AutoButtonColor = false
            
            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(0, 4)
            pCorner.Parent = pBtn
            
            pBtn.MouseButton1Click:Connect(function()
                pBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
                pBtn.Text = "💥 LAUNCHING!"
                superFlingPlayer(p)
                task.wait(0.5)
                pBtn.BackgroundColor3 = COLOR_INACTIVE
                pBtn.Text = "👤 " .. p.DisplayName
            end)
            
            pBtn.MouseEnter:Connect(function()
                pBtn.BackgroundColor3 = COLOR_ACCENT_BRIGHT
            end)
            
            pBtn.MouseLeave:Connect(function()
                pBtn.BackgroundColor3 = COLOR_INACTIVE
            end)
        end
    end
    
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
end

updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
