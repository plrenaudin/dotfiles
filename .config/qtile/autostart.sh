#!/bin/sh
picom &
nm-applet &
light-locker &
# xinput set-prop "MSFT0001:01 06CB:CD64 Touchpad" 315 1
libinput-gestures &

