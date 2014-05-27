autoload colors; colors;

export LSCOLORS="Gxfxcxdxbxegedabagacad"
# export LS_COLORS via dircolors for compretion
if [ -z "$LS_COLORS" ]
then
	eval `dircolors`
fi

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

# set some colors
for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN; do
	eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RST="%{${reset_color}%}"
PR_RESET="%{%b%s%u$reset_color%}"
PR_BG="%{%(?.$PR_RESET.%S)%}"
