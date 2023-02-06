-- Here's a quick example of something like a global market for the server that is replicated to all clients.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Common = ReplicatedStorage:WaitForChild("Common");
local Repli = require(Common:WaitForChild("Repli"));

local DefaultMarket = {
    ["Wood"] = 100,
    ["Stone"] = 100,
    ["Iron"] = 100,
    ["Gold"] = 100,
    ["Diamond"] = 100,
    ["Obsidian"] = 100,
};

local Market = Repli.createValue("Market", DefaultMarket);

local function updateMarket()
    -- Go through the market and update with random values
    Market:updateValue(function(oldMarket)
        local newMarket = oldMarket or DefaultMarket;
        for resource, value in pairs(newMarket) do
            newMarket[resource] = value + math.random(-100, 100);
        end;
        return newMarket;
    end);
end

-- Update periodically
local function updatePeriodically(interval, callback)
    while (task.wait(interval)) do
        callback();
    end;
end
task.spawn(updatePeriodically, 35, updateMarket);