#NoEnv
SendMode Input

Gui, BotGUIUpdate: New, -Caption, idolBot Update
Gui, Color, 6C2509
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Picture, x0 y0, images/gui/guiUpdate_bg.png
Gui, Add, Picture, x276 y0 g_GUICloseUpdate, images/gui/bClose.png

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Hachifac/idolBot/master/changelog.txt", true)
whr.Send()
whr.WaitForResponse()
changeLog := whr.ResponseText

Gui, Add, Edit, x25 y46 w251 h229 ReadOnly, % changeLog
Gui, Add, Picture, x67 y280 g_GUIUpdateDownload, images/gui/bDownload.png
Gui, Add, Picture, x153 y280 g_GUIUpdateIgnore, images/gui/bIgnore.png