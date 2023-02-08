local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Lib = ReplicatedStorage:WaitForChild("lib");
local Repli = require(Lib:WaitForChild("Repli"));

local Market = Repli.fromValue("Market");

local function marketChanged(newValue)
    print("Market changed!", newValue);
end

Market:subscribe(marketChanged);