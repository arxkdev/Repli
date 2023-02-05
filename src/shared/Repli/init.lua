local RunService = game:GetService("RunService");

-- Require RepliClient or RepliServer depending on the environment
if (RunService:IsClient()) then
    return require(script.RepliClient);
else
    return require(script.RepliServer);
end