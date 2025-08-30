--- READ FIRST THIS PLUGIN/FILE DOES NOT HARM YOUR DEVICE OR RBLX ACCOUNT 

local shared = odh_shared_plugins
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local InsertService = game:GetService("InsertService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Server_section = shared.AddSection("Force Kick | #1")
local Server_section = shared.AddSection("Mute Gun| #2")
local RTX_section = shared.AddSection("RTX| #3")
local speed_glitch_section = shared.AddSection("Auto Speed Glitch| #4")

local speed_glitch_enabled = false
local horizontal_only = false
local speed_slider_value = 16
local default_speed = 16

local character, humanoid, rootPart
local is_in_air = false

local function onCharacterAdded(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")

    humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall then
            is_in_air = true
        else
            is_in_air = false
        end
    end)
end

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

speed_glitch_section:AddToggle("Enable SG", function(enabled)
    speed_glitch_enabled = enabled
end)

speed_glitch_section:AddToggle("Sideways Only", function(enabled)
    horizontal_only = enabled
end)

speed_glitch_section:AddSlider("Speed (0â€“128)", 0, 128, 0, function(value)
    speed_slider_value = value
end)

RunService.Stepped:Connect(function()
    if not isMobile() then return end
    if not speed_glitch_enabled then return end
    if not character or not humanoid or not rootPart then return end

    local final_speed = default_speed + speed_slider_value

    if is_in_air then
        if horizontal_only then
            local moveDir = humanoid.MoveDirection
            local rightDir = rootPart.CFrame.RightVector
            local horizontalAmount = moveDir:Dot(rightDir)

            if math.abs(horizontalAmount) > 0.5 then
                humanoid.WalkSpeed = final_speed
            else
                humanoid.WalkSpeed = default_speed
            end
        else
            humanoid.WalkSpeed = final_speed
        end
    else
        humanoid.WalkSpeed = default_speed
    end
end)

other_section:AddButton("Force Kick", function() game:Shutdown() end)
other_section:AddButton("Mute Gun", function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    task.spawn(function()
        while task.wait(1) do
            local char = player.Character or player.CharacterAdded:Wait()
            local gun = char:FindFirstChild("Gun")

            if gun then
                local handle = gun:FindFirstChild("Handle")
                if handle then
                    local reload = handle:FindFirstChild("Reload")
                    if reload and reload:IsA("Sound") then
                        reload.Volume = 0
                    end

                    local gunshot = handle:FindFirstChild("Gunshot")
                    if gunshot and gunshot:IsA("Sound") then
                        gunshot.Volume = 0
                    end
                end
            end
        end
    end)
end)

warn("[#]: Loaded")
-- UPDATED!
