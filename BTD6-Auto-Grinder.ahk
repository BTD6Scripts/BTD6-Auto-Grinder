#NoEnv
#Warn
#SingleInstance Force
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
SendMode Input
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1


winTitle := "BTD6 Auto Grinder"
safetyDelay := 80
enableFastRestart := true


ShowInfoBox()
return
; auto-execute section ends here


ShowInfoBox()
{
	global winTitle
	
	MsgBox, % 0 + 64, %winTitle%, Welcome to %winTitle%!`n`n`nOnce you're ready to start automatically grinding for Monkey Money and Experience`, make sure that:`n1. You're using the default`, unchanged hotkey setup`n2. The game is Fullscreen and in any 16:9 resolution (e.g. 1920x1080)`n3. Auto Start and Drag & Drop are enabled`n`nthen:`n4. Select Obyn as your hero`n5. Head into the Dark Castle map (Expert)`n6. Select Easy`, then Deflation`n7. Press Alt + S to Start!`n`nYou may also:`n- press Alt + I to bring this Info box up again`n- press Alt + D to set a custom Delay (if inputs aren't timed correctly)`n- press Alt + F to enable/disable Fast restart`n- press Ctrl + Shift + E to fully Exit the script.
}



SafeInput(paramOne, paramTwo)	; use paramOne for chosenHotkey, or paramOne AND paramTwo for x, y coords of mouse click
{
	while(true)
	{
		IfWinActive, BloonsTD6
		{
			if(paramTwo = "")
				Send, %paramOne%	; chosenHotkey
			else
			{
				MouseMove, A_ScreenWidth * paramOne, A_ScreenHeight * paramTwo, 0	; move to x, y instantly
				Sleep, 50
				MouseClick
			}
			
			break
		}
		Sleep, 50
	}	
}

SafeHotkey(chosenHotkey)
{
	global safetyDelay
	
	SafeInput(chosenHotkey, "")
	Sleep, %safetyDelay%
}

SafeClick(x, y)
{
	global safetyDelay
	
	SafeInput(x, y)
	Sleep, %safetyDelay%	
}

SafePutDownTower(chosenHotkey, x, y, selectTower)
{
	global safetyDelay
	
	SafeHotkey(chosenHotkey)
	
	SafeClick(x, y)
	
	if(selectTower)
		SafeClick(x, y)
}



$!s::	; alt + S to Start
Loop
{
	Loop 2
	{
		SafePutDownTower("k", 0.35 + A_Index * 0.067, 0.27, true)	; monkey village 0/0/2, two times
		SafeHotkey("/")
		SafeHotkey("/")
	}
	
	SafePutDownTower("s", 0.5, 0.385, true)	; super monkey 2/0/3
	SafeHotkey(",")
	SafeHotkey(",")
	SafeHotkey("/")
	SafeHotkey("/")
	SafeHotkey("/")
	
	SafePutDownTower("u", 0.445, 0.4, false)	; Obyn, no upgrades
	
	SafePutDownTower("d", 0.4020, 0.4, true)	; ninja 3/0/1
	SafeHotkey(",")
	SafeHotkey(",")
	SafeHotkey(",")
	SafeHotkey("/")
	
	SafePutDownTower("f", 0.3825, 0.335, true)	; alchemist 3/0/0
	SafeHotkey(",")
	SafeHotkey(",")
	SafeHotkey(",")
	
	Loop, 2	; sell both monkey villages
	{
		SafeClick(0.35 + A_Index * 0.067, 0.27)	
		SafeHotkey("`b")
	}
	
	SafeClick(0.4025, 0.4)	; get *3*/0/*2* upgrades ninja. caltrops is optional, but you'll get it if you can afford it
	SafeHotkey(",")
	SafeHotkey("/")
	
	SafeClick(0.3825, 0.335)	; get 3/0/*1* upgrade on alchemist. this is extremely optional
	SafeHotkey("/")
	
	
	SafeHotkey(" ")	; starts the bloon waves
	SafeHotkey(" ")	; enables fast-forward
	
	
	Loop, 420	; click in the middle of the screen to discard level up msg constantly, and wait for waves to finish
	{
		Sleep, 500
		SafeClick(0.5, 0.5)
		Sleep, 500
		
		PixelSearch, , , 0.9540 * A_ScreenWidth, 0.9213 * A_ScreenHeight, 0.9580 * A_ScreenWidth, 0.9250 * A_ScreenHeight, 0xAFF700, 4, Fast RGB	; if speed button isn't light green, set it back to ffw (or start wave if paused due to lvl up)
		if(ErrorLevel = 1)
			SafeHotkey(" ")
		
		if(enableFastRestart)
		{
			PixelSearch, , , 0.6583 * A_ScreenWidth, 0.3602 * A_ScreenHeight, 0.6599 * A_ScreenWidth, 0.3620 * A_ScreenHeight, 0xDC2300, 2, Fast RGB	; look for the orange band to the right of "VICTORY" to restart faster
			if(ErrorLevel = 0)
			{
				Sleep, 1000
				break
			}
		}
	}
	
	
	SafeClick(0.5849, 0.7824)	; freeplay button
	Sleep, 1500	; wait until the freeplay window animation finishes
	
	SafeHotkey("{Enter}")	; freeplay "ok" button
	Sleep, 1500	; wait until freeplay window disappears
	
	SafeHotkey("{Escape}")	; options button
	Sleep, 1500	; wait until options menu shows up
	
	SafeClick(0.5625, 0.7843)	; restart button
	Sleep, 1500	; wait until restart confirm button shows up
	
	SafeHotkey("{Enter}")	; restart confirm button
	
	Sleep, 3500	; wait until restart loads
}
return



StartChangeFastRestartButtons:
WinWait, % winTitle " - Fast restart settings"
ControlSetText, Button1, Enable
ControlSetText, Button2, Disable
return


$!f::	; alt + F to enable/disable Fast restart
SetTimer, StartChangeFastRestartButtons, -80
MsgBox, % 4 + 32 + (enableFastRestart ? 256 : 0), % winTitle " - Fast restart settings", % "Fast restart tries to restart more quickly after achieving victory, saving you up to 1 minute on every run (which is why it is enabled by default).`n`nHowever, under some rare circumstances it may determine victory too quickly and restart before all waves finish.`nIf this is a common occurrence for you, you may want to disable it.`n`nIt is currently " (enableFastRestart ? "enabled" : "disabled") "."
IfMsgBox, Yes
	enableFastRestart := true
else
	enableFastRestart := false
return


$!d::	; alt + D to set custom safety Delay
InputBox, safetyDelay, % winTitle " - Delay settings", You can set a custom Delay between actions:`n`n- Lower values make things go a little faster`, but are unstable`n- Higher values make everything more stable, , , , , , , , %safetyDelay%
return


$!i::	; alt + I for Info box
ShowInfoBox()
return


^+e::	; ctrl + shift + E to Exit
ExitApp
return
