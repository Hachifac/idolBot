#NoEnv
SendMode Input

_GUIChooseCampaign:
	Gui, Submit, NoHide
	optTempCampaign := guiCampaignChoice
	Return

_GUISetBackupCampaign:
	Gui, Submit, NoHide
	if (guiCampaignChoice > 1) {
		optTempBackupCampaign := guiCampaignChoice
		GuiControl,, guiBackupCampaign, % "images/gui/backupc" . optTempBackupCampaign . ".png"
	}
	Return
	
_GUISetFormationQ:
	GuiControl,, guiFormationQ, images/gui/bF1_on.png
	GuiControl,, guiFormationW, images/gui/bF2_off.png
	GuiControl,, guiFormationE, images/gui/bF3_off.png
	GuiControl,, guiFormationOff, images/gui/bFOff_off.png
	optTempFormation = 1
	optTempFormationKey = q
	Return
	
_GUISetFormationW:
	GuiControl,, guiFormationQ, images/gui/bF1_off.png
	GuiControl,, guiFormationW, images/gui/bF2_on.png
	GuiControl,, guiFormationE, images/gui/bF3_off.png
	GuiControl,, guiFormationOff, images/gui/bFOff_off.png
	optTempFormation = 2
	optTempFormationKey = w
	Return

_GUISetFormationE:
	GuiControl,, guiFormationQ, images/gui/bF1_off.png
	GuiControl,, guiFormationW, images/gui/bF2_off.png
	GuiControl,, guiFormationE, images/gui/bF3_on.png
	GuiControl,, guiFormationOff, images/gui/bFOff_off.png
	optTempFormation = 3
	optTempFormationKey = e
	Return

_GUISetFormationOff:
	GuiControl,, guiFormationQ, images/gui/bF1_off.png
	GuiControl,, guiFormationW, images/gui/bF2_off.png
	GuiControl,, guiFormationE, images/gui/bF3_off.png
	GuiControl,, guiFormationOff, images/gui/bFOff_on.png
	optTempFormation = 0
	optTempFormationKey = 0
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

_GUISetBuffsGoldCOn:
	status = off
	if (optTempBuffsGoldC = 1) {
		optTempBuffsGoldC = 0
	} else {
		optTempBuffsGoldC = 1
		status = on
	}
	GuiControl,, guiBuffsGoldCStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsGoldUOn:
	status = off
	if (optTempBuffsGoldU = 1) {
		optTempBuffsGoldU = 0
	} else {
		optTempBuffsGoldU = 1
		status = on
	}
	GuiControl,, guiBuffsGoldUStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsGoldROn:
	status = off
	if (optTempBuffsGoldR = 1) {
		optTempBuffsGoldR = 0
	} else {
		optTempBuffsGoldR = 1
		status = on
	}
	GuiControl,, guiBuffsGoldRStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsGoldEOn:
	status = off
	if (optTempBuffsGoldE = 1) {
		optTempBuffsGoldE = 0
	} else {
		optTempBuffsGoldE = 1
		status = on
	}
	GuiControl,, guiBuffsGoldEStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsPowerCOn:
	status = off
	if (optTempBuffsPowerC = 1) {
		optTempBuffsPowerC = 0
	} else {
		optTempBuffsPowerC = 1
		status = on
	}
	GuiControl,, guiBuffsPowerCStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsPowerUOn:
	status = off
	if (optTempBuffsPowerU = 1) {
		optTempBuffsPowerU = 0
	} else {
		optTempBuffsPowerU = 1
		status = on
	}
	GuiControl,, guiBuffsPowerUStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsPowerROn:
	status = off
	if (optTempBuffsPowerR = 1) {
		optTempBuffsPowerR = 0
	} else {
		optTempBuffsPowerR = 1
		status = on
	}
	GuiControl,, guiBuffsPowerRStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsPowerEOn:
	status = off
	if (optTempBuffsPowerE = 1) {
		optTempBuffsPowerE = 0
	} else {
		optTempBuffsPowerE = 1
		status = on
	}
	GuiControl,, guiBuffsPowerEStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsSpeedCOn:
	status = off
	if (optTempBuffsSpeedC = 1) {
		optTempBuffsSpeedC = 0
	} else {
		optTempBuffsSpeedC = 1
		status = on
	}
	GuiControl,, guiBuffsSpeedCStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsSpeedUOn:
	status = off
	if (optTempBuffsSpeedU = 1) {
		optTempBuffsSpeedU = 0
	} else {
		optTempBuffsSpeedU = 1
		status = on
	}
	GuiControl,, guiBuffsSpeedUStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsSpeedROn:
	status = off
	if (optTempBuffsSpeedR = 1) {
		optTempBuffsSpeedR = 0
	} else {
		optTempBuffsSpeedR = 1
		status = on
	}
	GuiControl,, guiBuffsSpeedRStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsSpeedEOn:
	status = off
	if (optTempBuffsSpeedE = 1) {
		optTempBuffsSpeedE = 0
	} else {
		optTempBuffsSpeedE = 1
		status = on
	}
	GuiControl,, guiBuffsSpeedEStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsCritCOn:
	status = off
	if (optTempBuffsCritC = 1) {
		optTempBuffsCritC = 0
	} else {
		optTempBuffsCritC = 1
		status = on
	}
	GuiControl,, guiBuffsCritCStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsCritUOn:
	status = off
	if (optTempBuffsCritU = 1) {
		optTempBuffsCritU = 0
	} else {
		optTempBuffsCritU = 1
		status = on
	}
	GuiControl,, guiBuffsCritUStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsCritROn:
	status = off
	if (optTempBuffsCritR = 1) {
		optTempBuffsCritR = 0
	} else {
		optTempBuffsCritR = 1
		status = on
	}
	GuiControl,, guiBuffsCritRStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsCritEOn:
	status = off
	if (optTempBuffsCritE = 1) {
		optTempBuffsCritE = 0
	} else {
		optTempBuffsCritE = 1
		status = on
	}
	GuiControl,, guiBuffsCritEStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsClickCOn:
	status = off
	if (optTempBuffsClickC = 1) {
		optTempBuffsClickC = 0
	} else {
		optTempBuffsClickC = 1
		status = on
	}
	GuiControl,, guiBuffsClickCStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsClickUOn:
	status = off
	if (optTempBuffsClickU = 1) {
		optTempBuffsClickU = 0
	} else {
		optTempBuffsClickU = 1
		status = on
	}
	GuiControl,, guiBuffsClickUStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsClickROn:
	status = off
	if (optTempBuffsClickR = 1) {
		optTempBuffsClickR = 0
	} else {
		optTempBuffsClickR = 1
		status = on
	}
	GuiControl,, guiBuffsClickRStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsClickEOn:
	status = off
	if (optTempBuffsClickE = 1) {
		optTempBuffsClickE = 0
	} else {
		optTempBuffsClickE = 1
		status = on
	}
	GuiControl,, guiBuffsClickEStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsSplashCOn:
	status = off
	if (optTempBuffsSplashC = 1) {
		optTempBuffsSplashC = 0
	} else {
		optTempBuffsSplashC = 1
		status = on
	}
	GuiControl,, guiBuffsSplashCStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsSplashUOn:
	status = off
	if (optTempBuffsSplashU = 1) {
		optTempBuffsSplashU = 0
	} else {
		optTempBuffsSplashU = 1
		status = on
	}
	GuiControl,, guiBuffsSplashUStatus, images/gui/bUse_%status%.png
	Return
	
