local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local TabContainer = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- ЦВЕТА (ФИОЛЕТОВАЯ ТЕМА)
local COLOR_BG_DARK = Color3.fromRGB(15, 10, 30)
local COLOR_ACCENT_PURPLE = Color3.fromRGB(138, 43, 226)
local COLOR_ACCENT_BRIGHT = Color3.fromRGB(186, 85, 211)
local COLOR_ACTIVE = Color3.fromRGB(138, 43, 226)
local COLOR_INACTIVE = Color3.fromRGB(50, 30, 80)
local COLOR_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_TEXT_LIGHT = Color3.fromRGB(200, 200, 255)

ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- ГЛАВНОЕ ОКНО - ШИРОКОЕ И КОРОТКОЕ
MainFrame.Name = "PurpleHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = COLOR_BG_DARK
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
MainFrame.Size = UDim2.new(0, 700, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- TITLE BAR
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = COLOR_ACCENT_PURPLE
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BorderSizePixel = 0

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 15)
TitleBarCorner.Parent = TitleBar

Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Text = "⚡ PURPLE HUB ⚡"
Title.TextColor3 = COLOR_TEXT
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

-- MINIMIZE BUTTON (-)
MinimizeBtn.Parent = TitleBar
MinimizeBtn.Position = UDim2.new(0.85, 0, 0, 7)
MinimizeBtn.Size = UDim2.new(0, 36, 0, 36)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
MinimizeBtn.Text = "[-]"
MinimizeBtn.TextColor3 = COLOR_TEXT
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.BorderSizePixel = 0

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

-- CLOSE BUTTON (+)
CloseBtn.Parent = TitleBar
CloseBtn.Position = UDim2.new(0.925, 0, 0, 7)
CloseBtn.Size = UDim2.new(0, 36, 0, 36)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Text = "[X]"
CloseBtn.TextColor3 = COLOR_TEXT
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- CONTAINER ДЛЯ КОНТЕНТА
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 0, 0, 50)
TabContainer.Size = UDim2.new(1, 0, 1, -50)
TabContainer.BorderSizePixel = 0

-- SCROLLING FRAME
ScrollingFrame.Parent = TabContainer
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = COLOR_ACCENT_PURPLE

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

-- ПЕРЕМЕННЫЕ
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local isMinimized = false
local miniFrame = nil

-- ФИЧИ
local isSpeedEnabled = false
local isFlyEnabled = false
local isNoclipEnabled = false
local isTPEnabled = false
local isESPEnabled = false
local isSilentAimEnabled = false

local currentSpeedValue = 100
local flySpeed = 60
local espObjects = {}
local silentAimFOV = 200
local silentAimTarget = nil

-- HELPER FUNCTION
local function createButton(parent, name, text, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = parent
    btn.Size = UDim2.new(0, 150, 0, 40)
    btn.BackgroundColor3 = COLOR_INACTIVE
    btn.Text = text
    btn.TextColor3 = COLOR_TEXT
    btn.TextSize = 12
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(100, 60, 140)
    end)
    
    btn.MouseLeave:Connect(function()
        if btn.Text:find("OFF") then
            btn.BackgroundColor3 = COLOR_INACTIVE
        end
    end)
    
    return btn
end

local function createLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = UDim2.new(0, 300, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLOR_ACCENT_BRIGHT
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    return label
end

local function createTextBox(parent, placeholder)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.Size = UDim2.new(0, 100, 0, 35)
    box.BackgroundColor3 = COLOR_INACTIVE
    box.Text = placeholder
    box.TextColor3 = COLOR_TEXT
    box.TextSize = 12
    box.Font = Enum.Font.Gotham
    box.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    
    return box
end

-- MOVEMENT SECTION
createLabel(ScrollingFrame, "📍 MOVEMENT").LayoutOrder = 1

local SpeedToggle = createButton(ScrollingFrame, "SpeedToggle", "Speed: OFF", function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        isSpeedEnabled = not isSpeedEnabled
        SpeedToggle.Text = isSpeedEnabled and "✓ Speed: ON" or "Speed: OFF"
        SpeedToggle.BackgroundColor3 = isSpeedEnabled and COLOR_ACTIVE or COLOR_INACTIVE
        hum.WalkSpeed = isSpeedEnabled and currentSpeedValue or 16
    end
end)
SpeedToggle.LayoutOrder = 2

local SpeedInput = createTextBox(ScrollingFrame, "100")
SpeedInput.LayoutOrder = 3
SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then
        currentSpeedValue = num
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum and isSpeedEnabled then hum.WalkSpeed = currentSpeedValue end
    end
end)

local FlyToggle = createButton(ScrollingFrame, "FlyToggle", "Fly: OFF", function()
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
    elseif hrp:FindFirstChild("UIFlyForce") then
        hrp.UIFlyForce:Destroy()
    end
end)
FlyToggle.LayoutOrder = 4

