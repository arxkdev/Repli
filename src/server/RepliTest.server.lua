local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Common = ReplicatedStorage:WaitForChild("Common");
local Repli = require(Common:WaitForChild("Repli"));

local Default = {
    ["Gems"] = 0;
    ["Level"] = 1;
};
local TestPlayerData = Repli.createValue("TestPlayerData", Default);
local Test2 = Repli.createValue("Test2", 3333);

ReplicatedStorage.RemoteEvent.OnServerEvent:Connect(function(player)
    local new = (TestPlayerData:getValueForClient(player));
    new.Gems = new.Gems + 1;

    -- print(`Gems value for {player.Name} is {new}`);
    TestPlayerData:setValueForClient(player, new);
end)

task.wait(5);
Test2:setValue(5);
task.wait(5)
Test2:setValue(666);
print(Test2:getValue())

-- Players.PlayerAdded:Connect(function(player)
--     Test2:setValueForClient(player, 5);
--     task.wait(5)
--     Test2:setValueForClient(player, 666);
-- end)