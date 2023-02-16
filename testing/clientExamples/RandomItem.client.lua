local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");

local Lib = ReplicatedStorage:WaitForChild("lib");
local Repli = require(Lib:WaitForChild("Repli"));

local Player = Players.LocalPlayer;
local PlayerGui = Player:WaitForChild("PlayerGui");
local ScreenGui = PlayerGui:WaitForChild("ScreenGui");
local Template = ReplicatedStorage.RandomItem;

-- Reconcile the items in the frame
local function Reconcile(items)
    for _, item in pairs(ScreenGui.RandomItemFrame.Items:GetChildren()) do
        if (item:IsA("Frame") and items[tostring(item.Name)] == nil) then
            item:Destroy();
        end;
    end;
end

-- When the random items change, update the frame
local function randomItemsChanged(newValue)
    print(newValue);

    -- Reconcile the items in the frame
    Reconcile(newValue);

    -- Add new items
    for id, itemName in newValue do
        if (ScreenGui.RandomItemFrame.Items:FindFirstChild(id)) then
            continue;
        end;

        local newFrame = Template:Clone();
        newFrame.Name = id;
        newFrame.TextLabel.Text = itemName;
        newFrame.Parent = ScreenGui.RandomItemFrame.Items;
    end;
end

Repli.listenForCreation("RandomItems", function(randomItems)
    -- We don't actually need to put this function here, but we can if we want to listen for the initial value
    randomItemsChanged(randomItems.value);

    -- Here's our subscribe function for listening to only further changes
    randomItems:subscribe(randomItemsChanged);
end);

-- When the player clicks the button, add a random item
ScreenGui.RandomItemFrame.AddRandomItem.MouseButton1Click:Connect(function()
    ReplicatedStorage.AddRandomItem:FireServer();
end);

