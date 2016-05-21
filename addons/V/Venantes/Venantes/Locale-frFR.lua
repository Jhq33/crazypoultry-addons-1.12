------------------------------------------------------------------------------------------------------
-- Venantes - French translation
--
-- Translated by: Dagonet (EU, Alliance), Bastien Ribot
--
-- Maintainer: Zirah on Blackhand (EU, Alliance)
--
-- Based on Ideas by:
--   Serenity and Cryolysis by Kaeldra of Aegwynn 
--   Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
--   Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
------------------------------------------------------------------------------------------------------

local L = AceLibrary('AceLocale-2.2'):new('Venantes')

L:RegisterTranslations('frFR', function() return {
  ['SLASH_COMMANDS'] = { '/venantes', '/venan' },
  ['TOGGLE_CONFIG'] = 'Panneau de congiguration',
  ['TOGGLE_MINIMAP'] = 'Toggle minimap icon',
  ['CLICK_TOGGLE_CONFIG'] = 'Click to toggle the config dialog!',
  ['ERROR_LOAD'] = 'Erreur de chargement',
  ['NONE'] = 'None',
    
  -- labels
  ['AMMO'] = 'Munitions',
  ['UNIT_ON_TAXI'] = 'Taxi',
  
  --cooldown 
  ['COOLDOWN_REMAINING'] = 'Cooldown restant',
  ['BUTTON_COOLDOWN_HOUR'] = 'h',
  ['BUTTON_COOLDOWN_MINUTES'] = 'm',
  ['TOOLTIP_COOLDOWN_HOUR'] = 'h',
  ['TOOLTIP_COOLDOWN_MINUTES'] = 'min',
  ['TOOLTIP_COOLDOWN_SECONDS'] = 's',
  
  -- user messages
  ['MSG_INCOMBAT'] = 'Vous etes en combat',
  ['MSG_FULLMANA'] = 'Vous etes full mana',
  ['MSG_FULLHEALTH'] = 'Vous etes full vie',
  
  --tooltips
  ['TOOLTIP_LEFTCLICK'] = 'Click Gauche',
  ['TOOLTIP_RIGHTCLICK'] = 'Click Droit',
  ['TOOLTIP_DRINKFOOD'] = 'Boisson/Nourriture',
  ['TOOLTIP_POTION'] = 'Potions',
  
  ['TAB_SPHERE'] = 'Sphere',
  ['TAB_BUTTONS'] = 'Bouttons',
  ['TAB_MESSAGES'] = 'Messages',
  ['TAB_INVENTORY'] = 'Inventaire',
  ['TAB_DEBUG'] = 'Debug',
  -- options messages tab
  ['MESSAGES_LANGUAGE'] = 'langue',
  ['MESSAGES_ONSCREEN'] = 'Afficher les messages sur l\'ecran',
  ['MESSAGES_TEXTURE_DEBUG'] = 'montrer les textures manquantes',
  ['MESSAGES_TOOLTIPS'] = 'Voir la bulle d aide',
  ['MESSAGES_RAID'] = 'Voir uniquement les messages raid',
  ['MESSAGES_RANDOM'] = 'messages Aleatoires',
  ['MESSAGES_RANDOM_HUNTERSMARK'] = 'Marque du chasseur',
  ['MESSAGES_RANDOM_TRANQSHOT'] = 'Tir tranquilisant',
  ['MESSAGES_RANDOM_PETCALL'] = 'Appel du Familier',
  ['MESSAGES_RANDOM_PETREVIVE'] = 'Ressusciter le Familier',
  ['MESSAGES_RANDOM_MOUNT'] = 'Monture',
  -- options button tab
  ['SHOW_BUTTONS'] = 'Voir les buttons',
  ['BUTTON_DRINK_FOOD'] = 'Boissons et nourriture',
  ['BUTTON_POTION'] = 'Vie et Mana',
  ['BUTTON_USE_WEAKEST'] = 'Use weakest',
  ['BUTTON_MOUNT'] = 'Monture',
  ['BUTTON_PETMENU'] = 'Menu du Familier',
  ['BUTTON_ASPECTMENU'] = 'Menu des Aspects',
  ['BUTTON_TRACKINGMENU'] = 'Menu pistage',
  ['BUTTON_TRAPSMENU'] = 'Menu pieges',
  ['BUTTON_ACTION_ONE'] = '1 er Bouton',
  ['BUTTON_ACTION_TWO'] = '2 ieme Bouton',
  ['BUTTON_ACTION_THREE'] = '3 ieme Bouton',
  -- options graphics tab
  ['LOCK_SPHERE'] = 'BLoque la position de la sphere',
  ['LOCK_BUTTONS'] = 'BLoque la position des boutons',
  ['SPHERE_SKIN'] = 'Sphere skin',
  ['SPHERE_ROTATION'] = 'Tourne les boutons',
  ['SPHERE_SCALE'] = 'Taille de la sphere',
  ['BUTTON_SCALE'] = 'Taille des boutons',
  ['SPHERE_CIRCLE'] = 'Sphere circle',
  ['SPHERE_OPACITY'] = 'Sphere transparence',
  ['BUTTON_OPACITY'] = 'Boutons transparence',
  ['BUTTON_ORDERCCW'] = 'Order buttons counter clockwise',
  ['SPHERE_TEXT'] = 'texte sur la sphere',
  ['MENU_KEEPOPEN'] = 'Keep menus open',
  -- status info titles
  ['STATUS_MANA'] = 'Mana',
  ['STATUS_HEALTH'] = 'Vie',
  ['STATUS_XP'] = 'Experience',
  ['STATUS_PET_MANA'] = 'Mana du pet',
  ['STATUS_PET_HEALTH'] = 'Vie du Pet',
  ['STATUS_PET_XP'] = 'Experience du pet',
  ['STATUS_PET_HAPPY'] = 'Pet happyness',
  ['STATUS_DRINK_FOOD'] = 'Boissons/Nourriture',
  ['STATUS_AMMO'] = 'Munitions',
  -- slot names
  ['SLOT_Trinket0Slot'] = 'Trinket 1';
  ['SLOT_Trinket1Slot'] = 'Trinket 2';
  -- debug
  ['DEBUG_ITEMDROP'] = 'Drag an item to the box';
  ['DEBUG_TEXTURES'] = 'Missing textures';
} end)