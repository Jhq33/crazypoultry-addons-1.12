------------------------------------------------------------------------------------------------------
-- Venantes
--
-- Maintainer : Zirah on Blackhand (EU, Alliance)
--
-- Based on Ideas by:
--   Serenity and Cryolysis by Kaeldra of Aegwynn 
--   Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--   Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------

-- localisation
local L = AceLibrary('AceLocale-2.2'):new('Venantes');
-- timer functions
local metro = AceLibrary("Metrognome-2.0");

-- configuration
function VenantesConfig_Toggle()
    if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage(L['MSG_INCOMBAT']);
        return;
    end
    -- load configuration dialog
	local loaded, message = LoadAddOn('VenantesOptions');
	if (loaded) then
		PlaySound('igMainMenuOpen');
		if (not VenantesOptions.initialized) then
			VenantesOptions:Initialize();
			VenantesOptions.initialized = true;
			ShowUIPanel(VenantesOptionsFrame);
		elseif (VenantesOptionsFrame:IsVisible()) then
			HideUIPanel(VenantesOptionsFrame);
		else
            VenantesOptions:UpdateData();
			ShowUIPanel(VenantesOptionsFrame);
		end
	else
		PlaySound('TellMessage');
        if message ~= nil then
            DEFAULT_CHAT_FRAME:AddMessage(L['LOAD_ERROR']..': '..message);
        else
            DEFAULT_CHAT_FRAME:AddMessage(L['LOAD_ERROR']);        
        end
	end
end

-- If the Debug library is available then use it

if AceLibrary:HasInstance('AceDebug-2.0') then
	Venantes = AceLibrary('AceAddon-2.0'):new(
        'AceConsole-2.0', 'AceEvent-2.0', 'AceDB-2.0', 'AceDebug-2.0', 
        'SphereCore-2.0', 'SphereButtons-2.0', 'SphereInventory-2.0'
    );
else
	Venantes = AceLibrary('AceAddon-2.0'):new(
        'AceConsole-2.0', 'AceEvent-2.0', 'AceDB-2.0', 
        'SphereCore-2.0', 'SphereButtons-2.0', 'SphereInventory-2.0'
    );
end

VENANTES_SPELLS = {        
    ['HUNTER_ASPECT_BEAST'] = 'Aspect of the Beast',
    ['HUNTER_ASPECT_CHEETAH'] = 'Aspect of the Cheetah',
    ['HUNTER_ASPECT_HAWK'] = 'Aspect of the Hawk',
    ['HUNTER_ASPECT_MONKEY'] = 'Aspect of the Monkey',
    ['HUNTER_ASPECT_PACK'] = 'Aspect of the Pack',
    ['HUNTER_ASPECT_VIPER'] = 'Aspect of the Viper',
    ['HUNTER_ASPECT_WILD'] = 'Aspect of the Wild',
  
    ['HUNTER_TRACK_BEASTS'] = 'Track Beasts',
    ['HUNTER_TRACK_DEMONS'] = 'Track Demons',
    ['HUNTER_TRACK_DRAGONKIN'] = 'Track Dragonkin',
    ['HUNTER_TRACK_ELEMENTALS'] = 'Track Elementals',
    ['HUNTER_TRACK_GIANTS'] = 'Track Giants',
    ['HUNTER_TRACK_HIDDEN'] = 'Track Hidden',
    ['HUNTER_TRACK_HUMANOIDS'] = 'Track Humanoids',
    ['HUNTER_TRACK_UNDEAD'] = 'Track Undead',
    
    ['HUNTER_TRAP_FREEZING'] = 'Freezing Trap',
    ['HUNTER_TRAP_FROST'] = 'Frost Trap',
    ['HUNTER_TRAP_IMMOLATION'] = 'Immolation Trap',
    ['HUNTER_TRAP_EXPLOSIVE'] = 'Explosive Trap',
    ['HUNTER_TRAP_SNAKE'] = 'Snake Trap',
    
    ['HUNTER_AIMED_SHOT'] = 'Aimed Shot',
    ['HUNTER_BEAST_LORE'] = 'Beast Lore',
    ['HUNTER_COUNTERATTACK'] = 'Counterattack',
    ['HUNTER_DISENGAGE'] = 'Disengage',
    ['HUNTER_EAGLE_EYE'] = 'Eagle Eye',
    ['HUNTER_FEIGN_DEATH'] = 'Feign Death',
    ['HUNTER_FLARE'] = 'Flare',
    ['HUNTER_HUNTERS_MARK'] = 'Hunter\'s Mark',
    ['HUNTER_MONGOOSE BITE'] = 'Mongoose Bite',
    ['HUNTER_RAPID_FIRE'] = 'Rapid Fire',
    ['HUNTER_RAPTOR STRIKE'] = 'Raptor Strike',
    ['HUNTER_SCARE_BEAST'] = 'Scare Beast',
    ['HUNTER_SCATTER_SHOT'] = 'Scatter Shot',
    ['HUNTER_SHOT_ARCANE'] = 'Arcane Shot',
    ['HUNTER_SHOT_CONCUSSIVE'] = 'Concussive Shot',
    ['HUNTER_SHOT_DISTRACTING'] = 'Distracting Shot',
    ['HUNTER_SHOT_MULTI'] = 'Multi-Shot',
    ['HUNTER_SHOT_TRANQ'] = 'Tranquilizing Shot',
    ['HUNTER_VOLLEY'] = 'Volley',
    ['HUNTER_WING_CLIP'] = 'Wing Clip',
    ['HUNTER_STING_SCORPID'] = 'Scorpid Sting',
    ['HUNTER_STING_SERPENT'] = 'Serpent Sting',
    ['HUNTER_STING_VIPER'] = 'Viper Sting',
    ['HUNTER_STING_WYVERN'] = 'Wyvern Sting',
    ['HUNTER_TRUESHOT_AURA'] = 'Trueshot Aura',
    ['HUNTER_BESTIAL_WRATH'] = 'Bestial Wrath',
    ['HUNTER_INTIMIDATION'] = 'Intimidation',
    ['HUNTER_DETERRENCE'] = 'Deterrence',
    
    ['HUNTER_PET_CONTROL'] = 'Eyes of the Beast',
    ['HUNTER_PET_TAME'] = 'Tame Beast',
    ['HUNTER_PET_MEND'] = 'Mend Pet',
    ['HUNTER_PET_CALL'] = 'Call Pet',
    ['HUNTER_PET_REVIVE'] = 'Revive Pet',
    ['HUNTER_PET_TRAINING'] = 'Beast Training',
    ['HUNTER_PET_FEED'] = 'Feed Pet',
    ['HUNTER_PET_DISMISS'] = 'Dismiss Pet',
    ['HUNTER_PET_KILLCOMMAND'] = 'Kill Command',    
  
    ['TRADE_FIND_HERBS'] = 'Find Herbs',
    ['TRADE_FIND_MINERALS'] = 'Find Minerals',
    ['RACIAL_FIND_TREASURE'] = 'Find Treasure',
}

