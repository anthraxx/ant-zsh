# check if a plugin is valid withhin a base
is_plugin() {
	local base_dir=$1
	local name=$2
	is_plugin_source $1 $2 \
		|| test -f $base_dir/plugin/$name/_$name
}

# check if a plugin is a source script
is_plugin_source() {
	local base_dir=$1
	local name=$2
	test -f $base_dir/plugin/$name/$name.plugin.zsh
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
		if is_plugin $ZSH_CUSTOM $plugin; then
			source $ZSH_CUSTOM/plugin/$plugin/$plugin.plugin.zsh
		elif is_plugin $ZSH $plugin; then
			source $ZSH/plugin/$plugin/$plugin.plugin.zsh
		else
			antigen bundle $plugin
		fi
	done
}

