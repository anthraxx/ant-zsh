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

function psgrep() {
  grep "$1" =(ps aux)
}

function run-with-sudo() {
  LBUFFER="sudo $LBUFFER"
}
zle -N run-with-sudo

function zsh_update() {
	pushd "${ZSH}"
	git pull --rebase origin master
	git submodule update --init --recursive --rebase
	antigen reset
	antigen update
	popd 2>/dev/null
}
