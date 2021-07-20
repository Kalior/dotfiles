#!/bin/sh

setxkbmap se

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

	xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then


    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
xrdb -merge ~/.Xdefaults &
xbindkeys &

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) & 
export SSH_AUTH_SOCK &

modprobe vboxdrv &

xrandr --output eDP-1 --primary &
xset r rate 300 45 &
#sh ~/.wallpaper.sh &
feh --bg-max close-up-photo-ofg-light-bulb-716398-corrupted.png  --image-bg "#241E20" & 
twmnd &
xsetroot -cursor_name left_ptr &
libinput-gestures-setup start &
srandrd -e screenconfig &
DISPLAY=":0" picom -b --respect-prop-shadow & 
exec i3
