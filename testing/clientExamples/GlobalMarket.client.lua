local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Lib = ReplicatedStorage:WaitForChild("lib");
local Repli = require(Lib:WaitForChild("Repli"));

local function furtherMarketChanges(newValue)
    print("Market changed!", newValue);
end

-- listenForCreation is a new signal that will only fire once on start and will give a market object that you can subscribe to
-- this is still a work in progress
Repli.listenForCreation("Market", function(market)
    -- value created
    print("Market created!", market.value);

    -- check if the value is ready (will be)
    print(market:isReady());

    -- listen for further changes
    market:subscribe(furtherMarketChanges);
end);