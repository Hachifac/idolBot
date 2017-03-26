#NoEnv
SendMode Input

Gui, BotGUISettings: New, -Caption, CoTLI Bot Settings
Gui, Color, 933506
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui/gui_settings_bg.png

Gui, Add, Edit, x15 y72 w180
Gui, Add, UpDown, vSUpgAllUntil Range0-2147483647, 1
Gui, Add, Picture, x+30 yp+4 gSHelp, images/gui/help.png

Gui, Add, Edit, x15 y124 w180
Gui, Add, UpDown, vSAutoProgressCheckDelay Range0-2147483647
Gui, Add, Picture, x+30 yp+4 gSHelp, images/gui/help.png

Gui, Add, Edit, x15 y176 w180
Gui, Add, UpDown, vSMainDPSDelay Range0-2147483647
Gui, Add, Picture, x+30 yp+4 gSHelp, images/gui/help.png

Gui, Add, DropDownList, x15 y228 w180 vSResetCrusader, Nate|Rudolph|Kizlblyp
Gui, Add, Picture, x+30 yp+4 gSHelp, images/gui/help.png

Gui, Add, Edit, x15 y280
Gui, Add, UpDown, vSChatRoom Range1-10, 1
Gui, Add, Picture, x+30 yp+4 gSHelp, images/gui/help.png

Gui, Add, Edit, x15 y332
Gui, Add, UpDown, vSClickDelay Range1-2147483647, 1
Gui, Add, Picture, x+30 yp+4 gSHelp, images/gui/help.png

Gui, Add, Picture, x227 y0 gCloseSettings, images/gui/close.png

Gui, Add, Picture, x95 y365 gApplySettings, images/gui/apply.png