#NoEnv
SendMode Input

Gui, BotGUIBuffs: New, -Caption, idolBot Buffs
Gui, Color, 6C2509
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui/guiBuffs_bg.png

Gui, Add, Picture, x217 y0 g_GUICloseBuffs, images/gui/bClose.png


	optBuffsSpeedStatusOn := "images/gui/bOn_on.png"
	optBuffsSpeedStatusOff := "images/gui/bOff_off.png"


Gui, Add, Picture, x15 y+46 vguiBuffsSpeedStatusOn g_GUISetBuffsSpeedOn, %optBuffsSpeedStatusOn%
Gui, Add, Picture, x+2 vguiBuffsSpeedStatusOff g_GUISetBuffsSpeedOff, %optBuffsSpeedStatusOff%

Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSpeedInterval Range0-480, %optBuffsSpeedInterval%

Gui, Add, Picture, x+24 yp+2 g_GUIHelpBuffs, images/gui/bHelp.png

Gui, Add, Picture, x90 y+67 g_GUIApplyBuffs, images/gui/bApply.png
