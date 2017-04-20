#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

listKeys = |LCTRL|RCTRL|LALT|RALT|LSHIFT|RSHIFT|SPACE|BACKSPACE|DELETE|INSERT|HOME|END|PGUP|PGDN|UP|DOWN|LEFT|RIGHT|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|0|1|2|3|4|5|6|7|8|9|NUMPAD0|NUMPAD1|NUMPAD2|NUMPAD3|NUMPAD4|NUMPAD5|NUMPAD6|NUMPAD7|NUMPAD8|NUMPAD9|NUMPADDOT|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z

__ListKeysRemove(f, k) {
	k = |%k%|
	Return, StrReplace(f, k, "|")
}