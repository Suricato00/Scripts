--[[ 
CrabHub
Created by Suricato006#8711

if you are someone that wants some script for a game you want to exploit ask in the discord server (https://discord.gg/JSjpgSPs4v), i will make one for sure.

The script is open source so you can learn from it, not steal it. If you want to use my script you are free to do it, just credit me.
Much love and thanks for using my script <3

(hope to make someone learn from my scripts)]]

if not game:IsLoaded() then game.Loaded:Wait() end

if not game:GetService("Players").LocalPlayer.Character then
    game:GetService("Players").LocalPlayer.CharacterAdded:wait()
end
game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

if game:GetService("CoreGui"):FindFirstChild("CrabHub") then
    game:GetService("CoreGui").CrabHub:Destroy()
end

local FileName = "CrabHub.JSON"
local function SaveSettings()
    writefile(FileName, game:GetService("HttpService"):JSONEncode(_G.VariablesTable))
end

local function LoadSettings()
    if isfile(FileName) then
        _G.VariablesTable = game:GetService("HttpService"):JSONDecode(readfile(FileName))
    end
end

local function FastWait()
    game:GetService("RunService").Heartbeat:wait()
end

local function Find(table, value)
    for i, v in  pairs(table) do
        if v == value then
            return i
        end
    end
end

local Player = game:GetService("Players").LocalPlayer

local function PlayerCheck()
    if Player.Character:FindFirstChild("HumanoidRootPart") then
        return true
    else
        return nil
    end
end

_G.VariablesTable = {}
LoadSettings()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts/main/Edited%20Venyx%20UI"))()
local CrabHub = library.new("CrabHub")
local General = CrabHub:addPage("General", 5012544693)
local GeneralSection = General:addSection("Works in every game")
local Config = General:addSection("Configuration")
local Credits = General:addSection("Credits")

local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    if _G.VariablesTable["AntiAfk"] then
        bb:CaptureController()
        bb:ClickButton2(Vector2.new()) 
    end
end)

GeneralSection:addToggle("AntiAfk", _G.VariablesTable.AntiAfk, function(bool)
	_G.VariablesTable.AntiAfk = bool
    SaveSettings()
end)

local function AutoRejoin()
    while _G.VariablesTable["AutoRejoin"] do wait()
        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then 
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    end
end

spawn(AutoRejoin)

GeneralSection:addToggle("AutoRejoin when kicked", _G.VariablesTable.AutoRejoin, function(bool)
	_G.VariablesTable.AutoRejoin = bool
    SaveSettings()
    AutoRejoin()
end)

GeneralSection:addButton("Rejoin", function()
	CrabHub:Notify("Rejoining", "Wait a second...")
	wait(1)
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

GeneralSection:addButton("FPS boost", function()
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    sethiddenproperty(l,"Technology",2)
    sethiddenproperty(t,"Decoration",false)
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end)

local function SpeedCheck()
    if Player.Character:FindFirstChild("Humanoid") then
        return Player.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed
    else
        return
    end
end

local function Change()
    Player.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = _G.VariablesTable.WalkSpeed or 16
    Player.Character:FindFirstChildWhichIsA("Humanoid").JumpPower = _G.VariablesTable.JumpPower or 50
end

Change()

GeneralSection:addSlider("WalkSpeed", (_G.VariablesTable.WalkSpeed or 16), 1, 500, function(chosen)
    _G.VariablesTable.WalkSpeed = chosen
    Change()
    SaveSettings()
end)

local function JumpCheck()
    if Player.Character:FindFirstChild("Humanoid") then
        return Player.Character:FindFirstChildWhichIsA("Humanoid").JumpPower
    else
        return
    end
end

GeneralSection:addSlider("JumpPower", (_G.VariablesTable.JumpPower or 50), 1, 500, function(chosen)
    _G.VariablesTable.JumpPower = chosen
    Change()
    SaveSettings()
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.VariablesTable.InfiniteJump then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
    end
end)

GeneralSection:addToggle("Infinite Jump", _G.VariablesTable.InfiniteJump, function(bool)
	_G.VariablesTable.InfiniteJump = bool
    SaveSettings()
end)

Player.Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal("JumpPower"):Connect(Change)
Player.Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(Change)
Player.CharacterAdded:Connect(function(Char)
    Char:WaitForChild("Humanoid"):GetPropertyChangedSignal("JumpPower"):Connect(Change)
    Char:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(Change)
    Change()
end)

GeneralSection:addButton("RemoteSpy", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts/main/RemoteSpy%20modified"))()
end)

GeneralSection:addButton("DarkDex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Neon-Fox/roblox-scripts/main/Dex-V3"))()
end)

