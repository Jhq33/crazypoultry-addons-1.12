local AceLocale = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")

AceLocale:RegisterTranslations("koKR", function()
	return {
		["SLASHCMD_LONG"] = "/questannouncer",
		["SLASHCMD_SHORT"] = "/qa",
		["ADDON_PREFIX"] = "퀘스트알리미",

		["OPT_SHOWDEBUG_NAME"] = "디버그 모드",
		["OPT_SHOWDEBUG_DESC"] = "디버그 정보 표시를 전환합니다.",
		["OPT_SHOWDEBUG_ON"] = "디버그 모드 사용.",
		["OPT_SHOWDEBUG_OFF"] = "디버그 모드 미사용.",
		["OPT_ANNOUNCE_NAME"] = "알림 유형",
		["OPT_ANNOUNCE_DESC"] = "알림 유형을 설정합니다.\naddon - 이 애드온을 사용하는 파티원에게만 알림\nchar - 파티대화로 알림\nboth - 두 가지 방법 모두 알림\nnone - 정보 없음",
		["OPT_ANNOUNCE_ADDON"] = "애드온 사용자에게만 알림.",
		["OPT_ANNOUNCE_CHAT"] = "파티대화로 알림.",
		["OPT_ANNOUNCE_BOTH"] = "파티대화 및 애드온 사용자 모두 알림.",
		["OPT_ANNOUNCE_NONE"] = "알리지 않음.",
		["OPT_DISPLAY_NAME"] = "표시 유형",
		["OPT_DISPLAY_DESC"] = "다른 플레이어의 알림을 이 애드온으로 표시할 방법을 선택합니다.\nui - 화면 중앙 (UIErrorFrame)\nchat - 대화창\nboth - 대화창과 화면 중앙\nnone - 표시 하지 않음",
		["OPT_DISPLAY_UI"] = "화면 중앙 표시.",
		["OPT_DISPLAY_CHAT"] = "대화창 표시",
		["OPT_DISPLAY_BOTH"] = "대화창 및 화면 중앙 모두 표시",
		["OPT_DISPLAY_NONE"] = "표시 없음.",

		["FUBAR_TOOLTIP_HINT"] = "FuBar를 이용한 퀘스트알리미 환경설정",

		["ADVMSG"] = "$NumItems / $NumNeeded $ItemName ($NumLeft 남음)",
		["FINMSG"] = "$NumItems / $NumNeeded $ItemName (완료)",
		["(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$"] = "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$",
	}
end)
