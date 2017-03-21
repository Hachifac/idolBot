#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent phaseing directory.

; Include the GUIs
#include gui/main.ahk

; Include the lists
#include lists/crusaders.ahk

CoordMode, Pixel, Client
CoordMode, Mouse, Client

SetTimer, GUIPos, 100 ; Every 100ms we position the GUI below the game

phase = -1 ; -1 = bot not launched, 0 = bot in campaign selection screen, 1 = initial stuff like looking for overlays, waiting for the game to fully load, 2 = maxing the levels/ main dps and upgrades, 3 = reset phase
launchTime = % UnixTime(A_Now)
now = 0
relaunching = false
checkLevelCap := false
lootItemsDuration = 30

global maxAllCount = 0

lastProgressCheck = 0
runTime = 0
lastChatRoom := chatRoom

global currentCIndex := [1, 1]
global currentCCoords := [36, 506]
global crusaderPixels := Object()
global crusaderPixelsTemp := Object()

; Bot loop
Bot:
	FileGetSize, Output, logs/logs.txt, M
	if (Output >= 10) {
		FileMove, logs/logs.txt, logs/logs_old.txt
		FileDelete, logs/logs.txt
	}
	Log("------------- CoTLI Bot by Hachifac -------------")
	IfWinExist, Crusaders of The Lost Idols
	{
		WinActivate, Crusaders of The Lost Idols
		; WinMove, 0, 0
		; Self-explanatory
		if (phase = -1) {
			Loop {
				if (phase = 0) {
					Break
				}
			}
		}
		; Campaign selection, the bot will either start a campaign or realize one is already started
		if (phase = 0) {
			Log("Launching bot.")
			Gosub, CampaignStart
			phase = 1
		}
		; Campaign selected/game screen loaded/game running
		if (phase > 0) {
			Log("Bot launched.")
			; We look for overlays throughout phase 1 & 2
			Loop {
				WinActivate, Crusaders of The Lost Idols
				if (phase = 1 or phase = 2) {
					PixelGetColor, Output, 15, 585, RGB
					if (Output = 0x503803) {
						Log("Found an overlay.")
						ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/news_x.png
						if (ErrorLevel = 0) {
							Log("Overlay closed.")
							MouseMove, OutputX + 7, OutputY + 7
							Sleep, 100
							Click
						}
					}
				}
				if (phase = 1) {
					relaunching = false
					Log("Waiting for the campaign to load.")
					; We look at the left arrow in the crusaders bar, if it's there it means the screen is fully loaded
					PixelGetColor, Output, 15, 585, RGB
					if (Output = 0xA07107 or Output = 0xFFB103) {
						Log("Campaign loaded.")
						; Press space bar to close the events/sales tabs
						Send, {Space}
						; If the left arrow is gold, it means we're not at the beginning of the characters bar, we're moving back until we detect the gold color
						if (Output != 0xA07107) {
							Log("Moving the characters bar to the beginning.")
							MoveToFirstPage()
						}
						Loop, 100 {
							; We look at Jim's buy button to know if we can select the formation
							PixelGetColor, Output, 244, 595, RGB
							; If it's not green, we first look if the right arrow is gold, if it is it means the game already started long ago and Jim is probably maxed, meaning we need to put the formation in right now
							; then we click the monsters until we get some cash to initiate the formation
							; If it's green, in a few seconds the bot will max all levels and some crusaders will get in formation, eventually the formation set will kick in
							if (Output != 0x45D402) {
								PixelGetColor, Output, 985, 585, RGB
								if (Output != 0xA07107) {
									send, {%formationKey%}
									phase = 2
									Break
								}
								; Auto click until Jim lvl up button turns green
								Log("Clicking until Jim lvl up button turns green.")
								MouseMove, 695, 325
								Click
								Sleep, 40
								MouseMove, 750, 325
								Click
								Sleep, 40
							} else {
								Break
							}
						}
						; Open options window to see if auto progress is on
						Log("Initial auto progress check...")
						Gosub, SetAutoProgress
						; We look at Jim's buy button one last time, if it's green we're good to go to phase 2
						PixelGetColor, Output, 244, 595, RGB
						if (Output = 0x45D402) {
							phase = 2
						}
						; Set Chat Room to chatRoom
						Log("Setting chat room to " . chatRoom . ".")
						Gosub, SetChatRoom
					} else {
						Sleep, 1000
					}
				}
				; Sometimes we get a server failed error, shit happens. We search for it and if it pops up, we relaunch the game.
				ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/serverfailed.png
				if (ErrorLevel = 0) {
					Log("Server failed error. Relaunching the game.")
					Gosub, Relaunch
				}
				; Upgrade all/max all/max main dps. Final phase until reset phase.
				if (phase = 2) {
					if (lastChatRoom != chatRoom) {
						Gosub, SetChatRoom
					}
					; If mainDPSDelay elapsed between the launchTime and current time, we only max mainDPS until reset phase
					if (UnixTime(A_Now) - launchTime > (mainDPSDelay * 60)) {
						Log("Moving to mainDPS.")
						if (crusaderPixels.length() = 0) {
							MoveToFirstPage()
							MoveToCrusader(mainDPS)
							Sleep, 1000
							SetCrusadersPixels()
						} else {
							if (CompareCrusadersPixels() = false) {
								Log("We might have moved from the mainDPS, let's go back.")
								MoveToFirstPage()
								Sleep, 500
								MoveToCrusader(mainDPS)
								Sleep, 1000
								SetCrusadersPixels()
							}
						}
						Log("Maxing mainDPS.")
						MouseMove, currentCCoords[1] + 252, currentCCoords[2] + 18
						send, {ctrl down}
						sleep, 100
						click
						send, {ctrl up}
						sleep, 100
					} else {
						; If mainDPSDelay hasn't elapsed yet, we max all levels
						maxLevels()
						maxAllCount++
						; If the bot did upgAllUntil max all levels, do one buy all upgrades
						if (maxAllCount >= upgAllUntil) {
							UpgAll()
							maxAllCount = 0
						}
					}
					; Auto move the mouse to get the gold and quest items for 30 seconds.
					Log("Get the gold and quest items for 30 seconds.")
					now = % UnixTime(A_Now)
					if (clicking = true) {
						delay := clickDelay / 2
					} else {
						delay = 40
					}
					while (UnixTime(A_Now) - now <= lootItemsDuration) {
						MouseMove, 840, 240
						if (clicking = true) {
							click
						}
						Sleep, %delay%
						MouseMove, 840, 355
						Sleep, %delay%
					}
					if (checkLevelCap = true) {
						MaxLevels()
					}
					; If the last time we did an auto progress check is >= than autoProgressCheckDelay, we initiate an auto progress check
					if (UnixTime(A_Now) - lastProgressCheck >= autoProgressCheckDelay or checkLevelCap = true) {
						levelCapReset := false
						if (levelCapReset = true) {
							Log("Level cap reset check.")
							MoveToLastPage()
							Sleep, 500
							PixelGetColor, Output, 872, 594, RGB
							if (Output = 0x7D2E0C) {
								PixelGetColor, Output, 872, 508, RGB
							}
							if (Output = 0x979797) {
								if (checkLevelCap = false) {
									checkLevelCap := true
								} else {
									Log("Level cap achieved.")
									MoveToFirstPage()
									phase = 3
								}
							} else {
								Log("Level cap not achieved.")
								MoveToFirstPage()
								checkLevelCap := false
							}
						}
						; Every autoProgressCheckDelay seconds we take a look if Auto Progress is still activated, if it's not it means we died so achieved the highest zone we could, we have to reset
						lastProgressCheck = % UnixTime(A_Now)
						if (CheckAutoProgress() = false and checkLevelCap = false) {
							if (UnixTime(A_Now) - launchTime < 60) {
								; Stuck at beginning, might be the formation not active
								Log("Might be stuck at the beginning.")
								send, {%formationKey%}
								Sleep, 100
								Send, {g}
							} else {
								phase = 3
							}
						}
						Log("Using all skills.")
						useSkill(0)
					}
				}
				; If runTime time elapsed or phase is set at 3, we reset
				if ((runTime > 0 and UnixTime(A_Now) - launchTime > runTime) or phase = 3) {
					Log("Cannot progress further, time to reset.")
					phase = 1
					MouseMove, 985, 630
					Click
					Sleep, 500
					; Move to reset crusader
					Log("Moving to reset crusader.")
					MoveToCrusader(resetCrusader)
					Sleep, 1000
					; Get pixel color on resetCrusader skills to know where the reset button is
					Log("Searching for that reset skill.")
					cY := currentCCoords[2] + 60
					if (resetCrusader == "nate" or resetCrusader == "kizlblyp") {
						cX := currentCCoords[1] + 154
					}
					if (resetCrusader == "rudolph") {
						cX := currentCCoords[1] + 96
					}
					PixelGetColor, Output, cX, cY, RGB
					if (Output = 0x853213) {
						MouseMove, currentCCoords[1] + 9, cY
						Sleep, 500
					} else {
						MouseMove, cX, cY
						Sleep, 500
					}
					Log("Found. Reset inbound.")
					Loop {
						Click
						Sleep, 1000
						Log("Reset warning window.")
						ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/resetwarning.png
						if (ErrorLevel = 0) {
							Loop {
								; Reset button
								MouseMove, 407, 516
								Sleep, 500
								Click
								Sleep, 2000
								; Big red button
								Log("Clicking the red button.")
								ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/redbutton.png
								if (ErrorLevel = 0) {
									MouseMove, 509, 546
									Sleep, 500
									Click
									Sleep, 5000
								}
								; Idols screen
								Log("Idols continue screen.")
								ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/idolscontinue.png
								if (ErrorLevel = 0) {
									MouseMove, 507, 550
									Sleep, 500
									Click
									Sleep, 2000
									Break
								}
							}
							Log("Start a new campaign.")
							Gosub, CampaignStart
							Sleep, 100
							phase = 1
							Break
						}
					}
				}
			}
		}
	}
	IfWinNotExist, Crusaders of The Lost Idols
	{
		Log("Game not found.")
	}
	Return

