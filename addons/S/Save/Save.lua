--[[
	Save
	Addon for automatically saving you character on server
	Author: BalakinUser
	License: GPLv2
]]--

local nextTime = 0;
local nextTime2 = 300;

function Save_OnLoad()
	SaveFrame:SetScript("OnUpdate", Save_OnUpdate);
	nextTime = math.ceil(GetTime() + nextTime2);
	SaveFrame:Show();
end

function Save_OnUpdate()
	if (math.ceil(GetTime()) == nextTime) then
		SendChatMessage(".save", "GUILD");
		nextTime = math.ceil(GetTime() + nextTime2);
	end
end
