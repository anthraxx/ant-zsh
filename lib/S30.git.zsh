autoload -Uz vcs_info
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# state initialization
export __CURRENT_GIT_BRANCH=
export __CURRENT_GIT_VARS_INVALID=1

# get the name of the branch we are on
git_prompt_info() {
	test -n "$__CURRENT_GIT_VARS_INVALID" && zsh_git_compute_vars
	test -z "$__CURRENT_GIT_BRANCH" && return
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${__CURRENT_GIT_BRANCH}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# invalidate prompt cache
zsh_git_invalidate_vars() {
	export __CURRENT_GIT_VARS_INVALID=1
}

# compute new prompt infos
zsh_git_compute_vars() {
	local name="$(parse_git_branch)"
	export __CURRENT_GIT_BRANCH=${name#refs/heads/}
	export __CURRENT_GIT_VARS_INVALID=
}

# parse the current git branch
parse_git_branch() {
	git symbolic-ref HEAD 2> /dev/null
}


# checks if working tree is dirty
parse_git_dirty() {
	local SUBMODULE_SYNTAX=''
	if [[ $POST_1_7_2_GIT -gt 0 ]]; then
		SUBMODULE_SYNTAX="--ignore-submodules=dirty"
	fi
	if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
		echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
	else
		echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
}


# checks if there are commits ahead from remote
git_prompt_ahead() {
	if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
		echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
	fi
}

# formats prompt string for current git commit short SHA
git_prompt_short_sha() {
	SHA=$(git rev-parse --short HEAD 2> /dev/null) && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

# formats prompt string for current git commit long SHA
git_prompt_long_sha() {
	SHA=$(git rev-parse HEAD 2> /dev/null) && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

# get the status of the working tree
git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  echo $STATUS
}

#compare the provided version of git to the version installed and on path
#prints 1 if input version <= installed version
#prints -1 otherwise 
git_compare_version() {
  local INPUT_GIT_VERSION=$1;
  local INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)INPUT_GIT_VERSION});
  INSTALLED_GIT_VERSION=($(git --version));
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]});

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 1
}

#this is unlikely to change so make it all statically assigned
POST_1_7_2_GIT=$(git_compare_version "1.7.2")
#clean up the namespace slightly by removing the checker function
unset -f git_compare_version

add-zsh-hook chpwd zsh_git_chpwd_update_vars
zsh_git_chpwd_update_vars() {
	zsh_git_invalidate_vars
}

add-zsh-hook preexec zsh_git_preexec_update_vars
zsh_git_preexec_update_vars() {
	case $(history $HISTCMD) in 
		*git*) zsh_git_invalidate_vars ;;
	esac
}
