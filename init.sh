#!/bin/bash

set -eu

if [ -z "$WINDOWS_USER" ]; then
  WINDOWS_USER=$1
fi
if [ -z "$PATH_TO_SSH" ]; then
  PATH_TO_SSH=${2:-}
fi

sudo apt update

sudo apt -y upgrade

sudo apt install -y git tasksel net-tools exa openjdk-11-jdk maven gradle wget chromium curl gcc g++ make jq fish

cd $HOME

chsh -s /usr/bin/fish

mkdir -p ~/.config/fish/functions/
wget https://gitlab.com/kyb/fish_ssh_agent/raw/master/functions/fish_ssh_agent.fish -P ~/.config/fish/functions/

cat >> ~/.config/fish/config.fish <<EOF
alias ls=exa
set -x DISPLAY (cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2):0
fish_ssh_agent
set -x PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin:/mnt/c/Users/$WINDOWS_USER/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/$WINDOWS_USER/AppData/Local/Programs/Microsoft VS Code/bin"
EOF

mkdir ~/.ssh
cat >> ~/.ssh/config <<EOF
AddKeysToAgent yes
User root
EOF

cat > ~/.config/fish/functions/fish_prompt.fish <<EOF
# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '~'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


function fish_prompt
  test \$SSH_TTY; and printf (set_color red)(whoami)(set_color white)'@'(set_color yellow)(hostname)' '

    test \$USER = 'root'; and echo (set_color red)"#"

    # Main
  echo -n (set_color cyan)(prompt_pwd) (__fish_git_prompt) (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
end
EOF

if [ -d "$PATH_TO_SSH" ]; then
  cp -r $PATH_TO_SSH/* ~/.ssh
  chmod 600 ~/.ssh/id_rsa*
fi

cat > ~/.vimrc <<EOF
" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
" syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

" Automatically wrap text that extends beyond the screen length.
set wrap
" Vim's auto indentation feature does not work properly with text copied from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview"
EOF

# Node TLS and tools

curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm -g install jwt-cli

# download IntelliJ

wget -O - https://download-cf.jetbrains.com/idea/ideaIC-2020.2.3.tar.gz | tar zxf -
sudo mv idea-IC* /opt/idea

# at the end: long running setup gnome-desktop 

sudo tasksel install gnome-desktop

sudo chown -R $USER:$USER ~/.cache
