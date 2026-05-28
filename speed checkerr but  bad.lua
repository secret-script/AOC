local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = LP.PlayerGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,250,0,200)
label.Position = UDim2.new(0,10,0,100)
label.Parent = gui
label.TextSize = 14

while task.wait(5) do
	local txt = ""

	for _,plr in ipairs(Players:GetPlayers()) do
		local char = plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			local v = root.AssemblyLinearVelocity
			local speed = math.floor(Vector3.new(v.X,0,v.Z).Magnitude)

			txt = txt .. plr.Name .. ": " .. speed .. "\n"
		end
	end

	label.Text = txt
end