; Set the GUI below the game
GUIPos:
	IfWinExist, Crusaders of The Lost Idols
	{
		WinGetPos, X, Y, W, H, Crusaders of The Lost Idols
		nY := A_ScreenHeight - (A_ScreenHeight - Y) + H - 2
		nW := W
		nX := X + W / 2 - 661 / 2 + 2
		Gui, BotGUI: Show, x%nX% y%nY% w661 h115 NoActivate, BotGUI
	}
	IfWinNotExist, Crusaders of The Lost Idols
	{
		if (relaunching = false) {
			Pause,, 1
			GuiControl, BotGUI:, BotStatus, images/paused.png
			Log("[GUI] Game not found.")
		}
	}
	Return

; Pause key
F8::
	if (phase = -1) {
		phase = 0
		GuiControl, BotGUI:, BotStatus, images/running.png
		WinActivate, Crusaders of The Lost Idols
	} else {
		Pause,,1
	}
	if (phase > 0) {
		if (A_IsPaused) {
			Log("Paused.")
			GuiControl, BotGUI:, BotStatus, images/paused.png
		} else {
			Log("Unpaused.")
			GuiControl, BotGUI:, BotStatus, images/running.png
			WinActivate, Crusaders of The Lost Idols
		}
	}
	Return

BotStatus:
		if (A_IsPaused) {
			Log("Unpaused.")
			GuiControl, BotGUI:, BotStatus, images/running.png
			WinActivate, Crusaders of The Lost Idols
			Pause,,1
		} else if (phase = -1 ) {
			phase = 0
			GuiControl, BotGUI:, BotStatus, images/running.png
			WinActivate, Crusaders of The Lost Idols
		}
	Return

