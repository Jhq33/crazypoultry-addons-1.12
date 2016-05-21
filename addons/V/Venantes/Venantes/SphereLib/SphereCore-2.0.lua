--[[
Name: SphereCore-2.0
Revision: $Rev: 10000 $
Developed by: Zirah
Website: http://thomas.weinert.info/zirah/
Description: core functions for sphere addons
Dependencies: AceLibrary, AceOO-2.0
]]

local MAJOR_VERSION = 'SphereCore-2.0'
local MINOR_VERSION = '$Revision: 10000 $'

if not AceLibrary then error(MAJOR_VERSION..' requires AceLibrary') end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance('AceOO-2.0') then error(MAJOR_VERSION..' requires AceOO-2.0') end
local AceOO = AceLibrary:GetInstance('AceOO-2.0')
local Mixin = AceOO.Mixin

-- localisation
local SL = AceLibrary('Babble-Spell-2.2');

local SphereCore = Mixin {
    'InitPlayerInfos',
    'RegisterSpells',
    'UpdateSpellTable',
    'GetSpellCooldown',
    'GetEquipCooldown',
    'GetActionInfo',
    'ShowMessage',
    'ShowMessageFmt',
    'ShowRandomMessageFmt',
    'RegisterSpeechLanguage',
    'GetSpeechLanguageCount',
    'GetSpeechLanguage',
    'DoSpeech',
    'UpdateAmmoItem',
    'GetAmmoCount',
    'MountZoneInformation',
    'GetFormattedCooldownTime',
}
-- player infos
function SphereCore:InitPlayerInfos()
    self.playerData = {
        level = UnitLevel("player"),
        language = GetLocale(),
        ammo = {
            slot = nil,
            name = '',
        }
    };
    self.identStrings = {
        ammoTrown = 'Thrown',
        zoneAQ = 'Ahn\'Qiraj',
        zoneOutlands = {'Blade\'s Edge Mountains', 'Hellfire Peninsula', 'Nagrand', 'Netherstorm', 'Shadowmoon Valley', 'Terokkar Forest', 'Zangarmarsh'},
        mana = 'Mana',        
    }
    if self.playerData.language == 'deDE' then
        self.identStrings.ammoTrown = 'Wurf';
        self.identStrings.zoneOutlands = {'Schergrat', 'Höllenfeuerhalbinsel', 'Nagrand', 'Netherstorm', 'Schattenmondtal', 'Wälder von Terokkar', 'Zangarmarschen'};
    elseif self.playerData.language == 'enUS' then
        -- no translation needed    
    elseif self.playerData.language == 'esES' then
        self.identStrings.ammoTrown = 'Arrojadiza';
    elseif self.playerData.language == 'frFR' then
        self.identStrings.ammoTrown = 'Jet';  
    elseif self.playerData.language == 'koKR' then
        -- no translation available    
    elseif self.playerData.language == 'zhCN' then
        self.identStrings.ammoTrown = '投擲';
    elseif self.playerData.language == 'zhTW' then
        self.identStrings.ammoTrown = '投擲';
    end    
end

-- registers spells in an internal table
function SphereCore:RegisterSpells(spellList)
    self.spellTable = {};
    self.spellTableRevIndex = {};
    for spellId, spellEn in pairs(spellList) do
        self.spellTable[spellId] = {
            name = SL[spellEn],
            index = 0,
            rank = nil,
            texture = nil,
        }
        if SL[spellEn] ~= nil then
            self.spellTableRevIndex[SL[spellEn]] = spellId;
        else
            self.spellTableRevIndex[spellEn] = spellId;        
        end
    end
end

