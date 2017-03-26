#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

OnExit, ExitBot

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Hachifac/idolBot/master/version", true)
whr.Send()
whr.WaitForResponse()
getVersion := whr.ResponseText

FileRead, Output, version

if (Output < getVersion) {
	
}

version = 1.05
; Run, botChests.ahk, lib,, botChestsPID
; Include the bot
#include lib/botMain.ahk



F9::
	Reload
	Return
	
ExitBot:
	; Process, Close, %botChestsPID%
	ExitApp