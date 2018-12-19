START=$1
END=$2
FROM=$3
TO=$4

for i in $(seq $START $END); do
  JPG="${FROM}/IMG_${i}.JPG"
  RAW="${FROM}/IMG_${i}.CR2"
  if [ -f $JPG ]; then
    echo "Copying ${JPG} to ${TO}"
    cp $JPG $TO
  fi
  if [ -f $RAW ]; then
    echo "Copying ${RAW} to ${TO}"
    cp $RAW $TO
  fi
done;
