#!/bin/bash
if [[ $(playerctl -p spotify status 2>/dev/null) = "Playing" ]]; then
  title=$(exec playerctl -p spotify metadata xesam:title)
  artist=$(exec playerctl -p spotify metadata xesam:albumArtist)
  echo "$title - $artist"
else
  echo ""
fi