; Relaunch the game, pretty much self-explanatory
Relaunch:
	Log("Closing the game.")
	relaunching = true;
	WinClose, Crusaders of The Lost Idols
	Log("Waiting on the game to close.")
	WinWaitClose, Crusaders of The Lost Idols,,180
	Loop {
		Process, Exist, Crusaders of the Lost Idols.exe
		if (ErrorLevel > 0) {
			Process, Close, ErrorLevel
		} else {
			Break
		}
		Sleep, 500
	}
	Log("Game closed. Relaunching.")
	Run, steam://Rungameid/402840,,UseErrorLevel
	Log("Waiting on the game to launch.")
	WinWait, Crusaders of The Lost Idols,,300
	relaunching = false
	WinActivate, Crusaders of The Lost Idols
	WinMove, Crusaders of The Lost Idols,,15,15
	seen = 0
	Log("Searching for start button.")
	Loop {
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/start.png
		if (ErrorLevel = 0) {
			seen = 1
			MouseMove, 498, 540
			Sleep, 500
			Click
		} else {
			if (seen = 1) {
				phase = 1
				Break
			}
		}
		Sleep, 1000
	}
	Return

; Campaign screen, well at least triggered when we think it's the campaign screen or we just did a reset
CampaignStart:
	Log("Searching for campaign header.")
	Loop {
		; If the campaign.png is found (which is the big campaign text at the top of the screen), we know for sure that's where we are
		; If not found, we look for the cog (settings button), we're instead still/already in the game
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/campaign.png
		if (ErrorLevel = 0) {
			Log("Found the campaign header.")
			SetCampaign(campaign, objective)
			MouseMove, 781, 571
			Sleep, 5000
			Click
			launchTime = % UnixTime(A_Now)
			lastProgressCheck = 0
			maxAllCount = 0
			if (phase = 1) {
				Log("Relaunching CoTLI.")
				Gosub, Relaunch
			}
			Break
		} else {
			Log("Searching for the cog.")
			ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/cog.png
			if (ErrorLevel = 0) {
				Log("Found the cog.")
				Break
			} else {
				Log("Didn't find the cog, looking for left arrow instead.")
				PixelGetColor, Output, 15, 585, RGB
				if (Output = 0x503803) {
					Break
				}
			}
		}
	}
	Return

