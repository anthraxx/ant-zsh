# history file settings
export HISTFILE=~/.zhistory
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE

setopt append_history
setopt histignorealldups
setopt histreduceblanks
setopt histignorespace
setopt extended_history
setopt hist_expire_dups_first
setopt hist_verify
setopt inc_append_history
setopt share_history

