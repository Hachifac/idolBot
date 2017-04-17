#NoEnv
SendMode Input

_GUIChooseCampaign:
	Gui, Submit, NoHide
	optTempCampaign := guiCampaignChoice
	Return

_GUISetFormationQ:
	GuiControl,, guiFormationQ, images/gui/bF1_on.png
	GuiControl,, guiFormationW, images/gui/bF2_off.png
	GuiControl,, guiFormationE, images/gui/bF3_off.png
	optTempFormation = 1
	optTempFormationKey = q
	Return
	
_GUISetFormationW:
	GuiControl,, guiFormationQ, images/gui/bF1_off.png
	GuiControl,, guiFormationW, images/gui/bF2_on.png
	GuiControl,, guiFormationE, images/gui/bF3_off.png
	optTempFormation = 2
	optTempFormationKey = w
	Return

_GUISetFormationE:
	GuiControl,, guiFormationQ, images/gui/bF1_off.png
	GuiControl,, guiFormationW, images/gui/bF2_off.png
	GuiControl,, guiFormationE, images/gui/bF3_on.png
	optTempFormation = 3
	optTempFormationKey = e
	Return

_GUIChooseMainDPS:
	Gui, Submit, NoHide
	optTempMainDPS := guiMainDPSChoice
	Return

_GUIChooseReset:
	Gui, Submit, NoHide
	optTempResetType := guiResetChoice
	Return
	
_GUISetClickingOn:
	GuiControl,, guiClickingStatusOn, images/gui/bOn_on.png
	GuiControl,, guiClickingStatusOff, images/gui/bOff_off.png
	optTempClicking = 1
	Return

_GUISetClickingOff:
	GuiControl,, guiClickingStatusOn, images/gui/bOn_off.png
	GuiControl,, guiClickingStatusOff, images/gui/bOff_on.png
	optTempClicking = 0
	Return
	
_GUISetStormRiderFormationQ:
	GuiControl,, guiStormRiderFormationQ, images/gui/bF1_on.png
	GuiControl,, guiStormRiderFormationW, images/gui/bF2_off.png
	GuiControl,, guiStormRiderFormationE, images/gui/bF3_off.png
	GuiControl,, guiStormRiderFormationD, images/gui/bF0_off.png
	optTempStormRiderFormation = 1
	optTempStormRiderFormationKey = q
	Return
	
_GUISetStormRiderFormationW:
	GuiControl,, guiStormRiderFormationQ, images/gui/bF1_off.png
	GuiControl,, guiStormRiderFormationW, images/gui/bF2_on.png
	GuiControl,, guiStormRiderFormationE, images/gui/bF3_off.png
	GuiControl,, guiStormRiderFormationD, images/gui/bF0_off.png
	optTempStormRiderFormation = 2
	optTempStormRiderFormationKey = w
	Return

_GUISetStormRiderFormationE:
	GuiControl,, guiStormRiderFormationQ, images/gui/bF1_off.png
	GuiControl,, guiStormRiderFormationW, images/gui/bF2_off.png
	GuiControl,, guiStormRiderFormationE, images/gui/bF3_on.png
	GuiControl,, guiStormRiderFormationD, images/gui/bF0_off.png
	optTempStormRiderFormation = 3
	optTempStormRiderFormationKey = e
	Return
	
_GUISetStormRiderFormationD:
	GuiControl,, guiStormRiderFormationQ, images/gui/bF1_off.png
	GuiControl,, guiStormRiderFormationW, images/gui/bF2_off.png
	GuiControl,, guiStormRiderFormationE, images/gui/bF3_off.png
	GuiControl,, guiStormRiderFormationD, images/gui/bF0_on.png
	optTempStormRiderFormation := 0
	optTempStormRiderFormationKey := optFormationKey
	Return
	
_GUISetStormRiderMagnifyOn:
	GuiControl,, guiStormRiderMagnifyStatusOn, images/gui/bOn_on.png
	GuiControl,, guiStormRiderMagnifyStatusOff, images/gui/bOff_off.png
	optTempStormRiderMagnify = 1
	Return

_GUISetStormRiderMagnifyOff:
	GuiControl,, guiStormRiderMagnifyStatusOn, images/gui/bOn_off.png
	GuiControl,, guiStormRiderMagnifyStatusOff, images/gui/bOff_on.png
	optTempStormRiderMagnify = 0
	Return
	
