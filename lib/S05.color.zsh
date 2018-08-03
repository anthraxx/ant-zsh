autoload colors; colors;

export LSCOLORS="Gxfxcxdxbxegedabagacad"
# export LS_COLORS via dircolors for compretion
if [ -z "$LS_COLORS" ]
then
	eval $(dircolors)
fi

# enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

# enable ip colors
if [ "$DISABLE_IP_COLORS" != "true" ]
then
  ip --color -br link &>/dev/null 2>&1 && alias ip='ip --color -br'
fi

# enable diff colors
if [ "$DISABLE_DIFF_COLORS" != "true" ]
then
  diff --color=auto --version &>/dev/null 2>&1 && alias diff='diff --color=auto'
fi

# enable ncdu colors
if [ "$DISABLE_NCDU_COLORS" != "true" ]
then
  ncdu --color=dark -version &>/dev/null 2>&1 && alias ncdu='ncdu --color=dark'
fi

if [ "$DISABLE_S_COLORS" != "true" ]
then
	export S_COLORS=auto
fi

# set some colors
for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN; do
	eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RST="%{${reset_color}%}"
PR_RESET="%{%b%s%u$reset_color%}"
PR_BG="%{%(?.$PR_RESET.%S)%}"
