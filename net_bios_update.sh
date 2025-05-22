#!/bin/bash 

USER=" "
PASS=" "

# $1 = IP address | $2 = BIOS file

$HOME/sum -i "$1" -u "$USER" -p "$PASS" -c UpdateBIOS --file "$2" --reboot
