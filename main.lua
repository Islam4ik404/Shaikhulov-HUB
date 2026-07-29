-- 🔷 SHAIKHULOV HUB - YZHE_STARUY Edition
-- Premium UI + Все вкладки + Vega X Fling + Fake Ban

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- ===== ФЕЙК-БАН ДЛЯ DRAGON_CAMELoN735 =====
if player.Name == "DRAGON_CAMELoN735" then
    task.wait(3)
    local fb = Instance.new("ScreenGui")
    fb.Parent = player:WaitForChild("PlayerGui")
    fb.ResetOnSpawn = false
    fb.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fb.DisplayOrder = 999
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.6
    bg.Parent = fb
    
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, 360, 0, 230)
    box.Position = UDim2.new(0.5, -180, 0.5, -115)
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.BorderSizePixel = 0
    box.Parent = fb
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 35)
    bar.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    bar.Parent = box
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 12)
    
    local tt = Instance.new("TextLabel")
    tt.Size = UDim2.new(1, -20, 1, 0)
    tt.Position = UDim2.new(0, 10, 0, 0)
    tt.Text = "🚫 ДОСТУП ЗАБЛОКИРОВАН"
    tt.TextColor3 = Color3.fromRGB(255, 255, 255)
    tt.BackgroundTransparency = 1
    tt.Font = Enum.Font.GothamBold
    tt.TextSize = 15
    tt.TextXAlignment = Enum.TextXAlignment.Left
    tt.Parent = bar
    
    local et = Instance.new("TextLabel")
    et.Size = UDim2.new(0, 320, 0, 110)
    et.Position = UDim2.new(0.5, -160, 0, 55)
    et.Text = "АККАУНТ ЗАБЛОКИРОВАН\n\n• Причина: Soft Ban\n• Нарушение: Стороннее ПО\n• Блокировка: НАВСЕГДА\n\nОбратитесь в поддержку:\nroblox.com/support"
    et.TextColor3 = Color3.fromRGB(200, 200, 200)
    et.BackgroundTransparency = 1
    et.Font = Enum.Font.Gotham
    et.TextSize = 13
    et.TextXAlignment = Enum.TextXAlignment.Center
    et.TextYAlignment = Enum.TextYAlignment.Top
    et.TextWrapped = true
    et.Parent = box
    
    local ok = Instance.new("TextButton")
    ok.Size = UDim2.new(0, 120, 0, 35)
    ok.Position = UDim2.new(0.5, -60, 0, 180)
    ok.Text = "ПОНЯТНО"
    ok.TextColor3 = Color3.fromRGB(255, 255, 255)
    ok.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    ok.Font = Enum.Font.GothamBold
    ok.TextSize = 13
    ok.Parent = box
    Instance.new("UICorner", ok).CornerRadius = UDim.new(0, 8)
    
    ok.MouseButton1Click:Connect(function()
        player:Kick("Вы забанены. Причина: Soft Ban")
    end)
    
    local blocker = Instance.new("Frame")
    blocker.Size = UDim2.new(1, 0, 1, 0)
    blocker.BackgroundTransparency = 1
    blocker.ZIndex = 998
    blocker.Active = true
    blocker.Parent = fb
    
    return
end

-- ===== ОПРЕДЕЛЕНИЕ ИГРЫ =====
local GameNames = {
    [142823291] = {name = "🔪 MM2", short = "MM2"},
    [537413528] = {name = "🚢 Boat", short = "Boat"},
    [286090429] = {name = "🔫 Arsenal", short = "Ars"},
    [4924922222] = {name = "🏠 Brook", short = "Brk"},
}
local currentGame = GameNames[game.PlaceId] or {name = "🎮 Игра", short = "Gm"}
local isMM2 = (game.PlaceId == 142823291)
local isBoat = (game.PlaceId == 537413528)

-- ===== ЦВЕТОВАЯ СХЕМА (СИНЯЯ) =====
local C = {
    BG = Color3.fromRGB(8, 12, 25),
    Frame = Color3.fromRGB(12, 18, 38),
    Frame2 = Color3.fromRGB(18, 25, 50),
    Accent = Color3.fromRGB(0, 120, 255),
    Accent2 = Color3.fromRGB(0, 80, 200),
    Green = Color3.fromRGB(0, 200, 100),
    Red = Color3.fromRGB(255, 50, 50),
    Gold = Color3.fromRGB(255, 200, 0),
    White = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(180, 200, 240),
    Text2 = Color3.fromRGB(140, 160, 200),
    MR = Color3.fromRGB(255, 30, 30),
    SB = Color3.fromRGB(30, 100, 255),
    IW = Color3.fromRGB(255, 255, 255),
}

