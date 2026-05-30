local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Prevent multiple GUIs
if LocalPlayer.PlayerGui:FindFirstChild("SpeedDetector") then
    LocalPlayer.PlayerGui.SpeedDetector:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedDetector"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 260, 0, 300)
label.Position = UDim2.new(0, 10, 0, 100)
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 0.4
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.TextSize = 15
label.TextColor3 = Color3.new(1, 1, 1)
label.Text = "Speed Detector Loading..."
label.Font = Enum.Font.Gotham
label.Active = true
label.Parent = gui

-- Simple Drag System
local dragging = false
local dragStart
local startPos

label.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = label.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        label.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Main Loop (Safe Version)
RunService.Heartbeat:Connect(function()
    pcall(function()
        local output = "=== Speed Detector ===\n\n"

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChild("Humanoid")

                if root and hum then
                    local vel = root.Velocity or root.AssemblyLinearVelocity
                    
                    -- Safe speed calculation (works better on old clients)
                    local speed = math.floor(
                        Vector3.new(vel.X, 0, vel.Z).Magnitude
                    )

                    if speed < 12 then
                        speed = 0
                    end

                    output = output .. plr.Name .. " | " .. speed

                    if speed > 35 then
                        output = output .. "  [FAST]"
                    elseif speed > 20 then
                        output = output .. "  [MOVING]"
                    end

                    output = output .. "\n"
                end
            end
        end

        label.Text = output
    end)
end)

print("Speed Detector Fixed & Loaded")
