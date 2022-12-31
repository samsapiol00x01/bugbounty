#!/bin/bash

echo ""
figlet -f small "JS finder"
echo ""

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
then
	echo ""
	echo "$ bash js-finder.sh file.txt"
	echo ""
	echo "requirements: figlet, waybackurls, anew, gauplus, httpx"
	exit
fi

file=$1

rm -rf all_urls.txt

echo ""
echo "[+] waybackurls scan running..."
echo ""

cat $file | waybackurls | grep ".js" | anew -q all_urls.txt

echo ""
echo "[+] gauplus scan running..."
echo ""

cat $file | gauplus | grep ".js" | anew -q all_urls.txt

echo ""
echo "[+] httpx scan running..."
echo ""

cat all_urls.txt | httpx -timeout=30 -silent -content-type | grep -E "text/javascript|application/javascript"

rm -rf all_urls.txt
rm -rf resume.cfg

echo ""
echo "[+] scan completed!"
echo ""
