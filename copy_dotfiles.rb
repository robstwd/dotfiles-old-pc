#!/usr/bin/env ruby

require 'fileutils'

dest = "/home/rob/scripts/Projects/dotfiles/"

# openbox config files
openboxfiles = []
path = "/home/rob/.config/openbox/"
openboxfiles << "#{path}menu.xml"
openboxfiles << "#{path}autostart"
openboxfiles << "#{path}rc.xml" 
FileUtils.cp(openboxfiles, "#{dest}openbox/")
puts "Copied #{openboxfiles.length} openbox files"

# conky config files
conkyfiles = []
path = "/home/rob/.config/conky/"
conkyfiles << "#{path}conky_topleft"
conkyfiles << "#{path}scripts/ConkyStartup.sh"
conkyfiles << "#{path}conky_bottomleft"
conkyfiles << "#{path}conky_topright"
conkyfiles << "#{path}conky_dwm"
FileUtils.cp(conkyfiles, "#{dest}conky/")
puts "Copied #{conkyfiles.length} conky files"

# bash
bashfiles = []
path = "/home/rob/"
bashfiles << "#{path}.bashrc"
FileUtils.cp(bashfiles, "#{dest}bash/")
puts "Copied #{bashfiles.length} bash files"

# Arch linux config files
archfiles = []
path = "/etc/"
archfiles << "#{path}rc.conf"
archfiles << "#{path}fstab"
archfiles << "#{path}mkinitcpio.conf"
archfiles << "#{path}modprobe.d/modprobe.conf"
#~ archfiles << "#{path}resolv.conf" # commented out as this file automatically changes when boot with network or no network
archfiles << "#{path}hosts"
archfiles << "#{path}hosts.deny"
archfiles << "#{path}hosts.allow"
archfiles << "#{path}locale.gen"
archfiles << "#{path}pacman.conf"
archfiles << "#{path}pacman.d/mirrorlist"
archfiles << "/home/rob/.xinitrc"
FileUtils.cp(archfiles, "#{dest}arch/")
puts "Copied #{archfiles.length} arch files"

# Git
gitfiles = []
path = "/home/rob/"
gitfiles << "#{path}.gitconfig"
gitfiles << "/home/rob/.config/git/git-prompt.sh"
FileUtils.cp(gitfiles, "#{dest}git/")
puts "Copied #{gitfiles.length} git files"

# Terminal urxvt
urxvtfiles = []
path = "/home/rob/"
urxvtfiles << "#{path}.Xdefaults"
urxvtfiles << "/home/rob/.config/xfce4/helpers.rc"
FileUtils.cp(urxvtfiles, "#{dest}terminal/")
puts "Copied #{urxvtfiles.length} urxvt files"

# tint2
tint2files = []
path = "/home/rob/.config/tint2/"
tint2files << "#{path}tint2rc"
FileUtils.cp(tint2files, "#{dest}tint2/")
puts "Copied #{tint2files.length} tint2 files"

# xorg
xorgfiles = []
path = "/etc/X11/"
xorgfiles << "#{path}xorg.conf"
FileUtils.cp(xorgfiles, "#{dest}xorg/")
puts "Copied #{xorgfiles.length} xorg files"

# slim
slimfiles = []
path = "/etc/"
slimfiles << "#{path}slim.conf"
FileUtils.cp(slimfiles, "#{dest}slim/")
puts "Copied #{slimfiles.length} slim files"

# testing
testingfiles = []
path = "/home/rob/"
testingfiles << "#{path}.autotest"
testingfiles << "#{path}.rspec"
FileUtils.cp(testingfiles, "#{dest}testing/")
puts "Copied #{testingfiles.length} testing files"

# vim files
vimfiles = Dir.glob("/home/rob/.vim/*/*")
path = "/home/rob/"
vimfiles << "#{path}.vimrc"
FileUtils.cp_r(vimfiles, "#{dest}vim/")
puts "Copied #{vimfiles.length} vim files"

# motion files
motionfiles = Dir.glob("/home/rob/.motion/*")
motionfiles << "/home/rob/scripts/Projects/motion_run/run_motion.sh"
motionfiles << "/home/rob/scripts/Projects/motion_run/run_motion2.sh"
FileUtils.cp_r(motionfiles, "#{dest}motion/")
puts "Copied #{motionfiles.length} motion files"

# awesome files
awesomefiles = Dir.glob("/home/rob/.config/awesome/*")
FileUtils.cp_r(awesomefiles, "#{dest}awesome/")
puts "Copied #{awesomefiles.length} awesome files"

# dwm files
path = "/home/rob/dwm/"
dwmfiles = []
dwmfiles << "#{path}config.h"
#dwmfiles << "#{path}config.h"
dwmfiles << "/usr/bin/dwm-personalised"
dwmfiles << "/usr/share/xsessions/dwm-personalised.desktop"
#dwmfiles << "/usr/share/xsessions/dwm­personalised.desktop"
FileUtils.cp_r(dwmfiles, "#{dest}dwm/")
puts "Copied #{dwmfiles.length} dwm files"

# ~/bin files
binfiles = Dir.glob("/home/rob/bin/*")
FileUtils.cp_r(binfiles, "#{dest}bin/")
puts "Copied #{binfiles.length} bin files"

# pam files
pamfiles = Dir.glob("/etc/pam.d/*")
FileUtils.cp_r(pamfiles, "#{dest}pam/")
puts "Copied #{pamfiles.length} pam files"
