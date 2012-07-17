#!/bin/bash

# remove all running conky instances, saving cpu
killall conky

# lock the screensaver, to prevent tampering
xscreensaver-command --lock

# wait 30 seconds for me to exit the room (and turn off the monitor)
sleep 30

# run the motion detection software
motion -s

# once the motion thread is killed, then sort the resultant motion files into their respective subfolders 
~/scripts/Projects/motion_sorter/bin/motion_sorter ~/Videos/webcam/Motion
