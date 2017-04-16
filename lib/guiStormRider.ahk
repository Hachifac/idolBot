#NoEnv
SendMode Input

Gui, BotGUIStormRider: New, -Caption, idolBot Storm Rider
Gui, Color, 6C2509
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Picture, x0 y0, images/gui/guiStormRider_bg.png

Gui, Add, Picture, x157 y0 g_GUICloseStormRider, images/gui/bClose.png

f1 := "images/gui/bF1_off.png"
f2 := "images/gui/bF2_off.png"
f3 := "images/gui/bF3_off.png"
f0 := "images/gui/bF0_off.png"

f%optStormRiderFormation% := "images/gui/bF" . optStormRiderFormation . "_on.png"

if (optStormRiderMagnify = 1) {
	optStormRiderMagnifyStatusOn := "images/gui/bOn_on.png"
	optStormRiderMagnifyStatusOff := "images/gui/bOff_off.png"
} else {
	optStormRiderMagnifyStatusOn := "images/gui/bOn_off.png"
	optStormRiderMagnifyStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+46 vguiStormRiderMagnifyStatusOn g_GUISetStormRiderMagnifyOn, %optStormRiderMagnifyStatusOn%
Gui, Add, Picture, x+2 vguiStormRiderMagnifyStatusOff g_GUISetStormRiderMagnifyOff, %optStormRiderMagnifyStatusOff%
Gui, Add, Picture, x+78 yp+2 g_GUIHelpStormRider, images/gui/bHelp.png

Gui, Add, Picture, x15 y+33 vguiStormRiderFormationQ g_GUISetStormRiderFormationQ, %f1%
Gui, Add, Picture, x+5 vguiStormRiderFormationW g_GUISetStormRiderFormationW, %f2%
Gui, Add, Picture, x+5 vguiStormRiderFormationE g_GUISetStormRiderFormationE, %f3%
Gui, Add, Picture, x+5 vguiStormRiderFormationD g_GUISetStormRiderFormationD, %f0%
Gui, Add, Picture, x+29 yp+2 g_GUIHelpStormRider, images/gui/bHelp.png

Gui, Add, Picture, x60 y+8 g_GUIApplyStormRider, images/gui/bApply.png
