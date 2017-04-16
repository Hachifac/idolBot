#NoEnv
SendMode Input

Gui, BotGUIAdvancedOptions: New, -Caption, idolBot Advanced Options
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Tab2, vguiAdvancedOptionsTabs Choose1 w0 h0, 1|2

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
Gui, Add, Picture, x+148 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Add, DropDownList, x15 y+32 w120 Choose%optMoveGameWindow% vguiMoveGameWindowChoice g_GUIChooseMoveGameWindow altSubmit, Don't move|Left|Top-Left|Top-Center|Top-Right|Right|Center
Gui, Add, Picture, x+90 yp+4 g_GUIHelpAdvanced, images/gui/bHelp.png

Gui, Tab
Gui, Add, Picture, x7 y44 vguiAdvancedOptionsAdvancedTab g_GUIAdvancedOptionsAdvancedTab, images/gui/guiAdvancedOptionsAdvanced_tab_active.png
Gui, Add, Picture, x+2 vguiAdvancedOptionsMoreTab g_GUIAdvancedOptionsMoreTab, images/gui/guiAdvancedOptionsMore_tab_inactive.png
Gui, Add, Picture, x227 y0 g_GUICloseAdvancedOptions, images/gui/bClose.png
Gui, Add, Picture, x95 y432 g_GUIApplyAdvancedOptions, images/gui/bApply.png

GuiControl, ChooseString, guiResetCrusader, %optResetCrusader%