#NoEnv
SendMode Input

Gui, BotGUIAbout: New, -Caption, idolBot About
Gui, Color, 853213
Gui, Font, s14 norm cE5BF87, System

Gui, Add, Picture, x0 y0, images/gui/guiAbout_bg.png

Gui, Add, Picture, x227 y0 gCloseAbout, images/gui/bClose.png

Gui, Add, Text, x25 y117, %version%