local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Common = ReplicatedStorage:WaitForChild("Common");
local Repli = require(Common:WaitForChild("Repli"));

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local ScreenGui = PlayerGui:WaitForChild("ScreenGui");

local TestPlayerData = Repli.fromValue("TestPlayerData");
local Test2 = Repli.fromValue("Test2");

-- Subscribe to it and print the value, and also update the text label
local function subscribedFunctionTestPlayerdData(value)
    -- print("Client subscribed to TestPlayerData: ", value);

    print("Player gems:", value.Gems);
    ScreenGui.TextLabel.Text = "Gems: " .. value.Gems;
end
TestPlayerData:subscribe(subscribedFunctionTestPlayerdData);

local function subscribedFunctionTest2(value)
    print("Client subscribed to Test2: ", value);
end
Test2:subscribe(subscribedFunctionTest2);

-- TextButton is a button that fires the event
ScreenGui:WaitForChild("TextButton").MouseButton1Click:Connect(function()
    ReplicatedStorage.RemoteEvent:FireServer();
end)