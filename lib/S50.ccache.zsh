# check if ccache module is disabled
if [ "$ZSH_CCACHE" = 0 ]; then return; fi

# check if ccache already in PATH
case $PATH in */usr/lib/ccache/bin* ) return;; esac

# prepend ccache bin dir to PATH
if [ -d "/usr/lib/ccache/bin" ]; then
	export PATH="/usr/lib/ccache/bin/:$PATH"
fi
