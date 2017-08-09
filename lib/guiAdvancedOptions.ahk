#NoEnv
SendMode Input

Gui, BotGUIAdvancedOptions: New, -Caption, idolBot Advanced Options
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Tab2, vguiAdvancedOptionsTabs Choose1 w0 h0, 1|2|3|4|5

Gui, Tab, 1
Gui, Add, Picture, x0 y0, images/gui/guiAdvancedOptions_bg.png

Gui, Add, Edit, x15 y102 w180
Gui, Add, UpDown, vguiUpgAllUntil Range0-2147483647, %optUpgAllUntil%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32 w180
Gui, Add, UpDown, vguiMainDPSDelay Range0-2147483647, %optMainDPSDelay%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32
Gui, Add, UpDown, vguiChatRoom Range0-10, %optChatRoom%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32
Gui, Add, UpDown, vguiClickDelay Range1-2147483647, %optClickDelay%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32
Gui, Add, UpDown, vguiRunTime Range1-2147483647, %optRunTime%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32
Gui, Add, UpDown, vguiResetOnLevel Range1-2147483647, %optResetOnLevel%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Tab, 2
Gui, Add, Picture, x0 y0, images/gui/guiAdvancedOptionsMore_bg.png

Gui, Add, Edit, x15 y99 w180
Gui, Add, UpDown, vguiLootItemsDuration Range1-2147483647, %optLootItemsDuration%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

