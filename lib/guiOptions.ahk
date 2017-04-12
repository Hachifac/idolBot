#NoEnv
SendMode Input

Gui, BotGUIOptions: New, -Caption, idolBot Options
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui/guiOptions_bg.png

Gui, Add, Picture, x227 y0 gCloseOptions, images/gui/bClose.png

f1 := "images/gui/bF1_off.png"
f2 := "images/gui/bF2_off.png"
f3 := "images/gui/bF3_off.png"

f%formation% := "images/gui/bF" . formation . "_on.png"

if (clicking = 1) {
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

Gui, Add, DropDownList, x15 y72 w190 Choose%campaign% vCampaignChoice gChooseCampaign altSubmit, Event|World's Wake|Descent into Darkness|Ghostbeard's Greed|Grimm's Idle Tales|Mischief at Mugwarts|Ready Player Two|Idols Through Time|Amusement Park of Doom

Gui, Add, Picture, y+30 vFormationQ gSetFormationQ, %f1%
Gui, Add, Picture, x+5 vFormationW gSetFormationW, %f2%
Gui, Add, Picture, x+5 vFormationE gSetFormationE, %f3%

Gui, Add, DropDownList, x15 y+32 w100 vMainDPSChoice gChooseMainDPS, Alan|Bat|Baenarall|Bernard|Billy|Boggins|Brogon|Broot|Bubba|Bush|Cindy|Dark Helper|Draco|Drizzle|Eiralon|Emo|Exterminator|Fright-o-Tron|Frosty|Gloria|Graham|Greyskull|Groklok|Gryphon|Half-Blood Elf|Henry|Hermit|Ilsa|Jack|Jason|Jim|Kaine|Karen|Karl|Katie|Khouri|Kizlblyp|Kyle|Larry|Leerion|Lion|Littlefoot|Merci|Mindy|Momma|Monkey|Montana|Natalie|Nate|Pam|Panda|Paul|Pete|Petra|Phoenix|Princess|Rayna|Reginald|Robbie|Roborabbit|Roboturkey|Rocky|Rudolph|Sal|Sally|Santa|Sarah|Sasha|Shadow Queen|Siri|Sisaron|Snickette|Soldierette|Squiggles|Thalia|Val|Veronica|Warwick|Wendy

Gui, Add, DropDownList, y+32 w100 Choose%resetType% vResetChoice gChooseReset altSubmit, No reset|Max progress|Level cap - Not Working|Fast|Timed run

Gui, Add, Picture, y+32 vClickingStatusOn gSetClickingOn, %clickingStatusOn%
Gui, Add, Picture, x+2 vClickingStatusOff gSetClickingOff, %clickingStatusOff%

Gui, Add, Picture, x+84 y+5 gAdvancedOptions, images/gui/bAdvanced.png

Gui, Add, Picture, x95 y+10 gApplyOptions, images/gui/bApply.png

GuiControl, ChooseString, MainDPSChoice, %mainDPS%