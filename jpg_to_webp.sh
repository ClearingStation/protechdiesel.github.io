#!/bin/bash

# directory containing images
input_dir="$1"

# webp image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
    echo "Please specify an input directory."
    exit 1
elif [[ -z "$quality" ]]; then
    echo "Please specify image quality."
    exit 1
fi

rm -rf *-optimized*

# for each webp in the input directory
for img in $( find $input_dir -type f -iname "*.jpg" -o -iname "*.jpeg" );
do
    # convert to png first
    convert $img ${img%.*}-optimized.png

    # resize to max width 1024
    convert ${img%.*}-optimized.png -resize 1024\> ${img%.*}-optimized.png

    # then convert png to webp
    cwebp ${img%.*}-optimized.png -q $quality -o ${img%.*}-optimized.webp
done

rm -rf *-optimized.png
