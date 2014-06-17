# check if a plugin is valid withhin a base
is_plugin() {
	local base_dir=$1
	local name=$2
	test -f $base_dir/plugin/$name/$name.plugin.zsh \
		|| test -f $base_dir/plugin/$name/_$name
}

# load all plugins passed as parameters
load_plugin() {
	for plugin ($*); do
		# add all defined plugins to fpath
		# must be done before running compinit
		if is_plugin $ZSH_CUSTOM $plugin; then
			fpath=($ZSH_CUSTOM/plugin/$plugin $fpath)
		elif is_plugin $ZSH $plugin; then
			fpath=($ZSH/plugin/$plugin $fpath)
		fi
		# load the plugin if a plugin file exists
		if [ -f $ZSH_CUSTOM/plugin/$plugin/$plugin.plugin.zsh ]; then
			fpath=($ZSH_CUSTOM/plugin/$plugin $fpath)
			source $ZSH_CUSTOM/plugin/$plugin/$plugin.plugin.zsh
		elif [ -f $ZSH/plugin/$plugin/$plugin.plugin.zsh ]; then
			source $ZSH/plugin/$plugin/$plugin.plugin.zsh
		fi
	done
}

