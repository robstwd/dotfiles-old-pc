
# Check for an interactive session
[ -z "$PS1" ] && return

# default apps
EDITOR=vim
export EDITOR

# key bindings
## make tab cycle through commands rather than listing
bind '"\t":menu-complete'

# aliases
alias ls='ls --color=auto'
alias lock='xscreensaver-command --lock'
alias lmts='blkid -o list -c /dev/null'
alias luds='ls -lF /dev/disk/by-uuid/'
alias keys="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias mnt='sudo mount'
alias umnt='sudo umount -l'

# xinit aliases
alias stm='xinit monsterwm_start'
alias sta='xinit awesome'
alias sto='xinit openbox-session'
alias std='xinit dwm-personalised'
alias stx='xinit xbmc'
alias stdm='xinit dminiwm_start'
alias sts='xinit snapwm_start'

# git aliases
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gp='git push'
alias gg='git gui'
alias gb='git branch'
alias go='git checkout'
alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
#~ alias glog='git log -1 HEAD'

# cucumber aliases
alias cuc='cucumber'

# RSpec aliases
alias rs='rspec'

# Pacman alias examples
alias pacupg='sudo pacman -Syu'        				 # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman -S'           				 # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          				 # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           				 # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        				 # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              				 # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             				 # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              				 # Display information about a given package in the local database
alias paclocs='pacman -Qs'             				 # Search for package(s) in the local database
alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# prompt mods
#~ PS1='[\u@\h \W]\$ '
#~ PS1='[\u \W] \n$ '
#~ PS1='\u@\H \W \$\n >: '
#~ PS1=':::::::::::::::::::::::::::::: \n =>    '
#~ PS1='\e[1;32m\u@\H \e[1;37m\w \e[1;32m$ \e[1;37m'
#~ PS1='\[\e[37m\][\t \W]$ \e[0m'
PS1='  :: [ \t ] [ \W ]\n  >> '

[[ $- == *i* ]]   &&   . /home/rob/.config/git/git-prompt.sh
