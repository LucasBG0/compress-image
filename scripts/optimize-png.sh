#!/bin/bash

# directory containing images
input_dir="$1"

if [[ -z "$input_dir" ]]; then
  echo "Please specify an input directory."
  exit 1
fi

# for each png in the input directory
for img in $( find $input_dir -name '*.png' -type f );
#for img in $( find $input_dir -name '*.png' -size +1M -type f );
do
  pngquant --speed 1 $img -o $img -f
done