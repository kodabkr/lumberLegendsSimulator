for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
    v:Disable()
end

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kodabkr/hubLoad/main/main.lua"))()
local Koko = library.new("Koko Hub | Current Game: " .. gameName .. " |", 5013109572)

local FarmSection = Koko:addPage("Farming", 5012544693)
local farmMain = FarmSection:addSection("Main")

local selectedEgg
local selectedTree
local openAmt
local TweenService = game:GetService("TweenService")

local function isPlayerNearObject(player, object, distance)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local objectPosition = object.Position
        local playerPosition = humanoidRootPart.Position
        local playerToObjectDistance = (objectPosition - playerPosition).Magnitude
        return playerToObjectDistance <= distance
    end
    return false
end

local function chopTree()
    for _, v in pairs(workspace["[Codable]"]["[Tree Spawners]"].Spawn:GetChildren()) do
        for _, x in pairs(v:GetChildren()) do
            if x.Name == selectedTree then
                local character = game.Players.LocalPlayer.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                    local targetCFrame = v.CFrame

                    if not isPlayerNearObject(game.Players.LocalPlayer, v, 10) then
                        local tweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Linear)

                        local tween = TweenService:Create(humanoidRootPart, tweenInfo, {
                            CFrame = targetCFrame,
                        })

                        tween:Play()
                        tween.Completed:Wait()
                    end

                    local args = {
                        [1] = tostring(v)
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("AxeService"):WaitForChild("RE"):WaitForChild("HitTree"):FireServer(unpack(args))
                end
            end
        end
    end
end

farmMain:addDropdown("Select Tree", {"Large Cactus", "Large Oak Tree", "Large Palm Tree", "Large Pine Tree", "Cactus", "Large Snow Pine", "Large Tall Tree", "Oak Tree", "Palm Tree", "Pine Tree", "Snow Pine", "Great Tree", "Icicle Tree", "Large Great Tree", "Large Icicle Tree", "Large Magma Tree", "Large Withered Tree", "Tall Tree", "Sakura Tree", "Glitch 2", "Large Mighty Tree", "Magma Tree", "Withered Tree", "Mighty Tree", "The Knowing Tree", "Glitch 1", "Glitch 3", "Glitch 4", "God Tree", "Large Bonsai Tree", "Large Sakura Tree", "Bonsai Tree", "Deku Tree", "Fruit Tree", "Ninja Tree", "Majestic Tree"}, function(passThrough)
	selectedTree = passThrough
end)

farmMain:addToggle("Auto Chop Selected Tree", nil, function(state)
    auto1 = state
    repeat
        chopTree()
        task.wait()
    until not auto1
end)

farmMain:addDropdown("Select Egg", {'1M Egg', '2M Egg', 'Basic Egg', 'Beach Ball Egg', 'Burning Egg', 'Ember Egg', 'Exclusive Egg', 'Frost Egg', 'Glitch Egg', 'Golden Glitch Egg', 'Golden Magic Egg', 'Good Egg', 'Icey Egg', 'Jungle Egg', 'Magic Egg', 'Magic Egg', 'Relic Egg', 'Sand Castle Egg' }, function(passThrough)
	selectedEgg = passThrough
end)

farmMain:addDropdown("Select Open Amoutn (3 is free with script)", {1, 3}, function(passThrough)
	openAmt = passThrough
end)

farmMain:addToggle("Auto Open Selected Egg", nil, function(state)
	auto2 = state
	if auto2 then
		coroutine.wrap(function()
			while auto2 and task.wait() do
                local args = {
                    [1] = tonumber(openAmt),
                    [2] = tostring(selectedEgg)
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("EggService"):WaitForChild("RE"):WaitForChild("BuyEgg"):FireServer(unpack(args))
			end
		end)()
	end
end)

farmMain:addToggle("Auto Collect Coins", nil, function(state)
	auto3 = state
	if auto3 then
		coroutine.wrap(function()
			while auto3 and task.wait() do
                for _,v in pairs(workspace["[Codable]"]["[Orbs]"]:GetChildren()) do
                    if v:IsA("Part") then
                        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end
		end)()
	end
end)

farmMain:addToggle("Auto Daily Spin", nil, function(state)
	auto4 = state
	if auto4 then
		coroutine.wrap(function()
			while auto4 and task.wait(5) do
                game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SpinWheelService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()
            end
		end)()
	end
end)

farmMain:addToggle("Auto Claim Time Rewards", nil, function(state)
	auto5 = state
	if auto5 then
		coroutine.wrap(function()
			while auto5 and task.wait(1) do
                for i = 1, 12 do
                    local args = {
                        [1] = i
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GiftsService"):WaitForChild("RE"):WaitForChild("Claim"):FireServer(unpack(args))
                end
            end
		end)()
	end
end)

farmMain:addToggle("Auto Evolve Pickaxes", nil, function(state)
	auto6 = state
	if auto6 then
		coroutine.wrap(function()
			while auto6 and task.wait(1) do
                for _,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.CoreUI.Frames.Axes.Main.Container:GetChildren()) do
                    if v:IsA("Frame") then 
                        local args = {
                            [1] = tostring(v)
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("AxeInventoryService"):WaitForChild("RF"):WaitForChild("CraftAxe"):InvokeServer(unpack(args))
                    end
                end
            end
		end)()
	end
end)
