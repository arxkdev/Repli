local Promise = require(script.Parent.Promise);
local Signal = require(script.Parent.Signal);

-- Client side of the replication system
--[=[
    @within RepliClient
    @readonly
    @prop isReady boolean

    Whether or not the client is ready to receive data
]=]
--[=[
    @within RepliClient
    @prop value any

    The current value of the class
]=]
--[=[
    @class RepliClient
    @client
]=]
local RepliClient = {};
RepliClient.__index = RepliClient;

-- Example
--[[
    local Repli = require(ReplicatedStorage.Repli)
    local Value = Repli.fromClass("TestValue")

    Value:subscribe(function(value)
        print(value)
    end)

    Value:get() -- returns the value
]]

-- Connect to the server
local NewClassConnected = Signal.new();
local ClassesConnected = {};
local ClassConnectRemote = script.Parent._RepliConnect;
ClassConnectRemote.OnClientEvent:Connect(function(classConnectedTo, initialValue)
    -- Update classes connected to and fire the signal with the initial value
    ClassesConnected[classConnectedTo] = initialValue;
    NewClassConnected:Fire(classConnectedTo, initialValue);
end);

-- Wait for a class to be connected to
function WaitForClass(class)
    return Promise.new(function(resolve)
        if (ClassesConnected[class]) then
            resolve(ClassesConnected[class]);
            return;
        end;

        local connection
        connection = NewClassConnected:Connect(function(classConnectedTo, initialValue)
            if (classConnectedTo ~= class) then
                return;
            end;

            connection:Disconnect();
            resolve(initialValue);
        end);
    end);
end

-- Create a new RepliClient
--[=[
    Retrieves a new value (class) from the server and returns a RepliClient.

    Example:
    ```lua
    local testValue = Repli.fromValue("TestValue");
    ```

    @param class string
    @return RepliClient
]=]
function RepliClient.fromValue(class)
    local self = setmetatable({}, RepliClient);
    self._isReady = false;
    self._changedSignal = Signal.new();
    self._value = nil;
    self._R = script.Parent._R;
    self._className = class;

    -- Tell server we are ready to receive data and whatnot
    local ClassReadyRemote = script.Parent._RepliClassReady;
    ClassReadyRemote:FireServer(class);

    -- Wait for the server to allow us to connect to the class
    WaitForClass(class):await();
    self._remoteEvent = self._R:FindFirstChild("RepliEvent_" .. class);
    self._value = ClassesConnected[class];
    self._isReady = true;

    -- Once we are connected, we can start listening for changes
    self:onReady():andThen(function()
        -- Listen for further changes
        self._furtherChanges = self._remoteEvent.OnClientEvent:Connect(function(value)
            if (value == self._value) then
                return;
            end;

            -- print(value);
            self._value = value;
            self._changedSignal:Fire(value);
        end);
    end);
    
    return self;
end

-- Listen for a class to be created and return a RepliClient with the given class name
--[=[
    Example:
    ```lua
    Repli.listenForCreation("TestValue", function(testValue)
        testValue:subscribe(function(newValue)
            print(newValue);
        end);
    end);
    ```

    @param class string
    @param callback function
    @return RepliClient
]=]
function RepliClient.listenForCreation(class, callback)
    local classObject = RepliClient.fromValue(class);

    -- Initial value
    classObject:onReady():andThen(function()
        callback(classObject);
    end);

    -- They can attach to the classObject's methods to listen for changes with subscribe
    return classObject;
end

-- Check if this client class is ready
--[=[
    Returns true if the client is ready to receive data.

    Example:
    ```lua
    if (testValue:isReady()) then
        print(testValue:getValue());
    end;
    ```

    :::caution
    This will return false if the client is not ready. Consider using ``onReady`` if you want to wait for the value to be ready.
    :::

    @return boolean
]=]
function RepliClient:isReady()
    return self._isReady;
end

-- Wait for the remote to be ready and fire the initial value
--[=[
    Returns a promise that resolves when the client is ready.

    Example:
    ```lua
    testValue:onReady():andThen(function()
        print(testValue:getValue());
    end);
    ```

    @return Promise<any>
]=]
function RepliClient:onReady()
    if (self._isReady) then
        Promise.resolve(self._value);
    end;

    return Promise.fromEvent(self._remoteEvent.OnClientEvent, function(value)
        self._value = value;
        self._isReady = true;
        return true;
    end):_andThen(function()
        return self._value;
    end);
end

-- Subscribe to changes
-- Does initial value and any further changes
--[=[
    Subscribes to changes.

    Example:
    ```lua
    testValue:subscribe(function(newValue)
        print(newValue);
    end);
    ```

    @param callback function
    @return RBXScriptConnection
]=]
function RepliClient:subscribe(callback)
    -- task.defer(function()
    --     if (self._isReady) then
    --         callback(self._value);
    --     end;
    -- end);

    return self._changedSignal:Connect(callback);
end

-- Get the current value
--[=[
    Returns the current value

    Example:
    ```lua
    print(testValue:getValue());
    ```

    :::caution
    This will return nil if the client is not ready. Consider using ``onReady`` if you want to wait for the value to be ready.
    :::

    @return any
]=]
function RepliClient:getValue()
    return self._value;
end

return table.freeze(RepliClient);