_GUIHelpAdvanced:
	Loop {
		MouseGetPos,,,, OutputVarControl
		help := null
		if (OutputVarControl = "Static2") {
			help = Once the bot max all the levels [VALUE] of times, it will buy all upgrades.`nExample: If the value is 5, after 5 max all levels the bot will upgrade.
		} else if (OutputVarControl = "Static3") {
			help = Delay, in minutes, in which the bot will start leveling up the Main DPS while ignoring the other crusaders.
		} else if (OutputVarControl = "Static4") {
			help = Chat room to auto join when the bot launches.`nIf you change this setting mid-run the bot will not change the room.`nSet to 0 to disable.
		} else if (OutputVarControl = "Static5") {
			help = Delay, in milliseconds, between each click in the click & loot phase.`nThis can induce lag.
		} else if (OutputVarControl = "Static6") {
			help = Delay, in minutes, before the bot resets the world if the reset is set to Timed
		} else if (OutputVarControl = "Static7") {
			help = The level on which the bot will reset the world if the reset is set to On level
		} else if (OutputVarControl = "Static9") {
			help = Time, in seconds, spent looting items
		} else if (OutputVarControl = "Static12") {
			help = When active, the bot will relaunch the game after every resets.`nThis is useful if your game experiences memory leak.
		} else if (OutputVarControl = "Static13") {
			help = Move the game to the desired position when launching the bot
		} else {
			ToolTip,
			Break
		}
		ToolTip, % help
		Sleep, 100
	}
	Return	

_GUIHelpOptions:
	Loop {
		MouseGetPos,,,, OutputVarControl
		help := null
		if (OutputVarControl = "Static6") {
			help = Max progress: The bot will reset when the formation dies`nLevel cap: The bot will reset when all crusaders are maxed. (still in beta, might not work as intended)`nFast: The bot will reset at level 6 while maximizing idols gain. (Not yet implemented)`nTimed run: The bot will reset when the Advanced Option [Run Time] has elapsed.`nOn level: The bot will reset once it reaches the level set in Advanced Option [Reset on level]
		} else {
			ToolTip,
			Break
		}
		ToolTip, % help
		Sleep, 100
	}
	Return

_GUIHelpStormRider:
	Loop {
		MouseGetPos,,,, OutputVarControl
		help := null
		if (OutputVarControl = "Static5") {
			help = When active, the bot will use Magnify before Storm Rider.`nNote that it requires the Magnify crusader to be in the Storm Rider formation.
		} else if (OutputVarcontrol = "Static10") {
			help = The formation in which your Storm Rider crusader is. When set to [D], it will use the main formation set in Options.
		} else {
			ToolTip,
			Break
		}
		ToolTip, % help
		Sleep, 100
	}
	Return
	
_GUICloseOptions:
	Gosub, _GUICloseAdvancedOptions
	Gui, BotGUIOptions: Hide
	GuiControl, BotGUI:, buttonOptions, images/gui/bOptions.png
	GuiControl, BotGUIOptions: Choose, guiCampaignChoice, % optCampaign
	f1 := "images/gui/bF1_off.png"
	f2 := "images/gui/bF2_off.png"
	f3 := "images/gui/bF3_off.png"
	f%optFormation% := "images/gui/bF" . optFormation . "_on.png"
	GuiControl, BotGUIOptions:, guiFormationQ, % f1
	GuiControl, BotGUIOptions:, guiFormationW, % f2
	GuiControl, BotGUIOptions:, guiFormationE, % f3
	GuiControl, BotGUIOptions: ChooseString, guiMainDPSChoice, % optMainDPS
	GuiControl, BotGUIOptions: Choose, guiResetChoice, % optResetType
	if (optClicking = 1) {
		GuiControl, BotGUIOptions:, guiClickingStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIOptions:, guiClickingStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIOptions:, guiClickingStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIOptions:, guiClickingStatusOff, images/gui/bOff_on.png
	}
	Return

_GUICloseAdvancedOptions:
	Gui, BotGUIAdvancedOptions: Hide
	GuiControl, BotGUIAdvancedOptions:, guiUpgAllUntil, % optUpgAllUntil
	GuiControl, BotGUIAdvancedOptions:, guiMainDPSDelay, % optMainDPSDelay
	GuiControl, BotGUIAdvancedOptions:, guiChatRoom, % optChatRoom
	GuiControl, BotGUIAdvancedOptions:, guiClickDelay, % optClickDelay
	GuiControl, BotGUIAdvancedOptions:, guiRunTime, % optRunTime
	GuiControl, BotGUIAdvancedOptions:, guiResetOnLevel, % optResetOnLevel
	GuiControl, BotGUIAdvancedOptions:, guiLootItemsDuration, % optLootItemsDuration
	if (optRelaunchGame = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiRelaunchGameStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiRelaunchGameStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiRelaunchGameStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiRelaunchGameStatusOff, images/gui/bOff_on.png
	}
	GuiControl, BotGUIAdvancedOptions: Choose, guiMoveGameWindowChoice, % optMoveGameWindow
	Return	

