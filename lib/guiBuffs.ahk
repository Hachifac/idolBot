#NoEnv
SendMode Input

Gui, BotGUIBuffs: New, -Caption, idolBot Buffs
Gui, Color, 7F2805
Gui, Font, s12 norm c000000, Candara

Gui, Add, Tab2, vguiBuffsTabs Choose1 w0 h0, 1|2|3|4|5|6

Gui, Tab, 1
Gui, Add, Picture, x0 y0, images/gui/guiBuffsGold_bg.png

guiBuffsGoldCStatusB = off
if (optBuffsGoldC = 1) {
	guiBuffsGoldCStatusB = on
}
guiBuffsGoldUStatusB = off
if (optBuffsGoldU = 1) {
	guiBuffsGoldUStatusB = on
}
guiBuffsGoldRStatusB = off
if (optBuffsGoldR = 1) {
	guiBuffsGoldRStatusB = on
}
guiBuffsGoldEStatusB = off
if (optBuffsGoldE = 1) {
	guiBuffsGoldEStatusB = on
}

Gui, Add, Picture, x61 y101 vguiBuffsGoldCStatus g_GUISetBuffsGoldCOn, images/gui/bUse_%guiBuffsGoldCStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsGoldCInterval Range0-480, %optBuffsGoldCInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsGoldUStatus g_GUISetBuffsGoldUOn, images/gui/bUse_%guiBuffsGoldUStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsGoldUInterval Range0-480, %optBuffsGoldUInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsGoldRStatus g_GUISetBuffsGoldROn, images/gui/bUse_%guiBuffsGoldRStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsGoldRInterval Range0-480, %optBuffsGoldRInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsGoldEStatus g_GUISetBuffsGoldEOn, images/gui/bUse_%guiBuffsGoldEStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsGoldEInterval Range0-480, %optBuffsGoldEInterval%

Gui, Tab, 2
Gui, Add, Picture, x0 y0, images/gui/guiBuffsPower_bg.png

guiBuffsPowerCStatusB = off
if (optBuffsPowerC = 1) {
	guiBuffsPowerCStatusB = on
}
guiBuffsPowerUStatusB = off
if (optBuffsPowerU = 1) {
	guiBuffsPowerUStatusB = on
}
guiBuffsPowerRStatusB = off
if (optBuffsPowerR = 1) {
	guiBuffsPowerRStatusB = on
}
guiBuffsPowerEStatusB = off
if (optBuffsPowerE = 1) {
	guiBuffsPowerEStatusB = on
}

Gui, Add, Picture, x61 y101 vguiBuffsPowerCStatus g_GUISetBuffsPowerCOn, images/gui/bUse_%guiBuffsPowerCStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsPowerCInterval Range0-480, %optBuffsPowerCInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsPowerUStatus g_GUISetBuffsPowerUOn, images/gui/bUse_%guiBuffsPowerUStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsPowerUInterval Range0-480, %optBuffsPowerUInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsPowerRStatus g_GUISetBuffsPowerROn, images/gui/bUse_%guiBuffsPowerRStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsPowerRInterval Range0-480, %optBuffsPowerRInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsPowerEStatus g_GUISetBuffsPowerEOn, images/gui/bUse_%guiBuffsPowerEStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsPowerEInterval Range0-480, %optBuffsPowerEInterval%

Gui, Tab, 3
Gui, Add, Picture, x0 y0, images/gui/guiBuffsSpeed_bg.png

guiBuffsSpeedCStatusB = off
if (optBuffsSpeedC = 1) {
	guiBuffsSpeedCStatusB = on
}
guiBuffsSpeedUStatusB = off
if (optBuffsSpeedU = 1) {
	guiBuffsSpeedUStatusB = on
}
guiBuffsSpeedRStatusB = off
if (optBuffsSpeedR = 1) {
	guiBuffsSpeedRStatusB = on
}
guiBuffsSpeedEStatusB = off
if (optBuffsSpeedE = 1) {
	guiBuffsSpeedEStatusB = on
}

Gui, Add, Picture, x61 y101 vguiBuffsSpeedCStatus g_GUISetBuffsSpeedCOn, images/gui/bUse_%guiBuffsSpeedCStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSpeedCInterval Range0-480, %optBuffsSpeedCInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsSpeedUStatus g_GUISetBuffsSpeedUOn, images/gui/bUse_%guiBuffsSpeedUStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSpeedUInterval Range0-480, %optBuffsSpeedUInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsSpeedRStatus g_GUISetBuffsSpeedROn, images/gui/bUse_%guiBuffsSpeedRStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSpeedRInterval Range0-480, %optBuffsSpeedRInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsSpeedEStatus g_GUISetBuffsSpeedEOn, images/gui/bUse_%guiBuffsSpeedEStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSpeedEInterval Range0-480, %optBuffsSpeedEInterval%

Gui, Tab, 4
Gui, Add, Picture, x0 y0, images/gui/guiBuffsCrit_bg.png

guiBuffsCritCStatusB = off
if (optBuffsCritC = 1) {
	guiBuffsCritCStatusB = on
}
guiBuffsCritUStatusB = off
if (optBuffsCritU = 1) {
	guiBuffsCritUStatusB = on
}
guiBuffsCritRStatusB = off
if (optBuffsCritR = 1) {
	guiBuffsCritRStatusB = on
}
guiBuffsCritEStatusB = off
if (optBuffsCritE = 1) {
	guiBuffsCritEStatusB = on
}

