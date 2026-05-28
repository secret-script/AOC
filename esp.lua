 getgenv().AOC_ESP = state

    if state then
        local Players = game:GetService("Players")
        local ESP_COLOR = Color3.fromRGB(0,170,255)

        local function CreateESP(player)
            if player == Players.LocalPlayer then
                return
            end

            local character = player.Character
            if not character then
                return
            end

            local head = character:FindFirstChild("Head")
            local hrp = character:FindFirstChild("HumanoidRootPart")

            if not head or not hrp then
                return
            end

            if character:FindFirstChild("ESP_FOLDER") then
                character.ESP_FOLDER:Destroy()
            end

            local folder = Instance.new("Folder")
            folder.Name = "ESP_FOLDER"
            folder.Parent = character

            local billboard = Instance.new("BillboardGui")
            billboard.Parent = folder
            billboard.Name = "NameESP"
            billboard.Adornee = head
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0,220,0,60)
            billboard.StudsOffset = Vector3.new(0,3,0)

            local text = Instance.new("TextLabel")
            text.Parent = billboard
            text.Size = UDim2.new(1,0,1,0)
            text.BackgroundTransparency = 1
            text.Text = player.Name
            text.TextColor3 = ESP_COLOR
            text.TextStrokeTransparency = 0
            text.TextScaled = true
            text.Font = Enum.Font.GothamBold

            local box = Instance.new("BoxHandleAdornment")
            box.Parent = folder
            box.Adornee = hrp
            box.AlwaysOnTop = true
            box.Size = Vector3.new(4,6,2)
            box.Color3 = ESP_COLOR
            box.Transparency = 0.4
        end

        local function SetupPlayer(player)
            player.CharacterAdded:Connect(function()
                task.wait(1)
                if getgenv().AOC_ESP then
                    CreateESP(player)
                end
            end)

            if player.Character then
                task.wait(1)
                CreateESP(player)
            end
        end

        for _, p in ipairs(Players:GetPlayers()) do
            SetupPlayer(p)
        end

        Players.PlayerAdded:Connect(SetupPlayer)

    else
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("ESP_FOLDER") then
                v.Character.ESP_FOLDER:Destroy()
            end
        end
    end
