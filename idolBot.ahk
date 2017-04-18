#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%

OnExit, _BotExit

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Hachifac/idolBot/master/version", true)
whr.Send()
whr.WaitForResponse()
gVersion := whr.ResponseText
gVersion := StrSplit(gVersion, "#")
rGVersion := gVersion[2]

FileRead, fVersion, version
fVersion := StrSplit(fVersion, "#")
fRVersion := fVersion[2]

download := gVersion[2]

#include lib/guiUpdate.ahk

if (fRVersion < rGVersion and gVersion[2] > fVersion[3]) {
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
	FileAppend, #%download%, version
	Goto, _GUICloseUpdate
	Return
	
_GUICloseUpdate:
	Pause, Toggle
	Gui, BotGUIUpdate: Hide
	Return
	
_BotExit:
	ExitApp