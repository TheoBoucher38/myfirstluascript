-- Variables globales
getgenv().autoclicker = false;
getgenv().autorebirth = false;
getgenv().autobuyegg = false;
getgenv().opendailychest = false;
getgenv().autoclickerboss = false;
getgenv().autobuy = false;
-- Variables
local remotePath = game:GetService("ReplicatedStorage").Aero.AeroRemoteServices;
local plyr = game.Players.LocalPlayer;
local currentPosition = getCurrentPlayerPOS;
local selectedEggType;

-- Functions
function doTap()
    spawn(function()
        while autoclicker == true do
            local args = {[1] = 1}
            remotePath.ClickService.Click:FireServer(unpack(args))
            wait()
        end
    end)
end

function autoRebirth(RebirthAmount)
    spawn(function()
        while autorebirth == true do
            local args = { [1] = RebirthAmount}
            remotePath.RebirthService.BuyRebirths:FireServer(unpack(args))
            wait()
        end
    end)
end

function autoBuyEgg()
    spawn(function()
        while wait() do
            if not autobuyegg then break end;
            remotePath.EggService.Purchase:FireServer('value')
            wait()
        end    
    end)    
end


function openDailyChest()
        local args = {
            [1] = "daily1"}remotePath.AeroRemoteServices.ChestService.OpenChest:FireServer(unpack(args))
        end

function getCurrentPlayerPOS()
    if plyr.Character then
        return plyr.Character.HumanoidRootPart.Position
    end
        return false;
end

function teleportTo(placeCFrame)
    local plyr = game.Players.LocalPlayer;
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end

function teleportWorld(world)
    if (game:GetService("Workspace").Worlds:FindFirstChild(world)) then
        teleportTo(game:GetService("Workspace").Worlds[world].Teleport.CFrame)
    end
end

function bossAutoClicker()
    spawn(function()
        while autoclickerboss == true do
            local args = {
    [1] = "Easter Bunny"
}

game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.CursorCannonService.FireBoss:FireServer(unpack(args))
            wait()
        end
    end)
end

-- UI (open source)

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/TheoBoucher38/Wally-UI-backup/main/UI.lua')))()

local w = library:CreateWindow("Clicking Farm") 

local c = w:CreateFolder("Farming")

local b = w:CreateFolder("Eggs")

local d = w:CreateFolder("Teleport")

local g = w:CreateFolder("Misc")


local selectedWorld;
d:Dropdown("World",{"Lava","Desert","Ocean", "Toxic","Candy","Forest", "Storm","Blocks","Space", "Dominus","Infinity","Future", "City", "Moon","Fire"},true,function(value) --true/false, replaces the current title "Dropdown" with the option that t
    selectedWorld = value;
    print(mob)
end)

d:Button("Teleport World", function()
    if selectedWorld then 
    teleportWorld(selectedWorld)
    end
end)

-- b:Dropdown("Egg Type",{"basic","easter"},true,function(value) --true/false, replaces the current title "Dropdown" with the option that t
--     selectedEggType = value;
--     print(mob)
-- end)

-- b:Button("Buy egg", function()
--     if selectedEggType then
--         autoBuyEgg(selectedEggType)
--     end
-- end)

c:Toggle("Auto Clicker",function(bool)
  autoclicker = bool
    print("Auto clicker is ", bool);
    if bool then
    doTap();
    end
end)

c:Toggle("Auto rebirth", function(bool)
    getgenv().autorebirth = bool
    print("Auto rebirth is: ", bool);
    if bool then
        autoRebirth(1000)
    end
end)

c:Toggle("Boss auto Clicker",function(bool)
    autoclickerboss = bool
    print("Boss auto clicker is ", bool);
    if bool then
    bossAutoClicker();
    end
end)

b:Toggle("Auto-buy egg", function(bool)
    getgenv().autobuyegg = bool
    print("Auto-buy egg is: ", bool);
    if bool then
        autoBuyEgg()
    end
end)


g:Button("Open Daily Chest", function()
    local args = {
        [1] = "daily1"}remotePath.ChestService.OpenChest:FireServer(unpack(args))
end)

g:DestroyGui()
