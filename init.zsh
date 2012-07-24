# some pre-checks
if [ "" = "$ZSH" ]; then
	echo "\033[00;31mERROR: missing ZSH env var! read the README!"
fi
if [ ! -d "$ZSH" ]; then
	echo "\033[00;31mERROR: ZSH env var leads nowhere: '$ZSH'"
else
	# include all lib config files
	for config_file ($ZSH/lib/*.zsh) source $config_file
fi

# include defined theme or default fallback
if [ "$ZSH_THEME" = ""  ]; then
	ZSH_THEME=anthraxx
fi
if [ ! -f "${ZSH}/theme/${ZSH_THEME}.zsh" ]; then
	echo "\033[00;31mERROR: could not find ZSH_THEME '${ZSH_THEME}'"
	ZSH_THEME=anthraxx
fi
source "${ZSH}/theme/${ZSH_THEME}.zsh"

