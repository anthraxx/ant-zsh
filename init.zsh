# include all lib config files
for config_file ($ZSH/lib/*.zsh) source $config_file

ZSH_THEME=anthraxx

# include defined theme
if [ ! "$ZSH_THEME" = ""  ]; then
	source "${ZSH}/theme/${ZSH_THEME}.zsh"
fi

