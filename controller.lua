--> I do not really want to explain how this works
--> You can figure it out yourself,
--> But I have left comments around, so enjoy those I guess?
--> Made by Suno, in a rush because I want to do other things right now..

--> Variables <--
local Players = game.Players or game:GetService("Players")
local ReplicatedStorage = game.ReplicatedStorage or game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer:WaitForChild("Character")
local Humanoid = Character.Humanoid or Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character.HumanoidRootPart or Character:WaitForChild("HumanoidRootPart")

local Prefix = "-"
local Version = "1"

--> Functions <--
local function Chat(Message, Place) --> Allow for easier communications :)
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, Place)
end

local function Command(Command)
    return Arg1 == string.lower(Prefix..Command) --> Return command back to you
end

--> Connections <--
local function ConnectPlayer(Player)
    Player.Chatted:Connect(function(Message)
        local Split = Message:split(" ") --> Break the message apart to allow spaces
        
        Arg1 = Split[1]
        Arg2 = Split[2]
        Arg3 = Split[3]
        Arg4 = Split[4]

        if (Command("credits")) then
            Chat("This script was made by Suno! (rscripts net/u/Suno)")
        end

        if (Command("jump")) then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) --> Use an alternative method to jump
        end

        if (Command("sit")) then
            Humanoid.Sit = true --> Make the player have a seat
        end

        if (Command("spin")) then
            local Velocity = tonumber(Arg2)

            for i,v in pairs(Humanoid.RootPart:GetChildren()) do
                if v:IsA("BodyAngularVelocity") then
                    v:Destroy()
                end
            end

            local Speed = Velocity
            local Humanoid = Humanoid

            local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
            BodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyAngularVelocity.AngularVelocity = Vector3.new(0, Speed, 0)
            BodyAngularVelocity.Parent = Humanoid.RootPart
        end

        if (Command("unspin")) then
            for i,v in pairs(Humanoid.RootPart:GetChildren()) do
                if v:IsA("BodyAngularVelocity") then
                    v:Destroy()
                end
            end
        end

        if (Command("cmds") or Command("commands")) then
            if (getgenv().CmdsActive) then
                return print("Commands are already active")
            end

            getgenv().CmdsActive = true
            task.wait(2)

            Chat("-credits -unfloat -jump -sit [message] -spin [speed] -unspin -cmds -float [height] -freeze -unfreeze -gravity [power]", "All")
            
            getgenv().CmdsActive = false
        end
        
        if (Command("float")) then
            local MaxHeight = 10
            local Height = tonumber(Arg2)

            if Height > MaxHeight then
                Height = MaxHeight
            end

            Humanoid.HipHeight = Height
        end

        if (Command("freeze")) then
            HumanoidRootPart.Anchored = true
        end

        if (Command("thaw") or Command("unfreeze")) then
            HumanoidRootPart.Anchored = false
        end

        if (Command("unfloat")) then
            Humanoid.HipHeight = 0
        end

        if (Command("gravity")) then
            local MaxGravity = 20 --> This is so you can not float up forever.
            local Gravity = tonumber(Arg2)

            if Gravity < MaxGravity then
                Gravity = MaxGravity
            end

            workspace.Gravity = Gravity
        end
    end)
end

Players.PlayerAdded:Connect(function(Player) --> When a new person joins, add them to list
    ConnectPlayer(Player)
end)

for _,Player in ipairs(Players:GetPlayers()) do --> Connect current users to list of whitelisted
    ConnectPlayer(Player)
end

if game.PlaceId == 8737602449 then
  while true do
    Chat("-cmds or -commands to see all commands! :)", "All")
    Humanoid:ChangeState("Jumping")
    
    wait(50)
  end
end
