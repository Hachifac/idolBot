#NoEnv
SendMode Input

Gui, BotGUIAdvancedOptions: New, -Caption, idolBot Advanced Options
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui/guiAdvancedOptions_bg.png

Gui, Add, Edit, x15 y65 w180
Gui, Add, UpDown, vUpgAllUntil Range0-2147483647, %upgAllUntil%
Gui, Add, Picture, x+30 yp+4 gHelp, images/gui/bHelp.png

Gui, Add, Edit, x15 y+35 w180
Gui, Add, UpDown, vAutoProgressCheckDelay Range0-2147483647, %autoProgressCheckDelay%
Gui, Add, Picture, x+30 yp+4 gHelp, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32 w180
Gui, Add, UpDown, vMainDPSDelay Range0-2147483647, %mainDPSDelay%
Gui, Add, Picture, x+30 yp+4 gHelp, images/gui/bHelp.png

Gui, Add, DropDownList, x15 y+34 w180 vResetCrusader gChooseResetCrusader, Nate|Rudolph|Kizlblyp
Gui, Add, Picture, x+30 yp+4 gHelp, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32
Gui, Add, UpDown, vChatRoom Range1-10, %chatRoom%
Gui, Add, Picture, x+30 yp+4 gHelp, images/gui/bHelp.png

Gui, Add, Edit, x15 y+32
Gui, Add, UpDown, vClickDelay Range1-2147483647, %clickDelay%
Gui, Add, Picture, x+30 yp+4 gHelp, images/gui/bHelp.png

Gui, Add, Picture, x227 y0 gCloseAdvancedOptions, images/gui/bClose.png

Gui, Add, Picture, x95 y382 gApplyAdvancedOptions, images/gui/bApply.png

GuiControl, ChooseString, ResetCrusader, %resetCrusader%