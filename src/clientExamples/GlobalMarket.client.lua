local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Common = ReplicatedStorage:WaitForChild("Common");
local Repli = require(Common:WaitForChild("Repli"));

local Market = Repli.fromValue("Market");

local function marketChanged(newValue)
    print("Market changed!", newValue);
end

Market:subscribe(marketChanged);