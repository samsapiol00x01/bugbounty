#!/bin/bash

echo ""
figlet -f small "get subdomains"
echo ""

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
then
	echo ""
	echo "$ bash get-subdomains.sh file.txt"
	echo ""
	echo "requirements: figlet, anew, subfinder, assetfinder, findomain, httpx"
	exit
fi

file=$1

echo ""
echo "[+] subfinder scan running..."
echo ""

subfinder -dL $file -silent | anew subdomains.txt

echo ""
echo "[+] assetfinder scan running..."
echo ""

cat $file | assetfinder --subs-only | anew subdomains.txt

echo ""
echo "[+] findomain scan running..."
echo ""

findomain -f $file -q | anew subdomains.txt

echo ""
echo "[+] httpx scan running..."
echo ""

cat subdomains.txt | httpx -sc -timeout 30 -silent -o domains.txt

echo ""
echo "[+] scan completed!"
echo ""
