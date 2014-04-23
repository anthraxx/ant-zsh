function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function take() {
  mkdir -p "$1"
  cd "$1"
}

function mkdircd() {
  take "$1"
}

function zc () {
  for exp in $argv; do
    print "$exp = $(( exp ))";
  done
}

function zsh_update() {
	pushd ${ZSH}
	git pull --rebase
	git submodule update
	antigen update
	popd
}
