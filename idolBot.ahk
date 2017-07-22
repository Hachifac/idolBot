#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Client
CoordMode, Mouse, Client

if WinExist("idolBot ahk_class AutoHotkeyGUI") {
	MsgBox, There seems to be another idolBot version open, please close it first then try again.
	Goto, _BotExit
}

if WinExist("Crusaders of The Lost Idols ahk_exe Crusaders of The Lost Idols.exe") {
	WinActivate, Crusaders of The Lost Idols
	WinGet, CoTLI,, ahk_exe Crusaders of The Lost Idols.exe
	GetClientSize(CoTLI, W, H)
	if (H != 675 and (W != 1000 or W != 1280)) {
		if (W > 0 and H > 0) {
			MsgBox, 0x1, idolBot, % "The resolution of your instance of Crusaders of The Lost Idols appears to be " . W . "x" . H . ".`nA proper resolution for the bot to properly work would need to be 1000x675 or 1280x675.`nIf you experience issues with the bot in the current resolution, please relaunch the game to set it to the proper one."
			IfMsgBox Cancel
			{
				Goto, _BotExit
			}
		}
	}
}

OnExit, _BotExit

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Hachifac/idolBot/master/version", true)
whr.Send()
whr.WaitForResponse()
gVersion := whr.ResponseText
gVersion := StrSplit(gVersion, "#")

FileRead, fVersion, version
fVersion := StrSplit(fVersion, "#")

download := gVersion[2]

#include lib/guiUpdate.ahk

if (fVersion[1] < gVersion[2] and gVersion[2] > fVersion[3]) {
	winW = 301
	winH = 321
	nX := A_ScreenWidth / 2 - winW / 2
	nY := A_ScreenHeight / 2 - winH / 2
	Gui, BotGUIUpdate: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Update
	Pause, Toggle
}

version := fVersion[1]

; Include the bot
#include lib/botMain.ahk

GetClientSize(hwnd, ByRef W, ByRef H) {
    VarSetCapacity(rc, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
    w := NumGet(rc, 8, "int")
    h := NumGet(rc, 12, "int")
}

_BotReload:
	Reload
	Return

_GUIUpdateDownload:
	Run, https://github.com/Hachifac/idolBot/releases/download/%download%/idolBot.%download%.zip
	Goto, _BotExit
	Return
	
_GUIUpdateIgnore:
	FileDelete, version
	FileAppend, % fVersion[1] . "#" . fVersion[2] . "#" . gVersion[2], version
	Goto, _GUICloseUpdate
	Return
	
_GUICloseUpdate:
	Pause, Toggle
	Gui, BotGUIUpdate: Hide
	Return
	
_BotExit:
	ExitApp