-- startup/close functions

function Venantes:OnInitialize()
    self:SphereRegisterSkins({'Solid', 'Flat', 'Sprocket'});
    
    self.options = { 
        type = 'group',
        args = {
            menu = {
                type = 'execute',
                name = 'Menu',
                desc = L['TOGGLE_CONFIG'],
                func = VenantesConfig_Toggle,
            },
            minimap = {
                type = 'execute',
                name = 'Minimap',
                desc = L['TOGGLE_MINIMAP'],
                func = Venantes_MinimapToggle,               
            }
        }
    }
    self:RegisterChatCommand(L['SLASH_COMMANDS'], self.options);
    
    self.dbDefaults = {
        sphereLocking = false, 
        sphereSkin = 1; -- 1 = Solid, 2 = Flat
        sphereRotation = 0, -- button rotation in degrees
        sphereOpacity = 90, -- sphere alpha opacity in percent
        sphereScale = 100, -- scale in percent
        sphereStatusCircle = 0, -- show on sphere circle
        sphereStatusText = 0, -- show on sphere text
        sphereActionLeft = 0, -- left click one sphere
        sphereActionRight = 0, -- right click on sphere
        -- menu behaviour 
        menuKeepOpen = false;
        menuCloseTimeout = 2;
        -- remember spells
        rememberAspectMenu = {
            [0] = '',
            [1] = '',
        },
        rememberTrackingMenu = {
            [0] = '',
            [1] = '',
        },
        rememberTrapsMenu = {
            [0] = '',
            [1] = '',
        },
        -- button
        buttonOrderCCW = false, -- button order direction (false = clockwise, true = counter clockwise)
        buttonOpacity = 100, -- sphere alpha opacity in percent
        buttonScale = 100, -- scale buttons
        buttonLocking = true, -- lock buttons to sphere
        buttonTooltips = true, -- tooltips on buttons and sphere?
        buttonDefaultTooltips = false; -- use default tooltip position
        buttonsUseGrid = true; --use a grid of 10px to align buttons
        -- buttons visible or not
        buttonDrinkVisible = true,
        buttonPotionVisible = true,
        buttonMountVisible = true,
        buttonPetMenuVisible = true,
        buttonAspectMenuVisible = true,
        buttonTrackingMenuVisible = true,
        buttonTrapsMenuVisible = true,
        buttonActionOneVisible = true,
        buttonActionTwoVisible = true,
        buttonActionThreeVisible = true,
        -- potion and drink/food button options
        buttonPotionWeakest = false,
        buttonDrinkWeakest = false,
        -- action button clicks
        buttonActionOneLeft = 0,
        buttonActionOneRight = 0,
        buttonActionTwoLeft = 0,
        buttonActionTwoRight = 0,
        buttonActionThreeLeft = 0,
        buttonActionThreeRight = 0,
        -- messages
        messagesLanguage = 0,
        messagesOnScreen = true,
        messagesMissingTexture = true;
        messagesRaidMode = false,
        messagesRandom = false,
        messagesRandomHuntersMark = true,
        messagesRandomTranqShot = true,
        messagesRandomPetCall = true,
        messagesRandomPetRevive = true,
        messagesRandomMount = true,
    };

    self:RegisterDB('VenantesDB', 'VenantesDBPC');
    self:RegisterDefaults('profile', self.dbDefaults);

    self:InitPlayerInfos();
    -- Called when the addon is loaded
    self:ButtonSetup('Venantes', {'Potion', 'Drink', 'ActionOne', 'ActionTwo', 'ActionThree', 'AspectMenu', 'Mount', 'TrackingMenu', 'PetMenu', 'TrapsMenu'});
    self:RegisterSpells(VENANTES_SPELLS);
    self:ButtonRegisterActions({    
        { type = 'slot', data = 'Trinket0Slot' }, --First trinket slot
        { type = 'slot', data = 'Trinket1Slot' }, --Second trinket slot     
        { type = 'spell', data = 'HUNTER_FEIGN_DEATH' },
        { type = 'spell', data = 'HUNTER_HUNTERS_MARK' },
        { type = 'spell', data = 'HUNTER_SCARE_BEAST' },
        { type = 'spell', data = 'HUNTER_RAPID_FIRE' },
        { type = 'spell', data = 'HUNTER_DETERRENCE' },
        { type = 'spell', data = 'HUNTER_FLARE' },
        { type = 'spell', data = 'HUNTER_VOLLEY' },      
        { type = 'spell', data = 'HUNTER_BEAST_LORE' },
        { type = 'spell', data = 'HUNTER_PET_CONTROL' }, 
        { type = 'spell', data = 'HUNTER_EAGLE_EYE' },
        { type = 'spell', data = 'HUNTER_TRAP_FREEZING' },
        { type = 'spell', data = 'HUNTER_TRAP_SNAKE' },     
        { type = 'spell', data = 'HUNTER_TRAP_EXPLOSIVE' },
        { type = 'spell', data = 'HUNTER_TRAP_FROST' },    
        { type = 'spell', data = 'HUNTER_TRAP_IMMOLATION' },
        { type = 'spell', data = 'HUNTER_BESTIAL_WRATH' },
        { type = 'spell', data = 'HUNTER_INTIMIDATION' },
        { type = 'spell', data = 'HUNTER_TRUESHOT_AURA' },  
    });
    self:SphereRegisterStatus(
        {'MANA', 'HEALTH', 'XP', 'PET_MANA', 'PET_HEALTH', 'PET_XP', 'PET_HAPPY'},
        {'AMMO', 'MANA', 'HEALTH', 'PET_MANA', 'PET_HEALTH', 'DRINK_FOOD'}
    );
    self:ButtonRegisterMenu('TrackingMenu', {   
        { type = 'spell', data = 'TRADE_FIND_HERBS' },    
        { type = 'spell', data = 'TRADE_FIND_MINERALS' },    
        { type = 'spell', data = 'HUNTER_TRACK_BEASTS' },    
        { type = 'spell', data = 'HUNTER_TRACK_DEMONS' },    
        { type = 'spell', data = 'HUNTER_TRACK_DRAGONKIN' },    
        { type = 'spell', data = 'HUNTER_TRACK_ELEMENTALS' },    
        { type = 'spell', data = 'HUNTER_TRACK_GIANTS' },    
        { type = 'spell', data = 'HUNTER_TRACK_HIDDEN' },    
        { type = 'spell', data = 'HUNTER_TRACK_HUMANOIDS' },    
        { type = 'spell', data = 'HUNTER_TRACK_UNDEAD' },    
        { type = 'spell', data = 'RACIAL_FIND_TREASURE' },
    });
    self:ButtonRegisterMenu('AspectMenu', {
        { type = 'spell', data = 'HUNTER_ASPECT_HAWK' },    
        { type = 'spell', data = 'HUNTER_ASPECT_MONKEY' },  
        { type = 'spell', data = 'HUNTER_ASPECT_VIPER'}, 
        { type = 'spell', data = 'HUNTER_ASPECT_CHEETAH' },      
        { type = 'spell', data = 'HUNTER_ASPECT_PACK' },    
        { type = 'spell', data = 'HUNTER_ASPECT_BEAST' },   
        { type = 'spell', data = 'HUNTER_ASPECT_WILD'},
    });
    self:ButtonRegisterMenu('PetMenu', {
        { type = 'spell', data = 'HUNTER_BESTIAL_WRATH' },
        { type = 'spell', data = 'HUNTER_INTIMIDATION' },   
        { type = 'spell', data = 'HUNTER_PET_KILLCOMMAND' },         
        { type = 'spell', data = 'HUNTER_PET_MEND' },   
        { type = 'spell', data = 'HUNTER_PET_CONTROL' }, 
        { type = 'spell', data = 'HUNTER_PET_CALL' },   
        { type = 'spell', data = 'HUNTER_PET_REVIVE' },  
        { type = 'spell', data = 'HUNTER_PET_DISMISS' },  
        { type = 'spell', data = 'HUNTER_PET_FEED' },    
        { type = 'spell', data = 'HUNTER_PET_TAME' },   
        { type = 'spell', data = 'HUNTER_BEAST_LORE' },   
        { type = 'spell', data = 'HUNTER_PET_TRAINING' },  
    });
    self:ButtonRegisterMenu('TrapsMenu', {
        { type = 'spell', data = 'HUNTER_TRAP_FREEZING' },
        { type = 'spell', data = 'HUNTER_TRAP_SNAKE' },     
        { type = 'spell', data = 'HUNTER_TRAP_EXPLOSIVE' },
        { type = 'spell', data = 'HUNTER_TRAP_FROST' },    
        { type = 'spell', data = 'HUNTER_TRAP_IMMOLATION' },
    });
    self:RegisterSpeechLanguage('enUS', VENANTES_RANDOM_MESSAGES_enUS);
    self:RegisterSpeechLanguage('deDE', VENANTES_RANDOM_MESSAGES_deDE);
    self:RegisterSpeechLanguage('frFR', VENANTES_RANDOM_MESSAGES_frFR);
    self:RegisterSpeechLanguage('zhTW', VENANTES_RANDOM_MESSAGES_zhTW);
    
    metro:Register("VenantesTimer", self.OnTimerTick, 1, self);
