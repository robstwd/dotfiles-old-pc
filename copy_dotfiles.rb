#!/usr/bin/env ruby

require 'fileutils'

dest = "/home/rob/scripts/Projects/dotfiles/"

# openbox config files
openboxfiles = []
path = "/home/rob/.config/openbox/"
openboxfiles << "#{path}menu.xml"
openboxfiles << "#{path}autostart.sh"
openboxfiles << "#{path}rc.xml" 
FileUtils.cp(openboxfiles, "#{dest}openbox/")

# conky config files
conkyfiles = []
path = "/home/rob/.config/conky/"
conkyfiles << "#{path}conky_topleft"
conkyfiles << "#{path}scripts/ConkyStartup.sh"
FileUtils.cp(conkyfiles, "#{dest}conky/")

# bash
bashfiles = []
path = "/home/rob/"
bashfiles << "#{path}.bashrc"
FileUtils.cp(bashfiles, "#{dest}bash/")

# Arch linux config files
archfiles = []
path = "/etc/"
archfiles << "#{path}rc.conf"
archfiles << "#{path}fstab"
archfiles << "#{path}mkinitcpio.conf"
archfiles << "#{path}modprobe.d/modprobe.conf"
archfiles << "#{path}resolv.conf"
archfiles << "#{path}hosts"
archfiles << "#{path}hosts.deny"
archfiles << "#{path}hosts.allow"
archfiles << "#{path}locale.gen"
archfiles << "#{path}pacman.conf"
archfiles << "#{path}pacman.d/mirrorlist"
archfiles << "/home/rob/.xinitrc"
FileUtils.cp(archfiles, "#{dest}arch/")

# Git
gitfiles = []
path = "/home/rob/"
gitfiles << "#{path}.gitconfig"
gitfiles << "/home/rob/.config/git/git-prompt.sh"
FileUtils.cp(gitfiles, "#{dest}git/")

# Terminal urxvt
urxvtfiles = []
path = "/home/rob/"
urxvtfiles << "#{path}.Xdefaults"
urxvtfiles << "/home/rob/.config/xfce4/helpers.rc"
FileUtils.cp(urxvtfiles, "#{dest}terminal/")

# tint2
tint2files = []
path = "/home/rob/.config/tint2/"
tint2files << "#{path}tint2rc"
FileUtils.cp(tint2files, "#{dest}tint2/")

# xorg
xorgfiles = []
path = "/etc/X11/"
xorgfiles << "#{path}xorg.conf"
FileUtils.cp(xorgfiles, "#{dest}xorg/")

# slim
slimfiles = []
path = "/etc/"
slimfiles << "#{path}slim.conf"
FileUtils.cp(slimfiles, "#{dest}slim/")

# testing
testingfiles = []
path = "/home/rob/"
testingfiles << "#{path}.autotest"
testingfiles << "#{path}.rspec"
FileUtils.cp(testingfiles, "#{dest}testing/")
