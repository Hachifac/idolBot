#NoEnv
SendMode Input

Gui, BotGUIStats: New, -Caption, idolBot Stats
Gui, Color, 6F2203
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Tab2, vguiStatsTabs Choose1 w0 h0, 1|2

Gui, Tab, 1
Gui, Add, Picture, x0 y0, images/gui/guiStatsIdols_bg.png

Gui, Add, Text, x20 y97 w217 vguiIdolsLastRun, 0
Gui, Add, Text, y+27 w217 vguiIdolsThisSession, 0
Gui, Add, Text, y+27 w217 vguiIdolsPastDay, 0
Gui, Add, Text, y+27 w217 vguiIdolsAllTime, 0

Gui, Tab, 2
Gui, Add, Picture, x0 y0, images/gui/guiStatsChests_bg.png

Gui, Add, Text, x20 y97 w217 vguiChestsThisRun, 0
Gui, Add, Text, y+27 w217 vguiChestsLastRun, 0
Gui, Add, Text, y+27 w217 vguiChestsThisSession, 0
Gui, Add, Text, y+27 w217 vguiChestsPastDay, 0
Gui, Add, Text, y+27 w217 vguiChestsAllTime, 0

Gui, Tab
Gui, Add, Picture, x7 y42 vguiStatsIdolsTab g_GUIStatsIdolsTab, images/gui/guiStatsIdols_tab_active.png
Gui, Add, Picture, x+2 vguiStatsChestsTab g_GUIStatsChestsTab, images/gui/guiStatsChests_tab_inactive.png
Gui, Add, Picture, x227 y0 g_GUICloseStats, images/gui/bClose.png