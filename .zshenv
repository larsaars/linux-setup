# aliases i use
alias vip="vim -p"
alias cls="clear"
alias pub="flutter pub"
alias mkdir="mkdir -p"
alias ls="ls --color=auto"
alias vim="nvim"


# alias for copying to clipboard
# use cat file | clip to copy file to clipboard
# or clipo > file.txt to paste clipboard to file
alias clip="xclip -sel clip"
alias clipo="xclip -sel clip -o"

# alias
function loadenv() {
    local envfile="${1:-.env}"
    export $(grep -v '^#' ${envfile} | xargs)
}

# function for killing all processes with a name searched
function kills() {
    kill -9 $(ps aux | grep "${1}" | grep -v grep | awk '{print $2}')
}

# alias for finding largest files and smallest
function lf() {
    local nsize="${1:-10}"
    du -hsx * | sort -rh | head -n "$nsize"
}

function sf() {
    local nsize="${1:-10}"
    du -hsx * | sort -h | head -n "$nsize"
}


# function for opening files with the default application but no log
function open() {
    xdg-open "$1" > /dev/null 2>&1
}

# for mkdir and cd directly
function mkc () {
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

# start simple server
function server() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# add local binaries to path
export PATH="$HOME/.local/bin:$PATH"
# and other binaries
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"

# dart executable
export PATH="$HOME/.pub-cache/bin:$PATH"

# add snapapps to the XDG_DATA_DIRS
export XDG_DATA_DIRS="/var/lib/snapd/desktop:$XDG_DATA_DIRS"

# export python startup .pythonrc
export PYTHONSTARTUP=~/.pythonrc

# set default input mode to vim
set -o vi

# start zsh in the same pwd as last used
# save path on cd
function cd {
    builtin cd $@
    pwd > ~/.last_dir
}

# restore last saved path
if [ -f ~/.last_dir ]
    then cd `cat ~/.last_dir`
fi


