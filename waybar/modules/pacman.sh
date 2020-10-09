#/bin/bash
NUMBER_OF_PACKAGES=$(checkupdates | wc -l)

if [ "$NUMBER_OF_PACKAGES" -eq 0 ]; then
    echo ""
elif [ "$NUMBER_OF_PACKAGES" -lt 5 ]; then
    echo "•"
elif [ "$NUMBER_OF_PACKAGES" -lt 10 ]; then
    echo "• •"
elif [ "$NUMBER_OF_PACKAGES" -lt 15 ]; then
    echo "• • •"
elif [ "$NUMBER_OF_PACKAGES" -lt 20 ]; then
    echo "• • • •"
else
    echo "• • • • •"
fi
