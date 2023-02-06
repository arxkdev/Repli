local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Common = ReplicatedStorage:WaitForChild("Common");
local Repli = require(Common:WaitForChild("Repli"));

-- Define our default data for TestPlayerData
local Default = {
    ["Gems"] = 0;
    ["Level"] = 1;
};

-- Create our new values
local TestPlayerData = Repli.createValue("TestPlayerData", Default);
local Test2 = Repli.createValue("Test2", 3333);

-- Subscribe to the value on the server
Test2:subscribe(function(value)
    print("Server subscribe: Test2 changed to " .. value);
end)

-- New event for increasing gems for specific player
ReplicatedStorage.RemoteEvent.OnServerEvent:Connect(function(player)
    local new = (TestPlayerData:getValueForClient(player));
    new.Gems = new.Gems + 1;

    -- print(`Gems value for {player.Name} is {new}`);
    TestPlayerData:setValueForClient(player, new);
end)

-- Testing the global value every couple seconds
task.wait(5);
Test2:setValue(5);
task.wait(5)
Test2:setValue(666);
print(Test2:getValue())

-- Set the Test2 specific value for each player
Players.PlayerAdded:Connect(function(player)
    Test2:setValueForClient(player, 5);
    task.wait(5)
    Test2:setValueForClient(player, 666);
end)