-- Here's a quick example of something like a global market for the server that is replicated to all clients.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Common = ReplicatedStorage:WaitForChild("Common");
local Repli = require(Common:WaitForChild("Repli"));

local Market = Repli.createValue("Market", {
    ["Gold"] = 1000;
    ["Wood"] = 1000;
    ["Stone"] = 1000;
    ["Iron"] = 1000;
    ["Food"] = 1000;
});

local function updateMarket()
    -- Go through the market and update with random values
    local previousMarket = Market:getValue();
    local newMarket = {};
    for resource, value in pairs(previousMarket) do
        newMarket[resource] = value + math.random(-100, 100);
    end
    Market:setValue(newMarket);
end

-- Update periodically
local function updatePeriodically(interval, callback)
    while (task.wait(interval)) do
        callback();
    end;
end
task.spawn(updatePeriodically, 35, updateMarket);