#!/bin/bash

if [ "$1" == "" ] || [ "$1" == "-h" ]
then
	echo -e "\e[1;92m[+]\e[0m \e[1;93mUSAGE\e[0m : $0 domain_file_name"
	exit
fi

#Subfinder
subfinder -dL $1 -silent -all | anew subdomains.txt

number=`wc -l subdomains`

echo -e "\e[1;92m[+]\e[0m \e[1;93mSubfinder Scan\e[0m     : DONE!!! \e[1;36m$number Subdomains Discovered\e[0m"

#Assetfinder
cat $1 | assetfinder -subs-only | anew subdomains.txt

number=`wc -l subdomains`

echo -e "\e[1;92m[+]\e[0m \e[1;93mAssetfinder Scan\e[0m   : DONE!!! \e[1;36m$number Subdomains Discovered\e[0m"

#Httpx
httpx -l subdomains.txt -sc -title -td -ip -location -silent -p 80,443,8443,9001,9002,9003,7001,7002,445,81,20-25 | anew livedomains.txt

echo -e "\e[1;92m[+]\e[0m \e[1;93mHttpx Scan\e[0m         : DONE!!! \e[1;92mLive Subdomain Scan Complete\e[0m"

