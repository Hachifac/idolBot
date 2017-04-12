#NoEnv
SendMode Input

#include lib/guiOptions.ahk
#include lib/guiAdvancedOptions.ahk
#include lib/guiStormRider.ahk
#include lib/guiStats.ahk
#include lib/guiAbout.ahk

Gui, BotGUI: New, -Caption, idolBot
Gui, Color, 913A0D
Gui, Add, Picture, x0 y0, images/gui/guiMain_bg.png
Gui, Font, s12 norm cFFFFFF, Candara

Gui, Add, Picture, x2 y2 vBotStatus, images/gui/paused.png

Gui, Add, Picture, x+2 yp+3 vBOptions gOptions, images/gui/bOptions.png
Gui, Add, Picture, x+5 vBStormRider gStormRider, images/gui/bStormRider.png
Gui, Add, Picture, x+5 vBStats gStats, images/gui/bStats.png
Gui, Add, Picture, x+5 vBAbout gAbout, images/gui/bAbout.png
Gui, Add, Picture, x+5 vBClose gExitBot, images/gui/bClose.png