Config:addKeybind("Toggle GUI", Enum.KeyCode.RightControl, function()
	CrabHub:toggle(true)
end)

Credits:addButton("Suricato006#8711, Scripter", function()
	CrabHub:Notify("Scripter", "Made all the scripts for the GUI")
end)
Credits:addButton("GreenDeno and ToddDev-Roblox", function()
	CrabHub:Notify("UI library creators", "Made the UI library, insane job")
end)
Credits:addButton("Discord Server", function()
    CrabHub:Notify("Discord invite", "Do you wanna copy the discord server invite?", function(bool)
		if bool == true then
			CrabHub:Notify("Discord invite", "Copied to your clipboard")
		else
			CrabHub:Notify("Jokes on you", "Copied anyway")
		end
		setclipboard("https://discord.gg/JSjpgSPs4v")
	end)
end)

if game.PlaceId == 5324597737 or game.PlaceId == 5832683990 then
	game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("LoadingScreen"):WaitForChild("Gui")
	if game:GetService("Players").LocalPlayer.PlayerGui.LoadingScreen:FindFirstChild("MainFrame") then
		local l__ReplicatedStorage__9 = game:GetService("ReplicatedStorage")
		game.Players.LocalPlayer.PlayerScripts.Fly.Disabled = false;
		l__ReplicatedStorage__9.Loader:FireServer(2);
		game:GetService("Players").LocalPlayer.PlayerGui.LoadingScreen.Gui.Value = "pc";
		l__ReplicatedStorage__9.Control:FireServer("pc");
		game:GetService("Players").LocalPlayer.PlayerGui.LoadingScreen.MainFrame:Destroy()
	end

	local Main = CrabHub:addPage("Main", 5012544693)
	local AutoFarm = Main:addSection("AutoFarm")
	local Fun = Main:addSection("Fun")

	local function Transform()
        if Player.Character:WaitForChild("Data"):WaitForChild("Transformation").Value == _G.VariablesTable.FormName then
        elseif Player.Character:WaitForChild("Data"):WaitForChild("Transformation").Value == nil or Player.Character:WaitForChild("Data"):WaitForChild("Transformation").Value == "" then
            game:GetService("ReplicatedStorage").Transform:FireServer(_G.VariablesTable.FormName)
        elseif Player.Character:WaitForChild("Data"):WaitForChild("Transformation").Value ~= _G.VariablesTable.FormName then
            game:GetService("ReplicatedStorage").Transform:FireServer(_G.VariablesTable.FormName)
            game:GetService("ReplicatedStorage").Transform:FireServer(_G.VariablesTable.FormName)
        end
    end

    local NpcToFarm = nil
	if not _G.VariablesTable.HitBoxSize then
		_G.VariablesTable.HitBoxSize = 20
		SaveSettings()
	end
    local function AutoFarmDBE()
        while _G.VariablesTable.AutoFarmDBE == true and _G.VariablesTable.NpcName do wait(1)
            if PlayerCheck() then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(2964.28, 32.2051, 2233.63)
                for i, v in pairs(Player.Character:GetDescendants()) do
                    pcall(function()
                        v.Anchored = true
                    end)
                end
                Player.Character.HumanoidRootPart.CanCollide = true
                Player.Character.HumanoidRootPart.Transparency = 0
                for i, v in pairs(Player.Character:GetDescendants()) do
                    if v.Name == "HealthGui" or v.Name == "ScouterGui" or (v.Name == "Root" and v.Parent == Player.Character.LowerTorso) then
                        v:Destroy()
                    end
                end
                for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do 
                    if v.Name == _G.VariablesTable.NpcName and v:FindFirstChild("Humanoid") and v:FindFirstChild("Stats") and v:FindFirstChild("Data") then
                        if v.Humanoid.Health > 0 then
                            NpcToFarm = v
                            break
                        else
                            NpcToFarm = nil
                        end
                    end
                end
                if NpcToFarm and _G.VariablesTable.AutoFarmDBE == true then
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(NpcToFarm:GetModelCFrame().Position)
                    Player.Character.HumanoidRootPart.Anchored = true
                    NpcToFarm:WaitForChild("HumanoidRootPart")
                end
                local Broken = false
                local CPosition
                while _G.VariablesTable.AutoFarmDBE == true and NpcToFarm and NpcToFarm.Humanoid.Health > 0 and not Broken do FastWait()
                    if PlayerCheck() then
                        if Player.Character.HumanoidRootPart.Anchored == true then
                            Player.Character.HumanoidRootPart.Anchored = false
                        end

                        if NpcToFarm:FindFirstChild("Humanoid") then
                            pcall(function()
                                Player.PlayerGui.NewMain.staminabar.TextLabel.Text = "Health: " .. math.ceil(NpcToFarm.Humanoid.Health)
                            end)
                        end

                        local ActualCFrame = NpcToFarm.HumanoidRootPart.CFrame.Position
                        local StillTheSame = true
                        if ActualCFrame == CPosition and not (NpcToFarm.Humanoid.Health == NpcToFarm.Humanoid.MaxHealth) and not (NpcToFarm.Humanoid.Health <= 0) and (NpcToFarm.Data.MoveState.Value == "CanMove") then
                            spawn(function()
                                wait(3)
                                if StillTheSame then
                                    Broken = true
                                end
                            end)
                        end
                        if not (ActualCFrame == CPosition) then
                            StillTheSame = false
                        end

                        CPosition = NpcToFarm.HumanoidRootPart.CFrame.Position

                        Transform()
                        Player.Character.HumanoidRootPart.CFrame = CFrame.new(NpcToFarm.HumanoidRootPart.CFrame.Position - (NpcToFarm.HumanoidRootPart.CFrame.LookVector * (_G.VariablesTable.HitBoxSize/2)))
                        NpcToFarm.HumanoidRootPart.Size = Vector3.new(_G.VariablesTable.HitBoxSize, _G.VariablesTable.HitBoxSize, _G.VariablesTable.HitBoxSize)
                        NpcToFarm.HumanoidRootPart.Transparency = 0.5
                        Player.Backpack:WaitForChild("Combat"):WaitForChild("RemoteEvent"):FireServer("comboAttack")
                    end
                end
                Broken = false
            end
        end
    end

    spawn(AutoFarmDBE)

    local function AutoHtcDBE()
        if game.PlaceId == 5832683990 then
        elseif _G.VariablesTable.AutoHtcDBE then
            CrabHub:Notify("Teleporting", "Wait a second...")
            game:GetService("TeleportService"):Teleport(5832683990, Player)
        end
        local NpcToFarm = game:GetService("Workspace"):WaitForChild("Aetherius Boss")

        while _G.VariablesTable.AutoHtcDBE do wait(1)
            while _G.VariablesTable.AutoHtcDBE == true do FastWait()
                if PlayerCheck() then
                    if not NpcToFarm or NpcToFarm.Humanoid.Health <= 0 then
                        break
                    end

                    Transform()
                    
                    NpcToFarm.HumanoidRootPart.Size = Vector3.new(_G.VariablesTable.HitBoxSize, _G.VariablesTable.HitBoxSize, _G.VariablesTable.HitBoxSize)
                    NpcToFarm.HumanoidRootPart.CFrame = CFrame.new(-15.7113, 50.9, -4.9043)
                    NpcToFarm.HumanoidRootPart.Transparency = 0.5
                    NpcToFarm.HumanoidRootPart.CanCollide = false

                    Player.Character.HumanoidRootPart.Anchored = true
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(NpcToFarm.HumanoidRootPart.CFrame.Position - (NpcToFarm.HumanoidRootPart.CFrame.LookVector * (_G.VariablesTable.HitBoxSize/2)))
                    Player.Backpack.Combat.RemoteEvent:FireServer("comboAttack")
                end
            end
        end
    end

    spawn(AutoHtcDBE)

	AutoFarm:addToggle("AutoFarm", (_G.VariablesTable.AutoFarmDBE == true and _G.VariablesTable.NpcName), function(bool)
        _G.VariablesTable.AutoFarmDBE = bool
		SaveSettings()
		AutoFarmDBE()
	end)

	AutoFarm:addSlider("HitBox Size", 20, 5, 150, function(chosen)
		_G.VariablesTable.HitBoxSize = chosen
	end)

    local NpcTable = {}
    local Number = 0
    for i, v in pairs(game.Workspace:GetDescendants()) do
        if v:FindFirstChild("Data") and v:FindFirstChild("Stats") and v:FindFirstChild("Humanoid") then
            if not table.find(NpcTable, v.Name) then
                NpcTable[Number + 1] = v.Name
                Number = Number + 1
            end
        end
    end

	local FormTable = {}
    for i, v in pairs(Player.Transformations:GetChildren()) do
        FormTable[i + 1] = string.lower(v.Name)
    end

	AutoFarm:addDropdown("Form", FormTable, function(chosen)
        _G.VariablesTable.FormName = chosen
        SaveSettings()
    end)

	local NpcDropDown = AutoFarm:addDropdown("NpcToFarm", NpcTable, function(chosen)
        _G.VariablesTable.NpcName = chosen
        SaveSettings()
	end)

	AutoFarm:addButton("Refresh", function()
		local NewNpcTable = {}
        local Number = 0
        for i, v in pairs(game.Workspace:GetDescendants()) do
            if v:FindFirstChild("Data") and v:FindFirstChild("Stats") and v:FindFirstChild("Humanoid") then
                if not table.find(NewNpcTable, v.Name) then
                    NewNpcTable[Number + 1] = v.Name
                    Number = Number + 1
                end
            end
        end
		AutoFarm:updateDropdown(NpcDropDown, "NpcToFarm", NewNpcTable, function(chosen)
			_G.VariablesTable.NpcName = chosen
            SaveSettings()
		end)
	end)

	AutoFarm:addToggle("AutoHTC", (_G.VariablesTable.AutoHtcDBE), function(bool)
        _G.VariablesTable.AutoHtcDBE = bool
		SaveSettings()
		AutoHtcDBE()
	end)

    local function GtaDBE()
        while _G.VariablesTable.GtaDBE do
            game:GetService("ReplicatedStorage").KiBlast:FireServer(1, false)
            game:GetService("RunService").Heartbeat:wait()
            game:GetService("ReplicatedStorage").KiBlast:FireServer(1, true)    
        end
    end

    spawn(GtaDBE)

    Fun:addToggle("GTA", (_G.VariablesTable.GtaDBE), function(bool)
        _G.VariablesTable.GtaDBE = bool
		SaveSettings()
		GtaDBE()
    end)

