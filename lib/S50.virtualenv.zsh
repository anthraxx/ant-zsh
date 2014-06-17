# source virtualenvwrapper.sh if it exists
ZSH_VIRTUALENV_WRAPPER=$(which virtualenvwrapper.sh 2>/dev/null)
if [ 0 -eq $? ]; then
	source ${ZSH_VIRTUALENV_WRAPPER}
fi

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

# virtualenv prompt
ZSH_THEME_VIRTUALENV_PROMPT_PREFIX="%{${reset_color}%}%{$fg[red]%}[%{${reset_color}%}"
ZSH_THEME_VIRTUALENV_PROMPT_SUFFIX="%{${reset_color}%}%{$fg[red]%}]%{${reset_color}%}"
ZSH_THEME_VIRTUALENV_PROMPT_ENVNAME="%{${reset_color}%}%{$fg_bold[yellow]%}"
ZSH_THEME_VIRTUALENV_PROMPT_EMPTY=""

function virtualenv_prompt_info(){
	if [[ -n $VIRTUAL_ENV ]]; then
		printf "%s%s%s%s" "${ZSH_THEME_VIRTUALENV_PROMPT_PREFIX}" "${ZSH_THEME_VIRTUALENV_PROMPT_ENVNAME}" "${${VIRTUAL_ENV}:t}" "${ZSH_THEME_VIRTUALENV_PROMPT_SUFFIX}"
		return
	fi
	printf "%s" "${ZSH_THEME_VIRTUALENV_PROMPT_EMPTY}"
}