-- ===== ФУНКЦИИ =====
local F = {
    ESP = {on = true, obj = {}},
    Speed = {on = false, val = 100},
    InfJump = {on = false},
    Noclip = {on = false},
    ClickTP = {on = false},
    RGB = {on = false},
    FlingMurder = {on = false},
    GunTP = {on = false},
    Sky = "Default",
    AutoBuild = {on = false, bld = false},
    FlingAll = {on = false},
    FlingPower = 50000,
    Target = nil
}

-- ===== ГЛАВНЫЙ GUI (УЛУЧШЕННЫЙ) =====
local Gui = Instance.new("ScreenGui")
Gui.Parent = game.CoreGui
Gui.Name = "ShaikhulovHUB"

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 240, 0, 310)
Main.Position = UDim2.new(0.5, -120, 0.3, -155)
Main.BackgroundColor3 = C.BG
Main.BorderSizePixel = 0
Main.Parent = Gui
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = C.Accent

-- Заголовок
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = C.Frame
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HTitle = Instance.new("TextLabel")
HTitle.Size = UDim2.new(0, 180, 1, 0)
HTitle.Position = UDim2.new(0, 10, 0, 0)
HTitle.Text = "🔷 SHAIKHULOV HUB"
HTitle.TextColor3 = C.Accent
HTitle.BackgroundTransparency = 1
HTitle.Font = Enum.Font.GothamBold
HTitle.TextSize = 12
HTitle.TextXAlignment = Enum.TextXAlignment.Left
HTitle.Parent = Header

-- Кнопка сворачивания
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -32, 0, 1)
MinBtn.Text = "—"
MinBtn.TextColor3 = C.White
MinBtn.BackgroundColor3 = C.Frame2
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- ===== ВКЛАДКИ =====
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 26)
TabBar.Position = UDim2.new(0, 0, 0, 32)
TabBar.BackgroundColor3 = C.Frame
TabBar.Parent = Main

local Tabs = {}
local CurTab = "Universal"

local function MakeTab(name, text, x)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 58, 1, -2)
    btn.Position = UDim2.new(0, x, 0, 1)
    btn.Text = text
    btn.TextColor3 = C.White
    btn.BackgroundColor3 = C.Frame2
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 9
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(function()
        CurTab = name
        for _, b in pairs(Tabs) do b.BackgroundColor3 = C.Frame2 end
        btn.BackgroundColor3 = C.Accent2
        Update()
    end)
    Tabs[name] = btn
    return btn
end

MakeTab("Universal", "⚔️ Унив", 2).BackgroundColor3 = C.Accent2
MakeTab("Players", "👥 Игроки", 62)
MakeTab("Game", currentGame.short, 122)
MakeTab("Settings", "⚙️ Настр", 182)

-- Контент
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -8, 1, -62)
Content.Position = UDim2.new(0, 4, 0, 60)
Content.BackgroundColor3 = C.Frame
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -8, 1, -8)
Scroll.Position = UDim2.new(0, 4, 0, 4)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = C.Accent
Scroll.Parent = Content

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0, 3)
List.Parent = Scroll

-- ===== КУБИК =====
local Cube = Instance.new("TextButton")
Cube.Size = UDim2.new(0, 42, 0, 42)
Cube.Position = UDim2.new(0.5, -21, 0.35, -21)
Cube.BackgroundColor3 = C.Accent
Cube.BorderSizePixel = 0
Cube.Text = "🔷"
Cube.TextColor3 = C.White
Cube.TextSize = 22
Cube.Parent = Gui
Cube.Visible = false
Cube.Active = true
Cube.Draggable = true
Instance.new("UICorner", Cube).CornerRadius = UDim.new(0, 10)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false; Cube.Visible = true
end)
Cube.MouseButton1Click:Connect(function()
    Cube.Visible = false; Main.Visible = true
end)

