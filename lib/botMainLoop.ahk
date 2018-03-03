; Bot loop
idolBot:
	Gosub, _rotateLogs ;check log size at the start of each run, rotate as necessary
	
	IfWinExist, Crusaders of The Lost Idols
	{
		WinActivate, Crusaders of The Lost Idols
		if (optMoveGameWindow > 0) {
			Gosub, _BotMoveGame
		}
		; Checks to see if the bot is paused. If the bot is paused, loop until it's not.
		if (botPhase = -1) {
			__GUIShowPause(true)
			Loop {
				if (botPhase > -1) {
					Break
				}
			}
		}
		; Campaign selection, the bot will either start a campaign or realize one is already started
		if (botPhase = 0) {
			__Log("Launching bot.")
			now := __UnixTime(A_Now)
			botRunLaunchTime := now
			botLastRelaunch := now
			botLaunchTime := now
			__BotCampaignStart()
			botPhase = 1
		}
		; PHASES 1/2/3
		; Campaign selected/game screen loaded/game running
		if (botPhase > 0) {
			__Log("Bot launched.")
			; We look for overlays throughout phase 1 & 2
			attempt = 0
			Loop {
				WinActivate, Crusaders of The Lost Idols
				if (botPhase = 1 or botPhase = 2) {
					Gosub, _BotCloseWindows
				}
				; PHASE 1. 
				if (botPhase = 1) {
					Sleep, 1000 * optBotClockSpeed
					attempt++
					if (attempt > 2 and optCampaign = 1) {
						attempt = 0
						__Log("Event FP not available.  Trying the backup campaign.")
						__BotCampaignStart(optBackupCampaign)
					}
					if (attempt > 5) {
						attempt = 0
						__BotCampaignStart()
						MouseMove, 740, 480
						Click
					}
					botRelaunching := false
					MouseMove, 550, 50
					__Log("Waiting for the campaign to load.")
					; We look at the left arrow in the crusaders bar, if it's there it means the screen is fully loaded
					PixelGetColor, OutputC, 15, 585, RGB
					if (OutputC = 0xA07107 or OutputC = 0xFFB103) {
						__Log("Campaign loaded.")
						; If the left arrow is gold, it means we're not at the beginning of the characters bar, we're moving back until we detect 
						; the gold color
						if (Output != 0xA07107) {
							__Log("Moving the characters bar to the beginning.")
							__BotMoveToFirstPage()
						}
						Gosub, _BotUseBuffs
						; Open options window to see if auto progress is on
						__Log("Initial auto progress check...")
						if (optResetType = 2 or optAutoProgressCheck = 1 or optAutoProgress = 2) {
							__BotSetAutoProgress(true)
						} else {
							__BotSetAutoProgress(false)
						}
						skipJim := __UnixTime(A_Now)
						__Log("Looking for Jim's status.")
						Loop {
							; We look at Jim's buy button to know if we can select the formation
							PixelGetColor, Output, 244, 595, RGB
							; If it's not green, we first look if the right arrow is gold, if it is it means the game already started long ago
							; and Jim is probably maxed, meaning we need to put the formation in right now
							; then we click the monsters until we get some cash to initiate the formation
							; If it's green, in a few seconds the bot will max all levels and some crusaders will get in formation, 
							; eventually the formation set will kick in
							if (Output != 0x45D402) {
								; Auto click until Jim lvl up button turns green
								if (__UnixTime(A_Now) - skipJim > 60) {
									__Log("Skipping Jim.")
									botSkipJim := true
									Break
								}
								MouseMove, 695, 325
								Click
								Sleep, 40
								MouseMove, 750, 325
								Click
								Sleep, 40
							} else {
								Break
							}
							if (botSkipJim) {
								Break
							}
						}
						; We look at Jim's buy button one last time, if it's green we're good to go to phase 2
						PixelGetColor, Output, 244, 595, RGB
						if (Output = 0x45D402 or Output = 0x226A01 or botSkipJim = true) {
							botPhase = 2
						}
						; Press space bar to close the events/sales tabs
						Send, {Space}
						Gosub, _BotMaxLevels
						__BotSetFormation(optFormation)
						botMaxAllCount++
						botFirstCycle := true
						botCurrentLevelLastTimeout := __UnixTime(A_Now)
						if (optRelaunchGame = 1 and optRelaunchGameFrequency = 1 and botResets > 0) {
							__Log("Relaunching CoTLI.")
							Sleep, 2500
							Gosub, _BotRelaunch
						}
						; Set Chat Room to optChatRoom, but only if we've just started or relaunched
						if (optChatRoom > 0 and (botSession = 0 or botRelaunched = true)) {
							__Log("Setting chat room to " . optChatRoom . ".")
							botRelaunched := false
							Gosub, _BotSetChatRoom
						}
						if (optCheatEngine = 1) {
							Gosub, _BotCEOn
						}
					}
				}
				; TODO - maybe relocate this serverfailed check, as part of refactor?
				; Sometimes we get a server failed error, shit happens. We search for it and if it pops up, we relaunch the game.
				ImageSearch, OutputX, OutputY, 0, 0, 997, 671, *100 images/game/serverfailed.png
				if (ErrorLevel = 0) {
					__Log("Server failed error. Relaunching the game.")
					Gosub, _BotRelaunch
					if (optCheatEngine = 1) {
						Gosub, _BotCEOn
					}
				}
				; Phase 2.  Upgrade all/max all/max main dps. Final phase until reset phase.
				if (botPhase = 2 or botDelayReset = true) {
					; set time on first loop only
					if (botCurrentCycleLoop = 0) {
						botCurrentCycleTime := __UnixTime(A_Now)
					}
					; set variable to note we're beyond loop init
					if (botSession = 0) {
						botSession = 1
					}
					; set chatroom if it's not right, or if we just relaunched the bot
					if (optChatRoom > 0 and (optLastChatRoom != optChatRoom or botRelaunched = true)) {
						botRelaunched := false
						Gosub, _BotSetChatRoom
					}
					; move to the crusaders select tab, click it to be sure we're looking at crusader list
					MouseMove, 740, 480
					Sleep, 100 * optBotClockSpeed
					Click
					
					; move to phase 3 and reset if we're stuck on the same level for longer than timeout setting
					if (optSameLevelTimeout = 1 and botCurrentLevelTimeout > optSameLevelTimeoutDelay and botTrackCurrentLevel = true) {
						__Log("Same level timeout.")
						botPhase = 3
						botSkipToReset := true
					}
					
					if (botSkipToReset = false) {
						if ((botCycles[botCurrentCycle].loop = "" or botCycles[botCurrentCycle].loop = 0) and (botCycles[botCurrentCycle].duration = "" or botCycles[botCurrentCycle].duration = 0) and (botCycles[botCurrentCycle].level = "" or botCycles[botCurrentCycle].level = 0)) {
							botCurrentCycleLoop = 0
						}
						if (botCycles[botCurrentCycle].level = "" or botCycles[botCurrentCycle].level > botCurrentLevel) {
							if (botCycles[botCurrentCycle].duration = "" or (__UnixTime(A_Now) - botCurrentCycleTime < botCycles[botCurrentCycle].duration)) {
								if (botCycles[botCurrentCycle].loop = "" or botCurrentCycleLoop < botCycles[botCurrentCycle].loop) {
									for cL in botCycles[botCurrentCycle].cyclesList {
										if (botSkipToReset = true) {
											Break
										}
										if (StrLen(botCycles[botCurrentCycle].cyclesList[cL]) > 1) {
											if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)PickGold\(([\d]+)\)", f)) {
												__BotPickGold(f.1)
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)PickGold", f)) {
												__BotPickGold(optLootItemsDuration)
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)MaxLevels", f)) {
												Gosub, _BotMaxLevels
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)UpgradeAll", f)) {
												Gosub, _BotUpgAll
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)MaxAll", f)) {
												Gosub, _BotMaxAll
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)LevelCrusader\(([\d|\w]+)\)", f)) {
												__BotLevelCrusader(f.1)
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)LevelMainDPS", f)) {
												if (__UnixTime(A_Now) - botRunLaunchTime > (optMainDPSDelay * 60) and optMainDPS != "None") {
													__BotLevelCrusader(optMainDPS)
												}
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)SetFormation\(([\d]+)\)", f)) {
												__BotSetFormation(f.1)
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)SetFormation", f)) {
												__BotSetFormation(optFormation)
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)Wait\(([\d]+)\)", f)) {
												Sleep, % f.1 * 1000 * optBotClockSpeed
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)UseSkill\(([\d]+)\)", f)) {
												__BotUseSkill(f.1)
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)UseSkills", f)) {
												Gosub, __BotUseSkills
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)UseBuffs", f)) {
												Gosub, _BotUseBuffs
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)CheatEngineOn", f)) {
												Gosub, _BotCEOn
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)CheatEngineOff", f)) {
												Gosub, _BotCEOff
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)ClickingOn", f)) {
												optTempClicking = 1
											} else if (RegExMatch(botCycles[botCurrentCycle].cyclesList[cL], "iO)ClickingOff", f)) {
												optTempClicking = 0
											}
										}
									}
									botCurrentCycleLoop++
								} else {
									__Log("Next cycle.")
									botCurrentCycle++
									botCurrentCycleLoop = 0
								}
							} else {
								__Log("Next cycle.")
								botCurrentCycle++
								botCurrentCycleLoop = 0
							}
						} else {
							__Log("Next cycle.")
							botCurrentCycle++
							botCurrentCycleLoop = 0
						}
					}

						
					; If the last time we did an auto progress check is >= than autoProgressCheckDelay, we initiate an auto progress check
					if ((optResetType = 2 or optAutoProgressCheck = 1) and __UnixTime(A_Now) - lastProgressCheck >= optAutoProgressCheckDelay) {
						; Every autoProgressCheckDelay seconds we take a look if Auto Progress is still activated, if it's not it means we died so 
						; achieved the highest zone we could, we have to reset
						lastProgressCheck = % __UnixTime(A_Now)
						__Log("Auto progress check for max progress.")
						if (__BotCheckAutoProgress() = false) {
							if (__UnixTime(A_Now) - botRunLaunchTime < optResetGracePeriod) {
								; Stuck at beginning, might be the formation not active
								__Log("Might be stuck at the beginning.")
								__BotSetFormation(optFormation)
								Sleep, 100 * optBotClockSpeed
								Send, {g}
							} else {
								botPhase = 3
							}
						}
					}
						
					if (optResetType = 3 and __UnixTime(A_Now) - botRunLaunchTime >= (optRunTime * 60)) {
						botSkipToReset := true
						botPhase = 3
					}
					
					if (optResetType = 4) {
						if (botCurrentLevel >= optResetOnLevel) {
							__Log("Level " . optResetOnLevel . " reached.")
							botSkipToReset := true
							botPhase = 3
						}
					}
				}
				; If optRunTime time elapsed or phase is set at 3, we reset
				if (botPhase = 3 and optResetType > 1) {
					if (botCheatEngine = true) {
						Gosub, _BotCEOff
					}
					botDelayReset := false
					resetPhase = 0
					__Log("Cannot progress further, time to reset.")
					; Move to reset crusader
					if (resetPhase = 0) {
						if (optTakeScreenshot = 1){
							__Log("Starting screenshot process.")
							Runwait, screenshot.exe
							__Log("Screenshot process done")
						}
						; check if we're using chests, then set phase to 1, then max levels
						if (optUseChests = 1) {
							__Log("Using chests before reset.")
							MouseMove, 795, 480
							Sleep, 25 * optBotClockSpeed
							Click
							Sleep, 500 * optBotClockSpeed
							MouseMove, 160, 555
							Sleep, 25 * optBotClockSpeed
							Click
							chestFound := false
							Loop {
								if (chestFound == true) {
									Break
								}
								Sleep, 1000 * optBotClockSpeed
								Loop {
									ImageSearch, OutputX, OutputY, 0, 505, 1000, 675, *100 images/game/chests_reset.png
									if (ErrorLevel = 0) {
										Sleep, 100 * optBotClockSpeed
										ImageSearch, OutputX2, OutputY2, 0, 505, 1000, 675, *100 images/game/chests_reset.png
										if (ErrorLevel = 0) {
											if (OutputX2 = OutputX and OutputY2 = OutputY) {
												__Log("Found the chests.")
												Break
											} else {
												if (A_Index > 9) {
													__Log("Cannot find the chests. It seems unstable.")
													Break
												}
											}
										}
									} else {
										if (A_Index > 9) {
											__Log("Cannot find the chests.")
											Break
										}
									}
									Sleep, 1000 * optBotClockSpeed
								}
								Loop {
									ImageSearch, OutputX, OutputY, OutputX - 50, OutputY, OutputX, OutputY + 75, *100 images/game/chests_reset_x%optUseChestsAmount%.png
									if (ErrorLevel = 0) {
										__Log("Using " . optUseChestsAmount . " chests.")
										MouseMove, OutputX + 5, OutputY + 5
										Sleep, 100 * optBotClockSpeed
										Click
										Break
									} else {
										__Log("Cannot open " . optUseChestsAmount . " chests.")
										Break
									}
								}
								Loop {
									Sleep, 1000 * optBotClockSpeed
									ImageSearch, OutputX, OutputY, 345, 345, 495, 385, *100 images/game/chests_reset_yes.png
									if (ErrorLevel = 0) {
										ImageSearch, OutputX, OutputY, 345, 345, 495, 385, *100 images/game/chests_reset_yes.png
										if (ErrorLevel = 0) {
											__Log("Yes button found.")
											MouseMove, OutputX + 5, OutputY + 5
											Sleep, 100 * optBotClockSpeed
											Click
											Break
										}
									} else {
										if (A_Index > 9) {
											__Log("Cannot find the yes button.")
											Break
										}
									}
								}
								Loop {
									Sleep, 500 * optBotClockSpeed
									ImageSearch, OutputX, OutputY, 415, 20, 505, 55, *100 images/game/chest_loot.png
									if (ErrorLevel = 0) {
										__Log("Chests opening window.")
										Loop {
											if (chestFound == true) {
												Break
											}
											MouseMove, 135, 40
											Sleep, 500 * optBotClockSpeed
											ImageSearch, OutputX, OutputY, 885, 5, 930, 45, *100 images/game/close.png
											if (ErrorLevel = 0) {
												MouseMove, OutputX + 5, OutputY + 5
												Sleep, 100 * optBotClockSpeed
												Click
												Loop {
													Sleep, 500 * optBotClockSpeed
													ImageSearch, OutputX, OutputY, 905, 605, 985, 650, *100 images/game/chests_reset_close.png
													if (ErrorLevel = 0) {
														Sleep, 500 * optBotClockSpeed
														ImageSearch, OutputX, OutputY, 905, 605, 985, 650, *100 images/game/chests_reset_close.png
														if (ErrorLevel = 0) {
															__Log("Closing the chests window.")
															MouseMove, OutputX + 5, OutputY + 5
															Sleep, 100 * optBotClockSpeed
															Click
															Sleep, 1000 * optBotClockSpeed
															ImageSearch, OutputX, OutputY, 298, 90, 340, 130, *150 images/game/cog.png
															if (ErrorLevel = 0) {
																MouseMove, 740, 480
																Sleep, 100 * optBotClockSpeed
																Click
																Sleep, 500 * optBotClockSpeed
																chestFound := true
																Break
															} else {
																__Log("Still in the chests window.")
															}
														} else {
															if (A_Index > 9) {
																__Log("Cannot find the close button.")
																Break
															}
														}
													} else {
														if (A_Index > 9) {
															__Log("Cannot find the close button.")
															Break
														}
													}
													Break
												}
											}
										}
									} else {
										if (A_Index > 9) {
											__Log("Couldn't find the chests window.")
											Break
										}
									}
								}
							}
							if (chestFound == false) {
								__Log("Couln't find the chests.")
								MouseMove, 940, 630
								Click
								Sleep, 500 * optBotClockSpeed
								MouseMove, 740, 480
								Click
								Sleep, 500 * optBotClockSpeed
							}
						}
						resetPhase = 1
						Gosub, _BotMaxLevels
					}
					; start of resetPhase 1 below. resetPhase 1 is finding the reset crusader and then clicking the reset button
					if (resetPhase = 1) {
						resetAttempt = 0
						; stops auto-progress if it somehow was turned back on, then move to Nates slot 
						Loop {
							Click
							__Log("Moving to reset crusader.")
							if (optAutoProgress = 1) {
								__BotSetAutoProgress(false)
								Sleep, 2000
							}
							__BotMoveToFirstPage()
							Sleep, 500 * optBotClockSpeed
							__BotMoveToCrusader("nate")
							Sleep, 2000 * optBotClockSpeed
							Break
						}
						; check if the reset window is up. If it's not, click on three buttons that might have the reset the world button
						; increment the reset attempt flag, then search for the reset window. If we find it, set reset phase flag to 2, 
						; and break out of the loop, otherwise try again. if it fails 10 times, log the failure. 
						Loop {
							__Log("Waiting for the reset warning window.")
							ImageSearch, OutputRWX, OutputRWY, 281, 116, 717, 235, *100 images/game/resetwarning.png
							if (ErrorLevel = 0) {
								__Log("Reset warning window found.")
								resetPhase = 2
								Break
							} else {
								MouseMove, 675, 650
								Sleep, 100 * optBotClockSpeed
								Click
								Sleep, 100 * optBotClockSpeed
								MouseMove, 760, 650
								Sleep, 100 * optBotClockSpeed
								Click
								MouseMove, 815, 650
								Sleep, 100 * optBotClockSpeed
								Click
								Sleep, 1000
								resetAttempt++
							}
							if (resetAttempt > 10) {
								__Log("Failed attempt.")
								Break
							}
						}
					}
					; start of resetPhase 2 below. phase 2 is waiting / clicking on the big red button
					if (resetPhase = 2) {
						resetPhase = 3
						failedReset := false
						Loop { 
						; search for the button. Break out of the loop if we find it. Otherwise, search for the reset
						; warning. If we find it, click it. If we don't, search for the failed reset warning. If we find it
						; relaunch and try again. 
						; !! note: some commented code here for future testing on safety checking. Might end up culled. 
						; !! noted with !! 
							; !! phase3ResetAttempts = 0
							__Log("Waiting for the big red button.") ; search for the button
							ImageSearch, OutputRB, OutputRB, 439, 479, 671, 601, *100 images/game/redbutton.png
							if (ErrorLevel = 0) { ; found the button, break out of the loop
								__Log("Clicking the red button.")
								Break
							} else {			
								; Reset button
								ImageSearch, OutputRWX, OutputRWY, 281, 116, 717, 235, *100 images/game/resetwarning.png
								if (ErrorLevel = 0) {
									MouseMove, 375, 525 ; changed from 426, 528 to avoid opening crafing menu if window isn't actually open
									Sleep, 500 * optBotClockSpeed
									Click
									Sleep, 500 * optBotClockSpeed
								}
								ImageSearch,,, 287, 242, 472, 289, *100 images/game/failedreset.png
								if (ErrorLevel = 0) {
									__Log("Failed reset. Relaunching.")
									failedReset := true
									Gosub, _BotRelaunch
									Break
								}
							}
							; !! phase3ResetAttempts++
							Sleep, 1000
							; !! if (phase3ResetAttempts = 10) {
								; !! __Log("We've failed 10 times to find the button or the reset button. Resetting and trying again.")
								; !! Send, {Esc}
								; !! resetPhase = 1
								; !! Break
							; !! }
						}
						if (failedReset = false) {
							Loop {
								ImageSearch, OutputIS, OutputIS, 439, 479, 671, 601, *100 images/game/idolscontinue.png
								if (ErrorLevel = 0) {
									__Log("Calculating the idols.")
									idolsCount := __BotGetIdolsCount()
									FileAppend, % __UnixTime(A_Now) . ":" . idolsCount, stats/idols.txt
									statsIdolsPastDay := 0
									Loop, read, stats/idols.txt
									{
										break := StrSplit(A_LoopReadLine, ":")
										if (__UnixTime(A_Now) - break[1] <= 86400) {
											FileAppend, % break[1] . ":" . break[2] . "`n", stats/idols_temp.txt
											statsIdolsPastDay := statsIdolsPastDay + break[2]
										}
									}
									FileDelete, stats/idols.txt
									FileMove, stats/idols_temp.txt, stats/idols.txt
									
									IniRead, statsIdolsAllTime, stats/stats.txt, Idols, alltime, 0
									statsIdolsAllTime += idolsCount
									statsIdolsThisSession += idolsCount
									
									statsRunTime := __UnixTime(A_Now) - botRunLaunchTime
									
									IniWrite, % statsIdolsAllTime, stats/stats.txt, Idols, alltime
									IniWrite, % statsIdolsPastDay, stats/stats.txt, Idols, pastday
									IniWrite, % idolsCount, stats/stats.txt, Idols, lastrun
									IniWrite, % statsRunTime, stats/stats.txt, Idols, lastruntime
									
									IniWrite, % statsChestsThisRun, stats/stats.txt, Chests, lastrun
									IniWrite, % statsRunTime, stats/stats.txt, Chests, lastruntime
									statsChestsThisRun = 0
									
									botLevelCurrentCursor = 0
									botLevelPreviousCursor = 0
									botCurrentLevel = 0
									botResets++
									
									botCurrentCycle = 1
									botCurrentCycleLoop = 0
									botCurrentCycleTime = 0
									botCurrentLevelTimeout = 0
									
									if (botResets = 1) {
										statsIdolsFirstReset := idolsCount
										botRunTimeFirstReset := statsRunTime
									}
									
									if (botResets > 1) {
										GuiControl, BotGUI:, guiMainStatsIdolsPerHour, % Round((statsIdolsThisSession - statsIdolsFirstReset) / (__UnixTime(A_Now) - botLaunchTime - botRunTimeFirstReset) * 60 * 60)
									}
									
									bI = 1
									Loop, % botBuffs.length() {
										Loop, % botBuffsRarity.length() {
											bB := botBuffs[bI]
											bR := botBuffsRarity[A_Index]
											botBuffs%bB%%bR%Timer := 0
										}
										bI++
									}
									
									MouseMove, 507, 550
									Sleep, 500 * optBotClockSpeed
									Click
									Sleep, 500 * optBotClockSpeed
									Break
								} else {
									MouseMove, 210, 95
									Sleep, 500 * optBotClockSpeed
									Click
									Sleep, 500 * optBotClockSpeed
								}
							}
						}
					}
					if (resetPhase = 3) {
						__Log("Start a new campaign.")
						__BotCampaignStart()
						botSkipJim := false
						botPhase = 1
						Gosub, _BotTimers
						Sleep, 100 * optBotClockSpeed
					}
				}
				if (optRelaunchGame = 1 and optRelaunchGameFrequency > 1) {
					if ((__UnixTime(A_Now) - botLastRelaunch) / 60 >= (optRelaunchGameFrequency - 1) * 60) {
						__Log((optRelaunchGameFrequency - 1) * 60 . " minutes elapsed. Time to reset.")
						Gosub, _BotRelaunch
						if (botCheatEngine = true) {
							Gosub, _BotCEOn
						}
					}
				}
			}
		}
	}
	IfWinNotExist, Crusaders of The Lost Idols
	{
		__Log("Game not found.")
	}
	Return