; Browse the campaign screen to find the desired one, will scan up and down until the proper campaign image is found
; Once the campaign is found, we set the objective by calling the function SetObjective
SetCampaign(c, o) {
	Log("Setting the campaign.")
	if (c = 1) {
		MouseMove, 535, 195
		Sleep, 500
		Click
		Log("Starting the event campaign.")
		Return
	} else {
		currentPos = 0
		Log("Searching for the campaign.")
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/c%c%.png
		if (ErrorLevel = 0) {
			Log("Found the campaign.")
			SetObjective(o, OutputX, OutputY)
			Return
		} else {
			ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/campaign_uparrow_active.png
			if (ErrorLevel = 0) {
				upX += 10
				upY += 10
				Loop {
					MouseMove, upX, upY
					Click
					Sleep, 500
					ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/campaign_uparrow_inactive.png
					if (ErrorLevel = 0) {
						Break
					}
				}
			}
			ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/campaign_uparrow_inactive.png
			ImageSearch, downX, downY, 0, 0, 997, 671, *100 images/campaign_downarrow_active.png
			upX += 10
			upY += 10
			downX += 10
			downY += 10
			Loop {
				MouseMove, downX, downY
				Click
				Sleep, 500
				ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/c%c%.png
				if (ErrorLevel = 0) {
					Log("Found the campaign.")
					SetObjective(o, OutputX, OutputY)
					Return
				}
				ImageSearch, downX, downY, 0, 0, 997, 671, *100 images/campaign_downarrow_inactive.png
				if (ErrorLevel = 0) {
					Loop {
						MouseMove, upX, upY
						Click
						Sleep, 500
						ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/campaign_uparrow_inactive.png
						if (ErrorLevel = 0) {
							Break
						}
					}
				}
			}
		}
	}
}

; Set the objective, called by SetCampaign(c, o)
; c = campaign, x and y = the campaign image's location
SetObjective(o, x, y) {
	Log("Setting the objective.")
	if (o = "1") {
		MouseMove, x + 505, y + 85
		Sleep, 500
		Click
	}
	Log("Objective set.")
	Return
}