local NoclipToggle = createButton(ScrollingFrame, "NoclipToggle", "Noclip: OFF", function()
    isNoclipEnabled = not isNoclipEnabled
    NoclipToggle.Text = isNoclipEnabled and "✓ Noclip: ON" or "Noclip: OFF"
    NoclipToggle.BackgroundColor3 = isNoclipEnabled and COLOR_ACTIVE or COLOR_INACTIVE
end)
NoclipToggle.LayoutOrder = 5

local TPToggle = createButton(ScrollingFrame, "TPToggle", "Click TP: OFF", function()
    isTPEnabled = not isTPEnabled
    TPToggle.Text = isTPEnabled and "✓ Click TP: ON" or "Click TP: OFF"
    TPToggle.BackgroundColor3 = isTPEnabled and COLOR_ACTIVE or COLOR_INACTIVE
end)
TPToggle.LayoutOrder = 6

-- COMBAT SECTION
createLabel(ScrollingFrame, "⚔️ COMBAT").LayoutOrder = 10

local FlingBtn = createButton(ScrollingFrame, "FlingBtn", "👾 FLING", function()
    -- Выбираем ближайшего врага
    local nearest = nil
    local maxDist = math.huge
    local myPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if myPos then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local pPos = p.Character:FindFirstChild("HumanoidRootPart")
                if pPos then
                    local dist = (myPos.Position - pPos.Position).Magnitude
                    if dist < maxDist then
                        maxDist = dist
                        nearest = p
                    end
                end
            end
        end
    end
    
    if nearest then
        superFlingPlayer(nearest)
    end
end)
FlingBtn.LayoutOrder = 11
FlingBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 255)

local ToolsBtn = createButton(ScrollingFrame, "ToolsBtn", "🎒 GIVE TOOLS", function()
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
ToolsBtn.LayoutOrder = 12
ToolsBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 255)

-- VISION SECTION
createLabel(ScrollingFrame, "👁️ VISION").LayoutOrder = 20

local ESPToggle = createButton(ScrollingFrame, "ESPToggle", "ESP: OFF", function()
    isESPEnabled = not isESPEnabled
    ESPToggle.Text = isESPEnabled and "✓ ESP: ON" or "ESP: OFF"
    ESPToggle.BackgroundColor3 = isESPEnabled and COLOR_ACTIVE or COLOR_INACTIVE
end)
ESPToggle.LayoutOrder = 21

-- AIM SECTION
createLabel(ScrollingFrame, "🎯 SILENT AIM").LayoutOrder = 30

local SilentAimToggle = createButton(ScrollingFrame, "SilentAimToggle", "Aim: OFF", function()
    isSilentAimEnabled = not isSilentAimEnabled
    SilentAimToggle.Text = isSilentAimEnabled and "✓ Aim: ON" or "Aim: OFF"
    SilentAimToggle.BackgroundColor3 = isSilentAimEnabled and COLOR_ACTIVE or COLOR_INACTIVE
end)
SilentAimToggle.LayoutOrder = 31

local FOVLabel = createLabel(ScrollingFrame, "FOV: 200")
FOVLabel.LayoutOrder = 32

local FOVInput = createTextBox(ScrollingFrame, "200")
FOVInput.LayoutOrder = 33
FOVInput.FocusLost:Connect(function()
    local num = tonumber(FOVInput.Text)
    if num then
        silentAimFOV = num
        FOVLabel.Text = "FOV: " .. num
    end
end)

-- PLAYERS SECTION
createLabel(ScrollingFrame, "👾 PLAYERS").LayoutOrder = 40

local PlayersScrollFrame = Instance.new("ScrollingFrame")
PlayersScrollFrame.Parent = ScrollingFrame
PlayersScrollFrame.Size = UDim2.new(0, 650, 0, 150)
PlayersScrollFrame.BackgroundTransparency = 1
PlayersScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayersScrollFrame.ScrollBarThickness = 3
PlayersScrollFrame.LayoutOrder = 41

local PlayersLayout = Instance.new("UIListLayout")
PlayersLayout.Parent = PlayersScrollFrame
PlayersLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayersLayout.Padding = UDim.new(0, 5)

-- MINIMIZE / CLOSE LOGIC
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        -- Сворачиваем в маленький квадратик
        MainFrame.Size = UDim2.new(0, 150, 0, 50)
        MainFrame.Position = UDim2.new(0.5, -75, 0.5, -25)
        TabContainer.Visible = false
        Title.Text = "⚡ HUB"
    else
        -- Разворачиваем обратно
        MainFrame.Size = UDim2.new(0, 700, 0, 400)
        MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
        TabContainer.Visible = true
        Title.Text = "⚡ PURPLE HUB ⚡"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame:Destroy()
end)

