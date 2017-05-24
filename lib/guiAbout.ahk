#NoEnv
SendMode Input

Gui, BotGUIAbout: New, -Caption, idolBot About
Gui, Color, 853213
Gui, Font, s11 norm cE5BF87, Tahoma

Gui, Add, Picture, x0 y0, images/gui/guiAbout_bg.png

Gui, Add, Picture, x227 y0 g_GUICloseAbout, images/gui/bClose.png

Gui, Add, Text, x25 y222, %version%