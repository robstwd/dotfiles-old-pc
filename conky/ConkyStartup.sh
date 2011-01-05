#!/bin/sh
# click to start, click to stop

if pidof conky | grep [0-9] > /dev/null
then
exec killall conky
else

# run scripts
ruby ~/scripts/cronjobs/internodeData_v11.rb
ruby ~/scripts/cronjobs/InternodeAdvisories_v2.rb

# sleep 30  # sleep not required for xfce on startup - 30 or more for others
conky -c ~/.config/conky/conky_topleft &
conky -c ~/.config/conky/conky_topright &

exit
fi
