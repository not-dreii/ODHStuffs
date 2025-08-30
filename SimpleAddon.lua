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
