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
    @class RepliServer
    @server
]=]
local RepliServer = {};
RepliServer.__index = RepliServer;

-- Types
type Repli = typeof(RepliServer.createValue("", nil));

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

-- Helper Functions
-- Function for checking for table equality
local function CheckTableEquality(t1: {any}, t2: {any}): boolean
	-- If t1 and t2 are not tables, simply compare them
	if (type(t1) ~= "table" or type(t2) ~= "table") then
		return (t1 == t2);
	end;

	-- If the tables have different lengths, they are not the same
	if (#t1 ~= #t2) then
		return false;
	end;

	-- Compare the elements in the tables
	for k, v1 in pairs(t1) do
		local v2 = t2[k];
		
		if (not CheckTableEquality(v1, v2)) then
			return false;
		end;
	end;

	return true;
end

--[=[
    Creates a new value that can be replicated to the clients

    Example:
    ```lua
    local testValue = Repli.createValue("TestValue", 0);
    ```

    @param className string
    @param value any
    @return RepliServer
]=]
function RepliServer.createValue(className: string, value: any): Repli
    local self = setmetatable({ }, RepliServer);
    -- Value globally
    self._value = value;
    -- Value for specific clients
    self._clientValues = {};
    -- Signal for when the global value changes
    self._valueChanged = Signal.new();
    self._className = className;
    self._playerRemoving = nil;
    self._R = _R;

    -- Check if the class name is already taken, if it is, throw an error
    if (self._R:FindFirstChild("RepliEvent_" .. className)) then
        error([[The classname "]] .. className .. [[" has already been created, please use a different classname.]]);
    end;

    -- Create a remote event for the clients to send data to the server
    local remoteEvent = Instance.new("RemoteEvent");
    remoteEvent.Name = "RepliEvent_" .. className;
    remoteEvent.Parent = self._R;

    self._remoteEvent = remoteEvent;

    -- Setup our playerremoving event for removing clients
    self._playerRemoving = Players.PlayerRemoving:Connect(function(player)
        self:removeClient(player);
    end);

    -- A client has said they have a class ready
    classReady.OnServerEvent:Connect(function(player, clientClassReady: string)
        if (clientClassReady == className) then
            -- Adds a client for the class
            self:addClient(player);
        end;
    end);

    -- Return self
    return self;
end

-- This is a function for sanitizing a value, so that it can be sent to the client efficiently
-- It'll mainly check for same values and do a recursion check for tables for looking at same values
function RepliServer:SanitizeValue(value: any, value2: any): boolean
    -- Check if the value is a table and it's the same as the value2
    if (typeof(value) == "table" and CheckTableEquality(value, value2)) then
        return false;
    end;

    -- Check for regular values now
    if (value == value2) then
        return false;
    end;

    -- Return true if it's not the same
    return true;
end

-- Gets the changed signal for the global value
--[=[
    Gets the changed signal for the global value.

    Example:
    ```lua
    testValue:subscribe(function(newValue)
        print(newValue);
    end);
    ```

    :::caution
    You can only subscribe to global values ie. using ``value:setValue(x)`` and not ``value:setValueForClient(player, x)``
    :::

    @return Signal
]=]
function RepliServer:subscribe(callback: (newValue: any) -> ())
    self._valueChanged:Connect(callback);
end

-- Set value for all clients
--[=[
    Sets the value for all clients.

    Example:
    ```lua
    testValue:setValue(5);
    ```

    @param value any
]=]
function RepliServer:setValue(value: any)
    self._value = value;
    self._remoteEvent:FireAllClients(value);
    self._valueChanged:Fire(value);
end

-- Set value for a specific client
--[=[
    Sets the value for a specific client.

    Example:
    ```lua
    testValue:setValueForClient(player, 5);
    ```

    @param client Player
    @param value any
]=]
function RepliServer:setValueForClient(client: Player, value: any)
    self._clientValues[client] = value;
    self._remoteEvent:FireClient(client, self._clientValues[client]);
end

-- Set value for a list of clients
--[=[
    Sets the value for a list of clients.

    Example:
    ```lua
    testValue:setValueForList({player1, player2}, 5);
    ```

    @param clients table
    @param value any
]=]
function RepliServer:setValueForList(clients: {Player}, value: any)
    for _, client in clients do
        self:setValueForClient(client, value);
    end;
end

-- Set a value for a filter of clients with a predicate
--[=[
    Sets the value for a filter of clients.

    Example:
    ```lua
    testValue:setValueFilter(function(client)
        return (client.Name == "Player1");
    end, 10);
    ```

    @param value any
]=]
function RepliServer:setValueFilter(predicate: (Player) -> (boolean), value: any)
    for client, _ in self._clientValues do
        if (predicate(client)) then
            self:setValueForClient(client, value);
        end;
    end;
end

-- Update a value for all clients
--[=[
    Updates the value for all clients.

    Example:
    ```lua
    testValue:updateValue(function(oldValue)
        return oldValue + 1;
    end);
    ```
]=]
function RepliServer:updateValue(transformerFunction: (oldValue: any) -> ())
    local newValue = transformerFunction(self._value);
    self:setValue(newValue);
end

-- Update a value for a specific client
--[=[
    Updates the value for a specific client.

    Example:
    ```lua
    testValue:updateValueForClient(player, function(oldValue)
        return oldValue + 1;
    end);
    ```

    @param client Player
]=]
function RepliServer:updateValueForClient(client: Player, transformerFunction: (oldValue: any) -> ())
    local oldValue = table.clone(self._clientValues[client]);
    local newValue = transformerFunction(oldValue);
    self:setValueForClient(client, newValue);
end

-- Update a value for a list of clients
--[=[
    Updates the value for a list of clients.

    Example:
    ```lua
    testValue:updateValueForList({player1, player2}, function(oldValue)
        return oldValue + 1;
    end);
    ```

    @param clients table
]=]
function RepliServer:updateValueForList(clients: {Player}, transformerFunction: (oldValue: any) -> ())
    for _, client in clients do
        local oldValue = table.clone(self._clientValues[client]);
        local newValue = transformerFunction(oldValue);
        self:updateValueForClient(client, newValue);
    end;
end

-- Get value for all clients
--[=[
    Gets the value for all clients.

    Example:
    ```lua
    local gotValue = testValue:getValue();
    ```

    @return any
]=]
function RepliServer:getValue(): any
    return self._value;
end

-- Get value for a specific client
--[=[
    Gets the value for a specific client.

    Example:
    ```lua
    local gotValueForPlayer = testValue:getValueForClient(player);
    ```

    @param client Player
    @return any
]=]
function RepliServer:getValueForClient(client: Player): any
    return self._clientValues[client];
end

-- Clear a value for a specific client
--[=[
    Clears the value for a specific client.

    Example:
    ```lua
    testValue:clearValueForClient(player);
    ```

    @param client Player
]=]
function RepliServer:clearValueForClient(client: Player)
    if (not self._clientValues[client]) then
        return;
    end;

    self._clientValues[client] = nil;
    self._remoteEvent:FireClient(client, self.value);
end

-- Clear a value for a list of clients
--[=[
    Clears the value for a list of clients.

    Example:
    ```lua
    testValue:clearValueForList({player1, player2});
    ```
]=]
function RepliServer:clearValueForList(clients: {Player})
    for _, client in clients do
        self:clearValueForClient(client);
    end;
end

-- Clear a value for all clients
--[=[
    Clears the value for all clients.

    Example:
    ```lua
    testValue:clearValue();
    ```
]=]
function RepliServer:clearValue()
    table.clear(self._clientValues);
    self._value = nil;
    self.remoteEvent:FireAllClients(self._value);
end

-- Clear value for a filter of clients with a predicate
--[=[
    Clears the value for a filter of clients.

    Example:
    ```lua
    testValue:clearValueFilter(function(client)
        return (client.Name == "Player1");
    end);
    ```
]=]
function RepliServer:clearValueFilter(predicate: (Player) -> (boolean))
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
function RepliServer:addClient(client: Player)
    self._clientValues[client] = self._value;

    -- Tell the client they are connected to the class
    classConnect:FireClient(client, self._className, self._value);

    -- Tell the client the value of the class
    self:setValueForClient(client, self._value);
end

-- Removing a client from the class
--[=[
    Removes a client from the class

    @param client Player
]=]
function RepliServer:removeClient(client: Player)
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

return table.freeze(RepliServer) :: typeof(RepliServer);