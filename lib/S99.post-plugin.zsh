# zaw
BOOKMARKFILE=~/.config/zsh/zaw-bookmarks
mkdir -p $(dirname $BOOKMARKFILE)
bindkey '^W' zaw-bookmark
bindkey '^R' zaw-history