elseif game.PlaceId == 4988816744 then

    local Main = CrabHub:addPage("Main", 5012544693)
	local AutoFarm = Main:addSection("AutoFarm")
	local Fun = Main:addSection("Fun")

    local function AutoSpeedOPS()
        while _G.VariablesTable.AutoSpeedOPS do wait()
            game:GetService("ReplicatedStorage").Events.GiverSpeed_Client_Event:FireServer()
        end
    end

    spawn(AutoSpeedOPS)

    AutoFarm:addToggle("Auto Speed", _G.VariablesTable.AutoSpeedOPS, function(bool)
        _G.VariablesTable.AutoSpeedOPS = bool
        SaveSettings()
        AutoSpeedOPS()
    end)

    local function AutoTrainOPS()
        while _G.VariablesTable.AutoTrainOPS do wait()
            game:GetService("ReplicatedStorage").Events.GiverPower_Client_Event:FireServer()
        end
    end

    spawn(AutoTrainOPS)

    AutoFarm:addToggle("Auto Train", _G.VariablesTable.AutoTrainOPS, function(bool)
        _G.VariablesTable.AutoTrainOPS = bool
        SaveSettings()
        AutoTrainOPS()
    end)

    local NpcTable = {}
    local a = 0

    for _, Folder in pairs(game:GetService("Workspace").Dummys:GetChildren()) do
        for i, Dummy in pairs(Folder:GetChildren()) do
            if not table.find(NpcTable, Dummy.Name) then
                NpcTable[a + 1] = Dummy.Name
                a = a + 1
            end
        end
    end

    local NpcDropdown = AutoFarm:addDropdown("Npc to farm", NpcTable, function(chosen)
        _G.VariablesTable.NpcToFarmOPS = chosen
        SaveSettings()
    end)

    AutoFarm:addButton("Refresh", function()

        local NewTable = {}
        local a = 0

        for _, Folder in pairs(game:GetService("Workspace").Dummys:GetChildren()) do
            for i, Dummy in pairs(Folder:GetChildren()) do
                if not table.find(NpcTable, Dummy.Name) then
                    NpcTable[a + 1] = Dummy.Name
                    a = a + 1
                end
            end
        end

        AutoFarm:updateDropdown(NpcDropdown, "Npc to farm", NewTable, function(chosen)
            _G.VariablesTable.NpcToFarmOPS = chosen
            SaveSettings()
        end)
    end)

    local function AutofarmOPS()
        local NpcToFarm = nil
        for i, v in pairs(game:GetService("Workspace").Dummys:GetDescendants()) do
            if v.Name == _G.VariablesTable.NpcToFarmOPS then
                NpcToFarm = v
                break
            end
        end
        while _G.VariablesTable.AutofarmOPS do FastWait()
            if PlayerCheck() then
                Player.Character.HumanoidRootPart.CFrame = NpcToFarm.Torso.CFrame
                if Player.Backpack:FindFirstChild("Punch") then
                    Player.Character:WaitForChild("Humanoid"):EquipTool(Player.Backpack.Punch)
                end
                Player.Character:WaitForChild("Punch"):Activate()
            end
        end
    end

    spawn(AutofarmOPS)

    AutoFarm:addToggle("Autofarm", _G.VariablesTable.AutofarmOPS, function(bool)
        _G.VariablesTable.AutofarmOPS = bool
        SaveSettings()
        AutofarmOPS()
    end)

    local function HideNameOPS()
        while _G.VariablesTable.HideNameOPS do wait(1)
            if PlayerCheck() then
                if Player.Character.HumanoidRootPart:FindFirstChild("RootBillBoard") then
                    Player.Character.HumanoidRootPart.RootBillBoard:Destroy()
                end
            end
        end
    end

    AutoFarm:addToggle("HideName", _G.VariablesTable.HideNameOPS, function(bool)
        _G.VariablesTable.HideNameOPS = bool
        SaveSettings()
        HideNameOPS()
    end)

