#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
# exec enlightenment_start
# exec ck-launch-session openbox-session
# exec openbox-session

xset +fp /usr/share/fonts/local
xset fp rehash

# from .Xresources arch wiki page; added 2012-07-30
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

DEFAULT_SESSION=awesome
case $1 in
  awesome|openbox-session|dwm-personalised|xbmc|monsterwm_start|dminiwm_start|snapwm_start) exec $1 ;;
  *) exec $DEFAULT_SESSION ;;
esac
