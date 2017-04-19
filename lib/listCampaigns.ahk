#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

listCampaigns := Object()
listCampaigns[2] := [0, 235, 0, 380]
listCampaigns[3] := [0, 353, 0, 500]
listCampaigns[4] := [0, 471, 0, 610]
listCampaigns[5] := [0, 589, 1, 610]
listCampaigns[6] := [1, 589, 2, 610]
listCampaigns[7] := [2, 589, 3, 610]
listCampaigns[8] := [3, 589, 4, 610]
listCampaigns[9] := [4, 589, 5, 610]