#NoEnv
SendMode Input

/*
Bot initialization. Create directories, load settings, etc. All things should only need to be done once.
*/

FileCreateDir, logs
FileCreateDir, settings
FileCreateDir, stats

Gosub, _BotLoadSettings
Gosub, _BotLoadCycles
Gosub, _BotLoadCrusaders
Gosub, _BotSetHotkeys

statsChestsThisRun = 0
statsChestsThisSession = 0
statsIdolsThisSession = 0

Gosub, _BotLoadStats

; Include the lists
#include lib/listKeys.ahk
#include lib/listCampaigns.ahk

; Include the GUIs
#include lib/guiMain.ahk
CoordMode, Pixel, Client
CoordMode, Mouse, Client

lastProgressCheck = 0

botLookingForCursor := false 
; ^^ Quite important little bool, set to true when the _BotGetCurrentLevel timer occurs, it pauses the loot items 
; phase because threads gets messy
botLevelCursorCoords := [1, 2, 3, 4, 5]
botLevelCursorCoords[1] := [745, 11, 785, 130]
botLevelCursorCoords[2] := [780, 11, 825, 130]
botLevelCursorCoords[3] := [817, 11, 863, 130]
botLevelCursorCoords[4] := [856, 11, 905, 130]
botLevelCursorCoords[5] := [904, 11, 943, 130]
botLevelCurrentCursor = 0
botLevelPreviousCursor = 0
botCurrentLevel = 0
botTrackCurrentLevel := false
botTempTrackCurrentLevel := false
botSprintModeCheck := false
botCurrentLevelTimeout = 0 
botBuffsRarity := ["C", "U", "R", "E"]
botBuffs := ["Gold", "Power", "Speed", "Crit", "Click", "Splash"]
botBuffsCoords := [494, 110]
botBuffsGoldCTimer := botBuffsGoldUTimer := botBuffsGoldRTimer := botBuffsGoldETimer := 0
botBuffsPowerCTimer := botBuffsPowerUTimer := botBuffsPowerRTimer := botBuffsPowerETimer := 0
botBuffsSpeedCTimer := botBuffsSpeedUTimer := botBuffsSpeedRTimer := botBuffsSpeedETimer := 0
botBuffsCritCTimer := botBuffsCritUTimer := botBuffsCritRTimer := botBuffsCritETimer := 0
botBuffsClickCTimer := botBuffsClickUTimer := botBuffsClickRTimer := botBuffsClickETimer := 0
botBuffsSplashCTimer := botBuffsSplashUTimer := botBuffsSplashRTimer := botBuffsSplashETimer := 0
rightKeyInterrupt := false
rightKeyStop := false
