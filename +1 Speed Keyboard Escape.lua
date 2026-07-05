---------------------------------------------------------------------------
-- AETHER UI BUILDER — called after key is verified
---------------------------------------------------------------------------
local function BuildUI()
    local Window = Library:Window({
        Title = "Aether",
        Desc  = "by slayeryx",
        Icon  = "door-open",       -- lucide icon name from Icons.lua spritesheet
        Theme = "Default",         -- "Default" or "Dark"
        -- DiscordLink = "https://discord.gg/yourserver",
        -- Version = "v1.0",
        Config = {
            Keybind = Enum.KeyCode.LeftControl,
            Size    = UDim2.new(0, 530, 0, 400),
        },
    })

    -----------------------------------------------------------------------
    -- TAB 1 — Main
    -----------------------------------------------------------------------
    local MainTab = Window:Tab({ Title = "Main", Icon = "house" })

    MainTab:Section({ Title = "General" })

    MainTab:Toggle({
        Title    = "Example Toggle",
        Desc     = "Flip me on or off",
        Value    = false,
        Callback = function(val)
            print("[Aether] Toggle:", val)
        end,
    })

    MainTab:Slider({
        Title    = "Walk Speed",
        Desc     = "Adjust your speed",
        Min      = 16,
        Max      = 200,
        Value    = 16,
        Rounding = 0,
        Callback = function(val)
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
            end)
        end,
    })

    MainTab:Button({
        Title    = "Print Hello",
        Desc     = "Prints to console",
        Callback = function()
            print("[Aether] Hello from LO & ENI!")
        end,
    })

    MainTab:Dropdown({
        Title    = "Pick One",
        List     = {"Option A", "Option B", "Option C"},
        Value    = "Option A",
        Callback = function(val)
            print("[Aether] Dropdown:", val)
        end,
    })

    -----------------------------------------------------------------------
    -- TAB 2 — Settings
    -----------------------------------------------------------------------
    Window:Line()
    local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

    SettingsTab:Section({ Title = "UI Config" })

    SettingsTab:Keybind({
        Title    = "Toggle UI Key",
        Key      = Enum.KeyCode.LeftControl,
        Callback = function(key)
            Window:SetUIToggleKeybind(key)
        end,
    })

    SettingsTab:ColorPicker({
        Title    = "Accent Color",
        Value    = Color3.fromRGB(108, 30, 210),
        Callback = function(r, g, b)
            print("[Aether] Color:", r, g, b)
        end,
    })

    SettingsTab:Textbox({
        Title       = "Username",
        Placeholder = "Type here...",
        Value       = "",
        Callback    = function(val)
            print("[Aether] Textbox:", val)
        end,
    })

    SettingsTab:Label({
        Title = "Aether UI — Loaded",
        Desc  = "Loader by ENI & LO",
    })

    -----------------------------------------------------------------------
    -- startup notification
    -----------------------------------------------------------------------
    Window:Notify({
        Title = "Aether",
        Desc  = "UI loaded successfully!",
        Time  = 5,
    })

    print("[Aether Loader] UI built — have fun, darlin'")
end
