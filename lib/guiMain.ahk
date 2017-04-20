#NoEnv
SendMode Input

#include lib/guiOptions.ahk
#include lib/guiAdvancedOptions.ahk
#include lib/guiStormRider.ahk
#include lib/guiStats.ahk
#include lib/guiAbout.ahk
#include lib/guiCurrentLevel.ahk
#include lib/guiDev.ahk

Gui, BotGUI: New, -Caption, idolBot
Gui, Color, 913A0D
Gui, Add, Picture, x0 y0, images/gui/guiMain_bg.png
Gui, Font, s12 norm cFFFFFF, Candara

Gui, Add, Picture, x2 y2 vBotStatus, images/gui/paused.png

Gui, Add, Picture, x+2 yp+3 vbuttonOptions g_GUIOptions, images/gui/bOptions.png
Gui, Add, Picture, x+5 vbuttonStormRider g_GUIStormRider, images/gui/bStormRider.png
Gui, Add, Picture, x+5 vbuttonStats g_GUIStats, images/gui/bStats.png
Gui, Add, Picture, x+5 vbuttonAbout g_GUIAbout, images/gui/bAbout.png
Gui, Add, Picture, x+5 vbuttonClose g_BotExit, images/gui/bClose.png