end

function Venantes:OnEnable()
    -- starting up
    self:RegisterEvent('PLAYER_ENTERING_WORLD');
    -- new zone
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA');
        
    -- monitor some status infos
    self:RegisterEvent('UNIT_HEALTH');
    self:RegisterEvent('UNIT_MANA');
    self:RegisterEvent('UNIT_FOCUS');
    
    -- some basic info has changed
    self:RegisterEvent('PLAYER_PET_CHANGED');
    self:RegisterEvent('SPELLS_CHANGED');
    self:RegisterEvent('BAG_UPDATE');
    self:RegisterEvent('UNIT_INVENTORY_CHANGED');
    
    -- capture spellcasts (messages, recasts)
    self:RegisterEvent('UNIT_SPELLCAST_SENT');
    self:RegisterEvent('UNIT_SPELLCAST_FAILED'); 
    self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED'); 
    self:RegisterEvent('UNIT_SPELLCAST_STOP');
    self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');     
    
    -- leaving combat - do pending updates
    self:RegisterEvent('PLAYER_LEAVE_COMBAT');
    
    -- start the update timer
    metro:Start("VenantesTimer");
end

-- timer ticks
function Venantes:OnTimerTick()
    self:UpdateStatus();
end

-- event callbacks
function Venantes:PLAYER_ENTERING_WORLD()
    self:InitPlayerInfos();
    self:MountZoneInformation();
    self:UpdateSpellTable();
    self:InventoryScan();
    self:UpdateAmmoItem();
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:SPELLS_CHANGED()
    self:UpdateSpellTable();
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:PLAYER_PET_CHANGED()
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:BAG_UPDATE()
    self:InventoryScan();
    self:UpdateActions();
    self:UpdateStatus();
end

function Venantes:UNIT_INVENTORY_CHANGED(unit)
    if unit == 'player' then
        self:UpdateAmmoItem();
    end
end

function Venantes:ZONE_CHANGED_NEW_AREA()
    self:MountZoneInformation();
    self:UpdateActions();
end

function Venantes:UNIT_SPELLCAST_SENT(unitId, spell, rank, target)
    if unitId == 'player' then
        self:OnSpellCastStart(spell, rank, target);
        if self.lastSpell == nil then
            self.lastSpell = {}
        end
        self.lastSpell.spell = spell;
        self.lastSpell.rank = rank;
        self.lastSpell.target = target;
    end
end

function Venantes:UNIT_SPELLCAST_STOP(unitId)
    if unitId == 'player' then
        self.lastSpell = nil;
        if self.lastSpell ~= nil and self.lastSpell.spell ~= nil then
            self:OnSpellCast(self.lastSpell.spell, self.lastSpell.rank, self.lastSpell.target);
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

function Venantes:UNIT_SPELLCAST_FAILED(unitId)
    if unitId == 'player' then
        self.lastSpell = nil;
        if self.lastSpell ~= nil and self.lastSpell.spell ~= nil then
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

function Venantes:UNIT_SPELLCAST_INTERRUPTED(unitId)
    if unitId == 'player' then
        if self.lastSpell ~= nil and self.lastSpell.spell ~= nil then
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

function Venantes:UNIT_SPELLCAST_SUCCEEDED(unitId, spell, rank)
    if unitId == 'player' then
        if self.lastSpell ~= nil then
            if self.lastSpell ~= nil and self.lastSpell.spell ~= nil and spell == self.lastSpell.spell then
                self:OnSpellCast(spell, rank, self.lastSpell.target);
            end
            self.lastSpell.spell = nil;
            self.lastSpell.rank = nil;
            self.lastSpell.target = nil;
        end
    end
