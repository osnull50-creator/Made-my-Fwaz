-- [[ Kingdom Beta 2.0 | Ultimate Edition | Final ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Kingdom Beta 2.0", LoadingTitle = "جاري التحميل...", LoadingSubtitle = "فواز"})

local MainTab = Window:CreateTab("الرئيسية", nil)
local PlateTab = Window:CreateTab("فك اللوحة", nil)
local CarTab = Window:CreateTab("قومات", nil)
local SettingsTab = Window:CreateTab("إعدادات", nil)

-- [1] فارم (الرئيسية)
MainTab:CreateToggle({
    Name = "Auto Farm (Speed 130)",
    CurrentValue = false,
    Callback = function(V)
        _G.AutoFarm = V
        while _G.AutoFarm do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
                char.Humanoid.SeatPart.Parent.PrimaryPart.AssemblyLinearVelocity = char.Humanoid.SeatPart.Parent.PrimaryPart.CFrame.LookVector * 130
            end
            task.wait()
        end
    end
})

-- [2] فك اللوحة
local mode = "Visible"
PlateTab:CreateButton({
    Name = "تبديل حالة اللوحة",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") or not char.Humanoid.SeatPart then return end
        local vehicle = char.Humanoid.SeatPart.Parent
        if mode == "Visible" then mode = "Hidden" elseif mode == "Hidden" then mode = "Deleted" else mode = "Visible" end
        for _, part in pairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") and string.find(string.lower(part.Name), "plate") then
                if mode == "Hidden" then part.Transparency = 1 part.CanCollide = false
                elseif mode == "Deleted" then part:Destroy()
                else part.Transparency = 0 part.CanCollide = true end
            end
        end
        Rayfield:Notify({Title = "اللوحة", Content = "الحالة الآن: " .. mode})
    end
})

-- [3] قومات (الجديد)
local speedVal = 100
CarTab:CreateSlider({
    Name = "سرعة المركبة",
    Range = {100, 500},
    Increment = 10,
    CurrentValue = 100,
    Callback = function(V) speedVal = V end
})

CarTab:CreateToggle({
    Name = "تفعيل التيربو",
    CurrentValue = false,
    Callback = function(V)
        _G.Turbo = V
        while _G.Turbo do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
                local vehicle = char.Humanoid.SeatPart.Parent.PrimaryPart
                vehicle.AssemblyLinearVelocity = vehicle.CFrame.LookVector * speedVal
            end
            task.wait()
        end
    end
})

-- [4] إعدادات
SettingsTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(V)
        if V then
            game.Players.LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

SettingsTab:CreateButton({
    Name = "FPS Unlocker",
    Callback = function() setfpscap(999) Rayfield:Notify({Title = "FPS", Content = "تم الفك!"}) end
})

