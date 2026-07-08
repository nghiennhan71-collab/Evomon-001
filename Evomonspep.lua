-- Tải thư viện giao diện Orion Library
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- Tạo cửa sổ Menu chính của Hub
local Window = OrionLib:MakeWindow({
    Name = "⚡ Cyraa Speed Hub ⚡", 
    HidePremium = true, 
    SaveConfig = false, 
    ConfigFolder = "EvomonSpeed"
})

-- ================= TAB CHÍNH =================
local MainTab = Window:MakeTab({
    Name = "Chiến Đấu",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Tính năng duy nhất: Tăng tốc trận đấu x10
local FastBattleToggle = false
MainTab:AddToggle({
    Name = "⚡ Tăng tốc trận đấu x10 (Fast Battle)",
    Default = false,
    Callback = function(Value)
        FastBattleToggle = Value
        
        task.spawn(function()
            while FastBattleToggle do
                task.wait(0.01) -- Vòng lặp siêu nhanh để quét và tăng tốc liên tục
                pcall(function()
                    -- 1. Đẩy nhanh tốc độ hoạt ảnh (Animation) trận đấu lên x10 trên màn hình
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("AnimationController") or v:IsA("Humanoid") then
                            local animator = v:FindFirstChildOfClass("Animator")
                            if animator then
                                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                                    track:AdjustSpeed(10) -- Ép hoạt ảnh quái vật và chiêu thức đánh nhanh gấp 10 lần
                                end
                            end
                        end
                    end

                    -- 2. Gửi lệnh chọn kỹ năng liên tục bỏ qua thời gian chờ của lượt (nếu có)
                    local battleRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") 
                        and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("BattleAction")
                    
                    if battleRemote then
                        battleRemote:FireServer("Attack", "Skill1") 
                        battleRemote:FireServer("Attack", "Skill2")
                    end
                end)
            end
        end)
    end    
})

-- Khởi tạo giao diện
OrionLib:Init()