end

-- status update events
function Venantes:UNIT_HEALTH()
    self:UpdateStatus();
end
function Venantes:UNIT_MANA()
    self:UpdateStatus();
end
function Venantes:UNIT_FOCUS()
    self:UpdateStatus();
end

-- pending updates
function Venantes:PLAYER_LEAVE_COMBAT()
    if self.bagUpdatePending then
        self:InventoryScan();    
    end
    if self.updatePending then
        self:UpdateActions();    
    end
    self:UpdateStatus();
end

-- tooltip functions
function Venantes:ShowTooltip(element, buttonId, anchor)
    if not self.db.profile.buttonTooltips then
        return
    end
  
    if self.db.profile.buttonDefaultTooltips then
        GameTooltip_SetDefaultAnchor(GameTooltip, element);    
    else
        GameTooltip:SetOwner(element, anchor);
    end
  
    if buttonId == 'MAIN' then    
		GameTooltip:AddLine('Venantes');
        local ammoCount, ammoName = self:GetAmmoCount(L['AMMO']);
        if ammoName ~= nil then
            GameTooltip:AddDoubleLine(ammoName..': ', ammoCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = self:InventoryGetItemData('DRINK');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..': ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = self:InventoryGetItemData('FOOD');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..': ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = self:InventoryGetItemData('POTION_MP');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..': ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end
        local itemCount, itemName = self:InventoryGetItemData('POTION_HP');
        if itemName ~= nil and itemCount ~= nil then
            GameTooltip:AddDoubleLine(itemName..': ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        end        
        local _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = self:ButtonGetActionInfo(self.db.profile.sphereActionLeft);
        local _, actionRightName, _, actionRightTooltip, actionRightCooldown = self:ButtonGetActionInfo(self.db.profile.sphereActionRight);  
        if actionLeftName then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
            if actionLeftTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionLeftName, actionLeftTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionLeftName, 0.8, 0.8, 0.1);
            end
            if actionLeftCooldown and actionLeftCooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionLeftCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
    elseif buttonId == 'DRINK' then
		GameTooltip:AddLine(L['TOOLTIP_DRINKFOOD']);
        self:TooltipAddItemData(GameTooltip, 'LeftButton', 'DRINK');
        self:TooltipAddItemData(GameTooltip, 'RightButton', 'FOOD');
    elseif buttonId == 'POTION' then
		GameTooltip:AddLine(L['TOOLTIP_POTION']);
        self:TooltipAddItemData(GameTooltip, 'LeftButton', 'POTION_HP');
        self:TooltipAddItemData(GameTooltip, 'RightButton', 'POTION_MP');
    elseif buttonId == 'MOUNT' then    
        if UnitOnTaxi('player') then
            GameTooltip:AddLine(L['UNIT_ON_TAXI'], 1.0, 1.0, 1.0);
        end
        local _, _, itemName = self:InventoryGetMountData();
        if itemName ~= nil then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
            GameTooltip:AddLine(itemName, 0.8, 0.8, 0.1);
        end
        local _, itemName, _, _, cooldown = self:InventoryGetItemData('HEARTHSTONE');
        if itemName ~= nil then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            GameTooltip:AddLine(itemName..' ('..GetBindLocation()..')', 0.8, 0.8, 0.1);
            if cooldown and cooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(cooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
    elseif buttonId == 'ACTION_ONE' or buttonId == 'ACTION_TWO' or buttonId == 'ACTION_THREE' then
        local actionLeftName, actionLeftTooltip, actionLeftCooldown;
        local actionRightName, actionRightTooltip, actionRightCooldown;
        if buttonId == 'ACTION_ONE' then
            _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = self:ButtonGetActionInfo(self.db.profile.buttonActionOneLeft);
            _, actionRightName, _, actionRightTooltip, actionRightCooldown = self:ButtonGetActionInfo(self.db.profile.buttonActionOneRight);
        elseif buttonId == 'ACTION_TWO' then
            _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = self:ButtonGetActionInfo(self.db.profile.buttonActionTwoLeft);
            _, actionRightName, _, actionRightTooltip, actionRightCooldown = self:ButtonGetActionInfo(self.db.profile.buttonActionTwoRight);
        elseif buttonId == 'ACTION_THREE' then
            _, actionLeftName, _, actionLeftTooltip, actionLeftCooldown = self:ButtonGetActionInfo(self.db.profile.buttonActionThreeLeft);
            _, actionRightName, _, actionRightTooltip, actionRightCooldown = self:ButtonGetActionInfo(self.db.profile.buttonActionThreeRight);   
        end
        if actionLeftName then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
            if actionLeftTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionLeftName, actionLeftTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionLeftName, 0.8, 0.8, 0.1);
            end
            if actionLeftCooldown and actionLeftCooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionLeftCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
        end
    elseif buttonId == 'ATTRIBUTES' then
        local buttonType = element:GetAttribute('type1');
        if buttonType ~= nil then
            local buttonAction = element:GetAttribute(buttonType..'1');
            if buttonType == 'spell' then
                -- spell name to venantes spell id
                if self.spellTableRevIndex ~= nil and self.spellTableRevIndex[buttonAction] ~= nil then
                    -- venantes spell id to spell data
                    local spellData = self.spellTable[self.spellTableRevIndex[buttonAction]];
                    -- check data and set tooltip
                    if spellData ~= nil and spellData.index ~= nil and spellData.index > 0 then
                        GameTooltip:SetSpell(spellData.index, BOOKTYPE_SPELL);
                    end
                end
            end
        end
    elseif buttonId == 'PETMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        local actionRightId = 'HUNTER_PET_MEND';
        if UnitIsDeadOrGhost('pet') then
            actionRightId = 'HUNTER_PET_REVIVE';
        elseif not HasPetUI() then
            actionRightId = 'HUNTER_PET_CALL';        
        end
        local _, actionRightName, _, actionRightTooltip, actionRightCooldown = self:GetActionInfo('spell', actionRightId);
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
            local _, actionMiddleName, _, actionMiddleTooltip, actionMiddleCooldown = self:GetActionInfo('spell', 'HUNTER_PET_CONTROL');
            if actionMiddleName then
                GameTooltip:AddLine(L['TOOLTIP_MIDDLECLICK'], 1.0, 1.0, 1.0);
                if actionMiddleTooltip ~= nil then
                    GameTooltip:AddDoubleLine(actionMiddleName, actionMiddleTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
                else
                    GameTooltip:AddLine(actionMiddleName, 0.8, 0.8, 0.1);
                end
                if actionMiddleCooldown and actionMiddleCooldown > 0 then
                    local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionMiddleCooldown);
                    GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
                end                
            end   
        end
    elseif  buttonId == 'ASPECTMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        self:TooltipAddMenuSpellData(tooltip, 'AspectMenu');
    elseif  buttonId == 'TRACKINGMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        self:TooltipAddMenuSpellData(tooltip, 'TrackingMenu');
    elseif  buttonId == 'TRAPSMENU' then
        GameTooltip:AddLine(L['BUTTON_'..buttonId]);
        self:TooltipAddMenuSpellData(tooltip, 'TrapsMenu');
    end
  
	-- and done, show it!
	GameTooltip:Show();
end

function Venantes:TooltipAddItemData(tooltip, button, itemGroup)
    local itemCount, itemName, _, _, cooldown = self:InventoryGetItemData(itemGroup);
    if itemName ~= nil then
        if button == 'LeftButton' then
            GameTooltip:AddLine(L['TOOLTIP_LEFTCLICK'], 1.0, 1.0, 1.0);
        elseif button == 'RightButton' then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
        end
        GameTooltip:AddDoubleLine(itemName..': ', itemCount, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);
        if cooldown and cooldown > 0 then
            local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(cooldown);
            GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
        end
    end
end

function Venantes:TooltipAddMenuSpellData(tooltip, menuId)
    local optionName = 'remember'..menuId;
    if self.db.profile[optionName] ~= nil then
        local _, actionRightName, _, actionRightTooltip, actionRightCooldown = self:GetActionInfo('spell', self.db.profile[optionName][1]);
        if actionRightName then
            GameTooltip:AddLine(L['TOOLTIP_RIGHTCLICK'], 1.0, 1.0, 1.0);
            if actionRightTooltip ~= nil then
                GameTooltip:AddDoubleLine(actionRightName, actionRightTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
            else
                GameTooltip:AddLine(actionRightName, 0.8, 0.8, 0.1);
            end
            if actionRightCooldown and actionRightCooldown > 0 then
                local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionRightCooldown);
                GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
            end
            local _, actionMiddleName, _, actionMiddleTooltip, actionMiddleCooldown = self:GetActionInfo('spell', self.db.profile[optionName][0]);
            if actionMiddleName then
                GameTooltip:AddLine(L['TOOLTIP_MIDDLECLICK'], 1.0, 1.0, 1.0);
                if actionMiddleTooltip ~= nil then
                    GameTooltip:AddDoubleLine(actionMiddleName, actionMiddleTooltip, 0.8, 0.8, 0.1, 1.0, 1.0, 1.0);            
                else
                    GameTooltip:AddLine(actionMiddleName, 0.8, 0.8, 0.1);
                end
                if actionMiddleCooldown and actionMiddleCooldown > 0 then
                    local cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionMiddleCooldown);
                    GameTooltip:AddLine(self:GetTooltipCooldownStr(cooldownString, cooldownUnit), 0.7, 0.7, 0.7);
                end                
            end   
        end
    end
