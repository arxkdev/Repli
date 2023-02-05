---
sidebar_position: 3
---

# Examples

## Simple Example (Server)
```lua
local Players = game:GetService("Players");
local Repli = require(game:GetService("ReplicatedStorage").Repli);

local replicatedValue = Repli.createValue("ReplicatedValue", 0);
local replicatedTable = Repli.createTable("ReplicatedTable", {1, 2, 3});
print(replicatedValue:getValue()); -- 0

-- Set the value for all clients to 5
replicatedValue:setValue(5);

-- Get the value for all clients
local value = replicatedValue:getValue();
print(value); -- 5

-- Individually set the value for each client
Players.PlayerAdded:Connect(function(player)
    -- Set the value for a specific client
    replicatedTable:setValueForClient(player, {1, 2, 3, 4});

    -- Get the value for a specific client
    local value = replicatedTable:getValueForClient(player);
    print(value); -- {1, 2, 3, 4}
end);
```

## Simple Example (Client)
```lua
local Players = game:GetService("Players");
local Repli = require(game:GetService("ReplicatedStorage").Repli);

-- Get the value from the server
local replicatedValue = Repli.fromValue("ReplicatedValue");

-- Write a callback to be called when the value changes
local function onValueChanged(newValue)
    -- Will initially print 0, but will print 5 after the server sets the value
    print(newValue); -- 5
end

-- Add the callback to the subscriber method
replicatedValue:subscribe(onValueChanged);
```
