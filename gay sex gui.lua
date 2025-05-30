-- Gui to Lua
-- Version: 3.2

-- Instances:

local PS = game:GetService("Players")

local SexGUI = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local knobheads = Instance.new("TextLabel")
local idiots = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local title = Instance.new("TextLabel")
local Target = Instance.new("TextLabel")
local Bang = Instance.new("TextButton")
local valBanging = Instance.new("BoolValue")
local valTarget = Instance.new("ObjectValue")
local bangAnim
local bang
local bangDied
local bangLoop

--Properties:

SexGUI.Name = "Sex GUI"
SexGUI.Parent = game.CoreGui
SexGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

main.Name = "main"
main.Parent = SexGUI
main.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
main.BorderColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.391341984, 0, 0.16853933, 0)
main.Size = UDim2.new(0.316450208, 0, 0.661797762, 0)

knobheads.Name = "knobheads"
knobheads.Parent = main
knobheads.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
knobheads.BorderColor3 = Color3.fromRGB(0, 0, 0)
knobheads.BorderSizePixel = 0
knobheads.Position = UDim2.new(0.0465116277, 0, 0.199490651, 0)
knobheads.Size = UDim2.new(0.439124495, 0, 0.0745330974, 0)
knobheads.Font = Enum.Font.SourceSans
knobheads.Text = "People"
knobheads.TextColor3 = Color3.fromRGB(255, 255, 255)
knobheads.TextScaled = true
knobheads.TextSize = 14.000
knobheads.TextWrapped = true

idiots.Name = "idiots"
idiots.Parent = main
idiots.Active = true
idiots.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
idiots.BorderColor3 = Color3.fromRGB(0, 0, 0)
idiots.BorderSizePixel = 0
idiots.Position = UDim2.new(0.0465115458, 0, 0.31833604, 0)
idiots.Size = UDim2.new(0.439124644, 0, 0.626315892, 0)
idiots.CanvasSize = UDim2.new(0, 0, 0, 0)

UIGridLayout.Parent = idiots
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0.100000001, 0, 0.100000001, 0)
UIGridLayout.CellSize = UDim2.new(1, 0, 0.100000001, 0)

title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0.0383036919, 0, 0.0466893017, 0)
title.Size = UDim2.new(0.904240787, 0, 0.108488955, 0)
title.Font = Enum.Font.SourceSans
title.Text = "Gay Sex GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

Target.Name = "Target"
Target.Parent = main
Target.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Target.BorderColor3 = Color3.fromRGB(0, 0, 0)
Target.BorderSizePixel = 0
Target.Position = UDim2.new(0.528043747, 0, 0.314091682, 0)
Target.Size = UDim2.new(0.414500684, 0, 0.0745330974, 0)
Target.Font = Enum.Font.SourceSans
Target.Text = "Target: Nobody"
Target.TextColor3 = Color3.fromRGB(255, 255, 255)
Target.TextScaled = true
Target.TextSize = 14.000
Target.TextWrapped = true

Bang.Name = "Bang"
Bang.Parent = main
Bang.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Bang.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bang.BorderSizePixel = 0
Bang.Position = UDim2.new(0.528043747, 0, 0.526315749, 0)
Bang.Size = UDim2.new(0.414500862, 0, 0.206112102, 0)
Bang.Font = Enum.Font.SourceSans
Bang.Text = "Bang"
Bang.TextColor3 = Color3.fromRGB(255, 255, 255)
Bang.TextScaled = true
Bang.TextSize = 14.000
Bang.TextWrapped = true

valBanging.Parent = main
valBanging.Name = "banging"
valBanging.Value = false

valTarget.Parent = main
valTarget.Name = "target"

local function makeButton(plr : Player)
	local button = Instance.new("TextButton")
	button.Parent = idiots
	button.BackgroundColor3 = Color3.fromRGB(50,50,50)
	button.TextScaled = true
	button.Text = plr.DisplayName
	button.MouseButton1Click:Connect(function()
		valTarget.Value = plr
	end)
	
end

local function r15(plr : Player)
	if plr.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
		return true
	end
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function getTorso(x)
	x = x or PS.LocalPlayer.Character
	return x:FindFirstChild("Torso") or x:FindFirstChild("UpperTorso") or x:FindFirstChild("LowerTorso") or x:FindFirstChild("HumanoidRootPart")
end

for i,v in PS:GetPlayers() do
	if v ~= game.Players.LocalPlayer then
		makeButton(v)
	end
end

local UIS = game:GetService("UserInputService")
local frame = main

local dragToggle = nil
local dragSpeed = 0.1
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService("TweenService"):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)

Bang.MouseButton1Click:Connect(function()
	if valTarget.Value then
		Bang.Text = "unBang"
	else
		Bang.Text = "Bang"
	end
	valTarget.Value = not valTarget.Value
end)

valTarget.Changed:Connect(function()
	if valBanging.Value then
		local knob = valTarget.Value
	
		local humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
		bangAnim = Instance.new("Animation")
		bangAnim.AnimationId = not r15(game.Players.LocalPlayer) and "rbxassetid://148840371" or "rbxassetid://5918726674"
		bang = humanoid:LoadAnimation(bangAnim)
		bang:Play(0.1, 1, 1)
		bang:AdjustSpeed(3)
		bangDied = humanoid.Died:Connect(function()
			bang:Stop()
			bangAnim:Destroy()
			bangDied:Disconnect()
			bangLoop:Disconnect()
		end)
		if valTarget then
			local players = {valTarget, game.Players.LocalPlayer}
			for _, v in pairs(players) do
				local bangplr = PS[v].Name
				local bangOffet = CFrame.new(0, 0, 1.1)
				bangLoop = game:GetService("RunService").Stepped:Connect(function()
					pcall(function()
						local otherRoot = getTorso(PS[bangplr].Character)
						getRoot(game.Players.LocalPlayer.Character).CFrame = otherRoot.CFrame * bangOffet
					end)
				end)
			end
		end
	else
		if bangDied then
			bangDied:Disconnect()
			bang:Stop()
			bangAnim:Destroy()
			bangLoop:Disconnect()
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	idiots.CanvasSize = UDim2.new(0,0,0,script.Parent.UIGridLayout.AbsoluteContentSize.Y)
end)
