#!/bin/bash

# Define the input file containing a list of domains
INPUT_FILE="domain-list.txt"

# Define the output file where the subdomains will be saved
OUTPUT_FILE="subdomains.txt"

# Status-code files
TwoZeroZero="200.txt"
FourZeroThree="403.txt"
FourZeroFour="404.txt"

# Check if a single domain was passed as an argument
if [ $# -eq 1 ]; then
  # If a single domain was passed, add it to the input file
  echo $1 > $INPUT_FILE
fi

# Use subfinder to get subdomains and save the output to the output file
echo "[+] subfinder running..."
subfinder -dL $INPUT_FILE > $OUTPUT_FILE

# Use amass to get subdomains and append the output to the output file
# echo "[+] amass running..."
# amass enum -df $INPUT_FILE >> $OUTPUT_FILE

# Use sublister to get subdomains and append the output to the output file
# echo "[+] sublist3r running..."
# sublist3r -d $INPUT_FILE >> $OUTPUT_FILE

# Use assetfinder to get subdomains and append the output to the output file
echo "[+] assetfinder running..."
assetfinder --subs-only $INPUT_FILE >> $OUTPUT_FILE

# Remove duplicate subdomains from the output file
sort -u $OUTPUT_FILE -o $OUTPUT_FILE

# Storing URLs in different files on basis of status code
echo "[+] httpx for 200 domains scan running..."
cat $OUTPUT_FILE | httpx -mc 200 > $TwoZeroZero
echo "[+] httpx for 403 domains scan running..."
cat $OUTPUT_FILE | httpx -mc 403 > $FourZeroThree
echo "[+] httpx for 404 domains scan running..."
cat $OUTPUT_FILE | httpx -mc 404 > $FourZeroFour

# Print the number of subdomains found
echo "Total subdomains found: $(wc -l $OUTPUT_FILE)"
