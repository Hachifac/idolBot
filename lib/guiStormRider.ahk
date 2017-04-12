#NoEnv
SendMode Input

Gui, BotGUIStormRider: New, -Caption, idolBot Storm Rider
Gui, Color, 6C2509
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Picture, x0 y0, images/gui/guiStormRider_bg.png

Gui, Add, Picture, x157 y0 gCloseStormRider, images/gui/bClose.png

f1 := "images/gui/bF1_off.png"
f2 := "images/gui/bF2_off.png"
f3 := "images/gui/bF3_off.png"
f0 := "images/gui/bF0_off.png"

f%stormRiderFormation% := "images/gui/bF" . stormRiderFormation . "_on.png"

if (stormRiderMagnify = 1) {
	magnifyStatusOn := "images/gui/bOn_on.png"
	magnifyStatusOff := "images/gui/bOff_off.png"
} else {
	magnifyStatusOn := "images/gui/bOn_off.png"
	magnifyStatusOff := "images/gui/bOff_on.png"
}

Gui, Add, Picture, x15 y+46 vMagnifyStatusOn gSetMagnifyOn, %magnifyStatusOn%
Gui, Add, Picture, x+2 vMagnifyStatusOff gSetMagnifyOff, %magnifyStatusOff%

Gui, Add, Picture, x15 y+30 vStormRiderFormationQ gSetStormRiderFormationQ, %f1%
Gui, Add, Picture, x+5 vStormRiderFormationW gSetStormRiderFormationW, %f2%
Gui, Add, Picture, x+5 vStormRiderFormationE gSetStormRiderFormationE, %f3%
Gui, Add, Picture, x+5 vStormRiderFormationD gSetStormRiderFormationD, %f0%

Gui, Add, Picture, x60 y+10 gApplyStormRider, images/gui/bApply.png
