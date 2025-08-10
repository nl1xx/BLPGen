#!/bin/bash

url="https://deep-geometry.github.io/abc-dataset/data/all_v00.txt"
outputFile="all_v00.txt"

echo "Downloading all_v00.txt ..."
curl -k -o $outputFile $url

folders=("step")
for folder in "${folders[@]}"; do
    if [ ! -d "$folder" ]; then
        echo "Creating folder: $folder"
        mkdir -p "$folder"
    fi
done

formats=("step")
for format in "${formats[@]}"; do
    echo "Processing format: $format"
    grep "$format" $outputFile > "${format}_v00.txt"
    
    while read -r line; do
        url=$(echo $line | awk '{print $1}')
        filename=$(echo $line | awk '{print $2}')
        echo "Downloading $filename from $url"
        wget -P "./$format" $url
    done < "${format}_v00.txt"
done

echo "All files downloaded successfully!"
