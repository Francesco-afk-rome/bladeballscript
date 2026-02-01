local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

local autoParryEnabled = false
local isMinimized = false
local parryCount = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NIYE Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 0, 0)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 15)
TopFix.Position = UDim2.new(0, 0, 1, -15)
TopFix.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
TopFix.BorderSizePixel = 0
TopFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 180, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SOLRA HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0, 50, 0, 20)
Version.Position = UDim2.new(0, 15, 0.5, 5)
Version.BackgroundTransparency = 1
Version.Text = "v2.3"
Version.TextColor3 = Color3.fromRGB(200, 200, 200)
Version.TextSize = 10
Version.Font = Enum.Font.Code
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local function createToggle(name, posY, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.Position = UDim2.new(0, 0, 0, posY)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentFrame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame

    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Color3.fromRGB(60, 60, 70)
    ToggleStroke.Thickness = 1
    ToggleStroke.Parent = ToggleFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.65, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 55, 0, 26)
    ToggleButton.Position = UDim2.new(1, -65, 0.5, -13)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    ToggleButton.TextSize = 12
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = ToggleFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = ToggleButton

    local enabled = false
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = enabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(60, 60, 70),
            TextColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        })
        tween:Play()
        ToggleButton.Text = enabled and "ON" or "OFF"
        ToggleStroke.Color = enabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(60, 60, 70)
        callback(enabled)
    end)

    return ToggleButton, ToggleFrame
end

local autoParryBtn = createToggle("Auto Parry", 0, function(state)
    autoParryEnabled = state
end)

local TerminalFrame = Instance.new("Frame")
TerminalFrame.Size = UDim2.new(1, 0, 0, 140)
TerminalFrame.Position = UDim2.new(0, 0, 0, 55)
TerminalFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
TerminalFrame.BorderSizePixel = 0
TerminalFrame.Parent = ContentFrame

local TerminalCorner = Instance.new("UICorner")
TerminalCorner.CornerRadius = UDim.new(0, 8)
TerminalCorner.Parent = TerminalFrame

local TerminalStroke = Instance.new("UIStroke")
TerminalStroke.Color = Color3.fromRGB(180, 0, 0)
TerminalStroke.Thickness = 1
TerminalStroke.Parent = TerminalFrame

local TerminalHeader = Instance.new("TextLabel")
TerminalHeader.Size = UDim2.new(1, 0, 0, 20)
TerminalHeader.Position = UDim2.new(0, 0, 0, 5)
TerminalHeader.BackgroundTransparency = 1
TerminalHeader.Text = "  > TERMINAL_"
TerminalHeader.TextColor3 = Color3.fromRGB(180, 0, 0)
TerminalHeader.TextSize = 12
TerminalHeader.Font = Enum.Font.Code
TerminalHeader.TextXAlignment = Enum.TextXAlignment.Left
TerminalHeader.Parent = TerminalFrame

local TerminalText = Instance.new("TextLabel")
TerminalText.Size = UDim2.new(1, -20, 1, -30)
TerminalText.Position = UDim2.new(0, 10, 0, 25)
TerminalText.BackgroundTransparency = 1
TerminalText.Text = "[SYS] Initializing..."
TerminalText.TextColor3 = Color3.fromRGB(0, 255, 0)
TerminalText.TextSize = 11
TerminalText.Font = Enum.Font.Code
TerminalText.TextXAlignment = Enum.TextXAlignment.Left
TerminalText.TextYAlignment = Enum.TextYAlignment.Top
TerminalText.Parent = TerminalFrame

local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(1, 0, 0, 50)
StatsFrame.Position = UDim2.new(0, 0, 0, 205)
StatsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
StatsFrame.BorderSizePixel = 0
StatsFrame.Parent = ContentFrame

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 8)
StatsCorner.Parent = StatsFrame

local ParryCountLabel = Instance.new("TextLabel")
ParryCountLabel.Size = UDim2.new(0.5, 0, 1, 0)
ParryCountLabel.Position = UDim2.new(0, 0, 0, 0)
ParryCountLabel.BackgroundTransparency = 1
ParryCountLabel.Text = "Parrys\n0"
ParryCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ParryCountLabel.TextSize = 12
ParryCountLabel.Font = Enum.Font.GothamBold
ParryCountLabel.Parent = StatsFrame

