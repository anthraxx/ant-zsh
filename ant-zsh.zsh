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

# antigen
ADOTDIR="${ZSH}/plugin"
source "${ZSH}/plugin/antigen/antigen.zsh"

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

plugins=(git-antzsh cowfortune virtualenv ccache)
# Add all defined plugins to fpath. This must be done
# before running compinit.
is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugin/$name/$name.plugin.zsh \
    || test -f $base_dir/plugin/$name/_$name
}
for plugin ($plugins); do
  if is_plugin $ZSH $plugin; then
    fpath=($ZSH/plugin/$plugin $fpath)
  fi
done
# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH/plugin/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugin/$plugin/$plugin.plugin.zsh
  fi
done

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