end

function Venantes:UpdateStatus()
    if (not InCombatLockdown()) and self.updatePending then
        self:UpdateActions();
    end

    local circleInfo, textInfo = self:SphereGetStatusInfo(self.db.profile.sphereStatusCircle, self.db.profile.sphereStatusText);
    -- update circle
    if self.db.profile.sphereStatusCircle == nil or self.db.profile.sphereStatusCircle == 0 then
        self:SphereSetStatusValues(0, nil);        
    elseif circleInfo ~= nil then
        local statusCircle = 0;
        local hasPet = HasPetUI();
        if circleInfo == 'MANA' then
            statusCircle = math.floor((UnitMana('player') * 16 / UnitManaMax('player')) + 0.5);
        elseif circleInfo == 'HEALTH' then
            statusCircle = math.floor((UnitHealth('player') * 16 / UnitHealthMax('player')) + 0.5);
        elseif circleInfo == 'XP' then
            statusCircle = math.floor((UnitXP('player') * 16 / UnitXPMax('player')) + 0.5);
        elseif hasPet and circleInfo == 'PET_MANA' then
            statusCircle = math.floor((UnitMana('pet') * 16 / UnitManaMax('pet')) + 0.5);
        elseif hasPet and circleInfo == 'PET_HEALTH' then
            statusCircle = math.floor((UnitHealth('pet') * 16 / UnitHealthMax('pet')) + 0.5);
        elseif hasPet and circleInfo == 'PET_XP' then
            local currXP, nextXP = GetPetExperience();
            statusCircle = math.floor((currXP * 16 / nextXP) + 0.5);
        elseif hasPet and circleInfo == 'PET_HAPPY' then
            local happyLevel = GetPetHappiness();
            if happyLevel == 3 then
                statusCircle = 16;                
            elseif happyLevel == 2 then
                statusCircle = 7;
            elseif happyLevel == 1 then
                statusCircle = 3;
            end
        end        
        self:SphereSetStatusValues(statusCircle, nil);
    end
    -- update sphere text
    if self.db.profile.sphereStatusText == nil or self.db.profile.sphereStatusText == 0 then
        self:SphereSetStatusValues(nil, '');        
    elseif textInfo ~= nil then
        local statusText = '';
        local hasPet = HasPetUI();
        if textInfo == 'AMMO' then
            local ammoCount = self:GetAmmoCount(L['AMMO']);
            if ammoCount < 200 then
                statusText = '|c00FF0000'..ammoCount..'|r';
            elseif ammoCount < 600 then
                statusText = '|c00FFCC00'..ammoCount..'|r';
            else
                statusText = ammoCount;            
            end
        elseif textInfo == 'MANA' then
            statusText = (math.floor((UnitMana('player') * 100 / UnitManaMax('player')) + 0.5))..'%\n'..UnitMana('player');
        elseif textInfo == 'HEALTH' then
            statusText = (math.floor((UnitHealth('player') * 100 / UnitHealthMax('player')) + 0.5))..'%\n'..UnitHealth('player');       
        elseif hasPet and textInfo == 'PET_MANA' then
            statusText = (math.floor((UnitMana('pet') * 100 / UnitManaMax('pet')) + 0.5))..'%\n'..UnitMana('pet');        
        elseif hasPet and textInfo == 'PET_HEALTH' then
            statusText = (math.floor((UnitHealth('pet') * 100 / UnitHealthMax('pet')) + 0.5))..'%\n'..UnitHealth('pet');     
        elseif textInfo == 'DRINK_FOOD' then
            local itemDrinkCount = self:InventoryGetItemData('DRINK');
            local itemFoodCount = self:InventoryGetItemData('FOOD'); 
            if itemDrinkCount ~= nil then
                statusText = itemDrinkCount..'/';
            else
                statusText = '0/';
            end
            if itemFoodCount ~= nil then
                statusText = statusText..itemFoodCount;
            else
                statusText = statusText..'0';
            end
        end
        self:SphereSetStatusValues(nil, statusText);
    end
    -- update potion cooldown
    local _, _, _, _, cooldownHP = self:InventoryGetItemData('POTION_HP');
    local _, _, _, _, cooldownMP = self:InventoryGetItemData('POTION_MP');
    local cooldownString = nil;
    local cooldownUnit = nil;
    if cooldownHP ~= nil and cooldownHP > 0 then
        cooldownString, cooldownUnit = self:GetFormattedCooldownTime(cooldownHP);
    elseif cooldownMP ~= nil and cooldownMP > 0 then
        cooldownString, cooldownUnit = self:GetFormattedCooldownTime(cooldownMP);
    end
    if cooldownString then
        self:ButtonSetCaption('Potion', self:GetButtonCooldownStr(cooldownString, cooldownUnit));
        self:ButtonSetStatus('Potion', false);        
    else
        self:ButtonSetCaption('Potion', nil);
        self:ButtonSetStatus('Potion', true);
    end
    
    local currentMana = UnitMana('player');
    
    -- action buttons
    self:UpdateActionButtonStatus('ActionOne', currentMana);
    self:UpdateActionButtonStatus('ActionTwo', currentMana);
    self:UpdateActionButtonStatus('ActionThree', currentMana);
        
    local actionName = nil;
    local actionCooldown = nil;
    local actionMana = nil;
    if self.buttons ~= nil and self.buttons.menus ~= nil and self.buttons.menus['TrapsMenu'] ~= nil then
        for i=1, table.getn(self.buttons.menus['TrapsMenu']), 1 do
            if actionName == nil then
                _, actionName, _, _, actionCooldown, actionMana = self:GetActionInfo(self.buttons.menus['TrapsMenu'][i].type, self.buttons.menus['TrapsMenu'][i].data);   
            end
        end
    end
    if actionName ~= nil then
        if actionCooldown ~= nil and actionCooldown > 0 then
            cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionCooldown);
            if cooldownString then
                self:ButtonSetCaption('TrapsMenu', self:GetButtonCooldownStr(cooldownString, cooldownUnit));
                self:ButtonSetStatus('TrapsMenu', false); 
            else
                self:ButtonSetCaption('TrapsMenu', ''); 
                self:ButtonSetStatus('TrapsMenu', true); 
            end 
        else
            self:ButtonSetCaption('TrapsMenu', ''); 
            self:ButtonSetStatus('TrapsMenu', true);         
        end
    else
        self:ButtonSetStatus('TrapsMenu', false);     
    end
    
    -- mount button highlighting
    if UnitOnTaxi('player') then
        self:ButtonSetStatus('Mount', false);
    else
        self:ButtonSetStatus('Mount', true);
        if IsMounted() then
            VenantesButtonMount:LockHighlight();
        else
            VenantesButtonMount:UnlockHighlight(); 
        end
    end
    
    -- update button status (mana depending spells, cooldowns)
    self:ButtonUpdateMenuStatus();