; Navigate the crusaders bar to find the desired crusader
; c = crusader
MoveToCrusader(c) {
	global currentCCoords
	global crusaders
	apStatus := false
	if (CheckAutoProgress() = true) {
		apStatus := true
		send, {g}
		Sleep, 5000
	}
	currentCIndex[2] := crusaders[c][2]
	nX := crusaders[c][1] - currentCIndex[1]
	pagesToMove := 0
	if (currentCIndex[1] < crusaders[c][1]) {
		currentCIndex[1] := crusaders[c][1]
		if (nX > 2) {
			pagesToMove := nX - 2
			currentCIndex[1] -= 2
		} else {
			currentCIndex[1] -= nX
		}
	} else {
		currentCIndex[1] := crusaders[c][1]
		pagesToMove := nX
	}
	if (pagesToMove != 0) {
		MoveToPage(pagesToMove)
	}
	currentCCoords[1] := 37 + 315 * (nX - pagesToMove)
	currentCCoords[2] := 506 + 86 * (currentCIndex[2] - 1)
	if (apStatus = true) {
		Send, {g}
	}
	Return
}

MoveToFirstPage() {
	currentCIndex := [1, 1]
	Loop {
		PixelGetColor, Output, 15, 585, RGB
		if (Output = 0xA07107) {
			Break
		}
		MouseMove, 15, 585
		Click
		Sleep, 50
	}
	Return
}

MoveToLastPage() {
	Loop {
		PixelGetColor, Output, 985, 585, RGB
		if (Output = 0xA07107) {
			Break
		}
		MouseMove, 985, 585
		Click
		Sleep, 50
	}
	Return
}

MoveToPage(p) {
	if (p > 0) {
		aX = 985
		d = 1
	} else {
		aX = 15
		p *= -1
		d = 0
	}
	Loop, %p% {
		MouseMove, aX, 585
		PixelGetColor, Output, aX, 585, RGB
		if (Output != 0x000000) {
			Click
		}
		Sleep, 100
	}
	Return
}

SetCrusadersPixels() {
	Sleep, 1000
	initialX = 42
	i = 0
	j = 0
	Loop, 24 {
		if (A_Index = 9 or A_Index = 17) {
			j++
			i = 0
		}
		i++
		PixelGetColor, Output, initialX + (i - 1) * 4, 506 + j * 2, RGB
		crusaderPixels[A_Index] := Output
	}
	Return
}

CompareCrusadersPixels() {
	initialX = 42
	i = 0
	j = 0
	Loop, 24 {
		if (A_Index = 9 or A_Index = 17) {
			j++
			i = 0
		}
		i++
		PixelGetColor, Output, initialX + (i - 1) * 4, 506 + j * 2, RGB
		crusaderPixelsTemp[A_Index] := Output
	}
	j = 0
	for i, e in crusaderPixelsTemp {
		if (crusaderPixels[i] = crusaderPixelsTemp[i]) {
			j++
		}
	}
	if (j = crusaderPixels.MaxIndex()) {
		Return, true
	}
	Return, false
}

; Max levels
MaxLevels() {
	global formationKey
	Log("Max all levels.")
	MouseMove, 985, 630
	Click
	Sleep, 100
	Loop {
		PixelGetColor, Output, 985, 610, RGB
		if (Output != 0x226501) {
			Break
		}
		Sleep, 10
		
	}
	Send, {%formationKey%}
	Return
}

; Upgrade all
UpgAll() {
	Log("Buy all upgrades.")
	MouseMove, 985, 540
	Click
	Sleep, 100
	Loop {
		PixelGetColor, Output, 985, 515, RGB
		if (Output != 0x194D80) {
			Break
		}
		Sleep, 10
	}
	Return
}

; Use a skill, 0 to use all skills
useSkill(s) {
	if (s = 0) {
		Loop, 8 {
			Send, %A_Index%
			Sleep, 25
		}
	} else {
		Send, s
	}
	Return
}

; Sets the auto progress to true
SetAutoProgress:
	lastProgressCheck = % UnixTime(A_Now)
	if (CheckAutoProgress() = false) {
		Log("Setting auto progress to true.")
		Send, {g}
	}
	Return

