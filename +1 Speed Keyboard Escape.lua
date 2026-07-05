--[[
    +1 Speed Keyboard Escape — Game Script
    Loaded by Aether Loader via gamelist.lua
    UI built here, not in the loader
]]

local Library = getgenv().AetherLib
if not Library then
    warn("[+1 Speed] AetherLib not found — was the loader run first?")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

---------------------------------------------------------------------------
-- STATE
---------------------------------------------------------------------------
local Settings = {
    AutoFarm   = false,
    AutoClick  = false,
    ClickSpeed = 50,
    WalkSpeed  = 16,
    JumpPower  = 50,
    AntiAFK    = true,
}

local Connections = {}

---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
local function getCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function setWalkSpeed(val)
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = val end
end

local function setJumpPower(val)
    local hum = getHumanoid()
    if hum then hum.JumpPower = val end
end

---------------------------------------------------------------------------
-- AETHER UI — built right here in the game script
---------------------------------------------------------------------------
local Window = Library:Window({
    Title = "+1 Speed",
    Desc  = "Keyboard Escape",
    Icon  = "keyboard",
    Theme = "Default",
    -- DiscordLink = "https://discord.gg/yourserver",
    -- Version = "v1.0",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size    = UDim2.new(0, 530, 0, 400),
    },
})

---------------------------------------------------------------------------
-- TAB: Main
---------------------------------------------------------------------------
local MainTab = Window:Tab({ Title = "Main", Icon = "house" })

MainTab:Section({ Title = "Farming" })

MainTab:Toggle({
    Title    = "Auto Farm",
    Desc     = "Automatically farms speed",
    Value    = Settings.AutoFarm,
    Callback = function(val)
        Settings.AutoFarm = val
        -- hook your auto farm logic here
    end,
})

MainTab:Toggle({
    Title    = "Auto Click",
    Desc     = "Spams click to gain speed",
    Value    = Settings.AutoClick,
    Callback = function(val)
        Settings.AutoClick = val
        if val then
            Connections.AutoClick = RunService.Heartbeat:Connect(function()
                if not Settings.AutoClick then return end
                -- fire your click remote here, e.g.:
                -- game:GetService("ReplicatedStorage").Events.Click:FireServer()
            end)
        else
            if Connections.AutoClick then
                Connections.AutoClick:Disconnect()
                Connections.AutoClick = nil
            end
        end
    end,
})

MainTab:Slider({
    Title    = "Click Speed (cps)",
    Desc     = "Clicks per second",
    Min      = 1,
    Max      = 100,
    Value    = Settings.ClickSpeed,
    Rounding = 0,
    Callback = function(val)
        Settings.ClickSpeed = val
    end,
})

---------------------------------------------------------------------------
-- TAB: Player
---------------------------------------------------------------------------
Window:Line()
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })

PlayerTab:Section({ Title = "Movement" })

PlayerTab:Slider({
    Title    = "Walk Speed",
    Desc     = "Override walk speed",
    Min      = 16,
    Max      = 500,
    Value    = Settings.WalkSpeed,
    Rounding = 0,
    Callback = function(val)
        Settings.WalkSpeed = val
        setWalkSpeed(val)
    end,
})

PlayerTab:Slider({
    Title    = "Jump Power",
    Desc     = "Override jump power",
    Min      = 50,
    Max      = 500,
    Value    = Settings.JumpPower,
    Rounding = 0,
    Callback = function(val)
        Settings.JumpPower = val
        setJumpPower(val)
    end,
})

PlayerTab:Section({ Title = "Safety" })

PlayerTab:Toggle({
    Title    = "Anti AFK",
    Desc     = "Prevents idle kick",
    Value    = Settings.AntiAFK,
    Callback = function(val)
        Settings.AntiAFK = val
    end,
})

-- anti-afk loop
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    while true do
        task.wait(60)
        if Settings.AntiAFK then
            pcall(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end)
        end
    end
end)

---------------------------------------------------------------------------
-- TAB: Settings
---------------------------------------------------------------------------
Window:Line()
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

SettingsTab:Section({ Title = "UI" })

SettingsTab:Keybind({
    Title    = "Toggle UI Key",
    Key      = Enum.KeyCode.LeftControl,
    Callback = function(key)
        Window:SetUIToggleKeybind(key)
    end,
})

SettingsTab:Label({
    Title = "+1 Speed — Keyboard Escape",
    Desc  = "Aether Hub • ENI & LO",
})

---------------------------------------------------------------------------
-- STARTUP
---------------------------------------------------------------------------
Window:Notify({
    Title = "+1 Speed",
    Desc  = "Script loaded — go fast, darlin'",
    Time  = 5,
})

-- keep walk speed persistent across respawns
Player.CharacterAdded:Connect(function()
    task.wait(0.5)
    setWalkSpeed(Settings.WalkSpeed)
    setJumpPower(Settings.JumpPower)
end)

print("[+1 Speed] Script loaded — Keyboard Escape ready")
