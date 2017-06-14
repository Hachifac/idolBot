#NoEnv
SendMode Input

#include lib/guiOptions.ahk
#include lib/guiAdvancedOptions.ahk
#include lib/guiStormRider.ahk
#include lib/guiBuffs.ahk
#include lib/guiStats.ahk
#include lib/guiAbout.ahk
#include lib/guiCurrentLevel.ahk
#include lib/guiDev.ahk

Gui, BotGUI: New, -Caption, idolBot
Gui, Color, 5E1C0D
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Tab2, vguiMainTabs Choose1 w0 h0, 1|2

Gui, Tab, 1
Gui, Add, Picture, x0 y0, images/gui/guiMain_bg.png

Gui, Add, Picture, x77 y5 vbuttonOptions g_GUIOptions, images/gui/BOptions.png
Gui, Add, Picture, x+5 vbuttonStormRider g_GUIStormRider, images/gui/BStormRider.png
Gui, Add, Picture, x+5 vbuttonBuffs g_GUIBuffs, images/gui/BBuffs.png
Gui, Add, Picture, x+5 vbuttonStats g_GUIStats, images/gui/BStats.png
Gui, Add, Picture, x+5 vbuttonAbout g_GUIAbout, images/gui/BAbout.png
Gui, Add, Picture, x+5 vbuttonClose g_BotExit, images/gui/BClose.png

Gui, Tab, 2
Gui, Add, Picture, x0 y0, images/gui/guiMainStats_bg.png

Gui, Add, Text, w170 x82 y9 vguiMainTimeLeft

Gui, Tab
Gui, Add, Picture, x2 y2 vBotStatus, images/gui/paused.png