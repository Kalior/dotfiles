#!/bin/bash

# Dependencies:
# imagemagick
# scrot

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
#BLURTYPE="0x5" # 7.52s
#BLURTYPE="0x2" # 4.39s
#BLURTYPE="5x3" # 3.80s
#BLURTYPE="2x8" # 2.90s
#BLURTYPE="2x3" # 2.92s
#BLURTYPE="4x6"

CORRUPT="corrupter -boffset 8 -mag 0.8 -meanabber 2 -stdoffset 6"


for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o $OUTPUT $IMAGE
    #convert $IMAGE -blur $BLURTYPE $IMAGE
    $CORRUPT $IMAGE $IMAGE
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
    IMAGES="${IMAGES} ${IMAGE}"
done

swaylock \
--text-ver-color=ffffff00 \
--text-wrong-color=ffffff00 \
--inside-color=ffffff1c \
--ring-color=ffffff3e \
--line-color=ffffff00 \
--key-hl-color=00000080 \
--ring-ver-color=00000000 \
--inside-ver-color=0000001c \
--ring-wrong-color=00000055 \
--inside-wrong-color=0000001c \
$LOCKARGS

rm $IMAGES
