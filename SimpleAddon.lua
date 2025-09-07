--- READ FIRST THIS PLUGIN/FILE DOES NOT HARM YOUR DEVICE OR RBLX ACCOUNT 

local shared = odh_shared_plugins
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local speed_glitch_section = shared.AddSection("Auto Speed Glitch")

local speed_glitch_enabled = false
local horizontal_only = false
local speed_slider_value = 0
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

speed_glitch_section:AddToggle("Enable ASG", function(enabled)
    speed_glitch_enabled = enabled
end)

speed_glitch_section:AddToggle("Sideways Only", function(enabled)
    horizontal_only = enabled
end)

speed_glitch_section:AddSlider("Speed (0–255)", 0, 255, 0, function(value)
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

-- Rate: Featured
-- Made By: not_.gato
-- Special ID: tYbVq_01
-- Name: Minecraftizer
-- Description: Minecrafts Your Game :content:

local shared = odh_shared_plugins

local Minecraftizer = shared.AddSection("Minecraftizer")

Minecraftizer:AddLabel("<b><font color='#FFD700'>Credits:</font></b> not_.gato", true)

local materialTextures = {
    [Enum.Material.Asphalt] = "rbxassetid://10777285622",
    [Enum.Material.Basalt] = "rbxassetid://10777285622",
    [Enum.Material.Brick] = "rbxassetid://10777285622",
    [Enum.Material.Carpet] = "rbxassetid://18699165714",
    [Enum.Material.Fabric] = "rbxassetid://18699165714",
    [Enum.Material.CeramicTiles] = "rbxassetid://82688463827095",
    [Enum.Material.Cobblestone] = "rbxassetid://112006332656762",
    [Enum.Material.Concrete] = "rbxassetid://76434845888896",
    [Enum.Material.CrackedLava] = "rbxassetid://6072514670",
    [Enum.Material.DiamondPlate] = "rbxassetid://121527765592383",
    [Enum.Material.Glacier] = "rbxassetid://138703197443219",
    [Enum.Material.Glass] = "rbxassetid://11384458772",
    [Enum.Material.Granite] = "rbxassetid://84691298982406",
    [Enum.Material.Grass] = "rbxassetid://129412557796389",
    [Enum.Material.LeafyGrass] = "rbxassetid://129412557796389",
    [Enum.Material.Ground] = "rbxassetid://114241584338245",
    [Enum.Material.Ice] = "rbxassetid://11413423466",
    [Enum.Material.Marble] = "rbxassetid://71371694781487",
    [Enum.Material.Metal] = "rbxassetid://8677286748",
    [Enum.Material.Mud] = "rbxassetid://5104022863",
    [Enum.Material.Pavement] = "rbxassetid://76838016906118",
    [Enum.Material.Rock] = "rbxassetid://92531008905854",
    [Enum.Material.Salt] = "rbxassetid://112438351210604",
    [Enum.Material.Sand] = "rbxassetid://9277770677",
    [Enum.Material.Sandstone] = "rbxassetid://120884186339230",
    [Enum.Material.Slate] = "rbxassetid://92531008905854",
    [Enum.Material.Snow] = "rbxassetid://11108881974",
    [Enum.Material.Wood] = "rbxassetid://8676581022",
    [Enum.Material.WoodPlanks] = "rbxassetid://8676581022",
}

local function applyTexture(part, id)
    if not id then return end
    for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
        local exists = false
        for _, tex in ipairs(part:GetChildren()) do
            if tex:IsA("Texture") and tex.Face == face and tex.Texture == id then
                exists = true
                break
            end
        end
        if not exists then
            local texture = Instance.new("Texture")
            texture.Texture = id
            texture.Face = face
            texture.StudsPerTileU = 4
            texture.StudsPerTileV = 4
            texture.Color3 = part.Color
            texture.Parent = part
        end
    end
end

local function applyTexturesToAll()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
            if obj.Transparency < 0.99 then
                local id = materialTextures[obj.Material]
                if id then
                    applyTexture(obj, id)
                end
            end
        end
    end
end

local function removeMinecraftTextures()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("Texture") and child.Texture and child.Texture:match("rbxassetid://") then
                    child:Destroy()
                end
            end
        end
    end
end

Minecraftizer:AddButton("Apply Textures", function()
    applyTexturesToAll()
    shared.Notify("Material textures applied!", 3)
end)

Minecraftizer:AddButton("Remove All Textures", function()
    removeMinecraftTextures()
    shared.Notify("All Minecraft textures removed!", 3)
end)

Minecraftizer:AddKeybind("Apply Materials Keybind", "O", function()
    applyTexturesToAll()
    shared.Notify("Material textures applied via keybind!", 3)
end)

local shared = odh_shared_plugins
local RTX_section = shared.AddSection("RTX")
RTX:AddLabel("<b><font color='#FFD700'>RTX:</font></b> SOON TO BE UPDATED", true)

local shared = odh_shared_plugins
local Free_exclusive/premium_section = shared.AddSection("Click")

if not shared then return end

if plugin_on_startup then
    shared.plugin_mark_as_verified = "AES_STARLIGHT_256_683"
    return
end

shared.is_premium_user = true
shared.is_exclusive_user = true
