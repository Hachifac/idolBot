#NoEnv
SendMode Input

Gui, BotGUICurrentLevel: New, +AlwaysOnTop -Caption, idolBot Current Level
Gui, Color, 7F2805
Gui, Font, s12 norm c000000, Candara

Gui, Add, Picture, x0 y0, images/gui/guiCurrentLevel_bg.png

Gui, Add, Edit, x20 y67 w180
Gui, Add, UpDown, vguiCurrentLevel Range1-2147483647, %botCurrentLevel%
Gui, Add, Picture, x79 y109 g_GUIApplyCurrentLevel, images/gui/bApply.png