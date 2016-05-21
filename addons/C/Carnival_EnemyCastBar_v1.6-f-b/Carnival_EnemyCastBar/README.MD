Carnival_EnemyCastBar

Description:
------------
Displays a replication of your targets spell casting bar on your UI, which can be moved around.
Spell casting time is not something that is available to your WoW client, so I have provided cast times for most (if not all spells).
As talents can be a factor on the cast time of some spells, the lowest cast time possible is used
ie. all Shadow Bolt cast times will display at 2.5 seconds even though the player you have targetted doesnt have those specific talents.
Interruptions on your target, ie. they get hit, will not adjust the display on your cast bar, as again, its impossible to know if it affected the cast.
This currently works for both Alliance and Horde, but has only been really tested playing against alliance characters.
Will display either a green cast bar for friendly targets, or a red for a hostile target.

To move the bars, simply do...

/cenemycast lock
/cenemycast show

...then click and drag the bar that appears, then lock again

/cenemycast lock


Support:
--------
Please post on my guilds forums (http://www.carnivalguild.co.uk)
I'm no longer going to be checking the comments on www.curse-gaming.com or ui.worldofwar.net


Author:
-------
Miranda on Al'Akir (EU)
But please, don't ask me for support while im in game!
If you want to thank me however, feel free to do so on my forums...
http://www.carnivalguild.co.uk


Revision History:
-----------------
18/01/06  v1.0 ALPHA
* Initial Alpha Release

24/01/06  v1.1 BETA
* Adjusted bars so that they "grow" from the bottom up
* Adjusted cast time on several spells,
* Added timers for warlock pet spells,
* Added timers for most trinkets, talisman of power, zandalarian hero charm, to show remaining time
* Added timers for gained abilities, arcane power, sprint, to show remaining time,
* Added timers for racial talents, perception, war stomp, will of the forsaken, to show cast time or remaining time depending on the talent,
* Added timers for various PvE events,
 - Molten Core
   - Lucifron (Impending Doom, Lucifron's Curse)
   - Magmadar (Fear)
   - Gehennas (Gehennas' Curse)
   - Majordomo (Magic Reflection, Damage Shield)
   - Ragnaros (Submerge, Knockback and Sons of the Flame)
 - Blackwing Lair
   - Firemaw (Wing Buffet, Shadow Flame)
   - Ebonroc (Wing Buffet, Shadow Flame)
   - Flamegor (Wing Buffet, Shadow Flame)
   - Chromaggus (Frost Burn, Time Lapse, Ignite Flesh, Corrosive Acid, Incinerate)
   - Neferian (Event Start, Bellowing Roar, Class Calls)
* Fixed some possibly laggy code

24/01/06  v1.2 BETA
* Fixed a major problem with the XML frame

27/01/06  v1.3 BETA
* Added Slash Commands
 - /cenemycast enable/disable
 - /cenemycast show
 - /cenemycast pvp
 - /cenemycast pve
* Fixed issue with "X gains Y" events
* Added Stoneform,
* Added Shadowguard,
* Added Priest - Mana Burn,
* Added Priest - Holy Fire,
* Added Priest - Mind Soothe,
* Added Priest - Prayer of Healing,
* Added Priest - Shackle Undead,
* Added Druid - Hibernate,
* Added Druid - Soothe Animal,
* Added Druid - Bark Skin,
* Added Druid - Innervate,
* Added Mage - Conjure Mana Ruby,
* Added Mage - Conjure Mana Citrine,
* Added Mage - Conjure Mana Jade,
* Added Mage - Conjure Mana Agate,
* Added Mage - Slow Fall,
* Added Warrior - Bloodrage,
* Added Warrior - Shield Wall,
* Added Warrior - Recklessness,
* Added Warrior - Berserker Rage,

31/01/06  v1.4 BETA
* Fixed an error about FADESTEP,
* Fixed problem with Bellowing Roar on Nefarian/Onyxia, Onyxia's is 1.5sconds, Nefarain's is 2.0seconds
* Fixed debug output saying "ECB Control - Running i"
* Added cooldown data to the spell database, however the data is not in use yet
* Added timer for Hakkar in Zul'Gurrub
* Added German localization!
* Added /ecb lock - Locks or Unlocks the Casting Bars
* Added /ecb reset - Resets the bar position
* Adjusted Mage - Fireball,
* Adjusted Driud - Bark Skin,
* Adjusted Driud - Innervate,
* Adjusted Druid - Healing Touch,
* Adjusted Druid - Regrowth,
* Adjusted Hunter - Scare Beast,
* Adjusted Mage - Conjure Water,
* Adjusted Mage - Conjure Food,
* Adjusted Paladin - Howl of Terror,
* Adjusted Paladin - Summon Charger,
* Adjusted Paladin - Summon Warhorse
* Adjusted Warlock - Summon Felsteed,
* Adjusted Warlock - Summon Dreadsteed,
* Adjusted Warlock - Imp - Firebolt,
* Adjusted Warrior - Slam,
* Added Paladin - Divine Protection,
* Added Paladin - Divine Shield,
* Added Hunter - Dismiss Pet,
* Added Hunter - Revive Pet,
* Added Hunter - Eyes of the Beast,
* Added Hunter - Rapid Fire,
* Added Mage - Fire Ward,
* Added Mage - Frost Ward,
* Added Mage - Teleport: Darnassus,
* Added Mage - Teleport: Thunder Bluff,
* Added Mage - Teleport: Ironforge,
* Added Mage - Teleport: Orgrimmar,
* Added Mage - Teleport: Stormwind,
* Added Mage - Teleport: Undercity,
* Added Mage - Portal: Darnassus,
* Added Mage - Portal: Thunder Bluff,
* Added Mage - Portal: Ironforge,
* Added Mage - Portal: Orgrimmar,
* Added Mage - Portal: Stormwind,
* Added Mage - Portal: Undercity,
* Added Druid - Teleport: Moonglade,
* Added Druid - Tiger's Fury,
* Added Druid - Frenzied Regeneration,
* Added Druid - Rejuvenation
* Added Druid - Abolish Poison
* Added Priest - Fade,
* Added Priest - Renew,
* Added Priest - Abolish Disease,
* Added Rogue - Evasion,
* Added Rogue - Mind-numbing Poison,
* Added Rogue - Mind-numbing Poison II,
* Added Rogue - Mind-numbing Poison III,
* Added Rogue - Pick Lock,
* Added Shaman - Far Sight,
* Added Shaman - Fire Nova Totem,
* Added Shaman - Mana Tide Totem,
* Added Shaman - Stoneclaw Totem,
* Added Warrior - Slam,
* Added Warrior - Retaliation,
* Added Warlock - Ritual of Doom,
* Added Warlock - Enslave Demon,
* Added Warlock - Inferno, 
* Added Warlock - Shadow Ward,
* Added Warlock - Create Spellstone,
* Added Warlock - Create Healthstone,
* Added Warlock - Create Soulstone,
* Added Warlock - Create Firestone,
* Added Warlock - Voidwalker - Consume Shadows,

20/02/06  v1.5
* Added French Localization
* Added "/cenemycast timer" to toggle the timer text
* Fixed the time issue with Flamestrike and BWL mobs
* Fixed Nefarian/Ragnaros Timers so that they actually work
* Fixed (maybe) the issue with the bars not locking
* Fixed (maybe) the issue with multiple bars for the same mob (BWL Drakes)
* Fixed most (if not all) the issues with some PvE bars not appearing on MC bosses
* Removed the /ecb alias so that it doesnt clash with eCastingBar
* Guessed at a fix for the clash with WarriorAlert 
* Added PvE - BWL - Flamegor - Frenzy
* Added PvE - BWL - Chromaggus - Frenzy
* Added PvE - BWL - Nefarian - Landing Warning
* Added PvE - Outdoor - Azuregos - Manastorm
* Added PvE - AQ40 - Obsidian Eradicator Respawn - 15minutes
* Added PvE - AQ20 - Anubisath - Explode - 5 seconds?
* Added General - First Aid - 8 seconds
* Added Engineering - Frost Reflector
* Added Engineering - Shadow Reflector
* Added Engineering - Fire Reflector
* (Reflectors *should* work, however have had NO testing)
* Added Mage - Ice Block - 10 seconds
* Added Paladin - Blessing of Freedom - 16 seconds
* Added Paladin - Blessing of Protection - 10 seconds
* Added Paladin - Blessing of Sacrifice - 10 seconds
* Adjusted - Hakkar - Blood Siphon - 90 seconds
* Adjusted - Warlock - Summon Imp - 6 seconds
* Adjusted - Warlock - Summon Succubus - 6 seconds
* Adjusted - Warlock - Summon Voidwalker - 6 seconds
* Adjusted - Warlock - Summon Felhunter - 6 seconds

21/02/06  v1.5b
* Fixed problem with French localization
* Fixed problem with German localization
* Adjusted PvE - AQ20 - Anubisath - Explode - 6 seconds

04/04/06 v1.6 Final BETA
* Added the ability to target the player/mob from left clicking the bars, Thanks Astalia
* Added the ability to hide an active bar by shift + left clicking it,
* Added more French spell translations,
* Added more German spell translations, Thanks Tarci,
* Added Carnival - Head Honcho support (private addon),
* Added "/cenemycast clear" will stop and hide all currently showing bars, Thanks Naturfreund
* Added "/cenemycast buffet" will manually start a timer for the first wing buffet, Thanks Naturfreund
* Added "/cenemycast countsec sss" will start a countdown timer with the seconds value "sss", Thanks Naturfreund
* Added "/cenemycast countmin sss" will start a countdown timer with the minute value "sss", Thanks Naturfreund
* Added "/cenemycast scale x" will set the scaling of the bars, Thanks Naturfreund
* Added "/cenemycast alpha x" will set the alpha rating of the bars, Thanks Naturfreund
* Added "/cenemycast repeat x" will repeat a countdown bar until closed  for the time specified, Thanks Naturfreund
* Cleared out some old test code,
* Changed the bar label order, its now "spellname - mobname",
* Changed the way the bar displays timers, if over a minute will display in the format "mm:ss", if under "ss.d"
* Changed the way unique bars work in such a way that they will reset themselves if called again
* Fixed (possibly) the issue with the Wing Buffet not always appearing,
* Fixed the random bars from appearing on mobs, should work correctly now,
* Fixed German localization for the "gain" abilities,
* Fixed German localization for the "afflicttion" abilities, Thanks Naturfreund
* Fixed German localization for the "spell damage" abilities, Thanks Naturfreund
* Fixed the "YELL" issue that was confusing so many people,

This is the last version of the addon I will probably now release
Development has been handed over to someone else now who is re-coding it
If you have any suggestions for him, please post on my forums
http://www.carnivalguild.co.uk
Also, if you need a good host for either your comms server or hosting for any multiplayer game, speak to the nice people at
http://www.multiplay.co.uk
They also run the biggest gaming LAN events in the UK, come <s>harass</s> see me at i27 ;P