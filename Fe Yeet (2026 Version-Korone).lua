-- Fe Yeet (2026 v6) - Blatant Void Fling
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local function gplr(String)
    local Found = {}
    local strl = String:lower()
    for _, v in ipairs(Players:GetPlayers()) do
        if strl == "all" then
            table.insert(Found, v)
        elseif strl == "others" and v ~= lp then
            table.insert(Found, v)
        elseif strl == "me" and v == lp then
            table.insert(Found, v)
        elseif v.Name:lower():sub(1, #strl) == strl or v.DisplayName:lower():sub(1, #strl) == strl then
            table.insert(Found, v)
        end
    end
    return Found
end

-- GUI
local h = Instance.new("ScreenGui", game.CoreGui)
h.ResetOnSpawn = false

local Main = Instance.new("Frame", h)
Main.Size = UDim2.new(0, 320, 0, 200)
Main.Position = UDim2.new(0.2, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Loop Yeet 2026 - Void Fling"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local TextBox = Instance.new("TextBox", Main)
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 45)
TextBox.PlaceholderText = "Target name... (all / others)"
TextBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(1, -20, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 95)
ToggleBtn.Text = "Loop: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 15
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local looping = false
local connection = nil
local originalCFrame = nil

local function yeet(target)
    if not target or not target.Character then return end
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local myChar = lp.Character
    if not myChar then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP or not myHRP then return end

    -- Position slightly below target
    myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, -2.5, 0)

    -- Massive upward + forward velocity for void launch
    local direction = (targetHRP.Position - myHRP.Position).Unit
    local strongVelocity = direction * 650 + Vector3.new(0, 220, 0)  -- High up for void fall

    myHRP.AssemblyLinearVelocity = strongVelocity
    myHRP.Velocity = strongVelocity

    -- BodyVelocity for extra power
    local bv = Instance.new("BodyVelocity")
    bv.Name = "YeetBV"
    bv.MaxForce = Vector3.new(400000, 400000, 400000)
    bv.Velocity = strongVelocity * 1.3
    bv.Parent = myHRP

    task.delay(0.22, function()
        pcall(function() bv:Destroy() end)
    end)
end

ToggleBtn.MouseButton1Click:Connect(function()
    looping = not looping

    if looping then
        local myChar = lp.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            originalCFrame = myChar.HumanoidRootPart.CFrame
        end

        ToggleBtn.Text = "Loop: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

        connection = RunService.Heartbeat:Connect(function()
            if not looping then return end
            local targets = gplr(TextBox.Text)
            for _, target in ipairs(targets) do
                if target and target ~= lp and target.Character then
                    pcall(yeet, target)
                end
            end
        end)
    else
        ToggleBtn.Text = "Loop: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)

        if connection then
            connection:Disconnect()
            connection = nil
        end

        -- Cleanup + return
        if originalCFrame then
            local myChar = lp.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myChar.HumanoidRootPart.CFrame = originalCFrame
                myChar.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
                myChar.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end
    end
end)

print("✅ Fe Yeet 2026 v6 - Blatant Void Fling Loaded")

