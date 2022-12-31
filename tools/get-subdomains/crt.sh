#!/bin/bash

echo ""
figlet -f small "crt tool"
echo ""

if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]
then
	echo ""
        echo "$ bash crt.sh website or website.com"
        echo ""
        echo "requirements: figlet, jq, anew"
        exit
fi

json=$(curl -s https://crt.sh/\?q\=$1\&output\=json)

echo $json | jq -r '.[].common_name' | sort -u > crt-tmp.txt
echo $json | jq -r '.[].name_value' | sort -u >> crt-tmp.txt

cat crt-tmp.txt | sort -u | anew

rm -rf crt-tmp.txt