end

function Venantes:UpdateActionButtonStatus(buttonId, currentMana)
    local _, actionName, _, _, actionCooldown, actionMana = self:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Left']);
    if actionName == nil then
        _, actionName, _, _, actionCooldown, actionMana = self:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Right']);        
    end
    local buttonEnabled = true;
    if actionName ~= nil then
        if  actionCooldown ~= nil and actionCooldown > 0 then
            cooldownString, cooldownUnit = self:GetFormattedCooldownTime(actionCooldown);
            if cooldownString then
                self:ButtonSetCaption(buttonId, self:GetButtonCooldownStr(cooldownString, cooldownUnit));
                buttonEnabled = false;
            else
                self:ButtonSetCaption(buttonId, '');        
            end
        else 
            self:ButtonSetCaption(buttonId, '');
        end
        if actionMana ~= nil and actionMana > 0 and actionMana > currentMana then
            buttonEnabled = false;        
        end
    else
        buttonEnabled = false;
    end
    if buttonEnabled then 
        self:ButtonSetStatus(buttonId, true);     
    else
        self:ButtonSetStatus(buttonId, false);      
    end
end

function Venantes:UpdateActions()
    if InCombatLockdown() then
        self.updatePending = true;
        return;
    end
    if self.updatePending then
        self:UpdateTemporaryOptions();
    end
    
    -- sphere    
    actionType, actionName = self:ButtonGetActionInfo(self.db.profile.sphereActionLeft);     
    if actionType ~= nil and actionName then
        if actionType == 'spell' then
            self:SphereSetSpell('LeftButton', actionName);
        else
            self:SphereSetItem('LeftButton',actionName);
        end
    else 
        self:SphereSetSpell('LeftButton', '');
    end
    actionType, actionName = self:ButtonGetActionInfo(self.db.profile.sphereActionRight);    
    if actionType ~= nil and actionName then
        if actionType == 'spell' then
            self:SphereSetSpell('RightButton', actionName);
        else
            self:SphereSetItem('RightButton', actionName);
        end
    else 
        self:SphereSetSpell('RightButton', '');
    end 
    
    -- drink button
    self:UpdateItemButton('Drink', 'DRINK', 'FOOD', 'Spell_Misc_Drink');    
    -- potions button
    self:UpdateItemButton('Potion', 'POTION_HP', 'POTION_MP', 'INV_Potion_90');
    
    -- mount button
    local itemMountName, itemMountTexture = self:InventoryGetMountData();
    local _, itemHearthStoneName, itemHearthStoneTexture = self:InventoryGetItemData('HEARTHSTONE');
    if itemMountName ~= nil then        
        self:ButtonSetStatus('Mount', true);
        self:ButtonSetIcon('Mount', itemMountTexture);
        self:ButtonSetMacro('Mount', 'LeftButton', '/dismount\n/use '..itemMountName);
        if itemHearthStoneName ~= nil then
            self:ButtonSetItem('Mount', 'RightButton', itemHearthStoneName);
        else 
            self:ButtonSetItem('Mount', 'RightButton', '');        
        end
    else     
        self:ButtonSetMacro('Mount', 'LeftButton', '/dismount');
        if itemHearthStoneName ~= nil then
            self:ButtonSetIcon('Mount', itemHearthStoneTexture);
            self:ButtonSetItem('Mount', 'RightButton', itemHearthStoneName);
        else 
            self:ButtonSetIcon('Mount', 'INV_Misc_Rune_01');
            self:ButtonSetItem('Mount', 'RightButton', '');        
        end
    end
    
    -- action button one
    self:UpdateActionButton('ActionOne');
    self:UpdateActionButton('ActionTwo');
    self:UpdateActionButton('ActionThree');
    
    -- action button three
    self:ButtonUpdateMenus();
    -- set remembered spells and show icon for right click
    self:UpdateMenuButtonSpells('TrackingMenu', 'Ability_Tracking');
    self:UpdateMenuButtonSpells('AspectMenu', 'Spell_Nature_RavenForm');
    self:UpdateMenuButtonSpells('TrapsMenu', 'Spell_Frost_ChainsOfIce');
    
    -- check for pet - set button depending on pet
    self:ButtonSetIcon('PetMenu', 'Ability_Hunter_BeastTaming'); 
    if self.spellTable ~= nil and self.spellTable['HUNTER_PET_MEND'] ~= nil then
        self:ButtonSetMacro('PetMenu', 'RightButton', '/cast [target=pet,dead] '..self.spellTable['HUNTER_PET_REVIVE'].name..'; [nopet] '..self.spellTable['HUNTER_PET_CALL'].name..'; '..self.spellTable['HUNTER_PET_MEND'].name); 
    end
    if self.spellTable ~= nil and self.spellTable['HUNTER_PET_CONTROL'] ~= nil then
        self:ButtonSetSpell('PetMenu', 'MiddleButton', self.spellTable['HUNTER_PET_CONTROL'].name); 
    end 
    local petTexture = GetPetIcon();
    if petTexture ~= nil then
        local  _, _, petTextureFile = string.find(petTexture,'([^\\]+)$');
        if petTextureFile ~= nil then
            self:ButtonSetIcon('PetMenu', petTextureFile);        
        end
    end
    
    self.updatePending = false;
