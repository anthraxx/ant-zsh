setopt correct              # try to correct command line
setopt correct_all          # correct args
setopt no_correct_all       # don't coorect args
setopt auto_list            # list choice on ambiguous command

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias ebuild='nocorrect ebuild'
