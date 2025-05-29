#!/bin/bash 

TOOL="$1"
FILE="$2"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

case $TOOL in

bios)
"$SCRIPT_DIR/sum" -c UpdateBIOS --file "$SCRIPT_DIR/$FILE" ;;

ipmi)
"$SCRIPT_DIR/sum" -c UpdateBMC --file "$SCRIPT_DIR/$FILE" ;; 

*)
echo "./smicro_local_update.sh bios|ipmi file" ;;
esac
