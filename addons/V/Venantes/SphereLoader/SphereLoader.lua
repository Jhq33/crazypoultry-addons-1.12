------------------------------------------------------------------------------------------------------
-- SphereLoader
--
-- Maintainer : Zirah on Blackhand (EU, Alliance)
-- Developed for: Venantes
--
-- A really simple addon that loads one of the sphere addons depending on the character class
--
-- The sphere addon needs to be load on demand - add the following line to 
-- the toc file header of the addon it it is not:
--
--   ## LoadOnDemand: 1
--
------------------------------------------------------------------------------------------------------

SphereLoader = {}

-- class and addon list
SphereLoader.addons = {
    ['DRUID'] = nil,
    ['HUNTER'] = 'Venantes',
    ['MAGE'] = { 'Incantare', 'Cryolysis', 'Arcanum' },
    ['PALADIN'] = 'HolyHope',
    ['PRIEST'] = { 'Serenity', 'SacredBuff' },
    ['ROGUE'] = nil,
    ['SHAMAN'] = { 'Totemus', 'Spirit Sphere' },
    ['WARLOCK'] = 'Necrosis LdC',
    ['WARRIOR'] = nil,
}

function SphereLoader:OnLoad() 
    local localClassTitle, classTitle = UnitClass('player');
    if self.addons[classTitle] then
        if type(self.addons[classTitle]) == 'table' then
            for _, addonTitle in pairs(self.addons[classTitle]) do
                local loaded = LoadAddOn(addonTitle);
                if loaded then
                    return;
                end
            end
        else
            LoadAddOn(self.addons[classTitle]);
        end
    end
end
