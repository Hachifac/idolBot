#NoEnv
SendMode Input

Gui, BotGUIDev: New, -Caption, idolBot Dev
Gui, Color, 6C2509
Gui, Font, s8 norm cFFFFFF, Arial

if (optDevLogging = 1) {
	loggingStatus := "images/gui/bLoggingOn.png"
} else {
	loggingStatus := "images/gui/bLoggingOff.png"
}

Gui, Add, Picture, x0 y0, images/gui/guiDevConsole_bg.png

Gui, Add, Picture, x108 y43 vguiDevLoggingStatus g_GUIDevLogging, % loggingStatus
Gui, Add, Edit, x15 y79 w270 h581 vguiDevLogs ReadOnly
