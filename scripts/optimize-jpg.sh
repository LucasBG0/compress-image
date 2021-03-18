#!/bin/bash

# directory containing images
input_dir="$1"

# target image quality
quality="$2"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each jpg or jpeg in the input directory
for img in $( find $input_dir \( -name '*.png' -or -name '*.jpg' -or -name '*.jpeg' \) -type f );
#for img in $( find $input_dir \( -name '*.png' -or -name '*.jpg' -or -name '*.jpeg' \) -size +1M -type f );
do
  jpegoptim -m $quality $img
done