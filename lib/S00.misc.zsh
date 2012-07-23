# smart urls
autoload -U url-quote-magic
autoload -Uz vcs_info
zle -N self-insert url-quote-magic

# file rename magick
bindkey "^[m" copy-prev-shell-word

# options
setopt auto_continue        # send SIGCONT to jobs disowned
setopt long_list_jobs
setopt nohup
setopt nocheckjobs
setopt listpacked
setopt prompt_subst         # expansions-in-prompt

# pager
export PAGER="less -R"
export LC_CTYPE=$LANG

# vars
export TERM=xterm-256color
export BROWSER=firefox
export EDITOR=vim
export VISUAL=$EDITOR

# pre execute functions
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# dircolors
eval `dircolors /etc/dircolors/dircolors.256dark`
