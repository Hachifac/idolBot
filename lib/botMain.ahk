#NoEnv
SendMode Input

Gosub, LoadSettings

chestsThisRun = 0
chestsThisSession = 0
idolsThisSession = 0

Gosub, LoadStats

; Include the GUIs
#include lib/guiMain.ahk

; Include the lists
#include lib/listCrusaders.ahk

CoordMode, Pixel, Client
CoordMode, Mouse, Client

SetTimer, GUIPos, 100 ; Every 100ms we position the GUI below the game
SetTimer, ScanForChests, 1000

phase = -1 ; -1 = bot not launched, 0 = bot in campaign selection screen, 1 = initial stuff like looking for overlays, waiting for the game to fully load, 2 = maxing the levels/ main dps and upgrades, 3 = reset phase
runLaunchTime := UnixTime(A_Now)
botLaunchTime := UnixTime(A_Now)
resets = 0

now = 0
relaunching = false

global maxAllCount = 0

lastProgressCheck = 0
skipToReset := false
lastChatRoom := chatRoom

global currentCIndex := [1, 1]
global currentCCoords := [36, 506]
global crusaderPixels := Object()
global crusaderPixelsTemp := Object()
global levelCapPixels := Object()

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
			ShowPause(true)
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
						ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/news_x.png
						if (ErrorLevel = 0) {
							Log("Overlay closed.")
							MouseMove, OutputX + 10, OutputY + 10
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
						if (Output = 0x45D402 or Output = 0x226A01) {
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
				ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/serverfailed.png
				if (ErrorLevel = 0) {
					Log("Server failed error. Relaunching the game.")
					Gosub, Relaunch
				}
				; Upgrade all/max all/max main dps. Final phase until reset phase.
				if (phase = 2) {
					if (lastChatRoom != chatRoom) {
						Gosub, SetChatRoom
					}
					; If mainDPSDelay elapsed between the runLaunchTime and current time, we only max mainDPS until reset phase
					if ((resetType <= 2 or resetType = 5) and skipToReset = false) {
						if (UnixTime(A_Now) - runLaunchTime > (mainDPSDelay * 60)) {
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
						}
					}
					; Max all levels
					maxLevels()
					maxAllCount++
					; If the bot did upgAllUntil max all levels, do one buy all upgrades
					if (maxAllCount >= upgAllUntil) {
						UpgAll()
						maxAllCount = 0
					}
					if (skipToReset = false) {
						; Auto move the mouse to get the gold and quest items for 30 seconds.
						Log("Get the gold and quest items for 30 seconds.")
						now = % UnixTime(A_Now)
						if (clicking = 1) {
							delay := clickDelay / 5
						} else {
							delay = 20 / 5
						}
						while (UnixTime(A_Now) - now <= lootItemsDuration) {
							MouseMove, 910, 320
							Sleep, %delay%
							MouseMove, 860, 320
							if (clicking = 1) {
								click
							}
							Sleep, %delay%
							MouseMove, 810, 320
							Sleep, %delay%
							MouseMove, 760, 320
							Sleep, %delay%
							MouseMove, 710, 320
							Sleep, %delay%
							MouseMove, 660, 320
							Sleep, %delay%
							Send, {Right}
						}
						; If the last time we did an auto progress check is >= than autoProgressCheckDelay, we initiate an auto progress check
						if (resetType = 2 and UnixTime(A_Now) - lastProgressCheck >= autoProgressCheckDelay) {
							; Every autoProgressCheckDelay seconds we take a look if Auto Progress is still activated, if it's not it means we died so achieved the highest zone we could, we have to reset
							lastProgressCheck = % UnixTime(A_Now)
							Log("Auto progress check for max progress.")
							if (CheckAutoProgress() = false) {
								if (UnixTime(A_Now) - runLaunchTime < 60) {
									; Stuck at beginning, might be the formation not active
									Log("Might be stuck at the beginning.")
									send, {%formationKey%}
									Sleep, 100
									Send, {g}
								} else {
									phase = 3
								}
							}
						}
						if (resetType = 3) {
							if (levelCapResetCheck = true) {
								MoveToLastPage()
								Sleep, 500
								PixelGetColor, Output, 872, 594, RGB
								if (Output = 0x7D2E0C) {
									PixelGetColor, Output, 872, 508, RGB
									if (Output = 0x979797) {
										phase = 3
										skipToReset := true
									}
								} else if (Output = 0x979797) {
									phase = 3
									skipToReset := true
								}
							} else {
								MoveToFirstPage()
								PixelGetColor, Output, 242, 508, RGB
								if (Output = 0x979797) {
									Log("Bush is maxed.")
									levelCapResetCheck := true
								}
							}
						}
					}
					if (stormRiderMagnify = 0) {
						useSkill(0)
					} else {
						PixelSearch, OutputX, OutputY, 382, 449, 421, 488, 0x0000FE,, Fast
						if (ErrorLevel != 0) {
							PixelSearch, OutputX, OutputY, 582, 449, 621, 488, 0x0000FE,, Fast
							if (ErrorLevel != 0) {
								Send, {%stormRiderFormationKey%}
								Sleep, 100
								MaxLevels()
								UpgAll()
								PixelGetColor, Output, 390, 466, RGB
								if (Output != 0x3A3A3A) {
									PixelGetColor, Output, 590, 466, RGB
									if (Output != 0x3A3A3A) {
										Send, 2
										Sleep, 25
										Send, 7
										Sleep, 25
									}
								}
							}
						}
						useSkill(1)
						useSkill(3)
						useSkill(4)
						useSkill(5)
						useSkill(6)
						useSkill(8)
					}
				}
				; If runTime time elapsed or phase is set at 3, we reset
				if (((resetType = 5 and UnixTime(A_Now) - runLaunchTime >= runTime) or phase = 3) and resetType != 0) {
					Log("Cannot progress further, time to reset.")
					phase = 1
					MouseMove, 985, 630
					Click
					Sleep, 500
					; Move to reset crusader
					Log("Moving to reset crusader.")
					MoveToFirstPage()
					Sleep, 500
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
						cX := currentCCoords[1] + 9
					}
					Log("Found. Reset inbound.")
					rL = 0
					Loop {
						if (rL >= 5) {
							rL = 0
							MoveToFirstPage()
							Sleep, 500
							MoveToCrusader(resetCrusader)
						}
						MouseMove, cX, cY
						Sleep, 500
						Click
						Sleep, 1000
						Log("Reset warning window.")
						ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/resetwarning.png
						rL++
						if (ErrorLevel = 0) {
							Loop {
								; Reset button
								MouseMove, 407, 516
								Sleep, 500
								Click
								Sleep, 2000
								; Big red button
								Log("Clicking the red button.")
								ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/redbutton.png
								if (ErrorLevel = 0) {
									MouseMove, 509, 546
									Sleep, 500
									Click
									Sleep, 5000
								}
								; Idols screen
								Log("Idols continue screen.")
								ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/idolscontinue.png
								if (ErrorLevel = 0) {
									idolsCount := GetIdolsCount()
									FileAppend, % UnixTime(A_Now) . ":" . idolsCount, stats/idols.txt
									idolsPastDay := 0
									Loop, read, stats/idols.txt
									{
										break := StrSplit(A_LoopReadLine, ":")
										if (UnixTime(A_Now) - break[1] <= 86400) {
											FileAppend, % break[1] . ":" . break[2] . "`n", stats/idols_temp.txt
											idolsPastDay := idolsPastDay + break[2]
										}
									}
									FileDelete, stats/idols.txt
									FileMove, stats/idols_temp.txt, stats/idols.txt
									
									IniRead, idolsAllTime, stats/stats.txt, Idols, alltime
									idolsAllTime += idolsCount
									idolsThisSession += idolsCount
									
									cRunTime := UnixTime(A_Now) - runLaunchTime
									
									IniWrite, % idolsAllTime, stats/stats.txt, Idols, alltime
									IniWrite, % idolsPastDay, stats/stats.txt, Idols, pastday
									IniWrite, % idolsCount, stats/stats.txt, Idols, lastrun
									IniWrite, % cRunTime, Idols, lastruntime
									IniWrite, % idolsThisSession, stats/stats.txt, Idols, thissession
									
									IniWrite, % chestsThisRun, stats/stats.txt, Chests, lastrun
									IniWrite, % cRunTime, stats/stats.txt, Chests, lastruntime
									chestsThisRun = 0
									IniWrite, % chestsThisSession, stats/stats.txt, Chests, thissession
									
									resets++
									
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
		nX := X + W / 2 - 225 / 2 + 2
		Gui, BotGUI: Show, x%nX% y%nY% w227 h35 NoActivate, BotGUI
	}
	IfWinNotExist, Crusaders of The Lost Idols
	{
		if (relaunching = false) {
			Pause,, 1
			ShowPause(1)
			Log("[GUI] Game not found.")
		}
	}
	Return

; Pause key
F8::
	if (phase = -1) {
		phase = 0
		ShowPause(false)
		WinActivate, Crusaders of The Lost Idols
	} else {
		Pause,, 1
	}
	if (phase > 0) {
		if (A_IsPaused) {
			Log("Paused.")
			ShowPause(true)
		} else {
			Log("Unpaused.")
			ShowPause(false)
			WinActivate, Crusaders of The Lost Idols
		}
	}
	Return

; Self-explanatory
ShowPause(status) {
	if (status = false) {
		GuiControl, BotGUI:, BotStatus, images/gui/running.png
	} else {
		GuiControl, BotGUI:, BotStatus, images/gui/paused.png
	}
	Return
}

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
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/start.png
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
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/campaign.png
		if (ErrorLevel = 0) {
			Log("Found the campaign header.")
			SetCampaign(campaign, objective)
			MouseMove, 781, 571
			Sleep, 5000
			Click
			runLaunchTime = % UnixTime(A_Now)
			lastProgressCheck = 0
			maxAllCount = 0
			skipToReset := false
			if (phase = 1) {
				Log("Relaunching CoTLI.")
				Gosub, Relaunch
			}
			Break
		} else {
			Log("Searching for the cog.")
			ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/cog.png
			if (ErrorLevel = 0) {
				Log("Found the cog.")
				Break
			} else {
				Log("Didn't find the cog, looking for left arrow instead.")
				PixelGetColor, Output, 15, 585, RGB
				if (Output = 0x503803) {
					Break
				} else {
					Log("Left arrow not found, looking for the Start button.")
					ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/start.png
					if (ErrorLevel = 0) {
						MouseMove, 498, 540
						Sleep, 500
						Click
					}
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
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/c%c%.png
		if (ErrorLevel = 0) {
			Log("Found the campaign.")
			SetObjective(o, OutputX, OutputY)
			Return
		} else {
			ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/game/campaign_uparrow_active.png
			if (ErrorLevel = 0) {
				upX += 10
				upY += 10
				Loop {
					MouseMove, upX, upY
					Click
					Sleep, 500
					ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/game/campaign_uparrow_inactive.png
					if (ErrorLevel = 0) {
						Break
					}
				}
			}
			ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/game/campaign_uparrow_inactive.png
			ImageSearch, downX, downY, 0, 0, 997, 671, *100 images/game/campaign_downarrow_active.png
			upX += 10
			upY += 10
			downX += 10
			downY += 10
			Loop {
				MouseMove, downX, downY
				Click
				Sleep, 500
				ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/c%c%.png
				if (ErrorLevel = 0) {
					Log("Found the campaign.")
					SetObjective(o, OutputX, OutputY)
					Return
				}
				ImageSearch, downX, downY, 0, 0, 997, 671, *100 images/game/campaign_downarrow_inactive.png
				if (ErrorLevel = 0) {
					Loop {
						MouseMove, upX, upY
						Click
						Sleep, 500
						ImageSearch, upX, upY, 0, 0, 997, 671, *100 images/game/campaign_uparrow_inactive.png
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
	MouseMove, x + 505, y + 85
	Sleep, 500
	Click
	Log("Objective set.")
	Return
}

; Navigate the crusaders bar to find the desired crusader
; c = crusader
MoveToCrusader(c) {
	global currentCCoords
	global crusaders
	apStatus := false
	Log("Auto progress check before moving to crusader.")
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
		Sleep, 200
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
	global resetType
	global phase
	Log("Max all levels.")
	MouseMove, 985, 630
	Click
	Sleep, 100
	i = 0
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
		Send, %s%
	}
	Return
}

; Sets the auto progress to true
SetAutoProgress:
	lastProgressCheck = % UnixTime(A_Now)
	Log("Auto progress check at startup")
	if (CheckAutoProgress() = false) {
		Send, {g}
	}
	Return

; Check if the auto progress is set to true or false
CheckAutoProgress() {
	Loop {
		MouseMove, 317, 111
		Sleep, 100
		Click
		Sleep, 500
		ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/options.png
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
			ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/news_x.png
			Loop {
				ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/news_x.png
				if (ErrorLevel = 0) {
					MouseMove, OutputX + 10, OutputY + 10
					Click
					Sleep, 50
					Break
				}
			}
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

GetLevelCapPixels() {
	ImageSearch, OutputX, OutputY, 240, 548, 335, 575, *100 images/game/lvl.png
	if (ErrorLevel = 0) {
		X := OutputX + 16
		Y := OutputY + 1
		i = 0
		pixels := Object()
		Loop, 28 {
			nX := X + i * 4
			if (i = 7) {
				i = 0
				Y += 2
			}
			PixelGetColor, Output, nX, Y, RGB
			pixels[A_Index] := Output
			i++
		}
	}
	Return, pixels
}

CompareLevelCapPixels() {
	pixelsTemp := GetLevelCapPixels()
	j = 0
	for i, e in pixelsTemp {
		if (pixelsTemp[i] = levelCapPixels[i]) {
			j++
		}
	}
	if (j = pixelsTemp.MaxIndex()) {
		Return, true
	}
	Return, false
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

GetIdolsCount() {
	Loop {
		ImageSearch, lastX, lastY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 images/game/iplus.png
		if (ErrorLevel = 0) {
			idols := null
			lastX += 15
			Loop, 9 {
				i := 0
				Loop, 10 {
					WinActivate, Crusaders of The Lost Idols
					ImageSearch, OutputX, OutputY, lastX, lastY - 5, lastX + 23, lastY + 25, *100 images/game/i%i%.png
					if (ErrorLevel = 0) {
						idols := idols . i
						lastX := OutputX + 8
						Break
					}
					ToolTip,
					i++
					
				}
				if (ErrorLevel = 1) {
					Break
				}
			}
			
		}
		Return, idols
		Sleep, 1000
	}
}

ScanForChests:
	ImageSearch, OutputX, OutputY, 742, 12, 956, 138, *100 images/game/chest1.png
	if (ErrorLevel = 0) {
		FileAppend, % UnixTime(A_Now) . ":S", stats/chests.txt
		chestsPastDay = 0
		Loop, read, stats/chests.txt
		{
			break := StrSplit(A_LoopReadLine, ":")
			if (UnixTime(A_Now) - break[1] <= 86400) {
				FileAppend, % break[1] . ":" . break[2] . "`n", stats/chests_temp.txt
				chestsPastDay++
			}
		}
		chestsThisRun++
		chestsThisSession++
		FileDelete, stats/chests.txt
		FileMove, stats/chests_temp.txt, stats/chests.txt
		IniRead, chestsAllTime, stats/stats.txt, Chests, alltime
		chestsAllTime += 1
		IniWrite, % chestsAllTime, stats/stats.txt, Chests, alltime
		IniWrite, % chestsPastDay, stats/stats.txt, Chests, pastday
		IniWrite, % chestsThisRun, stats/stats.txt, Chests, thisrun
		IniWrite, % chestsThisSession, stats/stats.txt, Chests, thissession
		Sleep, 9000
	}
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

; Rounds a number (n) to d decimals
RoundNumber(n, d) {
	Transform, n, Round, n, d
	e := StrSplit(n, ".")
	if (e[2] != null) {
		e[2] := SubStr(e[2], 1, d)
		n := e[1] . "." . e[2]
	}
	Return, n
}

;				;
;	GUI Labels	;
;				;

ChooseCampaign:
	Gui, Submit, NoHide
	tempCampaign := CampaignChoice
	Return

SetFormationQ:
	GuiControl,, FormationQ, images/gui/bF1_on.png
	GuiControl,, FormationW, images/gui/bF2_off.png
	GuiControl,, FormationE, images/gui/bF3_off.png
	tempFormation = 1
	tempFormationKey = q
	Return
	
SetFormationW:
	GuiControl,, FormationQ, images/gui/bF1_off.png
	GuiControl,, FormationW, images/gui/bF2_on.png
	GuiControl,, FormationE, images/gui/bF3_off.png
	tempFormation = 2
	tempFormationKey = w
	Return

SetFormationE:
	GuiControl,, FormationQ, images/gui/bF1_off.png
	GuiControl,, FormationW, images/gui/bF2_off.png
	GuiControl,, FormationE, images/gui/bF3_on.png
	tempFormation = 3
	tempFormationKey = e
	Return

ChooseMainDPS:
	Gui, Submit, NoHide
	tempMainDPS := MainDPSChoice
	Return

ChooseReset:
	Gui, Submit, NoHide
	tempResetType := ResetChoice
	Return
	
SetClickingOn:
	GuiControl,, ClickingStatusOn, images/gui/bOn_on.png
	GuiControl,, ClickingStatusOff, images/gui/bOff_off.png
	tempClicking = 1
	Return

SetClickingOff:
	GuiControl,, ClickingStatusOn, images/gui/bOn_off.png
	GuiControl,, ClickingStatusOff, images/gui/bOff_on.png
	tempClicking = 0
	Return

ChooseResetCrusader:
	Gui, Submit, NoHide
	tempResetCrusader := ResetCrusader
	Return
	
SetStormRiderFormationQ:
	GuiControl,, StormRiderFormationQ, images/gui/bF1_on.png
	GuiControl,, StormRiderFormationW, images/gui/bF2_off.png
	GuiControl,, StormRiderFormationE, images/gui/bF3_off.png
	GuiControl,, StormRiderFormationD, images/gui/bF0_off.png
	tempStormRiderFormation = 1
	tempStormRiderFormationKey = q
	Return
	
SetStormRiderFormationW:
	GuiControl,, StormRiderFormationQ, images/gui/bF1_off.png
	GuiControl,, StormRiderFormationW, images/gui/bF2_on.png
	GuiControl,, StormRiderFormationE, images/gui/bF3_off.png
	GuiControl,, StormRiderFormationD, images/gui/bF0_off.png
	tempStormRiderFormation = 2
	tempStormRiderFormationKey = w
	Return

SetStormRiderFormationE:
	GuiControl,, StormRiderFormationQ, images/gui/bF1_off.png
	GuiControl,, StormRiderFormationW, images/gui/bF2_off.png
	GuiControl,, StormRiderFormationE, images/gui/bF3_on.png
	GuiControl,, StormRiderFormationD, images/gui/bF0_off.png
	tempStormRiderFormation = 3
	tempStormRiderFormationKey = e
	Return
	
SetStormRiderFormationD:
	GuiControl,, StormRiderFormationQ, images/gui/bF1_off.png
	GuiControl,, StormRiderFormationW, images/gui/bF2_off.png
	GuiControl,, StormRiderFormationE, images/gui/bF3_off.png
	GuiControl,, StormRiderFormationD, images/gui/bF0_on.png
	tempStormRiderFormation := 0
	tempStormRiderFormationKey := formationKey
	Return
	
SetMagnifyOn:
	GuiControl,, MagnifyStatusOn, images/gui/bOn_on.png
	GuiControl,, MagnifyStatusOff, images/gui/bOff_off.png
	tempStormRiderMagnify = 1
	Return

SetMagnifyOff:
	GuiControl,, MagnifyStatusOn, images/gui/bOn_off.png
	GuiControl,, MagnifyStatusOff, images/gui/bOff_on.png
	tempStormRiderMagnify = 0
	Return
	
Help:
	Loop {
		MouseGetPos,,,, OutputVarControl
		help := null
		if (OutputVarControl = "Static2") {
			help = Once the bot max all the levels [VALUE] of times, it will buy all upgrades.`nExample: If the value is 5, after 5 max all levels the bot will upgrade.
		} else if (OutputVarControl = "Static3") {
			help = Delay in seconds in which the bot checks if the auto progress option is on or off. It is used to make progression checks.`nThe lower this value is set, the more frequently the bot will check.
		} else if (OutputVarControl = "Static4") {
			help = Delay in minutes in which the bot will start leveling up the Main DPS while ignoring the other crusaders.
		} else if (OutputVarControl = "Static5") {
			help = The crusader with whom you want to reset.`nThe bot will still try to reset with the other crusaders if it cannot find yours.
		} else if (OutputVarControl = "Static6") {
			help = Chat room to auto join when the bot launches.`nIf you change this setting mid-run the bot will not change the room.
		} else if (OutputVarControl = "Static7") {
			help = Delay in milliseconds between each click in the click & loot phase.`nThis can induce lag.
		} else {
			ToolTip,
			Break
		}
		ToolTip, % help
		Sleep, 100
	}
	Return	

CloseOptions:
	Gosub, CloseAdvancedOptions
	Gui, BotGUIOptions: Hide
	GuiControl, BotGUI:, BOptions, images/gui/bOptions.png
	GuiControl, BotGUIOptions: Choose, CampaignChoice, % campaign
	f1 := "images/gui/bF1_off.png"
	f2 := "images/gui/bF2_off.png"
	f3 := "images/gui/bF3_off.png"
	f%formation% := "images/gui/bF" . formation . "_on.png"
	GuiControl, BotGUIOptions:, FormationQ, % f1
	GuiControl, BotGUIOptions:, FormationW, % f2
	GuiControl, BotGUIOptions:, FormationE, % f3
	GuiControl, BotGUIOptions: ChooseString, MainDPSChoice, % mainDPS
	GuiControl, BotGUIOptions: Choose, ResetChoice, % resetType
	if (clicking = 1) {
		GuiControl, BotGUIOptions:, ClickingStatusOn, images/gui/bOn_on.png
		GuiControl, BotGUIOptions:, ClickingStatusOff, images/gui/bOff_off.png
	} else {
		GuiControl, BotGUIOptions:, ClickingStatusOn, images/gui/bOn_off.png
		GuiControl, BotGUIOptions:, ClickingStatusOff, images/gui/bOff_on.png
	}
	Return

CloseAdvancedOptions:
	Gui, BotGUIAdvancedOptions: Hide
	GuiControl, BotGUIAdvancedOptions:, UpgAllUntil, % upgAllUntil
	GuiControl, BotGUIAdvancedOptions:, AutoProgressCheckDelay, % autoProgressCheckDelay
	GuiControl, BotGUIAdvancedOptions:, MainDPSDelay, % mainDPSDelay
	GuiControl, BotGUIAdvancedOptions: ChooseString, ResetCrusader, % resetCrusader
	GuiControl, BotGUIAdvancedOptions:, ChatRoom, % chatRoom
	GuiControl, BotGUIAdvancedOptions:, ClickDelay, % clickDelay
	GuiControl, BotGUIAdvancedOptions:, RunTime, % runTime
	Return	

CloseStats:
	GuiControl, BotGUI:, BStats, images/gui/bStats.png
	Gui, BotGUIStats: Hide
	Return

CloseAbout:
	GuiControl, BotGUI:, BAbout, images/gui/bAbout.png
	Gui, BotGUIAbout: Hide
	Return

CloseStormRider:
	GuiControl, BotGUI:, BStormRider, images/gui/bStormRider.png
	Gui, BotGUIStormRider: Hide
	f1 := "images/gui/bF1_off.png"
	f2 := "images/gui/bF2_off.png"
	f3 := "images/gui/bF3_off.png"
	f0 := "images/gui/bF0_off.png"
	f%stormRiderFormation% := "images/gui/bF" . stormRiderFormation . "_on.png"
	GuiControl, BotGUIStormRider:, StormRiderFormationQ, % f1
	GuiControl, BotGUIStormRider:, StormRiderFormationW, % f2
	GuiControl, BotGUIStormRider:, StormRiderFormationE, % f3
	GuiControl, BotGUIStormRider:, StormRiderFormationD, % f0
	Return

CloseOtherWindows:
	Gosub, CloseOptions
	Gosub, CloseAdvancedOptions
	Gosub, CloseStormRider
	Gosub, CloseStats
	Gosub, CloseAbout
	Return
	
; Self-explanatory
ApplyAdvancedOptions:
	Gui, Submit, NoHide
	GuiControlGet, upgAllUntil
	GuiControlGet, autoProgressCheckDelay
	GuiControlGet, mainDPSDelay
	lastChatRoom := chatRoom
	GuiControlGet, chatRoom
	GuiControlGet, clickDelay
	GuiControlGet, runTime
	resetCrusader := tempResetCrusader
	Gosub, RewriteSettings
	Gui, BotGUIAdvancedOptions: Hide
	Return
	
ApplyOptions:
	Gui, Submit, NoHide
	campaign := tempCampaign
	formation := tempFormation
	formationKey := tempFormationKey
	mainDPS := tempMainDPS
	resetType := tempResetType
	clicking := tempClicking
	Gosub, RewriteSettings
	GuiControl, BotGUI:, BOptions, images/gui/bOptions.png
	Gui, BotGUIOptions: Hide
	Return
	
ApplyStormRider:
	Gui, Submit, NoHide
	stormRiderFormation := tempStormRiderFormation
	stormRiderFormationKey := tempStormRiderFormationKey
	stormRiderMagnify := tempStormRiderMagnify
	Gosub, RewriteSettings
	GuiControl, BotGUI:, BStormRider, images/gui/bStormRider.png
	Gui, BotGUIStormRider: Hide
	Return	

Options:
	Gosub, CloseOtherWindows
	GuiControl, BotGUI:, BOptions, images/gui/bOptions_active.png
	winW = 252
	winH = 407
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIOptions: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Options
	Return

AdvancedOptions:
	winW = 252
	winH = 477
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/bAdvanced.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X + 30
	nY := Output2Y - 30
	Gui, BotGUIAdvancedOptions: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Advanced Options
	Return

Stats:
	Gosub, CloseOtherWindows
	GuiControl, BotGUI:, BStats, images/gui/bStats_active.png
	winW = 252
	winH = 325
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y  - winH
	Gui, BotGUIStats: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Stats
	Return

About:
	Gosub, CloseOtherWindows
	GuiControl, BotGUI:, BAbout, images/gui/bAbout_active.png
	winW = 252
	winH = 290
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIAbout: Show, x%nX% y%nY% w%winW% h%winH%, idolBot About
	Return

StormRider:
	Gosub, CloseOtherWindows
	GuiControl, BotGUI:, BStormRider, images/gui/bStormRider_active.png
	winW = 182
	winH = 199
	ControlGetPos, OutputX, OutputY, OutputW, OutputH, images/gui/guiMain_bg.png
	WinGetPos, Output2X, Output2Y
	nX := Output2X - ((winW - OutputW) / 2)
	nY := Output2Y - winH
	Gui, BotGUIStormRider: Show, x%nX% y%nY% w%winW% h%winH%, idolBot Storm Rider
	Return
	
; Self-explanatory
LoadSettings:
	Log("Reading settings.")
	IniRead, campaign, settings/settings.ini, Settings, campaign
	IniRead, formation, settings/settings.ini, Settings, formation
	IniRead, mainDPS, settings/settings.ini, Settings, maindps
	IniRead, clicking, settings/settings.ini, Settings, clicking
	IniRead, resetType, settings/settings.ini, Settings, resettype
	IniRead, upgAllUntil, settings/settings.ini, Settings, upgalluntil
	IniRead, autoProgressCheckDelay, settings/settings.ini, Settings, autoprogresscheckdelay
	IniRead, mainDPSDelay, settings/settings.ini, Settings, maindpsdelay
	IniRead, resetCrusader, settings/settings.ini, Settings, resetcrusader
	IniRead, chatRoom, settings/settings.ini, Settings, chatroom
	IniRead, clickDelay, settings/settings.ini, Settings, clickdelay
	IniRead, runTime, settings/settings.ini, Settings, runtime
	IniRead, lootItemsDuration, settings.ini, Settings, lootitemsduration
	IniRead, stormRiderFormation, settings/settings.ini, Settings, stormriderformation
	IniRead, stormRiderMagnify, settings/settings.ini, Settings, stormridermagnify
	if (formation = 1) {
		formationKey = q
	}
	if (formation = 2) {
		formationKey = w
	}
	if (formation = 3) {
		formationKey = e
	}
	if (stormRiderFormation = 1) {
		stormRiderFormationKey = q
	}
	if (stormRiderFormation = 2) {
		stormRiderFormationKey = w
	}
	if (stormRiderFormation = 3) {
		stormRiderFormationKey = e
	}
	if (stormRiderFormation = 0) {
		stormRiderFormationKey = formationKey
	}
	if (lootItemsDuration) {
		lootItemsDuration = 30
	}
	StringLower, mainDPS, mainDPS
	StringLower, resetCrusader, resetCrusader
	tempCampaign := campaign
	tempFormation := formation
	tempFormationKey := formationKey
	tempMainDPS := mainDPS
	tempResetType := resetType
	tempClicking := clicking
	tempUpgAllUntil := upgAllUntil
	tempAutoProgressCheckDelay := autoProgressCheckDelay
	tempMainDPSDelay := mainDPSDelay
	tempResetCrusader := resetCrusader
	tempChatRoom := chatRoom
	tempClickDelay := clickDelay
	tempRunTime := runTime
	tempStormRiderFormation := stormRiderFormation
	tempStormRiderFormationKey := stormRiderFormationKey
	tempStormRiderMagnify := stormRiderMagnify
	Return

; Self-explanatory
RewriteSettings:
	Log("Settings changed.")
	StringLower, mainDPS, mainDPS
	StringLower, resetCrusader, resetCrusader
	IniWrite, % campaign, settings/settings.ini, Settings, campaign
	IniWrite, % formation, settings/settings.ini, Settings, formation
	IniWrite, % mainDPS, settings/settings.ini, Settings, maindps
	IniWrite, % clicking, settings/settings.ini, Settings, clicking
	IniWrite, % resetType, settings/settings.ini, Settings, resettype
	IniWrite, % upgAllUntil, settings/settings.ini, Settings, upgalluntil
	IniWrite, % autoProgressCheckDelay, settings/settings.ini, Settings, autoprogresscheckdelay
	IniWrite, % mainDPSDelay, settings/settings.ini, Settings, maindpsdelay
	IniWrite, % resetCrusader, settings/settings.ini, Settings, resetcrusader
	IniWrite, % chatRoom, settings/settings.ini, Settings, chatroom
	IniWrite, % clickDelay, settings/settings.ini, Settings, clickdelay
	IniWrite, % runTime, settings/settings.ini, Settings, runtime
	IniWrite, % lootItemsDuration, settings/settings.ini, Settings, lootitemsduration
	IniWrite, % stormRiderFormation, settings/settings.ini, Settings, stormriderformation
	IniWrite, % stormRiderMagnify, settings/settings.ini, Settings, stormridermagnify
	Return
	
LoadStats:
	Log("Reading stats.")
	IniRead, idolsAllTime, stats/stats.txt, Idols, alltime
	IniRead, idolsPastDay, stats/stats.txt, Idols, pastday
	IniRead, idolsLastRun, stats/stats.txt, Idols, lastrun
	IniRead, idolsLastRunTime, stats/stats.txt, Idols, lastruntime
	IniRead, idolsThisSession, stats/stats.txt, Idols, thissession
	IniRead, chestsAllTime, stats/stats.txt, Chests, alltime
	IniRead, chestsPastDay, stats/stats.txt, Chests, pastday
	IniRead, chestsLastRun, stats/stats.txt, Chests, lastrun
	IniRead, chestsLastRunTime, stats/stats.txt, Chests, lastruntime
	IniRead, chestsThisSession, stats/stats.txt, Chests, thissession
	Return