-- FLING УЛУЧШЕННЫЙ
local function superFlingPlayer(target)
    if not target or not target.Character then return end
    
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
    
    if not hrp or not hum or not tHrp then return end
    
    local oldCFrame = hrp.CFrame
    local oldVel = hrp.AssemblyLinearVelocity
    
    -- Отключаем физику
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    
    -- Отключаем коллизии
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    
    for _, part in pairs(target.Character:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    
    -- Мощный флинг
    hrp.CFrame = tHrp.CFrame
    
    for i = 1, 50 do
        if not tHrp or not tHrp.Parent then break end
        
        -- ОЧЕНЬ МОЩНАЯ скорость
        tHrp.AssemblyLinearVelocity = Vector3.new(math.random(-500, 500), math.random(300, 500), math.random(-500, 500)) * 100
        tHrp.AssemblyAngularVelocity = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
        
        task.wait(0.01)
    end
    
    -- Восстанавливаем
    if tHrp then
        tHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        tHrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
    
    hrp.CFrame = oldCFrame
    hrp.AssemblyLinearVelocity = oldVel
    
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = true end
    end
    
    if target.Character then
        for _, part in pairs(target.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- ESP СИСТЕМА
local function createESP(player_obj)
    if not player_obj.Character then return end
    
    local hrp = player_obj.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. player_obj.Name
    billboard.Size = UDim2.new(4, 0, 5, 0)
    billboard.MaxDistance = math.huge
    billboard.Parent = hrp
    
    local frame = Instance.new("Frame")
    frame.Parent = billboard
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = frame
    textLabel.Size = UDim2.new(1, 0, 0.3, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player_obj.DisplayName
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    
    return billboard
end

-- UPDATE PLAYERS LIST
local function updatePlayersList()
    for _, child in pairs(PlayersScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local pBtn = Instance.new("TextButton")
            pBtn.Parent = PlayersScrollFrame
            pBtn.Size = UDim2.new(1, -10, 0, 35)
            pBtn.BackgroundColor3 = COLOR_INACTIVE
            pBtn.Text = "👤 " .. p.DisplayName
            pBtn.TextColor3 = COLOR_TEXT
            pBtn.TextSize = 11
            pBtn.Font = Enum.Font.Gotham
            pBtn.BorderSizePixel = 0
            pBtn.AutoButtonColor = false
            
            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(0, 6)
            pCorner.Parent = pBtn
            
            pBtn.MouseButton1Click:Connect(function()
                pBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
                pBtn.Text = "💥 FLING!"
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
    
    PlayersScrollFrame.CanvasSize = UDim2.new(0, 0, 0, PlayersLayout.AbsoluteContentSize.Y + 10)
end

-- CLICK TELEPORT
mouse.Button1Down:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if isTPEnabled and hrp and mouse.Target then
        hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z)
    end
end)

-- HEARTBEAT
game:GetService("RunService").Heartbeat:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    -- SPEED
    if isSpeedEnabled and hum and hum.WalkSpeed ~= currentSpeedValue then
        hum.WalkSpeed = currentSpeedValue
    end
    
    -- FLY
    if isFlyEnabled and hrp and hrp:FindFirstChild("UIFlyForce") then
        local flySpeedNum = flySpeed
        if hum and hum.MoveDirection.Magnitude > 0 then
            hrp.UIFlyForce.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeedNum
        else
            hrp.UIFlyForce.Velocity = Vector3.new(0, 0, 0)
        end
    end
    
    -- NOCLIP
    if isNoclipEnabled and char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end
    
    -- ESP
    if isESPEnabled then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hrp_p = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp_p and not hrp_p:FindFirstChild("ESP_" .. p.Name) then
                    createESP(p)
                end
            end
        end
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character then
                local hrp_p = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp_p then
                    local esp = hrp_p:FindFirstChild("ESP_" .. p.Name)
                    if esp then esp:Destroy() end
                end
            end
        end
    end
    
    -- SILENT AIM
    if isSilentAimEnabled and hrp then
        local nearest = nil
        local minDist = silentAimFOV
        local screenPos = workspace.CurrentCamera:WorldToScreenPoint(hrp.Position)
        
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local pHrp = p.Character:FindFirstChild("HumanoidRootPart")
                if pHrp then
                    local pScreen = workspace.CurrentCamera:WorldToScreenPoint(pHrp.Position)
                    local dist = math.sqrt((screenPos.X - pScreen.X)^2 + (screenPos.Y - pScreen.Y)^2)
                    
                    if dist < minDist then
                        minDist = dist
                        nearest = p
                    end
                end
            end
        end
        
        silentAimTarget = nearest
    end
end)

-- PLAYER EVENTS
game.Players.PlayerAdded:Connect(updatePlayersList)
game.Players.PlayerRemoving:Connect(updatePlayersList)

updatePlayersList()
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
