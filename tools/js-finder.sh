#!/bin/bash

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
then
	echo ""
	echo "$ bash js-finder.sh {file containing target urls}"
	echo ""
	echo "requirements: waybackurls, anew, gauplus, httpx"
	exit
fi

file=$1

cat $file | while read line || [[ -n $line ]];
do
	{ echo $line | waybackurls; echo $line | gauplus; } | sort -u | httpx -silent -timeout=30 -content-type | grep "application/javascript" | cut -d " " -f1
done