_GUISetBuffsSplashROn:
	status = off
	if (optTempBuffsSplashR = 1) {
		optTempBuffsSplashR = 0
	} else {
		optTempBuffsSplashR = 1
		status = on
	}
	GuiControl,, guiBuffsSplashRStatus, images/gui/bUse_%status%.png
	Return

_GUISetBuffsSplashEOn:
	status = off
	if (optTempBuffsSplashE = 1) {
		optTempBuffsSplashE = 0
	} else {
		optTempBuffsSplashE = 1
		status = on
	}
	GuiControl,, guiBuffsSplashEStatus, images/gui/bUse_%status%.png
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
		} else if (OutputVarControl = "Static16") {
			help = When activated, the bot will check if max progress has been achieved regardless of the reset type (Fast mode excluded).`nExample: You set reset to On level 400 but your formation dies on 300, the bot will reset`nDelay: Delay, in seconds, between each Auto progress check.
		} else if (OutputVarControl = "Static17") {
			help = When set to Always on, the bot will make sure auto progress is active at all time.`nKeep in mind that it can mess with the On level reset, which I would strongly suggest to turn on Prompt on current level after pause.`nThe Max progress reset is excluded from this setting, it will always make sure auto progress is active.
		} else if (OutputVarControl = "Static20") {
			help = Due to some limitations, if you proceed to pause the bot then manually play for a while, the bot could lose the current level.`nExample: You set reset to level 750 and you pause the bot on level 500 and unpause it on level 700, the bot still thinks it's on level 500 and won't reset until the game reaches the level 950.`nTurning this on will prompt you with a popup to set the current level every time you unpause.
		} else if (OutputVarControl = "Static28") {
			help = When activated, the bot will reset the run if it gets stuck on the same level for the set delay.
		} else if (OutputVarControl = "Static43") {
			help = When turning this option on, the bot will take longer to refresh some GUI elements and will turn off chests stats.`nTurn on if you experience lag with the bot.
		} else if (OutputVarControl = "Static44") {
			help = The higher the value, the slower the bot "thinks".`nChange it to a higher value if the game runs slower on your computer.
		} else if (OutputVarControl = "Static47") {
			help = IMPORTANT: THE BOT MUST RUN AS ADMINISTRATOR FOR THIS FEATURE TO WORK.`n`nWhen turning this option on, the bot will make use of Cheat Engine.`nHave the desired speed already preset in Cheat Engine and have speedhack turned off.
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
		if (OutputVarControl = "Static5") {
			help = If the bot cannot launch an event free play due to a lack of currency, it will instead launch the backup campaign.
		} else if (OutputVarControl = "Static10") {
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
	
_GUIHelpBuffs:
	Loop {
		MouseGetPos,,,, OutputVarControl
		help := null
		if (OutputVarControl = "Static37") {
			help = When a buff is set to Use, the bot will... use the buff.`nWhen the interval is set to 0, the bot will only use 1 buff at the start of a run. If set to anything else than 0, the bot will still use one at the start of a run then use another one at every interval.`nThe interval is in minutes.
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
	GuiControl, BotGUIOptions:, guiBackupCampaign, % "images/gui/backupc" . optBackupCampaign . ".png"
	f1 := "images/gui/bF1_off.png"
	f2 := "images/gui/bF2_off.png"
	f3 := "images/gui/bF3_off.png"
	fOff := "images/gui/bFOff_off.png"
	if (optFormation > 0) {
		f%optFormation% := "images/gui/bF" . optFormation . "_on.png"
	} else {
		fOff := "images/gui/bFOff_on.png"
	}
	GuiControl, BotGUIOptions:, guiFormationQ, % f1
	GuiControl, BotGUIOptions:, guiFormationW, % f2
	GuiControl, BotGUIOptions:, guiFormationE, % f3
	GuiControl, BotGUIOptions:, guiFormationOff, %fOff%
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
	GuiControl, BotGUIAdvancedOptions: Choose, guiRelaunchGameFrequencyChoice, % optRelaunchGameFrequency
	GuiControl, BotGUIAdvancedOptions: Choose, guiMoveGameWindowChoice, % optMoveGameWindow
	if (optAutoProgressCheck = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiAutoProgressCheckStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiAutoProgressCheckStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiAutoProgressCheckStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiAutoProgressCheckStatusOff, images/gui/bOff_on.png
	}
	GuiControl, BotGUIAdvancedOptions:, guiAutoProgressCheckDelay, % optAutoProgressCheckDelay
	GuiControl, BotGUIAdvancedOptions: Choose, guiAutoProgressChoice, % optAutoProgress
	GuiControl, BotGUIAdvancedOptions: Choose, guiMoveGameWindowChoice, % optMoveGameWindow
	if (optPromptCurrentLevel = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiPromptCurrentLevelStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiPromptCurrentLevelStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiPromptCurrentLevelStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiPromptCurrentLevelStatusOff, images/gui/bOff_on.png
	}
	if (optUseChests = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiUseChestsStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiUseChestsStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiUseChestsStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiUseChestsStatusOff, images/gui/bOff_on.png
	}
	GuiControl, BotGUIAdvancedOptions: ChooseString, guiUseChestsAmountChoice, % optUseChestsAmount
	if (optSkillsRoyalCommand = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiUseSkillsRoyalCommandStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiUseSkillsRoyalCommandStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiUseSkillsRoyalCommandStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiUseSkillsRoyalCommandStatusOff, images/gui/bOff_on.png
	}
	if (optSameLevelTimeout = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiSameLevelTimeoutStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiSameLevelTimeoutStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiSameLevelTimeoutStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiSameLevelTimeoutStatusOff, images/gui/bOff_on.png
	}
	GuiControl, BotGUIAdvancedOptions:, guiSameLevelTimeoutDelay, % optSameLevelTimeoutDelay
	GuiControl, BotGUIAdvancedOptions: ChooseString, guiForceStartHotkey1Choice, % optForceStartHotkey1
	GuiControl, BotGUIAdvancedOptions: ChooseString, guiPauseHotkey1Choice, % optPauseHotkey1
	GuiControl, BotGUIAdvancedOptions: ChooseString, guiReloadHotkey1Choice, % optReloadHotkey1
	GuiControl, BotGUIAdvancedOptions: ChooseString, guiExitHotkey1Choice, % optExitHotkey1
	GuiControl, BotGUIAdvancedOptions: ChooseString, guiForceResetHotkey1Choice, % optForceResetHotkey1
	if (optForceStartHotkey2) {
		GuiControl, BotGUIAdvancedOptions: ChooseString, guiForceStartHotkey2Choice, % optForceStartHotkey2
	} else {
		GuiControl, BotGUIAdvancedOptions: Choose, guiForceStartHotkey2Choice, 1
	}
	if (optForceResetHotkey2) {
		GuiControl, BotGUIAdvancedOptions: ChooseString, guiForceResetHotkey2Choice, % optForceResetHotkey2
	} else {
		GuiControl, BotGUIAdvancedOptions: Choose, guiForceResetHotkey2Choice, 1
	}
	if (optPauseHotkey2) {
		GuiControl, BotGUIAdvancedOptions: ChooseString, guiPauseHotkey2Choice, % optPauseHotkey2
	} else {
		GuiControl, BotGUIAdvancedOptions: Choose, guiPauseHotkey2Choice, 1
	}
	if (optReloadHotkey2) {
		GuiControl, BotGUIAdvancedOptions: ChooseString, guiReloadHotkey2Choice, % optReloadHotkey2
	} else {
		GuiControl, BotGUIAdvancedOptions: Choose, guiReloadHotkey2Choice, 1
	}
	if (optExitHotkey2) {
		GuiControl, BotGUIAdvancedOptions: ChooseString, guiExitHotkey2Choice, % optExitHotkey2
	} else {
		GuiControl, BotGUIAdvancedOptions: Choose, guiExitHotkey2Choice, 1
	}
	if (optBotLighter = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiUseLightVersionStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiUseLightVersionStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiUseLightVersionStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiUseLightVersionStatusOff, images/gui/bOff_on.png
	}
	GuiControl, BotGUIAdvancedOptions:, guiBotClockSpeed, % optBotClockSpeed
	if (optCheatEngine = 1) {
		GuiControl, BotGUIAdvancedOptions:, guiUseCheatEngineStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIAdvancedOptions:, guiUseCheatEngineStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIAdvancedOptions:, guiUseCheatEngineStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIAdvancedOptions:, guiUseCheatEngineStatusOff, images/gui/bOff_on.png
	}
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

_GUICloseBuffs:
	GuiControl, BotGUI:, buttonBuffs, images/gui/BBuffs.png
	Gui, BotGUIBuffs: Hide
	if (optBuffsGoldC = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsGoldCStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsGoldCStatus, images/gui/bUse_off.png
	}
	if (optBuffsGoldU = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsGoldUStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsGoldUStatus, images/gui/bUse_off.png
	}
	if (optBuffsGoldR = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsGoldRStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsGoldRStatus, images/gui/bUse_off.png
	}
	if (optBuffsGoldE = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsGoldEStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsGoldEStatus, images/gui/bUse_off.png
	}
	optTempBuffsGoldC := optBuffsGoldC
	optTempBuffsGoldU := optBuffsGoldU
	optTempBuffsGoldR := optBuffsGoldR
	optTempBuffsGoldE := optBuffsGoldE
	GuiControl, BotGUIBuffs:, guiBuffsGoldCInterval, % optBuffsGoldCInterval
	GuiControl, BotGUIBuffs:, guiBuffsGoldUInterval, % optBuffsGoldUInterval
	GuiControl, BotGUIBuffs:, guiBuffsGoldRInterval, % optBuffsGoldRInterval
	GuiControl, BotGUIBuffs:, guiBuffsGoldEInterval, % optBuffsGoldEInterval
	if (optBuffsPowerC = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsPowerCStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsPowerCStatus, images/gui/bUse_off.png
	}
	if (optBuffsPowerU = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsPowerUStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsPowerUStatus, images/gui/bUse_off.png
	}
	if (optBuffsPowerR = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsPowerRStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsPowerRStatus, images/gui/bUse_off.png
	}
	if (optBuffsPowerE = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsPowerEStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsPowerEStatus, images/gui/bUse_off.png
	}
	optTempBuffsPowerC := optBuffsPowerC
	optTempBuffsPowerU := optBuffsPowerU
	optTempBuffsPowerR := optBuffsPowerR
	optTempBuffsPowerE := optBuffsPowerE
	GuiControl, BotGUIBuffs:, guiBuffsPowerCInterval, % optBuffsPowerCInterval
	GuiControl, BotGUIBuffs:, guiBuffsPowerUInterval, % optBuffsPowerUInterval
	GuiControl, BotGUIBuffs:, guiBuffsPowerRInterval, % optBuffsPowerRInterval
	GuiControl, BotGUIBuffs:, guiBuffsPowerEInterval, % optBuffsPowerEInterval
	if (optBuffsSpeedC = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedCStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedCStatus, images/gui/bUse_off.png
	}
	if (optBuffsSpeedU = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedUStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedUStatus, images/gui/bUse_off.png
	}
	if (optBuffsSpeedR = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedRStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedRStatus, images/gui/bUse_off.png
	}
	if (optBuffsSpeedE = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedEStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSpeedEStatus, images/gui/bUse_off.png
	}
	optTempBuffsSpeedC := optBuffsSpeedC
	optTempBuffsSpeedU := optBuffsSpeedU
	optTempBuffsSpeedR := optBuffsSpeedR
	optTempBuffsSpeedE := optBuffsSpeedE
	GuiControl, BotGUIBuffs:, guiBuffsSpeedCInterval, % optBuffsSpeedCInterval
	GuiControl, BotGUIBuffs:, guiBuffsSpeedUInterval, % optBuffsSpeedUInterval
	GuiControl, BotGUIBuffs:, guiBuffsSpeedRInterval, % optBuffsSpeedRInterval
	GuiControl, BotGUIBuffs:, guiBuffsSpeedEInterval, % optBuffsSpeedEInterval
	if (optBuffsCritC = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsCritCStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsCritCStatus, images/gui/bUse_off.png
	}
	if (optBuffsCritU = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsCritUStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsCritUStatus, images/gui/bUse_off.png
	}
	if (optBuffsCritR = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsCritRStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsCritRStatus, images/gui/bUse_off.png
	}
	if (optBuffsCritE = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsCritEStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsCritEStatus, images/gui/bUse_off.png
	}
	optTempBuffsCritC := optBuffsCritC
	optTempBuffsCritU := optBuffsCritU
	optTempBuffsCritR := optBuffsCritR
	optTempBuffsCritE := optBuffsCritE
	GuiControl, BotGUIBuffs:, guiBuffsCritCInterval, % optBuffsCritCInterval
	GuiControl, BotGUIBuffs:, guiBuffsCritUInterval, % optBuffsCritUInterval
	GuiControl, BotGUIBuffs:, guiBuffsCritRInterval, % optBuffsCritRInterval
	GuiControl, BotGUIBuffs:, guiBuffsCritEInterval, % optBuffsCritEInterval
	if (optBuffsClickC = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsClickCStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsClickCStatus, images/gui/bUse_off.png
	}
	if (optBuffsClickU = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsClickUStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsClickUStatus, images/gui/bUse_off.png
	}
	if (optBuffsClickR = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsClickRStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsClickRStatus, images/gui/bUse_off.png
	}
	if (optBuffsClickE = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsClickEStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsClickEStatus, images/gui/bUse_off.png
	}
	optTempBuffsClickC := optBuffsClickC
	optTempBuffsClickU := optBuffsClickU
	optTempBuffsClickR := optBuffsClickR
	optTempBuffsClickE := optBuffsClickE
	GuiControl, BotGUIBuffs:, guiBuffsClickCInterval, % optBuffsClickCInterval
	GuiControl, BotGUIBuffs:, guiBuffsClickUInterval, % optBuffsClickUInterval
	GuiControl, BotGUIBuffs:, guiBuffsClickRInterval, % optBuffsClickRInterval
	GuiControl, BotGUIBuffs:, guiBuffsClickEInterval, % optBuffsClickEInterval
	if (optBuffsSplashC = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSplashCStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSplashCStatus, images/gui/bUse_off.png
	}
	if (optBuffsSplashU = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSplashUStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSplashUStatus, images/gui/bUse_off.png
	}
	if (optBuffsSplashR = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSplashRStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSplashRStatus, images/gui/bUse_off.png
	}
	if (optBuffsSplashE = 1) {
		GuiControl, BotGUIBuffs:, guiBuffsSplashEStatus, images/gui/bUse_on.png
	} else {
		GuiControl, BotGUIBuffs:, guiBuffsSplashEStatus, images/gui/bUse_off.png
	}
	optTempBuffsSplashC := optBuffsSplashC
	optTempBuffsSplashU := optBuffsSplashU
	optTempBuffsSplashR := optBuffsSplashR
	optTempBuffsSplashE := optBuffsSplashE
	GuiControl, BotGUIBuffs:, guiBuffsSplashCInterval, % optBuffsSplashCInterval
	GuiControl, BotGUIBuffs:, guiBuffsSplashUInterval, % optBuffsSplashUInterval
	GuiControl, BotGUIBuffs:, guiBuffsSplashRInterval, % optBuffsSplashRInterval
	GuiControl, BotGUIBuffs:, guiBuffsSplashEInterval, % optBuffsSplashEInterval
	Return
	
_GUICloseOtherWindows:
	Gosub, _GUICloseOptions
	Gosub, _GUICloseAdvancedOptions
	Gosub, _GUICloseStormRider
	Gosub, _GUICloseBuffs
	Gosub, _GUICloseStats
	Gosub, _GUICloseAbout
	Return
	
; Self-explanatory
_GUIApplyAdvancedOptions:
	Gui, Submit, NoHide
	proceed := true
	hotkeys := {1: optTempForceStartHotkey1 . optTempForceStartHotkey2
		, 2: optTempPauseHotkey1 . optTempPauseHotkey2
		, 3: optTempReloadHotkey1 . optTempReloadHotkey2
		, 4: optTempExitHotkey1 . optTempExitHotkey2
		, 5: optTempForceResetHotkey1 . optTempForceResetHotkey2}
	i = 1
	Loop, % hotkeys.length() - 1 {
		Loop, % hotkeys.length() - A_Index {
			if (hotkeys[i] = hotkeys[i - 1 + A_Index + 1]) {
				proceed := false
			}
		}
		i++
	}
	if (proceed = true) {
		GuiControlGet, optUpgAllUntil,, guiUpgAllUntil
		GuiControlGet, optMainDPSDelay,, guiMainDPSDelay
		optLastChatRoom := optChatRoom
		GuiControlGet, optChatRoom,, guiChatRoom
		GuiControlGet, optClickDelay,, guiClickDelay
		GuiControlGet, optRunTime,, guiRunTime
		GuiControlGet, optResetOnLevel,, guiResetOnLevel
		GuiControlGet, optLootItemsDuration,, guiLootItemsDuration
		optRelaunchGame := optTempRelaunchGame
		optRelaunchGameFrequency := optTempRelaunchGameFrequency
		optMoveGameWindow := optTempMoveGameWindow
		optAutoProgressCheck := optTempAutoProgressCheck
		GuiControlGet, optAutoProgressCheckDelay,, guiAutoProgressCheckDelay
		optAutoProgress := optTempAutoProgress
		optPromptCurrentLevel := optTempPromptCurrentLevel
		optUseChests := optTempUseChests
		optUseChestsAmount := optTempUseChestsAmount
		optSkillsRoyalCommand := optTempSkillsRoyalCommand
		optSameLevelTimeout := optTempSameLevelTimeout
		GuiControlGet, optSameLevelTimeoutDelay,, guiSameLevelTimeoutDelay
		optForceStartHotkey1 := optTempForceStartHotkey1
		optForceStartHotkey2 := optTempForceStartHotkey2
		optPauseHotkey1 := optTempPauseHotkey1
		optPauseHotkey2 := optTempPauseHotkey2
		optReloadHotkey1 := optTempReloadHotkey1
		optReloadHotkey2 := optTempReloadHotkey2
		optExitHotkey1 := optTempExitHotkey1
		optExitHotkey2 := optTempExitHotkey2
		optForceResetHotkey1 := optTempForceResetHotkey1
		optForceResetHotkey2 := optTempForceResetHotkey2
		optBotLighter := optTempBotLighter
		GuiControlGet, optBotClockSpeed,, guiBotClockSpeed
		optCheatEngine := optTempCheatEngine
		Gosub, _BotRewriteSettings
		Gosub, _BotSetHotkeys
		Gui, BotGUIAdvancedOptions: Hide
	} else {
		MsgBox, You cannot have the same hotkeys for different actions.
	}
	Return
	
_GUIApplyOptions:
	Gui, Submit, NoHide
	optCampaign := optTempCampaign
	optBackupCampaign := optTempBackupCampaign
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

_GUIApplyBuffs:
	Gui, Submit, NoHide
	optBuffsGoldC := optTempBuffsGoldC
	GuiControlGet, optBuffsGoldCInterval,, guiBuffsGoldCInterval
	optBuffsGoldU := optTempBuffsGoldU
	GuiControlGet, optBuffsGoldUInterval,, guiBuffsGoldUInterval
	optBuffsGoldR := optTempBuffsGoldR
	GuiControlGet, optBuffsGoldRInterval,, guiBuffsGoldRInterval
	optBuffsGoldE := optTempBuffsGoldE
	GuiControlGet, optBuffsGoldEInterval,, guiBuffsGoldEInterval
	optBuffsPowerC := optTempBuffsPowerC
	GuiControlGet, optBuffsPowerCInterval,, guiBuffsPowerCInterval
	optBuffsPowerU := optTempBuffsPowerU
	GuiControlGet, optBuffsPowerUInterval,, guiBuffsPowerUInterval
	optBuffsPowerR := optTempBuffsPowerR
	GuiControlGet, optBuffsPowerRInterval,, guiBuffsPowerRInterval
	optBuffsPowerE := optTempBuffsPowerE
	GuiControlGet, optBuffsPowerEInterval,, guiBuffsPowerEInterval
	optBuffsSpeedC := optTempBuffsSpeedC
	GuiControlGet, optBuffsSpeedCInterval,, guiBuffsSpeedCInterval
	optBuffsSpeedU := optTempBuffsSpeedU
	GuiControlGet, optBuffsSpeedUInterval,, guiBuffsSpeedUInterval
	optBuffsSpeedR := optTempBuffsSpeedR
	GuiControlGet, optBuffsSpeedRInterval,, guiBuffsSpeedRInterval
	optBuffsSpeedE := optTempBuffsSpeedE
	GuiControlGet, optBuffsSpeedEInterval,, guiBuffsSpeedEInterval
	optBuffsCritC := optTempBuffsCritC
	GuiControlGet, optBuffsCritCInterval,, guiBuffsCritCInterval
	optBuffsCritU := optTempBuffsCritU
	GuiControlGet, optBuffsCritUInterval,, guiBuffsCritUInterval
	optBuffsCritR := optTempBuffsCritR
	GuiControlGet, optBuffsCritRInterval,, guiBuffsCritRInterval
	optBuffsCritE := optTempBuffsCritE
	GuiControlGet, optBuffsCritEInterval,, guiBuffsCritEInterval
	optBuffsClickC := optTempBuffsClickC
	GuiControlGet, optBuffsClickCInterval,, guiBuffsClickCInterval
	optBuffsClickU := optTempBuffsClickU
	GuiControlGet, optBuffsClickUInterval,, guiBuffsClickUInterval
	optBuffsClickR := optTempBuffsClickR
	GuiControlGet, optBuffsClickRInterval,, guiBuffsClickRInterval
	optBuffsClickE := optTempBuffsClickE
	GuiControlGet, optBuffsClickEInterval,, guiBuffsClickEInterval
	optBuffsSplashC := optTempBuffsSplashC
	GuiControlGet, optBuffsSplashCInterval,, guiBuffsSplashCInterval
	optBuffsSplashU := optTempBuffsSplashU
	GuiControlGet, optBuffsSplashUInterval,, guiBuffsSplashUInterval
	optBuffsSplashR := optTempBuffsSplashR
	GuiControlGet, optBuffsSplashRInterval,, guiBuffsSplashRInterval
	optBuffsSplashE := optTempBuffsSplashE
	GuiControlGet, optBuffsSplashEInterval,, guiBuffsSplashEInterval
	Gosub, _BotRewriteSettings
	GuiControl, BotGUI:, buttonBuffs, images/gui/BBuffs.png
	Gui, BotGUIBuffs: Hide
	Return	
	
_GUIApplyCurrentLevel:
	GuiControlGet, botCurrentLevel,, guiCurrentLevel
	Gui, BotGUICurrentLevel: Hide
	Pause,, 1
	__GUIShowPause(false)
	Return

_GUICurrentLevel:
	Pause,, 1
	winW = 220
	winH = 149
	WinGetPos, X, Y, W, H, Crusaders of The Lost Idols
	nX := X + W / 2 - winW / 2
	nY := Y + H / 2 - winH / 2
	Gui, BotGUICurrentLevel: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Current Level
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
	if (botPhase > 0) {
		GuiControl, BotGUIOptions:Disable, guiResetChoice
	}
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
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsEvenmoreTab, images/gui/guiAdvancedOptionsEvenmore_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 1
	Return
	
_GUIAdvancedOptionsMoreTab:
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsAdvancedTab, images/gui/guiAdvancedOptionsAdvanced_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsMoreTab, images/gui/guiAdvancedOptionsMore_tab_active.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsEvenmoreTab, images/gui/guiAdvancedOptionsEvenmore_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 2
	Return
	
_GUIAdvancedOptionsEvenmoreTab:
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsAdvancedTab, images/gui/guiAdvancedOptionsAdvanced_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsMoreTab, images/gui/guiAdvancedOptionsMore_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsEvenmoreTab, images/gui/guiAdvancedOptionsEvenmore_tab_active.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 3
	Return
	
_GUIAdvancedOptionsHotkeysTab:
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsHotkeysTab, images/gui/guiAdvancedOptionsHotkeys_tab_active.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsBotTab, images/gui/guiAdvancedOptionsBot_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 4
	Return
	
_GUIAdvancedOptionsBotTab:
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsHotkeysTab, images/gui/guiAdvancedOptionsHotkeys_tab_inactive.png
	GuiControl, BotGUIAdvancedOptions:, guiAdvancedOptionsBotTab, images/gui/guiAdvancedOptionsBot_tab_active.png
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 5
	Return

_GUIAdvancedOptionsNextRight:
	GuiControl, Hide, guiAdvancedOptionsAdvancedTab
	GuiControl, Hide, guiAdvancedOptionsMoreTab
	GuiControl, Hide, guiAdvancedOptionsEvenMoreTab
	GuiControl, Hide, guiAdvancedOptionsNextRight
	GuiControl, Show, guiAdvancedOptionsNextLeft
	GuiControl, Show, guiAdvancedOptionsHotkeysTab
	GuiControl, Show, guiAdvancedOptionsBotTab
	Gosub, _GUIAdvancedOptionsHotkeysTab
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 4
	Return
	
_GUIAdvancedOptionsNextLeft:
	GuiControl, Show, guiAdvancedOptionsAdvancedTab
	GuiControl, Show, guiAdvancedOptionsMoreTab
	GuiControl, Show, guiAdvancedOptionsEvenMoreTab
	GuiControl, Show, guiAdvancedOptionsNextRight
	GuiControl, Hide, guiAdvancedOptionsNextLeft
	GuiControl, Hide, guiAdvancedOptionsHotkeysTab
	GuiControl, Hide, guiAdvancedOptionsBotTab
	Gosub, _GUIAdvancedOptionsAdvancedTab
	GuiControl, BotGUIAdvancedOptions:Choose, guiAdvancedOptionsTabs, 1
	Return
	
_GUIBuffsGoldTab:
	GuiControl, Hide, guiBuffsGoldTab
	GuiControl, Show, guiBuffsPowerTab
	GuiControl, Show, guiBuffsSpeedTab
	GuiControl, Show, guiBuffsCritTab
	GuiControl, Show, guiBuffsClickTab
	GuiControl, Show, guiBuffsSplashTab
	GuiControl, BotGUIBuffs:Choose, guiBuffsTabs, 1
	Return

_GUIBuffsPowerTab:
	GuiControl, Show, guiBuffsGoldTab
	GuiControl, Hide, guiBuffsPowerTab
	GuiControl, Show, guiBuffsSpeedTab
	GuiControl, Show, guiBuffsCritTab
	GuiControl, Show, guiBuffsClickTab
	GuiControl, Show, guiBuffsSplashTab
	GuiControl, BotGUIBuffs:Choose, guiBuffsTabs, 2
	Return

_GUIBuffsSpeedTab:
	GuiControl, Show, guiBuffsGoldTab
	GuiControl, Show, guiBuffsPowerTab
	GuiControl, Hide, guiBuffsSpeedTab
	GuiControl, Show, guiBuffsCritTab
	GuiControl, Show, guiBuffsClickTab
	GuiControl, Show, guiBuffsSplashTab
	GuiControl, BotGUIBuffs:Choose, guiBuffsTabs, 3
	Return

_GUIBuffsCritTab:
	GuiControl, Show, guiBuffsGoldTab
	GuiControl, Show, guiBuffsPowerTab
	GuiControl, Show, guiBuffsSpeedTab
	GuiControl, Hide, guiBuffsCritTab
	GuiControl, Show, guiBuffsClickTab
	GuiControl, Show, guiBuffsSplashTab
	GuiControl, BotGUIBuffs:Choose, guiBuffsTabs, 4
	Return

_GUIBuffsClickTab:
	GuiControl, Show, guiBuffsGoldTab
	GuiControl, Show, guiBuffsPowerTab
	GuiControl, Show, guiBuffsSpeedTab
	GuiControl, Show, guiBuffsCritTab
	GuiControl, Hide, guiBuffsClickTab
	GuiControl, Show, guiBuffsSplashTab
	GuiControl, BotGUIBuffs:Choose, guiBuffsTabs, 5
	Return

_GUIBuffsSplashTab:
	GuiControl, Show, guiBuffsGoldTab
	GuiControl, Show, guiBuffsPowerTab
	GuiControl, Show, guiBuffsSpeedTab
	GuiControl, Show, guiBuffsCritTab
	GuiControl, Show, guiBuffsClickTab
	GuiControl, Hide, guiBuffsSplashTab
	GuiControl, BotGUIBuffs:Choose, guiBuffsTabs, 6
	Return
	
_GUIForceStartHotkey1Unmask:
	GuiControl, Hide, guiForceStartHotkey1Mask
	guiForceStartHotkey1Show := true
	GuiControl, BotGUIAdvancedOptions:, guiForceStartHotkey1Choice, % listKeys
	GuiControl, Show, guiForceStartHotkey1Choice
	GuiControl, ChooseString, guiForceStartHotkey1Choice, % optForceStartHotkey1
	Return

_GUIForceStartHotkey2Unmask:
	GuiControl, Hide, guiForceStartHotkey2Mask
	GuiControlGet, guiForceStartHotkey1Choice
	ForceStartHotkey2Choices := listKeys
	GuiControl,, guiForceStartHotkey2Choice, ||%ForceStartHotkey2Choices%
	GuiControl, Show, guiForceStartHotkey2Choice
	GuiControl, ChooseString, guiForceStartHotkey2Choice, % optForceStartHotkey2
	Return

_GUIChooseForceStartHotkey1:
	Gui, Submit, NoHide
	ForceStartHotkey2Choices := __ListKeysRemove(listKeys, guiForceStartHotkey1Choice)
	GuiControl,, guiForceStartHotkey2Choice, ||%ForceStartHotkey2Choices%
	GuiControl, ChooseString, guiForceStartHotkey2Choice, % optTempForceStartHotkey2
	optTempForceStartHotkey1 := guiForceStartHotkey1Choice
	Return
	
_GUIChooseForceStartHotkey2:
	Gui, Submit, NoHide
	ForceStartHotkey1Choices := __ListKeysRemove(listKeys, guiForceStartHotkey2Choice)
	GuiControl,, guiForceStartHotkey1Choice, ||%ForceStartHotkey1Choices%
	GuiControl, ChooseString, guiForceStartHotkey1Choice, % optTempForceStartHotkey1
	optTempForceStartHotkey2 = %guiForceStartHotkey2Choice%
	Return
	
_GUIPauseHotkey1Unmask:
	GuiControl, Hide, guiPauseHotkey1Mask
	guiPauseHotkey1Show := true
	GuiControl, BotGUIAdvancedOptions:, guiPauseHotkey1Choice, % listKeys
	GuiControl, Show, guiPauseHotkey1Choice
	GuiControl, ChooseString, guiPauseHotkey1Choice, % optPauseHotkey1
	Return

_GUIPauseHotkey2Unmask:
	GuiControl, Hide, guiPauseHotkey2Mask
	GuiControlGet, guiPauseHotkey1Choice
	pauseHotkey2Choices := listKeys
	GuiControl,, guiPauseHotkey2Choice, ||%pauseHotkey2Choices%
	GuiControl, Show, guiPauseHotkey2Choice
	GuiControl, ChooseString, guiPauseHotkey2Choice, % optPauseHotkey2
	Return

_GUIChoosePauseHotkey1:
	Gui, Submit, NoHide
	pauseHotkey2Choices := __ListKeysRemove(listKeys, guiPauseHotkey1Choice)
	GuiControl,, guiPauseHotkey2Choice, ||%pauseHotkey2Choices%
	GuiControl, ChooseString, guiPauseHotkey2Choice, % optTempPauseHotkey2
	optTempPauseHotkey1 := guiPauseHotkey1Choice
	Return
	
_GUIChoosePauseHotkey2:
	Gui, Submit, NoHide
	pauseHotkey1Choices := __ListKeysRemove(listKeys, guiPauseHotkey2Choice)
	GuiControl,, guiPauseHotkey1Choice, ||%pauseHotkey1Choices%
	GuiControl, ChooseString, guiPauseHotkey1Choice, % optTempPauseHotkey1
	optTempPauseHotkey2 = %guiPauseHotkey2Choice%
	Return

_GUIReloadHotkey1Unmask:
	GuiControl, Hide, guiReloadHotkey1Mask
	GuiControl, BotGUIAdvancedOptions:, guiReloadHotkey1Choice, % listKeys
	GuiControl, Show, guiReloadHotkey1Choice
	GuiControl, ChooseString, guiReloadHotkey1Choice, % optReloadHotkey1
	Return
	
_GUIReloadHotkey2Unmask:
	GuiControl, Hide, guiReloadHotkey2Mask
	GuiControlGet, guiReloadHotkey1Choice
	reloadHotkey2Choices := __ListKeysRemove(listKeys, guiReloadHotkey1Choice)
	GuiControl,, guiReloadHotkey2Choice, ||%reloadHotkey2Choices%
	GuiControl, Show, guiReloadHotkey2Choice
	GuiControl, ChooseString, guiReloadHotkey2Choice, % optReloadHotkey2
	Return

_GUIChooseReloadHotkey1:
	Gui, Submit, NoHide
	reloadHotkey2Choices := __ListKeysRemove(listKeys, guiReloadHotkey1Choice)
	GuiControl,, guiReloadHotkey2Choice, ||%reloadHotkey2Choices%
	GuiControl, ChooseString, guiReloadHotkey2Choice, % optTempReloadHotkey2
	optTempReloadHotkey1 := guiReloadHotkey1Choice
	Return
	
_GUIChooseReloadHotkey2:
	Gui, Submit, NoHide
	ReloadHotkey1Choices := __ListKeysRemove(listKeys, guiReloadHotkey2Choice)
	GuiControl,, guiReloadHotkey1Choice, ||%ReloadHotkey1Choices%
	GuiControl, ChooseString, guiReloadHotkey1Choice, % optTempReloadHotkey1
	optTempReloadHotkey2 = %guiReloadHotkey2Choice%
	Return

_GUIExitHotkey1Unmask:
	GuiControl, Hide, guiExitHotkey1Mask
	GuiControl, BotGUIAdvancedOptions:, guiExitHotkey1Choice, % listKeys
	GuiControl, Show, guiExitHotkey1Choice
	GuiControl, ChooseString, guiExitHotkey1Choice, % optExitHotkey1
	Return
	
_GUIExitHotkey2Unmask:
	GuiControl, Hide, guiExitHotkey2Mask
	GuiControlGet, guiExitHotkey1Choice
	exitHotkey2Choices := __ListKeysRemove(listKeys, guiExitHotkey1Choice)
	GuiControl,, guiExitHotkey2Choice, ||%exitHotkey2Choices%
	GuiControl, Show, guiExitHotkey2Choice
	GuiControl, ChooseString, guiExitHotkey2Choice, % optExitHotkey2
	Return

_GUIChooseExitHotkey1:
	Gui, Submit, NoHide
	exitHotkey2Choices := __ListKeysRemove(listKeys, guiExitHotkey1Choice)
	GuiControl,, guiExitHotkey2Choice, ||%exitHotkey2Choices%
	GuiControl, ChooseString, guiExitHotkey2Choice, % optTempExitHotkey2
	optTempExitHotkey1 := guiExitHotkey1Choice
	Return
	
_GUIChooseExitHotkey2:
	Gui, Submit, NoHide
	ExitHotkey1Choices := __ListKeysRemove(listKeys, guiExitHotkey2Choice)
	GuiControl,, guiExitHotkey1Choice, ||%ExitHotkey1Choices%
	GuiControl, ChooseString, guiExitHotkey1Choice, % optTempExitHotkey1
	optTempExitHotkey2 = %guiExitHotkey2Choice%
	Return	

_GUIForceResetHotkey1Unmask:
	GuiControl, Hide, guiForceResetHotkey1Mask
	guiForceResetHotkey1Show := true
	GuiControl, BotGUIAdvancedOptions:, guiForceResetHotkey1Choice, % listKeys
	GuiControl, Show, guiForceResetHotkey1Choice
	GuiControl, ChooseString, guiForceResetHotkey1Choice, % optForceResetHotkey1
	Return

_GUIForceResetHotkey2Unmask:
	GuiControl, Hide, guiForceResetHotkey2Mask
	GuiControlGet, guiForceResetHotkey1Choice
	ForceResetHotkey2Choices := listKeys
	GuiControl,, guiForceResetHotkey2Choice, ||%ForceResetHotkey2Choices%
	GuiControl, Show, guiForceResetHotkey2Choice
	GuiControl, ChooseString, guiForceResetHotkey2Choice, % optForceResetHotkey2
	Return

_GUIChooseForceResetHotkey1:
	Gui, Submit, NoHide
	ForceResetHotkey2Choices := __ListKeysRemove(listKeys, guiForceResetHotkey1Choice)
	GuiControl,, guiForceResetHotkey2Choice, ||%ForceResetHotkey2Choices%
	GuiControl, ChooseString, guiForceResetHotkey2Choice, % optTempForceResetHotkey2
	optTempForceResetHotkey1 := guiForceResetHotkey1Choice
	Return
	
_GUIChooseForceResetHotkey2:
	Gui, Submit, NoHide
	ForceResetHotkey1Choices := __ListKeysRemove(listKeys, guiForceResetHotkey2Choice)
	GuiControl,, guiForceResetHotkey1Choice, ||%ForceResetHotkey1Choices%
	GuiControl, ChooseString, guiForceResetHotkey1Choice, % optTempForceResetHotkey1
	optTempForceResetHotkey2 = %guiForceResetHotkey2Choice%
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

_GUIChooseRelaunchGameFrequency:
	Gui, Submit, NoHide
	optTempRelaunchGameFrequency := guiRelaunchGameFrequencyChoice
	Return
	
_GUIChooseMoveGameWindow:
	Gui, Submit, NoHide
	optTempMoveGameWindow := guiMoveGameWindowChoice
	Return

_GUIChooseAutoProgress:
	Gui, Submit, NoHide
	optTempAutoProgress := guiAutoProgressChoice
	Return
	
_GUISetAutoProgressCheckOn:
	GuiControl,, guiAutoProgressCheckStatusOn, images/gui/bOn_on.png
	GuiControl,, guiAutoProgressCheckStatusOff, images/gui/bOff_off.png
	optTempAutoProgressCheck = 1
	Return

_GUISetAutoProgressCheckOff:
	GuiControl,, guiAutoProgressCheckStatusOn, images/gui/bOn_off.png
	GuiControl,, guiAutoProgressCheckStatusOff, images/gui/bOff_on.png
	optTempAutoProgressCheck = 0
	Return
	
_GUISetPromptCurrentLevelOn:
	GuiControl,, guiPromptCurrentLevelStatusOn, images/gui/bOn_on.png
	GuiControl,, guiPromptCurrentLevelStatusOff, images/gui/bOff_off.png
	optTempPromptCurrentLevel = 1
	Return

_GUISetPromptCurrentLevelOff:
	GuiControl,, guiPromptCurrentLevelStatusOn, images/gui/bOn_off.png
	GuiControl,, guiPromptCurrentLevelStatusOff, images/gui/bOff_on.png
	optTempPromptCurrentLevel = 0
	Return	

_GUISetUseChestsOn:
	GuiControl,, guiUseChestsStatusOn, images/gui/bOn_on.png
	GuiControl,, guiUseChestsStatusOff, images/gui/bOff_off.png
	optTempUseChests = 1
	Return
	
_GUISetUseChestsOff:
	GuiControl,, guiUseChestsStatusOn, images/gui/bOn_off.png
	GuiControl,, guiUseChestsStatusOff, images/gui/bOff_on.png
	optTempUseChests = 0
	Return

_GUISetUseSkillsRoyalCommandOn:
	GuiControl,, guiUseSkillsRoyalCommandStatusOn, images/gui/bOn_on.png
	GuiControl,, guiUseSkillsRoyalCommandStatusOff, images/gui/bOff_off.png
	optTempSkillsRoyalCommand = 1
	Return
	
_GUISetUseSkillsRoyalCommandOff:
	GuiControl,, guiUseSkillsRoyalCommandStatusOn, images/gui/bOn_off.png
	GuiControl,, guiUseSkillsRoyalCommandStatusOff, images/gui/bOff_on.png
	optTempSkillsRoyalCommand = 0
	Return

_GUISetSameLevelTimeoutOn:
	GuiControl,, guiSameLevelTimeoutStatusOn, images/gui/bOn_on.png
	GuiControl,, guiSameLevelTimeoutStatusOff, images/gui/bOff_off.png
	optTempSameLevelTimeout = 1
	Return

_GUISetSameLevelTimeoutOff:
	GuiControl,, guiSameLevelTimeoutStatusOn, images/gui/bOn_off.png
	GuiControl,, guiSameLevelTimeoutStatusOff, images/gui/bOff_on.png
	optTempSameLevelTimeout = 0
	Return
	
_GUISetUseLightVersionOn:
	GuiControl,, guiUseLightVersionStatusOn, images/gui/bOn_on.png
	GuiControl,, guiUseLightVersionStatusOff, images/gui/bOff_off.png
	optTempBotLighter = 1
	Return

_GUISetUseLightVersionOff:
	GuiControl,, guiUseLightVersionStatusOn, images/gui/bOn_off.png
	GuiControl,, guiUseLightVersionStatusOff, images/gui/bOff_on.png
	optTempBotLighter = 0
	Return

_GUISetUseCheatEngineOn:
	MsgBox, 0x1, idolBot, % "The bot supports Cheat Engine but some features will break due to the Speed Hack.`nPretty much everything that is related to resets on level will not work as intended.`nI strongly suggest to use timed resets instead."
	IfMsgBox Ok
	{
		GuiControl,, guiUseCheatEngineStatusOn, images/gui/bOn_on.png
		GuiControl,, guiUseCheatEngineStatusOff, images/gui/bOff_off.png
		optTempCheatEngine = 1
	}
	Return

_GUISetUseCheatEngineOff:
	GuiControl,, guiUseCheatEngineStatusOn, images/gui/bOn_off.png
	GuiControl,, guiUseCheatEngineStatusOff, images/gui/bOff_on.png
	optTempCheatEngine = 0
	Return
	
_GUIChooseChestsAmount:
	Gui, Submit, NoHide
	optTempUseChestsAmount := guiUseChestsAmountChoice
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
	winH = 397
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
	
_GUIBuffs:
	Gosub, _GUICloseOtherWindows
	GuiControl, BotGUI:, buttonBuffs, images/gui/BBuffs_active.png
	winW = 256
	winH = 274
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIBuffs: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Buffs
	Return
	
_GUIDevLogging:
	if (optDevLogging = 1) {
		optDevLogging = 0
		GuiControl, BotGUIDev:, guiDevLoggingStatus, images/gui/bLoggingOff.png
	} else {
		optDevLogging = 1
		GuiControl, BotGUIDev:, guiDevLoggingStatus, images/gui/bLoggingOn.png
	}
	Return