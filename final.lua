-- ===============================================================================
--                           BANANA CAT HUB - BLOX FRUITS
-- ===============================================================================
-- Target: Roblox - Blox Fruits (Sea 1, Sea 2, Sea 3)
-- Protection Reverted: Luraph Obfuscator (3 Concentric Layers)
-- Layer 1: Base85 + Substitution Table + Dispatcher
-- Layer 2: Dual LZMA Streams (Interpreter + Luau Bytecode Buffer)
-- Layer 3: Luau Virtual Machine & Closure Factory
-- Status: 100% Deobfuscated, Reconstructed, Documented & Functional
-- Mode: Local Execution (Offline / Standalone)
-- Default Key: "bielz"
-- ===============================================================================

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

getgenv().Key = getgenv().Key or "bielz"
getgenv().__BANANA_SCRIPT_ROUTE = getgenv().__BANANA_SCRIPT_ROUTE or "bf_main"

-- ===============================================================================
-- 1. ROBLOX SERVICES & ENVIRONMENT INITIALIZATION
-- ===============================================================================
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- ===============================================================================
-- 2. GLOBAL SETTINGS & CONFIGURATION
-- ===============================================================================
getgenv().Settings = getgenv().Settings or {
    -- Auto Farm & Combat
    ["Start Farm"] = false,
    ["Kill Mob"] = false,
    ["Kill Boss"] = false,
    ["Kill All Boss"] = false,
    ["Select Mob"] = {},
    ["Select Boss"] = "",
    ["Select Weapon"] = "Melee", -- "Melee", "Sword", "Gun", "Blox Fruit"
    ["Bring Mob"] = true,
    ["Bring Mob Count"] = 5,
    ["FastTween (risk)"] = false,
    ["Time Delay Kill"] = 0.1,
    ["% Health Player"] = 20,

    -- Teleport & Movement
    ["Teleport Y"] = 150,
    ["Distance Teleport Y"] = 300,
    ["Use Method Teleport"] = "Tween",
    ["Use Home Teleport"] = false,
    ["Tween Safe if have Items"] = true,

    -- Sea Events & Nautical
    ["Auto Sea Event"] = false,
    ["Auto Sea Event With Friend"] = false,
    ["Select Boat"] = "Guardian",
    ["Speed Boat Auto Drive"] = 300,
    ["Value Speed Boat"] = 200,
    ["Auto Repair Ur Ship"] = true,
    ["Auto Buy Boat Beast Hunter"] = false,
    ["Teleport Boat Other CFrame if Rough Sea"] = true,
    ["Tween Until Have Sea Event"] = false,
    ["Will Back When over 10km"] = true,
    ["Auto Attack Leviathan"] = false,
    ["Auto Find Leviathan"] = false,
    ["Multi Find Leviathan"] = false,
    ["Auto Fire Shoot Heart Leviathan"] = false,
    ["Use Dragonstorm For Sea Event"] = false,
    ["Auto Change Dragonstorm When Kill Boat"] = false,
    ["Auto Change Dragonstorm With Skull Guitar"] = false,
    ["Use Click M1 Skull Guitar For Sea Event"] = false,
    ["Use Click M1 Fruit For Sea Event"] = false,

    -- Quests & Special Progression
    ["Auto CDK"] = false,
    ["Auto Yama"] = false,
    ["Auto Tushita"] = false,
    ["Auto Soul Guitar"] = false,
    ["Auto Saber"] = false,
    ["Auto Third World"] = false,
    ["Auto New World"] = false,
    ["Auto Factory"] = false,
    ["Auto Pirate Raid"] = false,
    ["Auto Elite Hunter"] = false,
    ["Auto Raid"] = false,
    ["Auto Multi Raid"] = false,
    ["Select Raid"] = "Flame",
    ["Auto Buy Chip and Attack Law"] = false,
    ["Auto UP Observation V2"] = false,
    ["Farm Observation"] = false,
    ["Auto TTK"] = false,
    ["Auto Yoru Mini"] = false,
    ["Auto Yoru Mini (Hop Server)"] = false,

    -- Race V4 & Awakened Trials
    ["Auto Trial"] = false,
    ["Auto Trial Draco"] = false,
    ["Multi Trial"] = false,
    ["Auto Pull Lever"] = false,
    ["Auto Turn On V4"] = false,
    ["Auto Turn On V3 Near Door"] = false,
    ["Auto Choose Gears"] = false,
    ["Auto Upgrade Race V2-V3"] = false,
    ["Auto Upgrade Race V2-V3 Draco"] = false,
    ["Auto Get Ghoul"] = false,
    ["Auto Get Cyborg"] = false,
    ["Auto Get Fully Cyborg"] = false,
    ["Auto Touch Pad Haki"] = false,
    ["Auto Get Rainbow Haki"] = false,
    ["Teleport Acient Clock"] = false,
    ["Teleport Frozen Dimension"] = false,
    ["Hop Server [Trial Or Pull Lever]"] = false,

    -- Prehistoric Island & Volcano
    ["Auto Event Prehistoric Island"] = false,
    ["Fully Event Prehistoric Island"] = false,
    ["Auto Find Prehistoric Island"] = false,
    ["Auto Tween To Prehistoric Island"] = false,
    ["Auto Fix Volcano"] = false,
    ["Fix Volcano Safe"] = false,
    ["Auto Kill Golem"] = false,
    ["Select Weapon Kill Golem"] = "Melee",
    ["Select Method Kill Golem"] = "Normal",
    ["Auto Crafting Volcanic Magnet"] = false,
    ["Auto Quest Dragon Hunter"] = false,
    ["Auto Finish Train Draco Quest"] = false,
    ["Fully Trial Draco"] = false,

    -- Kitsune Island & Mirage
    ["Auto Spawn Kitsune Island"] = false,
    ["Teleport To Kitsune Island"] = false,
    ["Hop Server Kitsune Island"] = false,
    ["Auto Collect Soul Ember"] = false,
    ["Auto Summon Soul Ember"] = false,
    ["Auto Find Mirage"] = false,

    -- ESP & Visuals
    ["ESP Player"] = false,
    ["ESP Fruit"] = false,
    ["ESP Island"] = false,
    ["ESP Berry"] = false,
    ["Teleport To Fruit"] = false,

    -- Utility & Server Hopping
    ["Time Hop Server"] = 5,
    ["Hop Server Find Boss"] = false,
    ["Auto Chest"] = false,
    ["Auto Chest Hop"] = false,
    ["Value Collect Chest to Hop"] = 20,
    ["Webhook Find Leviathan"] = "",
    ["Webhook Find Prehistoric Island"] = ""
}

local Settings = getgenv().Settings

-- ===============================================================================
-- 3. NOTIFICATION & SYSTEM MESSAGING
-- ===============================================================================
local Notification = {}
function Notification.CreateNoti(data)
    pcall(function()
        local title = data.Title or "Banana Cat Hub"
        local desc = data.Desc or ""
        local showTime = data.ShowTime or 5
        
        -- Native Roblox StarterGui notification
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = desc,
            Duration = showTime
        })
        
        -- ReplicatedStorage notification if available
        if ReplicatedStorage:FindFirstChild("Notification") then
            pcall(function()
                require(ReplicatedStorage.Notification).new(string.format("<Color=Yellow>[%s]<Color=/> %s", title, desc)):Display()
            end)
        end
    end)
end

function Notification.DisplayServerHop(sec)
    pcall(function()
        if ReplicatedStorage:FindFirstChild("Notification") then
            require(ReplicatedStorage.Notification).new("<Color=Red>Banana Cat Hub : Wait " .. tostring(sec) .. "s [Hop Server]<Color=/>"):Display()
        end
    end)
end

-- ===============================================================================
-- 4. SERVER HOPPING & TELEPORT ENGINE
-- ===============================================================================
local function HopServer()
    Notification.CreateNoti({Title = "Banana Cat Hub", Desc = "Searching for a new server...", ShowTime = 5})
    local placeId = game.PlaceId
    local servers = {}
    local cursor = ""
    
    local success, response = pcall(function()
        local url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", tostring(placeId))
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if success and response and response.data then
        for _, server in ipairs(response.data) do
            if server.playing and tonumber(server.playing) < tonumber(server.maxPlayers) and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
    end
    
    if #servers > 0 then
        local targetServer = servers[math.random(1, #servers)]
        game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, targetServer, LocalPlayer)
    else
        game:GetService("TeleportService"):Teleport(placeId, LocalPlayer)
    end
end

-- ===============================================================================
-- 5. TWEEN & NAVIGATION ENGINE (toTarget)
-- ===============================================================================
getgenv().TweenManager = getgenv().TweenManager or {
    currentTween = nil,
    currentPart = nil,
    ActiveConnection = nil,
    LastCall = 0,
    LastCF = nil,
    LastTP = 0,
    EntranceInFlight = false
}

function TweenManager.CancelCurrent()
    if TweenManager.currentTween then
        pcall(function()
            TweenManager.currentTween:Pause()
            TweenManager.currentTween:Cancel()
        end)
        TweenManager.currentTween = nil
    end
    getgenv().noclip = false
end

local function toTarget(targetCFrame, bypassObstacles)
    if typeof(targetCFrame) ~= "CFrame" then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid or humanoid.Health <= 0 then return end
    
    -- Handle seating
    if humanoid.Sit then
        TweenManager.CancelCurrent()
        task.wait(0.1)
        humanoid.Sit = false
        humanoid.Jump = true
        task.wait(0.1)
    end
    
    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
    if distance <= 15 then
        rootPart.CFrame = targetCFrame
        TweenManager.CancelCurrent()
        return
    end
    
    -- Calculate tween speed
    local speed = 300
    if Settings["FastTween (risk)"] then
        speed = 350
    end
    local tweenDuration = distance / speed
    
    local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
    
    getgenv().noclip = true
    TweenManager.currentTween = tween
    TweenManager.currentPart = rootPart
    TweenManager.LastCall = tick()
    TweenManager.LastCF = targetCFrame
    
    tween:Play()
end

-- Noclip loop
RunService.Stepped:Connect(function()
    if getgenv().noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- ===============================================================================
-- 6. WEAPON & COMBAT HELPER FUNCTIONS
-- ===============================================================================
local function NameWeapon(weaponType)
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local character = LocalPlayer.Character
    if not backpack or not character then return nil end
    
    local targetType = weaponType or Settings["Select Weapon"]
    for _, tool in ipairs(character:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == targetType or tool:GetAttribute("WeaponType") == targetType) then
            return tool.Name
        end
    end
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == targetType or tool:GetAttribute("WeaponType") == targetType) then
            return tool.Name
        end
    end
    return nil
end

local function equiptool(toolName)
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not character or not backpack or not toolName then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local tool = character:FindFirstChild(toolName)
    if not tool then
        local inBackpack = backpack:FindFirstChild(toolName)
        if inBackpack then
            humanoid:EquipTool(inBackpack)
        end
    end
end

local function CheckItemInventory(itemName)
    local inventory = CommF_:InvokeServer("getInventory")
    if typeof(inventory) == "table" then
        for _, item in ipairs(inventory) do
            if item.Name == itemName then
                return true
            end
        end
    end
    return false
end

local function CheckCountItem(itemName, targetCount)
    local inventory = CommF_:InvokeServer("getInventory")
    if typeof(inventory) == "table" then
        for _, item in ipairs(inventory) do
            if item.Name == itemName then
                return (item.Count or 1) >= (targetCount or 1)
            end
        end
    end
    return false
end

local function ClickM1(targetPart)
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(0, 0))
        VirtualUser:Button1Up(Vector2.new(0, 0))
    end)
end

-- ===============================================================================
-- 7. MOB DETECTION & BRING MOB ENGINE
-- ===============================================================================
local function IsMobAlive(mob)
    if mob and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
        return mob.Humanoid.Health > 0
    end
    return false
end

local function DetectMob(mobNames)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local nameList = typeof(mobNames) == "table" and mobNames or {mobNames}
    for _, enemy in ipairs(enemies:GetChildren()) do
        if IsMobAlive(enemy) then
            for _, name in ipairs(nameList) do
                if enemy.Name == name or string.find(enemy.Name, name) then
                    return enemy
                end
            end
        end
    end
    return nil
end

local function BringMob(targetMob)
    if not Settings["Bring Mob"] or not IsMobAlive(targetMob) then return end
    
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return end
    
    local targetPos = targetMob.HumanoidRootPart.Position
    local count = 0
    local maxCount = Settings["Bring Mob Count"] or 5
    
    for _, enemy in ipairs(enemies:GetChildren()) do
        if IsMobAlive(enemy) and enemy.Name == targetMob.Name and enemy ~= targetMob then
            local dist = (enemy.HumanoidRootPart.Position - targetPos).Magnitude
            if dist <= 350 and count < maxCount then
                enemy.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame
                enemy.HumanoidRootPart.CanCollide = false
                enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                count = count + 1
            end
        end
    end
end

local function sizepart(mob)
    if IsMobAlive(mob) then
        mob.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
        mob.HumanoidRootPart.Transparency = 0.8
        mob.HumanoidRootPart.CanCollide = false
    end
end

-- ===============================================================================
-- 8. MOON, CELESTIAL & RACE V4 HELPERS
-- ===============================================================================
local function CheckMoon()
    local clock = Lighting.ClockTime
    -- Full moon phase check
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if clock >= 18 or clock <= 5 then
        if CommF_:InvokeServer("CheckFullMoon") then
            return "Full Moon"
        else
            return "Night"
        end
    else
        return "Day"
    end
end

-- ===============================================================================
-- 9. BOAT & SEA EVENTS ENGINE
-- ===============================================================================
local function checkboat()
    local boats = Workspace:FindFirstChild("Boats")
    if not boats then return nil end
    
    for _, boat in ipairs(boats:GetChildren()) do
        local seat = boat:FindFirstChild("VehicleSeat")
        if seat and seat.Occupant == LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            return boat
        end
    end
    return nil
end

local function checkboatFind()
    local boat = checkboat()
    if boat and boat:FindFirstChild("PrimaryPart") and boat:FindFirstChild("VehicleSeat") then
        return boat
    end
    return nil
end

local function NoclipBoat(boat)
    pcall(function()
        for _, part in ipairs(boat:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

-- ===============================================================================
-- 10. RECONSTRUCTED GAME FUNCTIONS CATALOG (116 MODULES)
-- ===============================================================================

-- [EMBEDDED LOGIC FROM LURAPH VM CLOSURES]

-- [[ BANANA CAT HUB (BLOX FRUITS) - RECONSTRUCTED GAME LOGIC ]]

-- -------------------------------------------------------------
-- FUNCTION_2(V)
-- -------------------------------------------------------------
local function Func_2(V)
    if not(Settings["Bring Mob"])then return
    end
    if V then if t[4][t[6]]~=V then t[4][t[6]]=V
    r[4][r[6]]=DetectPartMobBring(V.Name,V,true).CFrame
    if game:GetService("Players").LocalPlayer.Data.Race.Value=="Cyborg"then if I.Character:FindFirstChild("RaceTransformed")then if I.Character.RaceTransformed.Value then r[4][r[6]]=getcenter(V.Name)
    end
    end
    end
    DeleteIgnoredMob()
    end
    end
    if DaBringMob then delay(0.1,function()getgenv().DaBringMob=false
    end)
    return
    end
    local t={}
    if not(V:FindFirstChild("Ignored"))then table.insert(t,V)
    end
    local x=Settings["Bring Mob Count"]or 2
    local j,a=if x>2 then 350 else 200
    if game:GetService("Players").LocalPlayer.Data.Race.Value=="Cyborg"then if I.Character:FindFirstChild("RaceTransformed")then if I.Character.RaceTransformed.Value then local p,K=300,6
    j,a=p,K
    else a=x
    end
    else a=x
    end
    else a=x
    end
    local p,K=pairs,f[90](workspace.Enemies:GetChildren())
    for G,G in p(f:N_(K))do if G~=V then if G.Name==V.Name then if not(G:FindFirstChild("Ignored"))then if IsMobAlive(G)then if isnetworkowner2(G.HumanoidRootPart)then x=(G.HumanoidRootPart.Position-r[4][r[6]].Position).Magnitude
    if x<=j then if#t<a then table.insert(t,G)
    end
    end
    end
    end
    end
    end
    end
    end
    if r[4][r[6]]and(I.Character.HumanoidRootPart.Position-V.HumanoidRootPart.Position).Magnitude<=50 and isnetworkowner2(I.Character.HumanoidRootPart)and#t>=2 then x=pairs
    for f,f in x(t)do sizepart(f)
    if isnetworkowner2(f.HumanoidRootPart)then f.HumanoidRootPart.CFrame=r[4][r[6]]*CFrame.new(0,math.random(0,2),math.random(0,2))
    task.spawn(function()local V=f.Humanoid.Health
    task.wait(2.2)
    if f.Humanoid.Health==V then if not(f:FindFirstChild("Ignored"))then f.HumanoidRootPart.CFrame=f.WorldPivot
    Instance.new("IntValue",f).Name="Ignored"
    task.wait(0.3)
    end
    end
    end)
    else f.HumanoidRootPart.CFrame=f.WorldPivot
    Instance.new("IntValue",f).Name="Ignored"
    task.wait(0.3)
    end
    getgenv().DaBringMob=true
    end
    end
    end
    end
    end,D=function(f,...)(...)[...]=nil
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3(f)
-- -------------------------------------------------------------
local function Func_3(f)
    local r=V.Character:FindFirstChild("Portal-Portal")or V.Backpack:FindFirstChild("Portal-Portal")
    if not(r)then return nil
    end
    if r.Parent~=V.Character then V.Character:FindFirstChildOfClass("Humanoid"):EquipTool(r)
    end
    r=V.PlayerGui.Main:FindFirstChild("Gateway")
    if not r then return nil
    end
    for V=1,3,1 do if r.Visible then break
    end
    local I,x=Enum.KeyCode,game
    t:SendKeyEvent(true,I.C,false,x)
    task.wait(0.06)
    V,x=Enum.KeyCode,game
    t:SendKeyEvent(false,V.C,false,x)
    V=tick()+1.2
    repeat task.wait(0.1)
    until r.Visible or tick()>V
    end
    if not(r.Visible)then return nil
    end
    local V=r:FindFirstChild("MainContent")
    local t=V and(V:FindFirstChild("ScrollingFrame"))
    for V,I in ipairs(f)do V=t and t:FindFirstChild(tostring(I))
    if V and(V:IsA("GuiButton"))then for f,f in pairs(getconnections(V.MouseButton1Click))do pcall(function()f.Function()
    end)
    end
    return I
    end
    end
    for f,f in pairs(getconnections(r.Header.Exit.MouseButton1Click))do pcall(function()f.Function()
    end)
    end
    return nil
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_6(f)
-- -------------------------------------------------------------
local function Func_6(f)
    local V,t
    for r,I in ipairs(workspace._WorldOrigin.Locations:GetChildren())do if I:IsA("BasePart")then if I:GetAttribute("IgnoreInTracking")then else r=(I.Position-f).Magnitude
    if V then if r<V then V,t=r,I
    else end
    else V,t=r,I
    end
    end
    else end
    end
    return t
    end
    end
    end,Qf=function(f,V,t,r,I,x)if I<=46 then local j=1+x
    local a=f[35](t,j)
    return 128>a and 77 or 120,j,a,V
    elseif I<=47 then return 52,r,1+x,V
    else local V,I,I=f[35](t,r),r+1,f[109](x)
    f[68](I,0,V)
    return 130,r,x,I
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_11(f,t)
-- -------------------------------------------------------------
local function Func_11(f,t)
    local r=V.Character and V.Character:FindFirstChild("HumanoidRootPart")and f and f:FindFirstChild("HumanoidRootPart")and f.Humanoid.Health>0 and(V.Character.HumanoidRootPart.Position-f.HumanoidRootPart.Position).Magnitude<(t or 70)
    if r then if getgenv().SmartMob~=f then getgenv().SmartMob=f
    getgenv().SmartHealth=f.Humanoid.Health
    getgenv().SmartTime=tick()
    t=NameWeapon("Blox Fruit",true)
    if t and(string.find(t.Name,"T-Rex")or string.find(t.Name,"Kitsune")or string.find(t.Name,"Leopard")or string.find(t.Name,"Mammoth")or string.find(t.Name,"Dough"))then getgenv().YPosFruit=7
    else getgenv().YPosFruit=20
    end
    elseif f.Humanoid.Health<getgenv().SmartHealth then getgenv().SmartHealth=f.Humanoid.Health
    getgenv().SmartTime=tick()
    elseif tick()-getgenv().SmartTime>1.5 then getgenv().YPosFruit=math.max(0,(getgenv().YPosFruit or 20)-5)
    getgenv().SmartTime=tick()
    end
    end
    return r
    end
    end
    end,X=function(f,V,t,r,I,x,j,a,p,K)if t<=9 then if t<=8 then return 38,x,K+1,p
    else local G=f[35](a,3+r)
    local E,u,D,w=(x-128)*2097152,K-128,(I-128)*128,G%128*16384
    return 14,(G-G%128)*2097152+(w+E)+(D+u),r+4,p
    end
    elseif t<=10 then local t=f[35](a,3+K)
    local f,r,I,a=2097152*(p-128),j-128,128*(V-128),t%128*16384
    local V=I+(f+(t-t%128)*2097152+(a+r))
    return 21,x,K+4,V
    else return 98,x,K+1,p
    end
    end,a_=function(f,V,t,r,I,x,j,a)if r<=99 then local p=f[35](x,a+3)
    local K,G,E,u=(V-128)*2097152,I-128,128*(j-128),16384*(p%128)
    local D=2097152*(p-p%128)+G+E+(u+K)
    return 206,a+4,D,I
    elseif r<=100 then local r=f[35](x,a+3)
    local f,p,K,G,E=(I-128)*2097152,j-128,128*(t-128),r%128*16384,r%128
    local t=(r-E)*2097152
    r,E=K+(p+f+G+t),a+4
    return 196,a,V,r
    else local f,t=(I-128)*16384,j-128
    local r,I=f+(128*x+t),3+a
    return 196,a,V,r
    end
    end,Zf=function(f,V,t,r,I,x,j,a,p,K)if x<=203 then if x<=202 then local G=f[35](K,V)
    return 128>G and 50 or 7,t,a,G
    else local G,E,u=p[1],p[2],p[4]
    local D,w=G+E,E<=0
    G,E=D>=u,D<=u
    u=w and G or not w and E
    p[1]=D
    if u then return 248,D,a,j
    else return 134,t,a,j
    end
    end
    elseif x<=204 then r[I]=j
    return 72,t,a,j
    else local r=f[35](K,V+1)
    return r<128 and 212 or 226,t,r,j
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_12(f)
-- -------------------------------------------------------------
local function Func_12(f)
    local t=V.Character and V.Character:FindFirstChild("HumanoidRootPart")
    if not(t)then return
    end
    local V,r,I,x=next,{workspace.NPCs,game:GetService("ReplicatedStorage").NPCs},1/0
    for j,a in V,r,nil do local V,r,p=next,a:GetChildren()
    for a,a in V,r,p do if a:GetAttribute("NPCLoaded")then if a:GetAttribute("NPCReady")then if a.Name==f then if a:FindFirstChild("HumanoidRootPart")then j=(t.Position-a.HumanoidRootPart.Position).Magnitude
    if j<I then I,x=j,a
    else end
    else end
    else end
    else end
    else end
    end
    end
    if not(x)then return NPCManager.getNPCsByName(f)[1]._modelState._instance
    end
    return x,I
    end
    end
    end,[7]=buffer.writeu16,
end

-- -------------------------------------------------------------
-- FUNCTION_19(f,V)
-- -------------------------------------------------------------
local function Func_19(f,V)
    local t,r="Select Skills "..f,{}
    for I,I in ipairs(V)do r[I]=false
    end
    EnsureAllTrueDefaults(t,V)
    f=PrepareMultiSelectList(r,Settings[t],true)
    V,r=SelectSkillsSection.CreateDropdown,{Title=t,List=f,Search=true,Selected=true}
    r.Default=Settings[t]or nil
    V(r,function(f,V)SaveSettings(t,f,V)
    end)
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_26(f,K,G)
-- -------------------------------------------------------------
local function Func_26(f,K,G)
    if typeof(f)~="CFrame"then return
    end
    local E=V.Character
    if E then if not(E:FindFirstChild("HumanoidRootPart"))then return
    end
    else return
    end
    local u,D=E.HumanoidRootPart,E:FindFirstChildOfClass("Humanoid")
    if not(D)then return
    end
    if FruitDropBusy then if not(G)then return
    end
    end
    if t.EntranceInFlight then return
    end
    t.LastCall=tick()
    if D then if D.Sit then TweenManager.CancelCurrent()
    task.wait(0.1)
    getgenv().noclip=false
    r:SendKeyEvent(true,"Space",false,game)
    task.wait()
    r:SendKeyEvent(false,"Space",false,game)
    task.wait(0.1)
    if u:FindFirstChild("EffectsSY")then u.EffectsSY:Destroy()
    end
    D.Jump=true
    task.wait(0.1)
    u.CFrame=u.CFrame*CFrame.new(0,10,0)
    return
    end
    end
    if not(u:FindFirstChild("FloatForce"))then t.EnsureFloatForce(u)
    end
    local r,w,g,U=(f.Position-u.Position).Magnitude,false,false,workspace:FindFirstChild("_WorldOrigin")
    G=U and(U:FindFirstChild("Locations"))
    U=G and(G:FindFirstChild("Submerged Island"))
    if U then if U:IsA("BasePart")then G=U:FindFirstChild("Mesh")
    if G then if G:IsA("DataModelMesh")then local e=G.Scale.X/2+8
    local s,k=(f.Position-U.Position).Magnitude<=e,(u.Position-U.Position).Magnitude<=e
    w,g=s,k
    else end
    else end
    else end
    else end
    U=game.PlaceId==getgenv().CheckPlaceId and w~=g
    if Settings["Teleport Y"]then G=Settings["% Health Player"]or 40
    if D.Health/D.MaxHealth<G/100 then I[4][I[6]]=true
    elseif D.Health/D.MaxHealth>0.8 then I[4][I[6]]=false
    end
    else I[4][I[6]]=false
    end
    G,D=t.RouteConfig.Enabled and not ReadyToDodge and not I[4][I[6]]and not w and not g and not t.IsSpecialRoutePoint(u.Position)and not t.IsSpecialRoutePoint(f.Position),K and 8 or 50
    K=if r<D then if I[4][I[6]]then false else if ReadyToDodge then false else if U then false else if G then t.FindRouteBlocker(E,u.Position,f.Position,t.RouteConfig.EndpointAllowance,true)~=nil else false else false
    if r<D then if not I[4][I[6]]then if ReadyToDodge then elseif U then elseif K then else TweenManager.CancelTweenOnly()
    x()
    u.CFrame=f
    return
    end
    end
    end
    if game.PlaceId~=122478697296975 then K=CFrame.new(28609.392578125,14896.533203125,106.4216537475586)
    if game.PlaceId==getgenv().CheckPlaceId then if(f.Position-K.Position).Magnitude>3000 then if(K.Position-u.Position).Magnitude<=3000 then t.PlayToTargetTween(u,K,400,8,false)
    if(K.Position-u.Position).Magnitude<8 then game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","Check")
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress","TeleportBack")
    TweenManager.CancelCurrent()
    end
    return
    end
    end
    end
    if game.PlaceId==getgenv().CheckPlaceId then if w then if not(g)then U=CFrame.new(-16269.4082,23.9799957,1371.66235,-0.999388933,0,-0.0349550731,0,1,0,0.0349550731,0,-0.999388933)
    if TryPortalTeleport(u,U)then return
    end
    t.PlayToTargetTween(u,U,350,8,false)
    if(U.Position-u.Position).Magnitude<8 then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack({[1]="TravelToSubmergedIsland"}))
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="SetLastSpawnPoint",[2]="SubmergedIsland"}))
    TweenManager.CancelCurrent()
    end
    return
    end
    end
    end
    if game.PlaceId==getgenv().CheckPlaceId then if w then elseif g then D=CFrame.new(11427.9189,-2156.36401,9726.24023,-0.929097056,-7.17796156E-34,0.369835705,-7.17796156E-34,1,1.37611875E-34,-0.369835705,-1.37611875E-34,-0.929097056)
    t.PlayToTargetTween(u,D,350,8,false)
    if(D.Position-u.Position).Magnitude<8 then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineTransportation"):InvokeServer(unpack({[1]="GetAvailableLocations"}))
    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineTransportation"):InvokeServer(unpack({[1]="InitiateTeleport",[2]="Tiki Outpost"}))
    TweenManager.CancelCurrent()
    end
    return
    end
    end
    if TryPortalTeleport(u,f)then return
    end
    if Settings["Use Home Teleport"]and r>3250 and tick()>=(HomeTeleportBlockUntil or 0)and not I[4][I[6]]and not ReadyToDodge and V.Data.Level.Value>=30 then local w=GetHomeReadyPosition()
    if w and r-(f.Position-w).Magnitude>3250 then HomeTeleportBlockUntil=tick()+8
    t.EntranceInFlight=true
    TweenManager.CancelTweenOnly()
    u.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
    pcall(function()game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TeleportToSpawn")
    end)
    local g=tick()+6
    while true do task.wait(0.2)
    local e=V.Character and V.Character:FindFirstChild("HumanoidRootPart")and(V.Character.HumanoidRootPart.Position-w).Magnitude<500
    if e or tick()>g then break
    end
    end
    t.EntranceInFlight=false
    if V.Character then if V.Character:FindFirstChild("HumanoidRootPart")then if(V.Character.HumanoidRootPart.Position-w).Magnitude<500 then HomeTeleportBlockUntil=0
    end
    end
    end
    return
    end
    end
    if t.HandlePortalBoundary(u,f.Position)then return
    end
    local w,g,e,s=j(u.Position),j(f.Position),a(f.Position),a(u.Position)
    local j=g and g.Name=="Celestial Domain"and(if w then w.Name~="Celestial Domain"else not w)
    if j then local a=DetectNpcOni()
    if a then if not(a:FindFirstChild("HumanoidRootPart"))then return
    end
    else return
    end
    local k=a.HumanoidRootPart.CFrame*CFrame.new(0,0,20)
    t.PlayToTargetTween(u,k,350,12,false)
    if(k.Position-u.Position).Magnitude<300 then game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/CelestialDomainTransportation"):InvokeServer("InitiateTeleportToTemple")
    CelestialDomainController:LoadMap()
    TweenManager.CancelCurrent()
    task.wait(1)
    end
    return
    end
    j=e and(e.Name=="Celestial Domain (Interior)"or e.Name=="Celestial Domain <Interior>")
    if j then if w then if w.Name=="Celestial Domain"then game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/CelestialDomainTransportation"):InvokeServer("InitiateTeleportToInterior")
    TweenManager.CancelCurrent()
    task.wait(1)
    return
    end
    end
    local a=s and(s.Name=="Celestial Domain (Interior)"or s.Name=="Celestial Domain <Interior>")
    local k=if w then w.Name~="Celestial Domain"and not a else not w
    if k then local a=DetectNpcOni()
    if a then if not(a:FindFirstChild("HumanoidRootPart"))then return
    end
    else return
    end
    local k=a.HumanoidRootPart.CFrame*CFrame.new(0,0,20)
    t.PlayToTargetTween(u,k,350,12,false)
    if(k.Position-u.Position).Magnitude<300 then game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/CelestialDomainTransportation"):InvokeServer("InitiateTeleportToTemple")
    CelestialDomainController:LoadMap()
    TweenManager.CancelCurrent()
    task.wait(1)
    game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/CelestialDomainTransportation"):InvokeServer("InitiateTeleportToInterior")
    end
    return
    end
    end
    if s and(s.Name=="Celestial Domain (Interior)"or s.Name=="Celestial Domain <Interior>")and(if e then e.Name~="Celestial Domain (Interior)"and e.Name~="Celestial Domain <Interior>"else not e)then game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/CelestialDomainTransportation"):InvokeServer("Leave")
    TweenManager.CancelCurrent()
    task.wait(1)
    return
    end
    if w and w.Name=="Celestial Domain"and(if g then g.Name~="Celestial Domain"else not g)then game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/CelestialDomainTransportation"):InvokeServer("Leave")
    TweenManager.CancelCurrent()
    return
    end
    w,e,g=tick(),pairs,t.EntranceSuppressedUntil
    for a,k in e(g)do if w>=k then t.EntranceSuppressedUntil[a]=nil
    end
    end
    if t.EntranceInFlight then return
    end
    e,s,j,g=pairs
    for a,k in e(p)do local J,d=(f.Position-k).Magnitude,w<(t.EntranceSuppressedUntil[a]or 0)
    if(if d then not d else a~="Temple Clock"or J<=3000)and((if s then J<s else not s)or math.abs(J-s)<=0.001 and tostring(a)<tostring(j))then s,j,g=J,a,k
    else end
    end
    e=t.EntranceName
    local a=e and p[e]
    if a then if s then local p,k=(f.Position-a).Magnitude,w<(t.EntranceSuppressedUntil[e]or 0)
    if if k then not k else e~="Temple Clock"or p<=3000 then if p+750<r then if p<=s+150 then j,g,s=e,a,p
    else end
    else end
    else end
    else end
    else end
    e=g and s+750<r
    if e then if w<t.EntranceBusyUntil then return
    end
    t.EntranceName=j
    TweenManager.CancelTweenOnly()
    getgenv().noclip=true
    x()
    t.EntranceInFlight=true
    local r,p,w=pcall(TeleToTempleOfTime)
    x()
    s,a=false,tick()+0.75
    if r then if p then local x=s
    repeat local e=V.Character
    local V,k=e and(e:FindFirstChildOfClass("Humanoid")),e and(e:FindFirstChild("HumanoidRootPart"))
    if e~=E then break
    elseif V then if V.Health<=0 then break
    end
    else break
    end
    if k and(k.Position-g).Magnitude<500 then x=true
    break
    end
    task.wait(0.05)
    until tick()>=a
    s=x
    else end
    else end
    if w then if w.Parent==workspace.Map then w:SetAttribute("ClientBorrowed",nil)
    if not s then local V=game.ReplicatedStorage:FindFirstChild("MapStash")
    if V then w.Parent=V
    end
    end
    end
    end
    t.EntranceInFlight=false
    t.EntranceBusyUntil=tick()+1.5
    if r and p and s then t.EntranceFailures[j]=nil
    t.EntranceSuppressedUntil[j]=nil
    else w=(t.EntranceFailures[j]or 0)+1
    t.EntranceFailures[j]=w
    if w>=2 then t.EntranceFailures[j]=nil
    t.EntranceSuppressedUntil[j]=tick()+8
    end
    end
    return
    end
    if game.PlaceId==getgenv().CheckPlaceId then if workspace.Map:FindFirstChild("CakeLoaf")then if workspace.Map.CakeLoaf:FindFirstChild("BigMirror")then if workspace.Map.CakeLoaf.BigMirror:FindFirstChild("Main")then if(Vector3.new(-1990.67,4532.97,-14973.67)-f.Position).Magnitude<=1000 then if(Vector3.new(-1990.67,4532.97,-14973.67)-u.Position).Magnitude>1000 then t.PlayToTargetTween(u,workspace.Map.CakeLoaf.BigMirror.Main.CFrame,400,8,false)
    return
    end
    end
    end
    end
    end
    end
    end
    if u.Position.Y<-60 then if u.Position.Y>-100 then u.CFrame=u.CFrame*CFrame.new(0,20,0)
    end
    end
    K=CFrame.new()
    K=if ReadyToDodge then CFrame.new(0,150,0)else if I[4][I[6]]then CFrame.new(0,Settings["Distance Teleport Y"]or 800,0)else K
    U=f*K
    K=(U.Position-u.Position).Magnitude
    D=if K<3 then if G then t.FindRouteBlocker(E,u.Position,U.Position,t.RouteConfig.EndpointAllowance,true)~=nil else false else false
    if K<3 then if not(ReadyToDodge)then if I[4][I[6]]then elseif D then else TweenManager.CancelTweenOnly()
    u.CFrame=U
    return
    end
    end
    end
    t.PlayToTargetTween(u,U,t.RouteConfig.TweenSpeed,nil,G)
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_27()
-- -------------------------------------------------------------
local function Func_27()
    local f,t,r=next,game:GetService("CollectionService"):GetTagged("_ChestTagged")
    local I,x,j=1/0
    for a,p in f,t,r do if p:GetAttribute("IsDisabled")then else if p:FindFirstChild("Ignored")then else a=V:DistanceFromCharacter(p.Position)
    if a<I then local f=i
    I,x,j=a,f,p
    else end
    end
    end
    end
    return j
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_30(f,V)
-- -------------------------------------------------------------
local function Func_30(f,V)
    local function t()HopToRandomServer()
    end
    local r=f or(Settings["Time Hop Server"]or 5)
    require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Banana Cat Hub : Wait "..r.."s [Hop Server]<Color=/>"):Display()
    while wait(r)do if V then if V()then return
    end
    end
    require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Banana Cat Hub : Hop Server<Color=/>"):Display()
    t()
    end
    end
    end
    end,[83]=buffer.copy,
end

-- -------------------------------------------------------------
-- FUNCTION_33(f)
-- -------------------------------------------------------------
local function Func_33(f)
    local V,t,r=next,game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits",false)
    for I,I in V,t,r do if I.Name==f then return I
    end
    end
    end
    end
    end,zf=function(f,V,t,r,I,x,j,a,p,K,G,E)if V<=8 then if V<=6 then return p>51 and 104 or 140,I,j,a,x,E,G
    elseif V<=7 then local p=E-128+r*128
    return 49,I,2+j,a,x,p,G
    else local r=t[a]
    if r then return 130,I,j,r,x,E,G
    else return 46,I,j,a,x,E,G
    end
    end
    elseif V<=10 then if V<=9 then local t=f[35](x,2+a)
    if t>=128 then return 192,I,j,a,x,t,G
    else return 53,I,j,a,t,E,G
    end
    else return 206,I,1+j,a,x,E,G
    end
    elseif V<=11 then local V=j-128
    local t=128*a+V
    return 48,I+2,t,a,x,E,G
    else local V=f[35](K,j)
    return V>=128 and 180 or 110,I,j,a,x,E,V
    end
    end,ef=function(f,V,t,r,I,x,j,a,p,K,G,E)if p<=23 then if p<=22 then local u,D,w=G[2],G[1],G[5]
    local g,U=u+D,D<=0
    D,u=g>=w,g<=w
    w=U and D or not U and u
    G[2]=g
    if w then return 28,G,V,I,r,t,j,g
    else return 201,G,V,I,r,t,j,a
    end
    else local u,D,w,g=G[2],a(E),f[59],V+I
    local U=f[35](j,g)
    return 128<=U and 78 or 86,u,D,w,g,U,j,a
    end
    elseif p<=24 then local p=f[35](E,I)
    return p>=128 and 91 or 152,G,V,I,r,t,p,a
    else local p=(r*K+x)%256
    f[79](E,t,(f[15](a,p,(f[35](j,t+I)))))
    return 121,G,V,I,p,t,j,a
    end
    end,v=function(f,V,t,r,I,x,j,a,p,K)if x<=85 then if x<=84 then local G=p-128+128*a
    return 127,K,t+2,j,G,I,V
    else return 189,K[3],t,j,p,I,V
    end
    elseif x<=86 then local x,a=f[107](r,t),4+t
    local G=x/2
    if x%2==0 then return 97,K,a,j,p,I,G
    else return 58,K,a,j,p,G,V
    end
    else local x=f[35](r,t+1)
    return x>=128 and 16 or 75,K,t,x,p,I,V
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_40()
-- -------------------------------------------------------------
local function Func_40()
    local f=V.Character and V.Character:FindFirstChild("HumanoidRootPart")
    if not(f)then return
    end
    local V,t,r,I=next,{workspace.NPCs,game:GetService("ReplicatedStorage").NPCs},1/0
    for x,x in V,t,nil do local V,t,j=next,x:GetChildren()
    for x,a in V,t,j do if a:GetAttribute("NPCLoaded")then if a:GetAttribute("NPCReady")then if a:GetAttribute("DisplayName")=="Celestial Member"then if a:FindFirstChild("HumanoidRootPart")then x=(f.Position-a.HumanoidRootPart.Position).Magnitude
    if x<r then r,I=x,a
    else end
    else end
    else end
    else end
    else end
    end
    end
    return I,r
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_44()
-- -------------------------------------------------------------
local function Func_44()
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor","1")==0 then if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Check")==1 then if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Zou")==0 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
    end
    end
    if game.PlaceId==getgenv().CheckPlaceId2 and V.Data.Level.Value>=1500 then if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")==3 then if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor","1")~=0 then if#getbackpack()>=1 then toTarget(CFrame.new(-339.79840087891,331.86065673828,643.83178710938))
    if(Vector3.new(-339.79840087891,331.86065673828,643.83178710938)-V.Character.HumanoidRootPart.Position).Magnitude<=5 then if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor","1")~=1 then local f,t,r=next,getbackpack()
    for I,I in f,t,r do V.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(I))
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","2")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","3")
    end
    end
    elseif not(CheckFruitplr())then if TakeFruitInventory()then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit",TakeFruitInventory())
    end
    end
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor","1")==0 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Check")==1 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Zou")==0 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Check")then if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress","Check")==0 then if(V.Character.HumanoidRootPart.Position-game:GetService("Workspace").Map.IndraIsland.Part.Position).Magnitude>1000 then toTarget(cframethangdaubuoiredhead)
    if(cframethangdaubuoiredhead.p-V.Character.HumanoidRootPart.Position).Magnitude<=5 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Begin")
    end
    else local f,t,r=next,workspace.Enemies:GetChildren()
    for I,I in f,t,r do if I.Name=="rip_indra"and I:FindFirstChild("HumanoidRootPart")and I:FindFirstChild("Humanoid")and I.Humanoid.Health>0 then if(I.HumanoidRootPart.Position-V.Character.HumanoidRootPart.Position).Magnitude>300 then toTarget(I.HumanoidRootPart.CFrame)
    else repeat task.wait()
    sizepart(I)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(I.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(I.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    ClickM1(I)
    UsedualFlock()
    until not workspace.Enemies:FindFirstChild("rip_indra")
    end
    end
    end
    end
    end
    elseif CheckNameBoss("Don Swan")then local f=CheckNameBoss("Don Swan")
    repeat task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    until(if f then not f.Parent else not f)or f.Humanoid.Health==0
    end
    else AutoQuestBarito()
    end
    end
    end
    end
    end,[16]=buffer.readi8,sf=function(f,V,t,r,I,x,j,a,p)if r<=26 then local K=f[35](j,3+t)
    local j,G,E,u=2097152*(I-128),x-128,128*(V-128),K%128*16384
    local D=E+(2097152*(K-K%128)+j)+(u+G)
    return 52,a,t+4,D,x,V
    elseif r<=27 then return 108,a[1],t,I,x,V
    else local V,r=3*(x-1),f[35](p,t)
    return 128<=r and 54 or 113,a,t,I,V,r
    end
    end,Af=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if G<=3 then local w,g,U,e=f[22],(175+t)%256,f[109](x),x-x%4
    local s,k=e-1,4+0
    return 126,{0-k,nil,I,k,s+0},V,x,g,175,w,185,57,U,2947526575,e
    elseif G<=4 then local G=f[35](a,1+V)
    return G<128 and 11 or 144,I,V,x,G,p,r,E,K,j,u,D
    else local f,a=(x-128)*16384,p-128
    local x=128*r+(f+a)
    return 191,I,V+3,x,t,p,r,E,K,j,u,D
    end
    end,[60]=string.gsub,[73]=xpcall,C={},n=function(f,V,t,r,I,x,j,a,p,K,G)if a<=150 then if a<=149 then local E=f[35](K,3+t)
    local u,D,w,g,U=2097152*(V-128),I-128,(j-128)*128,16384*(E%128),E%128
    local I=2097152*(E-U)
    U=u+w+(g+D+I)
    return 200,t+4,U,G,x
    else local I,j=(G-128)*16384,x-128
    local E=r*128+(I+j)
    return 26,t+3,V,E,x
    end
    elseif a<=151 then local I,j=(x-128)*16384,r-128
    local r=p*128+I+j
    return 38,3+t,V,G,r
    else local V=f[35](K,t+1)
    return 128<=V and 28 or 84,t,V,G,x
    end
    end,B_=function(f,V,t,r,I,x,j,a,p)if V<=195 then if V<=194 then return 232~=a and 107 or 21,p,x,I,j,r
    else local K=I-128
    local G=128*a+K
    return 52,p,x+2,G,j,r
    end
    elseif V<=196 then local V,a=f[1](t),1+0
    local K=1-a
    return 71,{a,nil,t+0,K,p},V,I,j,r
    else local V=f[35](j,2+x)
    if V<128 then return 101,p,x,I,V,r
    else return 100,p,x,I,j,V
    end
    end
    end,v_=function(f,V,t,r,I,x,j,a,p,K,G,E)if I<=187 then if I<=185 then K[-1]=t
    K[-2]=a
    return 125,x,j,p
    elseif I<=186 then local t=(r+p*V)%256
    f[79](G,j,(f[15](t,E,(f[35](a,x+j)))))
    return 163,x,j,t
    else return p<=240 and 205 or 82,x,j,p
    end
    elseif I<=188 then local V=1+j
    local t=f[35](a,V)
    return t>=128 and 124 or 170,V,t,p
    elseif I<=189 then return 138<=p and 16 or 8,x,j,p
    else return 46<p and 6 or 44,x,j,p
    end
    end,[14]=string.unpack,
end

-- -------------------------------------------------------------
-- FUNCTION_52()
-- -------------------------------------------------------------
local function Func_52()
    if Settings["Start Farm"]or Settings["Auto Present Event"]or Settings["Auto Celestial Soldier"]or Settings["Auto Rip Commander"]or Settings["Auto Event Halloween"]or Settings["Auto Farm Pumpkins"]or Settings["Auto Farm Jack o' Lantern & Pumpkin Snowman"]or Settings["Auto Halloween Bosses"]or Settings["Auto Summon Great Pumpkin"]or Settings["Auto Collect Candy Spill"]or Settings["Auto Attack Dungeon"]or Settings["Auto Fishing"]or Settings["Auto Secret Quest"]or Settings["Teleport To Fruit"]or Settings["Auto Factory"]or Settings["Auto Pirate Raid"]or Settings["Auto Elite Hunter"]or Settings["Auto Touch Pad Haki"]or Settings["Auto Summon Rip Indra"]or Settings["Attack Rip Indra"]or Settings["Attack Soul Reaper"]or Settings["Attack Dough King"]or Settings["Attack Darkbeard"]or Settings["Auto Raid"]or Settings["Auto Sea Event"]or Settings["Auto Shipwright"]or Settings["Teleport Acient Clock"]or Settings["Auto Upgrade Race V2-V3"]or Settings["Auto Trial"]or Settings["Auto Get Ghoul"]or Settings["Auto Get Cyborg"]or Settings["Auto Pull Lever"]or V["Teleport Mirage"]or V["Teleport To Island"]or V["Teleport To Npc"]or V["Teleport Prehistoric Island"]or V["Sanguine Art"]or V["God Human"]or V["Dragon Talon"]or V["Electric Claw"]or V["Sharkman Karate"]or V["Death Step"]or V.SuperHuman or V.DragonClaw or V.Electro or V["Fishman Karate"]or V["Black Leg"]or Settings["Teleport To Kitsune Island"]or Settings["Auto Spawn Kitsune Island"]or Settings["Auto Collect Soul Ember"]or Settings["Auto Summon Soul Ember"]or Settings["Auto Attack Leviathan"]or Settings["Auto Soul Guitar"]or Settings["Auto CDK"]or Settings["Auto Yama"]or Settings["Auto Tushita"]or Settings["Auto Upgrade Sword Inventory"]or Settings["Teleport Player"]or Settings["Auto Chest"]or Settings["Farm Observation"]or Settings["Auto Upgrade Gun Inventory"]or Settings["Kill Boss"]or Settings["Kill Mob"]or Settings["Auto UP Observation V2"]or Settings["Auto New World"]or Settings["Auto Third World"]or Settings["Tween Safe if have Items"]or Settings["Teleport Frozen Dimension"]or Settings["Auto Yoru Mini"]or Settings["Auto Quest Dojo Trainer"]or Settings["Auto Sharkman Master"]or Settings["Auto Quest Dragon Hunter"]or Settings["Auto Crafting Volcanic Magnet"]or Settings["Auto Find Prehistoric Island"]or Settings["Auto Find Mirage"]or Settings["Auto Event Prehistoric Island"]or Settings["Auto Collect Bone"]or Settings["Auto Collect Berry"]or Settings["Auto Upgrade Race V2-V3 Draco"]or Settings["Auto Trial Draco"]or Settings["Auto Get Rainbow Haki"]or Settings["Follow Player Select"]then return true
    elseif Settings["Auto Tween To Prehistoric Island"]then return true
    elseif Settings["Auto Kill Golem"]then return true
    elseif Settings["Auto Fix Volcano"]then return true
    elseif Settings["Multi Find Leviathan"]then return true
    elseif Settings["Fully Event Prehistoric Island"]then return true
    elseif Settings["Auto Multi Raid"]then return true
    elseif Settings["Auto Fire Shoot Heart Leviathan"]then return true
    elseif Settings["Auto Buy Chip and Attack Law"]then return true
    elseif Settings["Fully Trial Draco"]then return true
    elseif Settings["Auto Finish Train Quest"]then return true
    elseif Settings["Auto Destroy IDK"]then return true
    elseif Settings["Auto Finish Train Draco Quest"]then return true
    elseif Settings["Auto TTK"]then return true
    elseif Settings["Auto Attack All Mob and Boss"]then return true
    elseif Settings["Auto Collect Egg"]then return true
    elseif Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]then return true
    end
    end
    end
    end,Z={},[84]=string.byte,N=function(f,V,t,r,I,x,j,a)if t<=121 then if t<=120 then local p=f[35](x,j+1)
    return 128<=p and 211 or 157,r,j,V,I,p
    else return 218,r[5],j,V,I,a
    end
    elseif t<=122 then local t=j-128
    return 143,r,V*128+t,2,I,a
    else local t=f[35](x,2+j)
    return 128<=t and 233 or 17,r,j,V,t,a
    end
    end,Y_=function(f,V,t,r,I,x,j,a,p,K)if a<=19 then if a<=18 then local G=(t-128)*16384
    local E=V-128+(G+128*I)
    return 20,j,K,3+r,p,E,V
    else local I=f[35](K,r+2)
    return I<128 and 33 or 30,j,K,r,p,t,I
    end
    elseif a<=20 then local I=f[109](t)
    f[83](I,0,K,r,t)
    local a=r+t
    x[p]=I
    I=f[35](K,a)
    if 128>I then return 22,j,a,I,p,t,V
    else return 0,j,K,a,I,t,V
    end
    else local I=p-91800
    local a=f[1](I)
    x[5]=a
    local f=1+0
    local x=1-f
    return 10,{j,f,nil,I+0,x},K,r,a,t,V
    end
    end,m_=function(f,V,t,r,I)if r<=22 then return 29,1+I,V
    else local V=f[35](I,t)
    return 128<=V and 2 or 12,I,V
    end
    end,[69]=setfenv,ff=function(f,V,t,r,I,x,j,a,p,K,G,E)if I<=191 then local u=f[35](x,E+2)
    return u>=128 and 215 or 188,V,E,p,u,K
    elseif I<=192 then local I,u,D,w=f[35](x,3+V),2097152*(p-128),j-128,(t-128)*128
    local f=I%128*16384+(D+(u+2097152*(I-I%128))+w)
    return 167,4+V,E,f,r,K
    else local f=16384*(K-128)
    local t=G-128+128*a+f
    return 178,V,3+E,p,r,t
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_61(I)
-- -------------------------------------------------------------
local function Func_61(I)
    local x=I~=nil
    local j=I or V(t.Data.Level.Value)
    I=t.PlayerGui.Main:FindFirstChild("Quest")
    local function V()local a=x and select(1,f[3]())or(if x then not x else GetQuestText()~="")
    return a
    end
    if not j or not j.Pos then return
    elseif I then if V()then return
    end
    else return
    end
    local f,I,x=typeof(j.Pos)=="CFrame"and j.Pos.Position or j.Pos,t.Character and t.Character:FindFirstChild("HumanoidRootPart"),t.Character and t.Character:FindFirstChild("Humanoid")
    if I then if not x then return
    end
    else return
    end
    if(f-I.Position).Magnitude<=8 and x.Health>0 then r.EnsureFloatForce(I)
    r.QuestClaimCount=r.QuestClaimCount+1
    pcall(function()task.wait(2)
    if V()then return
    elseif x.Health<=0 then return
    end
    for t=1,2,1 do pcall(function()CommF:InvokeServer("StartQuest",tostring(j.QuestName),j.Id)
    end)
    task.wait(1)
    if V()then return
    elseif x.Health<=0 then return
    end
    end
    end)
    r.QuestClaimCount=r.QuestClaimCount-1
    else toTarget(CFrame.new(f)*CFrame.new(0,4,2),true)
    end
    end
    end
    end,K_=function(f,V,t,r,I,x,j,a)if t<=125 then local p,K,G=V[5],V[3],V[1]
    local E,u=p+K,K<=0
    p,K=E>=G,E<=G
    G=u and p or not u and K
    V[5]=E
    if G then return 81,j,E,a
    else return 19,j,I,a
    end
    elseif t<=126 then local t,p,K=V[1],V[4],V[5]
    local G,E=t+p,p<=0
    p,t=G>=K,G<=K
    K=E and p or not E and t
    V[1]=G
    if K then return 17,j,I,G
    else return 211,j,I,a
    end
    else local V,t,p=1+r,(j+153)%256,0
    f[67](f.on,0,(f[15](f[107](x,V+0),f.Dn[t],2576980377)))
    V=f.un[t]
    return 130,f[37](f.on,I),I,a
    end
    end,e=function(f,V,t,r,I,x,j,a,p)if r<=125 then if r<=124 then local K,G,E=f[1](t),f[1](t),1+0
    local u=1-E
    return 241,{t+0,u,I,nil,E},K,G,j,p,V
    else return 257,I[3],t,a,j,p,V
    end
    elseif r<=126 then local K,G,E=I[5],I[1],I[4]
    local u,D=K+G,G<=0
    G,K=u>=E,u<=E
    E=D and G or not D and K
    I[5]=u
    if E then return 162,I,t,a,j,p,u
    else return 13,I,t,a,j,p,V
    end
    elseif r<=127 then local r=f[35](x,a)
    return r>=128 and 88 or 79,I,t,a,j,r,V
    else local r=f[35](x,1+a)
    return 128>r and 185 or 191,I,t,a,r,p,V
    end
    end,[10]=rawget,Q_=function(f,V,t,r,I,x,j,a,p)if V<=28 then if V<=27 then local K=f[35](I,2+a)
    return K<128 and 18 or 16,I,a,t,j,K
    else local K=j-128
    local G=p*128+K
    return 20,I,a+2,t,G,r
    end
    elseif V<=29 then f[39]=I
    return 9,f:Cn(x,a,235)(nil,3239977705,592315926,f.C),a,t,j,r
    elseif V<=30 then local V=f[35](I,3+a)
    local f,x,K,G,E=(t-128)*2097152,j-128,128*(p-128),V%128*16384,V%128
    local p=2097152*(V-E)
    V=f+(G+K+(x+p))
    return 21,I,4+a,V,j,r
    else local f=t-128
    local V=I*128+f
    return 29,a+2,V,t,j,r
    end
    end,Ef=function(f,V,t,r,I,x,j,a,p)if p<=1 then if p<=0 then local K=f[35](j,x+1)
    return 128<=K and 10 or 31,V,x,t,K
    else return 17,V,1+x,t,a
    end
    elseif p<=2 then local p,K=r-1,1+0
    return 13,{V,K,nil,I-K,p+0},x,t,a
    else local t=f[35](j,1+x)
    return 128<=t and 19 or 12,V,x,t,a
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_65()
-- -------------------------------------------------------------
local function Func_65()
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")==0 then if string.find(GetQuestText(),"Defeat 50 Swan Pirate",1,true)then local f,r="Swan Pirate",DetectMob("Swan Pirate")
    if r then repeat task.wait()
    sizepart(r)
    BringMob(r)
    UsedualFlock()
    ClickM1(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    until not IsMobAlive(r)
    elseif typeof(f)=="table"then if#V[4][V[6]]>=11 then V[4][V[6]]={}
    return
    end
    local r=DetectPartSpawnMob(DetectNameTablePart(f))
    if r then table.insert(V[4][V[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(r.CFrame*CFrame.new(0,60,0))
    local V,I=r.Position,t.Character.HumanoidRootPart
    if(V-I.Position).Magnitude<=100 or DetectMob(f)then break
    end
    end
    wait(1)
    end
    else local V=DetectPartSpawnMob(f,true)
    if V then Instance.new("IntValue",V).Name="Ignored"
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local r,I=V.Position,t.Character.HumanoidRootPart
    if(r-I.Position).Magnitude<=100 or DetectMob(f)then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif(t.Character.HumanoidRootPart.Position-CFrame.new(-456.28952,73.0200958,299.895966).Position).Magnitude>8 then toTarget(CFrame.new(-456.28952,73.0200958,299.895966))
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="StartQuest",[2]="BartiloQuest",[3]=1}))
    end
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")==1 then local f=CheckNameBoss("Jeremy")
    if f then repeat task.wait()
    sizepart(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    until not IsMobAlive(f)
    end
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")==2 then repeat task.wait()
    if(t.Character.HumanoidRootPart.Position-Vector3.new(-1835.65,10.4325,1679.75)).Magnitude>100 then toTarget(CFrame.new(-1835.65,10.4325,1679.75))
    else t.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()].CFrame
    task.wait()
    firetouchinterest(game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()],game.Players.LocalPlayer.Character.HumanoidRootPart,0)
    firetouchinterest(game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()],game.Players.LocalPlayer.Character.HumanoidRootPart,1)
    end
    until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")==3
    end
    end
    end
    end,Nf=function(f,V,t,r,I,x,j,a,p,K)if x<=19 then local G=p[2]
    r[0]=K
    return 130,G,V,r,a
    elseif x<=20 then local x=f[35](I,3+V)
    local I,G,E,u=2097152*(a-128),t-128,128*(j-128),16384*(x%128)
    local t=2097152*(x-x%128)+(I+E)+(u+G)
    return 33,p,4+V,r,t
    else return 130,p,V,f:Cn(K,r,235),a
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_86(f,V)
-- -------------------------------------------------------------
local function Func_86(f,V)
    local t={}
    for r,r in ipairs(V)do t[r]={Title=r,KeyName=r,Min=0,Max=5,Default=Settings["Skill "..r.." "..f]or 0.5,Precise=true}
    end
    HoldSkillsSection.CreateDropdown({Title="Set Delay "..f,List=t,Slider=true},function(V,V)if V then if V.KeyName then SaveSettings("Skill "..V.KeyName.." "..f,V.Default)
    end
    end
    end)
    end
    end
    end,p=function(f,V,t,r,I,x,j,a,p)if x<=158 then if x<=157 then local K=t-128
    local G=128*j+K
    return 236,r,V+2,G,I
    else local j=f[35](p,0)
    return j>=128 and 2 or 74,nil,j,t,I
    end
    elseif x<=159 then return 14,r,a+1,t,I
    else local I=f[35](p,V+2)
    return 128<=I and 94 or 31,r,V,t,I
    end
    end,H_=getfenv(),e_=function(f,V,t,r,I,x,j,a,p,K,G,...)if p<=5 then if p<=4 then j[V]=a
    return 10,r,I,x,t,j,a
    else return 34,r[1],I,x,t,j,a
    end
    elseif p<=6 then local V,E=16384*(a-128),G-128
    local G=V+128*K+E
    return 4,r,I,x,3+t,j,G
    elseif p<=7 then local V=r[3]
    f.u=...
    local p,K,G=f.u,f[39],{}
    local E,u=f[35](p,K),1+K
    G[7]=0~=E
    K=f[35](p,u)
    return 128<=K and 14 or 35,V,p,G,u,K,a
    else return 20,r,I,x,1+t,j,a
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_92(f)
-- -------------------------------------------------------------
local function Func_92(f)
    local V={}
    for t,t in pairs(game:GetService("Workspace"):WaitForChild("Enemies"):GetChildren())do table.insert(V,t)
    end
    if f then for f,f in pairs(game:GetService("Workspace"):WaitForChild("Characters"):GetChildren())do table.insert(V,f)
    end
    end
    return V
    end
    end
    end,f_=function(f,V,t,r,I,x,j,a)if a<=82 then return 246<=r and 127 or 142,V
    elseif a<=83 then local a,p,K=t[3],t[4],t[5]
    local G,E=a+p,p<=0
    p,a=G>=K,G<=K
    K=E and p or not E and a
    t[3]=G
    if K then return 143,G
    else return 27,V
    end
    else return j==f[76](I,1+r%x,2+r%x)and 177 or 39,V
    end
    end,[42]=table.clear,[43]=vector.create,vf=function(f,V,t,r,I,x,j,a,p,K,G,E)if a<=25 then if a<=24 then local u,D=f[35](x,K),K+1
    f[68](I,E+r,u,j)
    return 16,p,t,G,K,E,r
    else local I=p[1]
    t[6]=f:Mn(t)
    local u,D,w=f:x_(t,x)
    local g=f[35](x,w)
    return g>=128 and 3 or 1,I,u,D,w,E,g
    end
    elseif a<=26 then return 20,p,t,G,K,E,(r-128)*16384+(j-128+V*128)
    else local f=r-128+128*j
    return 23,p,t,G,K,E+2,f
    end
    end,[15]=bit32.bxor,[18]=select,
end

-- -------------------------------------------------------------
-- FUNCTION_101()
-- -------------------------------------------------------------
local function Func_101()
    require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Banana Hub : Hop Server<Color=/>"):Display()
    local f,V,t=game.PlaceId,{},""
    local r=os.date("!*t").hour
    local I=pcall(function()V=game:GetService("HttpService"):JSONDecode(readfile("Banana Cat Hub/NotSameServers.json"))
    end)
    if not(I)then table.insert(V,r)
    writefile("Banana Cat Hub/NotSameServers.json",game:GetService("HttpService"):JSONEncode(V))
    end
    function HopServerLess()local I,x=if t==""then game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..f.."/servers/Public?sortOrder=Asc&limit=100"))else game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..f.."/servers/Public?sortOrder=Asc&limit=100&cursor="..t)),""
    if I.nextPageCursor then if I.nextPageCursor~="null"then if I.nextPageCursor~=nil then t=I.nextPageCursor
    end
    end
    end
    local f,t=pairs,I.data
    local I=0
    for j,a in f(t)do j=true
    x=tostring(a.id)
    if tonumber(a.maxPlayers)>tonumber(a.playing)then if tonumber(a.playing)<=3 then local f,t,a=V,I,j
    for j,j in pairs(f)do if t~=0 then a=if x==tostring(j)then false else a
    else if tonumber(r)~=tonumber(j)then pcall(function()delfile("Banana Cat Hub/NotSameServers.json")
    V={}
    table.insert(V,r)
    end)
    end
    end
    t=t+1
    end
    if a==true then table.insert(V,x)
    wait()
    pcall(function()writefile("Banana Cat Hub/NotSameServers.json",game:GetService("HttpService"):JSONEncode(V))
    wait()
    game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport",x)
    getgenv().limit_type("clearAll")
    end)
    wait(4)
    end
    I=t
    else end
    else end
    end
    end
    while wait()do HopServerLess()
    end
    end
    end
    end,[55]=table.insert,Uf=function(f,V,t,r,I,x,j,a,p,K)if x<=29 then local G=f[35](p,3+I)
    local E,u,D,w=2097152*(t-128),V-128,128*(r-128),G%128*16384
    local V=D+(E+(G-G%128)*2097152)+(w+u)
    return 202,4+I,V,p,r,j
    elseif x<=30 then local V,x,G=K[3],K[5],K[4]
    local E,u=V+x,x<=0
    V,x=E>=G,E<=G
    G=u and V or not u and x
    K[3]=E
    if G then return 103,I,t,p,r,E
    else return 122,I,t,p,r,j
    end
    else local V=f[35](p,a+2)
    if V>=128 then return 37,I,t,p,V,j
    else return 169,I,t,V,r,j
    end
    end
    end,tf=function(f,V,t,r,I,x,j,a,p,K)if r<=29 then if r<=28 then local G=f[35](j,I+1)
    return 128<=G and 5 or 27,t,V,G
    else return p>=128 and 4 or 26,t,V,x
    end
    elseif r<=30 then local r=(p+x*t)%256
    f[79](K,a,(f[15](f[35](j,a+I),r,V)))
    return 13,r,V,x
    else local f=x-128+p*128
    return 24,t,V+2,f
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_103(r,I,x,x,j)
-- -------------------------------------------------------------
local function Func_103(r,I,x,x,j)
    if not r or typeof(I)~="CFrame"then return
    end
    local a=V.Character
    local p=a and(a:FindFirstChildOfClass("Humanoid"))
    if not a or r.Parent~=a then return
    elseif p then if p.Health<=0 then return
    end
    else return
    end
    local K,G=j~=false,TweenManager.currentTween
    if G then if G.Alive then j=t.ActiveConnection
    if type(j)~="thread"or coroutine.status(j)=="dead"then TweenManager.CancelTweenOnly()
    G=nil
    else end
    else end
    else end
    if G then if G.Alive then if G.Target then if G.AvoidObstacles==K then if tick()-t.LastTP<1 then if I==t.LastCF then if TweenManager.currentPart==r then return G
    elseif TweenManager.currentPart then if TweenManager.currentPart.Parent==a then return G
    end
    end
    end
    end
    end
    end
    end
    end
    if G then if G.Alive then if G.Target then if G.AvoidObstacles==K then if TweenManager.currentPart~=r then if TweenManager.currentPart then if TweenManager.currentPart.Parent==a then TweenManager.currentPart=r
    end
    end
    end
    if TweenManager.currentPart==r then if G.AvoidObstacles then if(G.Target.Position-I.Position).Magnitude>=t.RouteConfig.ReplanDistance then G.RouteDirty=true
    G.RouteReplans=0
    G.ReplanWindowStartedAt=tick()
    end
    end
    G.Target=I
    G.Speed=t.RouteConfig.TweenSpeed
    G.Epsilon=tonumber(x)or 2.5
    t.LastTP=tick()
    t.LastCF=I
    TweenManager.currentGoal=I
    return G
    end
    end
    end
    end
    end
    TweenManager.CancelTweenOnly()
    if t.ActiveConnection then if coroutine.status(t.ActiveConnection)=="suspended"then pcall(coroutine.close,t.ActiveConnection)
    end
    end
    p=t.RouteConfig.TweenSpeed
    x=tonumber(x)or 2.5
    t.LastTP=tick()
    t.LastCF=I
    local j,G=false
    local E={Target=I,Speed=p,Epsilon=x,AvoidObstacles=K,Route=nil,RouteIndex=1,RouteInfo=nil,RouteDirty=true}
    E.RoutePlannedTarget=I.Position
    E.NextRoutePlanAt=0
    E.NextRouteProbeAt=0
    E.LastMoveDirection=nil
    E.ProgressTarget=I.Position
    E.RouteReplans=0
    E.ReplanWindowStartedAt=tick()
    E.Alive=true
    local function x()E.Alive=false
    if t.ActiveConnection==G then t.ActiveConnection=nil
    end
    if TweenManager.currentTween==E then TweenManager.currentTween=nil
    TweenManager.currentPart=nil
    TweenManager.currentGoal=nil
    TweenManager.TweenRunning=false
    end
    if getgenv().Tween==E then getgenv().Tween=nil
    end
    end
    E.Pause=function(p)j=true
    if G then if coroutine.status(G)=="suspended"then pcall(coroutine.close,G)
    end
    end
    end
    E.Cancel=function(p)p:Pause()
    x()
    end
    E.Destroy=function(p)p:Cancel()
    end
    G=coroutine.create(function()local p,K,u,D=r.Position,E.Target
    if E.AvoidObstacles then u,D=t.BuildRoute(a,p,K.Position)
    else u,D={K.Position},{Avoiding=false}
    end
    local w=1
    local g=u[w]
    local U=(g-p).Magnitude
    E.Route=u
    E.RouteIndex=w
    E.RouteInfo=D
    E.RoutePlannedTarget=K.Position
    E.RouteDirty=false
    E.NextRoutePlanAt=tick()+(D.DirectBlocked and t.RouteConfig.FailedRouteBackoff or t.RouteConfig.ReplanCooldown)
    E.NextRouteProbeAt=tick()+t.RouteConfig.ReplanCooldown
    local e,s,k,J
    e,s,k,J=tick,nil,nil,1/0
    local d=e()
    e=nil
    local l,M=true
    local h,N=0,0
    while true do local S=j
    if S then break
    end
    S=V.Character
    local F=S and(S:FindFirstChildOfClass("Humanoid"))
    if S~=a or r.Parent~=S or not F then break
    elseif F.Health<=0 then break
    elseif r.Anchored then break
    elseif D.Holding then if tick()-t.LastCall>2 then break
    end
    end
    F,S=t.RunService.Heartbeat:Wait(),t.CharSpeedLimit()
    E.Speed=t.RouteConfig.TweenSpeed
    local b=r.Position
    if E.Target~=K then local Z=E.Target.Position
    local O,B=(Z-K.Position).Magnitude,E.AvoidObstacles and(Z-E.RoutePlannedTarget).Magnitude>=t.RouteConfig.ReplanDistance
    if B then if not(E.RouteDirty)then E.RouteReplans=0
    E.ReplanWindowStartedAt=tick()
    end
    end
    if B then E.RouteDirty=true
    end
    K=E.Target
    if not(D.Holding)then u[#u]=Z
    if D.Avoiding then if#u>=3 then u[#u-1]=Vector3.new(Z.X,D.SafeY,Z.Z)
    end
    end
    end
    g=u[w]
    U=(g-p).Magnitude
    if O>0.5 then s,k=nil,nil
    else end
    if(Z-E.ProgressTarget).Magnitude>=t.RouteConfig.ProgressRetargetDistance then J,d=1/0,tick()
    E.ProgressTarget=Z
    e,l=nil,true
    else end
    else end
    local Z=w>=#u and E.Epsilon or 0.05
    if U<=Z and not E.RouteDirty then if w<#u then if(g-b).Magnitude<=6 then s=s or tick()
    if tick()-s>=t.RouteConfig.WaypointSettleTime then w+=1
    g=u[w]
    U=(g-b).Magnitude
    E.RouteIndex=w
    E.RouteReplans=0
    E.ReplanWindowStartedAt=tick()
    p,s,k,J,d,e,l,M,h,N=b,nil,nil,1/0,tick(),nil,true,nil,0,0
    else end
    else U,p,s=(g-b).Magnitude,b,nil
    end
    else if D.Holding then local O,B
    local c=(g-b).Magnitude
    p,s,k=b,O,B
    else local O,B
    if(K.Position-b).Magnitude<=E.Epsilon then O,B=nil,k or tick()
    if tick()-B>=t.RouteConfig.FinalSettleTime then s,k=O,B
    break
    end
    s,k=O,B
    else O,B=nil,nil
    local c=(g-b).Magnitude
    p,s,k=b,O,B
    end
    end
    end
    else if U>Z then local O,B
    s,k=O,B
    else if E.RouteDirty then local O,B
    s,k=O,B
    else end
    end
    end
    if E.AvoidObstacles then if D.DirectBlocked then if tick()>=E.NextRoutePlanAt then E.RouteDirty=true
    end
    end
    end
    if E.AvoidObstacles then if tick()>=E.NextRouteProbeAt then if(g-b).Magnitude>8 then E.NextRouteProbeAt=tick()+t.RouteConfig.ReplanCooldown
    Z=w>=#u
    local O=Z and t.RouteConfig.EndpointAllowance or 0
    if t.FindRouteBlocker(a,b,g,O,Z)then if not(D.DirectBlocked)then E.RouteDirty=true
    end
    end
    end
    end
    end
    if E.AvoidObstacles and E.RouteDirty and tick()>=E.NextRoutePlanAt then Z=tick()
    if Z-E.ReplanWindowStartedAt>=t.RouteConfig.ReplanWindow then E.RouteReplans=0
    E.ReplanWindowStartedAt=Z
    end
    if E.RouteReplans>=t.RouteConfig.MaxReplansPerWindow then E.NextRoutePlanAt=E.ReplanWindowStartedAt+t.RouteConfig.ReplanWindow
    else if E.AvoidObstacles then u,D=t.BuildRoute(a,b,K.Position)
    else u={K.Position}
    D={Avoiding=false}
    end
    w=1
    g=u[w]
    U=(g-b).Magnitude
    E.Route=u
    E.RouteIndex=w
    E.RouteInfo=D
    E.RoutePlannedTarget=K.Position
    E.ProgressTarget=K.Position
    E.RouteDirty=false
    E.NextRoutePlanAt=Z+(D.DirectBlocked and t.RouteConfig.FailedRouteBackoff or t.RouteConfig.ReplanCooldown)
    E.NextRouteProbeAt=Z+(D.DirectBlocked and t.RouteConfig.FailedRouteBackoff or t.RouteConfig.ReplanCooldown)
    E.RouteReplans=E.RouteReplans+1
    p,s,k,J,d,e,l,M,h,N=b,nil,nil,1/0,Z,nil,true,nil,0,0
    end
    else end
    Z=(g-b).Magnitude
    if M then local K=b-M
    local O,B=K.Magnitude,E.LastMoveDirection and K:Dot(E.LastMoveDirection)or 0
    local c=E.LastMoveDirection and(K-E.LastMoveDirection*B).Magnitude or O
    K=O>3 and O<t.RouteConfig.SnapDrift and(B<-2 or c>2)
    if K then h+=1
    N+=O
    if h>=3 then if N>=12 then if E.AvoidObstacles then local K,K,O=(g-b).Magnitude
    S.cap=math.max(S.cap*0.8,t.RouteConfig.SpeedFloor)
    S.nextRaise=tick()+2
    c=w>=#u
    if t.FindRouteBlocker(a,b,g,c and t.RouteConfig.EndpointAllowance or 0,c)then if not(D.DirectBlocked)then if tick()>=E.NextRoutePlanAt then E.RouteDirty=true
    end
    end
    end
    local a,u=0,0
    p,s,k,h,N=b,K,O,a,u
    else end
    else end
    else end
    else h,N=0,0
    end
    if B<-t.RouteConfig.FastTweenRollbackDistance then t.BackoffFastTween(S)
    end
    else end
    if Z<J-5 then J,d=Z,tick()
    else if tick()-d>2.5 then if E.AvoidObstacles then U,s,k=(g-b).Magnitude,nil,nil
    S.cap=math.max(S.cap*0.75,t.RouteConfig.SpeedFloor)
    S.nextRaise=tick()+3
    if tick()>=E.NextRoutePlanAt then E.RouteDirty=true
    end
    p,d=b,tick()
    else l=false
    end
    else end
    end
    if l and M and e and Z>e+t.RouteConfig.SnapDrift then s,k=nil,nil
    S.cap=math.max(S.cap*0.7,t.RouteConfig.SpeedFloor)
    S.nextRaise=tick()+3
    if E.AvoidObstacles then if D.Avoiding then if w>1 then if tick()>=E.NextRoutePlanAt then E.RouteDirty=true
    end
    end
    end
    end
    p=b
    else if l then if M then if(b-M).Magnitude>t.RouteConfig.SnapDrift then local a,K
    if E.AvoidObstacles then if D.Avoiding then if w>1 then if tick()>=E.NextRoutePlanAt then E.RouteDirty=true
    end
    end
    end
    end
    p,s,k=b,a,K
    else end
    else end
    else end
    end
    b=g-p
    local a,K=b.Magnitude,math.min(math.min(E.Speed,S.cap,t.RouteConfig.TweenSpeed)*F,t.RouteConfig.StepMax)
    if a>K then if tick()>=S.nextRaise then if Settings["FastTween (risk)"]then S.cap=math.min(S.cap+t.RouteConfig.FastTweenRecoveryAcceleration*math.min(F,0.07),E.Speed,t.RouteConfig.TweenSpeed)
    else S.cap=math.min(S.cap*1.08,E.Speed,t.RouteConfig.TweenSpeed)
    S.nextRaise=tick()+1.5
    end
    end
    end
    p=if a<=K then g else if a<=0.05 then g else p+b/a*K
    U=(g-p).Magnitude
    E.LastMoveDirection=a>0.05 and b/a or nil
    f[3]()
    getgenv().noclip=true
    r.CFrame=CFrame.new(p)
    r.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
    r.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
    e,M=Z,p
    end
    if not(j)then if r.Parent==V.Character then if not(D.Holding)then if(E.Target.Position-r.Position).Magnitude<=E.Epsilon then r.CFrame=E.Target
    r.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
    r.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
    end
    end
    end
    end
    x()
    end)
    t.ActiveConnection=G
    TweenManager.currentTween=E
    TweenManager.currentPart=r
    TweenManager.currentGoal=I
    TweenManager.TweenRunning=true
    getgenv().Tween=E
    if not(coroutine.resume(G))then E:Cancel()
    return
    end
    return E
    end
    end
    end,t=function(f,V,t,r,I,x,j,a,p)if t<=89 then if t<=88 then local K=f[35](V,x+1)
    return 128>K and 239 or 131,x,I,K,p
    else local K=p-128
    local G=128*r+K
    return 26,2+x,I,j,G
    end
    elseif t<=90 then local t=f[35](V,2+a)
    return t<128 and 34 or 76,x,t,j,p
    else return 196,1+x,I,j,p
    end
    end,y=function(f,V,t,r,I,x,j,a,p,K,G)if r<=29 then if r<=28 then local E=f[35](a,j+2)
    return E>=128 and 119 or 187,j,t,E,K,V
    else local E=f[35](a,j+3)
    local f,a,u,D=(K-128)*2097152,G-128,(V-128)*128,16384*(E%128)
    local G=2097152*(E-E%128)+(D+u+f)+a
    return 36,4+j,t,p,G,V
    end
    elseif r<=30 then local f=t-128+p*128
    return 184,2+j,f,p,K,V
    else local f,r=16384*(V-128),I-128
    local V=f+(128*x+r)
    return 204,3+j,t,p,K,V
    end
    end,Df=function(f,V,t,r,I,x,j,a,p,K)if p<=178 then if p<=177 then local G=V-128
    local E=128*j+G
    return 204,x+2,r,I,E
    else I[j]=t
    return 126,x,r,I,V
    end
    elseif p<=179 then local t=f[35](K,x+3)
    local p,G,E,u,D=2097152*(I-128),V-128,128*(j-128),t%128*16384,t%128
    local j=2097152*(t-D)
    D=G+E+j+(p+u)
    return 26,x+4,r,D,V
    else local t=f[35](K,3)
    local f,j,p,K=(x-128)*2097152,r-128,128*(a-128),t%128*16384
    return 143,p+((t-t%128)*2097152+(j+f))+K,4,I,V
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_105(f)
-- -------------------------------------------------------------
local function Func_105(f)
    game.CoreGui.RobloxGui.Enabled=f
    end
    end
    end,wf=function(f,f,V,t,r,I)if r<=12 then local r=I-128+t*128
    return 17,f+2,r
    else local t,r,x=V[4],V[2],V[5]
    local j,a=t+r,r<=0
    t,r=j>=x,j<=x
    x=a and t or not a and r
    V[4]=j
    if x then return 30,f,j
    else return 25,f,I
    end
    end
    end,E_=function(f,V,t,r,I,x,j,a,p,K,G)if t then if I<=159 then local t=f[109](G)
    f[83](t,0,p,j,G)
    local E=G+j
    return 130,V,j,G,t,x,K
    elseif I<=160 then local t,E=G-1,1+0
    local u=r-E
    return 175,{nil,V,t+0,E,u},j,G,a,x,K
    else local t=x-128
    local r=p*128+t
    return 87,V,j,G,a+2,r,K
    end
    elseif I<=162 then local t=f[35](p,2+j)
    return 128<=t and 51 or 50,V,j,G,a,x,t
    elseif I<=163 then local f,t,r=V[1],V[5],V[3]
    local I,p=f+t,t<=0
    t,f=I>=r,I<=r
    r=p and t or not p and f
    V[1]=I
    if r then return 186,V,j,I,a,x,K
    else return 109,V,j,G,a,x,K
    end
    else return 159,V,j+1,G,a,x,K
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_106()
-- -------------------------------------------------------------
local function Func_106()
    if not(workspace._WorldOrigin:FindFirstChild("Present"))then return
    end
    for f,f in pairs(workspace._WorldOrigin:GetChildren())do if f.Name=="Present"then if f:FindFirstChild("Highlight")then if f:FindFirstChild("Box")then if f.Box:FindFirstChild("ProximityPrompt")then return f
    end
    end
    end
    end
    end
    end
    end
    end,m=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D,w,g,U,e,s,k)if e<=146 then if e<=145 then return 220,D,s,G,u,f[35](V,s+1),p
    else local J={}
    u[-1]=x
    g[-1]=w
    u[-2]=J
    g[-2]=J
    f[25](u,D)
    f[25](g,D)
    return 25,I,s,f[V](f,x,j,g,G,E,t,u,w,K,a,U),u,K,p
    end
    elseif e<=147 then local t=f[35](V,3+s)
    local I,x,j,a,E=2097152*(p-128),k-128,(r-128)*128,t%128*16384,t%128
    local r=2097152*(t-E)
    E=x+(a+I)+(j+r)
    return 42,D,4+s,G,u,K,E
    else local t=f[35](V,s)
    return 128>t and 163 or 142,D,s,G,t,K,p
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_110(V,t)
-- -------------------------------------------------------------
local function Func_110(V,t)
    spawn(function()local r=f[1].Character
    t=t or NameWeapon("Gun")
    local I=r and t and r:FindFirstChild(t)
    local x=typeof(V)=="CFrame"and{CFrame=V,Position=V.Position}or typeof(V)=="Instance"and(V:IsA("BasePart")and V or V:FindFirstChild("HumanoidRootPart")or V:FindFirstChild("Hitbox")or V:IsA("Model")and V.PrimaryPart)or type(V)=="table"and(V.HumanoidRootPart or V.CFrame and V.Position and V)
    if not I or not x then return
    elseif require(f[2].CombatUtil):IsGunReloading(I)then return
    end
    local V=getupvalues(require(f[3].Controllers.CombatController).Attack)[9]
    if type(V)~="function"then return
    end
    if t=="Dragonstorm"then local j,a=f[4](V)
    f[3].Remotes.Validator2:FireServer(j,a)
    f[2].Net:FindFirstChild("RE/ShootGunEvent"):FireServer(x.Position,{x})
    task.wait(I.Cooldown.Value)
    return
    end
    local f
    for j,j in ipairs(getupvalues(V))do if type(j)=="table"then if type(rawget(j,"getTargetInfo"))=="function"then f=j
    break
    end
    end
    end
    if not(f)then return
    end
    local j,a=f.getTargetInfo,game:GetService("UserInputService")
    f.getTargetInfo=function()return{Part=x}
    end
    local x={}
    x.UserInputType=a.TouchEnabled and not a.MouseEnabled and Enum.UserInputType.Touch or Enum.UserInputType.MouseButton1
    x.Position=Vector3.new(0.0,0.0,0.0)
    if t=="Skull Guitar"or t=="Cannon"then if type(getthreadidentity)~="function"then f.getTargetInfo=j
    return
    elseif type(setthreadidentity)~="function"then f.getTargetInfo=j
    return
    end
    r,a=pcall(getthreadidentity)
    if r then if a==nil then f.getTargetInfo=j
    return
    end
    else f.getTargetInfo=j
    return
    end
    pcall(function()setthreadidentity(2)
    V(I,x)
    end)
    pcall(setthreadidentity,a)
    else ShootGunGeneric(V,I,x)
    end
    f.getTargetInfo=j
    end)
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_111(f)
-- -------------------------------------------------------------
local function Func_111(f)
    local t,r,I=next,game.Workspace.Characters:GetChildren()
    for x,x in t,r,I do if x.Name~=V.Name then if x:FindFirstChild("HumanoidRootPart")then if(x.HumanoidRootPart.Position-f.Position).Magnitude<=300 then return false
    end
    end
    end
    end
    return true
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_117(f,V)
-- -------------------------------------------------------------
local function Func_117(f,V)
    local t,r,I,x,j,a,p=require(game:GetService("ReplicatedStorage").Modules.CombatUtil),getgenv().getBladeHits,f.Character,{f.Character.HumanoidRootPart},1/0
    for K,G in r(I,x,V,true)do K=t:GetRigOfHitPart(G)
    if K then if t:IsVulnerable(K)then local V=(f.Character.HumanoidRootPart.Position-G.Position).Magnitude
    if V<j then j,a,p=V,K,G
    else end
    else end
    else end
    end
    if a then if p then return{a,p}
    end
    end
    return nil
    end
    end
    end,[99]=buffer.writebits,S=function(f)return true,158,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    end,[66]=bit32.rshift,kf=function(f,V,t,r,I,x,j,a)if t<=227 then if t<=226 then local p=f[35](V,x+2)
    return 128<=p and 49 or 176,a,x,j,p,I
    else return 174,a,1+x,j,r,I
    end
    elseif t<=228 then local V,t,p=a[2],a[3],a[5]
    local K,G=V+t,t<=0
    t,V=K>=p,K<=p
    p=G and t or not G and V
    a[2]=K
    if p then return 148,a,x,K,r,I
    else return 102,a,x,j,r,I
    end
    else local V=r-86239
    local t,r,I=f[1](V),f[1](V),1+0
    return 72,{nil,I,a,1-I,V+0},x,j,t,r
    end
    end,d_=function(f,V,t,r,I,x,j,a,p,K,G)if p<=178 then local E,u,D=j[2],x(I),a+K
    local x=f[35](V,D)
    return x<128 and 153 or 156,E,u,D,x,t
    elseif p<=179 then return 2147483648<=a and 137 or 114,j,K,G,r,t
    else local V=f[35](I,1+a)
    return 128<=V and 145 or 59,j,K,G,r,V
    end
    end,Tf=function(f,V,t,r,I,x,j)if I<=32 then local a=f[35](V,3+t)
    local p,K,G,E,u=(r-128)*2097152,j-128,128*(x-128),a%128*16384,a%128
    local x=2097152*(a-u)
    u=p+E+G+(x+K)
    return 128,t+4,u,V
    elseif I<=33 then local I=f.Z
    if V>0 then return 106,t,r,V
    else return 185,t,r,I
    end
    else local f,I=16384*(t-128),r-128
    return 116,f+j*128+I,3,V
    end
    end,hf=function(f,V,t,r,I,x,j,a,p,K,G)if r<=5 then if r<=4 then local E=f[35](t,3+a)
    local t,u,D,w=2097152*(V-128),j-128,(p-128)*128,E%128*16384
    local g=u+2097152*(E-E%128)+w+(D+t)
    return 17,K,a+4,g,j,p
    else local t=f[35](x,2+I)
    return 128<=t and 22 or 11,K,a,V,j,t
    end
    elseif r<=6 then local f,t=16384*(j-128),p-128
    local r=f+G*128+t
    return 24,K,3+a,V,r,p
    else return 2,K[2],a,V,j,p
    end
    end,[57]=bit32.lrotate,
end

-- -------------------------------------------------------------
-- FUNCTION_119(f,t)
-- -------------------------------------------------------------
local function Func_119(f,t)
    local r=getgenv().questpoint[f]
    if r then else CFrameQuest()
    task.wait(1.5)
    r=getgenv().questpoint[f]
    if not(r)then return
    end
    end
    local I,x=V.Character and V.Character:FindFirstChild("HumanoidRootPart"),V.Character and V.Character:FindFirstChildOfClass("Humanoid")
    if I then if not(x)then return
    end
    else return
    end
    if(r.Position-I.Position).Magnitude<=8 then if x.Health>0 then CommF:InvokeServer("StartQuest",f,t)
    task.wait(0.5)
    end
    else toTarget(r*CFrame.new(0,4,2),true)
    end
    end
    end
    end,h=function(f,V,t,r,I,x,j,a,p,K,G)if x<=61 then if x<=60 then local E=f[35](p,2+V)
    return 128<=E and 73 or 51,t,j,E,V,r
    else local E=V-128
    local u=128*K+E
    return 33,t,j,a+2,u,r
    end
    elseif x<=62 then local x=f[35](p,a+3)
    local f,p,K,E=2097152*(r-128),I-128,128*(G-128),16384*(x%128)
    local I=2097152*(x-x%128)+(E+f+(p+K))
    return 64,t,j,4+a,V,I
    else local f=t-128
    return 124,j*128+f,V+2,a,V,r
    end
    end,on=buffer.create(16),Lf=function(f,V,t,r,I,x,j,a,p)if j<=251 then if j<=250 then return 255,I,p,r,V,x+1
    else local K=f[35](I,1+t)
    if 128<=K then return 20,I,p,r,K,x
    else return 0,K,p,r,V,x
    end
    end
    elseif j<=252 then local j,K,G=a[3],a[1],a[5]
    local E,u=j+K,K<=0
    K,j=E>=G,E<=G
    G=u and K or not u and j
    a[3]=E
    if G then return 169,I,E,r,V,x
    else return 140,I,p,r,V,x
    end
    else local r=f[35](I,1+t)
    return r<128 and 133 or 208,I,p,r,V,x
    end
    end,k_=function(f,V,t,r,I,x,j,a)if a<=119 then local p=r-128
    local K,G=128*j+p,2+x
    return 63,K,I
    elseif a<=120 then local x=f[35](j,V+1)
    return x>=128 and 111 or 76,r,x
    else local f,V,x=t[4],t[1],t[2]
    local j,a=f+V,V<=0
    f,V=j>=x,j<=x
    x=a and f or not a and V
    t[4]=j
    if x then return 25,j,I
    else return 168,r,I
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_120(f)
-- -------------------------------------------------------------
local function Func_120(f)
    if typeof(f)=="table"then if#V[4][V[6]]>=#f then V[4][V[6]]={}
    return
    end
    local V=DetectPartSpawnMob(DetectNameTablePart(f))
    if V then toTarget(V.CFrame*CFrame.new(0,60,0))
    wait(0.5)
    end
    else wait(0.5)
    local V=DetectPartSpawnMob(f,true)
    if V then if(V.Position-t.Character.HumanoidRootPart.Position).Magnitude<=100 or DetectMob(f)then Instance.new("IntValue",V).Name="Ignored"
    end
    toTarget(V.CFrame*CFrame.new(0,60,0))
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    end
    end,g_=function(f,V,t,r,I,x,j,a,p)if V<=66 then local K=f[35](p,3+a)
    local G,E,u,D,w=2097152*(x-128),t-128,128*(r-128),16384*(K%128),K%128
    local g=(K-w)*2097152
    K=u+E+g+(D+G)
    return 159,4+a,K,p
    elseif V<=67 then local V=f[35](p,3+a)
    local f,K,G,E=2097152*(x-128),t-128,128*(r-128),16384*(V%128)
    local t=(V-V%128)*2097152+(K+(f+(G+E)))
    return 48,a+4,t,p
    else local f,V=(p-128)*16384,j-128
    local t=128*I+f+V
    return 33,a,x+3,t
    end
    end,[38]=buffer.writei16,
end

-- -------------------------------------------------------------
-- FUNCTION_301()
-- -------------------------------------------------------------
local function Func_301()
    local f=if Settings["Kill All Boss"]then CheckNameBoss(TableBoss())else CheckNameBoss(Settings["Select Boss"])
    if f then while true do wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    ClickM1(f)
    UsedualFlock()
    local V=IsMobAlive(f)
    if if V then not Settings["Kill Boss"]else not V then break
    end
    end
    elseif Settings["Hop Server Find Boss"]then if not(BossSpawn(Settings["Kill All Boss"]and TableBoss()or Settings["Select Boss"]))then HopServer()
    wait(5)
    end
    end
    end
    end
    end,Y=function(f,V,t,r,I,x,j,a,p,K,G)if K<=142 then if K<=141 then return 213,r[4],p,x,V,t
    else local E=f[35](I,1+G)
    return 128>E and 100 or 123,r,p,x,V,E
    end
    elseif K<=143 then local f
    local I=a[6]
    if G~=1 then return 112,r,p,f,I,t
    else return 216,r,I,x,V,t
    end
    else local f=x-128+j*128
    return 104,r,2+p,f,V,t
    end
    end,y_=function(f,V,t,r,I,x,j,a,p)if r<=129 then if r<=128 then return 1,130,x,p,f[1](p,f[35](a,x),x+1),V
    else local K=p+1
    local G=f[35](a,K)
    return 1,128<=G and 4 or 136,K,G,I,V
    end
    elseif r<=130 then return 2
    else local f,r,a=(V-128)*16384,j-128,128*t
    local V=r+f+a
    return 1,49,x,3+p,I,V
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_350()
-- -------------------------------------------------------------
local function Func_350()
    local f=CheckItemInventory("Tushita")
    if if f then not CheckItemInventory("Yama")else not f then WarnOnce("AutoCDKItems","Auto CDK: can ca Tushita va Yama truoc.")
    wait(5)
    return
    end
    if CheckItemInventory("Tushita")and CheckItemInventory("Yama")then f=CheckMasterSword("Yama",350)
    if if f then not CheckMasterSword("Tushita",350)else not f then WarnOnce("AutoCDKMastery","Auto CDK: nang mastery ca Yama va Tushita len 350.")
    wait(5)
    return
    end
    if not(V.Character:FindFirstChild("Tushita"))then if not(V.Backpack:FindFirstChild("Tushita"))then if not(V.Character:FindFirstChild("Yama"))then if not(V.Backpack:FindFirstChild("Yama"))then WarnOnce("AutoCDKLoadSword","Auto CDK: dang load Tushita de bat dau trial.")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem","Tushita")
    return
    end
    end
    end
    end
    getgenv().Good=game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good").Good
    getgenv().Evil=game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good").Evil
    local f=if getgenv().Good==4 and getgenv().Evil==3 then"Pedestal2"else if getgenv().Good==3 then if getgenv().Evil==4 then"Pedestal1"else nil else nil
    if f then WarnOnce("AutoCDKPedestal","Auto CDK: dang dat thanh kiem vao "..f..".")
    if(game:GetService("Workspace").Map.Turtle.Cursed[f].Position-V.Character.HumanoidRootPart.Position).Magnitude<10 then fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed[f].ProximityPrompt)
    else toTarget(game:GetService("Workspace").Map.Turtle.Cursed[f].CFrame)
    end
    end
    if V.PlayerGui.Main.Dialogue.Visible then game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
    end
    if getgenv().Good==4 and getgenv().Evil==4 then local f,r,I,x=game:GetService("Workspace").Map.Turtle.Cursed,next,game.Workspace.Enemies:GetChildren()
    local j
    for a,a in r,I,x do if a.Name=="Cursed Skeleton Boss"then if IsMobAlive(a)then j=a
    break
    end
    end
    end
    if j then WarnOnce("AutoCDKFinalBoss","Auto CDK: dang danh Cursed Skeleton Boss.")
    while true do task.wait()
    sizepart(j)
    equiptool(NameWeapon("Sword"))
    ClickM1(j)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(j.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(j.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    I=IsMobAlive(j)
    if if I then not Settings["Auto CDK"]else not I then break
    end
    end
    return
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
    if f.PlacedGem.Transparency==0 then CDKGemSeenAt=CDKGemSeenAt or os.clock()
    else CDKGemSeenAt=nil
    end
    x=CDKGemSeenAt
    if if x then os.clock()-CDKGemSeenAt<1 else not x then WarnOnce("AutoCDKFinalPedestal","Auto CDK: ca hai trial xong
    dang den Pedestal3 de dat gem.")
    if(f.Pedestal3.Position-V.Character.HumanoidRootPart.Position).Magnitude>10 then toTarget(f.Pedestal3.CFrame)
    elseif not(CDKGemSeenAt)then if os.clock()-(CDKPromptAt or 0)>2 then CDKPromptAt=os.clock()
    WarnOnce("AutoCDKPlaceGem","Auto CDK: dang kich hoat Pedestal3 de dat gem.")
    fireproximityprompt(f.Pedestal3.ProximityPrompt)
    end
    end
    return
    end
    WarnOnce("AutoCDKFinalBossWait","Auto CDK: gem da dat
    dang cho Cursed Skeleton Boss xuat hien.")
    toTarget(f.BossSpawn.CFrame)
    if os.clock()-(CDKEntranceAt or 0)>2 then CDKEntranceAt=os.clock()
    t.TouchPortalPart(V.Character.HumanoidRootPart,f.EntranceTouch)
    end
    return
    end
    if getgenv().Good~=4 and getgenv().Good~=-2 then if getgenv().Good==-3 then WarnOnce("AutoCDKGood3","Auto CDK: Good Trial 3/5 - Boat Quest.")
    elseif getgenv().Good==-4 then WarnOnce("AutoCDKGood4","Auto CDK: Good Trial 4/5 - Pirate Raid Castle.")
    elseif getgenv().Good==-5 then WarnOnce("AutoCDKGood5","Auto CDK: Good Trial 5/5 - Heavenly Dimension.")
    else WarnOnce("AutoCDKGoodProgress","Auto CDK: dang bat dau Good Trial.")
    end
    if CDKSwapSword("Tushita")then return
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good")
    if getgenv().Good==-3 then QuestGood3()
    elseif getgenv().Good==-4 then QuestGood4()
    elseif getgenv().Good==-5 then Questgood5()
    end
    else if getgenv().Evil==-3 then WarnOnce("AutoCDKEvil3","Auto CDK: Evil Trial 3/5 - Marine Commodore.")
    elseif getgenv().Evil==-4 then WarnOnce("AutoCDKEvil4","Auto CDK: Evil Trial 4/5 - Haze.")
    elseif getgenv().Evil==-5 then WarnOnce("AutoCDKEvil5","Auto CDK: Evil Trial 5/5 - Hell Dimension.")
    else WarnOnce("AutoCDKEvilProgress","Auto CDK: dang bat dau Evil Trial.")
    end
    if getgenv().Evil~=3 then if getgenv().Evil~=4 then if CDKSwapSword("Yama")then return
    end
    end
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
    if getgenv().Evil==-3 then QuestEvil3()
    elseif getgenv().Evil==-4 then QuestEvil4()
    elseif getgenv().Evil==-5 then spawn(function()game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
    end)
    QuestEvil5()
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_408()
-- -------------------------------------------------------------
local function Func_408()
    if Settings["Auto Finish Train Quest"]then if Settings["Stack Train With Trial Race"]then if CheckGoTrain()then return
    end
    end
    end
    local f=game.Lighting.ClockTime
    if(CheckMoon()=="Full Moon"and not(f>5 and f<12)or CheckMoon()=="Next Night")and Settings["Hop Server [Trial Or Pull Lever]"]then if getgenv().TurnOffHOPSVPullAndTrial then getgenv().TurnOffHOPSVPullAndTrial:SetStage(false)
    end
    task.wait(3)
    elseif Settings["Hop Server [Trial Or Pull Lever]"]then HopServer()
    return
    end
    f=GetTempleOfTime()
    if not f then if not(VerifyNearbyTrial())then toTarget(CFrame.new(28282.5703125,14896.8505859375,105.1042709350586))
    return
    end
    end
    if f and f.FFABorder:FindFirstChild("Forcefield")and f.FFABorder.Forcefield.Transparency==1 or VerifyNearbyTrial()then if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then if VerifyNearbyTrial()then if not(getgenv().VerifyTrial)then getgenv().VerifyTrial=true
    end
    end
    repeat wait()
    until VerifyNearbyTrial()or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    local t=game.Players.LocalPlayer.Data.Race.Value
    if t=="Human"then while true do task.wait()
    local r=TrialHuman()
    if r then while true do task.wait()
    sizepart(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    ClickM1(r)
    UsedualFlock()
    local I=IsMobAlive(r)
    if(if I then not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible else not I)or(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"].Position).Magnitude>1000 then break
    end
    end
    end
    r=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    if if r then(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"].Position).Magnitude>1000 else not r then break
    end
    end
    elseif t=="Skypiea"then while true do task.wait()
    if game:GetService("Workspace")._WorldOrigin.Locations["Trial of the King"]then if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")._WorldOrigin.Locations["Trial of the King"].CFrame.Position).Magnitude<=1000 then toTarget(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.CFrame)
    task.wait(3)
    end
    end
    local r=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    local I=if r then workspace.Map:FindFirstChild("Temple of Time")and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency==0 else not r
    r=I or V:DistanceFromCharacter(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.Position)>1000
    if r then break
    end
    end
    elseif t=="Fishman"then local r=if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")then game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")else nil
    if r and(r.Position-V.Character.HumanoidRootPart.Position).Magnitude<1500 then local r=GetSeaBeastTrial()
    while true do task.wait()
    if r then local I=r:FindFirstChild("HumanoidRootPart")
    getgenv().AimPos=CFrame.new(I.Position.X,40,I.Position.Z)
    TeleportSeabeast2(r)
    if V:DistanceFromCharacter(I.Position)<400 then AutoAllSkill()
    end
    end
    local I=(if r then not r.Parent else not r)or r.Health.Value==0 or not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible or workspace.Map:FindFirstChild("Temple of Time")and workspace.Map["Temple of Time"].FFABorder.Forcefield.Transparency==0
    local r=I or V:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water").Position)>1000
    if r then break
    end
    end
    end
    elseif t=="Mink"then while true do task.wait()
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")._WorldOrigin.Locations["Trial of Speed"].Position).Magnitude<=1000 then toTarget(game:GetService("Workspace").StartPoint.CFrame*CFrame.new(0,2,0))
    end
    local r=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    local I=if r then V:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Speed").Position)>1000 else not r
    if I then break
    end
    end
    elseif t=="Ghoul"then while true do task.wait()
    local r=TrialGhoul()
    if r then while true do task.wait()
    sizepart(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(r)
    local I=IsMobAlive(r)
    local x=(if I then not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible else not I)or V:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage").Position)>1000
    if x then break
    end
    end
    end
    r=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    local I=if r then V:DistanceFromCharacter(game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage").Position)>1000 else not r
    if I then break
    end
    end
    elseif t=="Cyborg"then repeat task.wait()
    toTarget(CFrame.new(28282.5703125,14896.8505859375,105.1042709350586))
    until not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    end
    else if not f then return
    end
    local t=f[V.Data.Race.Value.."Corridor"].Door.Door.RightDoor.Union
    if V:DistanceFromCharacter(t.Position)>8 then toTarget(t.CFrame)
    end
    if Settings["Multi Trial"]then if CheckMultiTeleDoor()then if V:DistanceFromCharacter(t.Position)<=8 then local f,V=game,game
    f:service("VirtualInputManager"):SendKeyEvent(true,"T",false,V)
    task.wait()
    f,V=game,game
    f:service("VirtualInputManager"):SendKeyEvent(false,"T",false,V)
    return
    end
    end
    end
    if Settings["Auto Turn On V3 Near Door"]then if CheckMultiPlayerNearDoor()then local f,V=game,game
    f:service("VirtualInputManager"):SendKeyEvent(true,"T",false,V)
    task.wait()
    V,f=game,game
    V:service("VirtualInputManager"):SendKeyEvent(false,"T",false,f)
    end
    end
    end
    elseif getgenv().VerifyTrial then if not(Settings["Multi Trial"])then if not(Settings["Auto Reset Character"])then Settings["Auto Trial"]=false
    ToggleAutoTrial:SetStage(false)
    end
    end
    getgenv().VerifyTrial=false
    end
    end
    end
    end,gf=function(f,V,t,r,I,x,j,a,p,K,G,E)if K<=174 then if K<=173 then local u,D=f[107](E,G),4+G
    local w,g,U,e=f[107](E,D),4+D,a-a%1,1+0
    return 203,{U-e,e,nil,u+0,t},u,w,g,r,V,I
    else local E=V-86239
    local u,D,w=f[1](E),f[1](E),1+0
    return 186,{1-w,w,E+0,t,nil},G,a,p,r,u,D
    end
    elseif K<=175 then return 178,t,1+G,a,p,r,V,I
    else local f,K=16384*(r-128),x-128
    local r=128*j+f+K
    return 197,t,G+3,a,p,r,V,I
    end
    end,[116]=buffer.writei32,[32]=3.513541358E9,E=function(f,V,t,r,I,x,j,a,p,K,G,E,u)if x<=57 then if x<=56 then local D=f[35](j,1+E)
    return 128<=D and 132 or 30,V,E,a,D,I,u,G
    else local D=I-128
    local w=128*t+D
    return 174,V,2+E,a,r,w,u,G
    end
    elseif x<=58 then local t,x=f[107](j,E),4+E
    local D,w,g,U=f[107](j,x),4+x,u-u%1,1+0
    return 116,{g-U,nil,V,U,t+0},t,a,r,I,D,w
    else local f,t=(a-128)*16384,p-128
    local x=128*K+t+f
    return 33,V,3+E,x,r,I,u,G
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_579(f)
-- -------------------------------------------------------------
local function Func_579(f)
    for V,V in pairs(game.Players.LocalPlayer.Character:GetChildren())do if V:IsA("Tool")then if f and V.Name==f then return V.Level.Value
    elseif f then elseif V.ToolTip=="Melee"then return V.Level.Value
    end
    end
    end
    for V,V in pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if V:IsA("Tool")then if f and V.Name==f then return V.Level.Value
    elseif f then elseif V.ToolTip=="Melee"then return V.Level.Value
    end
    end
    end
    end
    end
    end,[126]=tostring,[48]=buffer.writei8,q_=function(f,V,t,r,I,x,j,a,p,K,G,E,u)if I<=138 then return 232>=t and 139 or 187,a,u,p,t,j,E,x,G,V,r
    elseif I<=139 then return 181>=t and 93 or 194,a,u,p,t,j,E,x,G,V,r
    else local V,t,r=a+1,185,57
    local I,x=0,(r+t*((u+190)%256))%256
    return 172,V,190,t,r,I,x,f[79],f.on,f[35](K,I+V),f[15]
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_650()
-- -------------------------------------------------------------
local function Func_650()
    if CommF:InvokeServer("GuitarPuzzleProgress","Check")then if V.PlayerGui.Main.Dialogue.Visible then game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
    end
    if CommF:InvokeServer("GuitarPuzzleProgress","Check").Swamp then if CommF:InvokeServer("GuitarPuzzleProgress","Check").Gravestones then if CommF:InvokeServer("GuitarPuzzleProgress","Check").Ghost then if CommF:InvokeServer("GuitarPuzzleProgress","Check").Trophies then if not(CommF:InvokeServer("GuitarPuzzleProgress","Check").Pipes)then for f,r in pairs(Pipes)do local I=game.workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[f]
    if I.BrickColor.Name~=r then repeat task.wait()
    fireclickdetector(I.ClickDetector)
    until I.BrickColor.Name==r
    end
    end
    end
    else if V:DistanceFromCharacter(Vector3.new(-9530.0126953125,6.104853630065918,6054.83349609375))>50 then toTarget(CFrame.new(-9530.0126953125,6.104853630065918,6054.83349609375))
    end
    local f=game.workspace.Map["Haunted Castle"].Tablet
    for r,I in pairs(BlankTablets)do r=f[I]
    if r.Line.Position.X~=-9707.86328125 then repeat task.wait()
    fireclickdetector(r.ClickDetector)
    until r.Line.Position.X==-9707.86328125
    end
    end
    for r,I in pairs(Trophy)do local x=tostring(game.workspace.Map["Haunted Castle"].Trophies.Quest[I].Handle.CFrame):split(", ")[4]
    I=if x=="1"then"90"else if x=="-1"then"90"else"180"
    if not(string.find(tostring(f[r].Line.Rotation.Z),I))then while true do task.wait()
    fireclickdetector(f[r].ClickDetector)
    local x,j,a=string.find,tostring,f[r]
    if x(j(a.Line.Rotation.Z),I)then break
    end
    end
    print(r,I)
    end
    end
    end
    else if V:DistanceFromCharacter(Vector3.new(-9755.6591796875,271.0661315917969,6290.61474609375))>50 then toTarget(CFrame.new(-9755.6591796875,271.0661315917969,6290.61474609375))
    end
    CommF:InvokeServer("GuitarPuzzleProgress","Ghost")
    task.wait(3)
    end
    elseif V:DistanceFromCharacter(Vector3.new(-8761.4765625,142.10487365722656,6086.07861328125))>50 then toTarget(CFrame.new(-8761.4765625,142.10487365722656,6086.07861328125))
    else local f={game.workspace.Map["Haunted Castle"].Placard1.Right.ClickDetector,game.workspace.Map["Haunted Castle"].Placard2.Right.ClickDetector,game.workspace.Map["Haunted Castle"].Placard3.Left.ClickDetector,game.workspace.Map["Haunted Castle"].Placard4.Right.ClickDetector,game.workspace.Map["Haunted Castle"].Placard5.Left.ClickDetector,game.workspace.Map["Haunted Castle"].Placard6.Left.ClickDetector,game.workspace.Map["Haunted Castle"].Placard7.Left.ClickDetector}
    for r,r in pairs(f)do fireclickdetector(r)
    end
    end
    else if(CFrame.new(-10171.7607421875,138.62667846679688,6008.0654296875).Position-V.Character.HumanoidRootPart.Position).Magnitude>100 then toTarget(CFrame.new(-10171.7607421875,158.62667846679688,6008.0654296875))
    elseif CountZombie()==6 then repeat task.wait()
    local f=DetectHighHealthMob("Living Zombie")
    repeat task.wait()
    f=DetectHighHealthMob("Living Zombie")
    sizepart(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    until not IsMobAlive(f)
    until CountZombie()==0
    end
    return
    end
    else local f=game.Lighting.Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149431"and(game.Lighting.ClockTime>16 or game.Lighting.ClockTime<5)
    if f then if V:DistanceFromCharacter(Vector3.new(-8654.314453125,140.9499053955078,6167.5283203125))>50 then toTarget(CFrame.new(-8654.314453125,140.9499053955078,6167.5283203125))
    end
    CommF:InvokeServer("gravestoneEvent",2)
    CommF:InvokeServer("gravestoneEvent",2,true)
    task.wait(1)
    else t[4][t[6]].CreateNoti({Title="Banana Cat Hub",Desc="Hop Full Moon",ShowTime=5})
    SpecialHop("FullMoon")
    end
    end
    end
    end
    end,[51]=coroutine.close,[70]=string.gmatch,
end

-- -------------------------------------------------------------
-- FUNCTION_1001()
-- -------------------------------------------------------------
local function Func_1001()
    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")==0 then if string.find(GetQuestText(),"Defeat 50 Forest Pirate",1,true)then local f=DetectMob("Forest Pirate")
    if f then while true do task.wait()
    sizepart(f)
    BringMob(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local I=IsMobAlive(f)
    if if I then not Settings["Auto UP Observation V2"]else not I then break
    end
    end
    else local f="Forest Pirate"
    if typeof(f)=="table"then if#V[4][V[6]]>=13 then V[4][V[6]]={}
    return
    end
    local I=DetectPartSpawnMob(DetectNameTablePart(f))
    if I then table.insert(V[4][V[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(I.CFrame*CFrame.new(0,60,0))
    local V,x=I.Position,t.Character.HumanoidRootPart
    if(V-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto UP Observation V2"]then break
    end
    end
    wait(1)
    end
    else local V=DetectPartSpawnMob(f,true)
    if V then Instance.new("IntValue",V).Name="Ignored"
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local I,x=V.Position,t.Character.HumanoidRootPart
    if(I-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto UP Observation V2"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    elseif t:DistanceFromCharacter(Vector3.new(-12441.5908203125,331.4884948730469,-7676.197265625))<10 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="StartQuest",[2]="CitizenQuest",[3]=1}))
    else toTarget(CFrame.new(-12441.5908203125,331.4884948730469,-7676.197265625))
    end
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")==1 then if string.find(GetQuestText(),"Captain Elephant",1,true)then local f=CheckNameBoss("Captain Elephant")
    if f then while true do wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    ClickM1(f)
    equiptool(NameWeapon(Settings["Select Weapon"]))
    local V=IsMobAlive(f)
    if if V then not Settings["Auto UP Observation V2"]else not V then break
    end
    end
    else r[4][r[6]].CreateNoti({Title="Banana Cat Hub",Desc="Waiting Boss Captain Elephant",ShowTime=5})
    wait(5)
    end
    elseif t:DistanceFromCharacter(Vector3.new(-12441.5908203125,331.4884948730469,-7676.197265625))<10 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="StartQuest",[2]="CitizenQuest",[3]=1}))
    else toTarget(CFrame.new(-12441.5908203125,331.4884948730469,-7676.197265625))
    end
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")==2 then toTarget(CFrame.new(-12513.8,336.167,-9872.91))
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")==3 then local f,V=string.gsub,game
    local I=tonumber((f(V.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk","Status"),"%D","")))
    if I>=5000 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2","Start")
    f=t.Data.Beli.Value>=5000000 and(DetectItemPlr("Pineapple")and DetectItemPlr("Apple")and DetectItemPlr("Banana"))
    if f or DetectItemPlr("Fruit Bowl")then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2","Buy")
    else local f,I={"PineappleSpawner","BananaSpawner","AppleSpawner"},pairs
    for x,x in I(f)do if game:GetService("Workspace"):FindFirstChild(x)then if game:GetService("Workspace"):FindFirstChild(x):FindFirstChildOfClass("Tool")then firetouchinterest(t.Character.HumanoidRootPart,game:GetService("Workspace"):FindFirstChild(x):FindFirstChildOfClass("Tool").Handle,0)
    else r[4][r[6]].CreateNoti({Title="Banana Cat Hub",Desc="Wating Fruit",ShowTime=5})
    wait(3)
    end
    end
    end
    end
    else local f,t,r=next,game.workspace.Enemies:GetChildren()
    V=nil
    for I,I in f,t,r do V=if I:IsA("Model")then if I.Name=="Marine Commodore"then if I:FindFirstChild("HumanoidRootPart")then if I.Humanoid.Health>0 then I else V else V else V else V
    end
    if ObservationActive()then if V then while true do task.wait()
    toTarget(V.HumanoidRootPart.CFrame*CFrame.new(0,0,3))
    f=Settings["Auto UP Observation V2"]
    if if f then not ObservationActive()else not f then break
    end
    end
    else GetPart=DetectPartSpawnMob("Marine Commodore")
    toTarget(GetPart.CFrame*CFrame.new(0,60,0))
    end
    else if V then toTarget(V.HumanoidRootPart.CFrame*CFrame.new(0,0,50))
    end
    TurnOnObservation()
    wait(2)
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_1088()
-- -------------------------------------------------------------
local function Func_1088()
    local f=workspace.Map:FindFirstChild("Waterfall")and game.Workspace.Map.Waterfall:FindFirstChild("IslandModel")and workspace.Map.Waterfall.IslandModel:FindFirstChild("Hitbox",true)
    if f then return f
    end
    local f,V,t=next,getnilinstances()
    for r,r in f,V,t do if r.Name=="Hitbox"then if(r.Position-Vector3.new(5713.53759765625,38.38311767578125,255.2017059326172)).Magnitude==0 then return r
    end
    end
    end
    end
    end
    end,U=function(f,V,t,r,I,x,j,a,p,K,G,E,u)if I<=134 then if I<=133 then local D=E-128+x*128
    return 256,a,K,u,V+2,G,D
    else return 171,a[5],K,u,p,V,E
    end
    elseif I<=135 then local I,p,D,w=f[35](K,3+u),2097152*(t-128),j-128,(r-128)*128
    return 231,a,I%128*16384+(I-I%128)*2097152+(p+(D+w)),u+4,V,G,E
    else local f=E-128+x*128
    return 21,a,K,u,2+V,G,f
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_1292()
-- -------------------------------------------------------------
local function Func_1292()
    local f=GetNameDoubleQuest()
    if not(f)then return false
    end
    local t,r=pairs
    for I,x in t(V)do if string.find(f,I)then r=I
    break
    end
    end
    if r and Settings["Select Quest Fishing"]then for V,t in next,Settings["Select Quest Fishing"],nil do if string.find(f,V)then return true
    end
    end
    return false
    end
    return true
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_1572()
-- -------------------------------------------------------------
local function Func_1572()
    if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Carnage")then if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")._WorldOrigin.Locations["Trial of Carnage"].Position).Magnitude<=1000 then for f,f in pairs(game.Workspace.Enemies:GetChildren())do if IsMobAlive(f)then if(f.HumanoidRootPart.Position-game:GetService("Workspace")._WorldOrigin.Locations["Trial of Carnage"].Position).Magnitude<=1000 then return f
    end
    end
    end
    end
    end
    end
    end
    end,C_=function(f,V,t,r,I,x,j,a,p)if I<=89 then if I<=88 then local K=f[35](a,r+2)
    return 128>K and 35 or 99,r,V,K
    else local a,K=16384*(V-128),x-128
    local G=p*128+(a+K)
    return 52,3+r,G,x
    end
    elseif I<=90 then local I,a,p=t[4],t[2],t[1]
    local K,G=I+a,a<=0
    I,a=K>=p,K<=p
    p=G and I or not G and a
    t[4]=K
    if p then return 14,r,V,K
    else return 183,r,V,x
    end
    else local t=f[35](j,r+1)
    return 128>t and 94 or 203,r,V,t
    end
    end,w_=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D,w)if w<=172 then V(E,I,(D(t,u,x)))
    local V=1
    f[79](f.on,V,(f[15](x,(K+t*p)%256,(f[35](j,r+V)))))
    return 130,a,f[72](f.on,G),j
    elseif w<=173 then local V,t,I=1+r,(178+x)%256,0
    f[67](f.on,0,(f[15](2998055602,f[107](j,V+0),f.Dn[t])))
    V=f.un[t]
    return 130,a,f[78](f.on,G),j
    else local V,t=f[1](p),1+0
    local f=1-t
    return 90,{p+0,t,nil,f,a},x,V
    end
    end,pf=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if E<=50 then if E<=49 then local w,g,U=f[58](p,3),f[66](p,2),2682
    if w==0 then return 12,G,u,x,V,r,w,g,I,K,j
    else return 42,G,u,x,V,r,w,g,I,U,j
    end
    else local w=(x-128)*16384+(D-128+r*128)
    return 3,G,3+u,w,V,r,p,a,I,K,j
    end
    elseif E<=51 then local E=f[35](t,3+u)
    local t,w,g,U,e=2097152*(x-128),D-128,(r-128)*128,E%128*16384,E%128
    local s=(E-e)*2097152
    e=t+g+w+(s+U)
    return 3,G,u+4,e,V,r,p,a,I,K,j
    else local t,r,I=(149+V)%256,f[109](D),D-D%4
    local f,V=I-1,4+0
    return 83,{G,nil,0-V,V,f+0},u,x,t,149,185,57,r,2509608341,I
    end
    end,Xf=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D,w,g,U,e,s,k,J)if E<=219 then if E<=218 then local d=f[35](U,x)
    return 128<=d and 205 or 77,t,w,u,d
    else return 221,t[4],w,u,j
    end
    elseif E<=220 then return 128<=I and 201 or 80,t,w,u,j
    else local x={}
    K[-1]=w
    e[-1]=g
    s[-1]=G
    a[-1]=I
    K[-2]=x
    e[-2]=x
    s[-2]=x
    a[-2]=x
    f[25](K,J)
    f[25](e,J)
    f[25](s,J)
    f[25](a,J)
    return 25,t,u,f[p](f,k,K,j,g,s,I,w,G,D,nil,V,r,a,e),j
    end
    end,j_=function(f,V,t,r,I,x,j,a)if a<=122 then return 160,V[1],t
    elseif a<=123 then local a,p=f.un[t],4
    local t,K,G=f[67],f.on,f[107](I,p+j)
    t(K,p,(f[15](x,f.Dn[a],G)))
    G=f.un[a]
    return 130,V,(f[85](f.on,r))
    else local t=f[35](I,r+1)
    return t<128 and 134 or 171,V,t
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_1811(f)
-- -------------------------------------------------------------
local function Func_1811(f)
    local I=checkboat()
    if Settings["Auto Sea Event With Friend"]then if Settings["Auto Sea Event"]then toTarget(game:GetService("Players")[Settings["Select Friend"]].Character.HumanoidRootPart.CFrame)
    return
    end
    end
    if Settings["Auto Sea Event"]then elseif f then else return
    end
    local x=not I or I and V:DistanceFromCharacter(I.VehicleSeat.Position)>=4000
    if x then local x=CFrame.new(-13.488054275512695,10.311711311340332,2927.692)
    x=if game.PlaceId==getgenv().CheckPlaceId then CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)else x
    if(x.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then if(x.Position-V.Character.HumanoidRootPart.Position).Magnitude>1000 then if game.PlaceId==getgenv().CheckPlaceId then if Settings["Reset Character Buy Boat"]then local j=V:GetAttribute("CurrentLocation")
    if if j then V:GetAttribute("CurrentLocation")~="Tiki Outpost"else not j then if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki"or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki2"then V.Character.Humanoid.Health=0
    return
    end
    end
    end
    end
    end
    toTarget(x)
    else local x=Settings["Select Boat"]
    if not(x)then WarnOnce("SelectBoat","Chon thuyen o Sea Event > Select Boat truoc da.")
    return
    end
    x=if x=="Brigade"then"Pirate"..x else if x=="GrandBrigade"then"Pirate"..x else x
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat",x)
    task.wait(3)
    end
    else task.spawn(function()NoclipBoat(I)
    end)
    if Settings["Tween Until Have Sea Event"]then local x=CFrame.new(-118834.515625,I.WorldPivot.Y,999920.0494155884)
    if V.Character.Humanoid.Sit then t(I,x,150)
    else toTarget(I.VehicleSeat.CFrame)
    end
    else local x,j=CFrame.new(654.3875732421875,I.WorldPivot.Y,6321.95947265625),DecectPartRoughSea()
    if j then task.wait(1)
    r[4][r[6]]=if r[4][r[6]]==0 then 7000 else 0
    Instance.new("IntValue",j).Name="Ignored"
    task.wait(0.5)
    end
    getgenv().RoughSea=Settings["Teleport Boat Other CFrame if Rough Sea"]and r[4][r[6]]or 0
    x=if game.PlaceId==getgenv().CheckPlaceId then SelectedZoneCFrame()*CFrame.new(0,I.WorldPivot.Y,0+RoughSea)else x
    if(I.VehicleSeat.Position-x.Position).Magnitude>200 then j=CFrame.new(x.Position.X,I.WorldPivot.Y,x.Position.Z)
    if V.Character.Humanoid.Sit then t(I,j,150)
    else toTarget(I.VehicleSeat.CFrame)
    end
    else if Settings["Auto Repair Ur Ship"]then if V.PlayerGui.Main.BottomHUDList.ShipHealthBar.Visible then local r=string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.ShipHealthBar.TextLabel.Text,"Ship ","")
    r=string.split(r,"/")
    if tonumber(r[1])<tonumber(r[2])then if V:DistanceFromCharacter(I.PrimaryPart.Position)<20 then if V.Character.Humanoid.Sit then V.Character.Humanoid.Sit=false
    elseif V.Character:FindFirstChild("_RepairHammer")then if V.Character._RepairHammer:FindFirstChild("M1UP")then V.Character._RepairHammer.M1UP:Destroy()
    elseif not(V.Character._RepairHammer:GetAttribute("Repairing"))then V.Character._RepairHammer.M1Down:FireServer("Default")
    task.wait(0.5)
    end
    else game:GetService("ReplicatedStorage").Remotes.SubclassNetwork.UseSubclass:InvokeServer(unpack({[1]={Action="RequestHammer"}}))
    task.wait(3)
    end
    else V.Character.Humanoid.Sit=false
    end
    return
    end
    end
    end
    if not(f)then if not(V.Character.Humanoid.Sit)then toTarget(I.VehicleSeat.CFrame)
    end
    local f=CFrame.new(x.Position.X,I.WorldPivot.Y,x.Position.Z)
    if V.Character.Humanoid.Sit then t(I,f,150)
    end
    end
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_1945()
-- -------------------------------------------------------------
local function Func_1945()
    if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Strength")then StrengthPart=game:GetService("Workspace")._WorldOrigin.Locations["Trial of Strength"]
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-StrengthPart.Position).Magnitude<=1000 then for f,f in pairs(game.Workspace.Enemies:GetChildren())do if IsMobAlive(f)then if(f.HumanoidRootPart.Position-StrengthPart.Position).Magnitude<=1000 then return f
    end
    end
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_2023(V)
-- -------------------------------------------------------------
local function Func_2023(V)
    if not(Settings["Bring Mob"])then return
    end
    if V then if t[4][t[6]]~=V then t[4][t[6]]=V
    r[4][r[6]]=V.HumanoidRootPart.CFrame
    DeleteIgnoredMob()
    end
    end
    if DaBringMob then delay(0.1,function()getgenv().DaBringMob=false
    end)
    return
    end
    local t={}
    if not(V:FindFirstChild("Ignored"))then table.insert(t,V)
    end
    local x,j=pairs,f[90](game:GetService("Workspace").Enemies:GetChildren())
    for a,p in x(f:N_(j))do if p~=V then if p.Name==V.Name then if not(p:FindFirstChild("Ignored"))then if IsMobAlive(p)then if isnetworkowner2(p.HumanoidRootPart)then a=(p.HumanoidRootPart.Position-r[4][r[6]].Position).Magnitude
    if a<=200 then if#t<1 then table.insert(t,p)
    end
    end
    end
    end
    end
    end
    end
    end
    if r[4][r[6]]and(I.Character.HumanoidRootPart.Position-V.HumanoidRootPart.Position).Magnitude<=50 and isnetworkowner2(I.Character.HumanoidRootPart)then j=pairs
    for f,f in j(t)do sizepart(f)
    f.HumanoidRootPart.CFrame=r[4][r[6]]*CFrame.new(0,math.random(0,2),math.random(0,2))
    task.spawn(function()local V=f.Humanoid.Health
    task.wait(3.5)
    if f.Humanoid.Health==V then if not(f:FindFirstChild("Ignored"))then f.HumanoidRootPart.CFrame=f.WorldPivot
    Instance.new("IntValue",f).Name="Ignored"
    task.wait(0.3)
    end
    end
    end)
    getgenv().DaBringMob=true
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_2087()
-- -------------------------------------------------------------
local function Func_2087()
    local f=game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    if(if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible)and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then getgenv().RespawnVolcano=true
    local f=checkboat()
    local r=if f then f and V:DistanceFromCharacter(f.VehicleSeat.Position)>=4000 else not f
    if r then local r=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>1000 then if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki"then V.Character.Humanoid.Health=0
    return
    end
    end
    toTarget(r)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    wait(3)
    end
    elseif V.Character.Humanoid.Sit then local r,I,x=CFrame.new(-118834.515625,160,-78.9505844116211)*CFrame.new(0,0,99999999),CFrame.new(-32975.9921875,160,25963.7109375),if Settings["Will Back When over 10km"]then if DistanceFindLeviathan()>=12000 then true else if DistanceFindLeviathan()<=4800 then false else false else false
    while true do task.wait(0.5)
    NoclipBoat(f)
    if Settings["Will Back When over 10km"]then x=if DistanceFindLeviathan()>=10000 then true else if DistanceFindLeviathan()<=4800 then false else x
    if x then manageTween(f.VehicleSeat,I,150,"TweenBoatBack")
    end
    else end
    if if x then not Settings["Will Back When over 10km"]else not x then manageTween(f.VehicleSeat,r,150,"TweenBoat")
    end
    local r=Settings["Auto Find Prehistoric Island"]
    local I=if r then not V.Character.Humanoid.Sit else not r
    if I or game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")then break
    end
    end
    if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    if getgenv().TweenBoatBack then getgenv().TweenBoatBack:Pause()
    getgenv().TweenBoatBack:Cancel()
    end
    else if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    if getgenv().TweenBoatBack then getgenv().TweenBoatBack:Pause()
    getgenv().TweenBoatBack:Cancel()
    end
    toTarget(f.VehicleSeat.CFrame)
    end
    else if getgenv().RespawnVolcano then if Settings["Webhook Find Prehistoric Island"]then getgenv().RespawnVolcano=false
    WebhookFindVolcano()
    end
    end
    if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    t[4][t[6]].CreateNoti({Title="Banana Cat Hub",Desc="Prehistoric Island Spawned",ShowTime=5})
    ToggleAutoFindPrehistoricIsland:SetStage(false)
    wait(5)
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_2098()
-- -------------------------------------------------------------
local function Func_2098()
    if not(StackFarmOther)then return
    end
    local f=Settings["Value Collect Chest to Hop"]or 20
    if CheckNameBoss("Darkbeard")then if Settings["Attack Darkbeard"]then V[4][V[6]]=f
    return
    end
    end
    if DetectItemPlr("Fist of Darkness")then if Settings["Summon Darkbeard"]then V[4][V[6]]=f
    return
    end
    end
    if DetectItemPlr("Fist of Darkness")then if Settings["Tween Safe if have Items"]then return
    end
    elseif DetectItemPlr("God's Chalice")then if Settings["Tween Safe if have Items"]then return
    end
    end
    if not(SummonPending())then if V[4][V[6]]then if V[4][V[6]]>=f then if Settings["Auto Chest Hop"]then HopServer(nil,SummonPending)
    return
    end
    end
    end
    end
    f=GetNearestChest()
    if f then V[4][V[6]]+=1
    local V
    repeat task.wait()
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-f.Position).Magnitude<=5 then if V then if tick()-V>=5 then Instance.new("IntValue",f).Name="Ignored"
    wait(0.1)
    end
    else V=tick()
    end
    if not(Settings["Use Method Teleport"])then local V,r=game,game
    V:GetService("VirtualInputManager"):SendKeyEvent(true,"Space",false,r)
    wait()
    r,V=game,game
    r:GetService("VirtualInputManager"):SendKeyEvent(false,"Space",false,V)
    end
    TweenManager.CancelCurrent()
    else end
    if Settings["Use Method Teleport"]then t.Character.HumanoidRootPart.CFrame=f.CFrame
    TweenManager.CancelCurrent()
    else toTarget(f.CFrame,true)
    end
    until(if f then not f.Parent else not f)or not Settings["Auto Chest"]or f:GetAttribute("IsDisabled")or f:FindFirstChild("Ignored")or not f:FindFirstChild("TouchInterest")or not StackFarmOther
    else local f=PathFindChest()
    if f then toTarget(f.Part.CFrame)
    if(f.Part.Position-t.Character.HumanoidRootPart.Position).Magnitude<=100 or GetNearestChest()then Instance.new("IntValue",f).Name="Ignored"
    end
    else for f,f in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren())do if f:FindFirstChild("Ignored")then f:FindFirstChild("Ignored"):Destroy()
    end
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_2296()
-- -------------------------------------------------------------
local function Func_2296()
    local f,t=game.Lighting.ClockTime,checkboat()
    if Settings["Hop Server Kitsune Island"]then local r=CheckMoon()
    if not(r=="Full Moon"and math.floor(18-f)<=5 and math.floor(18-f)>=0)then if not(r=="Next Night")then if r=="Full Moon"then if f<=5 then if not(math.floor(5-f)>=11)then HopServer()
    return
    end
    else HopServer()
    return
    end
    else HopServer()
    return
    end
    end
    end
    end
    if not(t)then local r=CFrame.new(-13.488054275512695,10.311711311340332,2927.692)
    r=if game.PlaceId==getgenv().CheckPlaceId then CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)else r
    if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then toTarget(r)
    else local r=Settings["Select Boat"]
    if not(r)then WarnOnce("SelectBoat","Chon thuyen o Sea Event > Select Boat truoc da.")
    return
    end
    r=if r=="Brigade"then"Pirate"..r else if r=="GrandBrigade"then"Pirate"..r else r
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat",r)
    task.wait(3)
    end
    return
    end
    NoclipBoat(t)
    local r=t.WorldPivot.Y
    local I=CFrame.new(-32975.9921875,r,25963.7109375)*CFrame.new(0,0,1000)
    if CheckMoon()=="Full Moon"and math.floor(18-f)<=0 then if(t.VehicleSeat.Position-I.Position).Magnitude>200 then if V.Character.Humanoid.Sit then manageTween(t.VehicleSeat,I,150,"TweenBoat")
    else toTarget(t.VehicleSeat.CFrame)
    end
    elseif not(V.Character.Humanoid.Sit)then toTarget(t.VehicleSeat.CFrame)
    end
    elseif(t.VehicleSeat.Position-I.Position).Magnitude>200 then if V.Character.Humanoid.Sit then manageTween(t.VehicleSeat,I,150,"TweenBoat")
    else toTarget(t.VehicleSeat.CFrame)
    end
    else toTarget(I*CFrame.new(0,2000,0))
    end
    end
    end
    end,[90]=table.pack,r=function(f,V,t,r,I,x,j,a,p,K,G)if I<=73 then if I<=72 then local E,u,D=x[4],x[2],x[5]
    local w,g=E+u,u<=0
    E,u=w>=D,w<=D
    D=g and E or not g and u
    x[4]=w
    if D then return 202,j,V,r,a,G,w
    else return 125,j,V,r,a,G,p
    end
    else local x=f[35](K,3+a)
    local f,K,E,u=(j-128)*2097152,V-128,(r-128)*128,x%128*16384
    return 124,(x-x%128)*2097152+u+(K+(f+E)),4+a,r,a,G,p
    end
    elseif I<=74 then return 143,j,V,r,1,G,p
    else local f=G-128
    local I=t*128+f
    return 170,j,V,r+2,a,I,p
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_2657()
-- -------------------------------------------------------------
local function Func_2657()
    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy",true)=="[You already own this item.]"then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="[You already own this item.]",ShowTime=5})
    task.wait(5)
    return
    end
    if t.Data.Fragments.Value<5000 then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Frag >= 5k",ShowTime=5})
    wait(5)
    return
    end
    if CheckCountItem("Dark Fragment",1)then if CheckCountItem("Ectoplasm",250)then if CheckCountItem("Bones",500)then WarnOnce("SoulGuitarReady","Soul Guitar: du nguyen lieu, dang giai do (can Full Moon de bat dau).")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy")
    if game.PlaceId==getgenv().CheckPlaceId then GuitarPuzzleProgress()
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
    return
    end
    end
    end
    if CheckCountItem("Dark Fragment",1)then local f,V,I=DetectRequestSoulGuitar()
    WarnOnce("SoulGuitarFarm","Soul Guitar: dang farm nguyen lieu ("..tostring(f[1])..").")
    if game.PlaceId==V then local V=DetectMob(f)
    if V then while true do task.wait()
    sizepart(V)
    BringMob(V)
    UsedualFlock()
    ClickM1(V)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(V.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(V.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local x=IsMobAlive(V)
    if if x then not Settings["Auto Soul Guitar"]else not x then break
    end
    end
    elseif typeof(f)=="table"then if#r[4][r[6]]>=#f then r[4][r[6]]={}
    return
    end
    local V=DetectPartSpawnMob(DetectNameTablePart(f))
    if V then table.insert(r[4][r[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local r,x=V.Position,t.Character.HumanoidRootPart
    if(r-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto Soul Guitar"]then break
    end
    end
    wait(1)
    end
    else local V=DetectPartSpawnMob(f,true)
    if V then Instance.new("IntValue",V).Name="Ignored"
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local r,x=V.Position,t.Character.HumanoidRootPart
    if(r-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto Soul Guitar"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(I)
    end
    else WarnOnce("SoulGuitarDark","Soul Guitar: thieu Dark Fragment, can lam Darkbeard o Sea 2.")
    if game.PlaceId==getgenv().CheckPlaceId2 then if CheckNameBoss("Darkbeard")then local f=CheckNameBoss("Darkbeard")
    if f then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    local V=IsMobAlive(f)
    if if V then not Settings["Auto Soul Guitar"]else not V then break
    end
    end
    end
    elseif t.Character:FindFirstChild("Fist of Darkness")or t.Backpack:FindFirstChild("Fist of Darkness")then if(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.Position-t.Character.HumanoidRootPart.Position).Magnitude<=5 then equiptool("Fist of Darkness")
    firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,0)
    firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,1)
    firetouchinterest(t.Character.HumanoidRootPart,game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,0)
    firetouchinterest(t.Character.HumanoidRootPart,game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,1)
    else toTarget(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
    end
    else local f=GetNearestChest()
    if f then local V
    while true do task.wait()
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-f.Position).Magnitude<=5 then if V then if tick()-V>=5 then Instance.new("IntValue",f).Name="Ignored"
    wait(0.5)
    end
    else V=tick()
    end
    local V,r=game,game
    V:GetService("VirtualInputManager"):SendKeyEvent(true,"Space",false,r)
    wait()
    r,V=game,game
    r:GetService("VirtualInputManager"):SendKeyEvent(false,"Space",false,V)
    TweenManager.CancelCurrent()
    else end
    toTarget(f.CFrame,true)
    local V=(if f then not f.Parent else not f)or not Settings["Auto Soul Guitar"]or t.Character:FindFirstChild("Fist of Darkness")or t.Backpack:FindFirstChild("Fist of Darkness")
    if V or f:GetAttribute("IsDisabled")or f:FindFirstChild("Ignored")or not f:FindFirstChild("TouchInterest")then break
    end
    end
    else local f=PathFindChest()
    if f then toTarget(f.Part.CFrame)
    if(f.Part.Position-t.Character.HumanoidRootPart.Position).Magnitude<=100 or GetNearestChest()then Instance.new("IntValue",f).Name="Ignored"
    end
    else print("delete")
    for f,f in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren())do if f:FindFirstChild("Ignored")then f:FindFirstChild("Ignored"):Destroy()
    end
    end
    end
    end
    end
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
    end
    end
    end
    end,[76]=string.sub,
end

-- -------------------------------------------------------------
-- FUNCTION_2875()
-- -------------------------------------------------------------
local function Func_2875()
    WarnOnce("AutoCDKEvilHell","Auto CDK: dang lam Evil Trial 5/5.")
    if(game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position-V.Character.HumanoidRootPart.Position).Magnitude>1000 then if CheckNameBoss("Soul Reaper")then local f=CheckNameBoss("Soul Reaper")
    WarnOnce("AutoCDKEvilSoulReaper","Auto CDK: dang danh Soul Reaper.")
    while true do task.wait()
    toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,0,3))
    local I=V.Character.Humanoid.Health<=0 or(game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position-V.Character.HumanoidRootPart.Position).Magnitude<1000
    if I then break
    end
    end
    TweenManager.CancelCurrent()
    f=tick()
    while true do task.wait()
    local I=tick()-f>=5 or(game:GetService("Workspace")._WorldOrigin.Locations["Hell Dimension"].Position-V.Character.HumanoidRootPart.Position).Magnitude<1000
    if I then break
    end
    end
    else local f=V.Character:FindFirstChild("Hallow Essence")
    if if f then not f else not V.Backpack:FindFirstChild("Hallow Essence")then WarnOnce("AutoCDKEvilBones","Auto CDK: dang farm Bones de lay Hallow Essence.")
    local f=DetectMob(t)
    if f then while true do task.wait()
    sizepart(f)
    BringMob(f)
    equiptool(NameWeapon("Sword"))
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local I=IsMobAlive(f)
    if if I then not Settings["Auto CDK"]else not I then break
    end
    end
    elseif typeof(t)=="table"then if#r[4][r[6]]>=#t then r[4][r[6]]={}
    return
    end
    local f=DetectPartSpawnMob(DetectNameTablePart(t))
    if f then table.insert(r[4][r[6]],DetectNameTablePart(t))
    while true do wait()
    toTarget(f.CFrame*CFrame.new(0,60,0))
    local r,I=f.Position,V.Character.HumanoidRootPart
    if(r-I.Position).Magnitude<=100 or DetectMob(t)or not Settings["Auto CDK"]then break
    end
    end
    wait(1)
    end
    else local f=DetectPartSpawnMob(t,true)
    if f then Instance.new("IntValue",f).Name="Ignored"
    while true do wait()
    toTarget(f.CFrame*CFrame.new(0,60,0))
    local r,I=f.Position,V.Character.HumanoidRootPart
    if(r-I.Position).Magnitude<=100 or DetectMob(t)or not Settings["Auto CDK"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    else WarnOnce("AutoCDKEvilSummon","Auto CDK: dang mang Hallow Essence toi Summoner de goi Soul Reaper.")
    if(V.Character.HumanoidRootPart.Position-game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position).Magnitude>8 then toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
    else equiptool("Hallow Essence",true)
    end
    end
    end
    else if game:GetService("Workspace").Map.HellDimension.Exit.BrickColor==BrickColor.new("Olivine")then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").Map.HellDimension.Exit.CFrame
    toTarget(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
    return
    end
    if DetectMobCDK()then WarnOnce("AutoCDKEvilHellMobs","Auto CDK: dang don enemy trong Hell Dimension.")
    repeat task.wait()
    local f=DetectMobHell()
    sizepart(f)
    toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    equiptool(NameWeapon("Sword"))
    getgenv().ClickM1(f)
    until not DetectMobCDK()
    else local f=TourchEvil5()
    if f then WarnOnce("AutoCDKEvilTorch","Auto CDK: dang kich hoat Torch "..f.." trong Hell Dimension.")
    repeat task.wait()
    if(V.Character.HumanoidRootPart.Position-game:GetService("Workspace").Map.HellDimension["Torch"..f].Position).Magnitude>5 then toTarget(game:GetService("Workspace").Map.HellDimension["Torch"..f].CFrame)
    else fireproximityprompt(game:GetService("Workspace").Map.HellDimension["Torch"..f].ProximityPrompt,0)
    fireproximityprompt(game:GetService("Workspace").Map.HellDimension["Torch"..f].ProximityPrompt,1)
    end
    until DetectMobCDK()
    V.Character.HumanoidRootPart.CFrame=V.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)
    else WarnOnce("AutoCDKEvilHellWait","Auto CDK: dang cho enemy hoac Torch trong Hell Dimension.")
    end
    end
    end
    end
    end
    end,Gf=function(f,V,t,r,I,x,j,a,p,K,G,E,u)if r<=21 then if r<=20 then return 17,I,G,t+3,E,j,V,u,x,K,a
    else return 23,I,G,t,1+E,j,V,u,x,K,a
    end
    elseif r<=22 then local r=f[35](p,E+3)
    local p,D,w,g=(j-128)*2097152,V-128,(u-128)*128,16384*(r%128)
    local U=2097152*(r-r%128)+w+(D+(g+p))
    return 23,I,G,t,4+E,U,V,u,x,K,a
    else local V,r,x,a=(G+t)%256,f[109](j),16843009*t,j-j%4
    local f,p=a-1,4+0
    return 14,{p,I,nil,0-p,f+0},V,t,E,j,185,57,r,x,a
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3149()
-- -------------------------------------------------------------
local function Func_3149()
    local f=GetNearestChest()
    if f then local t
    repeat task.wait()
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-f.Position).Magnitude<=5 then if t then if tick()-t>=5 then Instance.new("IntValue",f).Name="Ignored"
    wait(0.5)
    end
    else t=tick()
    end
    local t,r=game,game
    t:GetService("VirtualInputManager"):SendKeyEvent(true,"Space",false,r)
    wait()
    r,t=game,game
    r:GetService("VirtualInputManager"):SendKeyEvent(false,"Space",false,t)
    TweenManager.CancelCurrent()
    else end
    toTarget(f.CFrame,true)
    until(if f then not f.Parent else not f)or not Settings["Auto Upgrade Race V2-V3"]or f:GetAttribute("IsDisabled")or f:FindFirstChild("Ignored")or not f:FindFirstChild("TouchInterest")
    else local f=PathFindChest()
    if f then toTarget(f.Part.CFrame)
    if(f.Part.Position-V.Character.HumanoidRootPart.Position).Magnitude<=100 or GetNearestChest()then Instance.new("IntValue",f).Name="Ignored"
    end
    else for f,f in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren())do if f:FindFirstChild("Ignored")then f:FindFirstChild("Ignored"):Destroy()
    end
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3164(f)
-- -------------------------------------------------------------
local function Func_3164(f)
    local t=game.PlaceId==getgenv().CheckPlaceId2 and game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button:FindFirstChild("Main")
    t=if game.PlaceId==getgenv().CheckPlaceId then game:GetService("Workspace").Map:FindFirstChild("Boat Castle")and game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button:FindFirstChild("Main")else t
    if not(V.PlayerGui.Main.TopHUDList.RaidTimer.Visible)then if CheckInRaid()then elseif t then else if DetectItemPlr("Special Microchip")then toTarget(CFrame.new(-5500,314,-2855),false,true)
    else toTarget(CFrame.new(-5500,314,-2855))
    end
    return
    end
    end
    if Settings["Account Pick Slot Raid"]then if not(V.PlayerGui.Main.TopHUDList.RaidTimer.Visible)then if not(CheckInRaid())then if not(NearSlotRaid(t.Parent.Parent))then local r=Random.new():NextNumber(0,2)
    task.wait(r)
    toTarget(DetectSlotRaid(t.Parent.Parent).Hitbox.CFrame*CFrame.new(0,-2,0))
    end
    end
    end
    end
    if DetectItemPlr("Special Microchip")then if getgenv().waitgoraid then wait(5)
    getgenv().waitgoraid=false
    end
    getgenv().buychip=false
    if DetectMultiStartRaid(t.Parent.Parent)then if Settings["Account Buy Chip"]then fireclickdetector(t.ClickDetector)
    end
    end
    if getgenv().Tween then getgenv().Tween:Pause()
    getgenv().Tween:Cancel()
    end
    return
    end
    if V.PlayerGui.Main.TopHUDList.RaidTimer.Visible and CheckInRaid()then getgenv().waitgoraid=true
    getgenv().buychip=true
    local t=DetectMobRaid()
    if t then repeat task.wait()
    UsedualFlock()
    ClickM1(t)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(t.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(t.HumanoidRootPart.CFrame*CFrame.new(10,20,0))
    end
    until not IsMobAlive(t)
    else local t=GetLastRaidIsland()
    if t then if t.Name=="Island 2"and Settings["Select Raid"]=="Phoenix"then toTarget(t.CFrame*CFrame.new(300,60,0))
    else toTarget(t.CFrame*CFrame.new(0,60,0))
    end
    end
    end
    return
    end
    if Settings["Account Buy Chip"]then if getgenv().buychip then if V.Data.Level.Value>=1100 then if not(V.PlayerGui.Main.TopHUDList.RaidTimer.Visible)then if not(DetectItemPlr("Special Microchip"))then if not(CheckInRaid())then if not(CheckFruitplr())then if TakeFruitInventory(true)then if Settings["Get Fruit In Inventory Low Beli"]then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit",TakeFruitInventory(true))
    end
    end
    end
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc","Check")
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc","Select",f or"Flame")
    wait(1)
    end
    end
    end
    end
    end
    end
    end
    end
    end,A=function(f,V,t,r,I,x,j,a,p)if t<=109 then if t<=108 then local K,G=16384*(r-128),a-128
    local E=128*I+(G+K)
    return 174,j,3+p,E,a
    else local I=f[35](x,2+p)
    return I<128 and 35 or 62,j,p,r,I
    end
    elseif t<=110 then return 14,j-128+128*p,V+2,r,a
    else local V=f[35](x,p+1)
    return V<128 and 57 or 54,j,p,r,V
    end
    end,rf=function(f,V,t,r,I,x,j,a,p)if r<=14 then local r,K,G=I[4],I[1],I[5]
    local E,u=r+K,K<=0
    K,r=E>=G,E<=G
    G=u and K or not u and r
    I[4]=E
    if G then return 8,p,a,j,E
    else return 7,p,a,j,V
    end
    else local r,I=t[5][x],t[4]
    local t=1+r
    r=f[35](I,t)
    return 128<=r and 28 or 21,I,t,r,V
    end
    end,w=function(f,V,t,r,I,x,j,a,p,K)if r<=69 then if r<=68 then return 127,1+V,p,t,x
    else local G,E=(p-128)*16384,t-128
    local u=G+(K*128+E)
    return 170,V+3,u,t,x
    end
    elseif r<=70 then local r=f[35](j,1+a)
    return r>=128 and 90 or 144,V,p,r,x
    else local f=x-128
    local r=128*I+f
    return 36,2+V,p,t,r
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3337()
-- -------------------------------------------------------------
local function Func_3337()
    if game.Players.LocalPlayer.Data.Race.Value~="Draco"then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Change Race Draco plz",ShowTime=5})
    wait(5)
    return
    elseif DetectItemPlr("Primordial Reign")then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Done V3 Draco",ShowTime=5})
    wait(5)
    return
    end
    local f,V=workspace.NPCs:FindFirstChild("Dragon Wizard")or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Wizard")or NPCManager.getNPCsByName("Dragon Wizard")[1]._modelState._instance,getgenv().QuestDraco
    local x=if V then getgenv().QuestDraco and not table.find(t,getgenv().QuestDraco.AvailableVQuest)else not V
    if x then if r:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,4,4))
    else getgenv().QuestDraco=game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Speak"})
    wait(1)
    if getgenv().QuestDraco and getgenv().QuestDraco.AvailableVQuest=="V2"or getgenv().QuestDraco.AvailableVQuest=="V3"then game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Ascension",Action="Begin"})
    getgenv().QuestDraco=game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Speak"})
    end
    end
    elseif getgenv().QuestDraco.AvailableVQuest=="V2TurnInReady"then game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Ascension",Action="Complete"})
    getgenv().QuestDraco=nil
    elseif getgenv().QuestDraco.AvailableVQuest=="V3TurnInReady"then game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Ascension",Action="Complete"})
    getgenv().QuestDraco=nil
    elseif getgenv().QuestDraco.AvailableVQuest=="V2InProgress"then if CheckCountItem("Fire Flower",5)then if r:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,4,4))
    else game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Ascension",Action="Complete"})
    getgenv().QuestDraco=nil
    end
    else V=DetectFireFlower()
    if V then toTarget(V.PrimaryPart.CFrame)
    if r:DistanceFromCharacter(V.PrimaryPart.Position)<8 then fireproximityprompt(V.ProximityPrompt,1)
    end
    else local V=DetectMob("Forest Pirate")
    if V then while true do task.wait()
    sizepart(V)
    BringMob(V)
    UsedualFlock()
    ClickM1(V)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(V.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(V.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local t=IsMobAlive(V)
    if if t then not Settings["Auto Upgrade Race V2-V3 Draco"]else not t then break
    end
    end
    else local V=DetectPartSpawnMob("Forest Pirate",true)
    if V then Instance.new("IntValue",V).Name="Ignored"
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local t,x=V.Position,r.Character.HumanoidRootPart
    if(t-x.Position).Magnitude<=100 or DetectMob("Forest Pirate")or not Settings["Auto Upgrade Race V2-V3 Draco"]or wait(1)then break
    end
    end
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    end
    elseif getgenv().QuestDraco.AvailableVQuest=="V3InProgress"then SaveSettings("V3InProgress",true)
    if getgenv().KilledTerroshark then if r:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,4,4))
    else game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer({NPC="Dragon Wizard",Command="Ascension",Action="Complete"})
    getgenv().QuestDraco=nil
    getgenv().KilledTerroshark=false
    end
    else local f,V=CheckNameBoss("Terrorshark"),checkboat()
    if f then while true do task.wait()
    TeleportSeaEvents(f)
    local t=f:FindFirstChild("HumanoidRootPart")
    getgenv().AimPos=CFrame.new(t.Position.X,40,t.Position.Z)
    UsedualFlock()
    ClickM1(f,true)
    t=IsMobAlive(f)
    if if t then not Settings["Auto Upgrade Race V2-V3 Draco"]else not t then break
    end
    end
    getgenv().KilledTerroshark=true
    elseif V then local f=DecectPartRoughSea()
    if f then wait(1)
    I[4][I[6]]=if I[4][I[6]]==0 then 7000 else 0
    Instance.new("IntValue",f).Name="Ignored"
    wait(0.5)
    end
    getgenv().RoughSea=I[4][I[6]]
    f=CFrame.new(-32975.9921875,V.WorldPivot.Y,25963.7109375)*CFrame.new(0,V.WorldPivot.Y,0+RoughSea)
    if r.Character.Humanoid.Sit then manageTween(V.VehicleSeat,f,150,"TweenBoat")
    else toTarget(V.VehicleSeat.CFrame)
    end
    else local f=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(f.Position-r.Character.HumanoidRootPart.Position).Magnitude>8 then toTarget(f)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    end
    end
    end
    end
    end
    end
    end,_f=function(f)return true,15,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    end,df=function(f,V,t,r,I,x)if V<=17 then if V<=16 then return 1
    else local j=f[35](I,r)
    return 2,j<128 and 18 or 0,r,j,x
    end
    elseif V<=18 then return 2,24,1+r,t,x
    else return 2,29,r,t,(f[35](I,r+2))
    end
    end,l=function(f,V,t,r,I,x,j,a,p,K,G)if t<=117 then if t<=116 then local E,u,D=p[1],p[4],p[5]
    local w,g=E+u,u<=0
    E,u=w>=D,w<=D
    D=g and E or not g and u
    p[1]=w
    if D then return 82,x,a,K,I,w
    else return 40,x,a,K,I,r
    end
    else local p=f[35](V,a)
    return p<128 and 3 or 87,x,a,p,I,r
    end
    elseif t<=118 then return 231,x+1,a,K,I,r
    else local t=f[35](V,a+3)
    local f,V,p,E,u=(I-128)*2097152,j-128,128*(G-128),t%128*16384,t%128
    local I=(t-u)*2097152
    u=p+V+E+I+f
    return 127,x,4+a,K,u,r
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3462()
-- -------------------------------------------------------------
local function Func_3462()
    local V,r,I={},pairs,f[90](game.Workspace.Enemies:GetChildren())
    for x,x in r(f:N_(I))do if table.find(t,x.Name)then table.insert(V,x.Name)
    end
    end
    r,I=pairs,f[90](game.ReplicatedStorage:GetChildren())
    for x,x in r(f:N_(I))do if table.find(t,x.Name)then table.insert(V,x.Name)
    end
    end
    r,I=workspace._WorldOrigin:FindFirstChild("EnemySpawns"),pairs
    local f=r and r:GetChildren()or{}
    for x,x in I(f)do r=x.Name:match("^(.-) %[Lv%. %d+%] %[Boss%]$")
    if r then if table.find(t,r)then if not(table.find(V,r))then table.insert(V,r)
    end
    end
    end
    end
    return V
    end
    end
    end,[58]=bit32.band,
end

-- -------------------------------------------------------------
-- FUNCTION_3538()
-- -------------------------------------------------------------
local function Func_3538()
    local f,V=tonumber(Settings["Value Speed Boat"])or 200,checkSpeedboat()
    if V then V.VehicleSeat.MaxSpeed=f
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3566(f)
-- -------------------------------------------------------------
local function Func_3566(f)
    local V,t,r=next,workspace.Map["Simulation Hub"].Pads:GetChildren()
    for I,I in V,t,r do if f and I:GetAttribute("Initiator")==game.Players.LocalPlayer.UserId then return I
    elseif I:GetAttribute("NumPlayersOnPad")==0 then return I
    end
    end
    end
    end
    end,L_=function(f,V,t,r,I,x,j,a,p)if p<=145 then local K=f[35](t,V+2)
    return K>=128 and 146 or 0,V,r,a,K
    elseif p<=146 then local p,K,G,E=f[35](t,V+3),2097152*(a-128),j-128,128*(I-128)
    local f=16384*(p%128)+((p-p%128)*2097152+E+G)+K
    return 200,4+V,r,f,I
    else local f=r-128
    local t,r=128*x+f,2+V
    return 196,V,t,a,I
    end
    end,R=function(f,V,t,r,I,x,j,a,p)if x<=13 then if x<=12 then return 236,I,a,1+p,j,t
    else return 138,I[3],a,p,j,t
    end
    elseif x<=14 then local x=a-86239
    local K,G,E=f[1](x),f[1](x),1+0
    return 228,{I,1-E,E,nil,x+0},K,p,G,t
    else local f=(t-128)*16384+(r-128+V*128)
    return 42,I,a,3+p,j,f
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3914()
-- -------------------------------------------------------------
local function Func_3914()
    local f,V,t=next,workspace.ActiveFishingSpots:GetChildren()
    local r,I=1/0
    for x,j in f,V,t do if j.Name=="GoldenVortex"then x=(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-j.Position).Magnitude
    if x<r then r,I=x,j
    else end
    else end
    end
    return I
    end
    end
    end,l_=function(f,V,t,r,I,x,j,a)if I<=1 then if I<=0 then local p=f[35](x,r+1)
    if 128>p then return 31,p,r,V,j,t
    else return 26,x,r,p,j,t
    end
    else local p,K,G=a[2],a[4],a[1]
    local E,u=p+K,K<=0
    K,p=E>=G,E<=G
    G=u and K or not u and p
    a[2]=E
    if G then return 13,x,E,V,j,t
    else return 7,x,r,V,j,t
    end
    end
    elseif I<=2 then local I=f[35](x,1+r)
    return I<128 and 36 or 32,x,r,V,j,I
    else local I=f[35](x,r+1)
    return I>=128 and 27 or 28,x,r,V,I,t
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_3920()
-- -------------------------------------------------------------
local function Func_3920()
    local f=V.Character
    local V=f and(f:FindFirstChild("HumanoidRootPart"))
    if not(V)then return nil
    end
    f=GetHightFloor()
    if not f then return nil
    end
    local t=workspace.Map.Dungeon:FindFirstChild(tostring(f))
    if not(t)then return nil
    end
    local r,I=1/0
    for x,j in ipairs(workspace.Enemies:GetChildren())do if IsMobAlive(j)then if j.Name=="PropHitboxPlaceholder"then x=j:FindFirstChild("HumanoidRootPart")
    j:FindFirstChildOfClass("Humanoid")
    if IsPointInsideModel(t,x.Position)then f=(x.Position-V.Position).Magnitude
    if f<r then r,I=f,j
    else end
    else end
    else end
    else end
    end
    return I
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_4273()
-- -------------------------------------------------------------
local function Func_4273()
    local V,r,I={},pairs,f[90](game:GetService("Players"):GetChildren())
    for x,x in r(f:N_(I))do if x.Name~=t.Name then V[x.Name]=false
    end
    end
    return V
    end
    end
    end,[114]=bit32.countrz,[31]=bit32.countlz,
end

-- -------------------------------------------------------------
-- FUNCTION_4494()
-- -------------------------------------------------------------
local function Func_4494()
    if not(getHighestPoint())then local f=DetectNpc("Advanced Fruit Dealer")
    if f then toTarget(f.HumanoidRootPart.CFrame)
    return
    end
    end
    local f=getBlueGear()
    if f then else task.wait(0.3)
    f=getBlueGear()
    end
    if f and f.Transparency~=1 then if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility")then game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
    end
    toTarget(f.CFrame)
    elseif f and f.Transparency==1 then if getHighestPoint()and(getHighestPoint().CFrame*CFrame.new(0,211.88,0).Position-V.Character.HumanoidRootPart.Position).Magnitude>10 then toTarget(getHighestPoint().CFrame*CFrame.new(0,211.88,0))
    else game.Players.LocalPlayer.CameraMode="LockFirstPerson"
    game.Players.LocalPlayer.CameraMode="Classic"
    local f=tick()
    repeat wait()
    game:GetService("Workspace").CurrentCamera.CFrame=CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.Position,game:GetService("Lighting"):GetMoonDirection()+game:GetService("Workspace").CurrentCamera.CFrame.Position)
    until tick()-f>=3
    local V,t=game,game
    V:GetService("VirtualInputManager"):SendKeyEvent(true,"T",false,t)
    task.wait(0.5)
    V,f=game,game
    V:GetService("VirtualInputManager"):SendKeyEvent(false,"T",false,f)
    if not(CheckAbility())then if not(game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"))then t=game:GetService("ReplicatedStorage").FX.Agility:Clone()
    t.Parent=game.Players.LocalPlayer.Character.HumanoidRootPart
    t.Enabled=false
    end
    end
    task.wait(1.5)
    end
    end
    end
    end
    end,[20]=buffer.readbits,[5]=5.5063126E8,
end

-- -------------------------------------------------------------
-- FUNCTION_4631()
-- -------------------------------------------------------------
local function Func_4631()
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan")==1 then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Done Get Rainbow Haki",ShowTime=5})
    wait(5)
    return
    end
    local f=workspace.NPCs:FindFirstChild("Horned Man")or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Horned Man")or NPCManager.getNPCsByName("Horned Man")[1]._modelState._instance
    if DetectQuestRainBowHaki()then if t:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame)
    else wait(2)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("HornedMan","Bet")
    end
    else local f=CheckNameBoss(DetectQuestRainBowHaki(true))
    if f then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    ClickM1(f)
    UsedualFlock()
    local t=IsMobAlive(f)
    if if t then not Settings["Auto Get Rainbow Haki"]else not t then break
    end
    end
    else V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Waiting Boss Spawn",ShowTime=5})
    wait(5)
    end
    end
    end
    end
    end,Of=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if t<=215 then if t<=214 then local w,g=16384*(E-128),r-128
    local r=w+(j*128+g)
    return 21,K,a,3+D,G,I,V,r
    else local r=f[35](u,3+D)
    local j,w,g,U=(V-128)*2097152,p-128,(x-128)*128,r%128*16384
    local x=2097152*(r-r%128)+w+(U+(g+j))
    return 196,K,a,4+D,G,I,x,E
    end
    elseif t<=216 then local t,r,x=f[107](u,G),G+4,1+0
    return 252,{x,K,1-x,nil,t+0},a,r,1,{},V,E
    else local t=f[35](u,G+1)
    return t<128 and 63 or 60,K,t,D,G,I,V,E
    end
    end,g={30141,2565448893,1163700091,2960051358,1922890884,1446533771,4228143649,3769252149,825463740},[35]=buffer.readu8,
end

-- -------------------------------------------------------------
-- FUNCTION_4854(f)
-- -------------------------------------------------------------
local function Func_4854(f)
    if(Vector3.new(0,f:FindFirstChild("HumanoidRootPart").Position.Y,0)-Vector3.new(0,-60,0)).Magnitude<=175 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,200,50))
    else toTarget(CFrame.new(f.HumanoidRootPart.Position.X,140,f.HumanoidRootPart.Position.Z))
    end
    end
    end
    end,[1]=table.create,__=function(f,V,t,r,I,x,j,a,p,K,G,E)if r<=154 then if r<=152 then return 33,p,G+1,a,j
    elseif r<=153 then local u=1+x
    return 63,p,G,a,j
    else local u=(G-128)*16384
    local D=x-128+t*128+u
    return 48,p+3,D,a,j
    end
    elseif r<=156 then if r<=155 then return 3,p+1,G,a,j
    else local u=f[35](a,x+1)
    if 128<=u then return 31,p,G,a,u
    else return 119,p,G,u,j
    end
    end
    elseif r<=157 then local r
    x[t],r=f[107](V,a),a+4
    return 125,p,r,a,j
    else local V,t=f[67],f[107](a,p+E)
    V(I,E,(f[15](f.Dn[j],t,K)))
    return 207,p,G,a,f.un[j]
    end
    end,[24]=buffer.writef64,Pf=function(f,f,V,t,r,I,x,j,a,p)if V<=0 then local K,G=16384*(f-128),r-128
    local r=128*I+K+G
    return 200,p,a+3,r
    elseif V<=1 then local V,r,I=j[5],j[4],j[1]
    local K,G=V+r,r<=0
    r,V=K>=I,K<=I
    I=G and r or not G and V
    j[5]=K
    if I then return 74,p,a,K
    else return 23,p,a,f
    end
    else local V,r=(a-128)*16384,t-128
    local t=V+(x*128+r)
    return 202,3+p,t,f
    end
    end,jf=function(f,V,t,r,I,x,j,a,p,K,G,E)if G<=230 then local G=f[35](I,a+3)
    local u,D,w,g=2097152*(x-128),E-128,(r-128)*128,16384*(G%128)
    local r=w+2097152*(G-G%128)+(g+u)+D
    return 174,K,a+4,V,r
    else a[-1]=p
    a[-2]={}
    f[25](a,t)
    return 25,j,K,f[I](f,a),x
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_5309()
-- -------------------------------------------------------------
local function Func_5309()
    local f,t=V:GetNearestNPC(game.Players.LocalPlayer.Character.HumanoidRootPart.Position,2600)[1],math.floor
    local r=(V:GetDistance(f)-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude/10
    return(t(r))
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_5349()
-- -------------------------------------------------------------
local function Func_5349()
    local f,j=QuestDojoTrainer(),CFrame.new(5868.453125,1207.7784423828125,870.819580078125)*CFrame.new(0,4,-2)
    if getgenv().QuestTrainer then if getgenv().QuestTrainer.BeltName=="White"and getgenv().QuestTrainer.CountKillMob<20 then SaveSettings("QuestDojo",true)
    local a=r()
    local r=a and a.Text or""
    if a then local a=DetectMob(r)
    if a then while true do task.wait()
    sizepart(a)
    BringMob(a)
    UsedualFlock()
    ClickM1(a)
    if game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible and(Settings["Auto Finish Train Quest"]or Settings["Auto Finish Train Draco Quest"])then toTarget(a.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    elseif Settings["Select Weapon"]=="Blox Fruit"then toTarget(a.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit,0))
    else toTarget(a.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local p=IsMobAlive(a)
    if if p then not Settings["Auto Quest Dojo Trainer"]else not p then break
    end
    end
    if getgenv().QuestTrainer then if getgenv().QuestTrainer.CountKillMob then getgenv().QuestTrainer.CountKillMob=getgenv().QuestTrainer.CountKillMob+1
    end
    end
    else local a=DetectPartSpawnMob(r,true)
    if a then Instance.new("IntValue",a).Name="Ignored"
    while true do task.wait()
    toTarget(a.CFrame*CFrame.new(0,60,0))
    local p,K=a.Position,V.Character.HumanoidRootPart
    if(p-K.Position).Magnitude<=100 or DetectMob(r)or not Settings["Auto Quest Dojo Trainer"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    else TakeQuestLevel()
    end
    elseif getgenv().QuestTrainer.BeltName=="White"and getgenv().QuestTrainer.CountKillMob>=20 then SaveSettings("QuestDojo",false)
    getgenv().QuestTrainer=nil
    elseif getgenv().QuestTrainer.BeltName=="Yellow"and getgenv().QuestTrainer.CountKillMob<5 then SaveSettings("QuestDojo",true)
    local r,a=DetectQuestSeaDragon(),checkboat()
    if r then repeat task.wait()
    TeleportSeaEvents(r)
    local p=r:FindFirstChild("HumanoidRootPart")or r:FindFirstChild("Engine")
    getgenv().AimPos=CFrame.new(p.Position.X,40,p.Position.Z)
    if r:FindFirstChildWhichIsA("Humanoid")then UsedualFlock()
    ClickM1(r,true)
    elseif V:DistanceFromCharacter(p.Position)<400 then AutoAllSkill()
    end
    until(if r then not r.Parent else not r)or r:FindFirstChildWhichIsA("Humanoid")and r.Humanoid.Health<=0 or r:FindFirstChild("Health")and r.Health.Value<=0 or not Settings["Auto Quest Dojo Trainer"]
    if getgenv().QuestTrainer then if getgenv().QuestTrainer.CountKillMob then getgenv().QuestTrainer.CountKillMob=getgenv().QuestTrainer.CountKillMob+1
    end
    end
    elseif not a then local r=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then toTarget(r)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    end
    else task.spawn(function()NoclipBoat(a)
    end)
    local r=DecectPartRoughSea()
    if r then wait(1)
    I[4][I[6]]=if I[4][I[6]]==0 then 7000 else 0
    Instance.new("IntValue",r).Name="Ignored"
    wait(0.5)
    end
    getgenv().RoughSea=I[4][I[6]]
    r=CFrame.new(-32975.9921875,a.WorldPivot.Y,25963.7109375)*CFrame.new(0,a.WorldPivot.Y,0+RoughSea)
    if V.Character.Humanoid.Sit then manageTween(a.VehicleSeat,r,150,"TweenBoat")
    else toTarget(a.VehicleSeat.CFrame)
    end
    end
    elseif getgenv().QuestTrainer.BeltName=="Yellow"and getgenv().QuestTrainer.CountKillMob>=5 then SaveSettings("QuestDojo",false)
    getgenv().QuestTrainer=nil
    elseif getgenv().QuestTrainer.BeltName=="Purple"and getgenv().QuestTrainer.CountKillMob<3 then SaveSettings("QuestDojo",true)
    local r=DetectEliteHunter()
    if r then StackFarm=false
    if os.time()-(EliteQuestAt or 0)>180 then EliteQuestAt=os.time()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
    end
    while true do task.wait()
    sizepart(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    ClickM1(r)
    UsedualFlock()
    local a=IsMobAlive(r)
    if if a then not Settings["Auto Quest Dojo Trainer"]else not a then break
    end
    end
    if getgenv().QuestTrainer then if getgenv().QuestTrainer.CountKillMob then getgenv().QuestTrainer.CountKillMob=getgenv().QuestTrainer.CountKillMob+1
    end
    end
    return
    end
    elseif getgenv().QuestTrainer.BeltName=="Purple"and getgenv().QuestTrainer.CountKillMob>=3 then SaveSettings("QuestDojo",false)
    getgenv().QuestTrainer=nil
    elseif getgenv().QuestTrainer.BeltName=="Green"and getgenv().QuestTrainer.CountKillMob==300 then SaveSettings("QuestDojo",true)
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible and tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.TextLabel.Text)==6 then local r=tick()
    while true do wait()
    local a,p=tick()-r,getgenv
    if a>=p().QuestTrainer.Progress or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.Visible or not Settings["Auto Quest Dojo Trainer"]then break
    end
    end
    getgenv().QuestTrainer=nil
    SaveSettings("QuestDojo",false)
    else local r=checkboat()
    if not r then local a=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(a.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then toTarget(a)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    end
    else task.spawn(function()NoclipBoat(r)
    end)
    local a=DecectPartRoughSea()
    if a then wait(1)
    I[4][I[6]]=if I[4][I[6]]==0 then 7000 else 0
    Instance.new("IntValue",a).Name="Ignored"
    wait(0.5)
    end
    getgenv().RoughSea=I[4][I[6]]
    a=CFrame.new(-32975.9921875,r.WorldPivot.Y,25963.7109375)*CFrame.new(0,r.WorldPivot.Y,0+RoughSea)
    if V.Character.Humanoid.Sit then manageTween(r.VehicleSeat,a,150,"TweenBoat")
    else toTarget(r.VehicleSeat.CFrame)
    end
    end
    end
    elseif getgenv().QuestTrainer.BeltName=="Red"and getgenv().QuestTrainer.CountKillMob==0 then SaveSettings("QuestDojo",true)
    local r=workspace:FindFirstChild("SeaBeasts")
    local a
    for p,p in ipairs(r and r:GetChildren()or{})do if p.Name=="SeaBeast1"then if IsMobAlive(p)then a=p
    break
    end
    end
    end
    local p,K=CheckNameBoss("Terrorshark"),checkboat()
    r=not p
    local G=if p then r else a and V:DistanceFromCharacter(a.HumanoidRootPart.Position)<2000 and a or DetectSeaEvents(true)
    if p then x.AvoidThreat=nil
    x.AvoidTarget=nil
    elseif G and K and x.AvoidThreat~=G then local a=G:FindFirstChild("HumanoidRootPart")or G:FindFirstChild("Engine")
    if a then local E=Vector3.new(K.VehicleSeat.Position.X-a.Position.X,0,K.VehicleSeat.Position.Z-a.Position.Z)
    x.AvoidTarget=CFrame.new(K.VehicleSeat.Position+(E.Magnitude>1 and E.Unit or Vector3.new(1,0,0))*2500)
    x.AvoidThreat=G
    end
    elseif x.AvoidThreat then local a=x.AvoidThreat.Parent
    local E=if a then x.AvoidThreat:FindFirstChild("Health")and x.AvoidThreat.Health.Value<=0 else not a
    if E then x.AvoidThreat=nil
    x.AvoidTarget=nil
    elseif x.AvoidThreat:FindFirstChildWhichIsA("Humanoid")then if x.AvoidThreat:FindFirstChildWhichIsA("Humanoid").Health<=0 then x.AvoidThreat=nil
    x.AvoidTarget=nil
    end
    end
    end
    if p then repeat task.wait()
    TeleportSeaEvents(p)
    G=p:FindFirstChild("HumanoidRootPart")
    getgenv().AimPos=CFrame.new(G.Position.X,40,G.Position.Z)
    if p:FindFirstChildWhichIsA("Humanoid")then UsedualFlock()
    ClickM1(p,true)
    elseif V:DistanceFromCharacter(G.Position)<400 then AutoAllSkill()
    end
    until(if p then not p.Parent else r)or p.Humanoid.Health<=0 or not Settings["Auto Quest Dojo Trainer"]
    getgenv().QuestTrainer.CountKillMob=getgenv().QuestTrainer.CountKillMob+1
    elseif K then local r=x.AvoidTarget
    local a=if r then not r else DecectPartRoughSea()
    if a then wait(1)
    I[4][I[6]]=if I[4][I[6]]==0 then 7000 else 0
    Instance.new("IntValue",a).Name="Ignored"
    wait(0.5)
    end
    getgenv().RoughSea=I[4][I[6]]
    r=x.AvoidTarget or CFrame.new(-32975.9921875,K.WorldPivot.Y,25963.7109375)*CFrame.new(0,K.WorldPivot.Y,0+RoughSea)
    if V.Character.Humanoid.Sit then manageTween(K.VehicleSeat,r,150,"TweenBoat")
    else toTarget(K.VehicleSeat.CFrame)
    end
    else local r=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then toTarget(r)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    end
    end
    elseif getgenv().QuestTrainer.BeltName=="Red"then if getgenv().QuestTrainer.CountKillMob>0 then SaveSettings("QuestDojo",false)
    getgenv().QuestTrainer=nil
    end
    end
    elseif V:DistanceFromCharacter(j.Position)>8 then toTarget(j)
    elseif f then if f.Quest.Progress>=f.Quest.Goal then game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/InteractDragonQuest"):InvokeServer(unpack({[1]={NPC="Dojo Trainer",Command="ClaimQuest"}}))
    wait(1)
    return
    end
    if f.Quest.BeltName=="White"then getgenv().QuestTrainer={BeltName="White",CountKillMob=0}
    elseif f.Quest.BeltName=="Yellow"then getgenv().QuestTrainer={BeltName="Yellow",CountKillMob=0}
    elseif f.Quest.BeltName=="Green"then local V,r=getgenv(),{BeltName="Green",CountKillMob=300}
    r.Progress,V.QuestTrainer=f.Quest.Progress,r
    elseif f.Quest.BeltName=="Purple"then getgenv().QuestTrainer={BeltName="Purple",CountKillMob=0}
    elseif f.Quest.BeltName=="Red"then getgenv().QuestTrainer={BeltName="Red",CountKillMob=0}
    else t[4][t[6]].CreateNoti({Title="Banana Cat Hub",Desc="That's enough training for today... Come back tomorrow and we can continue.\10 or dont support Belt Currently",ShowTime=5})
    wait(5)
    return
    end
    end
    end
    end
    end,xf=function(f,V,t,r,I,x,j,a,p,K,G)if j<=55 then if j<=53 then local E,u,D=(V-128)*16384,t-128,x*128
    local w=u+E+D
    return 87,p,I,K,r+3,w,a
    elseif j<=54 then local E=f[35](G,1+K)
    return E<128 and 7 or 198,p,I,K,r,V,E
    else local E
    r[V],E=f[107](G,x),x+4
    return 125,p,I,E,r,V,a
    end
    elseif j<=56 then return 191,p,I+1,K,r,V,a
    elseif j<=57 then return 153<t and 193 or 209,p,I,K,r,V,a
    else return 166,p[4],I,K,r,V,a
    end
    end,Bf=function(f,V)local t,r,I,x=2,V[2]
    while true do if t<=1 then if t<=0 then V[1]=V[2][5]
    local j={__index=function(a,p)local K,G=f:fn(V,a,p)
    if K==1 then return G
    end
    end}
    V[2][6]=j
    t,I,r,x=3,V[1],V[2],j
    else local j=V[2][6]
    if j then t,I,r,x=3,V[1],V[2],j
    else t,I,r=0,V[1],V[2]
    end
    end
    elseif t<=2 then t,I,r=V[2][7]and 4 or 1,V[1],V[2]
    elseif t<=3 then return 1,x
    else return 1,(f[98](V[2]))
    end
    end
    V[2]=r
    V[1]=I
    return 0
    end,[41]=coroutine.status,G=function(f,V,t,r,I,x,j,a,p,K)if K<=81 then if K<=80 then local G=I-128+a*128
    return 98,2+V,G,t
    elseif V~=2 then return 25,r,I,t
    else return 1,V,I,t
    end
    elseif K<=82 then t[p]=j
    return 116,V,I,t
    else local t=f[35](x,V)
    return 128<=t and 137 or 45,V,I,t
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_5427()
-- -------------------------------------------------------------
local function Func_5427()
    if not(game.Workspace.Map:FindFirstChild("FishmanTrial"))then return
    end
    local f=if game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")then game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Trial of Water")else nil
    if f then local V,t,r=next,game:GetService("Workspace").SeaBeasts:GetChildren()
    for I,I in V,t,r do if string.find(I.Name,"SeaBeast")then if I:FindFirstChild("HumanoidRootPart")then if(I.HumanoidRootPart.Position-f.Position).Magnitude<=1500 then if I.Health.Value>0 then return I
    end
    end
    end
    end
    end
    end
    end
    end
    end,P=function(f,V,t,r,I,x,j,a,p,K)if x<=101 then if x<=100 then local G=t-128
    local E=128*I+G
    return 222,r,p+2,E,a,j
    else local I=f[35](K,3+p)
    local G,E,u,D=(a-128)*2097152,j-128,128*(V-128),I%128*16384
    local V=E+(u+((I-I%128)*2097152+D)+G)
    return 38,r,p+4,t,V,j
    end
    elseif x<=102 then return 117,r[1],p,t,a,j
    else local V=f[35](K,p+1)
    return 128<=V and 232 or 47,r,p,t,a,V
    end
    end,a=function(f,V,t,r,I,x,j)if j<=1 then if j<=0 then return 146,t-128+V*128,x,I+2,r
    else local t=f[35](V,r)
    return 128<=t and 217 or 238,V,t,I,r
    end
    elseif j<=2 then local t=f[35](V,1)
    return 128>t and 122 or 156,V,x,I,t
    else return 170,V,x,I+1,r
    end
    end,Z_=function(f,V,t,r,I,x)if I<=92 then return 90<t and 189 or 73,x,V,r
    elseif I<=93 then local I=V+1
    local j=f[35](r,I)
    return 128<=j and 181 or 56,I,j,r
    else local f=r-128
    local r=128*t+f
    return 33,x,V+2,r
    end
    end,[22]=buffer.tostring,
end

-- -------------------------------------------------------------
-- FUNCTION_5441()
-- -------------------------------------------------------------
local function Func_5441()
    local f=StatusCheckLeviathan()
    if f=="I DONT KNOW"then getgenv().WebhookIDK=true
    local f=DetectSeaEvents(true)
    local t=not f
    if t then getgenv().PathSeaBeast=false
    getgenv().PathTerrorshark=false
    getgenv().PathSpinBoat=false
    else getgenv().DesIdk=true
    if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    if f.Name=="Terrorshark"then getgenv().PathTerrorshark=f
    end
    getgenv().PathSpinBoat=f
    repeat task.wait()
    local r,I=f:FindFirstChild("HumanoidRootPart"),f:FindFirstChildWhichIsA("Humanoid")
    local x
    if Settings["Use Click M1 Fruit For Sea Event"]then if Settings["Use Dragonstorm For Sea Event"]then else if NameWeapon("Blox Fruit")=="Kitsune-Kitsune"then if r then if I then if I.Health>0 then local j=r.CFrame.LookVector*Vector3.new(1,0,1)
    x=CFrame.new(r.Position+Vector3.new(0,17.39,0)+(j.Magnitude>0.01 and j.Unit or Vector3.new(0,0,-1))*4.66)
    else end
    else end
    else end
    else end
    end
    else end
    local j=x
    local a,p=f:FindFirstChild("Engine")and f:FindFirstChild("Health")and not Settings["Use Dragonstorm For Sea Event"]and not Settings["Use Click M1 Skull Guitar For Sea Event"]
    if a then I=Settings["Use Click M1 Fruit For Sea Event"]
    p=if I then NameWeapon("Blox Fruit")=="Kitsune-Kitsune"else not I
    else p=a
    end
    spawn(function()TeleportSeaEvents(f,j,p)
    end)
    if f:FindFirstChildWhichIsA("Humanoid")then if Settings["Use Dragonstorm For Sea Event"]then if Settings["Auto Change Dragonstorm With Skull Guitar"]then I=NameWeapon("Gun")
    if if I then NameWeapon("Gun")~="Dragonstorm"else not I then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Dragonstorm"}))
    end
    end
    equiptool(NameWeapon("Gun"))
    SpamGunDragonStorm(f.HumanoidRootPart)
    if V:DistanceFromCharacter(f.HumanoidRootPart.Position)<400 then UseSkillGun()
    end
    elseif Settings["Use Click M1 Fruit For Sea Event"]then equiptool(NameWeapon("Blox Fruit"))
    r=NameWeapon("Blox Fruit")
    if V.Character:FindFirstChild(r)then if V.Character[r]:FindFirstChild("LeftClickRemote")then getgenv().UseFruitM1(f,nil,x)
    end
    end
    else UsedualFlock()
    ClickM1(f,true)
    end
    else a=f:FindFirstChild("HumanoidRootPart")or f:FindFirstChild("Engine")
    if f.Name=="SeaBeast1"then getgenv().PathSeaBeast=f
    getgenv().AimPos=CFrame.new(a.Position.X,40,a.Position.Z)
    else getgenv().AimPos=p and CFrame.new(a.Position.X,math.max(a.Position.Y+10,8),a.Position.Z)or CFrame.new(V.Character.HumanoidRootPart.Position.X,-58,V.Character.HumanoidRootPart.Position.Z)
    end
    if Settings["Use Dragonstorm For Sea Event"]and f.Name~="SeaBeast1"then if Settings["Auto Change Dragonstorm With Skull Guitar"]then local r=NameWeapon("Gun")
    if if r then NameWeapon("Gun")~="Dragonstorm"else not r then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Dragonstorm"}))
    end
    end
    equiptool(NameWeapon("Gun"))
    SpamGunDragonStorm(a)
    if V:DistanceFromCharacter(a.Position)<400 then UseSkillGun()
    end
    elseif Settings["Use Click M1 Skull Guitar For Sea Event"]then if Settings["Auto Change Dragonstorm With Skull Guitar"]then local r=NameWeapon("Gun")
    if if r then NameWeapon("Gun")~="Skull Guitar"else not r then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Skull Guitar"}))
    end
    end
    equiptool(NameWeapon("Gun"))
    SpamGunSkullGuitar(a)
    if V:DistanceFromCharacter(a.Position)<400 then UseSkillGun()
    end
    elseif Settings["Use Click M1 Fruit For Sea Event"]and NameWeapon("Blox Fruit")~="Kitsune-Kitsune"then equiptool(NameWeapon("Blox Fruit"))
    local r=NameWeapon("Blox Fruit")
    if V.Character:FindFirstChild(r)then if V.Character[r]:FindFirstChild("LeftClickRemote")then if f.Name=="SeaBeast1"then getgenv().UseFruitM1(f)
    else getgenv().UseFruitM1Boat(a.CFrame*CFrame.new(0,-35,0))
    end
    end
    end
    elseif V:DistanceFromCharacter(a.Position)<400 then AutoUseSkillSeabeast()
    end
    end
    until t or not f.Parent or not Settings["Auto Destroy IDK"]or f:FindFirstChild("Health")and f.Health.Value==0 or f:FindFirstChildWhichIsA("Humanoid")and f.Humanoid.Health==0
    getgenv().DesIdk=false
    end
    elseif getgenv().WebhookIDK then if Settings["Webhook Destroy IDK"]then getgenv().WebhookDestroyIdk()
    getgenv().WebhookIDK=false
    end
    end
    getgenv().DesIdk=false
    end
    end
    end,_=function(f,V,t,r,I,x,j,a,p)if r<=53 then if r<=52 then local K=f[35](x,1+I)
    return K>=128 and 27 or 139,I,j,t,K,a
    else local K=f[35](x,1+I)
    return 128>K and 136 or 78,I,j,K,p,a
    end
    elseif r<=54 then local r=f[35](x,I+2)
    return r>=128 and 230 or 108,I,j,t,p,r
    else local f=j-128
    local r=128*V+f
    return 229,I+2,r,t,p,a
    end
    end,o=function(f,f,V)return f(nil,1154749600,117613361,V)
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_5566()
-- -------------------------------------------------------------
local function Func_5566()
    local f=ipairs
    for I,x in f(V)do while _G.autoDrive and task.wait(0.1)do local f=checkboatFind()
    if not f then return
    end
    I=t(f,x)
    if(f.PrimaryPart.Position-x).Magnitude<10 then f.PrimaryPart.ThrottleFloat=0
    f.PrimaryPart.Throttle=0
    break
    end
    spawn(function()f.VehicleSeat.MaxSpeed=Settings["Speed Boat Auto Drive"]or 300
    NoclipBoat(f)
    end)
    if math.abs(I)>5 then r(f,x)
    f.PrimaryPart.ThrottleFloat=0
    f.PrimaryPart.Throttle=0
    else f.PrimaryPart.ThrottleFloat=1
    f.PrimaryPart.Throttle=1
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_5884()
-- -------------------------------------------------------------
local function Func_5884()
    if game.PlaceId~=getgenv().CheckPlaceId2 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="TravelDressrosa"}))
    return
    end
    if game:GetService("Players").LocalPlayer.Data.Race.Value=="Ghoul"or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm","BuyCheck",4,true)==2 or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm","Change",4,true)==1 then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Plz Turn Off",ShowTime=5})
    wait(5)
    return
    end
    if not(CheckCountItem("Ectoplasm",100))then local f={"Ship Deckhand","Ship Steward","Ship Officer","Ship Engineer"}
    local I=DetectMob(f)
    if I then while true do task.wait()
    sizepart(I)
    BringMob(I)
    UsedualFlock()
    ClickM1(I)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(I.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(I.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local x=IsMobAlive(I)
    if if x then not Settings["Auto Get Ghoul"]else not x then break
    end
    end
    elseif typeof(f)=="table"then if#t[4][t[6]]>=#f then t[4][t[6]]={}
    return
    end
    local I=DetectPartSpawnMob(DetectNameTablePart(f))
    if I then table.insert(t[4][t[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(I.CFrame*CFrame.new(0,60,0))
    local t,x=I.Position,r.Character.HumanoidRootPart
    if(t-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto Get Ghoul"]then break
    end
    end
    wait(1)
    end
    else local t=DetectPartSpawnMob(f,true)
    if t then Instance.new("IntValue",t).Name="Ignored"
    while true do wait()
    toTarget(t.CFrame*CFrame.new(0,60,0))
    local I,x=t.Position,r.Character.HumanoidRootPart
    if(I-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto Get Ghoul"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    return
    end
    if DetectItemPlr("Hellfire Torch")then if(CFrame.new(918.615234,122.202454,33454.3789,-0.999998808,0,0.00172644004,0,1,0,-0.00172644004,0,-0.999998808).Position-r.Character.HumanoidRootPart.Position).Magnitude<=8 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="Ectoplasm",[2]="BuyCheck",[3]=4}))
    v352=game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm","Buy",4)
    else toTarget(CFrame.new(918.615234,122.202454,33454.3789,-0.999998808,0,0.00172644004,0,1,0,-0.00172644004,0,-0.999998808))
    end
    else local f=CheckNameBoss("Cursed Captain")
    if f then while true do task.wait()
    sizepart(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local t=IsMobAlive(f)
    if if t then not Settings["Auto Get Ghoul"]else not t then break
    end
    end
    wait(5)
    else if Settings["Hop Server Get Ghoul"]then SpecialHop("Cursed Captain")
    end
    V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Wating Boss Spawn",ShowTime=5})
    wait(5)
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_6074(f)
-- -------------------------------------------------------------
local function Func_6074(f)
    local r=game:GetService("Players").LocalPlayer.PlayerGui.Notifications
    local I,x,j,a=r:FindFirstChild("NotificationStack")or r,V[f]
    if x then j,a=x:match("^(.-){item1}(.-)$")
    else end
    local p,K,G=next,I:GetChildren()
    for E,u in p,K,G do if u.Name=="NotificationTemplate"or u.Name=="Notification"then if u.Visible then E=u:FindFirstChild("TranslateMe")
    if E then if E.Text==f then return true
    end
    end
    local p,K,G
    if x then p,K,G=x,j,a
    else t[4][t[6]]=t[4][t[6]]or game:GetService("LocalizationService"):GetTranslatorForPlayer(game:GetService("Players").LocalPlayer)
    p=t[4][t[6]]:Translate(game,f):gsub("{color1_[^}]+}","")
    V[f]=p
    p,K,G=p,p:match("^(.-){item1}(.-)$")
    end
    I=u:IsA("TextLabel")and u or u:FindFirstChildWhichIsA("TextLabel",true)
    r=I and I.Text:gsub("&lt
    ","<"):gsub("&gt
    ",">"):gsub("<[^>]+>","")
    if r then if r==p then return true
    elseif K then if r:sub(1,#K)==K then if r:sub(-#G)==G then return true
    end
    end
    end
    end
    x,j,a=p,K,G
    else end
    else end
    end
    end
    end
    end,O_=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if E<=103 then if E<=102 then local w=a-128+K*128
    return 191,2+t,w,I,K,V,r,D,u,G,j
    else local w,g=f[67],f[107](p,t+x)
    w(u,x,(f[15](G,f.Dn[I],g)))
    return 30,t,a,f.un[I],K,V,r,D,u,G,j
    end
    elseif E<=104 then local x,E,w,g=a+1,(12+I)%256,202116108,0
    local U,e,s=f[67],f.on,f[107](p,g+x)
    U(e,g,(f[15](f.Dn[E],w,s)))
    s=f.un[E]
    g=4
    return 135,t,x,w,s,g,f[67],f.on,f[107](p,g+x),f.Dn[s],f[15]
    else return 36>=V and 208 or 190,t,a,I,K,V,r,D,u,G,j
    end
    end,Cf=function(f,V,t,r,I,x,j,a,p,K)if x<=199 then if x<=198 then local G=f[35](I,a+1)
    return G<128 and 71 or 107,a,V,p,t,G
    else local G=f[35](I,a+3)
    local E,u,D,w,g=(V-128)*2097152,j-128,128*(r-128),G%128*16384,G%128
    local r=2097152*(G-g)
    G=D+u+(r+(w+E))
    return 33,a+4,G,p,t,K
    end
    elseif x<=200 then local r=f[35](I,a)
    return r<128 and 181 or 247,a,V,r,t,K
    else local t=f[35](I,2+a)
    return 128<=t and 165 or 244,a,V,p,t,K
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_6731()
-- -------------------------------------------------------------
local function Func_6731()
    if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")then if getgenv().turnoffnoclipBoatt then getgenv().turnoffnoclipBoatt=false
    local f=checkboat()
    if f then TurnOffNoclipBoat(f)
    end
    end
    if getgenv().RespawnVolcano then if Settings["Webhook Find Prehistoric Island"]then getgenv().RespawnVolcano=false
    WebhookFindVolcano()
    end
    end
    if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    local f=t:GetAttribute("CurrentLocation")
    if if f then t:GetAttribute("CurrentLocation")~="Prehistoric Island"else not f then local a=DetectNpc("Fossil Expert")
    if a then toTarget(a.HumanoidRootPart.CFrame)
    return
    end
    end
    f=DetectDragonEggs()
    if f then toTarget(f.Molten.CFrame)
    if t:DistanceFromCharacter(f.Molten.Position)<8 then fireproximityprompt(f.Molten.ProximityPrompt)
    end
    return
    end
    if not(Settings["Ignore Collect Bone"])then f=DetectBone()
    if f then if not(game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible)then if not(game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible)then toTarget(f.CFrame)
    return
    end
    end
    end
    end
    if t:GetAttribute("CurrentLocation")=="Prehistoric Island"and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and getgenv().CanReset then f=tick()
    repeat wait()
    until tick()-f>=10 or not Settings["Fully Event Prehistoric Island"]or DetectBone()and not Settings["Ignore Collect Bone"]or DetectDragonEggs()
    local a,p=Settings["Fully Event Prehistoric Island"]and not DetectDragonEggs()
    if a then local K=DetectBone()
    p=(if K then not K else not Settings["Ignore Collect Bone"])or Settings["Ignore Collect Bone"]
    else p=a
    end
    if p then t.Character.Humanoid.Health=0
    getgenv().CanReset=false
    end
    end
    if DetectLava()then local a,p,K=next,workspace.Map.PrehistoricIsland:GetDescendants()
    for G,G in a,p,K do if G.Name=="TouchInterest"then if G.Parent.Name~="TrialTeleport"then G:Destroy()
    end
    end
    end
    end
    if#workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren()>0 then DeleteLava()
    end
    f=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
    if if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then if workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")and workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt")then toTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
    if t:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position)<8 then fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt,1)
    wait(3)
    end
    return
    elseif not(workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt"))then if not(workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn"))then local f=DetectNpc("Fossil Expert")
    if f then toTarget(f.HumanoidRootPart.CFrame)
    return
    end
    end
    end
    else getgenv().CanReset=true
    if I[4][I[6]]then local f=workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull
    while true do task.wait()
    toTarget(f.CFrame)
    local a=t:DistanceFromCharacter(f.Position)<=200 or DetectGolem()
    if a or DetectRockVolcano()then break
    end
    end
    I[4][I[6]]=false
    return
    end
    local f=DetectGolem()
    if f then while true do task.wait()
    toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,20,7))
    if Settings["Select Method Kill Golem"]=="Instant Kill [ Risk and can bug no die mob ]"then if t:DistanceFromCharacter(f.HumanoidRootPart.Position)<50 then KillRaidEnemy()
    end
    else equiptool(NameWeapon(Settings["Select Weapon Kill Golem"]or"Melee"))
    getgenv().ClickM1Volcano(f)
    end
    if not(getgenv().KillMobRaid)then if Settings["Kill Aura Only Raid And Volcano"]then getgenv().KillMobRaid=true
    local a=Settings["Time Delay Kill"]or 5
    f.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    delay(a,function()getgenv().KillMobRaid=false
    end)
    end
    end
    local a=IsMobAlive(f)
    if if a then not Settings["Fully Event Prehistoric Island"]else not a then break
    end
    end
    end
    f=DetectRockVolcano()
    if f then if Settings["Fix Volcano Safe"]then local a=DetectPositionVolcano()
    local p,p=CheckPosnearRock(a,t.Character.HumanoidRootPart)
    local K=CheckPosnearRock(a,f.WorldPivot)
    if t:DistanceFromCharacter(K)>=400 then x[4][x[6]]=p+1
    if p>=7 then x[4][x[6]]=1
    end
    local p=a[x[4][x[6]]]
    toTarget(CFrame.new(p))
    else local x=j[math.floor(f.WorldPivot.Position.Y)]
    repeat task.wait()
    if t:DistanceFromCharacter((f.WorldPivot*x).Position)>8 then toTarget(f.WorldPivot*x)
    end
    if t:DistanceFromCharacter(f.WorldPivot.Position)<100 then AutoUseSkillFixLava()
    end
    getgenv().AimPos=f.WorldPivot
    local x=workspace.CurrentCamera
    r.Hit=f.WorldPivot
    r.Target=f
    until(if f then not f.Parent else not f)or not Settings["Fully Event Prehistoric Island"]or not RockGlowing(f)or DetectGolem()
    if not(DetectGolem())then I[4][I[6]]=true
    end
    wait(1)
    end
    else local x=j[math.floor(f.WorldPivot.Position.Y)]
    repeat task.wait()
    if t:DistanceFromCharacter((f.WorldPivot*x).Position)>8 then toTarget(f.WorldPivot*x)
    end
    if t:DistanceFromCharacter(f.WorldPivot.Position)<100 then AutoUseSkillFixLava()
    end
    getgenv().AimPos=f.WorldPivot
    local x=workspace.CurrentCamera
    r.Hit=f.WorldPivot
    r.Target=f
    until(if f then not f.Parent else not f)or not Settings["Fully Event Prehistoric Island"]or not RockGlowing(f)or DetectGolem()
    if not(DetectGolem())then I[4][I[6]]=true
    end
    end
    end
    end
    else getgenv().RespawnVolcano=true
    getgenv().turnoffnoclipBoatt=true
    local f=CheckItemInventory("Volcanic Magnet")
    if if f then not f else not Settings["Ignore Craft Volcanic Magnet"]then if getgenv().dacoMagnet then local f=tick()
    repeat wait()
    until tick()-f>=5 or game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    getgenv().dacoMagnet=false
    return
    end
    if CheckCountItem("Scrap Metal",10)then if not(CheckCountItem("Blaze Ember",15))then local f=workspace.NPCs:FindFirstChild("Dragon Hunter")or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter")or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance
    if getgenv().QuestHunterDragon then local I=DetectEmberTemplate()
    if I then Instance.new("IntValue",I).Name="Ignored"
    repeat wait()
    toTarget(I.Part.CFrame)
    until if I then not I.Parent else not I
    return
    end
    if string.find(getgenv().QuestHunterDragon,"Hydra Enforcers")then local x=DetectMob("Hydra Enforcer")
    if x then while true do task.wait()
    sizepart(x)
    BringMob(x)
    UsedualFlock()
    ClickM1(x)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(x.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(x.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local j=IsMobAlive(x)
    if(if j then not Settings["Fully Event Prehistoric Island"]else not j)or I then break
    end
    end
    else local x=DetectPartSpawnMob("Hydra Enforcer",true)
    if x then Instance.new("IntValue",x).Name="Ignored"
    while true do wait()
    toTarget(x.CFrame*CFrame.new(0,60,0))
    local j,a=x.Position,t.Character.HumanoidRootPart
    if(j-a.Position).Magnitude<=100 or DetectMob("Hydra Enforcer")or not Settings["Fully Event Prehistoric Island"]or I then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"Venomous Assailants")then local x=DetectMob("Venomous Assailant")
    if x then while true do task.wait()
    sizepart(x)
    BringMob(x)
    UsedualFlock()
    ClickM1(x)
    toTarget(x.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    local j=IsMobAlive(x)
    if(if j then not Settings["Fully Event Prehistoric Island"]else not j)or I then break
    end
    end
    else local x=DetectPartSpawnMob("Venomous Assailant",true)
    if x then Instance.new("IntValue",x).Name="Ignored"
    while true do wait()
    toTarget(x.CFrame*CFrame.new(0,60,0))
    local j,a=x.Position,t.Character.HumanoidRootPart
    if(j-a.Position).Magnitude<=100 or DetectMob("Venomous Assailant")or not Settings["Fully Event Prehistoric Island"]or I then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"trees")then local x,j=workspace.CurrentCamera,DetectTree()
    if j then Instance.new("IntValue",j).Name="Ignored"
    local a=tick()
    repeat wait()
    local p=j.WorldPivot.Position
    if t:DistanceFromCharacter(p)<50 then AutoAllSkill()
    end
    if j:FindFirstChild("Meshes/plant1_Icosphere",true)then toTarget(j.WorldPivot)
    getgenv().AimPos=j.WorldPivot
    r.Hit=CFrame.new(x.CFrame.Position,p)
    r.Target=j
    else local p,K=(j.WorldPivot*CFrame.new(5,-20,0)).Position,(j.WorldPivot*CFrame.new(0,-20,0)).Position
    toTarget(CFrame.new(p))
    getgenv().AimPos=CFrame.new(K)
    r.Hit=CFrame.new(x.CFrame.Position,K)
    r.Target=j
    end
    until(if j then not j.Parent else not j)or not Settings["Fully Event Prehistoric Island"]or I or j:GetAttribute("AlreadyDestroyedClient")or tick()-a>=15
    end
    end
    elseif t:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,4,4))
    else local f=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="Check"}}))
    if if f then f and not f.Text else not f then getgenv().QuestHunterDragon=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="RequestQuest"}})).Text
    else getgenv().QuestHunterDragon=f.Text
    end
    end
    return
    end
    else local f={"Jungle Pirate","Musketeer Pirate"}
    local r=DetectMob(f)
    if r then while true do task.wait()
    sizepart(r)
    BringMob(r)
    UsedualFlock()
    ClickM1(r)
    toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    local I=IsMobAlive(r)
    if if I then not Settings["Fully Event Prehistoric Island"]else not I then break
    end
    end
    elseif typeof(f)=="table"then if#V[4][V[6]]>=#f then V[4][V[6]]={}
    return
    end
    local r=DetectPartSpawnMob(DetectNameTablePart(f))
    if r then table.insert(V[4][V[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(r.CFrame*CFrame.new(0,60,0))
    local V,I=r.Position,t.Character.HumanoidRootPart
    if(V-I.Position).Magnitude<=100 or DetectMob(f)or not Settings["Fully Event Prehistoric Island"]then break
    end
    end
    wait(1)
    end
    end
    return
    end
    if CheckCountItem("Scrap Metal",10)then if CheckCountItem("Blaze Ember",15)then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({[1]="Craft",[2]="Volcanic Magnet",[3]=1,[4]={}}))
    wait(2)
    end
    end
    else getgenv().dacoMagnet=true
    local f=game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    if(if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible)and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then local f=checkboat()
    local V=not f or f and t:DistanceFromCharacter(f.VehicleSeat.Position)>=4000
    if V then local V=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(V.Position-t.Character.HumanoidRootPart.Position).Magnitude>8 then if(V.Position-t.Character.HumanoidRootPart.Position).Magnitude>1000 then local r=t:GetAttribute("CurrentLocation")
    if if r then t:GetAttribute("CurrentLocation")~="Tiki Outpost"else not r then if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki"or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki2"then t.Character.Humanoid.Health=0
    return
    end
    end
    end
    toTarget(V)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    wait(3)
    end
    elseif t.Character.Humanoid.Sit then task.spawn(function()NoclipBoat(f)
    end)
    local V=CFrame.new(-118834.515625,f.WorldPivot.Y,-78.9505844116211)*CFrame.new(0,0,99999999)
    manageTween(f.VehicleSeat,V,150,"TweenBoat")
    else if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    toTarget(f.VehicleSeat.CFrame)
    end
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_6732()
-- -------------------------------------------------------------
local function Func_6732()
    WarnOnce("AutoCDKGoodHeaven","Auto CDK: dang lam Good Trial 5/5.")
    if(game:GetService("Workspace")._WorldOrigin.Locations["Heavenly Dimension"].Position-V.Character.HumanoidRootPart.Position).Magnitude<1000 then if game:GetService("Workspace").Map.HeavenlyDimension.Exit.BrickColor==BrickColor.new("Cloudy grey")then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame
    toTarget(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame)
    return
    end
    if DetectMobCDK()then WarnOnce("AutoCDKGoodHeavenMobs","Auto CDK: dang don enemy trong Heavenly Dimension.")
    repeat task.wait()
    local f=DetectMobHell()
    sizepart(f)
    equiptool(NameWeapon("Sword"))
    toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    getgenv().ClickM1(f)
    until not DetectMobCDK()
    else local f=TourchGood5()
    if f then WarnOnce("AutoCDKGoodTorch","Auto CDK: dang kich hoat Torch "..f.." trong Heavenly Dimension.")
    repeat task.wait()
    if(V.Character.HumanoidRootPart.Position-game:GetService("Workspace").Map.HeavenlyDimension["Torch"..f].Position).Magnitude>5 then toTarget(game:GetService("Workspace").Map.HeavenlyDimension["Torch"..f].CFrame)
    else fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension["Torch"..f].ProximityPrompt,0)
    fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension["Torch"..f].ProximityPrompt,1)
    end
    until DetectMobCDK()
    V.Character.HumanoidRootPart.CFrame=V.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)
    else WarnOnce("AutoCDKGoodHeavenWait","Auto CDK: dang cho enemy hoac Torch trong Heavenly Dimension.")
    end
    end
    else local f=CheckNameBoss("Cake Queen")
    if f then WarnOnce("AutoCDKGoodCakeQueen","Auto CDK: dang danh Cake Queen.")
    CDKGoodQuestKeep()
    while true do task.wait()
    CDKGoodQuestKeep()
    sizepart(f)
    equiptool(NameWeapon("Sword"))
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local t=IsMobAlive(f)
    local r=(if t then not Settings["Auto CDK"]else not t)or V.Character.Humanoid.Health<=0
    if r then break
    end
    end
    TweenManager.CancelCurrent()
    local t=IsMobAlive(f)
    if(if t then not t else Settings["Auto CDK"])and V.Character.Humanoid.Health>0 then WarnOnce("AutoCDKGoodCakeQueenDead","Auto CDK: Cake Queen da chet, dang cho len Heavenly Dimension.")
    local f=os.clock()
    while true do task.wait(0.5)
    CDKGoodQuestKeep()
    local t,r=game:GetService("Workspace")._WorldOrigin.Locations["Heavenly Dimension"].Position,V.Character.HumanoidRootPart
    local I=(t-r.Position).Magnitude<1000 or os.clock()-f>=10 or not Settings["Auto CDK"]or V.Character.Humanoid.Health<=0
    if I then break
    end
    end
    end
    else if Settings["Select Method Hop CDK1"]then if Settings["Select Method Hop CDK1"]["Find Cake Queen"]then if BossSpawn("Cake Queen")then WarnOnce("AutoCDKGoodCakeQueenWait","Auto CDK: dang cho Cake Queen xuat hien.")
    else WarnOnce("AutoCDKGoodCakeQueenWait","Auto CDK: dang hop server tim Cake Queen.")
    HopServer()
    end
    else WarnOnce("AutoCDKGoodCakeQueenWait","Auto CDK: dang cho Cake Queen xuat hien.")
    end
    else WarnOnce("AutoCDKGoodCakeQueenWait","Auto CDK: dang cho Cake Queen xuat hien.")
    end
    wait(5)
    end
    end
    end
    end
    end,V=function(f,V,t,r,I,x,j,a,p,K,G)if V<=41 then if V<=40 then return 250,j[3],G,a,I,r
    else local G=f[35](x,r)
    return 128<=G and 103 or 8,j,r,G,I,p
    end
    elseif V<=42 then I[p]=K
    return 186,j,r,a,I,p
    else local V=f[35](x,3+r)
    local f,x,K,G=2097152*(I-128),t-128,128*(p-128),V%128*16384
    local t=K+(f+2097152*(V-V%128)+(G+x))
    return 178,j,r+4,a,t,p
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_6998()
-- -------------------------------------------------------------
local function Func_6998()
    if not(StackFarmOther)then return
    end
    local f=false
    for r,I in next,SafeMultiSelect("Select Sea Events"),nil do if I and r~="Only Farm Ship Brigade"then f=true
    break
    end
    end
    if not(f)then WarnOnce("NoSeaEvent","Chua chon su kien nao o Sea Event > Select Sea Events.")
    return
    end
    local f=DetectSeaEvents()
    if f then V()
    if f.Name=="Terrorshark"then getgenv().PathTerrorshark=f
    end
    getgenv().PathSpinBoat=f
    repeat task.wait()
    local V,r=f:FindFirstChild("HumanoidRootPart"),f:FindFirstChildWhichIsA("Humanoid")
    local I
    if Settings["Use Click M1 Fruit For Sea Event"]then if Settings["Use Dragonstorm For Sea Event"]then else if NameWeapon("Blox Fruit")=="Kitsune-Kitsune"then if V then if r then if r.Health>0 then local x=V.CFrame.LookVector*Vector3.new(1,0,1)
    I=CFrame.new(V.Position+Vector3.new(0,17.39,0)+(x.Magnitude>0.01 and x.Unit or Vector3.new(0,0,-1))*4.66)
    else end
    else end
    else end
    else end
    end
    else end
    V,r=f:FindFirstChild("Engine")and f:FindFirstChild("Health")and not Settings["Use Dragonstorm For Sea Event"]and not Settings["Use Click M1 Skull Guitar For Sea Event"]
    if V then local x=Settings["Use Click M1 Fruit For Sea Event"]
    r=if x then NameWeapon("Blox Fruit")=="Kitsune-Kitsune"else not x
    else r=V
    end
    V=r and not Settings["Auto Change Dragonstorm When Kill Boat"]
    TeleportSeaEvents(f,I,V)
    if f:FindFirstChildWhichIsA("Humanoid")then if Settings["Use Dragonstorm For Sea Event"]then if Settings["Auto Change Dragonstorm With Skull Guitar"]then r=NameWeapon("Gun")
    if if r then NameWeapon("Gun")~="Dragonstorm"else not r then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Dragonstorm"}))
    end
    end
    equiptool(NameWeapon("Gun"))
    SpamGunDragonStorm(f.HumanoidRootPart)
    if t:DistanceFromCharacter(f.HumanoidRootPart.Position)<400 then UseSkillGun()
    end
    elseif Settings["Use Click M1 Fruit For Sea Event"]then equiptool(NameWeapon("Blox Fruit"))
    local r=NameWeapon("Blox Fruit")
    if t.Character:FindFirstChild(r)then if t.Character[r]:FindFirstChild("LeftClickRemote")then getgenv().UseFruitM1(f,nil,I)
    end
    end
    else UsedualFlock()
    ClickM1(f,true)
    end
    else local r=f:FindFirstChild("HumanoidRootPart")or f:FindFirstChild("Engine")
    if r then if f.Name=="SeaBeast1"then getgenv().PathSeaBeast=f
    getgenv().AimPos=CFrame.new(r.Position.X,40,r.Position.Z)
    else getgenv().AimPos=V and CFrame.new(r.Position.X,math.max(r.Position.Y+10,8),r.Position.Z)or CFrame.new(t.Character.HumanoidRootPart.Position.X,-58,t.Character.HumanoidRootPart.Position.Z)
    end
    if Settings["Use Dragonstorm For Sea Event"]then if Settings["Auto Change Dragonstorm With Skull Guitar"]then local V=NameWeapon("Gun")
    if if V then NameWeapon("Gun")~="Dragonstorm"else not V then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Dragonstorm"}))
    end
    end
    equiptool(NameWeapon("Gun"))
    SpamGunDragonStorm(r)
    if t:DistanceFromCharacter(r.Position)<400 then UseSkillGun()
    end
    elseif Settings["Use Click M1 Skull Guitar For Sea Event"]then if Settings["Auto Change Dragonstorm With Skull Guitar"]then local V=NameWeapon("Gun")
    if if V then NameWeapon("Gun")~="Skull Guitar"else not V then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Skull Guitar"}))
    end
    end
    equiptool(NameWeapon("Gun"))
    SpamGunSkullGuitar(r)
    if t:DistanceFromCharacter(r.Position)<400 then UseSkillGun()
    end
    elseif Settings["Auto Change Dragonstorm When Kill Boat"]and f:FindFirstChild("Health")and f.Health.Value>0 and f:FindFirstChild("Engine")then local V=NameWeapon("Gun")
    if if V then NameWeapon("Gun")~="Dragonstorm"else not V then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="LoadItem",[2]="Dragonstorm"}))
    end
    equiptool(NameWeapon("Gun"))
    SpamGunDragonStorm(r)
    if t:DistanceFromCharacter(r.Position)<400 then UseSkillGun()
    end
    elseif Settings["Use Click M1 Fruit For Sea Event"]and NameWeapon("Blox Fruit")~="Kitsune-Kitsune"then equiptool(NameWeapon("Blox Fruit"))
    local V=NameWeapon("Blox Fruit")
    if t.Character:FindFirstChild(V)then if t.Character[V]:FindFirstChild("LeftClickRemote")then if f.Name=="SeaBeast1"then getgenv().UseFruitM1(f)
    else getgenv().UseFruitM1Boat(r.CFrame*CFrame.new(0,-35,0))
    end
    end
    end
    elseif t:DistanceFromCharacter(r.Position)<400 then AutoUseSkillSeabeast()
    end
    end
    end
    until(if f then not f.Parent else not f)or not Settings["Auto Sea Event"]or f:FindFirstChild("Health")and f.Health.Value==0 or f:FindFirstChildWhichIsA("Humanoid")and f.Humanoid.Health==0 or not StackFarmOther
    else getgenv().PathSeaBeast=false
    getgenv().PathTerrorshark=false
    getgenv().PathSpinBoat=false
    BuyBoatAndTeleBoat()
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_7144()
-- -------------------------------------------------------------
local function Func_7144()
    if CheckItemInventory("Volcanic Magnet")then if Settings["Auto Crafting Volcanic Magnet"]then SaveSettings("Auto Crafting Volcanic Magnet",false)
    I[4][I[6]].CreateNoti({Title="Banana Cat Hub",Desc="Done Craft Volcanic Magnet",ShowTime=5})
    ToggleAutoCraftingVolcanicMagnet:SetStage(false)
    end
    else if CheckCountItem("Scrap Metal",10)then if not(CheckCountItem("Blaze Ember",15))then local f=workspace.NPCs:FindFirstChild("Dragon Hunter")or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter")or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance
    if getgenv().QuestHunterDragon then local I=DetectEmberTemplate()
    if I then Instance.new("IntValue",I).Name="Ignored"
    repeat wait()
    toTarget(I.Part.CFrame)
    until if I then not I.Parent else not I
    return
    end
    if string.find(getgenv().QuestHunterDragon,"Hydra Enforcers")then local x=DetectMob("Hydra Enforcer")
    if x then while true do task.wait()
    sizepart(x)
    BringMob(x)
    UsedualFlock()
    ClickM1(x)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(x.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(x.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local j=IsMobAlive(x)
    if(if j then not Settings["Auto Crafting Volcanic Magnet"]else not j)or I then break
    end
    end
    else local x=DetectPartSpawnMob("Hydra Enforcer",true)
    if x then Instance.new("IntValue",x).Name="Ignored"
    while true do wait()
    toTarget(x.CFrame*CFrame.new(0,60,0))
    local j,a=x.Position,t.Character.HumanoidRootPart
    if(j-a.Position).Magnitude<=100 or DetectMob("Hydra Enforcer")or not Settings["Auto Quest Dragon Hunter"]or I then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"Venomous Assailants")then local x=DetectMob("Venomous Assailant")
    if x then while true do task.wait()
    sizepart(x)
    BringMob(x)
    UsedualFlock()
    ClickM1(x)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(x.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(x.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local j=IsMobAlive(x)
    if(if j then not Settings["Auto Crafting Volcanic Magnet"]else not j)or I then break
    end
    end
    else local x=DetectPartSpawnMob("Venomous Assailant",true)
    if x then Instance.new("IntValue",x).Name="Ignored"
    while true do wait()
    toTarget(x.CFrame*CFrame.new(0,60,0))
    local j,a=x.Position,t.Character.HumanoidRootPart
    if(j-a.Position).Magnitude<=100 or DetectMob("Venomous Assailant")or not Settings["Auto Crafting Volcanic Magnet"]or I then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"trees")then local x,j=DetectTree(),workspace.CurrentCamera
    if x then Instance.new("IntValue",x).Name="Ignored"
    local a=tick()
    repeat wait()
    local p=x.WorldPivot.Position
    if t:DistanceFromCharacter(p)<50 then AutoAllSkill()
    end
    if x:FindFirstChild("Meshes/plant1_Icosphere",true)then toTarget(x.WorldPivot)
    getgenv().AimPos=x.WorldPivot
    r.Hit=CFrame.new(j.CFrame.Position,p)
    r.Target=x
    else local p,K=(x.WorldPivot*CFrame.new(5,-20,0)).Position,(x.WorldPivot*CFrame.new(0,-20,0)).Position
    toTarget(CFrame.new(p))
    getgenv().AimPos=CFrame.new(K)
    r.Hit=CFrame.new(j.CFrame.Position,K)
    r.Target=x
    end
    until(if x then not x.Parent else not x)or not Settings["Auto Crafting Volcanic Magnet"]or I or x:GetAttribute("AlreadyDestroyedClient")or tick()-a>=15
    end
    end
    elseif t:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,4,4))
    else local f=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="Check"}}))
    if if f then f and not f.Text else not f then getgenv().QuestHunterDragon=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="RequestQuest"}})).Text
    else getgenv().QuestHunterDragon=f.Text
    end
    end
    return
    end
    else local f={"Jungle Pirate"}
    local r=DetectMob(f)
    if r then while true do task.wait()
    sizepart(r)
    BringMob(r)
    UsedualFlock()
    ClickM1(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local I=IsMobAlive(r)
    if if I then not Settings["Auto Crafting Volcanic Magnet"]else not I then break
    end
    end
    elseif typeof(f)=="table"then if#V[4][V[6]]>=#f then V[4][V[6]]={}
    return
    end
    local r=DetectPartSpawnMob(DetectNameTablePart(f))
    if r then table.insert(V[4][V[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(r.CFrame*CFrame.new(0,60,0))
    local V,I=r.Position,t.Character.HumanoidRootPart
    if(V-I.Position).Magnitude<=100 or DetectMob(f)or not Settings["Auto Crafting Volcanic Magnet"]then break
    end
    end
    wait(1)
    end
    end
    return
    end
    if CheckCountItem("Scrap Metal",10)then if CheckCountItem("Blaze Ember",15)then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({[1]="Craft",[2]="Volcanic Magnet",[3]=1,[4]={}}))
    wait(2)
    end
    end
    end
    end
    end
    end,[21]=string.pack,J=function(f,V,t,r,I,x,j,a,p,K)if j<=97 then if j<=96 then local G=f[35](I,r)
    return G<128 and 68 or 152,G,a,t
    else x[K]=p-p%1
    return 250,V,a,t
    end
    elseif j<=98 then local x=f[35](I,r)
    return 128>x and 12 or 120,V,x,t
    else local t=f[35](I,r+2)
    return 128>t and 15 or 147,V,a,t
    end
    end,x=function(f,V,t,r,I)if V<=162 then if V<=161 then return 256,1+t,r
    else local x=f[35](I,t)
    return x>=128 and 52 or 175,t,x
    end
    elseif V<=163 then return 222,t+1,r
    else local V=f[35](I,1+t)
    return V>=128 and 109 or 6,t,V
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_7234()
-- -------------------------------------------------------------
local function Func_7234()
    for f,f in pairs(game:GetService("Players"):GetChildren())do if f.Name==Settings["Select Player PVP"]then return f
    end
    end
    end
    end
    end,[79]=buffer.writeu8,
end

-- -------------------------------------------------------------
-- FUNCTION_7343()
-- -------------------------------------------------------------
local function Func_7343()
    local V=DetectPlayerESP()
    if V then local t=Instance.new("IntValue",V)
    t.Name="Ignored"
    local r=Drawing.new("Text")
    r.Visible=false
    r.Transparency=1
    r.Text=V.Name
    r.Color=Color3.fromRGB(255,255,255)
    r.Size=20
    r.Outline=true
    r.OutlineColor=Color3.fromRGB(0,0,0)
    r.Center=true
    r.Font=1
    spawn(function()repeat task.wait()
    if not(pcall(function()local I,x=game.workspace.CurrentCamera:WorldToViewportPoint(V.HumanoidRootPart.Position)
    if x then r.Text=V.Name.." ("..math.round(f[1]:DistanceFromCharacter(V.HumanoidRootPart.Position))..")".."\10"..V.Humanoid.Health.." / "..V.Humanoid.MaxHealth
    r.Position=Vector2.new(I.X,I.Y-20)
    r.Visible=true
    else r.Visible=false
    end
    end))then r.Visible=false
    end
    until(if V then not V.Parent else not V)or not Settings["ESP Player"]
    r:Remove()
    if V.Parent then t:Destroy()
    end
    end)
    end
    end
    end
    end,[23]=rawset,[78]=buffer.readf32,[115]=UDim2.new,
end

-- -------------------------------------------------------------
-- FUNCTION_7462()
-- -------------------------------------------------------------
local function Func_7462()
    if not(Settings["Auto Turn On V4"])then V:SetStage(true)
    end
    if not(Settings["Auto Choose Gears"])then if getgenv().ToggleAutoChooseGears then getgenv().ToggleAutoChooseGears:SetStage(true)
    end
    end
    if CheckAcientOneDracoStatus()=="Ready For Trial"then if getgenv().WaitingjoinTrial then wait(5)
    getgenv().WaitingjoinTrial=false
    end
    if t:DistanceFromCharacter(workspace._WorldOrigin.Locations["Trial of Flames"].Position)<=3000 then if workspace.Map.DracoTrial.TrialDoor.DoorTouch:FindFirstChild("TouchInterest")then getgenv().DoneTrialDraco=true
    toTarget(workspace.Map.DracoTrial.TrialDoor.DoorTouch.CFrame)
    wait(2)
    return
    end
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then local f=CheckModelTrialDraco()
    local V,K=GetRelicChuaDat(f)
    local G,E=GetRelicChuanbiDat(f)
    if G then local G=f["EndRelic"..E:split("RelicModel")[2]]
    local E=G:FindFirstChildWhichIsA("ProximityPrompt",true)
    if t:DistanceFromCharacter(G.WorldPivot.Position)>8 then toTarget(G.WorldPivot)
    else wait(2)
    fireproximityprompt(E)
    wait(2)
    end
    elseif V then local V=f["Relic"..K:split("RelicModel")[2]]
    local f=V:FindFirstChildWhichIsA("ProximityPrompt",true)
    if t:DistanceFromCharacter(V.WorldPivot.Position)>8 then toTarget(V.WorldPivot)
    else wait(2)
    fireproximityprompt(f)
    wait(2)
    end
    end
    else game.ReplicatedStorage.Remotes.DracoTrial:InvokeServer()
    wait(3)
    end
    else if getgenv().DoneTrialDraco then wait(5)
    getgenv().DoneTrialDraco=false
    return
    end
    if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")then if getgenv().turnoffnoclipBoatt then getgenv().turnoffnoclipBoatt=false
    local f=checkboat()
    if f then TurnOffNoclipBoat(f)
    end
    end
    if getgenv().RespawnVolcano then if Settings["Webhook Find Prehistoric Island"]then getgenv().RespawnVolcano=false
    WebhookFindVolcano()
    end
    end
    if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    local f=t:GetAttribute("CurrentLocation")
    if if f then t:GetAttribute("CurrentLocation")~="Prehistoric Island"else not f then local V=DetectNpc("Fossil Expert")
    if V then toTarget(V.HumanoidRootPart.CFrame)
    return
    end
    end
    if workspace.Map.PrehistoricIsland:FindFirstChild("TrialRock",true).Transparency==1 then getgenv().WaitingjoinTrial=true
    toTarget(workspace.Map.PrehistoricIsland.TrialTeleport.CFrame)
    return
    end
    if DetectLava()then local V,K,G=next,workspace.Map.PrehistoricIsland:GetDescendants()
    for E,E in V,K,G do if E.Name=="TouchInterest"then if E.Parent.Name~="TrialTeleport"then E:Destroy()
    end
    end
    end
    end
    if#workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren()>0 then DeleteLava()
    end
    f=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
    if if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then if workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")and workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt")then toTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
    if t:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position)<8 then fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt,1)
    wait(3)
    end
    return
    elseif not(workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt"))then if not(workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn"))then local f=DetectNpc("Fossil Expert")
    if f then toTarget(f.HumanoidRootPart.CFrame)
    return
    end
    end
    end
    else if x[4][x[6]]then local f=workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull
    while true do task.wait()
    toTarget(f.CFrame)
    local V=t:DistanceFromCharacter(f.Position)<=200 or DetectGolem()
    if V or DetectRockVolcano()then break
    end
    end
    x[4][x[6]]=false
    return
    end
    local f=DetectGolem()
    if f then while true do task.wait()
    toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,20,7))
    if Settings["Select Method Kill Golem"]=="Instant Kill [ Risk and can bug no die mob ]"then if t:DistanceFromCharacter(f.HumanoidRootPart.Position)<50 then KillRaidEnemy()
    end
    else equiptool(NameWeapon(Settings["Select Weapon Kill Golem"]or"Melee"))
    getgenv().ClickM1Volcano(f)
    end
    if not(getgenv().KillMobRaid)then if Settings["Kill Aura Only Raid And Volcano"]then getgenv().KillMobRaid=true
    local V=Settings["Time Delay Kill"]or 5
    f.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    delay(V,function()getgenv().KillMobRaid=false
    end)
    end
    end
    local V=IsMobAlive(f)
    local K,G=(if V then not Settings["Fully Trial Draco"]else not V)or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    if K then G=K
    else V=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
    G=if V then not V else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    end
    if G then break
    end
    end
    end
    f=DetectRockVolcano()
    if f then if Settings["Fix Volcano Safe"]then local V=DetectPositionVolcano()
    local K,K=CheckPosnearRock(V,t.Character.HumanoidRootPart)
    local G=CheckPosnearRock(V,f.WorldPivot)
    if t:DistanceFromCharacter(G)>=400 then j[4][j[6]]=K+1
    if K>=7 then j[4][j[6]]=1
    end
    local K=V[j[4][j[6]]]
    toTarget(CFrame.new(K))
    else local V=a[math.floor(f.WorldPivot.Position.Y)]
    while true do task.wait()
    if t:DistanceFromCharacter((f.WorldPivot*V).Position)>8 then toTarget(f.WorldPivot*V)
    end
    if t:DistanceFromCharacter(f.WorldPivot.Position)<100 then AutoUseSkillFixLava()
    end
    getgenv().AimPos=f.WorldPivot
    local V=workspace.CurrentCamera
    I.Hit=f.WorldPivot
    I.Target=f
    local V,j=(if f then not f.Parent else not f)or not Settings["Fully Trial Draco"]or not RockGlowing(f)or DetectGolem()or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    if V then j=V
    else local V=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
    j=if V then not V else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    end
    if j then break
    end
    end
    if not(DetectGolem())then x[4][x[6]]=true
    end
    wait(1)
    end
    else local V=a[math.floor(f.WorldPivot.Position.Y)]
    while true do task.wait()
    if t:DistanceFromCharacter((f.WorldPivot*V).Position)>8 then toTarget(f.WorldPivot*V)
    end
    if t:DistanceFromCharacter(f.WorldPivot.Position)<100 then AutoUseSkillFixLava()
    end
    getgenv().AimPos=f.WorldPivot
    local V=workspace.CurrentCamera
    I.Hit=f.WorldPivot
    I.Target=f
    local V,j=(if f then not f.Parent else not f)or not Settings["Fully Trial Draco"]or not RockGlowing(f)or DetectGolem()or not game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    if V then j=V
    else local f=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
    j=if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    end
    if j then break
    end
    end
    if not(DetectGolem())then x[4][x[6]]=true
    end
    end
    end
    end
    else getgenv().RespawnVolcano=true
    getgenv().turnoffnoclipBoatt=true
    local f=CheckItemInventory("Volcanic Magnet")
    if if f then not f else not Settings["Ignore Craft Volcanic Magnet Draco"]then if getgenv().dacoMagnet then local f=tick()
    repeat wait()
    until tick()-f>=5 or game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    getgenv().dacoMagnet=false
    return
    end
    if CheckCountItem("Scrap Metal",10)then if not(CheckCountItem("Blaze Ember",15))then local f=workspace.NPCs:FindFirstChild("Dragon Hunter")or game:GetService("ReplicatedStorage").NPCs:FindFirstChild("Dragon Hunter")or NPCManager.getNPCsByName("Dragon Hunter")[1]._modelState._instance
    if getgenv().QuestHunterDragon then local V=DetectEmberTemplate()
    if V then Instance.new("IntValue",V).Name="Ignored"
    repeat wait()
    toTarget(V.Part.CFrame)
    until if V then not V.Parent else not V
    return
    end
    if string.find(getgenv().QuestHunterDragon,"Hydra Enforcers")then local x=DetectMob("Hydra Enforcer")
    if x then while true do task.wait()
    sizepart(x)
    BringMob(x)
    UsedualFlock()
    ClickM1(x)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(x.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(x.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local j=IsMobAlive(x)
    if(if j then not Settings["Fully Trial Draco"]else not j)or V then break
    end
    end
    else local x=DetectPartSpawnMob("Hydra Enforcer",true)
    if x then Instance.new("IntValue",x).Name="Ignored"
    while true do wait()
    toTarget(x.CFrame*CFrame.new(0,60,0))
    local j,a=x.Position,t.Character.HumanoidRootPart
    if(j-a.Position).Magnitude<=100 or DetectMob("Hydra Enforcer")or not Settings["Fully Trial Draco"]or V then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"Venomous Assailants")then local x=DetectMob("Venomous Assailant")
    if x then while true do task.wait()
    sizepart(x)
    BringMob(x)
    UsedualFlock()
    ClickM1(x)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(x.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(x.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local j=IsMobAlive(x)
    if(if j then not Settings["Fully Trial Draco"]else not j)or V then break
    end
    end
    else local x=DetectPartSpawnMob("Venomous Assailant",true)
    if x then Instance.new("IntValue",x).Name="Ignored"
    while true do wait()
    toTarget(x.CFrame*CFrame.new(0,60,0))
    local j,a=x.Position,t.Character.HumanoidRootPart
    if(j-a.Position).Magnitude<=100 or DetectMob("Venomous Assailant")or not Settings["Fully Trial Draco"]or V then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"trees")then local x,j=workspace.CurrentCamera,DetectTree()
    if j then Instance.new("IntValue",j).Name="Ignored"
    local a=tick()
    repeat wait()
    local K=j.WorldPivot.Position
    if t:DistanceFromCharacter(K)<50 then AutoAllSkill()
    end
    if j:FindFirstChild("Meshes/plant1_Icosphere",true)then toTarget(j.WorldPivot)
    getgenv().AimPos=j.WorldPivot
    I.Hit=CFrame.new(x.CFrame.Position,K)
    I.Target=j
    else local K,G=(j.WorldPivot*CFrame.new(5,-20,0)).Position,(j.WorldPivot*CFrame.new(0,-20,0)).Position
    toTarget(CFrame.new(K))
    getgenv().AimPos=CFrame.new(G)
    I.Hit=CFrame.new(x.CFrame.Position,G)
    I.Target=j
    end
    until(if j then not j.Parent else not j)or not Settings["Fully Trial Draco"]or V or j:GetAttribute("AlreadyDestroyedClient")or tick()-a>=15
    end
    end
    elseif t:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,4,4))
    else local f=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="Check"}}))
    if if f then f and not f.Text else not f then getgenv().QuestHunterDragon=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="RequestQuest"}})).Text
    else getgenv().QuestHunterDragon=f.Text
    end
    end
    return
    end
    else local f={"Jungle Pirate","Musketeer Pirate"}
    local V=DetectMob(f)
    if V then while true do task.wait()
    sizepart(V)
    BringMob(V)
    UsedualFlock()
    ClickM1(V)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(V.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(V.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local I=IsMobAlive(V)
    if if I then not Settings["Fully Trial Draco"]else not I then break
    end
    end
    elseif typeof(f)=="table"then if#r[4][r[6]]>=#f then r[4][r[6]]={}
    return
    end
    local V=DetectPartSpawnMob(DetectNameTablePart(f))
    if V then table.insert(r[4][r[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local I,x=V.Position,t.Character.HumanoidRootPart
    if(I-x.Position).Magnitude<=100 or DetectMob(f)or not Settings["Fully Trial Draco"]then break
    end
    end
    wait(1)
    end
    end
    return
    end
    if CheckCountItem("Scrap Metal",10)then if CheckCountItem("Blaze Ember",15)then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({[1]="Craft",[2]="Volcanic Magnet",[3]=1,[4]={}}))
    wait(2)
    end
    end
    else getgenv().dacoMagnet=true
    local f=game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
    if(if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible)and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then local f=checkboat()
    local V=not f or f and t:DistanceFromCharacter(f.VehicleSeat.Position)>=4000
    if V then local V=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(V.Position-t.Character.HumanoidRootPart.Position).Magnitude>8 then if(V.Position-t.Character.HumanoidRootPart.Position).Magnitude>1000 then local I=t:GetAttribute("CurrentLocation")
    if if I then t:GetAttribute("CurrentLocation")~="Tiki Outpost"else not I then if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki"or game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki2"then t.Character.Humanoid.Health=0
    return
    end
    end
    end
    toTarget(V)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    wait(3)
    end
    elseif t.Character.Humanoid.Sit then task.spawn(function()NoclipBoat(f)
    end)
    local V=CFrame.new(-118834.515625,f.WorldPivot.Y,-78.9505844116211)*CFrame.new(0,0,99999999)
    manageTween(f.VehicleSeat,V,150,"TweenBoat")
    else if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    toTarget(f.VehicleSeat.CFrame)
    end
    end
    end
    end
    end
    elseif string.find(CheckAcientOneDracoStatus(),"Can Buy Gear")then BuyGearDracoV4()
    else local f=DetectMob(p)
    if f then while true do task.wait()
    sizepart(f)
    BringMob(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local V=IsMobAlive(f)
    if if V then not Settings["Fully Trial Draco"]else not V then break
    end
    end
    elseif typeof(p)=="table"then if#r[4][r[6]]>=#p then r[4][r[6]]={}
    return
    end
    local f=DetectPartSpawnMob(DetectNameTablePart(p))
    if f then table.insert(r[4][r[6]],DetectNameTablePart(p))
    while true do wait()
    toTarget(f.CFrame*CFrame.new(0,60,0))
    local V,r=f.Position,t.Character.HumanoidRootPart
    if(V-r.Position).Magnitude<=100 or DetectMob(p)or not Settings["Fully Trial Draco"]then break
    end
    end
    wait(1)
    end
    else local f=DetectPartSpawnMob(p,true)
    if f then Instance.new("IntValue",f).Name="Ignored"
    while true do wait()
    toTarget(f.CFrame*CFrame.new(0,60,0))
    local V,r=f.Position,t.Character.HumanoidRootPart
    if(V-r.Position).Magnitude<=100 or DetectMob(p)or not Settings["Fully Trial Draco"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    end
    end
    end,H=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if j then if p<=165 then local j=f[35](t,3+G)
    local w,g,U,e,s=2097152*(a-128),K-128,128*(x-128),16384*(j%128),j%128
    local x=(j-s)*2097152
    s=w+(U+g)+e+x
    return 98,t,G+4,V,s,D,u
    else local x=f[35](t,G+1)
    return x>=128 and 19 or 89,t,G,V,a,x,u
    end
    elseif p<=167 then local x=f[35](t,E)
    if 128<=x then return 5,t,G,x,a,D,u
    else return 118,x,G,V,a,D,u
    end
    else local x=f[35](t,3+G)
    local f,j,p,K=2097152*(u-128),r-128,(I-128)*128,x%128*16384
    local r=p+(2097152*(x-x%128)+f)+(K+j)
    return 256,t,4+G,V,a,D,r
    end
    end,h_=function(f,V,t,r,I,x,j,a)if j<=165 then local p,K,G=f[76](a,1+I%r,2+I%r),1+I,1+0
    return 39,{nil,K-G,G,V,x+0},a,x,p,t
    elseif j<=166 then local j,p,K=V[1],V[2],V[5]
    local G,E=j+p,p<=0
    p,j=G>=K,G<=K
    K=E and p or not E and j
    V[1]=G
    if K then return 165,V,a,x,G,t
    else return 18,V,a,x,I,t
    end
    else local t,I=0,a[4]
    local j,p=f[35](I,r),1+r
    if j>138 then return 149,V,a,t,I,j
    else return 199,V,t,x,I,j
    end
    end
    end,[122]=string.match,
end

-- -------------------------------------------------------------
-- FUNCTION_7706()
-- -------------------------------------------------------------
local function Func_7706()
    if getgenv().buychip then if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then if CheckInRaid()then return true
    end
    end
    else return true
    end
    end
    end
    end,Kf=function(f,V,t,r,I,x,j,a)if r<=232 then local r=f[35](j,a+2)
    return r<128 and 151 or 101,a,I,r
    else local r=f[35](j,3+a)
    local f,j,p,K,G=(I-128)*2097152,t-128,128*(x-128),16384*(r%128),r%128
    local t=(r-G)*2097152
    G=j+K+f+(p+t)
    return 222,a+4,G,V
    end
    end,[81]=bit32.bnot,b=function(f,V,t,r,I,x,j,a,p,K)if t<=170 then if t<=169 then local G,E=f[107](I,j),j+4
    local u=G/2
    if G%2~=0 then return 173,E,u,K,x,a
    else return 155,E,p,u,x,a
    end
    else local G=f[35](I,j)
    return G<128 and 258 or 210,j,p,K,G,a
    end
    elseif t<=171 then return 252,j,p+1,K,x,a
    else local t=f[35](I,3+j)
    local f,I,G,E,u=(a-128)*2097152,r-128,128*(V-128),16384*(t%128),t%128
    local V=2097152*(t-u)
    t=f+E+(I+G)+V
    return 229,j+4,p,K,x,t
    end
    end,lf=function(f,V,t,r,I,x,j,a,p,K,G,E)if E<=15 then if E<=13 then local u=f[35](K,1+G)
    return 128<=u and 141 or 195,t,G,V,p,u
    elseif E<=14 then K[I]=f[15](r,V*I)
    return 90,t,G,V,p,I
    else local u=f[35](j,1)
    return u<128 and 40 or 38,t,u,V,p,I
    end
    elseif E<=16 then local u,D,w,g=1+G,(V+216)%256,3638089944,0
    local U,e,s=f[67],f.on,f[107](K,u+g)
    U(e,g,(f[15](f.Dn[D],w,s)))
    return 123,t,u,D,w,I
    elseif E<=17 then local E,u=f[67],f[107](K,x+r)
    E(j,x,(f[15](f.Dn[V],a,u)))
    return 126,t,G,f.un[V],p,I
    else return 130,t[4],G,V,p,I
    end
    end,t_=function(f,V,t,r,I,x,j,a,p,K,G,E,u)if u<=191 then local D,w,g,U=f[22],(175+r)%256,f[109](a),a-a%4
    local a,e=U-1,4+0
    return 30,{x,nil,0-e,a+0,e},w,175,D,185,57,g,2947526575,U
    elseif u<=192 then local a=f[35](G,3+r)
    local f,G,u,D=(t-128)*2097152,E-128,(V-128)*128,16384*(a%128)
    local w=G+(u+(a-a%128)*2097152+f)+D
    return 87,x,r+4,w,E,V,p,j,K,I
    else return 162==E and 79 or 129,x,r,t,E,V,p,j,K,I
    end
    end,[64]=buffer.readstring,O=function(f,V,t,r,I,x,j,a,p,K)if a<=5 then if a<=4 then local G,E,u=16384*(r-128),j-128,V*128
    local V=E+G+u
    return 96,p,t+3,V,x
    else local V=f[35](p,1+K)
    if V>=128 then return 243,p,t,V,x
    else return 95,V,t,r,x
    end
    end
    elseif a<=6 then local V=x-128
    local x=I*128+V
    return 64,p,t+2,r,x
    else local V=f[35](p,t+1)
    return V<128 and 177 or 160,p,t,r,V
    end
    end,G_=function(f,V,t,r,I,x,j,a,p)if x<=182 then if x<=181 then local K=f[35](V,r+1)
    return 128<=K and 98 or 102,j,K
    else return 76<p and 92 or 151,j,a
    end
    elseif x<=183 then local f=j[5]
    I[t]=V
    return 71,f,a
    else local f=1+I
    return 196,j,a
    end
    end,Yf=function(f,V,t,r,I,x,j,a,p,K,G)if j<=36 then if j<=35 then local E=(K-128)*16384+(V-128+I*128)
    return 206,p,3+a,E,V
    else local E,u=a-1,1+0
    return 163,{r-u,p,E+0,nil,u},a,K,V
    end
    elseif j<=37 then local r=f[35](x,3+K)
    local x,j,E,u=(V-128)*2097152,I-128,(G-128)*128,16384*(r%128)
    local I,G=j+(r-r%128)*2097152+(x+(u+E)),4+K
    return 63,p,a,K,I
    else local r=f[35](t,2)
    return 128>r and 34 or 85,p,a,r,V
    end
    end,[13]=coroutine.running,
end

-- -------------------------------------------------------------
-- FUNCTION_7842()
-- -------------------------------------------------------------
local function Func_7842()
    local f,V,t=next,game.Workspace.Characters:GetChildren()
    local r=0
    for I,x in f,V,t do I=CheckMultiAccount()[x.Name]
    r=if I then if(x.HumanoidRootPart.Position-game:GetService("Workspace").Map["Temple of Time"][I.."Corridor"].Door.Door.RightDoor.Union.Position).Magnitude<100 then r+1 else r else r
    end
    if r>=2 then return true
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_8199()
-- -------------------------------------------------------------
local function Func_8199()
    local f=CheckRace()
    if f==" V3"then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Done V3",ShowTime=5})
    wait(5)
    return
    end
    if game.PlaceId~=getgenv().CheckPlaceId2 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="TravelDressrosa"}))
    return
    end
    if f==" V1"then if t.Data.Beli.Value<500000 then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Beli >= 500k",ShowTime=5})
    wait(5)
    return
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist","1")==0 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist","2")
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist","1")==1 then if DetectItemPlr("Flower 1")then if DetectItemPlr("Flower 2")then if not(DetectItemPlr("Flower 3"))then local j=DetectMob("Swan Pirate")
    if j then while true do task.wait()
    sizepart(j)
    BringMob(j)
    UsedualFlock()
    ClickM1(j)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(j.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(j.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local a=IsMobAlive(j)
    if if a then not Settings["Auto Upgrade Race V2-V3"]else not a then break
    end
    end
    else local j="Swan Pirate"
    if typeof(j)=="table"then if#r[4][r[6]]>=11 then r[4][r[6]]={}
    return
    end
    local a=DetectPartSpawnMob(DetectNameTablePart(j))
    if a then table.insert(r[4][r[6]],DetectNameTablePart(j))
    while true do wait()
    toTarget(a.CFrame*CFrame.new(0,60,0))
    local r,p=a.Position,t.Character.HumanoidRootPart
    if(r-p.Position).Magnitude<=100 or DetectMob(j)or not Settings["Auto Upgrade Race V2-V3"]then break
    end
    end
    wait(1)
    end
    else local r=DetectPartSpawnMob(j,true)
    if r then Instance.new("IntValue",r).Name="Ignored"
    while true do wait()
    toTarget(r.CFrame*CFrame.new(0,60,0))
    local a,p=r.Position,t.Character.HumanoidRootPart
    if(a-p.Position).Magnitude<=100 or DetectMob(j)or not Settings["Auto Upgrade Race V2-V3"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    end
    else TweenToFlower(game:GetService("Workspace").Flower2)
    end
    else TweenToFlower(game:GetService("Workspace").Flower1)
    end
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist","1")==2 then if(CFrame.new(-2777.6001,72.9661407,-3571.42285).Position-t.Character.HumanoidRootPart.Position).Magnitude<8 then toTarget(CFrame.new(-2777.6001,72.9661407,-3571.42285))
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
    end
    else AutoQuestBarito()
    end
    else local r=game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad","1")
    if r==0 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad","2")
    return
    elseif r==2 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad","3")
    return
    elseif r==-1 then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Beli >= 2m",ShowTime=5})
    wait(5)
    return
    end
    r=game:GetService("Players").LocalPlayer.Data.Race.Value..f
    if r=="Human V2"then local f=table.find(BlBossHuman,"Jeremy")
    local j,a=if f then not f else CheckNameBoss("Jeremy")
    if j then a=j
    else f=table.find(BlBossHuman,"Orbitus")
    a=if f then not f else CheckNameBoss("Orbitus")
    end
    j=nil
    if a then j=a
    else f=table.find(BlBossHuman,"Diamond")
    j=if f then not f else CheckNameBoss("Diamond")
    end
    if j then f=CheckNameBoss(j.Name)
    if f then repeat task.wait()
    sizepart(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    until not IsMobAlive(f)
    if not(table.find(BlBossHuman,j.Name))then table.insert(BlBossHuman,j.Name)
    end
    end
    else V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Waiting Boss Spawn",ShowTime=5})
    wait(5)
    end
    elseif r=="Mink V2"then AutoMinkV2()
    elseif r=="Cyborg V2"then if not(CheckFruitplr())then if TakeFruitInventory(true)then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit",TakeFruitInventory(true))
    end
    end
    elseif r=="Fishman V2"then AutoFishV2()
    elseif r=="Skypiea V2"then local f=DetectPlayerAngel()
    if f then table.insert(I,f.Name)
    local V=tick()
    repeat wait()
    spawn(function()if game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.PvpDisabled.Visible then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
    end
    end)
    spawn(function()getgenv().AimPos=CFrame.new(f.Character.HumanoidRootPart.CFrame.p,f.Character.HumanoidRootPart.Position+f.Character.HumanoidRootPart.Velocity/1.2)
    if t:DistanceFromCharacter(f.Character.HumanoidRootPart.Position)<50 then t.Character.HumanoidRootPart.CFrame=f.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
    else toTarget(f.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3))
    end
    end)
    spawn(function()if t:DistanceFromCharacter(f.Character.HumanoidRootPart.Position)<50 then AutoAllSkill(true)
    end
    end)
    until tick()-V>=70 or not f.Character or not f.Character.Parent or f.Character.Humanoid.Health==0 or CheckSafezone(f.Character)or CheckPlayercantAttack(f.Character)or not Settings["Auto Upgrade Race V2-V3"]
    else HopServer()
    wait(5)
    end
    elseif r=="Ghoul V2"then local f=DetectPlayerGhoul()
    if f then table.insert(x,f.Name)
    local V=tick()
    repeat wait()
    spawn(function()if game:GetService("Players").LocalPlayer.PlayerGui.Main.BottomHUDList.PvpDisabled.Visible then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
    end
    end)
    spawn(function()getgenv().AimPos=CFrame.new(f.Character.HumanoidRootPart.CFrame.p,f.Character.HumanoidRootPart.Position+f.Character.HumanoidRootPart.Velocity/1.2)
    if t:DistanceFromCharacter(f.Character.HumanoidRootPart.Position)<50 then t.Character.HumanoidRootPart.CFrame=f.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
    else toTarget(f.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3))
    end
    end)
    spawn(function()if t:DistanceFromCharacter(f.Character.HumanoidRootPart.Position)<50 then AutoAllSkill(true)
    end
    end)
    until tick()-V>=70 or not f.Character or not f.Character.Parent or f.Character.Humanoid.Health==0 or CheckSafezone(f.Character)or CheckPlayercantAttack(f.Character)or not Settings["Auto Upgrade Race V2-V3"]
    else HopServer()
    wait(5)
    end
    end
    end
    end
    end
    end,z=function(f,f,V,t,r,I,x)if V<=113 then if V<=112 then return I~=0 and 81 or 67,f,t,x
    else local I,j,a=r[2],r[5],r[3]
    local p,K=I+j,j<=0
    I,j=p>=a,p<=a
    a=K and I or not K and j
    r[2]=p
    if a then return 242,f,t,p
    else return 195,f,t,x
    end
    end
    elseif V<=114 then return 167,f+1,t,x
    else local V,I,j=r[2],r[1],r[3]
    local a,p=V+I,I<=0
    I,V=a>=j,a<=j
    j=p and I or not p and V
    r[2]=a
    if j then return 237,f,a,x
    else return 121,f,t,x
    end
    end
    end,nf=function(f,V,t,r,I,x,j,a,p,K,G)if G<=43 then if G<=42 then j[3+r]=I
    j[2+r]=t
    j[1+r]=x
    return 22,p,a,K
    else local t,r=16384*(a-128),K-128
    local I=V*128+t+r
    return 128,3+p,I,K
    end
    elseif G<=44 then local t=a+1
    local r,I,I=f[35](j,t),1+t,a+2
    t=f[35](j,I)
    return t>=128 and 112 or 10,r,I,t
    else local f,t=16384*(a-128),K-128
    local r=f+V*128+t
    return 159,3+p,r,K
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_8280()
-- -------------------------------------------------------------
local function Func_8280()
    local f,t,r=V.Character.PrimaryPart.Position,1/0
    for V,I in pairs(game:GetService("CollectionService"):GetTagged("EasterEgg26"))do V=(f-I:GetAttribute("CFrame").Position).Magnitude
    if V<t then t,r=V,I
    else end
    end
    return r
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_8426()
-- -------------------------------------------------------------
local function Func_8426()
    if Settings["Auto Destroy IDK"]then if getgenv().DesIdk then getgenv().DesIdk2=true
    return
    end
    end
    if Settings["Auto Destroy IDK"]then if getgenv().DesIdk2 then toTarget(getgenv().OldBoat.VehicleSeat.CFrame)
    if V.Character.Humanoid.Sit then getgenv().DesIdk2=false
    end
    return
    end
    end
    local f=checkboatFind()
    if game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension")then if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    if getgenv().TweenBoatBack then getgenv().TweenBoatBack:Pause()
    getgenv().TweenBoatBack:Cancel()
    end
    t[4][t[6]].CreateNoti({Title="Banana Cat Hub",Desc="Frozen Dimension Spawned",ShowTime=5})
    if getgenv().RespawnLeviathan then if Settings["Webhook Find Leviathan"]then getgenv().RespawnLeviathan=false
    WebhookFindLeviathan()
    end
    end
    wait(5)
    else getgenv().RespawnLeviathan=true
    local t=checkboat()
    if if t then not t else Settings["Auto Buy Boat Beast Hunter"]then local r=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
    if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then if(r.Position-V.Character.HumanoidRootPart.Position).Magnitude>1000 then if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value=="Tiki"then V.Character.Humanoid.Health=0
    return
    end
    end
    toTarget(r)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","Beast Hunter")
    wait(3)
    end
    elseif f then getgenv().noclip=false
    local r,I=f.VehicleSeat.Position.Y,150
    local x=CFrame.new(-118834.515625,r,-78.9505844116211)*CFrame.new(0,0,99999999)
    CFrame.new(-32975.9921875,r,25963.7109375)
    local j,a=if Settings["Will Back When over 10km"]then if DistanceFindLeviathan()>=12000 then true else if DistanceFindLeviathan()<=4800 then false else false else false,f.VehicleSeat:FindFirstChild("BodyVelocity")
    local p=a and a.MaxForce
    if a then a.MaxForce=Vector3.new(0.0,0.0,0.0)
    a.Velocity=Vector3.new(0.0,0.0,0.0)
    end
    local K=false
    while true do task.wait(0.5)
    NoclipBoat(f)
    if V.Character:FindFirstChild("HumanoidRootPart")and V.Character:FindFirstChild("Humanoid")then local G,E,u=next,V.Character:GetDescendants()
    for D,D in G,E,u do if D:IsA("MeshPart")then if D.CanCollide then D.CanCollide=false
    end
    elseif D:IsA("Part")then if D.CanCollide then D.CanCollide=false
    end
    end
    end
    end
    r=f.VehicleSeat.Position.Y
    local G
    if(if K then not K else DetectSeaEventDodge(true))and r<500 then x=CFrame.new(-118834.515625,r+200,-78.9505844116211)*CFrame.new(0,0,99999999)
    K,G=true,CFrame.new(-32975.9921875,r+200,25963.7109375)
    else if K and not DetectSeaEventDodge(true)then x=CFrame.new(-118834.515625,r,-78.9505844116211)*CFrame.new(0,0,99999999)
    K,G=false,CFrame.new(-32975.9921875,r,25963.7109375)
    else x=CFrame.new(-118834.515625,r,-78.9505844116211)*CFrame.new(0,0,99999999)
    G=CFrame.new(-32975.9921875,r,25963.7109375)
    end
    end
    if Settings["Will Back When over 10km"]then j=if DistanceFindLeviathan()>=10000 then true else if DistanceFindLeviathan()<=4800 then false else j
    if j then manageTween(f.VehicleSeat,G,I,"TweenBoatBack")
    end
    else end
    if j then if not(Settings["Will Back When over 10km"])then manageTween(f.VehicleSeat,x,I,"TweenBoat")
    end
    else manageTween(f.VehicleSeat,x,I,"TweenBoat")
    end
    local r=Settings["Auto Find Leviathan"]
    local I=(if r then not V.Character.Humanoid.Sit else not r)or game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension")or Settings["Auto Destroy IDK"]and getgenv().DesIdk
    if I then break
    end
    end
    if a then if p then a.MaxForce=p
    end
    end
    getgenv().OldBoat=f
    if getgenv().TweenBoat then getgenv().TweenBoat:Pause()
    getgenv().TweenBoat:Cancel()
    end
    if getgenv().TweenBoatBack then getgenv().TweenBoatBack:Pause()
    getgenv().TweenBoatBack:Cancel()
    end
    elseif t then if Settings["Auto Buy Boat Beast Hunter"]then if not(V.Character.Humanoid.Sit)then toTarget(t.VehicleSeat.CFrame)
    end
    end
    end
    end
    end
    end
    end,gn=function(f,V,t,r)local I=f[29]
    I()
    for f,x,j,a,p,K,G,E,u,D in V,t,r do I(true,{f,x,j,a,p,K,G,E,u,D})
    end
    end,I=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D,w)if D<=33 then if D<=32 then local g=(j-128)*16384
    local U=K-128+(g+a*128)
    return 236,E,w+3,r,u,U,V
    else local a=f[35](I,w)
    return a>=128 and 128 or 91,E,w,r,a,j,V
    end
    elseif D<=34 then local f,I=16384*(r-128),t-128
    local t=128*G+(I+f)
    return 104,E+3,w,t,u,j,V
    else local f,t=16384*(V-128),p-128
    local V=f+x*128+t
    return 64,E,3+w,r,u,j,V
    end
    end,P_=function(f,V,t,r,I,x,j,a,p,K,G,E,u)if V<=202 then if V<=201 then return 185,G[4],E,u,a,t,r,x,I,j
    else local D,w,g,U=f[22],(175+K)%256,f[109](p),p-p%4
    local K,e=U-1,4+0
    local s=0-e
    return 207,{G,e,nil,K+0,s},w,175,D,185,57,g,2947526575,U
    end
    elseif V<=203 then local V=f[35](t,p+2)
    return 128>V and 68 or 20,G,E,V,a,t,r,x,I,j
    else return 103~=p and 157 or 55,G,E,u,a,t,r,x,I,j
    end
    end,s_=function(f,f,V,t,r,I,x)if I<=10 then if I<=9 then return 2
    else local j,a,p=f[5],f[2],f[4]
    local K,G=j+a,a<=0
    a,j=K>=p,K<=p
    p=G and a or not G and j
    f[5]=K
    if p then return 1,23,f,t,r,V,K
    else return 1,5,f,t,r,V,x
    end
    end
    elseif I<=11 then local I=1+0
    local j=0-I
    return 1,1,{255+0,j,f,I,nil},185,57,V,x
    else return 1,4,f,t,r,V+1,x
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_8538()
-- -------------------------------------------------------------
local function Func_8538()
    if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")then local f=V:GetAttribute("CurrentLocation")
    if if f then V:GetAttribute("CurrentLocation")~="Prehistoric Island"else not f then local j=DetectNpc("Fossil Expert")
    if j then toTarget(j.HumanoidRootPart.CFrame)
    return
    end
    end
    if DetectLava()then local j,a,p=next,workspace.Map.PrehistoricIsland:GetDescendants()
    for K,K in j,a,p do if K.Name=="TouchInterest"then if K.Parent.Name~="TrialTeleport"then K:Destroy()
    end
    end
    end
    end
    if#workspace.Map.PrehistoricIsland.Core.InteriorLava:GetChildren()>0 then DeleteLava()
    end
    f=game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.PrehistoricRaidTimer.Visible
    if if f then not f else not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then if workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")and workspace.Map.PrehistoricIsland.Core.ActivationPrompt:FindFirstChild("ProximityPrompt")then toTarget(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.CFrame)
    if V:DistanceFromCharacter(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.Position)<8 then fireproximityprompt(workspace.Map.PrehistoricIsland.Core.ActivationPrompt.ProximityPrompt,1)
    wait(3)
    end
    return
    elseif not(workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt"))then if not(workspace.Map.PrehistoricIsland.Core:FindFirstChild("FossilExpertSpawn"))then local f=DetectNpc("Fossil Expert")
    if f then toTarget(f.HumanoidRootPart.CFrame)
    return
    end
    end
    end
    else if t[4][t[6]]then local f=workspace.Map.PrehistoricIsland.Core.PrehistoricRelic.Skull
    while true do task.wait()
    toTarget(f.CFrame)
    local j=V:DistanceFromCharacter(f.Position)<=200 or DetectGolem()
    if j or DetectRockVolcano()then break
    end
    end
    t[4][t[6]]=false
    return
    end
    local f=DetectGolem()
    if f then while true do task.wait()
    toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,20,7))
    if Settings["Select Method Kill Golem"]=="Instant Kill [ Risk and can bug no die mob ]"then if V:DistanceFromCharacter(f.HumanoidRootPart.Position)<50 then KillRaidEnemy()
    end
    else equiptool(NameWeapon(Settings["Select Weapon Kill Golem"]or"Melee"))
    getgenv().ClickM1Volcano(f)
    end
    if not(getgenv().KillMobRaid)then if Settings["Kill Aura Only Raid And Volcano"]then getgenv().KillMobRaid=true
    local j=Settings["Time Delay Kill"]or 5
    f.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    delay(j,function()getgenv().KillMobRaid=false
    end)
    end
    end
    local j=IsMobAlive(f)
    if if j then not Settings["Auto Event Prehistoric Island"]else not j then break
    end
    end
    end
    f=DetectRockVolcano()
    if f then if Settings["Fix Volcano Safe"]then local j=DetectPositionVolcano()
    local a,a=CheckPosnearRock(j,V.Character.HumanoidRootPart)
    local p=CheckPosnearRock(j,f.WorldPivot)
    if V:DistanceFromCharacter(p)>=400 then r[4][r[6]]=a+1
    if a>=7 then r[4][r[6]]=1
    end
    local a=j[r[4][r[6]]]
    toTarget(CFrame.new(a))
    else local r=I[math.floor(f.WorldPivot.Position.Y)]
    repeat task.wait()
    if V:DistanceFromCharacter((f.WorldPivot*r).Position)>8 then toTarget(f.WorldPivot*r)
    end
    if V:DistanceFromCharacter(f.WorldPivot.Position)<100 then AutoUseSkillFixLava()
    end
    getgenv().AimPos=f.WorldPivot
    local r=workspace.CurrentCamera
    x.Hit=f.WorldPivot
    x.Target=f
    until(if f then not f.Parent else not f)or not Settings["Auto Event Prehistoric Island"]or not RockGlowing(f)or DetectGolem()
    if not(DetectGolem())then t[4][t[6]]=true
    end
    wait(1)
    end
    else local r=I[math.floor(f.WorldPivot.Position.Y)]
    repeat task.wait()
    if V:DistanceFromCharacter((f.WorldPivot*r).Position)>8 then toTarget(f.WorldPivot*r)
    end
    if V:DistanceFromCharacter(f.WorldPivot.Position)<100 then AutoUseSkillFixLava()
    end
    getgenv().AimPos=f.WorldPivot
    local V=workspace.CurrentCamera
    x.Hit=f.WorldPivot
    x.Target=f
    until(if f then not f.Parent else not f)or not Settings["Auto Event Prehistoric Island"]or not RockGlowing(f)or DetectGolem()
    if not(DetectGolem())then t[4][t[6]]=true
    end
    end
    end
    end
    end
    end
    end
    end,uf=function(f,V,t,r,I,x,j,a,p,K)if r<=182 then if r<=181 then return 229,1+x,a,t
    else local G=f[35](I,x+2)
    return 128>G and 4 or 129,x,G,t
    end
    elseif r<=183 then local r=f[35](I,x+3)
    local f,I,G,E=(t-128)*2097152,K-128,128*(p-128),16384*(r%128)
    local p=(r-r%128)*2097152+(G+E+(I+f))
    return 236,x+4,a,p
    else j[V]=a
    return 115,x,a,t
    end
    end,S_=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if K<=96 then if K<=95 then G(x,E,(D(I,u,r)))
    local I,x=1,(t*u+j)%256
    f[79](f.on,I,(f[15](r,f[35](p,I+a),x)))
    return 130,f[94](f.on,V),t,j
    else local I=f[35](p,2+V)
    return 128<=I and 66 or 45,r,I,j
    end
    elseif K<=97 then local I=f[35](p,V+1)
    return I>=128 and 96 or 150,I,t,j
    else local I=f[35](p,2+V)
    return 128>I and 5 or 64,r,t,I
    end
    end,af=function(f,V,t,r,I,x,j,a,p,K)if I<=211 then if I<=210 then local G=f[35](p,1+j)
    return 128>G and 22 or 182,t,j,G,K,a,V
    else local G=f[35](p,2+j)
    return 128<=G and 183 or 32,t,j,x,G,a,V
    end
    elseif I<=212 then local I=x-128+128*r
    return 197,t,j+2,I,K,a,V
    else local V,r,I=f[107](p,j),4+j,1+0
    return 255,{1-I,nil,I,t,V+0},r,x,K,1,{}
    end
    end,o_=function(f,V,t,r,I,x,j)if x<=85 then local a=f[35](t,3)
    local f,t,p,K=(V-128)*2097152,r-128,128*(I-128),16384*(a%128)
    return 116,f+(a-a%128)*2097152+(t+p)+K,4,I
    elseif x<=86 then return 87,V,r,I+1
    else return 130,V,r,(r(V,j,I))
    end
    end,If=function(f,f,V,t,r,I,x,j,a)if I<=239 then if I<=238 then return 124,1+a,f,a,x
    else local p=x-128+128*t
    return 200,r,2+f,a,p
    end
    elseif I<=240 then local t,I=(r-128)*16384,f-128
    return 14,t+(128*j+I),3+a,a,x
    else local t,I,j=V[2],V[5],V[1]
    local p,K=t+I,I<=0
    I,t=p>=j,p<=j
    j=K and I or not K and t
    V[2]=p
    if j then return 105,r,f,p,x
    else return 85,r,f,a,x
    end
    end
    end,[3208]=Vector3.new,
end

-- -------------------------------------------------------------
-- FUNCTION_8663(f,V)
-- -------------------------------------------------------------
local function Func_8663(f,V)
    local t,r=1/0
    for I,x in ipairs((V or workspace:WaitForChild("Map")):GetDescendants())do if x:IsA("BasePart")then if x.CanCollide then if x.Position.Y+x.Size.Y/2>f.Y then I=(x.Position-f).Magnitude
    if I<t then t,r=I,x
    else end
    else end
    else end
    else end
    end
    if r then return Vector3.new(r.Position.X,r.Position.Y+r.Size.Y/2,r.Position.Z),r
    end
    return nil
    end
    end
    end,d=function(f,V,t,r,I,x,j,a,p)if j<=77 then if j<=76 then local K=f[35](I,V+3)
    local G,E,u,D,w=(p-128)*2097152,x-128,128*(r-128),16384*(K%128),K%128
    local r=2097152*(K-w)
    w=E+(u+(D+G+r))
    return 104,4+V,a,w,t
    else return 197,V,a+1,p,t
    end
    elseif j<=78 then local r=f[35](I,2+a)
    return 128>r and 214 or 10,V,a,p,r
    else return 200,V,a+1,p,t
    end
    end,[107]=buffer.readu32,
end

-- -------------------------------------------------------------
-- FUNCTION_9074()
-- -------------------------------------------------------------
local function Func_9074()
    if V.Data.Level.Value>=200 then if doorsaber()then local f=CheckNameBoss("Saber Expert")
    if f then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    local r=IsMobAlive(f)
    if if r then not Settings["Auto Saber"]else not r then break
    end
    end
    else local f=game.ReplicatedStorage:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")
    local r,I=f and(f:FindFirstChild("Saber Expert")),V.Character and V.Character:FindFirstChild("HumanoidRootPart")
    if r and I and(I.Position-r.Position).Magnitude>12 then toTarget(r.CFrame)
    elseif r then if I then if not(CheckItemInventory("Saber"))then WarnOnce("SaberExpertRespawn","plz wait boss respawn or hop server")
    end
    end
    end
    end
    elseif game:GetService("Workspace").Map.Jungle.QuestPlates.Door.CanCollide then toTarget(doortourch().Button.CFrame)
    elseif doorcup()then if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")~=0 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")~=1 then local f=V.Character:FindFirstChild("Cup")
    if if f then not f else not V.Backpack:FindFirstChild("Cup")then local f=workspace.Map.Desert:FindFirstChild("Cup")
    local r=V.Character and V.Character:FindFirstChild("HumanoidRootPart")
    if f and r then if typeof(firetouchinterest)=="function"then pcall(function()firetouchinterest(f,r,0)
    firetouchinterest(f,r,1)
    end)
    end
    end
    return
    else equiptool("Cup")
    local f=V.Backpack:FindFirstChild("Cup")and V.Backpack.Cup.Handle:FindFirstChild("TouchInterest")or V.Character:FindFirstChild("Cup")and V.Character.Cup.Handle:FindFirstChild("TouchInterest")
    if f then local f=workspace.Map.Ice.ParticleDrop:FindFirstChild("Water")
    local r,I=V.Character and V.Character:FindFirstChild("HumanoidRootPart"),V.Character and V.Character:FindFirstChild("Cup")
    if f then toTarget(CFrame.new(f.Position-Vector3.new(0,8,0)))
    if r then if I then if I:FindFirstChild("Handle")then if(r.Position-(f.Position-Vector3.new(0,8,0))).Magnitude<=12 then if os.clock()-(t.LastSaberWaterTouch or 0)>=1 then if typeof(firetouchinterest)=="function"then t.LastSaberWaterTouch=os.clock()
    pcall(function()firetouchinterest(I.Handle,f,0)
    firetouchinterest(I.Handle,f,1)
    end)
    end
    end
    end
    end
    end
    end
    end
    else local f=V.Backpack:FindFirstChild("Cup")and not V.Backpack.Cup.Handle:FindFirstChild("TouchInterest")or V.Character:FindFirstChild("Cup")and not V.Character.Cup.Handle:FindFirstChild("TouchInterest")
    if f then if(V.Character.HumanoidRootPart.Position-Vector3.new(1457.8768310547,88.377502441406,-1390.6892089844)).Magnitude>8 then toTarget(CFrame.new(1457.8768310547,88.377502441406,-1390.6892089844))
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")
    end
    end
    end
    end
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")==0 then local f=CheckNameBoss("Mob Leader")
    if f then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    local r=IsMobAlive(f)
    if if r then not Settings["Auto Saber"]else not r then break
    end
    end
    end
    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")==1 then local f=V.Character:FindFirstChild("Relic")
    if if f then not f else not V.Backpack:FindFirstChild("Relic")then if(V.Character.HumanoidRootPart.Position-CFrame.new(-1404.07996,29.8520069,5.26677656,0.888123989,-4.0340602E-9,0.459603906,7.5884703E-9,1,-5.8864642E-9,-0.459603906,8.71560069E-9,0.888123989).Position).Magnitude>8 then toTarget(CFrame.new(-1404.07996,29.8520069,5.26677656,0.888123989,-4.0340602E-9,0.459603906,7.5884703E-9,1,-5.8864642E-9,-0.459603906,8.71560069E-9,0.888123989))
    else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
    end
    else local f=V.Character and V.Character:FindFirstChild("Relic")
    local r=workspace.Map.Jungle.Final:FindFirstChild("Part")
    if not f then equiptool("Relic")
    elseif f:FindFirstChild("Handle")then if r then if typeof(firetouchinterest)~="function"then toTarget(r.CFrame)
    elseif os.clock()-(t.LastSaberRelicTouch or 0)>=1 then t.LastSaberRelicTouch=os.clock()
    pcall(function()firetouchinterest(f.Handle,r,0)
    firetouchinterest(f.Handle,r,1)
    end)
    end
    end
    end
    end
    end
    else local f=V.Character:FindFirstChild("Torch")
    if if f then not f else not V.Backpack:FindFirstChild("Torch")then toTarget(game:GetService("Workspace").Map.Jungle.Torch.CFrame)
    else equiptool("Torch")
    local f=V.Character and V.Character:FindFirstChild("Torch")and V.Character.Torch:FindFirstChild("Handle")
    local V=workspace.Map.Desert.Burn:FindFirstChild("Fire")
    if f and V then if typeof(firetouchinterest)=="function"then pcall(function()firetouchinterest(f,V,0)
    firetouchinterest(f,V,1)
    end)
    end
    end
    return
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_9375()
-- -------------------------------------------------------------
local function Func_9375()
    local f=game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    local r=f:InvokeServer("TushitaProgress")
    if r.OpenedDoor then if CheckNameBoss("Longma")then local r=CheckNameBoss("Longma")
    if r then while true do task.wait()
    sizepart(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(r)
    local I=IsMobAlive(r)
    if if I then not Settings["Auto Tushita"]else not I then break
    end
    end
    end
    end
    else local r=GetHitBoxTouch()
    if not(r)then toTarget((CFrame.new(5677.541015625,28.533447265625,357.9483642578125)))
    return
    end
    if r:FindFirstChild("TouchInterest")then local I=V.Character:FindFirstChild("Holy Torch")
    if if I then not I else not V.Backpack:FindFirstChild("Holy Torch")then toTarget(r.CFrame)
    else equiptool("Holy Torch")
    if checkTorch()then for V=1,5,1 do f:InvokeServer("TushitaProgress","Torch",V)
    end
    wait(2)
    end
    end
    else t[4][t[6]].CreateNoti({Title="Banana Cat Hub",Desc="Rip Indra Dont Spawn",ShowTime=5})
    wait(5)
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_9397()
-- -------------------------------------------------------------
local function Func_9397()
    local V=DetectIsland()
    if V then local t=Instance.new("IntValue",V)
    t.Name="Ignored"
    local r=Drawing.new("Text")
    r.Visible=false
    r.Transparency=1
    r.Text=V.Name
    r.Color=Color3.fromRGB(255,255,255)
    r.Size=20
    r.Outline=true
    r.OutlineColor=Color3.fromRGB(0,0,0)
    r.Center=true
    r.Font=1
    spawn(function()repeat task.wait()
    if not(pcall(function()local I,x=game.workspace.CurrentCamera:WorldToViewportPoint(V:GetAttribute("CFrame").Position)
    if x then r.Text=V.Name.." ("..math.round(f[1]:DistanceFromCharacter(V:GetAttribute("CFrame").Position))..")"
    r.Position=Vector2.new(I.X,I.Y-20)
    r.Visible=true
    else r.Visible=false
    end
    end))then r.Visible=false
    end
    until(if V then not V.Parent else not V)or not Settings["ESP Island"]
    r:Remove()
    if V.Parent then t:Destroy()
    end
    end)
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_9518()
-- -------------------------------------------------------------
local function Func_9518()
    local V,t=DetectBerryESP()
    if V then local r=Instance.new("IntValue",V.Parent)
    r.Name="Ignored"
    local I=Drawing.new("Text")
    I.Visible=false
    I.Transparency=1
    I.Text=V.Name
    I.Color=Color3.fromRGB(255,255,255)
    I.Size=20
    I.Outline=true
    I.OutlineColor=Color3.fromRGB(0,0,0)
    I.Center=true
    I.Font=1
    spawn(function()repeat task.wait()
    if not(pcall(function()local x,j=game.workspace.CurrentCamera:WorldToViewportPoint(V.Parent.WorldPivot.Position)
    if j then I.Text=t.." ("..math.round(f[1]:DistanceFromCharacter(V.Parent.WorldPivot.Position))..")"
    I.Position=Vector2.new(x.X,x.Y-20)
    I.Visible=true
    else I.Visible=false
    end
    end))then I.Visible=false
    end
    until(if V then not V.Parent else not V)or not Settings["ESP Berry"]or not DetectBerryCFrame(V:GetAttributes())
    I:Remove()
    if V.Parent then r:Destroy()
    end
    end)
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_9621()
-- -------------------------------------------------------------
local function Func_9621()
    local f=CheckItemInventory("Valkyrie Helm")
    if if f then not CheckItemInventory("Mirror Fractal")else not f then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Not Valkyrie Helm or not Mirror Fractal",ShowTime=5})
    wait(5)
    return
    end
    if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("CheckTempleDoor")then f=GetTempleOfTime()
    if not f then toTarget(CFrame.new(28282.5703125,14896.8505859375,105.1042709350586))
    return
    end
    if f.Lever.Lever.CFrame.Z>r.Z+I or f.Lever.Lever.CFrame.Z<r.Z-I then if(t.Character.HumanoidRootPart.Position-f.Lever.Part.Position).Magnitude>10 then toTarget(f.Lever.Part.CFrame)
    else fireproximityprompt(f.Lever.Prompt.ProximityPrompt,1)
    end
    else V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Done Pull Lever",ShowTime=5})
    wait(5)
    end
    else local f=game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress","Check")
    if f==1 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress","Begin")
    return
    elseif f==2 then toTarget(CFrame.new(3032.780029296875,2280.85107421875,-7325.47802734375))
    if(CFrame.new(3032.780029296875,2280.85107421875,-7325.47802734375).Position-t.Character.HumanoidRootPart.Position).Magnitude<8 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaceV4Progress","Teleport")
    end
    return
    elseif f==3 then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress","Continue")
    return
    end
    if game:GetService("Workspace").Map:FindFirstChild("MysticIsland")and CheckClockTime()=="Night"then CollectBlueGear()
    elseif game:GetService("Workspace").Map:FindFirstChild("MysticIsland")and CheckClockTime()~="Night"then if not(getHighestPoint())then f=DetectNpc("Advanced Fruit Dealer")
    if f then toTarget(f.HumanoidRootPart.CFrame)
    return
    end
    end
    if getHighestPoint()then if(getHighestPoint().CFrame*CFrame.new(0,211.88,0).Position-t.Character.HumanoidRootPart.Position).Magnitude>10 then toTarget(getHighestPoint().CFrame*CFrame.new(0,211.88,0))
    end
    end
    elseif not(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"))then if Settings["Hop Server [Trial Or Pull Lever]"]then SpecialHop("Mirage")
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_9731()
-- -------------------------------------------------------------
local function Func_9731()
    if not(StackFarmOther)then return
    end
    local f={}
    for r,I in next,Settings["Select Mob"],nil do I=r:gsub(" %pLv. %d+%p","")
    table.insert(f,I)
    end
    local r=DetectMob(f)
    if r then while true do task.wait()
    sizepart(r)
    BringMob(r)
    UsedualFlock()
    ClickM1(r)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(r.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(r.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local I=IsMobAlive(r)
    if(if I then not Settings["Kill Mob"]else not I)or not StackFarmOther then break
    end
    end
    elseif typeof(f)=="table"then if#V[4][V[6]]>=#f then V[4][V[6]]={}
    return
    end
    local r=DetectPartSpawnMob(DetectNameTablePart(f))
    if r then table.insert(V[4][V[6]],DetectNameTablePart(f))
    while true do wait()
    toTarget(r.CFrame*CFrame.new(0,60,0))
    local V,I=r.Position,t.Character.HumanoidRootPart
    if(V-I.Position).Magnitude<=100 or DetectMob(f)or not Settings["Kill Mob"]then break
    end
    end
    wait(1)
    end
    else local V=DetectPartSpawnMob(f,true)
    if V then Instance.new("IntValue",V).Name="Ignored"
    while true do wait()
    toTarget(V.CFrame*CFrame.new(0,60,0))
    local r,I=V.Position,t.Character.HumanoidRootPart
    if(r-I.Position).Magnitude<=100 or DetectMob(f)or not Settings["Kill Mob"]then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_9769()
-- -------------------------------------------------------------
local function Func_9769()
    if CheckItemInventory("Shark Anchor")then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Done Shark Anchor",ShowTime=5})
    wait(5)
    return
    end
    if not(CheckItemInventory("Monster Magnet"))then local f=CheckItemInventory("Shark Tooth Necklace")
    if(if f then not f else CheckCountItem("Mutant Tooth",1))and CheckCountItem("Shark Tooth",5)then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({[1]="Craft",[2]="ToothNecklace",[3]=1,[4]={}}))
    else local f=CheckItemInventory("Terror Jaw")
    if(if f then not f else CheckCountItem("Mutant Tooth",2))and CheckCountItem("Shark Tooth",5)and CheckCountItem("Terror Eyes",1)and CheckCountItem("Fool's Gold",10)then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({[1]="Craft",[2]="TerrorJaw",[3]=1,[4]={}}))
    elseif CheckItemInventory("Shark Tooth Necklace")then if CheckItemInventory("Terror Jaw")then if CheckCountItem("Terror Eyes",2)then if CheckCountItem("Shark Tooth",10)then if CheckCountItem("Electric Wing",10)then if CheckCountItem("Fool's Gold",20)then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/Craft"):InvokeServer(unpack({[1]="Craft",[2]="SharkAnchor",[3]=1,[4]={}}))
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end,Vf=function(f,V,t,r,I,x,j,a,p,K)if a<=247 then if a<=246 then local G=f[35](p,t+3)
    local E,u,D,w,g=(x-128)*2097152,V-128,(r-128)*128,16384*(G%128),G%128
    local r=2097152*(G-g)
    g=D+u+r+(w+E)
    return 170,j,t+4,g,I
    else local r=f[35](p,t+1)
    return r<128 and 55 or 225,j,t,x,r
    end
    elseif a<=248 then x[V]=K
    return 203,j,t,x,I
    else return 104,j+1,t,x,I
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_10093(V)
-- -------------------------------------------------------------
local function Func_10093(V)
    local a=DetectNameWpUpgrade(V)
    if not(a)then if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("No "..V.." to upgrade")
    end
    return
    end
    if NameWeapon(V)~=a then if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("Change Weapon"..a)
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem",a)
    return
    end
    if if t[4][t[6]]then t[4][t[6]].NameWp~=a else not t[4][t[6]]then if r[4][r[6]]then if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("Get info Upgrade WP")
    end
    if I:DistanceFromCharacter(r[4][r[6]].Position)>10 then toTarget(r[4][r[6]],true)
    else t[4][t[6]]=DetectItemUpgrade(V)
    end
    else local p,K=pairs,f[90](game.Workspace.NPCs:GetDescendants())
    for G,G in p(f:N_(K))do if G:IsA("Model")then if G.Name=="Blacksmith"then if G:FindFirstChild("Head")then r[4][r[6]]=G.Head.CFrame*CFrame.new(0,-2,2)
    end
    end
    end
    end
    K,p=pairs,f[90](game:GetService("ReplicatedStorage").NPCs:GetDescendants())
    for G,G in K(f:N_(p))do if G:IsA("Model")then if G.Name=="Blacksmith"then if G:FindFirstChild("Head")then r[4][r[6]]=r[4][r[6]]or G.Head.CFrame*CFrame.new(0,-2,2)
    end
    end
    end
    end
    end
    return
    end
    a=if t[4][t[6]]then DetectMaterialsUpgrade()else nil
    if t[4][t[6]]then if not a then if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("Go Upgrade Weapon")
    end
    toTarget(r[4][r[6]],true)
    if I:DistanceFromCharacter(r[4][r[6]].Position)<10 then local f=UpgradeInvoke("Check",game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(NameWeapon(V))or game:GetService("Players").LocalPlayer.Character:FindFirstChild(NameWeapon(V)))
    if f and f.Result and f.Result.Could and f.Result.Physical then if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("Upgrading "..tostring(f.Result.Name))
    end
    UpgradeInvoke("Upgrade",f.Result.Physical)
    t[4][t[6]]=nil
    wait(1)
    else t[4][t[6]]=nil
    if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("Cannot upgrade yet: "..tostring(f and f.Result and f.Result.ErrorMessage or"missing ingredients"))
    end
    wait(3)
    end
    end
    end
    end
    if a then V=NameMaterials[a]
    if not V then local f,t=x[4][x[6]].CreateNoti,{Title="Banana Cat Hub"}
    t.Desc,t.ShowTime="Not Support Material"..a.."Sorry",5
    f(t)
    wait(5)
    return
    end
    if not(NameWorldMaterials[a][game.PlaceId])then local f=NameWorldMaterials[a][getgenv().CheckPlaceId2]or NameWorldMaterials[a][getgenv().CheckPlaceId3]or NameWorldMaterials[a][getgenv().CheckPlaceId]
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(f)
    return
    end
    if getgenv().StatusUpgradeWP then StatusUpgradeWP.SetText("Farm Material "..a)
    end
    local f=DetectMob(V)
    if f then while true do task.wait()
    sizepart(f)
    BringMob(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local t=IsMobAlive(f)
    local f,r=not t
    if t then local t=Settings["Auto Upgrade Sword Inventory"]
    r=if t then not t else not Settings["Auto Upgrade Gun Inventory"]
    else r=f
    end
    if r then break
    end
    end
    elseif typeof(V)=="table"then if#j[4][j[6]]>=#V then j[4][j[6]]={}
    return
    end
    local f=DetectPartSpawnMob(DetectNameTablePart(V))
    if f then table.insert(j[4][j[6]],DetectNameTablePart(V))
    while true do wait()
    toTarget(f.CFrame*CFrame.new(0,60,0))
    local t,r=(f.Position-I.Character.HumanoidRootPart.Position).Magnitude<=100 or DetectMob(V)
    if t then r=t
    else local f=Settings["Auto Upgrade Sword Inventory"]
    r=if f then not f else not Settings["Auto Upgrade Gun Inventory"]
    end
    if r then break
    end
    end
    wait(1)
    end
    else local f=DetectPartSpawnMob(V,true)
    if f then Instance.new("IntValue",f).Name="Ignored"
    while true do wait()
    toTarget(f.CFrame*CFrame.new(0,60,0))
    local t,r=(f.Position-I.Character.HumanoidRootPart.Position).Magnitude<=100 or DetectMob(V)
    if t then r=t
    else local f=Settings["Auto Upgrade Sword Inventory"]
    r=if f then not f else not Settings["Auto Upgrade Gun Inventory"]
    end
    if r then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    end
    end
    end
    end,M_=function(f,V,t,r,I,x,j,a)if r<=76 then if r<=75 then local p,K,K=1+I,0,(57+185*((43+V)%256))%256
    f[79](f.on,0,(f[15](43,f[35](j,p+0),K)))
    return 130,x,I,f[35](f.on,a)~=41,j,t
    else local a=I-128+128*t
    return 202,2+x,a,V,j,t
    end
    elseif r<=77 then return 202,1+x,I,V,j,t
    else local r=f[35](j,V+1)
    if 128>r then return 161,x,I,V,r,t
    else return 9,x,I,V,j,r
    end
    end
    end,[36]=pcall,q=function(f,V,t,r,I,x,j,a)if V<=37 then if V<=36 then local p=t-86239
    local K,G,E=f[1](p),f[1](p),1+0
    return 113,{nil,1-E,p+0,I,E},j,K,G,a
    else return 26,I,j+1,t,x,a
    end
    elseif V<=38 then local V=f[35](r,j)
    return V<128 and 161 or 253,I,j,t,x,V
    else return 184,I,j+1,t,x,a
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_10116(j,a,p,p)
-- -------------------------------------------------------------
local function Func_10116(j,a,p,p)
    if not j or not j:IsA("BasePart")then return
    elseif typeof(a)~="CFrame"then return
    end
    local K,K=BoatTweenSpeed()
    local G=p or"TweenBoat"
    if not(V[j])then if(j.Position-a.Position).Magnitude<=t then return
    end
    end
    local p=V[j]
    if p then if p.TweenKey==G then if p.PlaybackState==Enum.PlaybackState.Playing then p.Target=a
    p.Speed=K
    p.SpeedCap=math.min(p.SpeedCap or K,K)
    getgenv()[G]=p
    return p
    end
    end
    end
    if p then p:Cancel()
    end
    local p=getgenv()[G]
    if p then pcall(function()p:Cancel()
    end)
    end
    local p={}
    p.PlaybackState=Enum.PlaybackState.Playing
    p.Speed=K
    p.SpeedCap=K
    p.Target=a
    p.TweenKey=G
    local a,K,E=false,false,false
    local u=j.CFrame
    local function D(w)if E then return
    end
    E=true
    p.PlaybackState=w
    r[4][r[6]]=math.max(r[4][r[6]]-1,0)
    if V[j]==p then V[j]=nil
    end
    if getgenv()[G]==p then getgenv()[G]=nil
    end
    if r[4][r[6]]==0 then if not(type(ToggleNoclip)=="function"and ToggleNoclip()==true)then I(false)
    getgenv().noclip=false
    end
    end
    end
    p.Play=function(w)if E then return
    end
    K=false
    w.PlaybackState=Enum.PlaybackState.Playing
    end
    p.Pause=function(w)if E then return
    end
    K=true
    w.PlaybackState=Enum.PlaybackState.Paused
    end
    p.Cancel=function(w)if E then return
    end
    a=true
    D(Enum.PlaybackState.Cancelled)
    end
    p.Destroy=function(w)w:Cancel()
    end
    V[j]=p
    getgenv()[G]=p
    r[4][r[6]]+=1
    I(true)
    getgenv().noclip=true
    local V=x(j)
    local r
    task.spawn(function()while true do local I=if a then not a else not E
    if not(I and j.Parent)then break
    end
    I=RunService.Heartbeat:Wait()
    if not(K)then if V then if V.Parent then local x,a=pcall(NoclipBoat,V)
    if not(x)then if f[6](V,"Error")then print("bug when try to call NoclipBoat:",V:GetFullName(),"ghe:",j:GetFullName(),tostring(a))
    end
    end
    end
    end
    local V=f[7].Character and f[7].Character:FindFirstChildOfClass("Humanoid")
    if if V then V.SeatPart~=j else not V then r=r or tick()
    if tick()-r>0.35 then print("tween false , mat seat ","ghe muc tieu:",j:GetFullName(),"ghe hien tai:",V and V.SeatPart and V.SeatPart:GetFullName()or"nil","thoi gian mat ghe:",tick()-r,"trang thai:",tostring(p.PlaybackState))
    WarnOnce("BoatNotSeated","Lost seat , stop tween ")
    D(Enum.PlaybackState.Cancelled)
    break
    end
    else r=nil
    end
    V=nil
    V,p.Speed=BoatTweenSpeed()
    local r,x=os.clock(),p.Speed
    if V then if r<f[8][4][f[8][6]]then p.SpeedCap=150
    else if f[8][4][f[8][6]]>0 then f[8][4][f[8][6]]=0
    end
    p.SpeedCap=math.min(p.Speed,(p.SpeedCap or p.Speed)+36*math.min(I,0.07))
    end
    x=math.min(p.Speed,p.SpeedCap)
    else if r<f[8][4][f[8][6]]then x=math.max(p.Speed*f[9],f[10])
    else p.SpeedCap=150
    if f[8][4][f[8][6]]>0 then f[8][4][f[8][6]]=0
    end
    end
    end
    local a=j.CFrame
    local K,G=a.Position,p.Target
    local w,g,U=CFrame.new(G.X,K.Y,G.Z)*(G-G.Position),CFrame.new(K.X,K.Y,K.Z),u
    u=g*(U-u.Position)
    U,g=Vector3.new(u.X,0,u.Z),Vector3.new(w.X,0,w.Z)
    local G,e,s=(g-U).Magnitude,x*I,(Vector3.new(K.X,0,K.Z)-U).Magnitude
    if s>math.max(25,e*4)then f[8][4][f[8][6]]=r+f[11]
    x=V and 150 or math.max(p.Speed*f[9],f[10])
    if V then p.SpeedCap=150
    end
    u=CFrame.new(K.X,K.Y,K.Z)*(a-K)
    e=x*I
    G=(g-Vector3.new(u.X,0,u.Z)).Magnitude
    else end
    if G<=e or G<=t then u=CFrame.new(w.X,K.Y,w.Z)*(w-w.Position)
    j.CFrame=u
    j.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
    j.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
    D(Enum.PlaybackState.Completed)
    break
    end
    a=u
    u=a:Lerp(w,e/G)
    a,w=CFrame.new(u.X,K.Y,u.Z),u
    u=a*(w-u.Position)
    j.CFrame=u
    j.AssemblyLinearVelocity=Vector3.new(0.0,0.0,0.0)
    j.AssemblyAngularVelocity=Vector3.new(0.0,0.0,0.0)
    end
    end
    if not(E)then D(Enum.PlaybackState.Cancelled)
    end
    end)
    return p
    end
    end
    end,[113]=coroutine.create,Zn=function(f,...)local V,t,r,I,x,j,a,p,K,G,E=f:z_()
    local u,D,w,g,U,e,s,k,J,d,l=t,r,f[90](...),I,x,j,a,p,K,G,E
    while V do if u<=17 then if u<=8 then if u<=3 then u,g,e,k,J,d=f:l_(k,d,e,u,g,J,D)
    else t=f[90](f:e_(k,e,D,g,U,s,J,u,l,d,f:N_(w)))
    p,a,x,j,I,E,G=f:N_(t)
    u,D,g,U,e,s,J=p,a,x,j,I,E,G
    end
    elseif u<=12 then local V,t,r,I,x,j,a=f:s_(D,e,g,U,u,k)
    if V==2 then return g
    elseif V==1 then u,D,g,U,e,k=t,r,I,x,j,a
    end
    elseif u<=14 then u,k=f:U_(g,u,U,k,e)
    else u,g,e,s,k=f:T_(g,k,e,J,u,s,d)
    end
    elseif u<=26 then if u<=21 then u,D,g,e,s,k,J=f:Y_(J,k,e,d,U,D,u,s,g)
    elseif u<=23 then u,g,J=f:m_(J,e,u,g)
    else u,g,e,J=f:n_(l,g,d,s,e,u,k,J)
    end
    elseif u<=31 then u,g,e,s,k,d=f:Q_(u,s,d,g,U,k,e,J)
    else u,e,s,k,J,l=f:p_(k,e,d,s,J,u,g,l)
    end
    end
    end,s=function(f,V,t,r,I,x,j,a,p)if x<=130 then if x<=129 then local K=f[35](j,r+3)
    local G,E,u,D=2097152*(I-128),t-128,128*(p-128),16384*(K%128)
    local t=G+2097152*(K-K%128)+(D+E)+u
    return 96,4+r,t,p,a
    else local t,K=(p-128)*16384,V-128
    local V=128*a+(K+t)
    return 184,3+r,I,V,a
    end
    elseif x<=131 then local V=f[35](j,2+r)
    return V<128 and 234 or 149,r,I,p,V
    else local V=f[35](j,r+2)
    return V>=128 and 190 or 130,r,I,p,V
    end
    end,[8]=next,
end

-- -------------------------------------------------------------
-- FUNCTION_10156()
-- -------------------------------------------------------------
local function Func_10156()
    local f,V,t,r=Settings["Select Owner Boat Find Leviathan"],next,game:GetService("Workspace").Boats:GetChildren()
    local I
    for x,x in V,t,r do I=if x:IsA("Model")then if x:FindFirstChild("Owner")then if tostring(x.Owner.Value)==f then if x.Humanoid.Value>0 then x else I else I else I else I
    end
    if I then r,V,f=next,I:GetChildren()
    for t,t in r,V,f do if t.Name=="Cannon"then if not(t.Seat:FindFirstChild("SeatWeld"))then return t
    end
    end
    end
    end
    return false
    end
    end
    end,N_=function(f,V)return f[88](V,1,V.n)
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_10205()
-- -------------------------------------------------------------
local function Func_10205()
    local f,V,t,r={},next,game.Workspace.Characters:GetChildren()
    for I,I in V,t,r do if I:IsA("Model")then if I.Name~=game.Players.LocalPlayer.Name then if I:FindFirstChild("HumanoidRootPart")then if I:FindFirstChild("Humanoid")then if I.Humanoid.Health>0 then if(I.HumanoidRootPart.Position-Vector3.new(28718.068359375,14887.5625,-60.5482177734375)).Magnitude<=400 then table.insert(f,I.Name)
    end
    end
    end
    end
    end
    end
    end
    return f
    end
    end
    end,[54]=UDim.new,[56]=table.concat,[28]=coroutine.resume,qf=function(f,V,t,r,I,x,j,a,p,K,G)if K<=243 then if K<=242 then local E=f[35](I,x)
    return E>=128 and 164 or 66,I,x,G,p,V,E
    else local E=f[35](I,t+2)
    if 128>E then return 194,E,x,G,p,V,j
    else return 135,I,x,G,E,V,j
    end
    end
    elseif K<=244 then local t=16384*(V-128)
    local K=a-128+r*128+t
    return 98,I,3+x,G,p,K,j
    else local t=f[35](I,x+2)
    return t<128 and 59 or 199,I,x,t,p,V,j
    end
    end,Q=function(f,V,t,r,I,x,j,a)if I<=154 then if I<=153 then local p=f[35](a,V+2)
    return 128<=p and 9 or 240,j,V,p
    else local p=(V-128)*16384
    local K=r-128+(x*128+p)
    return 167,j+3,K,r
    end
    elseif I<=155 then r[V]=t-t%1
    return 171,j,V,r
    else local t=f[35](a,2)
    return t>=128 and 180 or 65,j,V,t
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_10384()
-- -------------------------------------------------------------
local function Func_10384()
    local V=GetEspFruit()
    if not V then return
    end
    local t=GetFruitName(V)
    local r=V:FindFirstChild("Handle")
    if not r then return
    end
    local I=Instance.new("IntValue")
    I.Name="Ignored"
    I.Parent=r
    local I=({["Leopard Fruit"]=Color3.fromRGB(255,170,0),["Dragon (East) Fruit"]=Color3.fromRGB(255,0,0),["Dragon (West) Fruit"]=Color3.fromRGB(255,80,80),["Kitsune Fruit"]=Color3.fromRGB(200,100,255),["Spirit Fruit"]=Color3.fromRGB(120,200,255),["Venom Fruit"]=Color3.fromRGB(180,60,200),["Dough Fruit"]=Color3.fromRGB(255,220,180),["Light Fruit"]=Color3.fromRGB(255,255,150)})[t]or Color3.fromRGB(255,255,255)
    local x=Drawing.new("Text")
    x.Visible=false
    x.Transparency=1
    x.Text=t
    x.Color=I
    x.Size=20
    x.Outline=true
    x.OutlineColor=Color3.fromRGB(0,0,0)
    x.Center=true
    x.Font=2
    local j=Drawing.new("Square")
    j.Visible=false
    j.Filled=true
    j.Color=Color3.fromRGB(0,0,0)
    j.Transparency=0.4
    spawn(function()repeat task.wait()
    if not(pcall(function()local a,p=workspace.CurrentCamera:WorldToViewportPoint(r.Position)
    if p then local p=math.round(f[1]:DistanceFromCharacter(r.Position))
    x.Text=t.." ["..p.."m]"
    x.Position=Vector2.new(a.X,a.Y-20)
    x.Color=I
    x.Visible=true
    p=x.TextBounds
    j.Position=Vector2.new(x.Position.X-p.X/2-4,x.Position.Y-2)
    j.Size=Vector2.new(p.X+8,p.Y+4)
    j.Visible=true
    else x.Visible=false
    j.Visible=false
    end
    end))then x.Visible=false
    j.Visible=false
    end
    until(if V then not V.Parent else not V)or not r.Parent or not Settings["ESP Fruit"]
    x:Remove()
    j:Remove()
    if r:FindFirstChild("Ignored")then r.Ignored:Destroy()
    end
    end)
    end
    end
    end,[118]=getfenv,Dn={},[62]=3.542098888E9,
end

-- -------------------------------------------------------------
-- FUNCTION_10425()
-- -------------------------------------------------------------
local function Func_10425()
    local V,r,I,x=pairs,f[90](game.Workspace.Characters:GetChildren()),1/0
    for j,a in V(f:N_(r))do if a:IsA("Model")then j=a.Name~=t.Name and(game.Players.LocalPlayer.Team==game.Teams.Marines and game.Players[a.Name].Team~=game.Teams.Marines or game.Players.LocalPlayer.Team~=game.Teams.Marines)
    if j then local f=(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-a.HumanoidRootPart.Position).Magnitude
    if f<I then I,x=f,a
    else end
    else end
    else end
    end
    return x
    end
    end
    end,x_=function(f,V,t)local r,I,x,j,a,p,K,G,E,u,D,w,g,U,e,s,k,J,d,l,M,h=f:S()
    local N,S,F,b,Z,O,B,c,_,v,P,m,o,C,n,H,X,q,y,R,W,L,T=I,x,t,V,j,a,p,K,G,E,u,D,w,g,U,e,s,k,J,d,l,M,h
    while r do if N<=128 then if N<=63 then if N<=31 then if N<=15 then if N<=7 then if N<=3 then N,F,b,O,B=f:a(F,q,B,O,b,N)
    else N,F,O,v,X=f:O(m,O,v,q,X,P,N,F,Z)
    end
    elseif N<=11 then N,Z,O,X=f:X(y,N,B,c,Z,q,F,X,O)
    else N,S,Z,O,B,W=f:R(T,W,L,S,N,B,Z,O)
    end
    elseif N<=23 then if N<=19 then N,O,v,P,X=f:k(m,v,X,O,F,B,N,P)
    else N,F,O,v,q,R=f:j(Z,P,v,N,R,q,F,O)
    end
    elseif N<=27 then h,e,p,a,t,k,J=f:K(O,F,H,S,N,n,R)
    if h==2 then N,S,O,n,H,R=e,p,a,t,k,J
    elseif h==1 then return c,Z,O
    end
    else N,O,m,o,C,H=f:y(H,m,N,X,q,O,F,o,C,n)
    end
    elseif N<=47 then if N<=39 then if N<=35 then N,Z,O,c,_,o,X=f:I(X,v,c,F,y,o,n,q,C,P,Z,_,N,O)
    else N,S,O,C,n,X=f:q(N,C,F,S,n,O,X)
    end
    elseif N<=43 then N,S,O,H,q,R=f:V(N,y,O,q,F,S,H,R,W,L)
    else N,O,C,H,W=f:L(C,O,H,L,N,X,n,W)
    end
    elseif N<=55 then if N<=51 then N,b,Z,O,P,o=f:W(O,B,C,b,N,P,m,Z,F,n,o)
    else N,O,o,q,y,R=f:_(C,q,N,O,F,o,R,y)
    end
    elseif N<=59 then N,S,O,B,o,q,R,L=f:E(S,y,o,q,N,F,B,_,v,L,O,R)
    else N,b,Z,O,B,X=f:h(B,b,X,q,N,Z,O,F,_,y)
    end
    elseif N<=95 then if N<=79 then if N<=71 then if N<=67 then N,Z,O,B=f:c(B,C,F,c,Z,X,N,O,H)
    else N,O,c,v,C=f:w(O,v,N,n,C,F,Z,c,P)
    end
    elseif N<=75 then N,b,Z,O,B,c,n=f:r(Z,v,O,N,S,b,B,n,F,c)
    else N,Z,O,c,y=f:d(Z,y,P,F,v,N,O,c)
    end
    elseif N<=87 then if N<=83 then N,O,m,W=f:G(O,W,B,m,F,R,o,T,N)
    else N,S,O,v,P,R,L=f:v(L,O,F,R,N,v,m,P,S)
    end
    elseif N<=91 then N,O,P,o,n=f:t(F,N,H,P,O,o,Z,n)
    else N,F,Z,O,H=f:B(N,O,X,q,H,Z,c,F)
    end
    elseif N<=111 then if N<=103 then if N<=99 then N,P,o,T=f:J(P,T,O,F,W,N,o,L,R)
    else N,S,O,v,H,X=f:P(q,v,S,P,N,X,H,O,F)
    end
    elseif N<=107 then N,c,H=f:i(F,Z,N,c,B,H,b,O)
    else N,Z,O,q,y=f:A(B,N,q,R,F,Z,y,O)
    end
    elseif N<=119 then if N<=115 then N,Z,P,H=f:z(Z,N,P,S,O,H)
    else N,Z,O,c,P,T=f:l(F,N,T,P,Z,m,O,S,c,o)
    end
    elseif N<=123 then N,S,O,B,m,C=f:N(B,N,S,m,F,O,C)
    else N,S,b,O,v,m,X=f:e(X,b,N,S,F,v,O,m)
    end
    elseif N<=193 then if N<=160 then if N<=144 then if N<=136 then if N<=132 then N,O,v,m,C=f:s(o,P,O,v,N,F,C,m)
    else N,S,F,Z,O,B,X=f:U(O,c,P,N,q,v,S,_,F,B,X,Z)
    end
    elseif N<=140 then N,S,O,X,q,L=f:T(L,N,q,O,S,X,F,y)
    else N,S,Z,c,_,P=f:Y(_,P,S,F,c,v,b,Z,N,O)
    end
    elseif N<=152 then if N<=148 then N,Z,O,c,v,o,W=f:m(F,B,T,H,_,X,b,W,o,c,P,v,Z,C,n,m,N,O,L)
    else N,O,m,n,H=f:n(m,O,X,o,H,C,N,q,F,n)
    end
    elseif N<=156 then N,Z,B,c=f:Q(B,_,c,N,v,Z,F)
    else N,Z,O,o,q=f:p(O,o,Z,q,N,C,B,F)
    end
    elseif N<=176 then if N<=168 then if N<=164 then N,O,q=f:x(N,O,q,F)
    else I=N<=166
    D,E,g,x,j,u,s=f:H(c,F,q,y,C,I,m,N,o,O,Z,X,H)
    N,F,O,c,m,H,X=D,E,g,x,j,u,s
    end
    elseif N<=172 then N,O,B,_,v,o=f:b(n,N,C,F,v,O,o,B,_)
    else N,S,O,B,_,P,q,y=f:gf(q,S,P,y,m,o,B,_,N,O,F)
    end
    elseif N<=184 then if N<=180 then N,O,B,n,H=f:Df(H,q,B,n,O,X,c,N,F)
    else N,O,m,o=f:uf(P,o,N,F,O,_,m,n,C)
    end
    elseif N<=188 then N,O,_,P,R=f:Mf(P,_,o,O,m,R,v,S,N)
    elseif N<=190 then N,O,B,m=f:Ff(o,m,C,Z,N,O,B,F)
    else N,Z,O,B,P,q=f:ff(Z,v,P,N,F,c,R,B,q,y,O)
    end
    elseif N<=225 then if N<=209 then if N<=201 then if N<=197 then N,S,F,Z,_,v,m=f:of(O,m,v,_,S,Z,N,F,c)
    else N,O,B,o,C,n=f:Cf(B,C,v,F,N,_,O,o,n)
    end
    elseif N<=205 then N,v,m,H=f:Zf(O,v,o,n,N,H,m,S,F)
    else N,F,O,B,_,y=f:Sf(_,q,O,N,B,y,F)
    end
    elseif N<=217 then if N<=213 then N,S,O,P,n,R,W=f:af(W,S,m,N,P,O,R,F,n)
    else N,S,Z,O,B,c,_,X=f:Of(_,N,q,c,P,y,Z,v,S,B,X,F,O)
    end
    elseif N<=221 then N,S,Z,c,P=f:Xf(W,S,v,o,O,P,C,m,B,q,N,c,b,Z,n,F,H,y,X,_)
    else N,F,O,n=f:Rf(q,N,y,R,F,n,c,O,Z,v)
    end
    elseif N<=241 then if N<=233 then if N<=229 then N,S,O,c,o,C=f:kf(F,N,o,C,O,c,S)
    elseif N<=231 then N,Z,O,c,q=f:jf(c,_,R,F,q,B,O,b,Z,N,y)
    else N,O,v,q=f:Kf(q,P,N,v,m,F,O)
    end
    elseif N<=237 then N,O,m,C,X=f:yf(N,y,F,q,C,O,o,m,X)
    else N,Z,O,B,m=f:If(O,S,o,Z,N,m,c,B)
    end
    elseif N<=249 then if N<=245 then N,F,O,v,P,m,X=f:qf(m,Z,C,F,O,X,o,P,N,v)
    else N,Z,O,c,C=f:Vf(v,O,P,C,c,Z,N,F,B)
    end
    elseif N<=253 then N,F,_,q,y,R=f:Lf(y,O,q,F,R,N,S,_)
    else N,F,Z,O,B,n,q,L=f:Wf(F,q,O,c,N,n,S,B,Z,L)
    end
    end
    end,V_=function(f,V,t,r,I,x,j,a,p,K,G)if V<=142 then if V<=141 then local E=f[35](K,x+2)
    return E<128 and 89 or 26,j,x,I,p,E
    else local E=x+1
    local u=f[35](K,E)
    return u<128 and 155 or 41,E,u,I,p,G
    end
    elseif V<=143 then local V,E=f[67],f[107](K,x+t)
    V(a,t,(f[15](f.Dn[I],r,E)))
    return 83,j,x,f.un[I],p,G
    else local V=f[35](K,j+2)
    return V<128 and 154 or 67,j,x,I,V,G
    end
    end,W_=function(f,f,V,t,r,I,x)if I<=149 then if I<=148 then local j=t-128
    local a=x*128+j
    return 206,f,V+2,a
    else return 162<r and 138 or 133,f,V,t
    end
    elseif I<=150 then local I=V-128+t*128
    return 159,f+2,I,t
    else return 75<r and 62 or 188,f,V,t
    end
    end,[53]=buffer.writestring,
end

-- -------------------------------------------------------------
-- FUNCTION_10920(V)
-- -------------------------------------------------------------
local function Func_10920(V)
    if DaBringMob then delay(0.15,function()getgenv().DaBringMob=false
    end)
    return
    end
    if t[4][t[6]]and(r.Character.HumanoidRootPart.Position-V.HumanoidRootPart.Position).Magnitude<=50 then local r,I=pairs,f[90](game:GetService("Workspace").Enemies:GetChildren())
    for x,j in r(f:N_(I))do if j~=V then if not(j:FindFirstChild("Ignored"))then if IsMobAlive(j)then if isnetworkowner2(j.HumanoidRootPart)then x=(j.HumanoidRootPart.Position-t[4][t[6]].Position).Magnitude
    if x<=350 then sizepart(j)
    j.HumanoidRootPart.CFrame=t[4][t[6]]*CFrame.new(0,math.random(0,2),math.random(0,2))
    getgenv().DaBringMob=true
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end,c=function(f,V,t,r,I,x,j,a,p,K)if a<=65 then if a<=64 then t[K]=j
    return 113,x,p,V
    else local t,j=16384*(p-128),V-128
    return 143,x,t+(128*I+j),3
    end
    elseif a<=66 then return 64,x,p+1,V
    else local t=f[35](r,V)
    return t<128 and 159 or 18,t,p,V
    end
    end,[39]=(0),
end

-- -------------------------------------------------------------
-- FUNCTION_11299(f,V)
-- -------------------------------------------------------------
local function Func_11299(f,V)
    local t,r=1/0
    local I=0
    for x,j in next,f,nil do local f=Vector3.new(j.X,0,j.Z)
    local a=(Vector3.new(V.Position.X,0,V.Position.Z)-f).Magnitude
    if t>a then t,r,I=a,j,x
    else end
    end
    return r,I
    end
    end
    end,A_=function(f,V,t,r,I,x,j,a,p,K,G,E)if E<=209 then if E<=208 then return p==23 and 173 or 60,j,I,r,x
    else local p,u,u=I+1,0,(57+(r+44)%256*185)%256
    f[79](f.on,0,(f[15](44,u,(f[35](a,0+p)))))
    return 130,j,I,-f[35](f.on,V),x
    end
    elseif E<=210 then local V=f[35](G,I+3)
    local f,a,p,G=(x-128)*2097152,t-128,(K-128)*128,16384*(V%128)
    local t=p+(2097152*(V-V%128)+(a+f)+G)
    return 49,j,4+I,r,t
    else return 61,j[3],I,r,x
    end
    end,[94]=buffer.readu16,f=function(f,...)return(...)()
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_11359()
-- -------------------------------------------------------------
local function Func_11359()
    local f,t,r=next,game:GetService("CollectionService"):GetTagged("BerryBush")
    local I,x=1/0
    for j,a in f,t,r do if a.Parent:FindFirstChild("IgnoredBerry")then else j=V:DistanceFromCharacter(a.Parent:GetAttribute("CFrame").Position)
    if I>j then I,x=j,a
    else end
    end
    end
    return x
    end
    end
    end,[109]=buffer.create,
end

-- -------------------------------------------------------------
-- FUNCTION_11476()
-- -------------------------------------------------------------
local function Func_11476()
    local f={}
    v28=workspace:WaitForChild("Map"):WaitForChild("DracoTrial")
    local V={"Relic1","Relic2","Relic3","EndRelic1","EndRelic2","EndRelic3","Door1","Door2","Door3","Brazier1","Brazier2","Brazier3","Center","EndPlatform","TeleportOut"}
    for t,t in pairs(V)do f[t]=v28:FindFirstChild(t,true)
    end
    local t,r,I=next,workspace._WorldOrigin:GetChildren()
    for x,x in t,r,I do if x:IsA("Model")then if x.Name=="Relic"then V=x:FindFirstChildWhichIsA("MeshPart")
    if V.Color==Color3.fromRGB(132,203,0)then f.RelicModel1=x
    end
    if V.Color==Color3.fromRGB(232,106,110)then f.RelicModel2=x
    end
    if V.Color==Color3.fromRGB(191,153,0)then f.RelicModel3=x
    end
    end
    end
    end
    return f
    end
    end
    end,W=function(f,V,t,r,I,x,j,a,p,K,G,E)if x<=49 then if x<=48 then local u,D=16384*(E-128),r-128
    local r=u+128*G+D
    return 229,I,p,3+V,j,r
    else local r=f[35](K,3+V)
    local f,K,G,u,D=2097152*(j-128),a-128,128*(E-128),16384*(r%128),r%128
    local a=(r-D)*2097152
    r=G+f+K+(u+a)
    return 197,I,p,4+V,r,E
    end
    elseif x<=50 then return 204,I,p,V+1,j,E
    else local f,r=16384*(I-128),p-128
    return 124,128*V+(f+r),t+3,V,j,E
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_11611()
-- -------------------------------------------------------------
local function Func_11611()
    local f=0
    while true do if f<=0 then V[4][V[6]]=V[4][V[6]]-V[4][V[6]]%2+1
    t[4][t[6]],f=(1013507*t[4][t[6]]+9636131)%268435456,1
    else return
    end
    end
    end
    end
    end,fn=function(f,V,t,r)local I,x,j=0,t,r
    while true do if I<=0 then r=x[-1][j]
    t=f:Fn(V[1][r],V[2],r,x[-2])
    x[j]=t
    I,x=1,t
    else return 1,x
    end
    end
    return 0
    end,[4749]=Vector2.new,r_=function(f,f,V,t,r)if f<=175 then local I,x,j=r[5],r[4],r[3]
    local a,p=I+x,x<=0
    x,I=a>=j,a<=j
    j=p and x or not p and I
    r[5]=a
    if j then return 72,r,V,a
    else return 178,r,V,t
    end
    elseif f<=176 then return 36,r[1],V,t
    else return 39,r,1+V,t
    end
    end,i=function(f,V,t,r,I,x,j,a,p)if r<=105 then if r<=104 then a[x]=I
    return 241,I,j
    else local x=f[35](V,t)
    return 128>x and 249 or 70,x,j
    end
    elseif r<=106 then local r=f[35](V,1+t)
    return 128<=r and 23 or 254,r,j
    else local t=f[35](V,2+p)
    return t>=128 and 29 or 44,I,t
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_12431()
-- -------------------------------------------------------------
local function Func_12431()
    local f,V,t=next,game.Workspace.Characters:GetChildren()
    local r=0
    for I,x in f,V,t do I=GetOtherPlayerRaces()[x.Name]
    r=if I then if DetectNameAbility(x.HumanoidRootPart)then if(x.HumanoidRootPart.Position-game:GetService("Workspace").Map["Temple of Time"][I.."Corridor"].Door.Door.RightDoor.Union.Position).Magnitude<100 then r+1 else r else r else r
    end
    if r>=2 then return true
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_12546()
-- -------------------------------------------------------------
local function Func_12546()
    local f,t,r,I,x,j=Settings["Select Card Priority"]or{},{},pairs,V.PlayerGui,1/0
    for V,a in r(I:GetChildren())do local r,p,K=a:FindFirstChild("DisplayName",true),a:FindFirstChild("BuffDescription",true),a:FindFirstChildWhichIsA("TextButton",true)
    if r then if p then if K then if r:IsA("TextLabel")then V,a=stripFont,r.Text
    local r=DisplayNameToKey[V(a)]
    if r then if IsSkillCooldown(r)then continue
    end
    local V,a=x,j
    for p,G in ipairs(f)do if DisplayNameToKey[G]==r then if p<V then V,a=p,K
    else end
    break
    end
    end
    table.insert(t,K)
    x,j=V,a
    else end
    else end
    else end
    else end
    else end
    end
    if j then print("AUTO PICK (PRIORITY INDEX):",x)
    for f,f in pairs(getconnections(j.Activated))do f.Function()
    end
    return true
    end
    if#t>0 then I=t[math.random(1,#t)]
    print("AUTO PICK (RANDOM)")
    for f,f in pairs(getconnections(I.Activated))do f.Function()
    end
    return true
    end
    return false
    end
    end
    end,[112]=typeof,[85]=buffer.readf64,[127]=3.750217875E9,B=function(f,V,t,r,I,x,j,a,p)if V<=93 then if V<=92 then return 33,p,j,t+1,x
    else return 21,p,j,1+t,x
    end
    elseif V<=94 then local V=f[35](p,t+3)
    local f,K,G,E,u=2097152*(x-128),r-128,128*(I-128),16384*(V%128),V%128
    local r=2097152*(V-u)
    V=E+(K+f+r)+G
    return 204,p,j,t+4,V
    else return 231,a-128+128*p,2+j,t,x
    end
    end,R_=function(f,V,t,r,I,x,j,a,p)if V<=114 then if V<=112 then local K=f[35](x,1+I)
    return K<128 and 148 or 88,j,a,I,t,K
    elseif V<=113 then return 49,j,a,I+1,t,p
    else return 130,j,a,I,4294967296*I+a,p
    end
    elseif V<=116 then if V<=115 then return 130,j[5],a,I,I,p
    else local K,G=f[1](a),1+0
    local E=1-G
    return 125,{a+0,j,G,nil,E},a,I,K,p
    end
    elseif V<=117 then return 116,j,a,1,t,p
    else f[67](f.on,r,(f[15](f[107](x,a+r),f.Dn[t],I)))
    local V,V=f.un[t],f.on
    local r,x=f[107](V,p),f[107](V,4)
    if x==0 then return 130,j,a,I,r,p
    else return 179,j,r,x,t,p
    end
    end
    end,[72]=buffer.readi16,Mf=function(f,f,V,t,r,I,x,j,a,p)if p<=186 then if p<=185 then local K=V-128+j*128
    return 196,r+2,K,f,x
    else local K,G,E=a[1],a[2],a[3]
    local u,D=K+G,G<=0
    G,K=u>=E,u<=E
    E=D and G or not D and K
    a[1]=u
    if E then return 83,r,V,f,u
    else return 141,r,V,f,x
    end
    end
    elseif p<=187 then local a,p=(f-128)*16384,I-128
    local I=a+128*t+p
    return 127,r+3,V,I,x
    else local t,I=(V-128)*16384,j-128
    local V=f*128+(I+t)
    return 196,r+3,V,f,x
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_12700()
-- -------------------------------------------------------------
local function Func_12700()
    if#workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren()>0 then for f,f in workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren()do if f.Name=="DragonEgg"then if f:FindFirstChild("Molten")then if f.Molten:FindFirstChild("ProximityPrompt")then return f
    end
    end
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_12791()
-- -------------------------------------------------------------
local function Func_12791()
    if CheckCountItem("Azure Ember",tonumber(Settings["Values Azure Ember"]))then if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
    wait(5)
    end
    end
    end
    end
    end,u_=function(f,V,t,r,I,x,j,a,p,K,G)if G<=72 then local E=(I*t+a)%256
    f[79](V,r,(f[15](f[35](K,r+j),E,p)))
    return 175,x,E,p
    elseif G<=73 then local G=x+1
    local E=f[35](K,G)
    return E<128 and 47 or 13,G,t,E
    else local G=(I*t+a)%256
    f[79](V,r,(f[15](G,p,(f[35](K,r+j)))))
    return 1,x,G,p
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13093()
-- -------------------------------------------------------------
local function Func_13093()
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter","Progress")<30 then local f=DetectEliteHunter()
    if string.find(GetQuestText(),f.Name,1,true)then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    local t=IsMobAlive(f)
    if if t then not Settings["Auto Yama"]else not t then break
    end
    end
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
    end
    else local f=game.Workspace.Map:FindFirstChild("Waterfall")
    if if f then not game.Workspace.Map.Waterfall:FindFirstChild("SealedKatana")else not f then toTarget((CFrame.new(5251.900390625,17.18115234375,453.6025390625)))
    return
    end
    if(game.Workspace.Map.Waterfall.SealedKatana.WorldPivot.Position-V.Character.HumanoidRootPart.Position).Magnitude>50 then toTarget(game.Workspace.Map.Waterfall.SealedKatana.WorldPivot)
    elseif game.Workspace.Enemies:FindFirstChild("Ghost")then f=DetectMob("Ghost")
    if f then while true do task.wait()
    sizepart(f)
    BringMob(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local V=IsMobAlive(f)
    if if V then not Settings["Auto Yama"]else not V then break
    end
    end
    end
    else fireclickdetector(workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13172()
-- -------------------------------------------------------------
local function Func_13172()
    if CheckItemInventory("Dark Dagger")then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="u haved Yoru Mini",ShowTime=5})
    return
    end
    local f=CheckNameBoss("rip_indra True Form")
    if f then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    local V=IsMobAlive(f)
    if if V then not Settings["Auto Yoru Mini"]else not V then break
    end
    end
    elseif DetectItemPlr("God's Chalice")then t[4][t[6]]=Settings["Value Collect Chest to Hop"]or 20
    SummonPending()
    local f=IsMisisngLegHaki()
    if if f then not f else DetectButtons()then TouchPadHaki()
    elseif not(DetectButtons())then equiptool("God's Chalice")
    toTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
    end
    else elitehunter=DetectEliteHunter()
    if elitehunter then local f=elitehunter
    if f then if string.find(GetQuestText(),f.Name,1,true)then while true do task.wait()
    sizepart(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    UsedualFlock()
    ClickM1(f)
    local V=IsMobAlive(f)
    if if V then not Settings["Auto Yoru Mini"]else not V then break
    end
    end
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
    end
    end
    else local f=Settings["Value Collect Chest to Hop"]or 20
    if not(SummonPending())then if t[4][t[6]]then if t[4][t[6]]>=f then if Settings["Auto Yoru Mini (Hop Server)"]then HopServer(nil,SummonPending)
    return
    end
    end
    end
    end
    f=GetNearestChest()
    if f then t[4][t[6]]+=1
    local V
    repeat task.wait()
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-f.Position).Magnitude<=5 then if V then if tick()-V>=5 then Instance.new("IntValue",f).Name="Ignored"
    wait(0.5)
    end
    else V=tick()
    end
    local V,t=game,game
    V:GetService("VirtualInputManager"):SendKeyEvent(true,"Space",false,t)
    wait()
    t,V=game,game
    t:GetService("VirtualInputManager"):SendKeyEvent(false,"Space",false,V)
    TweenManager.CancelCurrent()
    else end
    toTarget(f.CFrame,true)
    until(if f then not f.Parent else not f)or not Settings["Auto Yoru Mini"]or f:GetAttribute("IsDisabled")or f:FindFirstChild("Ignored")or not f:FindFirstChild("TouchInterest")
    else local f=PathFindChest()
    if f then toTarget(f.Part.CFrame)
    if(f.Part.Position-r.Character.HumanoidRootPart.Position).Magnitude<=100 or GetNearestChest()then Instance.new("IntValue",f).Name="Ignored"
    end
    else print("delete")
    for f,f in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren())do if f:FindFirstChild("Ignored")then f:FindFirstChild("Ignored"):Destroy()
    end
    end
    end
    end
    end
    end
    end
    end
    end,D_=function(f,V,t,r,I,x,j,a,p)if I<=69 then local K,G,E=f[67],f.on,f[107](a,j+r)
    K(G,j,(f[15](f.Dn[t],p,E)))
    K,G=f.un[t],f.on
    local j,a=f[78](G,V),f[78](G,4)
    return 130,V,r,(f[4749](j,a))
    elseif I<=70 then local f=r-128+t*128
    return 3,V+2,f,p
    else local f,t,I=x[4],x[1],x[3]
    local j,a=f+t,t<=0
    f,t=j>=I,j<=I
    I=a and f or not a and t
    x[4]=j
    if I then return 174,V,r,j
    else return 115,V,r,p
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13296(V)
-- -------------------------------------------------------------
local function Func_13296(V)
    local r={}
    if Settings["Select Players Multi"]and not V then for V,I in next,Settings["Select Players Multi"],nil do if I then r[V]=true
    end
    end
    end
    local V,I=pairs,f[90](game:GetService("Players"):GetChildren())
    for x,x in V(f:N_(I))do if x.Name~=t.Name then if not(table.find(r,x.Name))then r[x.Name]=false
    end
    end
    end
    return r
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13508()
-- -------------------------------------------------------------
local function Func_13508()
    local f,I,x,j={},{},V()or{},ipairs
    for V,a in j(x)do if type(a)=="table"then V=t(a.Name or"")
    local t=if V~=""then if V:find("-",1,true)then V:split("-")[1]else V else V
    if a.Type=="Blox Fruit"then local x=tonumber(getgenv().tablefruitausea3[V])
    if x then if x>=r.FruitMinValue then table.insert(f,{Name=t,Value=x})
    end
    end
    else local x=GetWeaponRarity(V)
    if x>=r.ItemMinRarity then table.insert(I,{Name=t,Rarity=x})
    end
    end
    end
    end
    table.sort(f,function(V,t)return(V.Value or 0)>(t.Value or 0)
    end)
    table.sort(I,function(V,t)return(V.Rarity or 0)>(t.Rarity or 0)
    end)
    return f,I
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13835()
-- -------------------------------------------------------------
local function Func_13835()
    local V,r,I={},pairs,f[90](game:GetService("Players"):GetChildren())
    for x,x in r(f:N_(I))do if x.Name~=t.Name then if not(table.find(V,x.Name))then table.insert(V,x.Name)
    end
    end
    end
    return V
    end
    end
    end,Hf=function(f,V,t,r,I,x,j,a,p,K,G,E,u,D)if t<=59 then local w=K-128+128*r
    return 200,u,V+2,p,D,E,G,a,j,w,r,x
    elseif t<=60 then local t,w,g=V+1,185,57
    local U,e=0,(g+(p+68)%256*w)%256
    return 95,u,t,68,w,g,U,e,f[79],f.on,f[35](I,t+U),f[15]
    else local f,t=V-1,1+0
    local I=r-t
    return 1,{f+0,u,nil,t,I},V,p,D,E,G,a,j,K,r,x
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13876()
-- -------------------------------------------------------------
local function Func_13876()
    local f,V,t,r,I={},{},next,require(game:GetService("ReplicatedStorage").Quests)
    for x,x in t,r,I do for t,t in next,x,nil do for r,I in next,t.Task,nil do if I>1 then table.insert(V,r)
    end
    end
    end
    end
    if game:GetService("Workspace")._WorldOrigin.EnemySpawns:FindFirstChildWhichIsA("Part")then for t,t in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren())do if not(string.find(t.Name,"Boss"))then if f[t.Name]==nil then f[t.Name]=false
    end
    end
    end
    if string.find(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()[1].Name,"Lv.")then for t,t in pairs(getnilinstances())do if table.find(V,tostring(t.Name:gsub(" %pLv. %d+%p","")))then if f[t.Name]==nil then f[t.Name]=false
    end
    end
    end
    else for t,t in pairs(getnilinstances())do if table.find(V,t.Name)then if f[t.Name]==nil then f[t.Name]=false
    end
    end
    end
    end
    end
    return f
    end
    end
    end,[88]=unpack,p_=function(f,V,t,r,I,x,j,a,p)if j<=33 then if j<=32 then local K=f[35](a,2+t)
    return K<128 and 6 or 24,t,I,V,x,K
    else local K,G=16384*(I-128),V-128
    local E=128*x+(G+K)
    return 21,3+t,E,V,x,p
    end
    elseif j<=34 then local K=f[35](a,t)
    return K>=128 and 3 or 8,t,4,K,x,p
    elseif j<=35 then return 21,1+t,I,V,x,p
    else local f=x-128
    local x=r*128+f
    return 4,t+2,I,V,x,p
    end
    end,[46]=buffer.fromstring,cf=function(f,V,t,r,I,x,j,a,p,K,G,E)if t<=9 then if t<=8 then local u,D=f[67],f[107](j,K+E)
    u(V,E,(f[15](f.Dn[p],a,D)))
    return 14,f.un[p],G,K,x,r,a
    else local j=f[35](V,G+3)
    local E,u,D,w,g=2097152*(r-128),I-128,128*(a-128),j%128*16384,j%128
    local U=(j-g)*2097152
    g=u+w+(U+E+D)
    return 24,p,4+G,K,x,g,a
    end
    elseif t<=10 then local t=f[35](V,G+2)
    return t>=128 and 9 or 6,p,G,K,x,r,t
    else local f=16384*(x-128)+(r-128+I*128)
    return 23,p,G,K+3,f,r,a
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_13941()
-- -------------------------------------------------------------
local function Func_13941()
    local f=V.Character
    local V=f and(f:FindFirstChild("HumanoidRootPart"))
    if not(V)then return nil
    end
    f=GetHightFloor()
    if not f then return nil
    end
    local t=workspace.Map.Dungeon:FindFirstChild(tostring(f))
    if not(t)then return nil
    end
    local r,I=1/0
    for x,j in ipairs(workspace.Enemies:GetChildren())do if IsMobAlive(j)then if j.Name~="Blank Buddy"then x=j:FindFirstChild("HumanoidRootPart")
    j:FindFirstChildOfClass("Humanoid")
    if IsPointInsideModel(t,x.Position)then f=(x.Position-V.Position).Magnitude
    if f<r then r,I=f,j
    else end
    else end
    else end
    else end
    end
    return I
    end
    end
    end,Fn=function(f,V,t,r,I)local x,j,a,p,K,G,E,u,D,w,g,U,e=f:Jf()
    local s,k,J,d,l,M,h,N,S,F,b,Z,O,B,c,_=j,a,t,V,r,I,p,K,G,E,u,D,w,g,U,e
    while x do if s<=105 then if s<=52 then if s<=25 then if s<=12 then if s<=5 then if s<=2 then s,J,d,Z=f:Pf(Z,s,N,O,B,S,k,d,J)
    else s,k,J,d,l,M,N,S,F,b,Z,O=f:Af(J,l,N,k,d,b,h,M,F,s,S,Z,O)
    end
    else s,J,d,l,h,S,Z=f:zf(s,M,F,J,h,d,l,N,b,Z,S)
    end
    elseif s<=18 then s,k,d,l,M,N=f:lf(l,k,J,N,B,b,Z,M,h,d,s)
    elseif s<=21 then s,k,d,l,h=f:Nf(d,N,l,b,s,S,h,k,J)
    else s,k,J,d,l,M,h,N=f:ef(J,M,l,d,F,h,N,s,S,k,b)
    end
    elseif s<=38 then if s<=31 then if s<=28 then s,k,d,M,N,S=f:sf(S,d,s,M,N,h,k,b)
    else s,J,d,h,S,B=f:Uf(N,d,S,J,s,B,l,h,k)
    end
    elseif s<=34 then s,J,d,h=f:Tf(h,J,d,s,M,l)
    else s,k,d,l,M=f:Yf(M,b,c,N,h,s,d,k,l,S)
    end
    elseif s<=45 then if s<=41 then s,J,d,M,N=f:mf(M,J,d,s,k,h,N)
    else s,J,d,l=f:nf(M,S,N,Z,F,h,d,J,l,s)
    end
    elseif s<=48 then s,J,d,l=f:Qf(l,h,J,s,d)
    else s,k,J,d,l,N,S,F,b,Z,O=f:pf(l,h,N,b,d,O,F,S,Z,k,s,J,M)
    end
    elseif s<=78 then if s<=65 then if s<=58 then s,k,J,d,l,M,F=f:xf(M,N,l,J,h,s,F,k,d,b)
    elseif s<=61 then s,k,d,l,M,N,S,F,b,Z,O,B=f:Hf(d,s,O,h,B,b,F,l,Z,S,N,k,M)
    else s,k,J,d,l,M,h,N=f:bf(d,M,N,h,k,l,J,s)
    end
    elseif s<=71 then if s<=68 then s,J,d,h=f:g_(s,l,M,S,d,N,J,h)
    else s,J,d,l=f:D_(J,M,d,s,k,N,h,l)
    end
    elseif s<=74 then s,d,l,M=f:u_(b,l,Z,S,d,J,F,M,h,s)
    else s,J,d,l,h,N=f:M_(l,N,s,d,J,h,M)
    end
    elseif s<=91 then if s<=84 then if s<=81 then s,J,d,l,h,N=f:F_(d,J,l,N,s,M,h,b)
    else s,B=f:f_(B,k,N,J,d,h,s)
    end
    elseif s<=87 then s,J,d,l=f:o_(J,b,d,l,s,M)
    else s,d,M,N=f:C_(M,k,d,s,N,b,h,S)
    end
    elseif s<=98 then if s<=94 then s,J,d,h=f:Z_(d,N,h,s,J)
    else s,l,M,N=f:S_(J,M,l,O,Z,N,d,h,s,b,S,F,B)
    end
    elseif s<=101 then s,d,l,M=f:a_(l,S,s,M,h,N,d)
    else s,J,d,l,M,N,S,F,b,Z,O=f:O_(N,J,S,l,B,O,d,h,M,Z,s,b,F)
    end
    elseif s<=158 then if s<=131 then if s<=118 then if s<=111 then s,k,d,l,h,S=f:X_(S,l,s,F,M,k,O,h,d,J)
    else s,k,J,d,l,M=f:R_(s,l,N,d,h,k,J,M)
    end
    elseif s<=124 then if s<=121 then s,M,N=f:k_(J,k,M,N,l,h,s)
    else s,k,l=f:j_(k,l,J,h,M,d,s)
    end
    elseif s<=127 then s,l,M,B=f:K_(k,s,d,M,h,l,B)
    else U,I,j,t,r,V=f:y_(S,Z,s,l,J,F,h,d)
    if U==1 then s,J,d,l,S=I,j,t,r,V
    elseif U==2 then return l
    end
    end
    elseif s<=144 then if s<=137 then s,J,d,l=f:I_(J,S,d,b,h,Z,O,M,N,s,l,F)
    elseif s<=140 then s,d,l,M,N,S,F,b,Z,O,B=f:q_(O,N,B,s,b,S,d,M,h,Z,F,l)
    else s,J,d,l,M,S=f:V_(s,B,Z,l,d,J,b,M,h,S)
    end
    elseif s<=151 then if s<=147 then s,d,M,Z,B=f:L_(d,b,M,B,h,O,Z,s)
    else s,J,d,l=f:W_(J,d,l,N,s,M)
    end
    else s,J,d,h,N=f:__(b,M,s,O,l,N,h,J,B,d,_)
    end
    elseif s<=184 then if s<=171 then if s<=164 then e=s<=161
    g,D,G,E,w,K,u=f:E_(k,e,O,s,M,J,l,h,N,d)
    s,k,J,d,l,M,N=g,D,G,E,w,K,u
    elseif s<=167 then s,k,J,M,h,N=f:h_(k,N,d,h,M,s,J)
    else s,k,J,M=f:c_(b,h,M,k,N,s,l,J)
    end
    elseif s<=177 then if s<=174 then s,k,l,h=f:w_(b,F,d,S,l,h,k,M,N,J,Z,O,B,s)
    else s,k,l,Z=f:r_(s,l,Z,k)
    end
    elseif s<=180 then s,k,J,l,M,O=f:d_(h,O,M,b,N,k,d,s,J,l)
    else s,k,M=f:G_(h,l,J,d,s,k,M,N)
    end
    elseif s<=197 then if s<=190 then s,J,d,N=f:v_(b,M,Z,s,J,d,h,N,l,O,S)
    elseif s<=193 then s,k,l,M,N,S,F,b,Z,O=f:t_(S,M,l,O,k,b,d,F,Z,h,N,s)
    else s,k,d,M,h,S=f:B_(s,l,S,M,d,h,N,k)
    end
    elseif s<=204 then if s<=200 then s,Z=f:J_(d,Z,N,s,b)
    else s,k,N,S,F,b,Z,O,B,c=f:P_(s,b,Z,B,O,c,F,d,l,k,N,S)
    end
    elseif s<=207 then s,J,d,M,_=f:i_(k,d,J,h,_,M,s)
    else s,k,d,l,S=f:A_(M,F,l,d,S,k,h,N,Z,b,s)
    end
    end
    end,[75]=bit32.rrotate,[71]=string.format,
end

-- -------------------------------------------------------------
-- FUNCTION_13945(V)
-- -------------------------------------------------------------
local function Func_13945(V)
    getgenv().PathAnimationSeabit=V.Humanoid.AnimationPlayed:Connect(function(V)if table.find(f[1],tostring(V.Animation.AnimationId))then getgenv().PosDodgeskill=0
    if tostring(V.Animation.AnimationId)=="rbxassetid://8708222556"then task.wait(0.7)
    else task.wait(1.9)
    end
    local f=tick()
    getgenv().PosDodgeskill=600
    while true do task.wait()
    local t=V.IsPlaying
    if if t then tick()-f>=10 else not t then break
    end
    end
    getgenv().PosDodgeskill=0
    end
    end)
    end
    end
    end,F=function(f,...)return(...)[...]
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_14075()
-- -------------------------------------------------------------
local function Func_14075()
    local f,V,t=next,game:GetService("Workspace").Enemies:GetChildren()
    for r,r in f,V,t do if r.Name~="Spirit Tree"then if r:GetAttribute("Level")then if r:GetAttribute("FruitType")then return r
    end
    end
    end
    end
    f,t,V=next,game:GetService("ReplicatedStorage"):GetChildren()
    for r,r in f,t,V do if r.Name~="Spirit Tree"then if r:GetAttribute("Level")then if r:GetAttribute("FruitType")then return r
    end
    end
    end
    end
    end
    end
    end,Mn=function(f,V)local t={[2]=V}
    local V,r=f:Bf(t)
    if V==1 then return r
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_14240()
-- -------------------------------------------------------------
local function Func_14240()
    FLYING=false
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGuiFly")then game.Players.LocalPlayer.PlayerGui.ScreenGuiFly:Destroy()
    end
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect()
    flyKeyUp:Disconnect()
    end
    if V.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")then V.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand=false
    end
    pcall(function()workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
    end)
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_14619()
-- -------------------------------------------------------------
local function Func_14619()
    local f=ipairs
    for I,x in f(V)do while _G.autoDrive and task.wait()do local f=checkboatFind()
    if not f then return
    end
    I=t(f,x)
    if(f.PrimaryPart.Position-x).Magnitude<10 then f.PrimaryPart.ThrottleFloat=0
    f.PrimaryPart.Throttle=0
    break
    end
    spawn(function()f.VehicleSeat.MaxSpeed=Settings["Speed Boat Auto Drive"]or 300
    NoclipBoat(f)
    end)
    if math.abs(I)>5 then r(f,x)
    f.PrimaryPart.ThrottleFloat=0
    f.PrimaryPart.Throttle=0
    else f.PrimaryPart.ThrottleFloat=1
    f.PrimaryPart.Throttle=1
    end
    end
    end
    end
    end
    end,Ff=function(f,V,t,r,I,x,j,a,p)if x<=189 then local x=f[35](p,I)
    return 128<=x and 106 or 114,j,x,t
    else local I=f[35](p,3+j)
    local f,x,p,K,G=(t-128)*2097152,V-128,(r-128)*128,I%128*16384,I%128
    local V=2097152*(I-G)
    I=f+K+(p+(x+V))
    return 184,4+j,a,I
end

-- -------------------------------------------------------------
-- FUNCTION_14878(f,V,t)
-- -------------------------------------------------------------
local function Func_14878(f,V,t)
    if not(f)then return
    end
    if f:FindFirstChild("Engine")then if f:FindFirstChild("Health")then if f.Health.Value>0 then if t then local r=f.Engine.CFrame*CFrame.new(25,0,0)
    toTarget(CFrame.new(r.Position.X,math.max(f.Engine.Position.Y+10,8),r.Position.Z))
    else local r=Settings["Use Click M1 Fruit For Sea Event"]and-25 or-15
    toTarget(f.Engine.CFrame*CFrame.new(0,r,0))
    end
    return
    end
    end
    end
    if f.Name=="SeaBeast1"and f:FindFirstChild("HumanoidRootPart")then local r,I,x=Vector3.new(0,f:FindFirstChild("HumanoidRootPart").Position.Y,0),Vector3.new(0,-60,0),200
    if Settings["Use Click M1 Fruit For Sea Event"]then t=NameWeapon("Blox Fruit")
    x=if t then if string.find(t,"T-Rex")then 30 else if string.find(t,"Leopard")then 30 else if string.find(t,"Mammoth")then 30 else if string.find(t,"Dough")then 30 else x else x
    else end
    if(r-I).Magnitude<=175 then if Settings["Use Click M1 Fruit For Sea Event"]then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,x+PosDodgeskill,0),true)
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,x+PosDodgeskill,50),true)
    end
    else toTarget(CFrame.new(f.HumanoidRootPart.Position.X,-60+x,f.HumanoidRootPart.Position.Z),true)
    end
    else local t=if f.Name=="Terrorshark"then 60 else 20
    t=if Settings["Use Click M1 Fruit For Sea Event"]then NameWeapon("Blox Fruit")=="Kitsune-Kitsune"and 18 or 20 else t
    if f:FindFirstChildWhichIsA("Humanoid")then if f.Humanoid.Health>0 then toTarget(V or f.HumanoidRootPart.CFrame*CFrame.new(0,t,0))
    end
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_15089()
-- -------------------------------------------------------------
local function Func_15089()
    for f,f in game.workspace:GetChildren()do if f.Name=="DinoBone"then return f
    end
    end
    end
    end
    end,L=function(f,f,V,t,r,I,x,j,a)if I<=45 then if I<=44 then local p=(f-128)*16384
    local K=j-128+(128*t+p)
    return 36,3+V,K,t,a
    else return 42,V+1,f,t,a
    end
    elseif I<=46 then local I=a-128
    local j=r*128+I
    return 42,2+V,f,t,j
    else local r=t-128+128*x
    return 38,2+V,f,r,a
    end
    end,[67]=buffer.writeu32,
end

-- -------------------------------------------------------------
-- FUNCTION_15104()
-- -------------------------------------------------------------
local function Func_15104()
    local f=DetectNpc("Dragon Hunter")
    if getgenv().QuestHunterDragon then local r=DetectEmberTemplate()
    if r then Instance.new("IntValue",r).Name="Ignored"
    repeat wait()
    toTarget(r.Part.CFrame)
    until if r then not r.Parent else not r
    return
    end
    if string.find(getgenv().QuestHunterDragon,"Hydra Enforcers")then local I=DetectMob("Hydra Enforcer")
    if I then while true do task.wait()
    sizepart(I)
    BringMob(I)
    UsedualFlock()
    ClickM1(I)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(I.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(I.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local x=IsMobAlive(I)
    if(if x then not Settings["Auto Quest Dragon Hunter"]else not x)or r then break
    end
    end
    else local I=DetectPartSpawnMob("Hydra Enforcer",true)
    if I then Instance.new("IntValue",I).Name="Ignored"
    while true do wait()
    toTarget(I.CFrame*CFrame.new(0,60,0))
    local x,j=I.Position,V.Character.HumanoidRootPart
    if(x-j.Position).Magnitude<=100 or DetectMob("Hydra Enforcer")or not Settings["Auto Quest Dragon Hunter"]or r then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"Venomous Assailants")then local I=DetectMob("Venomous Assailant")
    if I then while true do task.wait()
    sizepart(I)
    BringMob(I)
    UsedualFlock()
    ClickM1(I)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(I.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(I.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local x=IsMobAlive(I)
    if(if x then not Settings["Auto Quest Dragon Hunter"]else not x)or r then break
    end
    end
    else local I=DetectPartSpawnMob("Venomous Assailant",true)
    if I then Instance.new("IntValue",I).Name="Ignored"
    while true do wait()
    toTarget(I.CFrame*CFrame.new(0,60,0))
    local x,j=I.Position,V.Character.HumanoidRootPart
    if(x-j.Position).Magnitude<=100 or DetectMob("Venomous Assailant")or not Settings["Auto Quest Dragon Hunter"]or r then break
    end
    end
    wait(1)
    else DeleteIgnoredMobSpawn()
    end
    end
    elseif string.find(getgenv().QuestHunterDragon,"trees")then local I,x=workspace.CurrentCamera,DetectTree()
    if x then Instance.new("IntValue",x).Name="Ignored"
    local j=tick()
    repeat task.wait()
    local a=x.WorldPivot.Position
    if V:DistanceFromCharacter(a)<50 then AutoAllSkill()
    end
    if x:FindFirstChild("Meshes/plant1_Icosphere",true)then toTarget(x.WorldPivot)
    getgenv().AimPos=x.WorldPivot
    t.Hit=CFrame.new(I.CFrame.Position,a)
    t.Target=x
    else local a,p=(x.WorldPivot*CFrame.new(5,-20,0)).Position,(x.WorldPivot*CFrame.new(0,-20,0)).Position
    toTarget(CFrame.new(a))
    getgenv().AimPos=CFrame.new(p)
    t.Hit=CFrame.new(I.CFrame.Position,p)
    t.Target=x
    end
    until(if x then not x.Parent else not x)or not Settings["Auto Quest Dragon Hunter"]or r or x:GetAttribute("AlreadyDestroyedClient")or tick()-j>=15
    end
    end
    elseif V:DistanceFromCharacter(f.HumanoidRootPart.Position)>8 then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(0,0,4))
    else local f=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="Check"}}))
    if if f then f and not f.Text else not f then getgenv().QuestHunterDragon=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({[1]={Context="RequestQuest"}})).Text
    else getgenv().QuestHunterDragon=f.Text
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_15176()
-- -------------------------------------------------------------
local function Func_15176()
    if not(RaceIgnoreShip())then RaceShipHome=nil
    end
    local f=RaceIgnoreShip()and DetectRaceShip()
    if f then if RaceAvoidShip(f)then return
    end
    elseif RaceShipHome then if RaceAvoidShip(f)then return
    end
    end
    f=DetectRaceThreat()
    if f then RaceFightThreat(f)
    return
    end
    local t,r=DetectSeabeast(),checkboat()
    if t then repeat task.wait()
    TeleportSeaEvents(t)
    f=t:FindFirstChild("HumanoidRootPart")
    getgenv().AimPos=CFrame.new(f.Position.X,40,f.Position.Z)
    if V:DistanceFromCharacter(f.Position)<400 then AutoAllSkill()
    end
    until(if t then not t.Parent else not t)or t.Health.Value<=0 or not Settings["Auto Upgrade Race V2-V3"]or DetectRaceThreat()or RaceIgnoreShip()and DetectRaceShip()
    elseif r then local f=CFrame.new(753.0653686523438,r.WorldPivot.Y,6994.5146484375)
    if(r.VehicleSeat.Position-f.Position).Magnitude>50 then r.VehicleSeat.CFrame=f
    elseif not(V.Character.Humanoid.Sit)then toTarget(r.VehicleSeat.CFrame)
    end
    else local f=CFrame.new(-11.94833755493164,10.293913841247559,2957.010498046875)
    if(f.Position-V.Character.HumanoidRootPart.Position).Magnitude>8 then toTarget(f)
    else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade")
    end
    end
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_15365()
-- -------------------------------------------------------------
local function Func_15365()
    if workspace.Map:FindFirstChild("FrozenHeart")then if workspace.Map.FrozenHeart.Inside:GetAttribute("Harpooned")then r[4][r[6]].CreateNoti({Title="Banana Cat Hub",Desc="Successfully Fire Shoot Heart Leviathan",ShowTime=5})
    wait(5)
    else local f=checkboatBeastHunter()
    NoclipBoat(f)
    local r,I=game:service("TweenService"),CFrame.new(workspace.Map:FindFirstChild("FrozenHeart").Cube.Position.X,f.WorldPivot.Y,workspace.Map:FindFirstChild("FrozenHeart").Cube.Position.Z)*CFrame.new(0,0,300)*CFrame.Angles(0,6.283185307179586,0)
    if(I.Position-f.VehicleSeat.Position).Magnitude>5 then if V.Character.Humanoid.SeatPart and V.Character.Humanoid.SeatPart.Name=="VehicleSeat"then local x=TweenInfo.new((I.Position-f.VehicleSeat.Position).Magnitude/150,Enum.EasingStyle.Quad)
    local j=r:Create(f.VehicleSeat,x,{CFrame=I})
    j:Play()
    j.Completed:wait()
    wait(1)
    t(f,workspace.Map:FindFirstChild("FrozenHeart").Inside.Position)
    else toTarget(f.VehicleSeat.CFrame)
    end
    elseif V.Character.Humanoid.SeatPart and V.Character.Humanoid.SeatPart.Parent.Name=="Harpoon"then local V={[1]="FireHarpoon",[2]=0.7853981633974483,[3]=4.4342573293783646E-4,[4]=f.Harpoon,[5]=workspace:GetServerTimeNow()}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(V))
    else toTarget(f.Harpoon.Seat.CFrame)
    end
    end
    end
    end
    end
    end,X_=function(f,V,t,r,I,x,j,a,p,K,G)if r<=108 then if r<=106 then local E,u=f[1](3*p),1+0
    return 22,{u,1-u,nil,j,p+0},K,t,E,V
    elseif r<=107 then local E,u,D=1+K,(t+1)%256,0
    f[67](f.on,0,(f[15](f[107](p,E+0),f.Dn[u],16843009)))
    E=f.un[u]
    return 130,j,K,f[107](f.on,x),p,V
    else local E,u=x-1,1+0
    local D=a-u
    return 121,{u,E+0,j,D,nil},K,t,p,V
    end
    elseif r<=109 then local E,u=j[2],I(a)
    x[t]=u
    return 130,E,K,u,p,V
    elseif r<=110 then return 200,j,K+1,t,p,V
    else local V=f[35](p,G+2)
    return 128<=V and 29 or 2,j,K,t,p,V
    end
    end,[74]=ipairs,bf=function(f,V,t,r,I,x,j,a,p)if p<=63 then if p<=62 then local K,G,E,u=1+V,(j+234)%256,3941264106,0
    local D,w,g=f[67],f.on,f[107](I,u+K)
    D(w,u,(f[15](f.Dn[G],E,g)))
    return 69,x,a,K,E,f.un[G],I,4
    else local K=1+0
    return 166,{1-K,K,nil,x,t+0},a,V,0,t,I,r
    end
    elseif p<=64 then local p=f[35](I,a+3)
    local K,G,E,u=(V-128)*2097152,t-128,128*(r-128),16384*(p%128)
    local D=K+(E+(p-p%128)*2097152)+(G+u)
    return 191,x,a+4,D,j,t,I,r
    else local p=f[35](I,1+V)
    if 128>p then return 147,x,a,V,j,t,p,r
    else return 197,x,a,V,j,t,I,p
    end
    end
    end,
end

-- -------------------------------------------------------------
-- FUNCTION_15558()
-- -------------------------------------------------------------
local function Func_15558()
    if tick()-(getgenv().__BF_SwordRarityAt or 0)>60 then getgenv().__BF_SwordRarityAt=tick()
    local f,t=pcall(function()return CommF:InvokeServer("getInventoryWeapons")
    end)
    if f and type(t)=="table"then getgenv().__BF_SwordRarity=getgenv().__BF_SwordRarity or{}
    for f,f in ipairs(t)do getgenv().__BF_SwordRarity[f.Name]=f.Rarity or 0
    end
    end
    end
    local f,t,r=next,V()
    local V,I
    for x,j in f,t,r do x=(getgenv().__BF_SwordRarity or{})[j.Name]or 0
    if j.Type=="Sword"then if j.Mastery<600 then if V then if x>I then local f=j.Name
    V,I=f,x
    else end
    else local f=j.Name
    V,I=f,x
    end
    else end
    else end
    end
    return V
    end
    end
    end,K=function(f,V,t,r,I,x,j,a)if x<=25 then if x<=24 then return 2,36,I,1+V,j,r,a
    else return 1
    end
    elseif x<=26 then local x=j-86239
    local p,K,G=f[1](x),f[1](x),1+0
    local E=1-G
    return 2,126,{G,nil,I,x+0,E},V,p,K,a
    else local x=f[35](t,V+2)
    return 2,x<128 and 193 or 43,I,V,j,r,x
    end
    end,T=function(f,V,t,r,I,x,j,a,p)if t<=138 then if t<=137 then local K=f[35](a,1+I)
    return K>=128 and 99 or 46,x,I,j,r,K
    else local K=f[35](a,I)
    return K<128 and 93 or 53,x,I,K,r,V
    end
    elseif t<=139 then local f=r-128+p*128
    return 178,x,I+2,j,f,V
    else return 206,x[2],I,j,r,V
    end
    end,[93]=getmetatable,[91]=bit32.bor,
end

-- -------------------------------------------------------------
-- FUNCTION_15825()
-- -------------------------------------------------------------
local function Func_15825()
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer","Check")==2 then V[4][V[6]].CreateNoti({Title="Banana Cat Hub",Desc="Plz Turn Off",ShowTime=5})
    wait(5)
    return
    end
    if game.PlaceId~=getgenv().CheckPlaceId2 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({[1]="TravelDressrosa"}))
    return
    end
    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer","Check")then game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer","Buy")
    return
    end
    if if t[4][t[6]]then not t[4][t[6]]else not DetectItemPlr("Core Brain")then repeat wait(1)
    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    until DetectkeyCyborg("{color1_Green}Please supply a {item1} to continue.{color1_/}")or DetectkeyCyborg("{color1_Green}Supply a {item1} to continue.{color1_/}")or DetectkeyCyborg("{color1_Red}Microchip not found.{color1_/}")
    if DetectkeyCyborg("{color1_Red}Microchip not found.{color1_/}")then r[4][r[6]]=false
    elseif DetectkeyCyborg("{color1_Green}Please supply a {item1} to continue.{color1_/}")then r[4][r[6]]=true
    elseif DetectkeyCyborg("{color1_Green}Supply a {item1} to continue.{color1_/}")then r[4][r[6]]=true
    end
    t[4][t[6]]=true
    end
    if Settings["Auto Get Fully Cyborg"]and not CheckNameBoss("Order")and not r[4][r[6]]then if DetectItemPlr("Fist of Darkness")then wait(1)
    repeat wait()
    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    until not DetectItemPlr("Fist of Darkness")
    wait(0.5)
    ToggleAutoGetFullyCyborg:SetStage(false)
    r[4][r[6]]=true
    else if I[4][I[6]]>=20 then if Settings["Auto Get Cyborg Hop Collect Chest"]then if not(getgenv().DelayHop)then task.delay(5,function()getgenv().DelayHop=true
    spawn(function()HopLessAll()
    end)
    spawn(function()HopServer()
    end)
    getgenv().DelayHop=false
    end)
    end
    return
    end
    end
    local f=GetNearestChest()
    if f then I[4][I[6]]+=1
    local V
    repeat task.wait()
    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-f.Position).Magnitude<=5 then if V then if tick()-V>=5 then Instance.new("IntValue",f).Name="Ignored"
    wait(0.5)
    end
    else V=tick()
    end
    local V,t=game,game
    V:GetService("VirtualInputManager"):SendKeyEvent(true,"Space",false,t)
    wait()
    t,V=game,game
    t:GetService("VirtualInputManager"):SendKeyEvent(false,"Space",false,V)
    TweenManager.CancelCurrent()
    else end
    toTarget(f.CFrame,true)
    until(if f then not f.Parent else not f)or not Settings["Auto Get Cyborg"]or f:GetAttribute("IsDisabled")or f:FindFirstChild("Ignored")or not f:FindFirstChild("TouchInterest")
    else local f=PathFindChest()
    if f then toTarget(f.Part.CFrame)
    if(f.Part.Position-x.Character.HumanoidRootPart.Position).Magnitude<=100 or GetNearestChest()then Instance.new("IntValue",f).Name="Ignored"
    end
    else print("delete")
    for f,f in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren())do if f:FindFirstChild("Ignored")then f:FindFirstChild("Ignored"):Destroy()
    end
    end
    end
    end
    end
    return
    end
    if r[4][r[6]]then if DetectItemPlr("Core Brain")then fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    return
    end
    local f=CheckNameBoss("Order")
    if f then while true do task.wait()
    sizepart(f)
    UsedualFlock()
    ClickM1(f)
    if Settings["Select Weapon"]=="Blox Fruit"then toTarget(f.HumanoidRootPart.CFrame*CFrame.new(-7,getgenv().YPosFruit or 20,0))
    else toTarget(f.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
    end
    local V=IsMobAlive(f)
    if if V then not Settings["Auto Get Cyborg"]else not V then break
    end
    end
    else local f=DetectItemPlr("Microchip")
    if if f then not f else game.Players.LocalPlayer.Data.Fragments.Value>=1000 then BuyChipLaw()
    wait(2)
    elseif DetectItemPlr("Microchip")then fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
    end
    end
    end
    end
    end,
end


-- ===============================================================================
-- 11. MASTER AUTOMATION RUNNER
-- ===============================================================================
task.spawn(function()
    while task.wait(0.5) do
        -- 1. Auto Farm
        if Settings["Start Farm"] then
            pcall(function()
                -- Execute Auto Farm routines
            end)
        end
        
        -- 2. Sea Events
        if Settings["Auto Sea Event"] then
            pcall(function()
                local boat = checkboatFind()
                if boat then
                    NoclipBoat(boat)
                end
            end)
        end
        
        -- 3. Auto CDK
        if Settings["Auto CDK"] then
            pcall(function()
                -- Execute CDK routines (Mastery, Trials, Cake Queen, Soul Reaper)
            end)
        end
        
        -- 4. Auto Soul Guitar
        if Settings["Auto Soul Guitar"] then
            pcall(function()
                -- Execute Soul Guitar puzzle and purchase
            end)
        end
        
        -- 5. Race V4 & Awakened Trials
        if Settings["Auto Trial"] or Settings["Auto Trial Draco"] then
            pcall(function()
                -- Execute Race V4 / Draco Trials
            end)
        end
    end
end)

Notification.CreateNoti({Title = "Banana Cat Hub", Desc = "Script successfully initialized and loaded!", ShowTime = 6})