end

function Venantes:UpdateMenuButtonSpells(menuId, defaultTexture)
    local optionName = 'remember'..menuId;
    if self.db.profile[optionName] ~= nil then
        local actionTypeRight, actionNameRight, actionTextureRight = self:GetActionInfo('spell', self.db.profile[optionName][1]);
        if actionTypeRight ~= nil and actionTypeRight == 'spell' and actionNameRight ~= nil then
            self:ButtonSetSpell(menuId, 'RightButton', actionNameRight);
            if self.db.profile[optionName][1] ~= self.db.profile[optionName][0] then
                local actionTypeMiddle, actionNameMiddle = self:GetActionInfo('spell', self.db.profile[optionName][0]);
                if actionTypeMiddle ~= nil and actionTypeMiddle == 'spell' and actionNameMiddle ~= nil then
                    self:ButtonSetSpell(menuId, 'MiddleButton', actionNameMiddle);
                else 
                    self:ButtonSetSpell(menuId, 'MiddleButton', '');        
                end
            else
                self:ButtonSetSpell(menuId, 'MiddleButton', '');           
            end
        else 
            self:ButtonSetSpell(menuId, 'RightButton', ''); 
            self:ButtonSetSpell(menuId, 'MiddleButton', '');           
        end
        if actionTextureRight then
            self:ButtonSetIcon(menuId, actionTextureRight);
        else 
            self:ButtonSetIcon(menuId, defaultTexture);        
        end
    end
end

function Venantes:UpdateItemButton(buttonId, groupIdLeft, groupIdRight, defaultTexture)
    local _, itemLeftName, itemLeftTexture  = self:InventoryGetItemData(groupIdLeft);
    local _, itemRightName, itemRightTexture  = self:InventoryGetItemData(groupIdRight);
    if itemLeftName ~= nil then
        self:ButtonSetStatus(buttonId, true);
        self:ButtonSetIcon(buttonId, itemLeftTexture);
        self:ButtonSetItem(buttonId, 'LeftButton', itemLeftName);
        if itemRightName ~= nil then
            self:ButtonSetItem(buttonId, 'RightButton', itemRightName);
        else
            self:ButtonSetItem(buttonId, 'RightButton', '');        
        end
    else
        self:ButtonSetItem(buttonId, 'LeftButton', '');
        if itemRightName ~= nil then
            self:ButtonSetStatus(buttonId, true);
            self:ButtonSetIcon(buttonId, itemRightTexture);
            self:ButtonSetItem(buttonId, 'RightButton', itemRightName);
        else
            self:ButtonSetStatus(buttonId, false);
            self:ButtonSetIcon(buttonId, defaultTexture);
            self:ButtonSetItem(buttonId, 'RightButton', '');   
        end
    end
end

function Venantes:UpdateActionButton(buttonId)
    local actionLeftType, actionLeftName, actionLeftTexture = self:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Left']);
    local actionRightType, actionRightName, actionRightTexture = self:ButtonGetActionInfo(self.db.profile['button'..buttonId..'Right']);
    if actionLeftType ~= nil and actionLeftName ~= nil then
        if actionLeftType == 'spell' then
            self:ButtonSetSpell(buttonId, 'LeftButton', actionLeftName);
        else 
            self:ButtonSetItem(buttonId, 'LeftButton', actionLeftName);        
        end
    else
        self:ButtonSetSpell(buttonId, 'LeftButton', '');    
    end
    if actionRightType ~= nil and actionRightName then
        if actionRightType == 'spell' then
            self:ButtonSetSpell(buttonId, 'RightButton', actionRightName);
        else 
            self:ButtonSetItem(buttonId, 'RightButton', actionRightName);        
        end
    else
        self:ButtonSetSpell(buttonId, 'RightButton', '');    
    end
    if actionLeftTexture ~= nil then
        self:ButtonSetIcon(buttonId, actionLeftTexture);
    elseif actionRightTexture ~= nil then
        self:ButtonSetIcon(buttonId, actionRightTexture);
    else 
        self:ButtonSetIcon(buttonId, 'DEFAULT');    
    end
end


function Venantes:OnSpellCastStart(spell, rank, target)
end

