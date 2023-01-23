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
	echo ""
	echo "output: subdomains.txt | live_domains.txt"
	echo ""
	exit
fi

file=$1

rm -rf subdomains.txt
rm -rf live_domains.txt

echo ""
echo "[+] subfinder scan running..."
echo ""

subfinder -dL $file -silent | sed '/*/d' | anew subdomains.txt

echo ""
echo "[+] assetfinder scan running..."
echo ""

cat $file | assetfinder --subs-only | sed '/*/d' | anew subdomains.txt

echo ""
echo "[+] findomain scan running..."
echo ""

findomain -f $file -q | sed '/*/d' | anew subdomains.txt

echo ""
echo "[+] httpx scan running..."
echo ""

cat subdomains.txt | httpx -sc -timeout 30 -silent -o live_domains.txt

echo ""
echo "[+] scan completed!"
echo ""
