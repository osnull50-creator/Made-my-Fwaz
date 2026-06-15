-- [[ By Fwaz | M9L EDITION | STABLE AUTO-FARM ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "By Fwaz", 
   LoadingTitle = "By Fwaz", 
   KeySystem = false
})

local Tab1 = Window:CreateTab("التحكم", "zap")
local Tab2 = Window:CreateTab("Settings", "settings")

Tab1:CreateToggle({
   Name = "Auto Farm (Speed 130 - Stable)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end
})

Tab2:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Callback = function(Value) _G.AntiAFK = Value end
})

game:GetService("RunService").Heartbeat:Connect(function()
    if _G.AutoFarm then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart then
            local root = player.Character.Humanoid.SeatPart.Parent.PrimaryPart
            
            root.AssemblyLinearVelocity = root.CFrame.LookVector * 130
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
    
    if _G.AntiAFK then
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait()
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)
