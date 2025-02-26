# Windows wallpaper changer
![image](https://github.com/user-attachments/assets/2d396484-e5dc-4fe7-b197-991d1700d769)

A utility written in powershell to replace the cached wallpaper file on windows. Very useful on systems where the wallpaper is set using group policy and can not be changed.
### [Download here](https://github.com/MichaelK-F/windows-wallpaper-changer/releases/latest/download/wallpaper-changer.exe)

## How does it work?
It replaces the cached wallpaper. Due to it replacing the file and not actually changing the wallpaper from settings, it will not show up in the settings app. It also does not require administrator privledges to run, meaning that it is very useful on managed systems such as a work or school laptop.

## Building .exe from .ps1 (advanced users)
Install ps2exe (only has to be done one):
```Install-Module -Name ps2exe```
Convert ps1 to exe:
```Invoke-PS2EXE .\wallpaper-changer.ps1 .\wallpaper-changer.exe```
It is possible to convert it with the `-noConsole` parameter but it triggers a lot of anti-virus.
