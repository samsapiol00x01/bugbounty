#!/bin/bash

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
then
	echo ""
	echo "$ bash js-finder.sh {file containing target urls}"
	echo ""
	echo "requirements: "
	exit
fi

file=$1

cat $file | gauplus | getJS --complete
