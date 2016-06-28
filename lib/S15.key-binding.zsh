setopt vi
bindkey -v
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey '^E' history-incremental-search-backward

# zaw bindings
bindkey '^R' zaw-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey ' ' magic-space    # also do history expansion on space

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

bindkey "\e[5~" history-beginning-search-backward # PageUp
bindkey "\e[6~" history-beginning-search-forward # PageDown
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for guake
bindkey "\eOF" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\e[3~" delete-char # Del
