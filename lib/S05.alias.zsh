# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'
alias dl='dirs -v | head -n10'

# Show history
alias history='fc -l 1'

# List direcory contents
alias ls='ls --color=auto'
if which ls++ &>/dev/null 2>&1; then
	alias l='ls++ --potsf -lAh --color'
	alias ll='ls++ --potsf -lAh --color'
else
	alias l='ls -lAh --color'
	alias ll='ls -lAh --color'
fi

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias agrep='ack-grep --color'
