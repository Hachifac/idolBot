#NoEnv
SendMode Input

/* 
TODO notes:
	add debug log level for dev-mode debug messages
	fix loops around reset code to better handle failures
	eventually move reset code to functions
	for v1.5.0 - allow setting 2ndary formations 
		- on first wipe?
		- after a certain time period?
	auto-complete mission option?
*/

__Log("loaded bot main")

optDevConsole = 0
__Log("- idolBot v" . version . " by Hachifac (bobby@avoine.ca) -")
__Log("- paint refreshed by thejonpearson - ")
__Log("- Crusaders of The Lost Idols bot -")

#Include botInit.ahk

Gosub, _BotTimers

/*
BOT PHASES
-1 = bot not launched (is paused)
0 = bot in campaign selection screen
1 = initial stuff like looking for overlays, waiting for the game to fully load
2 = maxing the levels/ main dps and upgrades
3 = reset phase
*/

botPhase = -1 
botRunLaunchTime := 0
botLastRelaunch := 0
botLaunchTime := 0
botSession = 0
botRelaunched := false
botAutoProgressCheck := false
botResets = 0
idolsCount = 0

now = 0
botRelaunching := false
botSkipJim := false

botMaxAllCount = 0
botBuffsSpeedTimer = 0

botSkipToReset := false
optLastChatRoom := optChatRoom

global currentCIndex := [1, 1]
global currentCCoords := [36, 506]
global botCrusaderPixels := Object()
global botCrusaderPixelsTemp := Object()
global levelCapPixels := Object()

#Include botMainLoop.ahk