local StatusIndicator = Instance.new("TextLabel")
StatusIndicator.Size = UDim2.new(0.5, 0, 1, 0)
StatusIndicator.Position = UDim2.new(0.5, 0, 0, 0)
StatusIndicator.BackgroundTransparency = 1
StatusIndicator.Text = "Status\nIDLE"
StatusIndicator.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusIndicator.TextSize = 12
StatusIndicator.Font = Enum.Font.GothamBold
StatusIndicator.Parent = StatsFrame

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Size = UDim2.new(1, 0, 0, 15)
DiscordLabel.Position = UDim2.new(0, 0, 1, -18)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "discord.gg/solra"
DiscordLabel.TextColor3 = Color3.fromRGB(180, 0, 0)
DiscordLabel.TextSize = 11
DiscordLabel.Font = Enum.Font.GothamBold
DiscordLabel.Parent = ContentFrame

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 280, 0, 45) or UDim2.new(0, 280, 0, 320)
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize})
    tween:Play()
    ContentFrame.Visible = not isMinimized
    MinimizeBtn.Text = isMinimized and "+" or "-"
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local function getBlockButton()
    local hotbar = player.PlayerGui:FindFirstChild("Hotbar")
    if hotbar then
        local block = hotbar:FindFirstChild("Block")
        if block then return block end
        local newBlock = hotbar:FindFirstChild("NewBlockButton")
        if newBlock then return newBlock end
    end
    return nil
end

local function parryOnce(blockBtn)
    if firesignal then
        pcall(function() firesignal(blockBtn.MouseButton1Click) end)
    end
    pcall(function()
        for _, connection in pairs(getconnections(blockBtn.MouseButton1Click)) do
            connection:Fire()
        end
    end)
    pcall(function()
        for _, connection in pairs(getconnections(blockBtn.Activated)) do
            connection:Fire()
        end
    end)
end

local function parryBurst()
    local blockBtn = getBlockButton()
    if not blockBtn then return end
    
    task.spawn(function()
        parryOnce(blockBtn)
        task.wait(0.05)
        parryOnce(blockBtn)
        task.wait(0.05)
        parryOnce(blockBtn)
        task.wait(0.05)
        parryOnce(blockBtn)
        task.wait(0.05)
        parryOnce(blockBtn)
    end)
    
    parryCount = parryCount + 1
    ParryCountLabel.Text = "Parrys\n" .. parryCount
end

local function getBall()
    local ballsFolder = workspace:FindFirstChild("Balls")
    if ballsFolder then
        for _, obj in pairs(ballsFolder:GetChildren()) do
            if obj:IsA("BasePart") then
                return obj
            elseif obj:IsA("Model") then
                local part = obj:FindFirstChildWhichIsA("BasePart")
                if part then return part end
            end
        end
    end
    return nil
end

local function checkAlive()
    local aliveFolder = workspace:FindFirstChild("Alive")
    if aliveFolder then
        return aliveFolder:FindFirstChild(player.Name) ~= nil
    end
    return true
end

local terminalLines = {}
local function updateTerminal(line)
    table.insert(terminalLines, line)
    if #terminalLines > 6 then
        table.remove(terminalLines, 1)
    end
    TerminalText.Text = table.concat(terminalLines, "\n")
end

updateTerminal("[SYS] NIYE Hub v2.3 loaded")
updateTerminal("[SYS] Target: Blade Ball")
updateTerminal("[SYS] Mode: BURST PARRY")
updateTerminal("[SYS] Bypass: ACTIVE")

local lastParryFrame = 0
local frameCounter = 0

RunService.Heartbeat:Connect(function()
    frameCounter = frameCounter + 1
    
    if not autoParryEnabled then 
        StatusIndicator.Text = "Status\nIDLE"
        StatusIndicator.TextColor3 = Color3.fromRGB(150, 150, 150)
        return 
    end
    
    if not humanoidRootPart or not character then return end
    
    if not checkAlive() then 
        StatusIndicator.Text = "Status\nDEAD"
        StatusIndicator.TextColor3 = Color3.fromRGB(255, 0, 0)
        return 
    end

    local ball = getBall()
    if not ball then 
        StatusIndicator.Text = "Status\nWAITING"
        StatusIndicator.TextColor3 = Color3.fromRGB(255, 165, 0)
        return 
    end

    local distance = (ball.Position - humanoidRootPart.Position).Magnitude
    local speed = ball.Velocity.Magnitude
    
    local parryDist = 28
    if speed > 400 then
        parryDist = 80
    elseif speed > 300 then
        parryDist = 65
    elseif speed > 200 then
        parryDist = 52
    elseif speed > 150 then
        parryDist = 42
    elseif speed > 100 then
        parryDist = 35
    end

    if distance <= parryDist and (frameCounter - lastParryFrame) > 3 then
        lastParryFrame = frameCounter
        parryBurst()
        StatusIndicator.Text = "Status\nPARRY!"
        StatusIndicator.TextColor3 = Color3.fromRGB(180, 0, 0)
        updateTerminal("[HIT] Burst @ " .. math.floor(distance) .. "m | SPD:" .. math.floor(speed))
    elseif distance <= parryDist then
        StatusIndicator.Text = "Status\nBURST"
        StatusIndicator.TextColor3 = Color3.fromRGB(255, 255, 0)
    else
        StatusIndicator.Text = "Status\nTRACKING"
        StatusIndicator.TextColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

print("NIYE HUB - Blade Ball BURST PARRY")
print("https://discord.gg/G3uZHDafhy")
