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

DEFAULT_SESSION=openbox-session
case $1 in
  openbox-session|awesome|xmonad) exec $1 ;;
  *) exec $DEFAULT_SESSION ;;
esac
