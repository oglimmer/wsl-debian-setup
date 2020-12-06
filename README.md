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
``` 
 
 ## Setup without SSH keys

Replace the XXX with your windows users name then execute this statement

```
wget -O - https://raw.githubusercontent.com/oglimmer/wsl-debian-setup/master/init.sh | WINDOWS_USER=XXX bash -
```

# Next steps

* After closing the current Windows Terminal shell and re-opening one (to get a fish shell instead of bash)
* Make sure you've X Server from VcXsrv started (use all the defaults except for "remove native opengl" and "add disable access control"
* Possible first commands:

```
gnome-terminal

/opt/idea/bin/idea.sh &

chromium &

firefox &

nautilus / &

meld
```

* Change the settings in Windows Terminal. Add "startingDirectory": "//wsl$/Debian/home/oli" to change the initial directory and change defaultProfile to Debian's UUID
