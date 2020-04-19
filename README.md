# BTD6 Auto Grinder
BTD6 Auto Grinder is an AutoHotkey script for automatic grinding of Experience, Monkey Money and other things (such as event points) in the Steam release of [Bloons TD 6](https://store.steampowered.com/app/960090/Bloons_TD_6/).

As of right now, the script works by automatically putting down towers in the Dark Castle map (Deflation mode), letting them deal with all the waves of bloons, and restarting the map once finished.

All of that is triggered by a single hotkey press, and only requires the window to be in focus during the tower placement phase and the restarting phase (occasionally, it will also have to dismiss a level-up message).

## Does this script access the game's memory?
No, it's essentially a [screen scraper](https://en.wikipedia.org/wiki/Data_scraping#Screen_scraping), meaning that it acquires all of the necessary data by searching for specific patterns of pixels in various regions of the screen while the game is running.

It **doesn't** use any form of code injection and instead performs every action in basically the same way a human would, just much more quickly and efficiently.

## How do I use it?
You can download the required AutoHotkey version (any **Current Version**, don't choose V2 Alpha or V1.0 Deprecated for this) from their [official site](https://www.autohotkey.com/).

Once you've downloaded and installed the current version of AHK, simply run the .ahk file and follow the on-screen instructions.

It is expected that you have played the game for some time before running this script, if you haven't you may have to unlock the following ("x/y/z" means which tiers of the top, middle and bottom upgrade paths are required):
- The Expert map "Dark Castle" and its Deflation mode (under "Easy")
- The hero Obyn
- 0/0/2 Monkey Village
- 2/0/3 Super Monkey
- 3/0/1 Ninja Monkey
- 3/0/0 Alchemist

## How do I know it's working correctly?
If after the initial tower setup phase you are left with less than 500 money, you can be practically sure that your towers will have no trouble dealing with any of the waves.

If you want to make sure that all of the functionality is working correctly before leaving the script on for a significant amount of time, just let it do its magic for a single full run of Deflation and one full restart of the map. If that works, then the script should work correctly for an indefinite amount of time *(or until you forget to pay the power bill)*.

## HELP! EVERYTHING IS TERRIBLE!
It's extremely unlikely that the script would mess up that bad, because it can *only* operate while the BTD6 window is active, but you can terminate the script by pressing **Ctrl + Shift + E** or by right-clicking its tray icon and clicking **Exit**.

## Planned Features
- Saving user preferences
- Automatically checking for requirements before grinding
- Better GUI less reliant on hotkeys
- Other ways of grinding. Maybe.
