autoload -Uz vcs_info
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# zsh-git-prompt setup from antigen repo
export __GIT_PROMPT_DIR=$ZSH/plugin/repos/https-COLON--SLASH--SLASH-github.com-SLASH-olivierverdier-SLASH-zsh-git-prompt.git

# override update function to call gitstatus with python2
function update_current_git_vars() {
	unset __CURRENT_GIT_STATUS

	local gitstatus="$__GIT_PROMPT_DIR/gitstatus.py"
	_GIT_STATUS=`python2 ${gitstatus}`
	__CURRENT_GIT_STATUS=("${(@f)_GIT_STATUS}")
	GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
	GIT_REMOTE=$__CURRENT_GIT_STATUS[2]
	GIT_STAGED=$__CURRENT_GIT_STATUS[3]
	GIT_CONFLICTS=$__CURRENT_GIT_STATUS[4]
	GIT_CHANGED=$__CURRENT_GIT_STATUS[5]
	GIT_UNTRACKED=$__CURRENT_GIT_STATUS[6]
	GIT_CLEAN=$__CURRENT_GIT_STATUS[7]
}