Gui, Add, Picture, x61 y101 vguiBuffsCritCStatus g_GUISetBuffsCritCOn, images/gui/bUse_%guiBuffsCritCStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsCritCInterval Range0-480, %optBuffsCritCInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsCritUStatus g_GUISetBuffsCritUOn, images/gui/bUse_%guiBuffsCritUStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsCritUInterval Range0-480, %optBuffsCritUInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsCritRStatus g_GUISetBuffsCritROn, images/gui/bUse_%guiBuffsCritRStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsCritRInterval Range0-480, %optBuffsCritRInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsCritEStatus g_GUISetBuffsCritEOn, images/gui/bUse_%guiBuffsCritEStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsCritEInterval Range0-480, %optBuffsCritEInterval%

Gui, Tab, 5
Gui, Add, Picture, x0 y0, images/gui/guiBuffsClick_bg.png

guiBuffsClickCStatusB = off
if (optBuffsClickC = 1) {
	guiBuffsClickCStatusB = on
}
guiBuffsClickUStatusB = off
if (optBuffsClickU = 1) {
	guiBuffsClickUStatusB = on
}
guiBuffsClickRStatusB = off
if (optBuffsClickR = 1) {
	guiBuffsClickRStatusB = on
}
guiBuffsClickEStatusB = off
if (optBuffsClickE = 1) {
	guiBuffsClickEStatusB = on
}

Gui, Add, Picture, x61 y101 vguiBuffsClickCStatus g_GUISetBuffsClickCOn, images/gui/bUse_%guiBuffsClickCStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsClickCInterval Range0-480, %optBuffsClickCInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsClickUStatus g_GUISetBuffsClickUOn, images/gui/bUse_%guiBuffsClickUStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsClickUInterval Range0-480, %optBuffsClickUInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsClickRStatus g_GUISetBuffsClickROn, images/gui/bUse_%guiBuffsClickRStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsClickRInterval Range0-480, %optBuffsClickRInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsClickEStatus g_GUISetBuffsClickEOn, images/gui/bUse_%guiBuffsClickEStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsClickEInterval Range0-480, %optBuffsClickEInterval%

Gui, Tab, 6
Gui, Add, Picture, x0 y0, images/gui/guiBuffsSplash_bg.png

guiBuffsSplashCStatusB = off
if (optBuffsSplashC = 1) {
	guiBuffsSplashCStatusB = on
}
guiBuffsSplashUStatusB = off
if (optBuffsSplashU = 1) {
	guiBuffsSplashUStatusB = on
}
guiBuffsSplashRStatusB = off
if (optBuffsSplashR = 1) {
	guiBuffsSplashRStatusB = on
}
guiBuffsSplashEStatusB = off
if (optBuffsSplashE = 1) {
	guiBuffsSplashEStatusB = on
}

Gui, Add, Picture, x61 y101 vguiBuffsSplashCStatus g_GUISetBuffsSplashCOn, images/gui/bUse_%guiBuffsSplashCStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSplashCInterval Range0-480, %optBuffsSplashCInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsSplashUStatus g_GUISetBuffsSplashUOn, images/gui/bUse_%guiBuffsSplashUStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSplashUInterval Range0-480, %optBuffsSplashUInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsSplashRStatus g_GUISetBuffsSplashROn, images/gui/bUse_%guiBuffsSplashRStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSplashRInterval Range0-480, %optBuffsSplashRInterval%

Gui, Add, Picture, x61 y+5 vguiBuffsSplashEStatus g_GUISetBuffsSplashEOn, images/gui/bUse_%guiBuffsSplashEStatusB%.png
Gui, Add, Edit, x+59 w55
Gui, Add, UpDown, vguiBuffsSplashEInterval Range0-480, %optBuffsSplashEInterval%

Gui, Tab
Gui, Add, Picture, x15 y42 vguiBuffsGoldTab g_GUIBuffsGoldTab +Hidden, images/gui/guiBuffsGold_tab_inactive.png
Gui, Add, Picture, x+2 vguiBuffsPowerTab g_GUIBuffsPowerTab, images/gui/guiBuffsPower_tab_inactive.png
Gui, Add, Picture, x+2 vguiBuffsSpeedTab g_GUIBuffsSpeedTab, images/gui/guiBuffsSpeed_tab_inactive.png
Gui, Add, Picture, x+2 vguiBuffsCritTab g_GUIBuffsCritTab, images/gui/guiBuffsCrit_tab_inactive.png
Gui, Add, Picture, x+2 vguiBuffsClickTab g_GUIBuffsClickTab, images/gui/guiBuffsClick_tab_inactive.png
Gui, Add, Picture, x+2 vguiBuffsSplashTab g_GUIBuffsSplashTab, images/gui/guiBuffsSplash_tab_inactive.png


Gui, Add, Picture, x167 y12 g_GUIHelpBuffs, images/gui/bHelp.png
Gui, Add, Picture, x231 y0 g_GUICloseBuffs, images/gui/bClose.png
Gui, Add, Picture, x97 y234 g_GUIApplyBuffs, images/gui/bApply.png
