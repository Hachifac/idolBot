#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

v := "0.81"

Gui, BotGui: New, -Caption, CotLI Bot
Gui, Color, 5C1F07
Gui, Font, s8 italic cAAAAAA, Candara
Gui, Add, Text, x5 y+60, v%v% by Hachifac
Gui, Font, s12 norm cFFFFFF, Candara

campaign := "1"
objective := "1"
formation := 1
mainDPS := "frosty"

f1 := "images/f1_off.png"
f2 := "images/f2_off.png"
f3 := "images/f3_off.png"

Loop, Read, settings/settings.txt
{
	cLine := StrSplit(A_LoopReadLine, "=")
	if (cLine[1] == "campaign") {
		campaign := cLine[2]
	}
	if (cLine[1] == "objective") {
		objective := cLine[2]
	}
	if (cLine[1] == "formation") {
		formation := cLine[2]
	}
	if (cLine[1] == "maindps") {
		mainDPS := cLine[2]
	}
}

if (formation = 1) {
	formationKey := "q"
}
if (formation = 2) {
	formationKey := "w"
}
if (formation = 3) {
	formationKey := "e"
}

f%formation% := "images/f" . formation . "_on.png"

Gui, Add, Text, x5 y5, Campaign
Gui, Add, DropDownList, x5 y+5 w190 Choose%campaign% vCampaignChoice gChooseCampaign altSubmit, Event|World's Wake|Descent into Darkness|Ghostbeard's Greed|Grimm's Idle Tales|Mischief at Mugwarts|Ready Player Two|Idols Through Time|Amusement Park of Doom

Gui, Add, Text, x200 y5, Objective

Gui, Font, cAAAAAA
Gui, Add, Text, x200 y+5, Free Play
Gui, Font, cFFFFFF

Gui, Add, Text, x400 y5, Formation
Gui, Add, Picture, x400 y+5 vFormationQ gSetFormationQ, %f1%
Gui, Add, Picture, x+5 vFormationW gSetFormationW, %f2%
Gui, Add, Picture, x+5 vFormationE gSetFormationE, %f3%

Gui, Add, Text, x500 y5, Main DPS
Gui, Add, DropDownList, x500 y+5 w100 vCrusaderChoice gChooseCrusader, Alan|Bat|Bernard|Billy|Boggins|Brogon|Broot|Bubba|Bush|Cindy|Dark Helper|Draco|Drizzle|Eiralon|Emo|Exterminator|Fright-o-Tron|Frosty|Gloria|Graham|Greyskull|Groklok|Gryphon|Half-Blood Elf|Henry|Hermit|Ilsa|Jack|Jason|Jim|Kaine|Karen|Karl|Katie|Khouri|Kizlblyp|Kyle|Larry|Leerion|Lion|Littlefoot|Merci|Mindy|Momma|Monkey|Montana|Natalie|Nate|Pam|Panda|Paul|Pete|Petra|Phoenix|Princess|Rayna|Reginald|Robbie|Roborabbit|Roboturkey|Rocky|Rudolph|Sal|Sally|Santa|Sarah|Sasha|Shadow Queen|Siri|Snickette|Soldierette|Squiggles|Thalia|Val|Veronica|Warwick|Wendy
Gui, Add, Picture, x647 y5 vBotStatus gBotStatus, images/paused.png

GuiControl, ChooseString, CrusaderChoice, %mainDPS%