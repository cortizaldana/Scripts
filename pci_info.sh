#!/bin/bash
 
echo -e "\e[32m\t\tPCI Slot Information\e[0m\n"

sudo dmidecode -t slot | \

awk '/Designation/,/Bus Address/' | \

grep -vE "Type:|Characteristics:" | \

awk '1; NR % 4 == 0 {print ""}'
