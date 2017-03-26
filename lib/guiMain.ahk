#NoEnv
SendMode Input

#include lib/guiSettings.ahk

Gui, BotGUI: New, -Caption, CoTLI Bot
Gui, Color, 933506
Gui, Add, Picture, x0 y0, images/gui/gui_bg.png
; Gui, Font, s8 italic cAAAAAA, Candara
; Gui, Add, Text, x8 y95, v%version% by Hachifac
Gui, Font, s12 norm cFFFFFF, Candara

f1 := "images/gui/f1_off.png"
f2 := "images/gui/f2_off.png"
f3 := "images/gui/f3_off.png"

f%formation% := "images/gui/f" . formation . "_on.png"

if (clicking = 1) {
	clickingStatus := "images/gui/on.png"
} else {
	clickingStatus := "images/gui/off.png"
}

if (levelCapReset = 1) {
	levelCapResetStatus := "images/gui/on.png"
} else {
	levelCapResetStatus := "images/gui/off.png"
}

Gui, Add, DropDownList, x15 y43 w190 Choose%campaign% vCampaignChoice gChooseCampaign altSubmit, Event|World's Wake|Descent into Darkness|Ghostbeard's Greed|Grimm's Idle Tales|Mischief at Mugwarts|Ready Player Two|Idols Through Time|Amusement Park of Doom

Gui, Add, Picture, x+15 yp+2 vFormationQ gSetFormationQ, %f1%
Gui, Add, Picture, x+5 vFormationW gSetFormationW, %f2%
Gui, Add, Picture, x+5 vFormationE gSetFormationE, %f3%

Gui, Add, DropDownList, x+15 yp-2 w100 vCrusaderChoice gChooseCrusader, Alan|Bat|Bernard|Billy|Boggins|Brogon|Broot|Bubba|Bush|Cindy|Dark Helper|Draco|Drizzle|Eiralon|Emo|Exterminator|Fright-o-Tron|Frosty|Gloria|Graham|Greyskull|Groklok|Gryphon|Half-Blood Elf|Henry|Hermit|Ilsa|Jack|Jason|Jim|Kaine|Karen|Karl|Katie|Khouri|Kizlblyp|Kyle|Larry|Leerion|Lion|Littlefoot|Merci|Mindy|Momma|Monkey|Montana|Natalie|Nate|Pam|Panda|Paul|Pete|Petra|Phoenix|Princess|Rayna|Reginald|Robbie|Roborabbit|Roboturkey|Rocky|Rudolph|Sal|Sally|Santa|Sarah|Sasha|Shadow Queen|Siri|Snickette|Soldierette|Squiggles|Thalia|Val|Veronica|Warwick|Wendy

Gui, Add, Picture, x+151 y15 vClickingStatus gSetClicking, %clickingStatus%
Gui, Add, Picture, y+9 vLevelCapResetStatus gSetLevelCapReset, %levelCapResetStatus%

Gui, Add, Picture, x+15 y0 gExitBot, images/gui/close.png
Gui, Add, Picture, y+5 vStats gSettings, images/gui/stats.png
Gui, Add, Picture, y+5 vSettings gSettings, images/gui/settings.png

GuiControl, ChooseString, CrusaderChoice, %mainDPS%

Gui, BotGUIStatus: New, -Caption, CoTLI Bot Status
Gui, Add, Picture, x0 y0 vBotStatus gBotStatus, images/gui/paused.png