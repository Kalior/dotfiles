#!/bin/bash
if [[ $(playerctl status 2>/dev/null) = "Playing" ]]; then
  title=$(exec playerctl metadata xesam:title)
  artist=$(exec playerctl metadata xesam:albumArtist)
  echo "$title - $artist"
else
  echo ""
fi