elseif game.PlaceId == 4042427666 or game.PlaceId == 5113680396 or game.PlaceId == 5113678354 or game.PlaceId == 6479720355 or game.PlaceId == 5445525505 then
    local Main = CrabHub:addPage("Main", 5012544693)
	local AutoFarm = Main:addSection("AutoFarm")

    local function AutoChikaraAFS() 
        while _G.VariablesTable.AutoChikaraAFS do
            for i, v in pairs(game:GetService("Workspace").MouseIgnore:GetDescendants()) do
                if v:IsA("ClickDetector") and v.Parent.Name == "ClickBox" and v.Parent.Parent.Name == "ChikaraCrate" then
                    while game:IsAncestorOf(v) and _G.VariablesTable.AutoChikaraAFS do game:GetService("RunService").Heartbeat:wait()
                        pcall(function()
                            if PlayerCheck() then
                                Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
                                fireclickdetector(v, 0)
                            end
                        end)
                    end
                end
            end
        end
    end

    AutoFarm:addToggle("AutoChikara", _G.VariablesTable.AutoChikaraAFS, function(bool)
        _G.VariablesTable.AutoChikaraAFS = bool
        SaveSettings()
        AutoChikaraAFS()
    end)

    spawn(AutoChikaraAFS)

    local function AutoFarmAFS()
        while _G.VariablesTable.AutoFarmAFS and _G.VariablesTable.StatAFS do game:GetService("RunService").Heartbeat:wait()
            local args = {
                [1] = "Stat",
                [2] = _G.VariablesTable.StatAFS
            }
            
            game:GetService("ReplicatedStorage").RSPackage.Events.StatFunction:InvokeServer(unpack(args))
        end
    end

    spawn(AutoFarmAFS)

    local Stats = {"Strength", "Durability", "Chakra", "Sword"}

    AutoFarm:addDropdown("Stat to farm", Stats, function(chosen)
        _G.VariablesTable.StatAFS = chosen
        SaveSettings()
    end)

    AutoFarm:addToggle("Autofarm", _G.VariablesTable.AutoFarmAFS, function(bool)
        _G.VariablesTable.AutoFarmAFS = bool
        SaveSettings()
        AutoFarmAFS()
    end)
