#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# polybar --config=/home/kalior/.config/polybar/bar i3bar &
# MONITOR=eDP1 polybar --config=/home/kalior/.config/polybar/bar onlyi3 &
MONITOR=eDP-1 polybar --config=/home/kalior/.config/polybar/bar i3bar &
MONITOR=eDP1 polybar --config=/home/kalior/.config/polybar/bar i3bar &
# MONITOR=eDP1 polybar --config=/home/kalior/.config/polybar/bar left &
#MONITOR=DP1 polybar --config=/home/kalior/.config/polybar/bar i3bar &

echo "Bars launched..."
