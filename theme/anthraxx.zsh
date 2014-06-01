autoload -Uz vcs_info
setopt transientrprompt

PR_GIT_UPDATE=1
PR_PROMPT_COLUMNS=
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg[yellow]%}%{${reset_color}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[red]%}]%{${reset_color}%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR="%{$fg[red]%}|%{${reset_color}%}"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[blue]%}"
update_current_git_vars

N=$'%1(l.\n.)'
MODE_INDICATOR="%{$fg_bold[yellow]%}vi %{$fg[red]%}<%{$reset_color%}"
RPS1='$(vi_mode_prompt_info)'

prompt_anthraxx_setup () {
	local -a pcc
	local -A pc
	local p_date p_tty p_plat p_userpwd p_apm p_shlvlhist p_rc p_end p_win
	local p_first

	pcc[1]=${1:-${${SSH_CLIENT+'yellow'}:-'red'}}
	pcc[2]=${2:-'blue'}
	pcc[3]=${3:-'green'}
	pcc[4]=${4:-'yellow'}
	pcc[5]=${5:-'white'}

	pc['\[']="%F{$pcc[1]}["
	pc['\]']="%F{$pcc[1]}]"
	pc['<']="%F{$pcc[1]}<"
	pc['>']="%F{$pcc[1]}>"
	pc['\(']="%F{$pcc[1]}("
	pc['\)']="%F{$pcc[1]})"

	p_date="$pc['\[']%F{$pcc[2]}%D{%a %y/%m/%d %R %Z}$pc['\]']"
	p_tty="$pc['\[']%F{$pcc[3]}%l$pc['\]']"
	p_plat="$pc['\[']%F{$pcc[2]}${MACHTYPE}/${OSTYPE}/$(uname -r)$pc['\]']"

	[[ -n "$WINDOW" ]] && p_win="$pc['\(']%F{$pcc[4]}$WINDOW$pc['\)']"

	p_userpwd="$pc['\[']%F{$pcc[3]}%n%F{$pcc[1]}@%F{$pcc[3]}%m$p_win%F{$pcc[5]}:%F{$pcc[4]}%~$pc['\]']"
	p_vcs='$(git_super_status)'

	p_shlvlhist="$pc['\[']%F{$pcc[2]}zsh%(2L./$SHLVL.)$pc['\]']$pc['\[']%F{$pcc[4]}%h%b$pc['\]']"
	p_rc="%(?..[%F{$pcc[2]}%?%1v$pc['\]'])"
	p_end="%F{$pcc[2]}%F{$pcc[5]}%B> %b%f"

	zle_highlight[(r)default:*]=default:$pcc[2]
	p_first="$p_date$p_tty$p_plat"
	local p_first_end="]"
	local prompt_line_width=${#${(S%%)p_first//(\%([KF1]|)\{*\}|\%[Bbkf])}}
	local prompt_line_end_width=${#${(S%%)p_first_end//(\%([KF1]|)\{*\}|\%[Bbkf])}}
	local prompt_padding_size=$(( COLUMNS - prompt_line_width - prompt_line_end_width - 1 ))
	if (( prompt_padding_size > 0 )); then
		local prompt_padding
		eval "prompt_padding=\${(l:${prompt_padding_size}::=:)_empty_zz}"
		p_first="$p_first$prompt_padding$p_first_end"
	fi

	prompt="$p_first$N$p_userpwd$N$p_shlvlhist$p_rc$p_vcs$p_end"
	PS2='%(4_.\.)%3_> %E'
}

prompt_anthraxx_precmd () {
	setopt noxtrace noksharrays localoptions
	local exitstatus=$?
	local git_dir git_ref

	psvar=()
	[[ $exitstatus -ge 128 ]] && psvar[1]=" $signals[$exitstatus-127]" ||
	psvar[1]=""

	[[ -o interactive ]] && jobs -l

	if [[ -n "$PR_GIT_UPDATE" ]] ; then
		vcs_info 'prompt'
		PR_GIT_UPDATE=
	fi
	if [[ $COLUMNS -ne $PR_PROMPT_COLUMNS ]] ; then
		prompt_anthraxx_setup
		PR_PROMPT_COLUMNS="$COLUMNS"
	fi
}

prompt_anthraxx_preexec() {
	case $(history $HISTCMD) in
		git*|hub*|gh*|stg*)
			PR_GIT_UPDATE=1
			;;
	esac
}

prompt_anthraxx_chpwd() {
	PR_GIT_UPDATE=1
}

add-zsh-hook precmd prompt_anthraxx_precmd
add-zsh-hook preexec prompt_anthraxx_preexec
add-zsh-hook chpwd prompt_anthraxx_chpwd
prompt_anthraxx_setup

