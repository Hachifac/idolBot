#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#include lib/guiUpdate.ahk

OnExit, ExitBot

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

StringReplace, numRGVersion, rGVersion,.,, 1
StringReplace, numFRVersion, fRVersion,.,, 1
if (numFRVersion < numRGVersion) {
	winW = 200
	winH = 111
	nX := A_ScreenWidth / 2 - winW / 2
	nY := A_ScreenHeight / 2 - winH / 2
	Gui, BotGUIUpdate: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Update
	Pause, Toggle
}

version := fVersion[1]

; Include the bot
#include lib/botMain.ahk

F9::
	Reload
	Return
	
CloseUpdate:
	Pause, Toggle
	Gui, BotGUIUpdate: Hide
	Return
	
ExitBot:
	Process, Close, %botChestsPID%
	ExitApp