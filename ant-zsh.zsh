# some pre-checks
if [ -z "$ZSH" ]; then
	echo "\033[00;31mERROR: missing ZSH env var! read the README!"
	return
fi
if [ ! -d "$ZSH" ]; then
	echo "\033[00;31mERROR: ZSH env var leads nowhere: '$ZSH'"
	return
fi

# include all lib config files
for config_file ($ZSH/lib/*.zsh) source $config_file

# load antigen
ADOTDIR="${ZSH}/plugin"
source "${ZSH}/plugin/antigen/antigen.zsh"

# define and load the plugins
if [ "$ZSH_DEFAULT_PLUGINS_DISABLE" != "1" ]; then
	default_plugins=(cowfortune virtualenv ccache)
fi
load_plugin $default_plugins $plugins

antigen bundles <<EOBUNDLES
	olivierverdier/zsh-git-prompt
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-completions src
	zsh-users/zaw
	git
	git-flow
	taskwarrior
	colored-man
	extract
	python
	vi-mode
EOBUNDLES
antigen apply

# load gitstatus fix after zsh-git-prompt
load_plugin git-antzsh

# fallback theme
if [ -z "$ZSH_THEME" ]; then
	ZSH_THEME=anthraxx
fi
# include defined theme
if [ ! -f "${ZSH}/theme/${ZSH_THEME}.zsh" ]; then
	echo "\033[00;31mERROR: could not find ZSH_THEME '${ZSH_THEME}'"
	ZSH_THEME=anthraxx
fi
source "${ZSH}/theme/${ZSH_THEME}.zsh"
