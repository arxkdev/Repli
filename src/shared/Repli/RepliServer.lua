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
    @class RepliServer
]=]
local RepliServer = {}
RepliServer.__index = RepliServer

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
    self.value = value;
    self.clients = {};
    self.className = className;
    self._R = _R;

    -- Create a remote event for the clients to send data to the server
    local remoteEvent = Instance.new("RemoteEvent");
    remoteEvent.Name = "RepliEvent_" .. className;
    remoteEvent.Parent = self._R

    Players.PlayerRemoving:Connect(function(player)
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

-- Adding a client to the class
--[=[
    Adds a client to the class

    @param client Player
]=]
function RepliServer:addClient(client)
    self.clients[client] = self.value;

    -- Tell the client they are connected to the class
    classConnect:FireClient(client, self.className, self.value);
end

-- Removing a client from the class
--[=[
    Removes a client from the class

    @param client Player
]=]
function RepliServer:removeClient(client)
    if (self.clients[client]) then
        self.clients[client] = nil;
    end;
end

-- Set value for all clients
--[=[
    Sets the value for all clients

    @param value any
]=]
function RepliServer:setValue(value)
    self.value = value;

    local remoteEvent = self._R:FindFirstChild("RepliEvent_" .. self.className);
    remoteEvent:FireAllClients(value);
end

-- Set value for a specific client
--[=[
    Sets the value for a specific client

    @param client Player
    @param value any
]=]
function RepliServer:setValueForClient(client, value)
    self.clients[client] = value;

    local remoteEvent = self._R:FindFirstChild("RepliEvent_" .. self.className);
    remoteEvent:FireClient(client, value);
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
    return self.clients[client];
end

return table.freeze(RepliServer);