if (optRelaunchGame = 1) {
	relaunchGameStatusOn := "images/gui/bOn_on.png"
	relaunchGameStatusOff := "images/gui/bOff_off.png"
} else {
	relaunchGameStatusOn := "images/gui/bOn_off.png"
	relaunchGameStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+32 vguiRelaunchGameStatusOn g_GUISetRelaunchGameOn, %relaunchGameStatusOn%
Gui, Add, Picture, x+2 vguiRelaunchGameStatusOff g_GUISetRelaunchGameOff, %relaunchGameStatusOff%
Gui, Add, DropDownList, x+5 w100 Choose%optRelaunchGameFrequency% vguiRelaunchGameFrequencyChoice g_GUIChooseRelaunchGameFrequency altSubmit, Every reset|1 hour|2 hours|3 hours|4 hours|5 hours|6 hours|7 hours|8 hours|9 hours|10 hours|11 hours|12 hours
Gui, Add, Picture, x+148 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, DropDownList, x15 y+32 w120 Choose%optMoveGameWindow% vguiMoveGameWindowChoice g_GUIChooseMoveGameWindow altSubmit, Don't move|Left|Top-Left|Top-Center|Top-Right|Right|Center
Gui, Add, Picture, x+90 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

if (optAutoProgressCheck = 1) {
	autoProgressCheckStatusOn := "images/gui/bOn_on.png"
	autoProgressCheckStatusOff := "images/gui/bOff_off.png"
} else {
	autoProgressCheckStatusOn := "images/gui/bOn_off.png"
	autoProgressCheckStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+32 vguiAutoProgressCheckStatusOn g_GUISetAutoProgressCheckOn, %autoProgressCheckStatusOn%
Gui, Add, Picture, x+2 vguiAutoProgressCheckStatusOff g_GUISetAutoProgressCheckOff, %autoProgressCheckStatusOff%
Gui, Add, Edit, x+45 w73
Gui, Add, UpDown, vguiAutoProgressCheckDelay Range1-2147483647, %optAutoProgressCheckDelay%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, DropDownList, x15 y+32 w120 Choose%optAutoProgress% vguiAutoProgressChoice g_GUIChooseAutoProgress altSubmit, Default|Always on
Gui, Add, Picture, x+90 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

if (optPromptCurrentLevel = 1) {
	promptCurrentLevelStatusOn := "images/gui/bOn_on.png"
	promptCurrentLevelStatusOff := "images/gui/bOff_off.png"
} else {
	promptCurrentLevelStatusOn := "images/gui/bOn_off.png"
	promptCurrentLevelStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+32 vguiPromptCurrentLevelStatusOn g_GUISetPromptCurrentLevelOn, %promptCurrentLevelStatusOn%
Gui, Add, Picture, x+2 vguiPromptCurrentLevelStatusOff g_GUISetPromptCurrentLevelOff, %promptCurrentLevelStatusOff%
Gui, Add, Picture, x+148 yp+3 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Tab, 3
Gui, Add, Picture, x0 y0, images/gui/guiAdvancedOptionsEvenmore_bg.png

if (optUseChests = 1) {
	useChestsStatusOn := "images/gui/bOn_on.png"
	useChestsStatusOff := "images/gui/bOff_off.png"
} else {
	useChestsStatusOn := "images/gui/bOn_off.png"
	useChestsStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y99 vguiUseChestsStatusOn g_GUISetUseChestsOn, %useChestsStatusOn%
Gui, Add, Picture, x+2 vguiUseChestsStatusOff g_GUISetUseChestsOff, %useChestsStatusOff%
Gui, Add, DropDownList, x+15 w50 vguiUseChestsAmountChoice g_GUIChooseChestsAmount, 5|25|100

if (optSkillsRoyalCommand = 1) {
	useSkillsRoyalCommandStatusOn := "images/gui/bOn_on.png"
	useSkillsRoyalCommandStatusOff := "images/gui/bOff_off.png"
} else {
	useSkillsRoyalCommandStatusOn := "images/gui/bOn_off.png"
	useSkillsRoyalCommandStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+27 vguiUseSkillsRoyalCommandStatusOn g_GUISetUseSkillsRoyalCommandOn, %useSkillsRoyalCommandStatusOn%
Gui, Add, Picture, x+2 vguiUseSkillsRoyalCommandStatusOff g_GUISetUseSkillsRoyalCommandOff, %useSkillsRoyalCommandStatusOff%

if (optSameLevelTimeout = 1) {
	sameLevelTimeoutStatusOn := "images/gui/bOn_on.png"
	sameLevelTimeoutStatusOff := "images/gui/bOff_off.png"
} else {
	autoProgressCheckStatusOn := "images/gui/bOn_off.png"
	autoProgressCheckStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+28 w30 vguiSameLevelTimeoutStatusOn g_GUISetSameLevelTimeoutOn, %sameLevelTimeoutStatusOn%
Gui, Add, Picture, x+2 w30 vguiSameLevelTimeoutStatusOff g_GUISetSameLevelTimeoutOff, %sameLevelTimeoutStatusOff%
Gui, Add, Edit, x+45 w73
Gui, Add, UpDown, vguiSameLevelTimeoutDelay Range1-2147483647, %optSameLevelTimeoutDelay%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Tab, 4
Gui, Add, Picture, x0 y0, images/gui/guiAdvancedOptionsHotkeys_bg.png

Gui, Add, Picture, x15 y99 vguiForceStartHotkey1Mask g_GUIForceStartHotkey1Unmask, images/gui/guiAdvancedOptionsHotkeysDefault_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiForceStartHotkey1Choice g_GUIChooseForceStartHotkey1 +Hidden
Gui, Add, Picture, x+23 yp+0 vguiForceStartHotkey2Mask g_GUIForceStartHotkey2Unmask, images/gui/guiAdvancedOptionsHotkeysNone_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiForceStartHotkey2Choice g_GUIChooseForceStartHotkey2 +Hidden

Gui, Add, Picture, x15 y+28 vguiPauseHotkey1Mask g_GUIPauseHotkey1Unmask, images/gui/guiAdvancedOptionsHotkeysDefault_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiPauseHotkey1Choice g_GUIChoosePauseHotkey1 +Hidden
Gui, Add, Picture, x+23 yp+0 vguiPauseHotkey2Mask g_GUIPauseHotkey2Unmask, images/gui/guiAdvancedOptionsHotkeysNone_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiPauseHotkey2Choice g_GUIChoosePauseHotkey2 +Hidden

Gui, Add, Picture, x15 y+28 vguiReloadHotkey1Mask g_GUIReloadHotkey1Unmask, images/gui/guiAdvancedOptionsHotkeysDefault_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiReloadHotkey1Choice g_GUIChooseReloadHotkey1 +Hidden
Gui, Add, Picture, x+23 yp+0 vguiReloadHotkey2Mask g_GUIReloadHotkey2Unmask, images/gui/guiAdvancedOptionsHotkeysNone_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiReloadHotkey2Choice g_GUIChooseReloadHotkey2 +Hidden

Gui, Add, Picture, x15 y+28 vguiExitHotkey1Mask g_GUIExitHotkey1Unmask, images/gui/guiAdvancedOptionsHotkeysDefault_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiExitHotkey1Choice g_GUIChooseExitHotkey1 +Hidden
Gui, Add, Picture, x+23 yp+0 vguiExitHotkey2Mask g_GUIExitHotkey2Unmask, images/gui/guiAdvancedOptionsHotkeysNone_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiExitHotkey2Choice g_GUIChooseExitHotkey2 +Hidden

Gui, Add, Picture, x15 y+28 vguiForceResetHotkey1Mask g_GUIForceResetHotkey1Unmask, images/gui/guiAdvancedOptionsHotkeysDefault_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiForceResetHotkey1Choice g_GUIChooseForceResetHotkey1 +Hidden
Gui, Add, Picture, x+23 yp+0 vguiForceResetHotkey2Mask g_GUIForceResetHotkey2Unmask, images/gui/guiAdvancedOptionsHotkeysNone_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiForceResetHotkey2Choice g_GUIChooseForceResetHotkey2 +Hidden

Gui, Add, Picture, x15 y+28 vguiNextCycleHotkey1Mask g_GUINextCycleHotkey1Unmask, images/gui/guiAdvancedOptionsHotkeysDefault_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiNextCycleHotkey1Choice g_GUIChooseNextCycleHotkey1 +Hidden
Gui, Add, Picture, x+23 yp+0 vguiNextCycleHotkey2Mask g_GUINextCycleHotkey2Unmask, images/gui/guiAdvancedOptionsHotkeysNone_mask.png
Gui, Add, DropDownList, w100 yp+0 vguiNextCycleHotkey2Choice g_GUIChooseNextCycleHotkey2 +Hidden

Gui, Tab, 5
Gui, Add, Picture, x0 y0, images/gui/guiAdvancedOptionsBot_bg.png

if (optBotLighter = 1) {
	useLightVersionStatusOn := "images/gui/bOn_on.png"
	useLightVersionStatusOff := "images/gui/bOff_off.png"
} else {
	useLightVersionStatusOn := "images/gui/bOn_off.png"
	useLightVersionStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y102 vguiUseLightVersionStatusOn g_GUISetUseLightVersionOn, %useLightVersionStatusOn%
Gui, Add, Picture, x+2 vguiUseLightVersionStatusOff g_GUISetUseLightVersionOff, %useLightVersionStatusOff%
Gui, Add, Picture, x+148 yp+3 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+30 w180
Gui, Add, UpDown, vguiBotClockSpeed Range0-2147483647, %optBotClockSpeed%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

if (optCheatEngine = 1) {
	useCheatEngineStatusOn := "images/gui/bOn_on.png"
	useCheatEngineStatusOff := "images/gui/bOff_off.png"
} else {
	useCheatEngineStatusOn := "images/gui/bOn_off.png"
	useCheatEngineStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+32 vguiUseCheatEngineStatusOn g_GUISetUseCheatEngineOn, %useCheatEngineStatusOn%
Gui, Add, Picture, x+2 vguiUseCheatEngineStatusOff g_GUISetUseCheatEngineOff, %useCheatEngineStatusOff%
Gui, Add, Picture, x+148 yp+3 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, Edit, x15 y+30 w180
Gui, Add, UpDown, vguiResetGracePeriod Range0-2147483647, %optResetGracePeriod%
Gui, Add, Picture, x+30 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Tab
Gui, Add, Picture, x7 y44 vguiAdvancedOptionsAdvancedTab g_GUIAdvancedOptionsAdvancedTab, images/gui/guiAdvancedOptionsAdvanced_tab_active.png
Gui, Add, Picture, x+2 vguiAdvancedOptionsMoreTab g_GUIAdvancedOptionsMoreTab, images/gui/guiAdvancedOptionsMore_tab_inactive.png
Gui, Add, Picture, x+2 vguiAdvancedOptionsEvenmoreTab g_GUIAdvancedOptionsEvenmoreTab, images/gui/guiAdvancedOptionsEvenmore_tab_inactive.png
Gui, Add, Picture, x+10 vguiAdvancedOptionsNextRight g_GUIAdvancedOptionsNextRight, images/gui/guiAdvancedOptionsNext.png
Gui, Add, Picture, x7 y44 vguiAdvancedOptionsNextLeft g_GUIAdvancedOptionsNextLeft +Hidden, images/gui/guiAdvancedOptionsNext.png
Gui, Add, Picture, x+2 vguiAdvancedOptionsHotkeysTab g_GUIAdvancedOptionsHotkeysTab +Hidden, images/gui/guiAdvancedOptionsHotkeys_tab_active.png
Gui, Add, Picture, x+2 vguiAdvancedOptionsBotTab g_GUIAdvancedOptionsBotTab +Hidden, images/gui/guiAdvancedOptionsBot_tab_active.png
Gui, Add, Picture, x227 y0 g_GUICloseAdvancedOptions, images/gui/bClose.png
Gui, Add, Picture, x95 y432 g_GUIApplyAdvancedOptions, images/gui/bApply.png

GuiControl, ChooseString, guiResetCrusader, %optResetCrusader%
GuiControl, ChooseString, guiUseChestsAmountChoice, %optUseChestsAmount%
if (optForceStartHotkey1 != "F7" or (optForceStartHotkey1 = "F7" and optForceStartHotkey2)) {
	Gosub, _GUIForceStartHotkey1Unmask
	Gosub, _GUIForceStartHotkey2Unmask
}
if (optPauseHotkey1 != "F8" or (optPauseHotkey1 = "F8" and optPauseHotkey2)) {
	Gosub, _GUIPauseHotkey1Unmask
	Gosub, _GUIPauseHotkey2Unmask
}
if (optReloadHotkey1 != "F9" or (optReloadHotkey1 = "F9" and optReloadHotkey2)) {
	Gosub, _GUIReloadHotkey1Unmask
	Gosub, _GUIReloadHotkey2Unmask
}
if (optExitHotkey1 != "F10" or (optExitHotkey1 = "F10" and optExitHotkey2)) {
	Gosub, _GUIExitHotkey1Unmask
	Gosub, _GUIExitHotkey2Unmask
}
if (optForceResetHotkey1 != "F11" or (optForceResetHotkey1 = "F11" and optForceResetHotkey2)) {
	Gosub, _GUIForceResetHotkey1Unmask
	Gosub, _GUIForceResetHotkey2Unmask
}
if (optNextCycleHotkey1 != "F12" or (optNextCycleHotkey1 = "F12" and optNextCycleHotkey2)) {
	Gosub, _GUINextCycleHotkey1Unmask
	Gosub, _GUINextCycleHotkey2Unmask
}