; Check if the auto progress is set to true or false
CheckAutoProgress() {
	Log("Auto progress check...")
	Loop {
		MouseMove, 317, 111
		Sleep, 100
		Click
		Sleep, 500
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/options.png
		Sleep, 500
		; If the big options header is found, it means the options window is open
		if (ErrorLevel = 0) {
			c = 0
			; Here I use a loop because I've had lots of trouble with AHK giving me the wrong color, so now the bot loops until it finds the proper color
			; (will get stuck here infinitely until the color is found, this seriously can take a few seconds)
			Loop {
				PixelGetColor, Output, 212, 337, RGB
				if (Output = 0xE8CDC5) {
					Break
				} else {
					if (Output = 0x742814 or Output = 0xF7EDEA) {
						c++
						Break
					}
				}
			}
			lastProgressCheck = % UnixTime(A_Now)
			MouseMove, 738, 196
			Sleep, 100
			Click
			Sleep, 1000
			if (c = 0) {
				Break
			} else {
				Log("Auto progress check returned false.")
				Return, false
			}
		}
	}
	Log("Auto progress check returned true.")
	Return, true
}

SetChatRoom:
	MouseMove, 1135, 10
	Sleep, 100
	Click
	if (chatRoom > 10) {
		chatRoom = 10
	}
	MouseMove, 1135, 18 + (21 * chatRoom)
	Sleep, 100
	Click
	lastChatRoom := chatRoom
	Return

