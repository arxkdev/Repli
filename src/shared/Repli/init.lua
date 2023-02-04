local RunService = game:GetService("RunService");

if (RunService:IsClient()) then
    return require(script.RepliClient);
else
    return require(script.RepliServer);
end