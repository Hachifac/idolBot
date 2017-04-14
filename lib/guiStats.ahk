#NoEnv
SendMode Input

Gui, BotGUIStats: New, -Caption, idolBot Stats
Gui, Color, 6C2509
Gui, Font, s14 norm cFEFEFE, System

Gui, Add, Picture, x0 y0, images/gui/guiStats_bg.png

Gui, Add, Picture, x227 y0 gCloseStats, images/gui/bClose.png

idolsLastRunPerHour := RoundNumber(idolsLastRun / idolsLastRunTime * 60 * 60, 2)
idolsThisSessionPerHour := RoundNumber(idolsThisSession / (UnixTime(A_Now) - botLaunchTime) * 60 * 60, 2)
idolsPastDayPerHour := RoundNumber(idolsPastDay / 86400 * 60 * 60, 2)
chestsThisRunPerHour := RoundNumber(chestsThisRun / (UnixTime(A_Now) - botLaunchTime) * 60 * 60, 2)
chestsLastRunPerHour := RoundNumber(chestsLastRun / chestsLastRunTime * 60 * 60, 2)
chestsThisSessionPerHour := RoundNumber(chestsThisSession / (UnixTime(A_Now) - botLaunchTime) * 60 * 60, 2)
chestsPastDayPerHour := RoundNumber(chestsPastDay / 86400 * 60 * 60, 2)

Gui, Add, Text, x42 y66, %idolsLastRun% (%idolsLastRunPerHour%/hr)
Gui, Add, Text, y+9, %idolsThisSession% (%idolsThisSessionPerHour%/hr)
Gui, Add, Text, y+9, %idolsPastDay% (%idolsPastDayPerHour%/hr)
Gui, Add, Text, y+9, %idolsAllTime%
Gui, Add, Text, y+37, %chestsThisRun% (%chestsThisRunPerHour%/hr)
Gui, Add, Text, y+9, %chestsLastRun% (%chestsLastRunPerHour%/hr)
Gui, Add, Text, y+9, %chestsThisSession% (%chestsThisSessionPerHour%/hr)
Gui, Add, Text, y+9, %chestsPastDay% (%chestsPastDayPerHour%/hr)
Gui, Add, Text, y+9, %chestsAllTime%