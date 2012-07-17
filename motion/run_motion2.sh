#!/bin/bash

# lock the screensaver, to prevent tampering
#~ xscreensaver-command --lock

# wait 30 seconds for me to exit the room (and turn off the monitor)
#~ sleep 30

# run thunar
thunar /home/rob/Videos/webcam/Motion/video0 &
#thunar /home/rob/Videos/webcam/Motion/video1 &

# run the motion detection software
urxvt -e motion -s &