-- Shoot Murder кнопка
local ShootBtn = Instance.new("TextButton")
ShootBtn.Size = UDim2.new(0, 135, 0, 42)
ShootBtn.Position = UDim2.new(0.8, -67, 0.7, -21)
ShootBtn.BackgroundColor3 = C.Red
ShootBtn.BorderSizePixel = 0
ShootBtn.Text = "🔫 Shoot Murder"
ShootBtn.TextColor3 = C.White
ShootBtn.Font = Enum.Font.GothamBold
ShootBtn.TextSize = 13
ShootBtn.Parent = Gui
ShootBtn.Visible = isMM2
ShootBtn.Active = true
ShootBtn.Draggable = true
ShootBtn.ZIndex = 10
Instance.new("UICorner", ShootBtn).CornerRadius = UDim.new(0, 8)

-- Уведомления
function Notify(text, clr)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0, 230, 0, 32)
    n.Position = UDim2.new(0.5, -115, 0.12, 0)
    n.Text = text
    n.TextColor3 = clr or C.White
    n.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    n.BackgroundTransparency = 0.25
    n.Font = Enum.Font.GothamBold
    n.TextSize = 13
    n.ZIndex = 20
    n.Parent = Gui
    Instance.new("UICorner", n).CornerRadius = UDim.new(0, 6)
    
    task.spawn(function()
        for i = 1, 12 do
            n.Position += UDim2.new(0, 0, -0.003, 0)
            n.BackgroundTransparency += 0.06
            n.TextTransparency += 0.08
            task.wait(0.03)
        end
        n:Destroy()
    end)
end

