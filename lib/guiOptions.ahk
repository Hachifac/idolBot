#NoEnv
SendMode Input

Gui, BotGUIOptions: New, -Caption, idolBot Options
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui/guiOptions_bg.png

Gui, Add, Picture, x227 y0 g_GUICloseOptions, images/gui/bClose.png

f1 := "images/gui/bF1_off.png"
f2 := "images/gui/bF2_off.png"
f3 := "images/gui/bF3_off.png"
fOff := "images/gui/bFOff_off.png"

if (optFormation > 0) {
	f%optFormation% := "images/gui/bF" . optFormation . "_on.png"
} else {
	fOff := "images/gui/bFOff_on.png"
}
if (optClicking = 1) {
	clickingStatusOn := "images/gui/bOn_on.png"
	clickingStatusOff := "images/gui/bOff_off.png"
} else {
	clickingStatusOn := "images/gui/bOn_off.png"
	clickingStatusOff := "images/gui/bOff_on.png"
}

noResetStatus := "images/gui/noreset_off.png"
maxProgressResetStatus := "images/gui/maxprogressreset_off.png"
levelCapResetStatus := "images/gui/levelcapreset_off.png"
fastResetStatus := "images/gui/fastreset_off.png"

Gui, Add, DropDownList, x15 y65 w190 Choose%optCampaign% vguiCampaignChoice g_GUIChooseCampaign altSubmit, Event|World's Wake|Descent into Darkness|Ghostbeard's Greed|Grimm's Idle Tales|Mischief at Mugwarts|Ready Player Two|Idols Through Time|Amusement Park of Doom

Gui, Add, Picture, y+5 g_GUISetBackupCampaign, images/gui/bSetBackup.png
Gui, Add, Picture, x+5 yp+2 w40 h22 vguiBackupCampaign, % "images/gui/backupc" . optBackupCampaign . ".png"
Gui, Add, Picture, x+59 yp+2 g_GUIHelpOptions, images/gui/bHelp.png

Gui, Add, Picture, x15 y+31 vguiFormationQ g_GUISetFormationQ, %f1%
Gui, Add, Picture, x+5 vguiFormationW g_GUISetFormationW, %f2%
Gui, Add, Picture, x+5 vguiFormationE g_GUISetFormationE, %f3%
Gui, Add, Picture, x+5 vguiFormationOff g_GUISetFormationOff, %fOff%

Gui, Add, DropDownList, x15 y+28 w100 vguiMainDPSChoice g_GUIChooseMainDPS, % crusadersSorted

Gui, Add, DropDownList, y+28 w190 Choose%optResetType% vguiResetChoice g_GUIChooseReset hwndddl altSubmit, No reset|Max progress|Timed run|On level
Gui, Add, Picture, x+20 yp+4 g_GUIHelpOptions, images/gui/bHelp.png

Gui, Add, Picture, x15 y+32 vguiClickingStatusOn g_GUISetClickingOn, %clickingStatusOn%
Gui, Add, Picture, x+2 vguiClickingStatusOff g_GUISetClickingOff, %clickingStatusOff%

Gui, Add, Picture, x+84 y+2 g_GUIAdvancedOptions, images/gui/bAdvanced.png

Gui, Add, Picture, x95 y+2 g_GUIApplyOptions, images/gui/bApply.png

GuiControl, ChooseString, MainDPSChoice, %optMainDPS%