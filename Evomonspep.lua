local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

local Window = OrionLib:MakeWindow({
    Name = "⚡ Cyraa Speed Hub V2 ⚡", 
    HidePremium = true, 
    SaveConfig = false, 
    ConfigFolder = "EvomonSpeedV2"
})

local MainTab = Window:MakeTab({
    Name = "Chiến Đấu",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local FastBattleToggle = false
MainTab:AddToggle({
    Name = "⚡ Tăng tốc trận đấu x10 (Fast Battle)",
    Default = false,
    Callback = function(Value)
        FastBattleToggle = Value
        
        task.spawn(function()
            while FastBattleToggle do
                task.wait(0.1)
                pcall(function()
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("AnimationController") or v:IsA("Humanoid") then
                            local animator = v:FindFirstChildOfClass("Animator")
                            if animator then
                                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                                    if track.IsPlaying then
                                        track:AdjustSpeed(10)
                                    end
                                end
                            end
                        end
                    end

                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if remotes then
                        local battleAction = remotes:FindFirstChild("BattleAction") or remotes:FindFirstChild("Combat")
                        if battleAction then
                            battleAction:FireServer("Attack", "Skill1")
                            battleAction:FireServer("Attack", "Skill2")
                        end
                    end
                end)
            end
        end)
    end    
})

OrionLib:Init()
