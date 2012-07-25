# dotfiles
		
A collection of my Arch box linux config files.

The disparate collection of dotfiles/config files are copied from their varied locations with the script `copy_dotfiles.rb`

A cronjob runs the script every hour. The conky script for outputting the status of a git repository then outputs the status of this particular repo.

## Files
The following files are tracked via git.

1. openbox config files (found at `~/.config/openbox/`)
    * `menu.xml`
    * `autostart.sh`    
    * `rc.xml`
2. conky config files (found at `~/.config/conky/`)
    * `conky_topleft`
    * `conky_topright`
    * `ConkyStartup.sh`
    * `conky_topright`
    * `conky_dwm` 
3. bash config file (found at `~/`)
    * `.bashrc`
    * `/etc/bash.bashrc`
4.  Arch linux config files  (mostly found at `/etc/`)
    * `rc.conf`
    * `fstab`
    * `mkinitcpio.conf`
    * `modprobe.d/modprobe.conf`
    * `resolv.conf`
    * `hosts`
    * `hosts.deny`
    * `hosts.allow`
    * `locale.gen`
    * `pacman.conf`
    * `pacman.d/mirrorlist`
    * `group`
    * and `~/.xinitrc`
5. git config files (found at `~/`)
    * `~/.gitconfig`
    * `~/.config/git/git-prompt.sh`
6. Terminal urxvt config files (found at `~/`)
    * `.Xdefaults`
    * and `~/.config/xfce4/helpers.rc`
7. tint2 config file (found at `~/`)
    * `tint2rc`
8. xorg config file (found at `/etc/X11/`)
    * `xorg.conf`
9. slim  config file (found at `/etc/`)
    * `slim.conf`
10. testing config files (found at `~/`)
    * `.autotest`
    * `.rspec`
11. vim files (found at `~/`)
    * `.vimrc`
    * files in `~/.vim/` subdirectories
12. motion config files (found at `~/.motion/`)
    * `motion.conf`
    * `thread1.conf`    
    * `thread2.conf` 
13. awesome sonfig files (found at `~/.config/awesome/`)
    * `rc.lua`
    * and others in that directory, sudh as widgets
14. dwm sonfig files (found at `~/dwm/`)
    * `config.h`
    * `/usr/bin/dwm-personalised`
    * `/usr/share/xsessions/dwm-personalised.desktop`
15 ~/bin files
    * symlinks to script files
    * assorted standalone scripts
16. syslinux files (found at `/boot/syslinux`)
    * `syslinux.cfg`
