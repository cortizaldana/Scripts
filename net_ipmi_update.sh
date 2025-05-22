#!/bin/bash 

USER=" "
PASS=" "

$HOME/sum -i "$1" -u "$USER" -p "$PASS" -c UpdateBMC --file "$2"
