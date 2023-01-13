#!/bin/bash

echo ""
figlet -f small "JS finder"
echo ""

if [[ $1 == ""  ]] || [[ $1 == "-h" ]] || [[ $1 == "--help" ]]
then
	echo ""
	echo "$ bash js-finder.sh {file containing urls}"
	echo ""
	echo "requirements: figlet, waybackurls, gau, anew, httpx, nuclei"
	echo ""
	echo "output: js.txt | nuclei_js.txt"
	exit
fi


file=$1

rm -rf js.txt
rm -rf nuclei_js.txt

echo ""
echo "[+] searching for js files..."
echo "" 

{ cat $file | waybackurls; cat $file | gau; } | httpx -silent -timeout=30 -content-type | grep -E "text/javascript|application/javascript" | cut -d " " -f1 | anew js.txt

echo ""
echo "[+] js file all fetched | output : js.txt"
echo ""
echo "[+] nuclei scan checking for confidential information in js files..."
echo ""

nuclei -l js.txt -es info | anew nuclei_js.txt

echo ""
echo "[+] nuclei scan completed | output : nuclei_js.txt"
echo ""
