local AceLocale = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")
-- Russian Translation by StingerSoft (Эритнулл aka Шептун)
AceLocale:RegisterTranslations("ruRU", function()
	return {
		["SLASHCMD_LONG"] = "/questannouncer",
		["SLASHCMD_SHORT"] = "/qa",
		["ADDON_PREFIX"] = "QuestAnnouncer",

		["OPT_SHOWDEBUG_NAME"] = "Режим отладки",
		["OPT_SHOWDEBUG_DESC"] = "Вкл/Выкл отображение отладочной информации",
		["OPT_SHOWDEBUG_ON"] = "режим отладки включен",
		["OPT_SHOWDEBUG_OFF"] = "режим отладки отключен",
		["OPT_ANNOUNCE_NAME"] = "Тип оповещения",
		["OPT_ANNOUNCE_DESC"] = "Каким способом должно высылаться оповещение.\naddon - Только те участники группы будут информированы у которых стоит данный аддон\nchat - Участники группы будут информированны через чат\nboth - Ваша группа будет информированна двумя способами\nnone - Информация не будет высылаться",
		["OPT_ANNOUNCE_ADDON"] = "Оповещения будут высылаться участникам вашей группы у которых стоит данный аддон",
		["OPT_ANNOUNCE_CHAT"] = "Оповещения будут высылаться в групповой чат",
		["OPT_ANNOUNCE_BOTH"] = "Оповещения будут высылаться участникам вашей группы у которых стоит данный аддон и в групповой чат",
		["OPT_ANNOUNCE_NONE"] = "Оповещения не будут высылаться",
		["OPT_DISPLAY_NAME"] = "Тип отображения",
		["OPT_DISPLAY_DESC"] = "Каким способом будет отображаться информация от игроков с данным аддоном.\nui - В центре экрана (UIErrorFrame)\nchat - В окне чата\nboth - В окне чата и в центре экрана\nnone - не будет отображаться",
		["OPT_DISPLAY_UI"] = "Оповещения будут отображаться в центре экрана",
		["OPT_DISPLAY_CHAT"] = "Оповещения будут отображаться в окне чата",
		["OPT_DISPLAY_BOTH"] = "Оповещения будут отображаться в центре экрана и в чате",
		["OPT_DISPLAY_NONE"] = "Оповещения не будут отображаться",

		["FUBAR_TOOLTIP_HINT"] = "Настройка QuestAnnouncer через FuBar",

		["ADVMSG"] = "$ItemName $NumItems из $NumNeeded (осталось $NumLeft)",
		["FINMSG"] = "$ItemName $NumItems из $NumNeeded (готово)",
		["COMPLETED"]	= TEXT(COMPLETE),
		["FAILED"]		= TEXT(FAILED),
	}
end)