elseif game.PlaceId == 6461766546 then

    local Main = CrabHub:addPage("Main", 5012544693)
	local AutoFarm = Main:addSection("AutoFarm")

    local function QuestCheck()
        if not Player:FindFirstChild("Quest") then
            return false
        end
        if Player.Quest.Number.Value == _G.VariablesTable.QuestNumberAHD then
            return true
        end
        return false
    end

    local function AutoFarmAHD()
        while _G.VariablesTable.AutoFarmAHD do FastWait()
            local Mod = require(game:GetService("ReplicatedStorage").Modules.Quests)
            local NpcName = Mod[_G.VariablesTable.QuestNumberAHD]["Target"]
            local QuestName = "Quest ".._G.VariablesTable.QuestNumberAHD
            while not QuestCheck() do FastWait()
                if PlayerCheck() then
                    Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").StaticHumanoids[QuestName].QuestPart.CFrame
                    local args = {
                        [1] = "GetQuest",
                        [2] = _G.VariablesTable.QuestNumberAHD
                    }
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                end
            end
            for i, v in pairs(game:GetService("Workspace").Spawns:GetChildren()) do
                if v:FindFirstChild(NpcName) and PlayerCheck() and QuestCheck() then
                    Player.Character.HumanoidRootPart.CFrame = v.CFrame
                    while _G.VariablesTable.AutoFarmAHD do FastWait()
                        if PlayerCheck() then
                            if v:FindFirstChild(NpcName) then
                                Player.Character.HumanoidRootPart.CFrame = v[NpcName]:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(v[NpcName]:WaitForChild("HumanoidRootPart").CFrame.LookVector * 2)
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                                for i=1, 5 do
                                    if _G.VariablesTable[tostring(i)] then
                                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(string.gsub(Player.Stats.Class.Value.. "Attack"..i, " ", ""), v[NpcName]:WaitForChild("HumanoidRootPart").Position)
                                    end
                                end
                            else
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    spawn(AutoFarmAHD)

    AutoFarm:addToggle("Autofarm", _G.VariablesTable.AutoFarmAHD, function(bool)
        _G.VariablesTable.AutoFarmAHD = bool
        SaveSettings()
        AutoFarmAHD()
    end)

    local Table = {}
    for i=1, #require(game:GetService("ReplicatedStorage").Modules.Quests) do
        Table[i] = i
    end

    AutoFarm:addDropdown("Quest", Table, function(chosen)
        _G.VariablesTable.QuestNumberAHD = chosen
        SaveSettings()
    end)

    local function AutoTrainAHD()
        while _G.VariablesTable.AutoTrainAHD do FastWait()
            if PlayerCheck() then
                local args = {
                    [1] = "Train"
                }
                
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
            end
        end
    end

    spawn(AutoTrainAHD)

    AutoFarm:addToggle("Auto train", _G.VariablesTable.AutoTrainAHD, function(bool)
        _G.VariablesTable.AutoTrainAHD = bool
        SaveSettings()
        AutoTrainAHD()
    end)

    local Settings = Main:addSection("Settings")

    Settings:addToggle("Move E", _G.VariablesTable["1"], function(bool)
        _G.VariablesTable["1"] = bool
        SaveSettings()
    end)

    Settings:addToggle("Move R", _G.VariablesTable["2"], function(bool)
        _G.VariablesTable["2"] = bool
        SaveSettings()
    end)

    Settings:addToggle("Move C", _G.VariablesTable["5"], function(bool)
        _G.VariablesTable["5"] = bool
        SaveSettings()
    end)

    Settings:addToggle("Move F", _G.VariablesTable["3"], function(bool)
        _G.VariablesTable["3"] = bool
        SaveSettings()
    end)

    local function StaminaAHD()
        while _G.VariablesTable.StaminaAHD do FastWait()
            if PlayerCheck() then
                if Player.Character:WaitForChild("CurrentStamina").Value <= 10 then
                    Player.Character.Humanoid.Health = 0
                end
            end
        end
    end

    spawn(StaminaAHD)

    Settings:addToggle("Reset when low stamina", _G.VariablesTable.StaminaAHD, function(bool)
        _G.VariablesTable.StaminaAHD = bool
        SaveSettings()
        StaminaAHD()
    end)

    local Class = Main:addSection("Class")

    Class:addButton("Instant spin", function()
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
    end)
end




-- load
local themes = {
	Background = Color3.fromRGB(84, 101, 116),
	Glow = Color3.fromRGB(233, 234, 236),
	Accent = Color3.fromRGB(255, 232, 76),
	LightContrast = Color3.fromRGB(144, 173, 198),
	DarkContrast = Color3.fromRGB(51, 54, 82),  
	TextColor = Color3.fromRGB(250, 208, 44)
}
for theme, color in pairs(themes) do
	CrabHub:setTheme(theme, color)
end
CrabHub:SelectPage(CrabHub.pages[1], true)