; Log function
Log(log) {
	FormatTime, TimeOutput, A_Now, yyyy/M/d - HH:mm:ss
	FileAppend, [%TimeOutput%] %log%`n, logs/logs.txt
	Return
}

; Transforms YYYYMMDDHH24MISS date format to Unix
UnixTime(Time) {
	Result := Time
	Result -= 19700101000000, Seconds
	Return, Result
}

; Self-explanatory
RewriteSettings:
	Log("Settings changed.")
	FileDelete, settings/settings.txt
	FileAppend, [Settings]`n, settings/settings.txt
	FileAppend, campaign=%campaign%`n, settings/settings.txt
	FileAppend, objective=%objective%`n, settings/settings.txt
	FileAppend, formation=%formation%`n, settings/settings.txt
	FileAppend, maindps=%mainDPS%`n, settings/settings.txt
	if (clicking = true) {
		FileAppend, clicking=true`n, settings/settings.txt
	} else {
		FileAppend, clicking=false`n, settings/settings.txt
	}
	if (levelCapReset = true) {
		FileAppend, levelcapreset=true`n, settings/settings.txt
	} else {
		FileAppend, levelcapreset=false`n, settings/settings.txt
	}
	FileAppend, upgalluntil=%upgAllUntil%`n, settings/settings.txt
	FileAppend, autoprogresscheckdelay=%autoProgressCheckDelay%`n, settings/settings.txt
	FileAppend, maindpsdelay=%mainDPSDelay%`n, settings/settings.txt
	StringLower, resetCrusader, resetCrusader
	FileAppend, resetcrusader=%resetCrusader%`n, settings/settings.txt
	FileAppend, chatroom=%chatRoom%`n, settings/settings.txt
	FileAppend, clickdelay=%clickDelay%`n, settings/settings.txt
	Return

;				;
;	GUI Labels	;
;				;

ChooseCampaign:
	Gui, Submit, nohide
	if (CampaignChoice == 1) {
		
	}
	if (CampaignChoice == 2) {
		Objectives = "Getting Started|Centennial|Run Away!|Dig In|Holy Hand Grenade of Antioch|The Long Haul|Inflation|Your Mother's A Hamster|Around the World|Top Tier|Gray Goo|Free Play
	}
	campaign := CampaignChoice
	Log("User changed the campaign.")
	Gosub, RewriteSettings
	Return

ChooseCrusader:
	Gui, Submit, nohide
	Log("User changed the main DPS.")
	mainDPS := CrusaderChoice
	StringLower, mainDPS, mainDPS
	Gosub, RewriteSettings
	Return
	
SetFormationQ:
	Log("User changed the formation.")
	formationKey := "q"
	formation = 1
	Gosub, RewriteSettings
	GuiControl,, FormationQ, images/f1_on.png
	GuiControl,, FormationW, images/f2_off.png
	GuiControl,, FormationE, images/f3_off.png
	Return
	
SetFormationW:
	Log("User changed the formation.")
	formationKey := "w"
	formation = 2
	Gosub, RewriteSettings
	GuiControl,, FormationQ, images/f1_off.png
	GuiControl,, FormationW, images/f2_on.png
	GuiControl,, FormationE, images/f3_off.png
	Return

SetFormationE:
	Log("User changed the formation.")
	formationKey := "e"
	formation = 3
	Gosub, RewriteSettings
	GuiControl,, FormationQ, images/f1_off.png
	GuiControl,, FormationW, images/f2_off.png
	GuiControl,, FormationE, images/f3_on.png
	Return

SetClicking:
	if (clicking = true) {
		GuiControl,, ClickingStatus, images/off.png
		clicking := false
	} else {
		GuiControl,, ClickingStatus, images/on.png
		clicking := true
	}
	Gosub, RewriteSettings
	Return

SetLevelCapReset:
	/*
	if (levelCapReset = true) {
		GuiControl,, LevelCapResetStatus, images/off.png
		levelCapReset := false
	} else {
		GuiControl,, LevelCapResetStatus, images/on.png
		levelCapReset := true
	}
	Gosub, RewriteSettings
	*/
	MsgBox, Currently not working
	Return
	
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
SClickDelay:
	Return
SHelp:
	Return	

CloseSettings:
	Gui, BotGUISettings: Hide
	Return

ApplySettings:
	Gui, Submit, NoHide
	upgAllUntil := SUpgAllUntil
	autoProgressCheckDelay := SAutoProgressCheckDelay
	mainDPSDelay := SMainDPSDelay
	resetCrusader := SResetCrusader
	lastChatRoom := chatRoom
	chatRoom := SChatRoom
	clickDelay := SClickDelay
	Gosub, RewriteSettings
	Gui, BotGUISettings: Hide
	Return
	
Settings:
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/settings.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X + OutputX - 126 + OutputW / 2
	nY := A_ScreenHeight - Output2Y + OutputH * 2
	settings := ReadSettings()
	GuiControl, BotGUISettings:, SUpgAllUntil, % settings["upgalluntil"]
	GuiControl, BotGUISettings:, SAutoProgressCheckDelay, % settings["autoprogresscheckdelay"]
	autoProgressCheckDelay := SAutoProgressCheckDelay
	GuiControl, BotGUISettings:, SMainDPSDelay, % settings["maindpsdelay"]
	GuiControl, BotGUISettings: ChooseString, SResetCrusader, % settings["resetcrusader"]
	StringLower, resetCrusader, resetCrusader
	GuiControl, BotGUISettings:, SChatRoom, % settings["chatroom"]
	GuiControl, BotGUISettings:, SClickDelay, % settings["clickdelay"]
	Gui, BotGUISettings: Show, x%nX% y%nY% w252 h406, BotGUI Settings
	Return

LoadSettings:
	Log("Reading settings.")
	settings := Object()
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
			if (formation = 1) {
				Gosub, SetFormationQ
			}
			if (formation = 2) {
				Gosub, SetFormationW
			}
			if (formation = 3) {
				Gosub, SetFormationE
			}
		}
		if (cLine[1] == "maindps") {
			mainDPS := cLine[2]
		}
		if (cLine[1] == "clicking") {
			clicking := cLine[2]
			if (clicking = "true") {
				clicking := true
			} else {
				clicking := false
			}
		}
		if (cLine[1] == "levelcapreset") {
			levelcapreset := cLine[2]
			if (levelcapreset = "true") {
				levelcapreset := true
			} else {
				levelcapreset := false
			}
		}
		if (cLine[1] == "upgalluntil") {
			upgAllUntil := cLine[2]
		}
		if (cLine[1] == "autoprogresscheckdelay") {
			autoProgressCheckDelay := cLine[2]
		}
		if (cLine[1] == "maindpsdelay") {
			mainDPSDelay := cLine[2]
		}
		if (cLine[1] == "resetcrusader") {
			resetCrusader := cLine[2]
		}
		if (cLine[1] == "chatroom") {
			chatRoom := cLine[2]
		}
		if (cLine[1] == "clickdelay") {
			clickDelay := cLine[2]
		}
	}
	Return
	
ExitBot:
	ExitApp
	Return