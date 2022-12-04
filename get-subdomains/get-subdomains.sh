#!/bin/bash

# Define the input file containing a list of domains
INPUT_FILE="domain-list.txt"

# Define the output file where the subdomains will be saved
OUTPUT_FILE="subdomains.txt"

# Check if a single domain was passed as an argument
if [ $# -eq 1 ]; then
  # If a single domain was passed, add it to the input file
  echo $1 > $INPUT_FILE
fi

# Use subfinder to get subdomains and save the output to the output file
subfinder -dL $INPUT_FILE > $OUTPUT_FILE

# Use amass to get subdomains and append the output to the output file
amass enum -df $INPUT_FILE >> $OUTPUT_FILE

# Use sublister to get subdomains and append the output to the output file
# sublist3r -d $INPUT_FILE >> $OUTPUT_FILE

# Use assetfinder to get subdomains and append the output to the output file
assetfinder --subs-only $INPUT_FILE >> $OUTPUT_FILE

# Remove duplicate subdomains from the output file
sort -u $OUTPUT_FILE -o $OUTPUT_FILE

# Print the number of subdomains found
echo "Total subdomains found: $(wc -l $OUTPUT_FILE)"