_GUICloseStats:
	GuiControl, BotGUI:, buttonStats, images/gui/bStats.png
	Gui, BotGUIStats: Hide
	Return

_GUICloseAbout:
	GuiControl, BotGUI:, buttonAbout, images/gui/bAbout.png
	Gui, BotGUIAbout: Hide
	Return

_GUICloseStormRider:
	GuiControl, BotGUI:, buttonStormRider, images/gui/bStormRider.png
	Gui, BotGUIStormRider: Hide
	f1 := "images/gui/bF1_off.png"
	f2 := "images/gui/bF2_off.png"
	f3 := "images/gui/bF3_off.png"
	f0 := "images/gui/bF0_off.png"
	f%optStormRiderFormation% := "images/gui/bF" . optStormRiderFormation . "_on.png"
	GuiControl, BotGUIStormRider:, guiStormRiderFormationQ, % f1
	GuiControl, BotGUIStormRider:, guiStormRiderFormationW, % f2
	GuiControl, BotGUIStormRider:, guiStormRiderFormationE, % f3
	GuiControl, BotGUIStormRider:, guiStormRiderFormationD, % f0
	Return

_GUICloseOtherWindows:
	Gosub, _GUICloseOptions
	Gosub, _GUICloseAdvancedOptions
	Gosub, _GUICloseStormRider
	Gosub, _GUICloseStats
	Gosub, _GUICloseAbout
	Return
	
; Self-explanatory
_GUIApplyAdvancedOptions:
	Gui, Submit, NoHide
	GuiControlGet, optUpgAllUntil,, guiUpgAllUntil
	GuiControlGet, optMainDPSDelay,, guiMainDPSDelay
	optLastChatRoom := optChatRoom
	GuiControlGet, optChatRoom,, guiChatRoom
	GuiControlGet, optClickDelay,, guiClickDelay
	GuiControlGet, optRunTime,, guiRunTime
	GuiControlGet, optResetOnLevel,, guiResetOnLevel
	GuiControlGet, optLootItemsDuration,, guiLootItemsDuration
	optRelaunchGame := optTempRelaunchGame
	optMoveGameWindow := optTempMoveGameWindow
	Gosub, _BotRewriteSettings
	Gui, BotGUIAdvancedOptions: Hide
	Return
	
_GUIApplyOptions:
	Gui, Submit, NoHide
	optCampaign := optTempCampaign
	optFormation := optTempFormation
	optFormationKey := optTempFormationKey
	optMainDPS := optTempMainDPS
	optResetType := optTempResetType
	optClicking := optTempClicking
	Gosub, _BotRewriteSettings
	GuiControl, BotGUI:, buttonOptions, images/gui/bOptions.png
	Gui, BotGUIOptions: Hide
	Return
	
_GUIApplyStormRider:
	Gui, Submit, NoHide
	optStormRiderFormation := optTempStormRiderFormation
	optStormRiderFormationKey := optTempStormRiderFormationKey
	optStormRiderMagnify := optTempStormRiderMagnify
	Gosub, _BotRewriteSettings
	GuiControl, BotGUI:, buttonStormRider, images/gui/bStormRider.png
	Gui, BotGUIStormRider: Hide
	Return	

_GUIOptions:
	Gosub, _GUICloseOtherWindows
	GuiControl, BotGUI:, buttonOptions, images/gui/bOptions_active.png
	winW = 252
	winH = 407
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIOptions: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Options
	Return

_GUIAdvancedOptions:
	winW = 252
	winH = 477
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/bAdvanced.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X + 30
	nY := Output2Y - 30
	Gui, BotGUIAdvancedOptions: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Advanced Options
	Return

_GUIAdvancedOptionsAdvancedTab:
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsAdvancedTab, images/gui/guiAdvancedOptionsAdvanced_tab_active.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsMoreTab, images/gui/guiAdvancedOptionsMore_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 1
	Return
	
_GUIAdvancedOptionsMoreTab:
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsAdvancedTab, images/gui/guiAdvancedOptionsAdvanced_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsMoreTab, images/gui/guiAdvancedOptionsMore_tab_active.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 2
	Return

_GUISetRelaunchGameOn:
	GuiControl,, guiRelaunchGameStatusOn, images/gui/bOn_on.png
	GuiControl,, guiRelaunchGameStatusOff, images/gui/bOff_off.png
	optTempRelaunchGame = 1
	Return