-- gather spell information
function SphereCore:UpdateSpellTable()
    for i=1, 300, 1 do
        local spellName, subSpellName = GetSpellName(i, BOOKTYPE_SPELL);
		if not spellName then
			do break end
		else
            local _, _, spellRank = string.find(subSpellName, '(%d+)$');
            spellRank = tonumber(spellRank);
        
            local sphereSpellId = self.spellTableRevIndex[spellName];
            if sphereSpellId and self.spellTable[sphereSpellId] ~= nil then
                local addSpell = false;
                if self.spellTable[sphereSpellId].index == 0 then
                    addSpell = true;
                elseif spellRank ~= nil and self.spellTable[sphereSpellId].rank ~= nil and self.spellTable[sphereSpellId].rank < spellRank then
                    addSpell = true;
                end
                if addSpell then
                    self.spellTable[sphereSpellId].index = i;
                    self.spellTable[sphereSpellId].rank = spellRank;
                    self.spellTable[sphereSpellId].mana = nil;                        
                    local spellTexture = GetSpellTexture(i, BOOKTYPE_SPELL);
                    if spellTexture then
                        local  _, _,spellTextureFile = string.find(spellTexture,'([^\\]+)$');
                        self.spellTable[sphereSpellId].texture = spellTextureFile;
                    end
                    if not self.gratuity then
                        self.gratuity = AceLibrary("Gratuity-2.0");
                    end
                    if self.gratuity ~= nil and self.gratuity.SetSpell ~= nil then
                        self.gratuity:SetSpell(i, BOOKTYPE_SPELL);
                        local manaStr = self.gratuity:GetLine(2);
                        if manaStr ~= nil then
                            self.spellTable[sphereSpellId].manaStr = manaStr;
                            local _, _, manaNum = string.find(manaStr, '(%d+) '..self.identStrings.mana);
                            if manaNum then
                                self.spellTable[sphereSpellId].mana = tonumber(manaNum);
                            end
                        end
                    end
                end
            end
        end
    end
end

function SphereCore:GetActionInfo(actionType, actionData)
    if actionType ~= nil and actionData ~= nil then
        local name, texture, tooltip, cooldown, mana;
        if actionType == 'spell' then
            if self.spellTable[actionData] ~= nil then
                name = self.spellTable[actionData].name;
                texture = self.spellTable[actionData].texture;
                tooltip = self.spellTable[actionData].manaStr;
                cooldown = self:GetSpellCooldown(self.spellTable[actionData].name);
                if self.spellTable[actionData].mana then
                    mana = self.spellTable[actionData].mana;   
                else 
                    mana = nil;
                end
                return 'spell', name, texture, tooltip, cooldown, mana;
            end
        elseif actionType == 'item' then
            local itemName, _, _, _, itemMinLevel, _, _, _, _, itemTexture = GetItemInfo(actionData);
            local itemTextureFile = nil;
            if itemTexture then
                _, _, itemTextureFile = string.find(itemTexture,'([^\\]+)$');
            end
            if itemName ~= nil then
                name = itemName;
                texture = itemTextureFile;
                cooldown = self:InventoryGetItemCooldown(itemName);
                return 'item', name, texture, nil, cooldown;
            end
        elseif actionType == 'slot' then
            local slotId, slotTexture = GetInventorySlotInfo(actionData);
            if slotId then
                local itemTextureFile, cooldown, itemName, itemSpell;
                local itemTexture = GetInventoryItemTexture('player', slotId);
                if itemTexture then
                    _, _, itemTextureFile = string.find(itemTexture,'([^\\]+)$');
                end
                local itemLink = GetInventoryItemLink('player', slotId);
                if itemLink then
                    itemName = GetItemInfo(itemLink);
                    if itemName then
                        itemSpell = GetItemSpell(itemName);
                        cooldown = self:GetEquipCooldown(slotId);
                    end
                    if itemSpell == nil then
                        itemName = nil;
                    end
                end
                return 'slot', itemName, itemTextureFile, nil, cooldown, nil, actionData;
            end
        end
    end
    return;
end

function SphereCore:GetSpellCooldown(spellName)     
    local sphereSpellId = self.spellTableRevIndex[spellName];
    if sphereSpellId and self.spellTable[sphereSpellId] ~= nil and self.spellTable[sphereSpellId].index ~= nil  and self.spellTable[sphereSpellId].index > 0 then
        local startTime, duration, enable = GetSpellCooldown(self.spellTable[sphereSpellId].index, BOOKTYPE_SPELL);
        if enable and startTime ~= nil and startTime > 0 and duration ~= nil and duration > 2 then
            return math.floor(startTime - GetTime() + duration + 0.5);
        end
    end
    return 0;
