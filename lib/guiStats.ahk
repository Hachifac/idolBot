#NoEnv
SendMode Input

Gui, BotGUIStats: New, -Caption, idolBot Stats
Gui, Color, 6C2509
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Picture, x0 y0, images/gui/guiStats_bg.png

Gui, Add, Picture, x227 y0 g_GUICloseStats, images/gui/bClose.png

Gui, Add, Text, x42 y66 w110 vguiIdolsLastRun, 0
Gui, Add, Text, y+9 w110 vguiIdolsThisSession, 0
Gui, Add, Text, y+9 w110 vguiIdolsPastDay, 0
Gui, Add, Text, y+9 w110 vguiIdolsAllTime, 0
Gui, Add, Text, y+37 w110 vguiChestsThisRun, 0
Gui, Add, Text, y+9 w110 vguiChestsLastRun, 0
Gui, Add, Text, y+9 w110 vguiChestsThisSession, 0
Gui, Add, Text, y+9 w110 vguiChestsPastDay, 0
Gui, Add, Text, y+9 w110 vguiChestsAllTime, 0