_GUISetRelaunchGameOff:
	GuiControl,, guiRelaunchGameStatusOn, images/gui/bOn_off.png
	GuiControl,, guiRelaunchGameStatusOff, images/gui/bOff_on.png
	optTempRelaunchGame = 0
	Return	

_GUIChooseMoveGameWindow:
	Gui, Submit, NoHide
	optTempMoveGameWindow := guiMoveGameWindowChoice
	Return
	
_GUIStats:
	Gosub, _GUICloseOtherWindows
	GuiControl, BotGUI:, buttonStats, images/gui/bStats_active.png
	winW = 252
	winH = 261
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y  - winH
	Gosub, _BotLoadStats
	statsIdolsThisSessionPerHour := __RoundNumber(statsIdolsThisSession / (__UnixTime(A_Now) - botLaunchTime) * 60 * 60, 2)
	statsChestsThisSessionPerHour := __RoundNumber(statsChestsThisSession / (__UnixTime(A_Now) - botLaunchTime) * 60 * 60, 2)
	statsIdolsLastRunPerHour := __RoundNumber(statsIdolsLastRun / statsIdolsLastRunTime * 60 * 60, 2)
	statsIdolsPastDayPerHour := __RoundNumber(statsIdolsPastDay / 86400 * 60 * 60, 2)
	statsChestsThisRunPerHour := __RoundNumber(statsChestsThisRun / (__UnixTime(A_Now) - botLaunchTime) * 60 * 60, 2)
	statsChestsLastRunPerHour := __RoundNumber(statsChestsLastRun / statsChestsLastRunTime * 60 * 60, 2)
	statsChestsPastDayPerHour := __RoundNumber(statsChestsPastDay / 86400 * 60 * 60, 2)
	GuiControl, BotGUIStats:, guiIdolsLastRun, %statsIdolsLastRun% (%statsIdolsLastRunPerHour%/hr)
	GuiControl, BotGUIStats:, guiIdolsThisSession, %statsIdolsThisSession% (%statsIdolsThisSessionPerHour%/hr)
	GuiControl, BotGUIStats:, guiIdolsPastDay, %statsIdolsPastDay% (%statsIdolsPastDayPerHour%/hr)
	GuiControl, BotGUIStats:, guiIdolsAllTime, %statsIdolsAllTime%
	GuiControl, BotGUIStats:, guiChestsThisRun, %statsChestsThisRun% (%statsChestsThisRunPerHour%/hr)
	GuiControl, BotGUIStats:, guiChestsLastRun, %statsChestsLastRun% (%statsChestsLastRunPerHour%/hr)
	GuiControl, BotGUIStats:, guiChestsThisSession, %statsChestsThisSession% (%statsChestsThisSessionPerHour%/hr)
	GuiControl, BotGUIStats:, guiChestsPastDay, %statsChestsPastDay% (%statsChestsPastDayPerHour%/hr)
	GuiControl, BotGUIStats:, guiChestsAllTime, %statsChestsAllTime%
	Gui, BotGUIStats: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Stats
	Return

_GUIStatsIdolsTab:
	GuiControl, BotGUIStats:, guiStatsIdolsTab, images/gui/guiStatsIdols_tab_active.png
	GuiControl, BotGUIStats:, guiStatsChestsTab, images/gui/guiStatsChests_tab_inactive.png
	GuiControl, BotGUIStats:Choose, guiStatsTabs, 1
	Gui, BotGUIStats: Show, h261, idolBot Stats
	Return
	
_GUIStatsChestsTab:
	GuiControl, BotGUIStats:, guiStatsIdolsTab, images/gui/guiStatsIdols_tab_inactive.png
	GuiControl, BotGUIStats:, guiStatsChestsTab, images/gui/guiStatsChests_tab_active.png
	GuiControl, BotGUIStats:Choose, guiStatsTabs, 2
	Gui, BotGUIStats: Show, h304, idolBot Stats
	Return
	
_GUIAbout:
	Gosub, _GUICloseOtherWindows
	GuiControl, BotGUI:, buttonAbout, images/gui/bAbout_active.png
	winW = 252
	winH = 290
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIAbout: Show, x%nX% y%nY% w%winW% h%winH%, idolBot About
	Return

_GUIStormRider:
	Gosub, _GUICloseOtherWindows
	GuiControl, BotGUI:, buttonStormRider, images/gui/bStormRider_active.png
	winW = 182
	winH = 199
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIStormRider: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Storm Rider
	Return