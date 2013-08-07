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

# default env vars (if not set)
if [[ -z "$TERM" ]]; then
	export TERM=xterm-256color
fi
if [[ -z "$EDITOR" ]]; then
	export EDITOR=vim
	export VISUAL=$EDITOR
fi

# pre execute functions
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# dircolors
if [[ -z "$ZSH_DIRCOLORS_DIR" ]]; then
	ZSH_DIRCOLORS_DIR="/usr/share/dircolors"
fi
if [[ -z "$ZSH_DIRCOLORS" ]]; then
	ZSH_DIRCOLORS="dircolors.256dark"
fi
if [[ -f "$ZSH_DIRCOLORS_DIR/$ZSH_DIRCOLORS" ]]; then
	eval `dircolors $ZSH_DIRCOLORS_DIR/$ZSH_DIRCOLORS`
fi

