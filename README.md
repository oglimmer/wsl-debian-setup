# WSL 2 DEV setup on Debian

What is does:

* ssh-agent
* a proper DISPLAY env variable
* IntelliJ IDEA ultimate Version 2020.2.3
* fish shell with alias for ls=exa
* JDK 11, maven, gradle
* Node LTS
* some useful binaries (e.g. jwt, jq)

# Prerequisites

Preparations on the Windows side:

* Do https://docs.microsoft.com/en-us/windows/wsl/install-win10
* Do https://docs.docker.com/docker-for-windows/wsl/
* Install https://visualstudio.microsoft.com/
* Install https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6
* Install https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701
* Install https://sourceforge.net/projects/vcxsrv/

# WSL VM with Debian - ready to dev

* If not done yet, start "Debian" from the Windows Start menu once (close when you see the shell ready)
* Start Windows Terminal and select "Debian" from the profile menu
* Exec `sudo apt update && sudo apt install -y wget`

## Setup incl. copying SSH keys

Replace the XXX with your windows users name, also reaplce the '/mnt/f/Debian/.ssh/', then execute this statement

```
wget -O - https://raw.githubusercontent.com/oglimmer/wsl-debian-setup/master/init.sh | WINDOWS_USER=XXX PATH_TO_SSH=/mnt/f/Debian/.ssh/ bash -
chsh -s /usr/bin/fish
``` 
 
 ## Setup without SSH keys

Replace the XXX with your windows users name then execute this statement

```
wget -O - https://raw.githubusercontent.com/oglimmer/wsl-debian-setup/master/init.sh | WINDOWS_USER=XXX bash -
chsh -s /usr/bin/fish
```

# Next steps

* After closing the current Windows Terminal shell and re-opening one (to get a fish shell instead of bash)
* Make sure you've X Server from VcXsrv started (see [this article](https://oglimmer.medium.com/a-working-wsl-2-ubuntu-development-setup-332e64034e5) for details. Keep in mind to change the Windows Firewall!)
* Possible first commands:

```
gnome-terminal

/opt/idea/bin/idea.sh &

chromium &

firefox &

nautilus / &

meld
```

## Windows Terminal setup

Change the settings in Windows Terminal:

* Add a "startingDirectory": "//wsl$/Debian/home/oli" to change the initial directory
* Change the defaultProfile to Debian's UUID to avoid the first windows always creates a PowerShell
* Add a "commandline": "wsl -d Debian -- gnome-terminal && /usr/bin/fish" to automatically start the gnome terminal

Example settings:

```
    "profiles":
    {
        "defaults":
        {
        },
        "list":
        [
            {
                "guid": "{58ad8b0c-3ef8-5f4d-bc6f-13e4c00f2530}",
                "hidden": false,
                "name": "Debian",
                "source": "Windows.Terminal.Wsl",
                "commandline": "wsl -d Debian -- gnome-terminal && /usr/bin/fish",
                "startingDirectory": "//wsl$/Debian/home/oli"
            }
        ]
    }
```

## VcXsrv setup

To easily start the X11 Server under Windows, create a file called "x11-startup.xlaunch" at a convienent location under Windows. Add this content:

```
<?xml version="1.0" encoding="UTF-8"?>
<XLaunch 
    WindowMode="MultiWindow" 
    ClientMode="NoClient"
    LocalClient="False"
    Display="-1"
    LocalProgram="xcalc"
    RemoteProgram="xterm"
    RemotePassword=""
    PrivateKey=""
    RemoteHost=""
    RemoteUser=""
    XDMCPHost=""
    XDMCPBroadcast="False"
    XDMCPIndirect="False"
    Clipboard="True"
    ClipboardPrimary="False"
    ExtraParams=""
    Wgl="True"
    DisableAC="True"
    XDMCPTerminate="False"
/>
```

Go to `C:\Users\<WINDOWS_USER_NAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs` and create a Windows Shortcuts file here. For maximum convenience go to your Start Menu, right click the new entry "x11-startup" and click "Pin To Start".
