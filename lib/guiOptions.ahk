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

f%optFormation% := "images/gui/bF" . optFormation . "_on.png"

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

Gui, Add, DropDownList, x15 y71 w190 Choose%optCampaign% vguiCampaignChoice g_GUIChooseCampaign altSubmit, Event|World's Wake|Descent into Darkness|Ghostbeard's Greed|Grimm's Idle Tales|Mischief at Mugwarts|Ready Player Two|Idols Through Time|Amusement Park of Doom

Gui, Add, Picture, y+30 vguiFormationQ g_GUISetFormationQ, %f1%
Gui, Add, Picture, x+5 vguiFormationW g_GUISetFormationW, %f2%
Gui, Add, Picture, x+5 vguiFormationE g_GUISetFormationE, %f3%

Gui, Add, DropDownList, x15 y+32 w100 vguiMainDPSChoice g_GUIChooseMainDPS, Alan|Bat|Baenarall|Bernard|Billy|Boggins|Brogon|Broot|Bubba|Bush|Cindy|Dark Helper|Draco|Drizzle|Eiralon|Emo|Exterminator|Fright-o-Tron|Frosty|Gloria|Graham|Greyskull|Groklok|Gryphon|Half-Blood Elf|Henry|Hermit|Ilsa|Jack|Jason|Jim|Kaine|Karen|Karl|Katie|Khouri|Kizlblyp|Kyle|Larry|Leerion|Lion|Littlefoot|Merci|Mindy|Momma|Monkey|Montana|Natalie|Nate|Pam|Panda|Paul|Pete|Petra|Phoenix|Princess|Rayna|Reginald|Robbie|Roborabbit|Roboturkey|Rocky|Rudolph|Sal|Sally|Santa|Sarah|Sasha|Shadow Queen|Siri|Sisaron|Snickette|Soldierette|Squiggles|Thalia|Val|Veronica|Warwick|Wendy

Gui, Add, DropDownList, y+31 w190 Choose%optResetType% vguiResetChoice g_GUIChooseReset altSubmit, No reset|Max progress|Level cap - Beta|Fast - Coming soon|Timed run|On level
Gui, Add, Picture, x+20 yp+4 g_GUIHelpOptions, images/gui/bHelp.png

Gui, Add, Picture, x15 y+35 vguiClickingStatusOn g_GUISetClickingOn, %clickingStatusOn%
Gui, Add, Picture, x+2 vguiClickingStatusOff g_GUISetClickingOff, %clickingStatusOff%

Gui, Add, Picture, x+84 y+5 g_GUIAdvancedOptions, images/gui/bAdvanced.png

Gui, Add, Picture, x95 y+10 g_GUIApplyOptions, images/gui/bApply.png

GuiControl, ChooseString, MainDPSChoice, %optMainDPS%