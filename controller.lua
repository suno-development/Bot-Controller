--> Variables <--
local Players = game.Players or game:GetService("Players")
local ReplicatedStorage = game.ReplicatedStorage or game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer:WaitForChild("Character")
local Humanoid = Character.Humanoid or Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character.HumanoidRootPart or Character:WaitForChild("HumanoidRootPart")

local Prefix = "-"
local Version = "2"

--> Functions <--
local function Chat(Message, Place)
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, Place)
end

local function Command(Command)
    return Arg1 == string.lower(Prefix..Command)
end

--> Connections <--
local function ConnectPlayer(Player)
    Player.Chatted:Connect(function(Message)
        local Split = Message:split(" ")
        
        Arg1 = Split[1]
        Arg2 = Split[2]
        Arg3 = Split[3]
        Arg4 = Split[4]

        if (Command("credits")) then
            if (getgenv().CreditsActive) then
                return print("Commands are already active")
            end

            getgenv().CreditsActive = true
            task.wait(2)

            Chat("This script was made by Suno! (rscripts net/u/Suno)", "All")
            getgenv().CreditsActive = false
        end

        if (Command("jump")) then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        if (Command("sit")) then
            Humanoid.Sit = true
        end

        if (Command("spin")) then
            local MaxSpeed = 50
            local Velocity = tonumber(Arg2)

            if Velocity > MaxSpeed then
                Velocity = MaxSpeed
            end
                
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

            Chat("-credits -unfloat -jump -sit -spin [speed] -unspin -cmds -float [height] -freeze -unfreeze / -thaw -gravity [power]", "All")
            
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
            local MaxGravity = 20
            local Gravity = tonumber(Arg2)

            if Gravity < MaxGravity then
                Gravity = MaxGravity
            end

            workspace.Gravity = Gravity
        end
    end)
end

Players.PlayerAdded:Connect(function(Player)
    ConnectPlayer(Player)
end)

for _,Player in ipairs(Players:GetPlayers()) do
    ConnectPlayer(Player)
end

while true do
    Chat("Need commands? -cmds to see all commands.", "All")
    wait(30)
end