-- ===== VEGA X FLING =====
local function VegaFling(target)
    local ch = player.Character
    if not ch then return end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    local tc = target.Character
    if not tc then return end
    local th = tc:FindFirstChild("HumanoidRootPart")
    local tm = tc:FindFirstChildOfClass("Humanoid")
    if not th or not tm then return end
    
    local old = hrp.CFrame
    local pw = F.FlingPower
    
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    for _, p in pairs(ch:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end
    
    for i = 1, 12 do
        if not th or not th.Parent then break end
        hrp.CFrame = th.CFrame * CFrame.new(math.random(-3,3), math.random(-2,2), math.random(-3,3))
        hrp.Velocity = Vector3.new(math.random(-pw,pw), math.random(pw/2,pw), math.random(-pw,pw))
        hrp.RotVelocity = Vector3.new(math.random(-pw,pw), math.random(-pw,pw), math.random(-pw,pw))
        if tm.Health > 0 then tm.Health = math.max(tm.Health - 10, 0) end
        task.wait(0.02)
    end
    
    hrp.Velocity = Vector3.zero; hrp.RotVelocity = Vector3.zero
    hrp.CFrame = old
    hum:ChangeState(Enum.HumanoidStateType.Running)
    for _, p in pairs(ch:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = true end end
end

-- ESP
local function GetRole(plr)
    local ch = plr.Character
    if not ch then return "Мёртв", C.IW end
    local hm = ch:FindFirstChildOfClass("Humanoid")
    if hm and hm.Health <= 0 then return "Мёртв", C.IW end
    for _, obj in pairs(ch:GetChildren()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("knife") or n:find("нож") or n:find("murder") then return "🔪 УБИЙЦА", C.MR end
            if n:find("gun") or n:find("пистолет") or n:find("sheriff") then return "⭐ ШЕРИФ", C.SB end
        end
    end
    return "👤 Мирный", C.IW
end

-- Gun TP
local function GunTP()
    local ch = player.Character
    if not ch then return end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("пистолет")) then
            local h = obj:FindFirstChild("Handle")
            if h and obj.Parent ~= player.Backpack then
                local old = hrp.CFrame
                hrp.CFrame = h.CFrame; task.wait(0.1)
                obj.Parent = player.Backpack; task.wait(0.1)
                hrp.CFrame = old
                return
            end
        end
    end
end

-- Shoot Murder
local function ShootMurder()
    local ch = player.Character
    if not ch then return end
    local gun = nil
    for _, t in pairs(player.Backpack:GetChildren()) do
        if t:IsA("Tool") and (t.Name:lower():find("gun") or t.Name:lower():find("пистолет")) then gun = t; break end
    end
    if not gun then Notify("❌ Вам нужен пистолет!", C.Red); return end
    
    local murd = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local t = p.Character:FindFirstChildOfClass("Tool")
            if t and (t.Name:lower():find("knife") or t.Name:lower():find("нож")) then murd = p; break end
        end
    end
    if not murd then Notify("🔍 Убийца не найден!", C.Gold); return end
    
    local hm = ch:FindFirstChildOfClass("Humanoid")
    if hm and gun then hm:EquipTool(gun); task.wait(0.1) end
    if gun then gun:Activate() end
    
    local tm = murd.Character and murd.Character:FindFirstChildOfClass("Humanoid")
    if tm then tm.Health = math.max(tm.Health - 50, 0) end
    Notify("💥 Убийца под атакой!", C.Green)
end
ShootBtn.MouseButton1Click:Connect(ShootMurder)

-- Give Tools
local function GiveTools()
    local bp = player:FindFirstChild("Backpack")
    if not bp then return 0 end
    local n = 0
    for _, src in pairs({game.ReplicatedStorage, game.Lighting, game.ServerStorage, workspace}) do
        for _, obj in pairs(src:GetDescendants()) do
            if (obj:IsA("Tool") or obj:IsA("HopperBin")) and not bp:FindFirstChild(obj.Name) then
                obj:Clone().Parent = bp; n += 1
            end
        end
    end
    return n
end

-- Auto Build
local function Build()
    if F.AutoBuild.bld then return end
    F.AutoBuild.bld = true
    local ch = player.Character
    if not ch then F.AutoBuild.bld = false; return end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if not hrp then F.AutoBuild.bld = false; return end
    
    local blk = {}
    for _, it in pairs(player.Backpack:GetChildren()) do
        if it:IsA("Tool") and it:FindFirstChild("Handle") then table.insert(blk, it) end
    end
    if #blk == 0 then F.AutoBuild.bld = false; Notify("❌ Нет блоков!", C.Red); return end
    
    Notify("🏗️ Строим " .. #blk .. " блоков...", C.Accent)
    local sp = hrp.Position + hrp.CFrame.LookVector * 8 + Vector3.new(0, 3, 0)
    local cols = math.ceil(math.sqrt(#blk))
    
    for i, bl in ipairs(blk) do
        if not F.AutoBuild.bld then break end
        local cl = bl:Clone(); cl.Parent = workspace
        local h = cl:FindFirstChild("Handle")
        if h then
            h.CFrame = CFrame.new(sp + Vector3.new(((i-1)%cols)*4, 0, math.floor((i-1)/cols)*4))
            h.Anchored = true
        end
        if i % 20 == 0 then task.wait(0.05) end
    end
    F.AutoBuild.bld = false
    Notify("✅ Готово!", C.Green)
end

-- Sky
function ApplySky(id)
    local l = game.Lighting
    for _, c in pairs(l:GetChildren()) do if c:IsA("Sky") then c:Destroy() end end
    if id == "night" then l.ClockTime = 0; l.Brightness = 0.5
    elseif id == "day" then l.ClockTime = 12; l.Brightness = 2
    elseif id == "sunset" then l.ClockTime = 18; l.Brightness = 1.5
    elseif id == "blue" then l.Ambient = Color3.fromRGB(50, 100, 255)
    elseif id == "purple" then l.Ambient = Color3.fromRGB(150, 50, 255)
    elseif id == "red" then l.Ambient = Color3.fromRGB(255, 50, 50)
    else l.Ambient = Color3.fromRGB(127,127,127); l.Brightness = 2; l.ClockTime = 14 end
end

-- ===== КНОПКА =====
local function Btn(text, func)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 26)
    b.Text = text
    b.TextColor3 = C.White
    b.BackgroundColor3 = C.Frame2
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.Parent = Scroll
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    b.MouseButton1Click:Connect(func)
    return b
end

local function Label(text, clr)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -4, 0, 16)
    l.Text = text
    l.TextColor3 = clr or C.Text2
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextSize = 9
    l.Parent = Scroll
    return l
end

-- ===== ОБНОВЛЕНИЕ =====
function Update()
    for _, c in pairs(Scroll:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
    Tabs["Game"].Text = currentGame.short
    
    if CurTab == "Universal" then
        Label("⚔️ УНИВЕРСАЛЬНЫЕ", C.Accent)
        Btn("🏃 Speed: " .. (F.Speed.on and "ON" or "OFF"), function() F.Speed.on = not F.Speed.on; Update() end)
        Btn("🦘 Inf Jump: " .. (F.InfJump.on and "ON" or "OFF"), function() F.InfJump.on = not F.InfJump.on; Update() end)
        Btn("👻 Noclip: " .. (F.Noclip.on and "ON" or "OFF"), function() F.Noclip.on = not F.Noclip.on; Update() end)
        Btn("📍 Click TP: " .. (F.ClickTP.on and "ON" or "OFF"), function() F.ClickTP.on = not F.ClickTP.on; Update() end)
        Btn("🌈 RGB: " .. (F.RGB.on and "ON" or "OFF"), function() F.RGB.on = not F.RGB.on; Update() end)
        Btn("💥 Fling All: " .. (F.FlingAll.on and "ON" or "OFF"), function() F.FlingAll.on = not F.FlingAll.on; Update() end)
        Btn("🎒 Give All Tools", function() Notify("✅ " .. GiveTools() .. " инструментов!", C.Green) end)
        
        Label("Сила флинга: " .. F.FlingPower, C.Text)
        local inp = Instance.new("TextBox")
        inp.Size = UDim2.new(1, -4, 0, 22)
        inp.Text = tostring(F.FlingPower)
        inp.TextColor3 = C.White
        inp.BackgroundColor3 = C.Frame2
        inp.Font = Enum.Font.Gotham
        inp.TextSize = 10
        inp.Parent = Scroll
        Instance.new("UICorner", inp).CornerRadius = UDim.new(0, 4)
        inp.FocusLost:Connect(function()
            local v = tonumber(inp.Text)
            if v and v > 0 then F.FlingPower = v; Update() end
        end)
        
    elseif CurTab == "Players" then
        Label("👥 ВЫБОР ИГРОКА", C.Accent)
        Label("🎯 Цель: " .. (F.Target or "Нет"), C.Gold)
        
        Btn("💥 FLING ВЫБРАННОГО", function()
            if F.Target then
                local t = Players:FindFirstChild(F.Target)
                if t then VegaFling(t); Notify("💥 " .. t.DisplayName .. " зафлингован!", C.Red)
                else Notify("❌ Игрок не найден!", C.Red) end
            else Notify("❌ Выбери игрока!", C.Red) end
        end)
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then
                local pb = Instance.new("TextButton")
                pb.Size = UDim2.new(1, -4, 0, 24)
                pb.Text = p.DisplayName .. " (@" .. p.Name .. ")"
                pb.TextColor3 = C.White
                pb.BackgroundColor3 = (F.Target == p.Name) and C.Accent2 or C.Frame2
                pb.Font = Enum.Font.Gotham
                pb.TextSize = 9
                pb.Parent = Scroll
                Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 4)
                pb.MouseButton1Click:Connect(function()
                    F.Target = p.Name
                    Notify("🎯 Выбран: " .. p.DisplayName, C.Accent)
                    Update()
                end)
            end
        end
        
    elseif CurTab == "Game" then
        if isMM2 then
            Label("🔪 MURDER MYSTERY 2", C.MR)
            Btn("👁️ ESP: " .. (F.ESP.on and "ON" or "OFF"), function() F.ESP.on = not F.ESP.on; Update() end)
            Btn("💨 Fling Murder: " .. (F.FlingMurder.on and "ON" or "OFF"), function() F.FlingMurder.on = not F.FlingMurder.on; Update() end)
            Btn("🔫 Gun TP: " .. (F.GunTP.on and "ON" or "OFF"), function() F.GunTP.on = not F.GunTP.on; Update() end)
            Label("🔴 Убийца = красный", C.MR)
            Label("🔵 Шериф = синий", C.SB)
        elseif isBoat then
            Label("🚢 BUILD A BOAT", C.Gold)
            local bb = Btn(F.AutoBuild.bld and "🔄 СТРОИМ..." or "🚢 АВТО-ПОСТРОЙКА", function()
                if not F.AutoBuild.bld then F.AutoBuild.bld = true; task.spawn(function() Build(); Update() end)
                else F.AutoBuild.bld = false end
                Update()
            end)
            bb.BackgroundColor3 = F.AutoBuild.bld and C.Gold or C.Green
        else
            Label("⏳ Скоро!..", C.Gold)
        end
        
    elseif CurTab == "Settings" then
        Label("⚙️ НАСТРОЙКИ", C.Accent)
        Label("🌅 Небо:", C.Text)
        for _, s in pairs({{"🌙 Ночь","night"},{"☀️ День","day"},{"🌅 Закат","sunset"},{"🟦 Синий","blue"},{"🟪 Фиолет","purple"},{"🟥 Красный","red"},{"⬜ Стандарт","default"}}) do
            local sb = Btn(s[1], function() F.Sky = s[2]; ApplySky(s[2]); Update() end)
            if F.Sky == s[2] then sb.BackgroundColor3 = C.Accent2 end
        end
        Label("", C.Text)
        Label("👤 СОЗДАТЕЛЬ:", C.Text)
        Label("YZHE_STARUY", C.Gold)
    end
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 8)
end

-- ===== ЦИКЛЫ =====
RunService.RenderStepped:Connect(function()
    if not F.ESP.on or not isMM2 then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            if not F.ESP.obj[p] then
                local bx = Drawing.new("Square"); bx.Thickness = 2; bx.Filled = false
                local nm = Drawing.new("Text"); nm.Size = 12; nm.Center = true; nm.Outline = true
                local rl = Drawing.new("Text"); rl.Size = 11; rl.Center = true; rl.Outline = true
                F.ESP.obj[p] = {b = bx, n = nm, r = rl}
            end
            local d = F.ESP.obj[p]
            local pos, on = camera:WorldToViewportPoint(hrp.Position)
            local role, clr = GetRole(p)
            if on then
                local s = 800 / math.max((camera.CFrame.Position - hrp.Position).Magnitude, 1)
                d.b.Visible = true; d.b.Size = Vector2.new(2.5*s, 4*s)
                d.b.Position = Vector2.new(pos.X-1.25*s, pos.Y-2*s); d.b.Color = clr
                d.n.Visible = true; d.n.Text = p.DisplayName; d.n.Position = Vector2.new(pos.X, pos.Y-2.2*s)
                d.r.Visible = true; d.r.Text = role; d.r.Color = clr; d.r.Position = Vector2.new(pos.X, pos.Y+2.2*s)
            else d.b.Visible = false; d.n.Visible = false; d.r.Visible = false end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local ch = player.Character
    if not ch then return end
    local hm = ch:FindFirstChildOfClass("Humanoid")
    
    if F.InfJump.on and hm then hm.JumpPower = 50 end
    if F.Noclip.on then for _, p in pairs(ch:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    if F.Speed.on and hm then hm.WalkSpeed = F.Speed.val end
    if F.RGB.on then
        local clr = Color3.fromHSV((tick()*200)%255/255, 1, 1)
        for _, p in pairs(ch:GetChildren()) do if p:IsA("BasePart") then p.Color = clr end end
    end
    if F.FlingAll.on then for _, p in pairs(Players:GetPlayers()) do if p ~= player then VegaFling(p) end end end
    
    if F.FlingMurder.on and isMM2 then
        local hrp = ch:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local th = p.Character:FindFirstChild("HumanoidRootPart")
                    if th and (th.Position - hrp.Position).Magnitude < 15 then
                        local role, _ = GetRole(p)
                        if role:find("УБИЙЦА") then VegaFling(p) end
                    end
                end
            end
        end
    end
    if F.GunTP.on and isMM2 then GunTP() end
end)

UIS.JumpRequest:Connect(function()
    if F.InfJump.on then
        local hm = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hm then hm:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

mouse.Button1Down:Connect(function()
    if F.ClickTP.on then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y+3, mouse.Hit.Z) end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if F.ESP.obj[p] then F.ESP.obj[p].b:Remove(); F.ESP.obj[p].n:Remove(); F.ESP.obj[p].r:Remove(); F.ESP.obj[p] = nil end
    if F.Target == p.Name then F.Target = nil end
end)

Update()
print("🔷 SHAIKHULOV HUB - YZHE_STARUY (Premium UI)")
print("💥 Vega X Fling | 😈 Fake Ban | 👥 Выбор игрока")
