#!/bin/bash

OKBLUE='\033[94m'
OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
RESET='\e[0m'

if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]
then
        echo -e "$OKRED [-] Usage: cert.sh website or website.com$RESET"
        exit
fi

json=$(curl -s https://crt.sh/\?q\=$1\&output\=json)

echo $json | jq -r '.[].common_name' | sort -u #| unfurl -u apexes | sort -u
echo $json | jq -r '.[].name_value' | sort -u

