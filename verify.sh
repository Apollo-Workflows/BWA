#!/bin/bash
# Requires samtools, diff, wc
# Check length first
wc1=$(wc -c $1 | tr -dc '0-9')
wc2=$(wc -c $2 | tr -dc '0-9')
if [ "$wc1" -ne "$wc2" ]
  then
  echo "Files $1 and $2 have a different amount of characters: $wc1, $wc2"
  exit 1
fi
# Sort them
samtools sort -O sam -T sample.sort -o "$1-sorted.sam" "$1" 
samtools sort -O sam -T sample.sort -o "$2-sorted.sam" "$2" 
# Print diff of files
diff "$1-sorted.sam" "$2-sorted.sam"