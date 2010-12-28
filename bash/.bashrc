
# Check for an interactive session
[ -z "$PS1" ] && return

# default apps
EDITOR="/usr/bin/nano"

# key bindings
## make tab cycle through commands rather than listing
bind '"\t":menu-complete'

# aliases
alias ls='ls --color=auto'
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gg='git gui'
#~ alias glog='git log -1 HEAD'

# prompt mods
#~ PS1='[\u@\h \W]\$ '
#~ PS1='[\u \W] \n$ '
#~ PS1='\u@\H \W \$\n >: '
#~ PS1=':::::::::::::::::::::::::::::: \n =>    '
#~ PS1='\e[1;32m\u@\H \e[1;37m\w \e[1;32m$ \e[1;37m'
#~ PS1='\[\e[37m\][\t \W]$ \e[0m'
PS1='  :: [ \t ] [ \W ]\n  >> '
