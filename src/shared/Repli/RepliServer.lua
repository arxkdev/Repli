-- Server side of the replication system
local Players = game:GetService("Players");
local Promise = require(script.Parent.Promise);
local Signal = require(script.Parent.Signal);

--[=[
    @within RepliServer
    @prop value any

    The value of the created class
]=]
--[=[
    @within RepliServer
    @prop remoteEvent any

    The remote event for the created value/class.
]=]
--[=[
    @class RepliServer
    @server
]=]
local RepliServer = {}
RepliServer.__index = RepliServer

local insert = table.insert;

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

-- Helper Functions
local function filter(t, predicate)
    local new = {};
    for _, v in t do
        if (predicate(v)) then
            insert(new, v);
        end;
    end;
    return new;
end;

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
    self.value = value;
    -- Value for specific clients
    self.clientValues = {};
    self.className = className;
    self.playerRemoving = nil;
    self._R = _R;

    -- Create a remote event for the clients to send data to the server
    local remoteEvent = Instance.new("RemoteEvent");
    remoteEvent.Name = "RepliEvent_" .. className;
    remoteEvent.Parent = self._R;

    self.remoteEvent = remoteEvent;

    self.playerRemoving = Players.PlayerRemoving:Connect(function(player)
        self:removeClient(player);
    end);

    -- A client has said they have a class ready
    classReady.OnServerEvent:Connect(function(player, classReady)
        if (classReady == className) then
            -- Adds a client for the class
            self:addClient(player);
        end
    end);

    -- Return self
    return self;
end

-- Set value for all clients
--[=[
    Sets the value for all clients

    @param value any
]=]
function RepliServer:setValue(value)
    self.value = value;
    self.remoteEvent:FireAllClients(value);
end

-- Set value for a specific client
--[=[
    Sets the value for a specific client

    @param client Player
    @param value any
]=]
function RepliServer:setValueForClient(client, value)
    self.clientValues[client] = value;
    self.remoteEvent:FireClient(client, value);
end

-- Set value for a list of clients
--[=[
    Sets the value for a list of clients

    @param clients table
    @param value any
]=]
function RepliServer:setValueForList(clients, value)
    for _, client in clients do
        self.remoteEvent:FireClient(client, value);
    end;
end

-- Get value for all clients
--[=[
    Gets the value for all clients

    @return any
]=]
function RepliServer:getValue()
    return self.value;
end

-- Get value for a specific client
--[=[
    Gets the value for a specific client

    @param client Player
    @return any
]=]
function RepliServer:getValueForClient(client)
    return self.clientValues[client];
end

-- Clear a value for a specific client
--[=[
    Clears the value for a specific client

    @param client Player
]=]
function RepliServer:clearValueForClient(client)
    if (not self.clientValues[client]) then
        return
    end;

    self.clientValues[client] = nil;
    self.remoteEvent:FireClient(client, self.value);
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
    table.clear(self.clientValues);
    self.remoteEvent:FireAllClients(self.value);
end

-- Adding a client to the class
--[=[
    Adds a client to the class

    @param client Player
]=]
function RepliServer:addClient(client)
    self.clientValues[client] = self.value;

    -- Tell the client they are connected to the class
    classConnect:FireClient(client, self.className, self.value);
end

-- Removing a client from the class
--[=[
    Removes a client from the class

    @param client Player
]=]
function RepliServer:removeClient(client)
    if (self.clientValues[client]) then
        self.clientValues[client] = nil;
    end;
end

-- Destroy the class
--[=[
    Destroys the class
]=]
function RepliServer:destroy()
    table.clear(self.clientValues);
    self.remoteEvent:Destroy();
    self.playerRemoving:Disconnect();
end

return table.freeze(RepliServer);