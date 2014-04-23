# some pre-checks
if [ "" = "$ZSH" ]; then
	echo "\033[00;31mERROR: missing ZSH env var! read the README!"
	return
fi
if [ ! -d "$ZSH" ]; then
	echo "\033[00;31mERROR: ZSH env var leads nowhere: '$ZSH'"
	return
fi

# antigen
ADOTDIR="${ZSH}/plugin"
source "${ZSH}/plugin/antigen/antigen.zsh"

antigen bundles <<EOBUNDLES
	olivierverdier/zsh-git-prompt
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-completions src
	zsh-users/zaw
	git
	gitfast
	git-extras
	git-flow
	taskwarrior
	colored-man
	extract
EOBUNDLES
antigen apply

# include all lib config files
for config_file ($ZSH/lib/*.zsh) source $config_file

# fallback theme
if [ "$ZSH_THEME" = ""  ]; then
	ZSH_THEME=anthraxx
fi
# include defined theme
if [ ! -f "${ZSH}/theme/${ZSH_THEME}.zsh" ]; then
	echo "\033[00;31mERROR: could not find ZSH_THEME '${ZSH_THEME}'"
	ZSH_THEME=anthraxx
fi
source "${ZSH}/theme/${ZSH_THEME}.zsh"
