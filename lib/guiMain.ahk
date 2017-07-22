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
Gui, Color, 3D0F03
Gui, Font, s8 norm cE5BF87, Arial

Gui, Add, Tab2, vguiMainTabs Choose1 w0 h0, 1|2

Gui, Tab, 1
Gui, Add, Picture, x0 y0, images/gui/guiMain_bg.png

Gui, Add, Picture, x35 y5 vbuttonOptions g_GUIOptions, images/gui/BOptions.png
Gui, Add, Picture, x+5 vbuttonStormRider g_GUIStormRider, images/gui/BStormRider.png
Gui, Add, Picture, x+5 vbuttonBuffs g_GUIBuffs, images/gui/BBuffs.png
Gui, Add, Picture, x+5 vbuttonStats g_GUIStats, images/gui/BStats.png
Gui, Add, Picture, x+5 vbuttonAbout g_GUIAbout, images/gui/BAbout.png
Gui, Add, Picture, x545 y5 vbuttonClose g_BotExit, images/gui/BClose.png

Gui, Add, Text, w37 x188 y4, Resets:
Gui, Font, cD59739
Gui, Add, Text, w91 x+3 vguiMainStatsResets, --
Gui, Font, cE5BF87
Gui, Add, Text, w58 x188 yp+13, Botting time:
Gui, Font, cD59739
Gui, Add, Text, w70 x+3 vguiMainStatsBottingtime, --

Gui, Font, cE5BF87
Gui, Add, Text, w73 x320 y4, Idols last reset:
Gui, Font, cD59739
Gui, Add, Text, w38 x+3 vguiMainStatsIdolsLastReset, --
Gui, Font, cE5BF87
Gui, Add, Text, w48 x320 yp+13, Idols total:
Gui, Font, cD59739
Gui, Add, Text, w63 x+3 vguiMainStatsIdolsTotal, --

Gui, Font, cE5BF87
Gui, Add, Text, w69 x435 y4, Idols per hour:
Gui, Font, cD59739
Gui, Add, Text, w34 x+3 vguiMainStatsIdolsPerHour, --
Gui, Font, cE5BF87
Gui, Add, Text, w42 x435 yp+13, Reset in:
Gui, Font, cD59739
Gui, Add, Text, w61 x+3 vguiMainStatsResetIn, --

Gui, Add, Picture, x0 y0 vBotStatus, images/gui/paused.png