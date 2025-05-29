#!/bin/bash 
USER=" "
PASS=" "
TOOL="$1"
FILE="$2"

case $TOOL in

bios)
$HOME/sum -c UpdateBIOS --file "$FILE" ;;

ipmi)
$HOME/sum -c UpdateBMC --file "$FILE" ;; 

*)
echo "./smicro_update.sh bios|ipmi file"
esac
