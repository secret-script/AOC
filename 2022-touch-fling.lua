local _UserInputService = game:GetService('UserInputService')

local function v17()
    local _ScreenGui = Instance.new('ScreenGui', game.Players.LocalPlayer.PlayerGui)
    local _Frame = Instance.new('Frame')

    _Frame.Size = UDim2.new(0, 200, 0, 120)
    _Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
    _Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    _Frame.Parent = _ScreenGui

    local _TextLabel = Instance.new('TextLabel')

    _TextLabel.Size = UDim2.new(0, 180, 0, 30)
    _TextLabel.Position = UDim2.new(0.5, -90, 0.5, -55)
    _TextLabel.Text = 'Fling GUI'
    _TextLabel.BackgroundTransparency = 1
    _TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextLabel.Parent = _Frame

    local _TextButton = Instance.new('TextButton')

    _TextButton.Size = UDim2.new(0, 180, 0, 30)
    _TextButton.Position = UDim2.new(0.5, -90, 0.5, -15)
    _TextButton.Text = 'Off'
    _TextButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    _TextButton.Parent = _Frame

    local _TextButton2 = Instance.new('TextButton')

    _TextButton2.Size = UDim2.new(0, 30, 0, 30)
    _TextButton2.Position = UDim2.new(0, 10, 1, -40)
    _TextButton2.Text = 'I'
    _TextButton2.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    _TextButton2.Parent = _ScreenGui

    local _TextLabel2 = Instance.new('TextLabel')

    _TextLabel2.Size = UDim2.new(0, 180, 0, 20)
    _TextLabel2.Position = UDim2.new(0.5, -90, 0.5, 25)
    _TextLabel2.Text = 'Credits: AOC'
    _TextLabel2.BackgroundTransparency = 1
    _TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextLabel2.Parent = _Frame

    local u8 = false
    local u9 = nil
    local u10 = nil

    local function v13(p11)
        if u8 then
            local v12 = p11.Position - u9

            _Frame.Position = UDim2.new(u10.X.Scale, u10.X.Offset + v12.X, u10.Y.Scale, u10.Y.Offset + v12.Y)
        end
    end
    local function v16(p14, p15)
        if not p15 then
            u8 = true
            u9 = p14.Position
            u10 = _Frame.Position

            p14.Changed:Connect(function()
                if p14.UserInputState == Enum.UserInputState.End then
                    u8 = false
                end
            end)
        end
    end

    _TextLabel.InputBegan:Connect(v16)
    _UserInputService.InputChanged:Connect(v13)

    return _ScreenGui, _Frame, _TextButton, _TextButton2, _TextLabel2
end

local u18 = false

local function v24()
    local v19 = nil
    local v20 = nil
    local v21 = 0.1

    repeat
        game:GetService('RunService').Heartbeat:Wait()
    until u18

    local _LocalPlayer = game.Players.LocalPlayer

    if u18 then
        local _Velocity = v20.Velocity

        v20.Velocity = _Velocity * 10000 + Vector3.new(0, 10000, 0)

        game:GetService('RunService').RenderStepped:Wait()

        if v19 and (v19.Parent and (v20 and v20.Parent)) then
            v20.Velocity = _Velocity
        end

        game:GetService('RunService').Stepped:Wait()

        if v19 and (v19.Parent and (v20 and v20.Parent)) then
            v20.Velocity = _Velocity + Vector3.new(0, v21, 0)
            v21 = v21 * -1
        end
    end

    game:GetService('RunService').Heartbeat:Wait()

    v19 = _LocalPlayer.Character
    v20 = v19:FindFirstChild('HumanoidRootPart') or (v19:FindFirstChild('Torso') or v19:FindFirstChild('UpperTorso'))

    if u18 and not (v19 and (v19.Parent and (v20 and v20.Parent))) then
    else
    end
end

local _, u25, u26, v27 = v17()

u26.MouseButton1Click:Connect(function()
    u18 = not u18

    if u18 then
        u26.Text = 'On'
    else
        u26.Text = 'Off'
    end
end)
v27.MouseButton1Click:Connect(function()
    u25.Visible = not u25.Visible
end)
v24()
