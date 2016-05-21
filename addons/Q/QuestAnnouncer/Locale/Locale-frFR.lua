local AceLocale = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")

AceLocale:RegisterTranslations("frFR", function()
	return {
		["SLASHCMD_LONG"] = "/questannouncer",
		["SLASHCMD_SHORT"] = "/qa",
		["ADDON_PREFIX"] = "QuestAnnouncer",

		["OPT_SHOWDEBUG_NAME"] = "Mode Debug",
		["OPT_SHOWDEBUG_DESC"] = "Toggle the display of debug information",
		["OPT_SHOWDEBUG_ON"] = "mode debug activé",
		["OPT_SHOWDEBUG_OFF"] = "mode debug désactivé",
		["OPT_ANNOUNCE_NAME"] = "Type d'annonce",
		["OPT_ANNOUNCE_DESC"] = "Comment une annonce est affichée.\naddon - Seuls les membres du groupe avec l'addon sont informés\nchat - Votre groupe sera informé via le canal de groupe\nboth - Votre groupe sera informé par les deux méthodes\nnone - Aucune annonce ne sera envoyée",
		["OPT_ANNOUNCE_ADDON"] = "Les annonces sont envoyées aux membres de votre groupe qui ont cet addon",
		["OPT_ANNOUNCE_CHAT"] = "Les annonces seront envoyées via le canal de groupe",
		["OPT_ANNOUNCE_BOTH"] = "Les annonces seront envoyées via le canal de groupe et aux membres de votre groupe qui ont cet addon",
		["OPT_ANNOUNCE_NONE"] = "Aucune annonce ne sera envoyée",
		["OPT_DISPLAY_NAME"] = "Type d'affichage",
		["OPT_DISPLAY_DESC"] = "Comment les annonces des autres joueurs avec cet addon sont affichées.\nui - Au milieu de l'écran (UIErrorFrame)\nchat - Dans la fenêtre de discussion\nboth - Dans la fenêtre de discussion et au milieu de l'écran\nnone - Ne rien afficher",
		["OPT_DISPLAY_UI"] = "Les annonces seront affichées au milieu de l'écran",
		["OPT_DISPLAY_CHAT"] = "Les annonces seront affichées dans la fenêtre de discussion",
		["OPT_DISPLAY_BOTH"] = "Les annonces seront affichées dans la fenêtre de discussion et au milieu de l'écran",
		["OPT_DISPLAY_NONE"] = "Les annonces ne seront pas affichées",

		["FUBAR_TOOLTIP_HINT"] = "Configuration de QuestAnnouncer avec FuBar",

		["ADVMSG"] = "$ItemName: $NumItems/$NumNeeded ($NumLeft restant)",
		["FINMSG"] = "$ItemName: $NumItems/$NumNeeded (terminé)",
	}
end)
