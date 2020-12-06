# WSL 2 DEV setup on Debian

# Prerequisites

Preparations on the Windows side:

* Do https://docs.microsoft.com/en-us/windows/wsl/install-win10
* Do https://docs.docker.com/docker-for-windows/wsl/
* Install https://visualstudio.microsoft.com/
* Install https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6
* Install https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701

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
