#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

listKeys = |CTRL|ALT|SHIFT|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|

__ListKeysRemove(f, k) {
	k = |%k%|
	Return, StrReplace(f, k, "|")
}