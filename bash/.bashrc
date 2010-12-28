
# Check for an interactive session
[ -z "$PS1" ] && return

# key bindings
## make tab cycle through commands rather than listing
bind '"\t":menu-complete'

# aliases
alias ls='ls --color=auto'

# prompt mods
#~ PS1='[\u@\h \W]\$ '
#~ PS1='[\u \W] \n$ '
#~ PS1='\u@\H \W \$\n >: '
#~ PS1=':::::::::::::::::::::::::::::: \n =>    '
#~ PS1='\e[1;32m\u@\H \e[1;37m\w \e[1;32m$ \e[1;37m'
PS1='\[\e[37m\][\t \W]$ \e[0m'
