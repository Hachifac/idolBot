#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Client
CoordMode, Mouse, Client
OnExit, _BotExit

/* some initial startup items. 
Check that the bot isn't already running twice
Check that Crusaders IS running, and get it's resolution
Check if the bot needs an update
*/

Gosub, _botInternal_botRunningCheck
__Log("ran Running Check")
Gosub, _botInternal_CoTLIrunningCheck
__Log("ran COTI running check")
GoSub, _BotUpdate
__Log("ran Bot update check")



; Include the bot
#include lib/botMain.ahk

; Include internal bot functions
; Include libraries we only want called at specific times after we load the main bot, because AHK is very procedural
;   and likes to run functions even if we don't actually "call" them.....
#include lib/botInternalFunctions.ahk
#include lib/guiLabels.ahk
