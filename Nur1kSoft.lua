local _C = string.char -- Используем короткое имя для string.char
local _L = loadstring   -- Используем короткое имя для loadstring

local PASSWORD_CODES = {68, 79, 83, 65, 83, 65, 83, 65, 76, 73, 49, 50, 51}
local PASSWORD = ""
for i=1, #PASSWORD_CODES do PASSWORD = PASSWORD .. _C(PASSWORD_CODES[i]) end

local authenticated = false
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local function promptPassword()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PasswordPrompt"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui
    
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1,0,1,0)
    background.BackgroundColor3 = Color3.fromRGB(0,0,0)
    background.BackgroundTransparency = 0.65
    background.Parent = screenGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,0,0,0)
    frame.Position = UDim2.new(0.5,0,0.5,0)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = Color3.fromRGB(28,28,36)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,16)
    corner.Parent = frame
    
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0,480,0,280) }):Play()
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-30,0,60)
    title.Position = UDim2.new(0,15,0,15)
    title.BackgroundTransparency = 1
    title.Text = "🔒 Введите пароль"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 28
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    local inputContainer = Instance.new("Frame")
    inputContainer.Size = UDim2.new(1,-40,0,60)
    inputContainer.Position = UDim2.new(0,20,0,90)
    inputContainer.BackgroundTransparency = 1
    inputContainer.Parent = frame
    
    local inputBg = Instance.new("Frame")
    inputBg.Size = UDim2.new(1,0,1,0)
    inputBg.BackgroundColor3 = Color3.fromRGB(40,40,48)
    inputBg.BorderSizePixel = 0
    inputBg.Parent = inputContainer
    local inputBgCorner = Instance.new("UICorner")
    inputBgCorner.CornerRadius = UDim.new(0,12)
    inputBgCorner.Parent = inputBg
    
    local keySticker = Instance.new("TextLabel")
    keySticker.Size = UDim2.new(0,50,1,0)
    keySticker.Position = UDim2.new(0,8,0,0)
    keySticker.BackgroundTransparency = 1
    keySticker.Text = "🔑"
    keySticker.Font = Enum.Font.GothamSemibold
    keySticker.TextSize = 30
    keySticker.TextColor3 = Color3.fromRGB(255,255,255)
    keySticker.TextXAlignment = Enum.TextXAlignment.Center
    keySticker.TextYAlignment = Enum.TextYAlignment.Center
    keySticker.Parent = inputBg
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1,-80,1,0)
    textBox.Position = UDim2.new(0,70,0,0)
    textBox.BackgroundTransparency = 1
    textBox.TextColor3 = Color3.fromRGB(255,255,255)
    textBox.Font = Enum.Font.GothamBold
    textBox.TextSize = 18
    textBox.PlaceholderText = "Введите ваш пароль"
    textBox.ClearTextOnFocus = true
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Text = ""
    textBox.Parent = inputBg
    
    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(1,-40,0,60)
    submitBtn.Position = UDim2.new(0,20,0,180)
    submitBtn.BackgroundColor3 = Color3.fromRGB(0,165,245)
    submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 20
    submitBtn.Text = "✅ Подтвердить"
    submitBtn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,12)
    btnCorner.Parent = submitBtn
    
    local glow = Instance.new("UIStroke")
    glow.Color = Color3.fromRGB(120,200,255)
    glow.Thickness = 2
    glow.Parent = submitBtn
    
    submitBtn.MouseEnter:Connect(function()
        TweenService:Create(submitBtn, TweenInfo.new(0.18), { BackgroundColor3 = Color3.fromRGB(0,195,255) }):Play()
    end)
    submitBtn.MouseLeave:Connect(function()
        TweenService:Create(submitBtn, TweenInfo.new(0.18), { BackgroundColor3 = Color3.fromRGB(0,165,245) }):Play()
    end)
    
    local function checkPassword()
        if textBox.Text == PASSWORD then
            authenticated = true
            TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = UDim2.new(0,0,0,0) }):Play()
            task.wait(0.3)
            screenGui:Destroy()
        else
            textBox.Text = ""
            textBox.PlaceholderText = "❌ Неверный пароль"
            local shake = TweenService:Create(frame, TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 3, true), { Position = UDim2.new(0.5, -16, 0.5, 0) })
            shake:Play()
        end
    end
    
    submitBtn.MouseButton1Click:Connect(checkPassword)
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            checkPassword()
        end
    end)
end

promptPassword()

while not authenticated do
    task.wait()
end

local URL_CODES = {104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,78,117,114,49,107,83,99,114,112,47,78,117,114,49,107,45,83,99,114,105,112,116,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,78,117,114,49,107,37,50,48,83,99,114,105,112,116,46,108,117,97}
local url = ""
for i=1, #URL_CODES do url = url .. _C(URL_CODES[i]) end


local ok, source = pcall(function() return game:HttpGet(url) end)
if ok and source then
    local func, err = _L(source) -- Используем _L вместо loadstring
    if func then
        func()
    else
        warn("Ошибка запуска: "..tostring(err))
    end
else
    warn("Не удалось получить скрипт.")
end