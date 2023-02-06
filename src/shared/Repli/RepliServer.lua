-- Server side of the replication system
local Players = game:GetService("Players");

-- Dependencies
local Signal = require(script.Parent.Signal);

--[=[
    @within RepliServer
    @readonly
    @prop value any

    The value of the created class
]=]
--[=[
    @within RepliServer
    @readonly
    @prop remoteEvent any

    The remote event for the created value/class.
]=]
--[=[
    @class RepliServer
    @server
]=]
local RepliServer = {};
RepliServer.__index = RepliServer;

-- Example
--[[
local Repli = require(ReplicatedStorage.Repli)

local Default = 0;
-- Give it a class name and a default value or nil
local Value = Repli.createValue("TestValue", Default);

-- Set value
Value:setValue(5) -- Will be replicated to all clients

-- Set value for a specific client
Value:setValueForClient(player, 10) -- Will be replicated to only that client

-- Get value
print(Value:getValue()) -- Will print the value of the server (every client will have the same value)

-- Get value for a specific client
print(Value:getValueForClient(player)) -- Will print the value of the client

]]

-- Contains all the remotes
local _R = Instance.new("Folder")
_R.Name = "_R";
_R.Parent = script.Parent;

-- Remote for the client saying they have a class ready
local classReady = Instance.new("RemoteEvent");
classReady.Name = "_RepliClassReady";
classReady.Parent = script.Parent;

-- Remote for the client saying they want to connect to a class
local classConnect = Instance.new("RemoteEvent");
classConnect.Name = "_RepliConnect";
classConnect.Parent = script.Parent;

--[=[
    Creates a new value that can be replicated to the clients

    @param className string
    @param value any
    @return RepliServer
]=]
function RepliServer.createValue(className, value)
    local self = setmetatable({}, RepliServer);
    -- Value globally
    self._value = value;
    -- Value for specific clients
    self._clientValues = {};
    -- Signal for when the global value changes
    self._valueChanged = Signal.new();
    self._className = className;
    self._playerRemoving = nil;
    self._R = _R;

    -- Create a remote event for the clients to send data to the server
    local remoteEvent = Instance.new("RemoteEvent");
    remoteEvent.Name = "RepliEvent_" .. className;
    remoteEvent.Parent = self._R;

    self._remoteEvent = remoteEvent;

    self._playerRemoving = Players.PlayerRemoving:Connect(function(player)
        self:removeClient(player);
    end);

    -- A client has said they have a class ready
    classReady.OnServerEvent:Connect(function(player, clientClassReady)
        if (clientClassReady == className) then
            -- Adds a client for the class
            self:addClient(player);
        end;
    end);

    -- Return self
    return self;
end

-- Gets the changed signal for the global value
--[=[
    Gets the changed signal for the global value

    :::note
    You can only subscribe to global values ie. using ``value:setValue(x)`` and not ``value:setValueForClient(player, x)``
    :::

    @return Signal
]=]
function RepliServer:subscribe(callback)
    self._valueChanged:Connect(callback);
end

-- Set value for all clients
--[=[
    Sets the value for all clients

    @param value any
]=]
function RepliServer:setValue(value)
    self._value = value;
    self._remoteEvent:FireAllClients(value);
    self._valueChanged:Fire(value);
end

-- Set value for a specific client
--[=[
    Sets the value for a specific client

    @param client Player
    @param value any
]=]
function RepliServer:setValueForClient(client, value)
    self._clientValues[client] = value;
    self._remoteEvent:FireClient(client, value);
end

-- Set value for a list of clients
--[=[
    Sets the value for a list of clients

    @param clients table
    @param value any
]=]
function RepliServer:setValueForList(clients, value)
    for _, client in clients do
        self:setValueForClient(client, value);
    end;
end

-- Set a value for a filter of clients with a predicate
--[=[
    Sets the value for a filter of clients

    @param predicate function
    @param value any
]=]
function RepliServer:setValueForFilter(predicate, value)
    for client, _ in self._clientValues do
        if (predicate(client)) then
            self:setValueForClient(client, value);
        end;
    end;
end
-- value:setValueForFilter(function(client)
--     return (client.Name == "Player1");
-- end, 10);

-- Update a value for all clients
--[=[
    Updates the value for all clients

    @param transformerFunction function
]=]
function RepliServer:updateValue(transformerFunction)
    local newValue = transformerFunction(self._value);
    self:setValue(newValue);
end
-- value:updateValue(function(oldValue)
--     return oldValue + 1;
-- end);

-- Update a value for a specific client
--[=[
    Updates the value for a specific client

    @param client Player
    @param transformerFunction function
]=]
function RepliServer:updateValueForClient(client, transformerFunction)
    local newValue = transformerFunction(self._clientValues[client]);
    self:setValueForClient(client, newValue);
end
-- value:updateValueForClient(player1, function(oldValue)
--     return oldValue + 1;
-- end);

-- Update a value for a list of clients
--[=[
    Updates the value for a list of clients

    @param clients table
    @param transformerFunction function
]=]
function RepliServer:updateValueForList(clients, transformerFunction)
    for _, client in clients do
        local newValue = transformerFunction(self._clientValues[client]);
        self:updateValueForClient(client, newValue);
    end;
end
-- value:updateValueForList({player1, player2}, function(oldValue)
--     return oldValue + 1;
-- end);

-- Get value for all clients
--[=[
    Gets the value for all clients

    @return any
]=]
function RepliServer:getValue()
    return self._value;
end

-- Get value for a specific client
--[=[
    Gets the value for a specific client

    @param client Player
    @return any
]=]
function RepliServer:getValueForClient(client)
    return self._clientValues[client];
end

-- Clear a value for a specific client
--[=[
    Clears the value for a specific client

    @param client Player
]=]
function RepliServer:clearValueForClient(client)
    if (not self._clientValues[client]) then
        return;
    end;

    self._clientValues[client] = nil;
    self._remoteEvent:FireClient(client, self.value);
end

-- Clear a value for a list of clients
--[=[
    Clears the value for a list of clients

    @param clients table
]=]
function RepliServer:clearValueForList(clients)
    for _, client in clients do
        self:clearValueForClient(client);
    end;
end

-- Clear a value for all clients
--[=[
    Clears the value for all clients
]=]
function RepliServer:clearValue()
    table.clear(self._clientValues);
    self.remoteEvent:FireAllClients(self._value);
end

-- Clear value for a filter of clients with a predicate
--[=[
    Clears the value for a filter of clients

    @param predicate function
]=]
function RepliServer:clearValueForFilter(predicate)
    for client, _ in self._clientValues do
        if (predicate(client)) then
            self:clearValueForClient(client);
        end;
    end;
end

-- Adding a client to the class
--[=[
    Adds a client to the class

    @param client Player
]=]
function RepliServer:addClient(client)
    self._clientValues[client] = self._value;

    -- Tell the client they are connected to the class
    classConnect:FireClient(client, self._className, self._value);
end

-- Removing a client from the class
--[=[
    Removes a client from the class

    @param client Player
]=]
function RepliServer:removeClient(client)
    if (self._clientValues[client]) then
        self._clientValues[client] = nil;
    end;
end

-- Destroy the class
--[=[
    Destroys the class
]=]
function RepliServer:destroy()
    table.clear(self._clientValues);
    self._remoteEvent:Destroy();
    self._playerRemoving:Disconnect();
    self._valueChanged:Destroy();
end

return table.freeze(RepliServer);