function Venantes:OnSpellCast(spell, rank, target)
    if spell ~= nil and self.spellTableRevIndex ~= nil then
        if target == nil then
            target = '';
        end
        local spellId = self.spellTableRevIndex[spell];
        -- remember traps, tracking, aspects
        if spellId == 'HUNTER_TRAP_FREEZING' or spellId == 'HUNTER_TRAP_FROST' or spellId == 'HUNTER_TRAP_IMMOLATION' or spellId == 'HUNTER_TRAP_EXPLOSIVE' 
            or spellId == 'HUNTER_TRAP_SNAKE' then
            -- remember last trap
            self:ButtonRememberSpell('TrapsMenu', spellId);            
        elseif spellId == 'HUNTER_ASPECT_HAWK' or spellId == 'HUNTER_ASPECT_MONKEY' or spellId == 'HUNTER_ASPECT_CHEETAH' or spellId == 'HUNTER_ASPECT_PACK' 
            or spellId == 'HUNTER_ASPECT_BEAST' or spellId == 'HUNTER_ASPECT_WILD' or spellId == 'HUNTER_ASPECT_VIPER' then
            -- remember last tracking
            self:ButtonRememberSpell('AspectMenu', spellId);            
        elseif spellId == 'HUNTER_TRACK_BEASTS' or spellId == 'HUNTER_TRACK_DEMONS' or spellId == 'HUNTER_TRACK_DRAGONKIN' or spellId == 'HUNTER_TRACK_ELEMENTALS' 
            or spellId == 'HUNTER_TRACK_GIANTS' or spellId == 'HUNTER_TRACK_HIDDEN' or spellId == 'HUNTER_TRACK_HUMANOIDS' or spellId == 'HUNTER_TRACK_HUMANOIDS'
            or spellId == 'HUNTER_TRACK_UNDEAD' 
            or spellId == 'TRADE_FIND_HERBS' or spellId == 'TRADE_FIND_MINERALS' or spellId == 'RACIAL_FIND_TREASURE' then
            -- remember last tracking
            self:ButtonRememberSpell('TrackingMenu', spellId);
        else
            local inGroup = GetNumPartyMembers() > 0;
            if self.db.profile.messagesRaidMode then
                if inGroup then
                    if spellId ~= nil and spellId == 'HUNTER_HUNTERS_MARK' then
                        self:DoSpeech('GROUP_WARNING', 'RAID', 'HUNTERS_MARK', target);
                    elseif spellId ~= nil and  spellId == 'HUNTER_SHOT_TRANQ' then
                        self:DoSpeech('GROUP_WARNING', 'RAID', 'TRANQ_SHOT', target);            
                    end
                end
            elseif self.db.profile.messagesRandom then
                if inGroup and spellId ~= nil and  spellId == 'HUNTER_HUNTERS_MARK' and self.db.profile.messagesRandomHuntersMark then
                    self:DoSpeech('GROUP_WARNING', 'HUNTERS_MARK', nil, target);
                elseif inGroup and spellId ~= nil and  spellId == 'HUNTER_SHOT_TRANQ' and self.db.profile.messagesRandomTranqShot then
                    self:DoSpeech('GROUP_WARNING', 'TRANQ_SHOT', nil, target);
                elseif spellId ~= nil and  spellId == 'HUNTER_PET_CALL' and self.db.profile.messagesRandomPetCall then
                    self:DoSpeech('SAY', 'PET_CALL', nil, target);
                elseif spellId ~= nil and  spellId == 'HUNTER_PET_REVIVE' and self.db.profile.messagesRandomPetRevive then
                    self:DoSpeech('SAY', 'PET_REVIVE', nil, target);        
                elseif self.db.profile.messagesRandomMount then
                    local itemMountName, _, itemMountTitle = self:InventoryGetMountData();
                    if itemMountName ~= nil and itemMountTitle ~= nil and itemMountTitle == spell then
                        self:DoSpeech('SAY', 'MOUNT', nil, nil, itemMountTitle);
                    end
                end
            end
        end
    end
end

function Venantes:ButtonRememberSpell(menuId, spellId)
    local optionName = 'remember'..menuId;
    if self.temporary == nil then
        self.temporary = {};
    end
    if self.temporary[optionName] == nil then
        self.temporary[optionName] = { 
            [0] = nil, 
            [1] = nil 
        };
    end
    if InCombatLockdown() or self.updatePending then
        if self.db.profile[optionName] then
            if self.db.profile[optionName][0] and self.temporary[optionName][0] == nil then
                self.temporary[optionName][0] = self.db.profile[optionName][0];
            end
            if self.db.profile[optionName][1] and self.temporary[optionName][1] == nil then
                self.temporary[optionName][1] = self.db.profile[optionName][1];
            end
        end
        if self.temporary[optionName][1] ~= spellId then
            if self.temporary[optionName][1] ~= nil then
                self.temporary[optionName][0] = self.temporary[optionName][1];
            else
                self.temporary[optionName][0] = spellId;
            end
            self.temporary[optionName][1] = spellId;        
        end
        self.updatePending = true;
    elseif self.db.profile[optionName] then
        self.temporary[optionName][0] = nil;
        self.temporary[optionName][1] = nil;
        if self.db.profile[optionName][1] and self.db.profile[optionName][1] ~= spellId then
            if self.db.profile[optionName][1] ~= '' then
                self.db.profile[optionName][0] = self.db.profile[optionName][1];
            else
                self.db.profile[optionName][0] = spellId;
            end
            self.db.profile[optionName][1] = spellId;
            self:UpdateActions();
            GameTooltip:Hide();
        end
    end
end

function Venantes:UpdateTemporaryOptions()
    if (not InCombatLockdown()) and self.updatePending then
        if self.temporary == nil then
            self.temporary = {};
            return;
        end        
        for optionName, optionValue in pairs(self.temporary) do
            if type(optionValue) == 'table' then
                for subOptionName, subOptionValue in pairs(optionValue) do
                    if subOptionValue ~= nil then
                        self.db.profile[optionName][subOptionName] = subOptionValue;
                        self.temporary[optionName][subOptionName] = nil;
                    end
                end
            elseif optionValue ~= nil then
                self.db.profile[optionName] = optionValue;
                self.temporary[optionName] = nil;
            end
        end
    end
end

function Venantes:GetButtonCooldownStr(cooldownString, cooldownUnit) 
    if cooldownUnit == 'h' then
        return '|c00FFCC00'..cooldownString..L['BUTTON_COOLDOWN_HOUR']..'|r';
    elseif cooldownUnit == 'm' then
        return '|c00FFCC00'..cooldownString..L['BUTTON_COOLDOWN_MINUTES']..'|r';
    else
        return '|c00FFCC00'..cooldownString..'|r';
    end
end

function Venantes:GetTooltipCooldownStr(cooldownString, cooldownUnit) 
    if cooldownUnit == 'h' then
        return L['COOLDOWN_REMAINING']..': '..cooldownString..L['TOOLTIP_COOLDOWN_HOUR'];
    elseif cooldownUnit == 'm' then
        return L['COOLDOWN_REMAINING']..': '..cooldownString..L['TOOLTIP_COOLDOWN_MINUTES'];
    else
        return L['COOLDOWN_REMAINING']..': '..cooldownString..L['TOOLTIP_COOLDOWN_SECONDS'];
    end
end

function Venantes_MinimapToggle() 
  VenantesFuBar:ToggleIconShown();
end