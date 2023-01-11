#!/bin/bash

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
then
	echo ""
	figlet -f small "JS finder"
	echo ""
	echo "$ bash js-finder.sh {file contaning target urls}"
	echo ""
	echo "requirements: figlet, waybackurls, anew, gauplus, httpx"
	exit
fi

file=$1

rm -rf all_urls.txt

cat $file | waybackurls | grep ".js" | anew -q all_urls.txt

cat $file | gauplus | grep ".js" | anew -q all_urls.txt

cat all_urls.txt | httpx -timeout=30 -silent -content-type | grep -E "application/javascript" | cut -d " " -f1

rm -rf all_urls.txt
rm -rf resume.cfg
