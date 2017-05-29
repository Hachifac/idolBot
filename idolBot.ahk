#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%

if WinExist("idolBot ahk_class AutoHotkeyGUI") {
	MsgBox, There seems to be another idolBot version open, please close it first then try again.
	Goto, _BotExit
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