#!/bin/bash

# directory containing images
input_dir="$1"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
elif [[ -z "$quality" ]]; then
  echo "Please specify image quality."
  exit 1
fi

# for each png in the input directory
for img in $( find $input_dir -size +1024k -type f -iname "*.png" );
do
  pngquant --speed 1 $img -o $img -f
done