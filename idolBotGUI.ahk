#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

v := "0.81"

Gui, BotGUI: New, -Caption, CotLI Bot
Gui, Color, 933506
Gui, Add, Picture, x0 y0, images/gui_bg.png
Gui, Font, s8 italic cAAAAAA, Candara
Gui, Add, Text, x8 y96, v%v% by Hachifac
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

Gui, Add, DropDownList, x10 y35 w190 Choose%campaign% vCampaignChoice gChooseCampaign altSubmit, Event|World's Wake|Descent into Darkness|Ghostbeard's Greed|Grimm's Idle Tales|Mischief at Mugwarts|Ready Player Two|Idols Through Time|Amusement Park of Doom

Gui, Font, cAAAAAA
Gui, Add, Text, x+33 yp+3, Free Play
Gui, Font, cFFFFFF

Gui, Add, Picture, x+107 yp-5 vFormationQ gSetFormationQ, %f1%
Gui, Add, Picture, x+5 vFormationW gSetFormationW, %f2%
Gui, Add, Picture, x+5 vFormationE gSetFormationE, %f3%

Gui, Add, DropDownList, x+37 yp w100 vCrusaderChoice gChooseCrusader, Alan|Bat|Bernard|Billy|Boggins|Brogon|Broot|Bubba|Bush|Cindy|Dark Helper|Draco|Drizzle|Eiralon|Emo|Exterminator|Fright-o-Tron|Frosty|Gloria|Graham|Greyskull|Groklok|Gryphon|Half-Blood Elf|Henry|Hermit|Ilsa|Jack|Jason|Jim|Kaine|Karen|Karl|Katie|Khouri|Kizlblyp|Kyle|Larry|Leerion|Lion|Littlefoot|Merci|Mindy|Momma|Monkey|Montana|Natalie|Nate|Pam|Panda|Paul|Pete|Petra|Phoenix|Princess|Rayna|Reginald|Robbie|Roborabbit|Roboturkey|Rocky|Rudolph|Sal|Sally|Santa|Sarah|Sasha|Shadow Queen|Siri|Snickette|Soldierette|Squiggles|Thalia|Val|Veronica|Warwick|Wendy
Gui, Add, Picture, x644 y7 vBotStatus gBotStatus, images/paused.png

Gui, Add, Picture, x644 y+2 vSettings gSettings, images/settings.png

Gui, BotGUI: Show, x0 y0 w749 h116 NoActivate, BotGUI
GuiControl, ChooseString, CrusaderChoice, %mainDPS%

Gui, BotGUISettings: New, -Caption, CotLI Bot Settings
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui_settings_bg.png

Gui, Add, Edit, x15 y72 w180
Gui, Add, UpDown, vSUpgAllUntil gSUpgAllUntil Range0-2147483647, 1
Gui, Add, Picture, x+19 yp+4 gSHelp, images/help.png

Gui, Add, Edit, x15 y124 w180
Gui, Add, UpDown, vSAutoProgressCheckDelay gSAutoProgressCheckDelay Range0-2147483647
Gui, Add, Picture, x+19 yp+4 gSAutoProgressCheckDelay gSHelp, images/help.png

Gui, Add, Edit, x15 y176 w180
Gui, Add, UpDown, vSMainDPSDelay gSMainDPSDelay Range0-2147483647
Gui, Add, Picture, x+19 yp+4 gSMainDPSDelay gSHelp, images/help.png

Gui, Add, DropDownList, x15 y228 w180 vSResetCrusader gSResetCrusader, Nate|Rudolph|Kizlblyp
Gui, Add, Picture, x+19 yp+4 gSResetCrusader gSHelp, images/help.png

Gui, Add, Edit, x15 y280
Gui, Add, UpDown, vSChatRoom gSChatRoom Range1-10, 1
Gui, Add, Picture, x+17 yp+4 gSChatRoom gSHelp, images/help.png

Gui, Add, Picture, x220 y7 gCloseSettings, images/close.png

Gui, Add, Picture, x78 y333 gApplySettings, images/apply.png

SUpgAllUntil:
	Return
SMainDPSDelay:
	Return
SChatRoom:
	Return
SAutoProgressCheckDelay:
	Return
SResetCrusader:
	Return
SHelp:
	Return	

CloseSettings:
	Gui, BotGUISettings: Hide
	Return

ApplySettings:
	Gui, Submit, NoHide
	Gosub, RewriteSettings
	Gui, BotGUISettings: Hide
	Return
	
Settings:
	settings := ReadSettings()
	GuiControl,, SUpgAllUntil, settings[upgalluntil]
	GuiControl, BotGUISettings:, SUpgAllUntil, % settings["upgalluntil"]
	GuiControl, BotGUISettings:, SAutoProgressCheckDelay, % settings["autoprogresscheckdelay"]
	GuiControl, BotGUISettings:, SMainDPSDelay, % settings["maindpsdelay"]
	GuiControl, BotGUISettings: ChooseString, SResetCrusader, % settings["resetcrusader"]
	GuiControl, BotGUISettings:, SChatRoom, % settings["chatroom"]
	Gui, BotGUISettings: Show, x0 y0 w252 h400, BotGUI Settings
	Return
	
ReadSettings() {
	Log("Reading settings.")
	settings := Object()
	Loop, Read, settings/settings.txt
	{
		cLine := StrSplit(A_LoopReadLine, "=")
		if (cLine[1] == "upgalluntil") {
			settings["upgalluntil"] := cLine[2]
		} else if (cLine[1] == "autoprogresscheckdelay") {
			settings["autoprogresscheckdelay"] := cLine[2]
		} else if (cLine[1] == "maindpsdelay") {
			settings["maindpsdelay"] := cLine[2]
		} else if (cLine[1] == "resetcrusader") {
			settings["resetcrusader"] := cLine[2]
		} else if (cLine[1] == "chatroom") {
			settings["chatroom"] := cLine[2]
		}
	}
	Return settings
}