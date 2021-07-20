#!/bin/sh

while true; do
	find ~/media/non-blured/ -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.JPG' \) -print0 |
		shuf -n1 -z | xargs -0 feh --bg-fill
	sleep 15m
done