end

function SphereCore:GetEquipCooldown(slot)     
    local startTime, duration, enable = GetInventoryItemCooldown('player', slot);
    if enable and startTime ~= nil and startTime > 0 and duration ~= nil and duration > 2 then
        return math.floor(startTime - GetTime() + duration + 0.5);
    end
    return 0;
end

-- message functions
function SphereCore:ShowMessage(msg, msgType)
    if msgType == 'CHAT' then
        -- to self chat
        DEFAULT_CHAT_FRAME:AddMessage(msg, 0.2, 0.9, 0.95, 1.0, UIERRORS_HOLD_TIME);
    elseif msgType == 'WORLD' then    
		-- to raid, party, say
        if (GetNumRaidMembers() > 0) then
			SendChatMessage(msg, 'RAID');
		elseif (GetNumPartyMembers() > 0) then
			SendChatMessage(msg, 'PARTY');
		else
			SendChatMessage(msg, 'SAY');
		end
    elseif msgType == 'RAID_WARNING' then
        -- to raid warning / raid 
        if IsRaidLeader() or IsRaidOfficer() then
			SendChatMessage(msg, 'RAID_WARNING');      
		else
			SendChatMessage(msg, 'RAID');
		end    
	elseif msgType == 'GROUP_WARNING' then
        -- to raid warning / raid / group
        if (GetNumRaidMembers() > 0) then
            if IsRaidLeader() or IsRaidOfficer() then
                SendChatMessage(msg, 'RAID_WARNING');
            else 
                SendChatMessage(msg, 'RAID');
            end
		elseif (GetNumPartyMembers() > 0) then
			SendChatMessage(msg, 'PARTY');
        end   
    elseif msgType == 'RAID' then
        -- to raid
    	SendChatMessage(msg, "RAID");
    elseif msgType == 'GROUP' then
        -- to raid / group
        if (GetNumRaidMembers() > 0) then
            SendChatMessage(msg, 'RAID');
        elseif (GetNumPartyMembers() > 0) then
			SendChatMessage(msg, 'PARTY');
		end   
    elseif (msgType == 'SAY') then
		-- to say
		SendChatMessage(msg, 'SAY');
    else
        -- to self
        if self.db.profile.messagesOnScreen then
            UIErrorsFrame:AddMessage(msg, 0.2, 0.9, 0.95, 1.0, UIERRORS_HOLD_TIME);
        else
            DEFAULT_CHAT_FRAME:AddMessage(msg, 0.2, 0.9, 0.95, 1.0, UIERRORS_HOLD_TIME);
        end
    end
end

function SphereCore:ShowMessageFmt(msg, msgType, target, action)
	msg = string.gsub(msg, "<player>", UnitName('player'));
    msg = string.gsub(msg, "<target>", target);
    local pet = UnitName('pet');
    if pet ~= nil then
	  msg = string.gsub(msg, "<pet>", pet);
    else
	  msg = string.gsub(msg, "<pet>", '');    
    end
	msg = string.gsub(msg, "<action>", action);
	msg = string.gsub(msg, "<mount>", action);
	self:ShowMessage(msg, msgType);
end

function SphereCore:ShowRandomMessageFmt(msgId, msgs, msgType, target, action)
    if msgs ~= nil then
        if self.lastRandomMessages == nil then
            self.lastRandomMessages = {};
        end
        local msgCount = table.getn(msgs);
        local msgIdx = random(1, msgCount);
        while msgCount >= 2 and self.lastRandomMessages[msgId] ~= nil and msgIdx == self.lastRandomMessages[msgId] do
            msgIdx = random(1, msgCount);
        end
        self.lastRandomMessages[msgId] = msgIdx;
        self:ShowMessageFmt(msgs[msgIdx], msgType, target, action)
    end
end

function SphereCore:RegisterSpeechLanguage(lngLocale, messages) 
    if self.randomMessageTable == nil then
        self.randomMessageTable = {};
        self.randomMessageLngs = {};
    end 
    self.randomMessageTable[lngLocale] = messages;
    self.randomMessageLngs[table.getn(self.randomMessageLngs)+1] = lngLocale;
end

