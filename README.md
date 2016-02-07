# Aware
## Automatic toggling f-keys on mac os to work with JetBrains shortcuts. 

A really simple and dumb tool which I might improve in the future. It recognizes current active app and according to its bundle changes the keyboard preference for F- keys. The use of AppleScript was inevitable for me becasue I have wasted enough time already trying to use the CFPreferences API and defaults and failed miserably. 
``` Swift
// Does not work but should
CFPreferencesSetAppValue("fnState", kCFBooleanTrue, "com.apple.keyboard")
CFPreferencesAppSynchronize("com.apple.keyboard")
```

```
// This also should but it seems that changing only flag does not propagate or it is only read at system boot
defaults write -g com.apple.keyboard.fnState -bool true
```

If you know something that I have missed, please let me know :)

## Using Aware
In order to use Aware, you have to let it use accessibility on your mac. 
Go to System Preferences -> Security & Privacy -> Accessibility and check permission for Aware app to control your mac.
From now on you don't have to worry about <b>Fn</b> key in JetBrains IDE, it will automatically adjust from media to IDE shortcuts. <b>Happy coding!</b>
### Aware is aware so you don't have to be 

``` If you are afraid that app can be harmful just look at scpt files and calm down :) ```

## Before
<img src="https://github.com/ninjazoete/Aware/blob/master/Docs/Before.png" width="700">

## After
<img src="https://github.com/ninjazoete/Aware/blob/master/Docs/After.png" width="700">

## Known issues
- When working with spaces, user is taken away to different space after focusing jetbrains IDE and has to go back there again
- AppleScript (yuk!)
