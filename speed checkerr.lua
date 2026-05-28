local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedDetector"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,260,0,300)
label.Position = UDim2.new(0,10,0,100)
label.BackgroundTransparency = 0.3
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.TextSize = 16
label.Text = ""
label.Active = true
label.Parent = gui

-- Drag
local dragging = false
local dragStart
local startPos

label.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		
		dragging = true
		dragStart = input.Position
		startPos = label.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		
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
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

while task.wait(0.3) do
	local output = ""

	for _, plr in ipairs(Players:GetPlayers()) do
		local char = plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			local vel = root.AssemblyLinearVelocity
			
			local speed = math.floor(
				Vector3.new(
					vel.X,
					0,
					vel.Z
				).Magnitude
			)

			if speed < 12 then
				speed = 0
			end

			output = output ..
				plr.Name ..
				" | " ..
				speed

			if speed > 30 then
				output = output .. " [FAST]"
			end

			output = output .. "\n"
		end
	end

	label.Text = output
end
-- xd

