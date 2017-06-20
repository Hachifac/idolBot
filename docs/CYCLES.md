# Documentation  

## Cycles  
You can find the custom cycles under **settings/cycles.txt**  

### Format  
Cycles must be enclosed inside brackets, have a cycle number and a cycle parameter.  

```
[1:  
    cycle: {
        
    }
]
```  

There are three parameters that can be set:  
- loop
- duration  
- cycle

```
[1:  
    loop: 10  
    duration: 300
    cycle: {
        
    }
]
``` 
loop: **X**  
*Loops through the cycle **X** times and then proceed to the next cycle.*  
*When set to zero or left out, it will act as an infinite loop.*

duration: **X**  
*After **X** seconds elapsed, the bot will proceed to the next cycle.*  

**Note:** duration prevails over loop, if *duration* elapsed, regardless of the loops remaining, the bot will proceed to the next cycle.  

cycle: {  
    **COMMANDS**
}  

Commands must be entered in the cycle parameter.  
- PickGold
- PickGold(**TIME**)
- MaxLevels
- UpgradeAll
- MaxAll
- LevelCrusader(**CRUSADER**)
- LevelMainDPS
- SetFormation(**FORMATION NUMBER**)
- SetFormation
- Wait(**WAIT TIME**)
- UseSkill(**SKILL KEY NUMBER**)
- UseSkills
- UseBuffs
- CheatEngineOn
- CheatEngineOff

Example
```
[1:  
    loop: 10  
    duration: 300
    cycle: {
        UseBuffs
        PickGold(5)
        MaxAll
        SetFormation
        PickGold(1)
        MaxLevels
        PickGold(1)
        UpgradeAll
    }
]
``` 

The above cycle will loop 10 times and/or for a maximum of 5 minutes.  
Through the course of one loop, the bot will:  
- Use the buffs (if the conditions are met)
- Pick gold and items for 5 seconds
- Max all levels and upgrade all skills
- Set the formation to the one specified in the options
- Pick gold and items for 1 second
- Max all levels
- Pick gold and items for 1 second
- Upgrade all skills

## Definitions  

**PickGold**  
Pick gold and items for the *Loot items duration* bot option.

**PickGold(*TIME*)**  
*TIME* is the time in **seconds** in which the bot will pick gold and items for.  

**MaxLevels**  
Max all the levels. This does not count towards the *Upgrade all until* bot options.  

**UpgradeAll**  
Upgrade all the skills.  

**MaxAll**  
Max all the levels and upgrade all the skills. This count towards the *Upgrade all until* bot options.  
Example: *Upgrade all until* is set to 2, after two **MaxAll** the bot will upgrade all the skills.  

**LevelCrusader(*CRUSADER*)**  
Move to and level up *CRUSADER*  

**LevelMainDPS**  
Move to and level up the *Main DPS* crusader in the bot options.  

**SetFormation(*FORMATION NUMBER*)**  
Set the crusaders formation to *FORMATION NUMBER*  

**SetFormation**  
Set the crusaders formation to the *Formation* in the bot options.  

**Wait(*WAIT TIME*)**  
*TIME* is the time in **seconds** in which the bot will wait before proceeding further down in the cycle.  

**UseSkill(*SKILL KEY NUMBER*)**  
Use *SKILL KEY NUMBER* skill.  

**UseSkills**  
Let the bot use skills accordingly to the Storm Rider options.  

**UseBuffs**  
Use the buffs accordingly to the Buffs options.  

**CheatEngineOn**  
Activate Cheat Engine.  
Independant of the Cheat Engine options.  

**CheatEngineOff**  
Deactivate Cheat Engine.  
Independant of the Cheat Engine options.

## Notes  

If the last cycle is not infinite, the bot will not go back to the first cycle.  
A proper way to do the cycles would be to make sure the last cycle is the final one until reset.  

Example:  

```
[1:
	loop: 1
	cycle: {
		PickGold(5)
		Wait(2)
		MaxLevels
		Wait(0.1 )
		SetFormation
		PickGold(1)
		UpgradeAll
		Wait(0.1)
		PickGold(1)
		UpgradeAll
		PickGold(1)
		MaxLevels
		Wait(0.1)
		SetFormation
		PickGold(1)
		UpgradeAll
	}
]
[2:
	duration: 600
	cycle: {
		PickGold
		LevelCrusader(Siri)
		MaxAll
		UseSkills
		UseBuffs
		SetFormation
	}
]
[3:
	cycle: {
		PickGold
		MaxAll
		UseSkills
		UseBuffs
		SetFormation
	}
]
```  

With these cycles, the bot will do one pass of the first cycle, then 10 minutes of the second cycle and spend the rest of the run on the third cycle.