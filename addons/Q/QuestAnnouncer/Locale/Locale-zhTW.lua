local AceLocale = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")

AceLocale:RegisterTranslations("zhTW", function()
	return {
		["SLASHCMD_LONG"] = "/questannouncer",
		["SLASHCMD_SHORT"] = "/qa",
		["ADDON_PREFIX"] = "QuestAnnouncer",

		["OPT_SHOWDEBUG_NAME"] = "Debug 模式",
		["OPT_SHOWDEBUG_DESC"] = "切換顯示 Debug 訊息",
		["OPT_SHOWDEBUG_ON"] = "打開 Debug 模式",
		["OPT_SHOWDEBUG_OFF"] = "關閉 Debug 模式",
		["OPT_ANNOUNCE_NAME"] = "報告類型",
		["OPT_ANNOUNCE_DESC"] = "任務發送形式：\naddon - 僅加載此插件的隊友取得\nchar - 通過小隊頻道發送通告t\nboth - 以兩種形式同時發送\nnone - 不發送通告",
		["OPT_ANNOUNCE_ADDON"] = "在插件頻道發佈任務通告",
		["OPT_ANNOUNCE_CHAT"] = "在隊伍頻道發佈任務通告",
		["OPT_ANNOUNCE_BOTH"] = "在UI頻道和隊伍頻道同時發佈任務通告",
		["OPT_ANNOUNCE_NONE"] = "不發表",
		["OPT_DISPLAY_NAME"] = "顯示類型",
		["OPT_DISPLAY_DESC"] = "設置加載此插件的隊友顯示任務通告形式:\nUI - 螢幕中央 (UI 錯誤框)\nchat - 聊天視窗\nboth - 螢幕中央與聊天視窗同時顯示\nnone - 不顯示",
		["OPT_DISPLAY_UI"] = "在螢幕中央顯示通告",
		["OPT_DISPLAY_CHAT"] = "在聊天視窗顯示通告",
		["OPT_DISPLAY_BOTH"] = "同時在螢幕中央和聊天視窗顯示通告",
		["OPT_DISPLAY_NONE"] = "不顯示任務通告",

		["FUBAR_TOOLTIP_HINT"] = "用 Fubar 設置任務通告",

		["ADVMSG"] = "$ItemName: $NumItems/$NumNeeded (剩餘 $NumLeft)",
		["FINMSG"] = "$ItemName: $NumItems/$NumNeeded (已完成)",
		["(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$"] = "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$",
	}
end)
