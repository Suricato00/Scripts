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

Config:addButton("Delete Config File", function()
    delfile(FileName)
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

local Informations = General:addSection("Current Game Supported")
local GameSupported = {"Dragon Ball Evolution", "One Punch simulator", "Anime Fighting Simulator", "A Hero's Destiny", "Anime Tappers"}
for i, v in pairs(GameSupported) do
    Informations:addButton(v)
end


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

	AutoFarm:addDropdown(_G.VariablesTable.FormName or "Form", FormTable, function(chosen)
        _G.VariablesTable.FormName = chosen
        SaveSettings()
    end)

	local NpcDropDown = AutoFarm:addDropdown(_G.VariablesTable.NpcName or "NpcToFarm", NpcTable, function(chosen)
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
	local QuestFarm = Main:addSection("QuestFarm")

    local function QuestCheck(QuestNumber)
        if not Player:FindFirstChild("Quest") then
            return false
        end
        if Player.Quest.Number.Value == QuestNumber then
            return true
        end
        return false
    end

    local function QuestFarmAHD()
        while _G.VariablesTable.QuestFarmAHD do FastWait()
            local Mod = require(game:GetService("ReplicatedStorage").Modules.Quests)
            local NpcName = Mod[_G.VariablesTable.QuestNumberAHD]["Target"]
            local QuestName = "Quest ".._G.VariablesTable.QuestNumberAHD
            while not QuestCheck(_G.VariablesTable.QuestNumberAHD) do FastWait()
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
                if v:FindFirstChild(NpcName) and PlayerCheck() and QuestCheck(_G.VariablesTable.QuestNumberAHD) then
                    Player.Character.HumanoidRootPart.CFrame = v.CFrame
                    while _G.VariablesTable.QuestFarmAHD do FastWait()
                        if PlayerCheck() then
                            if v:FindFirstChild(NpcName) then
                                Player.Character.HumanoidRootPart.CFrame = CFrame.new(v[NpcName]:WaitForChild("HumanoidRootPart").CFrame.Position - v[NpcName]:WaitForChild("HumanoidRootPart").CFrame.LookVector * 2, v[NpcName]:WaitForChild("HumanoidRootPart").CFrame.Position)
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                                for i=1, 5 do
                                    if _G.VariablesTable[tostring(i).."AHD"] then
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

    spawn(QuestFarmAHD)

    QuestFarm:addToggle("QuestFarm", _G.VariablesTable.QuestFarmAHD, function(bool)
        _G.VariablesTable.QuestFarmAHD = bool
        SaveSettings()
        QuestFarmAHD()
    end)

    local Table = {}
    for i=1, #require(game:GetService("ReplicatedStorage").Modules.Quests) do
        Table[i] = i
    end

    QuestFarm:addDropdown(_G.VariablesTable.QuestNumberAHD or "Quest", Table, function(chosen)
        _G.VariablesTable.QuestNumberAHD = chosen
        SaveSettings()
    end)

    local MultipleBossFarm = Main:addSection("Multiple Boss Farm")

    local function BossFarmAHD()
        while _G.VariablesTable.BossFarmAHD do FastWait()
            local Mod = require(game:GetService("ReplicatedStorage").Modules.Quests)
            local QuestNumber = nil
            local Npc = nil
            while not QuestNumber and not Npc and _G.VariablesTable.BossFarmAHD do wait()
                for i1, v1 in pairs(Mod) do
                    for i, v in pairs(_G.VariablesTable.BossTableAHD) do
                        if v1.Target == v then
                            if game:GetService("Workspace").Spawns:FindFirstChild(v):FindFirstChild(v) then
                                QuestNumber = i1
                                Npc = game:GetService("Workspace").Spawns:FindFirstChild(v):FindFirstChild(v)
                                break
                            end
                        end
                    end
                end
            end
        
            local QuestName = "Quest "..QuestNumber
        
            while not QuestCheck(QuestNumber) and _G.VariablesTable.BossFarmAHD do FastWait()
                if PlayerCheck() then
                    Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").StaticHumanoids[QuestName].QuestPart.CFrame
                    local args = {
                        [1] = "GetQuest",
                        [2] = QuestNumber
                    }
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                end
            end
        
            while _G.VariablesTable.BossFarmAHD do FastWait()
                if PlayerCheck() then
                    if game:IsAncestorOf(Npc) then
                        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Npc:WaitForChild("HumanoidRootPart").CFrame.Position - Npc:WaitForChild("HumanoidRootPart").CFrame.LookVector * 2, Npc:WaitForChild("HumanoidRootPart").CFrame.Position)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Punch", "Right")
                        if Player.Stats.Class.Value == "Angel" then
                            Player.Stats.Class.Value = "PuriPuri"
                        end
                        for i=1, 5 do
                            if _G.VariablesTable[tostring(i).."AHD"] then
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer(string.gsub(Player.Stats.Class.Value.. "Attack"..i, " ", ""), Npc:WaitForChild("HumanoidRootPart").Position)
                            end
                        end
                        if PlayerCheck() and Player:WaitForChild("Stats"):WaitForChild("Level").Value >= 200 then
                            while Player.Character:FindFirstChild("Form") and _G.VariablesTable.BossFarmAHD do 
                                if PlayerCheck() then
                                    local Mod = require(Player.PlayerGui.Cooldown.CooldownBackground.Input.LocalAttacks)
                                    if Player.Character.Form.Value == nil or Player.Character.Form.Value == "" or Player.Character.Form.Value == " " then
                                        Mod[string.gsub(Player.Stats.Class.Value.. "Attack"..6, " ", "")]()
                                        wait(0.5)
                                    else
                                        break
                                    end
                                    FastWait()
                                else break
                                end
                            end
                        end
                    else
                        break
                    end
                end
            end
        end
    end

    spawn(BossFarmAHD)

    MultipleBossFarm:addToggle("Bosses Farm", _G.VariablesTable.BossFarmAHD, function(bool)
        _G.VariablesTable.BossFarmAHD = bool
        SaveSettings()
        BossFarmAHD()
    end)

    local AllBosses = {}
    for i,v in pairs(require(game:GetService("ReplicatedStorage").Modules.Quests)) do
        if v.Amount == 1 then
            AllBosses[i] = v.Target
        end
    end

    if not _G.VariablesTable.BossTableAHD then
        _G.VariablesTable.BossTableAHD = {}
    end

    MultipleBossFarm:addDropdown("All bosses", AllBosses, function(chosen)
        for i, v in pairs(_G.VariablesTable.BossTableAHD) do
            if v == chosen then
                return
            end
        end
        _G.VariablesTable.BossTableAHD[#_G.VariablesTable.BossTableAHD + 1] = chosen
        SaveSettings()
    end)


    MultipleBossFarm:addDropdown("Selected", _G.VariablesTable.BossTableAHD, function(chosen)
        for i, v in pairs(_G.VariablesTable.BossTableAHD) do
            if v == chosen then
                table.remove(_G.VariablesTable.BossTableAHD, i)
            end
        end
        MultipleBossFarm:updateDropdown("Selected", "Selected", _G.VariablesTable.BossTableAHD)
        SaveSettings()
    end)

    local Settings = Main:addSection("Settings")

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

    Settings:addToggle("Auto train", _G.VariablesTable.AutoTrainAHD, function(bool)
        _G.VariablesTable.AutoTrainAHD = bool
        SaveSettings()
        AutoTrainAHD()
    end)

    local function AutoPunchAHD()
        while _G.VariablesTable.AutoPunchAHD do FastWait()
            local connections = getconnections(Player:GetMouse().Button1Down)
            while not connections[4] do wait()
            end
            if PlayerCheck() then
                connections[1]:Fire()
                debug.setupvalue(connections[1].Function, 1, false)
                debug.setupvalue(connections[1].Function, 4, false)
            elseif not PlayerCheck() then
                Player.CharacterAdded:Wait()
                wait(0.5)
            end
        end
    end

    spawn(AutoPunchAHD)

    Settings:addToggle("Auto Punch", _G.VariablesTable.AutoPunchAHD, function(bool)
        _G.VariablesTable.AutoPunchAHD = bool
        SaveSettings()
        AutoPunchAHD()
    end)

    Settings:addToggle("Move E", _G.VariablesTable["1AHD"], function(bool)
        _G.VariablesTable["1AHD"] = bool
        SaveSettings()
    end)

    Settings:addToggle("Move R", _G.VariablesTable["2AHD"], function(bool)
        _G.VariablesTable["2AHD"] = bool
        SaveSettings()
    end)

    Settings:addToggle("Move C", _G.VariablesTable["5AHD"], function(bool)
        _G.VariablesTable["5AHD"] = bool
        SaveSettings()
    end)

    Settings:addToggle("Move F", _G.VariablesTable["3AHD"], function(bool)
        _G.VariablesTable["3AHD"] = bool
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

    local function NoSlowAHD()
        while _G.VariablesTable.NoSlowAHD do FastWait()
            Player:WaitForChild("Stats"):WaitForChild("CanAttack").Value = true
            if PlayerCheck() then
                Player.Character.HumanoidRootPart.Anchored = false
            end
        end
    end

    spawn(NoSlowAHD)

    Settings:addToggle("NoSlow", _G.VariablesTable.NoSlowAHD, function(bool)
        _G.VariablesTable.NoSlowAHD = bool
        SaveSettings()
        NoSlowAHD()
    end)

    local function HealthAHD()
        while _G.VariablesTable.HealthAHD do FastWait()
            if PlayerCheck() then
                if Player.Stats.Attributes.Value > 0 then
                    local args = {
                        [1] = "UpgradeHealth",
                        [2] = 1
                    }
                    
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                end
            end
        end
    end

    spawn(HealthAHD)

    Settings:addToggle("Auto add health", _G.VariablesTable.HealthAHD, function(bool)
        _G.VariablesTable.HealthAHD = bool
        SaveSettings()
        HealthAHD()
    end)

    local Class = Main:addSection("Class")

    Class:addButton("Instant spin", function()
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
    end)

    Class:addButton("Buy all spins", function()
        local args = {
            [1] = "PurchaseSpinAll"
        }
        
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    end)

    local function AutoSpinAHD()
        while _G.VariablesTable.AutoSpinAHD do FastWait()
            if PlayerCheck() then
                for i, v in pairs(_G.VariablesTable.ClassTableAHD) do
                    if game:GetService("Players").LocalPlayer.Stats.Class.Value == v then
                        return
                    end
                end
                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
            end
        end
    end

    Class:addToggle("Auto Spin", _G.VariablesTable.AutoSpinAHD, function(bool)
        _G.VariablesTable.AutoSpinAHD = bool
        SaveSettings()
        AutoSpinAHD()
    end)

    local ClassTable = {}

    for i, v in pairs(require(game:GetService("ReplicatedStorage").Modules.Classes)["Normal"]) do
        ClassTable[i] = v.Item
    end

    if not _G.VariablesTable.ClassTableAHD then
        _G.VariablesTable.ClassTableAHD = {}
    end

    Class:addDropdown("All classes", ClassTable, function(chosen)
        for i, v in pairs(_G.VariablesTable.ClassTableAHD) do
            if v == chosen then
                return
            end
        end
        _G.VariablesTable.ClassTableAHD[#_G.VariablesTable.ClassTableAHD + 1] = chosen
        SaveSettings()
    end)

    Class:addDropdown("Selected", _G.VariablesTable.ClassTableAHD, function(chosen)
        for i, v in pairs(_G.VariablesTable.ClassTableAHD) do
            if v == chosen then
                table.remove(_G.VariablesTable.ClassTableAHD, i)
            end
        end
        Class:updateDropdown("Selected", "Selected", _G.VariablesTable.ClassTableAHD)
        SaveSettings()
    end)
elseif game.PlaceId == 7429434108 or game.PlaceId == 7834860976 then
    local Main = CrabHub:addPage("Main", 5012544693)
	local AutoFarm = Main:addSection("AutoFarm")

    local function AutoClickAT()

        while _G.VariablesTable.AutoClickAT do FastWait()
            game:GetService("ReplicatedStorage").Remotes.Events.Tap:FireServer()
        end
    end

    spawn(AutoClickAT)

    AutoFarm:addToggle("Auto Clicker", _G.VariablesTable.AutoClickAT, function(bool)
        _G.VariablesTable.AutoClickAT = bool
        SaveSettings()
        AutoClickAT()
    end)

    local function AutoCollectYenAT()
        while _G.VariablesTable.AutoCollectYenAT do FastWait()
            for i, v in pairs(game:GetService("Workspace").Worlds.StarterWorld.Yen:GetChildren()) do
                while game:IsAncestorOf(v) and PlayerCheck() and _G.VariablesTable.AutoCollectYenAT do FastWait()
                    local Handle = v:FindFirstChild("Handle")
                    if Handle then
                        Player.Character.HumanoidRootPart.CFrame = Handle.CFrame
                    end
                end
            end
        end
    end

    spawn(AutoCollectYenAT)

    AutoFarm:addToggle("Auto Collect Yen", _G.VariablesTable.AutoCollectYenAT, function(bool)
        _G.VariablesTable.AutoCollectYenAT = bool
        SaveSettings()
        AutoCollectYenAT()
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