function SphereCore:GetSpeechLanguageCount()
    if self.randomMessageLngs ~= nil then
        return table.getn(self.randomMessageLngs);
    else 
        return 0;
    end
end

function SphereCore:GetSpeechLanguage(lngIdx)
    if self.randomMessageLngs ~= nil then
        if self.randomMessageLngs[lngIdx] ~= nil then
            return self.randomMessageLngs[lngIdx];
        end      
    end  
    return '';
end

function SphereCore:DoSpeech(msgType, speechType, speechSubType, target, action) 
    local speechLng = self:GetSpeechLanguage(self.db.profile.messagesLanguage);
    if speechLng ~= nil and self.randomMessageTable ~= nil and self.randomMessageTable[speechLng] ~= nil and 
        self.randomMessageTable[speechLng][speechType] ~= nil then
        if speechSubType == nil then
            self:ShowRandomMessageFmt(speechType, self.randomMessageTable[speechLng][speechType], msgType, target, action);
        elseif self.randomMessageTable[speechLng][speechType][speechSubType] ~= nil then
            self:ShowMessageFmt(self.randomMessageTable[speechLng][speechType][speechSubType], msgType, target, action);
        end
    end
end

-- get mount zone informations - todo: intergrate outland
function SphereCore:MountZoneInformation()
    local zoneName = GetRealZoneText();
    if zoneName == self.identStrings.zoneAQ then
        self.playerData.inAQ = true;
    else
        self.playerData.inAQ = false;
        self.playerData.inOutlands = false;
        for _, outlandsZone in pairs(self.identStrings.zoneOutlands) do
            if outlandsZone == zoneName then
                self.playerData.inOutlands = true;
                return;
            end
        end
    end  
end

function SphereCore:UpdateAmmoItem()
	local itemLink;
	local usedSlotId = nil;
    
    local ammoTrownIdent = self.identStrings.ammoTrown;
    
    local ammoSlotId = GetInventorySlotInfo("ammoSlot");
	local rangedSlotId = GetInventorySlotInfo("rangedSlot");
    if (GetInventoryItemQuality("player", rangedSlotId) and string.find(GetInventoryItemLink("player", rangedSlotId), ammoTrownIdent)) then
		usedSlotId = rangedSlotId;
	elseif GetInventoryItemQuality("player", ammoSlotId) then
		usedSlotId = ammoSlotId;
	end
	
	if usedSlotId then
		self.playerData.ammo.slot = usedSlotId;
        itemLink = GetInventoryItemLink("player", usedSlotId);
		itemCount = GetInventoryItemCount("player", usedSlotId);
        if itemLink then
            self.playerData.ammo.name = GetItemInfo(itemLink);
        else
            if not self.gratuity then
                self:ShowMessage('Gratuity Init', 'CHAT');
                self.gratuity = AceLibrary("Gratuity-2.0");
            end
            self:ShowMessage('Gratuity Use', 'CHAT');
            self.gratuity:SetInventoryItem('player', usedSlotId);
                self.playerData.ammo.name = self.gratuity:GetLine(1);
            if not itemName then
                self.playerData.ammo.name = '';
            end
        end
	else
		self.playerData.ammo.slot = nil;
		self.playerData.ammo.name = '';
	end
end

-- get ammo count
function SphereCore:GetAmmoCount()
	if self.playerData.ammo.slot then
        return itemCount, self.playerData.ammo.name;
	else
		return 0, '';
	end
end

function SphereCore:GetFormattedCooldownTime(cooldownTime) 
    local cooldownString, timeUnit; 
    if cooldownTime >= 3600 then
        cooldownString = math.floor((cooldownTime / 3600) + 0.5);
        timeUnit = 'h';
    elseif cooldownTime >= 60 then
        cooldownString = math.floor((cooldownTime / 60) + 0.5);
        timeUnit = 'm';
    else
        cooldownString = math.floor(cooldownTime + 0.5);
        timeUnit = 's';    
    end
    return cooldownString, timeUnit;
end

AceLibrary:Register(SphereCore, MAJOR_VERSION, MINOR_VERSION, SphereCore.activate)
SphereCore = AceLibrary(MAJOR_VERSION)