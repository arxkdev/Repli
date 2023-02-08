local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Lib = ReplicatedStorage:WaitForChild("lib");
local Repli = require(Lib:WaitForChild("Repli"));

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local ScreenGui = PlayerGui:WaitForChild("ScreenGui");

local TestPlayerData = Repli.fromValue("TestPlayerData");
local Test2 = Repli.fromValue("Test2");

-- Subscribe to it and print the value, and also update the text label
local function subscribedFunctionTestPlayerdData(value)
    print("Player gems:", value.Gems);
    ScreenGui.TextLabel.Text = "Gems: " .. value.Gems;
end
TestPlayerData:subscribe(subscribedFunctionTestPlayerdData);

-- Subscribe to the test value and print the value
local function subscribedFunctionTest2(value)
    print("Test2: ", value);
end
Test2:subscribe(subscribedFunctionTest2);

-- TextButton is a button that fires the event
ScreenGui:WaitForChild("TextButton").MouseButton1Click:Connect(function()
    ReplicatedStorage.RemoteEvent:FireServer();
end)