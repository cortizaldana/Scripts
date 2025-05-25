#!/bin/bash
 
echo -e "\e[32m\t\tPCI Slot Information\e[0m\n"

dmidecode -t slot | \

awk '/Designation:/,/Bus Address:/' | \

grep -vE "Characteristics:|ID:|Length:|3.3|SMB|PME|5.0 V" | \

awk '1; NR % 5 == 0 {print ""}'
