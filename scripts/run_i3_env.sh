#!/usr/bin/zsh
export XDG_DATA_DIRS="/usr/share:/usr/local/share:$XDG_DATA_DIRS"
"$@"
