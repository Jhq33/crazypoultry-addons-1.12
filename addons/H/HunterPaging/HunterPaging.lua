local RaptorStrikeSlot, ArcaneShotSlot
local _,class = UnitClass("player")
local Status = 1
local HPScanTip = CreateFrame("GameTooltip", "HPScanTip", nil, "GameTooltipTemplate")
HPScanTip:SetOwner(WorldFrame, "ANCHOR_NONE")
local HPframe = CreateFrame("Frame")
HPframe:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
HPframe:RegisterEvent("PLAYER_ENTERING_WORLD")

local function ScanActionBar()
	RaptorStrikeSlot = nil
	ArcaneShotSlot = nil
	for i=1, 120 do
		HPScanTip:ClearLines()
		HPScanTip:SetAction(i)
		if HPScanTipTextLeft1 and HPScanTipTextLeft1:GetText() == "Mongoose Bite" then
			RaptorStrikeSlot = i
		elseif HPScanTipTextLeft1 and HPScanTipTextLeft1:GetText() == "Arcane Shot" then
			ArcaneShotSlot = i
		end
	end
end

local function TestRange()
	if not RaptorStrikeSlot then
		return 1
	end
	if IsActionInRange(RaptorStrikeSlot) == 1 and IsActionInRange(ArcaneShotSlot) == 0 then
		return
	else
		return 1
	end
end

local function PageActionBar(inRange)
	if inRange then
		CURRENT_ACTIONBAR_PAGE = 1
		ChangeActionBarPage()
	else
		CURRENT_ACTIONBAR_PAGE = 9
		ChangeActionBarPage()
	end
end

local function onEvent()
	if event == "ACTIONBAR_SLOT_CHANGED" then
		ScanActionBar()
	elseif event == "PLAYER_ENTERING_WORLD" then
		ScanActionBar()
	end
end

local function onUpdate()
	if TestRange() then
		if not Status then
			PageActionBar(1)
			Status = 1
		end
	elseif Status then
		PageActionBar(nil)
		Status = nil
	end
end

if class == "HUNTER" then
	HPframe:SetScript("OnEvent", onEvent)
	HPframe:SetScript("OnUpdate", onUpdate)
end