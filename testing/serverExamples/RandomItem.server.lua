-- Here's a quick example of a list of random items that you can add, only replicated per client.
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");

local Lib = ReplicatedStorage:WaitForChild("lib");
local Repli = require(Lib:WaitForChild("Repli"));

local DefaultRandomItems = {
    
};

local randomItems = Repli.createValue("RandomItems", DefaultRandomItems);
local arrayOfItems = {"Peach", "Melon", "Apple", "Banana", "Orange", "Grapes", "Watermelon", "Strawberry"};

local function UUID()
    return HttpService:GenerateGUID(false);
end

local function addRandomItem()
    local randomItem = arrayOfItems[math.random(1, #arrayOfItems)];

    randomItems:updateValue(function(oldItems)
        local newItems = oldItems or DefaultRandomItems;
        newItems[UUID()] = randomItem;
        return newItems;
    end);
end

ReplicatedStorage.AddRandomItem.OnServerEvent:Connect(addRandomItem);